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
local In_Studio = false
local g
if game:GetService("RunService"):IsStudio() then
    g = _G
    In_Studio = true
else
    g = getgenv()
end
wait(0.25)
if game:GetService("RunService"):IsServer() then warn("This script can only be run on the client."); return end
if game.PlaceId ~= 155615604 then
    if g.notify and typeof(g.notify) == "function" then
        return g.notify("Error", "This game isn't allowed to run with this script (only: Prison Life).", 30)
    else
        return warn("This game isn't allowed to run with this script (only: Prison Life).")
    end
end
wait(0.1)
local blank_F = g.blank_function or g.blankfunction or function(...) return ... end
local cloneref = typeof(cloneref) == "function" and cloneref or function(instance) return instance end
-- [[ Should no longer break in Roblox Studio. 😈🚬 ]] --
local http_game
if In_Studio then
    http_game = blank_F
else
    http_game = (g["game"] or game)["HttpGet"]
    g.http_get = function(url) return http_game(game, url) end
end
wait(0.1)
local Raw_Version = "V1.3.8"
g.Script_Version = tostring(Raw_Version).."-PrisonLife"
local StarterGui = g.StarterGui or cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")
local StarterPlayer = g.StarterPlayer or cloneref and cloneref(game:GetService("StarterPlayer")) or game:GetService("StarterPlayer")
local Players = g.Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players") -- up here to let everything load first.
local localPlayer = g.LocalPlayer or Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local speaker = localPlayer
if In_Studio and script.Parent ~= StarterGui then script.Parent = StarterGui end
g.colors = g.colors or {
    Color3.fromRGB(255,255,255),
    Color3.fromRGB(128,128,128),
    Color3.fromRGB(0,0,0),
    Color3.fromRGB(0,0,255),
    Color3.fromRGB(0,255,0),
    Color3.fromRGB(0,255,255),
    Color3.fromRGB(255,165,0),
    Color3.fromRGB(139,69,19),
    Color3.fromRGB(255,255,0),
    Color3.fromRGB(50,205,50),
    Color3.fromRGB(255,0,0),
    Color3.fromRGB(255,155,172),
    Color3.fromRGB(128,0,128),
}
g.LocalPlayer = g.LocalPlayer or speaker
if not In_Studio then
    if not g.GlobalEnvironmentFramework_Initialized then
        loadstring(g.http_get("https://pastebin.com/raw/T25mDhBZ"))()
        wait(0.1)
        g.GlobalEnvironmentFramework_Initialized = true
    end
end
wait(0.1)
g.anti_jump_enabled = g.anti_jump_enabled or false
g.fullbright_enabled = g.fullbright_enabled or false
g.anti_taze_on = g.anti_taze_on or false
g.walkspeed_on = g.walkspeed_on or false
g.walkspeed_value = g.walkspeed_value or StarterPlayer.CharacterWalkSpeed
g.noclip_on = g.noclip_on or false
g.gun_mods_on = g.gun_mods_on or false
g.auto_reload_on = g.auto_reload_on or false
g.silent_aim_on = g.silent_aim_on or false
g.silent_aim_fov = g.silent_aim_fov or 120
g.silent_aim_fov_visible = g.silent_aim_fov_visible ~= false
g.fence_transmitters = g.fence_transmitters or {}
g.fence_godmode_on = g.fence_godmode_on or false
g.silent_aim_team_check = g.silent_aim_team_check or true
g.esp_cache = g.esp_cache or {}
g.esp_active = g.esp_active or false
g.inf_jump_on = g.inf_jump_on or false
g.inf_jump_debounce = g.inf_jump_debounce or false
local has_gethui = (typeof(gethui) == "function") or (typeof(g.gethui) == "function")
local has_gethidden = (typeof(get_hidden_gui) == "function") or (typeof(g.get_hidden_gui) == "function")
local RunService = g.RunService or cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local CoreGui = g.CoreGui or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local Workspace = g.Workspace or cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local ReplicatedStorage = g.ReplicatedStorage or cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local LocalPlayer = g.LocalPlayer or Players.LocalPlayer
local Teams = g.Teams or cloneref and cloneref(game:GetService("Teams")) or game:GetService("Teams")
local Debris = g.Debris or cloneref and cloneref(game:GetService("Debris")) or game:GetService("Debris")
local Lighting = g.Lighting or cloneref and cloneref(game:GetService("Lighting")) or game:GetService("Lighting")
local UserInputService = g.UserInputService or cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local AssetService = g.AssetService or cloneref and cloneref(game:GetService("AssetService")) or game:GetService("AssetService")
local player_gui = g.PlayerGui or LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
local FlamesLibrary = g.FlamesLibrary or getgenv().FlamesLibrary
local g_c = getconnections or get_signal_cons or get_signal_conns
if not has_gethui and not has_gethidden and not g.roblox_hidden_gui_location then
    if In_Studio then
        g.roblox_hidden_gui_location = player_gui
    else
        for _, v in ipairs(CoreGui:GetChildren()) do
            if v:IsA("ScreenGui") and v.Name == "RobloxGui" then
                g.roblox_hidden_gui_location = v
                break
            end
        end
    end
    local function resolve_gui()
        if In_Studio then return player_gui end
        if g.roblox_hidden_gui_location and g.roblox_hidden_gui_location.Parent and g.roblox_hidden_gui_location:IsA("ScreenGui") then return g.roblox_hidden_gui_location end
        return CoreGui
    end
    g.get_hui = resolve_gui
    g.get_hidden_gui = resolve_gui
end

local function Get_Camera()
    if Workspace.CurrentCamera then
        return Workspace.CurrentCamera
    elseif Workspace:FindFirstChildOfClass("Camera") then
        return Workspace:FindFirstChildOfClass("Camera")
    elseif Workspace:FindFirstChildWhichIsA("Camera") then
        return Workspace:FindFirstChildWhichIsA("Camera")
    else
        return nil
    end
end

local Camera = Get_Camera()
local GUN_MODS = {
    ["MP5"] = {
        FireRate = 0.009,
        MaxAmmo = 30,
        CurrentAmmo = 30,
        Local_CurrentAmmo = 30,
    },
    ["Remington 870"] = {
        FireRate = 0.1,
        ReloadTime = 0.1,
        MaxAmmo = 9,
        CurrentAmmo = 9,
        Local_CurrentAmmo = 9,
        AutoFire = true,
        AccurateRange = 100,
    },
}

local function find_gooeys_from_HUD()
    local cache = g.gooeys_frame_RS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("gooeys") then
            g.gooeys_frame_RS = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not g.gooeys_frame_RS then pcall(function() find_gooeys_from_HUD() end) end

