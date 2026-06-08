local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImInsane-1337/neverlose-ui/refs/heads/main/source/library.lua"))()

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

-- UI SETUP
Library.LogsEnabled = true

local Window = Library:Window({
    Name = "wo0psie's private ap",
    SubName = "Basically FNF: Remix",
    MenuKeybind = Enum.KeyCode.RightShift
})

local Page = Window:Page({Name = "Settings"})
local Section = Page:Section({Name = "Main", Side = 1})

local EnabledToggle = Section:Toggle({
    Name = "Auto Player",
    Flag = "AutoPlayer_Enabled",
    Default = false,
    Callback = function(val)
        v8 = val
        if v8 then
            holdCache = {}
            cacheBuilt = {}
            for _, key in pairs(v4.KeyBinds) do releaseKey(key) end
            startLoop()
            Library:Log("AutoPlayer Enabled", 3, Color3.fromRGB(0, 255, 100))
        else
            for _, key in pairs(v4.KeyBinds) do releaseKey(key) end
            if mainLoop then mainLoop:Disconnect() end
            Library:Log("AutoPlayer Disabled", 3, Color3.fromRGB(255, 80, 80))
        end
    end,
})

Section:Toggle({
    Name = "Miss Jack Notes",
    Flag = "MissJacks",
    Default = false,
    Callback = function(val)
        missJacks = val
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
            local num = tonumber(obj.Name)
            table.insert(normalNotes, {num = num, obj = obj})
        end
    end
    table.sort(normalNotes, function(a, b) return a.num < b.num end)
    table.sort(holdNotes, function(a, b) return a.num < b.num end)
    for _, noteData in pairs(normalNotes) do
        local noteY = noteData.obj.AbsolutePosition.Y
        local closest = nil
        local closestDist = math.huge
        for _, holdData in pairs(holdNotes) do
            local dist = math.abs(holdData.obj.AbsolutePosition.Y - noteY)
            if dist < closestDist then
                closestDist = dist
                closest = holdData.obj
            end
        end
        if closest and closestDist <= 50 then
            holdCache[noteData.obj] = closest
        end
    end
end

local function findHoldForNote(note, notesFolder)
    if holdCache[note] then return holdCache[note] end
    local noteY = note.AbsolutePosition.Y
    local closest = nil
    local closestDist = math.huge
    for _, obj in pairs(notesFolder:GetChildren()) do
        if obj.Name:sub(1, 5) == "Hold_" and obj.Visible then
            local dist = math.abs(obj.AbsolutePosition.Y - noteY)
            if dist < closestDist then
                closestDist = dist
                closest = obj
            end
        end
    end
    if closest and closestDist <= 50 then return closest end
    return nil
end

-- NOTE HANDLER
local function handleNote(arrowIdx, note, notesFolder, arrowFolder)
    local key = v4.KeyBinds[arrowIdx]
    local holdObj = findHoldForNote(note, notesFolder)
    local isHold = holdObj ~= nil
    local lnHold = arrowFolder:FindFirstChild("LnHold")

    -- Jack note handling
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
                if not lnHold then
                    doRelease()
                    conn:Disconnect()
                    return
                end
                if lnHold.ImageTransparency >= 0.9 then
                    doRelease()
                    conn:Disconnect()
                end
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
                            local closest = nil
                            local closestDist = math.huge
                            for _, obj in pairs(notes:GetChildren()) do
                                if obj.Name:sub(1, 5) == "Hold_" and obj.Visible then
                                    local dist = math.abs(obj.AbsolutePosition.Y - noteY)
                                    if dist < closestDist then
                                        closestDist = dist
                                        closest = obj
                                    end
                                end
                            end
                            if closest and closestDist <= 50 then
                                holdCache[child] = closest
                            end
                        end
                    end)
                end

                local targetY = receptor.AbsolutePosition.Y
                for _, note in pairs(notes:GetChildren()) do
                    if not note:IsA("GuiObject") or not note.Visible or note.Name == "Arrow" or v6[note] then continue end
                    if note.Name:sub(1, 5) == "Hold_" then continue end

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
