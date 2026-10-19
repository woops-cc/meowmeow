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
    warn("[bfnf:r] the library loader failed ("..tostring(res).."), loading the library file directly")
    for _, user in ipairs(LIBRARY_USERS) do
        local ok2, res2 = pcall(viaFile, user)
        if ok2 and res2 then return res2 end
        warn(("[bfnf:r] loading the library from %s failed: %s"):format(user, tostring(res2)))
    end
    warn("[bfnf:r] couldn't load the ui library")
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
                warn(("[bfnf:r] ui: %s:%s failed: %s"):format(label, tostring(key), tostring(res)))
                res = nil
            end
            if containers[key] then return guard(res, label.."/"..tostring(key)) end
            return res
        end
    end})
end

local VERSION = "v3.7-beta"  -- bump this every update or the footer lies to everyone

-- colors: galaxy collapse theme, crimson + ink black + white. very emo, i love it
local C_RED   = Color3.fromRGB(196, 30,  58)
local C_STEEL = Color3.fromRGB(208, 208, 214)
local C_BG    = Color3.fromRGB(10,  10,  12)
local C_WHITE = Color3.fromRGB(232, 232, 236)

local WINDOW_OPTIONS = {
    Title    = "<font color='#E8E8EC'><b>bfnf:r</b></font><font color='#C41E3A'> botplay</font>",
    Icon     = "125411711221424",
    Footer   = "<font color='#C41E3A'>woops &lt;3</font>  ·  basically fnf: remix  ·  "..VERSION,
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
        opts = {Title = "bfnf:r botplay", Keybind = Enum.KeyCode.RightShift}
    end
    local ok, res = pcall(function() return lib:Window("bfnfr_ap", opts) end)
    if ok and res then window = res; break end
    warn(("[bfnf:r] window attempt %d failed: %s"):format(attempt, tostring(res)))
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

local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VIM          = game:GetService("VirtualInputManager")
local UIS          = game:GetService("UserInputService")
local Players      = game:GetService("Players")
local v5           = Players.LocalPlayer

-- ════════════════════════════════════════════════════════════
-- timing & auto latency notes (read this when you forget how it works AGAIN)
-- ────────────────────────────────────────────────────────────
-- perfect window:  |scale| <= 0.71775 * spd
-- trigger formula: (0.71775 - latMs/1000 * 5.5) * spd
--
-- auto latency (proportional controller on the median):
--   NO integral term (when i tested it was causing overshooting and stuffs)
--   uses the MEDIAN of the last 8 readings so hold/miss outliers dont get a vote
--   hunting: samples on every fresh ms text, corrects by median * adaptive gain
--            (big errors get fixed fast, small ones gently, so it settles
--            instead of ringing around the target like a bell)
--            locks after 10 samples in a row with |median| <= 2ms
--   locked:  samples every 1s, corrects by median * 0.03 (basically frozen, its napping)
--            re-hunts only if |median| > 5ms for 8 samples in a row
--            outlier window gets tighter once locked (18ms vs 35ms while hunting)
--   stale guard: skips if the msIndic text hasnt changed in the last 0.35s
--   the lock carries over between songs. its a device/input thing, not a
--   per-song thing, so a new song only clears the sample buffer
-- ════════════════════════════════════════════════════════════
local vimLatencyMs    = 111
local autoLatency     = true
local autoLatencyConn = nil
local alSongWatcher   = nil
local alPhase         = "hunt"

local LOCK_GAIN     = 0.03
local LOCK_THRESH   = 2.0
local LOCK_N        = 10
local UNLOCK_THRESH = 5.0
local UNLOCK_N      = 8
local HUNT_INTERVAL = 0.15
local LOCK_INTERVAL = 1.0
local STALE_MAX     = 0.35
local BUF_SIZE      = 8

local alBuf          = {}
local alGoodN        = 0
local alBadN         = 0
local alSavedHitLate = false
local pressLog       = {}   -- the calibration reads this to undo the error the player MEANT to make, dont delete it

local function alReset(phase)
    alBuf={}; alGoodN=0; alBadN=0
    alPhase = phase or "hunt"
end

local function huntGain(med)
    return math.clamp(0.18 + math.abs(med)/120, 0.18, 0.45)
end

local function alMedian()
    if #alBuf == 0 then return 0 end
    local s = {}
    for _,v in ipairs(alBuf) do s[#s+1]=v end
    table.sort(s)
    local n = #s
    if n%2==1 then return s[math.ceil(n/2)]
    else return (s[n/2] + s[n/2+1]) / 2 end
end

local function startAutoLatency()
    if autoLatencyConn then
        autoLatencyConn:Disconnect(); autoLatencyConn = nil
    else
        -- first start: remember the real HitLate so stop can put it back. leaving someones setting flipped is rude
        alSavedHitLate = _G.Settings and _G.Settings.HitLate or false
    end
    alReset("hunt")
    if _G.Settings then _G.Settings.HitLate = true end

    if alSongWatcher then alSongWatcher:Disconnect() end
    task.spawn(function()
        local mg = v5.PlayerGui:WaitForChild("Main", 30)
        if not mg then return end
        alSongWatcher = mg.ChildAdded:Connect(function(c)
            if c.Name ~= "MatchFrame" then return end
            -- a locked calibration is a device thing, not a song thing, so no re-hunting every song (it
            -- wasted the first few seconds of every run, rip). just dump the buffer in case a reading
            -- straddled the song boundary and keep the lock
            alBuf = {}
            if alPhase == "hunt" then alGoodN=0; alBadN=0 end
        end)
    end)

    local lastSample   = 0
    local lastText     = ""
    local lastTextTime = 0

    autoLatencyConn = RunService.Heartbeat:Connect(function()
        if not autoLatency then return end
        local now = tick()
        local interval = (alPhase=="hunt") and HUNT_INTERVAL or LOCK_INTERVAL
        if now - lastSample < interval then return end

        local mf = v5.PlayerGui:FindFirstChild("Main")
               and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
        if not mf then return end
        local ind = mf:FindFirstChild("msIndic")
        if not (ind and ind.Visible) then return end

        local txt = ind.Text or ""
        if txt ~= lastText then
            lastText = txt
            lastTextTime = now
        else
            if now - lastTextTime > STALE_MAX then return end
        end

        if now - lastSample < interval then return end
        lastSample = now

        local val = tonumber(txt:match("(-?%d+%.?%d*)"))
        if not val then return end
        -- the reading includes the error the player MEANT to make, so subtract that and whats left is
        -- the real latency. needs one clear press to match it, otherwise skip (no guessing)
        local nLog = #pressLog
        local lastPress = pressLog[nLog]
        if not lastPress or now - lastPress.t > 0.14 then return end
        if nLog > 1 and lastPress.t - pressLog[nLog-1].t < 0.045 then return end
        val = val + lastPress.e
        -- outlier window: holds/misses make huge values, ignore those. tighter once locked, cuz anything
        -- wild by then is a hold/miss artifact and not a real correction
        local outlierMax = (alPhase=="locked") and 18 or 35
        if math.abs(val) > outlierMax then return end

        table.insert(alBuf, val)
        if #alBuf > BUF_SIZE then table.remove(alBuf, 1) end
        if #alBuf < 3 then return end

        local med = alMedian()

        if alPhase == "hunt" then
            vimLatencyMs = math.clamp(vimLatencyMs + med * huntGain(med), 0, 300)

            if math.abs(med) <= LOCK_THRESH then
                alGoodN = alGoodN+1; alBadN = 0
                if alGoodN >= LOCK_N then
                    alPhase = "locked"
                    alGoodN = 0; alBadN = 0; alBuf = {}
                end
            else
                alBadN = alBadN+1; alGoodN = 0
            end

        else
            vimLatencyMs = math.clamp(vimLatencyMs + med * LOCK_GAIN, 0, 300)

            if math.abs(med) > UNLOCK_THRESH then
                alBadN = alBadN+1; alGoodN = 0
                if alBadN >= UNLOCK_N then alReset("hunt") end
            else
                alBadN = 0; alGoodN = alGoodN+1
            end
        end
    end)
end

local function stopAutoLatency()
    local wasRunning = autoLatencyConn ~= nil
    if autoLatencyConn then autoLatencyConn:Disconnect(); autoLatencyConn=nil end
    if alSongWatcher   then alSongWatcher:Disconnect();   alSongWatcher=nil   end
    -- only put HitLate back if WE turned it on (dont touch what isnt yours)
    if wasRunning and _G.Settings then _G.Settings.HitLate = alSavedHitLate end
    alReset("hunt")
end

-- ════════════════════════════════════════════════════════════
-- keybinds & state (ill soon js make it automatically get the keys since im lowk lazy and tarded asf)
-- (update: it does now, FS.refreshKeys() grabs them from the game settings. past me can relax)
-- ════════════════════════════════════════════════════════════
local KEYS        = {Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.W, Enum.KeyCode.D}
local TAP_DUR     = 0.05

local v8            = false
local missJacks     = false
local perfected     = false
local tileLights    = false
local mainLoop      = nil

local laneHoldFrame = {nil,nil,nil,nil}
local lanePressed   = {false,false,false,false}
local pressSeq      = {0,0,0,0}   -- bumps every press so an old tap timer cant release a newer press (race conditions, my beloved)

local perfectChance = 100
local sickChance    = 0
local goodChance    = 0
local okChance      = 0
local badChance     = 0
local missChance    = 0

-- ════════ humanize settings (the advanced tab fills these in) ════════
local humanize         = true
local hAccuracy        = 92
local hConsistency     = 70
local hJackFatigue     = true
local hChordStagger    = true
local hWarmupFatigue   = true
local hPersonalBias    = true
local hAllowRealMiss   = true
local hMistakes        = 35     -- 0-100, how often it slips (aka the skill issue slider)
local hLeanMs          = 0      -- manual lean in ms (+ = late, remember that one)
local hEarlyHits       = true
local hDriftOn         = true
local hFocusOn         = true
local hFingerBias      = true
local hSelfCorrect     = true
local hStreaks         = true
local hRush            = true
local hColdStart       = true
local hSlips           = true
local hTiltOn          = true
local hHumanHolds      = true
local hHumanTaps       = true
local fingerSpeedLimit = 100    -- presses per second (replaced the old hard "legit" cap)

local kpsLog          = {}
local streakState     = 0
local personalBiasMs  = 0
local songStartTick   = 0

-- ════════ difficulty scanner settings ════════
local hAutoScan            = true
local hReactToSpikes       = true
local lastScanResult       = nil     -- shape of the result so i dont have to dig for it: {totalSeconds=, noteCount=, spikes={ {t=,strain=}, ... }}
local scanHookInstalled    = false
local chartIsInSpikeWindow -- declared up here, defined in the scanner part (lua makes me do this, dont ask)

local startLoop  -- same thing, defined in the main loop part

-- ════════════════════════════════════════════════════════════
-- tile lighting thingy for legitimacy and stuffs 😇😇
-- the tiles live at MatchFrame.MobileKeys.Left/Down/Up/Right
-- press = see-through 0, release = fades back to 0.8
-- ════════════════════════════════════════════════════════════
local TILE_NAMES = {"Left","Down","Up","Right"}
local TILE_TW    = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local tileTweens = {}

local function getMobileTile(lane)
    local ok,r = pcall(function()
        return v5.PlayerGui.Main.MatchFrame.MobileKeys[TILE_NAMES[lane]]
    end)
    return ok and r or nil
end

local function lightTile(lane, lit)
    if not tileLights then return end
    if lit and perfected then return end
    local t = getMobileTile(lane)
    if not t then return end
    if tileTweens[lane] then tileTweens[lane]:Cancel(); tileTweens[lane]=nil end
    if lit then
        t.ImageTransparency = 0
    else
        local tw = TweenService:Create(t, TILE_TW, {ImageTransparency=0.8})
        tileTweens[lane]=tw; tw:Play()
    end
end

-- ════════════════════════════════════════════════════════════
-- press method (the "how do i actually push a key" department)
-- ────────────────────────────────────────────────────────────
-- vim:  VirtualInputManager fakes a real key event. the engine queues it, so the game
--       only sees it about a frame late. the OG way, works every time
-- fire: hands a fake key event straight to the game's key handler, right now. the game
--       only reads KeyCode and UserInputType off it, so a plain table does the job.
--       no queue = less lag, and a lag spike after the press cant push it late
-- executors disagree on what actually reaches the game (on delta plain firesignal
-- reached MY listeners but not the game's, rude), so fire has three routes:
--   all      calls every lua listener on InputBegan / InputEnded by hand
--   signal   firesignal(UserInputService.InputBegan, fake, false)
--   handler  calls the game's own KeyPress / KeyLift functions
-- picking firesignal in the dropdown tests which routes reach the game, starts with the
-- best one and checks that real notes get hit. a route that hits nothing gets skipped
-- and if none work it goes back to VirtualInputManager on its own.
-- it all lives in the one FS table cuz lua only allows 200 locals in a file and this
-- script is already hugging that limit like a koala
-- ════════════════════════════════════════════════════════════
local FS = {
    on = false,
    broken = false,       -- it gave up. vim takes over until firesignal gets picked again
    breakWhy = nil,       -- the reason it gave up, handled at the start of the next frame (a safe spot)
    skipWhy = nil,
    failN = 0,
    verified = false,
    reported = false,
    missN = 0,
    watch = {},           -- {note=, t=} presses waiting for their verdict
    lastPress = -math.huge,
    req = 0,              -- bumps whenever the dropdown changes, so a slow setup cant overwrite a newer pick
    objs = {},            -- the fake key events, objs[lane] = {down, up}
    via = {},             -- how each lane's key went down, so it comes back up the same way (dont mix them up)
    routes = {}, routeI = 0, route = nil,
    handlers = {},
    listeners = {down = {}, up = {}, at = 0},
    picker = nil,
    apply = nil,          -- defined down in the main loop part (forward declare, yes again)
    defaultKeys = {Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.W, Enum.KeyCode.D},
}

function FS.fake(key, state)
    return {
        KeyCode        = key,
        UserInputType  = Enum.UserInputType.Keyboard,
        UserInputState = state,
        Position       = Vector3.new(0, 0, 0),
        Delta          = Vector3.new(0, 0, 0),
    }
end

-- keys come from the game's own settings (primary bind first, then the alt bind) so custom
-- binds work. a s w d is the backup plan for when the settings are being weird
function FS.refreshKeys()
    local inputs = _G.Settings and _G.Settings.Inputs
    for lane = 1, 4 do
        local key = FS.defaultKeys[lane]
        if type(inputs) == "table" then
            for _, slot in ipairs({lane, lane + 4}) do
                local ok, kc = pcall(function() return Enum.KeyCode[inputs[slot]] end)
                if ok and kc and kc ~= Enum.KeyCode.Unknown then key = kc; break end
            end
        end
        KEYS[lane] = key
        FS.objs[lane] = {FS.fake(key, Enum.UserInputState.Begin), FS.fake(key, Enum.UserInputState.End)}
    end
end
FS.refreshKeys()

-- puts the dropdown back on VirtualInputManager. tries the name AND the index cuz idk
-- which one the lib wants
function FS.resetPicker()
    if not FS.picker then return end
    pcall(function() FS.picker:SetValue("VirtualInputManager") end)
    pcall(function() FS.picker:SetValue(1) end)
end

function FS.giveUp(why)
    if FS.broken then return end
    FS.broken = true
    FS.breakWhy = why
end

function FS.info(f, what)
    local ok, v = pcall(function() return debug.info(f, what) end)
    if ok then return v end
end

-- grabs every lua listener on InputBegan / InputEnded (needs getconnections)
function FS.scan()
    local out = {down = {}, up = {}, at = tick()}
    if type(getconnections) ~= "function" then return out end
    for _, pair in ipairs({{UIS.InputBegan, out.down}, {UIS.InputEnded, out.up}}) do
        local ok, conns = pcall(getconnections, pair[1])
        if ok and type(conns) == "table" then
            for _, c in ipairs(conns) do
                local okf, f = pcall(function() return c.Function end)
                local on = true
                pcall(function() if c.Enabled == false then on = false end end)
                if okf and type(f) == "function" and on then pair[2][#pair[2] + 1] = f end
            end
        end
    end
    return out
end

-- finds the game's KeyPress / KeyLift by name from the listeners (the game ships its function
-- names, thanks), or from the songPlay module's globals as plan b
function FS.findHandlers(L)
    local found = {how = "listeners"}
    local function pick(list, name)
        for _, f in ipairs(list) do
            if FS.info(f, "n") == name then
                local src = FS.info(f, "s")
                if type(src) ~= "string" or src:find("songPlay", 1, true) then return f end
            end
        end
    end
    found.down, found.up = pick(L.down, "KeyPress"), pick(L.up, "KeyLift")
    if not (found.down and found.up) and type(getsenv) == "function" then
        pcall(function()
            for _, ch in ipairs(v5.PlayerGui.Main:GetChildren()) do
                local sp = ch:IsA("LocalScript") and ch:FindFirstChild("songPlay")
                if sp then
                    local env = getsenv(sp)
                    if type(env) == "table" and type(env.KeyPress) == "function" and type(env.KeyLift) == "function" then
                        found.down, found.up, found.how = env.KeyPress, env.KeyLift, "getsenv"
                    end
                    break
                end
            end
        end)
    end
    return found
end

function FS.call(route, down, obj)
    if route == "handler" then
        local f = down and FS.handlers.down or FS.handlers.up
        if not f then return false, "no handler" end
        return pcall(f, obj, false)
    elseif route == "all" then
        if tick() - FS.listeners.at > 30 then
            local s = FS.scan()
            if #s.down > 0 then FS.listeners = s else FS.listeners.at = tick() end
        end
        local list = down and FS.listeners.down or FS.listeners.up
        if #list == 0 then return false, "no listeners" end
        local any, lastErr = false, nil
        for _, f in ipairs(list) do
            local ok, err = pcall(f, obj, false)
            if ok then any = true else lastErr = err end
        end
        if any then return true end
        return false, lastErr
    end
    return pcall(firesignal, down and UIS.InputBegan or UIS.InputEnded, obj, false)
end

-- does plain firesignal even reach a listener? some executors have one that does absolutely
-- nothing. fires a harmless fake key at OUR listener to find out
function FS.signalTest()
    if type(firesignal) ~= "function" then return false, "no firesignal in this executor" end
    local probe = FS.fake(Enum.KeyCode.Unknown, Enum.UserInputState.Begin)
    probe.UserInputType = Enum.UserInputType.None
    local got = false
    local conn = UIS.InputBegan:Connect(function(inp) if inp == probe then got = true end end)
    local ok, err = pcall(firesignal, UIS.InputBegan, probe, false)
    task.wait(0.1)   -- some executors run the listeners a moment later, so wait
    conn:Disconnect()
    if not ok then return false, "firesignal errored: "..tostring(err) end
    if not got then return false, "firesignal didn't reach our own listener" end
    return true
end

-- does a route reach the GAME's listeners? sneaky trick: the game flips _G.Index.Device to
-- "Computer" when a keyboard event hits its InputBegan listener. so park it on something else,
-- send a harmless fake key, see if it flipped, put it back. true / false, or nil when theres
-- no way to tell
function FS.reaches(route)
    local idx = _G.Index
    if type(idx) ~= "table" then return nil end
    local prev = idx.Device
    idx.Device = "bfnfr-probe"
    local ok = FS.call(route, true, FS.fake(Enum.KeyCode.Unknown, Enum.UserInputState.Begin))
    task.wait(0.1)
    local reached = idx.Device ~= "bfnfr-probe"
    idx.Device = prev
    if not ok then return false end
    return reached
end

-- figures out which routes are worth trying (best first) and prints what it found to the console.
-- that console output is what to send over when something is acting weird
function FS.setup()
    local L = FS.scan()
    FS.listeners = L
    FS.handlers = FS.findHandlers(L)
    local verified, maybe, say = {}, {}, {}
    say[#say + 1] = ("listeners seen: %d on InputBegan, %d on InputEnded"):format(#L.down, #L.up)
    local function judge(name, r)
        say[#say + 1] = name..": "..(r == true and "reaches the game" or (r == false and "does NOT reach the game" or "can't tell (no probe)"))
        if r == true then verified[#verified + 1] = name elseif r == nil then maybe[#maybe + 1] = name end
    end
    if #L.down > 0 and #L.up > 0 then
        judge("all", FS.reaches("all"))
    else
        say[#say + 1] = "all: getconnections gave no listeners"
    end
    local sOk, sWhy = FS.signalTest()
    if sOk then judge("signal", FS.reaches("signal")) else say[#say + 1] = "signal: "..tostring(sWhy) end
    if FS.handlers.down and FS.handlers.up then
        say[#say + 1] = "handler: found KeyPress and KeyLift (via "..FS.handlers.how..")"
        table.insert(maybe, 1, "handler")
    else
        say[#say + 1] = "handler: couldn't find the game's KeyPress / KeyLift"
    end
    local routes = {}
    for _, r in ipairs(verified) do routes[#routes + 1] = r end
    for _, r in ipairs(maybe) do routes[#routes + 1] = r end
    say[#say + 1] = "routes to try: "..(#routes > 0 and table.concat(routes, ", ") or "none")
    for _, line in ipairs(say) do warn("[bfnf:r] firesignal: "..line) end
    return routes
end

-- diagnostics: a report on this executor + how the game handles keys (whats connected to the key
-- signals, what KeyPress keeps inside, what happens with a fake press). goes to the console and
-- the clipboard so i can paste it to whoever is helping me
function FS.report()
    local out = {}
    local function add(s) out[#out + 1] = s end
    local function show(v)
        local t = type(v)
        if t == "nil" or t == "boolean" or t == "number" then return tostring(v) end
        if t == "string" then return '"'..v:sub(1, 40)..'"' end
        if t == "function" then return "function "..tostring(FS.info(v, "n") or "?") end
        if t == "table" then
            local n, parts = 0, {}
            for k, x in pairs(v) do
                n = n + 1
                if #parts < 8 and type(x) ~= "table" and type(x) ~= "function" then parts[#parts + 1] = tostring(k).."="..tostring(x) end
            end
            return "table("..n..") {"..table.concat(parts, ", ").."}"
        end
        return tostring(v):sub(1, 40)
    end
    local function ups(f)
        local ok, res = pcall(function() return (debug.getupvalues or getupvalues)(f) end)
        if ok and type(res) == "table" then return res end
    end
    local function yn(f) return type(f) == "function" and "yes" or "no" end

    add("== executor ==")
    local okE, en, ev = pcall(function() return identifyexecutor() end)
    add(okE and ("executor: "..tostring(en).." "..tostring(ev)) or "executor: unknown (no identifyexecutor)")
    add("has: firesignal="..yn(firesignal).." getconnections="..yn(getconnections).." getsenv="..yn(getsenv)
        .." getgc="..yn(getgc).." hookfunction="..yn(hookfunction).." setclipboard="..yn(setclipboard)
        .." debug.info="..yn(debug.info).." debug.getupvalues="..yn(debug.getupvalues).." getupvalues="..yn(getupvalues))

    add("== game state ==")
    add("Device: "..tostring(_G.Index and _G.Index.Device))
    add("Settings.Inputs: "..show(_G.Settings and _G.Settings.Inputs))
    add("touch/keyboard/gamepad enabled: "..tostring(UIS.TouchEnabled).."/"..tostring(UIS.KeyboardEnabled).."/"..tostring(UIS.GamepadEnabled))
    local okM, vis = pcall(function() return v5.PlayerGui.Main.MatchFrame.Visible end)
    add("MatchFrame visible (a song is on screen): "..(okM and tostring(vis) or "unknown"))

    local kp, kl
    for _, pair in ipairs({{"InputBegan", UIS.InputBegan}, {"InputEnded", UIS.InputEnded}}) do
        add("== listeners on "..pair[1].." ==")
        if type(getconnections) ~= "function" then
            add("no getconnections")
        else
            local ok, conns = pcall(getconnections, pair[2])
            if not ok or type(conns) ~= "table" then
                add("getconnections failed: "..tostring(conns))
            else
                add("count: "..#conns)
                for i, c in ipairs(conns) do
                    if i > 30 then add("... (more)"); break end
                    local f, on, foreign, lua
                    pcall(function() f = c.Function end)
                    pcall(function() on = c.Enabled end)
                    pcall(function() foreign = c.ForeignState end)
                    pcall(function() lua = c.LuaConnection end)
                    if type(f) == "function" then
                        local nm, src, ln = FS.info(f, "n"), FS.info(f, "s"), FS.info(f, "l")
                        add(("%d: %s | %s | line %s | on=%s foreign=%s"):format(i, tostring(nm or "(no name)"), tostring(src or "?"), tostring(ln or "?"), tostring(on), tostring(foreign)))
                        if nm == "KeyPress" then kp = kp or f end
                        if nm == "KeyLift" then kl = kl or f end
                    else
                        add(("%d: no lua function (Function is %s) on=%s foreign=%s lua=%s"):format(i, type(f), tostring(on), tostring(foreign), tostring(lua)))
                    end
                end
            end
        end
    end

    add("== songPlay module ==")
    local env
    pcall(function()
        for _, ch in ipairs(v5.PlayerGui.Main:GetChildren()) do
            local sp = ch:IsA("LocalScript") and ch:FindFirstChild("songPlay")
            if sp then
                add("found: "..sp:GetFullName())
                if type(getsenv) ~= "function" then
                    add("no getsenv")
                else
                    local ok, e = pcall(getsenv, sp)
                    if ok and type(e) == "table" then env = e else add("getsenv failed: "..tostring(e)) end
                end
                break
            end
        end
    end)
    if env then
        local names = {}
        for k, v in pairs(env) do if type(v) == "function" and #names < 40 then names[#names + 1] = tostring(k) end end
        table.sort(names)
        add("functions in its env: "..table.concat(names, ", "))
        if type(env.KeyPress) == "function" then kp = kp or env.KeyPress end
        if type(env.KeyLift) == "function" then kl = kl or env.KeyLift end
    end

    add("== the game's KeyPress ==")
    if not kp then
        add("not found, so no deep check")
    else
        local list = ups(kp)
        if not list then
            add("no upvalue access (no debug.getupvalues / getupvalues)")
        else
            local laneFn
            for i, v in pairs(list) do
                add("KeyPress upvalue "..tostring(i)..": "..show(v))
                if type(v) == "function" and FS.info(v, "n") == "InputLane" then laneFn = v end
            end
            if laneFn then
                local l2 = ups(laneFn)
                if l2 then for i, v in pairs(l2) do add("InputLane upvalue "..tostring(i)..": "..show(v)) end end
                local okL, res = pcall(laneFn, FS.objs[1][1])
                add("InputLane(fake key of lane 1) -> "..(okL and tostring(res) or ("ERROR: "..tostring(res))))
            else
                add("InputLane not found among its upvalues")
            end
            -- hands KeyPress a fake press then a fake release and watches which tables it keeps change (skipped if the bot is holding that key)
            if lanePressed[1] then
                add("live test skipped: the bot is holding lane 1 right now")
            else
                local function snap()
                    local s = {}
                    for i, v in pairs(list) do
                        if type(v) == "table" then
                            local n = 0
                            for _, x in pairs(v) do if x then n = n + 1 end end
                            s[i] = n
                        end
                    end
                    return s
                end
                local before = snap()
                local okP, errP = pcall(kp, FS.objs[1][1], false)
                local after = snap()
                local okR, errR = true, nil
                if kl then okR, errR = pcall(kl, FS.objs[1][2], false) end
                add("KeyPress(fake lane 1 key) -> "..(okP and "ok" or ("ERROR: "..tostring(errP))))
                add("KeyLift(fake lane 1 key) -> "..(okR and "ok" or ("ERROR: "..tostring(errR))))
                local changed = false
                for i, n in pairs(after) do
                    if n ~= before[i] then
                        changed = true
                        add(("table upvalue %s: %s truthy entries -> %s"):format(tostring(i), tostring(before[i]), tostring(n)))
                    end
                end
                if not changed then add("nothing it keeps changed, so it ignored the fake press (no song running, or it was rejected)") end
            end
        end
    end

    add("== bound actions (ContextActionService) ==")
    pcall(function()
        local names = {}
        for k in pairs(game:GetService("ContextActionService"):GetAllBoundActionInfo()) do names[#names + 1] = tostring(k) end
        table.sort(names)
        add(#names > 0 and table.concat(names, ", ") or "none")
    end)

    add("== routes ==")
    FS.listeners = FS.scan()
    FS.handlers = FS.findHandlers(FS.listeners)
    local sOk, sWhy = FS.signalTest()
    add("firesignal reaches our own listener: "..tostring(sOk)..(sOk and "" or (" ("..tostring(sWhy)..")")))
    local function r2s(r) return r == true and "yes" or (r == false and "NO" or "can't tell") end
    add("'all' route reaches the game's device listener: "..r2s(FS.reaches("all")))
    add("'signal' route reaches the game's device listener: "..r2s(FS.reaches("signal")))
    add("handler found: "..tostring(FS.handlers.down ~= nil and FS.handlers.up ~= nil).." (via "..tostring(FS.handlers.how)..")")
    add(("state: on=%s broken=%s route=%s verified=%s routes=%s"):format(tostring(FS.on), tostring(FS.broken), tostring(FS.route), tostring(FS.verified), table.concat(FS.routes, ",")))

    local text = table.concat(out, "\n")
    for _, line in ipairs(out) do warn("[bfnf:diag] "..line) end
    local copied = false
    if type(setclipboard) == "function" then copied = pcall(setclipboard, text) end
    return text, copied
end

function FS.key(down, lane)
    local pair = FS.objs[lane]
    if not pair or not FS.route then return false end
    local ok, err = FS.call(FS.route, down, pair[down and 1 or 2])
    if ok then FS.failN = 0; return true end
    FS.failN = FS.failN + 1
    if FS.failN >= 3 and not FS.skipWhy then
        FS.skipWhy = ("route '%s' keeps erroring: %s"):format(FS.route, tostring(err))
    end
    return false
end

-- sends one key event and says how it went out ("fire" or "vim") so the release
-- goes out the same way
function FS.send(down, lane, via)
    if via == nil then via = (FS.on and not FS.broken) and "fire" or "vim" end
    if via == "fire" and FS.key(down, lane) then return "fire" end
    VIM:SendKeyEvent(down, KEYS[lane], false, game)
    return "vim"
end

-- ════════════════════════════════════════════════════════════
-- vim helpers (the names are from when vim was the only way, they press with
-- whatever method is on now. renaming everything = pain, so no)
-- ════════════════════════════════════════════════════════════
local function vimDown(lane)
    if not lanePressed[lane] then
        lanePressed[lane]=true
        FS.via[lane] = FS.send(true, lane)
        lightTile(lane, true)
    end
end

local function vimUp(lane)
    if lanePressed[lane] then
        lanePressed[lane]=false
        FS.send(false, lane, FS.via[lane])
        FS.via[lane] = nil
        lightTile(lane, false)
    end
end

-- a real tap isnt exactly 50ms every time, small legitimacy touch.
-- perfect mode skips it, that one is SUPPOSED to look like a bot
local function tapDurSec()
    if not humanize or perfected or not hHumanTaps then return TAP_DUR end
    return math.clamp(TAP_DUR + (math.random()-0.5)*0.03, 0.03, 0.09)
end

local function vimTap(lane, dur)
    vimUp(lane); vimDown(lane)
    pressSeq[lane] = pressSeq[lane] + 1
    local mine = pressSeq[lane]
    task.delay(dur or tapDurSec(), function()
        -- only the newest press on a lane gets to let go, so an old tap cant cut a hold or a newer tap short
        if pressSeq[lane] == mine then vimUp(lane) end
    end)
end

-- ════════════════════════════════════════════════════════════
-- hold system
-- hold duration straight from the game's source (math, ew):
--   v98 = max(0, p88-0.07), clamped 0 if <=0.03
--   Size.Y.Scale = v98 * 5.5 * spd  (negative in upscroll)
--   so p88 = |scale|/(5.5*spd) + 0.07
-- lowk pressed vimLatencyMs early, so hold for p88 - latency_sec
-- ════════════════════════════════════════════════════════════
local function resetLnHold(lane)
    pcall(function()
        local mf = v5.PlayerGui.Main.MatchFrame
        for s=1,2 do
            local ar = mf:FindFirstChild("KeySync"..s)
                   and mf["KeySync"..s]:FindFirstChild("Arrow"..lane)
            if ar then
                local ln = ar:FindFirstChild("LnHold")
                if ln then ln.ImageTransparency=1 end
            end
        end
    end)
end

local function stopHold(lane, interrupted)
    laneHoldFrame[lane]=nil
    vimUp(lane)
    if interrupted then resetLnHold(lane) end
end

-- ── firesignal checks (they need stopHold and vimUp, so they live down here) ──

-- moves to the next route. lets go of everything first so nothing stays stuck (stuck keys = very sad bot)
function FS.advance(why)
    for i=1,4 do
        if laneHoldFrame[i] then stopHold(i, false) end
        vimUp(i)
    end
    FS.routeI = FS.routeI + 1
    FS.route = FS.routes[FS.routeI]
    FS.failN, FS.missN, FS.watch = 0, 0, {}
    if FS.route then
        warn(("[bfnf:r] firesignal: %s, trying route '%s'"):format(why, FS.route))
    else
        FS.giveUp(why)
    end
end

function FS.handleBreak()
    local why = FS.breakWhy
    FS.breakWhy = nil
    warn("[bfnf:r] firesignal presses off: "..tostring(why))
    FS.apply(false)
    FS.resetPicker()
    window:Notification({Title="firesignal", Text="didn't work here ("..tostring(why).."), back to VirtualInputManager", Duration=5})
end

-- a hit note gets destroyed on the spot, so a press that really landed makes the note vanish.
-- until a route proves itself the presses get watched for a moment. checks again after a long
-- gap (= new song). basically a lie detector for the presses
function FS.watchAdd(note, now, lane)
    if not FS.on or FS.broken then return end
    if now - FS.lastPress > 10 then
        -- long gap = new song: check the route again and refresh the listeners in case the game reconnected its own
        FS.verified = false; FS.missN = 0
        local L = FS.scan()
        if #L.down > 0 then
            FS.listeners = L
            local h = FS.findHandlers(L)
            if h.down and h.up then FS.handlers = h end
        end
    end
    FS.lastPress = now
    -- a press that fell back to vim (the route errored) says nothing about the route
    if FS.via[lane] ~= "fire" then return end
    if FS.verified or #FS.watch >= 12 then return end
    FS.watch[#FS.watch + 1] = {note = note, t = now}
end

function FS.watchStep(now)
    if FS.breakWhy then FS.handleBreak(); return end
    if FS.skipWhy then
        local why = FS.skipWhy; FS.skipWhy = nil
        FS.advance(why)
        if FS.breakWhy then FS.handleBreak() end
        return
    end
    local i = 1
    while i <= #FS.watch do
        local w = FS.watch[i]
        if w.note.Parent == nil then
            FS.verified = true; FS.missN = 0; FS.watch = {}
            if not FS.reported then
                FS.reported = true
                warn(("[bfnf:r] firesignal: route '%s' is hitting notes"):format(tostring(FS.route)))
            end
            return
        elseif now - w.t >= 0.09 then
            table.remove(FS.watch, i)
            FS.missN = FS.missN + 1
        else
            i = i + 1
        end
    end
    if FS.missN >= 2 then
        FS.advance(("route '%s' didn't hit any notes"):format(tostring(FS.route)))
        if FS.breakWhy then FS.handleBreak() end
    end
end

-- ════════════════════════════════════════════════════════════
-- helpers (stuff that didnt fit anywhere else)
-- ════════════════════════════════════════════════════════════
-- real judgment windows, straight out of the game's own Combo() function (ms, absolute offset).
-- the old HIT_OFF guesses were close but "bad" (175ms) was past 130.5ms, which the game doesnt
-- count as a hit at all. oops
local JUDGE = {
    perfect = 16.5,
    sick    = 43.5,
    good    = 76.5,
    ok      = 106.5,
    bad     = 130.5,  -- later than this and its not a hit
}

-- random point INSIDE the rating's real band, not just its edge (a real sick isnt always
-- exactly 43.5ms off, its anywhere in that range)
local function randomOffsetForRating(rating)
    if rating=="perfect" then return math.random()*JUDGE.perfect end
    if rating=="sick"    then return JUDGE.perfect + math.random()*(JUDGE.sick-JUDGE.perfect) end
    if rating=="good"    then return JUDGE.sick    + math.random()*(JUDGE.good-JUDGE.sick)    end
    if rating=="ok"      then return JUDGE.good    + math.random()*(JUDGE.ok-JUDGE.good)      end
    if rating=="bad"     then return JUDGE.ok      + math.random()*(JUDGE.bad-JUDGE.ok)       end
    return 0
end

local function pickRating()
    local pool={}
    for _=1,perfectChance do pool[#pool+1]="perfect" end
    for _=1,sickChance    do pool[#pool+1]="sick"    end
    for _=1,goodChance    do pool[#pool+1]="good"    end
    for _=1,okChance      do pool[#pool+1]="ok"      end
    for _=1,badChance     do pool[#pool+1]="bad"     end
    for _=1,missChance    do pool[#pool+1]="miss"    end
    if #pool==0 then return "perfect" end
    return pool[math.random(1,#pool)]
end

-- ════════════════════════════════════════════════════════════
-- humanize engine
-- the player decides an error for every note BEFORE it lands (ms, + = late, - = early) and the
-- hands (further down) press at exactly that moment. the error is built from a few layers and
-- every layer is its own switch on the advanced tab. whatever band the error lands in IS the rating
-- ════════════════════════════════════════════════════════════
local function gaussianRandom()
    -- box-muller, gives a standard normal sample (mean 0, sd 1). math wizardry, dont touch
    local u1 = math.max(1e-9, math.random())
    local u2 = math.random()
    return math.sqrt(-2*math.log(u1)) * math.cos(2*math.pi*u2)
end

-- consistency slider = how much a hot/cold streak leaks into the next note
local function streakCarry()
    return 0.85 - 0.70 * (hConsistency/100)
end

local function updateStreak()
    local carry = streakCarry()
    streakState = streakState*carry + gaussianRandom()*(1-carry)
    streakState = math.clamp(streakState, -2, 2)
end

-- logs this press and says how far OVER the finger speed limit the recent press rate is (0 = chill)
local function trackAndGetOverflow()
    local now=tick(); local i=1
    while i<=#kpsLog do
        if now-kpsLog[i]>1 then table.remove(kpsLog,i) else i=i+1 end
    end
    kpsLog[#kpsLog+1]=now
    if fingerSpeedLimit<=0 then return 0 end
    return math.max(0, (#kpsLog - fingerSpeedLimit)/fingerSpeedLimit)
end

-- ── the player's state (a tiny fake brain) ──
local hDrift, hFocus, hTilt   = 0, 0, 0           -- slow timing wander, attention, "just slipped"
local hLaneBias               = {0,0,0,0}
local hChordDir               = 1
local hLastNoise, hLastNoiseT = 0, 0
local hLastT                  = nil
local H_PLAN                  = 0.45              -- decide each note this many secs before it lands
local hPlan                   = setmetatable({}, {__mode="k"})  -- note -> {e=ms, density=}
local hHold                   = {}                -- release plan for the hold each lane is on
local hLaneHit                = {-math.huge,-math.huge,-math.huge,-math.huge}
local hAnyHit                 = -math.huge
local hHitHist                = {}

-- fresh start for the player: runs on enable and every song start, so every attempt gets its
-- own lean, habits and warm-up (new run, new brain)
local function hResetRun()
    songStartTick  = tick()
    streakState    = 0
    table.clear(kpsLog)
    table.clear(pressLog)
    personalBiasMs = gaussianRandom() * 2.5
    for i=1,4 do hLaneBias[i] = gaussianRandom() * 2.2 end
    hChordDir = (math.random() < 0.5) and 1 or -1
    hDrift, hFocus, hTilt = 0, 0, 0
    hLastNoise, hLastNoiseT, hLastT = 0, 0, nil
    hHold = {}
    for i=1,4 do hLaneHit[i] = -math.huge end
    hAnyHit = -math.huge
    table.clear(hHitHist)
end

-- lets go of the hold on this lane when its plan says so. the plan is all timing (when the hold
-- body ends) so it doesnt care how the hold frame moves around once the game grabs it
local function hHoldTick(lane, now)
    local hf = laneHoldFrame[lane]
    if not hf then return end
    local hp = hHold[lane] or {t0=now, endAt=now}
    local held = now - hp.t0
    local release = held > 15 or not hf.Parent or now >= (hp.dropAt or hp.endAt)
    if release and held > 0.03 then stopHold(lane, false) end
end

local function hAdvance(now)
    local dt = hLastT and math.min(now - hLastT, 3) or 0
    hLastT = now
    if dt <= 0 then return end
    if hDriftOn then
        -- the timing average wanders a few ms and drifts back, wanders faster when consistency is low
        local k = math.exp(-dt/8)
        hDrift = hDrift*k + (1 + 6*(1 - hConsistency/100)) * math.sqrt(1-k*k) * gaussianRandom()
    end
    if hFocusOn then
        local k = math.exp(-dt/25)
        hFocus = math.clamp(hFocus*k + math.sqrt(1-k*k) * gaussianRandom() * 0.7, -1.5, 1.5)
    end
    hTilt = hTilt * math.exp(-dt/1.6)
end

-- the decision for ONE note. gives back the error in ms, or nil if the note gets dropped. c = {lane, now, gapPrev, restGap, density, chordSize}
local function hDecide(c)
    local now = c.now
    hAdvance(now)

    if not humanize then
        local rating = pickRating()
        if rating == "miss" then return nil, 8 end
        local off = math.min(randomOffsetForRating(rating), 125)
        return ((math.random() < 0.5) and -off or off), 8
    end

    local acc     = hAccuracy
    local t       = (100 - acc) / 100
    local sigma   = 4 + 51 * t^1.1       -- how scattered, ms
    local mean    = 1 + 40 * t^1.4       -- sloppier players land later on average, ms
    local comfort = 5 + 0.14 * acc       -- notes a second this player handles fine
    local dmul    = 1

    if hJackFatigue then
        dmul = 1 + 1.2 * math.max(0, c.density/comfort - 0.6)^1.3
        if c.gapPrev < 0.22 then
            local f = (0.22 - c.gapPrev) / 0.22
            mean  = mean + f*14
            sigma = sigma * (1 + f*0.8)
        end
        if c.chordSize >= 2 then sigma = sigma * (1 + 0.06 * (c.chordSize - 1)) end
    end
    if hRush then
        mean = mean - math.min(6, 0.35 * math.max(0, c.density - 0.5*comfort))
    end
    sigma = sigma * dmul

    if hWarmupFatigue then
        local elapsed = now - songStartTick
        if elapsed < 2.5 then
            sigma = sigma * (1 + 0.6*(1 - elapsed/2.5))
        elseif elapsed > 90 then
            sigma = sigma * (1 + math.min(0.25, (elapsed-90)/300))
        end
    end
    if hFocusOn then sigma = sigma * (1 - 0.12*hFocus) end
    if hColdStart and c.restGap > 1.5 then
        sigma = sigma * 1.3
        mean  = mean + 4
    end
    local spike = hReactToSpikes and chartIsInSpikeWindow and chartIsInSpikeWindow()
    if spike then sigma = sigma * 1.25 end

    local overflow = c.overflow or 0
    if overflow > 0 then
        mean  = mean + overflow*45
        sigma = sigma * (1 + overflow*2.5)
    end
    if hStreaks then
        updateStreak()
        sigma = sigma * (1 + streakState*0.5)
    end
    if hTiltOn then sigma = sigma * (1 + 0.6*hTilt) end
    sigma = math.max(1.5, sigma)

    local bias = hLeanMs
    if hPersonalBias then bias = bias + personalBiasMs end
    if hFingerBias   then bias = bias + hLaneBias[c.lane] end
    if hDriftOn      then bias = bias + hDrift end

    local noise = gaussianRandom() * sigma
    local corr = 0
    if hSelfCorrect and now - hLastNoiseT < 0.6 then corr = -0.25 * hLastNoise end
    hLastNoise, hLastNoiseT = noise, now
    local e = noise + mean + bias + corr

    -- slips: the odd bigger error, or a note that just doesnt get hit
    local slipped, missed = false, false
    if hSlips then
        local p = (hMistakes/100) * 0.012 * (1 + (100-acc)/40) * dmul
        if hTiltOn  then p = p * (1 + 1.5*hTilt) end
        if hFocusOn then p = p * (1 - 0.3*hFocus) end
        if spike    then p = p * 1.5 end
        if math.random() < math.min(p, 0.3) then
            slipped = true
            if hAllowRealMiss and math.random() < 0.35 then
                missed = true
            else
                local mag = 18 + math.abs(gaussianRandom()) * (1.5*sigma + 10)
                e = e + ((math.random() < 0.65) and mag or -mag)
            end
        end
    end
    if not missed and hAllowRealMiss and overflow > 0.5
       and math.random() < math.min(0.35, overflow*0.15) then
        missed = true
    end

    if hTiltOn and (missed or slipped or math.abs(e) > 40) then
        hTilt = math.min(2, hTilt + (missed and 0.8 or 0.5))
    end
    if missed then return nil, sigma end

    if not hEarlyHits then e = math.abs(e) end
    return math.clamp(e, -110, 125), sigma
end

local function getMyKeySync()
    local M = v5.PlayerGui:FindFirstChild("Main")
        and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
    if not (M and M.Visible) then return nil end
    local pv = v5:FindFirstChild("File") and v5.File:FindFirstChild("CurrentPlayer")
    if pv and pv.Value then
        return M:FindFirstChild("KeySync"..(pv.Value.Name=="Player2" and 2 or 1))
    end
end

-- which side's notes to read. the game hands the side to PlaySong and reads GetNotes<side> with it,
-- so use that when we have it and only guess from CurrentPlayer as a fallback
local function resolveSide(hookSide)
    if hookSide == 1 or hookSide == 2 then return hookSide end
    local side = 1
    pcall(function()
        local pv = v5:FindFirstChild("File") and v5.File:FindFirstChild("CurrentPlayer")
        if pv and pv.Value and pv.Value.Name=="Player2" then side = 2 end
    end)
    return side
end

-- ════════════════════════════════════════════════════════════
-- difficulty scanner
-- reads the chart from the game's own song module (the same GetNotes1() / GetNotes2() the game
-- calls) the moment a song starts, so it can point out the hardest parts before note one. it hooks
-- the game's PlaySong to grab that module. if the hook cant be set up it just does nothing, it
-- never touches the actual hitting
-- ════════════════════════════════════════════════════════════
local function fmtTime(s)
    s = math.max(0, math.floor(s or 0))
    return string.format("%d:%02d", math.floor(s/60), s%60)
end

local function buildScanMessage(result)
    local head = "<font color='#C41E3A'>"..result.noteCount.." notes</font> · "
    if #result.spikes == 0 then
        return head.."pretty even the whole way through, no major spikes"
    end
    local parts = {}
    for _, sp in ipairs(result.spikes) do parts[#parts+1] = fmtTime(sp.t) end
    return head.."hardest part"..(#result.spikes>1 and "s" or "")..": "..table.concat(parts, ", ")
end

local function analyzeChart(songModule, hookSide)
    local mySide = resolveSide(hookSide)

    local ok, rawNotes = pcall(function() return songModule["GetNotes"..mySide]() end)
    if not ok or type(rawNotes) ~= "table" then return end

    -- keep only real notes (lane is a number), skip SpeedBoost/Cam/etc events, those arent notes
    local notes = {}
    for _, n in pairs(rawNotes) do
        if type(n) == "table" and type(n[2]) == "number" then
            notes[#notes+1] = {t=n[1], lane=n[2]}
        end
    end
    if #notes < 2 then return end
    table.sort(notes, function(a,b) return a.t < b.t end)

    -- simple strain score per 1s bucket, extra weight for jacks (same lane firing fast) and chords (several lanes at once)
    local lastLaneT, strainAt = {}, {}
    for i, n in ipairs(notes) do
        local strain = 1.0
        local lastT = lastLaneT[n.lane]
        if lastT and (n.t-lastT) < 0.25 then strain = strain + (0.25-(n.t-lastT))*12 end
        lastLaneT[n.lane] = n.t
        local prev = notes[i-1]
        if prev and (n.t-prev.t) < 0.015 and prev.lane ~= n.lane then strain = strain + 1.5 end
        local bucket = math.floor(n.t)
        strainAt[bucket] = (strainAt[bucket] or 0) + strain
    end

    local buckets = {}
    for b, s in pairs(strainAt) do buckets[#buckets+1] = {b=b, s=s} end
    table.sort(buckets, function(a,b) return a.s > b.s end)

    local spikes, usedTimes = {}, {}
    for _, entry in ipairs(buckets) do
        local tSec, tooClose = entry.b, false
        for _, u in ipairs(usedTimes) do
            if math.abs(u-tSec) < 4 then tooClose=true; break end
        end
        if not tooClose then
            spikes[#spikes+1] = {t=tSec, strain=entry.s}
            usedTimes[#usedTimes+1] = tSec
        end
        if #spikes >= 3 then break end
    end

    lastScanResult = {totalSeconds=notes[#notes].t, noteCount=#notes, spikes=spikes}
    if hAutoScan and not perfected then
        window:Notification({Title="song scanned", Text=buildScanMessage(lastScanResult), Duration=5})
    end
end

chartIsInSpikeWindow = function()
    if not (lastScanResult and lastScanResult.spikes) then return false end
    local now = tick() - songStartTick
    for _, sp in ipairs(lastScanResult.spikes) do
        if math.abs(now-sp.t) < 1.5 then return true end
    end
    return false
end

local function installChartScanHook()
    if scanHookInstalled then return end
    pcall(function()
        local mainGui = v5.PlayerGui:WaitForChild("Main", 15)
        if not mainGui then return end
        local hostScript
        for _, ch in ipairs(mainGui:GetChildren()) do
            if ch:IsA("LocalScript") and ch:FindFirstChild("songPlay") then
                hostScript = ch; break
            end
        end
        if not hostScript then return end
        local sP = require(hostScript.songPlay)
        for _, fnName in ipairs({"PlaySong"}) do
            if type(sP[fnName]) == "function" then
                local original = sP[fnName]
                sP[fnName] = function(songModule, ...)
                    hResetRun()

                    -- the 2nd arg after songModule is the side the game plays (1 or 2)
                    local extra = {...}
                    local side = tonumber(extra[2])
                    if side ~= 1 and side ~= 2 then side = nil end

                    -- this hook runs AS PART OF the game's own function call, so it only reads the chart for the
                    -- scanner. it never presses or schedules anything (learned that one the hard way)
                    task.spawn(function() pcall(analyzeChart, songModule, side) end)
                    return original(songModule, ...)
                end
            end
        end
        scanHookInstalled = true
    end)
end

-- ════════════════════════════════════════════════════════════
-- perfect mode
-- the "actual bot" mode, and it overrides EVERYTHING. humanize, hit chances, miss jacks, tile
-- lights, the scanner popup and auto latency are all ignored while it's on, and they work like
-- normal again the second it's off
-- every frame it checks the notes in each lane, works out how long until each one crosses the line
-- from the note's own movement (no speed formulas, so scroll speed and sv dont matter) and presses
-- on the frame that lands closest to the hit. holds get let go using the game's own finish rule
-- it calibrates its press lead over the first few notes, then locks it and stops touching it.
-- only a long, clear drift unlocks it again
-- ════════════════════════════════════════════════════════════
local pfLead         = 0.017   -- secs between our press and the frame the game reads the note on (the magic number)
local pfLocked       = false
local pfBuf          = {}
local pfGoodN        = 0
local pfBadN         = 0
local pfDt           = 1/60
local pfLastText     = nil
local pfActive       = false
local pfSavedHitLate = false
local pfTrack        = setmetatable({}, {__mode="k"})
local pfDone         = setmetatable({}, {__mode="k"})

local function startPerfectMode()
    if not pfActive then
        pfActive = true
        -- msIndic only shows with HitLate on. remember the real value so it can go back when perfect mode stops
        pfSavedHitLate = _G.Settings and _G.Settings.HitLate or false
        if _G.Settings then _G.Settings.HitLate = true end
    end
    pfBuf = {}; pfLastText = nil
end

local function stopPerfectMode()
    if not pfActive then return end
    pfActive = false
    if _G.Settings then _G.Settings.HitLate = pfSavedHitLate end
end

local function pfMedian(list)
    local s = {}
    for _, v in ipairs(list) do s[#s+1] = v end
    table.sort(s)
    local n = #s
    if n == 0 then return 0 end
    if n % 2 == 1 then return s[(n+1)/2] end
    return (s[n/2] + s[n/2+1]) / 2
end

-- one fresh ms reading = one sample. it calibrates until the readings settle, then locks and stops
-- adjusting. locked = hands off, it only lets go if the readings are clearly off for a while
-- (like after an fps change)
local function pfCalibrate(mf)
    local ind = mf and mf:FindFirstChild("msIndic")
    if not (ind and ind.Visible) then return end
    local txt = ind.Text or ""
    if txt == pfLastText then return end
    pfLastText = txt
    local val = tonumber(txt:match("(-?%d+%.?%d*)"))
    if not val or math.abs(val) > (pfLocked and 20 or 60) then return end
    pfBuf[#pfBuf+1] = val
    if #pfBuf < (pfLocked and 8 or 5) then return end
    local med = pfMedian(pfBuf)
    pfBuf = {}
    if pfLocked then
        pfBadN = (math.abs(med) > 6) and (pfBadN + 1) or 0
        if pfBadN >= 3 then pfLocked = false; pfBadN = 0; pfGoodN = 0 end
    else
        -- a + reading means the press was early, so lead less (+ is early, - is late, i keep forgetting)
        pfLead = math.clamp(pfLead - med/1000 * 0.6, FS.on and -0.02 or 0, 0.25)
        pfGoodN = (math.abs(med) <= 3) and (pfGoodN + 1) or 0
        if pfGoodN >= 2 then pfLocked = true; pfGoodN = 0; pfBadN = 0 end
    end
end

local PF_LATE = 0.12  -- a note further past the line than this is too late to hit

-- how long until this note crosses the line (negative = already past it), from the note's own
-- movement over the last 0.1 to 0.3s. it works with the signed distance so the maths stays
-- straight even when a note crosses the line between two frames
local function pfRemaining(c, scale, now, fallbackV)
    local s = pfTrack[c]
    if not s then
        -- a note comes in from one side and that side counts as "before the line". one that first shows
        -- up right AT the line is assumed to be on the usual (positive) side
        local side = (scale < -0.5) and -1 or 1
        local d0 = scale * side
        pfTrack[c] = {side=side, pT=now, pD=d0, cT=now, cD=d0}
        return d0 / fallbackV
    end
    local d = scale * s.side
    if now - s.cT >= 0.15 then
        s.pT, s.pD, s.cT, s.cD = s.cT, s.cD, now, d
    end
    local span = now - s.pT
    if span < 0.08 then return d / fallbackV end
    local v = (s.pD - d) / span  -- scale units per second, + = getting closer
    if v < 0.02 then return d / fallbackV end
    return d / v
end

local function pfSpeed(c, fallbackV)
    local s = pfTrack[c]
    if s and s.cT - s.pT >= 0.05 then
        local v = (s.pD - s.cD) / (s.cT - s.pT)
        if v > 0.5 then return v end
    end
    return fallbackV
end

local function pfNearest(nf, now, fallbackV)
    local best, bestRem = nil, math.huge
    for _, c in ipairs(nf:GetChildren()) do
        if c:IsA("GuiObject") and c.Visible and c.Name:sub(1,5) ~= "Hold_" and not pfDone[c] then
            local rem = pfRemaining(c, c.Position.Y.Scale, now, fallbackV)
            if rem < -PF_LATE then
                pfDone[c] = true
            elseif rem < bestRem then
                best, bestRem = c, rem
            end
        end
    end
    return best, bestRem
end

local function perfectStep(dt)
    if not v8 or not perfected then return end
    pfDt = math.clamp(pfDt*0.9 + math.min(dt or pfDt, 0.05)*0.1, 0.004, 0.05)
    local KS = getMyKeySync()
    if not (KS and KS.Visible) then return end
    local now = tick()
    local S = _G.Settings or {}
    local fallbackV = math.max(1, 5.5 * (tonumber(S.NoteSpeed) or 2))

    pfCalibrate(KS.Parent)
    FS.watchStep(now)

    -- press on the frame that lands closest to the hit: the first frame where the note is within our lead + half a frame of the line (frame perfect, ish)
    local threshold = pfLead + pfDt/2

    for lane=1,4 do
        local af = KS:FindFirstChild("Arrow"..lane)
        local nf = af and af:FindFirstChild("Notes")
        if nf then
            hHoldTick(lane, now)

            -- press everything due this frame (fast jacks can have more than one note due at once, yes really)
            for _=1,4 do
                local note, rem = pfNearest(nf, now, fallbackV)
                if not (note and rem <= threshold) then break end
                pfDone[note] = true
                if laneHoldFrame[lane] then stopHold(lane, true) end
                local holdFrame = nil
                if note:GetAttribute("HoldHead") == true then
                    holdFrame = nf:FindFirstChild("Hold_"..note.Name)
                    if holdFrame and math.abs(holdFrame.Size.Y.Scale) < 0.01 then holdFrame = nil end
                end
                if holdFrame then
                    vimUp(lane); vimDown(lane)
                    pressSeq[lane] = pressSeq[lane] + 1
                    laneHoldFrame[lane] = holdFrame
                    -- the hold body takes (its length / its speed) to pass the line once the head lands. let go just after that
                    local body = math.abs(holdFrame.Size.Y.Scale) / pfSpeed(note, fallbackV)
                    hHold[lane] = {t0=now, endAt=now + rem + body + 0.03}
                else
                    vimTap(lane)
                end
                if rem > -0.03 then FS.watchAdd(note, now, lane) end
            end
        end
    end
end

-- ════════════════════════════════════════════════════════════
-- the player's hands
-- same note tracking as perfect mode. each note gets decided ONCE, ahead of time (hDecide), then
-- pressed on the frame that lands closest to the error it was given. holds get let go the way
-- they were planned
-- ════════════════════════════════════════════════════════════
local function humanTapDur(gapNext, density)
    -- a real tap is 40 to 90ms down, quicker when the notes come quicker, and it cant be longer than the gap to the next note in the lane
    local d = 0.055 * (0.75 + 0.6*math.random()) / (1 + 0.02*(density or 0))
    return math.clamp(d, 0.025, math.max(0.025, (gapNext or 1) * 0.6))
end

-- how a hold gets let go. all timing: the hold body takes (length / speed) to pass the line after the
-- head lands. normally a little after that, never on the exact frame. every so often too soon,
-- which breaks it (yes on purpose)
local function hHoldPlan(hf, now, hitT, vv)
    local body = math.abs(hf.Size.Y.Scale) / vv
    local plan = {t0=now, endAt=hitT + body + 0.03}
    if humanize and hHumanHolds then
        plan.endAt = hitT + body + math.clamp(0.035 + gaussianRandom()*0.03, 0, 0.12)
        if hAllowRealMiss and hSlips and body > 0.25 then
            local p = (hMistakes/100) * 0.02 * (1 + (100-hAccuracy)/40)
            if hTiltOn then p = p * (1 + 1.5*hTilt) end
            if math.random() < math.min(0.25, p) then
                plan.dropAt = hitT + body * (0.15 + math.random()*0.7)
                if hTiltOn then hTilt = math.min(2, hTilt + 0.5) end
            end
        end
    end
    return plan
end

local function hPress(lane, note, nf, e, gapNext, density, now, rem, fallbackV)
    pressLog[#pressLog+1] = {t=now, e=e}
    if #pressLog > 8 then table.remove(pressLog, 1) end
    if laneHoldFrame[lane] then stopHold(lane, true) end
    local holdFrame = nil
    if note:GetAttribute("HoldHead") == true then
        holdFrame = nf:FindFirstChild("Hold_"..note.Name)
        if holdFrame and math.abs(holdFrame.Size.Y.Scale) < 0.01 then holdFrame = nil end
    end
    if holdFrame then
        vimUp(lane); vimDown(lane)
        pressSeq[lane] = pressSeq[lane] + 1
        laneHoldFrame[lane] = holdFrame
        hHold[lane] = hHoldPlan(holdFrame, now, now + rem, pfSpeed(note, fallbackV))
    else
        vimTap(lane, (humanize and hHumanTaps) and humanTapDur(gapNext, density) or nil)
    end
    if math.abs(e) <= 20 and rem > -0.03 then FS.watchAdd(note, now, lane) end
end

local function hPlanGroup(group, all, now)
    table.sort(group, function(a, b) return a.lane < b.lane end)
    local rem0  = group[1].rem
    local hitT0 = now + rem0

    -- how busy it is around this note, in hand movements a second. a chord is ONE movement however
    -- many keys it has, so notes that land together only count once. notes already played count too
    local times = {}
    for _, o in ipairs(all) do
        if math.abs(o.rem - rem0) <= 0.4 then times[#times+1] = now + o.rem end
    end
    for _, ht in ipairs(hHitHist) do
        if ht <= now and ht >= hitT0 - 0.4 then times[#times+1] = ht end
    end
    table.sort(times)
    local count, lastT = 0, -math.huge
    for _, t in ipairs(times) do
        if t - lastT > 0.012 then count = count + 1 end
        lastT = t
    end
    local density = count / 0.8
    local restGap = hitT0 - hAnyHit
    local size    = #group
    local overflow = humanize and trackAndGetOverflow() or 0

    local function ctx(it)
        return {lane=it.lane, now=now, gapPrev=(now + it.rem) - hLaneHit[it.lane],
                restGap=restGap, density=density, chordSize=size, overflow=overflow}
    end

    local es = {}
    if size == 1 or not humanize then
        for k, it in ipairs(group) do
            es[k] = (hDecide(ctx(it))) or false
        end
    else
        -- a chord is one hand movement: one decision for the whole thing and every finger lands near it (fingers are lazy together)
        local e1, sig = hDecide(ctx(group[1]))
        if e1 == nil then
            -- a slip: one finger lets go of its key, the others still land, a bit off. oops
            local drop = math.random(1, size)
            for k = 1, size do
                if k == drop then es[k] = false
                else es[k] = math.clamp(gaussianRandom() * sig * 1.3 + 6, -110, 125) end
            end
        else
            for k = 1, size do
                if k == 1 then es[k] = e1
                else es[k] = math.clamp(e1 + gaussianRandom() * 0.35 * sig, -110, 125) end
            end
            if hSlips and hAllowRealMiss and size >= 3
               and math.random() < (hMistakes/100) * 0.012 * (size - 1) then
                es[math.random(1, size)] = false
            end
        end
        if hChordStagger then
            local st, total = {}, 0
            for m = 1, size do
                local rank = (hChordDir > 0) and m or (size - m + 1)
                st[m] = (rank - 1) * (3 + math.random() * 7)
                total = total + st[m]
            end
            for m = 1, size do
                if es[m] then es[m] = es[m] + (st[m] - total / size) end
            end
        end
    end

    if missJacks then
        for k, it in ipairs(group) do
            -- stumbles on a fast same-key repeat, on purpose (humans trip on jacks, so do we)
            if es[k] and (now + it.rem) - hLaneHit[it.lane] < 0.12 then es[k] = false end
        end
    end

    while #hHitHist > 0 and hHitHist[1] < now - 1 do table.remove(hHitHist, 1) end
    for k, it in ipairs(group) do
        if es[k] then
            hPlan[it.note] = {e=es[k], density=density}
        else
            pfDone[it.note] = true  -- left alone, the game counts it as a miss (ghosted)
        end
        hLaneHit[it.lane] = now + it.rem
        hHitHist[#hHitHist+1] = now + it.rem
    end
    hAnyHit = math.max(hAnyHit, hitT0)
end

local function humanStep(dt)
    if not v8 or perfected then return end
    pfDt = math.clamp(pfDt*0.9 + math.min(dt or pfDt, 0.05)*0.1, 0.004, 0.05)
    local KS = getMyKeySync()
    if not (KS and KS.Visible) then return end
    local now = tick()
    local S = _G.Settings or {}
    local fallbackV = math.max(1, 5.5 * (tonumber(S.NoteSpeed) or 2))
    FS.watchStep(now)
    -- time between our press and the frame the game reads the note on. the latency slider (or auto
    -- latency) sets this, same meaning as always: bigger slider = press later
    local lead = math.clamp((130.5 - vimLatencyMs) / 1000, FS.on and -0.03 or 0, 0.25)
    local dtHalf = pfDt / 2

    local lanes, all = {}, {}
    for lane=1,4 do
        local af = KS:FindFirstChild("Arrow"..lane)
        local nf = af and af:FindFirstChild("Notes")
        local list = {}
        if nf then
            for _, c in ipairs(nf:GetChildren()) do
                if c:IsA("GuiObject") and c.Visible and c.Name:sub(1,5) ~= "Hold_" and not pfDone[c] then
                    local rem = pfRemaining(c, c.Position.Y.Scale, now, fallbackV)
                    if rem < -PF_LATE then
                        pfDone[c] = true
                    elseif rem < 1.0 then
                        local item = {note=c, rem=rem, lane=lane}
                        list[#list+1] = item
                        all[#all+1] = item
                    end
                end
            end
            table.sort(list, function(a, b) return a.rem < b.rem end)
        end
        lanes[lane] = {nf=nf, list=list}
    end
    table.sort(all, function(a, b) return a.rem < b.rem end)

    local i = 1
    while i <= #all do
        local it = all[i]
        if it.rem > H_PLAN then break end
        if hPlan[it.note] or pfDone[it.note] then
            i = i + 1
        else
            local group = {it}
            local j = i + 1
            while j <= #all and all[j].rem - it.rem <= 0.012 do
                if not hPlan[all[j].note] and not pfDone[all[j].note] then group[#group+1] = all[j] end
                j = j + 1
            end
            hPlanGroup(group, all, now)
            i = j
        end
    end

    for lane=1,4 do
        local nf, list = lanes[lane].nf, lanes[lane].list
        if nf then
            hHoldTick(lane, now)

            local k, pressed = 1, 0
            while k <= #list and pressed < 4 do
                local it = list[k]
                if pfDone[it.note] then
                    k = k + 1
                else
                    local p = hPlan[it.note]
                    if not p then break end
                    if it.rem <= lead - p.e/1000 + dtHalf then
                        pfDone[it.note] = true
                        local nxt = nil
                        for m = k+1, #list do
                            if not pfDone[list[m].note] then nxt = list[m]; break end
                        end
                        hPress(lane, it.note, nf, p.e, nxt and (nxt.rem - it.rem) or 1, p.density, now, it.rem, fallbackV)
                        pressed = pressed + 1
                        k = k + 1
                    else
                        break
                    end
                end
            end
        end
    end
end

-- ════════════════════════════════════════════════════════════
-- main loop
-- perfect mode presses on the frame closest to the hit and ignores everything else. any other
-- time the player (humanize, or the hit chance weights with humanize off) decides and presses
-- ════════════════════════════════════════════════════════════
-- switches the press method. lets go of everything first (the way it went down) so nothing stays
-- stuck, then moves the timing one frame over: firesignal skips the frame the input queue costs.
-- the calibration does the fine tuning
FS.apply = function(on)
    on = on and true or false
    if on == FS.on then return end
    for i=1,4 do
        if laneHoldFrame[i] then stopHold(i, false) end
        vimUp(i)
    end
    FS.on = on
    FS.watch = {}; FS.missN = 0
    local fr = pfDt
    if on then
        pfLead = math.max(-0.02, pfLead - fr)
        vimLatencyMs = math.clamp(vimLatencyMs + fr * 1000, 0, 300)
    else
        pfLead = math.clamp(pfLead + fr, 0, 0.25)
        vimLatencyMs = math.clamp(vimLatencyMs - fr * 1000, 0, 300)
    end
    pfLocked = false; pfBuf = {}; pfGoodN = 0; pfBadN = 0; pfLastText = nil
    alReset("hunt")
    pressLog = {}
end

startLoop = function()
    if mainLoop then mainLoop:Disconnect(); mainLoop=nil end
    -- never leave a key stuck down when the mode changes, stuck keys are chaos
    for i=1,4 do
        if laneHoldFrame[i] then stopHold(i,false) end
        vimUp(i)
    end
    FS.refreshKeys()
    if perfected then
        -- perfect mode takes over completely. the old auto latency is shut off and none of the humanize stuff is touched
        stopAutoLatency()
        startPerfectMode()
        mainLoop = RunService.RenderStepped:Connect(perfectStep)
    else
        stopPerfectMode()
        if autoLatency then startAutoLatency() end
        mainLoop = RunService.RenderStepped:Connect(humanStep)
    end
end

task.spawn(installChartScanHook)

-- ════════════════════════════════════════════════════════════
-- ui which looks amazing btw
-- ════════════════════════════════════════════════════════════
local infoTab  = window:AddTab("InfoTab",  {Text="info",        Icon="info"    })
local playTab  = window:AddTab("PlayTab",  {Text="botplay",     Icon="play"    })
local advTab   = window:AddTab("AdvTab",   {Text="advanced bp", Icon="sparkles"})

-- ── info tab ──
local iL = infoTab:AddLeftGroupbox("IL",  {Text="about"       })
local iR = infoTab:AddRightGroupbox("IR", {Text="feature list" })

iL:AddLabel("IL1",{Text="<font color='#C41E3A'><b>bfnf:r botplay</b></font> by woops &lt;3\n\nplays basically fnf: remix for you, automatically.\nhumanize makes it look genuinely played. perfect mode is there too for a true 100% instead.\nauto latency figures out the right timing on its own after a few seconds."})
iL:AddSeparator("ILS1",{})
iL:AddLabel("IL2",{Text="<font color='#D0D0D6'><b>recommended setup:</b></font>\n• humanize (advanced bp tab) → on, for a run that looks genuinely played\n• perfect mode → on instead for a true 100%. it overrides everything else while it's on\n• auto latency → on"})
iL:AddSeparator("ILS2",{})
iL:AddLabel("IL3",{Text="<b>right shift</b> = open / close the menu"})

iR:AddLabel("IR1",{Text="<font color='#C41E3A'><b>botplay tab</b></font>"})
iR:AddLabel("IR2",{Text="enable → turns botplay on or off\nperfect mode → a true 100%, presses every note on the exact frame it lands. overrides everything else while it's on\npress method → VirtualInputManager is the normal way. firesignal hands fake key presses straight to the game's key handler instead, so no input lag. it tests how to reach the game on your executor and goes back to VirtualInputManager if nothing works\ntile lights → lights up the on-screen keys for looks\nmiss jacks → skips super-fast repeat notes so it doesn't stumble\nauto latency → watches your timing and adjusts itself, no setup needed\nvim latency → a manual timing offset, only used when auto latency is off\nhit chances → weights, not percentages, only used while humanize is off"})
iR:AddSeparator("IRS1",{})
iR:AddLabel("IR3",{Text="<font color='#D0D0D6'><b>advanced bp tab</b></font>"})
iR:AddLabel("IR3B",{Text="humanize → plays with realistic, human-like timing instead of frame-perfect inputs. every part of it is its own switch, so mix and match\nskill preset, accuracy, consistency, mistakes → how good, and how steady, this 'player' is\ndifficulty scanner → points out a song's hardest sections the moment it loads"})
iR:AddSeparator("IRS2",{})
iR:AddLabel("IR5",{Text="<font color='#C41E3A'><b>works with</b></font>\n✓ mid-song speed changes\n✓ up & down scroll charts\n✓ modded charts\n✓ smooth at high fps, and still keeps up if your fps drops\n✓ hold notes and short (blue) notes"})

-- ── botplay tab (where the magic happens) ──
local pL = playTab:AddLeftGroupbox( "PL", {Text="botplay"     })
local pR = playTab:AddRightGroupbox("PR", {Text="hit chances" })

pL:AddToggle("Enable",{
    Text="enable", Value=false,
    Tooltip="turns botplay on or off",
    Callback=function(val)
        v8=val
        if v8 then
            laneHoldFrame={nil,nil,nil,nil}; lanePressed={false,false,false,false}
            for i=1,4 do vimUp(i) end
            hResetRun()
            startLoop()
            window:Notification({Title="botplay",Text="<font color='#C41E3A'><b>on</b></font>",Duration=2})
        else
            for i=1,4 do
                if laneHoldFrame[i] then stopHold(i,false) end
                vimUp(i)
            end
            if mainLoop then mainLoop:Disconnect(); mainLoop=nil end
            stopAutoLatency()
            stopPerfectMode()
            laneHoldFrame={nil,nil,nil,nil}; lanePressed={false,false,false,false}
            window:Notification({Title="botplay",Text="off",Duration=2})
        end
    end,
})

pL:AddToggle("Perfected",{
    Text="perfect mode", Value=false,
    Tooltip="a true 100%. presses every note on the exact frame it lands and overrides everything else (humanize, auto latency, hit chances, miss jacks, tile lights) until you turn it off",
    Callback=function(val)
        perfected=val
        if v8 then if mainLoop then mainLoop:Disconnect(); mainLoop=nil end; startLoop() end
        window:Notification({Title="perfect mode",Text=val and "<font color='#C41E3A'>on</font>, overriding everything else" or "off, everything else is back",Duration=3})
    end,
})

FS.picker = pL:AddDropdown("PressMethod",{
    Text="press method", Values={"VirtualInputManager","firesignal"}, Value=1,
    Tooltip="VirtualInputManager is the normal way. firesignal hands fake key presses straight to the game's key handler instead, so there's no input lag and the timing stays steadier. it tests how to reach the game on your executor, and goes back to VirtualInputManager on its own if nothing works",
    Callback=function(val)
        local pick = (type(val) == "number") and ({"VirtualInputManager","firesignal"})[val] or val
        FS.req = FS.req + 1
        local mine = FS.req
        if pick ~= "firesignal" then
            local was = FS.on
            FS.apply(false)
            if was then window:Notification({Title="press method",Text="back to VirtualInputManager",Duration=2}) end
            return
        end
        FS.broken = false; FS.breakWhy = nil; FS.skipWhy = nil; FS.verified = false
        FS.reported = false; FS.missN = 0; FS.failN = 0
        task.spawn(function()
            local routes = FS.setup()
            if mine ~= FS.req then return end   -- flipped again while it was testing, so whatever it found is stale now
            if #routes == 0 then
                FS.broken = true
                FS.resetPicker()
                window:Notification({Title="firesignal",Text="can't reach the game's key handler on this executor, staying on VirtualInputManager (details in the console)",Duration=6})
                return
            end
            FS.routes, FS.routeI, FS.route = routes, 1, routes[1]
            FS.refreshKeys()
            FS.apply(true)
            window:Notification({Title="firesignal",Text="<font color='#C41E3A'>on</font>, route: "..FS.route,Duration=3})
        end)
    end,
})

pL:AddButton("FireDiag",{
    Text="firesignal diagnostics",
    Tooltip="prints a report about your executor and how the game handles keys to the console, and copies it to your clipboard. best pressed in the middle of a song with the bot off",
    Callback=function()
        window:Notification({Title="firesignal",Text="running diagnostics, give it a second",Duration=2})
        task.spawn(function()
            local _, copied = FS.report()
            window:Notification({Title="firesignal",Text="report is in the console"..(copied and " and copied to your clipboard" or ""),Duration=6})
        end)
    end,
})

pL:AddToggle("TileLights",{
    Text="tile lights", Value=false,
    Tooltip="lights up the on-screen keys when they're pressed, just for looks",
    Callback=function(val)
        tileLights=val
        if not val then
            for i=1,4 do local t=getMobileTile(i); if t then t.ImageTransparency=0.8 end end
        end
        window:Notification({Title="tile lights",Text=val and "<font color='#C41E3A'>on</font>" or "off",Duration=2})
    end,
})

pL:AddToggle("MissJacks",{
    Text="miss jack notes", Value=false,
    Tooltip="skips super-fast repeat notes on the same key so it doesn't stumble",
    Callback=function(val) missJacks=val end,
})

pL:AddSeparator("PLS1",{})

pL:AddToggle("AutoLatency",{
    Text="auto latency", Value=true,
    Tooltip="watches your timing and adjusts itself automatically, just leave it on",
    Callback=function(val)
        autoLatency=val
        if perfected then
            -- perfect mode ignores this and calibrates on its own, the switch is just remembered for when perfect mode goes off
        elseif val and v8 then
            startAutoLatency()
        elseif not val then
            stopAutoLatency()
        end
        window:Notification({
            Title="auto latency",
            Text=(val and "<font color='#C41E3A'>on</font>, adjusting itself" or "off, using manual slider")..(perfected and " (ignored while perfect mode is on)" or ""),
            Duration=3
        })
    end,
})

pL:AddLabel("TLH",{Text="<font color='#888'>manual mode (auto latency off):\nif the ms counter shows + raise the slider  ·  if it shows - lower it</font>"})

pL:AddSlider("VimLatency",{
    Text="vim latency (ms)", Min=0, Max=300, Value=103, Step=1,
    Tooltip="a manual timing offset, only used while auto latency is off",
    Callback=function(v) if not autoLatency then vimLatencyMs=v end end,
})

pR:AddLabel("TRH",{Text="<font color='#D0D0D6'><b>these are weights, not percentages.</b></font>\nleave them all at 0 for perfect hits every time.\nlocked automatically while humanize (advanced bp tab) is on."})
pR:AddSeparator("TRS",{})
pR:AddSlider("PC",{Text="perfect",Min=0,Max=100,Value=100,Step=1,Callback=function(v) if not humanize then perfectChance=v end end})
pR:AddSlider("SC",{Text="sick",   Min=0,Max=100,Value=0,  Step=1,Tooltip="16.5-43.5ms",  Callback=function(v) if not humanize then sickChance=v end end})
pR:AddSlider("GC",{Text="good",   Min=0,Max=100,Value=0,  Step=1,Tooltip="43.5-76.5ms",  Callback=function(v) if not humanize then goodChance=v end end})
pR:AddSlider("OC",{Text="ok",     Min=0,Max=100,Value=0,  Step=1,Tooltip="76.5-106.5ms", Callback=function(v) if not humanize then okChance=v end end})
pR:AddSlider("BC",{Text="bad",    Min=0,Max=100,Value=0,  Step=1,Tooltip="106.5-130.5ms",Callback=function(v) if not humanize then badChance=v end end})
pR:AddSlider("MC",{Text="miss",   Min=0,Max=100,Value=0,  Step=1,                        Callback=function(v) if not humanize then missChance=v end end})

-- ── advanced tab ──
local aL = advTab:AddLeftGroupbox( "AL", {Text="humanize"           })
local aR = advTab:AddRightGroupbox("AR", {Text="difficulty scanner" })

aL:AddToggle("Humanize",{
    Text="humanize", Value=true,
    Tooltip="replaces the old legit mode. plays with realistic, human-like timing instead of frame-perfect inputs",
    Callback=function(val)
        humanize=val
        window:Notification({Title="humanize",Text=val and "<font color='#C41E3A'>on</font>" or "off, using the hit chance sliders on the botplay tab instead",Duration=3})
    end,
})

local presetNames = {"custom","casual","average","skilled","pro","elite"}
local presets = {
    casual  = {acc=55, cons=40, mist=70},
    average = {acc=72, cons=55, mist=50},
    skilled = {acc=86, cons=65, mist=35},
    pro     = {acc=94, cons=78, mist=22},
    elite   = {acc=98, cons=88, mist=10},
}
local accSlider, consSlider, mistSlider

aL:AddDropdown("SkillPreset",{
    Text="skill preset", Values=presetNames, Value=1,
    Tooltip="one tap setups for accuracy, consistency and mistakes. 'custom' leaves the sliders alone",
    Callback=function(val)
        local p = presets[(type(val)=="number") and presetNames[val] or val]
        if not p then return end
        hAccuracy, hConsistency, hMistakes = p.acc, p.cons, p.mist
        for _, pair in ipairs({{accSlider,p.acc},{consSlider,p.cons},{mistSlider,p.mist}}) do
            if pair[1] then pcall(function() pair[1]:SetValue(pair[2]) end) end
        end
    end,
})

accSlider = aL:AddSlider("Accuracy",{
    Text="accuracy", Min=0, Max=100, Value=92, Step=1,
    Tooltip="how good this 'player' is, higher means tighter, closer-to-perfect timing",
    Callback=function(v) hAccuracy=v end,
})

consSlider = aL:AddSlider("Consistency",{
    Text="consistency", Min=0, Max=100, Value=70, Step=1,
    Tooltip="how steady it stays, lower lets it drift into little hot and cold streaks like a real player",
    Callback=function(v) hConsistency=v end,
})

mistSlider = aL:AddSlider("Mistakes",{
    Text="mistakes", Min=0, Max=100, Value=35, Step=1,
    Tooltip="how often it slips: a bigger error, a missed note, a dropped hold. 0 never slips",
    Callback=function(v) hMistakes=v end,
})

aL:AddSlider("Lean",{
    Text="timing lean (ms)", Min=-15, Max=15, Value=0, Step=1,
    Tooltip="negative presses early on average, positive presses late. stacks with the personal quirk",
    Callback=function(v) hLeanMs=v end,
})

aL:AddSeparator("ALS1",{})

aL:AddToggle("JackFatigue",{
    Text="finger fatigue on fast bursts", Value=true,
    Tooltip="busy sections and fast same-key repeats get sloppier, like a real hand struggling to keep up",
    Callback=function(val) hJackFatigue=val end,
})

aL:AddToggle("ChordStagger",{
    Text="chord finger stagger", Value=true,
    Tooltip="notes landing on the same beat across lanes are pressed as one hand movement, a few ms apart, not at the exact same instant",
    Callback=function(val) hChordStagger=val end,
})

aL:AddToggle("WarmupFatigue",{
    Text="warm-up & fatigue", Value=true,
    Tooltip="a little shakier for the first couple seconds, and can drift slightly on long songs",
    Callback=function(val) hWarmupFatigue=val end,
})

aL:AddToggle("PersonalBias",{
    Text="personal timing quirk", Value=true,
    Tooltip="picks a small, consistent lean each run (a touch early or a touch behind), like a real player's habit",
    Callback=function(val) hPersonalBias=val end,
})

aL:AddSeparator("ALS2",{})

aL:AddSlider("FingerSpeed",{
    Text="finger speed limit (kps)", Min=1, Max=100, Value=100, Step=1,
    Tooltip="going above this doesn't skip notes anymore, it just gets sloppier, the way a real hand would",
    Callback=function(v) fingerSpeedLimit=v end,
})

aL:AddToggle("AllowRealMiss",{
    Text="allow real misses & dropped holds", Value=true,
    Tooltip="lets it genuinely miss a note or let go of a hold too soon now and then. off = it never drops anything, it just gets sloppier",
    Callback=function(val) hAllowRealMiss=val end,
})

aR:AddLabel("ARH",{Text="<font color='#D0D0D6'><b>reads the chart the moment a song starts</b></font>\nand points out the hardest sections before you even hit note one."})
aR:AddSeparator("ARS1",{})

aR:AddToggle("AutoScan",{
    Text="scan songs automatically", Value=true,
    Tooltip="shows a popup with the hardest sections as soon as a song loads",
    Callback=function(val) hAutoScan=val end,
})

aR:AddToggle("ReactToSpikes",{
    Text="react to difficulty spikes", Value=true,
    Tooltip="humanize gets a bit looser during the hardest sections it found, instead of staying perfectly steady",
    Callback=function(val) hReactToSpikes=val end,
})

aR:AddButton("ShowSpikes",{
    Text="show hardest sections",
    Tooltip="re-shows the last scan's results",
    Callback=function()
        if not lastScanResult then
            window:Notification({Title="difficulty scanner",Text="no song scanned yet, start a song first",Duration=3})
        else
            window:Notification({Title="song scanned",Text=buildScanMessage(lastScanResult),Duration=5})
        end
    end,
})

aR:AddSeparator("ARS2",{})
aR:AddLabel("ARD",{Text="<font color='#D0D0D6'><b>human details</b></font>\neach one is its own switch, so mix and match. all of these only apply while humanize is on"})

aR:AddToggle("EarlyHits",{
    Text="hits can land early", Value=true,
    Tooltip="real players hit early as well as late. off = it only ever lands late",
    Callback=function(val) hEarlyHits=val end,
})
aR:AddToggle("TimingDrift",{
    Text="timing drift", Value=true,
    Tooltip="the timing average wanders a few ms over time, a bit ahead for a while, then a bit behind",
    Callback=function(val) hDriftOn=val end,
})
aR:AddToggle("FocusWaves",{
    Text="focus waves", Value=true,
    Tooltip="attention comes and goes over tens of seconds: tighter when locked in, looser when it fades",
    Callback=function(val) hFocusOn=val end,
})
aR:AddToggle("FingerHabits",{
    Text="finger habits", Value=true,
    Tooltip="each lane has its own small habit, one a hair early, another a hair late, re-rolled every song",
    Callback=function(val) hFingerBias=val end,
})
aR:AddToggle("SelfCorrect",{
    Text="self-correction", Value=true,
    Tooltip="after a late press the next one comes a touch earlier, and the other way round, like a real player adjusting",
    Callback=function(val) hSelfCorrect=val end,
})
aR:AddToggle("HotColdStreaks",{
    Text="hot & cold streaks", Value=true,
    Tooltip="runs of notes that are tighter than usual, then runs that are looser (consistency sets how streaky)",
    Callback=function(val) hStreaks=val end,
})
aR:AddToggle("Rush",{
    Text="rush on dense patterns", Value=true,
    Tooltip="presses a touch early when the notes get dense, like a player getting ahead of the beat",
    Callback=function(val) hRush=val end,
})
aR:AddToggle("ColdStart",{
    Text="cold start after a break", Value=true,
    Tooltip="the first notes after a long gap are sloppier, like a hand that went idle",
    Callback=function(val) hColdStart=val end,
})
aR:AddToggle("Slips",{
    Text="occasional slips", Value=true,
    Tooltip="every so often a note lands well off (the mistakes slider sets how often). slips can also be full misses if real misses are allowed",
    Callback=function(val) hSlips=val end,
})
aR:AddToggle("SlipsSnowball",{
    Text="slips snowball", Value=true,
    Tooltip="after a slip the next few notes are shakier, so mistakes come in clusters like they do for real",
    Callback=function(val) hTiltOn=val end,
})
aR:AddToggle("HumanHolds",{
    Text="human holds", Value=true,
    Tooltip="holds are let go a little after the end, never on the exact frame, and now and then too soon (needs real misses on)",
    Callback=function(val) hHumanHolds=val end,
})
aR:AddToggle("HumanTaps",{
    Text="human tap length", Value=true,
    Tooltip="how long a key stays down varies, shorter on fast patterns. shows up on the tile lights",
    Callback=function(val) hHumanTaps=val end,
})
