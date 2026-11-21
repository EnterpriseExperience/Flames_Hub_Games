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
local place_ids = {
    ["138332904385564"] = true,
    ["107139329854666"] = true,
}
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

g.Announcement_Message = "Added Auto Refuel Bike (FE), Refuel Bike (FE) + Fixed Vehicle Fly (FE), and fixed the timing on RGB Bike (FE)."
g.DisplayTimeMax = 30
if not place_ids[tostring(game.PlaceId)] then
    if g.notify and typeof(g.notify) == "function" then
        g.notify("Error", "This game is not supported. Run this on Bike Stars only.", 30)
        return
    else
        warn("This game is not supported. Run this on Bike Stars only.")
        return
    end
end
task.wait(0.1)
if g.Bike_Stars_Script_Hub_Running then
    if g.notify and typeof(g.notify) == "function" then
        g.notify("Error", "Bike Stars Script Hub is already running, please click 'Destroy GUI' at the bottom of the script to exit the menu.", 15)
        return 
    else
        warn("Bike Stars Script Hub is already running.")
        return 
    end
end
wait(0.1)
g.Bike_Stars_Script_Hub_Running = true
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
local TeleportService = g.TeleportService or cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
local ReplicatedFirst = g.ReplicatedFirst or cloneref and cloneref(game:GetService("ReplicatedFirst")) or game:GetService("ReplicatedFirst")
local CoreGui = g.CoreGui or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local speaker = g.LocalPlayer or Players.LocalPlayer or Players:GetAttributeChangedSignal("LocalPlayer"):Wait()
local PlayerGui = g.PlayerGui or speaker:FindFirstChildOfClass("PlayerGui") or speaker:FindFirstChildWhichIsA("PlayerGui")
local Camera = Workspace.CurrentCamera or Workspace:FindFirstChildWhichIsA("Camera") or Workspace:FindFirstChildOfClass("Camera")
local lib = g.FlamesLibrary or getgenv().FlamesLibrary
local FL = lib
local FlamesLibrary = lib
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local is_mobile = IsMobile
local control_module = is_mobile and require(speaker:FindFirstChildWhichIsA("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
local Raw_Version = "V1.5.6"
g.Script_Version = tostring(Raw_Version).."-BikeStars"
g.all_bikes = {}
g.fov_on = g.fov_on or false
g.target_fov = g.target_fov or 75
g.cframe_speed = g.cframe_speed or 16
g.cframe_speed_on = g.cframe_speed_on or false
g.cframe_speed_holding = g.cframe_speed_holding or false
g.bike_boost_speed = g.bike_boost_speed or 100
g.bike_boost_active = g.bike_boost_active or false
g.bike_boosted = g.bike_boosted or false
g.auto_refuel_threshold = g.auto_refuel_threshold or 10
g.auto_refuel_on = g.auto_refuel_on or false
g.target_jump_power = g.target_jump_power or 50
g.target_jump_height = g.target_jump_height or 7.2
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
local function get_anchor(model)
    if not model or not model:IsDescendantOf(workspace) then return nil end
    local pp = model.PrimaryPart
    if pp then
        local ok, root = pcall(function() return pp.AssemblyRootPart end)
        if ok and root and root ~= pp and root:IsDescendantOf(model) then return root end
        return pp
    end
    local ds = model:FindFirstChild("DriveSeat")
    if ds and ds:IsA("VehicleSeat") then
        local ok, root = pcall(function() return ds.AssemblyRootPart end)
        if ok and root and root:IsDescendantOf(model) then return root end
        return ds
    end
    return model:FindFirstChildWhichIsA("BasePart", true)
end

local function Bike_Assets_Folder_ReplicatedFirst()
    local cache = g.Bike_Cache_Assets_All_Model_Names
    if cache and cache.Parent and cache:IsA("Folder") then return cache end

    for _, v in ipairs(ReplicatedFirst:GetDescendants()) do
        if v:IsA("Folder") and v.Name:lower():find("bikes") and v.Parent.Name:lower():find("asset") then
            g.Bike_Cache_Assets_All_Model_Names = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Bike_Cache_Assets_All_Model_Names then pcall(function() Bike_Assets_Folder_ReplicatedFirst() end) end

local folder = g.Bike_Cache_Assets_All_Model_Names or Bike_Assets_Folder_ReplicatedFirst()
if folder and folder.Parent and folder:IsA("Folder") then
    for _, v in ipairs(folder:GetChildren()) do
        table.insert(g.all_bikes, v.Name)
    end
end

local function Find_Avatar_Shop_Action_RF()
    local cache = g.Avatar_Shop_Action_Remote_Function
    if cache and cache.Parent and cache:IsA("RemoteFunction") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("avatar") and v.Name:lower():find("shop") and v.Name:lower():find("action") then
            g.Avatar_Shop_Action_Remote_Function = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Avatar_Shop_Action_Remote_Function then pcall(function() Find_Avatar_Shop_Action_RF() end) end

g.Rejoin_Server = function()
	local function attempt()
		if #Players:GetPlayers() <= 1 then
			speaker:Kick("\nRejoining...")
			wait()
			return pcall(function() TeleportService:Teleport(game.PlaceId, speaker) end)
		else
			return pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, speaker) end)
		end
	end

	local ok = attempt()
	if not ok then
		wait(0.5)
		attempt()
	end
end

g.Wear_Asset_Id = function(id)
    if not id or typeof(id) ~= "number" then return end
    local r = g.Avatar_Shop_Action_Remote_Function or Find_Avatar_Shop_Action_RF()
    if not r or not r.Parent or not r:IsA("RemoteFunction") then return end
    r:InvokeServer(id)
end

g.Reset_To_Normal_Roblox_Avatar = function()
    local r = g.Avatar_Shop_Action_Remote_Function or Find_Avatar_Shop_Action_RF()
    if not r or not r.Parent or not r:IsA("RemoteFunction") then return end
    r:InvokeServer(
        "Reset",
        nil
    )
    wait(0.35)
    r:InvokeServer("SetOwnBody", true)
end

local function Get_Player_Bikes_Folder_WS()
    local cache = g.PlayerBikesFolder_WS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("player") and v.Name:lower():find("bike") then
            g.PlayerBikesFolder_WS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.PlayerBikesFolder_WS then pcall(function() Get_Player_Bikes_Folder_WS() end) end

local function Get_Gas_Pumps_Model_Folder_WS()
    local cache = g.Gas_Pumps_Folder_Models_WS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("gas") and v.Name:lower():find("pump") then
            g.Gas_Pumps_Folder_Models_WS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Gas_Pumps_Folder_Models_WS then pcall(function() Get_Gas_Pumps_Model_Folder_WS() end) end

