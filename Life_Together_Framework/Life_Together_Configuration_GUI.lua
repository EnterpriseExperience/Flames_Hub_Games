if not game:IsLoaded() then game.Loaded:Wait() end
local g = getgenv()
g.Game = game
if g.FlamesConfigManager then return end
g.FlamesConfigManager = true
local function safe_wrap(service)
    if cloneref then
        return cloneref(game:GetService(service))
    else
        return game:GetService(service)
    end
end
wait(0.25)
if not g.GlobalEnvironmentFramework_Initialized then
    loadstring(game:HttpGet("https://pastebin.com/raw/T25mDhBZ"))()
    wait(0.1)
    g.GlobalEnvironmentFramework_Initialized = true
end
wait(0.25)
local debug_ext = (debug :: any)
local lib = getgenv().FlamesLibrary
local fw = lib.wait
local function get_or_set(global, value)
    local v = rawget and rawget(getgenv(), global) or getgenv()[global]
    if v == nil then
        getgenv()[global] = value
        return value
    end
    return v
end
wait(0.25)
HttpService  = get_or_set("HttpService", safe_wrap("HttpService"))
Players = get_or_set("Players", safe_wrap("Players"))
LocalPlayer = get_or_set("LocalPlayer", Players.LocalPlayer)
CoreGui = get_or_set("CoreGui", safe_wrap("CoreGui"))
RunService = get_or_set("RunService", safe_wrap("RunService"))
UserInputService = get_or_set("UserInputService", safe_wrap("UserInputService"))
local is_mob_device = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local parent_gui = CoreGui
local config_path = "Flames_Admin_Config.json"
local default_config = {
    Enrolled = "disabled",
    RainbowVehicle = "disabled",
    RainbowPhone = "disabled",
    AntiCarFling = "disabled",
    AntiFling = "disabled",
    AntiVoid = "disabled",
    NoClip = "disabled",
    NoSit = "disabled",
    AntiOutfitStealer = "disabled",
    JobSpammer = "disabled"
}

local colors = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(128, 128, 128),
    Color3.fromRGB(0, 0, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 165, 0),
    Color3.fromRGB(139, 69, 19),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(50, 205, 50),
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 155, 172),
    Color3.fromRGB(128, 0, 128),
}

ReplicatedStorage = get_or_set("ReplicatedStorage", safe_wrap("ReplicatedStorage"))
Workspace = get_or_set("Workspace", safe_wrap("Workspace"))
Modules = get_or_set("Modules", ReplicatedStorage:FindFirstChild("Modules"))
Core = get_or_set("Core", Modules and Modules:FindFirstChild("Core"))
Game_Folder = get_or_set("Game_Folder", Modules and Modules:FindFirstChild("Game"))
InvisibleMode = get_or_set("InvisibleMode", Game_Folder and require(Game_Folder:FindFirstChild("InvisibleMode")))
CharacterBillboardGui = get_or_set("CharacterBillboardGui", Game_Folder and require(Game_Folder:FindFirstChild("CharacterBillboardGui")))
PlotMarker = get_or_set("PlotMarker", Game_Folder and require(Game_Folder:FindFirstChild("PlotMarker")))
Data = get_or_set("Data", Core and require(Core:FindFirstChild("Data")))
Phone_Module = get_or_set("Phone_Module", Game_Folder and Game_Folder:FindFirstChild("Phone"))
Phone = get_or_set("Phone", Game_Folder and require(Game_Folder:FindFirstChild("Phone")))
Privacy = get_or_set("Privacy", Core and require(Core:FindFirstChild("Privacy")))
AppModules = get_or_set("AppModules", Phone_Module and Phone_Module:FindFirstChild("AppModules"))
Messages = get_or_set("Messages", AppModules and require(AppModules:FindFirstChild("Messages")))
Network = get_or_set("Network", Core and require(Core:FindFirstChild("Net")))
CCTV = get_or_set("CCTV", Game_Folder and require(Game_Folder:FindFirstChild("CCTV")))
Tween = get_or_set("Tween", Core and require(Core:FindFirstChild("Tween")))
Seat = get_or_set("Seat", Game_Folder and require(Game_Folder:FindFirstChild("Seat")))
Blur = get_or_set("Blur", Core and require(Core:FindFirstChild("Blur")))
RateLimiter = get_or_set("RateLimiter", Core and require(Core:FindFirstChild("RateLimiter")))
UI = get_or_set("UI", Core and require(Core:FindFirstChild("UI")))
local Camera = Workspace.CurrentCamera or Workspace:FindFirstChildOfClass("Camera")

