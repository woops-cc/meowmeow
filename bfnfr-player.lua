local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Null-Cherry/Fire-Library/refs/heads/main/Loader.lua", true))()

-- ── palette (ui colors or something like that) ──
local C_BLUE   = Color3.fromRGB(91,  200, 245)   -- sky blue  #5BC8F5
local C_ORANGE = Color3.fromRGB(245, 166, 35)    -- gold      #F5A623
local C_BG     = Color3.fromRGB(18,  18,  22)    -- dark bg
local C_WHITE  = Color3.fromRGB(220, 220, 225)   -- soft white text

local window = lib:Window("bfnfr_ap", {
    Title    = "<font color='#5BC8F5'><b>fnf:r</b></font><font color='#F5A623'> autoplay</font>",
    Icon     = "76468651273482",
    Footer   = "<font color='#5BC8F5'>woops <3</font>  ·  basically fnf: remix",
    Keybind  = Enum.KeyCode.RightShift,
    NeonType      = "Top",
    NeonThickness = 2,
    AnimationSpeed     = 1.2,
    ShadowTransparency = 0.4,
    ShadowSize         = 20,
    Image             = "110348582183473",
    ImageEnabled      = true,
    ImageTransparency = 0.35,
    ImageColor        = Color3.new(1, 1, 1),
    Theme = { Back=C_BG, Main=C_BLUE, Stroke=C_ORANGE, Text=C_WHITE },
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
-- auto latency ( pure proportional controller, median-based ):
--   NO integral term (when i tested it was causing overshooting and stuffs)
--   uses MEDIAN of last 8 readings (immune to hold/miss outliers)
--   hunt:   sample every fresh text change, correct by median * GAIN
--           locks after 10 consecutive samples where |median| <= 2ms
--   locked: sample every 1s, correct by median * 0.03 (near-frozen)
--           re-hunts only if |median| > 5ms for 8 consecutive samples
--   stale guard: skip if msIndic text unchanged in last 0.35s
-- ════════════════════════════════════════════════════════════
local vimLatencyMs    = 111
local autoLatency     = true
local autoLatencyConn = nil
local alSongWatcher   = nil
local alPhase         = "hunt"

local HUNT_GAIN     = 0.30   -- fraction of median error to correct per sample
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
            if c.Name == "MatchFrame" then alReset("hunt") end
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
        -- tight outlier window: holds/misses produce large values we ignore
        if not val or math.abs(val) > 35 then return end

        table.insert(alBuf, val)
        if #alBuf > BUF_SIZE then table.remove(alBuf, 1) end
        if #alBuf < 3 then return end  -- need at least 3 samples for stable median

        local med = alMedian()

        if alPhase == "hunt" then
            -- pure proportional: correct by a fraction of the median error
            -- no integral = no overshoot, converges smoothly to 0
            vimLatencyMs = math.clamp(vimLatencyMs + med * HUNT_GAIN, 0, 300)

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
local legitMode     = false
local perfected     = false
local tileLights    = false
local mainLoop      = nil

local laneHoldFrame = {nil,nil,nil,nil}
local lanePressed   = {false,false,false,false}
local seenNotes     = {}

local minReaction   = 0
local maxReaction   = 0
local legitKpsLimit = 100
local perfectChance = 100
local sickChance    = 0
local goodChance    = 0
local okChance      = 0
local badChance     = 0
local missChance    = 0
local platformContent    = "😇"
local platformAutoRejoin = true
local kpsLog = {}

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

local function vimTap(lane)
    vimUp(lane); vimDown(lane)
    task.delay(TAP_DUR, function() vimUp(lane) end)
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
    task.delay(rem, function()
        if laneHoldFrame[lane] == holdFrame then stopHold(lane,false) end
    end)
end

-- ════════════════════════════════════════════════════════════
-- helpers
-- ════════════════════════════════════════════════════════════
local HIT_OFF = {sick=0.045, good=0.075, ok=0.125, bad=0.175}

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

local function canPress()
    if not legitMode then return true end
    local now=tick(); local i=1
    while i<=#kpsLog do
        if now-kpsLog[i]>1 then table.remove(kpsLog,i) else i=i+1 end
    end
    if #kpsLog>=legitKpsLimit then return false end
    kpsLog[#kpsLog+1]=now; return true
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
-- note handler !!!
-- ════════════════════════════════════════════════════════════
local function handleNote(lane, isHold, holdFrame, arrowFrame, sync, spd)
    if not canPress() then return end
    local rating = pickRating()
    if rating=="miss" then return end
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
        fire()
    else
        task.spawn(function()
            if maxReaction > 0 then
                local lo=math.min(minReaction,maxReaction)
                local hi=math.max(minReaction,maxReaction)
                task.wait((lo==hi and lo or math.random(lo,hi))/1000)
            end
            if rating~="perfect" then
                local off=HIT_OFF[rating]
                if off then task.wait(off) end
            end
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
local function startLoop()
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

            if laneHoldFrame[lane] then stopHold(lane,true) end
            handleNote(lane, isHold, holdFrame, af, sync, spd)

            best.AncestryChanged:Once(function() seenNotes[best]=nil end)
        end
    end

    if perfected then
        mainLoop = RunService.RenderStepped:Connect(function() tick_fn(true) end)
    else
        mainLoop = RunService.Heartbeat:Connect(function() tick_fn(false) end)
    end
end

-- ════════════════════════════════════════════════════════════
-- ui which looks amazing btw
-- ════════════════════════════════════════════════════════════
local infoTab  = window:AddTab("InfoTab",  {Text="ℹ info"   })
local playTab  = window:AddTab("PlayTab",  {Text="▶ play"   })
local tuneTab  = window:AddTab("TuneTab",  {Text="◈ tune"   })
local miscTab  = window:AddTab("MiscTab",  {Text="✦ misc"   })

-- ── info ─────────────────────────────────────────────────────
local iL = infoTab:AddLeftGroupbox("IL",  {Text="about"       })
local iR = infoTab:AddRightGroupbox("IR", {Text="feature list" })

iL:AddLabel("IL1",{Text="<font color='#5BC8F5'><b>fnf:r autoplay</b></font> by woops <3\n\nplays basically fnf: remix for you.\nperfected mode hits ~0ms consistently.\nauto latency self-tunes after ~3 seconds."})
iL:AddSeparator("ILS1",{})
iL:AddLabel("IL2",{Text="<font color='#F5A623'><b>recommended:</b></font>\n• perfected → on\n• auto latency → on\n• all hit chances at 0 (always perfect)"})
iL:AddSeparator("ILS2",{})
iL:AddLabel("IL3",{Text="<b>rightshift</b> = open / close"})

iR:AddLabel("IR1",{Text="<font color='#5BC8F5'><b>play tab</b></font>"})
iR:AddLabel("IR2",{Text="enable → turns autoplay on/off\nperfected → renderstep timing (best accuracy)\ntile lights → lights up mobile buttons cosmetically\nmiss jacks → skips rapid same-key notes\nlegit mode → human-like kps cap + mixed ratings"})
iR:AddSeparator("IRS1",{})
iR:AddLabel("IR3",{Text="<font color='#F5A623'><b>tune tab</b></font>"})
iR:AddLabel("IR4",{Text="auto latency → reads ms counter, self-tunes.\n  hunt phase: fast corrections every 0.25s\n  locked phase: near-frozen, micro-nudge only\n  re-hunts automatically if timing drifts\nvim latency → manual override (auto off only)\nhit chances → weights, not %. 0 = always perfect."})
iR:AddSeparator("IRS2",{})
iR:AddLabel("IR5",{Text="<font color='#5BC8F5'><b>supported</b></font>\n✓ sv (mid-song speed changes)\n✓ up & down scroll\n✓ mod charts\n✓ 60fps+  ✓ low fps (lag rescue scan)\n✓ hold notes  ✓ short holds (blue notes)"})

-- ── play ─────────────────────────────────────────────────────
local pL = playTab:AddLeftGroupbox( "PL", {Text="auto player"  })
local pR = playTab:AddRightGroupbox("PR", {Text="legit options" })

pL:AddToggle("Enable",{
    Text="enable", Value=false,
    Tooltip="start or stop the auto player",
    Callback=function(val)
        v8=val
        if v8 then
            laneHoldFrame={nil,nil,nil,nil}; lanePressed={false,false,false,false}
            for i=1,4 do vimUp(i) end
            seenNotes={}; startLoop()
            if autoLatency then startAutoLatency() end
            window:Notification({Title="autoplay",Text="<font color='#5BC8F5'><b>on</b></font>",Duration=2})
        else
            for i=1,4 do
                if laneHoldFrame[i] then stopHold(i,false) end
                vimUp(i)
            end
            if mainLoop then mainLoop:Disconnect(); mainLoop=nil end
            stopAutoLatency()
            laneHoldFrame={nil,nil,nil,nil}; lanePressed={false,false,false,false}
            seenNotes={}
            window:Notification({Title="autoplay",Text="off",Duration=2})
        end
    end,
})

pL:AddToggle("Perfected",{
    Text="perfected", Value=false,
    Tooltip="uses renderstep — most accurate timing, closest to 0ms",
    Callback=function(val)
        perfected=val
        if val then minReaction=0; maxReaction=0 end
        if v8 then if mainLoop then mainLoop:Disconnect(); mainLoop=nil end; startLoop() end
        window:Notification({Title="perfected",Text=val and "<font color='#5BC8F5'>on</font>" or "off",Duration=2})
    end,
})

pL:AddToggle("TileLights",{
    Text="tile lights", Value=false,
    Tooltip="lights up the mobile receptor tiles on keypress",
    Callback=function(val)
        tileLights=val
        if not val then
            for i=1,4 do local t=getMobileTile(i); if t then t.ImageTransparency=0.8 end end
        end
        window:Notification({Title="tile lights",Text=val and "<font color='#5BC8F5'>on</font>" or "off",Duration=2})
    end,
})

pL:AddToggle("MissJacks",{
    Text="miss jack notes", Value=false,
    Tooltip="skips fast repeated notes on the same key",
    Callback=function(val) missJacks=val end,
})

pR:AddToggle("LegitMode",{
    Text="legit mode", Value=false,
    Tooltip="mixes in sicks/goods and caps kps to look human",
    Callback=function(val)
        legitMode=val
        if val then
            perfectChance=35; sickChance=45; goodChance=15; okChance=4; badChance=1; missChance=0
        else
            perfectChance=100; sickChance=0; goodChance=0; okChance=0; badChance=0; missChance=0
        end
        window:Notification({Title="legit mode",Text=val and "<font color='#5BC8F5'>on</font>" or "off",Duration=2})
    end,
})

pR:AddSlider("LegitKps",{
    Text="kps limit", Min=1, Max=100, Value=100, Step=1,
    Tooltip="max keypresses per second in legit mode",
    Callback=function(v) legitKpsLimit=v end,
})

pR:AddSeparator("PRS1",{})

pR:AddSlider("MinReaction",{
    Text="min reaction (ms)", Min=0, Max=200, Value=0, Step=1,
    Tooltip="minimum artificial delay. ignored when perfected is on",
    Callback=function(v) if not perfected then minReaction=v end end,
})
pR:AddSlider("MaxReaction",{
    Text="max reaction (ms)", Min=0, Max=200, Value=0, Step=1,
    Tooltip="maximum artificial delay. ignored when perfected is on",
    Callback=function(v) if not perfected then maxReaction=v end end,
})

-- ── tune/ing ─────────────────────────────────────────────────────
local tL = tuneTab:AddLeftGroupbox( "TL", {Text="latency"    })
local tR = tuneTab:AddRightGroupbox("TR", {Text="hit chances" })

tL:AddToggle("AutoLatency",{
    Text="auto latency", Value=true,
    Tooltip="reads the ms counter and self-tunes. hunt → locked. locked is near-frozen and re-hunts if timing drifts.",
    Callback=function(val)
        autoLatency=val
        if val and v8 then startAutoLatency() elseif not val then stopAutoLatency() end
        window:Notification({
            Title="auto latency",
            Text=val and "<font color='#5BC8F5'>on</font> — self-tuning" or "off — manual slider",
            Duration=3
        })
    end,
})

tL:AddLabel("TLH",{Text="<font color='#888'>manual (auto latency off):\nms shows + → raise  ·  ms shows - → lower</font>"})

tL:AddSlider("VimLatency",{
    Text="vim latency (ms)", Min=0, Max=300, Value=103, Step=1,
    Tooltip="only used when auto latency is off",
    Callback=function(v) if not autoLatency then vimLatencyMs=v end end,
})

tR:AddLabel("TRH",{Text="<font color='#F5A623'><b>weights, not percentages.</b></font>\nall 0 = always perfect.\nlocked while legit mode is on."})
tR:AddSeparator("TRS",{})
tR:AddSlider("PC",{Text="perfect",Min=0,Max=100,Value=100,Step=1,Callback=function(v) if not legitMode then perfectChance=v end end})
tR:AddSlider("SC",{Text="sick",   Min=0,Max=100,Value=0,  Step=1,Tooltip="+45ms",  Callback=function(v) if not legitMode then sickChance=v end end})
tR:AddSlider("GC",{Text="good",   Min=0,Max=100,Value=0,  Step=1,Tooltip="+75ms",  Callback=function(v) if not legitMode then goodChance=v end end})
tR:AddSlider("OC",{Text="ok",     Min=0,Max=100,Value=0,  Step=1,Tooltip="+125ms", Callback=function(v) if not legitMode then okChance=v end end})
tR:AddSlider("BC",{Text="bad",    Min=0,Max=100,Value=0,  Step=1,Tooltip="+175ms", Callback=function(v) if not legitMode then badChance=v end end})
tR:AddSlider("MC",{Text="miss",   Min=0,Max=100,Value=0,  Step=1,                  Callback=function(v) if not legitMode then missChance=v end end})

-- ── miscellaneous which is like entirely empty rn (soon..) ─────────────────────────────────────────────────────
local mG = miscTab:AddLeftGroupbox("MG",{Text="platform display"})

mG:AddToggle("PAR",{
    Text="auto rejoin after applying", Value=true,
    Callback=function(v) platformAutoRejoin=v end,
})
mG:AddTextBox("PC2",{
    Text="display content", Value="😇", PlaceholderText="text or emoji...",
    Callback=function(v) if v and v~="" then platformContent=v end end,
})
mG:AddButton("APB",{
    Text="apply platform display",
    Callback=function()
        if game.PlaceId~=6520999642 then
            window:Notification({Title="error",Text="wrong game",Duration=3}); return
        end
        if not(isfile and readfile and writefile) then
            window:Notification({Title="error",Text="executor not supported",Duration=3}); return
        end
        local Q=(syn and syn.queue_on_teleport)
            or (fluxus and fluxus.queue_on_teleport)
            or (queue_on_teleport and queue_on_teleport)
        if not Q then
            window:Notification({Title="error",Text="missing queue_on_teleport",Duration=3}); return
        end
        local C=platformContent
        writefile("FNFRemixDisplayContent.txt",tostring(C))
        local SG=game:GetService("StarterGui")
        local P=game:GetService("Players")
        local TPS=game:GetService("TeleportService")
        local Spk=P.LocalPlayer
        local function Alert()
            local s=Instance.new("Sound",game:GetService("SoundService"))
            s.Volume=2; s.SoundId="rbxassetid://4590662766"; s.PlayOnRemove=true; s:Destroy()
        end
        if _G.FNFRemixACPD or (getgenv and getgenv().FNFRemixACPD) then
            SG:SetCore("SendNotification",{Title="🧐 changed!",Text="'"..C.."'",Duration=5})
            Alert(); return
        end
        local Rej=Instance.new("BindableFunction")
        Rej.OnInvoke=function(Ans)
            if Ans=="Yes" and platformAutoRejoin then
                if #P:GetPlayers()<=1 then
                    Spk:Kick("\nrejoining..."); task.wait(); TPS:Teleport(6520999642,Spk)
                else
                    TPS:TeleportToPlaceInstance(6520999642,game.JobId,Spk)
                end
            end
        end
        Q([[
            if game.PlaceId~=6520999642 then return end
            if not(isfile and readfile) then return end
            local C=(isfile('FNFRemixDisplayContent.txt') and readfile('FNFRemixDisplayContent.txt')) or '😇'
            local Spk=game:GetService'Players'.LocalPlayer
            task.spawn(function()
                local cn
                cn=Spk:WaitForChild'PlayerScripts'.ChildAdded:Connect(function(ch)
                    if ch:IsA'LocalScript' and ch.Name=='PlatformDisplay' then
                        ch.Disabled=true; cn:Disconnect()
                    end
                end)
            end)
            game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild'PlatformRemoteEvent':FireServer(tostring(C))
        ]])
        SG:SetCore("SendNotification",{
            Title=platformAutoRejoin and "🧐 rejoin?" or "🧐 done",
            Text=platformAutoRejoin and "rejoin to apply '"..C.."'?" or "rejoin manually.",
            Button1="Yes",Button2="No",Duration=(1/0),Callback=Rej,
        })
        Alert()
        window:Notification({Title="platform",Text="set: "..C,Duration=4})
        if getgenv then getgenv().FNFRemixACPD=true else _G.FNFRemixACPD=true end
    end,
})
