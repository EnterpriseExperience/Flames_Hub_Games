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
local place_id = "118580801709155"
local In_Studio = false
local g
if game:GetService("RunService"):IsStudio() then
    g = valid_t(_G) or {}
    In_Studio = true
else
    g = (getgenv and getgenv()) or valid_t(_G)
end
task.wait(0.25)
if game:GetService("RunService"):IsServer() then
    warn("This script can only be run on the client.")
    return
end

if tostring(game.PlaceId) ~= place_id then
    if g.notify and typeof(g.notify) == "function" then
        g.notify("Error", "This game is not supported. Run this on Carolina Leaners only.", 30)
        return
    else
        warn("This game is not supported. Run this on Carolina Leaners only.")
        return
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
local Announcement_Message = "ADDED AUTO FARM! (only supports Hay Hauling FOR NOW!) + it even lifts you over the hills, mountains and stuff, plus it buys a Vehicle for you if you don't own any."
g.displayTimeMax = 45
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
local CoreGui = g.CoreGui or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local HttpService = g.HttpService or cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local TeleportService = g.TeleportService or cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
local speaker = g.LocalPlayer or Players.LocalPlayer or Players:GetAttributeChangedSignal("LocalPlayer"):Wait()
local PlayerGui = g.PlayerGui or speaker:FindFirstChildOfClass("PlayerGui") or speaker:FindFirstChildWhichIsA("PlayerGui")
local lib = g.FlamesLibrary or getgenv().FlamesLibrary
local FL = lib
local FlamesLibrary = lib
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local is_mobile = IsMobile
local Raw_Version = "V2.1.7"
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
local function disable_folder_poles(folder, target_color)
    if not folder or not folder:IsA("Folder") then return end
    for _, v in ipairs(folder:GetChildren()) do
        if v:IsA("Model") then
            local matched = false
            for _, child in ipairs(v:GetChildren()) do
                if child:IsA("BasePart") and child.Color == target_color then
                    matched = true
                    break
                end
            end
            if matched then
                for _, part in ipairs(v:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if not g.Pole_Collision_Cache[part] then
                            g.Pole_Collision_Cache[part] = {
                                CanCollide = part.CanCollide,
                                CanQuery   = part.CanQuery,
                                CanTouch   = part.CanTouch,
                            }
                        end
                        part.CanCollide = false
                        part.CanQuery   = false
                        part.CanTouch   = false
                    end
                end
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
        disable_folder_poles(Roads,     Color3.fromRGB(86,  66,  54))
        disable_folder_poles(Buildings, Color3.fromRGB(163, 162, 165))
        disable_folder_poles(Roads,     Color3.fromRGB(27, 42, 53))
        task.wait(0.15)
        lib.connect("pole_collision_disable", RunService.Heartbeat:Connect(function()
            local Roads     = g.Roads_Folder_Found_WS     or Find_Roads_Folder_WS()
            local Buildings = g.Buildings_Folder_Found_WS or Find_Buildings_Folder_WS()
            disable_folder_poles(Roads,     Color3.fromRGB(86,  66,  54))
            disable_folder_poles(Buildings, Color3.fromRGB(163, 162, 165))
            disable_folder_poles(Roads,     Color3.fromRGB(27, 42, 53))
        end))
    else
        lib.disconnect("pole_collision_disable")
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

function Format_UserName(player)
    if player.DisplayName ~= player.Name then return string.format("%s (%s)", player.Name, player.DisplayName) end
    return player.Name
end
wait(0.1)
g.Format_UserName = Format_UserName

local target_group = 15286501
local watched_attrs = {"IdentityLabel", "IdentityTag"}
local staff_roles = {
	"mod", "admin", "staff", "dev", "founder", "owner",
	"supervis", "manager", "management", "executive",
	"president", "chairman", "chairwoman", "chairperson",
	"director",
}

g.Staffwatch_Teleport_Check = true
local function get_staff_role(player)
    if not player or not player:IsDescendantOf(game) then return { Role = "Unknown", Staff = false } end
    local ok, player_role = pcall(function() return player:GetRoleInGroup(target_group) end)
    if not ok or not player_role then return { Role = "Unknown", Staff = false } end
    local result = { Role = player_role, Staff = false }
    local ok2, in_roblox = pcall(function() return player:IsInGroup(1200769) end)
    if ok2 and in_roblox then
        result.Role = "Roblox Employee"
        result.Staff = true
    end
    for _, role in pairs(staff_roles) do
        if string.find(string.lower(player_role), role) then
            result.Staff = true
        end
    end
    return result
end

local function is_identity_mod(player)
	for _, attr_name in ipairs(watched_attrs) do
		local val = player:GetAttribute(attr_name)
		if type(val) == "string" and string.find(string.lower(val), "moderator") then
			return true, attr_name
		end
	end
	return false, nil
end

local function hop()
	local place_id = game.PlaceId
	local job_id = game.JobId
	local servers = {}
	local fetch_ok, res = pcall(game.HttpGet, game,"https://games.roblox.com/v1/games/" .. place_id .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
	if not fetch_ok then
		g.notify("Error", "Server request failed.", 3)
		return
	end

	local parse_ok, body = pcall(HttpService.JSONDecode, HttpService, res)
	if not parse_ok or not body or not body.data then
		g.notify("Error", "Server list parse failed.", 3)
		return
	end

	for _, v in next, body.data do
		if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= job_id then
			table.insert(servers, 1, v.id)
		end
	end

	if #servers > 0 then
		TeleportService:TeleportToPlaceInstance(place_id, servers[math.random(1, #servers)], Players.LocalPlayer)
	else
		g.notify("Error", "No available servers found.", 3)
	end
end

local function bind_attr_watch(player)
	for _, attr_name in ipairs(watched_attrs) do
		local conn_name = "staffwatch_attr_" .. tostring(player.UserId) .. "_" .. attr_name
		FL.connect(conn_name, player:GetAttributeChangedSignal(attr_name):Connect(function()
			local flagged, hit_attr = is_identity_mod(player)
			if flagged then
				g.notify("Warning", Format_UserName(player).." flagged as moderator via " .. hit_attr .. ". Hopping.", 5)
				hop()
			end
		end))
	end
end

FL.connect("staffwatch_join", Players.PlayerAdded:Connect(function(player)
	local result = get_staff_role(player)
	if result.Staff then
		g.notify("Warning", Format_UserName(player) .. " joined as " .. result.Role .. ". Hopping.", 5)
		hop()
		return
	end
	local flagged, hit_attr = is_identity_mod(player)
	if flagged then
		g.notify("Warning", Format_UserName(player) .. " joined flagged via " .. hit_attr .. ". Hopping.", 5)
		hop()
		return
	end
	bind_attr_watch(player)
end))

FL.connect("staffwatch_leaving", Players.PlayerRemoving:Connect(function(player)
	for _, attr_name in ipairs(watched_attrs) do FL.disconnect("staffwatch_attr_" .. tostring(player.UserId) .. "_" .. attr_name) end
end))

if queueteleport and typeof(queueteleport) == "function" then
    FL.connect("staffwatch_teleport", Players.LocalPlayer.OnTeleport:Connect(function(state)
        if not g.Staffwatch_Teleport_Check and queueteleport and typeof(queueteleport) == "function" then
            g.Staffwatch_Teleport_Check = true
            queueteleport("loadstring(game:HttpGet('https://gitlab.com/flames2431233/Starter/-/raw/main/Experiences/118580801709155.lua?ref_type=heads'))()")
        end
    end))
end

local found = {}
for _, player in ipairs(Players:GetPlayers()) do
    if not player:IsDescendantOf(game) then continue end
    local result = get_staff_role(player)
    if result.Staff then
        table.insert(found, Format_UserName(player) .. " — " .. result.Role)
    else
        local flagged, hit_attr = is_identity_mod(player)
        if flagged then
            table.insert(found, Format_UserName(player) .. " — moderator (" .. hit_attr .. ")")
        else
            bind_attr_watch(player)
        end
    end
end

if #found > 0 then
	g.notify("Warning", table.concat(found, ",\n") .. "\nHopping server.", 5)
	hop()
else
	g.notify("Success", "Staff-Watch V2 has been enabled for this session.", 5)
end

FlamesLibrary.spawn("gameplay_pause_kill_watcher", "Heartbeat", function()
    local PAUSE_THRESHOLD = 15
    local streaming_ok, streaming = pcall(function() return Workspace.StreamingEnabled end)
    if not streaming_ok or not streaming then
        print("StreamingEnabled is off — watcher aborted.")
        return
    end

    local pause_start = nil
    local triggered = false
    FlamesLibrary.connect("gameplay_pause_kill_loop", RunService.Heartbeat:Connect(function()
        local speaker = Players.LocalPlayer
        if not speaker then return end
        local ok, paused = pcall(function() return speaker.GameplayPaused end)
        if not ok then
            pause_start = nil
            triggered = false
            return
        end

        if paused == true then
            if not pause_start then
                pause_start = tick()
                triggered = false
            end

            if not triggered and (tick() - pause_start) >= PAUSE_THRESHOLD then
                triggered = true
                local human = g.get_human and g.get_human(speaker) or g.Humanoid
                if not human or not human.Parent or not human:IsDescendantOf(game) then return end
                local kill_ok, kill_err = pcall(function() human.Health = 0 end)
                if not kill_ok then
                    warn("[Error]: Kill trigger failed: "..tostring(kill_err))
                else
                    warn("[Success]: GameplayPaused threshold hit — executed.")
                end
            end
        else
            pause_start = nil
            triggered = false
        end
    end))
end)

if hookmetamethod and checkcaller and typeof(hookmetamethod) == "function" and typeof(checkcaller) == "function" then
    local lp = speaker
    local hooks = {
        walkspeed = StarterPlayer.CharacterWalkSpeed or 16,
        jumppower = StarterPlayer.CharacterJumpPower or 50,
        jumpheight = StarterPlayer.CharacterJumpHeight or 7.2
    }
    local index
    local newindex
    index = hookmetamethod(game,"__index",function(self,property)
        if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and hooks[property:lower()] then return hooks[property:lower()] end
        return index(self,property)
    end)

    newindex = hookmetamethod(game,"__newindex",function(self,property,value)
        if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and hooks[property:lower()] then return value end
        return newindex(self,property,value)
    end)
end
wait(0.15)
local PROXIMITY_RADIUS_ROADS = 100
local PROXIMITY_RADIUS_BUILDINGS = 100
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
            if part and (part.Color == Color3.fromRGB(86, 66, 54) or part.Color == Color3.fromRGB(27, 42, 53)) then
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

local re_fuzzy_cache = g.re_fuzzy_cache or {}
g.re_fuzzy_cache = re_fuzzy_cache
local function fuzzy_score(haystack, needle)
    if haystack == needle then return math.huge end
    if haystack:find(needle, 1, true) then return 1000 end
    local score, j = 0, 1
    for i = 1, #needle do
        local c = needle:sub(i, i)
        local idx = haystack:find(c, j, true)
        if idx then
            score = score + (100 - idx)
            j     = idx + 1
        else
            score = score - 15
        end
    end
    return score
end

local function find_remote(name)
    local key = name:lower()
    local cached = re_fuzzy_cache[key]
    if cached and typeof(cached) == "Instance" and cached:IsDescendantOf(game) then return cached end
    local best, best_score = nil, -math.huge
    local ok, descendants = pcall(function() return ReplicatedStorage:GetDescendants() end)
    if not ok or not descendants then return nil end
    for _, v in ipairs(descendants) do
        local ok2, is_re = pcall(function() return v:IsA("RemoteEvent") end)
        if ok2 and is_re then
            local s = fuzzy_score(v.Name:lower(), key)
            if s > best_score then
                best_score = s
                best       = v
            end
        end
    end
    if best and best_score > 0 then
        re_fuzzy_cache[key] = best
        return best
    end
    return nil
end
wait(0.1)
if not g.Exploit_Warning_Bypass_Executed then
    if hookmetamethod and newcclosure and typeof(newcclosure) == "function" and typeof(hookmetamethod) == "function" then
        g.Exploit_Warning_Bypass_Executed = true
        local target_remote = find_remote("ExploitWarning")
        if target_remote and target_remote:IsA("RemoteEvent") then
            local original
            original = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
                if self == target_remote and getnamecallmethod() == "FireServer" then return end
                return original(self, ...)
            end))
        end
        wait(0.1)
        pcall(function() target_remote:Destroy() end)
    else
        g.Exploit_Warning_Bypass_Executed = true
        local target_remote = find_remote("ExploitWarning")
        if target_remote and target_remote:IsA("RemoteEvent") then pcall(function() target_remote:Destroy() end) end
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

g.infinite_premium = function()
    if g.GET_LOADED_IY then g.notify("Warning", "You already have Infinite Premium running.", 5); return end
    if g.IY_LOADED then g.notify("Warning", "You already have Infinite Yield running! You cannot and should NOT run both at the same time.", 10); return end
    loadstring(g.http_get('https://pastefy.app/b052AUgc/raw'))()
end

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

g.start_vehicle_glitch_script = function()
    if g.VehicleSideGlitch_Enabled then
        g.notify("Warning", "Flames Hub | Vehicle glitch is already enabled!", 3)
        return
    end

    local car = g.get_vehicle() or g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsDescendantOf(game or workspace) then
        g.notify("Error", "Flames Hub | No vehicle found.", 3)
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
        g.notify("Error", "Flames Hub | Could not resolve vehicle anchor.", 3)
        return
    end

    local use_pivot   = car.PrimaryPart ~= nil
    local locked_origin = anchor.CFrame
    local last_flip   = 0
    local dir         = 1
    g.VehicleSideGlitch_Enabled = true
    FlamesLibrary.connect("VehicleSideGlitch_Loop", RunService.RenderStepped:Connect(function()
        if not g.VehicleSideGlitch_Enabled then return end
        if not car or not car:IsDescendantOf(game or workspace) then
            g.stop_vehicle_glitch_script()
            return
        end

        local now      = tick()
        local speed    = math.clamp(g.VehicleSideGlitch_Speed or 25, 1, 100)
        local distance = g.VehicleSideGlitch_Distance or 5
        local interval = 1 / speed
        if now - last_flip >= interval then
            dir       = -dir
            last_flip = now
        end

        local right     = locked_origin.RightVector
        local target_cf = CFrame.new(locked_origin.Position + right * (dir * distance)) * (locked_origin - locked_origin.Position)
        if use_pivot then
            pcall(function() car:PivotTo(target_cf) end)
        else
            pcall(function() anchor.CFrame = target_cf end)
        end
    end))

    FlamesLibrary.connect("VehicleSideGlitch_Restore", RunService.RenderStepped:Connect(function()
        if g.VehicleSideGlitch_Enabled then return end
        if not car or not car:IsDescendantOf(game or workspace) then
            FlamesLibrary.disconnect("VehicleSideGlitch_Restore")
            return
        end
        local ok, current_pos = pcall(function() return anchor.CFrame.Position end)
        if not ok then
            FlamesLibrary.disconnect("VehicleSideGlitch_Restore")
            return
        end
        if (current_pos - locked_origin.Position).Magnitude > 0.05 then
            if use_pivot then
                pcall(function() car:PivotTo(locked_origin) end)
            else
                pcall(function() anchor.CFrame = locked_origin end)
            end
        else
            FlamesLibrary.disconnect("VehicleSideGlitch_Restore")
        end
    end))
end

g.stop_vehicle_glitch_script = function()
    g.VehicleSideGlitch_Enabled = false
    FlamesLibrary.disconnect("VehicleSideGlitch_Loop")
    FlamesLibrary.disconnect("VehicleSideGlitch_Restore")
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

g.start_vehicle_orbit = function()
    if g.VehicleOrbit_Enabled then
        g.notify("Warning", "Flames Hub | Vehicle orbit is already enabled!", 3)
        return
    end

    local car = g.get_vehicle() or g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsDescendantOf(game or workspace) then
        g.notify("Error", "Flames Hub | No vehicle found.", 3)
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
        g.notify("Error", "Flames Hub | Could not resolve vehicle anchor.", 3)
        return
    end

    local use_pivot      = car.PrimaryPart ~= nil
    local locked_origin  = anchor.CFrame.Position
    local locked_y       = anchor.CFrame.Position.Y
    local angle          = 0
    local last_t         = tick()
    g.VehicleOrbit_Enabled = true
    FlamesLibrary.connect("VehicleOrbit_Loop", RunService.RenderStepped:Connect(function()
        if not g.VehicleOrbit_Enabled then return end
        if not car or not car:IsDescendantOf(game or workspace) then
            g.stop_vehicle_orbit()
            return
        end

        local now      = tick()
        local dt       = now - last_t
        last_t         = now
        local speed    = math.clamp(g.VehicleOrbit_Speed or 20, 1, 100)
        local radius   = math.clamp(g.VehicleOrbit_Radius or 15, 1, 100)
        local rad_per_sec = (speed / 100) * (2 * math.pi) * 1.5
        angle = angle + rad_per_sec * dt
        local offset_x   = math.cos(angle) * radius
        local offset_z   = math.sin(angle) * radius
        local new_pos    = Vector3.new(locked_origin.X + offset_x, locked_y, locked_origin.Z + offset_z)
        local tangent_x  = -math.sin(angle)
        local tangent_z  =  math.cos(angle)
        local look_dir   = Vector3.new(tangent_x, 0, tangent_z).Unit
        local target_cf  = CFrame.lookAt(new_pos, new_pos + look_dir)
        if use_pivot then
            pcall(function() car:PivotTo(target_cf) end)
        else
            pcall(function() anchor.CFrame = target_cf end)
        end
    end))
end

g.stop_vehicle_orbit = function()
    g.VehicleOrbit_Enabled = false
    FlamesLibrary.disconnect("VehicleOrbit_Loop")
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

g.graphics_enhancer_active = g.graphics_enhancer_active or false
g.graphics_enhancer_original = g.graphics_enhancer_original or nil
g.graphics_enhancer_instances = g.graphics_enhancer_instances or nil
g.night_enhancer_active = g.night_enhancer_active or false
g.night_enhancer_original = g.night_enhancer_original or nil
g.night_enhancer_instances = g.night_enhancer_instances or nil
local preset = {
    ClockTime               = 14,
    Brightness              = 4,
    Ambient                 = Color3.fromRGB(0, 0, 0),
    OutdoorAmbient          = Color3.fromRGB(112, 117, 128),
    ExposureCompensation    = 0.15,
    ColorShift_Top          = Color3.fromRGB(20, 20, 30),
    ColorShift_Bottom       = Color3.fromRGB(0, 0, 0),
    GlobalShadows           = true,
    ShadowSoftness          = 0.12,
    FogEnd                  = 100000,
    FogColor                = Color3.fromRGB(132, 132, 132),
    cc_brightness           = 0.1,
    cc_contrast             = 0.15,
    cc_saturation           = 0.25,
    cc_tint                 = Color3.fromRGB(255, 222, 211),
    bloom_intensity         = 0.1,
    bloom_size              = 32,
    bloom_threshold         = 1,
    sunrays_intensity       = 0.35,
    sunrays_spread          = 1,
    blur_size               = 2.75,
    atmosphere_density      = 0.06,
    atmosphere_color        = Color3.fromRGB(180, 210, 255),
    atmosphere_decay        = Color3.fromRGB(255, 220, 180),
    atmosphere_glare        = 0.1,
    atmosphere_haze         = 0.2,
    sky_sun_angular_size    = 21,
    sky_moon_angular_size   = 11,
    sky_star_count          = 0,
    sky_celestial_bodies    = true,
    terrain_water_color         = Color3.fromRGB(10, 10, 24),
    terrain_water_wave_size     = 0.15,
    terrain_water_wave_speed    = 22,
    terrain_water_transparency  = 1,
    terrain_water_reflectance   = 0.05,
}

local night_preset = {
    ClockTime               = 0,
    Brightness              = 3,
    Ambient                 = Color3.fromRGB(55, 55, 80),
    OutdoorAmbient          = Color3.fromRGB(70, 75, 110),
    ExposureCompensation    = 0.3,
    ColorShift_Top          = Color3.fromRGB(30, 30, 60),
    ColorShift_Bottom       = Color3.fromRGB(10, 10, 20),
    GlobalShadows           = true,
    ShadowSoftness          = 0.2,
    FogEnd                  = 80000,
    FogColor                = Color3.fromRGB(20, 20, 40),
    cc_brightness           = 0.05,
    cc_contrast             = 0.15,
    cc_saturation           = -0.05,
    cc_tint                 = Color3.fromRGB(180, 190, 255),
    bloom_intensity         = 0.3,
    bloom_size              = 32,
    bloom_threshold         = 0.9,
    sunrays_intensity       = 0.0,
    sunrays_spread          = 0.0,
    blur_size               = 1,
    atmosphere_density      = 0.2,
    atmosphere_color        = Color3.fromRGB(17, 17, 46),
    atmosphere_decay        = Color3.fromRGB(28, 28, 39),
    atmosphere_glare        = 0.0,
    atmosphere_haze         = 0.4,
    sky_sun_angular_size    = 0,
    sky_moon_angular_size   = 18,
    sky_star_count          = 3000,
    sky_celestial_bodies    = true,
    terrain_water_color         = Color3.fromRGB(5, 5, 20),
    terrain_water_wave_size     = 0.1,
    terrain_water_wave_speed    = 15,
    terrain_water_transparency  = 0.8,
    terrain_water_reflectance   = 0.2,
}

local function Capture_Original()
    local snap = {
        ClockTime            = Lighting.ClockTime,
        Brightness           = Lighting.Brightness,
        Ambient              = Lighting.Ambient,
        OutdoorAmbient       = Lighting.OutdoorAmbient,
        ExposureCompensation = Lighting.ExposureCompensation,
        ColorShift_Top       = Lighting.ColorShift_Top,
        ColorShift_Bottom    = Lighting.ColorShift_Bottom,
        GlobalShadows        = Lighting.GlobalShadows,
        ShadowSoftness       = Lighting.ShadowSoftness,
        FogEnd               = Lighting.FogEnd,
        FogColor             = Lighting.FogColor,
    }
    local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmo then
        snap.atmo_density = atmo.Density
        snap.atmo_color   = atmo.Color
        snap.atmo_decay   = atmo.Decay
        snap.atmo_glare   = atmo.Glare
        snap.atmo_haze    = atmo.Haze
    end
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky then
        snap.sky_sun_angular_size  = sky.SunAngularSize
        snap.sky_moon_angular_size = sky.MoonAngularSize
        snap.sky_star_count        = sky.StarCount
        snap.sky_celestial_bodies  = sky.CelestialBodiesShown
        snap.sky_existed           = true
    else
        snap.sky_existed = false
    end
    local ter = workspace.Terrain
    snap.terrain_water_color        = ter.WaterColor
    snap.terrain_water_wave_size    = ter.WaterWaveSize
    snap.terrain_water_wave_speed   = ter.WaterWaveSpeed
    snap.terrain_water_transparency = ter.WaterTransparency
    snap.terrain_water_reflectance  = ter.WaterReflectance
    return snap
end

local function Kill_Existing_Effects()
    for _, child in ipairs(Lighting:GetChildren()) do
        local n = child.Name
        if n == "GFX_ColorCorrection"
        or n == "GFX_Bloom"
        or n == "GFX_SunRays"
        or n == "GFX_Blur"
        or n == "GFX_Atmosphere"
        or n == "GFX_Sky" then
            child:Destroy()
        end
    end
end

local function Build_Effects()
    Kill_Existing_Effects()

    local cc = Instance.new("ColorCorrectionEffect")
    cc.Name       = "GFX_ColorCorrection"
    cc.Brightness = preset.cc_brightness
    cc.Contrast   = preset.cc_contrast
    cc.Saturation = preset.cc_saturation
    cc.TintColor  = preset.cc_tint
    cc.Parent     = Lighting

    local bloom = Instance.new("BloomEffect")
    bloom.Name      = "GFX_Bloom"
    bloom.Intensity = preset.bloom_intensity
    bloom.Size      = preset.bloom_size
    bloom.Threshold = preset.bloom_threshold
    bloom.Parent    = Lighting

    local sun = Instance.new("SunRaysEffect")
    sun.Name      = "GFX_SunRays"
    sun.Intensity = preset.sunrays_intensity
    sun.Spread    = preset.sunrays_spread
    sun.Parent    = Lighting

    local blur = Instance.new("BlurEffect")
    blur.Name   = "GFX_Blur"
    blur.Size   = preset.blur_size
    blur.Parent = Lighting

    local existing_atmo = Lighting:FindFirstChildOfClass("Atmosphere")
    local atmo = existing_atmo or Instance.new("Atmosphere")
    atmo.Name    = "GFX_Atmosphere"
    atmo.Density = preset.atmosphere_density
    atmo.Color   = preset.atmosphere_color
    atmo.Decay   = preset.atmosphere_decay
    atmo.Glare   = preset.atmosphere_glare
    atmo.Haze    = preset.atmosphere_haze
    if not existing_atmo then atmo.Parent = Lighting end

    local existing_sky = Lighting:FindFirstChildOfClass("Sky")
    local sky = existing_sky or Instance.new("Sky")
    sky.Name                = "GFX_Sky"
    sky.SunAngularSize      = preset.sky_sun_angular_size
    sky.MoonAngularSize     = preset.sky_moon_angular_size
    sky.StarCount           = preset.sky_star_count
    sky.CelestialBodiesShown = preset.sky_celestial_bodies
    if not existing_sky then sky.Parent = Lighting end

    local ter = Workspace.Terrain
    ter.WaterColor        = preset.terrain_water_color
    ter.WaterWaveSize     = preset.terrain_water_wave_size
    ter.WaterWaveSpeed    = preset.terrain_water_wave_speed
    ter.WaterTransparency = preset.terrain_water_transparency
    ter.WaterReflectance  = preset.terrain_water_reflectance
    return { cc = cc, bloom = bloom, sun = sun, blur = blur, atmo = atmo, sky = sky }
end

local function Lock_Properties()
    lib.connect("gfx_clock", Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
        if g.graphics_enhancer_active and Lighting.ClockTime ~= preset.ClockTime then
            Lighting.ClockTime = preset.ClockTime
        end
    end))
    lib.connect("gfx_bright", Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
        if g.graphics_enhancer_active and Lighting.Brightness ~= preset.Brightness then
            Lighting.Brightness = preset.Brightness
        end
    end))
    lib.connect("gfx_ambient", Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
        if g.graphics_enhancer_active and Lighting.Ambient ~= preset.Ambient then
            Lighting.Ambient = preset.Ambient
        end
    end))
    lib.connect("gfx_outdooramb", Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
        if g.graphics_enhancer_active and Lighting.OutdoorAmbient ~= preset.OutdoorAmbient then
            Lighting.OutdoorAmbient = preset.OutdoorAmbient
        end
    end))
    lib.connect("gfx_fogend", Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
        if g.graphics_enhancer_active and Lighting.FogEnd ~= preset.FogEnd then
            Lighting.FogEnd = preset.FogEnd
        end
    end))