local function Get_Bike_Custom_Action_RemoteFunction()
    local cache = g.Bike_Custom_Action_Found_RF
    if cache and cache:IsA("RemoteFunction") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("bike") and v.Name:lower():find("custom") and v.Name:lower():find("action") then
            g.Bike_Custom_Action_Found_RF = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Bike_Custom_Action_Found_RF then pcall(function() Get_Bike_Custom_Action_RemoteFunction() end) end

g.get_bike = function()
    local f = g.PlayerBikesFolder_WS or Get_Player_Bikes_Folder_WS()
    if not f or not f:IsA("Folder") then return end
    for _, v in ipairs(f:GetChildren()) do
        if v:IsA("Model") and v.Name == tostring(speaker.UserId) then
            return v
        end
    end
    return nil
end

g.get_plr_bike = function(p)
    if not p or not p:IsA("Player") then return end
    local f = g.PlayerBikesFolder_WS or Get_Player_Bikes_Folder_WS()
    if not f or not f:IsA("Folder") then return end
    for _, v in ipairs(f:GetChildren()) do
        if v:IsA("Model") and v.Name == p.UserId then
            return v
        end
    end
    return nil
end

g.Get_Current_Sitting_In_Vehicle = function()
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game or Workspace) then return nil end
    local humanoid = g.Humanoid or (char and char:FindFirstChildOfClass("Humanoid")) or g.get_human(speaker)
    if not humanoid or not humanoid.Parent or not humanoid:IsDescendantOf(game) then return nil end
    if not humanoid.Sit or not humanoid.SeatPart then return nil end
    local seat = humanoid.SeatPart
    if not seat or not seat:IsDescendantOf(game) then return nil end
    local vehicles_folder = g.PlayerBikesFolder_WS or Get_Player_Bikes_Folder_WS()
    if not vehicles_folder or not vehicles_folder:IsA("Folder") then return nil end
    if not seat:IsDescendantOf(vehicles_folder) then return nil end
    local cursor = seat
    while cursor and cursor.Parent and cursor.Parent ~= vehicles_folder do cursor = cursor.Parent end
    if cursor and cursor.Parent == vehicles_folder and cursor:IsA("Model") then return cursor end
    local fallback = seat:FindFirstAncestorWhichIsA("Model")
    if fallback and fallback:IsDescendantOf(vehicles_folder) then return fallback end
    return nil
end

g.fov = function(state)
    g.fov_on = state
    if g.fov_on then
        Camera.FieldOfView = g.target_fov
        FlamesLibrary.connect("fov_lock", Camera:GetPropertyChangedSignal("FieldOfView"):Connect(function() Camera.FieldOfView = g.target_fov end))
    else
        FlamesLibrary.disconnect("fov_lock")
        Camera.FieldOfView = 70
    end
end

local function get_move_vector()
    if UserInputService.TouchEnabled then
        local ok, control = pcall(function()
            local player_scripts = Players.LocalPlayer:WaitForChild("PlayerScripts", 5)
            local player_module = player_scripts:WaitForChild("PlayerModule", 5)
            return require(player_module:WaitForChild("ControlModule", 5))
        end)
        if ok and control then
            return control:GetMoveVector()
        end
        return Vector3.zero
    end
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game or workspace) then return Vector3.zero end
    local human = g.Humanoid or char and char:FindFirstChildOfClass("Humanoid") or g.get_human(speaker)
    if not human or not human.Parent or not human:IsDescendantOf(game) then return Vector3.zero end
    return human.MoveDirection
end

local function color3_to_hex(c) return string.format("%02X%02X%02X", math.floor(c.R * 255), math.floor(c.G * 255), math.floor(c.B * 255)) end
local function fire_bike_color(hex)
    local r_f = g.Bike_Custom_Action_Found_RF or Get_Bike_Custom_Action_RemoteFunction()
    if not r_f or not r_f:IsA("RemoteFunction") then return end
    local car = g.get_bike and g.get_bike()
    if not car or not car:IsDescendantOf(game) then
        g.Bike_Flash_Toggle(false)
        g.Bike_Rainbow_Toggle(false)
        return
    end
    local bike_name = car:GetAttribute("BikeName")
    if not bike_name or bike_name == nil then return end
    pcall(function()
        r_f:InvokeServer("SaveSlot", bike_name, 1, {
            Body         = { C = hex, F = "Gloss" },
            FrontSection = { C = hex },
            RearSection  = { C = hex, F = "Gloss" },
        })
    end)
end

g.Bike_Flash_Toggle = function(state)
    if state == g.Bike_Flash_Active then return end
    g.Bike_Flash_Active = state
    if not state then
        FL.disconnect("bike_flash_paint")
        return
    end
    local index = 1
    local timer = 0
    local interval = 0.08
    FL.connect("bike_flash_paint", RunService.Heartbeat:Connect(function(dt)
        if not g.Bike_Flash_Active then
            FL.disconnect("bike_flash_paint")
            return
        end
        timer = timer + dt
        if timer < interval then return end
        timer = 0
        index = (index % #g.colors) + 1
        fire_bike_color(color3_to_hex(g.colors[index]))
    end))
end

g.Bike_Rainbow_Toggle = function(state)
    if state == g.Bike_RGB_Active then return end
    g.Bike_RGB_Active = state
    if not state then
        FL.disconnect("bike_rgb_paint")
        return
    end
    local hue = 0
    FL.connect("bike_rgb_paint", RunService.Heartbeat:Connect(function(dt)
        if not g.Bike_RGB_Active then
            FL.disconnect("bike_rgb_paint")
            return
        end
        hue = (hue + dt * 0.1) % 1
        fire_bike_color(color3_to_hex(Color3.fromHSV(hue, 1, 1)))
    end))
end

g.cframe_speed_toggle = function(state)
    g.cframe_speed_on = state
    if not UserInputService.TouchEnabled then
        FlamesLibrary.connect("cframe_speed_input_began", UserInputService.InputBegan:Connect(function(input, gp)
            if not gp and input.KeyCode == Enum.KeyCode.LeftShift then g.cframe_speed_holding = true end
        end))
        FlamesLibrary.connect("cframe_speed_input_ended", UserInputService.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.LeftShift then
                g.cframe_speed_holding = false
            end
        end))
    end

    if state then
        FlamesLibrary.connect("cframe_speed_loop", RunService.RenderStepped:Connect(function()
            local char = g.Character or speaker.Character or g.get_char(speaker)
            if not char or not char:IsDescendantOf(game or workspace) then return end
            local root = g.HumanoidRootPart or char and char:FindFirstChild("HumanoidRootPart") or g.get_root(speaker)
            if not root or not root.Parent then return end
            local move = get_move_vector()
            if move.Magnitude == 0 then return end
            local should_move = UserInputService.TouchEnabled or g.cframe_speed_holding
            if not should_move then return end
            root.CFrame = root.CFrame + (move * g.cframe_speed)
        end))
    else
        FlamesLibrary.disconnect("cframe_speed_loop")
        FlamesLibrary.disconnect("cframe_speed_input_began")
        FlamesLibrary.disconnect("cframe_speed_input_ended")
        g.cframe_speed_holding = false
    end
