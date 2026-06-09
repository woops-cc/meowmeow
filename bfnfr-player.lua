local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/woops-cc/private/refs/heads/main/Library.lua"))()

-- OC colors: sky blue #5BC8F5, orange/gold #F5A623, white #FFFFFF
Library.Theme["Accent"]             = Color3.fromRGB(91, 200, 245)   -- sky blue
Library.Theme["Window Background"]  = Color3.fromRGB(18, 18, 22)
Library.Theme["Section Background"] = Color3.fromRGB(12, 12, 16)
Library.Theme["Inline"]             = Color3.fromRGB(10, 10, 14)
Library.Theme["Element"]            = Color3.fromRGB(40, 40, 50)
Library.Theme["Border"]             = Color3.fromRGB(91, 200, 245)
Library.Theme["Text"]               = Color3.fromRGB(220, 220, 220)

-- ──────────────────────────────────────────────
-- Services & config
-- ──────────────────────────────────────────────
local v0 = game:GetService("RunService")
local v1 = game:GetService("VirtualInputManager")
local v2 = game:GetService("Players")

local v4 = {
    KeyBinds    = {[1] = Enum.KeyCode.A, [2] = Enum.KeyCode.S, [3] = Enum.KeyCode.W, [4] = Enum.KeyCode.D},
    HitPixels   = 15,
    TapDuration = 0.05,
}

local v5           = v2.LocalPlayer
local v6           = {}
local v7           = {}
local v8           = false
local missJacks    = false
local mainLoop     = nil
local holdCache    = {}
local cacheBuilt   = {}
local heldKeys     = {}

local minReaction   = 0
local maxReaction   = 0
local perfectChance = 100
local sickChance    = 0
local goodChance    = 0
local okChance      = 0
local badChance     = 0
local missChance    = 0
local platformContent    = "😇"
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

-- ──────────────────────────────────────────────
-- Window
-- ──────────────────────────────────────────────
local Window = Library:Window({
    Name = "w0opsie's ap",
    GradientTitle = {
        Enabled = true,
        Start   = Color3.fromRGB(91, 200, 245),   -- sky blue
        Middle  = Color3.fromRGB(245, 166, 35),   -- orange/gold
        End     = Color3.fromRGB(91, 200, 245),   -- back to blue
        Speed   = 1
    }
})

-- ──────────────────────────────────────────────
-- OC toggle button (Sharp Cube)
-- ──────────────────────────────────────────────
task.defer(function()
    local holder = Library.Holder and Library.Holder.Instance
    if not holder then return end

    local windowFrame
    for _, c in ipairs(holder:GetChildren()) do
        if (c:IsA("Frame") or c:IsA("TextButton")) and c.AbsoluteSize.X > 100 then
            windowFrame = c
            break
        end
    end
    if not windowFrame then return end

    local uiVisible = true

    -- Base Cube matching Section Background
    local btn = Instance.new("ImageButton")
    btn.Name          = "OCToggleBtn"
    btn.Size          = UDim2.new(0, 45, 0, 45)
    btn.Position      = UDim2.new(1, -60, 0, 15)
    btn.AnchorPoint   = Vector2.new(0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(12, 12, 16) 
    btn.BorderSizePixel  = 0
    btn.ZIndex        = 999
    btn.Parent        = holder

    -- Sharp Border matching UI outline
    local stroke = Instance.new("UIStroke")
    stroke.Color     = Color3.fromRGB(68, 68, 68) 
    stroke.Thickness = 2
    stroke.LineJoinMode = Enum.LineJoinMode.Miter
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent    = btn

    -- OC Icon
    local icon = Instance.new("ImageLabel")
    icon.Size             = UDim2.new(0.8, 0, 0.8, 0)
    icon.Position         = UDim2.new(0.1, 0, 0.1, 0)
    icon.BackgroundTransparency = 1
    icon.Image            = "rbxassetid://133412738038266" 
    icon.ScaleType        = Enum.ScaleType.Fit
    icon.ZIndex           = 1000
    icon.Parent           = btn

    -- Top bar accent matching OC Blue
    local topbar = Instance.new("Frame")
    topbar.Size              = UDim2.new(1, 0, 0, 2)
    topbar.Position          = UDim2.new(0, 0, 0, 0)
    topbar.BorderSizePixel   = 0
    topbar.BackgroundColor3  = Color3.fromRGB(91, 200, 245)
    topbar.ZIndex            = 1001
    topbar.Parent            = btn

    btn.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        windowFrame.Visible = uiVisible
        stroke.Color = uiVisible and Color3.fromRGB(91, 200, 245) or Color3.fromRGB(68, 68, 68)
    end)
end)

