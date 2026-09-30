if not game:IsLoaded() then game.Loaded:Wait() end
local g
if game:GetService("RunService"):IsStudio() then
    g = _G
else
    g = getgenv()
end
wait(0.1)
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
local lib = g.FlamesLibrary
local fw = lib.wait
local function get_or_set(global, value)
    local v = rawget and rawget(g, global) or g[global]
    if v == nil then
        g[global] = value
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
local FlamesLibrary = lib
local speaker = g.LocalPlayer or Players.LocalPlayer
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
g.set_enrolled_state = set_enrolled_state
wait(0.1)
function get_enrolled_state()
    if not isfile(config_path) then
        writefile(config_path, HttpService:JSONEncode(default_config))
    end

    local config = HttpService:JSONDecode(readfile(config_path))
    return config.Enrolled
end
wait(0.1)
g.get_enrolled_state = get_enrolled_state
if not g.FreePay_Originals then g.FreePay_Originals = {} end
local originals = g.FreePay_Originals
local function freepay_func(state)
    if not Data or not Data.initiate then g.notify("Error", "Data module missing.", 3); return end
    if not debug_ext.getupvalue then g.notify("Error", "Executor does not support getupvalue.", 3); return end
    if state == nil then state = not g.Has_Free_LifePremium end
    if state then
        if g.Has_Free_LifePremium then g.notify("Error", "FreePay is already enabled.", 3); return end
        local update_datum = debug_ext.getupvalue(Data.initiate, 2)
        if type(update_datum) ~= "function" then g.notify("Error", "Could not resolve update_datum.", 3); return end
        local u3 = debug_ext.getupvalue(update_datum, 2)
        if type(u3) ~= "table" then g.notify("Error", "Could not resolve data store.", 3); return end
        local patches = {
            is_verified      = true,
            invisible_bought = true,
            max_outfits      = 99,
        }

        for key, spoof_val in next, patches do
            local current = u3[key]
            local should_patch = false

            if type(current) == "boolean" then
                should_patch = current ~= true
            elseif type(current) == "number" then
                should_patch = current < spoof_val
            else
                should_patch = current == nil
            end

            if should_patch then
                originals[key] = current
                update_datum(key, spoof_val)
                print(string.format("[freepay] patched [%s] %s -> %s", key, tostring(current), tostring(spoof_val)))
            else
                print(string.format("[freepay] skipped [%s] = %s (already sufficient)", key, tostring(current)))
            end
        end

        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            local val = v:GetAttribute("IsVerifiedOnly")
            if val ~= nil and val ~= false then
                originals[v] = val
                v:SetAttribute("IsVerifiedOnly", false)
            end
        end

        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            local val = v:GetAttribute("IsAirportRestricted")
            if val ~= nil and val ~= false then
                originals[v] = val
                v:SetAttribute("IsAirportRestricted", false)
            end
        end

        g.Has_Free_LifePremium = true
        g.notify("Success", "FreePay is now enabled.", 5)
    else
        if not g.Has_Free_LifePremium then g.notify("Error", "FreePay is not enabled.", 3); return end
        local update_datum = debug_ext.getupvalue(Data.initiate, 2)
        for key, original_val in next, originals do
            if typeof(key) == "string" then
                if type(update_datum) == "function" then
                    update_datum(key, original_val)
                    print(string.format("[freepay] restored [%s] -> %s", key, tostring(original_val)))
                end
            elseif typeof(key) == "Instance" and key.Parent then
                if key:GetAttribute("IsVerifiedOnly") ~= nil then
                    key:SetAttribute("IsVerifiedOnly", original_val)
                end
                if key:GetAttribute("IsAirportRestricted") ~= nil then
                    key:SetAttribute("IsAirportRestricted", original_val)
                end
            end
        end

        table.clear(originals)
        g.Has_Free_LifePremium = false
        g.notify("Success", "FreePay is now disabled.", 5)
    end
end

