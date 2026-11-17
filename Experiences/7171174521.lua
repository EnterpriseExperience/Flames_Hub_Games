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
local place_id = "7171174521"
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
        g.notify("Error", "This game is not supported. Run this on American Plains Mudding only.", 30)
        return
    else
        warn("This game is not supported. Run this on American Plains Mudding only.")
        return
    end
end
task.wait(0.1)
if g.American_Plains_Mudding_Script_Hub_Running then
    if g.notify and typeof(g.notify) == "function" then
        g.notify("Warning", "American Plains Mudding Script Hub is already running, please click 'Destroy GUI' at the bottom of the script to exit the menu.", 15)
        return 
    else
        warn("American Plains Mudding Script Hub is already running.")
        return 
    end
end
wait(0.1)
g.American_Plains_Mudding_Script_Hub_Running = true
wait(0.1)
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
local Announcement_Message = "Fixed Open All Tailgate Doors (FE) not correctly teleporting to Tailgate Model + fixed Despawn Current Vehicle not working + added Car Alarm (FE)."
g.displayTimeMax = 15
local Workspace = g.Workspace or cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local Players = g.Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local ReplicatedStorage = g.ReplicatedStorage or cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local RunService = g.RunService or cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local UserInputService = g.UserInputService or cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local StarterPlayer = g.StarterPlayer or cloneref and cloneref(game:GetService("StarterPlayer")) or game:GetService("StarterPlayer")
local TweenService = g.TweenService or cloneref and cloneref(game:GetService("TweenService")) or game:GetService("TweenService")
local Lighting = g.Lighting or cloneref and cloneref(game:GetService("Lighting")) or game:GetService("Lighting")
local CoreGui = g.CoreGui or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local TeleportService = g.TeleportService or cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
local speaker = g.LocalPlayer or Players.LocalPlayer or Players:GetAttributeChangedSignal("LocalPlayer"):Wait()
local PlayerGui = g.PlayerGui or speaker:FindFirstChildOfClass("PlayerGui") or speaker:FindFirstChildWhichIsA("PlayerGui")
local lib = g.FlamesLibrary or getgenv().FlamesLibrary
local FL = lib
local FlamesLibrary = lib
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local is_mobile = IsMobile
local Raw_Version = "V1.2.1"
g.Script_Version = tostring(Raw_Version).."-APM"
g.fullbright_enabled = g.fullbright_enabled or false
g.FLY_SPEED = g.FLY_SPEED or 75
g.Currently_Flying = g.Currently_Flying or false
g.RGB_Paint_Active = g.RGB_Paint_Active or false
local control_module = require(speaker:FindFirstChildWhichIsA("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
local fly_current_device = speaker:FindFirstChild("currentDevice")
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

local function Find_Remotes_Folder_RS()
    local cache = g.Remotes_Folder_Found_RS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("Folder") and v.Name:lower():find("remotes") then
            g.Remotes_Folder_Found_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Remotes_Folder_Found_RS then pcall(function() Find_Remotes_Folder_RS() end) end

local function Find_Modules_Folder_RS()
    local cache = g.Modules_Folder_Found_RS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("Folder") and v.Name:lower():find("modules") then
            g.Modules_Folder_Found_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Modules_Folder_Found_RS then pcall(function() Find_Modules_Folder_RS() end) end

function Validate_Number(str)
	if tonumber(str) ~= nil or str == 'inf' then return true end
	return false
end

local function Find_Notification_Template_NotifModule()
    local cache = g.Notification_Template_NotifModule_Found_RS
    if cache and cache:IsA("Frame") then return cache end
    local modules_folder = g.Modules_Folder_Found_RS or Find_Modules_Folder_RS()
    if not modules_folder or not modules_folder:IsA("Folder") then return nil end
    for _, v in ipairs(modules_folder:GetDescendants()) do
        if v:IsA("Frame") and v.Name:lower():find("notification") and v.Name:lower():find("template") and v.Parent.Name:lower():find("notification") and v.Parent:IsA("ModuleScript") then
            g.Notification_Template_NotifModule_Found_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Notification_Template_NotifModule_Found_RS then pcall(function() Find_Notification_Template_NotifModule() end) end

local function Find_TailGate_For_Car(car)
    if not car or not car:IsA("Model") then return nil end
    local body = car and car:FindFirstChild("Body")
    if not body or not body:IsA("Model") then return end
    for _, v in ipairs(body:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower():find("tailgate") then
            return v
        end
    end
    return nil
end

local function Find_Proximity_Prompt_TailGate_For_Car(car)
    if not car or not car:IsA("Model") then return nil end
    local body = car and car:FindFirstChild("Body")
    if not body or not body:IsA("Model") then return end
    for _, v in ipairs(body:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.Name:lower():find("tailgate") and v.Name:lower():find("prox") and v.Parent.Name:lower():find("prox") and v.Parent.Name:lower():find("part") then
            return v
        end
    end
    return nil
end

g.Fire_All_Doors_Running = g.Fire_All_Doors_Running or false
g.Fire_All_Doors_Last = g.Fire_All_Doors_Last or 0
local COOLDOWN = 1
g.Fire_All_Doors = function()
    local now = os.clock()
    if g.Fire_All_Doors_Running then return end
    if (now - g.Fire_All_Doors_Last) < COOLDOWN then return end
    if not fireproximityprompt or typeof(fireproximityprompt) ~= "function" then return end
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
        humanoid.Sit = false
        task.wait(0.2)
    end
    task.wait(0.15)
    local lp_vehicle = g.get_lp_vehicle()
    for _, car in pairs(vehicles_folder:GetChildren()) do
        if not car:IsA("Model") then continue end
        local is_own = lp_vehicle ~= nil and car == lp_vehicle
        if is_own then continue end
        local anchor = Find_TailGate_For_Car(car)
        if anchor and anchor.Parent then
            pcall(function() char:PivotTo(anchor:GetPivot() + Vector3.new(0, 3, 0)) end)
            task.wait(0.1)
        end
        local deadline = os.clock() + 2
        repeat task.wait(0.1) until Find_Proximity_Prompt_TailGate_For_Car(car) ~= nil or os.clock() >= deadline
        local prompt = Find_Proximity_Prompt_TailGate_For_Car(car)
        if not prompt then continue end
        pcall(function() fireproximityprompt(prompt) end)
        task.wait(0.05)
    end
    safe_return()
end

g.Rejoin_Server = function()
	local function attempt()
		if #Players:GetPlayers() <= 1 then
			Players.LocalPlayer:Kick("\nRejoining...")
			wait()
			return pcall(function() TeleportService:Teleport(game.PlaceId, Players.LocalPlayer) end)
		else
			return pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer) end)
		end
	end

	local ok = attempt()
	if not ok then
		wait(0.5)
		attempt()
	end
end

g.create_notification = function(data, persistent)
    local main = PlayerGui:FindFirstChild("Main")
    if not main or not main:IsA("ScreenGui") then return end
    local notifications = main:FindFirstChild("Notifications")
    if not notifications or not notifications:IsA("Frame") then return end
    local notification_template = g.Notification_Template_NotifModule_Found_RS or Find_Notification_Template_NotifModule()
    if not notification_template or not notification_template:IsA("Frame") then return end
    local text          = data.Text or ""
    local text_color    = data.TextColor or Color3.fromRGB(255, 255, 255)
    local text_size     = data.TextSize or 14
    local bg_color      = data.BackgroundColor or Color3.fromRGB(44, 44, 44)
    local icon_color    = data.IconColor or Color3.fromRGB(255, 255, 255)
    local duration      = data.Duration or 3
    local cfg           = data.Config or {}
    local is_deletable  = cfg.IsDeletable
    local only_one      = cfg.OnlyOne
    local entry_name    = cfg.Name
    if only_one then
        for _, child in ipairs(notifications:GetChildren()) do
            local ok, label = pcall(function() return child:FindFirstChild("TextLabel") end)
            if ok and label and label.Text == text then return end
        end
    end

    local frame = notification_template:Clone()
    frame.Name = entry_name or tostring(math.random(100000, 999999))
    frame.BackgroundTransparency = 1
    frame.TextLabel.Text = text
    frame.TextLabel.TextColor3 = text_color
    frame.TextLabel.TextSize = text_size
    frame.BackgroundColor3 = bg_color
    frame.Delete.ImageColor3 = icon_color
    frame.Parent = notifications
    local deleted = false
    local connections = {}
    local function delete()
        if deleted then return end
        deleted = true
        for _, c in ipairs(connections) do if typeof(c) == "RBXScriptConnection" then c:Disconnect() end end
        task.spawn(function()
            TweenService:Create(frame, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
            TweenService:Create(frame.Delete, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 1 }):Play()
            TweenService:Create(frame.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 1 }):Play()
            TweenService:Create(frame.TextLabel, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play()
            task.wait(0.16)
            if frame and frame.Parent then frame:Destroy() end
        end)
    end

    TweenService:Create(frame, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(frame.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Transparency = 0 }):Play()
    TweenService:Create(frame.TextLabel, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { TextTransparency = 0 }):Play()
    local can_delete = not (is_deletable ~= nil and not is_deletable)
    if can_delete then
        table.insert(connections, frame.MouseEnter:Connect(function()
            TweenService:Create(frame.Delete, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageTransparency = 0 }):Play()
            TweenService:Create(frame.TextLabel, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { TextTransparency = 1 }):Play()
        end))
        table.insert(connections, frame.MouseLeave:Connect(function()
            TweenService:Create(frame.Delete, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { ImageTransparency = 1 }):Play()
            TweenService:Create(frame.TextLabel, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
        end))
        table.insert(connections, frame.Delete.MouseButton1Click:Connect(function() delete() end))
    end
    table.insert(connections, frame.Destroying:Once(function() delete() end))
    if not persistent then task.delay(duration, delete) end
    return delete
end

local function Mod_Shop_Folder_RS()
    local cache = g.Mod_Shop_Folder_Found_RS
    if cache and cache:IsA("Folder") then return cache end
    local re_folder = g.Remotes_Folder_Found_RS or Find_Remotes_Folder_RS()
    if not re_folder or not re_folder:IsA("Folder") then return nil end
    for _, v in ipairs(re_folder:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("mod") and v.Name:lower():find("shop") then
            g.Mod_Shop_Folder_Found_RS = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not g.Mod_Shop_Folder_Found_RS then pcall(function() Mod_Shop_Folder_RS() end) end

local function Mod_Shop_Remote_Event()
    local cache = g.Mod_Shop_Remote_Event_Found_RS
    if cache and cache.Parent and cache:IsA("RemoteEvent") then return cache end
    local mod_shop_folder = g.Mod_Shop_Folder_Found_RS or Mod_Shop_Folder_RS()
    if not mod_shop_folder or not mod_shop_folder:IsA("Folder") then return nil end
    for _, v in ipairs(mod_shop_folder:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("remote") and v.Name:lower():find("event") then
            g.Mod_Shop_Remote_Event_Found_RS = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not g.Mod_Shop_Remote_Event_Found_RS then pcall(function() Mod_Shop_Remote_Event() end) end

local function Find_Vehicle_Configuration_Remote_Event()
    local cache = g.Vehicle_Configuration_Remote_Event_Found_RS
    if cache and cache:IsA("RemoteEvent") then return cache end
    local re_folder = g.Remotes_Folder_Found_RS or Find_Remotes_Folder_RS()
    if not re_folder or not re_folder:IsA("Folder") then return nil end
    for _, v in ipairs(re_folder:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("vehicle") and v.Name:lower():find("config") then
            g.Vehicle_Configuration_Remote_Event_Found_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.Vehicle_Configuration_Remote_Event_Found_RS then pcall(function() Find_Vehicle_Configuration_Remote_Event() end) end

local function Find_Delete_Remote_Event()
    local cache = g.Despawn_Vehicle_Delete_Remote_Event
    if cache and cache:IsA("RemoteEvent") then return cache end
    local re_folder = g.Remotes_Folder_Found_RS or Find_Remotes_Folder_RS()
    if not re_folder or not re_folder:IsA("Folder") then return nil end
    for _, v in ipairs(re_folder:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("delete") and v.Name:lower():find("event") then
            g.Despawn_Vehicle_Delete_Remote_Event = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not g.Despawn_Vehicle_Delete_Remote_Event then pcall(function() Find_Delete_Remote_Event() end) end

g.despawn_current_vehicle = function()
    local e = g.Despawn_Vehicle_Delete_Remote_Event or Find_Delete_Remote_Event()
    if not e or not e:IsA("RemoteEvent") then return end
    e:FireServer("Slot1", "Vehicle")
    e:FireServer("Slot2", "Vehicle")
end

g.get_lp_vehicle = function()
    local vehicles_folder = g.Main_Vehicles_Folder_Found_WS or get_vehicles_folder()
    if not vehicles_folder or not vehicles_folder:IsA("Folder") then return nil end
    for _, v in ipairs(vehicles_folder:GetChildren()) do
        if v:IsA("Model") then
            local config = v:FindFirstChild("VehicleConfig")
            if config and config:IsA("Folder") then
                local owner_id = config:FindFirstChild("OwnerUserID")
                if owner_id and owner_id.Value == speaker.UserId then return v end
            end
        end
    end
    return nil
end

g.get_vehicle = g.get_lp_vehicle
g.Get_Current_Sitting_In_Vehicle = function()
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game or workspace) then return nil end
    local humanoid = g.Humanoid or (char and char:FindFirstChildOfClass("Humanoid")) or g.get_human(speaker)
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

g.toggle_car_alarm = function(state)
    if typeof(state) ~= "boolean" then return end
    g.car_alarm_enabled = state
    local FL = g.FlamesLibrary or getgenv().FlamesLibrary
    if not FL or typeof(FL) ~= "table" then return end
    if not state then
        FL.disconnect("car_alarm_loop")
        g.toggle_horn(false)
        return
    end
    FL.spawn("car_alarm_loop", "spawn", function()
        while g.car_alarm_enabled == true do
            local car = (g.get_lp_vehicle and g.get_lp_vehicle()) or (g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle())
            if not car or not car:IsDescendantOf(game) then FL.wait(0); continue end
            g.toggle_horn(true)
            FL.wait(0.5)
            g.toggle_horn(false)
            FL.wait(0.5)
        end
    end)
end

g.Set_Walk_Speed = function(speed)
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(game) then return end
    local humanoid = g.Humanoid or (char and char:FindFirstChildOfClass("Humanoid")) or g.get_human(speaker)
    if not humanoid or not humanoid.Parent or not humanoid:IsDescendantOf(game) then return end
    pcall(function() humanoid.WalkSpeed = speed end)
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
    if fly_current_device.Value == 1 then
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
    g.FL.disconnect("fly_loop")
    g.FL.disconnect("fly_input_began")
    g.FL.disconnect("fly_input_ended")
    g.FL.disconnect("fly_char")
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
    g.FL.connect("fly_loop", g.RunService.Heartbeat:Connect(function()
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
        if g.fly_body_pos.D == damping then
            g.fly_body_gyro.CFrame = target_cf * CFrame.Angles(math.rad(tilt * move.Z), 0, 0)
        end
        t = tick()
        last_pos = Root.Position
    end))
    g.FL.connect("fly_input_began", g.UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe or not g.Currently_Flying or fly_current_device.Value ~= 1 then return end
        local d = g.fly_key_map[input.KeyCode]
        if d then g.fly_held_keys[input.KeyCode] = d end
    end))
    g.FL.connect("fly_input_ended", g.UserInputService.InputEnded:Connect(function(input)
        if fly_current_device.Value ~= 1 then return end
        if g.fly_key_map[input.KeyCode] then g.fly_held_keys[input.KeyCode] = nil end
    end))
    g.FL.connect("fly_char", Human:Connect(function() g.fly_stop() end))
end

g.fly = function(state)
    if state == g.Currently_Flying then return end
    if state then g.fly_start() else g.fly_stop() end
end

pcall(function() g.fly_setup() end)
g.despawn_vehicles = function()
    local r = g.Despawn_Vehicle_Delete_Remote_Event or Find_Delete_Remote_Event()
    if not r or not r:IsA("RemoteEvent") then return end
    r:FireServer("Slot1", g.get_lp_vehicle and g.get_lp_vehicle())
    r:FireServer("Slot2", g.get_lp_vehicle and g.get_lp_vehicle())
end

g.Change_Paint_Colr_Vehicle = function(...)
    local e = g.Mod_Shop_Remote_Event_Found_RS or Mod_Shop_Remote_Event()
    if not e or not e:IsA("RemoteEvent") then return end
    e:FireServer("applyChanges", ...)
end

g.Flash_Vehicle_Toggle = function(state)
    if state == g.Flash_Paint_Active then return end
    g.Flash_Paint_Active = state
    if not state then
        FL.disconnect("flash_paint")
        return
    end
    local index = 1
    local timer = 0
    local interval = 0.08
    FL.connect("flash_paint", RunService.Heartbeat:Connect(function(dt)
        local Event = g.Mod_Shop_Remote_Event_Found_RS or g.Find_Mod_Shop_Remote_Event()
        if not Event or not Event:IsA("RemoteEvent") then
            g.Flash_Paint_Active = false
            FL.disconnect("flash_paint")
            return
        end
        timer = timer + dt
        if timer < interval then return end
        timer = 0
        index = (index % #g.colors) + 1
        local color = g.colors[index]
        local vehicle = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
        if not vehicle or not vehicle:IsDescendantOf(game or workspace) then return end
        Event:FireServer("applyChanges", {
            {
                index = 1,
                vehicleModel = vehicle,
                PaintData = {
                    Windows = { Primary = { Color = Color3.new(0, 0, 0), Transparency = 0.5 } },
                    Exterior = {
                        Primary = { Color = color, Reflectance = 0.029999999329447746, Texture = "rbxassetid://129370726755662" },
                        Secondary = { Color = Color3.new(0.141, 0.141, 0.141), Reflectance = 0.029999999329447746, Texture = "rbxassetid://129370726755662" }
                    },
                    Rims = { Primary = { Color = Color3.new(0.588, 0.588, 0.588), Reflectance = 0, Texture = "Metal1" } }
                },
                WheelInfo = {
                    Tires = {
                        ["Front Diameter"] = 1, ["Front Width"] = 1,
                        ["Front Sidewall Bulge"] = 0.5, SidewallHeight = 0.5,
                        ["Rear Sidewall Height"] = 0.5, ["Rear Width"] = 1,
                        ["Front Sidewall Height"] = 0.5, ["Rear Sidewall Bulge"] = 0.5,
                        Width = 1, Diameter = 1, Selected = {},
                        ["Rear Diameter"] = 1, SidewallBulge = 0.5
                    },
                    Rims = { IsDually = false }
                },
                turbochargers = 1,
                attachments = { Sub = {}, Main = {}, Positions = { Main = {}, Sub = {} } },
                suspensionInfo = {
                    Rear = { Min = 4.5, ["Ride Max"] = 5.55, Default = 5.5, Max = 5.5, ["Ride Height"] = 5.5, ["Ride Min"] = 4.55 },
                    Camber = 0, ["Rear Spring Force"] = 5000, Spacer = 0,
                    ["Front Spring Force"] = 5000, ["Front Spacer"] = 0,
                    Front = { Min = 4.5, ["Ride Max"] = 5.55, Default = 5.5, Max = 5.5, ["Ride Height"] = 5.5, ["Ride Min"] = 4.55 },
                    ["Rear Camber"] = 0, ["Rear Spacer"] = 0
                },
                attachmentData = {}, superchargers = 1,
                exhaustInfo = {}, attachmentCount = {},
                ChangedSections = { Paint = true },
                engineLevel = 5, FrameInfo = {}
            }
        })
    end))
end

g.Rainbow_Vehicle_Toggle = function(state)
    if state == g.RGB_Paint_Active then return end
    g.RGB_Paint_Active = state
    if not state then
        FL.disconnect("rgb_paint")
        return
    end
    local hue = 0
    FL.connect("rgb_paint", RunService.Heartbeat:Connect(function(dt)
        local Event = g.Mod_Shop_Remote_Event_Found_RS or Mod_Shop_Remote_Event()
        if not Event or not Event:IsA("RemoteEvent") then
            g.RGB_Paint_Active = false
            FL.disconnect("rgb_paint")
            return
        end
        hue = (hue + dt * 0.1) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        local vehicle = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
        if not vehicle or not vehicle:IsDescendantOf(game or workspace) then return end
        Event:FireServer("applyChanges", {
            {
                index = 1,
                vehicleModel = vehicle,
                PaintData = {
                    Windows = { Primary = { Color = Color3.new(0, 0, 0), Transparency = 0.5 } },
                    Exterior = {
                        Primary = { Color = color, Reflectance = 0.029999999329447746, Texture = "rbxassetid://129370726755662" },
                        Secondary = { Color = Color3.new(0.141, 0.141, 0.141), Reflectance = 0.029999999329447746, Texture = "rbxassetid://129370726755662" }
                    },
                    Rims = { Primary = { Color = Color3.new(0.588, 0.588, 0.588), Reflectance = 0, Texture = "Metal1" } }
                },
                WheelInfo = {
                    Tires = {
                        ["Front Diameter"] = 1, ["Front Width"] = 1,
                        ["Front Sidewall Bulge"] = 0.5, SidewallHeight = 0.5,
                        ["Rear Sidewall Height"] = 0.5, ["Rear Width"] = 1,
                        ["Front Sidewall Height"] = 0.5, ["Rear Sidewall Bulge"] = 0.5,
                        Width = 1, Diameter = 1, Selected = {},
                        ["Rear Diameter"] = 1, SidewallBulge = 0.5
                    },
                    Rims = { IsDually = false }
                },
                turbochargers = 1,
                attachments = { Sub = {}, Main = {}, Positions = { Main = {}, Sub = {} } },
                suspensionInfo = {
                    Rear = { Min = 4.5, ["Ride Max"] = 5.55, Default = 5.5, Max = 5.5, ["Ride Height"] = 5.5, ["Ride Min"] = 4.55 },
                    Camber = 0, ["Rear Spring Force"] = 5000, Spacer = 0,
                    ["Front Spring Force"] = 5000, ["Front Spacer"] = 0,
                    Front = { Min = 4.5, ["Ride Max"] = 5.55, Default = 5.5, Max = 5.5, ["Ride Height"] = 5.5, ["Ride Min"] = 4.55 },
                    ["Rear Camber"] = 0, ["Rear Spacer"] = 0
                },
                attachmentData = {}, superchargers = 1,
                exhaustInfo = {}, attachmentCount = {},
                ChangedSections = { Paint = true },
                engineLevel = 5, FrameInfo = {}
            }
        })
    end))
end

g.Rainbow_Rims_Toggle = function(state)
    if state == g.RGB_Rims_Active then return end
    g.RGB_Rims_Active = state
    if not state then
        FL.disconnect("rgb_rims")
        return
    end
    local hue = 0
    FL.connect("rgb_rims", RunService.Heartbeat:Connect(function(dt)
        local Event = g.Mod_Shop_Remote_Event_Found_RS or g.Find_Mod_Shop_Remote_Event()
        if not Event or not Event:IsA("RemoteEvent") then
            g.RGB_Rims_Active = false
            FL.disconnect("rgb_rims")
            return
        end
        hue = (hue + dt * 0.1) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        local vehicle = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
        if not vehicle or not vehicle:IsDescendantOf(game or workspace) then return end
        Event:FireServer("applyChanges", {
            {
                index = 1,
                vehicleModel = vehicle,
                PaintData = {
                    Windows = { Primary = { Color = Color3.new(0, 0, 0), Transparency = 0.5 } },
                    Exterior = {
                        Primary = { Color = Color3.new(0.141, 0.141, 0.141), Reflectance = 0.029999999329447746, Texture = "rbxassetid://129370726755662" },
                        Secondary = { Color = Color3.new(0.141, 0.141, 0.141), Reflectance = 0.029999999329447746, Texture = "rbxassetid://129370726755662" }
                    },
                    Rims = { Primary = { Color = color, Reflectance = 0, Texture = "Metal1" } }
                },
                WheelInfo = {
                    Tires = {
                        ["Front Diameter"] = 1, ["Front Width"] = 1,
                        ["Front Sidewall Bulge"] = 0.5, SidewallHeight = 0.5,
                        ["Rear Sidewall Height"] = 0.5, ["Rear Width"] = 1,
                        ["Front Sidewall Height"] = 0.5, ["Rear Sidewall Bulge"] = 0.5,
                        Width = 1, Diameter = 1, Selected = {},
                        ["Rear Diameter"] = 1, SidewallBulge = 0.5
                    },
                    Rims = { IsDually = false }
                },
                turbochargers = 1,
                attachments = { Sub = {}, Main = {}, Positions = { Main = {}, Sub = {} } },
                suspensionInfo = {
                    Rear = { Min = 4.5, ["Ride Max"] = 5.55, Default = 5.5, Max = 5.5, ["Ride Height"] = 5.5, ["Ride Min"] = 4.55 },
                    Camber = 0, ["Rear Spring Force"] = 5000, Spacer = 0,
                    ["Front Spring Force"] = 5000, ["Front Spacer"] = 0,
                    Front = { Min = 4.5, ["Ride Max"] = 5.55, Default = 5.5, Max = 5.5, ["Ride Height"] = 5.5, ["Ride Min"] = 4.55 },
                    ["Rear Camber"] = 0, ["Rear Spacer"] = 0
                },
                attachmentData = {}, superchargers = 1,
                exhaustInfo = {}, attachmentCount = {},
                ChangedSections = { Paint = true },
                engineLevel = 5, FrameInfo = {}
            }
        })
    end))
end

g.Rainbow_Windows_Toggle = function(state)
    if state == g.RGB_Windows_Active then return end
    g.RGB_Windows_Active = state
    if not state then
        FL.disconnect("rgb_windows")
        return
    end
    local hue = 0
    FL.connect("rgb_windows", RunService.Heartbeat:Connect(function(dt)
        local Event = g.Mod_Shop_Remote_Event_Found_RS or g.Find_Mod_Shop_Remote_Event()
        if not Event or not Event:IsA("RemoteEvent") then
            g.RGB_Windows_Active = false
            FL.disconnect("rgb_windows")
            return
        end
        hue = (hue + dt * 0.1) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        local vehicle = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
        if not vehicle or not vehicle:IsDescendantOf(game or workspace) then return end
        Event:FireServer("applyChanges", {
            {
                index = 1,
                vehicleModel = vehicle,
                PaintData = {
                    Windows = { Primary = { Color = color, Transparency = 0.5 } },
                    Exterior = {
                        Primary   = { Color = Color3.new(0.141, 0.141, 0.141), Reflectance = 0.029999999329447746, Texture = "rbxassetid://129370726755662" },
                        Secondary = { Color = Color3.new(0.141, 0.141, 0.141), Reflectance = 0.029999999329447746, Texture = "rbxassetid://129370726755662" }
                    },
                    Rims = { Primary = { Color = Color3.new(0.588, 0.588, 0.588), Reflectance = 0, Texture = "Metal1" } }
                },
                WheelInfo = {
                    Tires = {
                        ["Front Diameter"] = 1, ["Front Width"] = 1,
                        ["Front Sidewall Bulge"] = 0.5, SidewallHeight = 0.5,
                        ["Rear Sidewall Height"] = 0.5, ["Rear Width"] = 1,
                        ["Front Sidewall Height"] = 0.5, ["Rear Sidewall Bulge"] = 0.5,
                        Width = 1, Diameter = 1, Selected = {},
                        ["Rear Diameter"] = 1, SidewallBulge = 0.5
                    },
                    Rims = { IsDually = false }
                },
                turbochargers = 1,
                attachments = { Sub = {}, Main = {}, Positions = { Main = {}, Sub = {} } },
                suspensionInfo = {
                    Rear = { Min = 4.5, ["Ride Max"] = 5.55, Default = 5.5, Max = 5.5, ["Ride Height"] = 5.5, ["Ride Min"] = 4.55 },
                    Camber = 0, ["Rear Spring Force"] = 5000, Spacer = 0,
                    ["Front Spring Force"] = 5000, ["Front Spacer"] = 0,
                    Front = { Min = 4.5, ["Ride Max"] = 5.55, Default = 5.5, Max = 5.5, ["Ride Height"] = 5.5, ["Ride Min"] = 4.55 },
                    ["Rear Camber"] = 0, ["Rear Spacer"] = 0
                },
                attachmentData = {}, superchargers = 1,
                exhaustInfo = {}, attachmentCount = {},
                ChangedSections = { Paint = true },
                engineLevel = 5, FrameInfo = {}
            }
        })
    end))
end

g.Rainbow_Full_Toggle = function(state)
    if state == g.RGB_Full_Active then return end
    g.RGB_Full_Active = state
    if not state then
        FL.disconnect("rgb_full")
        return
    end
    local hue = 0
    FL.connect("rgb_full", RunService.Heartbeat:Connect(function(dt)
        local Event = g.Mod_Shop_Remote_Event_Found_RS or g.Find_Mod_Shop_Remote_Event()
        if not Event or not Event:IsA("RemoteEvent") then
            g.RGB_Full_Active = false
            FL.disconnect("rgb_full")
            return
        end
        hue = (hue + dt * 0.1) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        local vehicle = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
        if not vehicle or not vehicle:IsDescendantOf(game or workspace) then return end
        Event:FireServer("applyChanges", {
            {
                index = 1,
                vehicleModel = vehicle,
                PaintData = {
                    Windows = { Primary = { Color = color, Transparency = 0.5 } },
                    Exterior = {
                        Primary   = { Color = color, Reflectance = 0.029999999329447746, Texture = "rbxassetid://129370726755662" },
                        Secondary = { Color = color, Reflectance = 0.029999999329447746, Texture = "rbxassetid://129370726755662" }
                    },
                    Rims = { Primary = { Color = color, Reflectance = 0, Texture = "Metal1" } }
                },
                WheelInfo = {
                    Tires = {
                        ["Front Diameter"] = 1, ["Front Width"] = 1,
                        ["Front Sidewall Bulge"] = 0.5, SidewallHeight = 0.5,
                        ["Rear Sidewall Height"] = 0.5, ["Rear Width"] = 1,
                        ["Front Sidewall Height"] = 0.5, ["Rear Sidewall Bulge"] = 0.5,
                        Width = 1, Diameter = 1, Selected = {},
                        ["Rear Diameter"] = 1, SidewallBulge = 0.5
                    },
                    Rims = { IsDually = false }
                },
                turbochargers = 1,
                attachments = { Sub = {}, Main = {}, Positions = { Main = {}, Sub = {} } },
                suspensionInfo = {
                    Rear = { Min = 4.5, ["Ride Max"] = 5.55, Default = 5.5, Max = 5.5, ["Ride Height"] = 5.5, ["Ride Min"] = 4.55 },
                    Camber = 0, ["Rear Spring Force"] = 5000, Spacer = 0,
                    ["Front Spring Force"] = 5000, ["Front Spacer"] = 0,
                    Front = { Min = 4.5, ["Ride Max"] = 5.55, Default = 5.5, Max = 5.5, ["Ride Height"] = 5.5, ["Ride Min"] = 4.55 },
                    ["Rear Camber"] = 0, ["Rear Spacer"] = 0
                },
                attachmentData = {}, superchargers = 1,
                exhaustInfo = {}, attachmentCount = {},
                ChangedSections = { Paint = true },
                engineLevel = 5, FrameInfo = {}
            }
        })
    end))
end

g.vehicle_fly               = g.vehicle_fly               or false
g.vehicle_fly_speed         = g.vehicle_fly_speed          or 3
g.vehiclefly_conns          = g.vehiclefly_conns           or {}
g.vehiclefly_control        = g.vehiclefly_control         or {f=0,b=0,l=0,r=0,q=0,e=0}
g.vehiclefly_noclip         = g.vehiclefly_noclip          or false
g.vehiclefly_locked_yaw     = g.vehiclefly_locked_yaw      or nil
g.vehiclefly_collisions          = g.vehiclefly_collisions          or {}
g.vehiclefly_passenger_collisions = g.vehiclefly_passenger_collisions or {}
g.vehiclefly_seat_conns          = g.vehiclefly_seat_conns          or {}
g.vehiclefly_seat_occupants      = g.vehiclefly_seat_occupants      or {}
g.vehiclefly_gyro_store          = g.vehiclefly_gyro_store          or {}
g.vehiclefly_mover_store         = g.vehiclefly_mover_store         or {}
local function get_anchor(model)
    if not model or not model:IsDescendantOf(workspace) then return nil end
    local body = model:FindFirstChild("Body")
    if body then
        local wt = body:FindFirstChild("#Weight")
        if wt and wt:IsA("BasePart") then return wt end
    end
    local pp = model.PrimaryPart
    if pp then
        local ok, root = pcall(function() return pp.AssemblyRootPart end)
        if ok and root and root ~= pp and root:IsDescendantOf(model) then return root end
        return pp
    end
    local ds = model:FindFirstChild("DriveSeat")
    if ds then
        local ok, root = pcall(function() return ds.AssemblyRootPart end)
        if ok and root and root:IsDescendantOf(model) then return root end
        return ds
    end
    return model:FindFirstChildWhichIsA("BasePart", true)
end

local function noclip_char(char)
    if not char or not char:IsDescendantOf(game) then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            if g.vehiclefly_passenger_collisions[part] == nil then g.vehiclefly_passenger_collisions[part] = part.CanCollide end
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
                local prev = g.vehiclefly_seat_occupants[seat]
                local occ = seat.Occupant
                if occ and occ.Parent and occ.Parent:IsDescendantOf(game) then
                    g.vehiclefly_seat_occupants[seat] = occ.Parent
                    noclip_char(occ.Parent)
                else
                    g.vehiclefly_seat_occupants[seat] = nil
                    if prev then restore_char(prev) end
                end
            end)
        end
    end
end

local function disable_body_gyros(model, anchor)
    for _, v in ipairs(model:GetDescendants()) do
        if v:IsA("BodyGyro") and v.Parent and v.Parent:IsA("BasePart") then
            local ok, root = pcall(function() return v.Parent.AssemblyRootPart end)
            if ok and root and anchor and root == anchor then
                local ok2, torque = pcall(function() return v.MaxTorque end)
                if ok2 then
                    g.vehiclefly_gyro_store[v] = torque
                    pcall(function() v.MaxTorque = Vector3.zero end)
                end
            end
        end
    end
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
    for mover, saved in pairs(g.vehiclefly_mover_store) do
        if mover and mover.Parent then pcall(function() mover.Enabled = saved end) end
    end
    g.vehiclefly_mover_store = {}
    for gyro, saved_torque in pairs(g.vehiclefly_gyro_store) do
        if gyro and gyro.Parent then pcall(function() gyro.MaxTorque = saved_torque end) end
    end
    g.vehiclefly_gyro_store = {}
end

g.enable_vehicle_noclip = function()
    if g.vehiclefly_noclip then return end
    g.vehiclefly_noclip = true
    g.vehiclefly_collisions = {}
    local car = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsA("Model") or not car:IsDescendantOf(workspace) then return end
    if g.ToggleNoclip and typeof(g.ToggleNoclip) == "function" then pcall(g.ToggleNoclip, true) end
    for _, v in ipairs(car:GetDescendants()) do
        if v:IsA("BasePart") then
            g.vehiclefly_collisions[v] = v.CanCollide
            v.CanCollide = false
        end
    end
    watch_seats(car)
    noclip_char(g.Character or g.get_char and g.get_char(speaker))
end

g.disable_vehicle_noclip = function()
    if not g.vehiclefly_noclip then return end
    g.vehiclefly_noclip = false
    if g.ToggleNoclip and typeof(g.ToggleNoclip) == "function" then pcall(g.ToggleNoclip, false) end
    for _, conn in pairs(g.vehiclefly_seat_conns) do pcall(function() conn:Disconnect() end) end
    g.vehiclefly_seat_conns = {}
    for part, state in pairs(g.vehiclefly_passenger_collisions) do
        if part and part.Parent then pcall(function() part.CanCollide = state end) end
    end
    g.vehiclefly_passenger_collisions = {}
    g.vehiclefly_seat_occupants = {}
    for part, state in pairs(g.vehiclefly_collisions) do
        if part and part.Parent then pcall(function() part.CanCollide = state end) end
    end
    g.vehiclefly_collisions = {}
    restore_char(g.Character or g.get_char and g.get_char(speaker))
end

local function silent_stop()
    g.vehicle_fly = false
    g.vehiclefly_locked_yaw = nil
    g.disable_vehicle_noclip()
    g.vf_cleanup()
    g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
    if g.Vehicle_Fly_Toggle_UI then pcall(function() g.Vehicle_Fly_Toggle_UI:Set(false, false) end) end
end

g.start_vehicle_fly = function()
    if g.vehiclefly_bg or g.vehiclefly_bv then return end
    local car = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsDescendantOf(workspace) then
        g.disable_vehicle_noclip()
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
    disable_body_gyros(car, anchor)
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
    g.vehiclefly_conns.destroy_watch = car.AncestryChanged:Connect(function() if not car:IsDescendantOf(game) then silent_stop() end end)
    g.vehiclefly_conns.render = RunService.Heartbeat:Connect(function()
        if not g.vehicle_fly then
            pcall(function() bv.Velocity = Vector3.zero end)
            g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
            return
        end
        if not anchor.Parent or not g.get_lp_vehicle() or not g.Get_Current_Sitting_In_Vehicle() then
            g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
            silent_stop()
            return
        end
        pcall(function() anchor.AssemblyAngularVelocity = Vector3.zero end)
        local cam = workspace.CurrentCamera or workspace:FindFirstChildOfClass("Camera")
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
            local yaw = math.atan2(-look.X, -look.Z)
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
    g.vehicle_fly = false
    g.vehiclefly_locked_yaw = nil
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
    local car = g.get_vehicle and g.get_vehicle() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
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

g.start_vehicle_orbit = function()
    if g.VehicleOrbit_Enabled then
        g.notify("Warning", "Flames Hub | Vehicle orbit is already enabled!", 3)
        return
    end

    local car = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle()
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

    local use_pivot     = car.PrimaryPart ~= nil
    local locked_origin = anchor.CFrame.Position
    local locked_y      = anchor.CFrame.Position.Y
    local angle         = 0
    local last_t        = tick()
    local current_cf    = anchor.CFrame
    g.VehicleOrbit_Enabled = true
    FlamesLibrary.connect("VehicleOrbit_Loop", RunService.RenderStepped:Connect(function()
        if not g.VehicleOrbit_Enabled then return end
        if not car or not car:IsDescendantOf(game or workspace) then
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
        angle = angle + rad_per_sec * dt
        local offset_x  = math.cos(angle) * radius
        local offset_z  = math.sin(angle) * radius
        local new_pos   = Vector3.new(locked_origin.X + offset_x, locked_y, locked_origin.Z + offset_z)
        local tangent_x = -math.sin(angle)
        local tangent_z =  math.cos(angle)
        local look_dir  = Vector3.new(tangent_x, 0, tangent_z).Unit
        local target_cf = CFrame.lookAt(new_pos, new_pos + look_dir)
        current_cf = current_cf:Lerp(target_cf, smooth)
        if use_pivot then
            pcall(function() car:PivotTo(current_cf) end)
        else
            pcall(function() anchor.CFrame = current_cf end)
        end
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

    local car = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsDescendantOf(game or workspace) then
        g.notify("Error", "Vehicle Spin: no vehicle found.", 3)
        return
    end

    local anchor = car.PrimaryPart
    if not anchor then for _, v in ipairs(car:GetDescendants()) do if v:IsA("VehicleSeat") then anchor = v; break end end end
    if not anchor then anchor = car:FindFirstChildWhichIsA("BasePart", true) end
    if not anchor or not anchor:IsDescendantOf(game or workspace) then
        g.notify("Error", "Vehicle Spin: could not resolve anchor.", 3)
        return
    end

    local existing = anchor:FindFirstChild("VehicleSpinBAV")
    if existing then existing:Destroy() end
    local bav = Instance.new("BodyAngularVelocity")
    bav.Name           = "VehicleSpinBAV"
    bav.MaxTorque      = Vector3.new(0, math.huge, 0)
    bav.AngularVelocity = Vector3.new(0, g.vehicle_spin_speed, 0)
    bav.Parent         = anchor

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
    if g._vehicle_spin_bav and g._vehicle_spin_bav.Parent then
        pcall(function() g._vehicle_spin_bav:Destroy() end)
    end
    g._vehicle_spin_bav    = nil
    g._vehicle_spin_anchor = nil
    g.notify("Success", "Vehicle Spin: disabled.", 3)
end

g.toggle_vehicle_spin = function() if g.vehicle_spin_running then g.stop_vehicle_spin() else g.start_vehicle_spin() end end
g.vehicle_boost_running = g.vehicle_boost_running or false
g.vehicle_boost_speed   = g.vehicle_boost_speed or 75
local STUDS_TO_MPH = 0.44704
local MPH_TO_STUDS = 1 / STUDS_TO_MPH
g.start_vehicle_boost = function()
    if g.vehicle_boost_running then
        g.notify("Warning", "Vehicle Boost: already active.", 3)
        return
    end

    local car = g.get_vehicle() or g.Get_Current_Sitting_In_Vehicle()
    if not car or not car:IsDescendantOf(game or workspace) then
        g.notify("Error", "Vehicle Boost: no vehicle found.", 3)
        return
    end

    local anchor = car.PrimaryPart
    local seat = nil
    if not anchor then
        for _, v in ipairs(car:GetDescendants()) do
            if v:IsA("VehicleSeat") then anchor = v; seat = v; break end
        end
    end
    if not seat then
        for _, v in ipairs(car:GetDescendants()) do
            if v:IsA("VehicleSeat") then seat = v; break end
        end
    end
    if not anchor then anchor = car:FindFirstChildWhichIsA("BasePart", true) end
    if not anchor or not anchor:IsDescendantOf(game or workspace) then
        g.notify("Error", "Vehicle Boost: could not resolve anchor.", 3)
        return
    end

    local existing = anchor:FindFirstChild("VehicleBoostBV")
    if existing then existing:Destroy() end
    local function get_game_mph_scale()
        if not seat or not seat.Parent then return MPH_TO_STUDS end
        local current_studs = seat.AssemblyLinearVelocity.Magnitude
        local speedometer_val = seat:GetAttribute("Speed") or seat:GetAttribute("SpeedMPH") or seat:GetAttribute("DisplaySpeed")
        if speedometer_val and speedometer_val > 0 and current_studs > 1 then return current_studs / speedometer_val end
        return MPH_TO_STUDS
    end

    local bv = Instance.new("BodyVelocity")
    bv.Name     = "VehicleBoostBV"
    bv.MaxForce = Vector3.new(9e9, 0, 9e9)
    bv.Velocity = Vector3.zero
    bv.Parent   = anchor

    g.vehicle_boost_running = true
    g._vehicle_boost_bv     = bv
    g._vehicle_boost_anchor = anchor
    local calibrated_scale = MPH_TO_STUDS
    local calibration_ticks = 0
    FlamesLibrary.connect("vehicle_boost_heartbeat", RunService.Heartbeat:Connect(function(dt)
        if not g.vehicle_boost_running then return end
        if not bv or not bv.Parent or not anchor or not anchor.Parent then
            g.stop_vehicle_boost()
            return
        end

        if calibration_ticks < 60 then
            local sampled = get_game_mph_scale()
            if sampled ~= MPH_TO_STUDS then
                calibrated_scale = sampled
            end
            calibration_ticks = calibration_ticks + 1
        end

        local pressing_forward = false
        if IsMobile and control_module then
            local ok, mv = pcall(function() return control_module:GetMoveVector() end)
            if ok and mv and mv.Z < -0.1 then pressing_forward = true end
        else
            pressing_forward = UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up)
        end

        if pressing_forward then
            local target_studs = (g.vehicle_boost_speed or 100) * calibrated_scale
            local look = (seat or anchor).CFrame.LookVector
            local flat_look = Vector3.new(look.X, 0, look.Z)
            if flat_look.Magnitude > 0.01 then
                flat_look = flat_look.Unit
            else
                flat_look = look
            end
            local current = bv.Velocity
            local target  = flat_look * target_studs
            bv.Velocity   = current:Lerp(target, math.min(1, dt * 18))
        else
            local current = bv.Velocity
            bv.Velocity = current:Lerp(Vector3.zero, math.min(1, dt * 18))
        end
    end))

    g.notify("Success", "Vehicle Boost: active.", 3)
end

g.stop_vehicle_boost = function()
    g.vehicle_boost_running = false
    FlamesLibrary.disconnect("vehicle_boost_heartbeat")
    if g._vehicle_boost_bv and g._vehicle_boost_bv.Parent then pcall(function() g._vehicle_boost_bv:Destroy() end) end
    g._vehicle_boost_bv     = nil
    g._vehicle_boost_anchor = nil
    g.notify("Success", "Vehicle Boost: disabled.", 3)
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

    local anchor = get_anchor(car)
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

        local anchor_now = get_anchor(car_now)
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
        local anchor_now = get_anchor(car_now)
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

g.set_suspension_front = function(free_length, max_length)
    max_length = max_length or (free_length + 0.133)
    local veh = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
    if not veh or not veh:IsA("Model") or not veh:IsDescendantOf(game or workspace) then return end
    local wheels = veh:FindFirstChild("Wheels")
    if not wheels or not wheels.Parent or not wheels:IsA("Model") then return end
    for _, name in ipairs({"FL", "FR"}) do
        local wheel = wheels:FindFirstChild(name)
        if wheel and wheel.Parent then
            local spring = wheel:FindFirstChild("Spring")
            if spring and spring:IsA("SpringConstraint") then
                g.Suspension_Vehicle_Front = free_length
                pcall(function()
                    spring.FreeLength = free_length
                    spring.MaxLength = max_length
                end)
            end
        end
    end
end

g.set_suspension_rear = function(free_length, max_length)
    max_length = max_length or (free_length + 0.133)
    local veh = g.get_lp_vehicle and g.get_lp_vehicle() or g.Get_Current_Sitting_In_Vehicle and g.Get_Current_Sitting_In_Vehicle()
    if not veh or not veh:IsA("Model") or not veh:IsDescendantOf(game or workspace) then return end
    local wheels = veh:FindFirstChild("Wheels")
    if not wheels or not wheels.Parent or not wheels:IsA("Model") then return end
    for _, name in ipairs({"RL", "RR"}) do
        local wheel = wheels:FindFirstChild(name)
        if wheel and wheel.Parent then
            local spring = wheel:FindFirstChild("Spring")
            if spring and spring:IsA("SpringConstraint") then
                g.Suspension_Vehicle_Rear = free_length
                pcall(function()
                    spring.FreeLength = free_length
                    spring.MaxLength = max_length
                end)
            end
        end
    end
end
wait(0.1)
g.vehicle_twerk = function(state)
    g.Suspension_Bounce_Active = state
    if state then
        FL.spawn("suspension_bounce", "spawn", function()
            local low = true
            while g.Suspension_Bounce_Active == true do
                if low then
                    g.set_suspension_rear(6)
                else
                    g.set_suspension_rear(10)
                end
                low = not low
                task.wait(0.35)
            end
        end)
    else
        FL.disconnect("suspension_bounce")
        wait(0.25)
        g.set_suspension_rear(5)
    end
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

local Atlas = loadstring(g.http_get("https://gitlab.com/flames2431233/Starter/-/raw/main/UIs/Atlas.lua?ref_type=heads", true))()
local UI = Atlas.new({
    Name = "Flames Hub | American Plains Mudding | "..tostring(g.Script_Version),
    ConfigFolder = "FlamesHub_APM_Menu_Configuration",
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

g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Car Alarm (FE)",
Default = g.car_alarm_enabled or false,
Flag = "Car_Alarm_Toggle_UI",
Callback = function(state)
    g.toggle_car_alarm(state)
end}, "Car_Alarm_Toggle_UI")

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

g.Flash_Vehicle_Toggle_UI_Main = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Rainbow Vehicle (FAST, FE)",
Default = g.Flash_Paint_Active or false,
Flag = "Flash_Vehicle_Toggle_UI",
Callback = function(state)
    if state then
        if g.Rainbow_Vehicle_Toggle_UI_Main then g.Rainbow_Vehicle_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Rims_Toggle_UI_Main then g.Rainbow_Rims_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Windows_Toggle_UI_Main then g.Rainbow_Windows_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Full_Toggle_UI_Main then g.Rainbow_Full_Toggle_UI_Main:Set(false, false) end
        g.Rainbow_Vehicle_Toggle(false)
        g.Rainbow_Rims_Toggle(false)
        g.Rainbow_Windows_Toggle(false)
        g.Rainbow_Full_Toggle(false)
    end
    g.Flash_Vehicle_Toggle(state)
end}, "Flash_Vehicle_Toggle_UI")

g.Rainbow_Vehicle_Toggle_UI_Main = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "RGB Vehicle (FE)",
Default = g.RGB_Paint_Active or false,
Flag = "Rainbow_Vehicle_Toggle_UI",
Callback = function(state)
    if state then
        if g.Flash_Vehicle_Toggle_UI_Main then g.Flash_Vehicle_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Rims_Toggle_UI_Main then g.Rainbow_Rims_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Windows_Toggle_UI_Main then g.Rainbow_Windows_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Full_Toggle_UI_Main then g.Rainbow_Full_Toggle_UI_Main:Set(false, false) end
        g.Flash_Vehicle_Toggle(false)
        g.Rainbow_Rims_Toggle(false)
        g.Rainbow_Windows_Toggle(false)
        g.Rainbow_Full_Toggle(false)
    end
    g.Rainbow_Vehicle_Toggle(state)
end}, "Rainbow_Vehicle_Toggle_UI")

g.Rainbow_Rims_Toggle_UI_Main = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Rainbow Rims (FE)",
Default = g.RGB_Rims_Active or false,
Flag = "Rainbow_Rims_Toggle_UI",
Callback = function(state)
    if state then
        if g.Flash_Vehicle_Toggle_UI_Main then g.Flash_Vehicle_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Vehicle_Toggle_UI_Main then g.Rainbow_Vehicle_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Windows_Toggle_UI_Main then g.Rainbow_Windows_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Full_Toggle_UI_Main then g.Rainbow_Full_Toggle_UI_Main:Set(false, false) end
        g.Flash_Vehicle_Toggle(false)
        g.Rainbow_Vehicle_Toggle(false)
        g.Rainbow_Windows_Toggle(false)
        g.Rainbow_Full_Toggle(false)
    end
    g.Rainbow_Rims_Toggle(state)
end}, "Rainbow_Rims_Toggle_UI")

