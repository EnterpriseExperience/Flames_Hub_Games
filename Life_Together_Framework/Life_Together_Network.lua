if not game:IsLoaded() then game.Loaded:Wait() end
-- [[ Better Network system, it'll grab ALL the ModuleScripts. ]] --
local g = getgenv()
local excluded = { Lighting = true }
g.Game = cloneref and cloneref(game) or game
g.service_cache = g.service_cache or {}
g.Chat_UI_Table_Stuff = { ["Owner_Chat_Tag"] = "😉🤫😈 | OWNER | ⚔️👑⭐", ["Staff_Chat_Tag"] = "⚔️ | STAFF | ⚔️", ["Wife_Chat_Tag"] = "💘 | WIFEY | 💘", }
g.safewrap = function(name)
    local cache = g.service_cache
    if cache[name] then return cache[name] end
    local ok, svc = pcall(function()
        local s = game:GetService(name)
        return cloneref and cloneref(s) or s
    end)
    if not ok or not svc then return nil end
    if rawset then rawset(cache, name, svc) else cache[name] = svc end
    return svc
end

local function getorset(global, value)
    local v = (rawget and typeof(rawget) == "function" and rawget(g, global)) or g[global]
    if v == nil then
        g[global] = value
        return value
    end
    return v
end

network = nil
HttpService    = getorset("HttpService",    g.safewrap("HttpService"))
Players        = getorset("Players",        g.safewrap("Players"))
RunService     = getorset("RunService",     g.safewrap("RunService"))
LocalPlayer    = getorset("LocalPlayer",    Players.LocalPlayer)
ReplicatedStorage = getorset("ReplicatedStorage", g.safewrap("ReplicatedStorage"))
Workspace      = getorset("Workspace",      g.safewrap("Workspace"))
Modules        = getorset("Modules",        ReplicatedStorage:FindFirstChild("Modules", true))
Core           = getorset("Core", ReplicatedStorage:FindFirstChild("Core", true) or Modules:FindFirstChild("Core", true))
Game_Folder    = getorset("Game_Folder", ReplicatedStorage:FindFirstChild("Game", true) or Modules:FindFirstChild("Game", true))

if not g.LifeTogether_Network_Modules_Already_Loaded_Initialized then
    g.LifeTogether_Network_Modules_Already_Loaded_Initialized = true

    local function load_modules(folder)
        for _, child in ipairs(folder:GetChildren()) do
            if excluded[child.Name] then
                for _, module in ipairs(child:GetChildren()) do
                    if module:IsA("ModuleScript") then
                        local ok, result = pcall(require, module)
                        if ok then getorset(module.Name, result) end
                    end
                end
            elseif child:IsA("ModuleScript") then
                local ok, result = pcall(require, child)
                if ok then getorset(child.Name, result) end
            else
                for _, module in ipairs(child:GetDescendants()) do
                    if module:IsA("ModuleScript") then
                        local ok, result = pcall(require, module)
                        if ok then getorset(module.Name, result) end
                    end
                end
            end
        end
    end


    load_modules(Core)
    load_modules(Game_Folder)
    Network  = getorset("Network", g.Net)
    Char     = getorset("Char",    g.Char)
    UI       = getorset("UI",      g.UI)
    Phone    = getorset("Phone",   g.Phone)
    Messages = getorset("Messages", g.Messages)
end
wait(0.4)
local function shownotification(title, text, method, image)
    if method == "Normal" and not image then
        Phone.show_notification(tostring(title), tostring(text))
    elseif method == "Warning" then
        Phone.show_notification(tostring(title), tostring(text), nil, "rbxassetid://13828984843")
    elseif method == "Error" then
        Phone.show_notification(tostring(title), tostring(text), nil, "rbxassetid://14930908086")
    end
end

getorset("show_notification", shownotification)
getorset("Modules",   Modules)
getorset("Core",      Core)
getorset("Game_Folder", Game_Folder)
getorset("Net",       network)
local function sendfunction(...) Network.get(...) end
local function sendremote(...) Network.send(...) end
getorset("send_remote", sendremote)
getorset("send_function", sendfunction)
getorset("Get", sendfunction)
getorset("Send", sendremote)