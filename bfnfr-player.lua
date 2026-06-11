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

-- FIX (Icon + Background): window.RealWindow is on window.Window, not proxy.
-- Also must set ImageContent for newer Roblox clients.
task.defer(function()
    local ok, rw = pcall(function() return window.Window.RealWindow end)
    if ok and rw then
        local bgUri = "rbxassetid://113037548508433"
        pcall(function() rw.ImageContent = Content.fromUri(bgUri) end)
        pcall(function() rw.Image = bgUri end)
    end
    local ok2, icon = pcall(function()
        return window.Window.RealWindow.Contents.TopbarZone.TitleZone.Icon
    end)
    if ok2 and icon then
        local iconUri = "rbxassetid://71140941882804"
        pcall(function() icon.ImageContent = Content.fromUri(iconUri) end)
        pcall(function() icon.Image = iconUri end)
        icon.Visible = true
    end
end)

-- ── Services ──────────────────────────────────
local RunService = game:GetService("RunService")
local VIM        = game:GetService("VirtualInputManager")
local Players    = game:GetService("Players")

-- ── Game hit windows (seconds) ────────────────
-- These are the actual offset windows BFNFR:R uses per rating.
-- "Perfect" requires the note to be pressed within the earliest detection
-- frame. We target 0ms by pressing the instant the note enters HitPixels.
-- For non-perfect ratings we add a deliberate delay after detection.
local HIT_OFFSETS = {
    -- perfect = 0 (no delay — press immediately on detection)
    sick = 0.045,   -- aim for centre of Sick window (~45ms)
    good = 0.075,   -- centre of Good window (~75ms)
    ok   = 0.125,   -- centre of Ok window (~125ms)
    bad  = 0.175,   -- centre of Bad window (~175ms)
}

-- ── Config ────────────────────────────────────
local v4 = {
    KeyBinds    = {Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.W, Enum.KeyCode.D},
    -- HitPixels: how close (in screen px) a note must be to the receptor
    -- before we fire the key. Smaller = press closer to centre of window.
    -- The game's hit window is evaluated server-side based on when VIM
    -- delivers the event, so we want to press as EARLY as possible.
    -- 20px gives a small lead so the event arrives before the centre.
    HitPixels   = 20,
    TapDuration = 0.05,
}

local v5         = Players.LocalPlayer
local v6         = {}   -- notes currently being processed
local v7         = {}   -- lanes currently held (jack detection)
local v8         = false
local missJacks  = false
local legitMode  = false
local perfected  = false
local mainLoop   = nil
local holdCache  = {}
local cacheBuilt = {}
local heldKeys   = {}
local kpsLog     = {}

local minReaction   = 0
local maxReaction   = 0
local legitKpsLimit = 100

-- Hit chance weights (integer weights, not percentages)
-- pickRating() builds a pool from these and picks randomly.
-- perfectChance=100, all others=0 → always Perfect.
local perfectChance = 100
local sickChance    = 0
local goodChance    = 0
local okChance      = 0
local badChance     = 0
local missChance    = 0

local platformContent    = "😇"
local platformAutoRejoin = true

-- ── Input (VIM only — confirmed working for this game) ────────────────────
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

-- ── Hold cache ────────────────────────────────
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

-- ── Rating pool ───────────────────────────────
-- Builds a weighted random pool. Each variable contributes that many
-- entries. e.g. perfectChance=3, sickChance=1 → 75% Perfect, 25% Sick.
-- All zero → defaults to Perfect.
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