g.Rainbow_Windows_Toggle_UI_Main = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Rainbow Windows (FE)",
Default = g.RGB_Windows_Active or false,
Flag = "Rainbow_Windows_Toggle_UI",
Callback = function(state)
    if state then
        if g.Flash_Vehicle_Toggle_UI_Main then g.Flash_Vehicle_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Vehicle_Toggle_UI_Main then g.Rainbow_Vehicle_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Rims_Toggle_UI_Main then g.Rainbow_Rims_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Full_Toggle_UI_Main then g.Rainbow_Full_Toggle_UI_Main:Set(false, false) end
        g.Flash_Vehicle_Toggle(false)
        g.Rainbow_Vehicle_Toggle(false)
        g.Rainbow_Rims_Toggle(false)
        g.Rainbow_Full_Toggle(false)
    end
    g.Rainbow_Windows_Toggle(state)
end}, "Rainbow_Windows_Toggle_UI")

g.Rainbow_Full_Toggle_UI_Main = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Rainbow Full Body (FE)",
Default = g.RGB_Full_Active or false,
Flag = "Rainbow_Full_Toggle_UI",
Callback = function(state)
    if state then
        if g.Flash_Vehicle_Toggle_UI_Main then g.Flash_Vehicle_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Vehicle_Toggle_UI_Main then g.Rainbow_Vehicle_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Rims_Toggle_UI_Main then g.Rainbow_Rims_Toggle_UI_Main:Set(false, false) end
        if g.Rainbow_Windows_Toggle_UI_Main then g.Rainbow_Windows_Toggle_UI_Main:Set(false, false) end
        g.Flash_Vehicle_Toggle(false)
        g.Rainbow_Vehicle_Toggle(false)
        g.Rainbow_Rims_Toggle(false)
        g.Rainbow_Windows_Toggle(false)
    end
    g.Rainbow_Full_Toggle(state)
