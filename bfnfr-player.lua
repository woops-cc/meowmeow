local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Null-Cherry/Fire-Library/refs/heads/main/Loader.lua", true))()

-- ── OC palette ────────────────────────────────
local C_BLUE   = Color3.fromRGB(91,  200, 245)
local C_ORANGE = Color3.fromRGB(245, 166, 35)
local C_WHITE  = Color3.fromRGB(220, 220, 225)
local C_BG     = Color3.fromRGB(18,  18,  22)

-- ── Window ────────────────────────────────────
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
    Theme = {
        Back   = C_BG,
        Main   = C_BLUE,
        Stroke = C_ORANGE,
        Text   = C_WHITE,
    },
})

-- ── Icon + Background ─────────────────────────
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

-- ── Services ──────────────────────────────────
local RunService = game:GetService("RunService")
local VIM        = game:GetService("VirtualInputManager")
local Players    = game:GetService("Players")
local v5         = Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════
-- TIMING
-- ───────────────────────────────────────────────────────────────
-- Perfect window from NoteInput: |scale| <= 0.71775 * spd
-- We fire VIM `vimLatencyMs` before the window edge.
-- Formula: triggerScale = (0.71775 - latSec * 5.5) * spd
--
-- FULLY AUTOMATIC LATENCY:
--   The game's msIndic (MatchFrame.msIndic) shows the hit offset.
--   We read it every ~30 frames and adjust vimLatencyMs automatically:
--     reading > 0  (pressed too late)  → increase latency compensation
--     reading < 0  (pressed too early) → decrease latency compensation
--   This self-corrects in real time regardless of scroll speed.
--   Calibration from testing: spd=2.4 → 103ms is a good starting point.
-- ═══════════════════════════════════════════════════════════════
local vimLatencyMs  = 103   -- starting value; auto-adjust will tune this
local autoLatency   = true  -- continuously self-correct from ms counter
local AUTO_RATE     = 0.25  -- how aggressively to correct (0=none, 1=full)
local autoLatencyConn = nil -- Heartbeat connection for auto-latency

local function calcTriggerScale(spd)
    local coeff = 0.71775 - (vimLatencyMs / 1000) * 5.5
    coeff = math.clamp(coeff, 0.05, 0.71775)
    return coeff * spd
end

-- ── Auto latency: read ms counter and self-correct ──────────────
local autoSampleCount = 0
local autoSampleSum   = 0
local AUTO_SAMPLE_N   = 8    -- average over 8 readings before adjusting

local function startAutoLatency()
    if autoLatencyConn then autoLatencyConn:Disconnect() end
    autoSampleCount = 0; autoSampleSum = 0
    local frameCount = 0
    autoLatencyConn = RunService.Heartbeat:Connect(function()
        if not autoLatency then return end
        frameCount = frameCount + 1
        if frameCount < 30 then return end  -- sample every 30 frames (~0.5s)
        frameCount = 0

        -- Find the ms counter in the game UI
        local mf = v5.PlayerGui:FindFirstChild("Main")
               and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
        if not mf then return end
        local msIndic = mf:FindFirstChild("msIndic")
        if not msIndic then return end

        local txt = msIndic.Text or ""
        -- Text format: "±XX.XXms" — extract the number
        local val = tonumber(txt:match("(-?%d+%.?%d*)"))
        if not val then return end

        -- Accumulate samples
        autoSampleSum   = autoSampleSum + val
        autoSampleCount = autoSampleCount + 1

        if autoSampleCount < AUTO_SAMPLE_N then return end

        -- Compute average and adjust
        local avg = autoSampleSum / autoSampleCount
        autoSampleSum   = 0
        autoSampleCount = 0

        -- avg > 0: pressing too late → need to fire earlier → increase latencyMs
        -- avg < 0: pressing too early → need to fire later → decrease latencyMs
        -- Only adjust if drift is > 2ms to avoid jitter on perfect timing
        if math.abs(avg) > 2 then
            vimLatencyMs = math.clamp(
                vimLatencyMs + avg * AUTO_RATE,
                0, 300
            )
        end
    end)
end

