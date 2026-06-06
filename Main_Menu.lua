if not game:IsLoaded() then game.Loaded:Wait() end
local g = getgenv()
g.Game = cloneref and cloneref(game) or game
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Notify_Lib.lua"))()
wait(0.2)
g.notify = g.notify or function(notif_type, msg, duration) NotifyLib:External_Notification(tostring(notif_type), tostring(msg), tonumber(duration)) end
local TeleportService = g.TeleportService or cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
local Players = g.Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local LocalPlayer = g.LocalPlayer or Players.LocalPlayer or game.Players.LocalPlayer
local base_url = "https://raw.githubusercontent.com/EnterpriseExperience/Flames_Hub_Games/refs/heads/main/Experiences/"
local scriptstoload = {
    ["Tower Of Misery"] = {
        id = 4954752502,
        link = base_url .. "4954752502.lua"
    },
    ["Ultimate Driving"] = {
        id = 54865335,
        link = base_url .. "54865335.lua"
    },
    ["Life Together RP"] = {
        id = {13967668166, 99644611200703, 99154507657228},
        link = base_url .. "13967668166.lua"
    },
    ["Hide And Seek Extreme"] = {
        id = 205224386,
        link = base_url .. "205224386.lua"
    },
    ["Apartment Hangout Spot"] = {
        id = 108873247414429,
        link = base_url .. "108873247414429.lua"
    },
    ["The Lanes"] = {
        id = 1333478699,
        link = base_url .. "1333478699.lua"
    },
    ["Player or AI"] = {
        id = 95217169945642,
        link = base_url .. "95217169945642.lua"
    },
    ["Main Street RP"] = {
        id = 18753889337,
        link = base_url .. "18753889337.lua"
    },
    ["Southwest Florida Beta"] = {
        id = 5104202731,
        link = base_url .. "5104202731.lua"
    },
    ["Driving Empire"] = {
        id = 3351674303,
        link = base_url .. "3351674303.lua"
    },
    ["Berry Avenue RP"] = {
        id = 8481844229,
        link = base_url .. "8481844229.lua"
    },
    ["Mega Fun Obby"] = {
        id = 12996397,
        link = base_url .. "12996397.lua"
    },
    ["Catalog Avatar Creator"] = {
        id = 7041939546,
        link = base_url .. "7041939546.lua"
    },
    ["Tower Of Hell"] = {
        id = 1962086868,
        link = base_url .. "1962086868.lua"
    },
    ["Car Driving Ultimate"] = {
        id = 11145865512,
        link = base_url .. "11145865512.lua"
    },
    ["Southern Mudding"] = {
        id = 79480724066456,
        link = base_url .. "79480724066456.lua"
    },
    ["Car Zone"] = {
        id = 80200604311136,
        link = base_url .. "80200604311136.lua"
    }
}

local function matcheswhat(tpplaces, togo)
    if typeof(tpplaces) == "number" then
        return tpplaces == togo
    elseif typeof(tpplaces) == "table" then
        for _, id in ipairs(tpplaces) do
            if id == togo then return true end
        end
    end
    return false
end

local function load_str(url) if not url or typeof(url) ~= "string" then return end loadstring(game:HttpGet(url))() end
local function get_place_name(place_id)
    if not place_id then return end
    local id = type(place_id) == "table" and place_id[1] or place_id
    local ok, info = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(id)
    end)
    if ok and info then return info.Name end
end

local flames_ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Luna_UI.lua"))()
local Window = flames_ui:CreateWindow({
    Name = "Flames Hub | Loader",
    Subtitle = "Welcome to: Flames Hub | Game Loader.",
    LogoID = "0",
    LoadingEnabled = true,
    LoadingTitle = "Flames Hub | Presents",
    LoadingSubtitle = "by Flames Hub.",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "FlamesHub_Main_Menu_Configuration"
    },
    KeySystem = false,
    KeySettings = {
        Title = "Flames Hub | Key System",
        Subtitle = "",
        Note = "Welcome to Flames Hub | Game Loader!",
        SaveInRoot = false,
        SaveKey = true,
        Key = {"Example Key"},
        SecondAction = {
            Enabled = false,
            Type = "Link",
            Parameter = ""
        }
    }
})

