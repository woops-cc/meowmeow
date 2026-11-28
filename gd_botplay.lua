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

local VERSION = "v2.0"  -- bump this every update or the footer lies to everyone

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
    local ok, res = pcall(function() return lib:Window("gdbot_ap", opts) end)
    if ok and res then window = res; break end
    warn(("[geometry dash] window attempt %d failed: %s"):format(attempt, tostring(res)))
end
if not window then return end
local rawWindow = window
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

-- ---- core ----
local RunService  = game:GetService("RunService")
local RepS        = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local StarterGui  = game:GetService("StarterGui")

local TOKEN     = "gdbot"       -- our own input source, the game treats it like one more finger
local TICKLEN   = 1 / 240       -- the physics runs at 240 ticks a second
local TRS       = 4             -- the macro keeps the player's x/y every 4 ticks to check playback against
local MACRO_DIR = "gdmacros"

local cfg = {
    practiceOnly = true,        -- playback only runs in practice mode, so bot runs never count as real completions
    autoPractice = true,
    lockTaps     = true,
    nudge        = 0,
    epoch        = 4,
    width        = 128,
    budget       = 600,
    strict       = true,
    refine       = true,
    partial      = true,
    slice        = 10,
}

-- R = runtime (record/play hooks), P = pathfinder, M = game modules, L = current level
local R = {rec = false, play = false, hooked = false, wantRec = false, wantPlay = false,
    private = setmetatable({}, {__mode = "k"}), ctxs = setmetatable({}, {__mode = "k"})}
local P = {running = false, stop = false}
local M = {}
local L = {}
local logBuf = {}

