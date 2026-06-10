local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Null-Cherry/Fire-Library/refs/heads/main/Loader.lua", true))()

-- ── OC palette ────────────────────────────────
local C_BLUE   = Color3.fromRGB(91,  200, 245)
local C_ORANGE = Color3.fromRGB(245, 166, 35)
local C_WHITE  = Color3.fromRGB(220, 220, 225)
local C_BG     = Color3.fromRGB(18,  18,  22)

-- ── Window ────────────────────────────────────
-- FIX (icon): pass the numeric ID as a plain string — the library prepends
-- "rbxassetid://" itself. Using the full "rbxassetid://..." form with a Decal
-- asset (not an ImageLabel asset) causes a silent empty-image result.
-- FIX (background): Image / ImageEnabled / ImageTransparency / ImageColor are
-- built-in window options. ImageTransparency default is 0.85 (very washed),
-- so we lower it to 0.35 for a visible but non-distracting background.
-- The decal was uploaded wider than the original art; ImageColor = white keeps
-- it unaffected by theme tinting.
local window = lib:Window("w0opsie_ap", {
    Title    = "<font color='#5BC8F5'>w0</font><font color='#F5A623'>o</font><font color='#5BC8F5'>opsie's ap</font>",
    Icon     = "71140941882804",        -- plain ID, library adds rbxassetid://
    Footer   = "<font color='#5BC8F5'>Basically FNF: Remix</font>",
    Keybind  = Enum.KeyCode.RightShift,
    NeonType      = "Top",
    NeonThickness = 2,
    AnimationSpeed     = 1.2,
    ShadowTransparency = 0.4,
    ShadowSize         = 20,
    -- background image
    Image             = "113037548508433",   -- your OC decal ID
    ImageEnabled      = true,
    ImageTransparency = 0.35,               -- 0 = fully opaque, 1 = invisible
    ImageColor        = Color3.new(1, 1, 1), -- white = no tint
    Theme = {
        Back   = C_BG,
        Main   = C_BLUE,
        Stroke = C_ORANGE,
        Text   = C_WHITE,
    },
})

-- ── Services ──────────────────────────────────
local RunService = game:GetService("RunService")
local VIM        = game:GetService("VirtualInputManager")
local UIS        = game:GetService("UserInputService")
local Players    = game:GetService("Players")

local HIT_OFFSETS = {
    perfect = 0.0,
    sick    = 0.05,
    good    = 0.10,
    ok      = 0.15,
    bad     = 0.20,
}

local v4 = {
    KeyBinds    = {Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.W, Enum.KeyCode.D},
    HitPixels   = 15,
    TapDuration = 0.05,
}

local v5         = Players.LocalPlayer
local v6         = {}
local v7         = {}
local v8         = false
local missJacks  = false
local legitMode  = false
local perfected  = false
local apMethod   = "VirtualInput"
local mainLoop   = nil
local holdCache  = {}
local cacheBuilt = {}
local heldKeys   = {}
local kpsLog     = {}

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

-- ── Input methods ─────────────────────────────
local function pressKey(key)
    if not heldKeys[key] then
        heldKeys[key] = true
        VIM:SendKeyEvent(true, key, false, game)
    end
end
local function releaseKey(key)
    if heldKeys[key] then
        heldKeys[key] = nil
        VIM:SendKeyEvent(false, key, false, game)
    end
end

-- FIX (FireSignal): Instance.new("InputObject") is blocked in executor
-- sandboxes on newer Roblox — that's what caused the 31 errors in the console.
-- Instead we fire connections directly using a plain table that mimics the
-- shape of an InputObject. The game's InputBegan/InputEnded handlers only read
-- .KeyCode, .UserInputType, and .UserInputState — they don't typecheck the
-- instance itself — so a table works fine.
local function makeInputObj(key, state)
    return {
        KeyCode        = key,
        UserInputType  = Enum.UserInputType.Keyboard,
        UserInputState = state,
    }
end

local function fireSignalPress(key)
    if heldKeys[key] then return end
    heldKeys[key] = true
    local obj = makeInputObj(key, Enum.UserInputState.Begin)
    pcall(function()
        if getconnections then
            for _, conn in ipairs(getconnections(UIS.InputBegan)) do
                if conn.Function then pcall(conn.Function, obj, false) end
            end
        end
    end)
end

local function fireSignalRelease(key)
    if not heldKeys[key] then return end
    heldKeys[key] = nil
    local obj = makeInputObj(key, Enum.UserInputState.End)
    pcall(function()
        if getconnections then
            for _, conn in ipairs(getconnections(UIS.InputEnded)) do
                if conn.Function then pcall(conn.Function, obj, false) end
            end
        end
    end)