local function stopAutoLatency()
    if autoLatencyConn then autoLatencyConn:Disconnect(); autoLatencyConn = nil end
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
local v8          = false
local missJacks   = false
local legitMode   = false
local perfected   = false
local antiMiss    = false
local tileLights  = false   -- light up mobile tiles on keypress
local mainLoop    = nil

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
-- The game uses v73 (arrow skin class) with :Hit(), :Tap(), :Release()
-- to animate the receptor. We replicate the "lit" state by setting
-- ArrowN.Arrow.ImageTransparency = 0 on press and 0.5 on release.
-- This matches what the skin does internally on Hit().
-- Path: MatchFrame > KeySyncN > ArrowN > Arrow (ImageLabel)
-- ═══════════════════════════════════════════════════════════════
local function getArrowImage(side, lane)
    local mf = v5.PlayerGui:FindFirstChild("Main")
           and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
    if not mf then return nil end
    local ks = mf:FindFirstChild("KeySync"..side)
    if not ks then return nil end
    local ar = ks:FindFirstChild("Arrow"..lane)
    if not ar then return nil end
    return ar:FindFirstChild("Arrow")  -- the ImageLabel receptor
end

local function lightTile(side, lane, lit)
    if not tileLights then return end
    local img = getArrowImage(side, lane)
    if not img then return end
    img.ImageTransparency = lit and 0 or 0.5
end

-- ═══════════════════════════════════════════════════════════════
-- VIM INPUT
-- ═══════════════════════════════════════════════════════════════
local currentSide = 1  -- updated by getMyKeySync result

local function vimDown(lane)
    if not lanePressed[lane] then
        lanePressed[lane] = true
        VIM:SendKeyEvent(true, v4.KeyBinds[lane], false, game)
        lightTile(currentSide, lane, true)
    end
end

local function vimUp(lane)
    if lanePressed[lane] then
        lanePressed[lane] = false
        VIM:SendKeyEvent(false, v4.KeyBinds[lane], false, game)
        lightTile(currentSide, lane, false)
    end
end

local function vimTap(lane)
    vimUp(lane)
    vimDown(lane)
    task.delay(v4.TapDuration, function() vimUp(lane) end)
end

-- ═══════════════════════════════════════════════════════════════
-- HOLD RELEASE WATCHER
-- ───────────────────────────────────────────────────────────────
-- Sequence (from decompiled NoteInput):
--   1. vimDown(lane)
--   2. NoteInput fires → v277.Parent = Hitbox
--   3. Poll Hitbox until holdFrame arrives
--   4. Connect Hitbox.ChildRemoved for that frame
--   5. ChildRemoved → vimUp(lane)
--   Fallback: Heartbeat polls IsDescendantOf(game)
--
-- HOLD VISUAL FIX (consecutive holds on same lane):
--   When a second hold arrives while the first is still in watchHold's
--   poll loop, stopHold() sets laneHoldFrame[lane]=nil which causes
--   the poll loop to bail (laneHoldFrame[lane] ~= holdFrame).
--   The second hold then calls vimDown cleanly.
--   Additionally we reset LnHold.ImageTransparency=1 on stopHold
--   to clear the stuck "hold active" glow.
-- ═══════════════════════════════════════════════════════════════
local function resetLnHold(arrowFrame)
    -- Reset the hold glow visual that the game sets to 0 on hold hit
    pcall(function()
        arrowFrame.LnHold.ImageTransparency = 1
    end)
end

local function stopHold(lane, arrowFrame)
    local prev = laneHoldFrame[lane]
    laneHoldFrame[lane] = nil
    vimUp(lane)
    -- Clear hold glow if we have the arrowFrame reference
    if arrowFrame then resetLnHold(arrowFrame) end
end

