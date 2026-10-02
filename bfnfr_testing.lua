local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Null-Cherry/Fire-Library/refs/heads/main/Loader.lua", true))()

local VERSION = "v3.0-beta"  -- bump this each update — shows in the footer

-- ── palette (galaxy collapse — crimson, ink black & white) ──
local C_RED   = Color3.fromRGB(196, 30,  58)     -- crimson   #C41E3A
local C_STEEL = Color3.fromRGB(208, 208, 214)    -- pale grey #D0D0D6
local C_BG    = Color3.fromRGB(10,  10,  12)     -- near-black bg
local C_WHITE = Color3.fromRGB(232, 232, 236)    -- soft white text

local window = lib:Window("bfnfr_ap", {
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
})

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
-- timing & auto latency details + whatever else
-- ────────────────────────────────────────────────────────────
-- perfect window:  |scale| <= 0.71775 * spd
-- trigger formula: (0.71775 - latMs/1000 * 5.5) * spd
--
-- auto latency ( proportional controller, median-based ):
--   NO integral term (when i tested it was causing overshooting and stuffs)
--   uses MEDIAN of last 8 readings (immune to hold/miss outliers)
--   hunt:   sample every fresh text change, correct by median * adaptive gain
--           (bigger errors correct faster, small ones correct gently so it
--           settles instead of oscillating right near the target)
--           locks after 10 consecutive samples where |median| <= 2ms
--   locked: sample every 1s, correct by median * 0.03 (near-frozen)
--           re-hunts only if |median| > 5ms for 8 consecutive samples
--           outlier window tightens once locked (18ms vs 35ms while hunting)
--   stale guard: skip if msIndic text unchanged in last 0.35s
--   persists across songs: a lock is a device/input property, not a
--   per-song one, so a new song only clears the sample buffer, never
--   the lock itself — no more re-hunting from scratch every single song
-- ════════════════════════════════════════════════════════════
local vimLatencyMs    = 111
local autoLatency     = true
local autoLatencyConn = nil
local alSongWatcher   = nil
local alPhase         = "hunt"

local LOCK_GAIN     = 0.03   -- near-frozen correction when locked
local LOCK_THRESH   = 2.0    -- ms: |median| below this = good sample
local LOCK_N        = 10     -- consecutive good samples → lock
local UNLOCK_THRESH = 5.0    -- ms: |median| above this when locked = bad
local UNLOCK_N      = 8      -- consecutive bad samples → re-hunt
local HUNT_INTERVAL = 0.15   -- min seconds between hunt samples
local LOCK_INTERVAL = 1.0    -- seconds between locked samples
local STALE_MAX     = 0.35   -- ms indicator must have changed within this
local BUF_SIZE      = 8      -- median buffer size (odd = clean median)

local alBuf          = {}
local alGoodN        = 0
local alBadN         = 0
local alSavedHitLate = false

local function alReset(phase)
    alBuf={}; alGoodN=0; alBadN=0
    alPhase = phase or "hunt"
end

-- adaptive gain: bigger errors correct fast, small errors correct gently
-- so it doesn't overshoot and oscillate right near the target
local function huntGain(med)
    return math.clamp(0.18 + math.abs(med)/120, 0.18, 0.45)
end

-- ════════ perfect mode's OWN latency calibration ════════
-- vimLatencyMs is tuned for the old scale-based detection, where MORE
-- latency means firing LATER (it shrinks the trigger window). perfect
-- mode's chart-exact formula is a direct subtraction, where MORE latency
-- means firing EARLIER — the opposite relationship. sharing one value
-- between both meant auto-latency was correcting vimLatencyMs using the
-- wrong-for-perfect-mode direction the entire time perfect mode ran,
-- actively fighting its own accuracy. this is perfect mode's own,
-- separate value, corrected with the sign flipped to match its formula.
local chartLatencyMs  = 111
local chartLatencyConn = nil

