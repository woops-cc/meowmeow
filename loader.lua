-- ui library loading. loader first, and if github breaks it again (wrong urls, classic) it
-- grabs the lib file directly and sets it up by hand. the loader and i have trust issues
local LOADER_URL    = "https://raw.githubusercontent.com/Null-Cherry/Fire-Library/refs/heads/main/Loader.lua"
local LIBRARY_USERS = {"Null-Cherry", "Its-Kawi"}

local function viaLoader()
    return loadstring(game:HttpGet(LOADER_URL, true))()
end

local function viaFile(user)
    local genv = (getgenv and getgenv()) or _G
    if genv.FireLibrary then return genv.FireLibrary end
    local contents = game:HttpGet("https://raw.githubusercontent.com/"..user.."/Fire-Library/refs/heads/main/Files/Library.lua")
    local first = contents:find("local", 1, true)
    local stop  = first and contents:find(";", first, true)
    if not stop then error("nothing usable came back") end
    local src = "local parent = nil"..contents:sub(stop + 1).."\nreturn require(obj:FindFirstChildOfClass(\"ModuleScript\"))"
    local fn, err = loadstring(src)
    if not fn then error("the library file didn't compile: "..tostring(err)) end
    return fn("FireLibrary")
end

local function loadLibrary()
    local ok, res = pcall(viaLoader)
    if ok and res then return res end
    warn("[geometry dash pathfinder] the library loader failed ("..tostring(res).."), loading the library file directly")
    for _, user in ipairs(LIBRARY_USERS) do
        local ok2, res2 = pcall(viaFile, user)
        if ok2 and res2 then return res2 end
        warn(("[geometry dash pathfinder] loading the library from %s failed: %s"):format(user, tostring(res2)))
    end
    warn("[geometry dash pathfinder] couldn't load the ui library")
    return nil
end

local lib = loadLibrary()
if not lib then return end

-- everything goes through guard() so one ui element dying only takes itself out and not the
-- whole ui. it prints the error too, so i know exactly who to blame
local nothing = setmetatable({}, {__index = function() return function() return nil end end})
local containers = {AddTab=true, AddLeftGroupbox=true, AddRightGroupbox=true, AddGroupbox=true}
local function guard(obj, label)
    if obj == nil or obj == nothing then return nothing end
    return setmetatable({}, {__index = function(_, key)
        local v = obj[key]
        if type(v) ~= "function" then return v end
        return function(_, ...)
            local ok, res = pcall(v, obj, ...)
            if not ok then
                warn(("[geometry dash pathfinder] ui: %s:%s failed: %s"):format(label, tostring(key), tostring(res)))
                res = nil
            end
            if containers[key] then return guard(res, label.."/"..tostring(key)) end
            return res
        end
    end})
end

local VERSION = "v1.0-beta"  -- bump this every update or the footer lies to everyone

-- colors: galaxy collapse theme, crimson + ink black + white. very emo, i love it
local C_RED   = Color3.fromRGB(196, 30,  58)
local C_STEEL = Color3.fromRGB(208, 208, 214)
local C_BG    = Color3.fromRGB(10,  10,  12)
local C_WHITE = Color3.fromRGB(232, 232, 236)

local WINDOW_OPTIONS = {
    Title    = "<font color='#E8E8EC'><b>geometry dash pathfinder</b></font><font color='#C41E3A'> botplay</font>",
    Icon     = "125411711221424",
    Footer   = "<font color='#C41E3A'>woops &lt;3</font>  ·  geometry dash pathfinder  ·  "..VERSION,
    Keybind  = Enum.KeyCode.RightShift,
    NeonType      = "Top",
    NeonThickness = 3,
    AnimationSpeed     = 1.2,
    ShadowTransparency = 0.4,
    ShadowSize         = 20,
    Image             = "112319963433704",
    ImageEnabled      = true,
    ImageTransparency = 0.55,
    ImageColor        = Color3.new(1, 1, 1),
    Theme = { Back=C_BG, Main=C_RED, Stroke=C_STEEL, Text=C_WHITE },
}

-- window creation: fancy version first, if the lib chokes retry without the image + blur,
-- then the bare minimum (potato mode, we dont talk about it)
local window
for attempt = 1, 3 do
    local opts = WINDOW_OPTIONS
    if attempt == 2 then
        opts = {}
        for k, v in pairs(WINDOW_OPTIONS) do opts[k] = v end
        opts.Image, opts.ImageEnabled, opts.Icon, opts.EnableUIBlur = nil, false, nil, false
    elseif attempt == 3 then
        opts = {Title = "geometry dash pathfinder botplay", Keybind = Enum.KeyCode.RightShift}
    end
    local ok, res = pcall(function() return lib:Window("gdpath_ap", opts) end)
    if ok and res then window = res; break end
    warn(("[geometry dash pathfinder] window attempt %d failed: %s"):format(attempt, tostring(res)))
