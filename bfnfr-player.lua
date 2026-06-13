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

-- ── Timing constants (from decompiled source) ─────────────────────────────
-- Notes spawn at Y.Scale = 11 * scrollSpeed, move to -11 * scrollSpeed
-- over 4 seconds total → note velocity = 5.5 * scrollSpeed scale units/sec
-- NoteInput accepts hit when: |scale| / (11 * spd) <= 0.06525
--   → Perfect window = 0.71775 * spd
--
-- BUG FIX: old trigger was 0.87*spd which fires 27.7ms BEFORE perfect window
-- even before accounting for VIM latency. Combined with ~22ms VIM delivery
-- that was ~50ms net error (ms counter showed ~100ms late = we pressed early).
--
-- CORRECT formula: trigger = (0.71775 - latency_sec * 5.5) * spd
--   We fire VIM exactly vimLatencyMs before the perfect edge so the note
--   reaches scale=0 as VIM delivers the keydown.
--   vimLatencyMs is tunable (default 22ms). Adjust empirically:
--     ms counter shows positive → lower vimLatencyMs
--     ms counter shows negative → raise vimLatencyMs
local vimLatencyMs = 22  -- tweak this to dial in perfect timing

local function calcTriggerScale(spd)
    local latSec = vimLatencyMs / 1000
    local coeff  = 0.71775 - latSec * 5.5
    coeff = math.clamp(coeff, 0.05, 0.71775)
    return coeff * spd
end

local v4 = {
    KeyBinds    = {Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.W, Enum.KeyCode.D},
    TapDuration = 0.05,
}

local v5 = Players.LocalPlayer
local v8 = false
local missJacks  = false
local legitMode  = false
local perfected  = false
local mainLoop   = nil
local heldKeys   = {}
local kpsLog     = {}

local laneHeld      = {false,false,false,false}
local laneHoldFrame = {nil,nil,nil,nil} -- Hold_ frame currently being held
local seenNotes     = {}
local seenHolds     = {}

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

-- ── Input ─────────────────────────────────────
local function doPress(key)
    if not heldKeys[key] then
        heldKeys[key] = true
        VIM:SendKeyEvent(true, key, false, game)
    end
end
local function doRelease(key)
    if heldKeys[key] then
        heldKeys[key] = nil
        VIM:SendKeyEvent(false, key, false, game)
    end
end

local function releaseHold(i)
    if laneHoldFrame[i] then
        laneHoldFrame[i] = nil
        doRelease(v4.KeyBinds[i])
    end
end

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

-- ── Hold release watcher ──────────────────────
-- SEQUENCE (from decompiled NoteInput, lines 1018-1033):
--   1. We detect note + grab holdFrame from Notes BEFORE pressing
--   2. We call pressKey → NoteInput fires synchronously → moves holdFrame to Hitbox
--   3. We poll until holdFrame:IsDescendantOf(hitbox) is true (up to 80ms)
--   4. ONLY THEN connect hitbox.ChildRemoved for our specific frame
--   5. Debris destroys holdFrame after holdDuration → ChildRemoved fires → release
--   6. Heartbeat fallback: release if holdFrame leaves game tree entirely
--
-- WHY previous approach was broken:
--   - watchHold was called BEFORE press, so ChildRemoved on Hitbox fired
--     when the frame was reparented INTO Hitbox (wrong trigger)
--   - AncestryChanged fires on every reparent, not just destruction
local function watchHold(ai, arrowFrame, holdFrame)
    laneHoldFrame[ai] = holdFrame
    local hitbox = arrowFrame:FindFirstChild("Hold") and
                   arrowFrame.Hold:FindFirstChild("Hitbox")

    if not hitbox then
        -- No hitbox found: pure heartbeat fallback
        task.spawn(function()
            while laneHoldFrame[ai] == holdFrame do
                RunService.Heartbeat:Wait()
                if not holdFrame:IsDescendantOf(game) then
                    releaseHold(ai); return
                end
            end
        end)
        return
    end

    -- Poll until NoteInput has moved holdFrame into Hitbox (happens within 1-2 frames)
    task.spawn(function()
        local deadline = tick() + 0.08  -- 80ms max wait (~5 frames at 60fps)
        while tick() < deadline do
            if laneHoldFrame[ai] ~= holdFrame then return end  -- cancelled
            if holdFrame:IsDescendantOf(hitbox) then
                -- Frame is now in Hitbox. Connect ChildRemoved for THIS frame only.
                local conn
                conn = hitbox.ChildRemoved:Connect(function(child)
                    if child == holdFrame then
                        conn:Disconnect()
                        releaseHold(ai)
                    end
                end)
                -- Heartbeat fallback in case ChildRemoved misfires
                task.spawn(function()
                    while laneHoldFrame[ai] == holdFrame do
                        RunService.Heartbeat:Wait()
                        if not holdFrame:IsDescendantOf(game) then
                            conn:Disconnect()
                            releaseHold(ai); return
                        end
                    end
                end)
                return
            end
            if not holdFrame:IsDescendantOf(game) then
                -- Already destroyed before we could watch (very short hold)
                releaseHold(ai); return
            end
            RunService.Heartbeat:Wait()
        end
        -- Timeout: frame never arrived in Hitbox — release to avoid stuck key
        if laneHoldFrame[ai] == holdFrame then
            releaseHold(ai)
        end
    end)