function set_enrolled_state(state)
    local valid = (state == "enabled" or state == "disabled")
    if not valid then return  end
    if not isfile(config_path) then writefile(config_path, HttpService:JSONEncode(default_config)) end
    local config = HttpService:JSONDecode(readfile(config_path))
    config.Enrolled = state
    writefile(config_path, HttpService:JSONEncode(config))
end
wait(0.1)
getgenv().set_enrolled_state = set_enrolled_state
wait(0.1)
function get_enrolled_state()
    if not isfile(config_path) then
        writefile(config_path, HttpService:JSONEncode(default_config))
    end

    local config = HttpService:JSONDecode(readfile(config_path))
    return config.Enrolled
end
wait(0.1)
getgenv().get_enrolled_state = get_enrolled_state
if not getgenv().FreePay_Originals then getgenv().FreePay_Originals = {} end
local originals = getgenv().FreePay_Originals
local function freepay_func(state)
    if not Data or not Data.initiate then g.notify("Error", "Data module missing.", 3); return end
    if not debug_ext.getupvalue then g.notify("Error", "Executor does not support getupvalue.", 3); return end
    if not ReplicatedStorage then g.notify("Error", "ReplicatedStorage is missing.", 3); return end
    if state == nil then state = not getgenv().Has_Free_LifePremium end
    if state then
        if getgenv().Has_Free_LifePremium then g.notify("Error", "FreePay is already enabled.", 3); return end
        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            local val = v:GetAttribute("IsVerifiedOnly")
            if val ~= nil then
                originals[v] = val
                v:SetAttribute("IsVerifiedOnly", false)
            end
        end

        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            local val = v:GetAttribute("IsAirportRestricted")
            if val ~= nil then
                originals[v] = val
                v:SetAttribute("IsAirportRestricted", false)
            end
        end
        pcall(function()
            local update = debug_ext.getupvalue(Data.initiate, 2)
            local _, original = Data.initiate("is_verified")
            originals["_is_verified"] = original
            update("is_verified", true)
        end)
        getgenv().Has_Free_LifePremium = true
        g.notify("Success", "FreePay is now enabled.", 5)
    else
        if not getgenv().Has_Free_LifePremium then g.notify("Error", "FreePay is not enabled.", 3); return end
        for obj, val in pairs(originals) do
            if obj ~= "_is_verified" and typeof(obj) == "Instance" then
                if obj.Parent and obj:GetAttribute("IsVerifiedOnly") ~= nil then
                    obj:SetAttribute("IsVerifiedOnly", val)
                end
            end
        end

        if debug_ext and debug_ext.getupvalue then
            local update = debug_ext.getupvalue(Data.initiate, 2)
            update("is_verified", originals["_is_verified"] or false)
        end
        table.clear(originals)
        getgenv().Has_Free_LifePremium = false
        g.notify("Success", "FreePay is now disabled.", 5)
    end
end