end
if not window then return end
window = guard(window, "window")

-- image fix: copies Image into ImageContent after the window builds. no clue why the lib needs me to babysit it like this
task.defer(function()
    task.wait(3)
    local function mirror(inst)
        if not inst then return end
        local busy = false
        local function sync()
            if busy then return end
            local img = inst.Image
            if not img or img == "" then return end
            busy = true
            pcall(function() inst.ImageContent = Content.fromUri(img) end)
            busy = false
        end
        sync()
        inst:GetPropertyChangedSignal("Image"):Connect(sync)
    end
    pcall(function() mirror(window.Window.RealWindow) end)
    pcall(function() mirror(window.Window.RealWindow.Contents.TopbarZone.TitleZone.Icon) end)
    pcall(function()
        local btn = window.MobileButton.CanvasGroup.ImageLabel
        mirror(btn); btn.Visible = true
    end)
end)



local RepS        = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local TOKEN       = "gdpath"
local FRAME       = 1 / 60
local MACRO_DIR   = "gdmacros"
local epochFrames = 2            -- how many frames one decision lasts (1 = most precise, slower)
local nodeBudget  = 400000       -- how many decisions the search may try before giving up
local savePartial = true
local searching, stopFlag = false, false

local gd = RepS:FindFirstChild("GDPort")
local function req(name)
    local m = gd and gd:FindFirstChild(name)
    if not m then return nil end
    local ok, r = pcall(require, m)
    return ok and r or nil
end

-- ---- a private copy of the level's physics ----
-- the game is a deterministic lua port of geometry dash, so the pathfinder runs the game's OWN simulation (GameLayer +
-- Simulation) in a private copy of the level: whatever the game supports (modes, portals, orbs, triggers...) is supported
-- here too. the level gets a copy of its mutable parts and its own layer pointer, so the live game is never touched
local function deep(v, seen)
    if type(v) ~= "table" then return v end
    if seen[v] then return seen[v] end
    local c = {}
    seen[v] = c
    for k, x in pairs(v) do c[k] = deep(x, seen) end
    local mt = getmetatable(v)
    if mt then setmetatable(c, mt) end
    return c
end

local M = {}
local function loadMods()
    if M.ok then return true end
    M.CR, M.RS, M.GL, M.Sim, M.Eff = req("ClientRuntime"), req("RuntimeSupport"), req("GameLayer"), req("Simulation"), req("Effects")
    M.ok = M.CR and M.RS and M.GL and M.Sim and M.Eff and true or false
    return M.ok
end

local function buildSim(setPointer)
    local live = M.CR.layer
    if type(live) ~= "table" or type(live.level) ~= "table" then return nil, "open a level first (you have to be inside it)" end
    local lvl = live.level
    local lvl2 = {}
    for k, v in pairs(lvl) do lvl2[k] = v end
    lvl2._lifecycleLayer = nil
    for _, k in ipairs({"groups", "colors", "colorDefinitions", "colorAlpha", "colorBlending"}) do
        if type(lvl[k]) == "table" then lvl2[k] = deep(lvl[k], {}) end
    end
    setmetatable(lvl2, getmetatable(lvl))
    local state = M.Sim.new(lvl2)
    local eff = M.Eff.new(lvl2)
    local input = M.RS.newInput()
    local tl = M.RS.newTimeline(input, 0)
    local layer = M.GL.new({level = lvl2, state = state, effects = eff, renderer = nil, shake = nil, support = M.RS, timeline = tl, clock = 0,
        quantum = not lvl.platformer,
        hooks = {isPaused = function() return false end, completeTimers = true, quitLevel = function() end}})
    layer:start()
    if setPointer then lvl2._lifecycleLayer = layer end
    return {state = state, layer = layer, tl = tl, level = lvl2, id = tostring(M.CR.snapshot().id)}
end

local function zeroTimeline(S)
    local tl = S.tl
    tl.remainder, tl.debt, tl._debtTicks = 0, 0, 0
    local q = tl.queue
    for i = #q, 1, -1 do table.remove(q, i) end
end

-- one decision = `epochFrames` frames with the finger held or not. the state is written EVERY epoch (it does nothing when
-- nothing changed), so restoring an old state never leaves the finger in the wrong position
local function applyEpoch(S, held)
    for f = 1, epochFrames do
        S.layer:steps(FRAME, f == 1 and {{TOKEN, "jump", held}} or nil)
        if S.state.dead then return false end
    end
    return true
