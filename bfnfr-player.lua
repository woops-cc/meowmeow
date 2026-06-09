local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Null-Cherry/Fire-Library/refs/heads/main/Loader.lua", true))()

-- ── OC palette ────────────────────────────────
local C_BLUE   = Color3.fromRGB(91,  200, 245)  -- sky blue  #5BC8F5
local C_ORANGE = Color3.fromRGB(245, 166, 35)   -- gold      #F5A623
local C_WHITE  = Color3.fromRGB(220, 220, 225)

-- ── Window ────────────────────────────────────
local window = lib:Window("w0opsie_ap", {
    Title              = "<font color='#5BC8F5'>w</font><font color='#6DCEF5'>0</font><font color='#7FD5F5'>o</font><font color='#F5A623'>o</font><font color='#F5B83A'>p</font><font color='#5BC8F5'>s</font><font color='#5BC8F5'>i</font><font color='#F5A623'>e</font><font color='#5BC8F5'>'s ap</font>",
    Icon               = "rbxassetid://0",  -- ← swap with your oc art asset id when ready
    Footer             = "Basically FNF: Remix",
    Keybind            = Enum.KeyCode.RightShift,
    NeonType           = "Top",
    NeonThickness      = 2,
    AnimationSpeed     = 1.2,
    ShadowTransparency = 0.5,
    ShadowSize         = 18,
    Theme = {
        Back   = Color3.fromRGB(18,  18,  22),   -- dark background
        Main   = C_BLUE,                          -- accent = sky blue
        Stroke = C_ORANGE,                        -- border glow = orange
        Text   = C_WHITE,
    },
})

-- ── Services ──────────────────────────────────
local RunService = game:GetService("RunService")
local VIM        = game:GetService("VirtualInputManager")
local Players    = game:GetService("Players")

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
local mainLoop   = nil
local holdCache  = {}
local cacheBuilt = {}
local heldKeys   = {}

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

-- KPS tracking for legit mode
local kpsLog  = {}
local kpsLock = false

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

-- ── Tabs ──────────────────────────────────────
local mainTab     = window:AddTab("MainTab",     { Text = "⚙ Main"     })
local platformTab = window:AddTab("PlatformTab", { Text = "🎭 Platform" })
local settingsTab = window:AddTab("SettingsTab", { Text = "🎨 Settings" })

-- ── Groupboxes ────────────────────────────────
local apGroup      = mainTab:AddLeftGroupbox( "APGroup",      { Text = "Auto Player"     })
local playerGroup  = mainTab:AddLeftGroupbox( "PlayerGroup",  { Text = "Player Settings" })
local chanceGroup  = mainTab:AddRightGroupbox("ChanceGroup",  { Text = "Hit Chances"     })
local platformGroup = platformTab:AddLeftGroupbox("PlatGroup", { Text = "Platform Display" })
local themeGroup   = settingsTab:AddLeftGroupbox("ThemeGroup", { Text = "Theme"           })

-- ── Auto Player ───────────────────────────────
apGroup:AddToggle("AutoPlayerEnabled", {
    Text    = "Enable",
    Value   = false,
    Tooltip = "Enables the auto player",
    Callback = function(val)
        v8 = val
        if v8 then
            holdCache = {}; cacheBuilt = {}
            for _, k in pairs(v4.KeyBinds) do releaseKey(k) end
            startLoop()
            window:Notification({ Title = "AutoPlayer", Text = "Turned ON", Duration = 2 })
        else
            for _, k in pairs(v4.KeyBinds) do releaseKey(k) end
            if mainLoop then mainLoop:Disconnect() end
            window:Notification({ Title = "AutoPlayer", Text = "Turned OFF", Duration = 2 })
        end
    end,
})

apGroup:AddToggle("MissJacks", {
    Text     = "Miss Jack Notes",
    Value    = false,
    Tooltip  = "Skips jack notes intentionally",
    Callback = function(val) missJacks = val end,
})

apGroup:AddSeparator("Sep1", {})

apGroup:AddToggle("LegitMode", {
    Text    = "Legit Mode",
    Value   = false,
    Tooltip = "Limits KPS and makes hits more human-like",
    Callback = function(val)
        legitMode = val
        if val then
            -- When legit mode is on, bias toward sick/good ratings
            perfectChance = 40
            sickChance    = 40
            goodChance    = 15
            okChance      = 4
            badChance     = 1
            missChance    = 0
        else
            -- Restore whatever the sliders say
            -- (callbacks will fire again on next slider interaction;
            --  for now just reset to full perfect)
            perfectChance = 100
            sickChance    = 0
            goodChance    = 0
            okChance      = 0
            badChance     = 0
            missChance    = 0
        end
        window:Notification({
            Title = "Legit Mode",
            Text  = val and "ON — KPS capped at "..legitKpsLimit or "OFF",
            Duration = 2
        })
    end,
})

