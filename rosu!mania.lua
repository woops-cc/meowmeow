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
    warn("[rosu!mania] the library loader failed ("..tostring(res).."), loading the library file directly")
    for _, user in ipairs(LIBRARY_USERS) do
        local ok2, res2 = pcall(viaFile, user)
        if ok2 and res2 then return res2 end
        warn(("[rosu!mania] loading the library from %s failed: %s"):format(user, tostring(res2)))
    end
    warn("[rosu!mania] couldn't load the ui library")
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
                warn(("[rosu!mania] ui: %s:%s failed: %s"):format(label, tostring(key), tostring(res)))
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
    Title    = "<font color='#E8E8EC'><b>rosu!mania</b></font><font color='#C41E3A'> botplay</font>",
    Icon     = "125411711221424",
    Footer   = "<font color='#C41E3A'>woops &lt;3</font>  ·  rosu!mania  ·  "..VERSION,
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
        opts = {Title = "rosu!mania botplay", Keybind = Enum.KeyCode.RightShift}
    end
    local ok, res = pcall(function() return lib:Window("rosumania_ap", opts) end)
    if ok and res then window = res; break end
    warn(("[rosu!mania] window attempt %d failed: %s"):format(attempt, tostring(res)))
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
local VIM          = game:GetService("VirtualInputManager")
local UIS          = game:GetService("UserInputService")
local RepS         = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Players      = game:GetService("Players")
local v5           = Players.LocalPlayer

local function f2(x) return type(x) == "number" and string.format("%.2f", x) or tostring(x) end

-- ---- state ----
local v8          = false
local perfected   = false
local missJacks   = false
local tileLights  = false
local tileLit     = 0.9     -- same as a real touch. the glow slider can push it brighter for videos
local autoLatency = true
local TAP_DUR     = 0.05
local STEP_NAME   = "rosumania_botplay"
local looping     = false

local DEFAULT_KEYS = {Enum.KeyCode.D, Enum.KeyCode.F, Enum.KeyCode.J, Enum.KeyCode.K}
local KEYS         = {DEFAULT_KEYS[1], DEFAULT_KEYS[2], DEFAULT_KEYS[3], DEFAULT_KEYS[4]}
local lanePressed  = {false, false, false, false}
local pressSeq     = {0, 0, 0, 0}   -- bumps every press so an old tap timer cant release a newer press (race conditions, my beloved)
local laneHold     = {}
local pfDone       = setmetatable({}, {__mode = "k"})   -- notes already pressed or skipped
local pend         = {}   -- presses waiting for their judged delta, auto latency reads these
local htSeen       = 0

local pxChance, perfChance, greatChance, goodChance, badChance, missChance = 100, 0, 0, 0, 0, 0

-- humanize settings (the advanced tab fills these in)
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

local hAutoScan      = true
local hFlawless      = false   -- the flawless skill preset: still humanized, but every hit gets kept inside perfectx
local hReactToSpikes = true
local lastScanResult = nil     -- {totalSeconds=, noteCount=, spikes={ {t=,strain=}, ... }}
local chartIsInSpikeWindow
local hResetRun, scanChart, releaseAll, lightTile

-- ---- auto latency ----
-- the game logs the judged delta of every hit (get_hit_table), so no text reading hacks here.
-- lat = how many ms later the game judges a press than the frame we pressed on. vim has ~a frame
-- of input queue, the direct route has none. press when early <= target + lat + half a frame
-- same controller as bfnf:r: median of the last 8 readings, no integral, locks when its calm
local lat = {vim = 16, direct = 0}
local alPhase, alBuf, alGoodN, alBadN = "hunt", {}, 0, 0
local LOCK_GAIN, LOCK_THRESH, LOCK_N, UNLOCK_THRESH, UNLOCK_N, BUF_SIZE = 0.03, 2.0, 10, 5.0, 8, 8

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

local FS = {route = "vim", via = {}, watch = {}, lastLane = {}, failN = 0, okN = 0, tried = {}, dead = false, picker = nil, quiet = false}

local function curLat() return lat[FS.route] or 0 end

