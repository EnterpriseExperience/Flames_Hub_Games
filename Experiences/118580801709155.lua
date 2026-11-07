if not game:IsLoaded() then
    local msg_instance = Instance.new("Message")
    local hint_instance = Instance.new("Hint")
    msg_instance.Text = "Flames Hub is waiting for the current experience to load fully."
    hint_instance.Text = "Flames Hub is currently waiting for the game to load."
    msg_instance.Parent = workspace
    hint_instance.Parent = workspace
    game.Loaded:Wait()
    task.wait(0.1)
    msg_instance:Destroy()
    hint_instance:Destroy()
end
-- [[     INITIALIZATION (Roblox Environment)     ]] --
local function valid_t(t) if t and typeof(t) == "table" then return t end; return false end
local In_Studio = false
local g
-- [[ Really secure checking below. ]] --
if game:GetService("RunService"):IsStudio() then
    g = valid_t(_G) or {}
    In_Studio = true
else
    g = valid_t(getgenv and getgenv()) or valid_t(_G) or {}
end
task.wait(0.25)
if game:GetService("RunService"):IsServer() then warn("This script can only be run on the client."); return end
if game.PlaceId ~= 118580801709155 then
    if g.notify and typeof(g.notify) == "function" then
        return g.notify("Error", "This game isn't allowed to run with this script (only: Carolina Leaners).", 30)
    else
        return warn("This game isn't allowed to run with this script (only: Carolina Leaners).")
    end
end
task.wait(0.1)
if g.Carolina_Leaners_Script_Hub_Running then
    if g.notify and typeof(g.notify) == "function" then
        g.notify("Error", "Carolina Leaners Script Hub is already running, please click 'Destroy GUI' at the bottom of the script to exit the menu.", 15)
        return 
    else
        warn("Carolina Leaners Script Hub is already running.")
        return 
    end
end
local blank_F = g.blank_function or g.blankfunction or function(...) return ... end
local cloneref = typeof(cloneref) == "function" and cloneref or function(instance) return instance end
-- [[ Should no longer break in Roblox Studio. 😈🚬 ]] --
if In_Studio then
    g.http_get = blank_F
else
    g.http_get = function(url)
        local ok, result = pcall(function() return game:HttpGet(url) end)
        if ok then return result end
        local ok2, result2 = pcall(function() return game:GetService("HttpService"):GetAsync(url) end)
        if ok2 then return result2 end
        warn("Http request failed for: " .. tostring(url))
        return nil
    end
end
wait(0.1)
if not In_Studio then
    if not g.GlobalEnvironmentFramework_Initialized then
        loadstring(g.http_get("https://pastebin.com/raw/T25mDhBZ"))()
        wait(0.1)
        g.GlobalEnvironmentFramework_Initialized = true
    end
end
wait(0.15)
local Workspace = g.Workspace or cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local Players = g.Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local ReplicatedStorage = g.ReplicatedStorage or cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local RunService = g.RunService or cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local UserInputService = g.UserInputService or cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local StarterPlayer = g.StarterPlayer or cloneref and cloneref(game:GetService("StarterPlayer")) or game:GetService("StarterPlayer")
local TweenService = g.TweenService or cloneref and cloneref(game:GetService("TweenService")) or game:GetService("TweenService")
local Lighting = g.Lighting or cloneref and cloneref(game:GetService("Lighting")) or game:GetService("Lighting")
local StarterGui = g.StarterGui or cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")
local GuiService = g.GuiService or cloneref and cloneref(game:GetService("GuiService")) or game:GetService("GuiService")
local speaker = g.LocalPlayer or Players.LocalPlayer or Players:GetAttributeChangedSignal("LocalPlayer"):Wait()
local PlayerGui = g.PlayerGui or speaker:FindFirstChildOfClass("PlayerGui") or speaker:FindFirstChildWhichIsA("PlayerGui")
local lib = g.FlamesLibrary or getgenv().FlamesLibrary
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local is_mobile = IsMobile
local Raw_Version = "V1.8.0"
g.Script_Version = tostring(Raw_Version).."-CL"
g._vehicle_light_cache = g._vehicle_light_cache or {}
g.fullbright_enabled = g.fullbright_enabled or false
g._vehicle_light_writing = g._vehicle_light_writing or false
g.all_vehicles = {}
g.lib = g.FlamesLibrary -- necessary for some reason.
local lib_attempts = 0
local lib_max_attempts = 15
while (not lib or type(lib) ~= "table") and lib_attempts < lib_max_attempts do
    task.wait(0.5)
    lib_attempts = lib_attempts + 1
    lib = g.FlamesLibrary
end

if not lib or type(lib) ~= "table" then
    if g.notify and typeof(g.notify) == "function" then g.notify("Error", "FlamesLibrary failed to load, the system cannot continue without it.", 15) else warn("FlamesLibrary failed to load, the system cannot continue without it.") end
    return
end
task.wait(0.1)
if g.notify and typeof(g.notify) == "function" then g.notify("Success", "Gathering Vehicle names, one moment...", 3) end
local function Find_Vehicle_Catalog_Remote_Function()
    local cache = g.Vehicle_Catalog_Remote_Function_Found
    if cache and cache.Parent and cache:IsA("RemoteFunction") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetChildren()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("get") and v.Name:lower():find("vehicle") and v.Name:lower():find("catalog") then
            g.Vehicle_Catalog_Remote_Function_Found = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Vehicle_Catalog_Remote_Function_Found then pcall(function() Find_Vehicle_Catalog_Remote_Function() end) end
if g.notify and typeof(g.notify) == "function" then g.notify("Success", "Sweeping Vehicle names, one moment...", 3) end
task.wait(0.15)
task.spawn(function()
    local V_Catalog = g.Vehicle_Catalog_Remote_Function_Found or Find_Vehicle_Catalog_Remote_Function()
    if not V_Catalog or not V_Catalog.Parent or not V_Catalog:IsA("RemoteFunction") then return end
    local ok, hit = pcall(function() return V_Catalog:InvokeServer() end)
    if not ok or type(hit) ~= "table" then return end
    local function sweep_catalog(tbl)
        for k, v in pairs(tbl) do
            if k == "label" and type(v) == "string" then
                table.insert(g.all_vehicles, v)
            elseif type(v) == "table" then
                sweep_catalog(v)
            end
        end
    end
    sweep_catalog(hit)
end)

function Validate_Number(str)
	if tonumber(str) ~= nil or str == 'inf' then return true end
	return false
end

local executor_string = nil
local function executor_contains(substr)
    if type(executor_string) ~= "string" then return false end
    return string.find(string.lower(executor_string), string.lower(substr), 1, true) ~= nil
end

local function retrieve_executor()
    local name
    if identifyexecutor then name = identifyexecutor() end
    return { Name = name or "Unknown Executor" }
end

local function identify_executor()
    local executorinfo = retrieve_executor()
    return tostring(executorinfo.Name)
end

executor_string = identify_executor()
function low_level_client()
    if executor_contains("solara") then return true end
    if executor_contains("jjsploit") then return true end
    if executor_contains("xeno") then return true end
    return false
end

g.all_available_colors = {
    ["Paint_white"]    = "#FFFFFF",
    ["Paint_silver"]   = "#C0C0C0",
    ["Paint_gray"]     = "#808080",
    ["Paint_charcoal"] = "#363636",
    ["Paint_black"]    = "#1B1B1B",
    ["Paint_red_1"]    = "#FFBFBF",
    ["Paint_red_2"]    = "#F77C7C",
    ["Paint_red_3"]    = "#E02D2D",
    ["Paint_red_4"]    = "#9E0808",
    ["Paint_red_5"]    = "#5C0000",
    ["Paint_orange_1"] = "#FFDCBF",
    ["Paint_orange_2"] = "#F7B37C",
    ["Paint_orange_3"] = "#E07E2D",
    ["Paint_orange_4"] = "#9E4B08",
    ["Paint_orange_5"] = "#5C2900",
    ["Paint_yellow_1"] = "#FFF3BF",
    ["Paint_yellow_2"] = "#F7E07C",
    ["Paint_yellow_3"] = "#E0BE2D",
    ["Paint_yellow_4"] = "#9E8208",
    ["Paint_yellow_5"] = "#5C4A00",
    ["Paint_green_1"]  = "#C1FFBF",
    ["Paint_green_2"]  = "#7EF77C",
    ["Paint_green_3"]  = "#30E02D",
    ["Paint_green_4"]  = "#0B9E08",
    ["Paint_green_5"]  = "#025C00",
    ["Paint_blue_1"]   = "#BFE0FF",
    ["Paint_blue_2"]   = "#7CBCF7",
    ["Paint_blue_3"]   = "#2D8AE0",
    ["Paint_blue_4"]   = "#08569E",
    ["Paint_blue_5"]   = "#00305C",
    ["Paint_purple_1"] = "#E3BFFF",
    ["Paint_purple_2"] = "#C17CF7",
    ["Paint_purple_3"] = "#912DE0",
    ["Paint_purple_4"] = "#5C089E",
    ["Paint_purple_5"] = "#33005C",
}

local function Find_Roads_Folder_WS()
    local cache = g.Roads_Folder_Found_WS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(Workspace:GetChildren()) do
        if typeof(v) == "Instance" and v:IsA("Folder") and v.Name:lower():find("roads") then
            g.Roads_Folder_Found_WS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Roads_Folder_Found_WS then pcall(function() Find_Roads_Folder_WS() end) end

local function Find_Buildings_Folder_WS()
    local cache = g.Buildings_Folder_Found_WS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(Workspace:GetChildren()) do
        if typeof(v) == "Instance" and v:IsA("Folder") and v.Name:lower():find("buildings") then
            g.Buildings_Folder_Found_WS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Buildings_Folder_Found_WS then pcall(function() Find_Buildings_Folder_WS() end) end

g.Pole_Collision_Cache = g.Pole_Collision_Cache or {}
local function matches_color(model, target_color)
    local primary = model:FindFirstChildOfClass("Part")
    return primary and primary.Color == target_color
end

local function register_part(part)
    if not part:IsA("BasePart") then return end
    if g.Pole_Collision_Cache[part] then return end
    g.Pole_Collision_Cache[part] = {
        CanCollide = part.CanCollide,
        CanQuery   = part.CanQuery,
        CanTouch   = part.CanTouch,
    }
    part.CanCollide = false
    part.CanQuery   = false
    part.CanTouch   = false
end

local function scan_folder(folder, target_color)
    if not folder or not folder:IsA("Folder") then return end
    for _, v in ipairs(folder:GetChildren()) do
        if v:IsA("Model") and matches_color(v, target_color) then
            for _, part in ipairs(v:GetDescendants()) do
                register_part(part)
            end
        end
    end
end

g.Disable_Pole_Collision = function(state)
    g.Disable_Pole_Collision_State = state
    if state then
        g.Pole_Collision_Cache = {}
        local Roads     = g.Roads_Folder_Found_WS     or Find_Roads_Folder_WS()
        local Buildings = g.Buildings_Folder_Found_WS or Find_Buildings_Folder_WS()
        scan_folder(Roads,     Color3.fromRGB(86,  66,  54))
        scan_folder(Buildings, Color3.fromRGB(163, 162, 165))
        if Roads and Roads:IsA("Folder") then
            lib.connect("pole_roads_added", Roads.ChildAdded:Connect(function(d)
                local model = d:FindFirstAncestorOfClass("Model")
                if model and matches_color(model, Color3.fromRGB(86, 66, 54)) then register_part(d) end
            end))
        end

        if Buildings and Buildings:IsA("Folder") then
            lib.connect("pole_buildings_added", Buildings.ChildAdded:Connect(function(d)
                local model = d:FindFirstAncestorOfClass("Model")
                if model and matches_color(model, Color3.fromRGB(163, 162, 165)) then register_part(d) end
            end))
        end

        lib.connect("pole_collision_disable", RunService.Heartbeat:Connect(function()
            for part in pairs(g.Pole_Collision_Cache) do
                if part:IsA("BasePart") and part.Parent then
                    if part.CanCollide or part.CanQuery or part.CanTouch then
                        part.CanCollide = false
                        part.CanQuery   = false
                        part.CanTouch   = false
                    end
                end
            end
        end))
    else
        lib.disconnect("pole_collision_disable")
        lib.disconnect("pole_roads_added")
        lib.disconnect("pole_buildings_added")
        for part, original in pairs(g.Pole_Collision_Cache) do
            if part:IsA("BasePart") and part.Parent then
                part.CanCollide = original.CanCollide
                part.CanQuery   = original.CanQuery
                part.CanTouch   = original.CanTouch
            end
        end
        g.Pole_Collision_Cache = {}
    end
