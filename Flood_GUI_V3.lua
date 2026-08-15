--[[
    Flood GUI v3 - Refactored
    Description: Exploit GUI for Flood Escape 2 providing various cheats and utilities.
]]
getgenv().debugmode = false
-- // Services //
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui") -- Added for potential future use or better UI parent checking

-- // Constants & Configuration //
local CONFIG = {
    SCRIPT_VERSION_NAME = "Flood GUI v3",
    LATEST_BUILD = 65,
    DEFAULT_BRANCH = "main",
    UI_LIBRARY_URL = "https://raw.githubusercontent.com/tomatotxt/code/refs/heads/main/kavomobile.luau",
    TAS_BASE_URL = "https://raw.githubusercontent.com/tomatotxt/Testing/main/Flood-GUI-main/TAS%20FILES/",
    TAS_PLAYER_URL_FORMAT = "https://raw.githubusercontent.com/tomatotxt/Flood-GUI/refs/heads/testing/TAS/PLAYER/newtasplayer.luau", -- %s for branch
    DISCORD_INVITE = "https://discord.gg/8N2M9fHJqa",
    FILES_FOLDER = "Flood-GUI",
    TAS_SUBFOLDER = "TAS FILES",
    DEFAULT_WALKSPEED = 20,
    MAX_WALKSPEED = 100,
    DEFAULT_JUMPPOWER = 50,
    MAX_JUMPPOWER = 200,
    TOGGLE_UI_KEY = Enum.KeyCode.J,
    INFINITE_AIR_KEY = Enum.KeyCode.R,
    NOCLIP_KEY = Enum.KeyCode.G,
    AIR_JUMP_KEY = Enum.KeyCode.M,
    SWIM_TOGGLE_KEY = Enum.KeyCode.T,
    COLORS = {
        SchemeColor = Color3.fromRGB(180, 20, 30),   -- red accent (V4)
        Background = Color3.fromRGB(12, 12, 12),     -- near black
        Header = Color3.fromRGB(8, 8, 8),            -- deeper black
        TextColor = Color3.fromRGB(245, 245, 245),
        ElementColor = Color3.fromRGB(28, 28, 28)
    },
    ALERT_COLORS = {
        SUCCESS = Color3.fromRGB(200, 0, 25),
        ERROR = Color3.fromRGB(160, 0, 15),
        WARNING = Color3.fromRGB(190, 10, 20),
        INFO = Color3.fromRGB(200, 15, 30),
        WHITE = Color3.new(1, 1, 1),
        BEHIND = Color3.new(1, 0.1, 0.1),
        DEBUG = Color3.fromRGB(180, 0, 20),
        RAINBOW = "rainbow"
    }
}

-- // Local Player & Environment //
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players.LocalPlayerAdded:Wait()
    LocalPlayer = Players.LocalPlayer
end
local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5)
local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts") or LocalPlayer:WaitForChild("PlayerScripts", 5)
local Multiplayer = workspace:FindFirstChild("Multiplayer") or workspace:WaitForChild("Multiplayer", 5)

-- Accessing client environment safely
local ClientMainScriptEnv = nil
local ok, env = pcall(function() return getsenv(PlayerScripts:WaitForChild("CL_MAIN_GameScript")) end)
if ok then
    ClientMainScriptEnv = env
else
    warn("Flood GUI: Failed to get environment for CL_MAIN_GameScript.", r)
    -- Fallback or error handling if needed, maybe a custom alert function
end

-- // Script State //
-- Using a local table for state instead of getgenv() for most things
local State = {
    IsLoaded = false,       -- Prevent re-execution
    DebugMode = getgenv().debugmode or false, -- Allow external setting for debug
    Branch = ... == "string" and (...) or CONFIG.DEFAULT_BRANCH,
    Maps = {},
    HighlightOnlyMaps = {}, -- Maps found only in highlights, formerly 'whatthefuckisthisyoumayaskitisaverylongvariblename'
    WalkSpeed = CONFIG.DEFAULT_WALKSPEED,
    JumpPower = CONFIG.DEFAULT_JUMPPOWER,
    GodModeEnabled = false,
    NoclipEnabled = false,
    AirJumpEnabled = false,
    AutoPlayEnabled = false, -- Formerly 'play'
    AutoCollectEnabled = false,
    SwimEnabled = false,     -- For TAS recording hook
    AutoLeaveEnabled = false,
    UIEnabled = true,
    TASSpeed = 1,
    FE2Library = nil,       -- Store the loaded library
    RemoteKey = nil,        -- Store the remote key
    CurrentBuild = nil,
    KavoLibrary = nil,
    UI = {}                 -- Store references to UI elements if needed later
}
getgenv().State = function()
    return State
end
getgenv().FloodGUI_Loaded = false
-- Check if already executed
if getgenv().FloodGUI_Loaded then
    if ClientMainScriptEnv and ClientMainScriptEnv.newAlert then
        ClientMainScriptEnv.newAlert('Flood GUI Already Executed!', CONFIG.ALERT_COLORS.ERROR)
    else
        warn("Flood GUI Already Executed!") -- Fallback if alert unavailable
    end
    return -- Stop execution
end
getgenv().FloodGUI_Loaded = true -- Mark as loaded using getgenv for simplicity across executions

-- // Utility Functions //
local function showAlert(message, color, duration, specialEffect)
    if ClientMainScriptEnv and ClientMainScriptEnv.newAlert then
        pcall(ClientMainScriptEnv.newAlert, message, color, duration, specialEffect)
    else
        -- Simple fallback print/warn
		-- XENO Issue
        warn(("Flood GUI Alert: %s"):format(message))
    end
end

local function safeHttpGet(url)
    local success, result = pcall(game.HttpGet, game, url)
    if success then
        return result
    else
        warn("HTTP GET failed for:", url, "| Error:", result)
        return nil
    end
end

local function loadLibrary(url)
    local source = safeHttpGet(url)
    if source then
        local success, lib = pcall(loadstring(source))
        if success and type(lib) == "function" then
             local ok, result = pcall(lib)
             if ok then return result else warn("Error executing library:", result) end
        elseif type(lib) == "table" then
            return lib
        else
             warn("Failed to load library source or source is not a function. Error:", lib or "Unknown loadstring error")
        end
    end
    return nil
end

-- // Initialization Functions //
local function loadFE2Library()
    local success, library = pcall(function()
        return require(ReplicatedStorage:FindFirstChild("FE2Library", true))
    end)
    if success then
        State.FE2Library = library
        return true
    else
        showAlert("Exploit doesn't support REQUIRE function or FE2Library not found.", CONFIG.ALERT_COLORS.WHITE)
        warn("FE2Library require failed:", library)
        return false
    end
end