getgenv().set_enrolled_state("enabled")
if not getgenv().FreePayFuncToggle then getgenv().FreePayFuncToggle = freepay_func end
function change_vehicle_color(Color, Vehicle) getgenv().Send("vehicle_color", Color, Vehicle) end
function change_phone_color(New_Color) getgenv().Send("phone_color", New_Color) end
task.wait(0.2)
getgenv().RGB_Phone = getgenv().RGB_Phone or function(Boolean)
    local key = "rgb_phone_loop"
    if Boolean == true then
        if getgenv().RGB_Rainbow_Phone then g.notify("Warning", "Rainbow Phone is already enabled.", 3); return end
        getgenv().RGB_Rainbow_Phone = true
        getgenv().notify("Success", "Started RGB/Rainbow Phone.", 5)
        lib.spawn(key, "spawn", function()
            while getgenv().RGB_Rainbow_Phone == true do
                for _, color in ipairs(colors) do
                    if getgenv().RGB_Rainbow_Phone ~= true then
                        lib.disconnect(key)
                        return
                    end
                    change_phone_color(color)
                    fw(0)
                end
            end
            lib.disconnect(key)
        end)
    elseif Boolean == false then
        if not getgenv().RGB_Rainbow_Phone then g.notify("Warning", "Rainbow Phone is not enabled.", 5); return end
        getgenv().RGB_Rainbow_Phone = false
        lib.disconnect(key)
        g.notify("Success", "Stopped RGB/Rainbow Phone.", 5)
        fw(0.1)
        change_phone_color(Color3.fromRGB(255, 255, 255))
    end
end

local NOCLIP_KEY = "noclip_loop"
getgenv().Noclip_Enabled = getgenv().Noclip_Enabled or false
local function ToggleNoclip(toggle)
    if toggle == true then
        if getgenv().Noclip_Enabled then g.notify("Error", "Noclip already enabled!", 3); return end
        getgenv().Noclip_Enabled = true
        g.notify("Success", "Noclip has been enabled.", 5)
        lib.connect(NOCLIP_KEY, RunService.Stepped:Connect(function()
            if not getgenv().Noclip_Enabled then return end
            local char = g.Character or g.LocalPlayer.Character or g.get_char(LocalPlayer, 5) or g.Char:get()
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end))
    elseif toggle == false then
        if not getgenv().Noclip_Enabled then g.notify("Error", "Noclip not enabled!", 3); return end
        getgenv().Noclip_Enabled = false
        lib.disconnect(NOCLIP_KEY)
        local char = getgenv().Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part and part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end

        g.notify("Success", "Noclip has been disabled.", 3)
    else
        g.notify("Error", "Invalid arg, expected true/false", 5)
        return
    end
end
if not getgenv().Toggleable_Noclip then getgenv().Toggleable_Noclip = ToggleNoclip end
function RGB_Vehicle(Boolean)
    local key = "rgb_vehicle_loop"
    if Boolean == true then
        if getgenv().Rainbow_Vehicle then g.notify("Warning", "Flames Hub | Rainbow Vehicle is already enabled.", 5); return end
        getgenv().Rainbow_Vehicle = true
        getgenv().notify("Success", "Flames Hub | Rainbow Vehicle is now enabled.", 5)
        lib.spawn(key, "spawn", function()
            while getgenv().Rainbow_Vehicle == true do
                for _, color in ipairs(colors) do
                    if getgenv().Rainbow_Vehicle ~= true then
                        lib.disconnect(key)
                        return
                    end
                    change_vehicle_color(color, g.get_vehicle())
                    fw(0)
                end
            end
            lib.disconnect(key)
        end)
    elseif Boolean == false then
        if not getgenv().Rainbow_Vehicle then g.notify("Warning", "Flames Hub | Rainbow Vehicle is not enabled.", 5); return end
        getgenv().Rainbow_Vehicle = false
        lib.disconnect(key)
        g.notify("Success", "Flames Hub | Rainbow Vehicle is now disabled.", 5)
    end
end