local function logLine(s)
    logBuf[#logBuf + 1] = string.format("[%.1f] %s", os.clock() % 100000, tostring(s))
    if #logBuf > 400 then table.remove(logBuf, 1) end
end

-- ui calls only ever run on this heartbeat thread. threads that touched game code (hooks, the search, require) can end up
-- without the capability to build gui, which is what the "lacking capability Plugin" warnings were
local jobs = {}
local function onMain(fn) jobs[#jobs + 1] = fn end
RunService.Heartbeat:Connect(function()
    local n = 0
    while jobs[1] and n < 8 do
        local fn = table.remove(jobs, 1)
        local ok, err = pcall(fn)
        if not ok then warn("[geometry dash] ui job failed: " .. tostring(err)) end
        n = n + 1
    end
end)

local lastNote = {}
local function notify(title, text, dur)
    title, text = tostring(title), tostring(text)
    local key = title .. "|" .. text
    local now = os.clock()
    if lastNote[key] and now - lastNote[key] < 3 then return end
    lastNote[key] = now
    local count = 0
    for _ in pairs(lastNote) do count = count + 1 end
    if count > 120 then lastNote = {} end
    logLine(title .. ": " .. text)
    onMain(function()
        local ok = pcall(function() rawWindow:Notification({Title = title, Text = text, Duration = dur or 4}) end)
        if not ok then
            pcall(function() StarterGui:SetCore("SendNotification", {Title = title, Text = (text:gsub("<[^>]+>", "")), Duration = dur or 4}) end)
        end
    end)
end

-- ---- files ----
local function ensureDir()
    if makefolder and isfolder then
        local ok, has = pcall(isfolder, MACRO_DIR)
        if ok and not has then pcall(makefolder, MACRO_DIR) end
    end
end

local function macroPath(key, partial)
    return MACRO_DIR .. "/" .. key .. (partial and "_partial" or "") .. ".json"
end

local function readJson(path)
    local ok, txt = pcall(readfile, path)
    if not ok or type(txt) ~= "string" or txt == "" then return nil end
    local ok2, res = pcall(function() return HttpService:JSONDecode(txt) end)
    if ok2 and type(res) == "table" then return res end
    return nil
end

local function deleteFile(path)
    if isfile then
        local ok, has = pcall(isfile, path)
        if ok and not has then return true end
    end
    if delfile then
        local ok = pcall(delfile, path)
        if ok then return true end
    end
    return (pcall(writefile, path, ""))
end

local function saveMacro(m, partial, cb)
    onMain(function()
        local ok, err = pcall(function()
            ensureDir()
            writefile(macroPath(m.key, partial), HttpService:JSONEncode(m))
        end)
        -- a finished macro makes the old partial one for the same level pointless
        if ok and not partial then deleteFile(macroPath(m.key, true)) end
        if cb then cb(ok, err) end
    end)
end

local function loadMacro(key)
    local m = readJson(macroPath(key, false))
    if m and type(m.ev) == "table" then return m, false end
    m = readJson(macroPath(key, true))
    if m and type(m.ev) == "table" then return m, true end
    return nil
end

-- ---- which level is this? ----
-- snapshot().id is 0 for online / editor levels, which is why every level used to land in level_0.json. so the key is the
-- level's name plus a fingerprint of its objects, and every level gets its own file
local function sanitize(s)
    s = tostring(s or ""):lower():gsub("[^%w]+", "_"):gsub("^_+", ""):gsub("_+$", "")
    if s == "" then s = "level" end
    return s:sub(1, 40)
end

local function looksLikeStore(t)
    return type(t) == "table" and type(rawget(t, "n")) == "number" and type(rawget(t, "x")) == "table"
        and type(rawget(t, "y")) == "table" and type(rawget(t, "id")) == "table"
end

local function findStore(lvl)
    local seen = {}
    local function scan(t, depth)
        if seen[t] then return nil end
        seen[t] = true
        if looksLikeStore(t) then return t end
        if depth >= 3 then return nil end
        local n = 0
        for k, v in pairs(t) do
            n = n + 1
            if n > 80 then break end
            if type(v) == "table" and k ~= "raw" and k ~= "groups" and k ~= "colors" then
                local r = scan(v, depth + 1)
                if r then return r end
            end
        end
        return nil
    end
    return scan(lvl, 0)
end

local function fingerprint(lvl)
    local h = 5381
    local function mix(v)
        v = tonumber(v) or 0
        v = math.floor(v * 8 + 0.5) % 1000003
        h = (h * 131 + v) % 4294967291
    end
    local store = findStore(lvl)
    if store then
        local n = store.n
        mix(n)
        local step = math.max(1, n // 400)
        for i = 1, n, step do mix(store.id[i]); mix(store.x[i]); mix(store.y[i]) end
    else
        local objs = type(lvl.objects) == "table" and lvl.objects or {}
        local n = #objs
        mix(n)
        local step = math.max(1, n // 400)
        for i = 1, n, step do
            local o = objs[i]
            if type(o) == "table" then mix(o.id); mix(o.x); mix(o.y) end
        end
    end
    mix(lvl.maxObjectX); mix(lvl.length)
    for c in tostring(lvl.name or ""):gmatch(".") do mix(c:byte()) end
    return string.format("%08x", math.floor(h))
end

local function levelInfo(lvl)
    local name = tostring(lvl.name or "")
    local id = lvl.levelId or lvl.id
    local fp = fingerprint(lvl)
    local shown = name ~= "" and name or ("level " .. tostring(id or "?"))
    return {name = shown, id = id, fp = fp, key = sanitize(name ~= "" and name or ("level_" .. tostring(id or "x"))) .. "_" .. fp}
end

-- ---- macro data ----
-- a macro is a list of toggle ticks: the finger goes down at ev[1], up at ev[2], down at ev[3]... (ticks since the level
-- started, half ticks are allowed). tx/ty = player x/y every TRS ticks, used to notice a run that left the recorded line
local function summary(m)
    if not m then return "no macro saved for this level" end
    return string.format("%d taps over %.1fs (%s%s)", math.floor(#(m.ev or {}) / 2 + 0.5), (m.ticks or 0) / 240, tostring(m.src or "?"), m.partial and ", partial" or "")
end

local function heldAt(ev, k)
    local lo, hi = 0, #ev
    while lo < hi do
        local mid = (lo + hi + 1) // 2
        if ev[mid] <= k + 0.0001 then lo = mid else hi = mid - 1 end
    end
    return lo % 2 == 1
end

local function firstAtLeast(ev, k)
    local lo, hi = 1, #ev + 1
    while lo < hi do
        local mid = (lo + hi) // 2
        if ev[mid] < k - 0.0001 then lo = mid + 1 else hi = mid end
    end
    return lo
end

local function round3(v) return math.floor(v * 1000 + 0.5) / 1000 end

local function loadModules()
    if M.ok then return true end
    local gd = RepS:FindFirstChild("GDPort")
    if not gd then return false end
    local function req(n)
        local m = gd:FindFirstChild(n)
        if not m then return nil end
        local ok, r = pcall(require, m)
        if ok and type(r) == "table" then return r end
        return nil
    end
    local CR, RS = req("ClientRuntime"), req("RuntimeSupport")
    if CR and RS then M.CR, M.RS, M.ok = CR, RS, true end
    return M.ok == true
end

local function loadPF()
    if M.pf then return true end
    if not loadModules() then return false end
    local gd = RepS:FindFirstChild("GDPort")
    local function req(n)
        local m = gd and gd:FindFirstChild(n)
        if not m then return nil end
        local ok, r = pcall(require, m)
        if ok and type(r) == "table" then return r end
        return nil
    end
    M.GL, M.Sim, M.Eff = req("GameLayer"), req("Simulation"), req("Effects")
    M.pf = (M.GL and M.Sim and M.Eff) and true or false
    return M.pf
end

-- ---- macro runtime ----
-- how the game eats input (RuntimeSupport.advanceTimeWarpFrame): every frame runs a few 1/240 s ticks, and on the LAST tick of the
-- frame it consumes every queued input no matter what timestamp it has. so queueing taps ahead of time (what v1 did, 0.3 s of
-- look-ahead) makes them land up to 0.3 s early. instead the hook below sits in front of advanceTimeWarpFrame and, tick by tick,
-- queues exactly the state the macro wants for THAT tick. recording reads what the physics was actually fed, per tick, so it
-- doesn't depend on timestamps or frame lengths either
local function newCtx()
    return {state = nil, rec = false, play = false, macro = nil, nudge = 0, gate = nil, onDesync = nil,
        ev = {}, tx = {}, ty = {}, trN = 0, curHeld = false, started = false, endTick = 0,
        lastK = nil, injected = -1, bad = 0, warned = false, maxDrift = 0, rollbacks = 0, desyncs = 0}
end
R.live = newCtx()
R.live.gate = function() return (not cfg.practiceOnly) or R.isPractice == true end
R.live.onDesync = function(k, d)
    R.live.desyncs = R.live.desyncs + 1
    -- one notification per 12 seconds at most, the counter is in the status button
    if os.clock() - (R.live.lastDesyncNote or -100) < 12 then return end
    R.live.lastDesyncNote = os.clock()
    notify("macro desync", string.format("off the recorded line at %.2fs (%.1f units, %d so far). restart the level from the very start and try again, or tell me if it keeps happening", k / 240, d, R.live.desyncs), 6)
end

-- the sim's tick counter (1/240 s units). falls back to time * 240 if a build ever drops the field
local function tickOf(st)
    local k = st.tick
    if type(k) == "number" then return k end
    if type(st.time) == "number" then return st.time * 240 end
    return nil
end

local function hookError(err)
    if R.err then return end
    R.err = tostring(err)
    notify("macro", "internal error: " .. R.err:sub(1, 160), 8)
end

local function purgeOurs(tl)
    local q = tl.queue
    for i = #q, 1, -1 do
        if q[i].token == TOKEN then table.remove(q, i) end
    end
    pcall(M.RS.releaseInput, tl.capture, TOKEN)
    pcall(M.RS.releaseInput, tl.input, TOKEN)
end

local function resetRec(ctx)
    ctx.ev, ctx.tx, ctx.ty, ctx.trN, ctx.curHeld, ctx.endTick = {}, {}, {}, 0, false, 0
end

local function rollbackRec(ctx, k)
    local ev = ctx.ev
    while #ev > 0 and ev[#ev] >= k - 0.01 do ev[#ev] = nil end
    ctx.curHeld = (#ev % 2 == 1)
    local keep = 0
    while keep * TRS < k - 0.01 do keep = keep + 1 end
    for i = #ctx.tx, keep + 1, -1 do ctx.tx[i], ctx.ty[i] = nil, nil end
    if ctx.trN > keep then ctx.trN = keep end
end

local function rolledBack(ctx, tl, k)
    ctx.rollbacks = ctx.rollbacks + 1
    ctx.injected = -1
    ctx.bad, ctx.warned = 0, false
    if ctx.play then purgeOurs(tl) end
    if ctx.rec then
        if k <= 1.0 then resetRec(ctx); ctx.started = true
        elseif ctx.started then rollbackRec(ctx, k) end
    end
end

-- records what the physics saw for the tick about to run: finger state changes and the player's position
local function record(ctx, st, k, held)
    if not ctx.started or st.dead or st.complete then return end
    local hd = held == true
    if hd ~= ctx.curHeld then
        ctx.ev[#ctx.ev + 1] = math.floor(k * 2 + 0.5) / 2
        ctx.curHeld = hd
    end
    local kr = math.floor(k + 0.5)
    if math.abs(k - kr) < 0.02 and kr % TRS == 0 then
        local idx = kr // TRS + 1
        ctx.tx[idx], ctx.ty[idx] = round3(st.x), round3(st.y)
        if idx > ctx.trN then ctx.trN = idx end
    end
    ctx.endTick = k
end

-- the sim is deterministic, so at the same tick the player must be on the recorded spot
local function check(ctx, st, k)
    local m = ctx.macro
    if not m.tx or (ctx.nudge or 0) ~= 0 or st.dead then return end
    local kr = math.floor(k + 0.5)
    if math.abs(k - kr) > 0.02 or kr % TRS ~= 0 then return end
    local idx = kr // TRS + 1
    local ex, ey = m.tx[idx], m.ty[idx]
    if not ex or not ey then return end
    local d = math.max(math.abs(st.x - ex), math.abs(st.y - ey))
    if d > ctx.maxDrift then ctx.maxDrift = d end
    if d > 0.75 then
        ctx.bad = ctx.bad + 1
        if ctx.bad >= 4 and not ctx.warned then
            ctx.warned = true
            if ctx.onDesync then ctx.onDesync(kr, d) end
        end
    else
        ctx.bad = 0
    end
end

-- puts the macro's finger state for the tick [k0, k0 + 1) into the game's queue. base = timeline clock at the start of that tick.
-- an event in the first half of the tick lands at +0.25 tick, one in the second half at +0.75 (that is what makes the game split the
-- tick, same as the original run did). sequence = 0 so it counts as queued before the frame even when we add it mid frame
local function inject(ctx, tl, k0, base)
    local m = ctx.macro
    if not m or not ctx.play then return end
    local kr = math.floor(k0 + 0.5)
    if math.abs(k0 - kr) > 0.02 or kr <= ctx.injected then return end
    if ctx.gate and not ctx.gate() then return end
    ctx.injected = kr
    local ev = m.ev
    local k = kr - (ctx.nudge or 0)
    local cap = tl.capture.sources[TOKEN]
    local capHeld = cap ~= nil and cap.jump == true
    local d = heldAt(ev, k - 0.25)
    local function put(te, down)
        local e = M.origQI(tl, te, TOKEN, "jump", down)
        if e then e.sequence = 0 end
    end
    if capHeld ~= d then put(base + TICKLEN * 0.02, d) end
    local i = firstAtLeast(ev, k)
    while ev[i] and ev[i] < k + 0.999 do
        d = not d
        local frac = ev[i] - k
        put(base + TICKLEN * (frac < 0.5 and 0.25 or 0.75), d)
        i = i + 1
    end
end

local function preFrame(ctx, tl, st)
    local k = tickOf(st)
    if not k then return end
    if ctx.rec and not ctx.started and k <= 1.0 then resetRec(ctx); ctx.started = true end
    if ctx.lastK and k < ctx.lastK - 0.25 then rolledBack(ctx, tl, k) end
    ctx.lastK = k
    if ctx.play and ctx.macro then inject(ctx, tl, k, tl.clock) end
end

-- runs right before the physics of every segment (a tick, or half a tick when the game splits it for a click between steps)
local function segment(ctx, tl, st, held, simh)
    local k = tickOf(st)
    if not k then return end
    if ctx.lastK and k < ctx.lastK - 0.25 then rolledBack(ctx, tl, k) end
    ctx.lastK = k
    if ctx.rec then record(ctx, st, k, held) end
    if ctx.play and ctx.macro then
        check(ctx, st, k)
        if not M.RS.stepLastOfFrame then inject(ctx, tl, k + simh * 240, tl.clock + simh) end
    end
end

local function pickCtx(tl)
    local c = R.ctxs[tl]
    if c then return c end
    if R.private[tl] then return nil end
    local live = R.live
    if (live.rec or live.play) and M.CR then
        local lyr = M.CR.layer
        if type(lyr) == "table" and lyr.timeline == tl and type(lyr.state) == "table" then
            live.state = lyr.state
            return live
        end
    end
    return nil
end

local function installHooks()
    if R.hooked then return end
    local RS = M.RS
    R.hooked = true
    M.origAdv, M.origQI, M.origQR = RS.advanceTimeWarpFrame, RS.queueInput, RS.queueRelease
    RS.advanceTimeWarpFrame = function(tl, dt, now, options, onStep, isRelevant)
        local ctx = pickCtx(tl)
        if not ctx or type(onStep) ~= "function" or type(ctx.state) ~= "table" then
            return M.origAdv(tl, dt, now, options, onStep, isRelevant)
        end
        local st = ctx.state
        local ok, err = pcall(preFrame, ctx, tl, st)
        if not ok then hookError(err) end
        local function step(h, held, pressed, left, right, edges, simh, scale)
            local ok2, err2 = pcall(segment, ctx, tl, st, held, simh or h)
            if not ok2 then hookError(err2) end
            return onStep(h, held, pressed, left, right, edges, simh, scale)
        end
        return M.origAdv(tl, dt, now, options, step, isRelevant)
    end
    -- while a macro plays your own presses are dropped (releases always pass, so nothing can get stuck down)
    RS.queueInput = function(tl, time, token, action, down)
        if down == true and token ~= TOKEN and cfg.lockTaps and R.live.play and not R.private[tl] and not R.ctxs[tl] then
            -- only lock while the macro is really driving the level, so you can take over when it ends or isn't there
            local live = R.live
            local m, st = live.macro, live.state
            if m and st and live.gate() and (tickOf(st) or 0) <= (m.ticks or 0) + 8 then return nil end
        end
        return M.origQI(tl, time, token, action, down)
    end
    RS.queueRelease = function(tl, time, token)
        return M.origQR(tl, time, token)
    end
end

local function removeHooks()
    if not R.hooked or R.verifying then return end
    R.hooked = false
    local RS = M.RS
    if RS.advanceTimeWarpFrame ~= M.origAdv then RS.advanceTimeWarpFrame = M.origAdv end
    if RS.queueInput ~= M.origQI then RS.queueInput = M.origQI end
    if RS.queueRelease ~= M.origQR then RS.queueRelease = M.origQR end
end

local function liveTimeline()
    local lyr = M.CR and M.CR.layer
    return type(lyr) == "table" and lyr.timeline or nil
end

local function buildRecorded(partial)
    local c = R.live
    local m = {v = 3, key = L.info.key, name = L.info.name, src = "recorded", partial = partial or nil, ticks = math.floor(c.endTick), ev = {},
        trStep = TRS, tx = {}, ty = {}}
    for i, v in ipairs(c.ev) do m.ev[i] = v end
    if #m.ev % 2 == 1 then m.ev[#m.ev + 1] = m.ticks + 1 end
    for i = 1, c.trN do
        m.tx[i] = c.tx[i] or m.tx[i - 1] or 0
        m.ty[i] = c.ty[i] or m.ty[i - 1] or 0
    end
    return m
end

local function finishRecording()
    local c = R.live
    local m = buildRecorded(false)
    c.rec, c.started = false, false
    R.wantRec = false
    c.macro = m
    saveMacro(m, false, function(ok)
        notify("macro recorded", summary(m) .. (ok and " (saved)" or " (couldn't save the file)"), 6)
    end)
    onMain(function() if R.uiRec then R.uiRec:SetValue(false) end end)
end

-- ---- the loop (heartbeat, never inside the game's own threads) ----
local function onLevel(lyr)
    R.lvl = lyr.level
    local ok, info = pcall(levelInfo, lyr.level)
    L.info = ok and info or {key = "level_unknown", name = "unknown level", fp = "00000000"}
    local live = R.live
    local m, partial = loadMacro(L.info.key)
    if m and partial then m.partial = true end
    live.macro = m
    live.injected, live.lastK, live.bad, live.warned, live.maxDrift = -1, nil, 0, false, 0
    resetRec(live)
    live.started = false
    R.practiceWarned = false
    notify("level", L.info.name .. ": " .. summary(m), 4)
end

local function applyModes()
    local live = R.live
    local tl = liveTimeline()
    if R.wantRec and not live.rec then
        live.rec, live.play = true, false
        R.play = false
        resetRec(live)
        live.started = (live.state and tickOf(live.state) or 99) <= 1.0
        installHooks()
        notify("macro", live.started and "<font color='#C41E3A'>recording</font>, play the level" or "recording starts when the level restarts from the beginning (die or restart)", 4)
    elseif not R.wantRec and live.rec then
        live.rec, live.started = false, false
        notify("macro", "stopped recording", 3)
    end
    if R.wantPlay and not live.play then
        live.rec, live.play = false, true
        live.injected, live.bad, live.warned, live.maxDrift = -1, 0, false, 0
        installHooks()
        if live.macro then notify("macro", "<font color='#C41E3A'>playing</font> | " .. summary(live.macro), 4)
        else notify("macro", "no macro saved for this level yet, record one or use the pathfinder", 5) end
    elseif not R.wantPlay and live.play then
        live.play = false
        if tl then purgeOurs(tl) end
        notify("macro", "stopped playing", 3)
    end
    if live.rec ~= R.rec then R.rec = live.rec end
    if live.play ~= R.play then R.play = live.play end
    if not live.rec and not live.play and not R.verifying then removeHooks() end
end

local function poll(dt)
    if not loadModules() then return end
    local CR = M.CR
    local lyr = CR.layer
    if type(lyr) ~= "table" or type(lyr.level) ~= "table" or type(lyr.state) ~= "table" then return end
    local live = R.live
    live.state = lyr.state
    if lyr.level ~= R.lvl then onLevel(lyr) end
    applyModes()
    R.snapT = (R.snapT or 0) - dt
    if R.snapT <= 0 then
        R.snapT = 0.25
        local ok, snap = pcall(CR.snapshot)
        if ok and type(snap) == "table" then
            R.isPractice = snap.practice == true
            R.snap = {practice = snap.practice == true, dead = snap.dead == true, complete = snap.complete == true, paused = snap.paused == true}
        end
    end
    local snap = R.snap
    if (live.rec or live.play) and cfg.autoPractice and snap and not snap.practice and not snap.dead and not snap.complete
        and (not R.lastPrac or os.clock() - R.lastPrac > 1) then
        R.lastPrac = os.clock()
        pcall(CR.enterPractice)
        R.snapT = 0
    end
    if live.play and cfg.practiceOnly and not cfg.autoPractice and snap and not snap.practice and not R.practiceWarned then
        R.practiceWarned = true
        notify("macro", "playback only runs in practice mode, so bot runs dont count. turn practice mode on (or switch that off in the macro tab)", 6)
    end
    if live.rec and live.started and (lyr.state.complete == true or (snap and snap.complete)) then finishRecording() end
end

RunService.Heartbeat:Connect(function(dt)
    if P.wantRun then
        P.wantRun = false
        if R.startPathfinder then R.startPathfinder() end
    end
    local ok, err = pcall(poll, dt)
    if not ok and os.clock() - (R.lastErr or 0) > 3 then
        R.lastErr = os.clock()
        warn("[geometry dash] loop error: " .. tostring(err))
        logLine("loop error: " .. tostring(err))
    end
end)

-- ---- pathfinder ----
-- runs the game's own physics (GameLayer + Simulation) in a private copy of the level and searches for the taps that get through.
-- v1 was a depth first search that walked into a dead end and then had to backtrack through every choice it made since, which blows
-- up on waves (a bait portal kills you a second after you touch it). this one is a breadth first sweep: it keeps EVERY state that is
-- still alive at each step (merged when two states are basically the same), so a doomed state just dies out on its own
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

local function buildSim(forcePointer)
    local live = M.CR.layer
    if type(live) ~= "table" or type(live.level) ~= "table" then return nil, "open a level first (you have to be inside it)" end
    local lvl = live.level
    if lvl.platformer or lvl.isPlatformer then return nil, "platformer levels aren't supported yet" end
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
    R.private[tl] = true
    local layer = M.GL.new({level = lvl2, state = state, effects = eff, renderer = nil, shake = nil, support = M.RS, timeline = tl, clock = 0,
        quantum = not lvl.platformer,
        hooks = {isPaused = function() return false end, completeTimers = true, quitLevel = function() end}})
    layer:start()
    if forcePointer then lvl2._lifecycleLayer = layer end
    -- the layer eats its first couple of steps as warm up frames, do that now so every run from the checkpoint behaves the same
    for _ = 1, 4 do
        if (layer.skipFrames or 0) > 0 then layer:steps(1 / 60) end
    end
    return {state = state, layer = layer, tl = tl, level = lvl2}
end

local function zeroTimeline(S)
    local tl = S.tl
    tl.remainder, tl.debt, tl._debtTicks = 0, 0, 0
    local q = tl.queue
    for i = #q, 1, -1 do table.remove(q, i) end
    if type(tl.frames) == "table" then
        for i = #tl.frames, 1, -1 do table.remove(tl.frames, i) end
    end
end

-- makes the timeline's finger state match a node. restoring a checkpoint only restores the player, not the finger, and the game
-- decides "was this a fresh press?" from the finger state, so a stale one would change the physics
local function setHeld(S, held)
    local tl, RS = S.tl, M.RS
    RS.releaseInput(tl.input, TOKEN)
    RS.releaseInput(tl.capture, TOKEN)
    if held then
        RS.setInput(tl.input, TOKEN, "jump", true)
        RS.setInput(tl.capture, TOKEN, "jump", true)
    end
    tl.input.pressed, tl.input.pressed2 = false, nil
    tl.capture.pressed, tl.capture.pressed2 = false, nil
end

local function restore(S, node)
    M.Sim.reset(S.state, node.cp)
    zeroTimeline(S)
    setHeld(S, node.held)
end

local function applyEpoch(S, dt, held)
    S.layer:steps(dt, {{TOKEN, "jump", held}})
    return not S.state.dead
end

local function finished(S)
    local st = S.state
    return st.complete == true or st._nativeEndLocked == true
end

local function sig(S)
    local s = S.state
    return string.format("%.4f|%.4f|%.3f|%s|%s|%.3f", s.x or 0, s.y or 0, s.tick or 0, tostring(s.dead), tostring(s.mode), s.vy or 0)
end

-- test patterns for the self test. the player has to survive the pattern for the test to mean anything, so the first one that
-- gets far enough is used
local PATS = {
    function(i) return (i // 2) % 2 == 0 end,
    function(i) return (i // 4) % 2 == 0 end,
    function(i) return false end,
    function(i) return true end,
    function(i) return (i // 1) % 2 == 0 end,
    function(i) return (i // 8) % 2 == 0 end,
}

local function runPat(S, pat, from, to)
    for i = from, to do
        S.layer:steps(1 / 60, {{TOKEN, "jump", pat(i)}})
        if S.state.dead then return i end
    end
    return to
end

-- same input twice must give the same result, and so must "restore a checkpoint taken halfway and carry on"
local function selfTest(S)
    local function fresh() M.Sim.reset(S.state, S.cp0); zeroTimeline(S); setHeld(S, false) end
    local pat, n = PATS[1], 0
    for _, cand in ipairs(PATS) do
        fresh()
        local got = runPat(S, cand, 1, 90)
        if got > n and not S.state.dead then pat, n = cand, got end
        if got > n and n < 90 then pat, n = cand, got end
        if n >= 90 then break end
    end
    if n < 10 then return true, "short" end
    fresh(); runPat(S, pat, 1, n)
    if (S.state.tick or 0) < n and not S.state.dead then return false, "the simulation doesn't advance" end
    local a = sig(S)
    fresh(); runPat(S, pat, 1, n)
    if a ~= sig(S) then return false, "not deterministic" end
    local mid = n // 2
    fresh(); runPat(S, pat, 1, mid)
    local cp = M.Sim.checkpoint(S.state)
    runPat(S, pat, mid + 1, n)
    local c = sig(S)
    M.Sim.reset(S.state, cp); zeroTimeline(S); setHeld(S, pat(mid))
    runPat(S, pat, mid + 1, n)
    if c ~= sig(S) then return false, "restoring a checkpoint changes the result" end
    return true
end

local function keyOf(st, held)
    return string.format("%s|%d|%d|%d|%s|%s|%s", tostring(st.mode), math.floor((st.x or 0) / 2), math.floor((st.y or 0) + 0.5),
        math.floor((st.vy or 0) / 2 + 0.5), tostring(st.gravity), tostring(st.grounded), held and "1" or "0")
end

-- when there are more live states than the width allows, keep an even spread over height (a wave has no "best" state, only
-- different places to be). states in a mode that isn't the main one are capped, so a bait portal can't crowd out the real route
local function stratified(list, take, out)
    if take <= 0 or #list == 0 then return end
    table.sort(list, function(a, b)
        if a.y ~= b.y then return a.y < b.y end
        return (a.held and 1 or 0) < (b.held and 1 or 0)
    end)
    local n = #list
    if n <= take then
        for _, v in ipairs(list) do out[#out + 1] = v end
        return
    end
    for i = 1, take do
        local idx = math.floor((i - 0.5) * n / take + 0.5)
        if idx < 1 then idx = 1 end
        out[#out + 1] = list[idx]
    end
end

local function truncate(list, width)
    if #list <= width then return list end
    local groups, order = {}, {}
    for _, n in ipairs(list) do
        local key = tostring(n.mode) .. "|" .. tostring(n.grav)
        local g = groups[key]
        if not g then g = {}; groups[key] = g; order[#order + 1] = g end
        g[#g + 1] = n
    end
    -- every mode / gravity lineage gets an equal share (small ones keep everything), so a doomed lineage can't crowd out the real route
    table.sort(order, function(a, b) return #a < #b end)
    local out, remaining = {}, width
    for i, g in ipairs(order) do
        local take = math.min(#g, remaining // (#order - i + 1))
        stratified(g, take, out)
        remaining = remaining - take
    end
    return out
end

local function pathOf(node)
    local rev = {}
    while node and node.parent do
        rev[#rev + 1] = node.held
        node = node.parent
    end
    local path = {}
    for i = #rev, 1, -1 do path[#path + 1] = rev[i] end
    return path
end

local function toToggles(path, E)
    local ev, prev = {}, false
    for d = 1, #path do
        if path[d] ~= prev then ev[#ev + 1] = (d - 1) * E; prev = path[d] end
    end
    if prev then ev[#ev + 1] = #path * E end
    return ev
end

local function endXOf()
    local lyr = M.CR.layer
    local ok, snap = pcall(M.CR.snapshot)
    if ok and type(snap) == "table" and type(snap.classicEnd) == "table" and type(snap.classicEnd.portalX) == "number" then
        return snap.classicEnd.portalX
    end
    return type(lyr) == "table" and type(lyr.level) == "table" and (lyr.level.maxObjectX or lyr.level.length) or nil
end

local function search(S, E, endX)
    local state = S.state
    local dt = E * TICKLEN
    local width = cfg.width
    local startMode = state.mode
    local strict = cfg.strict
    local root = {cp = S.cp0, held = false, x = state.x or 0, y = state.y or 0, mode = startMode, depth = 0}
    local frontier, best = {root}, root
    local depth, nodes, bestX = 0, 0, state.x or 0
    local lastRej
    local t0 = os.clock()
    local lastNote, lastYield = t0, t0
    local slice = cfg.slice / 1000
    local lastFrontier = root
    while true do
        if P.stop then return {status = "stopped", best = best, depth = depth, nodes = nodes, bestX = bestX} end
        if os.clock() - t0 > cfg.budget then return {status = "budget", best = best, depth = depth, nodes = nodes, bestX = bestX} end
        depth = depth + 1
        local nextF, seen, rej, won = {}, {}, {}, nil
        for _, node in ipairs(frontier) do
            local order = node.held and {true, false} or {false, true}
            for oi = 1, 2 do
                local c = order[oi]
                restore(S, node)
                local alive = applyEpoch(S, dt, c)
                nodes = nodes + 1
                if alive then
                    if finished(S) then
                        won = {parent = node, held = c, x = state.x, y = state.y, depth = depth, mode = state.mode}
                        break
                    end
                    local mode = state.mode
                    if strict and mode ~= startMode then
                        if #rej < 24 then
                            rej[#rej + 1] = {parent = node, held = c, cp = M.Sim.checkpoint(state), x = state.x or 0, y = state.y or 0, mode = mode, grav = state.gravity, depth = depth}
                        end
                    else
                        local key = keyOf(state, c)
                        if not seen[key] then
                            seen[key] = true
                            nextF[#nextF + 1] = {parent = node, held = c, cp = M.Sim.checkpoint(state), x = state.x or 0, y = state.y or 0,
                                mode = mode, grav = state.gravity, depth = depth}
                        end
                    end
                end
                local now = os.clock()
                if now - lastYield > slice then task.wait(); lastYield = os.clock() end
            end
            if won then break end
            node.cp = nil
        end
        if won then return {status = "found", node = won, depth = depth, nodes = nodes, bestX = state.x} end
        if #rej > 0 then lastRej = {depth = depth, list = rej} end
        if #nextF == 0 then
            if strict and lastRej then
                strict = false
                notify("pathfinder", "no route stays in the starting mode here, letting it change mode from x " .. string.format("%.0f", lastRej.list[1].x), 4)
                frontier, depth, lastRej = lastRej.list, lastRej.depth, nil
                best = frontier[1]
                lastFrontier = frontier[1]
            else
                return {status = "dead", best = lastFrontier, depth = depth, nodes = nodes, bestX = bestX}
            end
        else
            nextF = truncate(nextF, width)
            frontier = nextF
            local bn = nextF[1]
            for _, n in ipairs(nextF) do
                if n.x > bn.x then bn = n end
            end
            best, lastFrontier = bn, bn
            if bn.x > bestX then bestX = bn.x end
        end
        local now = os.clock()
        if now - lastNote > 3 then
            lastNote = now
            local pct = endX and endX > 0 and string.format("%d%% | ", math.min(99, math.floor(bestX / endX * 100))) or ""
            notify("pathfinder", string.format("%sx %.0f | %.0fs into the level | %d states | %.0fs", pct, bestX, depth * E / 240, #frontier, now - t0), 3)
        end
    end
end

-- plays a toggle list tick by tick from the start and records the line the macro will be checked against
local function replay(S, ev, ticks)
    M.Sim.reset(S.state, S.cp0); zeroTimeline(S); setHeld(S, false)
    local tx, ty = {}, {}
    local lastYield = os.clock()
    for k = 0, ticks - 1 do
        if k % TRS == 0 then
            local i = k // TRS + 1
            tx[i], ty[i] = round3(S.state.x), round3(S.state.y)
        end
        S.layer:steps(TICKLEN, {{TOKEN, "jump", heldAt(ev, k)}})
        if S.state.dead then return false, tx, ty, k end
        if finished(S) then return true, tx, ty, k + 1 end
        if os.clock() - lastYield > 0.01 then task.wait(); lastYield = os.clock() end
    end
    return finished(S), tx, ty, ticks
end

-- plays the macro back through the same hook the real game uses, with uneven frame lengths like a phone has
local function verifyJitter(S, m)
    local ctx = newCtx()
    ctx.state, ctx.play, ctx.macro = S.state, true, m
    ctx.onDesync = function() ctx.desyncs = ctx.desyncs + 1 end
    R.ctxs[S.tl] = ctx
    R.verifying = true
    installHooks()
    M.Sim.reset(S.state, S.cp0); zeroTimeline(S); setHeld(S, false)
    local rng = 987654321
    local lastYield = os.clock()
    for _ = 1, (m.ticks + 600) // 3 + 50 do
        rng = (rng * 1103515245 + 12345) % 2147483648
        local n = 3 + (rng // 65536) % 3
        local jit = ((rng // 8) % 1000) / 1000 * 0.6 - 0.3
        S.layer:steps((n + jit) * TICKLEN, nil)
        if S.state.dead or finished(S) then break end
        if os.clock() - lastYield > 0.01 then task.wait(); lastYield = os.clock() end
    end
    R.ctxs[S.tl] = nil
    R.verifying = false
    if not R.live.rec and not R.live.play then removeHooks() end
    return (finished(S) and not S.state.dead), ctx.maxDrift, ctx.desyncs
end

local function pfMain()
    if not loadPF() then notify("pathfinder", "couldn't load the game's modules", 5); return end
    local live = M.CR.layer
    if type(live) ~= "table" or type(live.level) ~= "table" then notify("pathfinder", "open a level first (you have to be inside it)", 5); return end
    if R.lvl ~= live.level or not L.info then
        local okI, inf = pcall(levelInfo, live.level)
        L.info = okI and inf or {key = "level_unknown", name = "unknown level", fp = "00000000"}
    end
    local info = L.info
    local S, why
    for _, forcePtr in ipairs({true, false}) do
        local s, e = buildSim(forcePtr)
        if not s then notify("pathfinder", e or "couldn't build the simulation", 6); return end
        s.cp0 = M.Sim.checkpoint(s.state)
        local ok, reason = selfTest(s)
        if ok then S = s; break end
        logLine("self test failed (" .. tostring(reason) .. ") with pointer " .. tostring(forcePtr))
        why = reason
    end
    if not S then notify("pathfinder", "the private simulation failed its self test (" .. tostring(why) .. "), so a search can't be trusted on this level", 8); return end
    notify("pathfinder", "searching " .. info.name .. " (mode " .. tostring(S.state.mode) .. ")", 4)
    local endX = endXOf()
    local epochs = {cfg.epoch}
    if cfg.refine then
        local e = cfg.epoch
        while e > 1 do e = math.max(1, e // 2); epochs[#epochs + 1] = e end
    end
    local res, usedE
    for i, E in ipairs(epochs) do
        usedE = E
        res = search(S, E, endX)
        logLine(string.format("search at %d ticks: %s, depth %d, %d sims, best x %.0f", E, res.status, res.depth, res.nodes, res.bestX or 0))
        if res.status ~= "dead" or i == #epochs then break end
        notify("pathfinder", string.format("stuck at x %.0f with %d ticks per decision, trying %d", res.bestX or 0, E, epochs[i + 1]), 4)
    end
    if res.status == "found" then
        local path = pathOf(res.node)
        local ev = toToggles(path, usedE)
        local fin, tx, ty, endTick = replay(S, ev, #path * usedE + 8)
        local m = {v = 3, key = info.key, name = info.name, src = "pathfinder", ticks = endTick, ev = ev, trStep = TRS, tx = tx, ty = ty, epoch = usedE}
        local okJ, drift, ds = false, 0, 0
        if fin then okJ, drift, ds = verifyJitter(S, m) end
        m.verified = fin and okJ
        if L.info and L.info.key == info.key then R.live.macro = m end
        saveMacro(m, false, function(ok)
            local txt = string.format("PATH FOUND: %d taps, %.1fs. replay %s, uneven frame test %s (drift %.2f). %s",
                #ev // 2, endTick / 240, fin and "ok" or "FAILED", okJ and "ok" or "FAILED", drift or 0,
                ok and "saved, turn on play macro (practice mode)" or "couldn't save the file")
            notify("pathfinder", txt, 10)
        end)
        return
    end
    local why2 = res.status == "dead" and "every route dies" or (res.status == "budget" and "ran out of time" or "stopped")
    local msg = string.format("no full path (%s), furthest x %.0f%s", why2, res.bestX or 0, endX and string.format(" of %.0f", endX) or "")
    if cfg.partial and res.best and res.best.parent then
        local path = pathOf(res.best)
        local ev = toToggles(path, usedE)
        local fin, tx, ty, endTick = replay(S, ev, #path * usedE + 8)
        local m = {v = 3, key = info.key, name = info.name, src = "pathfinder", partial = true, ticks = endTick, ev = ev, trStep = TRS, tx = tx, ty = ty, epoch = usedE}
        saveMacro(m, true, function(ok) notify("pathfinder", msg .. (ok and ", saved the furthest run as a partial macro" or ""), 10) end)
    else
        notify("pathfinder", msg, 10)
    end
end

function R.startPathfinder()
    if P.running then notify("pathfinder", "already searching", 3); return end
    P.running, P.stop = true, false
    task.spawn(function()
        local ok, err = xpcall(pfMain, function(e) return tostring(e) end)
        P.running = false
        if not ok then
            logLine("pathfinder error: " .. tostring(err))
            notify("pathfinder", "error: " .. tostring(err):sub(1, 170), 9)
        end
    end)
end

-- ---- ui ----
local function statusText()
    local live = R.live
    local hooked = R.hooked and "on" or "off"
    return string.format("level: %s | macro: %s | practice: %s | record: %s, play: %s | hooks %s | desyncs %d, max drift %.2f%s",
        L.info and L.info.name or "none yet", summary(live.macro), tostring(R.isPractice == true), tostring(live.rec), tostring(live.play),
        hooked, live.desyncs, live.maxDrift, R.err and (" | error: " .. R.err:sub(1, 80)) or "")
end

local infoTab = window:AddTab("InfoTab", {Text="info",  Icon="info"})
local mainTab = window:AddTab("MainTab", {Text="macro", Icon="play"})

local iL = infoTab:AddLeftGroupbox("IL", {Text="about"})
iL:AddLabel("IL1",{Text="<font color='#C41E3A'><b>geometry dash botplay</b></font> by woops &lt;3\n\nrecords your runs and plays them back on the exact physics tick, and can find the taps for a level by itself.\n\n<b>record</b>: open a level, turn it on and beat the level from the start. it switches to practice mode for you, dying is fine, the failed attempt after your checkpoint gets dropped. finishing the level saves the macro.\n<b>play macro</b>: restart the level and it replays the run.\n<b>find path</b>: searches the level inside a private copy of the game's physics and saves the taps it finds as a macro."})
iL:AddSeparator("ILS",{})
iL:AddLabel("IL2",{Text="<b>right shift</b> = open / close the menu\nevery level gets its own file in the <b>gdmacros</b> folder, named after the level"})

local mL = mainTab:AddLeftGroupbox("ML", {Text="macro"})
R.uiRec = mL:AddToggle("Record",{
    Text="record", Value=false,
    Tooltip="records your taps as the physics sees them, tick by tick. turn it on, restart the level from the beginning and beat it. dying in practice mode is fine, the macro keeps everything before your checkpoint. finishing saves the macro for this level",
    Callback=function(val)
        R.wantRec = val
        if val then
            R.wantPlay = false
            if R.uiPlay then R.uiPlay:SetValue(false) end
        end
    end,
})
R.uiPlay = mL:AddToggle("Play",{
    Text="play macro", Value=false,
    Tooltip="plays this level's macro on the exact ticks it was recorded on, every attempt. your own taps are ignored while it plays (see lock my taps)",
    Callback=function(val)
        R.wantPlay = val
        if val then
            R.wantRec = false
            if R.uiRec then R.uiRec:SetValue(false) end
        end
    end,
})
mL:AddToggle("AutoPractice",{
    Text="auto practice mode", Value=true,
    Tooltip="switches the level to practice mode by itself when you record or play, so you can die without losing the run",
    Callback=function(val) cfg.autoPractice = val end,
})
mL:AddToggle("PracticeOnly",{
    Text="practice mode only", Value=true,
    Tooltip="macro playback only runs inside practice mode, so bot runs don't count as real completions or rewards. turn it off and playback counts like a normal run, which can get you flagged",
    Callback=function(val) cfg.practiceOnly = val; R.practiceWarned = false end,
})
mL:AddToggle("LockTaps",{
    Text="lock my taps while playing", Value=true,
    Tooltip="drops your own presses while a macro plays. a finger on the screen counts as one more input and would ruin the run",
    Callback=function(val) cfg.lockTaps = val end,
})
mL:AddSlider("Nudge",{
    Text="timing nudge (ticks)", Min=-8, Max=8, Value=0, Step=1,
    Tooltip="shifts every playback input by this many physics ticks (1 tick = 1/240 s). playback is exact now, so leave it at 0 unless you want to experiment. the desync check is off while it isn't 0",
    Callback=function(v) cfg.nudge = v; R.live.nudge = v end,
})
mL:AddSeparator("MS",{})
mL:AddButton("SaveNow",{
    Text="save macro now",
    Tooltip="saves the macro in memory to this level's file. while you are recording it saves what you have so far as a partial macro",
    Callback=function()
        local live = R.live
        if live.rec and live.started and #live.ev > 0 and L.info then
            local m = buildRecorded(true)
            saveMacro(m, true, function(ok) notify("macro", ok and ("saved so far as a partial macro: " .. summary(m)) or "couldn't save the file", 4) end)
        elseif live.macro then
            local m = live.macro
            saveMacro(m, m.partial == true, function(ok) notify("macro", ok and ("saved: " .. summary(m)) or "couldn't save the file", 3) end)
        else
            notify("macro", "nothing to save yet", 3)
        end
    end,
})
mL:AddButton("ListMacros",{
    Text="list saved macros",
    Tooltip="shows the macro files in the gdmacros folder",
    Callback=function()
        onMain(function()
            local names = {}
            if listfiles then
                local ok, list = pcall(listfiles, MACRO_DIR)
                if ok and type(list) == "table" then
                    for _, f in ipairs(list) do
                        local n = tostring(f):match("([^/\\]+)%.json$")
                        if n then names[#names + 1] = n end
                    end
                end
            end
            if #names == 0 then
                notify("macro", "no saved macros yet", 3)
            else
                notify("macro", string.format("%d saved: %s", #names, table.concat(names, ", "):sub(1, 220)), 8)
            end
        end)
    end,
})
mL:AddButton("DeleteMacro",{
    Text="delete this level's macro",
    Tooltip="deletes the saved macro file of the level you are in (and its partial file), and forgets it in memory. recording or finding a path makes a new one",
    Callback=function()
        local info = L.info
        if not info then notify("macro", "open a level first", 3); return end
        R.live.macro = nil
        onMain(function()
            deleteFile(macroPath(info.key, false))
            deleteFile(macroPath(info.key, true))
            notify("macro", "deleted the macro files of " .. info.name, 4)
        end)
    end,
})
mL:AddButton("DeleteAll",{
    Text="delete ALL macro files",
    Tooltip="deletes everything in the gdmacros folder, including old level_<id> files from the first version. press it twice within 5 seconds",
    Callback=function()
        if os.clock() - (R.delAsk or -100) > 5 then
            R.delAsk = os.clock()
            notify("macro", "press delete ALL again within 5 seconds to wipe the gdmacros folder", 5)
            return
        end
        R.delAsk = nil
        R.live.macro = nil
        onMain(function()
            local n = 0
            if listfiles then
                local ok, list = pcall(listfiles, MACRO_DIR)
                if ok and type(list) == "table" then
                    for _, f in ipairs(list) do
                        if tostring(f):sub(-5) == ".json" and deleteFile(f) then n = n + 1 end
                    end
                end
            end
            notify("macro", string.format("deleted %d macro files", n), 4)
        end)
    end,
})
mL:AddButton("Status",{
    Text="status",
    Tooltip="shows what the tool is doing right now: level, macro, practice mode, hooks, desync count",
    Callback=function() notify("status", statusText(), 8) end,
})
mL:AddButton("CopyLog",{
    Text="copy log",
    Tooltip="copies the tool's log to the clipboard, handy when you want to tell me what happened",
    Callback=function()
        local ok = false
        if setclipboard then ok = pcall(setclipboard, statusText() .. "\n" .. table.concat(logBuf, "\n")) end
        notify("log", ok and "copied" or "couldn't copy (no clipboard)", 3)
    end,
})

local pL = mainTab:AddRightGroupbox("PL", {Text="pathfinder"})
pL:AddButton("Find",{
    Text="find path",
    Tooltip="searches the level you are in from the start, in a private copy of the physics, and saves the taps it finds as this level's macro. it keeps going until it finds a way through, runs out of time, or you press stop. you can keep playing meanwhile",
    Callback=function() P.wantRun = true end,
})
pL:AddButton("Stop",{
    Text="stop",
    Tooltip="stops the search (the furthest run it reached gets saved as a partial macro)",
    Callback=function() P.stop = true end,
})
pL:AddSlider("Epoch",{
    Text="decision length (ticks)", Min=1, Max=8, Value=4, Step=1,
    Tooltip="how long every tap/release decision lasts, in physics ticks (4 ticks = one 60 fps frame). 1 is the most precise but 4x slower. with auto refine on it starts here and drops to finer steps by itself when it gets stuck",
    Callback=function(v) cfg.epoch = v end,
})
pL:AddSlider("Width",{
    Text="search width", Min=16, Max=600, Value=128, Step=8,
    Tooltip="how many different situations it keeps alive at every step. wider is safer in wide open levels and slower",
    Callback=function(v) cfg.width = v end,
})
pL:AddSlider("Budget",{
    Text="time limit (seconds)", Min=60, Max=1800, Value=600, Step=60,
    Tooltip="how long the search may run before it gives up",
    Callback=function(v) cfg.budget = v end,
})
pL:AddSlider("Slice",{
    Text="cpu per frame (ms)", Min=3, Max=30, Value=10, Step=1,
    Tooltip="how much of every frame the search may use. higher finishes sooner but makes the game stutter while it runs",
    Callback=function(v) cfg.slice = v end,
})
pL:AddToggle("Strict",{
    Text="avoid mode portals (baits)", Value=true,
    Tooltip="first tries to get through without ever changing game mode, so a cube portal in a wave level is treated as the trap it is. if no route exists that way it lets the mode change from the last portal it was stopped at",
    Callback=function(val) cfg.strict = val end,
})
pL:AddToggle("Refine",{
    Text="auto refine precision", Value=true,
    Tooltip="when the search gets stuck it restarts with shorter decisions (half as long, down to 1 tick) before giving up",
    Callback=function(val) cfg.refine = val end,
})
pL:AddToggle("Partial",{
    Text="save the furthest run if it fails", Value=true,
    Tooltip="saves how far it got as <level>_partial.json, which the macro tool can play so you can see where it got stuck",
    Callback=function(val) cfg.partial = val end,
})