end

local function Unlock_Properties()
    lib.disconnect("gfx_clock")
    lib.disconnect("gfx_bright")
    lib.disconnect("gfx_ambient")
    lib.disconnect("gfx_outdooramb")
    lib.disconnect("gfx_fogend")
end

local function Restore_Original()
    local orig = g.graphics_enhancer_original
    if not orig then return end
    Lighting.ClockTime            = orig.ClockTime
    Lighting.Brightness           = orig.Brightness
    Lighting.Ambient              = orig.Ambient
    Lighting.OutdoorAmbient       = orig.OutdoorAmbient
    Lighting.ExposureCompensation = orig.ExposureCompensation
    Lighting.ColorShift_Top       = orig.ColorShift_Top
    Lighting.ColorShift_Bottom    = orig.ColorShift_Bottom
    Lighting.GlobalShadows        = orig.GlobalShadows
    Lighting.ShadowSoftness       = orig.ShadowSoftness
    Lighting.FogEnd               = orig.FogEnd
    Lighting.FogColor             = orig.FogColor
    local atmo = Lighting:FindFirstChild("GFX_Atmosphere") or Lighting:FindFirstChildOfClass("Atmosphere")
    if atmo and orig.atmo_density ~= nil then
        atmo.Density = orig.atmo_density
        atmo.Color   = orig.atmo_color
        atmo.Decay   = orig.atmo_decay
        atmo.Glare   = orig.atmo_glare
        atmo.Haze    = orig.atmo_haze
    end
    local sky = Lighting:FindFirstChild("GFX_Sky") or Lighting:FindFirstChildOfClass("Sky")
    if sky then
        if orig.sky_existed then
            sky.SunAngularSize       = orig.sky_sun_angular_size
            sky.MoonAngularSize      = orig.sky_moon_angular_size
            sky.StarCount            = orig.sky_star_count
            sky.CelestialBodiesShown = orig.sky_celestial_bodies
            sky.Name                 = "Sky"
        else
            sky:Destroy()
        end
    end
    local ter = Workspace.Terrain
    ter.WaterColor        = orig.terrain_water_color
    ter.WaterWaveSize     = orig.terrain_water_wave_size
    ter.WaterWaveSpeed    = orig.terrain_water_wave_speed
    ter.WaterTransparency = orig.terrain_water_transparency
    ter.WaterReflectance  = orig.terrain_water_reflectance