getgenv().anti_outfit_copier = function(toggle)
    if toggle == true then
        if getgenv().anti_outfit_stealer then g.notify("Error", "Anti Outfit Stealer is already enabled!", 5); return end
        if getgenv().FlamesLibrary.is_alive("AntiFitStealerConn") then g.notify("Error", "Anti Outfit Stealer is already enabled! [connection]", 5); return end
        g.notify("Success", "Flames Hub | Anti Outfit Stealer is now active.", 7)
        getgenv().ToggleAntiFit_Stealer = function(state)
            if not state then
                getgenv().anti_outfit_stealer = false
                lib.disconnect("AntiFitStealerConn")
                local hide_outfit_toggle = getgenv().LocalPlayer:GetAttribute("hide_view_outfit")
                if hide_outfit_toggle and hide_outfit_toggle == false then
                    getgenv().Send("hide_view_outfit", true)
                    g.notify("Success", "hide_view_outfit setting changed, reverted change (keep it on).", 3)
                end
            else
                getgenv().anti_outfit_stealer = true
                if getgenv().Send then getgenv().Send("bio", "`~ Flames Hub Anti Stealer Is Enabled ~`") end
            end

            local last_check = 0
            local target_bio = "`~ Flames Hub Anti Stealer Is Enabled ~`"
            lib.connect("AntiFitStealerConn", getgenv().RunService.Heartbeat:Connect(function()
                local now = tick()
                if now - last_check < 0.4 then return end
                last_check = now
                local hide_outfit_toggle = getgenv().LocalPlayer:GetAttribute("hide_view_outfit")
                if hide_outfit_toggle and hide_outfit_toggle == false then
                    getgenv().Send("hide_view_outfit", true)
                    g.notify("Success", "hide_view_outfit setting changed, reverted change (keep it on).", 3)
                end

                if getgenv().anti_outfit_stealer then
                    local current_bio = getgenv().LocalPlayer:GetAttribute("bio")
                    if current_bio ~= target_bio then
                        getgenv().Send("bio", target_bio)
                        g.notify("Success", "Bio was changed, reverted back.", 3)
                    end
                end
            end))
        end
        fw(0.1)
        getgenv().ToggleAntiFit_Stealer(true)
    elseif toggle == false then
        if not getgenv().anti_outfit_stealer then g.notify("Error", "Anti Outfit Copier is not enabled!", 3); return end
        getgenv().anti_outfit_stealer = false
        getgenv().FlamesLibrary.disconnect("AntiFitStealerConn")
        getgenv().ToggleAntiFit_Stealer(false)
        g.notify("Success", "Disabled Anti Outfit Stealer.", 5)
    else
        return
    end
end

function anti_sit_func(toggle)
    local lib = g.FlamesLibrary
    local key = "anti_sit_loop"
    local fw = lib.wait
	if not g.Game_Folder then return end
    g.Seat = require(g.Game_Folder:FindFirstChild("Seat"))
    if toggle == true then
        if g.Not_Ever_Sitting then g.notify("Warning", "AntiSit is already enabled!", 3); return end
        g.Not_Ever_Sitting = true
        g.notify("Success", "Anti-Sit is now enabled!", 5)
        g.show_notification("Success:", "Anti-Sit is now enabled!", "Normal")
        lib.spawn(key, "spawn", function()
            while g.Not_Ever_Sitting == true do
                g.Seat.enabled.set(false)
                fw(0)
            end
            lib.disconnect(key)
        end)
    elseif toggle == false then
        if not g.Not_Ever_Sitting then g.notify("Warning", "AntiSit is not enabled!", 5); return end
        g.Not_Ever_Sitting = false
        lib.disconnect(key)
        fw(0.2)
        g.Seat.enabled.set(true)
        g.notify("Success", "Sitting is now enabled!", 5)
        Phone.show_notification("Success:", "Sitting is now enabled!", "Normal")
    else
        return
    end
end

function disable_notifications(state)
    if state == true then
        g.Notifications_Disabled_In_Flames_Hub = true
    elseif state == false then
        g.Notifications_Disabled_In_Flames_Hub = false
    else
        return 
    end
end

function anti_void(toggle)
    if toggle == true then
        if getgenv().Anti_Void_Enabled_Bool then g.notify("Warning", "Anti-Void is already enabled!", 3); return end
        if not getgenv().originalFPDH then getgenv().originalFPDH = getgenv().Workspace.FallenPartsDestroyHeight end
        getgenv().Workspace.FallenPartsDestroyHeight = -9e9
        getgenv().Anti_Void_Enabled_Bool = true
        g.notify("Success", "Enabled anti-void.", 5)
    elseif toggle == false then
        if not getgenv().Anti_Void_Enabled_Bool then g.notify("Warning", "Anti-Void has not been enabled!", 3); return end
        if not getgenv().originalFPDH then getgenv().originalFPDH = -500; g.notify("Error", "Original FPDH didn't exist at runtime, try this command again!", 5); return end
        getgenv().Workspace.FallenPartsDestroyHeight = getgenv().originalFPDH
        getgenv().Anti_Void_Enabled_Bool = false
        g.notify("Success", "Disabled anti-void.", 5)
    end