end

local function find_remotes_folder()
    local cache = g.Remotes_Folder_Found_RS
    if cache and typeof(cache) == "Instance" and cache:IsA("Folder") then return cache end

    for _, v in ipairs(ReplicatedStorage:GetChildren()) do
        if typeof(v) == "Instance" and v:IsA("Folder") and v.Name:lower():find("remotes") then
            g.Remotes_Folder_Found_RS = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not g.Remotes_Folder_Found_RS then pcall(function() find_remotes_folder() end) end

local function Hit_Lamp_Post_Remote_Event()
    local cache = g.Lamp_Post_Remote_Event_Found_RS
    if cache and cache:IsA("RemoteEvent") then return cache end
    local remotes = g.Remotes_Folder_Found_RS or find_remotes_folder()
    if not remotes or not remotes:IsA("Folder") then return nil end
    for _, v in ipairs(remotes:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("lamp") and v.Name:lower():find("post") then
            g.Lamp_Post_Remote_Event_Found_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Lamp_Post_Remote_Event_Found_RS then pcall(function() Hit_Lamp_Post_Remote_Event() end) end

local PROXIMITY_RADIUS_ROADS = 200
local PROXIMITY_RADIUS_BUILDINGS = 300
g.Hit_All_Lamp_Posts = function()
    local Roads = g.Roads_Folder_Found_WS or Find_Roads_Folder_WS()
    local Buildings = g.Buildings_Folder_Found_WS or Find_Buildings_Folder_WS()
    local remote = g.Lamp_Post_Remote_Event_Found_RS or Hit_Lamp_Post_Remote_Event()
    if not remote or not remote:IsA("RemoteEvent") then return end
    local root = g.HumanoidRootPart or g.get_root(speaker)
    if not root then return end
    local origin = root.Position
    if Roads and Roads:IsA("Folder") then
        for _, v in ipairs(Roads:GetChildren()) do
            local part = v:IsA("Model") and v:FindFirstChildOfClass("Part")
            if part and part.Color == Color3.fromRGB(86, 66, 54) then
                local part_pos = part.Position
                if (part_pos - origin).Magnitude <= PROXIMITY_RADIUS_ROADS then remote:FireServer(v, part_pos) end
            end
        end
    end

    if Buildings and Buildings:IsA("Folder") then
        for _, v in ipairs(Buildings:GetChildren()) do
            local part = v:IsA("Model") and v:FindFirstChildOfClass("Part")
            if part and part.Color == Color3.fromRGB(163, 162, 165) then
                local part_pos = part.Position
                if (part_pos - origin).Magnitude <= PROXIMITY_RADIUS_BUILDINGS then remote:FireServer(v, part_pos) end
            end
        end
    end
end

g.Hit_Down_All_Poles_Near_LP = function(state)
    g.Knocking_Down_All_Poles = state
    if state then
        lib.spawn("knock_down_poles", "spawn", function()
            while g.Knocking_Down_All_Poles == true do
                task.wait(1)
                g.Hit_All_Lamp_Posts()
            end
        end)
    else
        g.Knocking_Down_All_Poles = false
        lib.disconnect("knock_down_poles")
    end
end

local function Find_Apply_Customization_Remote_Function()
    local cache = g.Apply_Customization_Remote_Function_Found_RS
    if cache and cache:IsA("RemoteFunction") then return cache end
    local remotes = g.Remotes_Folder_Found_RS or find_remotes_folder()
    if not remotes or not remotes:IsA("Folder") then return nil end
    for _, v in ipairs(remotes:GetChildren()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("apply") and v.Name:lower():find("customization") then
            g.Apply_Customization_Remote_Function_Found_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Apply_Customization_Remote_Function_Found_RS then pcall(function() Find_Apply_Customization_Remote_Function() end) end

local function find_Warden_Remote_Event()
    local cache = g.Warden_Remote_Event_Found_RS
    if cache and typeof(cache) == "Instance" and cache:IsA("RemoteEvent") then return cache end
    local remotes = g.Remotes_Folder_Found_RS or find_remotes_folder()
    if not remotes or typeof(remotes) ~= "Instance" or not remotes:IsA("Folder") then return nil end

    for _, v in ipairs(remotes:GetChildren()) do
        if typeof(v) == "Instance" and v:IsA("RemoteEvent") and v.Name:lower():find("warden") then
            g.Warden_Remote_Event_Found_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Warden_Remote_Event_Found_RS then pcall(function() find_Warden_Remote_Event() end) end

local function nuke_warden_ui()
    local w_gui = PlayerGui:FindFirstChild("Warden")
    if w_gui and typeof(w_gui) == "Instance" and w_gui:IsA("ScreenGui") then w_gui:Destroy() end
    pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
    pcall(function() GuiService.SelectedObject = nil end)
end

local function patch_remote(remote)
    if hookfunction and typeof(hookfunction) == "function" and newcclosure and typeof(newcclosure) == "function" then
        local original_fire = remote.FireServer
        if original_fire and typeof(original_fire) == "function" then
            hookfunction(original_fire, newcclosure(function(self, ...) return end))
        end
    end
end

local function blind_incoming(remote)
    if getconnections and typeof(getconnections) == "function" then
        local conns = getconnections(remote.OnClientEvent)
        if conns then
            for _, c in ipairs(conns) do
                pcall(function()
                    if c.Disable and typeof(c.Disable) == "function" then c:Disable() end
                    task.wait(0)
                    if c.Disconnect and typeof(c.Disconnect) == "function" then c:Disconnect() end
                end)
            end
        end
    end
end

local function find_ClientState_Remote_Event()
    local cache = g.ClientState_Remote_Event_Found_RS
    if cache and typeof(cache) == "Instance" and cache:IsA("RemoteEvent") then return cache end
    local remotes = g.Remotes_Folder_Found_RS or find_remotes_folder()
    if not remotes or typeof(remotes) ~= "Instance" or not remotes:IsA("Folder") then return nil end

    for _, v in ipairs(remotes:GetChildren()) do
        if typeof(v) == "Instance" and v:IsA("RemoteEvent") and v.Name:lower():find("clientstate") then
            g.ClientState_Remote_Event_Found_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.ClientState_Remote_Event_Found_RS then pcall(function() find_ClientState_Remote_Event() end) end

local function patch_ClientState_remote(remote)
    if hookfunction and typeof(hookfunction) == "function" and newcclosure and typeof(newcclosure) == "function" then
        local original_fire = remote.FireServer
        if original_fire and typeof(original_fire) == "function" then
            hookfunction(original_fire, newcclosure(function(self, ...)
                if rawequal and typeof(rawequal) == "function" and rawequal(self, remote) then
                    local args = table.pack(...)
                    local payload = args[1]
                    if typeof(payload) == "table" and payload.r == 2 then return end
                end
                return original_fire(self, ...)
            end))
        end
    end
end

local function find_ClientReport_Remote_Event()
    local cache = g.ClientReport_Remote_Event_Found_RS
    if cache and typeof(cache) == "Instance" and cache:IsA("RemoteEvent") then return cache end
    local remotes = g.Remotes_Folder_Found_RS or find_remotes_folder()
    if not remotes or typeof(remotes) ~= "Instance" or not remotes:IsA("Folder") then return nil end

    for _, v in ipairs(remotes:GetChildren()) do
        if typeof(v) == "Instance" and v:IsA("RemoteEvent") and v.Name:lower():find("clientreport") then
            g.ClientReport_Remote_Event_Found_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.ClientReport_Remote_Event_Found_RS then pcall(function() find_ClientReport_Remote_Event() end) end

local function patch_ClientReport_remote(remote)
    if hookfunction and typeof(hookfunction) == "function" and newcclosure and typeof(newcclosure) == "function" then
        local original_fire = remote.FireServer
        if original_fire and typeof(original_fire) == "function" then
            hookfunction(original_fire, newcclosure(function(self, ...)
                if rawequal and typeof(rawequal) == "function" and rawequal(self, remote) then return end
                return original_fire(self, ...)
            end))
        end
    end
end
wait(0.25)
local function full_bypass()
    if g.Bypassed_Anti_Cheat then return end
    g.Bypassed_Anti_Cheat = true
    local remote = g.Warden_Remote_Event_Found_RS or find_Warden_Remote_Event()
    if remote and typeof(remote) == "Instance" and remote:IsA("RemoteEvent") then
        blind_incoming(remote)
        patch_remote(remote)
        g.notify("Success", "Warden neutered — incoming event blinded, outbound patched.", 3)
    else
        g.notify("Warning", "Warden remote not found yet — polling...", 3)
    end

    for _, v in ipairs(speaker:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("warden") then
            g.notify("Warning", "Warden ModuleScript found — hooking before destroy...", 3)
            pcall(function() v:Destroy() end)
            task.wait(0.75)
            g.notify("Success", "Warden neutralized and destroyed.", 3)
        end
    end
    task.wait(0.1)
    local cs_remote = g.ClientState_Remote_Event_Found_RS or find_ClientState_Remote_Event()
    if cs_remote and typeof(cs_remote) == "Instance" and cs_remote:IsA("RemoteEvent") then
        g.notify("Success", "Patching ClientState RemoteEvent to prevent session-report payloads...", 3)
        patch_ClientState_remote(cs_remote)
        task.wait(0.75)
        g.notify("Success", "ClientState RemoteEvent patched & blocked.", 3)
        task.wait(0.1)
        pcall(function() cs_remote:Destroy() end)
        g.notify("Success", "ClientState RemoteEvent destroyed.", 3)
    else
        g.notify("Warning", "ClientState remote not found yet — polling...", 3)
    end
    task.wait(0.1)
    local cr_remote = g.ClientReport_Remote_Event_Found_RS or find_ClientReport_Remote_Event()
    if cr_remote and typeof(cr_remote) == "Instance" and cr_remote:IsA("RemoteEvent") then
        g.notify("Success", "Patching ClientReport RemoteEvent to prevent analytical payloads...", 3)
        patch_ClientReport_remote(cr_remote)
        task.wait(0.75)
        g.notify("Success", "ClientReport RemoteEvent patched & blocked.", 3)
        task.wait(0.1)
        pcall(function() cr_remote:Destroy() end)
        g.notify("Success", "ClientReport RemoteEvent destroyed.", 3)
    else
        g.notify("Warning", "ClientReport remote not found yet — polling...", 3)
    end
    task.wait(0.1)
    nuke_warden_ui()
    task.spawn(function()
        local attempts = 0
        local max_attempts = 60
        while attempts < max_attempts do
            task.wait(0.5)
            attempts = attempts + 1
            local r = g.Warden_Remote_Event_Found_RS or find_Warden_Remote_Event()
            if r and typeof(r) == "Instance" and r:IsA("RemoteEvent") then
                blind_incoming(r)
                patch_remote(r)
                g.notify("Success", "Warden Anti-Cheat has been successfully disabled, you may continue.", 5)
                break
            end
            nuke_warden_ui()
        end
    end)
end
wait(0.25)
if not g.Bypassed_Anti_Cheat then
    task.spawn(function()
        task.wait(0.1)
        full_bypass()
    end)
end
wait(0.25)
lib.connect("warden_ui_watchdog", RunService.Heartbeat:Connect(function()
    local w = PlayerGui:FindFirstChild("Warden")
    if w and typeof(w) == "Instance" and w:IsA("ScreenGui") then
        w:Destroy()
        pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
        g.notify("Warning", "Warden ScreenGui tried to respawn, attempt blocked.", 1)
    end
end))

local function get_vehicles_folder()
    local cache = g.Main_Vehicles_Folder_Found_WS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("vehicles") then
            g.Main_Vehicles_Folder_Found_WS = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not g.Main_Vehicles_Folder_Found_WS then pcall(function() get_vehicles_folder() end) end

g.get_lp_vehicle = function()
    local vehicles_folder = g.Main_Vehicles_Folder_Found_WS or get_vehicles_folder()
    if not vehicles_folder or not vehicles_folder:IsA("Folder") then return nil end
    for _, v in ipairs(vehicles_folder:GetChildren()) do
        if v:IsA("Model") and v:GetAttribute("owner") == speaker.UserId then
            return v
        end
    end

    return nil
end

g.get_lp_trailer = function()
    local vehicles_folder = g.Main_Vehicles_Folder_Found_WS or get_vehicles_folder()
    if not vehicles_folder or not vehicles_folder:IsA("Folder") then return nil end
    for _, v in ipairs(vehicles_folder:GetChildren()) do
        if v:IsA("Model") and v:GetAttribute("owner") == speaker.UserId and v:FindFirstChild("trailerConfig") and v:FindFirstChild("trailerConfig"):IsA("ModuleScript") then
            return v
        end
    end

    return nil
end

g.Get_Current_Sitting_In_Vehicle = function()
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game or workspace) then return nil end
    local humanoid = g.Humanoid
        or (char and char:FindFirstChildOfClass("Humanoid"))
        or g.get_human(speaker)
    if not humanoid or not humanoid.Parent or not humanoid:IsDescendantOf(game) then return nil end
    if not humanoid.Sit or not humanoid.SeatPart then return nil end
    local seat = humanoid.SeatPart
    if not seat or not seat:IsDescendantOf(game) then return nil end
    local vehicles_folder = g.Main_Vehicles_Folder_Found_WS or get_vehicles_folder()
    if not vehicles_folder or not vehicles_folder:IsA("Folder") then return nil end
    if not seat:IsDescendantOf(vehicles_folder) then return nil end
    local cursor = seat
    while cursor and cursor.Parent and cursor.Parent ~= vehicles_folder do cursor = cursor.Parent end
    if cursor and cursor.Parent == vehicles_folder and cursor:IsA("Model") then return cursor end
    local fallback = seat:FindFirstAncestorWhichIsA("Model")
    if fallback and fallback:IsDescendantOf(vehicles_folder) then return fallback end
    return nil
end

g.Apply_Paint_Customization = function(color)
    local remote = g.Apply_Customization_Remote_Function_Found_RS or Find_Apply_Customization_Remote_Function()
    if not remote or not remote:IsA("RemoteFunction") then return end
    local veh = g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle()
    if not veh or not veh:IsDescendantOf(game or workspace) then g.notify("Error", "You do not have a Vehicle spawned or you're not sitting in one.", 3); return end
    remote:InvokeServer(
        veh.Name,
        {
            category = "Paint",
            optionId = color,
            subcategory = "Color1"
        }
    )
    if veh and veh:GetAttribute("owner") ~= speaker.UserId then
        g.notify("Warning", "If it did not work, it is because you do not own this Vehicle.", 3)
    end
end

g.Fire_All_Doors_Running = g.Fire_All_Doors_Running or false
g.Fire_All_Doors_Last = g.Fire_All_Doors_Last or 0
local COOLDOWN = 1
local DOOR_ARGS = {"Tailgate", "FLDoor", "FRDoor", "RRDoor", "RLDoor"}
g.Fire_All_Doors = function()
    local now = os.clock()
    if g.Fire_All_Doors_Running then return end
    if (now - g.Fire_All_Doors_Last) < COOLDOWN then return end
    local vehicles_folder = g.Main_Vehicles_Folder_Found_WS or get_vehicles_folder()
    if not vehicles_folder or not vehicles_folder:IsA("Folder") then return end
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game or workspace) then return end
    local hrp = g.HumanoidRootPart or char and char:FindFirstChild("HumanoidRootPart") or g.get_root(speaker)
    local humanoid = g.Humanoid or char and char:FindFirstChildOfClass("Humanoid") or g.get_human(speaker)
    if not hrp or not hrp.Parent or not humanoid or not humanoid.Parent or not humanoid:IsDescendantOf(game) then return end
    g.Fire_All_Doors_Running = true
    g.Fire_All_Doors_Last = now
    local OldCFrame = hrp.CFrame
    local function safe_return()
        if hrp and hrp.Parent then hrp.CFrame = OldCFrame end
        g.Fire_All_Doors_Running = false
    end

    if humanoid and humanoid.Parent and humanoid:IsDescendantOf(game) and humanoid.Sit then
        if humanoid then humanoid.Sit = false end
        task.wait(0.2)
    end
    task.wait(0.15)
    local lp_vehicle = g.get_lp_vehicle()
    pcall(function()
        for _, v in pairs(vehicles_folder:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                local lower = v:GetFullName():lower()
                if lower:find("door") and lower:find("remote") then
                    local is_own = lp_vehicle ~= nil and v:IsDescendantOf(lp_vehicle)
                    if not is_own then
                        local vehicle_model = v.Parent.Parent.Parent
                        local anchor = vehicle_model and (vehicle_model.PrimaryPart or vehicle_model:FindFirstChildWhichIsA("BasePart"))
                        if anchor then
                            hrp.CFrame = anchor.CFrame * CFrame.new(0, 4, 0)
                            task.wait(0.1)
                        end
                        for _, arg in ipairs(DOOR_ARGS) do
                            pcall(function() v:FireServer(arg) end)
                            task.wait(0.05)
                        end
                        task.wait(0.05)
                    end
                end
            end
        end
    end)

    safe_return()
end

g.find_vehicle_Fuel_Remote_Event = function()
    local vehicle = g.get_lp_vehicle()
    if not vehicle or not vehicle:IsA("Model") then return nil end
    for _, v in ipairs(vehicle:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("fuel") and v.Name:lower():find("remote") then
            return v
        end
    end
    return nil
end

local function Find_Job_Action_RF()
    local cache = g.Job_Action_RF_Found
    if cache and cache:IsA("RemoteFunction") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("job") and v.Name:lower():find("action") then
            g.Job_Action_RF_Found = v
            return v
        end
    end
    return nil
end

g.all_jobs_available = {} -- dynamic update
g.collect_all_jobs_available = function()
    local Event = g.Job_Action_RF_Found or Find_Job_Action_RF()
    if not Event or not Event.Parent or not Event:IsA("RemoteFunction") then return end
    local payload = Event:InvokeServer("list")
    if payload and type(payload.jobs) == "table" then
        for _, job in pairs(payload.jobs) do
            if job.available and not job.locked then
                table.insert(g.all_jobs_available, job)
            end
        end
    end
end
wait(0.1)
if #g.all_jobs_available == 0 then pcall(g.collect_all_jobs_available) end -- only collect if empty

g.Start_Job = function(job_id)
    if not g.all_jobs_available or not g.all_jobs_available[job_id] then return nil end
    local Event = g.Job_Action_RF_Found or Find_Job_Action_RF()
    if not Event or not Event.Parent or not Event:IsA("RemoteFunction") then return end
    local payload = Event:InvokeServer("start", tostring(job_id))
    return payload
end

g.Clock_Off = function()
    local Event = g.Job_Action_RF_Found or Find_Job_Action_RF()
    if not Event or not Event.Parent or not Event:IsA("RemoteFunction") then return end
    Event:InvokeServer("end")
end

local function Find_GetBalance_Remote_Function()
    local cache = g.GetBalance_Remote_Function_Found
    if cache and cache:IsA("RemoteFunction") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("get") and v.Name:lower():find("balance") then
            g.GetBalance_Remote_Function_Found = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.GetBalance_Remote_Function_Found then pcall(function() Find_GetBalance_Remote_Function() end) end

g.Get_Balance = function()
    local Event = g.GetBalance_Remote_Function_Found or Find_GetBalance_Remote_Function()
    if not Event or not Event.Parent or not Event:IsA("RemoteFunction") then return nil end
    local payload = Event:InvokeServer()
    return tostring(payload) -- number > string
end

local function find_Despawn_Vehicle_Remote_Function()
    local cache = g.Despawn_Vehicle_Remote_Function_Found
    if cache and cache:IsA("RemoteFunction") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("despawn") and v.Name:lower():find("vehicle") then
            g.Despawn_Vehicle_Remote_Function_Found = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Despawn_Vehicle_Remote_Function_Found then pcall(function() find_Despawn_Vehicle_Remote_Function() end) end

local function find_Spawn_Vehicle_Remote_Function()
    local cache = g.Spawn_Vehicle_Remote_Function_Found
    if cache and cache:IsA("RemoteFunction") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("spawn") and v.Name:lower():find("vehicle") then
            g.Spawn_Vehicle_Remote_Function_Found = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Spawn_Vehicle_Remote_Function_Found then pcall(function() find_Spawn_Vehicle_Remote_Function() end) end

local function Get_Owned_Vehicles_RF()
    local cache = g.Get_Owned_Vehicles_RF_Found
    if cache and cache:IsA("RemoteFunction") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("get") and v.Name:lower():find("owned") and v.Name:lower():find("vehicles") then
            g.Get_Owned_Vehicles_RF_Found = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Get_Owned_Vehicles_RF_Found then pcall(function() Get_Owned_Vehicles_RF() end) end

g.Target_Vehicle_Copy_Id = nil
g.resolve_target_vehicle = function()
    local rf = g.Get_Owned_Vehicles_RF_Found or Get_Owned_Vehicles_RF()
    if not rf or not rf.Parent or not rf:IsA("RemoteFunction") then return false end
    local payload = rf:InvokeServer()
    if not payload or type(payload.copies) ~= "table" then return false end
    for _, copy in pairs(payload.copies) do
        if type(copy) == "table" and copy.id then
            g.Target_Vehicle_Copy_Id = copy.id
            return true
        end
    end
    return false
end
wait(0.1)
if not g.Target_Vehicle_Copy_Id then pcall(g.resolve_target_vehicle) end

local function find_Vehicles_Screen_Gui_PlayerGui()
    local cache = g.Vehicles_Screen_Gui_PlayerGui_Found
    if cache and cache:IsA("ScreenGui") then return cache end
    for _, v in ipairs(PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:lower():find("vehicles") then
            g.Vehicles_Screen_Gui_PlayerGui_Found = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Vehicles_Screen_Gui_PlayerGui_Found then pcall(function() find_Vehicles_Screen_Gui_PlayerGui() end) end

local function Find_Upgrades_ModuleScript_RS()
    local cache = g.Upgrades_ModuleScript_Found_RS
    if cache and cache:IsA("ModuleScript") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetChildren()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("upgrades") then
            g.Upgrades_ModuleScript_Found_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Upgrades_ModuleScript_Found_RS then pcall(function() Find_Upgrades_ModuleScript_RS() end) end

g.allow_walking_with_vehicles_menu_opened = function(state)
    g.walking_with_vehicles_menu_opened = state
    lib.disconnect("veh_walk_fix")
    if not state then return end
    local veh_GUI = g.Vehicles_Screen_Gui_PlayerGui_Found or find_Vehicles_Screen_Gui_PlayerGui()
    if not veh_GUI or not veh_GUI:IsA("ScreenGui") then return end
    local function apply_walk()
        if not g.walking_with_vehicles_menu_opened then return end
        if not veh_GUI.Enabled then return end
        wait(0.25)
        local Speaker = g.LocalPlayer or g.Players and g.Players.LocalPlayer or game.Players.LocalPlayer
        local Char = g.Character or Speaker.Character or g.get_char(Speaker)
        if not Char or not Char:IsDescendantOf(game) then return end
        local Human = g.Humanoid or Char and Char:FindFirstChildWhichIsA("Humanoid") or g.get_human(Speaker)
        if not Human or not Human.Parent or not Human:IsDescendantOf(game) then return end
        Human.WalkSpeed = StarterPlayer.CharacterWalkSpeed
    end

    lib.connect("veh_walk_fix", veh_GUI:GetPropertyChangedSignal("Enabled"):Connect(apply_walk))
    apply_walk()
end

local function find_A_Chassis_Screen_Gui()
    for _, v in ipairs(PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:lower():find("a") and v.Name:lower():find("chassis") and v.Name:lower():find("interface") then
            return v
        end
    end
    return nil
end

g.toggle_vehicle_state = function(state)
    if typeof(state) ~= "boolean" then return end
    local vehicle = g.get_lp_vehicle()
    if not vehicle or not vehicle:IsA("Model") then return end
    local interface = find_A_Chassis_Screen_Gui()
    if not interface or not interface:IsA("ScreenGui") then g.notify("Error", "A-Chassis Interface ScreenGui not found.", 3); return end
    for _, v in ipairs(interface:GetChildren()) do
        if v:IsA("BoolValue") and v.Name:lower():find("ison") and v.Parent:IsA("ScreenGui") then
            v.Value = state or false
        end
    end

    return nil
end

local function find_vehicle_Horn_Remote_Event()
    local vehicle = g.get_lp_vehicle()
    if not vehicle or not vehicle:IsA("Model") then return nil end
    for _, v in ipairs(vehicle:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("horn") and v.Name:lower():find("remote") then
            return v
        end
    end
    return nil
end

g.toggle_car_alarm = function(state)
    if typeof(state) ~= "boolean" then return end
    local horn_remote_event = find_vehicle_Horn_Remote_Event()
    if not horn_remote_event or not horn_remote_event:IsA("RemoteEvent") then return end
    horn_remote_event:FireServer(state or false)
end

g.despawn_current_vehicle = function()
    local veh = g.get_lp_vehicle()
    if not veh or not veh:IsA("Model") then return end
    local despawn_remote_function = g.Despawn_Vehicle_Remote_Function_Found or find_Despawn_Vehicle_Remote_Function()
    if not despawn_remote_function or not despawn_remote_function:IsA("RemoteFunction") then return end
    local get_attr = veh:GetAttribute("garageCopy")
    if get_attr ~= nil then despawn_remote_function:InvokeServer(tostring(get_attr)) end
end

local function Find_Notification_Remote_Event_RS()
    local cache = g.Notification_Remote_Event_Found_RS
    if cache and cache:IsA("RemoteEvent") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("notification") then
            g.Notification_Remote_Event_Found_RS = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not g.Notification_Remote_Event_Found_RS then pcall(function() Find_Notification_Remote_Event_RS() end) end

g.Call_Notification = function(title, str, dur) -- will work on it later, not important.
    if not title then title = "" end
    if not str or str == "" or str == " " then str = "Hello, World" end
    if not dur or not Validate_Number(dur) then dur = 5 end
    if not firesignal or typeof(firesignal) ~= "function" then return end
    local Event = g.Notification_Remote_Event_Found_RS or Find_Notification_Remote_Event_RS()
    if not Event or not Event:IsA("RemoteEvent") then return end
    firesignal(Event.OnClientEvent, {
        color = Color3.new(1, 0, 0),
        duration = tonumber(dur) or 5,
        title = tostring(title),
        message = tostring(str)
    })
end

local control_module
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    local ok, result = pcall(function() return require(speaker:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule")) end)
    if ok then control_module = result end
end

g.vehicle_fly           = g.vehicle_fly           or false
g.vehicle_fly_speed     = g.vehicle_fly_speed     or 3
g.vehiclefly_conns      = g.vehiclefly_conns      or {}
g.vehiclefly_control    = g.vehiclefly_control    or {f=0,b=0,l=0,r=0,q=0,e=0}
g.vehiclefly_noclip     = g.vehiclefly_noclip     or false
g.vehiclefly_collisions = g.vehiclefly_collisions or {}
local function resolve_anchor(car)
    if not car or not car:IsDescendantOf(game or workspace) then return nil end
    local primary = car.PrimaryPart
    if primary then return primary end
    local seat = car:FindFirstChild("DriveSeat")
    if seat then return seat end
    return car:FindFirstChildWhichIsA("BasePart")
end

local function resolve_active_car()
    local sitting = (g.get_vehicle and g.get_vehicle())
        or (g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle())
    if sitting and sitting:IsDescendantOf(game) then return sitting end
    local own = g.get_lp_vehicle and g.get_lp_vehicle()
    if own and own:IsDescendantOf(game) then return own end
    return nil
end

g.get_vehicle = g.get_vehicle or function() return g.get_lp_vehicle() or nil end
g.vf_cleanup = function()
    for _, c in pairs(g.vehiclefly_conns) do pcall(function() c:Disconnect() end) end
    g.vehiclefly_conns = {}
    if g.vehiclefly_bv then
        pcall(function() g.vehiclefly_bv.Velocity = Vector3.zero end)
        pcall(function() g.vehiclefly_bv:Destroy() end)
        g.vehiclefly_bv = nil
    end
    if g.vehiclefly_bg then
        pcall(function() g.vehiclefly_bg:Destroy() end)
        g.vehiclefly_bg = nil
    end
end

g.vehiclefly_passenger_collisions = g.vehiclefly_passenger_collisions or {}
g.vehiclefly_seat_conns           = g.vehiclefly_seat_conns           or {}
g.vehiclefly_seat_occupants       = g.vehiclefly_seat_occupants       or {}
local function noclip_char(char)
    if not char or not char:IsDescendantOf(game) then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            if g.vehiclefly_passenger_collisions[part] == nil then
                g.vehiclefly_passenger_collisions[part] = part.CanCollide
            end
            part.CanCollide = false
        end
    end
end

local function restore_char(char)
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and g.vehiclefly_passenger_collisions[part] ~= nil then
            pcall(function() part.CanCollide = g.vehiclefly_passenger_collisions[part] end)
            g.vehiclefly_passenger_collisions[part] = nil
        end
    end
end

local function watch_seats(model)
    for _, desc in ipairs(model:GetDescendants()) do
        if (desc:IsA("Seat") or desc:IsA("VehicleSeat")) and desc.Name == "PS" then
            local seat = desc
            if seat.Occupant and seat.Occupant.Parent then
                g.vehiclefly_seat_occupants[seat] = seat.Occupant.Parent
                noclip_char(seat.Occupant.Parent)
            end
            g.vehiclefly_seat_conns[seat] = seat:GetPropertyChangedSignal("Occupant"):Connect(function()
                local prev_char = g.vehiclefly_seat_occupants[seat]
                local occ       = seat.Occupant
                if occ and occ.Parent and occ.Parent:IsDescendantOf(game) then
                    g.vehiclefly_seat_occupants[seat] = occ.Parent
                    noclip_char(occ.Parent)
                else
                    g.vehiclefly_seat_occupants[seat] = nil
                    if prev_char then restore_char(prev_char) end
                end
            end)
        end
    end
end

local function silent_stop_fly()
    g.vehicle_fly = false
    g.disable_vehicle_noclip()
    g.vf_cleanup()
    g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
    if g.Vehicle_Fly_Toggle_UI then pcall(function() g.Vehicle_Fly_Toggle_UI:Set(false, false) end) end
end

g.enable_vehicle_noclip = function()
    if g.vehiclefly_noclip then return end
    g.vehiclefly_noclip     = true
    g.vehiclefly_collisions = {}
    local car = resolve_active_car()
    if not car or not car:IsA("Model") or not car:IsDescendantOf(game or workspace) then return end
    if g.ToggleNoclip and typeof(g.ToggleNoclip) == "function" then pcall(g.ToggleNoclip, true) end
    local own    = g.get_lp_vehicle and g.get_lp_vehicle()
    local is_own = own and own == car
    local targets = {car}
    if is_own then
        local trailer = g.get_lp_trailer and g.get_lp_trailer()
        if trailer and trailer:IsA("Model") and trailer:IsDescendantOf(game or workspace) then
            table.insert(targets, trailer)
        end
    end
    for _, model in ipairs(targets) do
        for _, v in ipairs(model:GetDescendants()) do
            if v:IsA("BasePart") then
                g.vehiclefly_collisions[v] = v.CanCollide
                v.CanCollide = false
            end
        end
        watch_seats(model)
    end
end

g.disable_vehicle_noclip = function()
    if not g.vehiclefly_noclip then return end
    g.vehiclefly_noclip = false
    if g.ToggleNoclip and typeof(g.ToggleNoclip) == "function" then pcall(g.ToggleNoclip, false) end
    for _, conn in pairs(g.vehiclefly_seat_conns) do pcall(function() conn:Disconnect() end) end
    g.vehiclefly_seat_conns = {}
    for part, state in pairs(g.vehiclefly_passenger_collisions) do if part and part.Parent then pcall(function() part.CanCollide = state end) end end
    g.vehiclefly_passenger_collisions = {}
    g.vehiclefly_seat_occupants       = {}
    for part, state in pairs(g.vehiclefly_collisions) do if part and part.Parent then pcall(function() part.CanCollide = state end) end end
    g.vehiclefly_collisions = {}
end

g.start_vehicle_fly = function()
    if g.vehiclefly_bg or g.vehiclefly_bv then return end
    local car = resolve_active_car()
    if not car or not car:IsDescendantOf(game or workspace) then
        g.disable_vehicle_noclip()
        task.wait()
        g.vf_cleanup()
        g.notify("Error", "Vehicle-Fly: no vehicle found.", 3)
        return
    end

    local anchor = resolve_anchor(car)
    if not anchor or not anchor:IsDescendantOf(game) then
        g.notify("Error", "Vehicle-Fly: could not resolve anchor Part.", 3)
        g.vf_cleanup()
        return
    end

    local bg = Instance.new("BodyGyro")
    bg.P         = 3e4
    bg.D         = 1e3
    bg.MaxTorque = Vector3.new(0, 9e9, 0)
    bg.CFrame    = anchor.CFrame
    bg.Parent    = anchor

    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.Parent   = anchor

    g.vehiclefly_bg = bg
    g.vehiclefly_bv = bv
    g.vehiclefly_conns.destroy_watch = car.AncestryChanged:Connect(function()
        if not car:IsDescendantOf(game) then
            silent_stop_fly()
        end
    end)

    g.vehiclefly_conns.render = RunService.Heartbeat:Connect(function()
        if not g.vehicle_fly then
            pcall(function() bv.Velocity = Vector3.zero end)
            g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
            return
        end

        local car_now = resolve_active_car()
        if not car_now or not car_now:IsDescendantOf(game) then
            g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
            silent_stop_fly()
            return
        end

        if not anchor.Parent then
            g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
            silent_stop_fly()
            return
        end

        pcall(function() anchor.AssemblyAngularVelocity = Vector3.zero end)
        local cam   = Workspace.CurrentCamera or Workspace:FindFirstChildOfClass("Camera")
        local speed = 45 * (g.vehicle_fly_speed or 3)
        if UserInputService.TouchEnabled and control_module then
            local ok, mv = pcall(function() return control_module:GetMoveVector() end)
            if ok and mv then
                pcall(function() bg.CFrame = cam.CFrame end)
                local vel = Vector3.zero
                if mv.X ~= 0 then vel = vel + cam.CFrame.RightVector * (mv.X * speed) end
                if mv.Z ~= 0 then vel = vel - cam.CFrame.LookVector * (mv.Z * speed) end
                pcall(function() bv.Velocity = vel end)
            end
        else
            local look = cam.CFrame.LookVector
            local yaw  = math.atan2(-look.X, -look.Z)
            pcall(function() bg.CFrame = CFrame.new(anchor.Position) * CFrame.Angles(0, yaw, 0) end)
            local c       = g.vehiclefly_control
            local forward = (c.f or 0) + (c.b or 0)
            local right   = (c.l or 0) + (c.r or 0)
            local up      = (c.q or 0) + (c.e or 0)
            pcall(function()
                bv.Velocity = (
                    cam.CFrame.LookVector  * forward +
                    cam.CFrame.RightVector * right   +
                    Vector3.new(0, up, 0)
                ) * speed
            end)
        end
    end)

    if not UserInputService.TouchEnabled then
        g.vehiclefly_conns.down = UserInputService.InputBegan:Connect(function(i, gp)
            if gp then return end
            if i.KeyCode == Enum.KeyCode.W then g.vehiclefly_control.f =  1 end
            if i.KeyCode == Enum.KeyCode.S then g.vehiclefly_control.b = -1 end
            if i.KeyCode == Enum.KeyCode.A then g.vehiclefly_control.l = -1 end
            if i.KeyCode == Enum.KeyCode.D then g.vehiclefly_control.r =  1 end
            if i.KeyCode == Enum.KeyCode.E then g.vehiclefly_control.q =  1 end
            if i.KeyCode == Enum.KeyCode.Q then g.vehiclefly_control.e = -1 end
        end)
        g.vehiclefly_conns.up = UserInputService.InputEnded:Connect(function(i)
            if i.KeyCode == Enum.KeyCode.W then g.vehiclefly_control.f = 0 end
            if i.KeyCode == Enum.KeyCode.S then g.vehiclefly_control.b = 0 end
            if i.KeyCode == Enum.KeyCode.A then g.vehiclefly_control.l = 0 end
            if i.KeyCode == Enum.KeyCode.D then g.vehiclefly_control.r = 0 end
            if i.KeyCode == Enum.KeyCode.E then g.vehiclefly_control.q = 0 end
            if i.KeyCode == Enum.KeyCode.Q then g.vehiclefly_control.e = 0 end
        end)
    end
end

g.stop_vehicle_fly = function()
    g.vehicle_fly = false
    g.disable_vehicle_noclip()
    g.vf_cleanup()
    g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
end

g.toggle_vehicle_fly = function()
    if g.vehicle_fly then
        g.stop_vehicle_fly()
    else
        g.vehicle_fly = true
        g.enable_vehicle_noclip()
        g.start_vehicle_fly()
    end
end

local float_name = "VehFloat_Active"
local inc = false
local dec = false
local function snapshot_floor_offset(car, anchor, trailer)
    local lowest = math.huge
    local models = {car}
    if trailer and trailer:IsDescendantOf(game) then table.insert(models, trailer) end
    for _, model in ipairs(models) do
        for _, part in ipairs(model:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                local bottom = part.Position.Y - (part.Size.Y * 0.5)
                if bottom < lowest then lowest = bottom end
            end
        end
    end
    if lowest == math.huge then lowest = anchor.Position.Y - (anchor.Size.Y * 0.5) end
    return lowest - anchor.Position.Y
end

local function get_combined_bounds(car, trailer)
    local min_x, min_z =  math.huge,  math.huge
    local max_x, max_z = -math.huge, -math.huge
    local models = {car}
    if trailer and trailer:IsDescendantOf(game) then table.insert(models, trailer) end
    for _, model in ipairs(models) do
        for _, part in ipairs(model:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                local pos  = part.Position
                local half = part.Size * 0.5
                if pos.X - half.X < min_x then min_x = pos.X - half.X end
                if pos.Z - half.Z < min_z then min_z = pos.Z - half.Z end
                if pos.X + half.X > max_x then max_x = pos.X + half.X end
                if pos.Z + half.Z > max_z then max_z = pos.Z + half.Z end
            end
        end
    end
    if min_x == math.huge then return nil end
    return (min_x + max_x) * 0.5, (min_z + max_z) * 0.5, (max_x - min_x) + 2, (max_z - min_z) + 2
end

local function silent_stop_float()
    g.Vehicle_Float_Running = false
    g.vehicle_float_height  = 0
    g.vehicle_floor_offset  = 0
    inc = false
    dec = false
    lib.disconnect("vfloat_input_began")
    lib.disconnect("vfloat_input_ended")
    lib.disconnect("vfloat_heartbeat")
    lib.disconnect("vfloat_destroy_watch")
    local fp_ref = g.vehicle_float_part
    if fp_ref and fp_ref.Parent then fp_ref:Destroy() end
    local leftover = Workspace:FindFirstChild(float_name)
    if leftover then leftover:Destroy() end
    g.vehicle_float_part = nil
    if g.Vehicle_Float_Toggle_UI then
        pcall(function() g.Vehicle_Float_Toggle_UI:Set(false, false) end)
    end
end

g.Vehicle_Float_Running = g.Vehicle_Float_Running or false
g.vehicle_float_height  = g.vehicle_float_height  or 0
g.vehicle_float_part    = g.vehicle_float_part    or nil
g.vehicle_floor_offset  = g.vehicle_floor_offset  or 0
g.start_vehicle_float = function()
    if g.Vehicle_Float_Running then
        g.notify("Warning", "Vehicle float is already active.", 3)
        return
    end

    local sitting = (g.get_vehicle and g.get_vehicle()) or (g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle())
    local own_car = g.get_lp_vehicle and g.get_lp_vehicle()
    local car     = nil
    local is_own  = false
    if sitting and sitting:IsDescendantOf(game) then
        car    = sitting
        is_own = own_car ~= nil and own_car == sitting
    elseif own_car and own_car:IsDescendantOf(game) then
        car    = own_car
        is_own = true
    end

    if not car or not car:IsDescendantOf(game) then
        g.notify("Error", "Vehicle float: no vehicle detected.", 3)
        return
    end

    local anchor = resolve_anchor(car)
    if not anchor or not anchor:IsDescendantOf(game) then
        g.notify("Error", "Vehicle float: could not resolve anchor part.", 3)
        return
    end

    local trailer = nil
    if is_own then
        trailer = g.get_lp_trailer and g.get_lp_trailer()
        if trailer and not trailer:IsDescendantOf(game) then trailer = nil end
    end

    local existing = Workspace:FindFirstChild(float_name)
    if existing then existing:Destroy() end
    g.Vehicle_Float_Running = true
    g.vehicle_float_height  = 0
    g.vehicle_floor_offset  = snapshot_floor_offset(car, anchor, trailer)
    inc = false
    dec = false
    local init_sx, init_sz = get_combined_bounds(car, trailer)
    local fp        = Instance.new("Part")
    fp.Name         = float_name
    fp.Size         = Vector3.new(init_sx or 24, 1, init_sz or 24)
    fp.Transparency = 1
    fp.Anchored     = true
    fp.CanCollide   = true
    fp.CastShadow   = false
    fp.Parent       = Workspace
    g.vehicle_float_part = fp

    lib.connect("vfloat_destroy_watch", car.AncestryChanged:Connect(function()
        if not car:IsDescendantOf(game) then
            silent_stop_float()
        end
    end))

    if not is_mobile then
        lib.connect("vfloat_input_began", UserInputService.InputBegan:Connect(function(i, gp)
            if gp then return end
            if i.KeyCode == Enum.KeyCode.Y then inc = true  end
            if i.KeyCode == Enum.KeyCode.T then dec = true  end
        end))
        lib.connect("vfloat_input_ended", UserInputService.InputEnded:Connect(function(i)
            if i.KeyCode == Enum.KeyCode.Y then inc = false end
            if i.KeyCode == Enum.KeyCode.T then dec = false end
        end))
    end

    lib.connect("vfloat_heartbeat", RunService.Heartbeat:Connect(function(dt)
        if not g.Vehicle_Float_Running then return end
        local fp_now = g.vehicle_float_part
        if not fp_now or not fp_now.Parent then return end
        local sitting_now = (g.get_vehicle and g.get_vehicle()) or (g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle())
        local own_now     = g.get_lp_vehicle and g.get_lp_vehicle()
        local car_now     = nil
        local is_own_now  = false

        if sitting_now and sitting_now:IsDescendantOf(game) then
            car_now    = sitting_now
            is_own_now = own_now ~= nil and own_now == sitting_now
        elseif own_now and own_now:IsDescendantOf(game) then
            car_now    = own_now
            is_own_now = true
        else
            silent_stop_float()
            return
        end

        local anchor_now = resolve_anchor(car_now)
        if not anchor_now or not anchor_now:IsDescendantOf(game) then
            silent_stop_float()
            return
        end

        local trailer_now = nil
        if is_own_now then
            trailer_now = g.get_lp_trailer and g.get_lp_trailer()
            if trailer_now and not trailer_now:IsDescendantOf(game) then trailer_now = nil end
        end

        local move_up   = false
        local move_down = false
        if is_mobile and control_module then
            local ok, mv = pcall(function() return control_module:GetMoveVector() end)
            if ok and mv then
                move_up   = mv.Z < -0.1
                move_down = mv.Z >  0.1
            end
        else
            move_up   = inc
            move_down = dec
        end

        local speed = 6
        if move_up then
            g.vehicle_float_height = g.vehicle_float_height + speed * dt
        elseif move_down then
            g.vehicle_float_height = math.max(0, g.vehicle_float_height - speed * dt)
        end

        local ref_y     = anchor_now.Position.Y + g.vehicle_floor_offset
        local part_half = fp_now.Size.Y * 0.5
        local target_y  = ref_y - part_half - 0.05 + g.vehicle_float_height
        local cx, cz, sx, sz = get_combined_bounds(car_now, trailer_now)
        if cx and cz and sx and sz then
            fp_now.Size   = Vector3.new(sx, 1, sz)
            fp_now.CFrame = CFrame.new(cx, target_y, cz)
        else
            fp_now.CFrame = CFrame.new(anchor_now.Position.X, target_y, anchor_now.Position.Z)
        end
    end))

    if is_mobile then
        g.notify("Success", "Vehicle float active. Forward = Up | Back = Down.", 5)
    else
        g.notify("Success", "Vehicle float active. Y = Up | T = Down.", 5)
    end
end

g.stop_vehicle_float = function()
    if not g.Vehicle_Float_Running then
        g.notify("Warning", "Vehicle float is not active.", 3)
        return
    end

    local car_now = (g.get_vehicle and g.get_vehicle()) or (g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()) or (g.get_lp_vehicle and g.get_lp_vehicle())
    if car_now then
        local anchor_now = resolve_anchor(car_now)
        if anchor_now and anchor_now:IsDescendantOf(game) then
            local fp_ref = g.vehicle_float_part
            if fp_ref and fp_ref.Parent then
                local snap_y  = fp_ref.Position.Y + fp_ref.Size.Y * 0.5 - g.vehicle_floor_offset + 0.1
                local current = anchor_now.CFrame
                pcall(function()
                    anchor_now.CFrame = CFrame.new(current.X, snap_y - g.vehicle_floor_offset, current.Z) * (current - current.Position)
                end)
            end
        end
    end
    silent_stop_float()
    g.notify("Success", "Vehicle float disabled.", 3)
end

g.toggle_vehicle_float = function()
    if g.Vehicle_Float_Running then
        g.stop_vehicle_float()
    else
        g.start_vehicle_float()
    end
end

g.teleport_vehicle = function(Target)
    if not Target then return end
    local Target_CFrame
    if typeof(Target) == "CFrame" then
        Target_CFrame = Target
    elseif typeof(Target) == "Vector3" then
        Target_CFrame = CFrame.new(Target)
    elseif typeof(Target) == "Instance" and Target:IsA("BasePart") then
        Target_CFrame = Target.CFrame
    elseif typeof(Target) == "Instance" and Target:IsA("Model") then
        if Target.PrimaryPart then
            Target_CFrame = Target.PrimaryPart.CFrame
        else
            local Part = Target:FindFirstChildWhichIsA("BasePart", true)
            if Part and Part:IsDescendantOf(workspace or game) then Target_CFrame = Part.CFrame end
        end
    end

    if not Target_CFrame then
        g.notify("Error", "Vehicle-Teleport: invalid target.", 3)
        return
    end

    local car = g.get_vehicle() or g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsDescendantOf(game or workspace) then
        g.notify("Error", "Vehicle-Teleport: no vehicle found.", 3)
        return
    end

    local anchor = car.PrimaryPart
    if not anchor then
        for _, v in ipairs(car:GetDescendants()) do
            if v:IsA("VehicleSeat") then
                anchor = v
                break
            end
        end
    end
    if not anchor then anchor = car:FindFirstChildWhichIsA("BasePart", true) end
    if not anchor or not anchor:IsDescendantOf(game or workspace) then
        g.notify("Error", "Vehicle-Teleport: could not resolve anchor.", 3)
        return
    end

    if car.PrimaryPart then
        pcall(function() car:PivotTo(Target_CFrame) end)
    else
        pcall(function() anchor.CFrame = Target_CFrame end)
    end
end

g.vehicle_tp_duration  = g.vehicle_tp_duration or 1
g.vehicle_tp_style     = g.vehicle_tp_style or Enum.EasingStyle.Linear
g.vehicle_tp_direction = g.vehicle_tp_direction or Enum.EasingDirection.Out
g.teleport_vehicle_tween = function(Target)
    if not Target then return end
    local Target_CFrame
    if typeof(Target) == "CFrame" then
        Target_CFrame = Target
    elseif typeof(Target) == "Vector3" then
        Target_CFrame = CFrame.new(Target)
    elseif typeof(Target) == "Instance" and Target:IsA("BasePart") then
        Target_CFrame = Target.CFrame
    elseif typeof(Target) == "Instance" and Target:IsA("Model") then
        if Target.PrimaryPart then
            Target_CFrame = Target.PrimaryPart.CFrame
        else
            local Part = Target:FindFirstChildWhichIsA("BasePart", true)
            if Part and Part:IsDescendantOf(workspace or game) then Target_CFrame = Part.CFrame end
        end
    end

    if not Target_CFrame then
        g.notify("Error", "Vehicle-Teleport: invalid target.", 3)
        return
    end

    local car = g.get_vehicle() or g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsDescendantOf(game or workspace) then
        g.notify("Error", "Vehicle-Teleport: no vehicle found.", 3)
        return
    end

    local anchor = car.PrimaryPart
    if not anchor then
        for _, v in ipairs(car:GetDescendants()) do
            if v:IsA("VehicleSeat") then
                anchor = v
                break
            end
        end
    end
    if not anchor then anchor = car:FindFirstChildWhichIsA("BasePart", true) end
    if not anchor or not anchor:IsDescendantOf(game or workspace) then
        g.notify("Error", "Vehicle-Teleport: could not resolve anchor.", 3)
        return
    end

    if g._vehicle_tp_tween then
        pcall(function() g._vehicle_tp_tween:Cancel() end)
        g._vehicle_tp_tween = nil
    end

    local Info = TweenInfo.new(
        g.vehicle_tp_duration,
        g.vehicle_tp_style,
        g.vehicle_tp_direction
    )

    local Tween = TweenService:Create(anchor, Info, { CFrame = Target_CFrame })
    g._vehicle_tp_tween = Tween
    Tween:Play()
    Tween.Completed:Connect(function()
        if car.PrimaryPart then pcall(function() car:PivotTo(Target_CFrame) end) end
        g._vehicle_tp_tween = nil
    end)
end

g.fully_upgrade_current_vehicle = function()
    local Stage = math.clamp(5, 0, 5)
    local car = g.get_vehicle()
    if not car or not car:IsA("Model") or not car:IsDescendantOf(game) then
        g.notify("Error", "Vehicle-Speed: No vehicle found.", 3)
        return
    end
    wait(0.1)
    local low_level_test = low_level_client()
    if low_level_test == false then
        local Tune_Script = car:FindFirstChild("A-Chassis Tune")
        if not Tune_Script or not Tune_Script:IsA("ModuleScript") or not Tune_Script.Parent then
            g.notify("Error", "Vehicle-Speed: No A-Chassis Tune found.", 3)
            return
        end

        local ok, Tune = pcall(require, Tune_Script)
        if not ok or type(Tune) ~= "table" then
            g.notify("Error", "Vehicle-Speed: failed to require tune.", 3)
            g.notify("Error", "Instead received response: "..tostring(Tune), 3)
            return
        end

        pcall(function() car:SetAttribute("Upgrade_Engine",       Stage) end)
        pcall(function() car:SetAttribute("Upgrade_Injectors",    Stage) end)
        pcall(function() car:SetAttribute("Upgrade_Turbo",        Stage) end)
        pcall(function() car:SetAttribute("Upgrade_Transmission", Stage) end)
        pcall(function() car:SetAttribute("Upgrade_Brakes",       Stage) end)
        local Upgrades_Module = g.Upgrades_ModuleScript_Found_RS or Find_Upgrades_ModuleScript_RS()
        if Upgrades_Module and Upgrades_Module:IsA("ModuleScript") then
            local ok2, Upgrades = pcall(require, Upgrades_Module)
            if ok2 and type(Upgrades) == "table" and Upgrades.Apply then pcall(Upgrades.Apply, Tune, car) end
        end
    else
        pcall(function() car:SetAttribute("Upgrade_Engine",       Stage) end)
        pcall(function() car:SetAttribute("Upgrade_Injectors",    Stage) end)
        pcall(function() car:SetAttribute("Upgrade_Turbo",        Stage) end)
        pcall(function() car:SetAttribute("Upgrade_Transmission", Stage) end)
        pcall(function() car:SetAttribute("Upgrade_Brakes",       Stage) end)
    end
end

g._vehicle_tune_cache = g._vehicle_tune_cache or {}
local function get_cached_tune(car, Tune)
    local cached = g._vehicle_tune_cache[car]
    if cached then return cached end
    local Stock = {
        car        = car,
        Horsepower = Tune.Horsepower,
        FinalDrive = Tune.FinalDrive,
        Redline    = Tune.Redline,
        PeakRPM    = Tune.PeakRPM,
        Ratios     = type(Tune.Ratios) == "table" and table.clone(Tune.Ratios) or nil,
    }
    g._vehicle_tune_cache[car] = Stock
    return Stock
end

local function validate_cache(car)
    local cached = g._vehicle_tune_cache[car]
    if not cached then return false end
    if cached.car ~= car then
        g._vehicle_tune_cache[car] = nil
        return false
    end
    if not cached.car:IsDescendantOf(game) then
        g._vehicle_tune_cache[car] = nil
        return false
    end
    return true
end

local function is_read_only_client() return executor_contains("xeno") and true or false end
g.set_vehicle_speed = function(Mult)
    Mult = Mult or 2
    local car = g.get_vehicle()
    if not car or not car:IsA("Model") or not car:IsDescendantOf(game) then
        g.notify("Error", "Vehicle-Speed: no vehicle found.", 3)
        return
    end
    wait(0.1)
    local Tune_Script = car:FindFirstChild("A-Chassis Tune")
    if not Tune_Script or not Tune_Script:IsA("ModuleScript") or not Tune_Script.Parent then
        g.notify("Error", "Vehicle-Speed: no A-Chassis Tune found.", 3)
        return
    end

    local ok, Tune = pcall(require, Tune_Script)
    if not ok or type(Tune) ~= "table" then
        g.notify("Error", "Vehicle-Speed: failed to require tune.", 3)
        return
    end

    local Stock = get_cached_tune(car, Tune)
    if is_read_only_client() then
        g.notify("Error", "Vehicle-Speed: client cannot write tune values.", 5)
        return
    end

    pcall(function() Tune.Horsepower = Stock.Horsepower * Mult end)
    pcall(function() Tune.Redline    = Stock.Redline    * Mult end)
    pcall(function() Tune.PeakRPM    = Stock.PeakRPM    * Mult end)
    pcall(function() Tune.FinalDrive = Stock.FinalDrive * Mult end)
    if type(Tune.Ratios) == "table" and type(Stock.Ratios) == "table" then
        for i = 1, #Stock.Ratios do
            pcall(function() Tune.Ratios[i] = Stock.Ratios[i] * Mult end)
        end
    end
end

g.reset_vehicle_speed = function()
    local car = g.get_vehicle()
    if not car or not car:IsA("Model") then return end
    if not validate_cache(car) then
        g.notify("Error", "Vehicle-Speed: cached vehicle is gone or changed.", 3)
        return
    end
    wait(0.1)
    local Tune_Script = car:FindFirstChild("A-Chassis Tune")
    if not Tune_Script or not Tune_Script:IsA("ModuleScript") or not Tune_Script.Parent then return end
    local ok, Tune = pcall(require, Tune_Script)
    if not ok or type(Tune) ~= "table" then return end
    local Stock = g._vehicle_tune_cache[car]
    if not Stock then return end
    if is_read_only_client() then
        g.notify("Error", "Vehicle-Speed: client cannot write tune values.", 5)
        return
    end

    pcall(function() Tune.Horsepower = Stock.Horsepower end)
    pcall(function() Tune.FinalDrive = Stock.FinalDrive end)
    pcall(function() Tune.Redline    = Stock.Redline    end)
    pcall(function() Tune.PeakRPM    = Stock.PeakRPM    end)
    if type(Tune.Ratios) == "table" and type(Stock.Ratios) == "table" then
        for i = 1, #Stock.Ratios do
            pcall(function() Tune.Ratios[i] = Stock.Ratios[i] end)
        end
    end

    g._vehicle_tune_cache[car] = nil
end

g.get_minimap_enabled = function()
    local minimap_toggle = speaker:GetAttribute("MinimapEnabled")
    return minimap_toggle ~= nil and minimap_toggle or false
end
wait(0.1)
g.minimap_currently_enabled = g.get_minimap_enabled()
g.toggle_minimap = function(state)
    local minimap_toggle = speaker:GetAttribute("MinimapEnabled")
    if minimap_toggle ~= nil then
        g.minimap_currently_enabled = state
        speaker:SetAttribute("MinimapEnabled", state)
    end
end

local function Find_Job_Sites_Folder()
    local cache = g.Job_Sites_Folder_Found_WS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("job") and v.Name:lower():find("sites") then
            g.Job_Sites_Folder_Found_WS = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not g.Job_Sites_Folder_Found_WS then pcall(function() Find_Job_Sites_Folder() end) end

local function calc_range(Brightness) return (Brightness * 8) + (Brightness * 2.5) end
local function lock_light(v, Stock, key)
    lib.connect("vlight_" .. key .. "_b", v:GetPropertyChangedSignal("Brightness"):Connect(function()
        if g._vehicle_light_writing then return end
        if v.Brightness ~= Stock.Target_Brightness then
            g._vehicle_light_writing = true
            pcall(function() v.Brightness = Stock.Target_Brightness end)
            g._vehicle_light_writing = false
        end
    end))
    lib.connect("vlight_" .. key .. "_r", v:GetPropertyChangedSignal("Range"):Connect(function()
        if g._vehicle_light_writing then return end
        if v.Range ~= Stock.Target_Range then
            g._vehicle_light_writing = true
            pcall(function() v.Range = Stock.Target_Range end)
            g._vehicle_light_writing = false
        end
    end))
end

local function unlock_light(key)
    lib.disconnect("vlight_" .. key .. "_b")
    lib.disconnect("vlight_" .. key .. "_r")
end

g.set_vehicle_lights = function(Brightness)
    local car = g.get_vehicle()
    if not car or not car:IsDescendantOf(game) then
        g.notify("Error", "Vehicle-Lights: no vehicle found.", 3)
        return
    end

    local Range = calc_range(Brightness)
    for i, v in ipairs(car:GetDescendants()) do
        if v:IsA("SpotLight") or v:IsA("PointLight") or v:IsA("SurfaceLight") then
            local key = tostring(i)
            if not g._vehicle_light_cache[v] then
                g._vehicle_light_cache[v] = {
                    instance         = v,
                    Brightness       = v.Brightness,
                    Range            = v.Range,
                    Target_Brightness = Brightness,
                    Target_Range      = Range,
                    key              = key,
                }
                lock_light(v, g._vehicle_light_cache[v], key)
            else
                g._vehicle_light_cache[v].Target_Brightness = Brightness
                g._vehicle_light_cache[v].Target_Range      = Range
            end

            g._vehicle_light_writing = true
            pcall(function() v.Brightness = Brightness end)
            pcall(function() v.Range      = Range      end)
            g._vehicle_light_writing = false
        end
    end
end

g.reset_vehicle_lights = function()
    for v, Stock in pairs(g._vehicle_light_cache) do
        if Stock.instance and Stock.instance:IsDescendantOf(game) then
            unlock_light(Stock.key)
            g._vehicle_light_writing = true
            pcall(function() Stock.instance.Brightness = Stock.Brightness end)
            pcall(function() Stock.instance.Range      = Stock.Range      end)
            g._vehicle_light_writing = false
        end
    end
    g._vehicle_light_cache = {}
end

g.fullbright_toggle = function(state)
	g.fullbright_enabled = state
	if state then
        Lighting.ClockTime = 14
		Lighting.Brightness = 3
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        lib.connect("day_time_cap", Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function() if g.fullbright_enabled and Lighting.ClockTime ~= 14 then Lighting.ClockTime = 14 end end))
        lib.connect("full_bright_cap", Lighting:GetPropertyChangedSignal("Brightness"):Connect(function() if g.fullbright_enabled and Lighting.Brightness ~= 3 then Lighting.Brightness = 3 end end))
        lib.connect("full_bright_ambient", Lighting:GetPropertyChangedSignal("Ambient"):Connect(function() if g.fullbright_enabled and Lighting.Ambient ~= Color3.fromRGB(255, 255, 255) then Lighting.Ambient = Color3.fromRGB(255, 255, 255) end end))
	else
        lib.disconnect("day_time_cap")
        lib.disconnect("full_bright_cap")
        lib.disconnect("full_bright_ambient")
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
	end
end

g.set_walkspeed_char = function(speed)
    if not Validate_Number(speed) then speed = 16 end
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game) then return end
    local human = g.Humanoid or char:FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
    if not human or not human.Parent or not human:IsDescendantOf(game) then return end
    human.WalkSpeed = speed or StarterPlayer.CharacterWalkSpeed
end

g.set_jump_power_height_char = function(speed)
    if not Validate_Number(speed) then speed = 16 end
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game) then return end
    local human = g.Humanoid or char:FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
    if not human or not human.Parent or not human:IsDescendantOf(game) then return end
    local Use_Jump_Power = StarterPlayer.CharacterUseJumpPower or true
    if Use_Jump_Power then
        human.JumpPower = speed or StarterPlayer.CharacterJumpPower
    else
        human.JumpHeight = speed or StarterPlayer.CharacterJumpHeight
    end
end

g.FlyEnabled = g.FlyEnabled or false
g.FlySpeed = g.FlySpeed or 1
g.QEfly = (g.QEfly == nil) and true or g.QEfly
g.flyKeyDown = g.flyKeyDown or nil
g.flyKeyUp = g.flyKeyUp or nil
g.mobileFlyConn = g.mobileFlyConn or nil
g.pcFlyConn = g.pcFlyConn or nil
g.EnableFly = g.EnableFly or function(state, speed, vfly)
    if g.FlyEnabled then
        if speed and tonumber(speed) then
            g.FlySpeed = tonumber(speed)
            g.notify("Success", "Fly speed updated to: "..tostring(g.FlySpeed), 3)
            return
        end
        g.notify("Warning", "Fly is already enabled! Provide a speed to update it.", 5)
        return 
    end

    local char = g.Character or speaker.Character or g.get_char(speaker)
    local hrp = g.HumanoidRootPart or char and char:FindFirstChild("HumanoidRootPart") or g.get_root(speaker)
    local hum = g.Humanoid or char and char:FindFirstChildOfClass("Humanoid") or g.get_human(speaker)
    local cam = workspace.CurrentCamera
    if not hrp or not hum or not hum.Parent or not hrp.Parent or not hum:IsDescendantOf(game) then g.notify("Error", "Character is not ready or Humanoid doesn't exist.", 3); return end
    if not state then
        g.DisableFly()
        return
    end

    if speed and tonumber(speed) then g.FlySpeed = tonumber(speed) end
    g.FlyEnabled = true
    if g.FlyKeyDown then g.FlyKeyDown:Disconnect(); g.FlyKeyDown = nil end
    if g.FlyKeyUp then g.FlyKeyUp:Disconnect(); g.FlyKeyUp = nil end
    if g.PCFlyConn then g.PCFlyConn:Disconnect(); g.PCFlyConn = nil end
    if g.MobileFlyConn then g.MobileFlyConn:Disconnect(); g.MobileFlyConn = nil end
    if hrp and hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
    if hrp and hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end

    local BG = Instance.new("BodyGyro")
    BG.P = 9e4
    BG.MaxTorque = Vector3.new(9e9,9e9,9e9)
    BG.CFrame = hrp.CFrame
    BG.Name = "FlyGyro"
    BG.Parent = hrp

    local BV = Instance.new("BodyVelocity")
    BV.MaxForce = Vector3.new(9e9,9e9,9e9)
    BV.Velocity = Vector3.zero
    BV.Name = "FlyVelocity"
    BV.Parent = hrp

    if hum and hum.Parent and hum:IsDescendantOf(game) then hum.PlatformStand = true end
    if not IsMobile then
        local CONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}
        g.PCFlyConn = RunService.RenderStepped:Connect(function(dt)
            if not g.FlyEnabled then return end
            if not cam or not hrp or not hum then return end
            local SpeedNow = ((vfly and (g.VehicleFlySpeed or g.FlySpeed)) or g.FlySpeed) * 50
            local look = cam.CFrame
            local move_vec = ((look.LookVector * (CONTROL.F + CONTROL.B)) + ((look * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.Q + CONTROL.E) * 0.2, 0)).Position - look.Position))
            if move_vec.Magnitude > 0 then
                move_vec = move_vec.Unit
                BV.Velocity = move_vec * SpeedNow
            else
                BV.Velocity = BV.Velocity * 0.9
            end

            BG.CFrame = cam.CFrame
        end)

        g.FlyKeyDown = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == Enum.KeyCode.W then CONTROL.F = 1 end
            if input.KeyCode == Enum.KeyCode.S then CONTROL.B = -1 end
            if input.KeyCode == Enum.KeyCode.A then CONTROL.L = -1 end
            if input.KeyCode == Enum.KeyCode.D then CONTROL.R = 1 end
            if g.QEfly then
                if input.KeyCode == Enum.KeyCode.E then CONTROL.Q = 1 end
                if input.KeyCode == Enum.KeyCode.Q then CONTROL.E = -1 end
            end
            pcall(function() cam.CameraType = Enum.CameraType.Track end)
        end)

        g.FlyKeyUp = UserInputService.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then CONTROL.F = 0 end
            if input.KeyCode == Enum.KeyCode.S then CONTROL.B = 0 end
            if input.KeyCode == Enum.KeyCode.A then CONTROL.L = 0 end
            if input.KeyCode == Enum.KeyCode.D then CONTROL.R = 0 end
            if input.KeyCode == Enum.KeyCode.E then CONTROL.Q = 0 end
            if input.KeyCode == Enum.KeyCode.Q then CONTROL.E = 0 end
        end)

        g.notify("Success", "Fly enabled (PC) | Speed: "..tostring(g.FlySpeed), 5)
        return
    end

    local ok, ControlModule = pcall(function() return require(speaker:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule")) end)
    if not ok or not ControlModule then
        g.notify("Warning", "ControlModule unavailable; using simple touch fallback.", 5)
        g.MobileFlyConn = RunService.RenderStepped:Connect(function()
            if not g.FlyEnabled then return end
            BG.CFrame = cam.CFrame
            BV.Velocity = Vector3.zero
        end)
        return
    end

    g.MobileFlyConn = RunService.RenderStepped:Connect(function()
        if not g.FlyEnabled then return end
        if not hrp or not hum or not cam then return end
        BG.CFrame = cam.CFrame
        local direction = ControlModule:GetMoveVector()
        local SpeedScaled = ((vfly and (g.VehicleFlySpeed or g.FlySpeed)) or g.FlySpeed) * 50
        if direction.Magnitude > 0 then
            BV.Velocity = (cam.CFrame.LookVector * -direction.Z + cam.CFrame.RightVector * direction.X) * SpeedScaled
        else
            BV.Velocity = Vector3.zero
        end
    end)
    g.notify("Success", "Fly enabled (Mobile) | Speed: "..tostring(g.FlySpeed), 5)
end

g.DisableFly = g.DisableFly or function()
    if not g.FlyEnabled then g.notify("Warning", "Fly is not enabled!", 3); return end
    g.FlyEnabled = false
    if g.FlyKeyDown then g.FlyKeyDown:Disconnect(); g.FlyKeyDown = nil end
    if g.FlyKeyUp then g.FlyKeyUp:Disconnect(); g.FlyKeyUp = nil end
    if g.PCFlyConn then g.PCFlyConn:Disconnect(); g.PCFlyConn = nil end
    if g.MobileFlyConn then g.MobileFlyConn:Disconnect(); g.MobileFlyConn = nil end
    local char = g.Character or speaker.Character or g.get_char(speaker)
    local hrp = g.HumanoidRootPart or char:FindFirstChild("HumanoidRootPart") or g.get_root(speaker)
    local hum = g.Humanoid or char:FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
    if hrp and hrp.Parent then
        if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
        if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
    end

    if hum and hum.Parent and hum:IsDescendantOf(game) then hum.PlatformStand = false end
    g.notify("Success", "Fly is now disabled.", 3)
end

g.Set_Max_Zoom_Distance = function(distance)
    if not Validate_Number(distance) then distance = StarterPlayer.CameraMaxZoomDistance end
    pcall(function() speaker.CameraMaxZoomDistance = distance end)
end

local Atlas = loadstring(g.http_get("https://gitlab.com/flames2431233/Starter/-/raw/main/UIs/Atlas.lua?ref_type=heads", true))()
local UI = Atlas.new({
    Name = "Flames Hub | Carolina Leaners | "..tostring(g.Script_Version),
    ConfigFolder = "FlamesHub_Carolina_Leaners_Menu_Configuration",
    Color = Color3.fromRGB(21, 103, 251),
    Credit = "Flames Hub",
    Bind = "RightShift",
})
wait(0.25)
g.create_ui_element = g.create_ui_element or function(element_type, parent, config, global_name, flag)
    local creators = {
        Tab         = function() return parent:CreatePage(config) end,
        Section     = function() return parent:CreateSection(config) end,
        Toggle      = function() return parent:CreateToggle(config, flag) end,
        Slider      = function() return parent:CreateSlider(config, flag) end,
        Button      = function() return parent:CreateButton(config, flag) end,
        ColorPicker = function() return parent:CreateColorPicker(config, flag) end,
        Input       = function() return parent:CreateTextBox(config, flag) end,
        Dropdown    = function() return parent:CreateDropdown(config, flag) end,
        Label       = function() return parent:CreateLabel(config, flag) end,
    }

    local creator = creators[element_type]
    if not creator then return g.notify("Error", "Unknown element type: " .. tostring(element_type), 1) end
    local element
    local done = false
    task.defer(function()
        element = creator()
        done = true
    end)

    while not done do task.wait() end
    if global_name then g[global_name] = element end
    return element
end
wait(0.25)
local Home_Page = UI:CreatePage("Main")
local Home_Section = Home_Page:CreateSection("Main")
local LocalPlayer_Section = Home_Page:CreateSection("LocalPlayer")
local Lighting_Section = Home_Page:CreateSection("Lighting")
local Vehicles_Section = Home_Page:CreateSection("Vehicles")
local UI_Section = Home_Page:CreateSection("UI")

g.create_ui_element("Toggle", Home_Section, {
Name = "Minimap Toggle",
Default = g.get_minimap_enabled() or false,
Flag = "Minimap_Toggle_UI",
Callback = function(state)
    g.toggle_minimap(state)
end}, "Minimap_Toggle_UI")

g.create_ui_element("Toggle", Lighting_Section, {
Name = "Fullbright",
Default = g.fullbright_enabled or false,
Flag = "Fullbright_Toggle_UI",
Callback = function(state)
    g.fullbright_toggle(state)
end}, "Fullbright_Toggle_UI")

g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Walk With Vehicles Menu Opened",
Default = g.walking_with_vehicles_menu_opened or false,
Flag = "Walk_Vehicles_Menu_Toggle_UI",
Callback = function(state)
    g.allow_walking_with_vehicles_menu_opened(state)
end}, "Walk_Vehicles_Menu_Toggle_UI")

g.create_ui_element("Button", Vehicles_Section, {
Name = "Hit All LampPosts Near You (FE)",
Callback = function()
    g.Hit_All_Lamp_Posts()
end,})

g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Hit Down All Poles Near You (FE) (BUGGY!)",
Default = g.Knocking_Down_All_Poles or false,
Flag = "Hit_Down_All_Poles_Near_LP_Toggle_UI",
Callback = function(state)
    g.Hit_Down_All_Poles_Near_LP(state)
end}, "Hit_Down_All_Poles_Near_LP_Toggle_UI")