end

-- ── Note handler ──────────────────────────────
local HIT_OFFSETS = { sick=0.045, good=0.075, ok=0.125, bad=0.175 }

local function handleNote(ai, note, arrowFrame, isHold, holdFrame, sync)
    local key = v4.KeyBinds[ai]

    -- Release any active hold (new note coming in)
    if laneHoldFrame[ai] then releaseHold(ai) end

    -- Jack check for regular taps
    if not isHold and laneHeld[ai] then
        if missJacks then return end
        if not sync then
            task.spawn(function()
                doRelease(key); task.wait(0.02)
                doPress(key); task.wait(v4.TapDuration); doRelease(key)
            end)
        end
        return
    end

    local function pressPath()
        if not canPress() then
            if not isHold then laneHeld[ai] = false end
            return
        end
        doRelease(key)
        if not sync then task.wait() end
        doPress(key)
        if isHold then
            -- Watch for hold completion — release when Debris destroys holdFrame
            watchHold(ai, arrowFrame, holdFrame)
        else
            laneHeld[ai] = true
            task.delay(v4.TapDuration, function()
                doRelease(key); laneHeld[ai] = false
            end)
        end
    end

    if sync then
        local rating = pickRating()
        if rating == "miss" then
            if not isHold then laneHeld[ai] = false end
            return
        end
        pressPath()
    else
        task.spawn(function()
            local rating = pickRating()
            if maxReaction > 0 then
                local lo = math.min(minReaction, maxReaction)
                local hi = math.max(minReaction, maxReaction)
                task.wait((lo == hi and lo or math.random(lo,hi)) / 1000)
            end
            if rating ~= "perfect" then
                local off = HIT_OFFSETS[rating]
                if off then task.wait(off) end
            end
            if not canPress() then
                if not isHold then laneHeld[ai] = false end
                return
            end
            if rating == "miss" then
                if not isHold then laneHeld[ai] = false end
                return
            end
            pressPath()
        end)
    end
end

local function getMyKeySync()
    local M = v5.PlayerGui:FindFirstChild("Main")
        and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
    if not (M and M.Visible) then return nil end
    local pv = v5:FindFirstChild("File") and v5.File:FindFirstChild("CurrentPlayer")
    if pv and pv.Value then
        return M:FindFirstChild(pv.Value.Name == "Player2" and "KeySync2" or "KeySync1")
    end
end

-- ── Main loop ─────────────────────────────────
local function startLoop()
    if mainLoop then mainLoop:Disconnect(); mainLoop = nil end

    seenNotes = {}
    seenHolds = {}
    local cacheBuilt = {}

    -- pendingHold removed: hold frame is named "Hold_<noteName>" per decompiled
    -- source (v100.Name = "Hold_" .. p90). We look it up directly by name when
    -- we see a HoldHead note — no pre-registration or ordering dependency needed.

    local function tick_fn(sync)
        if not v8 then return end
        local KS = getMyKeySync()
        if not (KS and KS.Visible) then return end

        local spd = (_G and _G.Settings and _G.Settings.NoteSpeed) or 2
        spd = math.clamp(tonumber(spd) or 2, 0.8, 5)

        -- Trigger window: fire VIM exactly vimLatencyMs before perfect edge
        local triggerScale = calcTriggerScale(spd)

        for i = 1, 4 do
            local f = KS:FindFirstChild("Arrow"..i)
            local n = f and f:FindFirstChild("Notes")
            if not (f and n) then continue end

            if not cacheBuilt[i] then
                cacheBuilt[i] = true
                n.ChildAdded:Connect(function(c)
                    c.AncestryChanged:Connect(function()
                        if not c:IsDescendantOf(game) then
                            seenNotes[c] = nil
                            seenHolds[c] = nil
                        end
                    end)
                end)
            end

            if laneHoldFrame[i] then continue end

            for _, child in pairs(n:GetChildren()) do
                if not child:IsA("GuiObject") then continue end
                -- Skip hold tail frames and the static Arrow object
                if child.Name:sub(1,5) == "Hold_" then continue end
                if child.Name == "Arrow" then continue end

                local dist = math.abs(child.Position.Y.Scale)
                if dist > triggerScale then continue end
                if not child.Visible then continue end
                if seenNotes[child] then continue end

                seenNotes[child] = true

                if laneHoldFrame[i] then releaseHold(i) end

                -- Detect hold head and locate its tail frame directly by name
                local isHold    = child:GetAttribute("HoldHead") == true
                local holdFrame = isHold and n:FindFirstChild("Hold_" .. child.Name) or nil

                handleNote(i, child, f, isHold, holdFrame, sync)

                child.AncestryChanged:Once(function()
                    seenNotes[child] = nil
                end)
            end
        end
    end

    if perfected then
        mainLoop = RunService.RenderStepped:Connect(function() tick_fn(true) end)
    else
        mainLoop = RunService.Heartbeat:Connect(function() tick_fn(false) end)
    end