end

local function finished(S)
    return S.state.complete == true or (type(S.layer.percent) == "number" and S.layer.percent >= 100)
end

local function selfTest(S)
    local function run()
        M.Sim.reset(S.state, S.cp0); zeroTimeline(S)
        for i = 1, 40 do
            S.layer:steps(FRAME, (i == 12 and {{TOKEN, "jump", true}}) or (i == 18 and {{TOKEN, "jump", false}}) or nil)
        end
        return S.state.x, S.state.y, S.state.time, S.state.dead
    end
    local a1, b1, c1, d1 = run()
    local a2, b2, c2, d2 = run()
    return a1 == a2 and b1 == b2 and c1 == c2 and d1 == d2
end

-- ---- the search ----
-- depth first over decisions, trying "keep doing what you were doing" first. a dead end marks its state as failed so
-- no path walks into it twice, and checkpoints let it step back without re-simulating from the start
local function search(S, notify)
    local state = S.state
    local E = epochFrames
    local path, triedF, triedT, cps, failed = {[0] = false}, {}, {}, {}, {}
    local function key(d)
        return string.format("%d|%.0f|%.1f|%s|%s", d, state.y or 0, state.vy or 0, tostring(state.mode), tostring(path[d]))
    end
    cps[0] = S.cp0
    local function restore(d)
        local base = d
        while base > 0 and not cps[base] do base = base - 1 end
        M.Sim.reset(state, cps[base]); zeroTimeline(S)
        for e = base + 1, d do applyEpoch(S, path[e]) end
    end
    local depth, nodes, bestDepth, bestX = 0, 0, 0, 0
    local lastNote, lastYield = os.clock(), os.clock()
    local t0 = os.clock()
    while true do
        if finished(S) then return true, path, depth, nodes end
        if nodes >= nodeBudget or stopFlag then return false, path, bestDepth, nodes, bestX end
        local prev = path[depth]
        local choice
        if not (prev and triedT[depth + 1] or (not prev) and triedF[depth + 1]) then choice = prev
        elseif not (prev and triedF[depth + 1] or (not prev) and triedT[depth + 1]) then choice = not prev end
        if choice == nil then
            failed[key(depth)] = true
            if depth == 0 then return false, path, bestDepth, nodes, bestX end
            cps[depth] = nil
            triedF[depth + 1], triedT[depth + 1] = nil, nil
            depth = depth - 1
            restore(depth)
        else
            if choice then triedT[depth + 1] = true else triedF[depth + 1] = true end
            nodes = nodes + 1
            local ok = applyEpoch(S, choice)
            if ok then
                path[depth + 1] = choice
                if failed[key(depth + 1)] then ok = false end
            end
            if ok then
                depth = depth + 1
                cps[depth] = M.Sim.checkpoint(state)
                if cps[depth - 64] and (depth - 64) % 20 ~= 0 then cps[depth - 64] = nil end
                if depth > bestDepth then bestDepth, bestX = depth, state.x end
            else
                path[depth + 1] = nil
                restore(depth)
            end
        end
        local now = os.clock()
        if now - lastYield > 0.008 then task.wait(); lastYield = os.clock() end
        if now - lastNote > 3 then
            lastNote = now
            notify(string.format("x %.0f (%.0f%%) | %d decisions | depth %d | %.0fs", bestX, (S.layer.percent or 0), nodes, depth, now - t0))
        end
    end
end