end

local VEHICLE_KEY = "vehicle_destroyer"
getgenv().VehicleDestroyer_Enabled = getgenv().VehicleDestroyer_Enabled or false
getgenv().DisableVehicleDestroyer = function()
    if not getgenv().VehicleDestroyer_Enabled then g.notify("Warning", "Anti Vehicle Fling is not enabled!", 3); return end
    fw(0.1)
    getgenv().VehicleDestroyer_Enabled = false
    lib.disconnect(VEHICLE_KEY)
    g.notify("Success", "Anti Vehicle Fling has been disabled.", 5)
end

getgenv().job_spammer = getgenv().job_spammer or function(toggle)
    local lib = getgenv().FlamesLibrary
    local key = "job_spammer_loop"

    if toggle == true then
        if getgenv().Every_Job then g.notify("Warning", "Job-Spammer is already enabled! disable it first.", 5); return end
        getgenv().Every_Job = true
        g.notify("Success", "Job-Spammer is now enabled.", 3)
        lib.spawn(key, "spawn", function()
            while getgenv().Every_Job == true do
            task.wait(0)
                getgenv().Send("job", "Police")
                fw(0)
                getgenv().Send("job", "Firefighter")
                fw(0)
                getgenv().Send("job", "Baker")
                fw(0)
                getgenv().Send("job", "Pizza Worker")
                fw(0)
                getgenv().Send("job", "Barista")
                fw(0)
                getgenv().Send("job", "Doctor")
                fw(0)
            end
            lib.disconnect(key)
        end)
    elseif toggle == false then
        if not getgenv().Every_Job then g.notify("Warning", "Job-Spammer is not enabled!", 5); return end
        getgenv().Every_Job = false
        lib.disconnect(key)
        g.notify("Success", "Job-Spammer is now disabled.", 3)
    end
end

g.VehicleDestroyer_Enabled = g.VehicleDestroyer_Enabled or false
g.vehicle_parts_cache = g.vehicle_parts_cache or {}
local _uid = 0
local function make_key(prefix, inst) _uid = _uid + 1; return prefix .. "_" .. tostring(inst):gsub("[^%w]", "") .. "_" .. _uid end
local function is_in_vehicle(obj, vehicle) return vehicle and obj and obj:IsDescendantOf(vehicle) end
local function process_veh_part(part)
    if not part:IsA("BasePart") then return end
    if g.vehicle_parts_cache[part] then return end
    local my_vehicle = g.get_vehicle()
    if my_vehicle and is_in_vehicle(part, my_vehicle) then return end
    part.CanCollide = false
    g.vehicle_parts_cache[part] = true

    local key = make_key("VehicleDestroyer_PartCleanup", part)
    lib.connect(key, part.AncestryChanged:Connect(function()
        if not part:IsDescendantOf(game) then
            g.vehicle_parts_cache[part] = nil
            lib.disconnect(key)
        end
    end))
end

local function process_veh_model(model)
    if not model or not model.Parent then
        local elapsed = 0
        repeat task.wait(0.5); elapsed = elapsed + 0.5 until (model and model.Parent) or elapsed >= 10
        if not model or not model.Parent then return end
    end

    for _, inst in ipairs(model:GetDescendants()) do
        if inst:IsA("BasePart") then
            process_veh_part(inst)
        end
    end

    lib.connect(make_key("VehicleDestroyer_DescAdded", model), model.DescendantAdded:Connect(function(desc)
        if not g.VehicleDestroyer_Enabled then return end
        if desc:IsA("BasePart") then
            process_veh_part(desc)
        end
    end))
end