end

g.Toggle_Graphics_Enhancer = function(state)
    if g.fullbright_enabled then
        g.fullbright_toggle(false)
        if g.FullBright_Main_Toggle_UI then g.FullBright_Main_Toggle_UI:Set(false, false) end
    end
    if g.night_enhancer_active then
        g.Toggle_Night_Enhancer(false)
        if g.Night_Enhancer_Main_Toggle_UI then g.Night_Enhancer_Main_Toggle_UI:Set(false, false) end
    end
    if state == g.graphics_enhancer_active then return false, "already_in_requested_state" end
    if state then
        g.graphics_enhancer_original  = Capture_Original()
        Lighting.ClockTime            = preset.ClockTime
        Lighting.Brightness           = preset.Brightness
        Lighting.Ambient              = preset.Ambient
        Lighting.OutdoorAmbient       = preset.OutdoorAmbient
        Lighting.ExposureCompensation = preset.ExposureCompensation
        Lighting.ColorShift_Top       = preset.ColorShift_Top
        Lighting.ColorShift_Bottom    = preset.ColorShift_Bottom
        Lighting.GlobalShadows        = preset.GlobalShadows
        Lighting.ShadowSoftness       = preset.ShadowSoftness
        Lighting.FogEnd               = preset.FogEnd
        Lighting.FogColor             = preset.FogColor
        g.graphics_enhancer_instances = Build_Effects()
        Lock_Properties()
        g.graphics_enhancer_active = true
        if g.notify and typeof(g.notify) == "function" then g.notify("Success", "Graphics Enhancer enabled.", 3) end
    else
        Unlock_Properties()
        Kill_Existing_Effects()
        Restore_Original()
        g.graphics_enhancer_instances = nil
        g.graphics_enhancer_original  = nil
        g.graphics_enhancer_active    = false
        if g.notify and typeof(g.notify) == "function" then g.notify("Info", "Graphics Enhancer disabled.", 3) end
    end
    return true
