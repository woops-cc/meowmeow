local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Null-Cherry/Fire-Library/refs/heads/main/Loader.lua", true))()

-- ── OC palette ────────────────────────────────
local C_BLUE   = Color3.fromRGB(91,  200, 245)
local C_ORANGE = Color3.fromRGB(245, 166, 35)
local C_WHITE  = Color3.fromRGB(220, 220, 225)
local C_BG     = Color3.fromRGB(18,  18,  22)

-- ── Window ────────────────────────────────────
local window = lib:Window("w0opsie_ap", {
    Title    = "<font color='#5BC8F5'>w0</font><font color='#F5A623'>o</font><font color='#5BC8F5'>opsie's ap</font>",
    Icon     = "71140941882804",
    Footer   = "<font color='#5BC8F5'>Basically FNF: Remix</font>",
    Keybind  = Enum.KeyCode.RightShift,
    NeonType      = "Top",
    NeonThickness = 2,
    AnimationSpeed     = 1.2,
    ShadowTransparency = 0.4,
    ShadowSize         = 20,
    Image             = "113037548508433",
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

-- ── Icon + Background fix ─────────────────────
-- The library's setIcon sets .Image but NOT .ImageContent.
-- Newer Roblox requires .ImageContent = Content.fromUri(uri).
-- We patch after 3s (library uses spawn() for async download),
-- then watch .Image changes to re-apply — but guard against
-- re-entrancy (setting .Image fires the signal again).
task.defer(function()
    task.wait(3)

    local function patchImg(inst, uri)
        if not inst then return end
        local patching = false
        local function apply()
            if patching then return end
            patching = true
            pcall(function() inst.Image = uri end)
            pcall(function() inst.ImageContent = Content.fromUri(uri) end)
            patching = false
        end
        apply()
        inst:GetPropertyChangedSignal("Image"):Connect(function()
            if inst.Image ~= uri then apply() end
        end)
    end

    pcall(function()
        patchImg(window.Window.RealWindow, "rbxassetid://113037548508433")
    end)
    pcall(function()
        patchImg(
            window.Window.RealWindow.Contents.TopbarZone.TitleZone.Icon,
            "rbxassetid://71140941882804"
        )
    end)
    pcall(function()
        local btn = window.MobileButton.CanvasGroup.ImageLabel
        patchImg(btn, "rbxassetid://71140941882804")
        btn.Visible = true
    end)
end)

-- ── Services ──────────────────────────────────
local RunService = game:GetService("RunService")
local VIM        = game:GetService("VirtualInputManager")
local Players    = game:GetService("Players")

local HIT_OFFSETS = {
    sick = 0.045, good = 0.075, ok = 0.125, bad = 0.175,
}

local v4 = {
    KeyBinds    = {Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.W, Enum.KeyCode.D},
    HitPixels   = 20,
    TapDuration = 0.05,
}

local v5 = Players.LocalPlayer
local v6 = {}       -- regular note dedup
local v8 = false
local missJacks  = false
local legitMode  = false
local perfected  = false
local mainLoop   = nil
local heldKeys   = {}
local kpsLog     = {}

-- Per-lane state
-- laneHeld[i]:      currently doing a tap press on lane i
-- laneHolding[i]:   currently holding a hold note on lane i
-- pendingHold[i]:   a Hold_ frame is in Notes but head not yet at receptor
local laneHeld    = {false,false,false,false}
local laneHolding = {false,false,false,false}
local pendingHold = {nil, nil, nil, nil} -- stores the Hold_ frame

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
-- Watches a Hold_ Frame and releases the key when it leaves the tree.
-- Called once the head note has been pressed (key is already held).
local function watchHoldRelease(ai, holdFrame)
    local key = v4.KeyBinds[ai]
    local released = false
    local function release()
        if released then return end
        released = true
        laneHolding[ai] = false
        pendingHold[ai]  = nil
        doRelease(key)
    end

    holdFrame.AncestryChanged:Connect(function()
        if not holdFrame:IsDescendantOf(game) then release() end
    end)

    local conn
    conn = RunService.Heartbeat:Connect(function()
        if released then conn:Disconnect(); return end
        if not holdFrame:IsDescendantOf(game) then
            release(); conn:Disconnect()
        end
    end)
end

-- ── Note handler ──────────────────────────────
-- Called when a note (regular or hold head) reaches the receptor.
-- If pendingHold[ai] is set, this note is the head of a hold — press
-- and hold instead of tap.
local function handleNote(ai, note, sync)
    local key = v4.KeyBinds[ai]

    if laneHolding[ai] then return end -- already holding, ignore

    local isHold = pendingHold[ai] ~= nil
    local holdFrame = pendingHold[ai]

    if not isHold then
        -- Regular tap: jack check
        if laneHeld[ai] then
            if missJacks then return end
            if not sync then
                task.spawn(function()
                    doRelease(key); task.wait(0.02)
                    doPress(key); task.wait(v4.TapDuration); doRelease(key)
                end)
            end
            return
        end
    end

    local function pressPath()
        if not canPress() then
            if not isHold then laneHeld[ai] = false end
            return
        end

        if isHold then
            -- Hold: press and keep held, release when Hold_ frame removed
            laneHolding[ai] = true
            pendingHold[ai]  = nil
            doRelease(key)
            if not sync then task.wait() end
            doPress(key)
            watchHoldRelease(ai, holdFrame)
        else
            -- Regular tap
            laneHeld[ai] = true
            doRelease(key)
            if not sync then task.wait() end
            doPress(key)
            task.delay(v4.TapDuration, function()
                doRelease(key)
                laneHeld[ai] = false
            end)
        end
    end

    if sync then
        local rating = pickRating()
        if rating == "miss" then return end
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

    local holdConns  = {}
    local seenHolds  = {}
    local cacheBuilt = {}

    -- ChildAdded watcher: when a Hold_ Frame appears, register it as
    -- pendingHold for that lane so the next head note press knows to hold.
    local function setupLane(i, notesFrame)
        if holdConns[i] then holdConns[i]:Disconnect() end
        seenHolds[i] = {}
        holdConns[i] = notesFrame.ChildAdded:Connect(function(c)
            if c.Name:sub(1,5) ~= "Hold_" then return end
            if seenHolds[i][c] then return end
            seenHolds[i][c] = true
            -- Register as pending — the proximity loop will press when
            -- the head note reaches the receptor
            pendingHold[i] = c
            -- Clean up when removed
            c.AncestryChanged:Connect(function()
                if not c:IsDescendantOf(game) then
                    seenHolds[i][c] = nil
                    if pendingHold[i] == c then pendingHold[i] = nil end
                end
            end)
        end)
    end

    local function tick_fn(sync)
        if not v8 then return end
        local KS = getMyKeySync()
        if not (KS and KS.Visible) then return end

        for i = 1, 4 do
            local f = KS:FindFirstChild("Arrow"..i)
            local r = f and f:FindFirstChild("Arrow")
            local n = f and f:FindFirstChild("Notes")
            if not (r and n) then continue end

            if not cacheBuilt[i] then
                cacheBuilt[i] = true
                setupLane(i, n)
            end

            if laneHolding[i] then continue end

            local ty = r.AbsolutePosition.Y
            for _, note in pairs(n:GetChildren()) do
                if not note:IsA("GuiObject") then continue end
                if not note.Visible then continue end
                if note.Name == "Arrow" then continue end
                if note.Name:sub(1,5) == "Hold_" then continue end
                if v6[note] then continue end

                if math.abs(note.AbsolutePosition.Y - ty) <= v4.HitPixels then
                    v6[note] = true
                    handleNote(i, note, sync)
                    note.AncestryChanged:Once(function() v6[note] = nil end)
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
    Text = "<font color='#F5A623'><b>📌 Best settings for all Perfects:</b></font>\n• Scroll speed: <b>2.0</b>\n• Perfected: <b>ON</b>\n• Min/Max Reaction: <b>0ms</b>\n• Perfect weight: <b>100</b>, rest <b>0</b>"
})
infoLeft:AddSeparator("InfoSep2", {})
infoLeft:AddLabel("InfoL3", {
    Text = "<font color='#5BC8F5'><b>⌨ Keybind:</b></font> RightShift = toggle UI"
})