-- ──────────────────────────────────────────────
-- Single page — Main (everything merged here)
-- ──────────────────────────────────────────────
local MainPage = Window:Page({Name = "Main", Columns = 2})

-- LEFT column
local apSection     = MainPage:Section({Name = "Auto Player",     Side = 1})
local playerSection = MainPage:Section({Name = "Player Settings", Side = 1})
local miscSection   = MainPage:Section({Name = "Platform",        Side = 1})

-- RIGHT column
local chanceSection = MainPage:Section({Name = "Hit Chances", Side = 2})

-- Settings page
local SettingsPage  = Window:Page({Name = "Settings", Columns = 2})

-- ──────────────────────────────────────────────
-- Auto Player
-- ──────────────────────────────────────────────
apSection:Toggle({
    Name     = "Enable",
    Flag     = "AutoPlayer_Enabled",
    Default  = false,
    Callback = function(val)
        v8 = val
        if v8 then
            holdCache  = {}
            cacheBuilt = {}
            for _, key in pairs(v4.KeyBinds) do releaseKey(key) end
            startLoop()
            Library:Notification("AutoPlayer ON", 2, Color3.fromRGB(91, 200, 245))
        else
            for _, key in pairs(v4.KeyBinds) do releaseKey(key) end
            if mainLoop then mainLoop:Disconnect() end
            Library:Notification("AutoPlayer OFF", 2, Color3.fromRGB(245, 166, 35))
        end
    end,
})

apSection:Toggle({
    Name     = "Miss Jack Notes",
    Flag     = "MissJacks",
    Default  = false,
    Callback = function(val) missJacks = val end,
})

-- ──────────────────────────────────────────────
-- Player Settings
-- ──────────────────────────────────────────────
playerSection:Slider({
    Name     = "Min Reaction",
    Flag     = "MinReaction",
    Min      = 0,
    Max      = 150,
    Default  = 0,
    Decimals = 0,
    Suffix   = "ms",
    Callback = function(val) minReaction = math.floor(tonumber(val) or 0) end,
})

playerSection:Slider({
    Name     = "Max Reaction",
    Flag     = "MaxReaction",
    Min      = 0,
    Max      = 150,
    Default  = 0,
    Decimals = 0,
    Suffix   = "ms",
    Callback = function(val) maxReaction = math.floor(tonumber(val) or 0) end,
})

-- ──────────────────────────────────────────────
-- Platform (misc merged into left column)
-- ──────────────────────────────────────────────
miscSection:Toggle({
    Name     = "Custom Platform Display",
    Flag     = "PlatformAutoRejoin",
    Default  = true,
    Callback = function(val) platformAutoRejoin = val end,
})

miscSection:Textbox({
    Name        = "Display Content",
    Flag        = "PlatformContent",
    Default     = "😇",
    Placeholder = "Enter text or emoji...",
    Callback    = function(val)
        if val and val ~= "" then platformContent = val end
    end,
})

