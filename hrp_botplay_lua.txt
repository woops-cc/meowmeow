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
    warn("[hu's rhythm project] the library loader failed ("..tostring(res).."), loading the library file directly")
    for _, user in ipairs(LIBRARY_USERS) do
        local ok2, res2 = pcall(viaFile, user)
        if ok2 and res2 then return res2 end
        warn(("[hu's rhythm project] loading the library from %s failed: %s"):format(user, tostring(res2)))
    end
    warn("[hu's rhythm project] couldn't load the ui library")
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
                warn(("[hu's rhythm project] ui: %s:%s failed: %s"):format(label, tostring(key), tostring(res)))
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
    Title    = "<font color='#E8E8EC'><b>hu's rhythm project</b></font><font color='#C41E3A'> botplay</font>",
    Icon     = "125411711221424",
    Footer   = "<font color='#C41E3A'>woops &lt;3</font>  ·  hu's rhythm project  ·  "..VERSION,
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
        opts = {Title = "hu's rhythm project botplay", Keybind = Enum.KeyCode.RightShift}
    end
    local ok, res = pcall(function() return lib:Window("hrp_ap", opts) end)
    if ok and res then window = res; break end
    warn(("[hu's rhythm project] window attempt %d failed: %s"):format(attempt, tostring(res)))
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


local RunService = game:GetService("RunService")

local function f2(x) return type(x) == "number" and string.format("%.2f", x) or tostring(x) end

-- ---- state ----
local v8        = false
local botFlag   = true      -- keeps the game's own botplay flag on while the bot plays (see keepFlag)
local STEP_NAME = "hrp_botplay"
local looping   = false
local pfDone    = setmetatable({}, {__mode = "k"})   -- notes already pressed or skipped
local laneHold  = {}
local heldFake  = {}
local missJacks = false     -- no switch for this one in this script, the engine just expects it to exist

-- judgement weights, only used while humanize is off
local sickChance, goodChance, badChance, trashChance, missChance = 100, 0, 0, 0, 0

-- the game's own windows (ms off the strum time), read from ScoreUtils when it attaches
local JUDGE = {sick = 50, good = 130, bad = 148, trash = 166}

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
local hReactToSpikes = true
local hFlawless      = false   -- the flawless skill preset: still humanized, but every hit gets kept inside sick
local lastScanResult = nil     -- {totalSeconds=, noteCount=, spikes={ {t=,strain=}, ... }}
local chartIsInSpikeWindow
local hResetRun, scanChart, releaseAll

-- ---- the game ----
-- the game is an fnf style engine. its note functions (GoodHit, CheckInput, ...) are globals of the
-- GameHandler module, so they get found by name through getgc and the rest of the game state hangs
-- off their upvalues. everything is looked up by SHAPE (a table with SongPos, one with ratingWindow...)
-- instead of by upvalue number, so a game update that shifts the numbers doesnt break it
local G = {ready = false, scanning = false, lastScan = -math.huge, fails = 0, frameN = 0,
           rate = 1, step = 16.7, stepHi = 17, steps = {}, lastSP = nil, stall = 0, lastErr = 0, lists = nil}

function G.dinfo(f, what)
    local ok, v = pcall(debug.info, f, what)
    if ok then return v end
end

function G.ups(f)
    local gu = (debug and debug.getupvalues) or getupvalues
    if not gu or not f then return {}, 0 end
    local ok, t = pcall(gu, f)
    if not ok or type(t) ~= "table" then return {}, 0 end
    local max = 0
    for k in pairs(t) do
        if type(k) == "number" and k > max then max = k end
    end
    return t, max
end

function G.raw(t, k)
    local ok, v = pcall(rawget, t, k)
    if ok then return v end
end

local function pickUp(f, pred)
    local t, max = G.ups(f)
    for i = 1, max do
        local ok, hit = pcall(pred, t[i])
        if ok and hit then return t[i] end
    end
end

local NEED = {GoodHit = true, CheckInput = true, ScorePopup = true, HeldDirections = true, CheckSpawns = true}

function G.findInner()
    local gc = getgc()
    local found = {}
    local t0 = os.clock()
    for i = 1, #gc do
        local f = gc[i]
        if type(f) == "function" then
            local ok, src, _, nm = pcall(debug.info, f, "sln")
            if ok and NEED[nm] and not found[nm] and type(src) == "string" and src:find("GameHandler", 1, true) then found[nm] = f end
        end
        if i % 3000 == 0 then task.wait() end
        if os.clock() - t0 > 10 then break end
    end
    gc = nil
    return found
