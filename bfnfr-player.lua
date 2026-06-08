local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImInsane-1337/neverlose-ui/refs/heads/main/source/library.lua"))()

Library.AccentColor = Color3.fromRGB(46, 160, 255)
Library.AccentColor2 = Color3.fromRGB(255, 150, 20)
Library.LogsEnabled = true
Library.CurrentScale = 0.75

local v0 = game:GetService("RunService")
local v1 = game:GetService("VirtualInputManager")
local v2 = game:GetService("Players")

local v4 = {
    KeyBinds = {[1] = Enum.KeyCode.A, [2] = Enum.KeyCode.S, [3] = Enum.KeyCode.W, [4] = Enum.KeyCode.D},
    HitPixels = 15,
    TapDuration = 0.05,
}

local v5 = v2.LocalPlayer
local v6 = {}
local v7 = {}
local v8 = false
local missJacks = false
local mainLoop = nil
local holdCache = {}
local cacheBuilt = {}
local heldKeys = {}

local minReaction = 0
local maxReaction = 0
local perfectChance = 100
local sickChance = 0
local goodChance = 0
local okChance = 0
local badChance = 0
local missChance = 0
local platformContent = "😇"
local platformAutoRejoin = true

local function pressKey(key)
    if not heldKeys[key] then
        heldKeys[key] = true
        v1:SendKeyEvent(true, key, false, game)
    end
end

local function releaseKey(key)
    if heldKeys[key] then
        heldKeys[key] = nil
        v1:SendKeyEvent(false, key, false, game)
    end
end

-- Squircle + gradient patcher — runs repeatedly for 3 seconds to catch late-loaded elements
task.spawn(function()
    local function patch(root)
        for _, gui in pairs(root:GetDescendants()) do
            if (gui:IsA("ImageButton") or gui:IsA("Frame")) then
                local corner = gui:FindFirstChildOfClass("UICorner")
                if corner and (corner.CornerRadius == UDim.new(1, 0) or corner.CornerRadius == UDim.new(0.5, 0)) then
                    corner.CornerRadius = UDim.new(0.3, 0)
                    if not gui:FindFirstChildOfClass("UIGradient") then
                        local grad = Instance.new("UIGradient")
                        grad.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 160, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 20)),
                        })
                        grad.Rotation = 135
                        grad.Parent = gui
                    end
                end
            end
        end
    end
    for i = 1, 6 do
        task.wait(0.5)
        pcall(function() patch(game:GetService("CoreGui")) end)
        pcall(function() patch(v5.PlayerGui) end)
    end
end)

-- UI
local Window = Library:Window({
    Name = "w0opsie's ap",
    SubName = "Basically FNF: Remix",
    MenuKeybind = Enum.KeyCode.RightShift
})

local MainPage = Window:Page({Name = "Main"})

-- AUTO PLAYER section (left)
local apSection = MainPage:Section({Name = "Auto Player", Side = 1})

apSection:Toggle({
    Name = "Enable",
    Flag = "AutoPlayer_Enabled",
    Default = false,
    Callback = function(val)
        v8 = val
        if v8 then
            holdCache = {}
            cacheBuilt = {}
            for _, key in pairs(v4.KeyBinds) do releaseKey(key) end
            startLoop()
            Library:Log("AutoPlayer ON", 3, Color3.fromRGB(46, 160, 255))
        else
            for _, key in pairs(v4.KeyBinds) do releaseKey(key) end
            if mainLoop then mainLoop:Disconnect() end
            Library:Log("AutoPlayer OFF", 3, Color3.fromRGB(255, 150, 20))
        end
    end,
})

apSection:Toggle({
    Name = "Miss Jack Notes",
    Flag = "MissJacks",
    Default = false,
    Callback = function(val)
        missJacks = val
    end,
})

-- PLAYER SETTINGS section (left)
local playerSection = MainPage:Section({Name = "Player Settings", Side = 1})

playerSection:Slider({
    Name = "Min Reaction",
    Flag = "MinReaction",
    Min = 0,
    Max = 150,
    Default = 0,
    Decimals = 0,
    Suffix = "ms",
    Callback = function(val)
        minReaction = tonumber(val) or 0
    end,
})