end

g.Set_Graphics_Enhancer_Value = function(key, value)
    if preset[key] == nil then return false, "unknown_key" end
    preset[key] = value
    if g.graphics_enhancer_active then
        g.Toggle_Graphics_Enhancer(false)
        g.Toggle_Graphics_Enhancer(true)
    end
    return true
end

local function Night_Capture_Original()
    local snap = {
        ClockTime            = Lighting.ClockTime,
        Brightness           = Lighting.Brightness,
        Ambient              = Lighting.Ambient,
        OutdoorAmbient       = Lighting.OutdoorAmbient,
        ExposureCompensation = Lighting.ExposureCompensation,
        ColorShift_Top       = Lighting.ColorShift_Top,
        ColorShift_Bottom    = Lighting.ColorShift_Bottom,
        GlobalShadows        = Lighting.GlobalShadows,
        ShadowSoftness       = Lighting.ShadowSoftness,
        FogEnd               = Lighting.FogEnd,
        FogColor             = Lighting.FogColor,
    }
    local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmo then
        snap.atmo_density = atmo.Density
        snap.atmo_color   = atmo.Color
        snap.atmo_decay   = atmo.Decay
        snap.atmo_glare   = atmo.Glare
        snap.atmo_haze    = atmo.Haze
    end
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky then
        snap.sky_sun_angular_size  = sky.SunAngularSize
        snap.sky_moon_angular_size = sky.MoonAngularSize
        snap.sky_star_count        = sky.StarCount
        snap.sky_celestial_bodies  = sky.CelestialBodiesShown
        snap.sky_existed           = true
    else
        snap.sky_existed = false
    end
    local ter = Workspace.Terrain
    snap.terrain_water_color        = ter.WaterColor
    snap.terrain_water_wave_size    = ter.WaterWaveSize
    snap.terrain_water_wave_speed   = ter.WaterWaveSpeed
    snap.terrain_water_transparency = ter.WaterTransparency
    snap.terrain_water_reflectance  = ter.WaterReflectance
    return snap
end

local function Night_Kill_Effects()
    for _, child in ipairs(Lighting:GetChildren()) do
        local n = child.Name
        if n == "NIGHT_ColorCorrection"
        or n == "NIGHT_Bloom"
        or n == "NIGHT_SunRays"
        or n == "NIGHT_Blur"
        or n == "NIGHT_Atmosphere"
        or n == "NIGHT_Sky" then
            child:Destroy()
        end
    end
end

local function Night_Build_Effects()
    Night_Kill_Effects()
    local cc = Instance.new("ColorCorrectionEffect")
    cc.Name       = "NIGHT_ColorCorrection"
    cc.Brightness = night_preset.cc_brightness
    cc.Contrast   = night_preset.cc_contrast
    cc.Saturation = night_preset.cc_saturation
    cc.TintColor  = night_preset.cc_tint
    cc.Parent     = Lighting

    local bloom = Instance.new("BloomEffect")
    bloom.Name      = "NIGHT_Bloom"
    bloom.Intensity = night_preset.bloom_intensity
    bloom.Size      = night_preset.bloom_size
    bloom.Threshold = night_preset.bloom_threshold
    bloom.Parent    = Lighting

    local sun = Instance.new("SunRaysEffect")
    sun.Name      = "NIGHT_SunRays"
    sun.Intensity = night_preset.sunrays_intensity
    sun.Spread    = night_preset.sunrays_spread
    sun.Parent    = Lighting

    local blur = Instance.new("BlurEffect")
    blur.Name   = "NIGHT_Blur"
    blur.Size   = night_preset.blur_size
    blur.Parent = Lighting

    local existing_atmo = Lighting:FindFirstChildOfClass("Atmosphere")
    local atmo = existing_atmo or Instance.new("Atmosphere")
    atmo.Name    = "NIGHT_Atmosphere"
    atmo.Density = night_preset.atmosphere_density
    atmo.Color   = night_preset.atmosphere_color
    atmo.Decay   = night_preset.atmosphere_decay
    atmo.Glare   = night_preset.atmosphere_glare
    atmo.Haze    = night_preset.atmosphere_haze
    if not existing_atmo then atmo.Parent = Lighting end

    local existing_sky = Lighting:FindFirstChildOfClass("Sky")
    local sky = existing_sky or Instance.new("Sky")
    sky.Name                 = "NIGHT_Sky"
    sky.SunAngularSize       = night_preset.sky_sun_angular_size
    sky.MoonAngularSize      = night_preset.sky_moon_angular_size
    sky.StarCount            = night_preset.sky_star_count
    sky.CelestialBodiesShown = night_preset.sky_celestial_bodies
    if not existing_sky then sky.Parent = Lighting end

    local ter = Workspace.Terrain
    ter.WaterColor        = night_preset.terrain_water_color
    ter.WaterWaveSize     = night_preset.terrain_water_wave_size
    ter.WaterWaveSpeed    = night_preset.terrain_water_wave_speed
    ter.WaterTransparency = night_preset.terrain_water_transparency
    ter.WaterReflectance  = night_preset.terrain_water_reflectance
    return { cc = cc, bloom = bloom, sun = sun, blur = blur, atmo = atmo, sky = sky }
end

local function Night_Lock_Properties()
    lib.connect("night_clock", Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
        if g.night_enhancer_active and Lighting.ClockTime ~= night_preset.ClockTime then
            Lighting.ClockTime = night_preset.ClockTime
        end
    end))
    lib.connect("night_bright", Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
        if g.night_enhancer_active and Lighting.Brightness ~= night_preset.Brightness then
            Lighting.Brightness = night_preset.Brightness
        end
    end))
    lib.connect("night_ambient", Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
        if g.night_enhancer_active and Lighting.Ambient ~= night_preset.Ambient then
            Lighting.Ambient = night_preset.Ambient
        end
    end))
    lib.connect("night_outdooramb", Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
        if g.night_enhancer_active and Lighting.OutdoorAmbient ~= night_preset.OutdoorAmbient then
            Lighting.OutdoorAmbient = night_preset.OutdoorAmbient
        end
    end))
    lib.connect("night_fogend", Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
        if g.night_enhancer_active and Lighting.FogEnd ~= night_preset.FogEnd then
            Lighting.FogEnd = night_preset.FogEnd
        end
    end))
end

local function Night_Unlock_Properties()
    lib.disconnect("night_clock")
    lib.disconnect("night_bright")
    lib.disconnect("night_ambient")
    lib.disconnect("night_outdooramb")
    lib.disconnect("night_fogend")
end

local function Night_Restore_Original()
    local orig = g.night_enhancer_original
    if not orig then return end
    Lighting.ClockTime            = orig.ClockTime
    Lighting.Brightness           = orig.Brightness
    Lighting.Ambient              = orig.Ambient
    Lighting.OutdoorAmbient       = orig.OutdoorAmbient
    Lighting.ExposureCompensation = orig.ExposureCompensation
    Lighting.ColorShift_Top       = orig.ColorShift_Top
    Lighting.ColorShift_Bottom    = orig.ColorShift_Bottom
    Lighting.GlobalShadows        = orig.GlobalShadows
    Lighting.ShadowSoftness       = orig.ShadowSoftness
    Lighting.FogEnd               = orig.FogEnd
    Lighting.FogColor             = orig.FogColor
    local atmo = Lighting:FindFirstChild("NIGHT_Atmosphere") or Lighting:FindFirstChildOfClass("Atmosphere")
    if atmo and orig.atmo_density ~= nil then
        atmo.Density = orig.atmo_density
        atmo.Color   = orig.atmo_color
        atmo.Decay   = orig.atmo_decay
        atmo.Glare   = orig.atmo_glare
        atmo.Haze    = orig.atmo_haze
    end
    local sky = Lighting:FindFirstChild("NIGHT_Sky") or Lighting:FindFirstChildOfClass("Sky")
    if sky then
        if orig.sky_existed then
            sky.SunAngularSize       = orig.sky_sun_angular_size
            sky.MoonAngularSize      = orig.sky_moon_angular_size
            sky.StarCount            = orig.sky_star_count
            sky.CelestialBodiesShown = orig.sky_celestial_bodies
            sky.Name                 = "Sky"
        else
            sky:Destroy()
        end
    end
    local ter = Workspace.Terrain
    ter.WaterColor        = orig.terrain_water_color
    ter.WaterWaveSize     = orig.terrain_water_wave_size
    ter.WaterWaveSpeed    = orig.terrain_water_wave_speed
    ter.WaterTransparency = orig.terrain_water_transparency
    ter.WaterReflectance  = orig.terrain_water_reflectance
