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
-- over 4 seconds total (tween speed = 22 * scrollSpeed / 4 per second)
-- Hit window: |scale| <= 2.4 * scrollSpeed (clamped 1-9)
-- Perfect+Sick window: |scale| <= 0.71775 * scrollSpeed
-- Miss threshold: |scale| > 0.6 * scrollSpeed (clamped 0.9-4)
--
-- VIM latency on mobile is typically 10-20ms. Notes move at:
--   (22 * scrollSpeed) scale units / 4 seconds = 5.5 * scrollSpeed units/sec
-- At 15ms VIM latency: lead = 0.015 * 5.5 * scrollSpeed = 0.0825 * scrollSpeed
-- We trigger when: |scale| <= perfectWindow + vimLead
-- perfectWindow = 0.71775 * scrollSpeed, vimLead ~ 0.15 * scrollSpeed (generous)
-- So trigger at: |scale| <= 0.87 * scrollSpeed
-- This is computed per-frame using current scrollSpeed from _G.Settings.NoteSpeed

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
-- After the head note is hit, the game moves the Hold_ frame from
-- Notes into ArrowN.Hold.Hitbox. It stays there until Debris destroys it.
-- We watch the Hitbox for ChildRemoved to know when the hold is done.
local function watchHold(ai, arrowFrame, holdFrame)
    laneHoldFrame[ai] = holdFrame
    local hitbox = arrowFrame:FindFirstChild("Hold") and
                   arrowFrame.Hold:FindFirstChild("Hitbox")
    if not hitbox then
        -- Fallback: watch holdFrame ancestry directly
        holdFrame.AncestryChanged:Connect(function()
            if laneHoldFrame[ai] == holdFrame and
               not holdFrame:IsDescendantOf(game) then
                releaseHold(ai)
            end
        end)
        return
    end

    -- Primary: watch Hitbox.ChildRemoved — fires when Debris destroys holdFrame
    local conn
    conn = hitbox.ChildRemoved:Connect(function(child)
        if child == holdFrame or laneHoldFrame[ai] == holdFrame then
            releaseHold(ai)
            conn:Disconnect()
        end
    end)

    -- Fallback: ancestry watch on holdFrame itself
    holdFrame.AncestryChanged:Connect(function()
        if laneHoldFrame[ai] == holdFrame and
           not holdFrame:IsDescendantOf(game) then
            releaseHold(ai)
            if conn then conn:Disconnect() end
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

    -- pendingHold[i]: a {frame, arrowFrame} pair registered from Notes
    local pendingHold = {nil,nil,nil,nil}

    local function tick_fn(sync)
        if not v8 then return end
        local KS = getMyKeySync()
        if not (KS and KS.Visible) then return end

        -- Get current scroll speed and direction from game
        local spd = (_G and _G.Settings and _G.Settings.NoteSpeed) or 2
        spd = math.clamp(tonumber(spd) or 2, 0.8, 5)
        local dir = (_G and _G.Settings and _G.Settings.Direction) or 1

        -- Trigger window: fire VIM when note is within this scale distance
        -- perfectWindow = 0.71775 * spd, add ~0.15*spd lead for VIM latency
        -- This means we fire VIM slightly before the perfect window opens,
        -- so by the time VIM delivers the key event the note is in the window.
        local triggerScale = 0.87 * spd

        for i = 1, 4 do
            local f = KS:FindFirstChild("Arrow"..i)
            local n = f and f:FindFirstChild("Notes")
            if not (f and n) then continue end

            if not cacheBuilt[i] then
                cacheBuilt[i] = true
                -- Cleanup: remove from seen tables when notes leave tree
                n.ChildAdded:Connect(function(c)
                    c.AncestryChanged:Connect(function()
                        if not c:IsDescendantOf(game) then
                            seenNotes[c] = nil
                            seenHolds[c] = nil
                            if pendingHold[i] and pendingHold[i][1] == c then
                                pendingHold[i] = nil
                            end
                        end
                    end)
                end)
            end

            if laneHoldFrame[i] then continue end

            for _, child in pairs(n:GetChildren()) do
                if not child:IsA("GuiObject") then continue end
                if child.Name == "Arrow" then continue end

                local scale = child.Position.Y.Scale
                local dist  = math.abs(scale)

                -- Only detect notes approaching from the correct direction
                -- dir=1: notes fall down, scale goes from positive toward 0
                -- dir=-1: notes rise up, scale goes from negative toward 0
                -- We want: scale * dir > 0 (approaching) OR already in window
                if dist > triggerScale then continue end

                if child.Name:sub(1,5) == "Hold_" then
                    -- Hold tail frame — register as pending for this lane
                    if not seenHolds[child] then
                        seenHolds[child] = true
                        pendingHold[i] = {child, f}
                    end
                elseif not seenNotes[child] then
                    -- Regular note (head note, possibly with pending hold)
                    if not child.Visible then continue end
                    seenNotes[child] = true

                    -- Release any current hold if we have a new note
                    if laneHoldFrame[i] then releaseHold(i) end

                    -- Check if there's a pending hold frame for this note
                    -- (hold frame appears in Notes alongside the head note)
                    local ph = pendingHold[i]
                    local isHold = ph ~= nil
                    local holdFrame = isHold and ph[1] or nil
                    local arrowFrame = isHold and ph[2] or f
                    if isHold then pendingHold[i] = nil end

                    handleNote(i, child, arrowFrame, isHold, holdFrame, sync)

                    child.AncestryChanged:Once(function()
                        seenNotes[child] = nil
                    end)
                end
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
local infoTab     = window:AddTab("InfoTab",     { Text = "📖 Info"     })
local mainTab     = window:AddTab("MainTab",     { Text = "⚙ Main"     })
local miscTab     = window:AddTab("MiscTab",     { Text = "🎭 Misc"     })
local settingsTab = window:AddTab("SettingsTab", { Text = "🎨 Settings" })

-- ── Info tab ──────────────────────────────────
local infoLeft  = infoTab:AddLeftGroupbox("InfoLeft",  { Text = "👋 Welcome" })
local infoRight = infoTab:AddRightGroupbox("InfoRight", { Text = "🎵 How It Works" })

infoLeft:AddLabel("InfoL1", {
    Text = "<font color='#5BC8F5'><b>w0opsie's Auto Player</b></font>\nMade with 💙 by w0opsie\n\nThis script automatically plays\n<b>Basically FNF: Remix</b> for you!"
})
infoLeft:AddSeparator("InfoSep1", {})
infoLeft:AddLabel("InfoL2", {
    Text = "<font color='#F5A623'><b>📌 Best settings for all Perfects:</b></font>\n• Perfected: <b>ON</b>\n• Min/Max Reaction: <b>0ms</b>\n• Perfect weight: <b>100</b>, rest <b>0</b>\n• Works at <b>any scroll speed</b>"
})
infoLeft:AddSeparator("InfoSep2", {})
infoLeft:AddLabel("InfoL3", {
    Text = "<font color='#5BC8F5'><b>⌨ Keybind:</b></font> RightShift = toggle UI"
})

infoRight:AddLabel("InfoR1", { Text = "<font color='#F5A623'><b>🎮 Feature Guide</b></font>" })
infoRight:AddSeparator("InfoSepR1", {})
infoRight:AddLabel("InfoR2", { Text = "<font color='#5BC8F5'><b>Enable</b></font>\nTurns the auto player on/off." })
infoRight:AddLabel("InfoR3", { Text = "<font color='#5BC8F5'><b>Input</b></font>\nUses VirtualInputManager — confirmed working." })
infoRight:AddLabel("InfoR4", { Text = "<font color='#5BC8F5'><b>Miss Jack Notes</b></font>\nSkips rapid same-key notes." })
infoRight:AddLabel("InfoR5", { Text = "<font color='#5BC8F5'><b>Legit Mode</b></font>\nCaps KPS and biases toward Sick/Good." })
infoRight:AddLabel("InfoR6", { Text = "<font color='#5BC8F5'><b>Perfected</b></font>\nRenderStepped + zero-yield press.\nDetects by Position.Y.Scale (same as game).\nAutomatically calibrated to scroll speed.\nHolds release via Hitbox.ChildRemoved." })
infoRight:AddLabel("InfoR7", {
    Text = "<font color='#5BC8F5'><b>Hit Chances</b></font>\nWeights not percentages.\nAll 0 → always Perfect.\n\n<font color='#F5A623'><b>Windows:</b></font>\n⬜ Perfect: immediate\n🟣 Sick: +45ms\n🟢 Good: +75ms\n🟡 Ok: +125ms\n🔴 Bad: +175ms"
})

-- ── Groupboxes ────────────────────────────────
local apGroup     = mainTab:AddLeftGroupbox( "APGroup",     { Text = "⚡ Auto Player"     })
local playerGroup = mainTab:AddLeftGroupbox( "PlayerGroup", { Text = "🎯 Player Settings" })
local chanceGroup = mainTab:AddRightGroupbox("ChanceGroup", { Text = "🎲 Hit Chances"     })
local miscGroup   = miscTab:AddLeftGroupbox( "MiscGroup",   { Text = "🎭 Platform Display" })
local themeGroup  = settingsTab:AddLeftGroupbox("ThemeGroup", { Text = "🎨 Theme" })

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
            window:Notification({ Title = "✅ AutoPlayer", Text = "Turned <font color='#5BC8F5'><b>ON</b></font>", Duration = 2 })
        else
            for i = 1, 4 do releaseHold(i) end
            for _, k in pairs(v4.KeyBinds) do doRelease(k) end
            if mainLoop then mainLoop:Disconnect(); mainLoop = nil end
            laneHeld      = {false,false,false,false}
            laneHoldFrame = {nil,nil,nil,nil}
            window:Notification({ Title = "❌ AutoPlayer", Text = "Turned <font color='#F5A623'><b>OFF</b></font>", Duration = 2 })
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
            window:Notification({ Title = "❌ Error", Text = "Wrong game!", Duration = 3 }); return
        end
        if not (isfile and readfile and writefile) then
            window:Notification({ Title = "❌ Error", Text = "Incompatible executor!", Duration = 3 }); return
        end
        local QueueOnTP = (syn and syn.queue_on_teleport)
            or (fluxus and fluxus.queue_on_teleport)
            or (queue_on_teleport and queue_on_teleport)
        if not QueueOnTP then
            window:Notification({ Title = "❌ Error", Text = "Missing queue_on_teleport!", Duration = 3 }); return
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