end

function Validate_Number(str)
	if tonumber(str) ~= nil or str == 'inf' then return true end
	return false
end

local function get_drive_env()
    if not getsenv or typeof(getsenv) ~= "function" then return end
    for _, v in ipairs(PlayerGui:GetDescendants()) do
        if v:IsA("LocalScript") and v.Name:lower():find("drive") then
            return getsenv(v), v
        end
    end
    return nil, nil
end

local function get_tune()
    local env = get_drive_env()
    if not env then return nil end
    local engine_fn = env["Engine"]
    if not engine_fn then return nil end
    local ok, ups = pcall(getupvalues, engine_fn)
    if not ok or not ups then return nil end
    return ups[2]
end

local function get_speed()
    local env = get_drive_env()
    if not env then return 0 end
    local fn = env["Gear"]
    if not fn then return 0 end
    local ok, ups = pcall(getupvalues, fn)
    if not ok or not ups then return 0 end
    return ups[11] or 0
end

local function apply_boost(tune)
    if not rawset or typeof(rawset) ~= "function" then return end
    if not rawget or typeof(rawget) ~= "function" then return end
    rawset(tune, "Horsepower",  math.min(g.bike_boost_speed * 6, 9999))
    rawset(tune, "Redline",     99999)
    rawset(tune, "PeakRPM",     99999)
    rawset(tune, "Flywheel",    50000)
    rawset(tune, "RevAccel",    550)
    rawset(tune, "RevDecay",    350)
    rawset(tune, "Drag",        0)
    rawset(tune, "Limiter",     false)
    rawset(tune, "SpeedLimit",  99999)
    rawset(tune, "FinalDrive",  50 / (g.bike_boost_speed / 50))
    local ratios = rawget(tune, "Ratios")
    if ratios and typeof(ratios) == "table" then
        for i = 1, #ratios do
            if ratios[i] ~= 0 then rawset(ratios, i, 0.3) end
        end
    end
end

local function revert_boost(tune)
    if not rawset or typeof(rawset) ~= "function" then return end
    if not rawget or typeof(rawget) ~= "function" then return end
    if not g.bike_original_values then return end
    for k, v in pairs(g.bike_original_values) do if k ~= "Ratios" then rawset(tune, k, v) end end
    local ratios = rawget(tune, "Ratios")
    if ratios and g.bike_original_values.Ratios then
        for i = 1, #g.bike_original_values.Ratios do
            rawset(ratios, i, g.bike_original_values.Ratios[i])
        end
    end
    g.bike_original_values = nil
end

local function save_originals(tune)
    if not rawget or typeof(rawget) ~= "function" then return end
    local ratios = rawget(tune, "Ratios")
    local ratios_copy = {}
    if ratios then for i = 1, #ratios do ratios_copy[i] = ratios[i] end end
    g.bike_original_values = {
        Horsepower  = tune.Horsepower,
        Redline     = tune.Redline,
        PeakRPM     = tune.PeakRPM,
        Flywheel    = tune.Flywheel,
        RevAccel    = tune.RevAccel,
        RevDecay    = tune.RevDecay,
        Drag        = tune.Drag,
        Limiter     = tune.Limiter,
        SpeedLimit  = tune.SpeedLimit,
        FinalDrive  = tune.FinalDrive,
        Ratios      = ratios_copy,
    }
end

local function is_on_bike()
    local bike = g.get_bike and g.get_bike()
    if not bike or not bike:IsA("Model") or not bike:IsDescendantOf(game or workspace) then return false end
    local seat = bike:FindFirstChildWhichIsA("VehicleSeat", true)
    if not seat then return false end
    local occupant = seat.Occupant
    if not occupant then return false end
    local c = g.Character or speaker.Character or g.get_char and g.get_char(speaker)
    return occupant.Parent == c
end

g.bike_boost_toggle = function(state)
    g.bike_boost_active = state
    if state then
        FlamesLibrary.connect("bike_boost_seat", speaker.CharacterAdded:Connect(function()
            if g.bike_boost_active then
                FlamesLibrary.disconnect("bike_boost")
                local tune = get_tune()
                if tune and rawset and typeof(rawset) == "function" then revert_boost(tune) end
                g.bike_boosted = false
                g.bike_boost_active = false
                if g.Bike_Boost_Toggle_UI then pcall(function() g.Bike_Boost_Toggle_UI:Set(false, false) end) end
            end
        end))
        FlamesLibrary.connect("bike_boost", RunService.Heartbeat:Connect(function()
            if not g.bike_boost_active then
                FlamesLibrary.disconnect("bike_boost")
                FlamesLibrary.disconnect("bike_boost_seat")
                local tune = get_tune()
                if tune and rawset and typeof(rawset) == "function" then revert_boost(tune) end
                g.bike_boosted = false
                return
            end
            if not g.get_bike() or not is_on_bike() then
                FlamesLibrary.disconnect("bike_boost")
                FlamesLibrary.disconnect("bike_boost_seat")
                local tune = get_tune()
                if tune and rawset and typeof(rawset) == "function" then revert_boost(tune) end
                g.bike_boosted = false
                g.bike_boost_active = false
                if g.Bike_Boost_Toggle_UI then pcall(function() g.Bike_Boost_Toggle_UI:Set(false, false) end) end
                return
            end
            if not g.bike_boosted then
                local tune = get_tune()
                if tune and rawset and typeof(rawset) == "function" then
                    save_originals(tune)
                    task.wait(0.1)
                    apply_boost(tune)
                    g.bike_boosted = true
                end
            else
                local tune = get_tune()
                if not tune or not rawset or typeof(rawset) ~= "function" then return end
                local speed = get_speed()
                local target = g.bike_boost_speed
                if speed >= target * 0.92 then
                    rawset(tune, "FinalDrive", 0.001)
                else
                    rawset(tune, "FinalDrive", 50 / (target / 50))
                    rawset(tune, "Horsepower", math.min(target * 6, 9999))
                end
            end
        end))
    else
        FlamesLibrary.disconnect("bike_boost")
        FlamesLibrary.disconnect("bike_boost_seat")
        local tune = get_tune()
        if tune and rawset and typeof(rawset) == "function" then revert_boost(tune) end
        g.bike_boosted = false
    end
end

