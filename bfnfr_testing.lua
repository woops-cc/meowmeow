-- ── loading the ui library ──
-- the loader makes its own network request after it downloads, and that can
-- fail or time out, so give it a couple of tries before giving up. the second
-- link is the same file with a different url shape
local LIBRARY_URLS = {
    "https://raw.githubusercontent.com/woops-cc/meowmeow/refs/heads/main/Loader_testing.lua",
    "https://raw.githubusercontent.com/woops-cc/meowmeow/main/Loader_testing.lua",
}

local function loadLibrary()
    local lastErr = "nothing ran"
    for attempt = 1, 2 do
        for i, url in ipairs(LIBRARY_URLS) do
            local ok, res = pcall(function()
                return loadstring(game:HttpGet(url, true))()
            end)
            if ok and res then return res end
            lastErr = tostring(res)
            warn(("[bfnf:r] ui library try %d.%d failed: %s"):format(attempt, i, lastErr))
        end
        if attempt < 2 then task.wait(1.5) end
    end
    warn("[bfnf:r] couldn't load the ui library: " .. lastErr)
    return nil
end

local lib = loadLibrary()
if not lib then return end

-- every ui call goes through guard(), so one element failing (a library
-- change, a bad option) only costs that element instead of the whole ui, and
-- the error gets printed so it can be fixed
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

local VERSION = "v3.3.1-beta"  -- bump this each update, it shows in the footer

-- ── palette (galaxy collapse: crimson, ink black & white) ──
local C_RED   = Color3.fromRGB(196, 30,  58)     -- crimson   #C41E3A
local C_STEEL = Color3.fromRGB(208, 208, 214)    -- pale grey #D0D0D6
local C_BG    = Color3.fromRGB(10,  10,  12)     -- near-black bg
local C_WHITE = Color3.fromRGB(232, 232, 236)    -- soft white text

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

-- try the full window first. if the library chokes on something, retry
-- without the image and blur extras, then with the bare minimum
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

-- image fix: mirror Image into ImageContent once the window has built
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
local Players      = game:GetService("Players")
local v5           = Players.LocalPlayer

-- ════════════════════════════════════════════════════════════
-- timing & auto latency notes
-- ────────────────────────────────────────────────────────────
-- perfect window:  |scale| <= 0.71775 * spd
-- trigger formula: (0.71775 - latMs/1000 * 5.5) * spd
--
-- auto latency (proportional controller on the median):
--   NO integral term (when i tested it was causing overshooting and stuffs)
--   uses the MEDIAN of the last 8 readings so hold/miss outliers don't matter
--   hunting: sample on every fresh ms text, correct by median * adaptive gain
--            (big errors correct fast, small ones gently, so it settles
--            instead of ringing around the target)
--            locks after 10 samples in a row with |median| <= 2ms
--   locked:  sample every 1s, correct by median * 0.03 (basically frozen)
--            re-hunts only if |median| > 5ms for 8 samples in a row
--            outlier window tightens once locked (18ms vs 35ms while hunting)
--   stale guard: skip if the msIndic text hasn't changed in the last 0.35s
--   the lock carries over between songs. it's a device/input thing, not a
--   per-song thing, so a new song only clears the sample buffer
-- ════════════════════════════════════════════════════════════
local vimLatencyMs    = 111
local autoLatency     = true
local autoLatencyConn = nil
local alSongWatcher   = nil
local alPhase         = "hunt"

local LOCK_GAIN     = 0.03   -- near-frozen correction when locked
local LOCK_THRESH   = 2.0    -- ms: |median| below this counts as a good sample
local LOCK_N        = 10     -- consecutive good samples to lock
local UNLOCK_THRESH = 5.0    -- ms: |median| above this while locked counts as bad
local UNLOCK_N      = 8      -- consecutive bad samples to re-hunt
local HUNT_INTERVAL = 0.15   -- min seconds between hunt samples
local LOCK_INTERVAL = 1.0    -- seconds between locked samples
local STALE_MAX     = 0.35   -- the ms text must have changed within this
local BUF_SIZE      = 8      -- median buffer size