local function find_Home_ScreenGui()
    local cache = g.home_ScreenGui_PlayerGui_PL
    if cache and cache:IsA("ScreenGui") then return cache end
    for _, v in ipairs(player_gui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == "Home" then
            g.home_ScreenGui_PlayerGui_PL = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not g.home_ScreenGui_PlayerGui_PL then pcall(function() find_Home_ScreenGui() end) end

g.spawn_announcement = function(text, title)
	local home_gui = find_Home_ScreenGui()
	if not home_gui or not home_gui:IsA("ScreenGui") then g.notify("Error", "Home does not exist.", 3); return end
	local announcements_frame = home_gui:FindFirstChild("hud") and home_gui.hud:FindFirstChild("AnnouncementsFrame")
	if not announcements_frame or not announcements_frame:IsA("Frame") then g.notify("Error", "AnnouncementsFrame does not exist.", 3); return end
	local gooeys = find_gooeys_from_HUD()
	local msg_gui = gooeys and gooeys:FindFirstChild("messageGui")
	local frame
	if msg_gui then
		frame = msg_gui:Clone()
		frame.Desc.Text = text
		for _, child in ipairs(frame:GetDescendants()) do
			if child:IsA("TextLabel") and child.Name ~= "Desc" then
				child.Text = title or ""
			end
		end
	else
		frame = Instance.new("Frame")
		frame.Size = UDim2.new(0.4, 0, 0.08, 0)
		frame.Position = UDim2.new(0.5, 0, -0.2, 0)
		frame.AnchorPoint = Vector2.new(0.5, 0)
		frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		frame.BackgroundTransparency = 0.2
		frame.BorderSizePixel = 0
		local corner = Instance.new("UICorner", frame)
		corner.CornerRadius = UDim.new(0, 8)
		local label = Instance.new("TextLabel", frame)
		label.Name = "Desc"
		label.Size = UDim2.new(1, -20, 1, 0)
		label.Position = UDim2.new(0, 10, 0, 0)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.TextScaled = true
		label.Font = Enum.Font.GothamBold
		label.Text = text
		label.TextXAlignment = Enum.TextXAlignment.Center
	end
	frame.Visible = true
	frame.Parent = announcements_frame
	frame:TweenPosition(UDim2.new(0.5, 0, 0.2, 0), "Out", "Quint", 1, false)
	task.wait(5)
	frame:TweenPosition(UDim2.new(0.5, 0, -0.4, 0), "In", "Quint", 1, false)
	Debris:AddItem(frame, 2)
end

if not g.announcement_already_called_PL then
    g.spawn_announcement("Flames Hub", "Welcome to Flames Hub's Prison Life script hub gang.")
    g.announcement_already_called_PL = true
end

g.find_anti_jump_controller_LS = function()
	local char = g.Character or speaker.Character or g.get_char(speaker)
	if not char then repeat task.wait(); char = g.Character or speaker.Character or g.get_char(speaker) until char end
	for _, v in ipairs(char:GetChildren()) do
		if v:IsA("LocalScript") and v.Name:lower():find("anti") and v.Name:lower():find("jump") then
			return v
		end
	end
	return nil
end

g.infinite_stamina_toggle = function(state)
    g.infinite_stamina_on = state
    local stamina_script = g.find_anti_jump_controller_LS()
    if not stamina_script then g.notify("Error", "Anti-Jump LocalScript not found.", 3); return end
    stamina_script.Disabled = state
    if state then
        FlamesLibrary.connect("infinite_stamina_respawn", speaker.CharacterAdded:Connect(function()
            if not g.infinite_stamina_on then return end
            FlamesLibrary.spawn("infinite_stamina_respawn_delay", "delay", 0, function()
                g.infinite_stamina_toggle(true)
            end)
        end))
    else
        FlamesLibrary.disconnect("infinite_stamina_respawn")
    end
end

g.fullbright_toggle = function(state)
	g.fullbright_enabled = state
	if state then
		Lighting.Brightness = 3
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        FlamesLibrary.connect("full_bright_cap", Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
            if g.fullbright_enabled and Lighting.Brightness ~= 3 then Lighting.Brightness = 3 end
        end))
        FlamesLibrary.connect("full_bright_ambient", Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
            if g.fullbright_enabled and Lighting.Ambient ~= Color3.fromRGB(255, 255, 255) then Lighting.Ambient = Color3.fromRGB(255, 255, 255) end
        end))
	else
        FlamesLibrary.disconnect("full_bright_cap")
        FlamesLibrary.disconnect("full_bright_ambient")
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
	end
end