playerSection:Slider({
    Name = "Max Reaction",
    Flag = "MaxReaction",
    Min = 0,
    Max = 150,
    Default = 0,
    Decimals = 0,
    Suffix = "ms",
    Callback = function(val)
        maxReaction = tonumber(val) or 0
    end,
})

-- HIT CHANCES section (right)
local chanceSection = MainPage:Section({Name = "Hit Chances", Side = 2})

chanceSection:Slider({
    Name = "Perfect Chance",
    Flag = "PerfectChance",
    Min = 0,
    Max = 100,
    Default = 100,
    Decimals = 0,
    Suffix = "%",
    Callback = function(val)
        perfectChance = tonumber(val) or 100
    end,
})

chanceSection:Slider({
    Name = "Sick Chance",
    Flag = "SickChance",
    Min = 0,
    Max = 100,
    Default = 0,
    Decimals = 0,
    Suffix = "%",
    Callback = function(val)
        sickChance = tonumber(val) or 0
    end,
})

chanceSection:Slider({
    Name = "Good Chance",
    Flag = "GoodChance",
    Min = 0,
    Max = 100,
    Default = 0,
    Decimals = 0,
    Suffix = "%",
    Callback = function(val)
        goodChance = tonumber(val) or 0
    end,
})

chanceSection:Slider({
    Name = "Ok Chance",
    Flag = "OkChance",
    Min = 0,
    Max = 100,
    Default = 0,
    Decimals = 0,
    Suffix = "%",
    Callback = function(val)
        okChance = tonumber(val) or 0
    end,
})

chanceSection:Slider({
    Name = "Bad Chance",
    Flag = "BadChance",
    Min = 0,
    Max = 100,
    Default = 0,
    Decimals = 0,
    Suffix = "%",
    Callback = function(val)
        badChance = tonumber(val) or 0
    end,
})

chanceSection:Slider({
    Name = "Miss Chance",
    Flag = "MissChance",
    Min = 0,
    Max = 100,
    Default = 0,
    Decimals = 0,
    Suffix = "%",
    Callback = function(val)
        missChance = tonumber(val) or 0
    end,
})

-- MISC section (right, under hit chances)
local miscSection = MainPage:Section({Name = "Misc", Side = 2})

miscSection:Toggle({
    Name = "Auto Rejoin",
    Flag = "PlatformAutoRejoin",
    Default = true,
    Callback = function(val)
        platformAutoRejoin = val
    end,
})

miscSection:Textbox({
    Name = "Platform Display Content",
    Flag = "PlatformContent",
    Placeholder = "Enter text or emoji...",
    Default = "😇",
    Numeric = false,
    Finished = false,
    Callback = function(val)
        if val and val ~= "" then
            platformContent = val
        end
    end,
})