end

g.Toggle_Night_Enhancer = function(state)
    if g.fullbright_enabled then
        g.fullbright_toggle(false)
        if g.FullBright_Main_Toggle_UI then g.FullBright_Main_Toggle_UI:Set(false, false) end
    end
    if g.graphics_enhancer_active then
        g.Toggle_Graphics_Enhancer(false)
        if g.Graphics_Enhancer_Main_Toggle_UI then g.Graphics_Enhancer_Main_Toggle_UI:Set(false, false) end
    end
    if state == g.night_enhancer_active then return false, "already_in_requested_state" end
    if state then
        g.night_enhancer_original     = Night_Capture_Original()
        Lighting.ClockTime            = night_preset.ClockTime
        Lighting.Brightness           = night_preset.Brightness
        Lighting.Ambient              = night_preset.Ambient
        Lighting.OutdoorAmbient       = night_preset.OutdoorAmbient
        Lighting.ExposureCompensation = night_preset.ExposureCompensation
        Lighting.ColorShift_Top       = night_preset.ColorShift_Top
        Lighting.ColorShift_Bottom    = night_preset.ColorShift_Bottom
        Lighting.GlobalShadows        = night_preset.GlobalShadows
        Lighting.ShadowSoftness       = night_preset.ShadowSoftness
        Lighting.FogEnd               = night_preset.FogEnd
        Lighting.FogColor             = night_preset.FogColor
        g.night_enhancer_instances    = Night_Build_Effects()
        Night_Lock_Properties()
        g.night_enhancer_active = true
        if g.notify and typeof(g.notify) == "function" then g.notify("Success", "Night Enhancer enabled.", 3) end
    else
        Night_Unlock_Properties()
        Night_Kill_Effects()
        Night_Restore_Original()
        g.night_enhancer_instances = nil
        g.night_enhancer_original  = nil
        g.night_enhancer_active    = false
        if g.notify and typeof(g.notify) == "function" then g.notify("Info", "Night Enhancer disabled.", 3) end
    end
    return true
end

g.target_walkspeed = g.target_walkspeed or 16
g.target_jump_power = g.target_jump_power or 50
g.target_jump_height = g.target_jump_height or 7.2
g.set_walkspeed_char = function(speed)
    if not Validate_Number(speed) then speed = 16 end
    g.target_walkspeed = speed
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game) then return end
    local human = g.Humanoid or char:FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
    if not human or not human.Parent or not human:IsDescendantOf(game) then return end
    human.WalkSpeed = speed
end

g.set_jump_power_height_char = function(value)
    local Use_Jump_Power = StarterPlayer.CharacterUseJumpPower or true
    if Use_Jump_Power then
        if not Validate_Number(value) then value = g.target_jump_power end
        g.target_jump_power = value
    else
        if not Validate_Number(value) then value = g.target_jump_height end
        g.target_jump_height = value
    end
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game) then return end
    local human = g.Humanoid or char:FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
    if not human or not human.Parent or not human:IsDescendantOf(game) then return end
    if Use_Jump_Power then
        human.JumpPower = value
    else
        human.JumpHeight = value
    end
end

g.start_movement_lock = function()
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game) then return end
    local human = g.Humanoid or char:FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
    if not human or not human.Parent or not human:IsDescendantOf(game) then return end
    FlamesLibrary.connect("movement_lock_walkspeed", human:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if human.WalkSpeed ~= g.target_walkspeed then
            human.WalkSpeed = g.target_walkspeed
        end
    end))

    local Use_Jump_Power = StarterPlayer.CharacterUseJumpPower or true
    if Use_Jump_Power then
        FlamesLibrary.connect("movement_lock_jump", human:GetPropertyChangedSignal("JumpPower"):Connect(function()
            if human.JumpPower ~= g.target_jump_power then
                human.JumpPower = g.target_jump_power
            end
        end))
    else
        FlamesLibrary.connect("movement_lock_jump", human:GetPropertyChangedSignal("JumpHeight"):Connect(function()
            if human.JumpHeight ~= g.target_jump_height then
                human.JumpHeight = g.target_jump_height
            end
        end))
    end
end

g.stop_movement_lock = function()
    FlamesLibrary.disconnect("movement_lock_walkspeed")
    FlamesLibrary.disconnect("movement_lock_jump")
end

g.start_movement_lock()

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
            g.notify("Success", "Fly speed updated to: "..tostring(g.FlySpeed), 1)
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

local BUDGET_VEHICLE_NAME = "2002 Raymo 2500 5.9 Cobbins"
local FARM_COORDS = Vector3.new(1045, 7, 958)
local DROP1_COORDS = Vector3.new(-737, 7, 374)
local DROP2_COORDS = Vector3.new(-1750, 7, 2439)
local DROP_ZONE_CF = CFrame.new(
    -734.186767578125, 3.587284564971924, 378.3937683105469,
    -0.6228994727134705, 0, 0.7823023796081543,
    0, 1, 0,
    -0.7823023796081543, 0, -0.6228994727134705
)

local PHASE_POLL_RATE = 0.5
local LOAD_TIMEOUT    = 20
local DELIVER_TIMEOUT = 25
g.hay_farm_running = g.hay_farm_running or false
g.hay_farm_state   = g.hay_farm_state   or "idle"
g.hay_farm_cruise_height = g.hay_farm_cruise_height or 500
local function find_Purchase_Vehicle_RF()
    local cache = g.Purchase_Vehicle_RF_Found
    if cache and cache:IsA("RemoteFunction") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("purchase") and v.Name:lower():find("vehicle") then
            g.Purchase_Vehicle_RF_Found = v
            return v
        end
    end
    return nil
end

wait(0.1)
if not g.Purchase_Vehicle_RF_Found then pcall(function() find_Purchase_Vehicle_RF() end) end

local function ensure_vehicle_available()
    local existing = g.get_lp_vehicle()
    if existing and existing:IsDescendantOf(game or workspace) then return true end
    local owned_rf = g.Get_Owned_Vehicles_RF_Found or Get_Owned_Vehicles_RF()
    if not owned_rf or not owned_rf:IsA("RemoteFunction") then
        if g.notify then g.notify("Error", "Hay Farm: could not reach owned vehicles remote.", 3) end
        return false
    end
    local payload = owned_rf:InvokeServer()
    if not payload or type(payload.copies) ~= "table" then
        if g.notify then g.notify("Error", "Hay Farm: owned vehicles payload invalid.", 3) end
        return false
    end
    local copy = payload.copies[1]
    if not copy then
        if g.notify then g.notify("Warning", "Hay Farm: no vehicles owned, purchasing budget vehicle...", 4) end
        local purchase_rf = g.Purchase_Vehicle_RF_Found or find_Purchase_Vehicle_RF()
        if not purchase_rf or not purchase_rf:IsA("RemoteFunction") then
            if g.notify then g.notify("Error", "Hay Farm: purchase remote not found.", 3) end
            return false
        end
        local ok = pcall(function() purchase_rf:InvokeServer(BUDGET_VEHICLE_NAME, nil, nil) end)
        if not ok then
            if g.notify then g.notify("Error", "Hay Farm: vehicle purchase failed.", 3) end
            return false
        end
        task.wait(1)
        payload = owned_rf:InvokeServer()
        if not payload or type(payload.copies) ~= "table" then return false end
        copy = payload.copies[1]
        if not copy then return false end
        if g.notify then g.notify("Success", "Hay Farm: budget vehicle purchased.", 3) end
    end
    if copy.spawned then
        task.wait(1)
        local refreshed = g.get_lp_vehicle()
        if refreshed and refreshed:IsDescendantOf(game or workspace) then return true end
    end
    if g.notify then g.notify("Info", "Hay Farm: spawning vehicle...", 3) end
    local spawn_rf = g.Spawn_Vehicle_Remote_Function_Found or find_Spawn_Vehicle_Remote_Function()
    if not spawn_rf or not spawn_rf:IsA("RemoteFunction") then
        if g.notify then g.notify("Error", "Hay Farm: spawn remote not found.", 3) end
        return false
    end
    pcall(function() spawn_rf:InvokeServer(copy.id) end)
    local deadline = os.clock() + 8
    while os.clock() < deadline do
        task.wait(0.5)
        local spawned = g.get_lp_vehicle()
        if spawned and spawned:IsDescendantOf(game or workspace) then
            if g.notify then g.notify("Success", "Hay Farm: vehicle spawned.", 3) end
            return true
        end
    end
    if g.notify then g.notify("Error", "Hay Farm: vehicle did not spawn in time.", 4) end
    return false
end