g.set_enrolled_state("enabled")
if not g.FreePayFuncToggle then g.FreePayFuncToggle = freepay_func end
function change_vehicle_color(Color, Vehicle) g.Send("vehicle_color", Color, Vehicle) end
function change_phone_color(New_Color) g.Send("phone_color", New_Color) end
task.wait(0.2)
g.RGB_Phone = g.RGB_Phone or function(Boolean)
    local key = "rgb_phone_loop"
    if Boolean == true then
        if g.RGB_Rainbow_Phone then g.notify("Warning", "Rainbow Phone is already enabled.", 3); return end
        g.RGB_Rainbow_Phone = true
        g.notify("Success", "Started RGB/Rainbow Phone.", 5)
        lib.spawn(key, "spawn", function()
            while g.RGB_Rainbow_Phone == true do
                for _, color in ipairs(colors) do
                    if g.RGB_Rainbow_Phone ~= true then
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
        if not g.RGB_Rainbow_Phone then g.notify("Warning", "Rainbow Phone is not enabled.", 5); return end
        g.RGB_Rainbow_Phone = false
        lib.disconnect(key)
        g.notify("Success", "Stopped RGB/Rainbow Phone.", 5)
        fw(0.1)
        change_phone_color(Color3.fromRGB(255, 255, 255))
    end
end

local NOCLIP_KEY = "noclip_loop"
g.Noclip_Enabled = g.Noclip_Enabled or false
local function ToggleNoclip(toggle)
    if toggle == true then
        if g.Noclip_Enabled then g.notify("Error", "Noclip already enabled!", 3); return end
        g.Noclip_Enabled = true
        g.notify("Success", "Noclip has been enabled.", 5)
        lib.connect(NOCLIP_KEY, RunService.Stepped:Connect(function()
            if not g.Noclip_Enabled then return end
            local char = g.Character or g.LocalPlayer.Character or g.get_char(LocalPlayer, 5) or g.Char:get()
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end))
    elseif toggle == false then
        if not g.Noclip_Enabled then g.notify("Error", "Noclip not enabled!", 3); return end
        g.Noclip_Enabled = false
        lib.disconnect(NOCLIP_KEY)
        local char = g.Character
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
if not g.Toggleable_Noclip then g.Toggleable_Noclip = ToggleNoclip end
function RGB_Vehicle(Boolean)
    local key = "rgb_vehicle_loop"
    if Boolean == true then
        if g.Rainbow_Vehicle then g.notify("Warning", "Flames Hub | Rainbow Vehicle is already enabled.", 5); return end
        g.Rainbow_Vehicle = true
        g.notify("Success", "Flames Hub | Rainbow Vehicle is now enabled.", 5)
        lib.spawn(key, "spawn", function()
            while g.Rainbow_Vehicle == true do
                for _, color in ipairs(colors) do
                    if g.Rainbow_Vehicle ~= true then
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
        if not g.Rainbow_Vehicle then g.notify("Warning", "Flames Hub | Rainbow Vehicle is not enabled.", 5); return end
        g.Rainbow_Vehicle = false
        lib.disconnect(key)
        g.notify("Success", "Flames Hub | Rainbow Vehicle is now disabled.", 5)
    end
end

g.anti_outfit_copier = function(toggle)
    if toggle == true then
        if g.anti_outfit_stealer then g.notify("Error", "Anti Outfit Stealer is already enabled!", 5); return end
        if g.FlamesLibrary.is_alive("AntiFitStealerConn") then g.notify("Error", "Anti Outfit Stealer is already enabled! [connection]", 5); return end
        g.notify("Success", "Flames Hub | Anti Outfit Stealer is now active.", 7)
        g.ToggleAntiFit_Stealer = function(state)
            if not state then
                g.anti_outfit_stealer = false
                lib.disconnect("AntiFitStealerConn")
                local hide_outfit_toggle = g.LocalPlayer:GetAttribute("hide_view_outfit")
                if hide_outfit_toggle and hide_outfit_toggle == false then
                    g.Send("hide_view_outfit", true)
                    g.notify("Success", "hide_view_outfit setting changed, reverted change (keep it on).", 3)
                end
            else
                g.anti_outfit_stealer = true
                if g.Send then g.Send("bio", "`~ Flames Hub Anti Stealer Is Enabled ~`") end
            end

            local last_check = 0
            local target_bio = "`~ Flames Hub Anti Stealer Is Enabled ~`"
            lib.connect("AntiFitStealerConn", g.RunService.Heartbeat:Connect(function()
                local now = tick()
                if now - last_check < 0.4 then return end
                last_check = now
                local hide_outfit_toggle = g.LocalPlayer:GetAttribute("hide_view_outfit")
                if hide_outfit_toggle and hide_outfit_toggle == false then
                    g.Send("hide_view_outfit", true)
                    g.notify("Success", "hide_view_outfit setting changed, reverted change (keep it on).", 3)
                end

                if g.anti_outfit_stealer then
                    local current_bio = g.LocalPlayer:GetAttribute("bio")
                    if current_bio ~= target_bio then
                        g.Send("bio", target_bio)
                        g.notify("Success", "Bio was changed, reverted back.", 3)
                    end
                end
            end))
        end
        fw(0.1)
        g.ToggleAntiFit_Stealer(true)
    elseif toggle == false then
        if not g.anti_outfit_stealer then g.notify("Error", "Anti Outfit Copier is not enabled!", 3); return end
        g.anti_outfit_stealer = false
        g.FlamesLibrary.disconnect("AntiFitStealerConn")
        g.ToggleAntiFit_Stealer(false)
        g.notify("Success", "Disabled Anti Outfit Stealer.", 5)
    else
        return
    end
end

local attr_name = "InHumanoidVehicle"
local keys = {loop = "anti_sit_loop", char = "anti_sit_char", spam = "anti_sit_spam", hook = "anti_sit_hook", seat = "anti_sit_seat", hv = "anti_sit_hv"}
local cfg = g.anti_sit_config or {phase_two = 0.75, phase_three = 2, timeout = 5, retry_delay = 0.5}
local spam = g.anti_sit_spam or {active = false, started = 0, last_send = 0, last_hard = 0, cooldown_until = 0, exits = 0, total = 0, fastest = math.huge}
local registry = g.anti_sit_registry or {}
g.seat_cache = {}
local uid = 0
g.anti_sit_config = cfg
g.anti_sit_spam = spam
g.anti_sit_registry = registry
-- [[ Replaced up here but kept down there as well because some scripts reference it after this point. ]] --
g.in_humanoid_vehicle = g.in_humanoid_vehicle or function(player_or_name)
    local humanoid_vehicles = g.Workspace:FindFirstChild("HumanoidVehicles", true)
    if not humanoid_vehicles then return end
    local player = player_or_name
    if typeof(player_or_name) == "string" then
        player = g.Players:FindFirstChild(player_or_name)
        if not player then return end
    end
    local character = player == g.LocalPlayer and g.Character or player.Character
    if not character then return end
    local humanoid = character and character:FindFirstChildWhichIsA("Humanoid") or g.get_human(player, 3)
    if not humanoid then return end
    local vehicle_attr = humanoid:GetAttribute("InHumanoidVehicle")
    if vehicle_attr == nil then return end
    if type(g.Humanoid_Vehicles) ~= "table" then return end
    if not table.find(g.Humanoid_Vehicles, vehicle_attr) then return end
    return vehicle_attr
end

g.hum_vehicle_name = g.hum_vehicle_name or function(plr)
    local hv = g.in_humanoid_vehicle(plr)
    if not hv then return nil end
    local folder = g.Workspace:FindFirstChild("HumanoidVehicles", true)
    if not folder or not folder:IsA("Folder") then return nil end
    local inst = folder:FindFirstChild(hv)
    if not inst then return nil end
    return inst.Name
end

g.anti_sit_uid = function() uid += 1; return uid end
g.anti_sit_connect = function(name, conn) registry[name] = true; g.FlamesLibrary.connect(name, conn) end
g.anti_sit_cleanup = function() for name in pairs(registry) do g.FlamesLibrary.disconnect(name) end; table.clear(registry); table.clear(g.seat_cache) end
g.anti_sit_get_char = function() return g.Character or speaker.Character or (g.get_char and g.get_char(speaker)) end
g.anti_sit_get_hum = function(char) return (char and char:FindFirstChildWhichIsA("Humanoid")) or g.Humanoid or (g.get_human and g.get_human(speaker)) or (g.Char and g.Char.get_hum and g.Char.get_hum()) end
g.anti_sit_char_valid = function(char) return char ~= nil and char:FindFirstChild("HumanoidRootPart") ~= nil and char:IsDescendantOf(workspace) end
g.anti_sit_hum_valid = function(hum) return hum ~= nil and hum.Parent ~= nil and hum:IsDescendantOf(game) end
g.anti_sit_attr = function(hum)
    if not hum then return nil end
    local ok, res = pcall(function() return hum:GetAttribute(attr_name) end)
    if ok and res ~= nil then return res end
    return nil
end

g.anti_sit_in_hv = function(hum)
    if g.in_humanoid_vehicle and typeof(g.in_humanoid_vehicle) == "function" then
        local ok, res = pcall(g.in_humanoid_vehicle, speaker)
        if ok and res ~= nil then return res end
    end
    return g.anti_sit_attr(hum)
end

g.anti_sit_hard_eject = function(char, hum)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local folder = workspace:FindFirstChild("HumanoidVehicles")
    if folder and hrp then
        for _, group in folder:GetChildren() do
            for _, model in group:GetChildren() do
                if model:IsA("Model") and model:HasTag("HumanoidVehicle") then
                    local occupant_val = model:FindFirstChild("occupant")
                    local owner_val = model:FindFirstChild("owner")
                    local ours = (occupant_val and occupant_val.Value == hum) or (owner_val and owner_val.Value == speaker)
                    if ours then
                        local touch_part = model:FindFirstChild("TouchPart", true)
                        if touch_part then
                            for _, weld in touch_part:GetChildren() do
                                if weld:IsA("WeldConstraint") and (weld.Part0 == hrp or weld.Part1 == hrp) then pcall(function() weld:Destroy() end) end
                            end
                        end
                        if occupant_val then pcall(function() occupant_val.Value = nil end) end
                    end
                end
            end
        end
    end
    if hrp and hrp.Parent then
        for _, joint in hrp:GetChildren() do
            if joint:IsA("JointInstance") or joint:IsA("WeldConstraint") then
                local other = joint.Part0 == hrp and joint.Part1 or joint.Part0
                if other and not other:IsDescendantOf(char) then pcall(function() joint:Destroy() end) end
            end
        end
        pcall(function() hrp.CFrame = hrp.CFrame * CFrame.new(0, 4, -3) end)
    end
    pcall(function() hum:SetAttribute(attr_name, nil) end)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
    if g.Send and typeof(g.Send) == "function" then pcall(g.Send, "stop_sitting") end
end

g.anti_sit_spam_stop = function(success)
    FlamesLibrary.disconnect(keys.spam)
    if success then
        local took = os.clock() - spam.started
        spam.exits += 1
        spam.total += took
        spam.fastest = math.min(spam.fastest, took)
    end
    spam.active = false
    spam.cooldown_until = os.clock() + (success and 0 or cfg.retry_delay)
end

g.anti_sit_spam_start = function()
    if spam.active or os.clock() < spam.cooldown_until then return end
    spam.active = true
    spam.started = os.clock()
    spam.last_send = 0
    spam.last_hard = 0
    FlamesLibrary.connect(keys.spam, RunService.Heartbeat:Connect(function()
        if not g.Not_Ever_Sitting then g.anti_sit_spam_stop(false); return end
        local char = g.anti_sit_get_char()
        local hum = char and g.anti_sit_get_hum(char)
        if not g.anti_sit_char_valid(char) or not g.anti_sit_hum_valid(hum) then g.anti_sit_spam_stop(false); return end
        if g.anti_sit_in_hv(hum) == nil then g.anti_sit_spam_stop(true); return end
        local now = os.clock()
        local elapsed = now - spam.started
        if elapsed > cfg.timeout then g.anti_sit_spam_stop(false); return end
        pcall(function()
            hum.Jump = true
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
        if elapsed > cfg.phase_two then
            pcall(function() hum.Sit = false end)
            if now - spam.last_send > 0.15 then
                spam.last_send = now
                if g.Send and typeof(g.Send) == "function" then pcall(g.Send, "stop_sitting") end
            end
        end
        if elapsed > cfg.phase_three and now - spam.last_hard > 0.4 then
            spam.last_hard = now
            g.anti_sit_hard_eject(char, hum)
        end
    end))
end

g.anti_sit_eject_seat = function(hum, seat)
    local target = seat or hum.SeatPart
    if target and target.Parent then
        pcall(function() target:SetAttribute("Disabled", true) end)
        task.delay(0.3, function() pcall(function() if target.Parent then target:SetAttribute("Disabled", false) end end) end)
    end
    pcall(function() hum.Sit = false end)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
    if g.Send then pcall(g.Send, "stop_sitting") end
    local char = hum.Parent
    local hrp = char and char:IsDescendantOf(workspace) and char:FindFirstChild("HumanoidRootPart")
    if hrp and hrp.Parent then pcall(function() hrp.CFrame = hrp.CFrame * CFrame.new(0, 3, -2) end) end
end

g.anti_sit_eject_any = function(char, hum)
    if not g.anti_sit_char_valid(char) or not g.anti_sit_hum_valid(hum) then return end
    if g.anti_sit_in_hv(hum) ~= nil then g.anti_sit_spam_start(); return end
    local seat_part = hum.SeatPart
    local is_sit = hum.Sit or (g.Char and g.Char.is_sitting and g.Char.is_sitting.get())
    if is_sit or seat_part then g.anti_sit_eject_seat(hum, seat_part) end
end

g.anti_sit_disable_nearby = function(char)
    local hrp = g.HumanoidRootPart or char and char:FindFirstChild("HumanoidRootPart") or g.get_root(speaker)
    if not hrp or not hrp.Parent then return end
    for seat in pairs(g.seat_cache) do
        if seat.Parent and seat:GetAttribute("Disabled") ~= true and (seat.Position - hrp.Position).Magnitude < 8 then
            pcall(function() seat:SetAttribute("Disabled", true) end)
            task.delay(0.35, function() pcall(function() if seat.Parent then seat:SetAttribute("Disabled", false) end end) end)
        end
    end
end

g.anti_sit_hook_hum = function(hum, char)
    g.anti_sit_connect(keys.hook .. "_attr", hum:GetAttributeChangedSignal(attr_name):Connect(function()
        if g.Not_Ever_Sitting and g.anti_sit_attr(hum) ~= nil then g.anti_sit_eject_any(char, hum) end
    end))
    g.anti_sit_connect(keys.hook .. "_sit", hum:GetPropertyChangedSignal("Sit"):Connect(function()
        if g.Not_Ever_Sitting and hum.Sit then g.anti_sit_eject_any(char, hum) end
    end))
    g.anti_sit_connect(keys.hook .. "_seatpart", hum:GetPropertyChangedSignal("SeatPart"):Connect(function()
        if not g.Not_Ever_Sitting or not hum.SeatPart then return end
        task.defer(function() if g.Not_Ever_Sitting then g.anti_sit_eject_any(char, hum) end end)
    end))
end

g.anti_sit_watch_seats = function()
    table.clear(g.seat_cache)
    for _, obj in workspace:GetDescendants() do if obj:IsA("Seat") or obj:IsA("VehicleSeat") then g.seat_cache[obj] = true end end
    g.anti_sit_connect(keys.seat .. "_added", workspace.DescendantAdded:Connect(function(obj) if obj:IsA("Seat") or obj:IsA("VehicleSeat") then g.seat_cache[obj] = true end end))
    g.anti_sit_connect(keys.seat .. "_removed", workspace.DescendantRemoving:Connect(function(obj) g.seat_cache[obj] = nil end))
end

g.anti_sit_bind_hv_model = function(model)
    if not (model:IsA("Model") and model:HasTag("HumanoidVehicle")) then return end
    task.spawn(function()
        local occupant_val = model:WaitForChild("occupant", 5)
        if not occupant_val or not occupant_val:IsA("ObjectValue") or not g.Not_Ever_Sitting then return end
        g.anti_sit_connect(keys.hv .. "_occ_" .. g.anti_sit_uid(), occupant_val:GetPropertyChangedSignal("Value"):Connect(function()
            if not g.Not_Ever_Sitting or occupant_val.Value == nil then return end
            local char = g.anti_sit_get_char()
            local hum = char and g.anti_sit_get_hum(char)
            if occupant_val.Value == hum then g.anti_sit_spam_start() end
        end))
    end)
end

g.anti_sit_bind_hv_folder = function(folder)
    if not folder:IsA("Folder") then return end
    for _, model in folder:GetChildren() do g.anti_sit_bind_hv_model(model) end
    g.anti_sit_connect(keys.hv .. "_child_" .. g.anti_sit_uid(), folder.ChildAdded:Connect(function(model)
        if g.Not_Ever_Sitting then g.anti_sit_bind_hv_model(model) end
    end))
end

g.anti_sit_watch_hv = function()
    local root = Workspace:FindFirstChild("HumanoidVehicles")
    if not root then return end
    for _, folder in root:GetChildren() do g.anti_sit_bind_hv_folder(folder) end
    g.anti_sit_connect(keys.hv .. "_folders", root.ChildAdded:Connect(function(folder) if g.Not_Ever_Sitting then g.anti_sit_bind_hv_folder(folder) end end))
end

function anti_sit_func(toggle)
    if not g.Seat then
        local ok, res = pcall(function() return require(g.Game_Folder:FindFirstChild("Seat")) end)
        if not ok or not res then g.notify("Error", "Seat ModuleScript not found or failed to load!", 3); return end
        g.Seat = res
    end
    if toggle == true then
        if g.Not_Ever_Sitting then g.notify("Warning", "AntiSit is already enabled!", 3); return end
        g.Not_Ever_Sitting = true
        g.notify("Success", "Anti-Sit is now enabled!", 3)
        g.show_notification("Success:", "Anti-Sit is now enabled.", "Normal")
        local char = g.anti_sit_get_char()
        local hum = char and g.anti_sit_get_hum(char)
        if g.anti_sit_char_valid(char) and g.anti_sit_hum_valid(hum) then g.anti_sit_hook_hum(hum, char) end
        g.anti_sit_watch_seats()
        g.anti_sit_watch_hv()
        g.anti_sit_connect(keys.char, speaker.CharacterAdded:Connect(function(new_char)
            fw(0)
            local new_hum = new_char:WaitForChild("Humanoid", 5)
            if g.anti_sit_char_valid(new_char) and g.anti_sit_hum_valid(new_hum) then g.anti_sit_hook_hum(new_hum, new_char) end
        end))
        lib.spawn(keys.loop, "spawn", function()
            while g.Not_Ever_Sitting == true do
                g.Seat.enabled.set(false)
                local cur_char = g.anti_sit_get_char()
                local cur_hum = cur_char and g.anti_sit_get_hum(cur_char)
                if g.anti_sit_char_valid(cur_char) and g.anti_sit_hum_valid(cur_hum) then
                    g.anti_sit_eject_any(cur_char, cur_hum)
                    if cur_hum.Sit or cur_hum.SeatPart then g.anti_sit_disable_nearby(cur_char) end
                end
                fw(0)
            end
            lib.disconnect(keys.loop)
        end)
    elseif toggle == false then
        if not g.Not_Ever_Sitting then g.notify("Warning", "AntiSit is not enabled!", 3); return end
        g.Not_Ever_Sitting = false
        g.anti_sit_spam_stop(false)
        g.anti_sit_cleanup()
        lib.disconnect(keys.loop)
        fw(0.2)
        g.Seat.enabled.set(true)
        g.notify("Success", "Anti-Sit is now disabled.", 3)
        pcall(function() g.Phone.show_notification("Success:", "Anti-Sit is now disabled.", "Normal") end)
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
        if g.Anti_Void_Enabled_Bool then g.notify("Warning", "Anti-Void is already enabled!", 3); return end
        if not g.originalFPDH then g.originalFPDH = g.Workspace.FallenPartsDestroyHeight end
        g.Workspace.FallenPartsDestroyHeight = -9e9
        g.Anti_Void_Enabled_Bool = true
        g.notify("Success", "Enabled anti-void.", 5)
    elseif toggle == false then
        if not g.Anti_Void_Enabled_Bool then g.notify("Warning", "Anti-Void has not been enabled!", 3); return end
        if not g.originalFPDH then g.originalFPDH = -500; g.notify("Error", "Original FPDH didn't exist at runtime, try this command again!", 5); return end
        g.Workspace.FallenPartsDestroyHeight = g.originalFPDH
        g.Anti_Void_Enabled_Bool = false
        g.notify("Success", "Disabled anti-void.", 5)
    end
end

local VEHICLE_KEY = "vehicle_destroyer"
g.VehicleDestroyer_Enabled = g.VehicleDestroyer_Enabled or false
g.DisableVehicleDestroyer = function()
    if not g.VehicleDestroyer_Enabled then g.notify("Warning", "Anti Vehicle Fling is not enabled!", 3); return end
    fw(0.1)
    g.VehicleDestroyer_Enabled = false
    lib.disconnect(VEHICLE_KEY)
    g.notify("Success", "Anti Vehicle Fling has been disabled.", 5)
end

g.job_spammer = g.job_spammer or function(toggle)
    local lib = g.FlamesLibrary
    local key = "job_spammer_loop"

    if toggle == true then
        if g.Every_Job then g.notify("Warning", "Job-Spammer is already enabled! disable it first.", 5); return end
        g.Every_Job = true
        g.notify("Success", "Job-Spammer is now enabled.", 3)
        lib.spawn(key, "spawn", function()
            while g.Every_Job == true do
            task.wait(0)
                g.Send("job", "Police")
                fw(0)
                g.Send("job", "Firefighter")
                fw(0)
                g.Send("job", "Baker")
                fw(0)
                g.Send("job", "Pizza Worker")
                fw(0)
                g.Send("job", "Barista")
                fw(0)
                g.Send("job", "Doctor")
                fw(0)
            end
            lib.disconnect(key)
        end)
    elseif toggle == false then
        if not g.Every_Job then g.notify("Warning", "Job-Spammer is not enabled!", 5); return end
        g.Every_Job = false
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

g.Flames_Features = g.Flames_Features or {}
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
            if g.Toggle_AntiFling_Boolean_Func then g.Toggle_AntiFling_Boolean_Func(true) end
        else
            if g.Toggle_AntiFling_Boolean_Func then g.Toggle_AntiFling_Boolean_Func(false) end
        end
    elseif name == "AntiVoid" then
        if state == "enabled" then
            anti_void(true)
        else
            anti_void(false)
        end
    elseif name == "NoClip" then
        if state == "enabled" then
            if g.Toggleable_Noclip then g.Toggleable_Noclip(true) end
        else
            if g.Toggleable_Noclip then g.Toggleable_Noclip(false) end
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