local function populateMaps()
    if not State.FE2Library then return end

    -- Get official maps
    local officialMaps = State.FE2Library.getOfficialMapData and State.FE2Library.getOfficialMapData() or {}
    for _, mapData in pairs(officialMaps) do
        if mapData.mapName and not table.find(State.Maps, mapData.mapName) then
            table.insert(State.Maps, mapData.mapName)
        end
    end

    -- Get maps from highlights (potentially unlisted/custom maps in rotation)
    local highlightsContainer = PlayerGui:FindFirstChild("MenuGui", true)
                              and PlayerGui.MenuGui:FindFirstChild("Goals", true)
                             and PlayerGui.MenuGui.Goals:FindFirstChild("Window", true)
                             and PlayerGui.MenuGui.Goals.Window:FindFirstChild("Content", true)
                             and PlayerGui.MenuGui.Goals.Window.Content:FindFirstChild("Pages", true)
                             and PlayerGui.MenuGui.Goals.Window.Content.Pages:FindFirstChild("Highlights", true)
                             and PlayerGui.MenuGui.Goals.Window.Content.Pages.Highlights:FindFirstChild("Maps", true)

    if highlightsContainer then
        for _, frame in pairs(highlightsContainer:GetChildren()) do
            if frame:IsA("Frame") and frame.Name == "HighlightFrame" and frame:FindFirstChild("MapName") then
                -- Use string.match for potentially more robust parsing
                local mapNameText = frame.MapName.Text
                local mapName = string.match(mapNameText, "%[(.+)%]") -- Matches text inside square brackets
                if mapName then
                    mapName = mapName:gsub("%s*$", "") -- Trim trailing whitespace if any
                    if not table.find(State.Maps, mapName) then
                        table.insert(State.Maps, mapName)
                        table.insert(State.HighlightOnlyMaps, mapName)
                        print("Found highlight-only map:", mapName)
                    end
                else
                     warn("Could not parse map name from highlight:", mapNameText)
                end
            end
        end
    else
        warn("Could not find Highlights map container in PlayerGui.")
    end
    table.sort(State.Maps) -- Keep the list sorted
    print("Total unique maps found:", #State.Maps)
end

local function checkBuildVersion()
    local configInstance = ReplicatedStorage:FindFirstChild("Config")
    if configInstance then
        State.CurrentBuild = tonumber(configInstance:GetAttribute("BuildVersion"))
        if State.CurrentBuild and CONFIG.LATEST_BUILD < State.CurrentBuild then
            local diff = State.CurrentBuild - CONFIG.LATEST_BUILD
            showAlert("Report all issues on the discord server!", CONFIG.ALERT_COLORS.BEHIND)
            showAlert(("%s is %f version(s) behind!"):format(CONFIG.SCRIPT_VERSION_NAME, diff), CONFIG.ALERT_COLORS.WARNING)
        else
             showAlert(("%s loaded successfully!"):format(CONFIG.SCRIPT_VERSION_NAME), CONFIG.ALERT_COLORS.SUCCESS)
        end
    else
        warn("Could not find ReplicatedStorage.Config to check build version.")
        showAlert("Could not verify build version.", CONFIG.ALERT_COLORS.WARNING)
    end
end

local function setupAntiIdle()
    if VirtualUser then
        LocalPlayer.Idled:Connect(function()
            pcall(function() -- Wrap in pcall in case of permission issues or errors
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end)
        print("Anti-Idle Initialized")
    else
        warn("VirtualUser service not available for Anti-Idle.")
    end
end

local function disableAntiExploit()
    -- Attempt to disable common anti-exploit scripts
    local antiExploitScripts = {
        "CL_AntiExploit",
        "FE2_AntiExploit", -- Add other potential names
        "ClientAntiCheat"
    }
    for _, scriptName in ipairs(antiExploitScripts) do
        local anti = game:FindFirstChild(scriptName, true)
        if anti then
            local success, err = pcall(function() anti.Disabled = true end)
            if success then
                print("Disabled AntiExploit:", scriptName)
            else
                warn("Failed to disable AntiExploit", scriptName, ":", err)
                -- Maybe try destroying it? Be cautious.
                -- pcall(function() anti:Destroy() end)
            end
        end
    end
end

local function getRemoteKey()
    local remote = ReplicatedStorage:FindFirstChild("Remote")
    local reqPasskey = remote and remote:FindFirstChild("ReqPasskey")
    if reqPasskey and reqPasskey:IsA("RemoteFunction") then
        local success, key = pcall(reqPasskey.InvokeServer, reqPasskey)
        if success then
            -- The original code negated the key, assuming it's intentional
            State.RemoteKey = -key
            print("Obtained Remote Key.")
        else
            warn("Failed to invoke ReqPasskey:", key)
            showAlert("Failed to obtain remote key.", CONFIG.ALERT_COLORS.ERROR)
        end
    else
        warn("Could not find Remote.ReqPasskey RemoteFunction.")
        showAlert("Could not find remote function for key.", CONFIG.ALERT_COLORS.ERROR)
    end
end

local function Touch(Character, Part)
    local RootPart = Character.HumanoidRootPart
    local OriginalCFrame = RootPart.CFrame
    RootPart.CFrame = CFrame.new(Part.Position)
    task.wait()
    RootPart.CFrame = OriginalCFrame
end

-- // Core Logic Functions //
local function updateMovement()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        -- Only set if the value actually differs to potentially reduce network traffic/overhead
        if hum.WalkSpeed ~= State.WalkSpeed then
            hum.WalkSpeed = State.WalkSpeed
        end
        if hum.JumpPower ~= State.JumpPower then
            hum.JumpPower = State.JumpPower
        end
    end
end

local function applyGodMode()
    if State.GodModeEnabled then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health < 100 then
            hum.Health = 100
            -- Optionally, could also manage MaxHealth if needed
            -- if hum.MaxHealth < 100 then hum.MaxHealth = 100 end
        end
        -- The original script commented out overriding 'takeAir'.
        -- This is safer as it doesn't modify game scripts directly.
        -- If 'takeAir' override is absolutely needed, it requires getsenv/setsenv or hooks.
    end
end

local function applyNoclip()
    local char = LocalPlayer.Character
    if not char then return end

    local partsToNoclip = {}
    local torso = char:FindFirstChild("Torso")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if torso then table.insert(partsToNoclip, torso) end
    if hrp then table.insert(partsToNoclip, hrp) end

    -- Find character parts that are BaseParts (handling potential variations)
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") and part ~= hrp and part ~= torso then
            -- Avoid double-adding, check if it's significant (e.g., has collision)
            if part.CanCollide and part.Mass > 0.1 then
                table.insert(partsToNoclip, part)
            end
        -- Handling the UnionOperation case specifically mentioned in the original code
        elseif part:IsA("UnionOperation") then
             table.insert(partsToNoclip, part)
        end
    end

    local shouldCollide = not State.NoclipEnabled -- If noclip is ON, collision should be OFF
    for _, part in ipairs(partsToNoclip) do
        -- Check if part still exists before modifying
        if part and part.Parent then
             part.CanCollide = shouldCollide
        end
    end
end

-- // UI Setup //
local StartBuiltInTASPlayer -- forward declare for UI buttons
local function initializeUI()
    State.KavoLibrary = loadLibrary(CONFIG.UI_LIBRARY_URL)
    if not State.KavoLibrary then
        showAlert("Failed to load Kavo UI Library!", CONFIG.ALERT_COLORS.ERROR)
        return
    end

    local Window = State.KavoLibrary.CreateLib(CONFIG.SCRIPT_VERSION_NAME, CONFIG.COLORS)
    State.UI.Window = Window -- Store reference if needed

    -- Create Tabs
    local tabAuto = Window:NewTab("Auto")
    local tabLocalPlayer = Window:NewTab("Local-Player")
    local tabBlatant = Window:NewTab("Blatant")
    local tabTAS = Window:NewTab("TAS")
    local tabOther = Window:NewTab("Other")
    local tabCredits = Window:NewTab("Credits")
    -- local tabStats = Window:NewTab("Stat Tracker") -- Uncomment if re-implementing stats

    -- Create Sections
    local secAuto = tabAuto:NewSection("Auto")
    local secLocalPlayer = tabLocalPlayer:NewSection("Local Player")
    local secBlatant = tabBlatant:NewSection("Blatant")
    local secTAS = tabTAS:NewSection("TAS")
    local secOther = tabOther:NewSection("Other")
    local secCredits = tabCredits:NewSection("Credits")
    -- local secStats = tabStats:NewSection("Stat Tracker") -- Uncomment if re-implementing stats

    -- == Auto Tab ==
    secAuto:NewToggle("Auto-Play [WIP]", "Requires downloaded TAS files. Currently EXPERIMENTAL.", function(enabled)
        State.AutoPlayEnabled = enabled
        if enabled then
             showAlert("Auto-Play Enabled (Experimental).", CONFIG.ALERT_COLORS.INFO)
             -- The loading loop will handle starting the player script
        else
             showAlert("Auto-Play Disabled.", CONFIG.ALERT_COLORS.INFO)
        end
        -- Consider loading the TAS player *here* once if the live-reload isn't strictly needed
        -- if enabled and not State.TasPlayerFunction then
        --     -- Load and store the function
        -- end
    end)
    State.AutoPlayEnabled = false -- Set initial state
    secAuto:NewToggle("Auto Collect (Page-Escapee)", "Collects LostPage and Escapee automatically.", function(enabled)
        State.AutoCollectEnabled = enabled
        if enabled then
             showAlert("Auto Collect Enabled", CONFIG.ALERT_COLORS.INFO)
        else
             showAlert("Auto Collect Disabled.", CONFIG.ALERT_COLORS.INFO)
        end
    end)
    State.AutoCollectEnabled = false

--[[
    secAuto:NewButton("Download TAS files", "Downloads required TAS files from GitHub.", function()
        local tasFolderPath = CONFIG.FILES_FOLDER .. "/" .. CONFIG.TAS_SUBFOLDER
        if getgenv().isfolder and not isfolder(tasFolderPath) then
            makefolder(tasFolderPath)
            print("Created TAS folder:", tasFolderPath)
        elseif not getgenv().isfolder then
             showAlert("File system operations (isfolder/makefolder) not supported by your exploit.", CONFIG.ALERT_COLORS.WARNING)
             -- Decide if download should proceed without folder check, maybe warn user?
        end

        if not getgenv().writefile or not getgenv().isfile then
             showAlert("File system operations (writefile/isfile) not supported.", CONFIG.ALERT_COLORS.ERROR)
             return
        end

        showAlert("Starting TAS file download...", CONFIG.ALERT_COLORS.INFO)
        task.spawn(function() -- Use task.spawn to avoid blocking UI
            local downloadedCount = 0
            local failedCount = 0
            for _, mapName in ipairs(State.Maps) do
                local encodedMapName = HttpService:UrlEncode(mapName)
                local filePath = tasFolderPath .. "/" .. mapName .. ".json"
                local url = CONFIG.TAS_BASE_URL .. encodedMapName .. ".json"

                if isfile(filePath) then
                    showAlert(mapName .. " TAS file already exists.", CONFIG.ALERT_COLORS.INFO, 2) -- Shorter duration
                else
                    local tasData = safeHttpGet(url)
                    if tasData and string.find(tasData, "CFrame", 1, true) then -- Check if it looks like a valid TAS file
                        local success, err = pcall(writefile, filePath, tasData)
                        if success then
                            showAlert("Downloaded " .. mapName .. " TAS.", CONFIG.ALERT_COLORS.SUCCESS, 2)
                            downloadedCount = downloadedCount + 1
                        else
                            showAlert("Failed to write " .. mapName .. " TAS file. Error: " .. tostring(err), CONFIG.ALERT_COLORS.ERROR)
                            failedCount = failedCount + 1
                        end
                    else
                        if tasData == nil then
                             showAlert("Failed to download " .. mapName .. " (Network Error).", CONFIG.ALERT_COLORS.ERROR)
                        else
                            showAlert("Failed to download " .. mapName .. " TAS (Invalid or Not Found Online).", CONFIG.ALERT_COLORS.ERROR)
                        end
                        failedCount = failedCount + 1
                    end
                end
                task.wait(0.1) -- Small delay between downloads
            end
            showAlert(("Finished downloading TAS files. Success: %d, Failed/Skipped: %d"):format(downloadedCount, failedCount + (#State.Maps - downloadedCount - failedCount)), CONFIG.ALERT_COLORS.INFO)
        end)
    end)
]]
    -- == Local Player Tab ==
    secLocalPlayer:NewSlider("Walkspeed", "Changes your movement speed.", CONFIG.MAX_WALKSPEED, CONFIG.DEFAULT_WALKSPEED, function(value)
        State.WalkSpeed = math.max(1, value) -- Ensure walkspeed is at least 1
    end)

    secLocalPlayer:NewSlider("JumpPower", "Changes your jump height.", CONFIG.MAX_JUMPPOWER, CONFIG.DEFAULT_JUMPPOWER, function(value)
        State.JumpPower = math.max(0, value) -- Ensure jumppower isn't negative
    end)
    -- == Blatant Tab ==
    secBlatant:NewKeybind("Infinite Air", "Prevents drowning / God Mode.", CONFIG.INFINITE_AIR_KEY, function()
        State.GodModeEnabled = not State.GodModeEnabled
        showAlert("Infinite Air " .. (State.GodModeEnabled and "Enabled" or "Disabled"), State.GodModeEnabled and CONFIG.ALERT_COLORS.SUCCESS or CONFIG.ALERT_COLORS.ERROR)
        -- Logic is handled in Heartbeat
    end)

    secBlatant:NewKeybind("Noclip", "Allows walking through walls.", CONFIG.NOCLIP_KEY, function()
        State.NoclipEnabled = not State.NoclipEnabled
        applyNoclip() -- Apply immediately
        showAlert("Noclip " .. (State.NoclipEnabled and "Enabled" or "Disabled"), State.NoclipEnabled and CONFIG.ALERT_COLORS.SUCCESS or CONFIG.ALERT_COLORS.ERROR)
    end)

    secBlatant:NewKeybind("Air Jump", "Allows jumping while mid-air.", CONFIG.AIR_JUMP_KEY, function()
        State.AirJumpEnabled = not State.AirJumpEnabled
        showAlert("Air Jump " .. (State.AirJumpEnabled and "Enabled" or "Disabled"), State.AirJumpEnabled and CONFIG.ALERT_COLORS.SUCCESS or CONFIG.ALERT_COLORS.ERROR)
        -- Logic is handled in UserInputService.InputBegan
    end)

    -- == TAS Tab ==
    secTAS:NewTextBox("TAS Speed (0.11-5)", "1=normal | 0.5=2x faster | 2=slower", function(txt)
        local n = tonumber(txt)
        if n then
            State.TASSpeed = math.clamp(n, 0.11, 5)
            getgenv().TASSpeed = State.TASSpeed
            showAlert("TAS Speed = " .. State.TASSpeed, CONFIG.ALERT_COLORS.SUCCESS)
        else
            showAlert("Invalid number", CONFIG.ALERT_COLORS.ERROR)
        end
    end)

    secTAS:NewButton("Force Start TAS", "Start built-in TAS Player now", function()
        getgenv().TAS_ManualStop = false
        getgenv().TASSpeed = State.TASSpeed
        task.spawn(function()
            local ok, err = pcall(StartBuiltInTASPlayer)
            if not ok then warn("TAS error:", err) end
        end)
    end)

    secTAS:NewButton("STOP TAS", "Stop the current TAS run", function()
        getgenv().TAS_ManualStop = true
        getgenv().IsTASPlaying = false
        getgenv().TASPaused = false
        if getgenv().TAS_RestoreAnim then pcall(getgenv().TAS_RestoreAnim) getgenv().TAS_RestoreAnim = nil end
        if getgenv().TASConnections then
            for _, c in pairs(getgenv().TASConnections) do pcall(function() c:Disconnect() end) end
            getgenv().TASConnections = {}
        end
        showAlert("TAS stopped", CONFIG.ALERT_COLORS.SUCCESS)
    end)

    secTAS:NewButton("Create TAS", "Create a TAS recording.", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tomatotxt/Flood-GUI/refs/heads/testing/TAS/CREATOR/creator.luau"))()
    end)

    secTAS:NewKeybind("Toggle Swim [TAS]", "For TAS recording. Simulates being in water.", CONFIG.SWIM_TOGGLE_KEY, function()
         State.SwimEnabled = not State.SwimEnabled
         showAlert("TAS Swim Mode " .. (State.SwimEnabled and "Enabled" or "Disabled"), CONFIG.ALERT_COLORS.INFO)
    end)

    secTAS:NewButton("Load Infinite Yield", "Loads Infinite Yield Admin Script", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
    end)

    -- == Other Tab ==
    secOther:NewKeybind("Toggle UI", "Toggles the GUI visibility.", CONFIG.TOGGLE_UI_KEY, function()
        State.UIEnabled = not State.UIEnabled
        if State.KavoLibrary and State.KavoLibrary.ToggleUI then
             State.KavoLibrary.ToggleUI()
             showAlert("UI " .. (State.UIEnabled and "Enabled" or "Disabled"), State.UIEnabled and CONFIG.ALERT_COLORS.INFO or CONFIG.ALERT_COLORS.INFO)
        else
             warn("Kavo Library ToggleUI function not available.")
        end
    end)

    secOther:NewToggle("Auto-Leave", "Automatically leaves the game if another player joins.", function(enabled)
        State.AutoLeaveEnabled = enabled
        showAlert("Auto-Leave " .. (enabled and "Enabled" or "Disabled"), enabled and CONFIG.ALERT_COLORS.INFO or CONFIG.ALERT_COLORS.INFO)
        -- Logic handled in Players.PlayerAdded
    end)
    State.AutoLeaveEnabled = false -- Set Initial Value
    secOther:NewButton("Rejoin Server", "Teleports you to a new server of the same game.", function()
        showAlert("Attempting to rejoin...", CONFIG.ALERT_COLORS.INFO)
        pcall(TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
        -- Consider adding error handling/feedback if Teleport fails
    end)


    -- == Credits Tab ==
    secCredits:NewLabel("TAS Record/Playback: Voiz#5668")
    secCredits:NewLabel("Reverse Engineering/Base GUI: Tomato")
    secCredits:NewLabel("Stat Tracker Concept & Misc: Moz") -- Added note about concept if not implemented
    secCredits:NewLabel("UI Library: xHeptc (Kavo)")
    secCredits:NewLabel("Refactoring & Improvements: AI")
    secCredits:NewLabel("Discord Invite")
    secCredits:NewButton("Copy Support Server Invite", "Copies the Discord invite link to your clipboard.", function()
        if setclipboard then
            pcall(setclipboard, CONFIG.DISCORD_INVITE)
            showAlert("Discord invite copied to clipboard!", CONFIG.ALERT_COLORS.SUCCESS)
        else
            showAlert("Clipboard access not supported by your exploit.", CONFIG.ALERT_COLORS.WARNING)
        end
    end)

    -- == Stat Tracker Section (Optional - Uncomment and integrate if needed) ==
    --[[
    local secStats = tabStats:NewSection("Stat Tracker")
    local statElements = {}

    local function setupStatTracker()
        local shop = PlayerGui:FindFirstChild("MenuGui", true) and PlayerGui.MenuGui:FindFirstChild("Shop", true)
        local goals = PlayerGui:FindFirstChild("MenuGui", true) and PlayerGui.MenuGui:FindFirstChild("Goals", true)

        local coinsAmount = shop and shop:FindFirstChild("Currencies", true) and shop.Currencies:FindFirstChild("Coins", true) and shop.Currencies.Coins:FindFirstChild("Amount", true)
        local gemsAmount = shop and shop:FindFirstChild("Currencies", true) and shop.Currencies:FindFirstChild("Gems", true) and shop.Currencies.Gems:FindFirstChild("Amount", true)
        local xpAmount = goals and goals:FindFirstChild("Window", true) --... path to xpEarned.Amount

        if not coinsAmount or not gemsAmount or not xpAmount then
            secStats:NewLabel("Stat Tracker Error: Could not find UI elements.")
            return
        end

        local initialValues = {
            Coins = tonumber(coinsAmount.Text) or 0,
            Gems = tonumber(gemsAmount.Text) or 0,
            XP = tonumber(xpAmount.Text) or 0,
            StartTime = os.time()
        }

        statElements.CoinsLabel = secStats:NewLabel("Coins Earned: 0")
        statElements.GemsLabel = secStats:NewLabel("Gems Earned: 0")
        statElements.XPLabel = secStats:NewLabel("XP Earned: 0")
        statElements.TimerLabel = secStats:NewLabel("Session Time: 00:00:00")

        local function updateStats()
            local currentCoins = tonumber(coinsAmount.Text) or initialValues.Coins
            local currentGems = tonumber(gemsAmount.Text) or initialValues.Gems
            local currentXP = tonumber(xpAmount.Text) or initialValues.XP

            statElements.CoinsLabel:UpdateLabel("Coins Earned: " .. (currentCoins - initialValues.Coins))
            statElements.GemsLabel:UpdateLabel("Gems Earned: " .. (currentGems - initialValues.Gems))
            statElements.XPLabel:UpdateLabel("XP Earned: " .. (currentXP - initialValues.XP))

            local elapsed = os.time() - initialValues.StartTime
            local hours = math.floor(elapsed / 3600)
            local minutes = math.floor((elapsed % 3600) / 60)
            local seconds = elapsed % 60
            statElements.TimerLabel:UpdateLabel(string.format("Session Time: %02d:%02d:%02d", hours, minutes, seconds))
        end

        -- Return the update function to be called periodically
        return updateStats
    end

    local updateStatsFunc = setupStatTracker()
    if updateStatsFunc then
        RunService.Heartbeat:Connect(function()
             if State.UIEnabled and updateStatsFunc then -- Only update if UI is visible and func exists
                 -- Add a throttle if Heartbeat is too frequent
                 -- local lastUpdate = lastUpdate or 0
                 -- if tick() - lastUpdate > 0.5 then -- Update every half second
                 --    updateStatsFunc()
                 --    lastUpdate = tick()
                 -- end
                 updateStatsFunc() -- Or update every heartbeat if performance allows
             end
        end)
    end
    ]]-- End Stat Tracker Section
end

-- // Event Handlers //
local function setupEventHandlers()
    -- Movement & God Mode Loop
    RunService.Heartbeat:Connect(function(deltaTime)
        pcall(function() -- Wrap in pcall for safety
             if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                 updateMovement()
                 applyGodMode()
             end
        end)
    end)

    -- Input Handling (Air Jump)
    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end -- Don't process if game handled it (e.g., typing in chat)

        if State.AirJumpEnabled and (input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.ButtonA) then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if hum and hrp and hum:GetState() == Enum.HumanoidStateType.Freefall then
                 -- Apply an upward velocity impulse for the jump
                 local currentVelocity = hrp.Velocity
                 hrp.Velocity = Vector3.new(currentVelocity.X, State.JumpPower * 0.8, currentVelocity.Z) -- Adjust multiplier as needed
            end
        end
    end)

    -- Auto Leave Handler
    Players.PlayerAdded:Connect(function(player)
        if State.AutoLeaveEnabled and player ~= LocalPlayer then
            showAlert(("Player '%s' joined. Auto-leaving as configured."):format(player.Name), CONFIG.ALERT_COLORS.WARNING)
            task.wait(0.5) -- Short delay before kicking
            pcall(LocalPlayer.Kick, LocalPlayer, "Flood GUI: Auto-Leave triggered by player joining.")
        end
    end)

    -- Hook for TAS Swim Mode (Requires hookmetamethod)
    if getgenv().hookmetamethod then
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, index)
            -- Check if we're indexing "Position" on a "HumanoidRootPart" AND Swim Mode is enabled
            -- Use 'tostring' check as it's common in these hooks, but be aware it can be spoofed.
            -- Added checkcaller() as in original script, assuming it's needed for exploit context.
            if State.SwimEnabled and index == "Position" and tostring(self) == "HumanoidRootPart" and not checkcaller() then
                -- Return a position known to be inside lobby water (adjust if needed)
                return Vector3.new(-23, -153, 0)
            end
            -- Otherwise, call the original __index metamethod
            return oldIndex(self, index)
        end)
        print("Swim mode hook initialized.")
    else
        warn("hookmetamethod not available. TAS Swim Toggle will not function.")
    end

end

-- // TAS Player Loop //


-- ==================== PAUSE SYSTEM (V4 black/red) ====================
local PauseButtonGui = nil

local function UpdatePauseButtonVisual(btn)
    if not btn then return end
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextColor3 = Color3.fromRGB(200, 0, 25)
    local stroke = btn:FindFirstChildOfClass("UIStroke")
    if stroke then stroke.Color = Color3.fromRGB(180, 0, 20) end
    btn.Text = getgenv().TASPaused and "PAUSED" or "PLAYING"
end

local function CreatePauseButton()
    if PauseButtonGui and PauseButtonGui.Parent then return end
    local parentGui = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5)
    if not parentGui then parentGui = game:GetService("CoreGui") end
    PauseButtonGui = Instance.new("ScreenGui")
    PauseButtonGui.Name = "TAS_PauseButton"
    PauseButtonGui.ResetOnSpawn = false
    PauseButtonGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() PauseButtonGui.Parent = parentGui end)
    if not PauseButtonGui.Parent then
        pcall(function() PauseButtonGui.Parent = game:GetService("CoreGui") end)
    end
    local Button = Instance.new("TextButton")
    Button.Name = "PauseBtn"
    Button.Size = UDim2.new(0, 100, 0, 50)
    Button.Position = UDim2.new(1, -120, 0.5, -25)
    Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Button.Text = "PLAYING"
    Button.TextColor3 = Color3.fromRGB(200, 0, 25)
    Button.TextSize = 16
    Button.Font = Enum.Font.GothamBold
    Button.Parent = PauseButtonGui
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 10)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(180, 0, 20)
    UIStroke.Thickness = 2
    UIStroke.Parent = Button
    Button.Activated:Connect(function()
        if not getgenv().IsTASPlaying then
            showAlert("TAS is not currently playing!", CONFIG.ALERT_COLORS.WARNING)
            return
        end
        getgenv().TASPaused = not getgenv().TASPaused
        UpdatePauseButtonVisual(Button)
        showAlert(getgenv().TASPaused and "TAS Paused" or "TAS Resumed",
            getgenv().TASPaused and CONFIG.ALERT_COLORS.WARNING or CONFIG.ALERT_COLORS.SUCCESS)
    end)