g.create_ui_element("Slider", LocalPlayer_Section, {
Name = "WalkSpeed (FE)",
Min = 16 or StarterPlayer.CharacterWalkSpeed,
Max = 300,
Default = StarterPlayer.CharacterWalkSpeed or 16,
Flag = "WalkSpeed_Slider_UI",
Callback = function(val)
    g.set_walkspeed_char(val)
end}, "WalkSpeed_Slider_UI")

g.create_ui_element("Slider", LocalPlayer_Section, {
Name = "Jump Power / Height (FE)",
Min = StarterPlayer.CharacterUseJumpPower and StarterPlayer.CharacterJumpPower or StarterPlayer.CharacterJumpHeight or 50,
Max = 300,
Default = StarterPlayer.CharacterJumpPower or 50,
Flag = "Jump_Power_Height_Slider_UI",
Callback = function(val)
    g.set_jump_power_height_char(val)
end}, "Jump_Power_Height_Slider_UI")

g.create_ui_element("Slider", LocalPlayer_Section, {
Name = "Max Camera Zoom Distance",
Min = StarterPlayer.CameraMaxZoomDistance or 128,
Max = 9999,
Default = StarterPlayer.CameraMaxZoomDistance or 128,
Flag = "Max_Zoom_Distance_Slider_UI",
Callback = function(val)
    g.Set_Max_Zoom_Distance(val)
end}, "Max_Zoom_Distance_Slider_UI")