local function setup_vehicles_folder(folder)
    for _, child in ipairs(folder:GetChildren()) do
        if child:IsA("Model") then
            process_veh_model(child)
        elseif child:IsA("BasePart") then
            process_veh_part(child)
        end
    end

    if lib.is_alive("VehicleDestroyer_ChildAdded") then
        lib.disconnect("VehicleDestroyer_ChildAdded")
    end

    lib.connect("VehicleDestroyer_ChildAdded", folder.ChildAdded:Connect(function(child)
        if not g.VehicleDestroyer_Enabled then return end
        if child:IsA("Model") then
            process_veh_model(child)
        elseif child:IsA("BasePart") then
            process_veh_part(child)
        end
    end))

    if g.notify and typeof(g.notify) == "function" then g.notify("Success", "Flames Hub | Anti Vehicle Fling is now enabled.", 5) end
end

local function clear_all()
   g.VehicleDestroyer_Enabled = false
   table.clear(g.vehicle_parts_cache)
   lib.cleanup_all()
end

g.anti_car_fling = g.anti_car_fling or function(state)
    if state == true then
        if g.VehicleDestroyer_Enabled then
            if g.notify and typeof(g.notify) == "function" then g.notify("Warning", "Flames Hub | Anti Vehicle Fling is already enabled.", 5) end
            return 
        end
        g.VehicleDestroyer_Enabled = true
        table.clear(g.vehicle_parts_cache)
        local vehicles_folder = Workspace:FindFirstChild("Vehicles")
        if vehicles_folder then setup_vehicles_folder(vehicles_folder) end
        lib.connect("VehicleDestroyer_FolderWatch", Workspace.ChildAdded:Connect(function(child)
            if not g.VehicleDestroyer_Enabled then return end
            if child.Name == "Vehicles" and child:IsA("Folder") then setup_vehicles_folder(child) end
        end))
    elseif state == false then
        if not g.VehicleDestroyer_Enabled then
            if g.notify and typeof(g.notify) == "function" then g.notify("Warning", "Anti Vehicle Fling not enabled.", 5) end
            return 
        end

        clear_all()
        if g.notify then g.notify("Success", "Anti Vehicle Fling disabled.", 5) end
    end
end

if not isfile(config_path) then writefile(config_path, HttpService:JSONEncode(default_config)) end
local config = HttpService:JSONDecode(readfile(config_path))
local function save_config() writefile(config_path, HttpService:JSONEncode(config)) end
if config.Enrolled ~= "enabled" then return  end
local ScreenGui = parent_gui:FindFirstChild("FlamesAdminGUI") or Instance.new("ScreenGui")
ScreenGui.Name = "FlamesAdminGUI"
ScreenGui.Parent = parent_gui
ScreenGui.Enabled = false
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = false

local Frame = Instance.new("Frame")
Frame.AutomaticSize = Enum.AutomaticSize.None
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundTransparency = 1
Header.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Size = UDim2.new(0.850000024, 0, 0, 45)
Title.Position = UDim2.new(0, -5, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "👑 Flames Hub | Config 👑"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextScaled = false

local Close = Instance.new("TextButton")
Close.Parent = Header
Close.Size = UDim2.new(0, 35, 0, 35)
Close.Position = UDim2.new(1, -40, 0, 5)
Close.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 100, 100)
Close.Font = Enum.Font.GothamBold
Close.TextScaled = true
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 8)
Close.MouseButton1Click:Connect(function() ScreenGui.Enabled = false end)

local Toggle_List = Instance.new("ScrollingFrame")
Toggle_List.Size = UDim2.new(1, 0, 1, -45)
Toggle_List.Position = UDim2.new(0, 0, 0, 45)
Toggle_List.BackgroundTransparency = 1
Toggle_List.BorderSizePixel = 0
Toggle_List.ScrollBarThickness = 4
Toggle_List.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
Toggle_List.CanvasSize = UDim2.new(0, 0, 0, 0)
Toggle_List.AutomaticCanvasSize = Enum.AutomaticSize.Y
Toggle_List.Parent = Frame

local List_Layout = Instance.new("UIListLayout")
List_Layout.SortOrder = Enum.SortOrder.LayoutOrder
List_Layout.Padding = UDim.new(0, 8)
List_Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
List_Layout.Parent = Toggle_List

local List_Padding = Instance.new("UIPadding")
List_Padding.PaddingTop = UDim.new(0, 8)
List_Padding.PaddingBottom = UDim.new(0, 10)
List_Padding.PaddingLeft = UDim.new(0, 10)
List_Padding.PaddingRight = UDim.new(0, 14)
List_Padding.Parent = Toggle_List