end

local function DestroyPauseButton()
    if PauseButtonGui then
        PauseButtonGui:Destroy()
        PauseButtonGui = nil
    end
    getgenv().TASPaused = false
end

local function TogglePauseManual()
    if not getgenv().IsTASPlaying then
        showAlert("TAS is not currently playing!", CONFIG.ALERT_COLORS.WARNING)
        return
    end
    getgenv().TASPaused = not getgenv().TASPaused
    if PauseButtonGui and PauseButtonGui:FindFirstChild("PauseBtn") then
        UpdatePauseButtonVisual(PauseButtonGui.PauseBtn)
    end
    showAlert(getgenv().TASPaused and "TAS Paused" or "TAS Resumed",
        getgenv().TASPaused and CONFIG.ALERT_COLORS.WARNING or CONFIG.ALERT_COLORS.SUCCESS)
end

local function AddTASConnection(conn)
    getgenv().TASConnections = getgenv().TASConnections or {}
    table.insert(getgenv().TASConnections, conn)
    return conn
end

local function Alert(msg, cat)
    local colors = CONFIG.ALERT_COLORS
    local map = { Success = colors.SUCCESS, Error = colors.ERROR, Warning = colors.WARNING, Info = colors.INFO, System = colors.INFO, Highlight = colors.INFO, Item = colors.INFO }
    showAlert(tostring(msg), map[cat] or colors.INFO)