-- ── Note handler ──────────────────────────────
-- PERFECTED path: called synchronously from RenderStepped.
-- No yields, no spawns — press fires in the same callback frame
-- that detected the note, giving minimum possible latency.
--
-- NON-PERFECTED path: spawned, adds reaction delay + rating offset.
local function handleNote(ai, note, nf, af, sync)
    local key    = v4.KeyBinds[ai]
    local hold   = findHold(note, nf)
    local isHold = hold ~= nil
    local lnHold = af:FindFirstChild("LnHold")

    -- Jack handling: same lane pressed again before release
    if v7[ai] and not isHold then
        if missJacks then return end
        if not sync then
            task.spawn(function()
                doRelease(key); task.wait(0.02)
                doPress(key); task.wait(v4.TapDuration); doRelease(key)
            end)
        end
        return
    end
    if v7[ai] then return end
    v7[ai] = true

    -- Shared press + hold logic
    local function pressPath()
        if not canPress() then v7[ai]=nil; return end
        doRelease(key)
        -- In perfected/sync mode we skip even the task.wait() between
        -- release and press — every microsecond counts for the hit window.
        if not sync then task.wait() end
        doPress(key)
        if isHold then
            v7[ai]=nil; v6[hold]=true
            local released = false
            local function doRel()
                if not released then
                    released=true; doRelease(key); v6[note]=nil; v6[hold]=nil
                end
            end
            task.delay(0.05, function()
                local conn
                conn = RunService.Heartbeat:Connect(function()
                    if not lnHold then doRel(); conn:Disconnect(); return end
                    if lnHold.ImageTransparency >= 0.9 then doRel(); conn:Disconnect() end
                end)
            end)
        else
            task.delay(v4.TapDuration, function()
                doRelease(key); v7[ai]=nil
            end)
        end
    end

    if sync then
        -- Perfected: synchronous, no yields at all
        pressPath()
    else
        task.spawn(function()
            local rating = pickRating()
            -- Reaction delay (human simulation, only when not perfected)
            if maxReaction > 0 then
                local lo = math.min(minReaction, maxReaction)
                local hi = math.max(minReaction, maxReaction)
                task.wait((lo == hi and lo or math.random(lo,hi)) / 1000)
            end
            -- Rating-based offset delay
            -- "perfect" = 0 extra delay (press immediately)
            -- other ratings = wait until centre of their hit window
            if rating ~= "perfect" then
                local offset = HIT_OFFSETS[rating]
                if offset then task.wait(offset) end
            end
            if not canPress() then v7[ai]=nil; return end
            if rating == "miss"    then v7[ai]=nil; return end
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
-- PERFECTED: uses RenderStepped (fires before the frame renders — earliest
-- possible hook). Passes sync=true to handleNote so no yields occur.
--
-- NORMAL: uses Heartbeat with sync=false (task.spawn + delays allowed).
--
-- Restarted whenever Perfected is toggled while the AP is running.
local function startLoop()
    if mainLoop then mainLoop:Disconnect(); mainLoop = nil end

    local function tick_fn(sync)
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
                        handleNote(i, note, n, f, sync)
                        note.AncestryChanged:Once(function() v6[note]=nil end)
                    end
                end
            end
        end
    end

    if perfected then
        mainLoop = RunService.RenderStepped:Connect(function()
            tick_fn(true)
        end)
    else
        mainLoop = RunService.Heartbeat:Connect(function()
            tick_fn(false)
        end)
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
    Text = "<font color='#F5A623'><b>📌 Best settings for all perfects:</b></font>\n• Scroll speed: <b>2.0</b>\n• Perfected: <b>ON</b>\n• Min/Max Reaction: <b>0ms</b>\n• Perfect Chance: <b>100</b>, all others <b>0</b>"
})
infoLeft:AddSeparator("InfoSep2", {})
infoLeft:AddLabel("InfoL3", {
    Text = "<font color='#5BC8F5'><b>⌨ Keybind:</b></font> RightShift = toggle UI"
})

infoRight:AddLabel("InfoR1", { Text = "<font color='#F5A623'><b>🎮 Feature Guide</b></font>" })
infoRight:AddSeparator("InfoSepR1", {})
infoRight:AddLabel("InfoR2", { Text = "<font color='#5BC8F5'><b>Enable</b></font>\nTurns the auto player on/off." })
infoRight:AddLabel("InfoR3", { Text = "<font color='#5BC8F5'><b>Input</b></font>\nUses Roblox VirtualInputManager — the only method that works for this game." })
infoRight:AddLabel("InfoR4", { Text = "<font color='#5BC8F5'><b>Miss Jack Notes</b></font>\nSkips rapid same-key notes to look more human." })
infoRight:AddLabel("InfoR5", { Text = "<font color='#5BC8F5'><b>Legit Mode</b></font>\nCaps KPS and biases ratings toward Sick/Good. Set KPS Limit to control max keys per second." })
infoRight:AddLabel("InfoR6", { Text = "<font color='#5BC8F5'><b>Perfected</b></font>\nUses RenderStepped (earliest frame hook) + synchronous press with no yields. This is the tightest possible press timing achievable from a LocalScript." })
infoRight:AddLabel("InfoR7", {
    Text = "<font color='#5BC8F5'><b>Hit Chances</b></font>\nEach slider is a <b>weight</b>, not a percentage. The script builds a pool with that many entries per rating and picks randomly.\n\nExample: Perfect=3, Sick=1 → 75% Perfect, 25% Sick.\nAll zero → always Perfect.\n\n<font color='#F5A623'><b>Game hit windows:</b></font>\n⬜ Perfect: earliest press\n🟣 Sick: ~45ms after\n🟢 Good: ~75ms after\n🟡 Ok: ~125ms after\n🔴 Bad: ~175ms after"
})

