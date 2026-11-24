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
    warn("[geometry dash] the library loader failed ("..tostring(res).."), loading the library file directly")
    for _, user in ipairs(LIBRARY_USERS) do
        local ok2, res2 = pcall(viaFile, user)
        if ok2 and res2 then return res2 end
        warn(("[geometry dash] loading the library from %s failed: %s"):format(user, tostring(res2)))
    end
    warn("[geometry dash] couldn't load the ui library")
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
                warn(("[geometry dash] ui: %s:%s failed: %s"):format(label, tostring(key), tostring(res)))
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
    Title    = "<font color='#E8E8EC'><b>geometry dash</b></font><font color='#C41E3A'> botplay</font>",
    Icon     = "125411711221424",
    Footer   = "<font color='#C41E3A'>woops &lt;3</font>  ·  geometry dash  ·  "..VERSION,
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
        opts = {Title = "geometry dash botplay", Keybind = Enum.KeyCode.RightShift}
    end
    local ok, res = pcall(function() return lib:Window("gdmacro_ap", opts) end)
    if ok and res then window = res; break end
    warn(("[geometry dash] window attempt %d failed: %s"):format(attempt, tostring(res)))
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



local UIPlay
local RunService  = game:GetService("RunService")
local RepS        = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local TOKEN     = "gdmacro"     -- our own input source name, the game treats it like one more finger
local LOOKAHEAD = 0.30          -- seconds of macro that get queued ahead of the sim (events wait in the game's own queue, so they land on the exact tick)
local MACRO_DIR = "gdmacros"

local recording   = false
local playing     = false
local practiceOnly = true       -- bot runs only play inside practice mode, so they dont count as real completions
local macro       = nil         -- {level=, events={{t=,a=,d=}}, traj={{t=,x=,y=}}, length=}
local rec         = {events = {}, traj = {}}
local nextIdx     = 1
local anchor      = {valid = false, sim = 0, clock = 0}
local lastSim, lastDead, lastLevel = nil, false, nil
local driftMax, driftWarned = 0, false
local hooked      = false
local origQI, origQR
local CR, RS
local looping, lastErr = false, 0

local function f2(x) return type(x) == "number" and string.format("%.2f", x) or tostring(x) end

-- ---- the game ----
-- the game is a full lua port of geometry dash (ReplicatedStorage.GDPort). ClientRuntime.snapshot() gives the live
-- player state and every tap goes through RuntimeSupport.queueInput(timeline, time, token, action, down) into a
-- timeline the physics eats at 240 ticks a second, so an event with a future timestamp lands on the exact tick
local function loadModules()
    if CR and RS then return true end
    local gd = RepS:FindFirstChild("GDPort")
    if not gd then return false end
    local ok1, a = pcall(require, gd:FindFirstChild("ClientRuntime"))
    local ok2, b = pcall(require, gd:FindFirstChild("RuntimeSupport"))
    if ok1 and ok2 and type(a) == "table" and type(b) == "table" then CR, RS = a, b; return true end
    return false
end

local function getTimeline()
    local gu = (debug and debug.getupvalues) or getupvalues
    if not gu or not CR or type(CR.inputTime) ~= "function" then return nil end
    local ok, t = pcall(gu, CR.inputTime)
    if not ok or type(t) ~= "table" then return nil end
    for i = 1, 12 do
        local v = t[i]
        if type(v) == "table" and type(rawget(v, "queue")) == "table" and type(rawget(v, "input")) == "table" and type(rawget(v, "clock")) == "number" then return v end
    end
end

-- recording: every real tap goes through queueInput / queueRelease, so a wrapper just writes down what passes
-- (time is converted from the timeline clock to simulation time with the anchor taken this frame). only reads
local function installHooks()
    if hooked then return end
    hooked = true
    origQI, origQR = RS.queueInput, RS.queueRelease
    RS.queueInput = function(tl, time, token, action, down)
        if recording and anchor.valid and token ~= TOKEN and type(time) == "number" then
            rec.events[#rec.events + 1] = {t = anchor.sim + (time - anchor.clock), a = action, d = down == true}
        end
        return origQI(tl, time, token, action, down)
    end
    RS.queueRelease = function(tl, time, token)
        if recording and anchor.valid and token ~= TOKEN and type(time) == "number" then
            rec.events[#rec.events + 1] = {t = anchor.sim + (time - anchor.clock), a = "release", d = false}
        end
        return origQR(tl, time, token)
    end
end

local function removeHooks()
    if not hooked then return end
    hooked = false
    if RS.queueInput ~= origQI then RS.queueInput = origQI end
    if RS.queueRelease ~= origQR then RS.queueRelease = origQR end
end

-- takes our not-yet-played events out of the game's queue (new attempt, macro turned off, ...)
local function clearOurEvents(tl)
    if not tl then return end
    local q = tl.queue
    for i = #q, 1, -1 do
        if q[i].token == TOKEN then table.remove(q, i) end
    end
    pcall(RS.releaseInput, tl.input, TOKEN)
    pcall(RS.releaseInput, tl.capture, TOKEN)
end

local function levelKey(snap) return tostring(snap.id) end

local function saveMacro()
    if not macro then return false, "no macro" end
    local ok, err = pcall(function()
        if makefolder and isfolder and not isfolder(MACRO_DIR) then makefolder(MACRO_DIR) end
        writefile(MACRO_DIR .. "/level_" .. macro.level .. ".json", HttpService:JSONEncode(macro))
    end)
    return ok, err
end

local function loadMacro(level)
    local ok, res = pcall(function()
        return HttpService:JSONDecode(readfile(MACRO_DIR .. "/level_" .. level .. ".json"))
    end)
    if ok and type(res) == "table" and type(res.events) == "table" then return res end
end

local function summary(m)
    if not m then return "no macro loaded" end
    return string.format("level %s: %d inputs over %.1fs", tostring(m.level), #m.events, m.length or 0)
end

local function newAttempt(tl)
    nextIdx = 1
    driftMax, driftWarned = 0, false
    rec = {events = {}, traj = {}}
    clearOurEvents(tl)
end

-- ---- the frame ----
local function frame(dt)
    if not (recording or playing) then return end
    if not loadModules() then return end
    local ok, snap = pcall(CR.snapshot)
    if not ok or type(snap) ~= "table" or type(snap.x) ~= "number" or type(snap.time) ~= "number" then
        anchor.valid = false
        return
    end
    local tl = getTimeline()
    if not tl then anchor.valid = false; return end
    anchor.valid, anchor.sim, anchor.clock = true, snap.time, tl.clock
    installHooks()

    local level = levelKey(snap)
    if level ~= lastLevel then
        lastLevel = level
        newAttempt(tl)
        if playing and not macro then macro = loadMacro(level) end
        if macro and tostring(macro.level) ~= level then macro = loadMacro(level) end
        window:Notification({Title = "level " .. level, Text = summary(macro), Duration = 3})
    end
    -- a new attempt: the sim clock went back, or we just died
    if (lastSim and snap.time < lastSim - 0.05) or (snap.dead and not lastDead) then
        local wasRec = recording and not snap.dead and snap.complete
        newAttempt(tl)
    end
    lastSim, lastDead = snap.time, snap.dead and true or false
    if snap.dead or snap.paused then return end

    if recording then
        rec.traj[#rec.traj + 1] = {t = snap.time, x = snap.x, y = snap.y}
        if snap.complete then
            macro = {level = level, events = rec.events, traj = rec.traj, length = snap.time}
            recording = false
            local sok = saveMacro()
            window:Notification({Title = "macro recorded", Text = summary(macro) .. (sok and " (saved)" or " (couldn't save the file)"), Duration = 5})
        end
    end

    if playing and macro then
        if practiceOnly and not snap.practice then
            if not driftWarned then
                driftWarned = true
                window:Notification({Title = "macro", Text = "playback only runs in practice mode, so bot runs dont count. turn practice mode on (or switch that off in the macro tab)", Duration = 5})
            end
            return
        end
        -- queue what falls inside the lookahead window
        while nextIdx <= #macro.events do
            local e = macro.events[nextIdx]
            if e.t > snap.time + LOOKAHEAD then break end
            local realT = anchor.clock + math.max(e.t - anchor.sim, 0)
            if e.a == "release" then
                pcall(origQR or RS.queueRelease, tl, realT, TOKEN)
            else
                pcall(origQI or RS.queueInput, tl, realT, TOKEN, e.a, e.d)
            end
            nextIdx = nextIdx + 1
        end
        -- is the run still on the recorded line? (the sim is deterministic, so it should be)
        local traj = macro.traj
        if traj and #traj > 0 then
            local lo, hi = 1, #traj
            while lo < hi do
                local mid = (lo + hi) // 2
                if traj[mid].t < snap.time then lo = mid + 1 else hi = mid end
            end
            local ref = traj[lo]
            if ref and math.abs(ref.t - snap.time) < 0.05 then
                local drift = math.abs(ref.y - snap.y)
                if drift > driftMax then driftMax = drift end
                if drift > 3 and not driftWarned then
                    driftWarned = true
                    window:Notification({Title = "macro desync", Text = string.format("off the recorded line at %.2fs (y off by %.1f). tell me about it", snap.time, drift), Duration = 6})
                end
            end
        end
    end
end

local function startLoop()
    if looping then return end
    looping = true
    RunService:BindToRenderStep("gd_macro", Enum.RenderPriority.Last.Value, function(dt)
        local ok, err = pcall(frame, dt)
        if not ok and tick() - lastErr > 2 then lastErr = tick(); warn("[gd macro] loop error: " .. tostring(err)) end
    end)
end

local function stopLoopIfIdle()
    if recording or playing or not looping then return end
    looping = false
    pcall(function() RunService:UnbindFromRenderStep("gd_macro") end)
    if CR and RS then
        clearOurEvents(getTimeline())
        removeHooks()
    end
end

-- ---- ui ----
local infoTab = window:AddTab("InfoTab",  {Text="info",  Icon="info"})
local macTab  = window:AddTab("MacroTab", {Text="macro", Icon="play"})

local iL = infoTab:AddLeftGroupbox("IL", {Text="about"})
iL:AddLabel("IL1",{Text="<font color='#C41E3A'><b>geometry dash macro</b></font> by woops &lt;3\n\nrecords your run and plays it back on the exact physics tick, in the game's own 240 tick/s timeline.\n\n1. open a level\n2. turn on <b>record</b> and beat the level (it keeps your latest attempt and saves it when you finish)\n3. turn on <b>play macro</b> and restart"})
iL:AddSeparator("ILS",{})
iL:AddLabel("IL2",{Text="<b>right shift</b> = open / close the menu\nmacros are saved in the <b>gdmacros</b> folder, one file per level"})

local mL = macTab:AddLeftGroupbox("ML", {Text="macro"})
mL:AddToggle("Record",{
    Text="record", Value=false,
    Tooltip="records every tap of your attempt. dying throws the attempt away and starts a new recording, finishing the level saves it",
    Callback=function(val)
        recording = val
        if val then
            playing = false
            if UIPlay then UIPlay:SetValue(false) end
            rec = {events = {}, traj = {}}
            startLoop()
        else
            stopLoopIfIdle()
        end
        window:Notification({Title="macro",Text=val and "<font color='#C41E3A'>recording</font>, play the level" or "stopped recording",Duration=3})
    end,
})
UIPlay = mL:AddToggle("Play",{
    Text="play macro", Value=false,
    Tooltip="plays the recorded macro for the current level, every attempt, on the same ticks",
    Callback=function(val)
        playing = val
        if val then
            recording = false
            nextIdx = 1
            startLoop()
        else
            clearOurEvents(getTimeline())
            stopLoopIfIdle()
        end
        window:Notification({Title="macro",Text=val and ("<font color='#C41E3A'>playing</font> | " .. summary(macro)) or "stopped playing",Duration=3})
    end,
})
mL:AddToggle("PracticeOnly",{
    Text="practice mode only", Value=true,
    Tooltip="macro playback only runs inside practice mode, so bot runs don't count as real completions or rewards. turn it off and playback counts like a normal run, which can get you flagged",
    Callback=function(val) practiceOnly = val; driftWarned = false end,
})
mL:AddButton("SaveNow",{
    Text="save macro now",
    Tooltip="saves the macro in memory to the gdmacros folder",
    Callback=function()
        local ok = saveMacro()
        window:Notification({Title="macro",Text=ok and ("saved: " .. summary(macro)) or "nothing to save",Duration=3})
    end,
})
mL:AddButton("ClearMacro",{
    Text="clear macro",
    Tooltip="forgets the macro in memory (the saved file stays)",
    Callback=function()
        macro = nil
        rec = {events = {}, traj = {}}
        window:Notification({Title="macro",Text="cleared",Duration=2})
    end,
})