end}, "Rainbow_Full_Toggle_UI")

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

g.Suspension_Vehicle_Front = g.Suspension_Vehicle_Front or 3
g.Suspension_Vehicle_Rear = g.Suspension_Vehicle_Rear or 3
g.Suspension_Front_Vehicle_Slider_UI = g.create_ui_element("Slider", Vehicles_Section, {
Name = "Vehicle Front Suspension (FE)",
Min = 0.1,
Max = 15,
Default = g.Suspension_Vehicle_Front or 3,
Flag = "Suspension_Front_Slider_Vehicle",
Callback = function(val)
    g.set_suspension_front(val)
end}, "Suspension_Front_Slider_Vehicle")

g.Suspension_Rear_Vehicle_Slider_UI = g.create_ui_element("Slider", Vehicles_Section, {
Name = "Vehicle Rear Suspension (FE)",
Min = 0.1,
Max = 15,
Default = g.Suspension_Vehicle_Rear or 3,
Flag = "Suspension_Rear_Slider_Vehicle",
Callback = function(val)
    g.set_suspension_rear(val)
end}, "Suspension_Rear_Slider_Vehicle")
wait(0.1)
if g.Suspension_Front_Vehicle_Slider_UI then g.Suspension_Front_Vehicle_Slider_UI:Set(g.Suspension_Vehicle_Front or 3) end
if g.Suspension_Rear_Vehicle_Slider_UI then g.Suspension_Rear_Vehicle_Slider_UI:Set(g.Suspension_Vehicle_Rear or 3) end