local alBuf          = {}
local alGoodN        = 0
local alBadN         = 0
local alSavedHitLate = false
local pressLog       = {}   -- recent presses and the error meant for each (the calibration needs it)

local function alReset(phase)
    alBuf={}; alGoodN=0; alBadN=0
    alPhase = phase or "hunt"
end

-- adaptive gain: big errors correct fast, small ones gently, so it doesn't
-- overshoot and oscillate right next to the target
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
        -- first start: remember the real HitLate so stop can restore it
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
            -- a locked calibration is a device/input thing, not a per-song one,
            -- so don't re-hunt from scratch every song (it wasted the first few
            -- seconds of every run). just drop the sample buffer in case some
            -- readings straddled the song boundary, and keep the lock
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
        -- only accept fresh readings (the note was just hit)
        if txt ~= lastText then
            lastText = txt
            lastTextTime = now
        else
            if now - lastTextTime > STALE_MAX then return end
        end

        -- only sample after the interval has passed AND the text is fresh
        if now - lastSample < interval then return end
        lastSample = now

        local val = tonumber(txt:match("(-?%d+%.?%d*)"))
        if not val then return end
        -- the reading includes the error the player meant to make, so take
        -- that back out and only look at what's left, which is the real
        -- latency. one clear press has to line up with it, otherwise skip it
        local nLog = #pressLog
        local lastPress = pressLog[nLog]
        if not lastPress or now - lastPress.t > 0.14 then return end
        if nLog > 1 and lastPress.t - pressLog[nLog-1].t < 0.045 then return end
        val = val + lastPress.e
        -- outlier window: holds/misses give big values we ignore. tighter once
        -- locked, since anything wildly off by then is almost certainly a
        -- hold/miss artifact and not a real correction
        local outlierMax = (alPhase=="locked") and 18 or 35
        if math.abs(val) > outlierMax then return end

        table.insert(alBuf, val)
        if #alBuf > BUF_SIZE then table.remove(alBuf, 1) end
        if #alBuf < 3 then return end  -- need at least 3 for a stable median

        local med = alMedian()

        if alPhase == "hunt" then
            -- proportional with adaptive gain. no integral term so no overshoot,
            -- and the gain shrinks as it nears the target
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

        else  -- locked: near-frozen, tiny drift correction only
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
    -- only put HitLate back if we were the ones who turned it on
    if wasRunning and _G.Settings then _G.Settings.HitLate = alSavedHitLate end
    alReset("hunt")
end

-- ════════════════════════════════════════════════════════════
-- keybinds & state (ill soon js make it automatically get the keys since im lowk lazy and tarded asf)
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
local pressSeq      = {0,0,0,0}   -- bumps on every press, so an old tap timer can't release a newer press

-- simple-mode hit chance weights, only used while humanize (below) is off
local perfectChance = 100
local sickChance    = 0
local goodChance    = 0
local okChance      = 0
local badChance     = 0
local missChance    = 0

-- ════════ advanced bp: humanize state ════════
local humanize         = true   -- master switch
local hAccuracy        = 92     -- 0-100, how tight the timing is
local hConsistency     = 70     -- 0-100, how steady it stays note to note
local hJackFatigue     = true   -- fast same-key repeats get sloppier
local hChordStagger    = true   -- same-beat notes across lanes get a tiny stagger
local hWarmupFatigue   = true   -- shakier at the very start, can drift late-song
local hPersonalBias    = true   -- a small consistent lean, re-rolled each run
local hAllowRealMiss   = true   -- lets it genuinely miss a note or drop a hold now and then
local hMistakes        = 35     -- 0-100, how often it slips
local hLeanMs          = 0      -- manual early/late lean in ms (+ = late)
local hEarlyHits       = true   -- hits can land early as well as late
local hDriftOn         = true   -- the timing average wanders slowly
local hFocusOn         = true   -- attention comes and goes
local hFingerBias      = true   -- each lane has its own small habit
local hSelfCorrect     = true   -- eases the next press after an early or late one
local hStreaks         = true   -- hot and cold streaks
local hRush            = true   -- presses a touch early when the notes get dense
local hColdStart       = true   -- sloppier on the first notes after a break
local hSlips           = true   -- the odd bigger error
local hTiltOn          = true   -- a slip makes the next few worse
local hHumanHolds      = true   -- holds are let go like a person would
local hHumanTaps       = true   -- tap lengths vary and shrink on fast patterns
local fingerSpeedLimit = 100    -- kps, replaces the old hard "legit" cap