apGroup:AddSlider("LegitKpsLimit", {
    Text    = "KPS Limit",
    Min     = 1,
    Max     = 100,
    Value   = 100,
    Step    = 1,
    Format  = "/",
    Tooltip = "Maximum key presses per second in Legit Mode",
    Callback = function(val) legitKpsLimit = val end,
})

apGroup:AddSeparator("Sep2", {})

apGroup:AddToggle("Perfected", {
    Text    = "Perfected",
    Value   = false,
    Tooltip = "Attempts to hit every note at exactly 0ms reaction time",
    Callback = function(val)
        perfected = val
        if val then
            minReaction = 0
            maxReaction = 0
        end
        window:Notification({
            Title = "Perfected",
            Text  = val and "ON — hitting at 0ms" or "OFF",
            Duration = 2
        })
    end,
})

-- ── Player Settings ───────────────────────────
playerGroup:AddSlider("MinReaction", {
    Text    = "Min Reaction",
    Min     = 0,
    Max     = 150,
    Value   = 0,
    Step    = 1,
    Format  = "/",
    Tooltip = "Minimum reaction time delay in ms",
    Callback = function(val)
        if not perfected then minReaction = math.floor(val) end
    end,
})

playerGroup:AddSlider("MaxReaction", {
    Text    = "Max Reaction",
    Min     = 0,
    Max     = 150,
    Value   = 0,
    Step    = 1,
    Format  = "/",
    Tooltip = "Maximum reaction time delay in ms",
    Callback = function(val)
        if not perfected then maxReaction = math.floor(val) end
    end,
})

-- ── Hit Chances ───────────────────────────────
chanceGroup:AddSlider("PerfectChance", {
    Text = "Perfect Chance", Min = 0, Max = 100, Value = 100, Step = 1,
    Tooltip = "Chance of hitting a Perfect",
    Callback = function(val) if not legitMode then perfectChance = math.floor(val) end end,
})
chanceGroup:AddSlider("SickChance", {
    Text = "Sick Chance", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Chance of hitting a Sick",
    Callback = function(val) if not legitMode then sickChance = math.floor(val) end end,
})
chanceGroup:AddSlider("GoodChance", {
    Text = "Good Chance", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Chance of hitting a Good",
    Callback = function(val) if not legitMode then goodChance = math.floor(val) end end,
})
chanceGroup:AddSlider("OkChance", {
    Text = "Ok Chance", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Chance of hitting an Ok",
    Callback = function(val) if not legitMode then okChance = math.floor(val) end end,
})
chanceGroup:AddSlider("BadChance", {
    Text = "Bad Chance", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Chance of hitting a Bad",
    Callback = function(val) if not legitMode then badChance = math.floor(val) end end,
})
chanceGroup:AddSlider("MissChance", {
    Text = "Miss Chance", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Chance of missing a note intentionally",
    Callback = function(val) if not legitMode then missChance = math.floor(val) end end,
})

-- ── Platform tab ──────────────────────────────
platformGroup:AddToggle("PlatformAutoRejoin", {
    Text     = "Custom Platform Display",
    Value    = true,
    Callback = function(val) platformAutoRejoin = val end,
})

platformGroup:AddTextBox("PlatformContent", {
    Text            = "Display Content",
    Value           = "😇",
    PlaceholderText = "Enter text or emoji...",
    Callback        = function(val)
        if val and val ~= "" then platformContent = val end
    end,
})

platformGroup:AddButton("ApplyPlatform", {
    Text = "Apply Platform Display",
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
                    Spk:Kick("\nRejoining..."); task.wait(); TPS:Teleport(6520999642, Spk)
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
            Title    = platformAutoRejoin and "🧐 Rejoin?" or "🧐 Done",
            Text     = platformAutoRejoin and "Rejoin to apply '"..Content.."'?" or "Rejoin manually.",
            Button1  = "Yes", Button2 = "No",
            Duration = (1/0), Callback = Rejoin,
        })
        Alert()
        window:Notification({ Title = "Platform", Text = "Set: "..Content, Duration = 4 })
        if getgenv then getgenv().FNFRemixACPD = true else _G.FNFRemixACPD = true end
    end,
})

-- ── Settings tab — theme picker ───────────────
themeGroup:AddLabel("ThemeLabel1", { Text = "Main accent (sky blue = default)" })
themeGroup:AddColorPicker("ThemeMain", {
    Text  = "Accent Color",
    Value = C_BLUE,
    Callback = function(val)
        window.Theme = { Back = Color3.fromRGB(18,18,22), Main = val, Stroke = C_ORANGE, Text = C_WHITE }
        window:Refresh()
    end,
})

themeGroup:AddLabel("ThemeLabel2", { Text = "Stroke / glow (orange = default)" })
themeGroup:AddColorPicker("ThemeStroke", {
    Text  = "Stroke Color",
    Value = C_ORANGE,
    Callback = function(val)
        window.Theme = { Back = Color3.fromRGB(18,18,22), Main = C_BLUE, Stroke = val, Text = C_WHITE }
        window:Refresh()
    end,
})