miscSection:Button({
    Name     = "Apply Platform Display",
    Callback = function()
        if game.PlaceId ~= 6520999642 then
            Library:Notification("Wrong game!", 3, Color3.fromRGB(255, 80, 80))
            return
        end
        if not (isfile and readfile and writefile) then
            Library:Notification("Incompatible executor!", 3, Color3.fromRGB(255, 80, 80))
            return
        end
        local QueueOnTP = (syn and syn.queue_on_teleport)
            or (fluxus and fluxus.queue_on_teleport)
            or (queue_on_teleport and queue_on_teleport)
        if not QueueOnTP then
            Library:Notification("Missing queue_on_teleport!", 3, Color3.fromRGB(255, 80, 80))
            return
        end
        local Content = platformContent
        writefile("FNFRemixDisplayContent.txt", tostring(Content))
        local StarterGui = game:GetService("StarterGui")
        local Players    = game:GetService("Players")
        local TPService  = game:GetService("TeleportService")
        local Speaker    = Players.LocalPlayer
        local function Alert()
            local Sound = Instance.new("Sound", game:GetService("SoundService"))
            Sound.Volume = 2;
            Sound.SoundId = "rbxassetid://4590662766"
            Sound.PlayOnRemove = true;
            Sound:Destroy()
        end
        if _G.FNFRemixACPD or (getgenv and getgenv().FNFRemixACPD) then
            StarterGui:SetCore("SendNotification", {Title="🧐 Changed!", Text="Display: '"..Content.."'", Duration=5})
            Library:Notification("Content: "..Content, 4, Color3.fromRGB(91,200,245))
            Alert();
            return
        end
        local Rejoin = Instance.new("BindableFunction")
        Rejoin.OnInvoke = function(Answer)
            if Answer == "Yes" and platformAutoRejoin then
                if #Players:GetPlayers() <= 1 then
                    Speaker:Kick("\nRejoining...");
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
                        Child.Disabled = true; conn:Disconnect()
                    end
                end)
            end)
            game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild'PlatformRemoteEvent':FireServer(tostring(Content))
        ]])
        StarterGui:SetCore("SendNotification", {
            Title=platformAutoRejoin and "🧐 Rejoin?" or "🧐 Done",
            Text=platformAutoRejoin and "Rejoin to apply '"..Content.."'?" or "Rejoin manually to apply.",
            Button1="Yes", Button2="No", Duration=(1/0), Callback=Rejoin
        })
        Alert()
        Library:Notification("Platform set: "..Content, 4, Color3.fromRGB(91,200,245))
        if getgenv then getgenv().FNFRemixACPD = true else _G.FNFRemixACPD = true end
    end,
})

-- ──────────────────────────────────────────────
-- Hit Chances (right column)
-- ──────────────────────────────────────────────
chanceSection:Slider({
    Name="Perfect Chance", Flag="PerfectChance", Min=0, Max=100, Default=100,
    Decimals=0, Suffix="%",
    Callback=function(val) perfectChance = math.floor(tonumber(val) or 100) end,
})
chanceSection:Slider({
    Name="Sick Chance", Flag="SickChance", Min=0, Max=100, Default=0,
    Decimals=0, Suffix="%",
    Callback=function(val) sickChance = math.floor(tonumber(val) or 0) end,
})
chanceSection:Slider({
    Name="Good Chance", Flag="GoodChance", Min=0, Max=100, Default=0,
    Decimals=0, Suffix="%",
    Callback=function(val) goodChance = math.floor(tonumber(val) or 0) end,
})
chanceSection:Slider({
    Name="Ok Chance", Flag="OkChance", Min=0, Max=100, Default=0,
    Decimals=0, Suffix="%",
    Callback=function(val) okChance = math.floor(tonumber(val) or 0) end,
})
chanceSection:Slider({
    Name="Bad Chance", Flag="BadChance", Min=0, Max=100, Default=0,
    Decimals=0, Suffix="%",
    Callback=function(val) badChance = math.floor(tonumber(val) or 0) end,
})
chanceSection:Slider({
    Name="Miss Chance", Flag="MissChance", Min=0, Max=100, Default=0,
    Decimals=0, Suffix="%",
    Callback=function(val) missChance = math.floor(tonumber(val) or 0) end,
})

-- ──────────────────────────────────────────────
-- Settings page
-- ──────────────────────────────────────────────
local ThemesSection  = SettingsPage:Section({Name = "Themes",  Side = 1})
local ConfigsSection = SettingsPage:Section({Name = "Configs", Side = 2})