getgenv().Flames_Features = getgenv().Flames_Features or {}
local function handle_toggle(name, state)
    if name == "RainbowVehicle" then
        if state == "enabled" then
            RGB_Vehicle(true)
        else
            RGB_Vehicle(false)
        end
    elseif name == "RainbowPhone" then
        if state == "enabled" then
            g.RGB_Phone(true)
        else
            g.RGB_Phone(false)
        end
    elseif name == "AntiCarFling" then
        if state == "enabled" then
            g.anti_car_fling(true)
        else
            g.anti_car_fling(false)
        end
    elseif name == "AntiFling" then
        if state == "enabled" then
            if getgenv().Toggle_AntiFling_Boolean_Func then getgenv().Toggle_AntiFling_Boolean_Func(true) end
        else
            if getgenv().Toggle_AntiFling_Boolean_Func then getgenv().Toggle_AntiFling_Boolean_Func(false) end
        end
    elseif name == "AntiVoid" then
        if state == "enabled" then
            anti_void(true)
        else
            anti_void(false)
        end
    elseif name == "NoClip" then
        if state == "enabled" then
            if getgenv().Toggleable_Noclip then getgenv().Toggleable_Noclip(true) end
        else
            if getgenv().Toggleable_Noclip then getgenv().Toggleable_Noclip(false) end
        end
    elseif name == "NoSit" then
        if state == "enabled" then
            anti_sit_func(true)
        else
            anti_sit_func(false)
        end
    elseif name == "AntiOutfitStealer" then
        if state == "enabled" then
            g.anti_outfit_copier(true)
        else
            g.anti_outfit_copier(false)
        end
    elseif name == "JobSpammer" then
        if state == "enabled" then
            g.job_spammer(true)
        else
            g.job_spammer(false)
        end
    elseif name == "FreePremium" then
        if state == "enabled" then
            freepay_func(true)
        else
            freepay_func(false)
        end
    elseif name == "DisableNotifications" then
        if state == "enabled" then
            disable_notifications(true)
        else
            disable_notifications(false)
        end
    end
end

local function create_toggle(name, order)
    if config[name] == "enabled" then handle_toggle(name, "enabled") end
    task.defer(function()
        local Button = Instance.new("TextButton")
        Button.Parent = Toggle_List
        Button.Size = UDim2.new(1, -20, 0, 35)
        Button.LayoutOrder = order
        Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextColor3 = Color3.fromRGB(0, 0, 0)
        Button.Font = Enum.Font.GothamBold
        Button.TextScaled = true
        Button.Text = name .. ": " .. (config[name] == "enabled" and "ON" or "OFF")
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)
        Button.MouseButton1Click:Connect(function()
            config[name] = (config[name] == "enabled") and "disabled" or "enabled"
            Button.Text = name .. ": " .. (config[name] == "enabled" and "ON" or "OFF")
            save_config()
            handle_toggle(name, config[name])
        end)
    end)
end

local toggles = {"RainbowVehicle", "RainbowPhone", "AntiCarFling", "AntiFling", "AntiVoid", "NoClip", "NoSit", "AntiOutfitStealer", "JobSpammer", "FreePremium", "DisableNotifications"}
local function get_viewport()
    if not Camera then return nil end
    return Camera.ViewportSize
end

local function update_frame_size()
    local viewport = get_viewport()
    if not viewport then return end
    local desired_width = 300
    local desired_height = 50 + (#toggles * 40) + 10
    local max_width_scale = is_mob_device and 0.85 or 0.9
    local max_height_scale = is_mob_device and 0.75 or 0.85
    local final_width = math.min(desired_width, viewport.X * max_width_scale)
    local final_height = math.min(desired_height, viewport.Y * max_height_scale)
    Frame.Size = UDim2.new(0, final_width, 0, final_height)
end

for i, t in ipairs(toggles) do create_toggle(t, i) end
update_frame_size()
if Camera then lib.connect("FlamesConfigGUI_ViewportResize", Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function() update_frame_size() end)) end