end

function G.bind(f)
    local ok, env = pcall(getfenv, f.GoodHit)
    local goodHit = ok and type(env) == "table" and G.raw(env, "GoodHit") or f.GoodHit
    local isT = function(v) return type(v) == "table" end
    local main = pickUp(f.ScorePopup, function(v) return isT(v) and type(G.raw(v, "settings")) == "table" and G.raw(v, "PlayerStats") ~= nil end)
    local cond = pickUp(f.ScorePopup, function(v) return isT(v) and type(G.raw(v, "SongPos")) == "number" end)
    local su   = pickUp(f.ScorePopup, function(v) return isT(v) and type(G.raw(v, "ratingWindow")) == "table" end)
    local ib   = pickUp(f.HeldDirections, function(v) return isT(v) and type(v.IsBindPressed) == "function" end)
    if not (goodHit and main and cond and ib) then return false end
    G.fn, G.goodHit, G.main, G.cond, G.ib = f, goodHit, main, cond, ib
    local w = su and su.ratingWindow
    if type(w) == "table" and type(w[1]) == "number" and type(w[4]) == "number" then
        JUDGE.sick, JUDGE.good, JUDGE.bad, JUDGE.trash = w[1], w[2], w[3], w[4]
    end
    G.ready = true
    return true
end

function G.find()
    if G.scanning or not getgc then return end
    G.scanning = true
    task.spawn(function()
        local ok, f = pcall(G.findInner)
        local good = ok and type(f) == "table" and f.GoodHit and f.CheckInput and f.ScorePopup and f.HeldDirections
        G.scanning = false
        if good and G.bind(f) then
            G.fails = 0
            window:Notification({Title = "botplay", Text = "found the game, it's ready", Duration = 3})
        else
            G.fails = G.fails + 1
        end
    end)
end

-- the lane tables get replaced every song, so they are re-read from CheckInput's upvalues every
-- few frames. true = a new song just started
function G.refresh()
    local t, max = G.ups(G.fn.CheckInput)
    local lists, recs
    for i = 1, max do
        local v = t[i]
        if type(v) == "table" then
            if type(v[1]) == "table" and G.raw(v[1], "CanBePressed") ~= nil then
                recs = v
            elseif not lists and (type(v[1]) == "table" or next(v) == nil) then
                lists = v
            end
        end
    end
    G.recs = recs
    G.song = pickUp(G.fn.HeldDirections, function(v) return type(v) == "table" and type(G.raw(v, "mania")) == "number" end)
    if lists and lists ~= G.lists then
        G.lists = lists
        return true
    end
    return false
end

-- the game judges a hit against SongPos + the time since this frame's update, so thats the clock
-- everything here runs on. chart ms, + diff = the note is still ahead
function G.timeNow()
    local el = 0
    local ok, v = pcall(G.main.getFrameElapsedMs)
    if ok and type(v) == "number" then el = v end
    return G.cond.SongPos + el
end

-- ---- botplay flag ----
-- the game stamps every note hit it sends to the server with shared.Botplay, and ScoreUtils skips the
-- sick leaderboard count while it is true. this keeps it true while the bot plays so bot runs stay
-- tagged as bot runs. the game resets it itself on the next song start. it has its own switch
local function keepFlag()
    if botFlag then shared.Botplay = true end
end

-- ---- held lanes ----
-- sustain pieces only get hit while the game thinks the lane is held. HeldDirections reads
-- UserInputBindables.IsBindPressed("Direction<lane>"), so while a hold is on that call answers true
-- for the lane. real input still passes straight through
local IBP = {}
local function installHold()
    local ib = G.ib
    if IBP.wrapper and ib.IsBindPressed == IBP.wrapper then return end
    IBP.orig = ib.IsBindPressed
    IBP.wrapper = function(name)
        local v = IBP.orig(name)
        if v then return v end
        if type(name) == "string" then
            local lane = tonumber(name:match("^Direction(%d+)$"))
            if lane and heldFake[lane] then return true end
        end
        return v
    end
    local ok = pcall(function() ib.IsBindPressed = IBP.wrapper end)
    if not ok then
        -- frozen module table: write the pressed-state table the original reads instead
        IBP.wrapper = nil
        IBP.tbl = (G.ups(IBP.orig))
        IBP.tbl = IBP.tbl and IBP.tbl[1]
    end