local function get_nearest_pump_prompt(bike)
    local folder = Get_Gas_Pumps_Model_Folder_WS()
    if not folder then return nil, nil end
    local bike_pos = bike:GetPivot().Position
    local nearest, nearest_dist, nearest_prompt = nil, math.huge, nil
    for _, pump in ipairs(folder:GetChildren()) do
        if pump:IsA("Model") then
            local ok, pivot = pcall(function() return pump:GetPivot() end)
            if ok and pivot then
                local dist = (pivot.Position - bike_pos).Magnitude
                if dist < nearest_dist then
                    local prompt = pump:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt then
                        nearest        = pump
                        nearest_dist   = dist
                        nearest_prompt = prompt
                    end
                end
            end
        end
    end
    return nearest, nearest_prompt
end

g.refuel_now = function()
    local bike = g.get_bike and g.get_bike()
    if not bike or not bike.Parent or not bike:IsA("Model") or not bike:IsDescendantOf(game or workspace) then
        if g.notify then g.notify("Error", "Refuel: no bike found.", 3) end
        return
    end
    local current_fuel = bike:GetAttribute("CurrentFuel")
    if not current_fuel then
        if g.notify then g.notify("Error", "Refuel: no fuel attribute.", 3) end
        return
    end
    if current_fuel >= 99 then
        if g.notify then g.notify("Success", "Refuel: bike is already full.", 3) end
        return
    end
    local pump, prompt = get_nearest_pump_prompt(bike)
    if not pump or not prompt then
        if g.notify then g.notify("Error", "Refuel: no pump or prompt found.", 3) end
        return
    end
    local ok, pivot = pcall(function() return pump:GetPivot() end)
    if not ok or not pivot then
        if g.notify then g.notify("Error", "Refuel: could not get pump pivot.", 3) end
        return
    end
    local saved_cf = bike:GetPivot()
    pcall(function() bike:PivotTo(pivot * CFrame.new(0, 3, -4)) end)
    task.wait(0.3)
    FlamesLibrary.disconnect("refuel_now_pump")
    FlamesLibrary.connect("refuel_now_pump", RunService.Heartbeat:Connect(function()
        local b = g.get_bike and g.get_bike()
        if not b or not b:IsDescendantOf(game or workspace) then
            FlamesLibrary.disconnect("refuel_now_pump")
            return
        end
        local f = b:GetAttribute("CurrentFuel")
        if not f or f >= 99 then
            FlamesLibrary.disconnect("refuel_now_pump")
            pcall(function() b:PivotTo(saved_cf) end)
            if g.notify then g.notify("Success", "Refuel: bike is full.", 3) end
            return
        end
        if prompt and prompt.Parent then
            pcall(function() fireproximityprompt(prompt) end)
        end
    end))
end

g.auto_refuel_toggle = function(state)
    g.auto_refuel_on = state
    if not state then
        FlamesLibrary.disconnect("auto_refuel")
        FlamesLibrary.disconnect("auto_refuel_pump")
        return
    end
    FlamesLibrary.connect("auto_refuel", RunService.Heartbeat:Connect(function()
        if not g.auto_refuel_on then
            FlamesLibrary.disconnect("auto_refuel")
            FlamesLibrary.disconnect("auto_refuel_pump")
            return
        end
        local bike = g.get_bike and g.get_bike()
        if not bike or not bike:IsDescendantOf(game or workspace) then return end
        local current_fuel = bike:GetAttribute("CurrentFuel")
        if not current_fuel then return end
        if current_fuel >= 99 then return end
        if current_fuel > (g.auto_refuel_threshold or 20) then return end
        FlamesLibrary.disconnect("auto_refuel")
        local saved_cf = bike:GetPivot()
        local pump, prompt = get_nearest_pump_prompt(bike)
        if not pump or not prompt then
            FlamesLibrary.connect("auto_refuel", RunService.Heartbeat:Connect(function()
                if not g.auto_refuel_on then FlamesLibrary.disconnect("auto_refuel"); return end
                local b = g.get_bike and g.get_bike()
                if not b or not b:IsDescendantOf(game or workspace) then FlamesLibrary.disconnect("auto_refuel"); return end
                local f = b:GetAttribute("CurrentFuel")
                if not f or f >= 99 then FlamesLibrary.disconnect("auto_refuel"); return end
                if f <= (g.auto_refuel_threshold or 20) then
                    local p2, pr2 = get_nearest_pump_prompt(b)
                    if p2 and pr2 then
                        FlamesLibrary.disconnect("auto_refuel")
                        g.auto_refuel_toggle(true)
                    end
                end
            end))
            return
        end
        local ok, pivot = pcall(function() return pump:GetPivot() end)
        if ok and pivot then
            pcall(function() bike:PivotTo(pivot * CFrame.new(0, 3, -4)) end)
        end
        task.wait(0.3)
        FlamesLibrary.connect("auto_refuel_pump", RunService.Heartbeat:Connect(function()
            if not g.auto_refuel_on then
                FlamesLibrary.disconnect("auto_refuel_pump")
                return
            end
            local b = g.get_bike and g.get_bike()
            if not b or not b:IsDescendantOf(game or workspace) then
                FlamesLibrary.disconnect("auto_refuel_pump")
                return
            end
            local f = b:GetAttribute("CurrentFuel")
            if not f then
                FlamesLibrary.disconnect("auto_refuel_pump")
                return
            end
            if f >= 99 then
                FlamesLibrary.disconnect("auto_refuel_pump")
                pcall(function() b:PivotTo(saved_cf) end)
                FlamesLibrary.connect("auto_refuel", RunService.Heartbeat:Connect(function()
                    if not g.auto_refuel_on then FlamesLibrary.disconnect("auto_refuel"); return end
                    local b2 = g.get_bike and g.get_bike()
                    if not b2 or not b2:IsDescendantOf(game or workspace) then FlamesLibrary.disconnect("auto_refuel"); return end
                    local f2 = b2:GetAttribute("CurrentFuel")
                    if not f2 then FlamesLibrary.disconnect("auto_refuel"); return end
                    if f2 >= 99 then return end
                    if f2 <= (g.auto_refuel_threshold or 20) then
                        FlamesLibrary.disconnect("auto_refuel")
                        g.auto_refuel_toggle(true)
                    end
                end))
                return
            end
            if prompt and prompt.Parent then
                pcall(function() fireproximityprompt(prompt) end)
            end
        end))
    end))
end

g.vehicle_fly               = g.vehicle_fly             or false
g.vehicle_fly_speed         = g.vehicle_fly_speed       or 3
g.vehiclefly_conns          = g.vehiclefly_conns        or {}
g.vehiclefly_control        = g.vehiclefly_control      or {f=0,b=0,l=0,r=0,q=0,e=0}
g.vehiclefly_locked_yaw     = g.vehiclefly_locked_yaw   or nil
g.vehiclefly_collisions     = g.vehiclefly_collisions   or {}
g.vehiclefly_seat_speed_store = g.vehiclefly_seat_speed_store or {}
g.vehiclefly_lean_store     = g.vehiclefly_lean_store   or {}
g.vehiclefly_anchor         = g.vehiclefly_anchor       or nil
local function disable_seat_drive(model)
    for _, v in ipairs(model:GetDescendants()) do
        if v:IsA("VehicleSeat") then
            local ok, spd = pcall(function() return v.MaxSpeed end)
            if ok then
                g.vehiclefly_seat_speed_store[v] = spd
                pcall(function() v.MaxSpeed = 0 end)
            end
        end
    end