do
    for Index, Value in Library.Theme do
        Library.ThemeColorpickers[Index] = ThemesSection:Label(Index, "Left"):Colorpicker({
            Name=Index, Flag="Theme"..Index, Default=Value,
            Callback=function(v) Library.Theme[Index]=v;
Library:ChangeTheme(Index,v) end
        })
    end
    ThemesSection:Dropdown({
        Name="Preset Themes", Items={"Default","Bitchbot","Onetap","Aqua"}, Default="Default",
        Callback=function(v)
            local d = Library.Themes[v]; if not d then return end
            for i, val in Library.Theme do
                Library.Theme[i]=d[i]; Library:ChangeTheme(i,d[i])
                Library.ThemeColorpickers[i]:Set(d[i])
            end
        end
    })
end

do
    local ConfigName, SelectedConfig = "", nil
    local ConfigsListbox = ConfigsSection:Listbox({
        Name="Saved Configs", Flag="ConfigsList", Items={}, Multi=false, Default=nil,
        Callback=function(v) SelectedConfig=v end
    })
    ConfigsSection:Textbox({Name="Config Name",Flag="ConfigName",Default="",Placeholder="Name...",
        Callback=function(v) ConfigName=v end})
    ConfigsSection:Button({Name="Save Config", Callback=function()
        if ConfigName=="" then return end
        local p=Library.Folders.Configs.."/"..ConfigName..".json"
        if not isfile(p) then writefile(p,Library:GetConfig());
Library:RefreshConfigsList(ConfigsListbox)
        else Library:Notification("Already exists!",3,Color3.fromRGB(255,80,80)) end
    end}):SubButton({Name="Load Config", Callback=function()
        if SelectedConfig then Library:LoadConfig(readfile(Library.Folders.Configs.."/"..SelectedConfig)) end
    end})
    ConfigsSection:Button({Name="Delete Config", Callback=function()
        if SelectedConfig then Library:DeleteConfig(SelectedConfig); Library:RefreshConfigsList(ConfigsListbox) end
    end}):SubButton({Name="Refresh", Callback=function() Library:RefreshConfigsList(ConfigsListbox) end})
    Library:RefreshConfigsList(ConfigsListbox)
end

-- ──────────────────────────────────────────────
-- HOLD CACHE
-- ──────────────────────────────────────────────
local function buildHoldCache(notesFolder)
    local normalNotes, holdNotes = {}, {}
    for _, obj in pairs(notesFolder:GetChildren()) do
        if not obj:IsA("GuiObject") then continue end
        if obj.Name:sub(1,5) == "Hold_" then
            local num = tonumber(obj.Name:sub(6))
            if num then table.insert(holdNotes, {num=num, obj=obj}) end
        elseif tonumber(obj.Name) then
            table.insert(normalNotes, {num=tonumber(obj.Name), obj=obj})
        end
    end
    table.sort(normalNotes, function(a,b) return a.num<b.num end)
    table.sort(holdNotes,   function(a,b) return a.num<b.num end)
    for _, nd in pairs(normalNotes) do
        local noteY = nd.obj.AbsolutePosition.Y
        local closest, closestDist = nil, math.huge
        for _, hd in pairs(holdNotes) do
            local dist = math.abs(hd.obj.AbsolutePosition.Y - noteY)
            if dist < closestDist then closestDist=dist;
closest=hd.obj end
        end
        if closest and closestDist<=50 then holdCache[nd.obj]=closest end
    end
end

local function findHoldForNote(note, notesFolder)
    if holdCache[note] then return holdCache[note] end
    local noteY = note.AbsolutePosition.Y
    local closest, closestDist = nil, math.huge
    for _, obj in pairs(notesFolder:GetChildren()) do
        if obj.Name:sub(1,5)=="Hold_" and obj.Visible then
            local dist = math.abs(obj.AbsolutePosition.Y - noteY)
             if dist<closestDist then closestDist=dist; closest=obj end
        end
    end
    if closest and closestDist<=50 then return closest end
    return nil
end