infoRight:AddLabel("InfoR1", { Text = "<font color='#F5A623'><b>🎮 Feature Guide</b></font>" })
infoRight:AddSeparator("InfoSepR1", {})
infoRight:AddLabel("InfoR2", { Text = "<font color='#5BC8F5'><b>Enable</b></font>\nTurns the auto player on/off." })
infoRight:AddLabel("InfoR3", { Text = "<font color='#5BC8F5'><b>Input</b></font>\nUses VirtualInputManager — confirmed working method." })
infoRight:AddLabel("InfoR4", { Text = "<font color='#5BC8F5'><b>Miss Jack Notes</b></font>\nSkips rapid same-key notes." })
infoRight:AddLabel("InfoR5", { Text = "<font color='#5BC8F5'><b>Legit Mode</b></font>\nCaps KPS and biases ratings toward Sick/Good." })
infoRight:AddLabel("InfoR6", { Text = "<font color='#5BC8F5'><b>Perfected</b></font>\nRenderStepped + sync press. Tightest timing possible." })
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
            v6 = {}
            laneHeld    = {false,false,false,false}
            laneHolding = {false,false,false,false}
            pendingHold = {nil,nil,nil,nil}
            for _, k in pairs(v4.KeyBinds) do doRelease(k) end
            startLoop()
            window:Notification({ Title = "✅ AutoPlayer", Text = "Turned <font color='#5BC8F5'><b>ON</b></font>", Duration = 2 })
        else
            for _, k in pairs(v4.KeyBinds) do doRelease(k) end
            if mainLoop then mainLoop:Disconnect(); mainLoop = nil end
            laneHeld    = {false,false,false,false}
            laneHolding = {false,false,false,false}
            pendingHold = {nil,nil,nil,nil}
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
    Tooltip = "RenderStepped + sync press — tightest possible timing",
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
    Tooltip = "Weight for Perfect",
    Callback = function(val) if not legitMode then perfectChance = math.floor(val) end end,
})
chanceGroup:AddSlider("SickChance", {
    Text = "Sick", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for Sick +45ms",
    Callback = function(val) if not legitMode then sickChance = math.floor(val) end end,
})
chanceGroup:AddSlider("GoodChance", {
    Text = "Good", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for Good +75ms",
    Callback = function(val) if not legitMode then goodChance = math.floor(val) end end,
})
chanceGroup:AddSlider("OkChance", {
    Text = "Ok", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for Ok +125ms",
    Callback = function(val) if not legitMode then okChance = math.floor(val) end end,
})
chanceGroup:AddSlider("BadChance", {
    Text = "Bad", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for Bad +175ms",
    Callback = function(val) if not legitMode then badChance = math.floor(val) end end,
})
chanceGroup:AddSlider("MissChance", {
    Text = "Miss", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for intentional miss",
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