miscSection:Button({
    Name = "Apply Platform Display",
    Flag = "ApplyPlatform",
    Callback = function()
        if game.PlaceId ~= 6520999642 then
            Library:Log("Wrong game!", 3, Color3.fromRGB(255, 80, 80))
            return
        end

        if not (isfile and readfile and writefile) then
            Library:Log("Incompatible executor!", 3, Color3.fromRGB(255, 80, 80))
            return
        end

        local QueueOnTP = (syn and syn.queue_on_teleport)
            or (fluxus and fluxus.queue_on_teleport)
            or (queue_on_teleport and queue_on_teleport)

        if not QueueOnTP then
            Library:Log("Missing queue_on_teleport!", 3, Color3.fromRGB(255, 80, 80))
            return
        end

        local Content = platformContent
        writefile("FNFRemixDisplayContent.txt", tostring(Content))

        local StarterGui = game:GetService("StarterGui")
        local Players = game:GetService("Players")
        local TPService = game:GetService("TeleportService")
        local Speaker = Players.LocalPlayer

        local function Alert()
            local Sound = Instance.new("Sound", game:GetService("SoundService"))
            Sound.Volume = 2
            Sound.SoundId = "rbxassetid://4590662766"
            Sound.PlayOnRemove = true
            Sound:Destroy()
        end

        if _G.FNFRemixACPD or (getgenv and getgenv().FNFRemixACPD) then
            StarterGui:SetCore("SendNotification", {
                Title = "🧐 Changed Content!",
                Text = "Display changed to '" .. Content .. "', rejoin to see changes.",
                Duration = 5
            })
            Library:Log("Content: " .. Content, 4, Color3.fromRGB(46, 160, 255))
            Alert()
            return
        end

        local Rejoin = Instance.new("BindableFunction")
        Rejoin.OnInvoke = function(Answer)
            if Answer == "Yes" and platformAutoRejoin then
                if #Players:GetPlayers() <= 1 then
                    Speaker:Kick("\nRejoining...")
                    task.wait()
                    TPService:Teleport(6520999642, Speaker)
                else
                    TPService:TeleportToPlaceInstance(6520999642, game.JobId, Speaker)
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
                        Child.Disabled = true
                        conn:Disconnect()
                    end
                end)
            end)
            game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild'PlatformRemoteEvent':FireServer(tostring(Content))
        ]])

        StarterGui:SetCore("SendNotification", {
            Title = "🧐 Rejoin Required!",
            Text = platformAutoRejoin
                and "Rejoin to apply display '" .. Content .. "'?"
                or "Display set. Rejoin manually to apply.",
            Button1 = "Yes",
            Button2 = "No",
            Duration = (1/0),
            Callback = Rejoin
        })

        Alert()
        Library:Log("Platform set: " .. Content, 4, Color3.fromRGB(46, 160, 255))

        if getgenv then getgenv().FNFRemixACPD = true
        else _G.FNFRemixACPD = true end
    end,
})

Library:CreateSettingsPage(Window)

-- HOLD CACHE
local function buildHoldCache(notesFolder)
    local normalNotes = {}
    local holdNotes = {}
    for _, obj in pairs(notesFolder:GetChildren()) do
        if not obj:IsA("GuiObject") then continue end
        if obj.Name:sub(1, 5) == "Hold_" then
            local num = tonumber(obj.Name:sub(6))
            if num then table.insert(holdNotes, {num = num, obj = obj}) end
        elseif tonumber(obj.Name) then
            table.insert(normalNotes, {num = tonumber(obj.Name), obj = obj})
        end
    end
    table.sort(normalNotes, function(a, b) return a.num < b.num end)
    table.sort(holdNotes, function(a, b) return a.num < b.num end)
    for _, noteData in pairs(normalNotes) do
        local noteY = noteData.obj.AbsolutePosition.Y
        local closest, closestDist = nil, math.huge
        for _, holdData in pairs(holdNotes) do
            local dist = math.abs(holdData.obj.AbsolutePosition.Y - noteY)
            if dist < closestDist then closestDist = dist; closest = holdData.obj end
        end
        if closest and closestDist <= 50 then holdCache[noteData.obj] = closest end
    end
end

local function findHoldForNote(note, notesFolder)
    if holdCache[note] then return holdCache[note] end
    local noteY = note.AbsolutePosition.Y
    local closest, closestDist = nil, math.huge
    for _, obj in pairs(notesFolder:GetChildren()) do
        if obj.Name:sub(1, 5) == "Hold_" and obj.Visible then
            local dist = math.abs(obj.AbsolutePosition.Y - noteY)
            if dist < closestDist then closestDist = dist; closest = obj end
        end
    end
    if closest and closestDist <= 50 then return closest end
    return nil
end