end

local function doPress(key)
    if apMethod == "FireSignal" then fireSignalPress(key) else pressKey(key) end
end
local function doRelease(key)
    if apMethod == "FireSignal" then fireSignalRelease(key) else releaseKey(key) end
end

-- ── Hold cache helpers ────────────────────────
local function buildHoldCache(nf)
    local nn, hn = {}, {}
    for _, o in pairs(nf:GetChildren()) do
        if not o:IsA("GuiObject") then continue end
        if o.Name:sub(1,5) == "Hold_" then
            local n = tonumber(o.Name:sub(6))
            if n then table.insert(hn, {num=n, obj=o}) end
        elseif tonumber(o.Name) then
            table.insert(nn, {num=tonumber(o.Name), obj=o})
        end
    end
    table.sort(nn, function(a,b) return a.num < b.num end)
    table.sort(hn, function(a,b) return a.num < b.num end)
    for _, nd in pairs(nn) do
        local y = nd.obj.AbsolutePosition.Y
        local c, cd = nil, math.huge
        for _, hd in pairs(hn) do
            local d = math.abs(hd.obj.AbsolutePosition.Y - y)
            if d < cd then cd=d; c=hd.obj end
        end
        if c and cd <= 50 then holdCache[nd.obj] = c end
    end
end

local function findHold(note, nf)
    if holdCache[note] then return holdCache[note] end
    local y = note.AbsolutePosition.Y
    local c, cd = nil, math.huge
    for _, o in pairs(nf:GetChildren()) do
        if o.Name:sub(1,5) == "Hold_" and o.Visible then
            local d = math.abs(o.AbsolutePosition.Y - y)
            if d < cd then cd=d; c=o end
        end
    end
    return (c and cd <= 50) and c or nil
end

-- ── Rating + timing ───────────────────────────
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

local function ratingDelay(rating)
    if rating == "perfect" then return 0 end
    return HIT_OFFSETS[rating] or 0
end

local function canPress()
    if not legitMode then return true end
    local now = tick()
    local i = 1
    while i <= #kpsLog do
        if now - kpsLog[i] > 1 then table.remove(kpsLog,i) else i = i + 1 end
    end
    if #kpsLog >= legitKpsLimit then return false end
    table.insert(kpsLog, now)
    return true
end

-- ── Note handler ──────────────────────────────
local function handleNote(ai, note, nf, af)
    local key    = v4.KeyBinds[ai]
    local hold   = findHold(note, nf)
    local isHold = hold ~= nil
    local lnHold = af:FindFirstChild("LnHold")

    if v7[ai] and not isHold then
        if missJacks then return end
        task.spawn(function()
            doRelease(key); task.wait(0.02)
            doPress(key); task.wait(v4.TapDuration); doRelease(key)
        end)
        return
    end
    if v7[ai] then return end
    v7[ai] = true

    task.spawn(function()
        local rating = pickRating()
        if not perfected then
            if maxReaction > 0 then
                local lo = math.min(minReaction, maxReaction)
                local hi = math.max(minReaction, maxReaction)
                task.wait((lo == hi and lo or math.random(lo,hi)) / 1000)
            end
            local extra = ratingDelay(rating)
            if extra > 0 then task.wait(extra) end
        end
        if not canPress() then v7[ai]=nil; return end
        if rating == "miss" then v7[ai]=nil; return end
        doRelease(key); task.wait(); doPress(key)
        if isHold then
            v7[ai]=nil; v6[hold]=true
            local released = false
            local function doRel()
                if not released then
                    released=true; doRelease(key); v6[note]=nil; v6[hold]=nil
                end
            end
            task.wait(0.05)
            local conn
            conn = RunService.Heartbeat:Connect(function()
                if not lnHold then doRel(); conn:Disconnect(); return end
                if lnHold.ImageTransparency >= 0.9 then doRel(); conn:Disconnect() end
            end)
        else
            task.wait(v4.TapDuration); doRelease(key); v7[ai]=nil
        end
    end)
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