end

local function setHeld(lane, on)
    heldFake[lane] = on or nil
    if IBP.tbl and type(IBP.tbl) == "table" then IBP.tbl["Direction" .. lane] = on and true or false end
end

local function removeHold()
    if IBP.wrapper and G.ib and G.ib.IsBindPressed == IBP.wrapper then
        pcall(function() G.ib.IsBindPressed = IBP.orig end)
    end
    IBP.wrapper = nil
    for lane in pairs(heldFake) do setHeld(lane, false) end
end

local function stopHold(lane)
    laneHold[lane] = nil
    setHeld(lane, false)
end

releaseAll = function()
    for lane in pairs(laneHold) do laneHold[lane] = nil end
    for lane in pairs(heldFake) do setHeld(lane, false) end
end


-- ---- judgment bands ----
-- the band the error lands in IS the rating (sick / good / bad / trash, anything past trash is a miss)

-- random point INSIDE the rating's band, not just its edge
local function randomOffsetForRating(rating)
    local halfFrame = math.min(10, G.step / G.rate / 2)
    if rating == "sick"  then return math.random() * math.max(6, JUDGE.sick - halfFrame) end   -- a frame can land half a frame off, so stay clear of the edge
    if rating == "good"  then return JUDGE.sick + math.random() * (JUDGE.good  - JUDGE.sick) end
    if rating == "bad"   then return JUDGE.good + math.random() * (JUDGE.bad   - JUDGE.good) end
    if rating == "trash" then return JUDGE.bad  + math.random() * (JUDGE.trash - JUDGE.bad)  end
    return 0
end

