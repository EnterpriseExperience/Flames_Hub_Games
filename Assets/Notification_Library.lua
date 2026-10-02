if not game:IsLoaded() then game.Loaded:Wait() end
local Is_Studio = game:GetService("RunService"):IsStudio() and true or false
local g
if Is_Studio then
    g = _G
else
    g = getgenv()
end
wait(0.1)
local function safe_wrapper(S)
    if Is_Studio then return game:GetService(S) end
    if g[S] then return g[S] end
    if cloneref and typeof(cloneref) == "function" then
        return cloneref(game:GetService(S))
    else
        return game:GetService(S)
    end
end

local parent_gui
local Players = safe_wrapper("Players")
local TweenService = safe_wrapper("TweenService")
local CoreGui = safe_wrapper("CoreGui")
local LocalPlayer = g.LocalPlayer or Players.LocalPlayer
local PlayerGui = g.PlayerGui or LocalPlayer:FindFirstChildWhichIsA("PlayerGui") or LocalPlayer:FindFirstChildOfClass("PlayerGui")
if Is_Studio then parent_gui = PlayerGui else parent_gui = (get_hidden_gui and get_hidden_gui()) or (gethui and gethui()) or CoreGui end
local StarterGui = safe_wrapper("StarterGui")
local GuiService = safe_wrapper("GuiService")
local Workspace = safe_wrapper("Workspace")
local UserInputService = safe_wrapper("UserInputService")
local LibraryName = "Notification Library"
local NotificationLibrary = {}
local library
local Template_Folder
local canvas

function NotificationLibrary:Load()
    local objects = game:GetObjects("rbxassetid://15133757123")
    if not objects or not objects[1] then
        warn("[NotifyLib] game:GetObjects failed to load asset.")
        return false
    end
    library = objects[1]
    Template_Folder = library:FindFirstChild("Templates")
    canvas = library:FindFirstChild("list")
    if not Template_Folder or not canvas then
        warn("[NotifyLib]: asset structure invalid — Templates or list missing.")
        return false
    end
    library.Name = LibraryName
    library.Parent = parent_gui
    return true
end
wait(0.25)
NotificationLibrary:Load()
wait(0.25)
function NotificationLibrary:SendNotification(Mode, Text, Duration)
    local libaryCore = parent_gui:FindFirstChild(LibraryName)
    if not libaryCore then
        local loaded = NotificationLibrary:Load()
        if not loaded then return end
    else
        library = libaryCore
        Template_Folder = library:FindFirstChild("Templates")
        canvas = library:FindFirstChild("list")
        if not Template_Folder or not canvas then
            local loaded = NotificationLibrary:Load()
            if not loaded then return end
        end
    end
    if not Template_Folder then return end
    if Template_Folder:FindFirstChild(Mode) then
        task.spawn(function()
            local success, err = pcall(function()
                local Notification = Template_Folder:WaitForChild(Mode):Clone()
                local filler = Notification.Filler
                local bar = Notification.bar
                Notification.Header.Text = Text
                Notification.Visible = true
                Notification.Parent = canvas
                Notification.Size = UDim2.new(0, 0, 0.087, 0)
                filler.Size = UDim2.new(1, 0, 1, 0)
                local T1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local T2 = TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                local T3 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                TweenService:Create(Notification, T1, {Size = UDim2.new(1, 0, 0.087, 0)}):Play()
                task.wait(0.2)
                TweenService:Create(filler, T3, {Size = UDim2.new(0.011, 0, 1, 0)}):Play()
                TweenService:Create(bar, T2, {Size = UDim2.new(1, 0, 0.05, 0)}):Play()
                task.wait(Duration)
                TweenService:Create(filler, T1, {Size = UDim2.new(1, 0, 1, 0)}):Play()
                task.wait(0.25)
                TweenService:Create(Notification, T3, {Size = UDim2.new(0, 0, 0.087, 0)}):Play()
                task.wait(0.25)
                Notification:Destroy()
            end)
            if not success then warn("[NotifyLib]: notification error: "..tostring(err)) end
        end)
    else
        warn(tostring(Mode).." is not a valid 'Mode'! (only: Warning, Success, Error, Info).")
    end
end
wait(0.25)
local NotificationLibrary_External = NotificationLibrary
local Sound_ID_Windows = "rbxassetid://8183296024"
local Sound_ID_iPhone = "rbxassetid://73722479618078"
local Sound_ID_Android = "rbxassetid://17582299860"
local Sound_ID_Universal = "rbxassetid://18595195017"
local Notification_Wrapper = {}
local function Device_Detector()
    local platform = UserInputService:GetPlatform()
    local Platform_Map = {
        [Enum.Platform.Windows] = "Windows",
        [Enum.Platform.OSX] = "OSX",
        [Enum.Platform.IOS] = "iOS",
        [Enum.Platform.Android] = "Android",
        [Enum.Platform.XBoxOne] = "Xbox One (Console)",
        [Enum.Platform.PS4] = "PS4 (Console)",
        [Enum.Platform.XBox360] = "Xbox 360 (Console)",
        [Enum.Platform.WiiU] = "Wii-U (Console)",
        [Enum.Platform.NX] = "Cisco Nexus",
        [Enum.Platform.Ouya] = "Ouya (Android-Based)",
        [Enum.Platform.AndroidTV] = "Android TV",
        [Enum.Platform.Chromecast] = "Chromecast",
        [Enum.Platform.Linux] = "Linux (Desktop)",
        [Enum.Platform.SteamOS] = "Steam Client",
        [Enum.Platform.WebOS] = "Web-OS",
        [Enum.Platform.DOS] = "DOS",
        [Enum.Platform.BeOS] = "BeOS",
        [Enum.Platform.UWP] = "UWP (Go Back To Web Bro..)",
        [Enum.Platform.PS5] = "PS5 (Console)",
        [Enum.Platform.MetaOS] = "MetaOS",
        [Enum.Platform.None] = "Unknown Device"
    }
    return Platform_Map[platform] or "Unknown Device"
end

local DevicePlatform = Device_Detector()
function Play_Notification_Sound()
    local Notification_Sound = Instance.new("Sound")
    Notification_Sound.Parent = Workspace
    Notification_Sound.Volume = 1
    if DevicePlatform == "Windows" then
        Notification_Sound.SoundId = Sound_ID_Windows
    elseif DevicePlatform == "iOS" then
        Notification_Sound.SoundId = Sound_ID_iPhone
    elseif DevicePlatform == "Android" then
        Notification_Sound.SoundId = Sound_ID_Android
    else
        Notification_Sound.SoundId = Sound_ID_Universal
    end
    task.wait()
    Notification_Sound:Play()
    Notification_Sound.Ended:Connect(function() Notification_Sound:Destroy() end)
end

function Notification_Wrapper:External_Notification(Type, Content, Time)
    if not Time then Time = 5 end
    wait()
    Play_Notification_Sound()
    NotificationLibrary_External:SendNotification(tostring(Type), tostring(Content), tonumber(Time))
end

function Notification_Wrapper:GuiService_Notify(title, content)
    Play_Notification_Sound()
    GuiService:SendNotification({
        Title = tostring(title),
        Text = tostring(content),
    })
end

function Notification_Wrapper:StarterGui_Notify(title, content, duration)
    if not duration then duration = 5 end
    wait()
    Play_Notification_Sound()
    StarterGui:SetCore("SendNotification", {
        Title = tostring(title);
        Text = tostring(content);
        Duration = tonumber(duration);
        Icon = "rbxassetid://0";
    })
end

return Notification_Wrapper