-- ── startLoop defined before UI so callbacks can safely call it ───────────
local function startLoop()
    if mainLoop then mainLoop:Disconnect(); mainLoop = nil end
    mainLoop = RunService.Heartbeat:Connect(function()
        if not v8 then return end
        local KS = getMyKeySync()
        if not (KS and KS.Visible) then return end
        for i = 1, 4 do
            local f = KS:FindFirstChild("Arrow"..i)
            local r = f and f:FindFirstChild("Arrow")
            local n = f and f:FindFirstChild("Notes")
            if r and n then
                if not cacheBuilt[i] then
                    cacheBuilt[i] = true
                    buildHoldCache(n)
                    n.ChildAdded:Connect(function(c)
                        if c:IsA("GuiObject") and c.Name:sub(1,5) ~= "Hold_" then
                            task.wait()
                            local y = c.AbsolutePosition.Y
                            local cl, cd = nil, math.huge
                            for _, o in pairs(n:GetChildren()) do
                                if o.Name:sub(1,5) == "Hold_" and o.Visible then
                                    local d = math.abs(o.AbsolutePosition.Y - y)
                                    if d < cd then cd=d; cl=o end
                                end
                            end
                            if cl and cd <= 50 then holdCache[c] = cl end
                        end
                    end)
                end
                local ty = r.AbsolutePosition.Y
                for _, note in pairs(n:GetChildren()) do
                    if not note:IsA("GuiObject") or not note.Visible
                        or note.Name == "Arrow" or v6[note] then continue end
                    if note.Name:sub(1,5) == "Hold_" then continue end
                    if math.abs(note.AbsolutePosition.Y - ty) <= v4.HitPixels then
                        v6[note] = true
                        handleNote(i, note, n, f)
                        note.AncestryChanged:Once(function() v6[note]=nil end)
                    end
                end
            end
        end
    end)
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
    Text = "<font color='#F5A623'><b>📌 Best settings for all perfects:</b></font>\n• Scroll speed: <b>2.0</b>\n• Method: <b>VirtualInput</b>\n• Min/Max Reaction: <b>0ms</b>\n• Perfect Chance: <b>100%</b>\n• Perfected: <b>ON</b>"
})
infoLeft:AddSeparator("InfoSep2", {})
infoLeft:AddLabel("InfoL3", {
    Text = "<font color='#5BC8F5'><b>⌨ Keybind:</b></font> RightShift = toggle UI"
})

infoRight:AddLabel("InfoR1", { Text = "<font color='#F5A623'><b>🎮 Feature Guide</b></font>" })
infoRight:AddSeparator("InfoSepR1", {})
infoRight:AddLabel("InfoR2", { Text = "<font color='#5BC8F5'><b>Enable</b></font>\nTurns the auto player on/off." })
infoRight:AddLabel("InfoR3", { Text = "<font color='#5BC8F5'><b>Input Method</b></font>\n<b>VirtualInput</b>: uses Roblox's VIM API.\n<b>FireSignal</b>: fires game connections directly. Better compatibility on most executors." })
infoRight:AddLabel("InfoR4", { Text = "<font color='#5BC8F5'><b>Miss Jack Notes</b></font>\nIntentionally skips rapid same-key notes (jacks) to look more human." })
infoRight:AddLabel("InfoR5", { Text = "<font color='#5BC8F5'><b>Legit Mode</b></font>\nCaps your KPS and biases ratings toward Sick/Good to appear human. Use the KPS Limit slider to set max keys per second." })
infoRight:AddLabel("InfoR6", { Text = "<font color='#5BC8F5'><b>Perfected</b></font>\nForces 0ms reaction time, hitting every note at the earliest possible frame for maximum Perfects." })
infoRight:AddLabel("InfoR7", { Text = "<font color='#5BC8F5'><b>Hit Chances</b></font>\nWeighted pool: set each rating's chance. Values are relative weights — e.g. Perfect 100 + Sick 0 = always perfect.\n\n<font color='#F5A623'><b>Hit windows (from game):</b></font>\n🟣 Sick: ±0.05ms\n🟢 Good: ±0.10ms\n🟡 Ok: ±0.15ms\n🔴 Bad: ±0.20ms" })

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
            holdCache = {}; cacheBuilt = {}
            for _, k in pairs(v4.KeyBinds) do doRelease(k) end
            startLoop()
            window:Notification({ Title = "✅ AutoPlayer", Text = "Turned <font color='#5BC8F5'><b>ON</b></font>", Duration = 2 })
        else
            for _, k in pairs(v4.KeyBinds) do doRelease(k) end
            if mainLoop then mainLoop:Disconnect(); mainLoop = nil end
            window:Notification({ Title = "❌ AutoPlayer", Text = "Turned <font color='#F5A623'><b>OFF</b></font>", Duration = 2 })
        end
    end,
})