end

local function restore_seat_drive()
    for seat, spd in pairs(g.vehiclefly_seat_speed_store) do if seat and seat.Parent then pcall(function() seat.MaxSpeed = spd end) end end
    g.vehiclefly_seat_speed_store = {}
end

local function kill_lean_gyros(car)
    for _, v in ipairs(car:GetDescendants()) do
        if v:IsA("BodyGyro") and v.Name == "LeanGyro" then
            local ok, t = pcall(function() return v.MaxTorque end)
            if ok then
                g.vehiclefly_lean_store[v] = t
                pcall(function() v.MaxTorque = Vector3.zero end)
            end
        end
    end
end

local function restore_lean_gyros()
    for gyro, t in pairs(g.vehiclefly_lean_store) do
        if gyro and gyro.Parent then
            pcall(function() gyro.MaxTorque = t end)
        end
    end
    g.vehiclefly_lean_store = {}
end

local function enable_noclip(car)
    g.vehiclefly_collisions = {}
    if g.ToggleNoclip and typeof(g.ToggleNoclip) == "function" then pcall(g.ToggleNoclip, true) end
    for _, v in ipairs(car:GetDescendants()) do
        if v:IsA("BasePart") then
            g.vehiclefly_collisions[v] = v.CanCollide
            v.CanCollide = false
        end
    end
end

local function disable_noclip(car)
    if g.ToggleNoclip and typeof(g.ToggleNoclip) == "function" then pcall(g.ToggleNoclip, false) end
    for part, state in pairs(g.vehiclefly_collisions) do
        if part and part.Parent then pcall(function() part.CanCollide = state end) end
    end
    g.vehiclefly_collisions = {}
end

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
    restore_seat_drive()
    restore_lean_gyros()
    g.vehiclefly_anchor = nil
end

local function silent_stop(car)
    g.vehicle_fly = false
    g.vehiclefly_locked_yaw = nil
    if car then disable_noclip(car) end
    g.vf_cleanup()
    g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
    if g.Vehicle_Fly_Toggle_UI then pcall(function() g.Vehicle_Fly_Toggle_UI:Set(false, false) end) end
end

g.start_vehicle_fly = function()
    if g.vehiclefly_bg or g.vehiclefly_bv then return end
    local car = g.get_bike and g.get_bike()
    if not car or not car:IsDescendantOf(workspace) then
        g.vf_cleanup()
        if g.notify then g.notify("Error", "Vehicle-Fly: no vehicle found.", 3) end
        return
    end
    local anchor = get_anchor(car)
    if not anchor or not anchor:IsDescendantOf(game) then
        if g.notify then g.notify("Error", "Vehicle-Fly: anchor resolve failed.", 3) end
        g.vf_cleanup()
        return
    end
    g.vehiclefly_anchor = anchor
    kill_lean_gyros(car)
    disable_seat_drive(car)
    local bg = Instance.new("BodyGyro")
    bg.P         = 1e4
    bg.D         = 1e4
    bg.MaxTorque = Vector3.new(0, 9e9, 0)
    bg.CFrame    = anchor.CFrame
    bg.Parent    = anchor
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.Parent   = anchor
    g.vehiclefly_bg = bg
    g.vehiclefly_bv = bv
    enable_noclip(car)
    g.vehiclefly_conns.destroy_watch = car.AncestryChanged:Connect(function()
        if not car:IsDescendantOf(game) then silent_stop(nil) end
    end)
    g.vehiclefly_conns.render = RunService.Heartbeat:Connect(function()
        if not g.vehicle_fly then
            pcall(function() bv.Velocity = Vector3.zero end)
            g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
            if g.Vehicle_Fly_Toggle_UI then pcall(function() g.Vehicle_Fly_Toggle_UI:Set(false, false) end) end
            return
        end
        local still_in = g.get_bike and g.get_bike()
        local char     = g.Character or Players.LocalPlayer.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if not anchor.Parent or not still_in or not still_in:IsDescendantOf(workspace) or not humanoid or not humanoid.SeatPart then
            g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
            if g.Vehicle_Fly_Toggle_UI then pcall(function() g.Vehicle_Fly_Toggle_UI:Set(false, false) end) end
            silent_stop(car)
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
            local ctrl = g.vehiclefly_control
            local moving = ctrl.f ~= 0 or ctrl.b ~= 0 or ctrl.l ~= 0 or ctrl.r ~= 0 or ctrl.q ~= 0 or ctrl.e ~= 0
            if moving then
                g.vehiclefly_locked_yaw = yaw
            elseif not g.vehiclefly_locked_yaw then
                g.vehiclefly_locked_yaw = yaw
            end
            local active_yaw = g.vehiclefly_locked_yaw
            pcall(function() bg.CFrame = CFrame.new(anchor.Position) * CFrame.Angles(0, active_yaw, 0) end)
            local vel = (
                cam.CFrame.LookVector  * (ctrl.f + ctrl.b) +
                cam.CFrame.RightVector * (ctrl.l + ctrl.r) +
                Vector3.new(0, ctrl.q + ctrl.e, 0)
            ) * speed
            pcall(function() bv.Velocity = vel end)
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
    local car = g.get_bike and g.get_bike()
    g.vehicle_fly = false
    g.vehiclefly_locked_yaw = nil
    if car then disable_noclip(car) end
    g.vf_cleanup()
    g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
end

g.toggle_vehicle_fly = function()
    if g.vehicle_fly then
        g.stop_vehicle_fly()
    else
        g.vehicle_fly = true
        g.start_vehicle_fly()
    end
end

g.Set_Jump_Power = function(power)
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game) then return end
    local humanoid = g.Humanoid or (char and char:FindFirstChildOfClass("Humanoid")) or g.get_human(speaker)
    if not humanoid or not humanoid.Parent or not humanoid:IsDescendantOf(game) then return end
    local ok, uses_jump_power = pcall(function() return StarterPlayer.CharacterUseJumpPower end)
    if ok and uses_jump_power then
        pcall(function() humanoid.JumpPower = power end)
    else
        pcall(function() humanoid.JumpHeight = power end)
    end
end

g.infinite_premium = function()
    if g.GET_LOADED_IY then g.notify("Warning", "You already have Infinite Premium running.", 5); return end
    if g.IY_LOADED then g.notify("Warning", "You already have Infinite Yield running! You cannot and should NOT run both at the same time.", 10); return end
    loadstring(g.http_get('https://pastefy.app/b052AUgc/raw'))()