g.create_ui_element("Slider", LocalPlayer_Section, {
Name = "Fly Speed",
Min = 1,
Max = 100,
Default = g.Fly_Speed_Value or 3,
Flag = "Fly_Speed_Slider_UI",
Callback = function(val)
    g.Fly_Speed_Value = val
end}, "Fly_Speed_Slider_UI")

g.Fly_Toggle_UI = g.create_ui_element("Toggle", LocalPlayer_Section, {
Name = "Fly (FE)",
Default = g.FlyEnabled or false,
Flag = "Fly_Toggle_UI",
Callback = function(state)
    if state then
        if g.FlyEnabled then g.notify("Error", "Fly is already enabled!", 5); return end
        if g.Enabled_Flying then g.notify("Error", "Another fly is already enabled!", 5); return end
        local char = g.Character or speaker.Character or g.get_char(speaker)
        if not char or not char:IsDescendantOf(game) then g.notify("Error", "Character is not ready.", 3); return end
        local human = g.Humanoid or char and char:FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
        if not human or not human.Parent or not human:IsDescendantOf(game) then g.notify("Error", "Character is not ready or Humanoid doesn't exist.", 3); return end
        local veh = g.get_lp_vehicle and g.get_lp_vehicle()
        local in_vehicle = veh and veh.Parent and veh:IsDescendantOf(game) and human.Sit and human.SeatPart and human.SeatPart:IsDescendantOf(veh)
        if in_vehicle then
            g.notify("Error", "Cannot enable fly while in a vehicle.", 3)
            g.FlyEnabled = false
            g.Enabled_Flying = false
            if g.Fly_Toggle_UI then g.Fly_Toggle_UI:Set(false, false) end
            return
        end
        if human.Sit then
            local seat_part = human.SeatPart
            if seat_part and seat_part.Parent and seat_part:IsDescendantOf(game) then
                g.notify("Error", "Cannot enable fly while seated.", 3)
                g.FlyEnabled = false
                g.Enabled_Flying = false
                if g.Fly_Toggle_UI then g.Fly_Toggle_UI:Set(false, false) end
                return
            end
        end
        local speed = g.Fly_Speed_Value or nil
        g.EnableFly(true, speed)
        if UserInputService.TouchEnabled then
            g.notify("Success", "Fly is now currently active..", 3)
        else
            g.notify("Success", "E = up, Q = down, WASD to move.", 3)
        end
    else
        g.DisableFly()
    end
end}, "Fly_Toggle_UI")