local kpsLog          = {}      -- rolling press timestamps, for finger-speed overflow
local streakState     = 0       -- slow "hot/cold streak" driver
local personalBiasMs  = 0       -- rolled once per run
local songStartTick   = 0       -- tick() when the current run started

-- ════════ advanced bp: difficulty scanner state ════════
local hAutoScan            = true    -- popup the scan results when a song starts
local hReactToSpikes       = true    -- humanize loosens up a bit during spikes
local lastScanResult       = nil     -- {totalSeconds=, noteCount=, spikes={ {t=,strain=}, ... }}
local scanHookInstalled    = false
local chartIsInSpikeWindow -- forward declared, defined down in the scanner section

local startLoop  -- forward declared, defined further down (main run loop)

-- ════════════════════════════════════════════════════════════
-- tile lighting thingy for legitimacy and stuffs 😇😇
-- path: MatchFrame.MobileKeys.Left/Down/Up/Right
-- press → transparency 0, release → tween to 0.8
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
    if lit and perfected then return end  -- perfect mode skips the tile lights
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
-- vim helpers
-- ════════════════════════════════════════════════════════════
local function vimDown(lane)
    if not lanePressed[lane] then
        lanePressed[lane]=true
        VIM:SendKeyEvent(true, KEYS[lane], false, game)
        lightTile(lane, true)
    end
end

local function vimUp(lane)
    if lanePressed[lane] then
        lanePressed[lane]=false
        VIM:SendKeyEvent(false, KEYS[lane], false, game)
        lightTile(lane, false)
    end
end

-- a real tap isn't exactly 50ms every time, small legitimacy touch.
-- perfect mode skips it, that one is supposed to look like a bot
local function tapDurSec()
    if not humanize or perfected or not hHumanTaps then return TAP_DUR end
    return math.clamp(TAP_DUR + (math.random()-0.5)*0.03, 0.03, 0.09)
end

local function vimTap(lane, dur)
    vimUp(lane); vimDown(lane)
    pressSeq[lane] = pressSeq[lane] + 1
    local mine = pressSeq[lane]
    task.delay(dur or tapDurSec(), function()
        -- only the newest press on a lane gets to let go, so an old tap can't
        -- cut a hold or a newer tap short
        if pressSeq[lane] == mine then vimUp(lane) end
    end)
end

-- ════════════════════════════════════════════════════════════
-- hold system
-- hold duration from source:
--   v98 = max(0, p88-0.07), clamped 0 if <=0.03
--   Size.Y.Scale = v98 * 5.5 * spd  (negative in upscroll)
--   → p88 = |scale|/(5.5*spd) + 0.07
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

-- ════════════════════════════════════════════════════════════
-- helpers
-- ════════════════════════════════════════════════════════════
-- real judgment windows, straight out of the game's own Combo() function
-- (ms, absolute offset). the old HIT_OFF guesses were close but "bad" (175ms)
-- was past 130.5ms, which the game doesn't count as a hit at all
local JUDGE = {
    perfect = 16.5,
    sick    = 43.5,
    good    = 76.5,
    ok      = 106.5,
    bad     = 130.5,  -- later than this and it isn't a hit
}

-- random point *inside* the rating's real band, not just its edge (a real
-- sick isn't always exactly 43.5ms off, it's anywhere in that range)
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
-- advanced bp: humanize engine
-- ────────────────────────────────────────────────────────────
-- the player decides an error for every note before it lands (ms, + = late,
-- - = early) and the hands (further down) press at exactly that moment. the
-- error is built from a few layers and every layer is its own switch on the
-- advanced tab. whatever band the error lands in IS the rating.
-- ════════════════════════════════════════════════════════════
local function gaussianRandom()
    -- box-muller, gives a standard normal sample (mean 0, sd 1)
    local u1 = math.max(1e-9, math.random())
    local u2 = math.random()
    return math.sqrt(-2*math.log(u1)) * math.cos(2*math.pi*u2)
