-- geometry dash 2.2 module picker v1
-- only decompiles the 23 game modules I still need (physics, collision, level data) (the game is a Lua engine in ReplicatedStorage.GDPort). takes about a minute, no need to be in a level.
-- files land in <executor workspace>/gamedump: bundle_<stamp>_N.txt (upload ALL of them), _index_<stamp>.txt and _log_<stamp>.txt

local CFG = {
    DECOMPILE   = true,
    RUNTIME     = false,
    FOLDER      = "gamedump",
    MAX_SCRIPTS = 300,
    EXTRA_ALSO  = 0,
    MAX_BYTES   = 5000000,
    BUNDLE_SIZE = 450000,
    PER_SCRIPT  = 40,
    TIME_BUDGET = 600,
    GC_BUDGET   = 10,
    BULK        = 1000000,
    COPIES      = 1000000,
    ORPHANS     = false,
    SAMPLE_SECONDS = 8,
    SKIP = {},
    ALSO = {},
    ONLY = {
        "ReplicatedStorage.GDPort.Player",
        "ReplicatedStorage.GDPort.PhysicsFamily",
        "ReplicatedStorage.GDPort.Seam_Physics",
        "ReplicatedStorage.GDPort.LogicRuntime",
        "ReplicatedStorage.GDPort.LogicStore",
        "ReplicatedStorage.GDPort.LogicFamily",
        "ReplicatedStorage.GDPort.LogicCollision",
        "ReplicatedStorage.GDPort.LogicEvents",
        "ReplicatedStorage.GDPort.CollisionPass",
        "ReplicatedStorage.GDPort.GameplayRules",
        "ReplicatedStorage.GDPort.GameLayer",
        "ReplicatedStorage.GDPort.ObjectMotion",
        "ReplicatedStorage.GDPort.GroupMotion",
        "ReplicatedStorage.GDPort.AreaEffects",
        "ReplicatedStorage.GDPort.Seam_Lifecycle",
        "ReplicatedStorage.GDPort.Seam_Logic",
        "ReplicatedStorage.GDPort.Simulation",
        "ReplicatedStorage.GDPort.LevelData",
        "ReplicatedStorage.GDPort.Checkpoints",
        "ReplicatedStorage.GDPort.AutoCheckpoints",
        "ReplicatedStorage.GDPort.LevelProgress",
        "ReplicatedStorage.GDPort.TwoPlayerInput",
        "ReplicatedStorage.GDPort.HackRules"
    },
}

local T0    = tick()
local STAMP = tostring(os.time())
local LOG   = {}

local function notify(text)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title = "dumper", Text = tostring(text), Duration = 4}) end)
end