local function pickRating()
    local pool = {}
    for _ = 1, sickChance  do pool[#pool + 1] = "sick"  end
    for _ = 1, goodChance  do pool[#pool + 1] = "good"  end
    for _ = 1, badChance   do pool[#pool + 1] = "bad"   end
    for _ = 1, trashChance do pool[#pool + 1] = "trash" end
    for _ = 1, missChance  do pool[#pool + 1] = "miss"  end
    if #pool == 0 then return "sick" end
    return pool[math.random(1, #pool)]
end

-- flawless preset: the humanize engine runs like normal (noise, drift, tilt, chords, holds, all of
-- it) and THEN every error gets squeezed into a safe slice of the sick window. slips and drops
-- turn into an edge-of-the-slice hit instead of a miss, so it stays human but never leaves 100%
local function flawlessBand()
    return math.clamp(JUDGE.sick - (G.step / G.rate) / 2 - 14, 6, 26)
end

local function flawlessLimit(e)
    local band = flawlessBand()
    local x = math.clamp(e / band, -20, 20)
    local ex = math.exp(2 * x)
    return band * (ex - 1) / (ex + 1)   -- tanh by hand, squashes big errors instead of piling them on the edge
end

-- how far past the target a frame is allowed to press (chart ms). half a frame normally, more when
-- the frames come uneven so one long frame cant throw the hit out of the slice
local function flawlessSlack(tgt)
    local sickC = JUDGE.sick * G.rate
    local lo = math.max(G.step / 2, G.stepHi - sickC + 8 - tgt)
    local hi = sickC - 8 - tgt
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
    personalBiasMs = gaussianRandom() * 2.5
    for i = 1, 9 do hLaneBias[i] = gaussianRandom() * 2.2 end
    hChordDir = (math.random() < 0.5) and 1 or -1
    hDrift, hFocus, hTilt = 0, 0, 0
    hLastNoise, hLastNoiseT, hLastT = 0, 0, nil
    for i = 1, 9 do hLaneHit[i] = -math.huge end
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
        local off = math.min(randomOffsetForRating(rating), JUDGE.trash - 3)
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
    return math.clamp(e, -(JUDGE.trash - 3), JUDGE.trash - 3), sigma
end

-- ---- the player's hands ----
-- each note gets decided ONCE, ahead of time (hDecide), then pressed on the frame that lands
-- closest to the error it was given. the game judges a hit at SongPos + the time since its last
-- update, so the diff we read right before pressing is exactly the diff it will judge
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
                else es[k] = math.clamp(gaussianRandom() * sig * 1.3 + 6, -(JUDGE.trash - 3), JUDGE.trash - 3) end
            end
        else
            for k = 1, size do
                if k == 1 then es[k] = e1
                else es[k] = math.clamp(e1 + gaussianRandom() * 0.35 * sig, -(JUDGE.trash - 3), JUDGE.trash - 3) end
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

-- how a hold gets let go (offset from the end in ms, + = late). normally around the end, never on
-- the exact frame. every so often way too soon, which breaks it (yes on purpose)
local function hHoldPlan(note, tnow)
    local plan = {note = note, t0 = tnow, hitAt = G.clockNow, endT = note.StrumTime + note.SustainLength, relOff = 8}
    if humanize and hHumanHolds then
        plan.relOff = math.clamp(10 + gaussianRandom() * 35, -60, 90)
        if hFlawless then plan.relOff = math.clamp(8 + gaussianRandom() * 7, -4, 24) end
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

-- the game hits the pieces of a hold itself every frame while the lane counts as held, and it hits
-- everything inside the last 150ms of the hold in one go, so letting go ~100ms early is still safe
local function holdTick(lane, tnow)
    local hp = laneHold[lane]
    if not hp then return end
    local n = hp.note
    local want = hp.endT + hp.relOff * G.rate
    local drop = hp.dropFrac and (G.clockNow - hp.hitAt) >= hp.dropFrac * (hp.endT - hp.hitAt)
    if drop or G.clockNow + G.step / 2 >= want or tnow - hp.t0 > 60 or n.Destroyed then stopHold(lane) end
end

-- one note, one press: the game's own GoodHit, the same call its keyboard handler ends in
local function pressNote(lane, it, tnow)
    keepFlag()
    local ok, err = pcall(G.goodHit, it.note)
    if not ok then
        if tick() - G.lastErr > 2 then G.lastErr = tick(); warn("[hrp] GoodHit failed: " .. tostring(err)) end
        return
    end
    if (it.note.SustainLength or 0) > 1 then
        laneHold[lane] = hHoldPlan(it.note, tnow)
        setHeld(lane, true)
    end
end

local function humanHands(lanes, all, tnow)
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
            hPlanGroup(group, all, tnow)
            i = j
        end
    end

    for lane = 1, #lanes do
        local list = lanes[lane]
        local k = 1
        while k <= #list do
            local it = list[k]
            if pfDone[it.note] then
                k = k + 1
            else
                local p = hPlan[it.note]
                if not p then break end
                local tgt = -p.e * G.rate
                if it.early <= tgt + (hFlawless and flawlessSlack(tgt) or dtHalf) then
                    if not it.note.CanBeHit then break end   -- the game doesnt count it as hittable yet, next frame
                    pfDone[it.note] = true
                    pressNote(lane, it, tnow)
                    k = k + 1
                else
                    break
                end
            end
        end
    end
end

-- ---- difficulty scanner ----
-- reads the chart straight from the game: the queue of notes CheckSpawns still has to spawn. it
-- never touches the hitting. turning on the bot mid song just scans what is left of the song
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
    local t, max = G.ups(G.fn.CheckSpawns)
    local q
    for i = 1, max do
        local v = t[i]
        if type(v) == "table" and #v > 20 and type(v[1]) == "table" and type(G.raw(v[1], "StrumTime")) == "number" then
            if not q or #v > #q then q = v end
        end
    end
    if not q then return end
    local notes = {}
    for _, n in ipairs(q) do
        if n.MustPress ~= false and type(n.StrumTime) == "number" then
            notes[#notes + 1] = {t = n.StrumTime / 1000, lane = (n.NoteData or 0) + 1}
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
    if hAutoScan then
        window:Notification({Title = "song scanned", Text = buildScanMessage(lastScanResult), Duration = 5})
    end
end

chartIsInSpikeWindow = function()
    if not (lastScanResult and lastScanResult.spikes) then return false end
    local now = G.clockNow / 1000
    for _, sp in ipairs(lastScanResult.spikes) do
        if math.abs(now - sp.t) < 1.5 then return true end
    end
    return false
end

-- ---- main loop ----
-- bound at the very end of the render step, after the game's own updates
local function frame(dt)
    if not v8 then return end
    local tnow = tick()
    if not G.ready then
        if not G.scanning and tnow - G.lastScan > ((G.fails >= 3) and 6 or 1.5) then
            G.lastScan = tnow
            G.find()
        end
        return
    end
    if not IBP.wrapper and not IBP.tbl then installHold() end

    G.frameN = G.frameN + 1
    if G.frameN % 20 == 1 then
        if G.refresh() then
            releaseAll()
            hResetRun()
            G.lastSP, G.stall, G.steps = nil, 0, {}
            pcall(scanChart)
        end
    end
    local lists = G.lists
    if not lists or #lists == 0 then return end
    local cond = G.cond
    local sp = cond.SongPos
    if type(sp) ~= "number" then return end
    if G.lastSP and sp == G.lastSP then
        G.stall = G.stall + 1
        if G.stall >= 3 then return end   -- paused, or between songs
    else
        G.stall = 0
    end
    if G.lastSP then
        local s = sp - G.lastSP
        if s > 0 and s < 120 then
            local st = G.steps
            st[#st + 1] = s
            if #st > 24 then table.remove(st, 1) end
            local sorted, hi = {}, 0
            for _, v in ipairs(st) do sorted[#sorted + 1] = v end
            table.sort(sorted)
            G.step = sorted[math.ceil(#sorted / 2)]
            for k = math.max(1, #st - 11), #st do hi = math.max(hi, st[k]) end
            G.stepHi = math.min(hi, 80)
        end
    end
    G.lastSP = sp
    G.rate = cond.RateScale or 1
    local now = G.timeNow()
    G.clockNow = now
    keepFlag()

    local rate = G.rate
    local nl = #lists
    local lanes, all = {}, {}
    for l = 1, nl do lanes[l] = {} end
    for lane = 1, nl do
        local list = lists[lane]
        local rec = G.recs and G.recs[lane]
        if type(list) == "table" and not (rec and rec.CanBePressed == false) then
            for i = 1, #list do
                local n = list[i]
                if not pfDone[n] and n.MustPress ~= false and not n.IsSustain and not n.GoodHit and not n.TooLate and n.Update ~= nil then
                    local hl = n.HealthLoss
                    if (type(hl) == "number" and hl > 0) or n.shouldPress == false then
                        pfDone[n] = true     -- mines and fake notes never get touched
                    else
                        local d = n.StrumTime - now
                        if d < 1000 * rate and d > -JUDGE.trash then
                            local it = {note = n, lane = lane, early = d, rem = d / 1000 / rate}
                            lanes[lane][#lanes[lane] + 1] = it
                            all[#all + 1] = it
                        end
                    end
                end
            end
        end
    end
    for l = 1, nl do table.sort(lanes[l], function(a, b) return a.early < b.early end) end
    table.sort(all, function(a, b) return a.early < b.early end)

    for l = 1, nl do holdTick(l, tnow) end
    humanHands(lanes, all, tnow)
end

local function stopLoop()
    if not looping then return end
    looping = false
    pcall(function() RunService:UnbindFromRenderStep(STEP_NAME) end)
    releaseAll()
    removeHold()
end

local function startLoop()
    stopLoop()
    looping = true
    RunService:BindToRenderStep(STEP_NAME, Enum.RenderPriority.Last.Value, function(dt)
        local ok, err = pcall(frame, dt)
        if not ok then
            local t = tick()
            if t - G.lastErr > 2 then G.lastErr = t; warn("[hrp] loop error: " .. tostring(err)) end
        end
    end)
end


-- ---- ui which looks amazing btw ----
local infoTab = window:AddTab("InfoTab", {Text="info",        Icon="info"    })
local playTab = window:AddTab("PlayTab", {Text="botplay",     Icon="play"    })
local advTab  = window:AddTab("AdvTab",  {Text="advanced bp", Icon="sparkles"})

-- ?? info tab ??
local iL = infoTab:AddLeftGroupbox("IL",  {Text="about"       })
local iR = infoTab:AddRightGroupbox("IR", {Text="feature list" })

iL:AddLabel("IL1",{Text="<font color='#C41E3A'><b>hu's rhythm project botplay</b></font> by woops &lt;3\n\nplays hu's rhythm project for you, automatically.\nhumanize makes it look genuinely played, or set exactly how every hit should be judged with the hit chances."})
iL:AddSeparator("ILS1",{})
iL:AddLabel("IL2",{Text="<font color='#D0D0D6'><b>recommended setup:</b></font>\n• humanize (advanced bp tab) → on, for a run that looks genuinely played\n• skill preset → flawless for a humanized run that is always 100%\n• tag runs as botplay → leave it on so bot runs stay tagged as bot runs"})
iL:AddSeparator("ILS2",{})
iL:AddLabel("IL3",{Text="<b>right shift</b> = open / close the menu"})

iR:AddLabel("IR1",{Text="<font color='#C41E3A'><b>botplay tab</b></font>"})
iR:AddLabel("IR2",{Text="enable → turns botplay on or off\ntag runs as botplay → the game stamps every note hit with a botplay flag and doesn't count sick ratings for the leaderboard while it's on. this keeps it on while the bot plays\nhit chances → weights, not percentages, only used while humanize is off"})
iR:AddSeparator("IRS1",{})
iR:AddLabel("IR3",{Text="<font color='#D0D0D6'><b>advanced bp tab</b></font>"})
iR:AddLabel("IR3B",{Text="humanize → plays with realistic, human-like timing instead of frame-perfect hits. every part of it is its own switch, so mix and match\nskill preset, accuracy, consistency, mistakes → how good, and how steady, this 'player' is\nflawless preset → still humanized, but every hit stays sick so it's always 100%\ndifficulty scanner → points out a song's hardest sections the moment it loads"})
iR:AddSeparator("IRS2",{})
iR:AddLabel("IR5",{Text="<font color='#C41E3A'><b>works with</b></font>\n• any song rate, 4k up to 9k\n• hold notes\n• mines and fake notes are left alone"})

-- ?? botplay tab (where the magic happens) ??
local pL = playTab:AddLeftGroupbox( "PL", {Text="botplay"     })
local pR = playTab:AddRightGroupbox("PR", {Text="hit chances" })

pL:AddToggle("Enable",{
    Text="enable", Value=false,
    Tooltip="turns botplay on or off",
    Callback=function(val)
        v8 = val
        if v8 then
            if not (getgc and getfenv and debug and debug.info) then
                window:Notification({Title="botplay",Text="your executor is missing getgc / getfenv / debug.info, this script can't run on it",Duration=6})
            end
            releaseAll()
            G.fails, G.lastScan = 0, -math.huge
            startLoop()
            window:Notification({Title="botplay",Text="<font color='#C41E3A'><b>on</b></font>",Duration=2})
        else
            stopLoop()
            window:Notification({Title="botplay",Text="off",Duration=2})
        end
    end,
})

pL:AddToggle("BotFlag",{
    Text="tag runs as botplay", Value=true,
    Tooltip="the game stamps every note hit with a botplay flag and doesn't count sick ratings for the leaderboard while it's on. leave this on so bot runs stay tagged as bot runs. turn it off and your hits count like a real player's, which can get you flagged",
    Callback=function(val)
        botFlag = val
        if not val and shared.Botplay == true then shared.Botplay = false end
        window:Notification({Title="botplay tag",Text=val and "<font color='#C41E3A'>on</font>, runs are tagged as bot runs" or "off, your hits count like a real player's",Duration=3})
    end,
})

pR:AddLabel("TRH",{Text="<font color='#D0D0D6'><b>these are weights, not percentages.</b></font>\nleave them all at 0 except sick for perfect hits every time.\nlocked automatically while humanize (advanced bp tab) is on."})
pR:AddSeparator("TRS",{})
pR:AddSlider("SC",{Text="sick",  Min=0,Max=100,Value=100,Step=1,Tooltip="0-50ms",    Callback=function(v) if not humanize then sickChance=v end end})
pR:AddSlider("GC",{Text="good",  Min=0,Max=100,Value=0,  Step=1,Tooltip="50-130ms",  Callback=function(v) if not humanize then goodChance=v end end})
pR:AddSlider("BC",{Text="bad",   Min=0,Max=100,Value=0,  Step=1,Tooltip="130-148ms", Callback=function(v) if not humanize then badChance=v end end})
pR:AddSlider("TC",{Text="trash", Min=0,Max=100,Value=0,  Step=1,Tooltip="148-166ms", Callback=function(v) if not humanize then trashChance=v end end})
pR:AddSlider("MC",{Text="miss",  Min=0,Max=100,Value=0,  Step=1,                     Callback=function(v) if not humanize then missChance=v end end})

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
    Tooltip="one tap setups for accuracy, consistency and mistakes. 'custom' leaves the sliders alone. 'flawless' keeps everything humanized but never lets a hit leave the sick window, so it's always a 100% run",
    Callback=function(val)
        local name = (type(val)=="number") and presetNames[val] or val
        local wasFlawless = hFlawless
        hFlawless = (name == "flawless")
        if hFlawless ~= wasFlawless then
            window:Notification({Title="skill preset",Text=hFlawless and "<font color='#C41E3A'>flawless</font>, still humanized but every hit stays sick" or "flawless off",Duration=3})
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