end

-- consistency slider → how much a hot/cold streak carries into the next note
local function streakCarry()
    return 0.85 - 0.70 * (hConsistency/100)  -- 0.85 streaky .. 0.15 steady
end

local function updateStreak()
    local carry = streakCarry()
    streakState = streakState*carry + gaussianRandom()*(1-carry)
    streakState = math.clamp(streakState, -2, 2)
end

-- records this press and returns how far OVER the finger speed limit the
-- recent press rate is (0 = comfortably under it)
local function trackAndGetOverflow()
    local now=tick(); local i=1
    while i<=#kpsLog do
        if now-kpsLog[i]>1 then table.remove(kpsLog,i) else i=i+1 end
    end
    kpsLog[#kpsLog+1]=now
    if fingerSpeedLimit<=0 then return 0 end
    return math.max(0, (#kpsLog - fingerSpeedLimit)/fingerSpeedLimit)
end

-- ── the player's state ───────────────────────────────────────
local hDrift, hFocus, hTilt   = 0, 0, 0           -- slow timing wander, attention, "just slipped"
local hLaneBias               = {0,0,0,0}         -- each finger's own habit, ms
local hChordDir               = 1                 -- which way a chord rolls
local hLastNoise, hLastNoiseT = 0, 0
local hLastT                  = nil
local H_PLAN                  = 0.45              -- decide each note this long before it lands
local hPlan                   = setmetatable({}, {__mode="k"})  -- note -> {e=ms, density=}
local hHold                   = {}                -- release plan for the hold each lane is on
local hLaneHit                = {-math.huge,-math.huge,-math.huge,-math.huge}  -- when the last planned note in each lane lands
local hAnyHit                 = -math.huge
local hHitHist                = {}                -- landing times of recent notes, for how busy it is

-- a fresh start for the player. runs on enable and every time a song starts,
-- so each attempt has its own lean, habits and warm-up
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

-- moves the slow stuff forward in real time
local function hAdvance(now)
    local dt = hLastT and math.min(now - hLastT, 3) or 0
    hLastT = now
    if dt <= 0 then return end
    if hDriftOn then
        -- the timing average wanders a few ms and drifts back, faster to
        -- wander when consistency is low
        local k = math.exp(-dt/8)
        hDrift = hDrift*k + (1 + 6*(1 - hConsistency/100)) * math.sqrt(1-k*k) * gaussianRandom()
    end
    if hFocusOn then
        local k = math.exp(-dt/25)
        hFocus = math.clamp(hFocus*k + math.sqrt(1-k*k) * gaussianRandom() * 0.7, -1.5, 1.5)
    end
    hTilt = hTilt * math.exp(-dt/1.6)  -- a slip fades out
end

-- the decision for one note. returns the error in ms, or nil if the note
-- gets dropped. c = {lane, now, gapPrev, restGap, density, chordSize}
local function hDecide(c)
    local now = c.now
    hAdvance(now)

    -- simple mode: pick a rating from the weights and land somewhere inside it
    if not humanize then
        local rating = pickRating()
        if rating == "miss" then return nil end
        local off = math.min(randomOffsetForRating(rating), 125)
        return (math.random() < 0.5) and -off or off
    end

    local acc     = hAccuracy
    local t       = (100 - acc) / 100
    local sigma   = 4 + 51 * t^1.1       -- how scattered, ms
    local mean    = 1 + 40 * t^1.4       -- sloppier players land later on average, ms
    local comfort = 5 + 0.14 * acc       -- notes a second this player handles fine
    local dmul    = 1

    if hJackFatigue then
        dmul = 1 + 1.2 * math.max(0, c.density/comfort - 0.6)^1.3
        if c.gapPrev < 0.22 then  -- same finger again, fast
            local f = (0.22 - c.gapPrev) / 0.22
            mean  = mean + f*14
            sigma = sigma * (1 + f*0.8)
        end
        if c.chordSize >= 3 then sigma = sigma * 1.15 end
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

    local overflow = trackAndGetOverflow()
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

    -- where this player's timing sits right now
    local bias = hLeanMs
    if hPersonalBias then bias = bias + personalBiasMs end
    if hFingerBias   then bias = bias + hLaneBias[c.lane] end
    if hDriftOn      then bias = bias + hDrift end

    local noise = gaussianRandom() * sigma
    local corr = 0
    if hSelfCorrect and now - hLastNoiseT < 0.6 then corr = -0.25 * hLastNoise end
    hLastNoise, hLastNoiseT = noise, now
    local e = noise + mean + bias + corr

    -- slips: the odd bigger error, or a note that just doesn't get hit
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
    if missed then return nil end

    if not hEarlyHits then e = math.abs(e) end
    return math.clamp(e, -110, 125)
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

-- which side's notes to read. the game hands the side to PlaySong and reads
-- GetNotes<side> with it, so use that when we have it and only guess from
-- CurrentPlayer as a fallback
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
-- advanced bp: difficulty scanner
-- ────────────────────────────────────────────────────────────
-- reads the chart from the game's own song module (the same GetNotes1() /
-- GetNotes2() the game calls) the moment a song starts, so it can point out
-- the hardest parts before note one. it hooks the game's PlaySong to grab
-- that module. if the hook can't be set up it just does nothing, it never
-- touches the actual hitting.
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

    -- keep only real notes (lane is a number), skip SpeedBoost/Cam/etc events
    local notes = {}
    for _, n in pairs(rawNotes) do
        if type(n) == "table" and type(n[2]) == "number" then
            notes[#notes+1] = {t=n[1], lane=n[2]}
        end
    end
    if #notes < 2 then return end
    table.sort(notes, function(a,b) return a.t < b.t end)

    -- simple strain score per 1s bucket, extra weight for jacks (same lane
    -- firing fast) and chords (several lanes at once)
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
    if hAutoScan and not perfected then  -- perfect mode keeps the screen clean
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
                    -- fresh start every song, not just on enable. a real
                    -- player's warm-up, lean and habits reset per attempt
                    hResetRun()

                    -- the 2nd arg after songModule is the side the game plays (1 or 2)
                    local extra = {...}
                    local side = tonumber(extra[2])
                    if side ~= 1 and side ~= 2 then side = nil end

                    -- this hook runs AS PART OF the game's own function call, so
                    -- it only reads the chart for the scanner. it never presses
                    -- or schedules anything
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
-- ────────────────────────────────────────────────────────────
-- the "actual bot" mode, and it overrides everything else. humanize, hit
-- chances, miss jacks, tile lights, the scanner popup and auto latency are
-- all ignored while it's on, and they work like normal again the moment
-- it's off.
-- every frame it checks the notes in each lane, works out how long until each
-- one crosses the line from the note's own movement (no speed formulas, so
-- scroll speed and sv don't matter), and presses on the frame that lands
-- closest to the hit. holds are let go using the game's own finish rule.
-- it calibrates its press lead over the first few notes, then locks it and
-- stops touching it. only a long, clear drift unlocks it again.
-- ════════════════════════════════════════════════════════════
local pfLead         = 0.017   -- sec between our press and the frame the game reads the note on
local pfLocked       = false
local pfBuf          = {}
local pfGoodN        = 0
local pfBadN         = 0
local pfDt           = 1/60    -- smoothed frame time
local pfLastText     = nil
local pfActive       = false
local pfSavedHitLate = false
local pfHeldAt       = {0,0,0,0}
local pfTrack        = setmetatable({}, {__mode="k"})  -- per note movement samples
local pfDone         = setmetatable({}, {__mode="k"})  -- notes already pressed or passed

local function startPerfectMode()
    if not pfActive then
        pfActive = true
        -- msIndic only shows with HitLate on. remember the real value so it
        -- can be put back when perfect mode stops
        pfSavedHitLate = _G.Settings and _G.Settings.HitLate or false
        if _G.Settings then _G.Settings.HitLate = true end
    end
    pfBuf = {}; pfLastText = nil
end

local function stopPerfectMode()
    if not pfActive then return end  -- never started, nothing to put back
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

-- one fresh ms reading = one sample. it calibrates until the readings settle,
-- then locks and stops adjusting. locked means hands off, it only lets go if
-- the readings are clearly off for a while (like after an fps change)
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
        -- a + reading means the press was early, so lead less
        pfLead = math.clamp(pfLead - med/1000 * 0.6, 0, 0.25)
        pfGoodN = (math.abs(med) <= 3) and (pfGoodN + 1) or 0
        if pfGoodN >= 2 then pfLocked = true; pfGoodN = 0; pfBadN = 0 end
    end
end

local PF_LATE = 0.12  -- a note further past the line than this is too late to hit

-- how long until this note crosses the line (negative = already past it),
-- from the note's own movement over the last 0.1 to 0.3s. it works with the
-- signed distance, so the maths stays straight even when a note crosses the
-- line between two frames
local function pfRemaining(c, scale, now, fallbackV)
    local s = pfTrack[c]
    if not s then
        -- a note comes in from one side and that side counts as "before the
        -- line". one that first shows up right at the line is assumed to be
        -- on the usual (positive) side
        local side = (scale < -0.5) and -1 or 1
        local d0 = scale * side
        pfTrack[c] = {side=side, pT=now, pD=d0, cT=now, cD=d0}
        return d0 / fallbackV  -- first look, nothing to measure yet
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

-- the note in this lane that is due first (skips hold bodies and notes
-- already pressed)
local function pfNearest(nf, now, fallbackV)
    local best, bestRem = nil, math.huge
    for _, c in ipairs(nf:GetChildren()) do
        if c:IsA("GuiObject") and c.Visible and c.Name:sub(1,5) ~= "Hold_" and not pfDone[c] then
            local rem = pfRemaining(c, c.Position.Y.Scale, now, fallbackV)
            if rem < -PF_LATE then
                pfDone[c] = true   -- too late to hit, leave it
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
    local dir = tonumber(S.Direction) or 1
    local fallbackV = math.max(1, 5.5 * (tonumber(S.NoteSpeed) or 2))

    pfCalibrate(KS.Parent)

    -- press on the frame that lands closest to the hit: the first frame where
    -- the note is within our lead plus half a frame of the line
    local threshold = pfLead + pfDt/2

    for lane=1,4 do
        local af = KS:FindFirstChild("Arrow"..lane)
        local nf = af and af:FindFirstChild("Notes")
        if nf then
            -- let go of a hold the moment the game counts it as finished.
            -- same check the game runs when the key comes up: the hold's
            -- size plus its position has to be 1.5 or less. 1.3 leaves room
            local hf = laneHoldFrame[lane]
            if hf then
                local held = now - pfHeldAt[lane]
                local done = held > 15 or not hf.Parent
                if not done then
                    done = math.abs(hf.Size.Y.Scale) + hf.Position.Y.Scale * dir <= 1.3
                end
                if done and held > 0.03 then stopHold(lane, false) end
            end

            -- press everything that's due this frame (fast jacks can have
            -- more than one note due at once)
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
                    pfHeldAt[lane] = now
                else
                    vimTap(lane)
                end
            end
        end
    end
end

-- ════════════════════════════════════════════════════════════
-- the player's hands
-- ────────────────────────────────────────────────────────────
-- uses the same note tracking as perfect mode. each note gets decided once,
-- ahead of time (hDecide), then pressed on the frame that lands closest to
-- the error it was given. holds are let go the way they were planned
-- ════════════════════════════════════════════════════════════
local function humanTapDur(gapNext, density)
    -- a real tap is 40 to 90ms down, quicker when the notes come quicker, and
    -- it can't be longer than the gap to the next note in the lane
    local d = 0.055 * (0.75 + 0.6*math.random()) / (1 + 0.02*(density or 0))
    return math.clamp(d, 0.025, math.max(0.025, (gapNext or 1) * 0.6))
end

-- how a hold gets let go. normally a little after the earliest moment the
-- game would count it as done. every so often too soon, which breaks it
local function hHoldPlan(hf, now, dir, fallbackV)
    local plan = {t0=now, relThr=1.3}
    if humanize and hHumanHolds then
        local late = math.clamp(0.035 + gaussianRandom()*0.03, 0, 0.12)
        plan.relThr = math.clamp(1.35 - fallbackV*late, -0.5, 1.35)
        if hAllowRealMiss and hSlips then
            local crit0 = math.abs(hf.Size.Y.Scale) + hf.Position.Y.Scale * dir
            if crit0 - 1.5 > 0.4 then
                local p = (hMistakes/100) * 0.02 * (1 + (100-hAccuracy)/40)
                if hTiltOn then p = p * (1 + 1.5*hTilt) end
                if math.random() < math.min(0.25, p) then
                    plan.dropThr = crit0 - (0.15 + math.random()*0.7) * (crit0 - 1.5)
                    if hTiltOn then hTilt = math.min(2, hTilt + 0.5) end
                end
            end
        end
    end
    return plan
end

local function hPress(lane, note, nf, e, gapNext, density, now, dir, fallbackV)
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
        hHold[lane] = hHoldPlan(holdFrame, now, dir, fallbackV)
    else
        vimTap(lane, (humanize and hHumanTaps) and humanTapDur(gapNext, density) or nil)
    end
end

-- decides the notes that landed in the same instant together, as a chord
local function hPlanGroup(group, all, now)
    table.sort(group, function(a, b) return a.lane < b.lane end)
    local rem0  = group[1].rem
    local hitT0 = now + rem0

    -- how busy it is around this note, in notes a second (counting the ones
    -- already played)
    local count = 0
    for _, o in ipairs(all) do
        if math.abs(o.rem - rem0) <= 0.4 then count = count + 1 end
    end
    for _, ht in ipairs(hHitHist) do
        if ht <= now and ht >= hitT0 - 0.4 then count = count + 1 end
    end
    local density = count / 0.8
    local restGap = hitT0 - hAnyHit

    local es = {}
    for k, it in ipairs(group) do
        local gapPrev = (now + it.rem) - hLaneHit[it.lane]
        if missJacks and gapPrev < 0.12 then
            es[k] = false  -- stumbles on a fast same-key repeat, on purpose
        else
            es[k] = hDecide({lane=it.lane, now=now, gapPrev=gapPrev, restGap=restGap,
                             density=density, chordSize=#group}) or false
        end
    end

    -- a chord is one hand movement: the fingers share most of the error and
    -- land a few ms apart
    if humanize and hChordStagger and #group > 1 then
        local ec = nil
        for k = 1, #group do if es[k] then ec = es[k]; break end end
        if ec then
            local st, total = {}, 0
            for m = 1, #group do
                local rank = (hChordDir > 0) and m or (#group - m + 1)
                st[m] = (rank - 1) * (3 + math.random()*7)
                total = total + st[m]
            end
            for m = 1, #group do
                if es[m] then es[m] = ec + (es[m] - ec)*0.35 + (st[m] - total/#group) end
            end
        end
    end

    while #hHitHist > 0 and hHitHist[1] < now - 1 do table.remove(hHitHist, 1) end
    for k, it in ipairs(group) do
        if es[k] then
            hPlan[it.note] = {e=es[k], density=density}
        else
            pfDone[it.note] = true  -- left alone, the game counts it as a miss
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
    local dir = tonumber(S.Direction) or 1
    local fallbackV = math.max(1, 5.5 * (tonumber(S.NoteSpeed) or 2))
    -- time between our press and the frame the game reads the note on. the
    -- latency slider (or auto latency) sets this, same meaning as always:
    -- bigger slider = press later
    local lead = math.clamp((130.5 - vimLatencyMs) / 1000, 0, 0.25)
    local dtHalf = pfDt / 2

    -- every lane: the notes that are close, nearest first
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

    -- decide the notes that just came inside the planning window
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
            -- let go of a hold the way it was planned
            local hf = laneHoldFrame[lane]
            if hf then
                local hp = hHold[lane] or {t0=now, relThr=1.3}
                local held = now - hp.t0
                local release = held > 15 or not hf.Parent
                if not release then
                    local crit = math.abs(hf.Size.Y.Scale) + hf.Position.Y.Scale * dir
                    release = crit <= (hp.dropThr or hp.relThr)
                end
                if release and held > 0.03 then stopHold(lane, false) end
            end

            -- press whatever is due, oldest first
            local k, pressed = 1, 0
            while k <= #list and pressed < 4 do
                local it = list[k]
                if pfDone[it.note] then
                    k = k + 1
                else
                    local p = hPlan[it.note]
                    if not p then break end  -- not decided yet, still too far out
                    if it.rem <= lead - p.e/1000 + dtHalf then
                        pfDone[it.note] = true
                        local nxt = nil
                        for m = k+1, #list do
                            if not pfDone[list[m].note] then nxt = list[m]; break end
                        end
                        hPress(lane, it.note, nf, p.e, nxt and (nxt.rem - it.rem) or 1, p.density, now, dir, fallbackV)
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
-- ────────────────────────────────────────────────────────────
-- perfect mode presses on the frame closest to the hit and ignores
-- everything else. any other time the player (humanize, or the hit chance
-- weights with humanize off) decides and presses
-- ════════════════════════════════════════════════════════════
startLoop = function()
    if mainLoop then mainLoop:Disconnect(); mainLoop=nil end
    -- never leave a key stuck down when the mode changes
    for i=1,4 do
        if laneHoldFrame[i] then stopHold(i,false) end
        vimUp(i)
    end
    if perfected then
        -- perfect mode takes over completely. the old auto latency is shut
        -- off and none of the humanize stuff is touched
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

-- ── info ─────────────────────────────────────────────────────
local iL = infoTab:AddLeftGroupbox("IL",  {Text="about"       })
local iR = infoTab:AddRightGroupbox("IR", {Text="feature list" })

iL:AddLabel("IL1",{Text="<font color='#C41E3A'><b>bfnf:r botplay</b></font> by woops &lt;3\n\nplays basically fnf: remix for you, automatically.\nhumanize makes it look genuinely played. perfect mode is there too for a true 100% instead.\nauto latency figures out the right timing on its own after a few seconds."})
iL:AddSeparator("ILS1",{})
iL:AddLabel("IL2",{Text="<font color='#D0D0D6'><b>recommended setup:</b></font>\n• humanize (advanced bp tab) → on, for a run that looks genuinely played\n• perfect mode → on instead for a true 100%. it overrides everything else while it's on\n• auto latency → on"})
iL:AddSeparator("ILS2",{})
iL:AddLabel("IL3",{Text="<b>right shift</b> = open / close the menu"})

iR:AddLabel("IR1",{Text="<font color='#C41E3A'><b>botplay tab</b></font>"})
iR:AddLabel("IR2",{Text="enable → turns botplay on or off\nperfect mode → a true 100%, presses every note on the exact frame it lands. overrides everything else while it's on\ntile lights → lights up the on-screen keys for looks\nmiss jacks → skips super-fast repeat notes so it doesn't stumble\nauto latency → watches your timing and adjusts itself, no setup needed\nvim latency → a manual timing offset, only used when auto latency is off\nhit chances → weights, not percentages, only used while humanize is off"})
iR:AddSeparator("IRS1",{})
iR:AddLabel("IR3",{Text="<font color='#D0D0D6'><b>advanced bp tab</b></font>"})
iR:AddLabel("IR3B",{Text="humanize → plays with realistic, human-like timing instead of frame-perfect inputs. every part of it is its own switch, so mix and match\nskill preset, accuracy, consistency, mistakes → how good, and how steady, this 'player' is\ndifficulty scanner → points out a song's hardest sections the moment it loads"})
iR:AddSeparator("IRS2",{})
iR:AddLabel("IR5",{Text="<font color='#C41E3A'><b>works with</b></font>\n✓ mid-song speed changes\n✓ up & down scroll charts\n✓ modded charts\n✓ smooth at high fps, and still keeps up if your fps drops\n✓ hold notes and short (blue) notes"})

-- ── botplay ──────────────────────────────────────────────────
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
            -- perfect mode ignores this and calibrates on its own, the switch
            -- is just remembered for when perfect mode goes off
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

-- ── advanced bp ──────────────────────────────────────────────
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