end

StartBuiltInTASPlayer = function()
    if getgenv().IsTASPlaying then return end
    
    local TimeModifier = State.TASSpeed or 1
    local DynamicTimeScale = 1
    local SwimSmoothness = 0.04
    local PausedCFrame = nil

    getgenv().IsTASPlaying = true
    getgenv().TASPaused = false
    getgenv().TAS_ManualStop = false
    getgenv().TASCurrentMoveDir = Vector3.new(0,0,0)

    local NewV = Vector3.new
    local NewC = CFrame.new
    local AngC = CFrame.fromEulerAnglesXYZ
    local LP = LocalPlayer
    local Multi = Workspace:FindFirstChild('Multiplayer') or Workspace:WaitForChild('Multiplayer', 5)
    local RS = RunService

    local Theme = {
        System = Color3.fromRGB(180, 0, 20),
        Info = Color3.fromRGB(200, 15, 30),
        Success = Color3.fromRGB(200, 0, 25),
        Warning = Color3.fromRGB(190, 10, 20),
        Error = Color3.fromRGB(160, 0, 15),
        Highlight = Color3.fromRGB(220, 0, 30)
    }

    local function Log(msg, category)
        local color = Theme[category] or Theme.Info
        local text = "[TAS] " .. msg
        print(text)
        if ClientMainScriptEnv and type(ClientMainScriptEnv.newAlert) == "function" then
            ClientMainScriptEnv.newAlert(text, color)
        end
    end

    Log("Built-in TAS Player started!", "System")

    -- // MAP EVENT LISTENER (speedup / slowdown) — from official Tomato V65 //
    task.spawn(function()
        local PlayerGui = LP:WaitForChild("PlayerGui", 10)
        local GameGui = PlayerGui and PlayerGui:WaitForChild("GameGui", 10)
        local HUD = GameGui and GameGui:WaitForChild("HUD", 10)
        local MapEventInfo = HUD and HUD:WaitForChild("MapEventInfo", 10)

        if MapEventInfo then
            AddTASConnection(MapEventInfo:GetPropertyChangedSignal("Text"):Connect(function()
                local currentText = MapEventInfo.Text
                local Events = {}
                for rawEventName in string.gmatch(currentText, ">(.-)</font>") do
                    local formattedEventName = string.lower(rawEventName):gsub("%s+", "")
                    table.insert(Events, formattedEventName)
                end

                if #Events > 0 then
                    DynamicTimeScale = 1
                    for _, eventName in ipairs(Events) do
                        if eventName == "speedup" then
                            DynamicTimeScale = DynamicTimeScale * (1 / 1.1225)
                        elseif eventName == "slowdown" then
                            DynamicTimeScale = DynamicTimeScale * (1 / (1 - 0.1091))
                        end
                    end
                    local speedMultiplier = 1 / DynamicTimeScale
                    Log(string.format("Map event! Game speed adjusted to %.2fx", speedMultiplier), "Highlight")
                end
            end))
            Log("Map event listener ready (speedup/slowdown).", "Info")
        end
    end)

    -- Water detection
    local WaterParts = {}
    local function CacheWaterParts(MapFolder)
        WaterParts = {}
        local attempts = 0
        repeat
            for _, v in pairs(MapFolder:GetDescendants()) do
                if v:IsA("BasePart") and (string.find(v.Name, "_Water") or v.Parent.Name == "Waters") then
                    if not table.find(WaterParts, v) then
                        table.insert(WaterParts, v)
                    end
                end
            end
            if #WaterParts == 0 then 
                attempts = attempts + 1
                task.wait(0.5) 
            end
        until #WaterParts > 0 or attempts > 10
    end

    local function IsInWater(Position)
        for _, water in pairs(WaterParts) do
            local halfSize = water.Size * 0.5
            local objSpace = water.CFrame:PointToObjectSpace(Position)
            if math.abs(objSpace.Y) <= halfSize.Y and math.abs(objSpace.X) <= halfSize.X and math.abs(objSpace.Z) <= halfSize.Z then
                local waterState = water:FindFirstChild("WaterState")
                if not waterState or waterState:GetAttribute("NoSwim") ~= true then
                    return true
                end
            end
        end
        return false
    end

    -- Animation
    if not LP.Character or not LP.Character:FindFirstChild("Animate") then
        LP.CharacterAdded:Wait()
        LP.Character:WaitForChild("Animate", 10)
    end

    local Animate, OriginalPlayAnim
    local SuccessHook = pcall(function()
        local AnimateScript = LP.Character.Animate
        Animate = getsenv(AnimateScript)
        OriginalPlayAnim = Animate.playAnimation
        
        getgenv().TAS_RestoreAnim = function()
            if Animate and OriginalPlayAnim then
                Animate.playAnimation = OriginalPlayAnim
            end
        end
    end)

    if not SuccessHook or not Animate then
        Log("Warning: Could not connect to the game's animation system.", "Warning")
        Animate = { setAnimationSpeed = function() end, playAnimation = function() end }
        OriginalPlayAnim = function() end
    end

    local function toggleSlide(newValue)
        if not LP.Character then return end
        if newValue == true then
            if LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.Size = NewV(2, 1, 1) end
            if LP.Character:FindFirstChild("FE2_Hitbox") then LP.Character.FE2_Hitbox.Size = NewV(2, 1, 1) end
            if LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.HipHeight = -1.5 end
        else
            if LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.Size = NewV(2, 2, 1) end
            if LP.Character:FindFirstChild("FE2_Hitbox") then LP.Character.FE2_Hitbox.Size = NewV(2, 2, 1) end
            if LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.HipHeight = 0 end
        end
        if LP.Character and LP.Character:FindFirstChild("Animate") and LP.Character.Animate:FindFirstChild("Sliding") then
            LP.Character.Animate.Sliding:Fire(newValue)
        end
    end

    if not getgenv().TASHookApplied then
        getgenv().TASHookApplied = true
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, key)
            if getgenv().IsTASPlaying and key == "MoveDirection" then
                if self:IsA("Humanoid") and self.Parent == LP.Character then
                    return getgenv().TASCurrentMoveDir
                end
            end
            return oldIndex(self, key)
        end)
    end

    local LastPlayedAnim = nil
    local IsSliding = false
    local SlideStartTime = 0
    local LastSlideEndTime = -3.0
    local SLIDE_DEBOUNCE = 3.0
    local IsCurrentlySwimming = false
    local IsCurrentlyZiplining = false
    -- Manual key overrides (same as Tomato V65)
    local IsManualZipline = false
    local IsManualSlide = false

    local LiftCheckPos = Vector3.new(-25, -144, 139)
    local CleanedUp = false
    
    local function Cleanup(resetCharacter)
        if CleanedUp then return end
        CleanedUp = true
        getgenv().IsTASPlaying = false
        getgenv().TASPaused = false
        getgenv().TAS_Stop = nil
        
        IsSliding = false
        IsCurrentlyZiplining = false
        IsManualZipline = false
        IsManualSlide = false
        
        if getgenv().TASConnections then
            for _, connection in pairs(getgenv().TASConnections) do
                if connection then connection:Disconnect() end
            end
            getgenv().TASConnections = {}
        end

        if getgenv().TAS_RestoreAnim then
            pcall(getgenv().TAS_RestoreAnim)
            getgenv().TAS_RestoreAnim = nil
        end

        if LP.Character then
            if LP.Character:FindFirstChild("Animate") and LP.Character.Animate:FindFirstChild("ToggleSwim") then
                pcall(function() LP.Character.Animate.ToggleSwim:Fire(false) end)
            end
            if LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.AutoRotate = true end
            toggleSlide(false)
        end

        DestroyPauseButton()

        if resetCharacter and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            Log("You reset or died. Halting the run...", "Error")
            LP.Character.Humanoid.Health = 0
        end
    end

    getgenv().TAS_Stop = function()
        getgenv().TAS_ManualStop = true
        Cleanup(false)
        Log("TAS stopped manually.", "Warning")
    end

    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        AddTASConnection(LP.Character.Humanoid.Died:Connect(function() Cleanup(false) end))
    end
    AddTASConnection(LP.CharacterRemoving:Connect(function() Cleanup(false) end))

    -- Wait for map
    local Map = nil
    while not Map and not CleanedUp do
        local ConditionsMet = false
        Log("Waiting for you to step into the lift...", "Warning")
        
        repeat
            task.wait(0.2)
            local Root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if Root then
                local Dist = (Root.Position - LiftCheckPos).Magnitude
                if Dist <= 30 or Dist > 800 then ConditionsMet = true end
            end
        until ConditionsMet or CleanedUp
        
        if CleanedUp then return end
        Log("Lift entered! Waiting for the map to load.", "System")
        
        while ConditionsMet and not Map and not CleanedUp do
            task.wait(0.1)
            local FoundMap = Multi:FindFirstChild("NewMap")
            if FoundMap then 
                Map = FoundMap
                break 
            end
            
            local Root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if Root then
                local Dist = (Root.Position - LiftCheckPos).Magnitude
                if Dist > 30 and Dist < 800 then
                    Log("You left the lift! Pausing until you return.", "Warning")
                    ConditionsMet = false
                end
            end
        end
    end

    if CleanedUp or not Map then return end

    -- Load TAS
    local realMapName = Map:WaitForChild('Settings'):GetAttribute("MapName")
    local mapName = HttpService:UrlEncode(realMapName)

    local success, path
    if isfolder("Flood-GUI") and isfolder("Flood-GUI/TAS FILES") then
        local TargetTASPath = "Flood-GUI/TAS FILES/" .. realMapName .. ".json"
        if isfile(TargetTASPath) then path = readfile(TargetTASPath); success = true end
    end

    if not path then
        success, path = pcall(function()
            return game:HttpGet("https://raw.githubusercontent.com/tomatotxt/Flood-GUI/refs/heads/testing/TAS%20FILES/".. mapName .. ".json")
        end)
    end

    if not success or #path < 50 then
        Log("Oops! We don't have a TAS file for '".. realMapName .."'.", "Error")
        Cleanup(true)
        return
    end

    local TAS
    local DecodeSuccess = pcall(function() TAS = HttpService:JSONDecode(path) end)
    if not TAS or not DecodeSuccess then
        Log("Uh oh, the TAS file for this map seems corrupted.", "Error")
        Cleanup(true)
        return
    end

    local OriginalFrameCount = #TAS
    Log("Loaded run for " .. realMapName .. " (" .. OriginalFrameCount .. " frames).", "Info")
    repeat task.wait() until Map.Name == "Map" or CleanedUp
    if CleanedUp then return end

    local SpawnPoint = nil
    for _,v in ipairs(Map:GetChildren()) do
        if v.Name == "Part" then
            local c; c = v:GetPropertyChangedSignal("Rotation"):Connect(function() c:Disconnect(); SpawnPoint = v end)
        end
    end

    local t = 0
    repeat task.wait(0.1); t=t+0.1; if not SpawnPoint then SpawnPoint = Map:FindFirstChild("Spawn", true) end
    until SpawnPoint or t > 10 or CleanedUp

    if not SpawnPoint then Log("Hmm, couldn't find where to spawn on this map.", "Error") Cleanup(true) return end

    CacheWaterParts(Map)

    for _, v in next, Map:GetDescendants() do
        if v.Name == 'ButtonIcon' then
            pcall(function()
                local p = v.Parent.Parent:FindFirstChildOfClass('Part')
                if p then p.Size = NewV(7, 7, 7) p.Transparency = 1 end
            end)
        end
    end
    Log("Map buttons and elements processed.", "Success")

    task.wait(0.1)
    Log("Starting the run! Press P or use the button to pause.", "Success")
    CreatePauseButton()

    local RootPart = LP.Character:WaitForChild("HumanoidRootPart", 10)
    local Humanoid = LP.Character:WaitForChild("Humanoid", 10)

    while (RootPart.Anchored == true) or (Humanoid.WalkSpeed <= 0) do
        if CleanedUp then return end
        task.wait()
    end

    local DelayedMaps = {
        ["Abandoned Harbour"] = true,
        ["Wildwood Waterways"] = true,
        ["Minds of Misery"] = true,
    }
    local MapStartDelay = 0
    if DelayedMaps[realMapName] then
        MapStartDelay = 0.8
        Log("Map delay active: waiting 0.7s before playback...", "Warning")
        task.wait(0.7)
    end

    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.AutoRotate = false
    end

    Animate.playAnimation = function() end

    -- 1:1 Tomato V65 activateAnimation (zipline/swing + slide)
    local function activateAnimation(AnimData, Elapsed)
        local character = LP.Character
        if not character or not character.Parent then return end
        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChild("Humanoid")
        if not head or not humanoid or not RootPart then return end

        local n = AnimData and AnimData[1] or nil
        local animTime = AnimData and AnimData[2] or 0.1
        Elapsed = Elapsed or 0

        local checkSubmerged = IsInWater(RootPart.Position + Vector3.new(0, 1, 0))

        local gameSpeedMultiplier = TimeModifier * DynamicTimeScale
        local nativeSlideDuration = 0.5 / gameSpeedMultiplier

        -- MANUAL KEY OVERRIDES (Z = Zipline/Swing, S = Slide)
        if IsManualZipline then
            n = "zipline"
            IsCurrentlyZiplining = true
            if IsSliding then
                toggleSlide(false)
                IsSliding = false
            end
        elseif IsManualSlide then
            n = "slide"
            IsSliding = true
        end

        -- Zipline/Swing Priority — keep TAS name (zipline OR swing), do not force-rename
        if n == "zipline" or n == "swing" then
            IsCurrentlyZiplining = true
            if IsSliding then
                toggleSlide(false)
                IsSliding = false
                LastSlideEndTime = Elapsed
            end
        end

        -- Exit zipline only when grounded AND this frame is not still zipline/swing
        if humanoid.FloorMaterial ~= Enum.Material.Air and not IsManualZipline then
            if n ~= "zipline" and n ~= "swing" then
                IsCurrentlyZiplining = false
            end
        end

        -- 1. SLIDE LOCK (nativeSlideDuration, unless Zipline or Manual Slide)
        if IsSliding then
            if not IsManualSlide and (Elapsed - SlideStartTime >= nativeSlideDuration) then
                toggleSlide(false)
                IsSliding = false
                LastSlideEndTime = Elapsed
                if checkSubmerged then
                    IsCurrentlySwimming = true
                    if character.Animate:FindFirstChild("ToggleSwim") then
                        pcall(function() character.Animate.ToggleSwim:Fire(true) end)
                    end
                    if RootPart.Velocity.Magnitude > 1.5 then n = "swim" else n = "swimidle" end
                else
                    IsCurrentlySwimming = false
                    if character.Animate:FindFirstChild("ToggleSwim") then
                        pcall(function() character.Animate.ToggleSwim:Fire(false) end)
                    end
                    if humanoid.FloorMaterial == Enum.Material.Air then
                        n = "fall"
                    elseif RootPart.Velocity.Magnitude > 1 then
                        n = "walk"
                    else
                        n = "idle"
                    end
                end
            else
                n = "slide"
            end
        else
            -- 2. NORMAL STATES (when not sliding)
            if checkSubmerged then
                IsCurrentlySwimming = true
                if RootPart.Velocity.Magnitude > 1.5 then n = "swim" else n = "swimidle" end
                if character.Animate:FindFirstChild("ToggleSwim") then
                    pcall(function() character.Animate.ToggleSwim:Fire(true) end)
                end
            else
                IsCurrentlySwimming = false
                if character.Animate:FindFirstChild("ToggleSwim") then
                    pcall(function() character.Animate.ToggleSwim:Fire(false) end)
                end

                if not IsCurrentlyZiplining then
                    if n == "slide" then
                        local absYVel = math.abs(RootPart.Velocity.Y)
                        if IsManualSlide or (Elapsed - LastSlideEndTime >= SLIDE_DEBOUNCE and absYVel <= 3 and humanoid.FloorMaterial ~= Enum.Material.Air) then
                            toggleSlide(true)
                            IsSliding = true
                            SlideStartTime = Elapsed
                            n = "slide"
                        else
                            if humanoid.FloorMaterial == Enum.Material.Air then
                                n = "fall"
                            elseif RootPart.Velocity.Magnitude > 1 then
                                n = "walk"
                            else
                                n = "idle"
                            end
                        end
                    end
                end

                if not AnimData and not IsSliding and not IsManualZipline and not IsManualSlide then
                    return
                end

                if not IsSliding and not IsCurrentlyZiplining then
                    if humanoid:GetState() == Enum.HumanoidStateType.Physics then n = "swing" end
                    if n == "idle" or not n then
                        if RootPart.Velocity.Magnitude > 1 then
                            if humanoid.FloorMaterial ~= Enum.Material.Air then n = "walk" else n = "fall" end
                        else
                            n = "idle"
                        end
                    end
                    if n == "fall" and RootPart.Velocity.Magnitude < 0.1 then n = "swing" end
                end
            end
        end

        if n and (n ~= LastPlayedAnim) then
            Animate.playAnimation = function() end
            -- FE2 accepts both "zipline" and "swing"; try recorded name, fallback the other
            pcall(function()
                OriginalPlayAnim(n, animTime, humanoid)
                if n == "zipline" then
                    -- some FE2 builds only register swing
                    pcall(OriginalPlayAnim, "swing", animTime, humanoid)
                elseif n == "swing" then
                    pcall(OriginalPlayAnim, "zipline", animTime, humanoid)
                end
            end)
            if n == "walk" then pcall(function() Animate.setAnimationSpeed(.76) end) end
            LastPlayedAnim = n
        end
    end

    local Offset = SpawnPoint.Position - NewV(0, 1000, 0)
    local OldFrame = 3
    local RenderedFrames = 0
    local FinishedRun = false
    local SmoothSwimDirection = nil
    local VisualElapsed = 0
    local LastClock = os.clock()

    -- // AUTO SYNC (HUD timer) — pause-aware; DISABLED while custom speed //
    local LastSyncTime = os.clock()
    local SyncInterval = 3
    local SyncThreshold = 0.05
    local PausedGameTimeAccum = 0
    local PauseTimerAnchor = nil
    local SyncResumeGraceUntil = 0
    local AutoSyncEnabled = true -- flipped off permanently if custom speed is used
    local AutoSyncDisabledLogged = false

    local function GetGameTimer()
        local ok, result = pcall(function()
            return LP.PlayerGui.GameGui.HUD.Main.GameStats.Ingame.Info.Time.Current.Count.Text
        end)
        if not ok or not result then return nil end
        local min, sec = tostring(result):match("(%d+):(%d+%.%d+)")
        if min and sec then
            return tonumber(min) * 60 + tonumber(sec)
        end
        min, sec = tostring(result):match("(%d+):(%d+)")
        if min and sec then
            return tonumber(min) * 60 + tonumber(sec)
        end
        return nil
    end

    local function IsCustomSpeedActive()
        local s = tonumber(State.TASSpeed) or 1
        local t = tonumber(TimeModifier) or 1
        return math.abs(s - 1) > 0.001 or math.abs(t - 1) > 0.001
    end

    local function TrySync()
        if not AutoSyncEnabled then return end
        if getgenv().TASPaused then return end
        if os.clock() < SyncResumeGraceUntil then return end

        -- Custom speed must never be overwritten by HUD timer
        if IsCustomSpeedActive() then
            AutoSyncEnabled = false
            if not AutoSyncDisabledLogged then
                AutoSyncDisabledLogged = true
                Log("Auto-sync OFF (custom TAS speed active)", "Warning")
            end
            return
        end

        -- Map event timescale active → don't fight it
        if math.abs((DynamicTimeScale or 1) - 1) > 0.02 then return end

        local gameTimer = GetGameTimer()
        if not gameTimer or gameTimer < 0.15 then return end

        local adjustedTimer = gameTimer - MapStartDelay - PausedGameTimeAccum
        if adjustedTimer < 0 then adjustedTimer = 0 end

        local drift = VisualElapsed - adjustedTimer
        if math.abs(drift) > SyncThreshold then
            VisualElapsed = VisualElapsed - drift
            if VisualElapsed < 0 then VisualElapsed = 0 end
            Log(string.format("Auto-sync: corrected %.3fs drift.", drift), "Warning")
        end
    end

    -- MAIN LOOP WITH PAUSE
    local MainLoop
    MainLoop = RS.Heartbeat:Connect(function()
        if not RootPart or not RootPart.Parent or not Humanoid or not Humanoid.Parent or CleanedUp then 
            if MainLoop then MainLoop:Disconnect() end
            if not CleanedUp then
                Log("Player removed from game. Halting the run.", "Warning")
                Cleanup(false) 
            end
            return 
        end

        -- PAUSE HANDLING
        if getgenv().TASPaused then
            if not PausedCFrame then
                PausedCFrame = RootPart.CFrame
                -- Anchor HUD timer so pause doesn't count as TAS drift
                PauseTimerAnchor = GetGameTimer()
                IsCurrentlyZiplining = false
                IsSliding = false
                toggleSlide(false)
                LastPlayedAnim = "idle"
                pcall(function()
                    OriginalPlayAnim("idle", 0.1, Humanoid)
                end)
            end
            -- Stay completely still
            RootPart.CFrame = PausedCFrame
            RootPart.Velocity = Vector3.zero
            RootPart.AssemblyLinearVelocity = Vector3.zero
            RootPart.AssemblyAngularVelocity = Vector3.zero
            RootPart.RotVelocity = Vector3.zero
            getgenv().TASCurrentMoveDir = Vector3.zero
            LastClock = os.clock()
            return
        else
            if PausedCFrame then
                -- Account for HUD time that passed while paused (prevents teleport on unpause)
                local nowTimer = GetGameTimer()
                if PauseTimerAnchor and nowTimer then
                    local pausedAmount = nowTimer - PauseTimerAnchor
                    if pausedAmount > 0 then
                        PausedGameTimeAccum = PausedGameTimeAccum + pausedAmount
                    end
                end
                PauseTimerAnchor = nil
                SyncResumeGraceUntil = os.clock() + 1.5 -- no sync for 1.5s after resume

                IsCurrentlyZiplining = false
                IsSliding = false
                IsCurrentlySwimming = false
                LastPlayedAnim = nil
                Humanoid.PlatformStand = false
                Humanoid:ChangeState(Enum.HumanoidStateType.Running)
                toggleSlide(false)
                pcall(function()
                    if LP.Character and LP.Character:FindFirstChild("Animate") and LP.Character.Animate:FindFirstChild("ToggleSwim") then
                        LP.Character.Animate.ToggleSwim:Fire(false)
                    end
                    OriginalPlayAnim("walk", 0.1, Humanoid)
                    if Animate and Animate.setAnimationSpeed then
                        Animate.setAnimationSpeed(0.76)
                    end
                    LastPlayedAnim = "walk"
                end)
            end
            PausedCFrame = nil
        end

        -- Live speed update from GUI textbox
        TimeModifier = State.TASSpeed or 1
        
        RenderedFrames = RenderedFrames + 1
        
        local CurrentClock = os.clock()
        local Delta = CurrentClock - LastClock
        LastClock = CurrentClock
        
        VisualElapsed = VisualElapsed + (Delta * (1 / (TimeModifier * DynamicTimeScale)))

        -- Auto-sync to in-game HUD timer every few seconds
        if os.clock() - LastSyncTime >= SyncInterval then
            LastSyncTime = os.clock()
            TrySync()
        end
        
        local liveWeld = RootPart:FindFirstChild("WalljumpWeld_Live")
        if liveWeld then liveWeld:Destroy() end
        local serverWeld = RootPart:FindFirstChild("WalljumpWeld_Server")
        if serverWeld then serverWeld:Destroy() end

        
        while OldFrame < #TAS and TAS[OldFrame + 1].time <= VisualElapsed do OldFrame = OldFrame + 1 end
        
        if OldFrame >= #TAS then
            if not FinishedRun then
                FinishedRun = true
                Log("Run completed successfully! Awesome.", "Success")
                if getgenv().TAS_RestoreAnim then 
                    pcall(getgenv().TAS_RestoreAnim)
                    getgenv().TAS_RestoreAnim = nil
                end
                pcall(function() OriginalPlayAnim("idle", 0.1, Humanoid) end)
                Cleanup(false) 
            end
            return
        end

        local FA = TAS[OldFrame]
        local FB = TAS[OldFrame + 1] or FA
        
        local Dur = FB.time - FA.time
        local Alpha = (Dur > 0) and math.clamp((VisualElapsed - FA.time) / Dur, 0, 1) or 0

        local cfA = NewC(FA.CCFrame[1], FA.CCFrame[2], FA.CCFrame[3]) * AngC(FA.CCFrame[4], FA.CCFrame[5], FA.CCFrame[6])
        local cfB = NewC(FB.CCFrame[1], FB.CCFrame[2], FB.CCFrame[3]) * AngC(FB.CCFrame[4], FB.CCFrame[5], FB.CCFrame[6])
        
        local vA = NewV(FA.VVelocity[1], FA.VVelocity[2], FA.VVelocity[3])
        local vB = NewV(FB.VVelocity[1], FB.VVelocity[2], FB.VVelocity[3])

        local TargetVelocity = vA:Lerp(vB, Alpha)
        getgenv().TASCurrentMoveDir = TargetVelocity.Magnitude > 0 and TargetVelocity.Unit or Vector3.zero

        local TargetCFrame = cfA:Lerp(cfB, Alpha) + Offset
        
        local OverrideToSlide = false
        local startPos = TargetCFrame.Position + Vector3.new(0, 1.5, 0)
        local direction = Vector3.new(0, -4.5, 0)
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = { LP.Character }
        
        local result = workspace:Raycast(startPos, direction, raycastParams)
        if result then
            local hitY = result.Position.Y
            local gap = TargetCFrame.Position.Y - hitY
            
            if gap < 1.7 and Humanoid.FloorMaterial ~= Enum.Material.Air then
                if TargetVelocity.Y <= 3 then
                    OverrideToSlide = true
                end
            end
        end

        if IsCurrentlySwimming and TargetVelocity.Magnitude > 0.5 then
            if not SmoothSwimDirection then
                SmoothSwimDirection = TargetVelocity.Unit
            else
                SmoothSwimDirection = SmoothSwimDirection:Lerp(TargetVelocity.Unit, SwimSmoothness).Unit
            end
            RootPart.CFrame = NewC(TargetCFrame.Position, TargetCFrame.Position + SmoothSwimDirection)
        else
            SmoothSwimDirection = nil
            RootPart.CFrame = TargetCFrame
        end
        
        RootPart.Velocity = TargetVelocity

        local AnimData = FA.AAnimation
        -- V65: block heuristic slide if ziplining or anim is zipline/swing
        if OverrideToSlide and not IsCurrentlyZiplining and (not AnimData or (AnimData[1] ~= "zipline" and AnimData[1] ~= "swing")) then
            AnimData = { "slide", 0.1 }
        end

        pcall(activateAnimation, AnimData, VisualElapsed)
    end)
    AddTASConnection(MainLoop)