g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Vehicle Twerk (FE)",
Default = g.Vehicle_Twerk_Running or false,
Flag = "Vehicle_Twerk_Toggle_UI",
Callback = function(state)
    if state then
        g.vehicle_twerk(true)
    else
        g.vehicle_twerk(false)
    end
end}, "Vehicle_Twerk_Toggle_UI")

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

g.create_ui_element("Slider", Vehicles_Section, {
Name = "Vehicle Spin Speed",
Min = 1,
Max = 100,
Default = g.vehicle_spin_speed or 15,
Flag = "Vehicle_Spin_Speed_Slider_UI",
Callback = function(val)
    g.vehicle_spin_speed = val
end}, "Vehicle_Spin_Speed_Slider_UI")

g.Vehicle_Spin_Toggle_UI = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Vehicle Spin (FE)",
Default = g.Vehicle_Spin_Running or false,
Flag = "Vehicle_Spin_Toggle_UI",
Callback = function(state)
    if state then
        if g.Vehicle_Spin_Running then
            g.notify("Error", "Vehicle spin is already enabled.", 3)
            return
        end
        local human = g.Humanoid or (g.Character or speaker.Character) and (g.Character or speaker.Character):FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
        if not human or not human.Sit then
            g.notify("Error", "You must be in a vehicle to use Vehicle Spin.", 3)
            g.Vehicle_Spin_Running = false
            if g.Vehicle_Spin_Toggle_UI then g.Vehicle_Spin_Toggle_UI:Set(false, false) end
            return
        end
        local veh = g.get_vehicle() or g.Get_Current_Sitting_In_Vehicle()
        if not veh or not veh:IsA("Model") or not veh:IsDescendantOf(game) then
            g.notify("Error", "No vehicle detected.", 3)
            g.Vehicle_Spin_Running = false
            if g.Vehicle_Spin_Toggle_UI then g.Vehicle_Spin_Toggle_UI:Set(false, false) end
            return
        end
        g.start_vehicle_spin()
    else
        g.stop_vehicle_spin()
    end