g.Vehicle_Float_Toggle_UI = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Vehicle Float (FE)",
Default = g.Vehicle_Float_Running or false,
Flag = "Vehicle_Float_Toggle_UI",
Callback = function(state)
    if state then
        if g.Vehicle_Float_Running then
            g.notify("Error", "Vehicle float is already enabled.", 3)
            return
        end
        local human = g.Humanoid or (g.Character or speaker.Character) and (g.Character or speaker.Character):FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
        if not human or not human.Sit then
            g.notify("Error", "You must be in a vehicle to use Vehicle Float.", 3)
            g.Vehicle_Float_Running = false
            if g.Vehicle_Float_Toggle_UI then g.Vehicle_Float_Toggle_UI:Set(false, false) end
            return
        end
        local veh = g.get_vehicle() or g.Get_Current_Sitting_In_Vehicle()
        if not veh or not veh:IsA("Model") or not veh:IsDescendantOf(game) then
            g.notify("Error", "No vehicle detected.", 3)
            g.Vehicle_Float_Running = false
            if g.Vehicle_Float_Toggle_UI then g.Vehicle_Float_Toggle_UI:Set(false, false) end
            return
        end
        g.start_vehicle_float()
    else
        g.stop_vehicle_float()
    end
end}, "Vehicle_Float_Toggle_UI")