local function is_clocked_in() return speaker:GetAttribute("ActiveJob") ~= nil end
local function try_clock_in()
    if is_clocked_in() then return true end
    local vehicle_ready = ensure_vehicle_available()
    if not vehicle_ready then
        if g.notify then g.notify("Error", "Hay Farm: no vehicle available, cannot clock in.", 4) end
        return false
    end
    local human = g.Humanoid or g.get_human(speaker)
    if not human or not human.Parent or not human:IsDescendantOf(game) then
        if g.notify then g.notify("Error", "Hay Farm: humanoid not found.", 3) end
        return false
    end
    if human.Sit then
        pcall(function() human:ChangeState(3) end)
        human.Sit = false
        task.wait(0.2)
    end
    if g.notify then g.notify("Info", "Hay Farm: clocking in to Hay Hauling...", 3) end
    pcall(function() g.HumanoidRootPart.CFrame = CFrame.new(763, 5, 708) end)
    task.wait(0.25)
    local Event = g.Job_Action_RF_Found or Find_Job_Action_RF()
    if Event and Event.Parent and Event:IsA("RemoteFunction") then
        pcall(function() Event:InvokeServer("start", "HayHaul") end)
    else
        if g.notify then g.notify("Error", "Hay Farm: JobAction remote not found.", 3) end
        return false
    end
    local deadline = os.clock() + 5
    while os.clock() < deadline do
        task.wait(0.5)
        if is_clocked_in() then return true end
    end
    return is_clocked_in()
end

local function get_job_hud()
    local hud = PlayerGui:FindFirstChild("JobHUD")
    if not hud or not hud:IsA("ScreenGui") then return nil end
    return hud
end

local function get_hud_objective()
    local hud = get_job_hud()
    if not hud then return nil end
    local strip = hud:FindFirstChild("Strip")
    if not strip then return nil end
    local stats = strip:FindFirstChild("Stats")
    if not stats then return nil end
    local obj = stats:FindFirstChild("Objective")
    if obj and obj:IsA("TextLabel") then return obj.Text end
    return nil
end

local function get_hud_phase()
    local text = get_hud_objective()
    if not text then return "unknown" end
    local lower = text:lower()
    if lower:find("next load in")                      then return "cooldown" end
    if lower:find("drive to") and lower:find("load")  then return "drive_to_farm" end
    if lower:find("deliver")                           then return "deliver" end  -- moved above "loading"
    if lower:find("loading")                           then return "loading" end
    if lower:find("drive to")                          then return "drive_to_farm" end
    return "unknown"
end

-- reads the objective text and returns the correct delivery CFrame for wherever the job is sending us
local function get_active_drop_cf()
    local text = get_hud_objective()
    if not text then return DROP_ZONE_CF end
    local lower = text:lower()
    if lower:find("hay fields") then
        return CFrame.new(DROP2_COORDS)
    end
    if lower:find("milling") or lower:find("ol") then
        return CFrame.new(DROP1_COORDS)
    end
    return DROP_ZONE_CF
end

g.get_drop_target = get_active_drop_cf
local function ensure_seated()
    local human = g.Humanoid or g.get_human(speaker)
    if not human or not human.Parent or not human:IsDescendantOf(game) then return false end
    if human.Sit and human.SeatPart then return true end
    local car = g.get_lp_vehicle()
    if not car or not car:IsDescendantOf(game or workspace) then return false end
    local drive_seat = car:FindFirstChildOfClass("VehicleSeat") or car:FindFirstChildWhichIsA("VehicleSeat", true)
    if not drive_seat or not drive_seat:IsDescendantOf(game) then return false end
    drive_seat:Sit(human)
    local deadline = os.clock() + 3
    while os.clock() < deadline do
        if human.Sit and human.SeatPart then return true end
        task.wait(0.1)
    end
    return human.Sit and human.SeatPart ~= nil
end

g.get_model_length_along_forward = function(model, forward)
    local min_proj, max_proj = math.huge, -math.huge
    for _, v in ipairs(model:GetDescendants()) do
        if v:IsA("BasePart") then
            local proj = v.Position:Dot(forward)
            local half = (v.Size * Vector3.new(math.abs(forward.X), math.abs(forward.Y), math.abs(forward.Z))).Magnitude * 0.5
            if proj - half < min_proj then min_proj = proj - half end
            if proj + half > max_proj then max_proj = proj + half end
        end
    end
    if min_proj == math.huge then return 10 end
    return max_proj - min_proj
end