-- Weighted random rating picker (for future use)
local function pickRating()
    local pool = {}
    for i = 1, perfectChance do table.insert(pool, "perfect") end
    for i = 1, sickChance do table.insert(pool, "sick") end
    for i = 1, goodChance do table.insert(pool, "good") end
    for i = 1, okChance do table.insert(pool, "ok") end
    for i = 1, badChance do table.insert(pool, "bad") end
    for i = 1, missChance do table.insert(pool, "miss") end
    if #pool == 0 then return "perfect" end
    return pool[math.random(1, #pool)]
end

-- NOTE HANDLER
local function handleNote(arrowIdx, note, notesFolder, arrowFolder)
    local key = v4.KeyBinds[arrowIdx]
    local holdObj = findHoldForNote(note, notesFolder)
    local isHold = holdObj ~= nil
    local lnHold = arrowFolder:FindFirstChild("LnHold")

    if v7[arrowIdx] and not isHold then
        if missJacks then return end
        task.spawn(function()
            releaseKey(key)
            task.wait(0.02)
            pressKey(key)
            task.wait(v4.TapDuration)
            releaseKey(key)
        end)
        return
    end

    if v7[arrowIdx] then return end
    v7[arrowIdx] = true

    task.spawn(function()
        -- Reaction time delay
        if maxReaction > 0 then
            local lo = math.min(minReaction, maxReaction)
            local hi = math.max(minReaction, maxReaction)
            task.wait(math.random(lo, hi) / 1000)
        end

        -- Miss chance: skip the press entirely
        local rating = pickRating()
        if rating == "miss" then
            v7[arrowIdx] = nil
            return
        end

        releaseKey(key)
        task.wait()
        pressKey(key)

        if isHold then
            v7[arrowIdx] = nil
            v6[holdObj] = true

            local released = false
            local function doRelease()
                if not released then
                    released = true
                    releaseKey(key)
                    v6[note] = nil
                    v6[holdObj] = nil
                end
            end

            task.wait(0.05)

            local conn
            conn = v0.Heartbeat:Connect(function()
                if not lnHold then doRelease(); conn:Disconnect(); return end
                if lnHold.ImageTransparency >= 0.9 then doRelease(); conn:Disconnect() end
            end)
        else
            task.wait(v4.TapDuration)
            releaseKey(key)
            v7[arrowIdx] = nil
        end
    end)
end

local function getMyKeySync()
    local Match = v5.PlayerGui:FindFirstChild("Main") and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
    if not (Match and Match.Visible) then return nil end
    local playerVal = v5:FindFirstChild("File") and v5.File:FindFirstChild("CurrentPlayer")
    if playerVal and playerVal.Value then
        local side = (playerVal.Value.Name == "Player2") and "KeySync2" or "KeySync1"
        return Match:FindFirstChild(side)
    end
    return nil
end

function startLoop()
    if mainLoop then mainLoop:Disconnect() end
    mainLoop = v0.Heartbeat:Connect(function()
        if not v8 then return end
        local KeySync = getMyKeySync()
        if not (KeySync and KeySync.Visible) then return end

        for i = 1, 4 do
            local folder = KeySync:FindFirstChild("Arrow"..i)
            local receptor = folder and folder:FindFirstChild("Arrow")
            local notes = folder and folder:FindFirstChild("Notes")

            if receptor and notes then
                if not cacheBuilt[i] then
                    cacheBuilt[i] = true
                    buildHoldCache(notes)
                    notes.ChildAdded:Connect(function(child)
                        if child:IsA("GuiObject") and child.Name:sub(1,5) ~= "Hold_" then
                            task.wait()
                            local noteY = child.AbsolutePosition.Y
                            local closest, closestDist = nil, math.huge
                            for _, obj in pairs(notes:GetChildren()) do
                                if obj.Name:sub(1,5) == "Hold_" and obj.Visible then
                                    local dist = math.abs(obj.AbsolutePosition.Y - noteY)
                                    if dist < closestDist then closestDist = dist; closest = obj end
                                end
                            end
                            if closest and closestDist <= 50 then holdCache[child] = closest end
                        end
                    end)
                end

                local targetY = receptor.AbsolutePosition.Y
                for _, note in pairs(notes:GetChildren()) do
                    if not note:IsA("GuiObject") or not note.Visible or note.Name == "Arrow" or v6[note] then continue end
                    if note.Name:sub(1,5) == "Hold_" then continue end
                    if math.abs(note.AbsolutePosition.Y - targetY) <= v4.HitPixels then
                        v6[note] = true
                        handleNote(i, note, notes, folder)
                        note.AncestryChanged:Once(function() v6[note] = nil end)
                    end
                end
            end
        end
    end)
end