end

g.fly_setup = function()
    g.fly_held_keys = {}
    g.fly_body_pos = nil
    g.fly_body_gyro = nil
    g.fly_key_map = {
        [Enum.KeyCode.Left] = "Left", [Enum.KeyCode.A] = "Left",
        [Enum.KeyCode.Right] = "Right", [Enum.KeyCode.D] = "Right",
        [Enum.KeyCode.Up] = "Forwards", [Enum.KeyCode.W] = "Forwards",
        [Enum.KeyCode.Down] = "Backwards", [Enum.KeyCode.S] = "Backwards",
        [Enum.KeyCode.Space] = "Up", [Enum.KeyCode.R] = "Up",
        [Enum.KeyCode.Q] = "Down", [Enum.KeyCode.LeftControl] = "Down",
        [Enum.KeyCode.F] = "Down",
    }
    g.fly_dir_map = {
        Left = Vector3.new(-1,0,0), Right = Vector3.new(1,0,0),
        Forwards = Vector3.new(0,0,-1), Backwards = Vector3.new(0,0,1),
        Up = Vector3.new(0,1,0), Down = Vector3.new(0,-1,0),
    }
end

g.fly_get_move_vector = function()
    if not UserInputService.TouchEnabled then
        local v = Vector3.new(0,0,0)
        for _, d in pairs(g.fly_held_keys) do v = v + g.fly_dir_map[d] end
        return v.Magnitude > 1 and v.Unit or v
    else
        local mv = control_module:GetMoveVector()
        if typeof(mv) ~= "Vector3" then return Vector3.new(0,0,0) end
        if mv.Z < -0.1 then return Vector3.new(0,0,-1) end
        if mv.Z > 0.1 then return Vector3.new(0,0,1) end
        return Vector3.new(0,0,0)
    end
end

g.fly_stop = function()
    if not g.Currently_Flying then return end
    g.Currently_Flying = false
    table.clear(g.fly_held_keys)
    FL.disconnect("fly_loop")
    FL.disconnect("fly_input_began")
    FL.disconnect("fly_input_ended")
    FL.disconnect("fly_char")
    local bp, bg = g.fly_body_pos, g.fly_body_gyro
    g.fly_body_pos = nil
    g.fly_body_gyro = nil
    if bp then bp.MaxForce = Vector3.new(0,0,0); bp:Destroy() end
    if bg then bg.MaxTorque = Vector3.new(0,0,0); bg:Destroy() end
    local Char = g.Character or speaker.Character or g.get_char and g.get_char(speaker)
    local Root = g.HumanoidRootPart or Char and Char:FindFirstChild("HumanoidRootPart") or g.get_root and g.get_root(speaker)
    if Root and Root.Parent then
        for _, v in ipairs(Root:GetChildren()) do
            if v.Name == "FlyForce" or v.Name == "FlyGyro" then v:Destroy() end
        end
    end
    local Human = g.Humanoid or Char and Char:FindFirstChildOfClass("Humanoid") or g.get_human and g.get_human(speaker)
    if Human and Human.Parent and Human:IsDescendantOf(game) then
        Human.PlatformStand = false
        Human:ChangeState(Enum.HumanoidStateType.GettingUp)
        task.defer(function()
            if Human and Human.Parent then Human:ChangeState(Enum.HumanoidStateType.None) end
        end)
    end
end

g.fly_start = function()
    if g.Currently_Flying then return end
    local Char = g.Character or speaker.Character or g.get_char and g.get_char(speaker)
    if not Char or not Char:IsDescendantOf(game) then return end
    local Human = g.Humanoid or Char and Char:FindFirstChildOfClass("Humanoid") or g.get_human and g.get_human(speaker)
    local Root = g.HumanoidRootPart or Char and Char:FindFirstChild("HumanoidRootPart") or g.get_root and g.get_root(speaker)
    if not Human or not Human.Parent or not Human:IsDescendantOf(game) or not Root or not Root.Parent then return end
    if Human and Human.Parent and Human:IsDescendantOf(game) and Human.Sit then
        task.wait(0.2)
        pcall(function() Human:ChangeState(3) end)
    end
    wait(0.1)
    table.clear(g.fly_held_keys)
    g.fly_body_pos = Instance.new("BodyPosition")
    g.fly_body_pos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    g.fly_body_pos.Position = Root.Position + Vector3.new(0, 4, 0)
    g.fly_body_pos.Name = "FlyForce"
    g.fly_body_pos.Parent = Root
    g.fly_body_gyro = Instance.new("BodyGyro")
    g.fly_body_gyro.D = 50
    g.fly_body_gyro.P = 200
    g.fly_body_gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    g.fly_body_gyro.CFrame = Root.CFrame
    g.fly_body_gyro.Name = "FlyGyro"
    g.fly_body_gyro.Parent = Root
    if Human and Human.Parent and Human:IsDescendantOf(game) then
        Human:ChangeState(Enum.HumanoidStateType.Flying)
        Human.PlatformStand = true
    end
    g.Currently_Flying = true
    local t = tick()
    local last_pos = Root.Position
    local tilt = 0
    local idle_frames = 0
    FL.connect("fly_loop", g.RunService.Heartbeat:Connect(function()
        if not g.Currently_Flying or not Root.Parent or not Human.Parent or not Human:IsDescendantOf(game) then g.fly_stop(); return end
        local cam = workspace.CurrentCamera
        if not cam or not g.fly_body_pos or not g.fly_body_gyro then g.fly_stop(); return end
        local elapsed = tick() - t
        local move = g.fly_get_move_vector()
        local look = cam.CFrame.LookVector
        local cf_delta = CFrame.new(move * (g.FLY_SPEED * 10) * elapsed)
        local pos2 = Root.Position
        local target_cf = CFrame.new(pos2, pos2 + look) * cf_delta
        local damping = g.FLY_SPEED * 0.2 + 750
        if cf_delta.Position.Magnitude > 0 then
            g.fly_body_pos.D = damping
            tilt = math.min(tilt + 1, 25)
            g.fly_body_pos.Position = target_cf.Position
            idle_frames = 0
        else
            idle_frames = idle_frames + 1
            tilt = 1
            if (Root.Position - last_pos).Magnitude > 6 and idle_frames >= 4 then
                g.fly_body_pos.Position = Root.Position
            end
        end
        if g.fly_body_pos.D == damping then g.fly_body_gyro.CFrame = target_cf * CFrame.Angles(math.rad(tilt * move.Z), 0, 0) end
        t = tick()
        last_pos = Root.Position
    end))
    FL.connect("fly_input_began", g.UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe or not g.Currently_Flying or UserInputService.TouchEnabled then return end
        local d = g.fly_key_map[input.KeyCode]
        if d then g.fly_held_keys[input.KeyCode] = d end
    end))
    FL.connect("fly_input_ended", g.UserInputService.InputEnded:Connect(function(input)
        if UserInputService.TouchEnabled then return end
        if g.fly_key_map[input.KeyCode] then g.fly_held_keys[input.KeyCode] = nil end
    end))
    FL.connect("fly_char", Human:Connect(function() g.fly_stop() end))