g.Disable_Pole_Collision_Toggle_UI = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Disable Pole Collision (FE)",
Default = g.Disable_Pole_Collision_State or false,
Flag = "Disable_Pole_Collision_Toggle_UI_1",
Callback = function(state)
    g.Disable_Pole_Collision(state)
end}, "Disable_Pole_Collision_Toggle_UI_1")

g.create_ui_element("Button", Vehicles_Section, {
Name = "Toggle All Players Car Doors (FE)",
Callback = function()
    g.Fire_All_Doors()
end,})

g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Vehicle Engine State (On/Off)",
Default = false,
Flag = "Vehicle_State_Toggle_UI",
Callback = function(state)
    g.toggle_vehicle_state(state)
end}, "Vehicle_State_Toggle_UI")

g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Car Alarm (FE)",
Default = false,
Flag = "Car_Alarm_Toggle_UI",
Callback = function(state)
    g.toggle_car_alarm(state)
end}, "Car_Alarm_Toggle_UI")

g.Vehicle_Fly_Toggle_UI = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Vehicle Fly (FE)",
Default = g.vehicle_fly or false,
Flag = "Vehicle_Fly_Toggle_UI",
Callback = function(state)
    g.toggle_vehicle_fly()
end}, "Vehicle_Fly_Toggle_UI")
wait(0.25)
if g.vehicle_fly then pcall(function() g.stop_vehicle_fly() end) end
if g.Vehicle_Fly_Toggle_UI then g.Vehicle_Fly_Toggle_UI:Set(false, false) end