-- ── Groupboxes ────────────────────────────────
local apGroup     = mainTab:AddLeftGroupbox( "APGroup",     { Text = "⚡ Auto Player"     })
local playerGroup = mainTab:AddLeftGroupbox( "PlayerGroup", { Text = "🎯 Player Settings" })
local chanceGroup = mainTab:AddRightGroupbox("ChanceGroup", { Text = "🎲 Hit Chances"     })
local miscGroup   = miscTab:AddLeftGroupbox( "MiscGroup",   { Text = "🎭 Platform Display" })
local themeGroup  = settingsTab:AddLeftGroupbox("ThemeGroup", { Text = "🎨 Theme" })

-- ── Auto Player group ─────────────────────────
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
    Tooltip = "Maximum key presses per second when Legit Mode is active",
    Callback = function(val) legitKpsLimit = val end,
})

apGroup:AddSeparator("APSep3", {})

apGroup:AddToggle("Perfected", {
    Text    = "Perfected",
    Value   = false,
    Tooltip = "RenderStepped + synchronous press — tightest possible timing for Perfect hits",
    Callback = function(val)
        perfected = val
        if val then minReaction = 0; maxReaction = 0 end
        -- Restart loop on the right signal for the new mode
        if v8 then
            if mainLoop then mainLoop:Disconnect(); mainLoop = nil end
            startLoop()
        end
        window:Notification({
            Title = "Perfected",
            Text  = val
                and "<font color='#5BC8F5'>ON</font> — RenderStepped, 0 yields"
                or  "<font color='#F5A623'>OFF</font>",
            Duration = 2
        })
    end,
})

-- ── Player Settings ───────────────────────────
playerGroup:AddSlider("MinReaction", {
    Text    = "Min Reaction (ms)",
    Min     = 0, Max = 150, Value = 0, Step = 1,
    Tooltip = "Minimum random reaction delay added before pressing. Ignored when Perfected is ON.",
    Callback = function(val)
        if not perfected then minReaction = math.floor(val) end
    end,
})
playerGroup:AddSlider("MaxReaction", {
    Text    = "Max Reaction (ms)",
    Min     = 0, Max = 150, Value = 0, Step = 1,
    Tooltip = "Maximum random reaction delay added before pressing. Ignored when Perfected is ON.",
    Callback = function(val)
        if not perfected then maxReaction = math.floor(val) end
    end,
})


-- ── Hit Chances ───────────────────────────────
-- These are WEIGHTS, not percentages. The script builds a pool with
-- (weight) entries per rating and picks one at random.
-- All sliders at 0 → always Perfect (pool empty → default Perfect).
-- Legit Mode overrides these with its own preset while active.
chanceGroup:AddLabel("ChanceInfo", {
    Text = "<font color='#F5A623'><b>Weights, not percentages.</b></font>\nPerfect=100, rest=0 → always Perfect.\nPerfect=1, Sick=1 → 50/50 Perfect/Sick.\nAll 0 → always Perfect.\n\n<font color='#888'>Locked while Legit Mode is ON.</font>"
})
chanceGroup:AddSeparator("ChanceSep1", {})
chanceGroup:AddSlider("PerfectChance", {
    Text = "Perfect", Min = 0, Max = 100, Value = 100, Step = 1,
    Tooltip = "Weight for Perfect (press immediately on detection — earliest hit window)",
    Callback = function(val)
        if not legitMode then perfectChance = math.floor(val) end
    end,
})
chanceGroup:AddSlider("SickChance", {
    Text = "Sick", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for Sick (~45ms after detection)",
    Callback = function(val)
        if not legitMode then sickChance = math.floor(val) end
    end,
})
chanceGroup:AddSlider("GoodChance", {
    Text = "Good", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for Good (~75ms after detection)",
    Callback = function(val)
        if not legitMode then goodChance = math.floor(val) end
    end,
})
chanceGroup:AddSlider("OkChance", {
    Text = "Ok", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for Ok (~125ms after detection)",
    Callback = function(val)
        if not legitMode then okChance = math.floor(val) end
    end,
})
chanceGroup:AddSlider("BadChance", {
    Text = "Bad", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for Bad (~175ms after detection)",
    Callback = function(val)
        if not legitMode then badChance = math.floor(val) end
    end,
})
chanceGroup:AddSlider("MissChance", {
    Text = "Miss", Min = 0, Max = 100, Value = 0, Step = 1,
    Tooltip = "Weight for intentional miss (note is ignored entirely)",
    Callback = function(val)
        if not legitMode then missChance = math.floor(val) end
    end,
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