end

-- ── Tabs ──────────────────────────────────────
local infoTab     = window:AddTab("InfoTab",     { Text = "Info"     })
local mainTab     = window:AddTab("MainTab",     { Text = "Main"     })
local miscTab     = window:AddTab("MiscTab",     { Text = "Misc"     })
local settingsTab = window:AddTab("SettingsTab", { Text = "Settings" })

-- ── Info tab ──────────────────────────────────
local infoLeft  = infoTab:AddLeftGroupbox("InfoLeft",  { Text = "Welcome" })
local infoRight = infoTab:AddRightGroupbox("InfoRight", { Text = "How It Works" })

infoLeft:AddLabel("InfoL1", {
    Text = "<font color='#5BC8F5'><b>w0opsie's Auto Player</b></font>\nMade with love by w0opsie\n\nThis script automatically plays\n<b>Basically FNF: Remix</b> for you!"
})
infoLeft:AddSeparator("InfoSep1", {})
infoLeft:AddLabel("InfoL2", {
    Text = "<font color='#F5A623'><b>Best settings for all Perfects:</b></font>\n• Perfected: <b>ON</b>\n• Min/Max Reaction: <b>0ms</b>\n• Perfect weight: <b>100</b>, rest <b>0</b>\n• Works at <b>any scroll speed</b>"
})
infoLeft:AddSeparator("InfoSep2", {})
infoLeft:AddLabel("InfoL3", {
    Text = "<font color='#5BC8F5'><b>Keybind:</b></font> RightShift = toggle UI"
})

infoRight:AddLabel("InfoR1", { Text = "<font color='#F5A623'><b>Feature Guide</b></font>" })
infoRight:AddSeparator("InfoSepR1", {})
infoRight:AddLabel("InfoR2", { Text = "<font color='#5BC8F5'><b>Enable</b></font>\nTurns the auto player on/off." })
infoRight:AddLabel("InfoR3", { Text = "<font color='#5BC8F5'><b>Input</b></font>\nUses VirtualInputManager — confirmed working." })
infoRight:AddLabel("InfoR4", { Text = "<font color='#5BC8F5'><b>Miss Jack Notes</b></font>\nSkips rapid same-key notes." })
infoRight:AddLabel("InfoR5", { Text = "<font color='#5BC8F5'><b>Legit Mode</b></font>\nCaps KPS and biases toward Sick/Good." })
infoRight:AddLabel("InfoR6", { Text = "<font color='#5BC8F5'><b>Perfected</b></font>\nRenderStepped + zero-yield press.\nDetects by Position.Y.Scale (same as game).\nAutomatically calibrated to scroll speed.\nHolds release via Hitbox.ChildRemoved." })
infoRight:AddLabel("InfoR7", {
    Text = "<font color='#5BC8F5'><b>Hit Chances</b></font>\nWeights not percentages.\nAll 0 → always Perfect.\n\n<font color='#F5A623'><b>Windows:</b></font>\nPerfect: immediate\nSick: +45ms\nGood: +75ms\nOk: +125ms\nBad: +175ms"
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
            laneHeld      = {false,false,false,false}
            laneHoldFrame = {nil,nil,nil,nil}
            for _, k in pairs(v4.KeyBinds) do doRelease(k) end
            startLoop()
            window:Notification({ Title = "AutoPlayer", Text = "Turned <font color='#5BC8F5'><b>ON</b></font>", Duration = 2 })
        else
            for i = 1, 4 do releaseHold(i) end
            for _, k in pairs(v4.KeyBinds) do doRelease(k) end
            if mainLoop then mainLoop:Disconnect(); mainLoop = nil end
            laneHeld      = {false,false,false,false}
            laneHoldFrame = {nil,nil,nil,nil}
            window:Notification({ Title = "AutoPlayer", Text = "Turned <font color='#F5A623'><b>OFF</b></font>", Duration = 2 })
        end
    end,
})

apGroup:AddSeparator("APSep1", {})

apGroup:AddToggle("MissJacks", {
    Text    = "Miss Jack Notes",
    Value   = false,
    Tooltip = "Skips rapid same-key notes",
    Callback = function(val) missJacks = val end,
})

apGroup:AddSeparator("APSep2", {})

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

apGroup:AddSeparator("APSep3", {})

apGroup:AddToggle("Perfected", {
    Text    = "Perfected",
    Value   = false,
    Tooltip = "RenderStepped + zero-yield. Auto-calibrates to scroll speed.",
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

-- ── Player Settings ───────────────────────────
playerGroup:AddSlider("VimLatency", {
    Text    = "VIM Latency (ms)",
    Min     = 0, Max = 80, Value = 22, Step = 1,
    Tooltip = "VIM delivery compensation. Lower if ms counter shows +, raise if shows -.",
    Callback = function(val) vimLatencyMs = math.floor(val) end,
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

-- ── Misc tab ──────────────────────────────────
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

-- ── Settings tab ──────────────────────────────
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