g.create_ui_element("Slider", Vehicles_Section, {
Name = "Vehicle Fly Speed",
Min = 1,
Max = 50,
Default = g.vehicle_fly_speed or 3,
Flag = "Vehicle_Fly_Speed_Slider_UI",
Callback = function(val)
    g.vehicle_fly_speed = val
end}, "Vehicle_Fly_Speed_Slider_UI")

local function get_color_names()
    local names = {}
    for name in pairs(g.all_available_colors) do table.insert(names, name) end
    table.sort(names)
    return names
end

g.create_ui_element("Dropdown", Vehicles_Section, {
Name = "Paint Vehicle Color (FE)",
Options = get_color_names(),
DefaultItemSelected = "None",
ItemSelecting = false,
Flag = "Vehicle_Paint_Dropdown_UI",
Callback = function(selected)
    local hex = g.all_available_colors[selected]
    if not hex then g.notify("Error", "Unknown color selected.", 2.5); return end
    g.Apply_Paint_Customization(hex)
    g.notify("Success", "Painting vehicle: " ..tostring(selected), 1)
end}, "Vehicle_Paint_Dropdown_UI")

local low_level = low_level_client()
if low_level == false then
    g.create_ui_element("Slider", Vehicles_Section, {
    Name = "Vehicle Speed Multiplier",
    Min = 1,
    Max = 50,
    Default = 1,
    Flag = "Vehicle_Speed_Slider_UI",
    Callback = function(val)
        g.set_vehicle_speed(val)
    end}, "Vehicle_Speed_Slider_UI")

    g.create_ui_element("Button", Vehicles_Section, {
    Name = "Reset Vehicle Speed",
    Callback = function()
        g.reset_vehicle_speed()
    end,})