end}, "Vehicle_Spin_Toggle_UI")

g.create_ui_element("Button", Vehicles_Section, {
Name = "Toggle All Players Car Tailgates (FE)",
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

g.Vehicle_Boost_Speed_BV_Toggle_UI = g.create_ui_element("Toggle", Vehicles_Section, {
Name = "Vehicle Speed Boost (FE)",
Default = g.vehicle_boost_running or false,
Flag = "Vehicle_Boost_Toggle_UI",
Callback = function(state)
    if state then
        g.start_vehicle_boost()
    else
        g.stop_vehicle_boost()
    end
end}, "Vehicle_Boost_Toggle_UI")

g.Vehicle_Boost_Speed_Slider_UI = g.create_ui_element("Slider", Vehicles_Section, {
Name = "Vehicle Boost Speed",
Min = 10,
Max = 300,
Default = g.vehicle_boost_speed or 100,
Flag = "Vehicle_Boost_Speed_Slider_UI",
Callback = function(val)
    g.vehicle_boost_speed = val
end}, "Vehicle_Boost_Speed_Slider_UI")
wait(0.1)
if g.vehicle_boost_speed and g.Vehicle_Boost_Speed_Slider_UI then g.Vehicle_Boost_Speed_Slider_UI:Set(g.vehicle_boost_speed) end

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
    if not g.despawn_current_vehicle and typeof(g.despawn_current_vehicle) ~= "function" then return end
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

g.create_ui_element("Slider", Vehicles_Section, {
Name = "Teleport Duration / Time",
Min = 0,
Max = 10,
Default = g.vehicle_tp_duration or 1,
Flag = "Vehicle_TP_Duration_Slider_UI",
Callback = function(val)
    g.vehicle_tp_duration = val
end}, "Vehicle_TP_Duration_Slider_UI")

g.create_ui_element("Button", UI_Section, {
Name = "Destroy GUI",
Callback = function()
    if g.stop_vehicle_fly and typeof(g.stop_vehicle_fly) == "function" then g.stop_vehicle_fly() end
    if g.Vehicle_Fly_Toggle_UI then g.Vehicle_Fly_Toggle_UI:Set(false, false) end
    if g.Vehicle_Float_Toggle_UI then g.Vehicle_Float_Toggle_UI:Set(false, false) end
    if g.stop_vehicle_float and typeof(g.stop_vehicle_float) == "function" then g.stop_vehicle_float() end
    g.American_Plains_Mudding_Script_Hub_Running = false
    pcall(function() UI:Destroy() end)
end,})

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
-- [[ do not make it RGB this time. ]] --
--if g.flowrgb and typeof(g.flowrgb) == "function" then g.flowrgb("banner_announcement_frame_flowing_rgb_smooth_conn", 3.5, frame, true) end
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