local function chartModeActive()
    return perfected and chartEpoch ~= nil
        and (#chartSchedule[1]+#chartSchedule[2]+#chartSchedule[3]+#chartSchedule[4] > 0)
end

local function startChartLatencyCalibration()
    if chartLatencyConn then chartLatencyConn:Disconnect() end
    local lastSample, lastText, lastTextTime = 0, "", 0
    chartLatencyConn = RunService.Heartbeat:Connect(function()
        if not chartModeActive() then return end
        local now = tick()
        if now - lastSample < 0.15 then return end
        local mf = v5.PlayerGui:FindFirstChild("Main") and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
        if not mf then return end
        local ind = mf:FindFirstChild("msIndic")
        if not (ind and ind.Visible) then return end
        local txt = ind.Text or ""
        if txt ~= lastText then
            lastText = txt; lastTextTime = now
        elseif now - lastTextTime > 0.35 then
            return
        end
        lastSample = now
        local val = tonumber(txt:match("(-?%d+%.?%d*)"))
        if not val or math.abs(val) > 35 then return end
        -- sign flipped from the old system on purpose — see note above
        chartLatencyMs = math.clamp(chartLatencyMs - val*0.4, 0, 300)
    end)
end

local function stopChartLatencyCalibration()
    if chartLatencyConn then chartLatencyConn:Disconnect(); chartLatencyConn=nil end
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

local function calcTriggerScale(spd)
    local c = math.clamp(0.71775 - (vimLatencyMs/1000)*5.5, 0.05, 0.71775)
    return c * spd
end

local function startAutoLatency()
    if autoLatencyConn then autoLatencyConn:Disconnect() end
    alReset("hunt")
    alSavedHitLate = _G.Settings and _G.Settings.HitLate or false
    if _G.Settings then _G.Settings.HitLate = true end

    if alSongWatcher then alSongWatcher:Disconnect() end
    task.spawn(function()
        local mg = v5.PlayerGui:WaitForChild("Main", 30)
        if not mg then return end
        alSongWatcher = mg.ChildAdded:Connect(function(c)
            if c.Name ~= "MatchFrame" then return end
            -- a locked calibration is a device/input property, not a per-song
            -- one — re-hunting from scratch every song wasted the first few
            -- seconds of every run. just drop the sample buffer (in case any
            -- readings straddled the song boundary) and keep the lock.
            alBuf = {}
            if alPhase == "hunt" then alGoodN=0; alBadN=0 end
        end)
    end)

    local lastSample   = 0
    local lastText     = ""
    local lastTextTime = 0

    autoLatencyConn = RunService.Heartbeat:Connect(function()
        if not autoLatency then return end
        if chartModeActive() then return end  -- chart mode has its own calibration now
        local now = tick()
        local interval = (alPhase=="hunt") and HUNT_INTERVAL or LOCK_INTERVAL
        if now - lastSample < interval then return end

        local mf = v5.PlayerGui:FindFirstChild("Main")
               and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
        if not mf then return end
        local ind = mf:FindFirstChild("msIndic")
        if not (ind and ind.Visible) then return end

        local txt = ind.Text or ""
        -- only accept readings that are freshly updated ( AKA note was just hit )
        if txt ~= lastText then
            lastText = txt
            lastTextTime = now
        else
            if now - lastTextTime > STALE_MAX then return end
        end

        -- only sample after the interval has passed AND text is fresh
        if now - lastSample < interval then return end
        lastSample = now

        local val = tonumber(txt:match("(-?%d+%.?%d*)"))
        -- outlier window: holds/misses produce large values we ignore.
        -- tighter once locked, since anything wildly off at that point is
        -- almost certainly a hold/miss artifact, not a real correction
        local outlierMax = (alPhase=="locked") and 18 or 35
        if not val or math.abs(val) > outlierMax then return end

        table.insert(alBuf, val)
        if #alBuf > BUF_SIZE then table.remove(alBuf, 1) end
        if #alBuf < 3 then return end  -- need at least 3 samples for stable median

        local med = alMedian()

        if alPhase == "hunt" then
            -- proportional with adaptive gain: no integral term = no overshoot,
            -- and the gain itself scales down as it nears the target
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

        else  -- locked: near-frozen, only tiny drift correction
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
    if autoLatencyConn then autoLatencyConn:Disconnect(); autoLatencyConn=nil end
    if alSongWatcher   then alSongWatcher:Disconnect();   alSongWatcher=nil   end
    if _G.Settings then _G.Settings.HitLate = alSavedHitLate end
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
local seenNotes     = {}
local lastLaneTime  = {0,0,0,0}   -- last press time per lane (jack detection)

-- simple-mode hit-chance weights — only used while humanize (below) is off
local perfectChance = 100
local sickChance    = 0
local goodChance    = 0
local okChance      = 0
local badChance     = 0
local missChance    = 0

-- ════════ advanced bp: humanize engine (replaces the old legit mode) ════════
local humanize         = true   -- master switch
local hAccuracy        = 92     -- 0-100, how tight the timing is
local hConsistency     = 70     -- 0-100, how steady it stays note to note
local hJackFatigue     = true   -- fast same-key repeats get sloppier
local hChordStagger    = true   -- same-beat multi-lane notes get a tiny stagger
local hWarmupFatigue   = true   -- shakier at the very start, can drift late-song
local hPersonalBias    = true   -- a small consistent lean, re-rolled each run
local hAllowRealMiss   = true   -- lets brutal speed cause a genuine miss sometimes
local fingerSpeedLimit = 100    -- kps; replaces the old hard "legit" cap

local kpsLog          = {}      -- rolling press timestamps, for finger-speed overflow
local streakState     = 0       -- slow "hot/cold streak" driver
local personalBiasMs  = 0       -- sampled once per run
local songStartTick   = 0       -- tick() when the current run started

-- ════════ advanced bp: difficulty scanner ════════
local hAutoScan            = true    -- popup the scan results when a song starts
local hReactToSpikes       = true    -- humanize loosens up a bit during spikes
local lastScanResult       = nil     -- {totalSeconds=, noteCount=, spikes={ {t=,strain=}, ... }}
local scanHookInstalled    = false
local chartIsInSpikeWindow -- forward declared; defined down in the scanner section

-- ════════ perfect mode: chart-exact scheduling ════════
-- perfect mode represents an actual bot, so instead of reacting to note
-- positions on screen (frame-rate and calibration dependent) it reads the
-- same GetNotes1()/GetNotes2() chart data the scanner already grabs, and
-- schedules every press at its real, exact timestamp. falls back to the
-- old on-screen detection automatically if chart data isn't available.
local chartSchedule       = {{},{},{},{}}  -- per lane: sorted {t=, hold=} for the current song
local chartEpoch          = nil            -- tick() matching chart-time 0; nil = no chart data yet
local buildChartSchedule  -- forward declared; defined down in the scanner section
local startLoop           -- forward declared; defined further down, the main run loop

-- ════════ mobile tiles: visual-only option ════════
local blockManualTaps = false  -- tiles stay visible/lit but stop registering real taps

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

-- .Active alone only blocks Roblox's built-in GuiButton input system — if
-- the game reads raw touch/input events itself (common for precise,
-- multi-touch rhythm controls), that wouldn't be stopped by .Active at
-- all. a real, front-most invisible button physically sitting on top of
-- each tile blocks the touch at the engine level regardless of how the
-- game underneath is listening for it.
local tapBlockOverlays = {}

local function ensureTapBlockOverlays()
    pcall(function()
        local keys = v5.PlayerGui.Main.MatchFrame.MobileKeys
        for _, name in ipairs(TILE_NAMES) do
            local tile = keys:FindFirstChild(name)
            if tile then
                local existing = tapBlockOverlays[name]
                if not existing or existing.Parent ~= tile then
                    if existing then existing:Destroy() end
                    local overlay = Instance.new("TextButton")
                    overlay.Name = "BPTapBlock_"..name
                    overlay.BackgroundTransparency = 1
                    overlay.Text = ""
                    overlay.AutoButtonColor = false
                    overlay.ZIndex = (tile.ZIndex or 1) + 50
                    overlay.Size = UDim2.new(1,0,1,0)
                    overlay.Position = UDim2.new(0,0,0,0)
                    overlay.Visible = false
                    overlay.Active = true
                    overlay.Parent = tile
                    tapBlockOverlays[name] = overlay
                end
            end
        end
    end)
end

-- turns real touch input on/off for the on-screen tiles without touching
-- how they look — so tile lights still work, but an accidental tap can't
-- register as a press, miss, or bad rating anymore
local function setTilesActive(active)
    ensureTapBlockOverlays()
    pcall(function()
        local keys = v5.PlayerGui.Main.MatchFrame.MobileKeys
        for _, name in ipairs(TILE_NAMES) do
            local t = keys:FindFirstChild(name)
            if t then pcall(function() t.Active = active end) end
            local ov = tapBlockOverlays[name]
            if ov then ov.Visible = not active end
        end
        -- also catches any invisible touch-zone nested under the tiles,
        -- in case the tappable area isn't the visible image itself
        for _, d in ipairs(keys:GetDescendants()) do
            if d:IsA("GuiButton") and not d.Name:match("^BPTapBlock_") then
                pcall(function() d.Active = active end)
            end
        end
    end)
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

-- a real tap isn't exactly 50ms every single time — small legitimacy touch
local function tapDurSec()
    if not humanize then return TAP_DUR end
    return math.clamp(TAP_DUR + (math.random()-0.5)*0.03, 0.03, 0.09)
end

local function vimTap(lane)
    vimUp(lane); vimDown(lane)
    task.delay(tapDurSec(), function() vimUp(lane) end)
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

local function holdForDuration(lane, holdFrame, spd, pressedAt)
    laneHoldFrame[lane] = holdFrame
    local scale   = math.abs(holdFrame.Size.Y.Scale)
    local p88     = scale / (5.5*spd) + 0.07
    local leadSec = vimLatencyMs / 1000
    local elapsed = tick() - pressedAt
    local rem     = math.max(0, p88 - leadSec - elapsed)
    if humanize then
        -- real fingers let go a hair late, never early — releasing early is
        -- what breaks the combo on a hold, so this only ever adds time
        rem = rem + (0.005 + math.random()*0.025)
    end
    task.delay(rem, function()
        if laneHoldFrame[lane] == holdFrame then stopHold(lane,false) end
    end)
end

-- ════════════════════════════════════════════════════════════
-- helpers
-- ════════════════════════════════════════════════════════════
-- real judgment windows, read straight out of the game's own Combo()
-- function (ms, absolute offset) — the old HIT_OFF guesses here were
-- close but "bad" (175ms) actually overshot 130.5ms, which means it
-- wouldn't even register as a hit at all, just an unintended miss.
local JUDGE = {
    perfect = 16.5,
    sick    = 43.5,
    good    = 76.5,
    ok      = 106.5,
    bad     = 130.5,  -- later than this and the game doesn't count it as a hit
}

-- a random point *inside* the rating's real band, not just the edge of it —
-- a real "sick" isn't always exactly 43.5ms off, it's anywhere in that range
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
-- instead of picking a rating word first, this samples a continuous
-- timing error (ms, late-only — see the note in the summary about
-- why early hits aren't modeled) shaped by several layered, genuinely
-- human effects, then whatever band that error lands in IS the rating.
-- ════════════════════════════════════════════════════════════
local function gaussianRandom()
    -- box-muller transform → a standard-normal sample (mean 0, sd 1)
    local u1 = math.max(1e-9, math.random())
    local u2 = math.random()
    return math.sqrt(-2*math.log(u1)) * math.cos(2*math.pi*u2)
end

-- accuracy slider → base mean/spread of the timing error, in ms
local function baseTimingFromAccuracy()
    local t = (100 - hAccuracy) / 100       -- 0 = flawless, 1 = sloppiest
    local mean  = 2  + 68 * (t^1.3)
    local sigma = 4  + 51 * (t^1.1)
    return mean, sigma
end

-- consistency slider → how much a hot/cold streak carries to the next note
local function streakCarry()
    return 0.85 - 0.70 * (hConsistency/100)  -- 0.85 streaky .. 0.15 steady
end

local function updateStreak()
    local carry = streakCarry()
    streakState = streakState*carry + gaussianRandom()*(1-carry)
    streakState = math.clamp(streakState, -2, 2)
end

-- records this press and returns how far OVER the finger-speed limit
-- the recent press rate is (0 = comfortably under it)
local function trackAndGetOverflow()
    local now=tick(); local i=1
    while i<=#kpsLog do
        if now-kpsLog[i]>1 then table.remove(kpsLog,i) else i=i+1 end
    end
    kpsLog[#kpsLog+1]=now
    if fingerSpeedLimit<=0 then return 0 end
    return math.max(0, (#kpsLog - fingerSpeedLimit)/fingerSpeedLimit)
end

-- the main roll: how late (ms) should this press land, and should it be
-- allowed to just genuinely whiff? jackGap = seconds since this same
-- lane was last pressed (small = jack).
local function computeHumanizeOffsetMs(jackGap)
    updateStreak()
    local mean, sigma = baseTimingFromAccuracy()

    if hJackFatigue and jackGap < 0.22 then
        local f = (0.22-jackGap)/0.22        -- 0..1, 1 = instant re-press
        mean  = mean  + f*22
        sigma = sigma * (1 + f*0.9)
    end

    if hWarmupFatigue then
        local elapsed = tick() - songStartTick
        if elapsed < 2.5 then
            sigma = sigma * (1 + 0.6*(1 - elapsed/2.5))
        elseif elapsed > 90 then
            sigma = sigma * (1 + math.min(0.25, (elapsed-90)/300))
        end
    end

    local realMiss = false
    local overflow = trackAndGetOverflow()
    if overflow > 0 then
        mean  = mean  + overflow*45
        sigma = sigma * (1 + overflow*2.5)
        if hAllowRealMiss and overflow > 0.5 and math.random() < math.min(0.35, overflow*0.15) then
            realMiss = true
        end
    end

    if hReactToSpikes and chartIsInSpikeWindow and chartIsInSpikeWindow() then
        sigma = sigma * 1.25
    end

    -- the streak modulates spread (a bad run looks scattered, not just late)
    sigma = math.max(1.5, sigma * (1 + streakState*0.5))

    local personal = hPersonalBias and personalBiasMs or 0
    local raw = gaussianRandom()*sigma + mean + personal
    return math.clamp(raw, 0, 165), realMiss
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

-- ════════════════════════════════════════════════════════════
-- advanced bp: difficulty scanner
-- ────────────────────────────────────────────────────────────
-- reads the chart straight from the game's own song module — the
-- exact same GetNotes1()/GetNotes2() the game calls — the moment a
-- song starts, so it can flag the hardest parts before note one.
-- it hooks the game's own PlaySong/AutoSong/BotPlaySong functions to
-- grab that song module; if the hook can't be set up for any reason
-- this just quietly does nothing — it never touches actual hitting.
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

local function analyzeChart(songModule)
    local mySide = 1
    pcall(function()
        local pv = v5:FindFirstChild("File") and v5.File:FindFirstChild("CurrentPlayer")
        if pv and pv.Value and pv.Value.Name=="Player2" then mySide = 2 end
    end)

    local ok, rawNotes = pcall(function() return songModule["GetNotes"..mySide]() end)
    if not ok or type(rawNotes) ~= "table" then return end

    -- keep only real notes (lane is a number) — skip SpeedBoost/Cam/etc. events
    local notes = {}
    for _, n in pairs(rawNotes) do
        if type(n) == "table" and type(n[2]) == "number" then
            notes[#notes+1] = {t=n[1], lane=n[2]}
        end
    end
    if #notes < 2 then return end
    table.sort(notes, function(a,b) return a.t < b.t end)

    -- simple strain score per 1s bucket: extra weight for jacks (same
    -- lane firing fast) and chords (multiple lanes at once)
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
    if hAutoScan then
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
                    local epoch = tick()
                    -- fresh "run" feel for every song, not just on enable — a
                    -- real player's warm-up and personal lean reset per attempt
                    songStartTick  = epoch
                    personalBiasMs = hPersonalBias and (math.random()*8) or 0
                    streakState    = 0
                    table.clear(kpsLog)
                    task.spawn(function() pcall(analyzeChart, songModule) end)

                    -- playback-rate divisor, if this call used one (practice/
                    -- speed-adjusted modes) — defaults to 1 for normal play
                    local extra = {...}
                    local rate = tonumber(extra[6])
                    if not rate or rate <= 0 then rate = 1 end
                    -- this hook runs AS PART OF the game's own function call, so
                    -- it only ever stashes data here — it never schedules or
                    -- presses anything itself. perfect mode's own loop (started
                    -- from the UI toggle, a safe call chain) notices the new
                    -- chartEpoch on its own and rebuilds from it
                    pcall(buildChartSchedule, songModule, epoch, rate)

                    if blockManualTaps then
                        task.spawn(function() task.wait(0.3); setTilesActive(false) end)
                    end
                    return original(songModule, ...)
                end
            end
        end
        scanHookInstalled = true
    end)
end

-- builds the per-lane, time-sorted note list perfect mode schedules
-- against. same raw chart data as the difficulty scanner, kept as its
-- own lightweight extraction so a bug in one never touches the other.
buildChartSchedule = function(songModule, epoch, rate)
    local mySide = 1
    pcall(function()
        local pv = v5:FindFirstChild("File") and v5.File:FindFirstChild("CurrentPlayer")
        if pv and pv.Value and pv.Value.Name=="Player2" then mySide = 2 end
    end)

    local ok, rawNotes = pcall(function() return songModule["GetNotes"..mySide]() end)
    local fresh = {{},{},{},{}}
    if ok and type(rawNotes) == "table" then
        rate = rate or 1
        for _, n in pairs(rawNotes) do
            if type(n)=="table" and type(n[2])=="number" and n[2]>=1 and n[2]<=4 then
                local lane = n[2]
                fresh[lane][#fresh[lane]+1] = {t=(n[1] or 0)/rate, hold=n[3] or 0}
            end
        end
        for lane=1,4 do
            table.sort(fresh[lane], function(a,b) return a.t < b.t end)
        end
    end
    chartSchedule = fresh
    chartEpoch    = epoch
end

-- is there an actual, currently-visible note waiting in this lane right
-- now? the chart tells fireChartNote roughly WHEN to press, but this is
-- the ground truth check before it actually does
local function liveNoteInLane(lane)
    local KS = getMyKeySync()
    if not (KS and KS.Visible) then return false end
    local af = KS:FindFirstChild("Arrow"..lane)
    local nf = af and af:FindFirstChild("Notes")
    if not nf then return false end
    for _, c in ipairs(nf:GetChildren()) do
        if c:IsA("GuiObject") and c.Visible and c.Name:sub(1,5) ~= "Hold_" then
            return true
        end
    end
    return false
end

-- fires one chart-scheduled press — perfect mode, so zero jitter, zero
-- stagger, zero fatigue, on purpose: it's meant to represent the bot
-- actually is, not a human
local function fireChartNote(lane, note)
    if not v8 or not perfected then return end

    -- confirm a real note is actually here before pressing — covers any
    -- start-of-song delay we couldn't see from outside (the chart's clock
    -- starts counting before the match visually begins), and skips chart
    -- entries that aren't actually ours to hit right now. costs nothing
    -- when timing is already correct, since the note is already waiting
    local tries = 0
    while not liveNoteInLane(lane) do
        tries = tries + 1
        if tries > 130 then return end  -- ~2s of retrying — genuinely not ours, skip cleanly
        if not v8 or not perfected then return end
        task.wait(0.015)
    end

    if laneHoldFrame[lane] then stopHold(lane,true) end
    if note.hold and note.hold > 0.08 then
        local marker = {}
        laneHoldFrame[lane] = marker
        vimUp(lane); vimDown(lane)
        task.delay(note.hold, function()
            if laneHoldFrame[lane] == marker then stopHold(lane,false) end
        end)
    else
        vimTap(lane)
    end
end

-- flattens chartSchedule into one time-sorted list, each with its real
-- fire time already worked out (compensating for vim's injection latency).
-- only a LIST — nothing here touches input, so building/rebuilding this
-- is always safe no matter what called it
local function buildChartTimeline()
    local list = {}
    local now = tick()
    for lane=1,4 do
        for _, note in ipairs(chartSchedule[lane]) do
            local fireAt = chartEpoch + note.t - (chartLatencyMs/1000)
            if fireAt > now then
                list[#list+1] = {fireAt=fireAt, lane=lane, note=note}
            end
        end
    end
    table.sort(list, function(a,b) return a.fireAt < b.fireAt end)
    return list
end

-- ════════════════════════════════════════════════════════════
-- note handler !!!
-- ════════════════════════════════════════════════════════════
local function handleNote(lane, isHold, holdFrame, arrowFrame, sync, spd, chordDelayMs)
    chordDelayMs = chordDelayMs or 0
    local now = tick()
    local jackGap = now - (lastLaneTime[lane] or 0)
    lastLaneTime[lane] = now

    if missJacks and jackGap < 0.12 then
        return  -- intentionally whiffs fast same-key repeats, like a stumbling finger
    end

    if laneHoldFrame[lane] then stopHold(lane,true) end

    local function fire()
        local pressedAt = tick()
        if isHold then
            local sc = holdFrame and math.abs(holdFrame.Size.Y.Scale) or 0
            if sc < 0.01 then   -- short hold (blue note) — tap it
                vimTap(lane)
            else
                vimUp(lane); vimDown(lane)
                holdForDuration(lane, holdFrame, spd, pressedAt)
            end
        else
            vimTap(lane)
        end
    end

    if sync then
        -- perfect mode: always fires immediately, on purpose — perfect mode and
        -- humanize are opposite philosophies, and the render-stepped loop that
        -- calls us with sync=true is exactly what "perfect mode" turns on
        fire()
        return
    end

    if humanize then
        task.spawn(function()
            local offsetMs, realMiss = computeHumanizeOffsetMs(jackGap)
            if realMiss then return end
            local delaySec = (offsetMs + chordDelayMs)/1000
            if delaySec > 0 then task.wait(delaySec) end
            fire()
        end)
    else
        local rating = pickRating()
        if rating=="miss" then return end
        task.spawn(function()
            local delaySec = (randomOffsetForRating(rating) + chordDelayMs)/1000
            if delaySec > 0 then task.wait(delaySec) end
            fire()
        end)
    end
end

-- ════════════════════════════════════════════════════════════
-- main loop
-- ────────────────────────────────────────────────────────────
-- sv support: spd is read from _G.Settings.NoteSpeed every frame
-- lag-spike recovery: scan up to 2x the trigger window so notes
-- that drifted past the normal trigger during a frame drop are
-- still caught and fired rather than missed
-- ════════════════════════════════════════════════════════════
startLoop = function()
    if mainLoop then mainLoop:Disconnect(); mainLoop=nil end
    seenNotes={}
    local cacheBuilt={}

    local function tick_fn(sync)
        if not v8 then return end
        local KS = getMyKeySync()
        if not (KS and KS.Visible) then return end

        -- sv: re-read speed every frame (which SHOULD handle mid-song sv changes)
        local spd = math.clamp(
            tonumber((_G and _G.Settings and _G.Settings.NoteSpeed) or 2) or 2,
            0.5, 10)
        local trigger  = calcTriggerScale(spd)
        -- this is what i call the RESCUE WINDOW, it catches notes that slipped past trigger during lag spikes
        -- capped at half the perfect window so we don't fire too early (i havent tested this at all btw)
        local rescue   = math.min(trigger * 1.8, 0.71775 * spd)

        -- pass 1: collect every lane with a note to press this tick, so
        -- simultaneous lanes (chords) can be told apart from solo notes
        local toPress = {}
        for lane=1,4 do
            local af = KS:FindFirstChild("Arrow"..lane)
            local nf = af and af:FindFirstChild("Notes")
            if not (af and nf) then continue end

            if not cacheBuilt[lane] then
                cacheBuilt[lane]=true
                nf.ChildAdded:Connect(function(c)
                    c.AncestryChanged:Connect(function()
                        if not c:IsDescendantOf(game) then seenNotes[c]=nil end
                    end)
                end)
            end

            local best, bestDist = nil, math.huge
            for _, c in ipairs(nf:GetChildren()) do
                if not c:IsA("GuiObject") then continue end
                if c.Name:sub(1,5)=="Hold_" then continue end
                if not c.Visible then continue end
                if seenNotes[c] then continue end
                local d = math.abs(c.Position.Y.Scale)
                if d <= rescue and d < bestDist then
                    bestDist=d; best=c
                end
            end

            if not best then continue end
            seenNotes[best]=true

            local isHold    = best:GetAttribute("HoldHead")==true
            local holdFrame = isHold and nf:FindFirstChild("Hold_"..best.Name) or nil
            if isHold and not holdFrame then isHold=false end

            toPress[#toPress+1] = {lane=lane, isHold=isHold, holdFrame=holdFrame, af=af}
            best.AncestryChanged:Once(function() seenNotes[best]=nil end)
        end

        -- pass 2: fire — chord-mates (2nd+ lane this tick) get a tiny human stagger
        local isChord = #toPress > 1
        for i, p in ipairs(toPress) do
            local chordDelayMs = 0
            if isChord and not sync and humanize and hChordStagger and i > 1 then
                chordDelayMs = math.abs(p.lane - toPress[1].lane) * (3 + math.random()*6)
            end
            handleNote(p.lane, p.isHold, p.holdFrame, p.af, sync, spd, chordDelayMs)
        end
    end

    if perfected and chartModeActive() then
        -- exact, chart-driven — genuinely 100%. the Heartbeat connection
        -- (started from this UI toggle, a safe call chain) only looks ahead
        -- and hands each note to task.delay for the actual precise press —
        -- firing straight off Heartbeat meant landing anywhere up to a
        -- whole frame late, which was enough to turn some Perfects into
        -- Sicks. task.delay scheduled from here, not from the song-start
        -- hook, keeps the capability fix from before intact
        startChartLatencyCalibration()
        local timeline  = buildChartTimeline()
        local idx       = 1
        local seenEpoch = chartEpoch
        local LOOKAHEAD = 0.75
        mainLoop = RunService.Heartbeat:Connect(function()
            if not v8 or not perfected then return end
            if chartEpoch ~= seenEpoch then
                -- a new song started mid-run — rebuild from the fresh chart
                seenEpoch = chartEpoch
                timeline  = buildChartTimeline()
                idx = 1
            end
            local t = tick()
            while idx <= #timeline and timeline[idx].fireAt <= t + LOOKAHEAD do
                local item     = timeline[idx]
                local atEpoch  = seenEpoch
                task.delay(math.max(0, item.fireAt - t), function()
                    if seenEpoch ~= atEpoch then return end  -- song changed since this was scheduled
                    fireChartNote(item.lane, item.note)
                end)
                idx = idx + 1
            end
        end)
    elseif perfected then
        -- no chart data for this song (hook unavailable, etc.) — fall back
        -- to the old frame-reactive detection so perfect mode still works
        stopChartLatencyCalibration()
        mainLoop = RunService.RenderStepped:Connect(function() tick_fn(true) end)
    else
        stopChartLatencyCalibration()
        mainLoop = RunService.Heartbeat:Connect(function() tick_fn(false) end)
    end
end

task.spawn(installChartScanHook)

-- ════════════════════════════════════════════════════════════
-- ui which looks amazing btw
-- ════════════════════════════════════════════════════════════
local infoTab  = window:AddTab("InfoTab",  {Text="info",        Icon="info"               })
local playTab  = window:AddTab("PlayTab",  {Text="botplay",     Icon="play"                })
local advTab   = window:AddTab("AdvTab",   {Text="advanced bp", Icon="sparkles"            })
local tuneTab  = window:AddTab("TuneTab",  {Text="tune",        Icon="sliders-horizontal"  })

-- ── info ─────────────────────────────────────────────────────
local iL = infoTab:AddLeftGroupbox("IL",  {Text="about"       })
local iR = infoTab:AddRightGroupbox("IR", {Text="feature list" })

iL:AddLabel("IL1",{Text="<font color='#C41E3A'><b>bfnf:r botplay</b></font> by woops &lt;3\n\nplays basically fnf: remix for you, automatically.\nhumanize makes it look genuinely played — perfect mode is there too for genuine 100% accuracy instead.\nauto latency figures out the right timing on its own after a few seconds."})
iL:AddSeparator("ILS1",{})
iL:AddLabel("IL2",{Text="<font color='#D0D0D6'><b>recommended setup:</b></font>\n• humanize (advanced bp tab) → on, for a run that looks genuinely played\n• perfect mode → on instead, only if you want pure frame-perfect inputs\n• auto latency → on"})
iL:AddSeparator("ILS2",{})
iL:AddLabel("IL3",{Text="<b>right shift</b> = open / close the menu"})

iR:AddLabel("IR1",{Text="<font color='#C41E3A'><b>play tab</b></font>"})
iR:AddLabel("IR2",{Text="enable → turns botplay on or off\nperfect mode → genuinely 100% — reads the chart's exact timing instead of reacting to the screen\ntile lights → lights up the on-screen keys for looks\nmiss jacks → skips super-fast repeat notes so it doesn't stumble\ndisable tile functionality → keys stay lit but stop registering real taps, so accidental presses can't interfere"})
iR:AddSeparator("IRS1",{})
iR:AddLabel("IR3",{Text="<font color='#D0D0D6'><b>advanced bp tab</b></font>"})
iR:AddLabel("IR3B",{Text="humanize → plays with realistic, human-like timing instead of frame-perfect inputs\naccuracy & consistency → how good, and how steady, this 'player' is\ndifficulty scanner → points out a song's hardest sections the moment it loads"})
iR:AddSeparator("IRS2",{})
iR:AddLabel("IR4",{Text="<font color='#C41E3A'><b>tune tab</b></font>"})
iR:AddLabel("IR4B",{Text="auto latency → watches your timing and adjusts itself, no setup needed\nvim latency → a manual timing offset, only used when auto latency is off\nhit chances → weights, not percentages — only used while humanize is off"})
iR:AddSeparator("IRS3",{})
iR:AddLabel("IR5",{Text="<font color='#C41E3A'><b>works with</b></font>\n✓ mid-song speed changes\n✓ up & down scroll charts\n✓ modded charts\n✓ smooth at high fps, and still keeps up if your fps drops\n✓ hold notes and short (blue) notes"})

-- ── play ─────────────────────────────────────────────────────
local pL = playTab:AddLeftGroupbox( "PL", {Text="botplay"  })

pL:AddToggle("Enable",{
    Text="enable", Value=false,
    Tooltip="turns botplay on or off",
    Callback=function(val)
        v8=val
        if v8 then
            laneHoldFrame={nil,nil,nil,nil}; lanePressed={false,false,false,false}
            for i=1,4 do vimUp(i) end
            seenNotes={}; startLoop()
            if autoLatency then startAutoLatency() end
            songStartTick  = tick()
            personalBiasMs = hPersonalBias and (math.random()*8) or 0
            streakState    = 0
            table.clear(kpsLog)
            window:Notification({Title="botplay",Text="<font color='#C41E3A'><b>on</b></font>",Duration=2})
        else
            for i=1,4 do
                if laneHoldFrame[i] then stopHold(i,false) end
                vimUp(i)
            end
            if mainLoop then mainLoop:Disconnect(); mainLoop=nil end
            stopAutoLatency()
            stopChartLatencyCalibration()
            laneHoldFrame={nil,nil,nil,nil}; lanePressed={false,false,false,false}
            seenNotes={}
            window:Notification({Title="botplay",Text="off",Duration=2})
        end
    end,
})

pL:AddToggle("Perfected",{
    Text="perfect mode", Value=false,
    Tooltip="genuinely 100% — reads the chart's exact note times instead of reacting to what's on screen, like an actual bot would",
    Callback=function(val)
        perfected=val
        if v8 then if mainLoop then mainLoop:Disconnect(); mainLoop=nil end; startLoop() end
        window:Notification({Title="perfect mode",Text=val and "<font color='#C41E3A'>on</font>" or "off",Duration=2})
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

pL:AddToggle("BlockTaps",{
    Text="disable tile functionality", Value=false,
    Tooltip="the on-screen keys still light up, but stop registering real taps — no more accidental presses messing with a run",
    Callback=function(val)
        blockManualTaps = val
        setTilesActive(not val)
        window:Notification({Title="disable tile functionality",Text=val and "<font color='#C41E3A'>on</font>" or "off",Duration=2})
    end,
})

-- ── advanced bp ──────────────────────────────────────────────
local aL = advTab:AddLeftGroupbox( "AL", {Text="humanize"           })
local aR = advTab:AddRightGroupbox("AR", {Text="difficulty scanner" })

aL:AddToggle("Humanize",{
    Text="humanize", Value=true,
    Tooltip="replaces the old legit mode — plays with realistic, human-like timing instead of frame-perfect inputs",
    Callback=function(val)
        humanize=val
        window:Notification({Title="humanize",Text=val and "<font color='#C41E3A'>on</font>" or "off — using the hit-chance sliders on the tune tab instead",Duration=3})
    end,
})

aL:AddSlider("Accuracy",{
    Text="accuracy", Min=0, Max=100, Value=92, Step=1,
    Tooltip="how good this 'player' is — higher means tighter, closer-to-perfect timing",
    Callback=function(v) hAccuracy=v end,
})

aL:AddSlider("Consistency",{
    Text="consistency", Min=0, Max=100, Value=70, Step=1,
    Tooltip="how steady it stays — lower lets it drift into little hot and cold streaks like a real player",
    Callback=function(v) hConsistency=v end,
})

aL:AddSeparator("ALS1",{})

aL:AddToggle("JackFatigue",{
    Text="finger fatigue on fast bursts", Value=true,
    Tooltip="rapid same-key notes get a little sloppier, like a real finger struggling to keep up",
    Callback=function(val) hJackFatigue=val end,
})

aL:AddToggle("ChordStagger",{
    Text="chord finger stagger", Value=true,
    Tooltip="notes landing on the same beat across lanes get pressed a few ms apart, not at the exact same instant",
    Callback=function(val) hChordStagger=val end,
})

aL:AddToggle("WarmupFatigue",{
    Text="warm-up & fatigue", Value=true,
    Tooltip="a little shakier for the first couple seconds, and can drift slightly on long songs",
    Callback=function(val) hWarmupFatigue=val end,
})

aL:AddToggle("PersonalBias",{
    Text="personal timing quirk", Value=true,
    Tooltip="picks a small, consistent 'a touch behind today' lean each run, like a real player's habit",
    Callback=function(val) hPersonalBias=val end,
})

aL:AddSeparator("ALS2",{})

aL:AddSlider("FingerSpeed",{
    Text="finger speed limit (kps)", Min=1, Max=100, Value=100, Step=1,
    Tooltip="going above this doesn't skip notes anymore — it just gets sloppier, the way a real hand would",
    Callback=function(v) fingerSpeedLimit=v end,
})

aL:AddToggle("AllowRealMiss",{
    Text="allow real misses on brutal bursts", Value=true,
    Tooltip="lets truly insane speed cause an occasional genuine miss, not just a sloppy hit",
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
            window:Notification({Title="difficulty scanner",Text="no song scanned yet — start a song first",Duration=3})
        else
            window:Notification({Title="song scanned",Text=buildScanMessage(lastScanResult),Duration=5})
        end
    end,
})

-- ── tune/ing ─────────────────────────────────────────────────────
local tL = tuneTab:AddLeftGroupbox( "TL", {Text="latency"    })
local tR = tuneTab:AddRightGroupbox("TR", {Text="hit chances" })

tL:AddToggle("AutoLatency",{
    Text="auto latency", Value=true,
    Tooltip="watches your timing and adjusts itself automatically — just leave it on",
    Callback=function(val)
        autoLatency=val
        if val and v8 then startAutoLatency() elseif not val then stopAutoLatency() end
        window:Notification({
            Title="auto latency",
            Text=val and "<font color='#C41E3A'>on</font> — adjusting itself" or "off — using manual slider",
            Duration=3
        })
    end,
})

tL:AddLabel("TLH",{Text="<font color='#888'>manual mode (auto latency off):\nif the ms counter shows + raise the slider  ·  if it shows - lower it</font>"})

tL:AddSlider("VimLatency",{
    Text="vim latency (ms)", Min=0, Max=300, Value=103, Step=1,
    Tooltip="a manual timing offset, only used while auto latency is off",
    Callback=function(v) if not autoLatency then vimLatencyMs=v end end,
})

tR:AddLabel("TRH",{Text="<font color='#D0D0D6'><b>these are weights, not percentages.</b></font>\nleave them all at 0 for perfect hits every time.\nlocked automatically while humanize (advanced bp tab) is on."})
tR:AddSeparator("TRS",{})
tR:AddSlider("PC",{Text="perfect",Min=0,Max=100,Value=100,Step=1,Callback=function(v) if not humanize then perfectChance=v end end})
tR:AddSlider("SC",{Text="sick",   Min=0,Max=100,Value=0,  Step=1,Tooltip="16.5-43.5ms",  Callback=function(v) if not humanize then sickChance=v end end})
tR:AddSlider("GC",{Text="good",   Min=0,Max=100,Value=0,  Step=1,Tooltip="43.5-76.5ms",  Callback=function(v) if not humanize then goodChance=v end end})
tR:AddSlider("OC",{Text="ok",     Min=0,Max=100,Value=0,  Step=1,Tooltip="76.5-106.5ms", Callback=function(v) if not humanize then okChance=v end end})
tR:AddSlider("BC",{Text="bad",    Min=0,Max=100,Value=0,  Step=1,Tooltip="106.5-130.5ms",Callback=function(v) if not humanize then badChance=v end end})
tR:AddSlider("MC",{Text="miss",   Min=0,Max=100,Value=0,  Step=1,                        Callback=function(v) if not humanize then missChance=v end end})

