local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local LP = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Window = Rayfield:CreateWindow({
    Name = "Rayfield Example Window",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "Rayfield Interface Suite",
    LoadingSubtitle = "by Sirius",
    Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
 
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Big Hub"
    },
 
    Discord = {
       Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
 
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })


local MainTab = Window:CreateTab("Main", "blinds")
------------CODE--------------
local Murderer, Sherif
local hasGameStarted = false
local Map
local CoinContainer

function getContainer()
    for i,v in pairs(workspace:GetDescendants()) do
        if v.Name == "CoinContainer" then
            CoinContainer = v
            return v
        end
    end
    
end

function getMap()
    for i,v in pairs(workspace:GetDescendants()) do
        if v.Name == "Spawns" and v.Parent ~= "Lobby" then
            Map = v.Parent
            return v.Parent
        end
    end
end

function getMurderer()
    local murd = nil
    for i,v in pairs(game.Workspace:GetDescendants() and game.Players:GetDescendants()) do
        if v:IsA("Tool") and v.Name == 'Knife' then
            if v.Parent.Parent:IsA("Model") then
                murd = v.Parent.Name
            else
                murd = v.Parent.Parent.Name
            end
        end
    end
    return murd
end

function getSherif()
    local Sher = nil
    for i,v in pairs(game.Workspace:GetDescendants() and game.Players:GetDescendants()) do
        if v:IsA("Tool") and v.Name == 'Gun' then
            if v.Parent.Parent:IsA("Model") then
                Sher = v.Parent.Name
            else
                Sher = v.Parent.Parent.Name
            end
        end
    end
    return Sher
end


function checkIfGameStarted()
    if getContainer() then
        hasGameStarted = true
        return true
    else
        hasGameStarted = false
        return false
    end
end

function getUserPFP(player)
    if player and player.UserId then
        local userId = player.UserId
        return userId
    end
end


function sendNotification(title, message, duration, image)
    Rayfield:Notify({
        Title = title,
        Content = message,
        Duration = duration,
        Image = tostring(image),
     })
end


------------------------------

local RolesButton = MainTab:CreateButton({
    Name = "Get Roles",
    Callback = function()
        local gs = checkIfGameStarted()
        if gs then
            local Murderer = getMurderer()
            local Sherif = getSherif()

            local MurdererText = "Murderer: "..(Murderer and tostring(Murderer) or " Not Found")
            local SherifText = "Sheriff: "..(Sherif and tostring(Sherif) or  "Not Found")
            
            sendNotification("Role Found!", MurdererText, 5, "check")
            sendNotification("Role Found!", SherifText, 5, "check")
        else
            sendNotification("Game Not Started!", "Game Not Started!", 5, "x")
        end
    end
})


local isGunDropped = MainTab:CreateButton({
    Name = "Check if Gun Dropped",
    Callback = function()
        local gs = checkIfGameStarted()
        local mapp = getMap()
        if gs then
            local Gun 
            for i,v in pairs(mapp:GetDescendants()) do
                if v.Name == "GunDrop" then
                    Gun = v
                    return Gun
                end
            end

            if Gun then
               
                sendNotification("Gun Dropped!", "Gun Dropped!", 5, "check")
            else
                sendNotification("Gun Dropped!", "Gun Not Dropped!", 5, "x")
           
             end
            else
            sendNotification("Game Not Started!", "Game Not Started!", 5, "x")
        end
    end
})