-- turns the winning path into macro events (times in sim seconds, a hair into the frame so they land in its first tick)
local function toMacro(S, path, depth)
    local events, prev = {}, false
    for e = 1, depth do
        if path[e] ~= prev then
            events[#events + 1] = {t = (e - 1) * epochFrames * FRAME + 0.0005, a = "jump", d = path[e]}
            prev = path[e]
        end
    end
    if prev then events[#events + 1] = {t = depth * epochFrames * FRAME + 0.0005, a = "jump", d = false} end
    -- replay from the start to record the line the macro player checks against, and to prove the path really finishes
    M.Sim.reset(S.state, S.cp0); zeroTimeline(S)
    local traj, ei, held = {}, 1, false
    local frames = depth * epochFrames
    for fr = 0, frames - 1 do
        local t = fr * FRAME
        local inp
        while events[ei] and events[ei].t < t + FRAME do inp = {{TOKEN, "jump", events[ei].d}}; ei = ei + 1 end
        if not inp then inp = {{TOKEN, "jump", false}} end
        S.layer:steps(FRAME, inp)
        traj[#traj + 1] = {t = S.state.time, x = S.state.x, y = S.state.y}
        if S.state.dead then break end
    end
    return {level = S.id, events = events, traj = traj, length = S.state.time}, (not S.state.dead) and finished(S)
end

local function saveMacro(m, suffix)
    local ok, err = pcall(function()
        if makefolder and isfolder and not isfolder(MACRO_DIR) then makefolder(MACRO_DIR) end
        writefile(MACRO_DIR .. "/level_" .. m.level .. (suffix or "") .. ".json", HttpService:JSONEncode(m))
    end)
    return ok
end

local function runPathfinder()
    if searching then return end
    if not loadMods() then window:Notification({Title = "pathfinder", Text = "couldn't load the game's modules", Duration = 4}); return end
    searching, stopFlag = true, false
    task.spawn(function()
        local function say(t) window:Notification({Title = "pathfinder", Text = t, Duration = 3}) end
        local ok, err = pcall(function()
            local S, e = nil, nil
            for _, setPtr in ipairs({true, false}) do
                S, e = buildSim(setPtr)
                if not S then say(e or "couldn't build the simulation"); return end
                S.cp0 = M.Sim.checkpoint(S.state)
                if selfTest(S) then say("private simulation ready (deterministic check passed)"); break end
                S = nil
            end
            if not S then say("the private simulation isn't deterministic, stopping"); return end
            M.Sim.reset(S.state, S.cp0); zeroTimeline(S)
            local found, path, depth, nodes, bestX = search(S, say)
            if found then
                local m, verified = toMacro(S, path, depth)
                local saved = saveMacro(m)
                say(string.format("PATH FOUND: %d inputs, %.1fs, %d decisions. verified: %s. %s", #m.events, m.length, nodes, tostring(verified), saved and ("saved as level_" .. m.level .. ".json, play it with the macro tool") or "couldn't save the file"))
            else
                local m = nil
                if savePartial and depth and depth > 0 then m = toMacro(S, path, depth); saveMacro(m, "_partial") end
                say(string.format("no full path found (%d decisions, best x %.0f)%s", nodes or 0, bestX or 0, m and ", saved the furthest run as level_" .. m.level .. "_partial.json" or ""))
            end
        end)
        if not ok then window:Notification({Title = "pathfinder", Text = "error: " .. tostring(err), Duration = 8}); warn("[gd pathfinder] " .. tostring(err)) end
        searching = false
    end)
end

-- ---- ui ----
local infoTab = window:AddTab("InfoTab", {Text="info",       Icon="info"})
local pfTab   = window:AddTab("PfTab",   {Text="pathfinder", Icon="play"})

local iL = infoTab:AddLeftGroupbox("IL", {Text="about"})
iL:AddLabel("IL1",{Text="<font color='#C41E3A'><b>geometry dash pathfinder</b></font> by woops &lt;3\n\nsolves a level by itself. it runs the game's own physics in a private copy of the level, searches for the taps that get through, and saves them as a macro.\n\n1. open the level and stay inside it\n2. press <b>find path</b>\n3. when it says PATH FOUND, play the macro with the macro tool (practice mode)"})
iL:AddSeparator("ILS",{})
iL:AddLabel("IL2",{Text="<b>right shift</b> = open / close the menu\nmacros land in the <b>gdmacros</b> folder as level_<id>.json"})

local pL = pfTab:AddLeftGroupbox("PL", {Text="pathfinder"})
pL:AddButton("Find",{
    Text="find path",
    Tooltip="searches the whole level from the start. it keeps going until it finds a way through, runs out of decisions, or you press stop",
    Callback=function() runPathfinder() end,
})
pL:AddButton("Stop",{
    Text="stop",
    Tooltip="stops the search (the furthest run it reached gets saved as a partial macro)",
    Callback=function() stopFlag = true end,
})
pL:AddSlider("Epoch",{
    Text="decision length (frames)", Min=1, Max=4, Value=2, Step=1,
    Tooltip="how long every tap/release decision lasts. 1 is the most precise but slower, 2 is a good start. harder levels may need 1",
    Callback=function(v) epochFrames = v end,
})
pL:AddSlider("Budget",{
    Text="search budget (thousand decisions)", Min=50, Max=2000, Value=400, Step=50,
    Tooltip="how many decisions it may try before giving up",
    Callback=function(v) nodeBudget = v * 1000 end,
})
pL:AddToggle("Partial",{
    Text="save the furthest run if it fails", Value=true,
    Tooltip="saves how far it got as level_<id>_partial.json",
    Callback=function(val) savePartial = val end,
})