local function find_player_tased_remote()
    local cache = g.player_tased_GunRemotes_RS
    if cache and cache:IsA("RemoteEvent") then return cache end
    local gun_remotes = ReplicatedStorage:FindFirstChild("GunRemotes")
    if not gun_remotes then return nil end
    for _, v in ipairs(gun_remotes:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("player") and v.Name:lower():find("tased") then
            g.player_tased_GunRemotes_RS = v
            return v
        end
    end
    return nil
end
task.wait(0.1)
if not g.player_tased_GunRemotes_RS then pcall(function() find_player_tased_remote() end) end

local function find_cih_state()
    local cache = g.cih_state_table
    if cache and cache.isTazed ~= nil then return cache end
    for _, fn in pairs(getgc(true)) do
        if typeof(fn) == "function" then
            local ok, ups = pcall(getupvalues, fn)
            if ok then
                for _, v in pairs(ups) do
                    if typeof(v) == "table" and v.isTazed ~= nil and v.isArrested ~= nil and v.isCrouching ~= nil then
                        g.cih_state_table = v
                        return v
                    end
                end
            end
        end
    end
    return nil
end

local function restore_from_taze()
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local state = find_cih_state()
    if state then state.isTazed = false end
    hum.WalkSpeed = 16
    hum.JumpHeight = 5.5
    speaker:SetAttribute("BackpackEnabled", true)
    task.defer(function()
        for i = 1, 8 do
            if pcall(StarterGui.SetCore, StarterGui, "ResetButtonCallback", true) then break end
            task.wait()
        end
    end)
end

g.anti_taze_toggle = function(state)
    if state then
        local team = speaker.Team
        local inmates = Teams:FindFirstChild("Inmates")
        local criminal = Teams:FindFirstChild("Criminal")
        if team ~= inmates and team ~= criminal then
            g.notify("Error", "You need to be on the Inmates or Criminals Team to use this!", 3)
            return
        end
    end
    g.anti_taze_on = state
    local player_tased = g.player_tased_GunRemotes_RS or find_player_tased_remote()
    if not player_tased or not player_tased:IsA("RemoteEvent") then return end
    if state then
        if g_c and typeof(g_c) == "function" then
            for _, c in pairs(g_c(player_tased.OnClientEvent)) do c:Disable() end
            FlamesLibrary.disconnect("anti_taze_restore")
        else
            FlamesLibrary.connect("anti_taze_restore", player_tased.OnClientEvent:Connect(function()
                task.defer(restore_from_taze)
            end))
        end
    else
        if g_c and typeof(g_c) == "function" then
            for _, c in pairs(g_c(player_tased.OnClientEvent)) do c:Enable() end
        end
        FlamesLibrary.disconnect("anti_taze_restore")
    end
end

local function find_giver_remote()
    local cache = g.giver_pressed_remote_RS
    if cache and cache:IsA("RemoteEvent") then return cache end
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not remotes or not remotes:IsA("Folder") then return nil end
    for _, v in ipairs(remotes:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name == "GiverPressed" then
            g.giver_pressed_remote_RS = v
            return v
        end
    end
    return nil
end
task.wait(0.1)
if not g.giver_pressed_remote_RS then pcall(function() find_giver_remote() end) end

local function find_touch_giver_by_name(name)
    local lower_name = name:lower()
    for _, v in ipairs(Workspace:QueryDescendants("#TouchGiver")) do
        if v:IsA("Model") then
            local tool_name = v:GetAttribute("ToolName")
            if tool_name and tostring(tool_name):lower():find(lower_name, 1, true) then
                return v
            end
        end
    end
    return nil
end

g.get_weapons = function(choice)
    local remote = g.giver_pressed_remote_RS or find_giver_remote()
    if not remote or not remote:IsA("RemoteEvent") then return end
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(workspace or game) then return end
    local hrp = char:FindFirstChild("HumanoidRootPart") or g.get_root(speaker)
    if not hrp or not hrp.Parent then return end
    local target_giver = find_touch_giver_by_name("Remington 870")
    if not target_giver then return end
    local done = false
    local function stop()
        if done then return end
        done = true
        FlamesLibrary.disconnect("get_weapons_backpack")
    end

    local function fire_giver(giver)
        local old_cf = hrp.CFrame
        hrp.CFrame = CFrame.new(giver:GetPivot().Position + Vector3.new(0, 0, 10))
        task.wait()
        pcall(remote.FireServer, remote, giver)
        task.wait()
        hrp.CFrame = old_cf
    end

    FlamesLibrary.connect("get_weapons_backpack", speaker.Backpack.ChildAdded:Connect(function(c)
        local name = tostring(c)
        if name == "Remington 870" then
            if choice and choice ~= "" then
                local next_giver = find_touch_giver_by_name(choice)
                if next_giver then
                    fire_giver(next_giver)
                end
            end
            stop()
        elseif name == choice then
            stop()
        end
    end))

    fire_giver(target_giver)
end

g.auto_reset_team_toggle = function(state)
    g.auto_reset_team_on = state
    if state then
        local prev_team = speaker.Team
        FlamesLibrary.connect("auto_reset_team", speaker:GetPropertyChangedSignal("Team"):Connect(function()
            local curr_team = speaker.Team
            if prev_team == Teams:FindFirstChild("Inmates") and curr_team == Teams:FindFirstChild("Criminal") then
                local char = g.Character or speaker.Character or g.get_char(speaker)
                if not char or not char:IsDescendantOf(workspace or game) then prev_team = curr_team; return end
                local hum = g.Humanoid or char and char:FindFirstChildOfClass("Humanoid") or g.get_human(speaker)
                if hum and hum.Parent and hum:IsDescendantOf(game) then hum.Health = 0 end
            end
            prev_team = curr_team
        end))
    else
        FlamesLibrary.disconnect("auto_reset_team")
    end
end

task.spawn(function()
    for _, v in ipairs(Workspace:GetChildren()) do
        if v.Name == "BOUNDARY" then
            pcall(function() v:Destroy() end)
        end
    end
end)

local function find_arrest_remote()
    local cache = g.arrest_player_remote_RS
    if cache and cache:IsA("RemoteFunction") then return cache end
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not remotes then return nil end
    for _, v in ipairs(remotes:GetChildren()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("arrest") and v.Name:lower():find("player") then
            g.arrest_player_remote_RS = v
            return v
        end
    end
    return nil
end
task.wait(0.1)
if not g.arrest_player_remote_RS then pcall(function() find_arrest_remote() end) end

local function find_prison_fences()
    local cache = g.prison_fences_WS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(workspace:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("prison") and v.Name:lower():find("fences") then
            g.prison_fences_WS = v
            return v
        end
    end
    return nil
end
task.wait(0.1)
if not g.prison_fences_WS then pcall(function() find_prison_fences() end) end

g.fence_godmode_toggle = function(state)
    local folder = g.prison_fences_WS or find_prison_fences()
    if not folder or not folder:IsA("Folder") then g.notify("Error", "Folder: Prison_Fences was not found or does not exist.", 3); return end
    g.fence_godmode_on = state
    if state then
        for _, v in ipairs(folder:GetDescendants()) do
            if v:IsA("BasePart") and v:FindFirstChildWhichIsA("TouchTransmitter") then
                g.fence_transmitters[v] = v.Parent
                pcall(function() v.Parent = AssetService end)
            end
        end
    else
        for part, original_parent in pairs(g.fence_transmitters) do
            pcall(function() part.Parent = original_parent end)
        end
        g.fence_transmitters = {}
    end
end

g.arrest_player = function(target_player)
    if speaker.Team ~= Teams:FindFirstChild("Guards") then
        g.notify("Error", "You must be on the Guards team to arrest players.", 3)
        return
    end
    local target_char = target_player.Character or g.get_char(target_player)
    if not target_char then return end
    local is_criminal = target_player.Team == Teams:FindFirstChild("Criminal")
    local is_hostile_inmate = target_player.Team == Teams:FindFirstChild("Inmates") and target_char:GetAttribute("Hostile") == true
    if not is_criminal and not is_hostile_inmate then
        g.notify("Error", target_player.Name .. " is not a Criminal or Hostile Inmate.", 3)
        return
    end
    local remote = g.arrest_player_remote_RS or find_arrest_remote()
    if not remote or not remote:IsA("RemoteFunction") then return end
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(workspace or game) then return end
    local handcuffs = g.Backpack:FindFirstChild("Handcuffs") or speaker.Backpack:FindFirstChild("Handcuffs") or char and char:FindFirstChild("Handcuffs")
    if not handcuffs or not handcuffs:IsA("Tool") then g.notify("Error", "You must have handcuffs to arrest players.", 3); return end
    local hrp = g.HumanoidRootPart or char and char:FindFirstChild("HumanoidRootPart") or g.get_root(speaker)
    if not hrp or not hrp.Parent then return end
    local target_hrp = target_char:FindFirstChild("HumanoidRootPart") or g.get_root(target_player)
    if not target_hrp then return end
    local old_cf = hrp.CFrame
    hrp.CFrame = CFrame.new(target_hrp.Position + Vector3.new(0, 0, 3))
    local ok, result = pcall(remote.InvokeServer, remote, target_player, 1)
    RunService:BindToRenderStep("arrest_restore", 101, function()
        hrp.CFrame = old_cf
        RunService:UnbindFromRenderStep("arrest_restore")
    end)
    return ok and result
end

local function find_snack_folder()
    local cache = g.snack_folder_remotes_RS
    if cache and cache:IsA("Folder") then return cache end
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not remotes then return nil end
    for _, v in ipairs(remotes:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("snack") then
            g.snack_folder_remotes_RS = v
            return v
        end
    end
    return nil
end
task.wait(0.1)
if not g.snack_folder_remotes_RS then pcall(function() find_snack_folder() end) end

local function find_snack_eaten_remote()
    local cache = g.snack_eaten_remote_RS
    if cache and cache:IsA("RemoteEvent") then return cache end
    local snack_folder = g.snack_folder_remotes_RS or find_snack_folder()
    if not snack_folder then return nil end
    for _, v in ipairs(snack_folder:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("eaten") then
            g.snack_eaten_remote_RS = v
            return v
        end
    end
    return nil
end
task.wait(0.1)
if not g.snack_eaten_remote_RS then pcall(function() find_snack_eaten_remote() end) end

local function find_interact_remote()
    local cache = g.interact_item_remote_RS
    if cache and cache:IsA("RemoteFunction") then return cache end
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not remotes then return nil end
    for _, v in ipairs(remotes:GetChildren()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("interact") and v.Name:lower():find("item") then
            g.interact_item_remote_RS = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.interact_item_remote_RS then pcall(function() find_interact_remote() end) end

local function find_vending_machine()
    local cache = g.vending_machine_workspace
    if cache and cache:IsA("Model") then return cache end
    for _, v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Model") and v.Name:lower():find("vending") and v.Name:lower():find("machine") then
            g.vending_machine_workspace = v
            return v
        end
    end
    return nil
end
wait(0.1)
if not g.vending_machine_workspace then pcall(function() find_vending_machine() end) end

local function find_vending_part(choice)
    local machine = g.vending_machine_workspace or find_vending_machine()
    if not machine then return nil end
    local lower_choice = choice:lower()
    for _, v in ipairs(machine:GetChildren()) do
        if v:IsA("BasePart") and v.Name:lower():find(lower_choice, 1, true) then
            return v
        end
    end
    return nil
end

local function find_vending_item(choice)
    local lower_choice = choice:lower()
    for _, v in ipairs(Workspace:GetChildren()) do
        if v.Name:lower():find(lower_choice, 1, true) then
            return v
        end
    end
    return nil
end

local function wait_for_snack(choice, timeout)
    local lower_choice = choice:lower()
    local elapsed = 0
    repeat
        task.wait(0.1)
        elapsed = elapsed + 0.1
        for _, v in ipairs(speaker.Backpack:GetChildren()) do
            if v.Name:lower():find(lower_choice, 1, true) then return true end
        end
        local char = speaker.Character
        if char then
            for _, v in ipairs(char:GetChildren()) do
                if v:IsA("Tool") and v.Name:lower():find(lower_choice, 1, true) then return true end
            end
        end
    until elapsed >= (timeout or 10)
    return false
end

g.get_snack = function(choice)
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(workspace or game) then return end
    local hrp = g.HumanoidRootPart or char and char:FindFirstChild("HumanoidRootPart") or g.get_root(speaker)
    if not hrp or not hrp.Parent then return end
    local giver_remote = g.giver_pressed_remote_RS or find_giver_remote()
    if not giver_remote or not giver_remote:IsA("RemoteEvent") then return end
    local item = find_vending_item(choice or "soda")
    if item then
        local old_cf = char:GetPivot()
        char:PivotTo(item:GetPivot() + Vector3.new(0, 2, 0))
        wait(0.2)
        pcall(giver_remote.FireServer, giver_remote, item)
        wait_for_snack(choice or "soda", 10)
        char:PivotTo(old_cf)
    else
        local interact_remote = g.interact_item_remote_RS or find_interact_remote()
        if not interact_remote or not interact_remote:IsA("RemoteFunction") then return end
        local part = find_vending_part(choice or "soda")
        if not part then g.notify("Error", "Could not find vending machine part: " .. tostring(choice or "soda"), 3); return end
        local old_cf = char:GetPivot()
        char:PivotTo(part:GetPivot() + Vector3.new(0, 2, 0))
        wait(0.2)
        local timeout = 10
        local start = os.clock()
        local last_invoke = os.clock()
        pcall(interact_remote.InvokeServer, interact_remote, part)
        local dropped_item = nil
        while not dropped_item and (os.clock() - start) < timeout do
            task.wait(0.1)
            dropped_item = find_vending_item(choice or "soda")
            if not dropped_item and (os.clock() - last_invoke) >= 1.5 then
                pcall(interact_remote.InvokeServer, interact_remote, part)
                last_invoke = os.clock()
            end
        end

        if not dropped_item then
            g.notify("Error", "Vending machine did not drop item in time.", 3)
            char:PivotTo(old_cf)
            return
        end

        char:PivotTo(dropped_item:GetPivot() + Vector3.new(0, 2, 0))
        wait(0.1)
        pcall(giver_remote.FireServer, giver_remote, dropped_item)
        wait_for_snack(choice or "soda", 10)
        char:PivotTo(old_cf)
    end
end

g.walkspeed_toggle = function(state, speed)
    g.walkspeed_on = state
    g.walkspeed_value = speed or g.walkspeed_value or StarterPlayer.CharacterWalkSpeed
    if state then
        FlamesLibrary.connect("walkspeed_cf", RunService.Heartbeat:Connect(function()
            local char = g.Character or speaker.Character or g.get_char(speaker)
            if not char or not char:IsDescendantOf(workspace or game) then return end
            local human = g.Humanoid or char and char:FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
            if not human or not human.Parent then return end
            if human.WalkSpeed ~= g.walkspeed_value then human.WalkSpeed = g.walkspeed_value end
        end))
        FlamesLibrary.connect("walkspeed_respawn", speaker.CharacterAdded:Connect(function()
            if not g.walkspeed_on then return end
            FlamesLibrary.spawn("walkspeed_respawn_delay", "delay", 0, function()
                g.walkspeed_toggle(true, g.walkspeed_value)
            end)
        end))
    else
        FlamesLibrary.disconnect("walkspeed_cf")
        FlamesLibrary.disconnect("walkspeed_respawn")
        FlamesLibrary.disconnect("walkspeed_respawn_delay")
        local char = g.Character or speaker.Character or g.get_char(speaker)
        if not char or not char:IsDescendantOf(workspace or game) then return end
        local human = g.Humanoid or char and char:FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
        if not human or not human.Parent then return end
        human.WalkSpeed = StarterPlayer.CharacterWalkSpeed
    end
end

local R6_PARTS = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "HumanoidRootPart"}
local function find_character_collision_script()
    local cache = g.character_collision_script_RS
    if cache and cache:IsA("Script") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("Script") and v.Name:lower():find("character") and v.Name:lower():find("collision") then
            g.character_collision_script_RS = v
            return v
        end
    end
    return nil
end
task.wait(0.1)
if not g.character_collision_script_RS then pcall(function() find_character_collision_script() end) end

g.noclip_toggle = function(state)
    g.noclip_on = state
    local collision_script = g.character_collision_script_RS or find_character_collision_script()
    if state then
        if collision_script and (collision_script:IsA("Script") or collision_script:IsA("LocalScript")) then collision_script.Disabled = true end
        FlamesLibrary.connect("noclip_heartbeat", RunService.Heartbeat:Connect(function()
            local char = g.Character or speaker.Character or g.get_char(speaker)
            if not char or not char:IsDescendantOf(workspace or game) then return end
            for _, part_name in ipairs(R6_PARTS) do
                local part = char:FindFirstChild(part_name)
                if part and part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end))
        FlamesLibrary.connect("noclip_respawn", speaker.CharacterAdded:Connect(function()
            if not g.noclip_on then return end
            FlamesLibrary.spawn("noclip_respawn_delay", "delay", 0, function() g.noclip_toggle(true) end)
        end))
    else
        if collision_script and (collision_script:IsA("Script") or collision_script:IsA("LocalScript")) then collision_script.Disabled = false end
        FlamesLibrary.disconnect("noclip_heartbeat")
        FlamesLibrary.disconnect("noclip_respawn")
        FlamesLibrary.disconnect("noclip_respawn_delay")
        local char = g.Character or speaker.Character or g.get_char(speaker)
        if not char or not char:IsDescendantOf(workspace or game) then return end
        for _, part_name in ipairs(R6_PARTS) do
            local part = char:FindFirstChild(part_name)
            if part and part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

g.inf_jump_toggle = function(state)
    g.inf_jump_on = state
    if state then
        FlamesLibrary.connect("inf_jump", UserInputService.JumpRequest:Connect(function()
            if g.inf_jump_debounce then return end
            local Char = g.Character or speaker.Character or g.get_char(speaker)
            if not Char or not Char:IsDescendantOf(workspace or game) then return end
            local Human = g.Humanoid or Char and Char:FindFirstChildWhichIsA("Humanoid") or g.get_human(speaker)
            if not Human or not Human.Parent then return end
            g.inf_jump_debounce = true
            Human:ChangeState(Enum.HumanoidStateType.Jumping)
            task.wait()
            g.inf_jump_debounce = false
        end))
    else
        FlamesLibrary.disconnect("inf_jump")
        g.inf_jump_debounce = false
    end
end

local AMMO_KEYS = {MaxAmmo = true, CurrentAmmo = true, Local_CurrentAmmo = true}
local function find_gun_remotes_folder()
    local cache = g.gun_remotes_folder_RS
    if cache and cache:IsA("Folder") then return cache end
    for _, v in ipairs(ReplicatedStorage:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("gun") and v.Name:lower():find("remotes") then
            g.gun_remotes_folder_RS = v
            return v
        end
    end
    return nil
end
task.wait(0.1)
if not g.gun_remotes_folder_RS then pcall(function() find_gun_remotes_folder() end) end

local function find_func_reload()
    local cache = g.func_reload_remote_RS
    if cache and cache:IsA("RemoteFunction") then return cache end
    local gun_remotes = g.gun_remotes_folder_RS or find_gun_remotes_folder()
    if not gun_remotes then return nil end
    for _, v in ipairs(gun_remotes:GetChildren()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("func") and v.Name:lower():find("reload") then
            g.func_reload_remote_RS = v
            return v
        end
    end
    return nil
end
task.wait(0.1)
if not g.func_reload_remote_RS then pcall(function() find_func_reload() end) end

local function find_shoot_event()
    local cache = g.shoot_event_remote_RS
    if cache and cache:IsA("RemoteEvent") then return cache end
    local gun_remotes = g.gun_remotes_folder_RS or find_gun_remotes_folder()
    if not gun_remotes then return nil end
    for _, v in ipairs(gun_remotes:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("shoot") then
            g.shoot_event_remote_RS = v
            return v
        end
    end
    return nil
end
task.wait(0.1)
if not g.shoot_event_remote_RS then pcall(function() find_shoot_event() end) end
local function has_drawing_lib() return typeof(Drawing) == "table" and typeof(Drawing.new) == "function" end
local esp_folder = CoreGui:FindFirstChild("AccessoryESP") or Instance.new("Folder")
esp_folder.Name = "AccessoryESP"
esp_folder.Parent = CoreGui
local hostile_attributes = {
    "Hostile",
    "Trespassing",
    "PunchedSomeone",
    "EnteredArmory",
    "EquippedHostileTool",
}

g.is_hostile = function(Player)
    local Char = Player.Character or g.get_char(Player)
    if not Char then return false end
    for _, attr in ipairs(hostile_attributes) do
        local ok, val = pcall(function() return Char:GetAttribute(attr) end)
        if ok and val == true then return true end
    end
    return false
end

g.get_team_color = function(Player)
    if g.is_hostile(Player) then return Color3.fromRGB(255, 0, 0) end
    if Player.Team and Player.Team.Name == "Inmates" then return Color3.fromRGB(255, 140, 0) end
    if Player.Team and speaker.Team and Player.Team == speaker.Team then return Player.Team.TeamColor.Color end
    return Color3.fromRGB(255, 0, 0)
end

g.get_local_origin = function()
    local Char = g.Character or speaker.Character or g.get_char(speaker)
    if not Char or not Char:IsDescendantOf(workspace or game) then return nil end
    for _, Desc in ipairs(Char:GetDescendants()) do
        if Desc:IsA("BasePart") and Desc.Name == "Handle" then
            return Desc.Position
        end
    end
    local Root = g.HumanoidRootPart or Char and Char:FindFirstChild("HumanoidRootPart") or g.get_root(speaker)
    if not Root or not Root.Parent then return nil end
    return Root and Root.Position or nil
end

g.detect_char_type = function(Char)
    if not Char then return nil end
    if Char:FindFirstChild("HumanoidRootPart") and Char:FindFirstChild("Torso") then return "r6" end
    for _, Desc in ipairs(Char:GetDescendants()) do
        if Desc:IsA("BasePart") and Desc.Name == "Handle" then
            return "handle"
        end
    end
    return nil
end

g.make_r6_esp = function(Player)
    local Char = Player.Character or g.get_char(Player, 3)
    if not Char or not Char:IsDescendantOf(workspace or game) then return end
    local key = tostring(Player.UserId) .. "_r6"
    if g.esp_cache[key] then return end
    local Head = Char:FindFirstChild("Head") or g.get_head(Player, 3)
    local Highlight = Instance.new("Highlight")
    Highlight.Adornee = Char
    Highlight.FillColor = g.get_team_color(Player)
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    Highlight.FillTransparency = 0.5
    Highlight.OutlineTransparency = 0
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.Parent = esp_folder
    local Bill = Instance.new("BillboardGui")
    Bill.AlwaysOnTop = true
    Bill.Size = UDim2.new(0, 120, 0, 40)
    Bill.StudsOffset = Vector3.new(0, 3, 0)
    Bill.Adornee = Head or Char:FindFirstChildWhichIsA("BasePart")
    Bill.Parent = esp_folder
    local NameLabel = Instance.new("TextLabel")
    NameLabel.BackgroundTransparency = 1
    NameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    NameLabel.TextColor3 = g.get_team_color(Player)
    NameLabel.TextStrokeTransparency = 0
    NameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextScaled = true
    NameLabel.Text = Player.DisplayName
    NameLabel.Parent = Bill
    local DistLabel = Instance.new("TextLabel")
    DistLabel.BackgroundTransparency = 1
    DistLabel.Size = UDim2.new(1, 0, 0.5, 0)
    DistLabel.Position = UDim2.new(0, 0, 0.5, 0)
    DistLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    DistLabel.TextStrokeTransparency = 0
    DistLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    DistLabel.Font = Enum.Font.Gotham
    DistLabel.TextScaled = true
    DistLabel.Text = "..."
    DistLabel.Parent = Bill
    g.esp_cache[key] = {
        highlight = Highlight,
        bill = Bill,
        dist = DistLabel,
        handle = Char:FindFirstChild("HumanoidRootPart") or g.get_root(Player, 3),
        player = Player,
        type = "r6",
    }
end

g.make_esp = function(Player, Handle)
    local key = Player.UserId .. "_" .. Handle:GetFullName()
    if g.esp_cache[key] then return end
    local Highlight = Instance.new("Highlight")
    Highlight.Adornee = Handle
    Highlight.FillColor = g.get_team_color(Player)
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    Highlight.FillTransparency = 0.5
    Highlight.OutlineTransparency = 0
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.Parent = esp_folder
    local Bill = Instance.new("BillboardGui")
    Bill.AlwaysOnTop = true
    Bill.Size = UDim2.new(0, 120, 0, 40)
    Bill.StudsOffset = Vector3.new(0, 2, 0)
    Bill.Adornee = Handle
    Bill.Parent = esp_folder
    local NameLabel = Instance.new("TextLabel")
    NameLabel.BackgroundTransparency = 1
    NameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    NameLabel.TextColor3 = g.get_team_color(Player)
    NameLabel.TextStrokeTransparency = 0
    NameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextScaled = true
    NameLabel.Text = Player.DisplayName
    NameLabel.Parent = Bill
    local DistLabel = Instance.new("TextLabel")
    DistLabel.BackgroundTransparency = 1
    DistLabel.Size = UDim2.new(1, 0, 0.5, 0)
    DistLabel.Position = UDim2.new(0, 0, 0.5, 0)
    DistLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    DistLabel.TextStrokeTransparency = 0
    DistLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    DistLabel.Font = Enum.Font.Gotham
    DistLabel.TextScaled = true
    DistLabel.Text = "..."
    DistLabel.Parent = Bill
    g.esp_cache[key] = {
        highlight = Highlight,
        bill = Bill,
        dist = DistLabel,
        handle = Handle,
        player = Player,
        type = "handle",
    }
end

g.scan_handles = function(Player)
    local Char = Player.Character
    if not Char then return end
    for _, Desc in ipairs(Char:GetDescendants()) do
        if Desc:IsA("BasePart") and Desc.Name == "Handle" then
            g.make_esp(Player, Desc)
        end
    end
end

g.scan_player = function(Player)
    local Char = Player.Character
    if not Char then return end
    local char_type = g.detect_char_type(Char)
    if char_type == "r6" then
        g.make_r6_esp(Player)
    elseif char_type == "handle" then
        g.scan_handles(Player)
    end
end

g.clear_esp = function(Player)
    local to_remove = {}
    local uid = tostring(Player.UserId)
    for key, entry in pairs(g.esp_cache) do
        if key:sub(1, #uid) == uid then
            pcall(function() entry.highlight:Destroy() end)
            pcall(function() entry.bill:Destroy() end)
            to_remove[#to_remove + 1] = key
        end
    end
    for _, key in ipairs(to_remove) do g.esp_cache[key] = nil end
end

g.clear_all_esp = function()
    for _, entry in pairs(g.esp_cache) do
        pcall(function() entry.highlight:Destroy() end)
        pcall(function() entry.bill:Destroy() end)
    end
    g.esp_cache = {}
end

g.setup_player = function(Player)
    if Player == speaker then return end
    g.scan_player(Player)
    FlamesLibrary.connect("esp_char_added_" .. Player.UserId, Player.CharacterAdded:Connect(function()
        FlamesLibrary.wait(1)
        if g.esp_active then g.scan_player(Player) end
    end))
    FlamesLibrary.connect("esp_char_removing_" .. Player.UserId, Player.CharacterRemoving:Connect(function()
        g.clear_esp(Player)
    end))
    FlamesLibrary.connect("esp_desc_added_" .. Player.UserId, Player.DescendantAdded:Connect(function(Desc)
        if not g.esp_active then return end
        if Desc:IsA("BasePart") and Desc.Name == "Handle" then
            g.make_esp(Player, Desc)
        end
    end))
end

g.esp_start = function()
    for _, Player in ipairs(Players:GetPlayers()) do g.setup_player(Player) end
    FlamesLibrary.connect("esp_player_added", Players.PlayerAdded:Connect(function(Player)
        if g.esp_active then g.setup_player(Player) end
    end))
    FlamesLibrary.connect("esp_player_removing", Players.PlayerRemoving:Connect(function(Player)
        g.clear_esp(Player)
    end))
    FlamesLibrary.connect("esp_heartbeat", RunService.Heartbeat:Connect(function()
        if not g.esp_active then
            FlamesLibrary.disconnect("esp_heartbeat")
            return
        end
        for key, entry in pairs(g.esp_cache) do
            if not entry.handle or not entry.handle.Parent then
                pcall(function() entry.highlight:Destroy() end)
                pcall(function() entry.bill:Destroy() end)
                g.esp_cache[key] = nil
                continue
            end
            local src = g.get_local_origin()
            if src then
                local dist = (entry.handle.Position - src).Magnitude
                entry.dist.Text = string.format("%.1f studs", dist)
            end
            entry.highlight.FillColor = g.get_team_color(entry.player)
        end
    end))
end

g.esp_stop = function()
    g.clear_all_esp()
    FlamesLibrary.disconnect("esp_heartbeat")
    FlamesLibrary.disconnect("esp_player_added")
    FlamesLibrary.disconnect("esp_player_removing")
    for _, Player in ipairs(Players:GetPlayers()) do
        FlamesLibrary.disconnect("esp_char_added_" .. Player.UserId)
        FlamesLibrary.disconnect("esp_char_removing_" .. Player.UserId)
    end
end

g.toggle_esp = function(state)
    g.esp_active = state
    if g.esp_active then
        g.esp_start()
    else
        g.esp_stop()
    end
end

local function create_fov_circle()
    local existing = g.silent_aim_fov_circle
    if existing then return existing end
    if not has_drawing_lib() then return nil end
    local circle = Drawing.new("Circle")
    circle.Visible = false
    circle.Radius = g.silent_aim_fov
    circle.Color = Color3.fromRGB(255, 255, 255)
    circle.Thickness = 1.5
    circle.Filled = false
    circle.NumSides = 64
    local mouse_pos = UserInputService:GetMouseLocation()
    circle.Position = Vector2.new(mouse_pos.X, mouse_pos.Y)
    g.silent_aim_fov_circle = circle
    return circle
end

local function destroy_fov_circle()
    local circle = g.silent_aim_fov_circle
    if circle then
        pcall(function() circle:Remove() end)
        g.silent_aim_fov_circle = nil
    end
end

local function is_valid_target(Player)
    if g.is_hostile(Player) then return true end
    if Player.Team and Player.Team.Name == "Criminal" then return true end
    return false
end

local function update_fov_and_target()
    local circle = g.silent_aim_fov_circle
    local mouse_pos = UserInputService:GetMouseLocation()
    local center = Vector2.new(mouse_pos.X, mouse_pos.Y)
    if circle then
        circle.Position = center
        circle.Radius = g.silent_aim_fov
        circle.Visible = g.silent_aim_on and g.silent_aim_fov_visible ~= false
    end
    local hitpart_name = g.silent_aim_hitpart or "Head"
    local fov = g.silent_aim_fov
    local best_dist = math.huge
    local best_part = nil
    local best_hrp = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p == speaker then continue end
        if not is_valid_target(p) then continue end
        local target_char = p.Character or g.get_char(p)
        if not target_char or not target_char:IsDescendantOf(workspace) then continue end
        local target_part = target_char:FindFirstChild(hitpart_name) or target_char:FindFirstChild("Head")
        local target_hrp = target_char:FindFirstChild("HumanoidRootPart") or g.get_root(p)
        local target_hum = target_char:FindFirstChildWhichIsA("Humanoid") or g.get_human(p)
        if not (target_part and target_hrp and target_hum and target_hum.Health > 0) then continue end
        local screen_pos, on_screen = Camera:WorldToViewportPoint(target_part.Position)
        if not on_screen then continue end
        local dist = (Vector2.new(screen_pos.X, screen_pos.Y) - center).Magnitude
        if dist <= fov and dist < best_dist then
            best_dist = dist
            best_part = target_part
            best_hrp = target_hrp
        end
    end
    g.silent_aim_cached_part = best_part
    g.silent_aim_cached_hrp = best_hrp
end

local cast_ray_ref = nil
local cast_ray_original = nil
local function find_cast_ray()
    if not filtergc or typeof(filtergc) ~= "function" then return nil end
    local results = filtergc("function", {Name = "castRay"}, false)
    return results and results[1] or nil
end

g.silent_aim_toggle = function(state)
    if state and not has_drawing_lib() then
        g.notify("Error", "Drawing library not available.", 3)
        return
    end
    if state and not (typeof(hookfunction) == "function" and typeof(newcclosure) == "function" and typeof(filtergc) == "function") then
        g.notify("Error", "Executor missing required functions.", 3)
        return
    end
    g.silent_aim_on = state
    if state then
        local circle = create_fov_circle()
        if not circle then return end
        circle.Visible = g.silent_aim_fov_visible ~= false
        FlamesLibrary.connect("silent_aim_update", RunService.RenderStepped:Connect(function()
            update_fov_and_target()
        end))
        if cast_ray_original then return end
        local target = find_cast_ray()
        if not target then
            g.notify("Error", "castRay not found.", 3)
            return
        end
        cast_ray_ref = target
        cast_ray_original = hookfunction(target, newcclosure(function(origin, aim, spread)
            if g.silent_aim_on then
                local part = g.silent_aim_cached_part
                local hrp = g.silent_aim_cached_hrp
                if part and hrp and part.Parent then return part, part.Position end
            end
            return cast_ray_original(origin, aim, spread)
        end))
    else
        destroy_fov_circle()
        FlamesLibrary.disconnect("silent_aim_update")
        g.silent_aim_cached_part = nil
        g.silent_aim_cached_hrp = nil
        if cast_ray_original and cast_ray_ref then
            if hookfunction and typeof(hookfunction) == "function" then hookfunction(cast_ray_ref, cast_ray_original) end
            cast_ray_original = nil
            cast_ray_ref = nil
        end
    end
end

local function apply_ammo_to_tool(tool)
    local mods = GUN_MODS[tool.Name]
    if not mods then return end
    for k, val in pairs(mods) do
        if AMMO_KEYS[k] and tool:GetAttribute(k) ~= val then
            tool:SetAttribute(k, val)
        end
    end
end

local function apply_stats_to_tool(tool)
    local mods = GUN_MODS[tool.Name]
    if not mods then return end
    for k, val in pairs(mods) do
        if not AMMO_KEYS[k] and tool:GetAttribute(k) ~= val then
            tool:SetAttribute(k, val)
        end
    end
end

local function apply_stats()
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(workspace or game) then return end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and GUN_MODS[tool.Name] then
            apply_stats_to_tool(tool)
        end
    end
end

local function watch_tool_reload(tool)
    FlamesLibrary.connect("gun_reload_watch_" .. tool.Name, tool:GetAttributeChangedSignal("isReloading"):Connect(function()
        if not g.gun_mods_on then return end
        if not tool:GetAttribute("isReloading") then return end
        repeat task.wait() until tool:GetAttribute("Local_ReloadSession") == 0 or not g.gun_mods_on or not tool.Parent
        if g.gun_mods_on and tool.Parent then
            apply_ammo_to_tool(tool)
        end
    end))
end

local function hook_equipped_guns()
    local char = g.Character or speaker.Character or g.get_char(speaker)
    if not char or not char:IsDescendantOf(workspace or game) then return end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and GUN_MODS[tool.Name] then
            apply_ammo_to_tool(tool)
            apply_stats_to_tool(tool)
            watch_tool_reload(tool)
        end
    end
end

g.gun_mods_toggle = function(state)
    g.gun_mods_on = state
    if state then
        hook_equipped_guns()
        FlamesLibrary.connect("gun_mods_heartbeat", RunService.Heartbeat:Connect(function() apply_stats() end))
        FlamesLibrary.connect("gun_mods_char_added", speaker.CharacterAdded:Connect(function(char)
            char.ChildAdded:Connect(function(child)
                if not g.gun_mods_on then return end
                if child:IsA("Tool") and GUN_MODS[child.Name] then
                    task.defer(function()
                        apply_ammo_to_tool(child)
                        apply_stats_to_tool(child)
                        watch_tool_reload(child)
                    end)
                end
            end)
        end))
        FlamesLibrary.connect("gun_mods_respawn", speaker.CharacterAdded:Connect(function()
            if not g.gun_mods_on then return end
            FlamesLibrary.spawn("gun_mods_respawn_delay", "delay", 0, function()
                g.gun_mods_toggle(true)
            end)
        end))
    else
        FlamesLibrary.disconnect("gun_mods_heartbeat")
        FlamesLibrary.disconnect("gun_mods_char_added")
        FlamesLibrary.disconnect("gun_mods_respawn")
        FlamesLibrary.disconnect("gun_mods_respawn_delay")
        for name in pairs(GUN_MODS) do FlamesLibrary.disconnect("gun_reload_watch_" .. name) end
    end
end

local Atlas = loadstring(g.http_get("https://gitlab.com/flames2431233/Starter/-/raw/main/UIs/Atlas.lua?ref_type=heads", true))()
local UI = Atlas.new({
    Name = "Flames Hub | Prison Life",
    ConfigFolder = "FlamesHub_Prison_Life_Menu_Configuration",
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
local Weapons_Section = Home_Page:CreateSection("Guns")
local LocalPlayer_Section = Home_Page:CreateSection("LocalPlayer")
local Lighting_Section = Home_Page:CreateSection("Lighting")
local Players_Section = Home_Page:CreateSection("Players")

g.create_ui_element("Toggle", LocalPlayer_Section, {
Name = "Infinite Stamina (FE)",
Default = g.infinite_stamina_on or false,
Flag = "Infinite_Stamina_Toggle_UI",
Callback = function(state)
    g.infinite_stamina_toggle(state)
end,}, "Infinite_Stamina_Toggle_UI")

g.create_ui_element("Toggle", Lighting_Section, {
Name = "Fullbright",
Default = g.fullbright_enabled or false,
Flag = "Fullbright_Toggle_UI",
Callback = function(state)
    g.fullbright_toggle(state)
end,}, "Fullbright_Toggle_UI")

g.create_ui_element("Toggle", LocalPlayer_Section, {
Name = "Anti Taze (FE)",
Default = g.anti_taze_on or false,
Flag = "Anti_Taze_Toggle_UI",
Callback = function(state)
    g.anti_taze_toggle(state)
end,}, "Anti_Taze_Toggle_UI")

g.create_ui_element("Toggle", LocalPlayer_Section, {
Name = "Noclip (FE)",
Default = g.noclip_on or false,
Flag = "Noclip_Toggle_UI",
Callback = function(state)
    g.noclip_toggle(state)
end,}, "Noclip_Toggle_UI")

g.create_ui_element("Toggle", LocalPlayer_Section, {
Name = "WalkSpeed (FE)",
Default = g.walkspeed_on or false,
Flag = "Walkspeed_Toggle_UI",
Callback = function(state)
    g.walkspeed_toggle(state, g.walkspeed_value or StarterPlayer.CharacterWalkSpeed or 16)
end,}, "Walkspeed_Toggle_UI")

g.create_ui_element("Slider", LocalPlayer_Section, {
Name = "WalkSpeed Value",
Min = StarterPlayer.CharacterWalkSpeed or 16,
Max = 500,
Default = g.walkspeed_value or StarterPlayer.CharacterWalkSpeed or 16,
Flag = "Walkspeed_Slider_UI",
Callback = function(val)
    g.walkspeed_value = val
end,}, "Walkspeed_Slider_UI")

g.create_ui_element("Toggle", LocalPlayer_Section, {
Name = "Infinite Jump (FE)",
Default = g.inf_jump_on or false,
Flag = "Inf_Jump_Toggle_UI",
Callback = function(state)
    g.inf_jump_toggle(state)
end,}, "Inf_Jump_Toggle_UI")

g.create_ui_element("Toggle", LocalPlayer_Section, {
Name = "Auto Reset On Criminal (FE)",
Default = g.auto_reset_team_on or false,
Flag = "Auto_Reset_Team_Toggle_UI",
Callback = function(state)
    g.auto_reset_team_toggle(state)
end,}, "Auto_Reset_Team_Toggle_UI")

g.create_ui_element("Toggle", Weapons_Section, {
Name = "Gun Mods (MP5 & Remington 870, broken)",
Default = g.gun_mods_on or false,
Flag = "Gun_Mods_Toggle_UI",
Callback = function(state)
    g.gun_mods_toggle(state)
end,}, "Gun_Mods_Toggle_UI")

g.create_ui_element("Toggle", Players_Section, {
Name = "ESP",
Default = g.esp_active or false,
Flag = "ESP_Toggle_UI",
Callback = function(state)
    g.toggle_esp(state)
end,}, "ESP_Toggle_UI")

g.create_ui_element("Toggle", Home_Section, {
Name = "Silent Aim",
Default = g.silent_aim_on or false,
Flag = "Silent_Aim_Toggle_UI",
Callback = function(state)
    g.silent_aim_toggle(state)
end,}, "Silent_Aim_Toggle_UI")

g.create_ui_element("Toggle", Home_Section, {
Name = "Silent Aim FOV Circle",
Default = g.silent_aim_fov_visible or true,
Flag = "Silent_Aim_FOV_Circle_Toggle_UI",
Callback = function(state)
    g.silent_aim_fov_visible = state
    local circle = g.silent_aim_fov_circle
    if circle then circle.Visible = state and g.silent_aim_on end
end,}, "Silent_Aim_FOV_Circle_Toggle_UI")

g.create_ui_element("Dropdown", Home_Section, {
Name = "Silent Aim Hit Part",
Options = {
    "Head",
    "Torso",
    "Left Arm",
    "Right Arm",
},
DefaultItemSelected = g.silent_aim_hitpart or "Head",
ItemSelecting = true,
Callback = function(selected)
    g.silent_aim_hitpart = selected
end,}, "Silent_Aim_Hitpart_Dropdown_UI")

g.create_ui_element("Toggle", Home_Section, {
Name = "Silent Aim Team Check",
Default = g.silent_aim_team_check ~= false,
Flag = "Silent_Aim_Team_Check_Toggle_UI",
Callback = function(state)
    g.silent_aim_team_check = state
end,}, "Silent_Aim_Team_Check_Toggle_UI")

g.create_ui_element("Slider", Home_Section, {
Name = "Silent Aim FOV",
Min = 10,
Max = 500,
Default = g.silent_aim_fov or 120,
Flag = "Silent_Aim_FOV_Slider_UI",
Callback = function(val)
    g.silent_aim_fov = val
end,}, "Silent_Aim_FOV_Slider_UI")

g.create_ui_element("Toggle", Home_Section, {
Name = "Fence Godmode (FE)",
Default = g.fence_godmode_on or false,
Flag = "Fence_Godmode_Toggle_UI",
Callback = function(state)
    g.fence_godmode_toggle(state)
end,}, "Fence_Godmode_Toggle_UI")

g.create_ui_element("Button", Weapons_Section, {
Name = "Get Remington 870 (FE)",
Callback = function()
    g.get_weapons("Remington 870")
end,})

g.create_ui_element("Button", Weapons_Section, {
Name = "Get MP5 (FE)",
Callback = function()
    g.get_weapons("MP5")
end,})

g.create_ui_element("Button", Home_Section, {
Name = "Get Soda (FE)",
Callback = function()
    g.get_snack("soda")
end,})

g.create_ui_element("Button", Home_Section, {
Name = "Get Chips (FE)",
Callback = function()
    g.get_snack("chips")
end,})

g.create_ui_element("Button", Home_Section, {
Name = "Get Chocolate (FE)",
Callback = function()
    g.get_snack("chocolate")
end,})

g.create_ui_element("Input", Players_Section, {
Name = "Arrest Player (FE)",
PlaceholderText = "Enter player name...",
Flag = "Arrest_Player_Input_UI",
Callback = function(input)
    local target = g.findplr(input)
    if target then
        g.arrest_player(target)
        g.notify("Success", "Arresting: " .. target.Name, 3)
    else
        g.notify("Error", "Player not found: " .. tostring(input), 3)
    end
end}, "Arrest_Player_Input_UI")