local function say(msg, loud)
    msg = tostring(msg)
    LOG[#LOG + 1] = string.format("[%5.1fs] %s", tick() - T0, msg)
    pcall(print, "[dump] " .. msg)
    if loud then pcall(warn, "[dump] " .. msg) end
    pcall(function() writefile(CFG.FOLDER .. "/_log_" .. STAMP .. ".txt", table.concat(LOG, "\n") .. "\n") end)
end

local function writeOut(name, text)
    local ok, err = pcall(function()
        if makefolder and isfolder and not isfolder(CFG.FOLDER) then makefolder(CFG.FOLDER) end
        writefile(CFG.FOLDER .. "/" .. name, text)
    end)
    if not ok then say("could not write " .. name .. ": " .. tostring(err), true) end
    return ok
end

local function finish(why)
    pcall(setclipboard, table.concat(LOG, "\n"))
    notify(why)
end

-- step 0: prove the script runs and files can be written, before anything heavy happens
local okW = writeOut("_started_" .. STAMP .. ".txt", "gd module picker 2 started\n")
say("gd module picker 2 is running. executor: " .. tostring((identifyexecutor and identifyexecutor()) or "?") .. " | file write test: " .. (okW and "ok" or "FAILED"), true)
notify(okW and "dumper running, files ok" or "dumper running, but files can't be written")

-- the real work lives in a string so a compile error shows up as a message instead of nothing at all
local CORE = [==[
local S = ...
local CFG = S.CFG
local say, notify, writeOut, STAMP = S.say, S.notify, S.writeOut, S.stamp
local Players    = game:GetService("Players")
local UIS        = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CAS        = game:GetService("ContextActionService")
local RepS       = game:GetService("ReplicatedStorage")
local lp         = Players.LocalPlayer

local function low(s) return string.lower(tostring(s)) end
local function try(f, ...)
    local ok, a, b, c = pcall(f, ...)
    if ok then return a, b, c end
    return nil
end

-- keeps the game from freezing while the loops run
local lastY = tick()
local function yieldNow()
    if tick() - lastY > 0.03 then task.wait(); lastY = tick() end
end

-- ---- live functions (getgc) ----
-- every function the game has loaded knows which script it lives in. that is how hidden modules
-- (no parent, garbled name) get their real path, and how the gameplay function names get listed
local STRONG = {"hit", "judg", "note", "score", "combo", "miss", "accura", "press", "release", "lane", "track", "receptor", "rating", "perfect", "health", "spawn", "key", "input", "hold", "result", "grade", "beat", "autoplay", "chart", "song", "timing", "offset", "early", "late", "step", "render"}
local function strongName(n)
    local l = low(n)
    for _, k in ipairs(STRONG) do
        if l:find(k, 1, true) then return true end
    end
    return false
end

local GC = {labels = {}, perSrc = {}, named = {}, size = 0, scanned = 0}
local function scanGC()
    if not getgc then GC.note = "no getgc"; return end
    local t0 = tick()
    local gc = getgc()
    GC.size = #gc
    for i = 1, #gc do
        local f = gc[i]
        if type(f) == "function" then
            local ok, src, line, name = pcall(debug.info, f, "sln")
            if ok and type(src) == "string" and src:find(".", 1, true) and src:sub(1, 1) ~= "[" then
                GC.scanned = GC.scanned + 1
                GC.perSrc[src] = (GC.perSrc[src] or 0) + 1
                local eok, env = pcall(getfenv, f)
                if eok and type(env) == "table" then
                    local sok, s = pcall(rawget, env, "script")
                    if sok and typeof(s) == "Instance" and GC.labels[s] == nil then GC.labels[s] = src end
                end
                if type(name) == "string" and name ~= "" and strongName(name) then
                    local key = name .. "|" .. src .. "|" .. tostring(line)
                    local e = GC.named[key]
                    if e then e.n = e.n + 1 else GC.named[key] = {n = 1, name = name, src = src, line = line} end
                end
            end
        end
        if i % 2500 == 0 then task.wait() end
        if tick() - t0 > CFG.GC_BUDGET then GC.cut = i; break end
    end
    gc = nil
end

-- ---- every script, ranked ----
local PATHKW = {{"player", 4}, {"control", 4}, {"physic", 5}, {"move", 3}, {"level", 3}, {"game", 3}, {"main", 3}, {"input", 3}, {"jump", 4}, {"gamemode", 5}, {"mode", 2}, {"hitbox", 4}, {"collision", 4}, {"spike", 3}, {"obstacle", 3}, {"portal", 3}, {"orb", 3}, {"pad", 2}, {"speed", 3}, {"camera", 2}, {"death", 3}, {"die", 2}, {"dead", 2}, {"checkpoint", 2}, {"attempt", 2}, {"percent", 2}, {"complete", 3}, {"respawn", 2}, {"manager", 2}, {"handler", 2}, {"client", 2}, {"core", 2}, {"engine", 3}, {"remote", 2}, {"character", 3}, {"ship", 2}, {"wave", 2}, {"ball", 2}, {"ufo", 2}, {"robot", 2}, {"spider", 2}, {"swing", 2}, {"gravity", 4}, {"velocity", 3}}
local BCKW = {{"Gravity", 2}, {"Velocity", 2}, {"Jump", 2}, {"Spike", 2}, {"Portal", 2}, {"Orb", 2}, {"Pad", 1}, {"Hitbox", 2}, {"Touched", 1.5}, {"Raycast", 1.5}, {"InputBegan", 1.5}, {"InputEnded", 1}, {"IsKeyDown", 1.5}, {"MouseButton1", 1}, {"Touch", 1}, {"Heartbeat", 1}, {"RenderStepped", 1}, {"Stepped", 1}, {"BindToRenderStep", 1.5}, {"CFrame", 1}, {"AssemblyLinearVelocity", 2}, {"LinearVelocity", 2}, {"BodyVelocity", 2}, {"VectorForce", 1.5}, {"Die", 1.5}, {"Dead", 1}, {"Respawn", 1.5}, {"Checkpoint", 1.5}, {"Level", 1}, {"Attempt", 1.5}, {"Percent", 1.5}, {"Complete", 1.5}, {"Speed", 1}, {"Gamemode", 2}, {"Ship", 1}, {"Wave", 1}, {"Cube", 1}, {"UFO", 1}, {"Robot", 1}, {"Spider", 1}, {"Swing", 1}, {"FireServer", 1.5}, {"InvokeServer", 1.5}, {"Humanoid", 1}}
local ROBLOX_NAMES = {PlayerModule = true, ControlModule = true, CameraModule = true, BaseCharacterController = true, RbxCharacterSounds = true, ChatScript = true, BubbleChat = true, Animate = true, ChatMain = true}

local function onlyMatch(path)
    local l = low((path:gsub("%s+<hidden module>$", "")))
    for _, n in ipairs(CFG.ONLY) do
        if l == low(n) then return true end
    end
    return false
end

local function matches(path, list)
    local l = low(path)
    for _, p in ipairs(list) do
        if l:find(low(p), 1, true) then return p end
    end
end

local function collectScripts()
    local set, list = {}, {}
    local function add(s)
        if typeof(s) ~= "Instance" or set[s] then return end
        if s:IsA("LocalScript") or s:IsA("ModuleScript") or s:IsA("Script") then
            set[s] = true
            list[#list + 1] = s
        end
    end
    if getscripts then for _, s in ipairs(try(getscripts) or {}) do add(s) end end
    if getloadedmodules then for _, s in ipairs(try(getloadedmodules) or {}) do add(s) end end
    if CFG.ORPHANS and getnilinstances then for _, s in ipairs(try(getnilinstances) or {}) do add(s) end end
    if not getscripts then
        for _, s in ipairs(game:GetDescendants()) do add(s); yieldNow() end
    end
    return list
end

local function describe(s)
    if s.Parent == nil then
        local lab = GC.labels[s]
        return (lab or ("(no parent) " .. s.Name)) .. "  <hidden module>", true, lab
    end
    local ok, fn = pcall(s.GetFullName, s)
    return ok and fn or s.Name, false, nil
end

local function tailOf(path)
    local a, b = path:match("([^.]+)%.([^.]+)$")
    if a then return low(a .. " " .. b) end
    return low(path)
end

-- groups skipped scripts by folder so the index shows "800 skipped under ReplicatedStorage.Songs", not 800 lines
local function groupOf(path)
    local parts = {}
    for seg in path:gmatch("[^.]+") do parts[#parts + 1] = seg end
    table.remove(parts)
    local keep = (parts[1] == "Players") and 4 or 2
    local k = {}
    for i = 1, math.min(keep, #parts) do k[i] = parts[i] end
    return #k > 0 and table.concat(k, ".") or path
end

local RANK = {list = {}, skipped = {}, skippedN = 0, bulk = {}, total = 0}
local function rankScripts()
    local all = collectScripts()
    RANK.total = #all
    local recs, byParent = {}, {}
    local function skip(why, path)
        local k = why .. ": " .. groupOf(path)
        RANK.skipped[k] = (RANK.skipped[k] or 0) + 1
        RANK.skippedN = RANK.skippedN + 1
    end
    -- pass A: roblox's own stuff and the SKIP list
    for _, s in ipairs(all) do
        local path, hidden, lab = describe(s)
        if s:IsA("Script") and not (s:IsA("LocalScript") or s:IsA("ModuleScript")) and s.RunContext ~= Enum.RunContext.Client then
            skip("server script", path)
        elseif ROBLOX_NAMES[s.Name] or matches(path, {"CoreGui", "CorePackages", "RobloxGui"}) then
            skip("roblox", path)
        elseif CFG.ONLY and not onlyMatch(path) then
            skip("not in the ONLY list", path)
        elseif matches(path, CFG.SKIP) then
            skip("skip list", path)
        else
            local parentPath = "(nil)"
            if hidden then
                parentPath = (lab or ""):match("^(.*)%.[^.]+$") or "(nil)"
            else
                local pr = s.Parent
                local okp, pp = pcall(pr.GetFullName, pr)
                parentPath = okp and pp or "(nil)"
            end
            local rec = {inst = s, class = s.ClassName, path = path, hidden = hidden, parentPath = parentPath, also = matches(path, CFG.ALSO)}
            recs[#recs + 1] = rec
            byParent[parentPath] = (byParent[parentPath] or 0) + 1
        end
        yieldNow()
    end
    -- pass B: bulk folders (songs, skins, charts) only get 2 samples
    local seenInBulk, kept = {}, {}
    for _, r in ipairs(recs) do
        if byParent[r.parentPath] > CFG.BULK and not r.hidden then
            seenInBulk[r.parentPath] = (seenInBulk[r.parentPath] or 0) + 1
            if seenInBulk[r.parentPath] <= 2 then
                kept[#kept + 1] = r
            else
                skip("bulk folder", r.path)
            end
        else
            kept[#kept + 1] = r
        end
    end
    for p, n in pairs(byParent) do
        if n > CFG.BULK then RANK.bulk[#RANK.bulk + 1] = {path = p, n = n} end
    end
    -- pass C: size + a look at the bytecode strings for gameplay words, copies collapse
    local copies, final = {}, {}
    local tb = tick()
    for _, r in ipairs(kept) do
        local bc = (getscriptbytecode and tick() - tb < 60) and try(getscriptbytecode, r.inst) or nil
        r.bytes = type(bc) == "string" and #bc or nil
        local score = 0
        local kw = 0
        if type(bc) == "string" and #bc < 250000 then
            for _, k in ipairs(BCKW) do
                if bc:find(k[1], 1, true) then kw = kw + k[2] end
            end
        end
        local t = tailOf(r.path)
        for _, k in ipairs(PATHKW) do
            if t:find(k[1], 1, true) then score = score + k[2] end
        end
        score = score + math.min(kw, 22) * 0.9 + 2.2 * math.log10((r.bytes or 500) + 1)
        if r.class == "LocalScript" then score = score + 1 elseif r.class == "ModuleScript" then score = score + 0.5 end
        if r.hidden then score = score + 3 end
        if r.also then score = score + 5 end
        r.score = score
        local key = r.class .. "|" .. r.inst.Name .. "|" .. tostring(r.bytes)
        copies[key] = (copies[key] or 0) + 1
        if copies[key] > CFG.COPIES and not r.hidden then
            skip("copies", r.path)
        else
            final[#final + 1] = r
        end
        bc = nil
        yieldNow()
    end
    table.sort(final, function(a, b)
        if a.score ~= b.score then return a.score > b.score end
        return a.path < b.path
    end)
    RANK.list = final
end

-- ---- index file ----
local function writeIndex()
    local L = {}
    local executed = (identifyexecutor and try(identifyexecutor)) or "?"
    L[#L + 1] = string.format("place %s | %d scripts ranked (best first), roblox's own stuff left out, %d more skipped | executor %s", tostring(game.PlaceId), #RANK.list, RANK.skippedN, tostring(executed))
    for i, r in ipairs(RANK.list) do
        L[#L + 1] = string.format("%3d | score %5.1f | %-12s | %7s bytes | %s%s", i, r.score, r.class, tostring(r.bytes or "?"), r.path, r.status and ("  [" .. r.status .. "]") or "")
    end
    L[#L + 1] = ""
    L[#L + 1] = "== bulk folders (only 2 scripts sampled each) =="
    table.sort(RANK.bulk, function(a, b) return a.n > b.n end)
    for i, b in ipairs(RANK.bulk) do
        if i > 40 then break end
        L[#L + 1] = string.format("%5d scripts | %s", b.n, b.path)
    end
    L[#L + 1] = ""
    L[#L + 1] = "== skipped, grouped (reason: path start) =="
    local sk = {}
    for k, n in pairs(RANK.skipped) do sk[#sk + 1] = {k = k, n = n} end
    table.sort(sk, function(a, b) return a.n > b.n end)
    for i, e in ipairs(sk) do
        if i > 60 then break end
        L[#L + 1] = string.format("%5d | %s", e.n, e.k)
    end
    writeOut("_index_" .. STAMP .. ".txt", table.concat(L, "\n") .. "\n")
end

-- ---- runtime file ----
local R = {}
local function line(s) R[#R + 1] = s end
local function section(title, fn)
    line("")
    line("== " .. title .. " ==")
    local ok, err = pcall(fn)
    if not ok then line("(section failed: " .. tostring(err) .. ")") end
end

local function propStr(o)
    local p = {}
    if o:IsA("ScreenGui") then
        p[#p + 1] = "enabled=" .. tostring(o.Enabled)
    elseif o:IsA("GuiObject") then
        p[#p + 1] = "vis=" .. tostring(o.Visible)
        p[#p + 1] = "pos=" .. tostring(o.Position) .. " size=" .. tostring(o.Size)
        if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
            local t = tostring(o.Text):gsub("[\r\n]", " ")
            if #t > 40 then t = t:sub(1, 40) .. "..." end
            if t ~= "" then p[#p + 1] = 'text="' .. t .. '"' end
        end
    elseif o:IsA("ValueBase") then
        p[#p + 1] = "value=" .. tostring(o.Value)
    elseif o:IsA("LuaSourceContainer") then
        p[#p + 1] = "(script)"
    end
    local at = try(o.GetAttributes, o)
    if type(at) == "table" then
        local a = {}
        for k, v in pairs(at) do
            if #a < 6 then a[#a + 1] = tostring(k) .. "=" .. tostring(v) end
        end
        if #a > 0 then p[#p + 1] = "attrs{" .. table.concat(a, ",") .. "}" end
    end
    return table.concat(p, " ")
end

-- many same-class kids (skins, songs, ui templates) fold into a count so one folder cant eat the file
local function tree(root, maxDepth, maxLines)
    local count = 0
    local function walk(o, depth)
        if count >= maxLines then return end
        local pad = string.rep("  ", depth)
        local kids = o:GetChildren()
        local extra = (depth >= maxDepth and #kids > 0) and (" (+" .. #kids .. " children)") or ""
        line(pad .. o.Name .. " [" .. o.ClassName .. "] " .. propStr(o) .. extra)
        count = count + 1
        if depth >= maxDepth then return end
        local seen, printed = {}, {}
        for _, k in ipairs(kids) do seen[k.ClassName] = (seen[k.ClassName] or 0) + 1 end
        for _, k in ipairs(kids) do
            local cls = k.ClassName
            printed[cls] = (printed[cls] or 0) + 1
            if seen[cls] > 12 and printed[cls] > 3 then
                if printed[cls] == 4 then line(pad .. "  ... +" .. (seen[cls] - 3) .. " more " .. cls) end
            else
                walk(k, depth + 1)
            end
        end
        yieldNow()
    end
    walk(root, 0)
    if count >= maxLines then line("(tree cut at " .. maxLines .. " lines)") end
end

local function fnLine(f)
    local ok, src, ln, nm = pcall(debug.info, f, "sln")
    if not ok then return "?" end
    return tostring(src) .. ":" .. tostring(ln) .. " " .. tostring(nm or "")
end

-- walks a tree without building one giant table (workspace and replicatedstorage can have 100k+ objects)
local function walkNodes(root, maxNodes, fn)
    local stack, n = {root}, 0
    while #stack > 0 and n < maxNodes do
        local o = table.remove(stack)
        n = n + 1
        fn(o)
        local kids = try(o.GetChildren, o)
        if kids then
            for i = #kids, 1, -1 do stack[#stack + 1] = kids[i] end
        end
        yieldNow()
    end
    return n
end

local function flushRuntime()
    writeOut("_runtime_" .. STAMP .. ".txt", table.concat(R, "\n") .. "\n")
end

local function runtimeA()

    section("executor and game", function()
        local name = "?"
        local info = try(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId) end)
        if type(info) == "table" then name = tostring(info.Name) end
        line("executor: " .. tostring((identifyexecutor and try(identifyexecutor)) or "?"))
        line("place " .. tostring(game.PlaceId) .. " | game " .. tostring(game.GameId) .. " | " .. name)
        line("touch/keyboard/gamepad: " .. tostring(UIS.TouchEnabled) .. "/" .. tostring(UIS.KeyboardEnabled) .. "/" .. tostring(UIS.GamepadEnabled))
        local caps = {{"firesignal", firesignal}, {"getconnections", getconnections}, {"getsenv", getsenv}, {"getgc", getgc}, {"getrenv", getrenv}, {"getgenv", getgenv}, {"getfenv", getfenv}, {"hookfunction", hookfunction}, {"hookmetamethod", hookmetamethod}, {"newcclosure", newcclosure}, {"checkcaller", checkcaller}, {"debug.getupvalues", debug and debug.getupvalues}, {"debug.getconstants", debug and debug.getconstants}, {"debug.getproto", debug and debug.getproto}, {"getscriptbytecode", getscriptbytecode}, {"decompile", decompile}, {"getscripts", getscripts}, {"getloadedmodules", getloadedmodules}, {"getnilinstances", getnilinstances}, {"getinstances", getinstances}, {"setclipboard", setclipboard}, {"writefile", writefile}, {"appendfile", appendfile}, {"makefolder", makefolder}, {"isfolder", isfolder}, {"request", request}, {"queue_on_teleport", queue_on_teleport}}
        local has = {}
        for _, c in ipairs(caps) do has[#has + 1] = c[1] .. "=" .. (c[2] and type(c[2]) or "no") end
        line("has: " .. table.concat(has, " "))
        line("scripts found: " .. RANK.total .. " | ranked: " .. #RANK.list .. " | skipped: " .. RANK.skippedN)
    end)

    section("playergui (screen guis, 6 levels deep)", function()
        for _, g in ipairs(lp.PlayerGui:GetChildren()) do tree(g, 6, 1400) end
    end)

    section("replicatedstorage (4 levels deep)", function()
        tree(RepS, 4, 1400)
    end)

    section("replicatedfirst, starterplayer, local player (3 levels deep)", function()
        for _, n in ipairs({"ReplicatedFirst", "StarterPlayer", "StarterGui"}) do
            local s = try(game.GetService, game, n)
            if s then tree(s, 3, 250) end
        end
        line("-- local player: " .. lp.Name .. " (" .. tostring(lp.UserId) .. ")")
        tree(lp, 2, 120)
    end)

    section("remotes and bindables (replicatedstorage, replicatedfirst, playergui, local player, workspace top level)", function()
        local n = 0
        local function check(o)
            if o:IsA("RemoteEvent") or o:IsA("RemoteFunction") or o:IsA("BindableEvent") or o:IsA("BindableFunction") or o:IsA("UnreliableRemoteEvent") then
                n = n + 1
                if n <= 400 then line(o.ClassName .. ": " .. o:GetFullName()) end
            end
        end
        local function scan(root, deep)
            if deep then
                walkNodes(root, 40000, check)
            else
                for _, o in ipairs(try(root.GetChildren, root) or {}) do check(o) end
            end
        end
        scan(RepS, true)
        scan(game:GetService("ReplicatedFirst"), true)
        scan(lp.PlayerGui, true)
        scan(lp, true)
        scan(workspace, false)
        if n > 400 then line("(+" .. (n - 400) .. " more)") end
    end)

    section("listeners (getconnections)", function()
        if not getconnections then line("no getconnections"); return end
        local evs = {{"UIS.InputBegan", UIS.InputBegan}, {"UIS.InputEnded", UIS.InputEnded}, {"UIS.InputChanged", UIS.InputChanged}, {"RunService.RenderStepped", RunService.RenderStepped}, {"RunService.Heartbeat", RunService.Heartbeat}, {"RunService.Stepped", RunService.Stepped}}
        for _, e in ipairs(evs) do
            local conns = try(getconnections, e[2]) or {}
            local withFn = {}
            for _, c in ipairs(conns) do
                local f = try(function() return c.Function end)
                if type(f) == "function" then withFn[#withFn + 1] = f end
            end
            line(e[1] .. ": count " .. #conns .. " | lua functions " .. #withFn .. " | no lua function (core scripts / other vm) " .. (#conns - #withFn))
            for i, f in ipairs(withFn) do
                if i > 25 then line("  ..."); break end
                line("  " .. fnLine(f))
            end
        end
    end)

    section("bound actions (ContextActionService)", function()
        local info = try(CAS.GetAllBoundActionInfo, CAS)
        local names = {}
        for k, v in pairs(info or {}) do
            local ins = {}
            for _, i in ipairs(type(v) == "table" and v.inputTypes or {}) do ins[#ins + 1] = tostring(i) end
            names[#names + 1] = tostring(k) .. " (prio " .. tostring(type(v) == "table" and v.priority or "?") .. (#ins > 0 and (" | " .. table.concat(ins, ",")) or "") .. ")"
        end
        table.sort(names)
        line(#names > 0 and table.concat(names, ", ") or "none")
    end)

    section("the game's _G and shared (names only)", function()
        for _, t in ipairs({{"_G", _G}, {"shared", shared}}) do
            local n = 0
            for k, v in pairs(type(t[2]) == "table" and t[2] or {}) do
                n = n + 1
                if n <= 120 then line(t[1] .. "." .. tostring(k) .. " : " .. type(v) .. (type(v) ~= "table" and type(v) ~= "function" and (" = " .. tostring(v)) or "")) end
            end
            if n == 0 then line(t[1] .. ": empty") end
        end
    end)

    section("workspace (top level, and anything named like note / track / lane)", function()
        for i, c in ipairs(workspace:GetChildren()) do
            if i > 150 then line("..."); break end
            line(c.Name .. " [" .. c.ClassName .. "]")
        end
        line("-- name hits:")
        local hits = 0
        local seen = walkNodes(workspace, 20000, function(o)
            local l = low(o.Name)
            if l:find("note", 1, true) or l:find("track", 1, true) or l:find("lane", 1, true) or l:find("receptor", 1, true) or l:find("arrow", 1, true) then
                hits = hits + 1
                if hits <= 80 then line(o:GetFullName() .. " [" .. o.ClassName .. "]") end
            end
        end)
        line("(looked at " .. seen .. " objects)")
    end)

    flushRuntime()
end

local function runtimeGC()

    section("gc: scripts that own live functions, and gameplay-ish function names", function()
        line("gc size: " .. GC.size .. " | game functions: " .. GC.scanned .. (GC.cut and (" | scan cut at " .. GC.cut) or "") .. (GC.note and (" | " .. GC.note) or ""))
        local srcs = {}
        for s, n in pairs(GC.perSrc) do srcs[#srcs + 1] = {s = s, n = n} end
        table.sort(srcs, function(a, b) return a.n > b.n end)
        line("-- live functions per script (top 120)")
        for i, e in ipairs(srcs) do
            if i > 120 then break end
            line(string.format("%5d | %s", e.n, e.s))
        end
        local named = {}
        for _, e in pairs(GC.named) do named[#named + 1] = e end
        table.sort(named, function(a, b)
            if a.src ~= b.src then return a.src < b.src end
            return (a.line or 0) < (b.line or 0)
        end)
        line("-- gameplay-ish names (x count | name | script | line), top 700")
        for i, e in ipairs(named) do
            if i > 700 then break end
            line("x" .. e.n .. " " .. e.name .. "|" .. e.src .. "|" .. tostring(e.line))
        end
    end)

    flushRuntime()
end

local function runtimeC()

    section("global functions of the top 15 ranked scripts (getsenv)", function()
        if not getsenv then line("no getsenv"); return end
        for i = 1, math.min(15, #RANK.list) do
            local r = RANK.list[i]
            local env = try(getsenv, r.inst)
            local names = {}
            for k, v in pairs(type(env) == "table" and env or {}) do
                if type(v) == "function" then names[#names + 1] = tostring(k) end
            end
            table.sort(names)
            line(r.path .. ": " .. (#names > 0 and table.concat(names, ", ") or "(no global functions)"))
        end
    end)

    section("api of the loaded modules that have no parent (require gives back the same table the game uses)", function()
        if not getloadedmodules then line("no getloadedmodules"); return end
        local n = 0
        for _, m in ipairs(try(getloadedmodules) or {}) do
            if m.Parent == nil then
                n = n + 1
                if n > 150 then break end
                local ok, t = pcall(require, m)
                local keys = {}
                if ok and type(t) == "table" then
                    for k, v in pairs(t) do
                        if #keys < 40 then keys[#keys + 1] = tostring(k) .. ":" .. (type(v) == "function" and "fun" or type(v) == "table" and "tab" or type(v)) end
                    end
                    table.sort(keys)
                end
                line((GC.labels[m] or ("(no parent) " .. m.Name)) .. "  <hidden module> -> " .. (ok and (type(t) == "table" and table.concat(keys, " ") or type(t)) or "require failed"))
            end
            yieldNow()
        end
    end)

    flushRuntime()
end

-- ---- geometry dash recon: the level, the camera and the player ----
-- everything a physics clone needs to know: how levels are built (part names, sizes, attributes,
-- tags), what the player is, and how it actually moves frame by frame while you play
local function r2(x) return math.floor(x * 100 + 0.5) / 100 end
local function v3s(v) return r2(v.X) .. "," .. r2(v.Y) .. "," .. r2(v.Z) end
local function normName(n) return (tostring(n):gsub("%d+", "#")) end

local function partRow(o)
    local ok, row = pcall(function()
        local rx, ry, rz = o.CFrame:ToEulerAnglesXYZ()
        local hex = try(function() return o.Color:ToHex() end) or "?"
        local mat = try(function() return o.Material.Name end) or "?"
        local a = {}
        local at = try(o.GetAttributes, o)
        if type(at) == "table" then
            for k, v in pairs(at) do
                if #a < 8 then a[#a + 1] = tostring(k) .. "=" .. tostring(v) end
            end
        end
        local tg = try(function() return game:GetService("CollectionService"):GetTags(o) end) or {}
        return table.concat({
            o:GetFullName(), o.ClassName, v3s(o.Position), v3s(o.Size),
            r2(math.deg(rx)) .. "," .. r2(math.deg(ry)) .. "," .. r2(math.deg(rz)),
            hex, mat, tostring(o.CanCollide), tostring(o.CanTouch), tostring(o.CanQuery), tostring(o.Anchored), tostring(r2(o.Transparency)),
            table.concat(a, ";"), table.concat(tg, ";"),
        }, "|")
    end)
    return ok and row or ("(row failed) " .. tostring(o.Name))
end

local function runtimeGD()
    local CS = game:GetService("CollectionService")
    local cam = workspace.CurrentCamera

    section("physics settings and camera", function()
        line("workspace.Gravity " .. tostring(workspace.Gravity) .. " | PhysicsSteppingMethod " .. tostring(try(function() return workspace.PhysicsSteppingMethod end)) .. " | FallenPartsDestroyHeight " .. tostring(try(function() return workspace.FallenPartsDestroyHeight end)) .. " | StreamingEnabled " .. tostring(try(function() return workspace.StreamingEnabled end)))
        if cam then
            line("camera: type " .. tostring(cam.CameraType) .. " | fov " .. tostring(cam.FieldOfView) .. " | cframe " .. tostring(cam.CFrame) .. " | subject " .. tostring(cam.CameraSubject))
        end
        local at = try(workspace.GetAttributes, workspace)
        local a = {}
        for k, v in pairs(type(at) == "table" and at or {}) do a[#a + 1] = tostring(k) .. "=" .. tostring(v) end
        line("workspace attributes: " .. (#a > 0 and table.concat(a, " ") or "none"))
    end)

    section("workspace tree (4 levels, folded)", function() tree(workspace, 4, 900) end)

    section("collectionservice tags", function()
        local tags = try(CS.GetAllTags, CS) or {}
        table.sort(tags)
        for i, tag in ipairs(tags) do
            if i > 150 then line("..."); break end
            local inst = try(CS.GetTagged, CS, tag) or {}
            local ex = {}
            for k = 1, math.min(3, #inst) do ex[#ex + 1] = inst[k]:GetFullName() end
            line(tag .. " x" .. #inst .. " | " .. table.concat(ex, " ; "))
        end
        if #tags == 0 then line("no tags") end
    end)

    section("local player: character, state, attributes", function()
        local ch = lp.Character
        line("character: " .. tostring(ch and ch:GetFullName()) .. " | player " .. lp.Name .. " (" .. tostring(lp.UserId) .. ")")
        if ch then
            tree(ch, 3, 120)
            local hum = ch:FindFirstChildOfClass("Humanoid")
            local root = ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart
            if hum then
                line("humanoid: walkspeed " .. tostring(hum.WalkSpeed) .. " jumppower " .. tostring(hum.JumpPower) .. " jumpheight " .. tostring(hum.JumpHeight) .. " hipheight " .. tostring(hum.HipHeight) .. " usejumppower " .. tostring(hum.UseJumpPower) .. " state " .. tostring(hum:GetState()) .. " platformstand " .. tostring(hum.PlatformStand))
            end
            if root then
                line("root: pos " .. tostring(root.Position) .. " vel " .. tostring(root.AssemblyLinearVelocity) .. " anchored " .. tostring(root.Anchored) .. " size " .. tostring(root.Size) .. " mass " .. tostring(root.AssemblyMass))
            end
        end
        local at = try(lp.GetAttributes, lp)
        local a = {}
        for k, v in pairs(type(at) == "table" and at or {}) do a[#a + 1] = tostring(k) .. "=" .. tostring(v) end
        line("player attributes: " .. (#a > 0 and table.concat(a, " ") or "none"))
        local ls = lp:FindFirstChild("leaderstats")
        if ls then
            local v = {}
            for _, c in ipairs(ls:GetChildren()) do v[#v + 1] = c.Name .. "=" .. tostring(c.Value) end
            line("leaderstats: " .. table.concat(v, " "))
        end
    end)

    section("level parts (counts by name | class | size | color, top 150) + a sample file", function()
        local groups, order, total = {}, {}, 0
        local lo, hi
        local containers = {}
        local seen = walkNodes(workspace, 80000, function(o)
            if o:IsA("BasePart") and not o:IsA("Terrain") then
                total = total + 1
                local p = o.Position
                if not lo then
                    lo, hi = {p.X, p.Y, p.Z}, {p.X, p.Y, p.Z}
                else
                    lo[1], lo[2], lo[3] = math.min(lo[1], p.X), math.min(lo[2], p.Y), math.min(lo[3], p.Z)
                    hi[1], hi[2], hi[3] = math.max(hi[1], p.X), math.max(hi[2], p.Y), math.max(hi[3], p.Z)
                end
                local hex = try(function() return o.Color:ToHex() end) or "?"
                local key = normName(o.Name) .. "|" .. o.ClassName .. "|" .. r2(o.Size.X) .. "x" .. r2(o.Size.Y) .. "x" .. r2(o.Size.Z) .. "|" .. hex
                local g = groups[key]
                if not g then g = {key = key, n = 0, items = {}}; groups[key] = g; order[#order + 1] = g end
                g.n = g.n + 1
                if #g.items < 400 then g.items[#g.items + 1] = o end
            elseif o:IsA("Model") or o:IsA("Folder") then
                local k = o.ClassName .. ":" .. normName(o.Name)
                containers[k] = (containers[k] or 0) + 1
            end
        end)
        line("looked at " .. seen .. " objects | parts " .. total .. " | groups " .. #order)
        if lo then
            line("bounding box of part positions: x " .. r2(lo[1]) .. " .. " .. r2(hi[1]) .. " | y " .. r2(lo[2]) .. " .. " .. r2(hi[2]) .. " | z " .. r2(lo[3]) .. " .. " .. r2(hi[3]))
        end
        table.sort(order, function(a, b) return a.n > b.n end)
        for i, g in ipairs(order) do
            if i > 150 then line("(+" .. (#order - 150) .. " more groups)"); break end
            line(string.format("%6d x %s  e.g. %s", g.n, g.key, g.items[1]:GetFullName()))
        end
        local cl = {}
        for k, n in pairs(containers) do cl[#cl + 1] = {k = k, n = n} end
        table.sort(cl, function(a, b) return a.n > b.n end)
        line("-- models and folders by name (top 60)")
        for i, c in ipairs(cl) do
            if i > 60 then break end
            line(string.format("%6d x %s", c.n, c.k))
        end
        -- a spread of examples from every group, with everything a clone needs (pos, size, rotation, flags, attributes, tags)
        local rows = {"# path|class|pos|size|rotDeg|color|material|collide|touch|query|anchored|transparency|attrs|tags"}
        for i, g in ipairs(order) do
            if i > 150 then break end
            local want = math.min(#g.items, 12)
            for k = 1, want do
                local idx = math.max(1, math.floor((k - 1) * #g.items / want) + 1)
                rows[#rows + 1] = partRow(g.items[idx])
            end
            yieldNow()
        end
        writeOut("gd_level_" .. STAMP .. ".txt", table.concat(rows, "\n") .. "\n")
        line("sample file: gd_level_" .. STAMP .. ".txt (" .. #rows .. " rows)")
    end)

    flushRuntime()

    -- the player, frame by frame. you play normally while this runs
    notify("play the level for the next " .. CFG.SAMPLE_SECONDS .. " seconds (jump, die, whatever)")
    say("sampling the player for " .. CFG.SAMPLE_SECONDS .. "s, play normally now")
    local bodies = {}
    local ch = lp.Character
    local root = ch and (ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart)
    if root then bodies[#bodies + 1] = {name = "character root", part = root} end
    walkNodes(workspace, 20000, function(o)
        if #bodies < 3 and o:IsA("BasePart") and (not root or o ~= root) and not (ch and o:IsDescendantOf(ch)) then
            local l = low(o.Name)
            if l == low(lp.Name) or l == "player" or l == "icon" or l == "cube" then bodies[#bodies + 1] = {name = o:GetFullName(), part = o} end
        end
    end)
    local out = {}
    out[#out + 1] = "bodies sampled: " .. (#bodies > 0 and "" or "none found")
    for _, b in ipairs(bodies) do out[#out + 1] = "  " .. b.name .. " (" .. b.part.ClassName .. ")" end
    local events, samples = {}, {}
    local t0 = tick()
    local c1 = UIS.InputBegan:Connect(function(i, gp) events[#events + 1] = string.format("%.3f down %s %s gp=%s", tick() - t0, tostring(i.UserInputType), tostring(i.KeyCode), tostring(gp)) end)
    local c2 = UIS.InputEnded:Connect(function(i, gp) events[#events + 1] = string.format("%.3f up   %s %s", tick() - t0, tostring(i.UserInputType), tostring(i.KeyCode)) end)
    local lastT = t0
    local c3 = RunService.Heartbeat:Connect(function(dt)
        local now = tick()
        local row = {string.format("%.4f", now - t0), string.format("%.4f", dt)}
        for _, b in ipairs(bodies) do
            local p = b.part
            local pos, vel = p.Position, p.AssemblyLinearVelocity
            row[#row + 1] = r2(pos.X) .. "," .. r2(pos.Y) .. "," .. r2(pos.Z) .. " v " .. r2(vel.X) .. "," .. r2(vel.Y) .. "," .. r2(vel.Z)
        end
        if cam then row[#row + 1] = "cam " .. v3s(cam.CFrame.Position) end
        samples[#samples + 1] = table.concat(row, " ")
    end)
    while tick() - t0 < CFG.SAMPLE_SECONDS do task.wait(0.1) end
    pcall(function() c1:Disconnect(); c2:Disconnect(); c3:Disconnect() end)
    out[#out + 1] = "heartbeats: " .. #samples .. " in " .. CFG.SAMPLE_SECONDS .. "s"
    out[#out + 1] = "-- input events (seconds since start)"
    for _, e in ipairs(events) do out[#out + 1] = e end
    out[#out + 1] = "-- samples: t dt | per body: pos v velocity | cam position"
    for i, s in ipairs(samples) do
        if i <= 1500 then out[#out + 1] = s end
    end
    writeOut("gd_player_" .. STAMP .. ".txt", table.concat(out, "\n") .. "\n")
    say("player sample written (" .. #samples .. " frames, " .. #events .. " input events)")
end

-- ---- decompile pass ----
local function decompileTimeout(inst, secs)
    local done, result, err = false, nil, nil
    local th = task.spawn(function()
        local ok, r = pcall(decompile, inst)
        if ok then result = r else err = tostring(r) end
        done = true
    end)
    local t0 = tick()
    while not done and tick() - t0 < secs do task.wait(0.05) end
    if not done then
        pcall(task.cancel, th)
        return nil, "timeout"
    end
    return result, err
end

local BUNDLES = {}
local function decompilePass()
    if not decompile then say("no decompile function, skipping the scripts"); return end
    local pick, extra = {}, 0
    for i, r in ipairs(RANK.list) do
        local big = r.bytes and r.bytes > CFG.MAX_BYTES
        if i <= CFG.MAX_SCRIPTS then
            if big and not r.also then r.status = "skipped: too big" else pick[#pick + 1] = r end
        elseif r.also and extra < CFG.EXTRA_ALSO then
            extra = extra + 1
            pick[#pick + 1] = r
        end
    end
    say("decompiling " .. #pick .. " scripts")
    local cur, curSize, n = {}, 0, 1
    local function flush()
        if #cur == 0 then return end
        local name = "bundle_" .. STAMP .. "_" .. n .. ".txt"
        writeOut(name, table.concat(cur, "\n"))
        BUNDLES[#BUNDLES + 1] = name .. " (" .. curSize .. " bytes)"
        n = n + 1
        cur, curSize = {}, 0
    end
    local t0 = tick()
    for i, r in ipairs(pick) do
        if tick() - t0 > CFG.TIME_BUDGET then
            r.status = "skipped: out of time"
        else
            local src, err = decompileTimeout(r.inst, CFG.PER_SCRIPT)
            if type(src) ~= "string" or #src < 4 then
                r.status = "decompile failed: " .. tostring(err or "empty")
            else
                local entry = "==== " .. r.path .. " ====\n-- [" .. r.class .. "] " .. tostring(r.bytes or "?") .. " bytes | rank " .. i .. "\n" .. src .. "\n"
                if curSize > 0 and curSize + #entry > CFG.BUNDLE_SIZE then flush() end
                cur[#cur + 1] = entry
                curSize = curSize + #entry
                r.status = "bundle " .. n
            end
        end
        if i % 10 == 0 then say("decompiled " .. i .. "/" .. #pick) end
    end
    flush()
end

-- ---- go ----
local function stageRun(name, fn)
    say("stage " .. name)
    notify(name)
    local ok, err = pcall(fn)
    if not ok then say("stage failed (" .. name .. "): " .. tostring(err)) end
end

stageRun("1/4 runtime: ui, remotes, listeners", function()
    if CFG.RUNTIME then runtimeA() end
end)
stageRun("1b/4 level, camera and player snapshot", function()
    if CFG.RUNTIME then runtimeGD() end
end)
stageRun("2/4 live functions (getgc)", function()
    if not CFG.ONLY then scanGC() end
    local labeled = 0
    for _ in pairs(GC.labels) do labeled = labeled + 1 end
    say("gc scan: " .. GC.scanned .. " game functions, " .. labeled .. " scripts labeled")
    if CFG.RUNTIME then runtimeGC() end
end)
stageRun("3/4 ranking scripts", function()
    rankScripts()
    say("ranked " .. #RANK.list .. " scripts (" .. RANK.skippedN .. " skipped)")
    if CFG.RUNTIME then runtimeC() end
    writeIndex()
end)
if CFG.DECOMPILE then
    stageRun("4/4 decompiling scripts", function()
        decompilePass()
        writeIndex()
    end)
end
for _, b in ipairs(BUNDLES) do say("  " .. b) end
]==]

if not loadstring then
    say("this executor has no loadstring", true)
    finish("no loadstring, see the log")
    return
end
local fn, cerr = loadstring(CORE, "=dumper_core")
if not fn then
    say("COMPILE ERROR: " .. tostring(cerr), true)
    writeOut("_error_" .. STAMP .. ".txt", tostring(cerr) .. "\n")
    pcall(setclipboard, tostring(cerr))
    notify("compile error, it's in your clipboard")
    return
end
local ok, err = pcall(fn, {CFG = CFG, say = say, notify = notify, writeOut = writeOut, stamp = STAMP})
if not ok then
    say("CRASH: " .. tostring(err), true)
    finish("crashed, the log is in your clipboard")
    return
end
say("done in " .. math.floor(tick() - T0) .. "s. files are in the '" .. CFG.FOLDER .. "' folder of your executor workspace", true)
finish("dump done, check the '" .. CFG.FOLDER .. "' folder")