local function alSample(val)
    if not autoLatency or FS.route ~= "vim" then return end
    local outlierMax = (alPhase == "locked") and 18 or 35
    if math.abs(val) > outlierMax then return end
    alBuf[#alBuf + 1] = val
    if #alBuf > BUF_SIZE then table.remove(alBuf, 1) end
    if #alBuf < 3 then return end
    local med = alMedian()
    -- every correction also shifts the old readings, otherwise the same error gets corrected 8 times
    -- over (the median remembers samples from before the last fix) and it rings like a bell
    local before = lat.vim
    if alPhase == "hunt" then
        lat.vim = math.clamp(lat.vim - med * huntGain(med), -10, 120)
        if math.abs(med) <= LOCK_THRESH then
            alGoodN = alGoodN + 1; alBadN = 0
            if alGoodN >= LOCK_N then alPhase = "locked"; alGoodN = 0; alBadN = 0; alBuf = {} end
        else
            alBadN = alBadN + 1; alGoodN = 0
        end
    else
        lat.vim = math.clamp(lat.vim - med * LOCK_GAIN, -10, 120)
        if math.abs(med) > UNLOCK_THRESH then
            alBadN = alBadN + 1; alGoodN = 0
            if alBadN >= UNLOCK_N then alReset("hunt") end
        else
            alBadN = 0; alGoodN = alGoodN + 1
        end
    end
    local shift = lat.vim - before
    for i = 1, #alBuf do alBuf[i] = alBuf[i] + shift end
end

-- ---- the game ----
-- the live game object sits in an upvalue behind GameJoin.get_game and the game ships its function
-- names, so it gets found by name + source. getgc is heavy, so it only scans when a new song's
-- BGM sound shows up, and it backs off when it finds nothing
local G = {g = nil, am = nil, sm = nil, ts = nil, bgm = nil, panel = nil, mode = 0, clock = 0, rate = 1, pre = 0,
           step = 16.7, stepHi = 17, steps = {}, lastClock = nil, scanning = false, lastScan = -math.huge,
           fails = 0, suspect = false, suspectT = 0, done = false, lastErr = 0}

function G.dinfo(f, what)
    local ok, v = pcall(debug.info, f, what)
    if ok then return v end
end

function G.ups(f)
    local gu = (debug and debug.getupvalues) or getupvalues
    if not gu then return {} end
    local ok, t = pcall(gu, f)
    return (ok and type(t) == "table") and t or {}
end

local function asGame(g)
    if type(g) ~= "table" then return nil end
    local ok, am = pcall(function() return g._audio_manager end)
    if ok and type(am) == "table" then return g, am end
end

-- the one with a moving clock is the live one (old songs leave their game objects behind)
function G.choose(cands)
    local live = {}
    for _, c in ipairs(cands) do
        local ok, m = pcall(function() return c.am:get_current_mode() end)
        local ok2, clk = pcall(function() return c.am:get_current_time_ms() end)
        if ok and ok2 and (m == 3 or m == 4) then c.m, c.c0 = m, clk; live[#live + 1] = c end
    end
    if #live <= 1 then return live[1] end
    task.wait(0.12)
    local best
    for _, c in ipairs(live) do
        local ok, clk = pcall(function() return c.am:get_current_time_ms() end)
        if ok and clk ~= c.c0 and (not best or c.m > best.m) then best = c end
    end
    if best then return best end
    table.sort(live, function(a, b) return a.m > b.m end)
    return live[1]
end

function G.findInner()
    local gc = getgc()
    local want = {get_game = {}, update_input = {}}
    local t0 = os.clock()
    for i = 1, #gc do
        local f = gc[i]
        if type(f) == "function" then
            local nm = G.dinfo(f, "n")
            local lst = nm and want[nm]
            if lst then
                local src = G.dinfo(f, "s")
                if type(src) == "string" and src:find(".", 1, true) then lst[#lst + 1] = {f = f, src = src} end
            end
        end
        if i % 3000 == 0 then task.wait() end
        if os.clock() - t0 > 10 then break end
    end
    gc = nil
    local seen, cands = {}, {}
    local function add(g)
        local gg, am = asGame(g)
        if gg and not seen[gg] then seen[gg] = true; cands[#cands + 1] = {g = gg, am = am} end
    end
    for _, c in ipairs(want.get_game) do
        if c.src:find("GameJoin", 1, true) then
            local ok, g = pcall(c.f)
            if ok then add(g) end
        end
    end
    if #cands == 0 then
        for _, c in ipairs(want.update_input) do
            if c.src:find("GameLocal", 1, true) then
                for _, v in pairs(G.ups(c.f)) do add(v) end
            end
        end
    end
    return G.choose(cands)
end

local function refreshKeys()
    local cfg  = RepS:FindFirstChild("Configuration")
    local kb   = cfg and cfg:FindFirstChild("Keybinds")
    local upv  = cfg and cfg:FindFirstChild("LaneUpscroll")
    local flip = upv and upv.Value == true
    for lane = 1, 4 do
        local key = DEFAULT_KEYS[lane]
        local v = kb and kb:FindFirstChild("Track" .. (flip and (5 - lane) or lane))
        if v then
            local ok, kc = pcall(function() return Enum.KeyCode[v.Value] end)
            if ok and kc and kc ~= Enum.KeyCode.Unknown then key = kc end
        end
        KEYS[lane] = key
    end
end

function G.attach(c)
    releaseAll()
    G.g, G.am = c.g, c.am
    G.sm = c.g._score_manager
    G.ts = c.g:get_local_tracksystem()
    G.fails, G.done, G.suspect = 0, false, false
    G.steps, G.lastClock = {}, nil
    local am = G.am
    G.pre   = am:get_song_length_ms() - am:get_song_time_length() * 1000
    G.rate  = am:get_song_rate()
    G.clock = am:get_current_time_ms()
    refreshKeys()
    hResetRun()
    songStartTick = tick() - math.max(0, G.clock - G.pre) / 1000 / G.rate
    htSeen = #G.sm:get_hit_table()
    pcall(scanChart)
end

function G.drop()
    releaseAll()
    G.g, G.am, G.sm, G.ts = nil, nil, nil, nil
    G.mode, G.suspect = 0, false
end

function G.find()
    if G.scanning or not getgc then return end
    G.scanning = true
    task.spawn(function()
        local ok, c = pcall(G.findInner)
        G.scanning = false
        if ok and c then
            G.attach(c)
        else
            G.fails = G.fails + 1
            if not ok then warn("[rosu!mania] game scan failed: " .. tostring(c)) end
        end
    end)
end

-- runs every frame, cheap. true = theres a live game to play
local function gameTick(now)
    local ga  = SoundService:FindFirstChild("GameAudio")
    local bgm = ga and ga:FindFirstChild("BGM") or nil
    if bgm ~= G.bgm then
        G.bgm = bgm
        G.fails, G.lastScan = 0, -math.huge
        if G.g then
            if G.done then G.drop() else G.suspect = true; G.suspectT = now end
        end
    end
    if G.g then
        local ok, m = pcall(G.am.get_current_mode, G.am)
        if not ok then G.drop(); return false end
        G.mode = m
        return true
    end
    local gap = (G.fails >= 3) and 6 or 1.2
    if bgm and not G.scanning and now - G.lastScan >= gap then
        G.lastScan = now
        G.find()
    end
    return false
end

-- ---- tile lights ----
-- the mobile tiles are MobilePanel.Tap1..4. a real touch sets BackgroundTransparency to 0.9 and
-- back to 0.95 when the finger leaves, so thats what this does. perfect mode skips the lighting
local function getTile(lane)
    local mp = G.panel
    if not (mp and mp.Parent) then
        mp = v5.PlayerGui:FindFirstChild("MobilePanel", true)
        G.panel = mp
    end
    if not mp then return nil end
    local cfg = RepS:FindFirstChild("Configuration")
    local upv = cfg and cfg:FindFirstChild("LaneUpscroll")
    return mp:FindFirstChild("Tap" .. ((upv and upv.Value == true) and (5 - lane) or lane))
end

lightTile = function(lane, lit)
    if not tileLights then return end
    if lit and perfected then return end
    pcall(function()
        local t = getTile(lane)
        if t then t.BackgroundTransparency = lit and tileLit or 0.95 end
    end)
end

-- ---- press layer ----
-- vim = fake key event, the game polls IsKeyDown every frame and sees it a frame or so later.
-- direct (firesignal in the dropdown) = hands the press straight to the game's own track function,
-- same code the keyboard ends up in, so the judged timing is exactly what we polled
-- the game's own press hits EVERY note of the lane that sits inside the hit window, so two notes
-- ~100ms apart in one lane both get eaten by one press (the 2nd as a worse judgment, or a miss if
-- its 130-170ms away). when that would happen the direct route hits just the note it aimed at
local function directPress(lane, note)
    local ts, g = G.ts, G.g
    local crowded = false
    if note then
        for _, o in ipairs(ts._active_notes) do
            if o ~= note and not pfDone[o] and o:get_track_index() == lane then
                local ok, hit = pcall(o.test_hit, o, g)
                if ok and hit then crowded = true; break end
            end
        end
    end
    if not crowded then ts:press_track_index(g, lane); return end
    ts:get_track(lane):press()
    local hit, res, d = note:test_hit(g)
    if hit then note:on_hit(g, res, 0, d) end
end

local function sendDown(lane, note)
    if FS.route == "direct" and G.ts then
        local ok = pcall(directPress, lane, note)
        if ok then return "direct" end
    end
    VIM:SendKeyEvent(true, KEYS[lane], false, game)
    return "vim"
end

local function sendUp(lane, via)
    if via == "direct" then
        if G.ts then pcall(G.ts.release_track_index, G.ts, G.g, lane) end
    else
        VIM:SendKeyEvent(false, KEYS[lane], false, game)
    end
end

local function keyDown(lane, note)
    if not lanePressed[lane] then
        lanePressed[lane] = true
        FS.via[lane] = sendDown(lane, note)
        lightTile(lane, true)
    end
end

local function keyUp(lane)
    if lanePressed[lane] then
        lanePressed[lane] = false
        sendUp(lane, FS.via[lane])
        FS.via[lane] = nil
        lightTile(lane, false)
    end
end

local function stopHold(lane)
    laneHold[lane] = nil
    keyUp(lane)
end

local function tapKey(lane, dur, note)
    keyUp(lane); keyDown(lane, note)
    pressSeq[lane] = pressSeq[lane] + 1
    local mine = pressSeq[lane]
    task.delay(dur, function()
        -- only the newest press on a lane gets to let go, so an old tap cant cut a hold or a newer tap short
        if pressSeq[lane] == mine then keyUp(lane) end
    end)
end

releaseAll = function()
    for i = 1, 4 do
        laneHold[i] = nil
        keyUp(i)
    end
end

-- ---- watchdog ----
-- a press that really landed leaves a hit (not a miss) in the game's hit table. if a route keeps
-- not landing any, it flips to the other one and says so
local function hitsSince(n0)
    local ht = G.sm:get_hit_table()
    for i = n0 + 1, #ht do
        local h = ht[i]
        if h and h.note_result and h.note_result > 0 then return true end
    end
    return false
end

function FS.switch()
    local from = FS.route
    FS.tried[from] = true
    local to = (from == "vim") and "direct" or "vim"
    FS.failN, FS.watch = 0, {}
    if FS.tried[to] then
        FS.dead = true
        window:Notification({Title = "press method", Text = "neither press method is landing hits, run the diagnostics button and send the report", Duration = 6})
        return
    end
    releaseAll()
    FS.route = to
    alReset("hunt")
    FS.quiet = true
    pcall(function() FS.picker:SetValue(to == "direct" and "firesignal" or "VirtualInputManager") end)
    FS.quiet = false
    window:Notification({Title = "press method", Text = from .. " isn't landing hits here, switched to " .. to, Duration = 5})
end

function FS.watchAdd(lane, now, n0)
    if FS.dead or not G.sm then return end
    -- a fast jack can eat the next press (the game hits every note of a lane inside the window), dont judge those
    local last = FS.lastLane[lane] or -1
    FS.lastLane[lane] = now
    if now - last < 0.3 then return end
    if #FS.watch < 8 then FS.watch[#FS.watch + 1] = {t = now, n0 = n0} end
end

function FS.watchStep(now)
    local i = 1
    while i <= #FS.watch do
        local w = FS.watch[i]
        if now - w.t >= 0.2 then
            table.remove(FS.watch, i)
            if hitsSince(w.n0) then FS.failN = 0; FS.okN = FS.okN + 1 else FS.failN = FS.failN + 1 end
        else
            i = i + 1
        end
    end
    if FS.failN >= 4 and not FS.dead then FS.switch() end
end

-- reads the hit table for the judged delta of our presses, feeds auto latency
local function alFeed(now)
    local ht = G.sm:get_hit_table()
    local n = #ht
    if n < htSeen then htSeen = n end
    for i = htSeen + 1, n do
        local h = ht[i]
        if h and not h.is_held_tail then
            for k = 1, #pend do
                local p = pend[k]
                if p.lane == h.lane_index and math.abs(h.hit_time_ms - p.hitAt) < 50 then
                    -- tap delta is hit - clock (+ early), a hold head is clock - hit, so flip that one
                    local j = h.is_held and -h.time_to_end or h.time_to_end
                    alSample(j - p.tgt)
                    table.remove(pend, k)
                    break
                end
            end
        end
    end
    htSeen = n
    local k = 1
    while k <= #pend do
        if now - pend[k].t > 1 then table.remove(pend, k) else k = k + 1 end
    end
end

-- delta the game would judge a press with right now, in chart ms, + = early. holds flip the sign
local function noteEarly(n)
    local ok, _, _, d = pcall(n.test_hit, n, G.g)
    if not ok or type(d) ~= "number" or d == 5000 then return nil end   -- 5000 = a hold thats already being held
    if n.Type == "HeldNote" then return -d end
    return d
end


-- ---- judgment bands ----
-- the game's own windows (ms off the hit). the band the error lands in IS the rating
local JUDGE = {px = 20, perf = 43, great = 76, good = 106, bad = 130}

-- random point INSIDE the rating's band, not just its edge
local function randomOffsetForRating(rating)
    if rating == "px"    then return math.random() * math.max(4, JUDGE.px - math.min(8, G.step / G.rate / 2)) end   -- a frame can land half a frame off, so stay clear of the edge
    if rating == "perf"  then return JUDGE.px    + math.random() * (JUDGE.perf  - JUDGE.px)    end
    if rating == "great" then return JUDGE.perf  + math.random() * (JUDGE.great - JUDGE.perf)  end
    if rating == "good"  then return JUDGE.great + math.random() * (JUDGE.good  - JUDGE.great) end
    if rating == "bad"   then return JUDGE.good  + math.random() * (JUDGE.bad   - JUDGE.good)  end
    return 0
end

local function pickRating()
    local pool = {}
    for _ = 1, pxChance    do pool[#pool + 1] = "px"    end
    for _ = 1, perfChance  do pool[#pool + 1] = "perf"  end
    for _ = 1, greatChance do pool[#pool + 1] = "great" end
    for _ = 1, goodChance  do pool[#pool + 1] = "good"  end
    for _ = 1, badChance   do pool[#pool + 1] = "bad"   end
    for _ = 1, missChance  do pool[#pool + 1] = "miss"  end
    if #pool == 0 then return "px" end
    return pool[math.random(1, #pool)]
end

-- flawless preset: the humanize engine runs like normal (noise, drift, tilt, chords, taps, holds,
-- all of it) and THEN every error gets squeezed into a safe slice of the perfectx window. a frame
-- can land half a frame off the target, so the slice shrinks when the fps does. slips and drops
-- turn into an edge-of-the-window hit instead of a miss, so it stays human but never leaves 100%
local function flawlessBand()
    return math.clamp(JUDGE.px - (G.step / G.rate) / 2 - 5, 2, 12)
end

local function flawlessLimit(e)
    local band = flawlessBand()
    local x = math.clamp(e / band, -20, 20)
    local ex = math.exp(2 * x)
    return band * (ex - 1) / (ex + 1)   -- tanh by hand, squashes big errors instead of piling them on the edge
end

-- how far past the target a frame is allowed to press. half a frame normally, more when the
-- frames come uneven so one long frame cant throw the hit out of the window. tgt in chart ms
local function flawlessSlack(tgt)
    local pxC = JUDGE.px * G.rate
    local lo = math.max(G.step / 2, G.stepHi - pxC + 4 - tgt)
    local hi = pxC - 4 - tgt
    return math.max(1, math.min(lo, hi))
end

-- ---- humanize engine ----
-- the player decides an error for every note BEFORE it lands (ms, + = late, - = early) and the
-- hands (further down) press at exactly that moment. every layer is its own switch on the advanced tab
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

-- fresh start for the player: runs on every song start, so every attempt gets its own lean, habits and warm-up
hResetRun = function()
    songStartTick  = tick()
    streakState    = 0
    table.clear(kpsLog)
    table.clear(pend)
    personalBiasMs = gaussianRandom() * 2.5
    for i = 1, 4 do hLaneBias[i] = gaussianRandom() * 2.2 end
    hChordDir = (math.random() < 0.5) and 1 or -1
    hDrift, hFocus, hTilt = 0, 0, 0
    hLastNoise, hLastNoiseT, hLastT = 0, 0, nil
    for i = 1, 4 do hLaneHit[i] = -math.huge end
    hAnyHit = -math.huge
    table.clear(hHitHist)
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
    if missed and not hFlawless then return nil, sigma end

    if not hEarlyHits then e = math.abs(e) end
    if hFlawless then return flawlessLimit(e), sigma end
    return math.clamp(e, -110, 125), sigma
end

-- ---- the player's hands ----
-- each note gets decided ONCE, ahead of time (hDecide), then pressed on the frame that lands
-- closest to the error it was given. everything runs on the game's own judged delta (test_hit),
-- so scroll speed, sv and song rate dont matter
local function humanTapDur(gapNext, density)
    -- a real tap is 40 to 90ms down, quicker when the notes come quicker, and it cant be longer than the gap to the next note in the lane
    local d = 0.055 * (0.75 + 0.6*math.random()) / (1 + 0.02*(density or 0))
    return math.clamp(d, 0.025, math.max(0.025, (gapNext or 1) * 0.6))
end

local function tapDurFor(gapNext, density)
    if humanize and hHumanTaps and not perfected then return humanTapDur(gapNext, density) end
    return math.clamp((gapNext or 1) * 0.5, 0.02, TAP_DUR)
end

-- how a hold gets let go (offset from the tail in ms, + = late). normally a little after, never on
-- the exact frame. every so often too soon, which breaks it (yes on purpose)
local function hHoldPlan(note, now)
    local plan = {note = note, t0 = now, relOff = 0}
    if humanize and not perfected and hHumanHolds then
        plan.relOff = math.clamp(35 + gaussianRandom() * 30, 0, 120)
        if hFlawless then plan.relOff = math.clamp(4 + gaussianRandom() * 7, -6, 18) end   -- stays well inside the release window
        if hAllowRealMiss and hSlips and not hFlawless then
            local p = (hMistakes / 100) * 0.02 * (1 + (100 - hAccuracy) / 40)
            if hTiltOn then p = p * (1 + 1.5 * hTilt) end
            if math.random() < math.min(0.25, p) then
                plan.dropFrac = 0.15 + math.random() * 0.7
                if hTiltOn then hTilt = math.min(2, hTilt + 0.5) end
            end
        end
    end
    return plan
end

-- lets go of a hold when its plan says so. the tail time comes from the game (test_release gives
-- clock - tail). on vim the head lands a frame or two after the press, so a hold that isnt
-- holding yet gets a moment before the bot gives up on it
local function holdTick(lane, now)
    local hp = laneHold[lane]
    if not hp then return end
    local n = hp.note
    local ok, _, _, d = pcall(n.test_release, n, G.g)
    if not ok or type(d) ~= "number" then
        if now - hp.t0 > 0.25 then stopHold(lane) end
        return
    end
    if not hp.d0 then hp.d0 = d; hp.len = math.max(1, -d) end
    local want = hp.relOff * G.rate
    local drop = hp.dropFrac and (d - hp.d0) >= hp.dropFrac * hp.len
    if drop or d + curLat() >= want - G.step / 2 or now - hp.t0 > 25 then stopHold(lane) end
end

-- one note, one press. e = the error it was planned with (ms, + late), 0 for perfect mode
local function pressNote(lane, it, e, gapNext, density, now)
    if laneHold[lane] then stopHold(lane) end
    local n0 = G.sm and #G.sm:get_hit_table() or 0   -- counted BEFORE the press, a direct press lands instantly
    pend[#pend + 1] = {lane = lane, t = now, tgt = -e * G.rate, hitAt = G.clock + it.early}
    if #pend > 24 then table.remove(pend, 1) end
    if it.kind == "HeldNote" then
        keyUp(lane); keyDown(lane, it.note)
        pressSeq[lane] = pressSeq[lane] + 1
        laneHold[lane] = hHoldPlan(it.note, now)
    else
        tapKey(lane, tapDurFor(gapNext, density), it.note)
    end
    if math.abs(e * G.rate) <= 60 then FS.watchAdd(lane, now, n0) end
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

    if hFlawless then
        for k = 1, size do es[k] = flawlessLimit(es[k] or (gaussianRandom() * 4)) end
    end

    if missJacks and not hFlawless then
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

local function humanHands(lanes, all, now)
    local dtHalf = G.step / 2
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
                if not hPlan[all[j].note] and not pfDone[all[j].note] then group[#group + 1] = all[j] end
                j = j + 1
            end
            hPlanGroup(group, all, now)
            i = j
        end
    end

    local lt = curLat()
    for lane = 1, 4 do
        local list = lanes[lane]
        local k, pressed = 1, 0
        while k <= #list and pressed < 4 do
            local it = list[k]
            if pfDone[it.note] then
                k = k + 1
            else
                local p = hPlan[it.note]
                if not p then break end
                local tgt = -p.e * G.rate
                if it.early <= tgt + lt + (hFlawless and flawlessSlack(tgt) or dtHalf) then
                    pfDone[it.note] = true
                    local nxt = nil
                    for m = k + 1, #list do
                        if not pfDone[list[m].note] then nxt = list[m]; break end
                    end
                    pressNote(lane, it, p.e, nxt and (nxt.rem - it.rem) or 1, p.density, now)
                    pressed = pressed + 1
                    k = k + 1
                else
                    break
                end
            end
        end
    end
end

-- ---- perfect mode ----
-- the "actual bot" mode, overrides humanize, hit chances, miss jacks and the tile glow. every
-- frame it reads the judged delta of each lane's next note and presses on the frame that lands
-- closest to zero. a frame can only land every ~16ms, so it presses once the NEXT frame would
-- overshoot (half a frame, or more when frames are uneven, never past the perfectx window)
local function perfectHands(lanes, now)
    local thr = math.clamp(math.max(G.step / 2, G.stepHi - 18), 3, 18) + curLat()
    for lane = 1, 4 do
        local list = lanes[lane]
        local it = list[1]
        if it and it.early <= thr then
            pfDone[it.note] = true
            pressNote(lane, it, 0, list[2] and (list[2].rem - it.rem) or 1, 0, now)
        end
    end
end

-- ---- difficulty scanner ----
-- reads the chart straight from the game (the same HitObjects the game spawns notes from) the
-- moment a song attaches. it never touches the hitting
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

scanChart = function()
    local ok, ad = pcall(function() return G.am:get_audio_data() end)
    if not ok or type(ad) ~= "table" or type(ad.HitObjects) ~= "table" then return end
    local notes = {}
    for _, h in ipairs(ad.HitObjects) do
        if type(h) == "table" and type(h.Time) == "number" and type(h.Track) == "number" then
            notes[#notes + 1] = {t = h.Time / 1000, lane = h.Track}
        end
    end
    if #notes < 2 then return end
    table.sort(notes, function(a, b) return a.t < b.t end)

    -- simple strain score per 1s bucket, extra weight for jacks (same lane firing fast) and chords
    local lastLaneT, strainAt = {}, {}
    for i, n in ipairs(notes) do
        local strain = 1.0
        local lastT = lastLaneT[n.lane]
        if lastT and (n.t - lastT) < 0.25 then strain = strain + (0.25 - (n.t - lastT)) * 12 end
        lastLaneT[n.lane] = n.t
        local prev = notes[i - 1]
        if prev and (n.t - prev.t) < 0.015 and prev.lane ~= n.lane then strain = strain + 1.5 end
        local bucket = math.floor(n.t)
        strainAt[bucket] = (strainAt[bucket] or 0) + strain
    end

    local buckets = {}
    for b, s in pairs(strainAt) do buckets[#buckets + 1] = {b = b, s = s} end
    table.sort(buckets, function(a, b) return a.s > b.s end)

    local spikes, usedTimes = {}, {}
    for _, entry in ipairs(buckets) do
        local tSec, tooClose = entry.b, false
        for _, u in ipairs(usedTimes) do
            if math.abs(u - tSec) < 4 then tooClose = true; break end
        end
        if not tooClose then
            spikes[#spikes + 1] = {t = tSec, strain = entry.s}
            usedTimes[#usedTimes + 1] = tSec
        end
        if #spikes >= 3 then break end
    end

    lastScanResult = {totalSeconds = notes[#notes].t, noteCount = #notes, spikes = spikes}
    if hAutoScan and not perfected then
        window:Notification({Title = "song scanned", Text = buildScanMessage(lastScanResult), Duration = 5})
    end
end

chartIsInSpikeWindow = function()
    if not (lastScanResult and lastScanResult.spikes) then return false end
    local now = (G.clock - G.pre) / 1000
    for _, sp in ipairs(lastScanResult.spikes) do
        if math.abs(now - sp.t) < 1.5 then return true end
    end
    return false
end

-- ---- main loop ----
-- bound AFTER the game's own render steps (its input is at 101, its update at 199), so every frame
-- we read the notes exactly as that frame's update left them, and a direct press is judged with
-- the very delta we just read
local function frame(dt)
    if not v8 then return end
    local now = tick()
    if not gameTick(now) then return end
    if G.mode >= 5 then
        if not G.done then G.done = true; releaseAll() end
        return
    end
    local am = G.am
    local clock = am:get_current_time_ms()
    if G.lastClock and clock == G.lastClock then
        -- clock frozen: paused, or a leftover game from the last song
        if G.suspect and now - G.suspectT > 0.5 then G.drop() end
        return
    end
    G.suspect = false
    if G.lastClock then
        local s = clock - G.lastClock
        if s > 0 and s < 120 then
            local st = G.steps
            st[#st + 1] = s
            if #st > 24 then table.remove(st, 1) end
            local sorted, hi = {}, 0
            for _, v in ipairs(st) do sorted[#sorted + 1] = v end
            table.sort(sorted)
            G.step = sorted[math.ceil(#sorted / 2)]
            for k = math.max(1, #st - 11), #st do hi = math.max(hi, st[k]) end
            G.stepHi = math.min(hi, 60)
        end
    end
    G.lastClock, G.clock = clock, clock
    G.rate = am:get_song_rate()

    alFeed(now)
    FS.watchStep(now)
    if not G.g then return end

    local lanes, all = {{}, {}, {}, {}}, {}
    for _, n in ipairs(G.ts._active_notes) do
        if not pfDone[n] then
            local e = noteEarly(n)
            if e then
                if e < -125 then
                    pfDone[n] = true     -- too late to hit, the game handles the miss
                elseif e < 1000 * G.rate then
                    local lane = n:get_track_index()
                    if lanes[lane] then
                        local it = {note = n, lane = lane, early = e, rem = e / 1000 / G.rate, kind = n.Type}
                        lanes[lane][#lanes[lane] + 1] = it
                        all[#all + 1] = it
                    end
                end
            end
        end
    end
    for l = 1, 4 do table.sort(lanes[l], function(a, b) return a.early < b.early end) end
    table.sort(all, function(a, b) return a.early < b.early end)

    for l = 1, 4 do holdTick(l, now) end
    if perfected then perfectHands(lanes, now) else humanHands(lanes, all, now) end
end

local function stopLoop()
    if not looping then return end
    looping = false
    pcall(function() RunService:UnbindFromRenderStep(STEP_NAME) end)
    releaseAll()
end

local function startLoop()
    stopLoop()
    refreshKeys()
    looping = true
    RunService:BindToRenderStep(STEP_NAME, Enum.RenderPriority.Last.Value, function(dt)
        local ok, err = pcall(frame, dt)
        if not ok then
            local t = tick()
            if t - G.lastErr > 2 then G.lastErr = t; warn("[rosu!mania] loop error: " .. tostring(err)) end
        end
    end)
end

-- ---- diagnostics ----
-- a report on this executor + the game it found. goes to the console and the clipboard so i can
-- paste it to whoever is helping me. read only, it never presses anything
function FS.report()
    local out = {}
    local function P(...)
        local t = {}
        for i = 1, select("#", ...) do t[#t + 1] = tostring((select(i, ...))) end
        out[#out + 1] = table.concat(t, " ")
    end
    P("rosu!mania botplay " .. VERSION, "| executor", identifyexecutor and identifyexecutor() or "?")
    P("caps: getgc", getgc ~= nil, "debug.info", debug and debug.info ~= nil, "getupvalues", ((debug and debug.getupvalues) or getupvalues) ~= nil, "setclipboard", setclipboard ~= nil, "touch", UIS.TouchEnabled)
    P("route", FS.route, "dead", FS.dead, "tried vim/direct", FS.tried.vim == true, FS.tried.direct == true, "watch ok/fail", FS.okN, FS.failN)
    P("lat vim", f2(lat.vim), "direct", f2(lat.direct), "phase", alPhase, "auto", autoLatency, "| frame step", f2(G.step), "hi", f2(G.stepHi))
    local ks = {}
    for i = 1, 4 do ks[i] = KEYS[i].Name end
    P("keys", table.concat(ks, " "), "| mode flags: enabled", v8, "perfect", perfected, "humanize", humanize)
    local cfg = RepS:FindFirstChild("Configuration")
    if cfg then
        local a = {}
        for _, c in ipairs(cfg:GetChildren()) do
            if c:IsA("ValueBase") then a[#a + 1] = c.Name .. "=" .. tostring(c.Value) end
        end
        table.sort(a)
        P("config:", table.concat(a, " "))
    end
    local ga = SoundService:FindFirstChild("GameAudio")
    P("bgm sound", (ga and ga:FindFirstChild("BGM")) ~= nil, "| scanning", G.scanning, "scan fails", G.fails)
    if G.g then
        local am, sm, ts = G.am, G.sm, G.ts
        P("game found. mode", G.mode, "clock", f2(am:get_current_time_ms()), "prebuffer", f2(am:get_note_prebuffer_time_ms()), "rate", f2(am:get_song_rate()), "pre", f2(G.pre))
        P("windows px/p/gr/go/bad/miss:", am.NOTE_PERFECTX_MAX, am.NOTE_PERFECT_MAX, am.NOTE_GREAT_MAX, am.NOTE_GOOD_MAX, am.NOTE_BAD_MAX, am.NOTE_MISS_MAX)
        P("results px,p,gr,go,bad,miss:", sm:get_noteresults())
        P("active notes", #ts._active_notes, "| hit table rows", #sm:get_hit_table())
        for i, n in ipairs(ts._active_notes) do
            if i > 5 then break end
            local ok, hit, res, d = pcall(n.test_hit, n, G.g)
            P("  note", i, n.Type, "lane", n:get_track_index(), "hit", hit, "res", res, "delta", f2(d))
        end
        local ht = sm:get_hit_table()
        for i = math.max(1, #ht - 4), #ht do
            local h = ht[i]
            P("  last hit:", "res", h.note_result, "delta", f2(h.time_to_end), "lane", h.lane_index, "held", h.is_held, "tail", h.is_held_tail)
        end
    else
        P("no live game found (start a song with the bot enabled)")
    end
    local text = table.concat(out, "\n")
    local copied = false
    if type(setclipboard) == "function" then copied = pcall(setclipboard, text) end
    print(text)
    return text, copied
end


-- ---- ui which looks amazing btw ----
local infoTab = window:AddTab("InfoTab", {Text="info",        Icon="info"    })
local playTab = window:AddTab("PlayTab", {Text="botplay",     Icon="play"    })
local advTab  = window:AddTab("AdvTab",  {Text="advanced bp", Icon="sparkles"})

-- ?? info tab ??
local iL = infoTab:AddLeftGroupbox("IL",  {Text="about"       })
local iR = infoTab:AddRightGroupbox("IR", {Text="feature list" })

iL:AddLabel("IL1",{Text="<font color='#C41E3A'><b>rosu!mania botplay</b></font> by woops &lt;3\n\nplays rosu!mania for you, automatically.\nhumanize makes it look genuinely played. perfect mode is there too for a true 100% instead.\nauto latency figures out the right timing on its own after a few notes."})
iL:AddSeparator("ILS1",{})
iL:AddLabel("IL2",{Text="<font color='#D0D0D6'><b>recommended setup:</b></font>\n• humanize (advanced bp tab) → on, for a run that looks genuinely played\n• perfect mode → on instead for a true 100%. it overrides everything else while it's on\n• auto latency → on"})
iL:AddSeparator("ILS2",{})
iL:AddLabel("IL3",{Text="<b>right shift</b> = open / close the menu"})

iR:AddLabel("IR1",{Text="<font color='#C41E3A'><b>botplay tab</b></font>"})
iR:AddLabel("IR2",{Text="enable → turns botplay on or off\nperfect mode → a true 100%, presses every note on the frame closest to the hit. overrides everything else while it's on\npress method → VirtualInputManager is the normal way. firesignal hands the press straight to the game's own track function instead, so there's no input lag. if a method isn't landing hits it switches to the other one on its own\ndiagnostics → a report on your executor and the game, copied to your clipboard\ntile lights → lights up the on-screen tiles when the bot presses, just for looks\nmiss jacks → skips super-fast repeat notes so it doesn't stumble\nauto latency → reads the game's own hit log and adjusts itself, no setup needed\nvim latency → a manual timing offset, only used when auto latency is off\nhit chances → weights, not percentages, only used while humanize is off"})
iR:AddSeparator("IRS1",{})
iR:AddLabel("IR3",{Text="<font color='#D0D0D6'><b>advanced bp tab</b></font>"})
iR:AddLabel("IR3B",{Text="humanize → plays with realistic, human-like timing instead of frame-perfect inputs. every part of it is its own switch, so mix and match\nskill preset, accuracy, consistency, mistakes → how good, and how steady, this 'player' is\nflawless preset → still humanized, but every hit stays perfectx so it's always 100%\ndifficulty scanner → points out a song's hardest sections the moment it loads"})
iR:AddSeparator("IRS2",{})
iR:AddLabel("IR5",{Text="<font color='#C41E3A'><b>works with</b></font>\n• any scroll speed and song rate\n• up & down scroll\n• hold notes\n• smooth at high fps, and still keeps up if your fps drops"})

-- ?? botplay tab (where the magic happens) ??
local pL = playTab:AddLeftGroupbox( "PL", {Text="botplay"     })
local pR = playTab:AddRightGroupbox("PR", {Text="hit chances" })
local manualLat = 16

pL:AddToggle("Enable",{
    Text="enable", Value=false,
    Tooltip="turns botplay on or off",
    Callback=function(val)
        v8 = val
        if v8 then
            releaseAll()
            FS.dead, FS.failN, FS.tried = false, 0, {}
            alReset("hunt")
            startLoop()
            window:Notification({Title="botplay",Text="<font color='#C41E3A'><b>on</b></font>",Duration=2})
        else
            stopLoop()
            window:Notification({Title="botplay",Text="off",Duration=2})
        end
    end,
})

pL:AddToggle("Perfected",{
    Text="perfect mode", Value=false,
    Tooltip="a true 100%. presses every note on the frame closest to the hit and overrides humanize, hit chances, miss jacks and tile lights until you turn it off",
    Callback=function(val)
        perfected = val
        releaseAll()
        window:Notification({Title="perfect mode",Text=val and "<font color='#C41E3A'>on</font>, overriding everything else" or "off, everything else is back",Duration=3})
    end,
})

FS.picker = pL:AddDropdown("PressMethod",{
    Text="press method", Values={"VirtualInputManager","firesignal"}, Value=1,
    Tooltip="VirtualInputManager is the normal way. firesignal hands the press straight to the game's own track function, so there's no input lag and the timing stays steadier. if a method isn't landing hits it switches to the other one on its own",
    Callback=function(val)
        if FS.quiet then return end
        local pick = (type(val) == "number") and ({"VirtualInputManager","firesignal"})[val] or val
        local to = (pick == "firesignal") and "direct" or "vim"
        FS.tried, FS.dead, FS.failN, FS.watch = {}, false, 0, {}
        if to == FS.route then return end
        releaseAll()
        FS.route = to
        alReset("hunt")
        window:Notification({Title="press method",Text=(to == "direct") and "<font color='#C41E3A'>firesignal</font>, presses go straight to the game" or "back to VirtualInputManager",Duration=3})
    end,
})

pL:AddButton("FireDiag",{
    Text="diagnostics",
    Tooltip="prints a report about your executor and the game to the console and copies it to your clipboard. best pressed in the middle of a song",
    Callback=function()
        window:Notification({Title="diagnostics",Text="running, give it a second",Duration=2})
        task.spawn(function()
            local ok, _, copied = pcall(FS.report)
            window:Notification({Title="diagnostics",Text=ok and ("report is in the console"..(copied and " and copied to your clipboard" or "")) or "the report errored, check the console",Duration=6})
        end)
    end,
})

pL:AddToggle("TileLights",{
    Text="tile lights", Value=false,
    Tooltip="lights up the on-screen tiles when the bot presses, just for looks. ignored in perfect mode",
    Callback=function(val)
        tileLights = val
        if not val then for i = 1, 4 do lightTile(i, false) end end
        window:Notification({Title="tile lights",Text=val and "<font color='#C41E3A'>on</font>" or "off",Duration=2})
    end,
})

pL:AddSlider("TileGlow",{
    Text="tile glow", Min=5, Max=70, Value=10, Step=1,
    Tooltip="how bright a lit tile gets. 10 is the same as a real touch, higher shows up better on video",
    Callback=function(v) tileLit = 1 - v / 100 end,
})

pL:AddToggle("MissJacks",{
    Text="miss jack notes", Value=false,
    Tooltip="skips super-fast repeat notes on the same key so it doesn't stumble",
    Callback=function(val) missJacks = val end,
})

pL:AddSeparator("PLS1",{})

pL:AddToggle("AutoLatency",{
    Text="auto latency", Value=true,
    Tooltip="reads the game's own hit log and adjusts the timing itself, just leave it on. only matters for VirtualInputManager",
    Callback=function(val)
        autoLatency = val
        if val then alReset("hunt") else lat.vim = manualLat end
        window:Notification({Title="auto latency",Text=val and "<font color='#C41E3A'>on</font>, adjusting itself" or "off, using manual slider",Duration=3})
    end,
})

pL:AddLabel("TLH",{Text="<font color='#888'>manual mode (auto latency off):\nif the hits come out early (+) lower the slider  •  if they come out late (-) raise it</font>"})

pL:AddSlider("VimLatency",{
    Text="vim latency (ms)", Min=0, Max=120, Value=16, Step=1,
    Tooltip="how late the game sees a VirtualInputManager press. higher = the bot presses earlier to make up for it. only used while auto latency is off",
    Callback=function(v) manualLat = v; if not autoLatency then lat.vim = v end end,
})

pR:AddLabel("TRH",{Text="<font color='#D0D0D6'><b>these are weights, not percentages.</b></font>\nleave them all at 0 for perfect hits every time.\nlocked automatically while humanize (advanced bp tab) is on."})
pR:AddSeparator("TRS",{})
pR:AddSlider("PC",{Text="perfectx",Min=0,Max=100,Value=100,Step=1,Tooltip="0-20ms",    Callback=function(v) if not humanize then pxChance=v end end})
pR:AddSlider("SC",{Text="perfect", Min=0,Max=100,Value=0,  Step=1,Tooltip="20-43ms",   Callback=function(v) if not humanize then perfChance=v end end})
pR:AddSlider("GC",{Text="great",   Min=0,Max=100,Value=0,  Step=1,Tooltip="43-76ms",   Callback=function(v) if not humanize then greatChance=v end end})
pR:AddSlider("OC",{Text="good",    Min=0,Max=100,Value=0,  Step=1,Tooltip="76-106ms",  Callback=function(v) if not humanize then goodChance=v end end})
pR:AddSlider("BC",{Text="bad",     Min=0,Max=100,Value=0,  Step=1,Tooltip="106-130ms", Callback=function(v) if not humanize then badChance=v end end})
pR:AddSlider("MC",{Text="miss",    Min=0,Max=100,Value=0,  Step=1,                     Callback=function(v) if not humanize then missChance=v end end})

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

local presetNames = {"custom","casual","average","skilled","pro","elite","flawless"}
local presets = {
    casual  = {acc=55, cons=40, mist=70},
    average = {acc=72, cons=55, mist=50},
    skilled = {acc=86, cons=65, mist=35},
    pro     = {acc=94, cons=78, mist=22},
    elite   = {acc=98, cons=88, mist=10},
    flawless = {acc=100, cons=100, mist=0},
}
local accSlider, consSlider, mistSlider

aL:AddDropdown("SkillPreset",{
    Text="skill preset", Values=presetNames, Value=1,
    Tooltip="one tap setups for accuracy, consistency and mistakes. 'custom' leaves the sliders alone. 'flawless' keeps everything humanized but never lets a hit leave perfectx, so it's always a 100% run. on firesignal that holds on any chart, on VirtualInputManager the game can still eat super close same-key notes",
    Callback=function(val)
        local name = (type(val)=="number") and presetNames[val] or val
        local wasFlawless = hFlawless
        hFlawless = (name == "flawless")
        if hFlawless ~= wasFlawless then
            window:Notification({Title="skill preset",Text=hFlawless and "<font color='#C41E3A'>flawless</font>, still humanized but every hit stays perfectx" or "flawless off",Duration=3})
        end
        local p = presets[name]
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