-- ── Hold cache ────────────────────────────────
local function buildHoldCache(nf)
    local nn, hn = {}, {}
    for _, o in pairs(nf:GetChildren()) do
        if not o:IsA("GuiObject") then continue end
        if o.Name:sub(1, 5) == "Hold_" then
            local n = tonumber(o.Name:sub(6))
            if n then table.insert(hn, {num = n, obj = o}) end
        elseif tonumber(o.Name) then
            table.insert(nn, {num = tonumber(o.Name), obj = o})
        end
    end
    table.sort(nn, function(a, b) return a.num < b.num end)
    table.sort(hn, function(a, b) return a.num < b.num end)
    for _, nd in pairs(nn) do
        local y = nd.obj.AbsolutePosition.Y
        local c, cd = nil, math.huge
        for _, hd in pairs(hn) do
            local d = math.abs(hd.obj.AbsolutePosition.Y - y)
            if d < cd then cd = d; c = hd.obj end
        end
        if c and cd <= 50 then holdCache[nd.obj] = c end
    end
end

local function findHold(note, nf)
    if holdCache[note] then return holdCache[note] end
    local y = note.AbsolutePosition.Y
    local c, cd = nil, math.huge
    for _, o in pairs(nf:GetChildren()) do
        if o.Name:sub(1, 5) == "Hold_" and o.Visible then
            local d = math.abs(o.AbsolutePosition.Y - y)
            if d < cd then cd = d; c = o end
        end
    end
    return (c and cd <= 50) and c or nil
end

-- ── Rating picker ─────────────────────────────
local function pickRating()
    local pool = {}
    for _ = 1, perfectChance do table.insert(pool, "perfect") end
    for _ = 1, sickChance    do table.insert(pool, "sick")    end
    for _ = 1, goodChance    do table.insert(pool, "good")    end
    for _ = 1, okChance      do table.insert(pool, "ok")      end
    for _ = 1, badChance     do table.insert(pool, "bad")     end
    for _ = 1, missChance    do table.insert(pool, "miss")    end
    if #pool == 0 then return "perfect" end
    return pool[math.random(1, #pool)]
end

-- ── KPS gate for legit mode ───────────────────
local function canPress()
    if not legitMode then return true end
    local now = tick()
    -- Remove entries older than 1 second
    local i = 1
    while i <= #kpsLog do
        if now - kpsLog[i] > 1 then
            table.remove(kpsLog, i)
        else
            i = i + 1
        end
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
            releaseKey(key); task.wait(0.02)
            pressKey(key); task.wait(v4.TapDuration); releaseKey(key)
        end)
        return
    end
    if v7[ai] then return end
    v7[ai] = true

    task.spawn(function()
        -- Reaction delay (0 if Perfected is on)
        if not perfected and maxReaction > 0 then
            local lo = math.min(minReaction, maxReaction)
            local hi = math.max(minReaction, maxReaction)
            task.wait((lo == hi and lo or math.random(lo, hi)) / 1000)
        end

        -- KPS gate
        if not canPress() then
            v7[ai] = nil; return
        end

        -- Rating gate
        if pickRating() == "miss" then v7[ai] = nil; return end

        releaseKey(key); task.wait(); pressKey(key)

        if isHold then
            v7[ai] = nil; v6[hold] = true
            local released = false
            local function doRelease()
                if not released then
                    released = true
                    releaseKey(key); v6[note] = nil; v6[hold] = nil
                end
            end
            task.wait(0.05)
            local conn
            conn = RunService.Heartbeat:Connect(function()
                if not lnHold then doRelease(); conn:Disconnect(); return end
                if lnHold.ImageTransparency >= 0.9 then doRelease(); conn:Disconnect() end
            end)
        else
            task.wait(v4.TapDuration); releaseKey(key); v7[ai] = nil
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

function startLoop()
    if mainLoop then mainLoop:Disconnect() end
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
                        if c:IsA("GuiObject") and c.Name:sub(1, 5) ~= "Hold_" then
                            task.wait()
                            local y = c.AbsolutePosition.Y
                            local cl, cd = nil, math.huge
                            for _, o in pairs(n:GetChildren()) do
                                if o.Name:sub(1, 5) == "Hold_" and o.Visible then
                                    local d = math.abs(o.AbsolutePosition.Y - y)
                                    if d < cd then cd = d; cl = o end
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
                    if note.Name:sub(1, 5) == "Hold_" then continue end
                    if math.abs(note.AbsolutePosition.Y - ty) <= v4.HitPixels then
                        v6[note] = true
                        handleNote(i, note, n, f)
                        note.AncestryChanged:Once(function() v6[note] = nil end)
                    end
                end
            end
        end
    end)
end