end



local function runTASPlayerLoop()
    task.spawn(function()
        while task.wait(1) do
            if State.AutoPlayEnabled then
                local isRunning = getgenv().IsTASPlaying
                    or (getgenv().TASConnections and #getgenv().TASConnections > 0)
                if not isRunning and not getgenv().TAS_ManualStop then
                    print("Flood GUI: Starting built-in TAS Player (v65)...")
                    getgenv().TASSpeed = State.TASSpeed
                    task.spawn(function()
                        local ok, err = pcall(StartBuiltInTASPlayer)
                        if not ok then
                            warn("TAS Player error:", err)
                            getgenv().IsTASPlaying = false
                        end
                    end)
                    task.wait(3)
                end
            end
        end
    end)
end

local function runAutoCollectLoop()
    task.spawn(function()
        while task.wait() do
            local Map = Multiplayer:WaitForChild("NewMap")
            Map:GetPropertyChangedSignal("Name"):Wait()
            
            -- FIX: Check if the toggle is enabled
            if State.AutoCollectEnabled then
                print("Map Loaded! V2")
                local Character = LocalPlayer.Character
                local Rescue = Map:FindFirstChild("_Rescue", true)
                local LostPage = Map:FindFirstChild("_LostPage", true)
                if Rescue then
                    Touch(Character, Rescue.Contact)
                    print("Got Escapee.")
                end
                if LostPage then
                    Touch(Character, LostPage)
                    print("Got Lost Page.")
                end
            end
        end
    end)
end

-- // Main Execution //
local function main()
    print("Initializing Flood GUI...")

    if not loadFE2Library() then
        showAlert("FE2Library failed to load. Some features (like map list) may be unavailable.", CONFIG.ALERT_COLORS.WARNING)
        -- Decide whether to continue execution or halt
    end

    populateMaps()
    checkBuildVersion()
    setupAntiIdle()
    disableAntiExploit()
    getRemoteKey()

    initializeUI() -- Setup the GUI
    setupEventHandlers() -- Connect event listeners

    -- Start the TAS player loading loop (only if AutoPlay is intended to work this way)
    runTASPlayerLoop()
    -- Start the Auto Collect loop.
    runAutoCollectLoop()

    State.IsLoaded = true
    print("Flood GUI Initialized.")
	print(State.Branch)
    if State.DebugMode then
        showAlert(CONFIG.SCRIPT_VERSION_NAME .. " loaded in Debug Mode!", CONFIG.ALERT_COLORS.DEBUG)
    else
        showAlert(CONFIG.SCRIPT_VERSION_NAME .. " Initialized!", nil, nil, CONFIG.ALERT_COLORS.RAINBOW)
    end
end

-- Run the main function safely
local success, err = pcall(main)
if not success then
    warn("FATAL ERROR during Flood GUI initialization:", err)
    showAlert("Flood GUI failed to initialize!", CONFIG.ALERT_COLORS.ERROR)
    getgenv().FloodGUI_Loaded = false -- Allow re-execution attempt if it failed critically
end