end

g.fly = function(state)
    if state == g.Currently_Flying then return end
    if state then g.fly_start() else g.fly_stop() end
end

pcall(function() g.fly_setup() end)

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
    cc_tint                 = Color3.fromRGB(255, 191, 185),
    bloom_intensity         = 0.1,
    bloom_size              = 32,
    bloom_threshold         = 1,
    sunrays_intensity       = 3,
    sunrays_spread          = 5,
    blur_size               = 5,
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
    ClockTime               = 3,
    Brightness              = 2,
    Ambient                 = Color3.fromRGB(0, 0, 0),
    OutdoorAmbient          = Color3.fromRGB(70, 75, 110),
    ExposureCompensation    = 0.3,
    ColorShift_Top          = Color3.fromRGB(30, 30, 60),
    ColorShift_Bottom       = Color3.fromRGB(10, 10, 20),
    GlobalShadows           = true,
    ShadowSoftness          = 0.2,
    FogEnd                  = 80000,
    FogColor                = Color3.fromRGB(20, 20, 40),
    bloom_intensity         = 0.3,
    bloom_size              = 32,
    bloom_threshold         = 0.9,
    sunrays_intensity       = 0.0,
    sunrays_spread          = 0.0,
    blur_size               = 2.5,
    atmosphere_density      = 0.2,
    atmosphere_color        = Color3.fromRGB(17, 17, 46),
    atmosphere_decay        = Color3.fromRGB(28, 28, 39),
    atmosphere_glare        = 0.0,
    atmosphere_haze         = 0.4,
    sky_sun_angular_size    = 0,
    sky_moon_angular_size   = 18,
    sky_star_count          = 5000,
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
    local ter = Workspace.Terrain
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
        if n == "NIGHT_Bloom"
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
    return {bloom = bloom, sun = sun, blur = blur, atmo = atmo, sky = sky }
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
        if g.notify and typeof(g.notify) == "function" then g.notify("Success", "Night Enhancer disabled.", 3) end
    end
    return true
end

g.start_vehicle_orbit = function()
    if g.VehicleOrbit_Enabled then
        g.notify("Warning", "Flames Hub | Vehicle orbit is already enabled!", 3)
        return
    end
    local car = g.get_bike() or g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsDescendantOf(game or Workspace) then
        g.notify("Error", "Flames Hub | No vehicle found.", 3)
        return
    end
    local anchor = get_anchor(car)
    if not anchor or not anchor:IsDescendantOf(game or Workspace) then
        g.notify("Error", "Flames Hub | Could not resolve vehicle anchor.", 3)
        return
    end
    local locked_origin = anchor.CFrame.Position
    local locked_y      = anchor.CFrame.Position.Y
    local angle         = 0
    local last_t        = tick()
    local current_cf    = anchor.CFrame
    g.VehicleOrbit_Enabled = true
    FlamesLibrary.connect("VehicleOrbit_Loop", RunService.RenderStepped:Connect(function()
        if not g.VehicleOrbit_Enabled then return end
        if not car or not car:IsDescendantOf(game or Workspace) then
            g.stop_vehicle_orbit()
            return
        end
        local now         = tick()
        local dt          = now - last_t
        last_t            = now
        local speed       = math.clamp(g.VehicleOrbit_Speed or 20, 1, 100)
        local radius      = math.clamp(g.VehicleOrbit_Radius or 15, 1, 100)
        local smooth      = math.clamp(g.VehicleOrbit_Smooth or 0.12, 0.01, 1)
        local rad_per_sec = (speed / 100) * (2 * math.pi) * 1.5
        angle             = angle + rad_per_sec * dt
        local offset_x    = math.cos(angle) * radius
        local offset_z    = math.sin(angle) * radius
        local new_pos     = Vector3.new(locked_origin.X + offset_x, locked_y, locked_origin.Z + offset_z)
        local tangent_x   = -math.sin(angle)
        local tangent_z   =  math.cos(angle)
        local look_dir    = Vector3.new(tangent_x, 0, tangent_z).Unit
        local target_cf   = CFrame.lookAt(new_pos, new_pos + look_dir)
        current_cf        = current_cf:Lerp(target_cf, smooth)
        pcall(function() anchor.CFrame = current_cf end)
    end))
end

g.stop_vehicle_orbit = function()
    g.VehicleOrbit_Enabled = false
    FlamesLibrary.disconnect("VehicleOrbit_Loop")
end

g.vehicle_spin_running = g.vehicle_spin_running or false
g.vehicle_spin_speed   = g.vehicle_spin_speed   or 10
g.start_vehicle_spin = function()
    if g.vehicle_spin_running then
        g.notify("Warning", "Vehicle Spin: already enabled.", 3)
        return
    end

    local car = g.get_bike and g.get_bike() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsDescendantOf(game or Workspace) then
        g.notify("Error", "Vehicle Spin: no vehicle found.", 3)
        return
    end

    local anchor = get_anchor(car)
    if not anchor or not anchor:IsDescendantOf(game or Workspace) then
        g.notify("Error", "Vehicle Spin: could not resolve anchor.", 3)
        return
    end

    local existing = anchor:FindFirstChild("VehicleSpinBAV")
    if existing then existing:Destroy() end
    local bav = Instance.new("BodyAngularVelocity")
    bav.Name            = "VehicleSpinBAV"
    bav.MaxTorque       = Vector3.new(0, math.huge, 0)
    bav.AngularVelocity = Vector3.new(0, g.vehicle_spin_speed, 0)
    bav.Parent          = anchor

    g.vehicle_spin_running = true
    g._vehicle_spin_bav    = bav
    g._vehicle_spin_anchor = anchor
    FlamesLibrary.connect("vehicle_spin_speed_watch", RunService.Heartbeat:Connect(function()
        if not g.vehicle_spin_running then return end
        if not bav or not bav.Parent then
            g.stop_vehicle_spin()
            return
        end
        bav.AngularVelocity = Vector3.new(0, g.vehicle_spin_speed, 0)
    end))

    g.notify("Success", "Vehicle Spin: enabled.", 3)
end

g.stop_vehicle_spin = function()
    g.vehicle_spin_running = false
    FlamesLibrary.disconnect("vehicle_spin_speed_watch")
    if g._vehicle_spin_bav and g._vehicle_spin_bav.Parent then pcall(function() g._vehicle_spin_bav:Destroy() end) end
    g._vehicle_spin_bav    = nil
    g._vehicle_spin_anchor = nil
    g.notify("Success", "Vehicle Spin: disabled.", 3)