local function tween_vehicle_to(target_cf)
    local car = g.get_vehicle() or g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsDescendantOf(game or workspace) then
        if g.notify then g.notify("Error", "Hay Farm: no vehicle found.", 3) end
        return false
    end
    local anchor = car.PrimaryPart
    if not anchor then
        for _, v in ipairs(car:GetDescendants()) do
            if v:IsA("VehicleSeat") then anchor = v; break end
        end
    end
    if not anchor then anchor = car:FindFirstChildWhichIsA("BasePart", true) end
    if not anchor or not anchor:IsDescendantOf(game or workspace) then
        if g.notify then g.notify("Error", "Hay Farm: could not resolve vehicle anchor.", 3) end
        return false
    end
    if g._vehicle_tp_tween then
        pcall(function() g._vehicle_tp_tween:Cancel() end)
        g._vehicle_tp_tween = nil
    end
    local trailer               = g.get_lp_trailer and g.get_lp_trailer()
    local trailer_snap_offset   = nil
    local car_collision_groups  = {}
    if trailer and trailer:IsDescendantOf(game or workspace) then
        local t_anchor = trailer.PrimaryPart or trailer:FindFirstChildWhichIsA("BasePart", true)
        if t_anchor then
            trailer_snap_offset = t_anchor.Position - anchor.Position
        end
    end
    for _, v in ipairs(car:GetDescendants()) do
        if v:IsA("BasePart") then
            car_collision_groups[v] = v.CollisionGroup
            pcall(function() v.CollisionGroup = "TrailersGhost" end)
        end
    end

    -- measure how far the lowest collidable floor sits below the anchor so we can offset the landing Y
    local floor_drop = 0
    for _, part in ipairs(car:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            local dist = anchor.Position.Y - (part.Position.Y - part.Size.Y * 0.5)
            if dist > floor_drop then floor_drop = dist end
        end
    end

    -- shift target up by floor_drop so wheels land on the surface instead of clipping into it
    target_cf = CFrame.new(target_cf.Position + Vector3.new(0, floor_drop, 0)) * (target_cf - target_cf.Position)

    local function restore()
        for _, v in ipairs(car:GetDescendants()) do
            if v:IsA("BasePart") then
                pcall(function() v.AssemblyLinearVelocity  = Vector3.zero end)
                pcall(function() v.AssemblyAngularVelocity = Vector3.zero end)
            end
        end
        if trailer and trailer:IsDescendantOf(game or workspace) then
            for _, v in ipairs(trailer:GetDescendants()) do
                if v:IsA("BasePart") then
                    pcall(function() v.AssemblyLinearVelocity  = Vector3.zero end)
                    pcall(function() v.AssemblyAngularVelocity = Vector3.zero end)
                end
            end
        end
        task.wait(0.15)
        for v, group in pairs(car_collision_groups) do
            pcall(function() v.CollisionGroup = group end)
        end
    end

    local CRUISE_HEIGHT = g.hay_farm_cruise_height or 550
    local ASCENT_FRAC   = 0.15
    local DESCENT_FRAC  = 0.35
    local start_cf      = anchor.CFrame
    local start_pos     = start_cf.Position
    local end_pos       = target_cf.Position
    local cruise_start  = Vector3.new(start_pos.X, CRUISE_HEIGHT, start_pos.Z)
    local cruise_end    = Vector3.new(end_pos.X,   CRUISE_HEIGHT, end_pos.Z)
    local distance      = (end_pos - start_pos).Magnitude
    local base_speed    = g.vehicle_tp_duration or 1
    local duration      = math.max(base_speed, distance / 125)
    local steps         = math.max(10, math.floor(duration * 60))
    local interval      = duration / steps
    for i = 1, steps do
        if not g.hay_farm_running then
            restore()
            return false
        end
        local alpha = i / steps
        local pos
        if alpha < ASCENT_FRAC then
            local t  = alpha / ASCENT_FRAC
            local te = t * t * (3 - 2 * t)
            pos = start_pos:Lerp(cruise_start, te)
        elseif alpha > (1 - DESCENT_FRAC) then
            local t  = (alpha - (1 - DESCENT_FRAC)) / DESCENT_FRAC
            local te = t * t * (3 - 2 * t)
            pos = cruise_end:Lerp(end_pos, te)
        else
            local t  = (alpha - ASCENT_FRAC) / (1 - ASCENT_FRAC - DESCENT_FRAC)
            local te = t * t * (3 - 2 * t)
            pos = cruise_start:Lerp(cruise_end, te)
        end
        local next_cf = CFrame.new(pos)
        pcall(function()
            if car.PrimaryPart then car:PivotTo(next_cf) else anchor.CFrame = next_cf end
        end)
        pcall(function() anchor.AssemblyLinearVelocity  = Vector3.zero end)
        pcall(function() anchor.AssemblyAngularVelocity = Vector3.zero end)
        task.wait(interval)
    end
    pcall(function()
        if car.PrimaryPart then car:PivotTo(target_cf) else anchor.CFrame = target_cf end
    end)
    if trailer and trailer_snap_offset and trailer:IsDescendantOf(game or workspace) then
        task.wait(0.1)
        pcall(function()
            if trailer.PrimaryPart then
                trailer:PivotTo(CFrame.new(target_cf.Position + trailer_snap_offset))
            end
        end)
    end
    restore()
    return true
end

g.wait_for_phase = function(target_phase, timeout)
    local start = os.clock()
    while (os.clock() - start) < timeout do
        if not g.hay_farm_running then return false end
        if get_hud_phase() == target_phase then return true end
        task.wait(PHASE_POLL_RATE)
    end
    return false
end

local function wait_for_phase_any(phases, timeout)
    local start = os.clock()
    while (os.clock() - start) < timeout do
        if not g.hay_farm_running then return nil end
        local phase = get_hud_phase()
        for _, p in ipairs(phases) do if phase == p then return phase end end
        task.wait(PHASE_POLL_RATE)
    end
    return nil
end

local function wait_until_seated(timeout)
    local human = g.Humanoid or g.get_human(speaker)
    if not human or not human.Parent or not human:IsDescendantOf(game) then return false end
    local car = g.get_lp_vehicle()
    local drive_seat = car and (car:FindFirstChildOfClass("VehicleSeat") or car:FindFirstChildWhichIsA("VehicleSeat", true))
    local deadline = os.clock() + (timeout or 5)
    while os.clock() < deadline do
        if human.Sit and human.SeatPart and drive_seat and human.SeatPart == drive_seat then return true end
        ensure_seated()
        task.wait(0.2)
    end
    return human.Sit and drive_seat ~= nil and human.SeatPart == drive_seat
end

local function bind_vehicle_destroy_watch(car)
    lib.disconnect("hay_farm_vehicle_destroy_watch")
    if not car or not car:IsDescendantOf(game) then return end
    lib.connect("hay_farm_vehicle_destroy_watch", car.AncestryChanged:Connect(function()
        if not car:IsDescendantOf(game) then
            if g.notify then g.notify("Error", "Hay Farm: vehicle was destroyed, stopping farm.", 3) end
            g.stop_hay_farm()
        end
    end))
end

local function hay_farm_loop()
    if g.notify then g.notify("Success", "Hay Farm: loop started.", 3) end
    local loop_count = 0
    while g.hay_farm_running == true do
        loop_count = loop_count + 1
        if g.notify then g.notify("Info", "Hay Farm: cycle " .. loop_count .. " starting.", 2) end
        if not is_clocked_in() then
            local clocked = try_clock_in()
            if not clocked then
                if g.notify then g.notify("Error", "Hay Farm: clock-in failed, stopping.", 5) end
                g.stop_hay_farm()
                break
            end
            task.wait(1)
            continue
        end
        local car = g.get_lp_vehicle()
        if not car or not car:IsDescendantOf(game or workspace) then
            if g.notify then g.notify("Error", "Hay Farm: vehicle not found, stopping.", 4) end
            g.stop_hay_farm()
            break
        end
        bind_vehicle_destroy_watch(car)
        local human = g.Humanoid or g.get_human(speaker)
        if not human or not human.Parent or not human:IsDescendantOf(game) then
            if g.notify then g.notify("Error", "Hay Farm: humanoid not found, waiting...", 3) end
            task.wait(2)
            continue
        end
        local phase = get_hud_phase()
        if phase == "cooldown" then
            if g.notify then g.notify("Info", "Hay Farm: cooldown, waiting for next load...", 2) end
            local cooldown_done = wait_for_phase_any({"drive_to_farm", "loading"}, 60)
            if not cooldown_done then
                if g.notify then g.notify("Warning", "Hay Farm: cooldown wait exceeded, re-checking.", 3) end
            end
            continue
        end
        if not human.Sit or not human.SeatPart then
            if g.notify then g.notify("Info", "Hay Farm: not seated, attempting to sit...", 2) end
            local seated = ensure_seated()
            if not seated then
                if g.notify then g.notify("Warning", "Hay Farm: could not seat in vehicle, retrying...", 3) end
                task.wait(2)
                continue
            end
            task.wait(0.3)
        end
        if phase == "drive_to_farm" or phase == "unknown" then
            g.hay_farm_state = "going_to_farm"
            if g.notify then g.notify("Info", "Hay Farm: heading to farm.", 2) end
            if not wait_until_seated(5) then
                if g.notify then g.notify("Warning", "Hay Farm: not seated, retrying...", 3) end
                task.wait(1)
                continue
            end
            local ok = tween_vehicle_to(CFrame.new(FARM_COORDS))
            if not ok then
                if g.notify then g.notify("Error", "Hay Farm: tween failed, retrying.", 3) end
                task.wait(2)
                continue
            end
            local arrived_phase = wait_for_phase_any({"loading", "deliver", "cooldown"}, LOAD_TIMEOUT)
            if not arrived_phase then
                if g.notify then g.notify("Warning", "Hay Farm: phase timeout at farm, re-centering.", 3) end
                task.wait(1)
                continue
            end
            phase = arrived_phase
        end
        if phase == "cooldown" then
            if g.notify then g.notify("Info", "Hay Farm: cooldown after arrival, waiting...", 2) end
            local cooldown_done = wait_for_phase_any({"drive_to_farm", "loading"}, 60)
            if not cooldown_done then
                if g.notify then g.notify("Warning", "Hay Farm: cooldown wait exceeded, re-checking.", 3) end
            end
            continue
        end
        if phase == "loading" then
            g.hay_farm_state = "loading"
            if g.notify then g.notify("Info", "Hay Farm: loading bale...", 2) end
            local loaded = false
            local load_start = os.clock()
            while not loaded and g.hay_farm_running do
                local current_phase = get_hud_phase()
                if current_phase == "deliver" then loaded = true; break end
                if current_phase == "cooldown" then break end
                if (os.clock() - load_start) >= LOAD_TIMEOUT then
                    if g.notify then g.notify("Warning", "Hay Farm: load timeout, repositioning.", 3) end
                    if not wait_until_seated(5) then task.wait(1); break end
                    tween_vehicle_to(CFrame.new(FARM_COORDS))
                    load_start = os.clock()
                end
                task.wait(PHASE_POLL_RATE)
            end
            if not loaded then task.wait(2); continue end
            phase = "deliver"
        end
        if phase == "deliver" then
            g.hay_farm_state = "delivering"
            if g.notify then g.notify("Info", "Hay Farm: delivering bale.", 2) end
            if not wait_until_seated(5) then
                if g.notify then g.notify("Warning", "Hay Farm: not seated for delivery, retrying...", 3) end
                task.wait(1)
                continue
            end
            -- read the HUD objective to route to the correct drop zone instead of hardcoding
            local drop_cf = get_active_drop_cf()
            local ok = tween_vehicle_to(drop_cf)
            if not ok then
                if g.notify then g.notify("Error", "Hay Farm: delivery tween failed.", 3) end
                task.wait(2)
                continue
            end
            g.hay_farm_state = "unloading"
            if g.notify then g.notify("Info", "Hay Farm: waiting for unload...", 2) end
            local next_phase = wait_for_phase_any({"drive_to_farm", "loading", "cooldown"}, DELIVER_TIMEOUT)
            if not next_phase then
                if g.notify then g.notify("Warning", "Hay Farm: delivery timeout, nudging.", 3) end
                if not wait_until_seated(5) then task.wait(1); continue end
                tween_vehicle_to(get_active_drop_cf())
                task.wait(2)
                continue
            end
            task.wait(0.5)
        end
        task.wait(0.5)
    end
    lib.disconnect("hay_farm_vehicle_destroy_watch")
    g.hay_farm_state = "idle"
    if g.notify then g.notify("Success", "Hay Farm: loop stopped.", 3) end
end

g.start_hay_farm = function()
    if g.hay_farm_running then
        if g.notify then g.notify("Warning", "Hay Farm: already running.", 3) end
        return
    end
    if not ensure_vehicle_available() then
        if g.notify then g.notify("Error", "Hay Farm: could not ensure a vehicle, aborting.", 5) end
        return
    end
    wait(0.1)
    if not is_clocked_in() then
        local clocked = try_clock_in()
        if not clocked then
            if g.notify then g.notify("Error", "Hay Farm: could not clock in, aborting.", 5) end
            return
        end
        task.wait(1)
    end
    if not get_job_hud() then
        if g.notify then g.notify("Error", "Hay Farm: JobHUD not found. Make sure Hay Hauling is active.", 5) end
        return
    end
    g.hay_farm_running = true
    lib.connect("hay_farm_clockout_watch", speaker:GetAttributeChangedSignal("ActiveJob"):Connect(function()
        if speaker:GetAttribute("ActiveJob") == nil and g.hay_farm_running then
            if g.notify then g.notify("Warning", "Hay Farm: clocked out, stopping farm.", 4) end
            g.stop_hay_farm()
            if g.Auto_Farm_Hay_Hauling_Toggle_UI then g.Auto_Farm_Hay_Hauling_Toggle_UI:Set(false, false) end
        end
    end))
    lib.spawn("hay_farm_loop_spawned", "spawn", function() hay_farm_loop() end)
end

g.stop_hay_farm = function()
    if not g.hay_farm_running then
        if g.notify then g.notify("Warning", "Hay Farm: not running.", 3) end
        return
    end
    g.hay_farm_running = false
    lib.disconnect("hay_farm_loop_spawned")
    lib.disconnect("hay_farm_vehicle_destroy_watch")
    if g._vehicle_tp_tween then
        pcall(function() g._vehicle_tp_tween:Cancel() end)
        g._vehicle_tp_tween = nil
    end
    g.hay_farm_state = "idle"
    lib.disconnect("hay_farm_clockout_watch")
    if g.notify then g.notify("Success", "Hay Farm: stopped.", 3) end
end

g.toggle_hay_farm = function()
    if g.hay_farm_running then g.stop_hay_farm() else g.start_hay_farm() end
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
local Job_Section = Home_Page:CreateSection("Job")
local UI_Section = Home_Page:CreateSection("UI")

g.create_ui_element("Toggle", Home_Section, {
Name = "Minimap Toggle",
Default = g.get_minimap_enabled() or false,
Flag = "Minimap_Toggle_UI",
Callback = function(state)
    g.toggle_minimap(state)
end}, "Minimap_Toggle_UI")

g.FullBright_Main_Toggle_UI = g.create_ui_element("Toggle", Lighting_Section, {
Name = "Fullbright",
Default = g.fullbright_enabled or false,
Flag = "Fullbright_Toggle_UI",
Callback = function(state)
    g.fullbright_toggle(state)
end}, "Fullbright_Toggle_UI")

g.Graphics_Enhancer_Main_Toggle_UI = g.create_ui_element("Toggle", Lighting_Section, {
Name = "Graphics Enhancer (Day)",
Default = g.graphics_enhancer_active or false,
Flag = "Graphics_Enhancer_Toggle_UI",
Callback = function(state)
    g.Toggle_Graphics_Enhancer(state)
end}, "Graphics_Enhancer_Toggle_UI")

g.Night_Enhancer_Main_Toggle_UI = g.create_ui_element("Toggle", Lighting_Section, {
Name = "Graphics Enhancer (Night)",
Default = g.night_enhancer_active or false,
Flag = "Night_Enhancer_Toggle_UI",
Callback = function(state)
    g.Toggle_Night_Enhancer(state)
end}, "Night_Enhancer_Toggle_UI")

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

g.create_ui_element("Button", LocalPlayer_Section, {
Name = "Infinite Premium",
Callback = function()
    g.infinite_premium()
end,})

g.Auto_Farm_Hay_Hauling_Toggle_UI = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Hay Hauling Auto Farm (FE)",
Default = g.hay_farm_running or false,
Flag = "Hay_Farm_Toggle_UI",
Callback = function(state)
    if state then
        if not is_clocked_in() then
            g.notify("Warning", "You are not clocked in. Clocking in...", 3)
            local clocked = try_clock_in()
            if not clocked then
                g.notify("Error", "Could not clock in to Hay Hauling, aborting.", 5)
                if g.Auto_Farm_Hay_Hauling_Toggle_UI then g.Auto_Farm_Hay_Hauling_Toggle_UI:Set(false, false) end
                return
            end
            task.wait(0.5)
        end
        g.start_hay_farm()
    else
        g.stop_hay_farm()
    end
end}, "Hay_Farm_Toggle_UI")