local function watchHold(lane, arrowFrame, holdFrame)
    laneHoldFrame[lane] = holdFrame

    local hitbox = arrowFrame:FindFirstChild("Hold")
               and arrowFrame.Hold:FindFirstChild("Hitbox")

    local released = false
    local function release()
        if released then return end
        released = true
        if laneHoldFrame[lane] == holdFrame then
            stopHold(lane, arrowFrame)
        end
    end

    task.spawn(function()
        if not hitbox then
            while laneHoldFrame[lane] == holdFrame do
                RunService.Heartbeat:Wait()
                if not holdFrame:IsDescendantOf(game) then
                    release(); return
                end
            end
            return
        end

        local deadline = tick() + 0.10
        while tick() < deadline do
            if laneHoldFrame[lane] ~= holdFrame then return end
            if holdFrame:IsDescendantOf(hitbox) then
                local conn
                conn = hitbox.ChildRemoved:Connect(function(child)
                    if child == holdFrame then
                        conn:Disconnect()
                        release()
                    end
                end)
                task.spawn(function()
                    while laneHoldFrame[lane] == holdFrame do
                        RunService.Heartbeat:Wait()
                        if not holdFrame:IsDescendantOf(game) then
                            conn:Disconnect()
                            release(); return
                        end
                    end
                end)
                return
            end
            if not holdFrame:IsDescendantOf(game) then
                release(); return
            end
            RunService.Heartbeat:Wait()
        end
        release()
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- HELPERS
-- ═══════════════════════════════════════════════════════════════
local HIT_OFFSETS = { sick=0.045, good=0.075, ok=0.125, bad=0.175 }

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
        currentSide = side
        return M:FindFirstChild("KeySync"..side), side
    end
end

-- ═══════════════════════════════════════════════════════════════
-- NOTE HANDLER
-- ═══════════════════════════════════════════════════════════════
local function handleNote(lane, isHold, holdFrame, arrowFrame, sync)
    if not canPress() then return end

    local rating = pickRating()
    if rating == "miss" then return end

    if laneHoldFrame[lane] then
        stopHold(lane, arrowFrame)
    end

    local function fire()
        if isHold then
            vimUp(lane)
            vimDown(lane)
            watchHold(lane, arrowFrame, holdFrame)
        else
            vimTap(lane)
        end
    end

    if sync then
        fire()
    else
        task.spawn(function()
            if maxReaction > 0 then
                local lo = math.min(minReaction, maxReaction)
                local hi = math.max(minReaction, maxReaction)
                local delay = lo == hi and lo or math.random(lo, hi)
                task.wait(delay / 1000)
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
    if mainLoop then mainLoop:Disconnect(); mainLoop = nil end
    seenNotes = {}

    local cacheBuilt = {}

    local function tick_fn(sync)
        if not v8 then return end
        local KS = getMyKeySync()
        if not (KS and KS.Visible) then return end

        local spd = (_G and _G.Settings and _G.Settings.NoteSpeed) or 2
        spd = math.clamp(tonumber(spd) or 2, 0.8, 5)
        local triggerScale = calcTriggerScale(spd)

        -- Anti Miss: scan wide (full outer detect window) but ONLY FIRE
        -- when the note is within triggerScale. Notes detected in the wider
        -- window are queued in seenNotes so they are not re-detected, and
        -- they get fired as soon as they enter triggerScale on a subsequent frame.
        -- This prevents the "fires too early" problem of the old approach.
        local scanWindow = antiMiss
            and math.clamp(2.4 * spd, 1, 9)
            or  triggerScale

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

            -- Find closest unhandled note within the scan window
            local bestNote = nil
            local bestDist = math.huge

            for _, child in ipairs(notesFrame:GetChildren()) do
                if not child:IsA("GuiObject") then continue end
                if child.Name:sub(1,5) == "Hold_" then continue end
                if not child.Visible then continue end
                if seenNotes[child] then continue end

                local dist = math.abs(child.Position.Y.Scale)
                if dist <= scanWindow and dist < bestDist then
                    bestDist = dist
                    bestNote = child
                end
            end

            if not bestNote then continue end

            -- Anti Miss: only fire when within the calibrated trigger window.
            -- If outside triggerScale but inside scanWindow: we've "seen" the
            -- note but don't fire yet — wait for it to reach trigger distance.
            -- We do NOT mark seenNotes yet so it stays eligible next frame.
            if bestDist > triggerScale then continue end

            -- Within trigger window — fire now
            seenNotes[bestNote] = true

            local isHold    = bestNote:GetAttribute("HoldHead") == true
            local holdFrame = nil
            if isHold then
                holdFrame = notesFrame:FindFirstChild("Hold_" .. bestNote.Name)
                if not holdFrame then isHold = false end
            end

            if laneHoldFrame[lane] then
                stopHold(lane, arrowFrame)
            end

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
-- TABS
-- ═══════════════════════════════════════════════════════════════
local infoTab     = window:AddTab("InfoTab",     { Text = "Info"     })
local mainTab     = window:AddTab("MainTab",     { Text = "Main"     })
local miscTab     = window:AddTab("MiscTab",     { Text = "Misc"     })
local settingsTab = window:AddTab("SettingsTab", { Text = "Settings" })

-- ── Info ──────────────────────────────────────
local infoLeft  = infoTab:AddLeftGroupbox("InfoLeft",  { Text = "Welcome"      })
local infoRight = infoTab:AddRightGroupbox("InfoRight", { Text = "How It Works" })

infoLeft:AddLabel("InfoL1", {
    Text = "<font color='#5BC8F5'><b>w0opsie's Auto Player</b></font>\nMade with love by w0opsie\n\nThis script automatically plays\n<b>Basically FNF: Remix</b> for you!"
})
infoLeft:AddSeparator("InfoSep1", {})
infoLeft:AddLabel("InfoL2", {
    Text = "<font color='#F5A623'><b>Best settings for all Perfects:</b></font>\n• Perfected: <b>ON</b>\n• Auto Latency: <b>ON</b>\n• Anti Miss: <b>ON</b>\n• Perfect weight: <b>100</b>, rest <b>0</b>"
})
infoLeft:AddSeparator("InfoSep2", {})
infoLeft:AddLabel("InfoL3", {
    Text = "<font color='#5BC8F5'><b>Keybind:</b></font> RightShift = toggle UI"
})

infoRight:AddLabel("InfoR1", { Text = "<font color='#F5A623'><b>Feature Guide</b></font>" })
infoRight:AddSeparator("InfoSepR1", {})
infoRight:AddLabel("InfoR2", { Text = "<font color='#5BC8F5'><b>Enable</b></font>\nTurns the auto player on/off." })
infoRight:AddLabel("InfoR3", { Text = "<font color='#5BC8F5'><b>Perfected</b></font>\nRenderStepped + zero-yield.\nBest timing accuracy." })
infoRight:AddLabel("InfoR4", { Text = "<font color='#5BC8F5'><b>Anti Miss</b></font>\nScans wide but only fires at the\ncalibrated trigger point.\nCatches notes even during holds\nor lag spikes. Safe to leave ON." })
infoRight:AddLabel("InfoR5", { Text = "<font color='#5BC8F5'><b>Auto Latency</b></font>\nReads the ms counter every ~4s\nand self-adjusts timing.\nStarts at 103ms, self-corrects\nto any scroll speed automatically." })
infoRight:AddLabel("InfoR6", { Text = "<font color='#5BC8F5'><b>Tile Lights</b></font>\nLights up mobile receptors when\na key is pressed/held.\nCosmetic only, no impact on gameplay." })
infoRight:AddLabel("InfoR7", {
    Text = "<font color='#5BC8F5'><b>Hit Chances</b></font>\nWeights not percentages.\nAll 0 → always Perfect.\n\n<font color='#F5A623'><b>Windows:</b></font>\nPerfect: immediate\nSick: +45ms / Good: +75ms\nOk: +125ms / Bad: +175ms"
})

-- ── Groupboxes ────────────────────────────────
local apGroup     = mainTab:AddLeftGroupbox( "APGroup",     { Text = "Auto Player"     })
local playerGroup = mainTab:AddLeftGroupbox( "PlayerGroup", { Text = "Player Settings" })
local chanceGroup = mainTab:AddRightGroupbox("ChanceGroup", { Text = "Hit Chances"     })
local miscGroup   = miscTab:AddLeftGroupbox( "MiscGroup",   { Text = "Platform Display" })
local themeGroup  = settingsTab:AddLeftGroupbox("ThemeGroup", { Text = "Theme" })

-- ── Auto Player ───────────────────────────────
apGroup:AddToggle("AutoPlayerEnabled", {
    Text    = "Enable",
    Value   = false,
    Tooltip = "Turns the auto player on or off",
    Callback = function(val)
        v8 = val
        if v8 then
            laneHoldFrame = {nil,nil,nil,nil}
            lanePressed   = {false,false,false,false}
            for i = 1,4 do vimUp(i) end
            seenNotes = {}
            startLoop()
            if autoLatency then startAutoLatency() end
            window:Notification({ Title = "AutoPlayer", Text = "Turned <font color='#5BC8F5'><b>ON</b></font>", Duration = 2 })
        else
            for i = 1, 4 do
                if laneHoldFrame[i] then stopHold(i, nil) end
                vimUp(i)
            end
            if mainLoop then mainLoop:Disconnect(); mainLoop = nil end
            stopAutoLatency()
            laneHoldFrame = {nil,nil,nil,nil}
            lanePressed   = {false,false,false,false}
            seenNotes = {}
            window:Notification({ Title = "AutoPlayer", Text = "Turned <font color='#F5A623'><b>OFF</b></font>", Duration = 2 })
        end
    end,
})

apGroup:AddSeparator("APSep1", {})

apGroup:AddToggle("Perfected", {
    Text    = "Perfected",
    Value   = false,
    Tooltip = "RenderStepped + zero-yield. Best for perfect timing.",
    Callback = function(val)
        perfected = val
        if val then minReaction = 0; maxReaction = 0 end
        if v8 then
            if mainLoop then mainLoop:Disconnect(); mainLoop = nil end
            startLoop()
        end
        window:Notification({
            Title = "Perfected",
            Text  = val and "<font color='#5BC8F5'>ON</font>" or "<font color='#F5A623'>OFF</font>",
            Duration = 2
        })
    end,
})

apGroup:AddSeparator("APSep2", {})

apGroup:AddToggle("AntiMiss", {
    Text    = "Anti Miss",
    Value   = false,
    Tooltip = "Scans notes early but only fires at the correct trigger point. Prevents skipped notes on dense/fast patterns.",
    Callback = function(val)
        antiMiss = val
        window:Notification({
            Title = "Anti Miss",
            Text  = val and "<font color='#5BC8F5'>ON</font>" or "<font color='#F5A623'>OFF</font>",
            Duration = 2
        })
    end,
})

apGroup:AddSeparator("APSep3", {})

apGroup:AddToggle("TileLights", {
    Text    = "Tile Lights",
    Value   = false,
    Tooltip = "Lights up mobile receptor tiles on keypress/hold. Cosmetic only.",
    Callback = function(val)
        tileLights = val
        -- Reset all tiles when toggling off
        if not val then
            for lane = 1, 4 do
                local img = getArrowImage(currentSide, lane)
                if img then img.ImageTransparency = 0.5 end
            end
        end
        window:Notification({
            Title = "Tile Lights",
            Text  = val and "<font color='#5BC8F5'>ON</font>" or "<font color='#F5A623'>OFF</font>",
            Duration = 2
        })
    end,
})

apGroup:AddSeparator("APSep4", {})

apGroup:AddToggle("MissJacks", {
    Text    = "Miss Jack Notes",
    Value   = false,
    Tooltip = "Skips rapid same-key notes to look more human",
    Callback = function(val) missJacks = val end,
})

apGroup:AddSeparator("APSep5", {})

apGroup:AddToggle("LegitMode", {
    Text    = "Legit Mode",
    Value   = false,
    Tooltip = "Caps KPS and biases ratings toward Sick/Good",
    Callback = function(val)
        legitMode = val
        if val then
            perfectChance=35; sickChance=45; goodChance=15
            okChance=4; badChance=1; missChance=0
        else
            perfectChance=100; sickChance=0; goodChance=0
            okChance=0; badChance=0; missChance=0
        end
        window:Notification({
            Title = "Legit Mode",
            Text  = val and "ON — KPS cap: <b>"..legitKpsLimit.."</b>" or "OFF",
            Duration = 2
        })
    end,
})

apGroup:AddSlider("LegitKpsLimit", {
    Text    = "KPS Limit",
    Min     = 1, Max = 100, Value = 100, Step = 1,
    Tooltip = "Max KPS in Legit Mode",
    Callback = function(val) legitKpsLimit = val end,
})

-- ── Player Settings ───────────────────────────
playerGroup:AddToggle("AutoLatency", {
    Text    = "Auto Latency",
    Value   = true,
    Tooltip = "Reads the ms counter every ~4s and auto-adjusts timing. Starts at 103ms and self-corrects continuously.",
    Callback = function(val)
        autoLatency = val
        if val and v8 then
            startAutoLatency()
        elseif not val then
            stopAutoLatency()
        end
        window:Notification({
            Title = "Auto Latency",
            Text  = val
                and "<font color='#5BC8F5'>ON</font> — self-correcting from ms counter"
                or  "<font color='#F5A623'>OFF</font> — using manual slider",
            Duration = 3
        })
    end,
})
playerGroup:AddLabel("LatencyLabel", {
    Text = "<font color='#888'>Manual: disable Auto Latency first.\nms counter + → raise  /  - → lower</font>"
})
playerGroup:AddSlider("VimLatency", {
    Text    = "VIM Latency (ms)",
    Min     = 0, Max = 300, Value = 103, Step = 1,
    Tooltip = "Only active when Auto Latency is OFF.",
    Callback = function(val) if not autoLatency then vimLatencyMs = math.floor(val) end end,
})
playerGroup:AddSeparator("PlayerSep0", {})
playerGroup:AddSlider("MinReaction", {
    Text    = "Min Reaction (ms)",
    Min     = 0, Max = 150, Value = 0, Step = 1,
    Tooltip = "Minimum reaction delay. Ignored when Perfected is ON.",
    Callback = function(val) if not perfected then minReaction = math.floor(val) end end,
})
playerGroup:AddSlider("MaxReaction", {
    Text    = "Max Reaction (ms)",
    Min     = 0, Max = 150, Value = 0, Step = 1,
    Tooltip = "Maximum reaction delay. Ignored when Perfected is ON.",
    Callback = function(val) if not perfected then maxReaction = math.floor(val) end end,
})

-- ── Hit Chances ───────────────────────────────
chanceGroup:AddLabel("ChanceInfo", {
    Text = "<font color='#F5A623'><b>Weights, not %.</b></font>\nAll 0 → always Perfect.\nLocked while Legit Mode is ON."
})
chanceGroup:AddSeparator("ChanceSep", {})
chanceGroup:AddSlider("PerfectChance", {
    Text = "Perfect", Min = 0, Max = 100, Value = 100, Step = 1,
    Callback = function(val) if not legitMode then perfectChance = math.floor(val) end end,
})
chanceGroup:AddSlider("SickChance", {
    Text = "Sick", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "+45ms",
    Callback = function(val) if not legitMode then sickChance = math.floor(val) end end,
})
chanceGroup:AddSlider("GoodChance", {
    Text = "Good", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "+75ms",
    Callback = function(val) if not legitMode then goodChance = math.floor(val) end end,
})
chanceGroup:AddSlider("OkChance", {
    Text = "Ok", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "+125ms",
    Callback = function(val) if not legitMode then okChance = math.floor(val) end end,
})
chanceGroup:AddSlider("BadChance", {
    Text = "Bad", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "+175ms",
    Callback = function(val) if not legitMode then badChance = math.floor(val) end end,
})
chanceGroup:AddSlider("MissChance", {
    Text = "Miss", Min = 0, Max = 100, Value = 0, Step = 1,
    Callback = function(val) if not legitMode then missChance = math.floor(val) end end,
})

-- ── Misc ──────────────────────────────────────
miscGroup:AddToggle("PlatformAutoRejoin", {
    Text     = "Custom Platform Display",
    Value    = true,
    Tooltip  = "Enable auto-rejoin after setting platform display",
    Callback = function(val) platformAutoRejoin = val end,
})
miscGroup:AddTextBox("PlatformContent", {
    Text            = "Display Content",
    Value           = "😇",
    PlaceholderText = "Enter text or emoji...",
    Callback        = function(val)
        if val and val ~= "" then platformContent = val end
    end,
})
miscGroup:AddButton("ApplyPlatform", {
    Text    = "Apply Platform Display",
    Tooltip = "Applies your display content and optionally rejoins",
    Callback = function()
        if game.PlaceId ~= 6520999642 then
            window:Notification({ Title = "Error", Text = "Wrong game!", Duration = 3 }); return
        end
        if not (isfile and readfile and writefile) then
            window:Notification({ Title = "Error", Text = "Incompatible executor!", Duration = 3 }); return
        end
        local QueueOnTP = (syn and syn.queue_on_teleport)
            or (fluxus and fluxus.queue_on_teleport)
            or (queue_on_teleport and queue_on_teleport)
        if not QueueOnTP then
            window:Notification({ Title = "Error", Text = "Missing queue_on_teleport!", Duration = 3 }); return
        end
        local Content = platformContent
        writefile("FNFRemixDisplayContent.txt", tostring(Content))
        local SG  = game:GetService("StarterGui")
        local P   = game:GetService("Players")
        local TPS = game:GetService("TeleportService")
        local Spk = P.LocalPlayer
        local function Alert()
            local s = Instance.new("Sound", game:GetService("SoundService"))
            s.Volume = 2; s.SoundId = "rbxassetid://4590662766"
            s.PlayOnRemove = true; s:Destroy()
        end
        if _G.FNFRemixACPD or (getgenv and getgenv().FNFRemixACPD) then
            SG:SetCore("SendNotification", { Title="🧐 Changed!", Text="Display: '"..Content.."'", Duration=5 })
            window:Notification({ Title = "Platform", Text = "Content: "..Content, Duration = 4 })
            Alert(); return
        end
        local Rejoin = Instance.new("BindableFunction")
        Rejoin.OnInvoke = function(Ans)
            if Ans == "Yes" and platformAutoRejoin then
                if #P:GetPlayers() <= 1 then
                    Spk:Kick("\nRejoining..."); task.wait()
                    TPS:Teleport(6520999642, Spk)
                else
                    TPS:TeleportToPlaceInstance(6520999642, game.JobId, Spk)
                end
            end
        end
        QueueOnTP([[
            if game.PlaceId ~= 6520999642 then return end
            if not (isfile and readfile) then return end
            local Content = (isfile('FNFRemixDisplayContent.txt') and readfile('FNFRemixDisplayContent.txt')) or '😇'
            local Speaker = game:GetService'Players'.LocalPlayer
            task.spawn(function()
                local conn
                conn = Speaker:WaitForChild'PlayerScripts'.ChildAdded:Connect(function(Child)
                    if Child:IsA'LocalScript' and Child.Name == 'PlatformDisplay' then
                        Child.Disabled = true; conn:Disconnect()
                    end
                end)
            end)
            game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild'PlatformRemoteEvent':FireServer(tostring(Content))
        ]])
        SG:SetCore("SendNotification", {
            Title=platformAutoRejoin and "🧐 Rejoin?" or "🧐 Done",
            Text=platformAutoRejoin and "Rejoin to apply '"..Content.."'?" or "Rejoin manually.",
            Button1="Yes", Button2="No", Duration=(1/0), Callback=Rejoin,
        })
        Alert()
        window:Notification({ Title = "Platform", Text = "Set: "..Content, Duration = 4 })
        if getgenv then getgenv().FNFRemixACPD = true else _G.FNFRemixACPD = true end
    end,
})

-- ── Settings ──────────────────────────────────
themeGroup:AddLabel("ThemeLbl1", {
    Text = "<font color='#5BC8F5'><b>Accent</b></font> (default: sky blue #5BC8F5)"
}):AddColorPicker("ThemeMain", {
    Value    = C_BLUE,
    Callback = function(val)
        window.Theme = { Back=C_BG, Main=val, Stroke=C_ORANGE, Text=C_WHITE }
        window:Refresh()
    end,
})
themeGroup:AddLabel("ThemeLbl2", {
    Text = "<font color='#F5A623'><b>Stroke</b></font> (default: gold #F5A623)"
}):AddColorPicker("ThemeStroke", {
    Value    = C_ORANGE,
    Callback = function(val)
        window.Theme = { Back=C_BG, Main=C_BLUE, Stroke=val, Text=C_WHITE }
        window:Refresh()
    end,
})