end

g.toggle_vehicle_spin = function() if g.vehicle_spin_running then g.stop_vehicle_spin() else g.start_vehicle_spin() end end
g.Set_Max_Zoom_Distance = function(distance)
    if not Validate_Number(distance) then distance = StarterPlayer.CameraMaxZoomDistance end
    pcall(function() speaker.CameraMaxZoomDistance = distance end)
end

local Atlas = loadstring(g.http_get("https://gitlab.com/flames2431233/Starter/-/raw/main/UIs/Atlas.lua?ref_type=heads", true))()
local UI = Atlas.new({
    Name = "Flames Hub | Bike Stars | "..tostring(g.Script_Version),
    ConfigFolder = "FlamesHub_Bike_Stars_Menu_Configuration",
    Color = Color3.fromRGB(162, 2, 255),
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

g.Refuel_Now_Button_UI = g.create_ui_element("Button", Vehicles_Section, {
Name = "Refuel Bike (FE)",
Callback = function()
    g.refuel_now()
end,})

g.Auto_Refuel_Threshold_Slider_UI = g.create_ui_element("Slider", Vehicles_Section, {
Name = "Auto Refuel Threshold (%)",
Min = 1,
Max = 99,
Default = g.auto_refuel_threshold or 20,
Flag = "Auto_Refuel_Threshold_Slider_UI_Flag",
Callback = function(val)
    g.auto_refuel_threshold = val
end}, "Auto_Refuel_Threshold_Slider_UI_Flag")

g.Auto_Refuel_Toggle_UI = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Auto Refuel Bike (FE)",
Default = g.auto_refuel_on or false,
Flag = "Auto_Refuel_Toggle_UI_Flag",
Callback = function(state)
    g.auto_refuel_toggle(state)
end}, "Auto_Refuel_Toggle_UI_Flag")
wait(0.1)
if g.auto_refuel_threshold and g.Auto_Refuel_Threshold_Slider_UI then g.Auto_Refuel_Threshold_Slider_UI:Set(g.auto_refuel_threshold or false) end

g.Noclip_Toggle_UI_Main = g.create_ui_element("Toggle", LocalPlayer_Section, {
Name = "NoClip (FE)",
Default = g.Noclip_Enabled or false,
Flag = "Noclip_Toggle_UI",
Callback = function(state)
    if not g.ToggleNoclip or typeof(g.ToggleNoclip) ~= "function" then
        if g.Noclip_Toggle_UI_Main then g.Noclip_Toggle_UI_Main:Set(false, false) end
        g.notify("Error", "NoClip function is currently unavailable.", 3)
        return
    end
    g.ToggleNoclip(state)
end,})

g.create_ui_element("Button", Home_Section, {
Name = "Infinite Premium",
Callback = function()
    g.infinite_premium()
end,})

g.Bike_Flash_Toggle_UI_Main = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Rainbow Bike (FAST, FE)",
Default = g.Bike_Flash_Active or false,
Flag = "Bike_Flash_Toggle_UI",
Callback = function(state)
    if state then
        if g.Bike_Rainbow_Toggle_UI_Main then g.Bike_Rainbow_Toggle_UI_Main:Set(false, false) end
        g.Bike_Rainbow_Toggle(false)
    end
    g.Bike_Flash_Toggle(state)
end}, "Bike_Flash_Toggle_UI")

g.Bike_Rainbow_Toggle_UI_Main = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "RGB Bike (FE)",
Default = g.Bike_RGB_Active or false,
Flag = "Bike_Rainbow_Toggle_UI",
Callback = function(state)
    if state then
        if g.Bike_Flash_Toggle_UI_Main then g.Bike_Flash_Toggle_UI_Main:Set(false, false) end
        g.Bike_Flash_Toggle(false)
    end
    g.Bike_Rainbow_Toggle(state)
end}, "Bike_Rainbow_Toggle_UI")

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
        local veh = g.get_bike and g.get_bike()
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

if rawset and rawget and typeof(rawset) == "function" and typeof(rawget) == "function" then
    g.Bike_Boost_Toggle_UI = g.create_ui_element("Toggle", Vehicles_Section, {
    Name = "Mod Bike Speed (FE)",
    Default = g.bike_boost_active or false,
    Flag = "Bike_Boost_Toggle_UI_Flag",
    Callback = function(state)
        g.bike_boost_toggle(state)
    end}, "Bike_Boost_Toggle_UI_Flag")

    g.Bike_Boost_Speed_Slider_UI = g.create_ui_element("Slider", Vehicles_Section, {
    Name = "Set Bike Speed (FE)",
    Min = 10,
    Max = 300,
    Default = g.bike_boost_speed or 100,
    Flag = "Bike_Boost_Speed_Slider_UI_Flag",
    Callback = function(val)
        g.bike_boost_speed = val
        if not rawset or typeof(rawset) ~= "function" then return end
        if g.bike_boost_active and g.bike_boosted then
            local tune = get_tune()
            if tune then rawset(tune, "FinalDrive", 50 / (val / 50)) end
        end
    end}, "Bike_Boost_Speed_Slider_UI_Flag")
    wait(0.1)
    if g.bike_boost_speed and g.Bike_Boost_Speed_Slider_UI then g.Bike_Boost_Speed_Slider_UI:Set(g.bike_boost_speed) end
end

g.create_ui_element("Button", UI_Section, {
Name = "Destroy GUI",
Callback = function()
    if g.stop_vehicle_fly and typeof(g.stop_vehicle_fly) == "function" then g.stop_vehicle_fly() end
    if g.Vehicle_Fly_Toggle_UI then g.Vehicle_Fly_Toggle_UI:Set(false, false) end
    if g.Vehicle_Float_Toggle_UI then g.Vehicle_Float_Toggle_UI:Set(false, false) end
    if g.stop_vehicle_float and typeof(g.stop_vehicle_float) == "function" then g.stop_vehicle_float() end
    g.Bike_Stars_Script_Hub_Running = false
    pcall(function() UI:Destroy() end)
end,})
task.wait(0.15)
g.make_round = g.make_round or function(obj, radius)
    local uic = Instance.new("UICorner")
    uic.CornerRadius = UDim.new(0, radius)
    uic.Parent = obj
end

g.make_stroke = g.make_stroke or function(obj, thickness, transparency)
    local uistroke = Instance.new("UIStroke")
    uistroke.Thickness = thickness or 1
    uistroke.Transparency = transparency or 0
    uistroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uistroke.Parent = obj
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
ScreenGui = CoreGui:FindFirstChild("TemporaryBanner_GUI") or Instance.new("ScreenGui")
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
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
label.Text = tostring(g.Announcement_Message)
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
DisplayTime = g.DisplayTimeMax
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