g.create_ui_element("Slider", Vehicles_Section, {
Name = "Auto Farm Tween Height (Recommended: 500)",
Min = 100,
Max = 3000,
Default = g.hay_farm_cruise_height or 500,
Flag = "Hay_Farm_Cruise_Height_Slider_UI",
Callback = function(val)
    g.hay_farm_cruise_height = val
end}, "Hay_Farm_Cruise_Height_Slider_UI")

-- [[ Not really necessary since the server has a speed that is capped very harshly. ]] --
--[[g.create_ui_element("Slider", Vehicles_Section, {
Name = "Auto Farm Tween Speed",
Min = 1,
Max = 10,
Default = g.vehicle_tp_duration or 1,
Flag = "Hay_Farm_Speed_Slider_UI",
Callback = function(val)
    g.vehicle_tp_duration = val
end}, "Hay_Farm_Speed_Slider_UI")--]]

g.create_ui_element("Button", Job_Section, {
Name = "Start Hay Hauling Job (FE)",
Callback = function()
    local Event = g.Job_Action_RF_Found or Find_Job_Action_RF()
    if not Event or not Event:IsA("RemoteFunction") then
        g.notify("Error", "Could not find: JobAction RemoteFunction.", 3)
        return
    end
    Event:InvokeServer("HayHaul")
end,})

g.create_ui_element("Button", Job_Section, {
Name = "Clock Off (FE)",
Callback = function()
    g.Clock_Off()
end,})

g.create_ui_element("Slider", Vehicles_Section, {
Name = "Vehicle Orbit Speed",
Min = 1,
Max = 100,
Default = g.VehicleOrbit_Speed or 20,
Flag = "Vehicle_Orbit_Speed_Slider_UI",
Callback = function(val)
    g.VehicleOrbit_Speed = val
end}, "Vehicle_Orbit_Speed_Slider_UI")

g.create_ui_element("Slider", Vehicles_Section, {
Name = "Vehicle Orbit Radius",
Min = 1,
Max = 100,
Default = g.VehicleOrbit_Radius or 15,
Flag = "Vehicle_Orbit_Radius_Slider_UI",
Callback = function(val)
    g.VehicleOrbit_Radius = val
end}, "Vehicle_Orbit_Radius_Slider_UI")

g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Vehicle Orbit (FE)",
Default = g.VehicleOrbit_Enabled or false,
Flag = "Vehicle_Orbit_Toggle_UI",
Callback = function(state)
    if state then
        g.start_vehicle_orbit()
    else
        g.stop_vehicle_orbit()
    end
end}, "Vehicle_Orbit_Toggle_UI")

g.create_ui_element("Slider", LocalPlayer_Section, {
Name = "Fly Speed",
Min = 1,
Max = 100,
Default = g.Fly_Speed_Value or 3,
Flag = "Fly_Speed_Slider_UI",
Callback = function(val)
    g.Fly_Speed_Value = val
    g.FlySpeed = val
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

g.create_ui_element("Slider", Vehicles_Section, {
Name = "Vehicle Side Glitch Speed",
Min = 1,
Max = 100,
Default = g.VehicleSideGlitch_Speed or 25,
Flag = "Vehicle_Side_Glitch_Speed_Slider_UI",
Callback = function(val)
    g.VehicleSideGlitch_Speed = val
end}, "Vehicle_Side_Glitch_Speed_Slider_UI")

g.create_ui_element("Slider", Vehicles_Section, {
Name = "Vehicle Side Glitch Distance",
Min = 1,
Max = 25,
Default = g.VehicleSideGlitch_Distance or 5,
Flag = "Vehicle_Side_Glitch_Distance_Slider_UI",
Callback = function(val)
    g.VehicleSideGlitch_Distance = val
end}, "Vehicle_Side_Glitch_Distance_Slider_UI")

g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Vehicle Side Glitch (FE)",
Default = g.VehicleSideGlitch_Enabled or false,
Flag = "Vehicle_Side_Glitch_Toggle_UI",
Callback = function(state)
    if state then
        g.start_vehicle_glitch_script()
    else
        g.stop_vehicle_glitch_script()
    end
end}, "Vehicle_Side_Glitch_Toggle_UI")

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
Max = 15,
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
task.wait(0.15)
g.make_round = g.make_round or function(obj, radius)
    local uic = Instance.new("UICorner")
    uic.CornerRadius = UDim.new(0, radius)
    uic.Parent = obj
end

local ScreenGui
wait(0.15)
if CoreGui:FindFirstChild("TemporaryBanner_GUI") then
    pcall(function()
        if g.camConn then
            g.camConn:Disconnect()
            g.camConn = nil
        end
        if ScreenGui and ScreenGui.Parent then ScreenGui:Destroy() end
        g.UpdatePosition = nil
        g.Clamp = nil
    end)
end
wait(0.5)
ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TemporaryBanner_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Name = "BannerFrame"
frame.AnchorPoint = Vector2.new(0.5, 0)
frame.Position = UDim2.new(0.5, 0, 0, 20)
frame.Size = UDim2.new(0.6, 0, 0, 48)
frame.BackgroundTransparency = 0
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = ScreenGui

if g.make_round and typeof(g.make_round) == "function" then g.make_round(frame, 12) end
if g.flowrgb and typeof(g.flowrgb) == "function" then g.flowrgb("banner_announcement_frame_flowing_rgb_smooth_conn", 3.5, frame, true) end
if g.make_stroke and typeof(g.make_stroke) == "function" then g.make_stroke(frame, 1.5, 0.25) end

local label = Instance.new("TextLabel")
label.Name = "BannerText"
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.Position = UDim2.new(0.5, 0, 0.5, 0)
label.Size = UDim2.new(0.95, 0, 0.9, 0)
label.BackgroundTransparency = 1
label.Text = tostring(Announcement_Message)
label.Font = Enum.Font.GothamBold
label.TextScaled = true
label.RichText = false
label.TextWrapped = true
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Parent = frame

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0)
shadow.Position = UDim2.new(0.5, 0, 0, 24)
shadow.Size = UDim2.new(0.62, 0, 0, 56)
shadow.Image = "rbxassetid://5059716102"
shadow.BackgroundTransparency = 1
shadow.ImageTransparency = 0.8
shadow.ZIndex = frame.ZIndex - 1
shadow.Parent = ScreenGui
shadow.Visible = false

g.Clamp = g.Clamp or function(n, lo, hi)
    if n < lo then return lo end
    if n > hi then return hi end
    return n
end

g.UpdatePosition = g.UpdatePosition or function()
    local _, vh = Workspace.CurrentCamera.ViewportSize.X, Workspace.CurrentCamera.ViewportSize.Y
    local WidthScale = g.Clamp(0.6, 0.4, 0.8)
    local HeightPX = g.Clamp(math.floor(vh * 0.07), 36, 72)
    frame.Size = UDim2.new(WidthScale, 0, 0, HeightPX)
    local TopOffset = math.max(12, math.floor(vh * 0.03))
    frame.Position = UDim2.new(0.5, 0, 0, TopOffset)
    shadow.Position = UDim2.new(0.5, 0, 0, TopOffset + math.floor(HeightPX/2))
    shadow.Size = UDim2.new(WidthScale + 0.02, 0, 0, HeightPX + 12)
end

g.UpdatePosition()
g.CamConn = nil
if Workspace.CurrentCamera then g.CamConn = Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(g.UpdatePosition) end
frame.BackgroundTransparency = 1
label.TextTransparency = 1
shadow.ImageTransparency = 1
appearInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenService:Create(frame, appearInfo, {BackgroundTransparency = 0}):Play()
TweenService:Create(label, appearInfo, {TextTransparency = 0}):Play()
shadow.Visible = false
TweenService:Create(shadow, appearInfo, {ImageTransparency = 0.8}):Play()
DisplayTime = g.displayTimeMax
task.delay(DisplayTime, function()
    local FadeInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local t1 = TweenService:Create(frame, FadeInfo, {BackgroundTransparency = 1})
    local t2 = TweenService:Create(label, FadeInfo, {TextTransparency = 1})
    local t3 = TweenService:Create(shadow, FadeInfo, {ImageTransparency = 1})
    t1:Play(); t2:Play(); t3:Play()
    t1.Completed:Wait()
    pcall(function()
        if g.CamConn then
            g.CamConn:Disconnect()
            g.CamConn = nil
        end
        ScreenGui:Destroy()
    end)
end)