local function pickRating()
    local pool = {}
    for _=1,perfectChance do table.insert(pool,"perfect") end
    for _=1,sickChance    do table.insert(pool,"sick")    end
    for _=1,goodChance    do table.insert(pool,"good")    end
    for _=1,okChance      do table.insert(pool,"ok")      end
    for _=1,badChance     do table.insert(pool,"bad")     end
    for _=1,missChance    do table.insert(pool,"miss")    end
    if #pool==0 then return "perfect" end
    return pool[math.random(1,#pool)]
end

local function handleNote(arrowIdx, note, notesFolder, arrowFolder)
    local key     = v4.KeyBinds[arrowIdx]
    local holdObj = findHoldForNote(note, notesFolder)
    local isHold  = holdObj ~= nil
    local lnHold  = arrowFolder:FindFirstChild("LnHold")

    if v7[arrowIdx] and not isHold then
        if missJacks then return end
        task.spawn(function()
            releaseKey(key);
task.wait(0.02)
            pressKey(key); task.wait(v4.TapDuration);
releaseKey(key)
        end)
        return
    end
    if v7[arrowIdx] then return end
    v7[arrowIdx] = true

    task.spawn(function()
        if maxReaction > 0 then
            local lo = math.min(minReaction, maxReaction)
            local hi = math.max(minReaction, maxReaction)
            task.wait((lo==hi and lo or math.random(lo,hi)) / 1000)
        end
        if pickRating()=="miss" then v7[arrowIdx]=nil; return end
        releaseKey(key); task.wait(); pressKey(key)
        if isHold then
            v7[arrowIdx]=nil; v6[holdObj]=true
            local released=false
            local function doRelease()
                if not released then
                    released=true; releaseKey(key); v6[note]=nil; v6[holdObj]=nil
                end
            end
            task.wait(0.05)
            local conn
            conn = v0.Heartbeat:Connect(function()
                if not lnHold then doRelease(); conn:Disconnect(); return end
                if lnHold.ImageTransparency>=0.9 then doRelease();
conn:Disconnect() end
            end)
        else
            task.wait(v4.TapDuration);
releaseKey(key); v7[arrowIdx]=nil
        end
    end)
end

local function getMyKeySync()
    local Match = v5.PlayerGui:FindFirstChild("Main")
        and v5.PlayerGui.Main:FindFirstChild("MatchFrame")
    if not (Match and Match.Visible) then return nil end
    local playerVal = v5:FindFirstChild("File") and v5.File:FindFirstChild("CurrentPlayer")
    if playerVal and playerVal.Value then
        local side = (playerVal.Value.Name=="Player2") and "KeySync2" or "KeySync1"
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
        for i=1,4 do
            local folder   = KeySync:FindFirstChild("Arrow"..i)
            local receptor = folder and folder:FindFirstChild("Arrow")
            local notes    = folder and folder:FindFirstChild("Notes")
            if receptor and notes then
                if not cacheBuilt[i] then
                    cacheBuilt[i]=true;
buildHoldCache(notes)
                    notes.ChildAdded:Connect(function(child)
                        if child:IsA("GuiObject") and child.Name:sub(1,5)~="Hold_" then
                            task.wait()
                            local noteY=child.AbsolutePosition.Y
                            local closest,closestDist=nil,math.huge
                            for _,obj in pairs(notes:GetChildren()) do
                                if obj.Name:sub(1,5)=="Hold_" and obj.Visible then
                                    local dist=math.abs(obj.AbsolutePosition.Y-noteY)
                             if dist<closestDist then closestDist=dist; closest=obj end
                                end
                            end
                            if closest and closestDist<=50 then holdCache[child]=closest end
                        end
                    end)
                end
                local targetY = receptor.AbsolutePosition.Y
                for _,note in pairs(notes:GetChildren()) do
                    if not note:IsA("GuiObject") or not note.Visible
                        or note.Name=="Arrow" or v6[note] then continue end
                    if note.Name:sub(1,5)=="Hold_" then continue end
                    if math.abs(note.AbsolutePosition.Y-targetY)<=v4.HitPixels then
                        v6[note]=true
                        handleNote(i,note,notes,folder)
                        note.AncestryChanged:Once(function() v6[note]=nil end)
                    end
                end
            end
        end
    end)
end
