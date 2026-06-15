local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Null-Cherry/Fire-Library/refs/heads/main/Loader.lua", true))()

local C_BLUE   = Color3.fromRGB(91,  200, 245)
local C_ORANGE = Color3.fromRGB(245, 166, 35)
local C_WHITE  = Color3.fromRGB(220, 220, 225)
local C_BG     = Color3.fromRGB(18,  18,  22)

local window = lib:Window("w0opsie_ap", {
    Title    = "<font color='#5BC8F5'>w0</font><font color='#F5A623'>o</font><font color='#5BC8F5'>opsie's ap</font>",
    Icon     = "76468651273482",
    Footer   = "<font color='#5BC8F5'>basically fnf: remix</font>",
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

-- ════════════════════════════════════════════
-- timing
-- ────────────────────────────────────────────
-- notes have a perfect window of |scale| <= 0.71775 * scrollspeed
-- we fire vim slightly before that window so by the time the input
-- registers, the note is exactly at the receptor (scale = 0)
-- formula: trigger = (0.71775 - latency_in_seconds * 5.5) * spd
--
-- auto latency reads the ms counter and self-corrects:
--   hunt   → fast samples every 0.3s, corrects aggressively
--   locked → slow samples every 1s, tiny corrections (never fully stops)
--   resets to hunt on every new song so scroll speed changes are handled
-- ════════════════════════════════════════════
local vimLatencyMs    = 103
local autoLatency     = true
local autoLatencyConn = nil
local alSongWatcher   = nil   -- watches for new songs to reset phase
local alPhase         = "hunt"

local GAIN           = 0.25   -- proportional: fraction of avg error to correct each sample
local GAIN_LOCKED    = 0.04   -- gentler correction when locked
local INTEGRAL_GAIN  = 0.02   -- integral: accumulates persistent drift over time
local LOCK_THRESH    = 3      -- ms: avg error below this = good
local LOCK_N         = 10     -- consecutive good samples to lock
local UNLOCK_BAD     = 4      -- consecutive bad samples to re-hunt
local HUNT_INTERVAL  = 0.25   -- seconds between samples when hunting (faster)
local LOCK_INTERVAL  = 0.6    -- seconds between samples when locked
local OUTLIER_MAX    = 45     -- ms: ignore readings beyond this (misses/holds)

local alBuf         = {}
local AL_BUF_SIZE   = 10
local alGoodStreak  = 0
local alBadStreak   = 0
local alIntegral    = 0       -- accumulated drift for integral correction
local alSavedHitLate = false

local function alReset(toPhase)
    alBuf={}; alGoodStreak=0; alBadStreak=0; alIntegral=0
    alPhase = toPhase or "hunt"
end

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
    alReset("hunt")
    alSavedHitLate = _G.Settings and _G.Settings.HitLate or false
    if _G.Settings then _G.Settings.HitLate = true end

    -- watch for new songs: reset to hunt when a new MatchFrame appears
    -- use ChildAdded on Main (not DescendantAdded on PlayerGui) to avoid
    -- firing hundreds of times for every child added inside the gui
    if alSongWatcher then alSongWatcher:Disconnect() end
    task.spawn(function()
        local mainGui = v5.PlayerGui:WaitForChild("Main", 30)
        if not mainGui then return end
        alSongWatcher = mainGui.ChildAdded:Connect(function(child)
            if child.Name == "MatchFrame" then
                alReset("hunt")
            end
        end)
    end)

    local lastSample = 0
    local msLastText = ""       -- last seen text value
    local msLastChange = 0      -- tick() when text last changed

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

        local txt = ind.Text or ""

        -- only use this reading if the text actually changed recently
        -- stale text = no notes hit lately = not a valid timing sample
        if txt ~= msLastText then
            msLastText = txt
            msLastChange = now
        end
        if now - msLastChange > 0.5 then return end  -- reading is stale, skip

        local val = tonumber(txt:match("(-?%d+%.?%d*)"))
        if not val then return end
        if math.abs(val) > OUTLIER_MAX then return end

        table.insert(alBuf, val)
        if #alBuf > AL_BUF_SIZE then table.remove(alBuf, 1) end
        local avg = alAvg()

        if alPhase == "hunt" then
            -- PI controller: proportional (fast response) + integral (removes steady-state error)
            alIntegral = alIntegral + avg * INTEGRAL_GAIN
            alIntegral = math.clamp(alIntegral, -30, 30)  -- prevent windup
            local correction = avg * GAIN + alIntegral
            vimLatencyMs = math.clamp(vimLatencyMs + correction, 0, 300)

            if math.abs(avg) <= LOCK_THRESH then
                alGoodStreak = alGoodStreak + 1; alBadStreak = 0
                if alGoodStreak >= LOCK_N then
                    alPhase="locked"; alGoodStreak=0; alBadStreak=0; alBuf={}
                    alIntegral = alIntegral * 0.5  -- halve integral on transition
                end
            else
                alBadStreak = alBadStreak + 1; alGoodStreak = 0
            end
        else -- locked: gentle PI, re-hunt if it drifts
            alIntegral = alIntegral + avg * (INTEGRAL_GAIN * 0.3)
            alIntegral = math.clamp(alIntegral, -10, 10)
            local correction = avg * GAIN_LOCKED + alIntegral
            vimLatencyMs = math.clamp(vimLatencyMs + correction, 0, 300)

            if math.abs(avg) <= LOCK_THRESH then
                alBadStreak = 0; alGoodStreak = alGoodStreak + 1
            else
                alBadStreak = alBadStreak + 1; alGoodStreak = 0
                if alBadStreak >= UNLOCK_BAD then
                    alReset("hunt")
                end
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

-- ════════════════════════════════════════════
-- keybinds
-- ════════════════════════════════════════════
local v4 = {
    KeyBinds    = {Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.W, Enum.KeyCode.D},
    TapDuration = 0.05,
}

-- ════════════════════════════════════════════
-- state
-- ════════════════════════════════════════════
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

-- ════════════════════════════════════════════
-- tile lighting
-- ────────────────────────────────────────────
-- buttons live at matchframe.mobilekeys.left/down/up/right
-- press  → transparency = 0   (lit)
-- release → tween to 0.8      (fade out, matches game behavior)
-- ════════════════════════════════════════════
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
        tileTweens[lane] = tw; tw:Play()
    end
end

-- ════════════════════════════════════════════
-- vim input
-- ════════════════════════════════════════════
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
    vimUp(lane); vimDown(lane)
    task.delay(v4.TapDuration, function() vimUp(lane) end)
end

-- ════════════════════════════════════════════
-- hold visual reset
-- ════════════════════════════════════════════
local function resetLnHold(lane)
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

local function stopHold(lane, interrupted)
    laneHoldFrame[lane] = nil
    vimUp(lane)
    -- only reset the hold glow when we interrupt early (new note came in)
    -- on a natural hold end the game resets it itself
    if interrupted then resetLnHold(lane) end
end

-- ════════════════════════════════════════════
-- hold timer
-- ────────────────────────────────────────────
-- exact math from CreateNote source:
--   v98 = max(0, p88 - 0.07),  clamped to 0 if <= 0.03
--   Size.Y.Scale = v98 * 5.5 * spd  (negative for upscroll)
--   Debris:AddItem(holdFrame, p88 + 4)
--
-- so: p88 = |scale| / (5.5 * spd) + 0.07
--
-- we press the key vimLatencyMs before the note reaches the receptor.
-- the game registers the hold start when VIM delivers our keydown,
-- which is ~vimLatencyMs later = approximately at the receptor.
-- Debris destroys the frame p88 seconds after the note was spawned.
-- the note reaches receptor at exactly t=2s after spawn (from 11*spd
-- over 4s, receptor at 0 = halfway point).
-- so from our keydown the hold lasts: p88 - (lead time already consumed)
-- lead time = vimLatencyMs/1000  (we pressed that early)
-- remaining after pressing = p88 - vimLatencyMs/1000 - elapsed_since_press
-- ════════════════════════════════════════════
local function holdForDuration(lane, holdFrame, spd, pressedAt)
    laneHoldFrame[lane] = holdFrame

    local tailScale   = math.abs(holdFrame.Size.Y.Scale)
    local p88         = tailScale / (5.5 * spd) + 0.07
    local leadTime    = vimLatencyMs / 1000   -- how early we pressed vs receptor
    local elapsed     = tick() - pressedAt    -- time since vimDown was called
    local remaining   = math.max(0, p88 - leadTime - elapsed)

    task.delay(remaining, function()
        if laneHoldFrame[lane] == holdFrame then
            stopHold(lane, false)
        end
    end)
end

-- ════════════════════════════════════════════
-- helpers
-- ════════════════════════════════════════════
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

-- ════════════════════════════════════════════
-- note handler
-- ════════════════════════════════════════════
local function handleNote(lane, isHold, holdFrame, arrowFrame, sync, spd)
    if not canPress() then return end
    local rating = pickRating()
    if rating == "miss" then return end
    if laneHoldFrame[lane] then stopHold(lane, true) end

    local function fire()
        local pressedAt = tick()
        if isHold then
            -- short holds (blue notes) have Size.Y.Scale = exactly 0
            -- because the source clamps v98 to 0 when duration <= 0.10s
            -- real holds always have |scale| >= 0.88 so 0.01 is a safe cutoff
            local tailScale = holdFrame and math.abs(holdFrame.Size.Y.Scale) or 0
            if tailScale < 0.01 then
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

-- ════════════════════════════════════════════
-- main loop
-- ════════════════════════════════════════════
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
                        if not child:IsDescendantOf(game) then seenNotes[child]=nil end
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
                    bestDist=dist; bestNote=child
                end
            end

            if not bestNote then continue end
            seenNotes[bestNote] = true

            local isHold    = bestNote:GetAttribute("HoldHead") == true
            local holdFrame = isHold and notesFrame:FindFirstChild("Hold_"..bestNote.Name) or nil
            if isHold and not holdFrame then isHold=false end

            if laneHoldFrame[lane] then stopHold(lane, true) end
            handleNote(lane, isHold, holdFrame, arrowFrame, sync, spd)

            bestNote.AncestryChanged:Once(function()
                seenNotes[bestNote]=nil
            end)
        end
    end

    if perfected then
        mainLoop = RunService.RenderStepped:Connect(function() tick_fn(true) end)
    else
        mainLoop = RunService.Heartbeat:Connect(function() tick_fn(false) end)
    end
end

-- ════════════════════════════════════════════
-- tabs
-- ════════════════════════════════════════════
local infoTab     = window:AddTab("InfoTab",     {Text="info"    })
local mainTab     = window:AddTab("MainTab",     {Text="main"    })
local miscTab     = window:AddTab("MiscTab",     {Text="misc"    })
local settingsTab = window:AddTab("SettingsTab", {Text="settings"})

-- ── info ─────────────────────────────────────
local infoLeft  = infoTab:AddLeftGroupbox("InfoLeft",  {Text="welcome"     })
local infoRight = infoTab:AddRightGroupbox("InfoRight", {Text="how it works"})

infoLeft:AddLabel("InfoL1", {
    Text="<font color='#5BC8F5'><b>woops <3 auto player</b></font>\nmade with love\n\nautomatically plays <b>basically fnf: remix</b> for you!"
})
infoLeft:AddSeparator("IS1",{})
infoLeft:AddLabel("InfoL2", {
    Text="<font color='#F5A623'><b>best settings:</b></font>\n• perfected: on\n• auto latency: on\n• perfect weight: 100, rest 0"
})
infoLeft:AddSeparator("IS2",{})
infoLeft:AddLabel("InfoL3", {Text="<font color='#5BC8F5'><b>keybind:</b></font> rightshift = open/close"})

infoRight:AddLabel("IR1",{Text="<font color='#F5A623'><b>features</b></font>"})
infoRight:AddSeparator("IRS1",{})
infoRight:AddLabel("IR2",{Text="<font color='#5BC8F5'><b>perfected</b></font>\nuses renderstep for the most accurate timing possible."})
infoRight:AddLabel("IR3",{Text="<font color='#5BC8F5'><b>auto latency</b></font>\nreads the ms counter and adjusts itself.\nhunt = fast correction at song start.\nlocked = gentle correction, never stops.\nresets on every new song automatically."})
infoRight:AddLabel("IR4",{Text="<font color='#5BC8F5'><b>tile lights</b></font>\nlights up the mobile buttons when a key is pressed.\njust cosmetic, doesn't change anything."})
infoRight:AddLabel("IR5",{
    Text="<font color='#5BC8F5'><b>hit chances</b></font>\nthese are weights, not percentages.\nif all are 0 it always hits perfect.\n\n<font color='#F5A623'>windows:</font>\nperfect: 0ms  sick: +45ms\ngood: +75ms   ok: +125ms\nbad: +175ms"
})

-- ── main ─────────────────────────────────────
local apGroup     = mainTab:AddLeftGroupbox( "APGroup",     {Text="auto player"    })
local playerGroup = mainTab:AddLeftGroupbox( "PlayerGroup", {Text="player settings"})
local chanceGroup = mainTab:AddRightGroupbox("ChanceGroup", {Text="hit chances"    })

apGroup:AddToggle("AutoPlayerEnabled", {
    Text="enable", Value=false,
    Tooltip="turns the auto player on or off",
    Callback=function(val)
        v8=val
        if v8 then
            laneHoldFrame={nil,nil,nil,nil}; lanePressed={false,false,false,false}
            for i=1,4 do vimUp(i) end
            seenNotes={}; startLoop()
            if autoLatency then startAutoLatency() end
            window:Notification({Title="auto player", Text="turned <font color='#5BC8F5'><b>on</b></font>", Duration=2})
        else
            for i=1,4 do
                if laneHoldFrame[i] then stopHold(i,false) end
                vimUp(i)
            end
            if mainLoop then mainLoop:Disconnect(); mainLoop=nil end
            stopAutoLatency()
            laneHoldFrame={nil,nil,nil,nil}; lanePressed={false,false,false,false}
            seenNotes={}
            window:Notification({Title="auto player", Text="turned <font color='#F5A623'><b>off</b></font>", Duration=2})
        end
    end,
})

apGroup:AddToggle("Perfected", {
    Text="perfected", Value=false,
    Tooltip="uses renderstep instead of heartbeat — gives the most accurate timing",
    Callback=function(val)
        perfected=val
        if val then minReaction=0; maxReaction=0 end
        if v8 then if mainLoop then mainLoop:Disconnect(); mainLoop=nil end; startLoop() end
        window:Notification({Title="perfected", Text=val and "<font color='#5BC8F5'>on</font>" or "<font color='#F5A623'>off</font>", Duration=2})
    end,
})

apGroup:AddToggle("TileLights", {
    Text="tile lights", Value=false,
    Tooltip="lights up the mobile buttons when a note is pressed — purely visual",
    Callback=function(val)
        tileLights=val
        if not val then
            for lane=1,4 do
                local tile=getMobileTile(lane)
                if tile then tile.ImageTransparency=0.8 end
            end
        end
        window:Notification({Title="tile lights", Text=val and "<font color='#5BC8F5'>on</font>" or "<font color='#F5A623'>off</font>", Duration=2})
    end,
})

apGroup:AddToggle("MissJacks", {
    Text="miss jack notes", Value=false,
    Tooltip="skips fast repeated notes on the same key to look more human",
    Callback=function(val) missJacks=val end,
})

apGroup:AddSeparator("AS_legit",{})

apGroup:AddToggle("LegitMode", {
    Text="legit mode", Value=false,
    Tooltip="caps your kps and mixes in sicks/goods to look like a real player",
    Callback=function(val)
        legitMode=val
        if val then
            perfectChance=35; sickChance=45; goodChance=15; okChance=4; badChance=1; missChance=0
        else
            perfectChance=100; sickChance=0; goodChance=0; okChance=0; badChance=0; missChance=0
        end
        window:Notification({Title="legit mode", Text=val and "on — kps cap: <b>"..legitKpsLimit.."</b>" or "off", Duration=2})
    end,
})

apGroup:AddSlider("LegitKps", {
    Text="kps limit", Min=1, Max=100, Value=100, Step=1,
    Tooltip="max keypresses per second when legit mode is on",
    Callback=function(val) legitKpsLimit=val end,
})

-- ── player settings ───────────────────────────
playerGroup:AddToggle("AutoLatency", {
    Text="auto latency", Value=true,
    Tooltip="reads the ms counter and auto-tunes the timing. starts fast, slows down once it finds the sweet spot.",
    Callback=function(val)
        autoLatency=val
        if val and v8 then startAutoLatency()
        elseif not val then stopAutoLatency() end
        window:Notification({
            Title="auto latency",
            Text=val and "<font color='#5BC8F5'>on</font> — tuning itself" or "<font color='#F5A623'>off</font> — using manual slider",
            Duration=3
        })
    end,
})

playerGroup:AddLabel("ALInfo", {
    Text="<font color='#888'>if auto latency is off:\nms shows + → raise slider\nms shows - → lower slider</font>"
})

playerGroup:AddSlider("VimLatency", {
    Text="vim latency (ms)", Min=0, Max=300, Value=103, Step=1,
    Tooltip="only matters when auto latency is off",
    Callback=function(val) if not autoLatency then vimLatencyMs=math.floor(val) end end,
})

playerGroup:AddSeparator("PS1",{})

playerGroup:AddSlider("MinReaction", {
    Text="min reaction (ms)", Min=0, Max=150, Value=0, Step=1,
    Tooltip="ignored when perfected is on",
    Callback=function(val) if not perfected then minReaction=math.floor(val) end end,
})

playerGroup:AddSlider("MaxReaction", {
    Text="max reaction (ms)", Min=0, Max=150, Value=0, Step=1,
    Tooltip="ignored when perfected is on",
    Callback=function(val) if not perfected then maxReaction=math.floor(val) end end,
})

-- ── hit chances ───────────────────────────────
chanceGroup:AddLabel("CI",{Text="<font color='#F5A623'><b>weights, not percentages</b></font>\nall 0 = always perfect.\nlocked while legit mode is on."})
chanceGroup:AddSeparator("CS",{})
chanceGroup:AddSlider("PerfectChance",{Text="perfect",Min=0,Max=100,Value=100,Step=1,Callback=function(v) if not legitMode then perfectChance=math.floor(v) end end})
chanceGroup:AddSlider("SickChance",   {Text="sick",   Min=0,Max=100,Value=0,  Step=1,Tooltip="+45ms",  Callback=function(v) if not legitMode then sickChance=math.floor(v) end end})
chanceGroup:AddSlider("GoodChance",   {Text="good",   Min=0,Max=100,Value=0,  Step=1,Tooltip="+75ms",  Callback=function(v) if not legitMode then goodChance=math.floor(v) end end})
chanceGroup:AddSlider("OkChance",     {Text="ok",     Min=0,Max=100,Value=0,  Step=1,Tooltip="+125ms", Callback=function(v) if not legitMode then okChance=math.floor(v) end end})
chanceGroup:AddSlider("BadChance",    {Text="bad",    Min=0,Max=100,Value=0,  Step=1,Tooltip="+175ms", Callback=function(v) if not legitMode then badChance=math.floor(v) end end})
chanceGroup:AddSlider("MissChance",   {Text="miss",   Min=0,Max=100,Value=0,  Step=1,               Callback=function(v) if not legitMode then missChance=math.floor(v) end end})

-- ── misc ─────────────────────────────────────
local miscGroup = miscTab:AddLeftGroupbox("MiscGroup", {Text="platform display"})

miscGroup:AddToggle("PlatformAutoRejoin", {
    Text="auto rejoin after applying", Value=true,
    Callback=function(val) platformAutoRejoin=val end,
})
miscGroup:AddTextBox("PlatformContent", {
    Text="display content", Value="😇", PlaceholderText="type text or emoji...",
    Callback=function(val) if val and val~="" then platformContent=val end end,
})
miscGroup:AddButton("ApplyPlatform", {
    Text="apply platform display",
    Callback=function()
        if game.PlaceId ~= 6520999642 then
            window:Notification({Title="error",Text="wrong game!",Duration=3}); return
        end
        if not (isfile and readfile and writefile) then
            window:Notification({Title="error",Text="executor not supported",Duration=3}); return
        end
        local QueueOnTP = (syn and syn.queue_on_teleport)
            or (fluxus and fluxus.queue_on_teleport)
            or (queue_on_teleport and queue_on_teleport)
        if not QueueOnTP then
            window:Notification({Title="error",Text="missing queue_on_teleport",Duration=3}); return
        end
        local Content=platformContent
        writefile("FNFRemixDisplayContent.txt", tostring(Content))
        local SG=game:GetService("StarterGui"); local P=game:GetService("Players")
        local TPS=game:GetService("TeleportService"); local Spk=P.LocalPlayer
        local function Alert()
            local s=Instance.new("Sound",game:GetService("SoundService"))
            s.Volume=2; s.SoundId="rbxassetid://4590662766"; s.PlayOnRemove=true; s:Destroy()
        end
        if _G.FNFRemixACPD or (getgenv and getgenv().FNFRemixACPD) then
            SG:SetCore("SendNotification",{Title="🧐 changed!",Text="display: '"..Content.."'",Duration=5})
            window:Notification({Title="platform",Text="content: "..Content,Duration=4})
            Alert(); return
        end
        local Rejoin=Instance.new("BindableFunction")
        Rejoin.OnInvoke=function(Ans)
            if Ans=="Yes" and platformAutoRejoin then
                if #P:GetPlayers()<=1 then
                    Spk:Kick("\nrejoining..."); task.wait(); TPS:Teleport(6520999642,Spk)
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
            Title=platformAutoRejoin and "🧐 rejoin?" or "🧐 done",
            Text=platformAutoRejoin and "rejoin to apply '"..Content.."'?" or "rejoin manually.",
            Button1="Yes",Button2="No",Duration=(1/0),Callback=Rejoin,
        })
        Alert()
        window:Notification({Title="platform",Text="set: "..Content,Duration=4})
        if getgenv then getgenv().FNFRemixACPD=true else _G.FNFRemixACPD=true end
    end,
})

-- ── settings ─────────────────────────────────
local themeGroup = settingsTab:AddLeftGroupbox("ThemeGroup", {Text="theme"})

themeGroup:AddLabel("TL1",{Text="<font color='#5BC8F5'><b>accent color</b></font> (default: #5BC8F5)"}):AddColorPicker("ThemeMain",{
    Value=C_BLUE,
    Callback=function(val) window.Theme={Back=C_BG,Main=val,Stroke=C_ORANGE,Text=C_WHITE}; window:Refresh() end,
})
themeGroup:AddLabel("TL2",{Text="<font color='#F5A623'><b>stroke color</b></font> (default: #F5A623)"}):AddColorPicker("ThemeStroke",{
    Value=C_ORANGE,
    Callback=function(val) window.Theme={Back=C_BG,Main=C_BLUE,Stroke=val,Text=C_WHITE}; window:Refresh() end,
})