wait(0.1)
g.Buttons = g.Buttons or {}
local Tab1 = Window:CreateTab({Name = "🏡 Home 🏡", Icon = "view_in_ar", ImageSource = "Material", ShowTitle = true})
local Section1 = Tab1:CreateSection("Section | Home Page")
local Tab2 = Window:CreateTab({Name = "🎮 Game TPs 🎮", Icon = "view_in_ar", ImageSource = "Material", ShowTitle = true})
local Section2 = Tab2:CreateSection("Section | Game TPs Page")
local Tab3 = Window:CreateTab({Name = "⭐ Extras ⭐", Icon = "view_in_ar", ImageSource = "Material", ShowTitle = true})
local Section3 = Tab3:CreateSection("Section | Extras Page")
local function destroy_current_ui() if not flames_ui then return end flames_ui:Destroy() end
local function get_nameless_admin_loaded()
    local registry = getreg and getreg() or getgenv()
    local na_env = registry
        and registry["__nameless_admin_private"]
        and registry["__nameless_admin_private"]["testing"]

    if na_env and (na_env.ltseverydayyou_NA or na_env.NA_LOADED) then
        return true
    end

    return false
end
wait(0.2)
Tab3:CreateButton({
Name = "Flames Hub (Universal)",
Description = "Loads the universal version of Flames Hub.",
Callback = function()
    destroy_current_ui()
    task.wait(0.5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/retrieve_branch_version.lua"))()
end,})

Tab3:CreateButton({
Name = "Free Emotes GUI",
Description = "Loads the Flames Hub | Free Emotes GUI script.",
Callback = function()
    if getgenv().FreeEmotes_Enabled then
		return 
	end

	getgenv().FreeEmotes_Enabled = true
	if not UserInputService.TouchEnabled then
		getgenv().notify("Success", "Press F to toggle.", 1)
	else
		getgenv().notify("Success", "Toggle with the 'F' button on the left side of your screen.", 3)
	end
	loadstring(game:HttpGet("https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Emotes_Backup.lua"))()
end})

Tab3:CreateButton({
Name = "Condo Games Destroyer",
Description = "Loads the Condo Games Destroyer script.",
Callback = function()
    destroy_current_ui()
    task.wait(0.5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/CondoGamesRuiner.lua"))()
end,})

Tab3:CreateButton({
Name = "Infinite Yield FE",
Description = "Loads Infinite Yield FE (normal version).",
Callback = function()
    if getgenv().IY_LOADED then return end
    if getgenv().GET_LOADED_IY then return end
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end,})

Tab3:CreateButton({
Name = "Infinite Premium FE",
Description = "Loads Infinite Premium FE (my version).",
Callback = function()
    if getgenv().IY_LOADED then return end
    if getgenv().GET_LOADED_IY then return end
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua"))()
end,})

Tab3:CreateButton({
Name = "Nameless Admin FE",
Description = "Loads Nameless Admin FE.",
Callback = function()
    local get_loaded = get_nameless_admin_loaded()
    if get_loaded then return end
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
end})

local Excluded_IDs = {99644611200703, 99154507657228}
local function is_excluded(id)
    local check = type(id) == "table" and id[1] or id
    for _, v in ipairs(Excluded_IDs) do
        if check == v then return true end
    end
    return false
end

for name, dude in pairs(scriptstoload) do
    if is_excluded(dude.id) then continue end
    local strname = name:gsub("%W", "_")
    local id_display = typeof(dude.id) == "table" and tostring(dude.id[1]) or tostring(dude.id)
    local id_for_name = typeof(dude.id) == "table" and dude.id[1] or dude.id
    local name_of_game_proper = get_place_name(id_for_name)

    g.Buttons[strname] = Tab1:CreateButton({
    Name = name,
    Description = "Runs the " .. name .. " script. Place ID: " .. id_display,
    Callback = function()
        if not dude.id or not dude.link then return end
        if not matcheswhat(dude.id, game.PlaceId) then
            local name_of_game_proper = get_place_name(id_for_name)
            g.notify("Error", "You are not in: "..tostring(name_of_game_proper).."!", 10)
            return
        end

        destroy_current_ui()
        task.wait(0.5)
        load_str(dude.link)
    end,})
end

for name, schnawg in pairs(scriptstoload) do
    if is_excluded(schnawg.id) then continue end
    local id_display = typeof(schnawg.id) == "table" and tostring(schnawg.id[1]) or tostring(schnawg.id)
    g.Buttons[name] = Tab2:CreateButton({
    Name = "Teleport To Game: "..tostring(name),
    Description = "Teleports you to "..tostring(name)..". Place ID: "..tostring(id_display),
    Callback = function()
        local idkok = type(schnawg.id) == "table" and schnawg.id[1] or schnawg.id
        if not idkok then return end
        if matcheswhat(schnawg.id, game.PlaceId) then
            g.notify("Info", "You are already in: "..tostring(name).. "!", 5)
            return
        end

        TeleportService:Teleport(idkok, LocalPlayer)
    end,})
end
