local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Null-Cherry/Fire-Library/refs/heads/main/Loader.lua", true))()

local C_BLUE   = Color3.fromRGB(91,  200, 245)
local C_ORANGE = Color3.fromRGB(245, 166, 35)
local C_WHITE  = Color3.fromRGB(220, 220, 225)
local C_BG     = Color3.fromRGB(18,  18,  22)

local window = lib:Window("w0opsie_ap", {
    Title    = "<font color='#5BC8F5'>w0</font><font color='#F5A623'>o</font><font color='#5BC8F5'>opsie's ap</font>",
    Icon     = "76468651273482",
    Footer   = "<font color='#5BC8F5'>Basically FNF: Remix</font>",
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

-- ═══════════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════════
local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VIM          = game:GetService("VirtualInputManager")
local Players      = game:GetService("Players")
local v5           = Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════
-- TIMING & AUTO-LATENCY
-- ───────────────────────────────────────────────────────────────
-- Perfect window: |scale| <= 0.71775 * spd  (from NoteInput source)
-- Trigger:        triggerScale = (0.71775 - latSec*5.5) * spd
--
-- AUTO-LATENCY — two-phase adaptive controller:
--
--   HUNT phase  (fast, 0.3s samples):
--     Read msIndic, adjust vimLatencyMs by error*GAIN each sample.
--     When rolling average |error| < LOCK_THRESH for LOCK_N samples
--     in a row → enter LOCKED phase.
--
--   LOCKED phase (slow, 1s samples):
--     Only tiny corrections (GAIN*0.1). Track quality:
--       • perfectStreak: increments on each sample within threshold
--       • badStreak: increments when |avg| > LOCK_THRESH
--     If badStreak >= UNLOCK_BAD → back to HUNT.
--     If perfectStreak >= PERFECT_LOCK → freeze (no more corrections).
--
--   FROZEN phase: vimLatencyMs is fixed. Re-activates HUNT if
--     5+ consecutive readings are bad (timing drifted, e.g. scroll
--     speed changed).
--
--   KEY: msIndic only updates when _G.Settings.HitLate=true.
--   We force it on internally and restore it when stopping.
--   Outliers >±50ms are ignored (those are misses/holds, not drift).
-- ═══════════════════════════════════════════════════════════════
local vimLatencyMs     = 103
local autoLatency      = true
local autoLatencyConn  = nil
local alPhase          = "hunt"   -- "hunt" | "locked" | "frozen"

local GAIN           = 0.5
local LOCK_THRESH    = 3     -- ms: avg error below this → good
local LOCK_N         = 8     -- consecutive good samples to lock
local UNLOCK_BAD     = 5     -- consecutive bad samples to re-hunt
local PERFECT_LOCK   = 40   -- consecutive locked-good samples to freeze
local HUNT_INTERVAL  = 0.3
local LOCK_INTERVAL  = 1.0
local OUTLIER_MAX    = 50    -- ms: ignore readings beyond this

local alBuf          = {}
local AL_BUF_SIZE    = 12
local alGoodStreak   = 0
local alBadStreak    = 0
local alPerfStreak   = 0
local alSavedHitLate = false

local function alAvg()
    if #alBuf == 0 then return 0 end
    local s = 0; for _,v in ipairs(alBuf) do s=s+v end
    return s / #alBuf
end

local function calcTriggerScale(spd)
    local coeff = math.clamp(0.71775 - (vimLatencyMs/1000)*5.5, 0.05, 0.71775)
    return coeff * spd
end

local function startAutoLatency()
    if autoLatencyConn then autoLatencyConn:Disconnect() end
    alBuf={}; alGoodStreak=0; alBadStreak=0; alPerfStreak=0
    alPhase = "hunt"
    alSavedHitLate = _G.Settings and _G.Settings.HitLate or false
    if _G.Settings then _G.Settings.HitLate = true end

    local lastSample = 0
    autoLatencyConn = RunService.Heartbeat:Connect(function()
        if not autoLatency then return end
        local now = tick()
        local interval = (alPhase=="hunt") and HUNT_INTERVAL or LOCK_INTERVAL
        if now - lastSample < interval then return end
        lastSample = now

        local mf = v5.PlayerGui:FindFirstChild("Main")
               and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
        if not mf then return end
        local ind = mf:FindFirstChild("msIndic")
        if not (ind and ind.Visible) then return end

        local val = tonumber((ind.Text or ""):match("(-?%d+%.?%d*)"))
        if not val then return end
        if math.abs(val) > OUTLIER_MAX then return end  -- ignore outliers

        table.insert(alBuf, val)
        if #alBuf > AL_BUF_SIZE then table.remove(alBuf, 1) end
        local avg = alAvg()

        if alPhase == "hunt" then
            vimLatencyMs = math.clamp(vimLatencyMs + avg * GAIN, 0, 300)
            if math.abs(avg) <= LOCK_THRESH then
                alGoodStreak = alGoodStreak + 1
                alBadStreak  = 0
                if alGoodStreak >= LOCK_N then
                    alPhase="locked"; alGoodStreak=0; alBadStreak=0; alBuf={}
                end
            else
                alBadStreak  = alBadStreak + 1
                alGoodStreak = 0
            end

        elseif alPhase == "locked" then
            vimLatencyMs = math.clamp(vimLatencyMs + avg*(GAIN*0.1), 0, 300)
            if math.abs(avg) <= LOCK_THRESH then
                alBadStreak  = 0
                alPerfStreak = alPerfStreak + 1
                if alPerfStreak >= PERFECT_LOCK then
                    alPhase="frozen"; alBuf={}
                end
            else
                alBadStreak  = alBadStreak + 1
                alPerfStreak = 0
                if alBadStreak >= UNLOCK_BAD then
                    alPhase="hunt"; alGoodStreak=0; alBadStreak=0; alBuf={}
                end
            end

        else -- frozen
            -- Just monitor; re-hunt if timing consistently drifts
            if math.abs(avg) > LOCK_THRESH then
                alBadStreak = alBadStreak + 1
                if alBadStreak >= UNLOCK_BAD then
                    alPhase="hunt"; alGoodStreak=0; alBadStreak=0
                    alPerfStreak=0; alBuf={}
                end
            else
                alBadStreak = 0
            end
        end
    end)
end

local function stopAutoLatency()
    if autoLatencyConn then autoLatencyConn:Disconnect(); autoLatencyConn=nil end
    if _G.Settings then _G.Settings.HitLate = alSavedHitLate end
    alPhase="hunt"; alBuf={}; alGoodStreak=0; alBadStreak=0; alPerfStreak=0
end

-- ═══════════════════════════════════════════════════════════════
-- KEYBINDS
-- ═══════════════════════════════════════════════════════════════
local v4 = {
    KeyBinds    = {Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.W, Enum.KeyCode.D},
    TapDuration = 0.05,
}

-- ═══════════════════════════════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════════════════════════════
local v8            = false
local missJacks     = false
local legitMode     = false
local perfected     = false
local tileLights    = false
local mainLoop      = nil

local laneHoldFrame = {nil, nil, nil, nil}
local lanePressed   = {false, false, false, false}
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

-- ═══════════════════════════════════════════════════════════════
-- TILE LIGHTING
-- ───────────────────────────────────────────────────────────────
-- Source (w0opsie_songPlay.lua line 1577):
--   v_u_397 = {
--     MatchFrame.MobileKeys.Left,   [1] = lane 1
--     MatchFrame.MobileKeys.Down,   [2] = lane 2
--     MatchFrame.MobileKeys.Up,     [3] = lane 3
--     MatchFrame.MobileKeys.Right   [4] = lane 4
--   }
--   Press:   tile.ImageTransparency = 0
--   Release: TweenService → ImageTransparency = 0.8 over 0.1s
-- ═══════════════════════════════════════════════════════════════
local TILE_NAMES     = {"Left","Down","Up","Right"}
local TILE_TWEEN_INF = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local tileTweens     = {}

local function getMobileTile(lane)
    local ok, result = pcall(function()
        return v5.PlayerGui.Main.MatchFrame.MobileKeys[TILE_NAMES[lane]]
    end)
    return ok and result or nil
end

local function lightTile(lane, lit)
    if not tileLights then return end
    local tile = getMobileTile(lane)
    if not tile then return end
    if tileTweens[lane] then tileTweens[lane]:Cancel(); tileTweens[lane]=nil end
    if lit then
        tile.ImageTransparency = 0
    else
        local tw = TweenService:Create(tile, TILE_TWEEN_INF, {ImageTransparency=0.8})
        tileTweens[lane] = tw
        tw:Play()
    end
end

-- ═══════════════════════════════════════════════════════════════
-- VIM INPUT
-- ═══════════════════════════════════════════════════════════════
local function vimDown(lane)
    if not lanePressed[lane] then
        lanePressed[lane] = true
        VIM:SendKeyEvent(true, v4.KeyBinds[lane], false, game)
        lightTile(lane, true)
    end
end

local function vimUp(lane)
    if lanePressed[lane] then
        lanePressed[lane] = false
        VIM:SendKeyEvent(false, v4.KeyBinds[lane], false, game)
        lightTile(lane, false)
    end
end

local function vimTap(lane)
    vimUp(lane)
    vimDown(lane)
    task.delay(v4.TapDuration, function() vimUp(lane) end)
end

-- ═══════════════════════════════════════════════════════════════
-- HOLD RELEASE
-- ───────────────────────────────────────────────────────────────
-- Source (NoteInput line 1034): v277.Parent = v256  (holdFrame → Hitbox)
-- Source (line 352): v_u_116["Arrow"..lane].LnHold.ImageTransparency = 0
--   where v_u_116 = KeySync frame.
--   arrowFrame in our code = KS["Arrow"..lane], so arrowFrame.LnHold is correct.
-- ═══════════════════════════════════════════════════════════════
local function resetLnHold(lane)
    -- Try both KeySync frames to cover whichever side is active
    pcall(function()
        local mf = v5.PlayerGui.Main.MatchFrame
        for s = 1, 2 do
            local ar = mf:FindFirstChild("KeySync"..s)
                   and mf["KeySync"..s]:FindFirstChild("Arrow"..lane)
            if ar then
                local ln = ar:FindFirstChild("LnHold")
                if ln then ln.ImageTransparency = 1 end
            end
        end
    end)
end

local function stopHold(lane)
    laneHoldFrame[lane] = nil
    vimUp(lane)
    resetLnHold(lane)
end

local function watchHold(lane, arrowFrame, holdFrame)
    laneHoldFrame[lane] = holdFrame

    local hitbox = arrowFrame:FindFirstChild("Hold")
               and arrowFrame.Hold:FindFirstChild("Hitbox")

    local released = false
    local function release()
        if released then return end
        released = true
        if laneHoldFrame[lane] == holdFrame then stopHold(lane) end
    end

    task.spawn(function()
        if not hitbox then
            while laneHoldFrame[lane] == holdFrame do
                RunService.Heartbeat:Wait()
                if not holdFrame:IsDescendantOf(game) then release(); return end
            end
            return
        end
        local deadline = tick() + 0.10
        while tick() < deadline do
            if laneHoldFrame[lane] ~= holdFrame then return end
            if holdFrame:IsDescendantOf(hitbox) then
                local conn
                conn = hitbox.ChildRemoved:Connect(function(child)
                    if child == holdFrame then conn:Disconnect(); release() end
                end)
                task.spawn(function()
                    while laneHoldFrame[lane] == holdFrame do
                        RunService.Heartbeat:Wait()
                        if not holdFrame:IsDescendantOf(game) then
                            conn:Disconnect(); release(); return
                        end
                    end
                end)
                return
            end
            if not holdFrame:IsDescendantOf(game) then release(); return end
            RunService.Heartbeat:Wait()
        end
        release()
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- HELPERS
-- ═══════════════════════════════════════════════════════════════
local HIT_OFFSETS = {sick=0.045, good=0.075, ok=0.125, bad=0.175}

local function pickRating()
    local pool = {}
    for _=1,perfectChance do table.insert(pool,"perfect") end
    for _=1,sickChance    do table.insert(pool,"sick")    end
    for _=1,goodChance    do table.insert(pool,"good")    end
    for _=1,okChance      do table.insert(pool,"ok")      end
    for _=1,badChance     do table.insert(pool,"bad")     end
    for _=1,missChance    do table.insert(pool,"miss")    end
    if #pool == 0 then return "perfect" end
    return pool[math.random(1,#pool)]
end

local function canPress()
    if not legitMode then return true end
    local now = tick()
    local i = 1
    while i <= #kpsLog do
        if now - kpsLog[i] > 1 then table.remove(kpsLog,i) else i=i+1 end
    end
    if #kpsLog >= legitKpsLimit then return false end
    table.insert(kpsLog, now)
    return true
end

local function getMyKeySync()
    local M = v5.PlayerGui:FindFirstChild("Main")
        and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
    if not (M and M.Visible) then return nil end
    local pv = v5:FindFirstChild("File") and v5.File:FindFirstChild("CurrentPlayer")
    if pv and pv.Value then
        local side = pv.Value.Name == "Player2" and 2 or 1
        return M:FindFirstChild("KeySync"..side)
    end
end

-- ═══════════════════════════════════════════════════════════════
-- NOTE HANDLER
-- ═══════════════════════════════════════════════════════════════
local function handleNote(lane, isHold, holdFrame, arrowFrame, sync)
    if not canPress() then return end
    local rating = pickRating()
    if rating == "miss" then return end
    if laneHoldFrame[lane] then stopHold(lane) end

    local function fire()
        if isHold then
            -- SHORT HOLD DETECTION (from CreateNote source):
            -- holdFrame.Size.Y.Scale = (duration - 0.07) * 5.5 * spd
            -- "Blue notes" are charters using holds with near-zero duration.
            -- Their tail scale is tiny (< 0.15). Treat these as taps — holding
            -- them causes the key to stay down and block subsequent notes.
            local tailScale = holdFrame and holdFrame.Size.Y.Scale or 0
            if tailScale < 0.15 then
                -- Short hold: tap instead of hold
                vimTap(lane)
            else
                vimUp(lane); vimDown(lane)
                watchHold(lane, arrowFrame, holdFrame)
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
                local lo = math.min(minReaction,maxReaction)
                local hi = math.max(minReaction,maxReaction)
                task.wait((lo==hi and lo or math.random(lo,hi))/1000)
            end
            if rating ~= "perfect" then
                local off = HIT_OFFSETS[rating]
                if off then task.wait(off) end
            end
            fire()
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════
-- MAIN LOOP
-- ═══════════════════════════════════════════════════════════════
local function startLoop()
    if mainLoop then mainLoop:Disconnect(); mainLoop=nil end
    seenNotes = {}
    local cacheBuilt = {}

    local function tick_fn(sync)
        if not v8 then return end
        local KS = getMyKeySync()
        if not (KS and KS.Visible) then return end

        local spd = math.clamp(tonumber((_G and _G.Settings and _G.Settings.NoteSpeed) or 2) or 2, 0.8, 5)
        local triggerScale = calcTriggerScale(spd)

        for lane = 1, 4 do
            local arrowFrame = KS:FindFirstChild("Arrow"..lane)
            local notesFrame = arrowFrame and arrowFrame:FindFirstChild("Notes")
            if not (arrowFrame and notesFrame) then continue end

            if not cacheBuilt[lane] then
                cacheBuilt[lane] = true
                notesFrame.ChildAdded:Connect(function(child)
                    child.AncestryChanged:Connect(function()
                        if not child:IsDescendantOf(game) then
                            seenNotes[child] = nil
                        end
                    end)
                end)
            end

            local bestNote, bestDist = nil, math.huge
            for _, child in ipairs(notesFrame:GetChildren()) do
                if not child:IsA("GuiObject") then continue end
                if child.Name:sub(1,5) == "Hold_" then continue end
                if not child.Visible then continue end
                if seenNotes[child] then continue end
                local dist = math.abs(child.Position.Y.Scale)
                if dist <= triggerScale and dist < bestDist then
                    bestDist = dist
                    bestNote = child
                end
            end

            if not bestNote then continue end
            seenNotes[bestNote] = true

            local isHold    = bestNote:GetAttribute("HoldHead") == true
            local holdFrame = isHold and notesFrame:FindFirstChild("Hold_"..bestNote.Name) or nil
            if isHold and not holdFrame then isHold = false end

            if laneHoldFrame[lane] then stopHold(lane) end
            handleNote(lane, isHold, holdFrame, arrowFrame, sync)

            bestNote.AncestryChanged:Once(function()
                seenNotes[bestNote] = nil
            end)
        end
    end

    if perfected then
        mainLoop = RunService.RenderStepped:Connect(function() tick_fn(true) end)
    else
        mainLoop = RunService.Heartbeat:Connect(function() tick_fn(false) end)
    end
end

-- ═══════════════════════════════════════════════════════════════
-- UI TABS
-- ═══════════════════════════════════════════════════════════════
local infoTab     = window:AddTab("InfoTab",     {Text="Info"    })
local mainTab     = window:AddTab("MainTab",     {Text="Main"    })
local miscTab     = window:AddTab("MiscTab",     {Text="Misc"    })
local settingsTab = window:AddTab("SettingsTab", {Text="Settings"})

-- ── Info ──────────────────────────────────────
local infoLeft  = infoTab:AddLeftGroupbox("InfoLeft",  {Text="Welcome"     })
local infoRight = infoTab:AddRightGroupbox("InfoRight", {Text="How It Works"})

infoLeft:AddLabel("InfoL1", {
    Text="<font color='#5BC8F5'><b>w0opsie's Auto Player</b></font>\nMade with love by w0opsie\n\nAutomatically plays <b>Basically FNF: Remix</b>!"
})
infoLeft:AddSeparator("IS1",{})
infoLeft:AddLabel("InfoL2", {
    Text="<font color='#F5A623'><b>Best settings:</b></font>\n• Perfected: ON\n• Auto Latency: ON\n• Perfect weight: 100, rest 0"
})
infoLeft:AddSeparator("IS2",{})
infoLeft:AddLabel("InfoL3", {Text="<font color='#5BC8F5'><b>Keybind:</b></font> RightShift = toggle UI"})

infoRight:AddLabel("IR1",{Text="<font color='#F5A623'><b>Feature Guide</b></font>"})
infoRight:AddSeparator("IRS1",{})
infoRight:AddLabel("IR2",{Text="<font color='#5BC8F5'><b>Perfected</b></font>\nRenderStepped + zero-yield.\nBest timing accuracy."})
infoRight:AddLabel("IR3",{Text="<font color='#5BC8F5'><b>Auto Latency</b></font>\nHUNT: fast correction (0.3s).\nLOCKED: stable, tiny nudges.\nFROZEN: perfect — stays fixed.\nRe-hunts if timing drifts."})
infoRight:AddLabel("IR4",{Text="<font color='#5BC8F5'><b>Tile Lights</b></font>\nLights up mobile receptors.\nCosmetic only."})
infoRight:AddLabel("IR5",{
    Text="<font color='#5BC8F5'><b>Hit Chances</b></font>\nWeights, not percentages.\nAll 0 = always Perfect.\n\n<font color='#F5A623'>Windows:</font>\nPerfect: 0ms  Sick: +45ms\nGood: +75ms   Ok: +125ms\nBad: +175ms"
})

-- ── Main groupboxes ───────────────────────────
local apGroup     = mainTab:AddLeftGroupbox( "APGroup",     {Text="Auto Player"    })
local playerGroup = mainTab:AddLeftGroupbox( "PlayerGroup", {Text="Player Settings"})
local chanceGroup = mainTab:AddRightGroupbox("ChanceGroup", {Text="Hit Chances"    })

-- ── Auto Player toggles ───────────────────────
apGroup:AddToggle("AutoPlayerEnabled", {
    Text="Enable", Value=false,
    Tooltip="Turn auto player on/off",
    Callback=function(val)
        v8 = val
        if v8 then
            laneHoldFrame={nil,nil,nil,nil}
            lanePressed={false,false,false,false}
            for i=1,4 do vimUp(i) end
            seenNotes={}
            startLoop()
            if autoLatency then startAutoLatency() end
            window:Notification({Title="AutoPlayer", Text="Turned <font color='#5BC8F5'><b>ON</b></font>", Duration=2})
        else
            for i=1,4 do
                if laneHoldFrame[i] then stopHold(i) end
                vimUp(i)
            end
            if mainLoop then mainLoop:Disconnect(); mainLoop=nil end
            stopAutoLatency()
            laneHoldFrame={nil,nil,nil,nil}
            lanePressed={false,false,false,false}
            seenNotes={}
            window:Notification({Title="AutoPlayer", Text="Turned <font color='#F5A623'><b>OFF</b></font>", Duration=2})
        end
    end,
})

apGroup:AddSeparator("AS1",{})

apGroup:AddToggle("Perfected", {
    Text="Perfected", Value=false,
    Tooltip="RenderStepped + zero-yield for best timing",
    Callback=function(val)
        perfected=val
        if val then minReaction=0; maxReaction=0 end
        if v8 then if mainLoop then mainLoop:Disconnect(); mainLoop=nil end; startLoop() end
        window:Notification({Title="Perfected", Text=val and "<font color='#5BC8F5'>ON</font>" or "<font color='#F5A623'>OFF</font>", Duration=2})
    end,
})

apGroup:AddSeparator("AS2",{})

apGroup:AddToggle("TileLights", {
    Text="Tile Lights", Value=false,
    Tooltip="Lights up mobile receptor tiles on keypress. Cosmetic only.",
    Callback=function(val)
        tileLights=val
        if not val then
            for lane=1,4 do
                local tile=getMobileTile(lane)
                if tile then tile.ImageTransparency=0.8 end
            end
        end
        window:Notification({Title="Tile Lights", Text=val and "<font color='#5BC8F5'>ON</font>" or "<font color='#F5A623'>OFF</font>", Duration=2})
    end,
})

apGroup:AddSeparator("AS3",{})

apGroup:AddToggle("MissJacks", {
    Text="Miss Jack Notes", Value=false,
    Tooltip="Skip rapid same-key notes to look more human",
    Callback=function(val) missJacks=val end,
})

apGroup:AddSeparator("AS4",{})

apGroup:AddToggle("LegitMode", {
    Text="Legit Mode", Value=false,
    Tooltip="Caps KPS and biases toward Sick/Good",
    Callback=function(val)
        legitMode=val
        if val then
            perfectChance=35; sickChance=45; goodChance=15; okChance=4; badChance=1; missChance=0
        else
            perfectChance=100; sickChance=0; goodChance=0; okChance=0; badChance=0; missChance=0
        end
        window:Notification({Title="Legit Mode", Text=val and "ON — KPS: <b>"..legitKpsLimit.."</b>" or "OFF", Duration=2})
    end,
})

apGroup:AddSlider("LegitKps", {
    Text="KPS Limit", Min=1, Max=100, Value=100, Step=1,
    Tooltip="Max keypresses per second in Legit Mode",
    Callback=function(val) legitKpsLimit=val end,
})

-- ── Player Settings ───────────────────────────
playerGroup:AddToggle("AutoLatency", {
    Text="Auto Latency", Value=true,
    Tooltip="Reads ms counter and self-tunes. HUNT→LOCKED→FROZEN as timing stabilises.",
    Callback=function(val)
        autoLatency=val
        if val and v8 then startAutoLatency()
        elseif not val then stopAutoLatency() end
        window:Notification({
            Title="Auto Latency",
            Text=val and "<font color='#5BC8F5'>ON</font> — self-tuning" or "<font color='#F5A623'>OFF</font> — manual slider",
            Duration=3
        })
    end,
})

playerGroup:AddLabel("ALStatus", {
    Text="<font color='#888'>Auto phases: HUNT (fast) → LOCKED (stable) → FROZEN (perfect)</font>"
})

playerGroup:AddSlider("VimLatency", {
    Text="VIM Latency (ms)", Min=0, Max=300, Value=103, Step=1,
    Tooltip="Only used when Auto Latency is OFF. + in ms counter = raise. - = lower.",
    Callback=function(val) if not autoLatency then vimLatencyMs=math.floor(val) end end,
})

playerGroup:AddSeparator("PS1",{})

playerGroup:AddSlider("MinReaction", {
    Text="Min Reaction (ms)", Min=0, Max=150, Value=0, Step=1,
    Tooltip="Ignored when Perfected is ON",
    Callback=function(val) if not perfected then minReaction=math.floor(val) end end,
})

playerGroup:AddSlider("MaxReaction", {
    Text="Max Reaction (ms)", Min=0, Max=150, Value=0, Step=1,
    Tooltip="Ignored when Perfected is ON",
    Callback=function(val) if not perfected then maxReaction=math.floor(val) end end,
})

-- ── Hit Chances ───────────────────────────────
chanceGroup:AddLabel("CI",{Text="<font color='#F5A623'><b>Weights, not %.</b></font>\nAll 0 = always Perfect.\nLocked while Legit Mode ON."})
chanceGroup:AddSeparator("CS",{})
chanceGroup:AddSlider("PerfectChance",{Text="Perfect",Min=0,Max=100,Value=100,Step=1,Callback=function(v) if not legitMode then perfectChance=math.floor(v) end end})
chanceGroup:AddSlider("SickChance",   {Text="Sick",   Min=0,Max=100,Value=0,  Step=1,Tooltip="+45ms",  Callback=function(v) if not legitMode then sickChance=math.floor(v) end end})
chanceGroup:AddSlider("GoodChance",   {Text="Good",   Min=0,Max=100,Value=0,  Step=1,Tooltip="+75ms",  Callback=function(v) if not legitMode then goodChance=math.floor(v) end end})
chanceGroup:AddSlider("OkChance",     {Text="Ok",     Min=0,Max=100,Value=0,  Step=1,Tooltip="+125ms", Callback=function(v) if not legitMode then okChance=math.floor(v) end end})
chanceGroup:AddSlider("BadChance",    {Text="Bad",    Min=0,Max=100,Value=0,  Step=1,Tooltip="+175ms", Callback=function(v) if not legitMode then badChance=math.floor(v) end end})
chanceGroup:AddSlider("MissChance",   {Text="Miss",   Min=0,Max=100,Value=0,  Step=1,                  Callback=function(v) if not legitMode then missChance=math.floor(v) end end})

-- ── Misc tab (Platform Display) ───────────────
local miscGroup = miscTab:AddLeftGroupbox("MiscGroup", {Text="Platform Display"})

miscGroup:AddToggle("PlatformAutoRejoin", {
    Text="Custom Platform Display", Value=true,
    Tooltip="Auto-rejoin after setting platform display",
    Callback=function(val) platformAutoRejoin=val end,
})
miscGroup:AddTextBox("PlatformContent", {
    Text="Display Content", Value="😇", PlaceholderText="Enter text or emoji...",
    Callback=function(val) if val and val~="" then platformContent=val end end,
})
miscGroup:AddButton("ApplyPlatform", {
    Text="Apply Platform Display",
    Callback=function()
        if game.PlaceId ~= 6520999642 then
            window:Notification({Title="Error",Text="Wrong game!",Duration=3}); return
        end
        if not (isfile and readfile and writefile) then
            window:Notification({Title="Error",Text="Incompatible executor!",Duration=3}); return
        end
        local QueueOnTP = (syn and syn.queue_on_teleport)
            or (fluxus and fluxus.queue_on_teleport)
            or (queue_on_teleport and queue_on_teleport)
        if not QueueOnTP then
            window:Notification({Title="Error",Text="Missing queue_on_teleport!",Duration=3}); return
        end
        local Content = platformContent
        writefile("FNFRemixDisplayContent.txt", tostring(Content))
        local SG=game:GetService("StarterGui")
        local P=game:GetService("Players")
        local TPS=game:GetService("TeleportService")
        local Spk=P.LocalPlayer
        local function Alert()
            local s=Instance.new("Sound",game:GetService("SoundService"))
            s.Volume=2; s.SoundId="rbxassetid://4590662766"
            s.PlayOnRemove=true; s:Destroy()
        end
        if _G.FNFRemixACPD or (getgenv and getgenv().FNFRemixACPD) then
            SG:SetCore("SendNotification",{Title="🧐 Changed!",Text="Display: '"..Content.."'",Duration=5})
            window:Notification({Title="Platform",Text="Content: "..Content,Duration=4})
            Alert(); return
        end
        local Rejoin=Instance.new("BindableFunction")
        Rejoin.OnInvoke=function(Ans)
            if Ans=="Yes" and platformAutoRejoin then
                if #P:GetPlayers()<=1 then
                    Spk:Kick("\nRejoining..."); task.wait()
                    TPS:Teleport(6520999642,Spk)
                else
                    TPS:TeleportToPlaceInstance(6520999642,game.JobId,Spk)
                end
            end
        end
        QueueOnTP([[
            if game.PlaceId~=6520999642 then return end
            if not(isfile and readfile) then return end
            local Content=(isfile('FNFRemixDisplayContent.txt') and readfile('FNFRemixDisplayContent.txt')) or '😇'
            local Speaker=game:GetService'Players'.LocalPlayer
            task.spawn(function()
                local conn
                conn=Speaker:WaitForChild'PlayerScripts'.ChildAdded:Connect(function(Child)
                    if Child:IsA'LocalScript' and Child.Name=='PlatformDisplay' then
                        Child.Disabled=true; conn:Disconnect()
                    end
                end)
            end)
            game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild'PlatformRemoteEvent':FireServer(tostring(Content))
        ]])
        SG:SetCore("SendNotification",{
            Title=platformAutoRejoin and "🧐 Rejoin?" or "🧐 Done",
            Text=platformAutoRejoin and "Rejoin to apply '"..Content.."'?" or "Rejoin manually.",
            Button1="Yes",Button2="No",Duration=(1/0),Callback=Rejoin,
        })
        Alert()
        window:Notification({Title="Platform",Text="Set: "..Content,Duration=4})
        if getgenv then getgenv().FNFRemixACPD=true else _G.FNFRemixACPD=true end
    end,
})

-- ── Settings tab (Theme) ──────────────────────
local themeGroup = settingsTab:AddLeftGroupbox("ThemeGroup", {Text="Theme"})

themeGroup:AddLabel("TL1",{Text="<font color='#5BC8F5'><b>Accent</b></font> (default: #5BC8F5)"}):AddColorPicker("ThemeMain",{
    Value=C_BLUE,
    Callback=function(val) window.Theme={Back=C_BG,Main=val,Stroke=C_ORANGE,Text=C_WHITE}; window:Refresh() end,
})
themeGroup:AddLabel("TL2",{Text="<font color='#F5A623'><b>Stroke</b></font> (default: #F5A623)"}):AddColorPicker("ThemeStroke",{
    Value=C_ORANGE,
    Callback=function(val) window.Theme={Back=C_BG,Main=C_BLUE,Stroke=val,Text=C_WHITE}; window:Refresh() end,
})