end

g.create_ui_element("Button", UI_Section, {
Name = "Destroy GUI",
Callback = function()
    if g.stop_vehicle_fly and typeof(g.stop_vehicle_fly) == "function" then g.stop_vehicle_fly() end
    if g.Vehicle_Fly_Toggle_UI then g.Vehicle_Fly_Toggle_UI:Set(false, false) end
    if g.Vehicle_Float_Toggle_UI then g.Vehicle_Float_Toggle_UI:Set(false, false) end
    if g.stop_vehicle_float and typeof(g.stop_vehicle_float) == "function" then g.stop_vehicle_float() end
    pcall(function() UI:Destroy() end)
end,})

g.create_ui_element("Button", Vehicles_Section, {
Name = "Fully Upgrade Vehicle",
Callback = function()
    g.fully_upgrade_current_vehicle()
end,})

g.create_ui_element("Slider", Vehicles_Section, {
Name = "Vehicle Lights Brightness",
Min = 1,
Max = 20,
Default = 1,
Flag = "Vehicle_Lights_Slider_UI",
Callback = function(val)
    g.set_vehicle_lights(val)
end}, "Vehicle_Lights_Slider_UI")

g.create_ui_element("Button", Vehicles_Section, {
Name = "Reset Vehicle Lights",
Callback = function()
    g.reset_vehicle_lights()
end})

g.create_ui_element("Button", Vehicles_Section, {
Name = "Despawn Current Vehicle (FE)",
Callback = function()
    g.despawn_current_vehicle()
end,})

g.create_ui_element("Input", Vehicles_Section, {
Name = "Teleport Vehicle To Position (FE)",
PlaceholderText = "X, Y, Z",
Flag = "Vehicle_Teleport_Input_UI",
Callback = function(input)
    local x, y, z = input:match("([%-%.%d]+),%s*([%-%.%d]+),%s*([%-%.%d]+)")
    if not x or not y or not z then
        g.notify("Error", "Invalid format. Use: X, Y, Z", 3)
        return
    end
    g.teleport_vehicle(Vector3.new(tonumber(x), tonumber(y), tonumber(z)))
end}, "Vehicle_Teleport_Input_UI")

g.create_ui_element("Input", Vehicles_Section, {
Name = "Teleport Vehicle To Player (FE)",
PlaceholderText = "Player name",
Flag = "Vehicle_Teleport_Player_UI",
Callback = function(input)
    if not input or input == "" then
        g.notify("Error", "Enter a player name.", 3)
        return
    end
    local target_player = g.findplr(input)
    if not target_player then
        g.notify("Error", "Player not found.", 3)
        return
    end
    local target_char = target_player.Character or g.get_char(target_player)
    if not target_char or not target_char:IsDescendantOf(game or workspace) then
        g.notify("Error", "Target character is not loaded.", 3)
        return
    end
    local target_root = target_char and target_char:FindFirstChild("HumanoidRootPart") or g.get_root(target_player)
    if not target_root or not target_root.Parent then
        g.notify("Error", "Could not resolve target HumanoidRootPart.", 3)
        return
    end
    g.teleport_vehicle(target_root.CFrame)
end}, "Vehicle_Teleport_Player_UI")

g.vehicle_return_delay = g.vehicle_return_delay or 3
g.vehicle_saved_return_cf = g.vehicle_saved_return_cf or nil
g.create_ui_element("Input", Vehicles_Section, {
Name = "Teleport Vehicle & Return (FE)",
PlaceholderText = "X, Y, Z",
Flag = "Vehicle_Teleport_Return_UI",
Callback = function(input)
    local x, y, z = input:match("([%-%.%d]+),%s*([%-%.%d]+),%s*([%-%.%d]+)")
    if not x or not y or not z then
        g.notify("Error", "Invalid format. Use: X, Y, Z", 3)
        return
    end
    local hrp = g.HumanoidRootPart or g.Character and g.Character:FindFirstChild("HumanoidRootPart") or g.get_root(speaker)
    if not hrp or not hrp.Parent then
        g.notify("Error", "Could not resolve HumanoidRootPart.", 3)
        return
    end
    local saved_cf = hrp.CFrame
    g.vehicle_saved_return_cf = saved_cf
    g.teleport_vehicle(Vector3.new(tonumber(x), tonumber(y), tonumber(z)))
    task.delay(g.vehicle_return_delay, function()
        if not g.vehicle_saved_return_cf then return end
        local car = g.get_vehicle() or g.Get_Current_Sitting_In_Vehicle()
        if not car or not car:IsDescendantOf(game or workspace) then
            g.vehicle_saved_return_cf = nil
            return
        end
        g.teleport_vehicle(g.vehicle_saved_return_cf)
        wait(0.15)
        g.vehicle_saved_return_cf = nil
    end)
    g.notify("Info", "Returning in: " .. g.vehicle_return_delay .. " second(s).", g.vehicle_return_delay)
end}, "Vehicle_Teleport_Return_UI")

local location_map = {}
local location_names = {}
local function get_all_job_sites()
    local job_sites = g.Job_Sites_Folder_Found_WS or Find_Job_Sites_Folder()
    if not job_sites or not job_sites:IsA("Folder") then return {}, {} end
    for _, v in ipairs(job_sites:GetDescendants()) do
        if v:IsA("BasePart") then
            location_map[v.Name] = v.CFrame * CFrame.new(0, 5, 0)
            table.insert(location_names, v.Name)
        end
    end
    return location_map, location_names
end

g.create_ui_element("Dropdown", Vehicles_Section, {
Name = "TP Vehicle To Job Site (FE)",
Options = (function() local _, names = get_all_job_sites(); return names end)(),
DefaultItemSelected = "None",
ItemSelecting = false,
Flag = "Vehicle_Teleport_Dropdown_UI",
Callback = function(selected)
    local location_map = get_all_job_sites()
    local target = location_map[selected]
    if not target then g.notify("Error", "Unknown location selected.", 2.5); return end
    g.teleport_vehicle(target)
    g.notify("Success", "Teleporting vehicle to: " .. tostring(selected), 3)
end}, "Vehicle_Teleport_Dropdown_UI")

g.create_ui_element("Slider", Vehicles_Section, {
Name = "Teleport Duration / Time",
Min = 0,
Max = 10,
Default = g.vehicle_tp_duration or 1,
Flag = "Vehicle_TP_Duration_Slider_UI",
Callback = function(val)
    g.vehicle_tp_duration = val
end}, "Vehicle_TP_Duration_Slider_UI")