apGroup:AddDropdown("APMethod", {
    Text    = "Input Method",
    Value   = "VirtualInput",
    Values  = {"VirtualInput", "FireSignal"},
    Tooltip = "VirtualInput: Roblox API\nFireSignal: fires game connections directly (better compatibility)",
    Callback = function(val)
        apMethod = val
        for _, k in pairs(v4.KeyBinds) do
            pcall(function() releaseKey(k) end)
            pcall(function() fireSignalRelease(k) end)
        end
        heldKeys = {}
        window:Notification({ Title = "Input Method", Text = "Switched to <b>"..val.."</b>", Duration = 2 })
    end,
})

apGroup:AddSeparator("APSep1", {})
apGroup:AddToggle("MissJacks", {
    Text    = "Miss Jack Notes",
    Value   = false,
    Tooltip = "Intentionally skips rapid same-key notes to look more human",
    Callback = function(val) missJacks = val end,
})
apGroup:AddSeparator("APSep2", {})

apGroup:AddToggle("LegitMode", {
    Text    = "Legit Mode",
    Value   = false,
    Tooltip = "Caps KPS and biases hit ratings toward Sick/Good to appear human",
    Callback = function(val)
        legitMode = val
        if val then
            perfectChance = 35; sickChance = 45
            goodChance = 15;  okChance  = 4
            badChance  = 1;   missChance = 0
        else
            perfectChance = 100; sickChance = 0
            goodChance = 0; okChance = 0
            badChance  = 0; missChance = 0
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
    Tooltip = "Maximum key presses per second when Legit Mode is active",
    Callback = function(val) legitKpsLimit = val end,
})

apGroup:AddSeparator("APSep3", {})

apGroup:AddToggle("Perfected", {
    Text    = "Perfected",
    Value   = false,
    Tooltip = "Forces 0ms reaction time — hits every note at the earliest possible frame",
    Callback = function(val)
        perfected = val
        if val then minReaction = 0; maxReaction = 0 end
        window:Notification({
            Title = "Perfected",
            Text  = val and "<font color='#5BC8F5'>ON</font> — hitting at <b>0ms</b>" or "<font color='#F5A623'>OFF</font>",
            Duration = 2
        })
    end,
})

-- ── Player Settings ───────────────────────────
playerGroup:AddSlider("MinReaction", {
    Text    = "Min Reaction",
    Min     = 0, Max = 150, Value = 0, Step = 1,
    Tooltip = "Minimum reaction delay in ms (ignored when Perfected is ON)",
    Callback = function(val) if not perfected then minReaction = math.floor(val) end end,
})
playerGroup:AddSlider("MaxReaction", {
    Text    = "Max Reaction",
    Min     = 0, Max = 150, Value = 0, Step = 1,
    Tooltip = "Maximum reaction delay in ms (ignored when Perfected is ON)",
    Callback = function(val) if not perfected then maxReaction = math.floor(val) end end,
})

-- ── Hit Chances ───────────────────────────────
chanceGroup:AddLabel("ChanceInfo", {
    Text = "<font color='#F5A623'>Values are relative weights.\nTotal doesn't need to equal 100.</font>"
})
chanceGroup:AddSlider("PerfectChance", {
    Text = "Perfect Chance", Min = 0, Max = 100, Value = 100, Step = 1,
    Tooltip = "Weight for hitting a Perfect (< 0.05ms offset)",
    Callback = function(val) if not legitMode then perfectChance = math.floor(val) end end,
})
chanceGroup:AddSlider("SickChance", {
    Text = "Sick Chance", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for hitting a Sick (~0.05ms offset)",
    Callback = function(val) if not legitMode then sickChance = math.floor(val) end end,
})
chanceGroup:AddSlider("GoodChance", {
    Text = "Good Chance", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for hitting a Good (~0.10ms offset)",
    Callback = function(val) if not legitMode then goodChance = math.floor(val) end end,
})
chanceGroup:AddSlider("OkChance", {
    Text = "Ok Chance", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for hitting an Ok (~0.15ms offset)",
    Callback = function(val) if not legitMode then okChance = math.floor(val) end end,
})
chanceGroup:AddSlider("BadChance", {
    Text = "Bad Chance", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for hitting a Bad (~0.20ms offset)",
    Callback = function(val) if not legitMode then badChance = math.floor(val) end end,
})
chanceGroup:AddSlider("MissChance", {
    Text = "Miss Chance", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for intentionally missing a note",
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
    Callback        = function(val) if val and val ~= "" then platformContent = val end end,
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
