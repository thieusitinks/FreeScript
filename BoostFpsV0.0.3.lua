-- # Fps Boost Script V0.0.3 ( Configurable )
-- Using This Script For Showcasing Auto Bounty Script !!!!! 

--[[

Config :

getgenv().PlayerList = true 
getgenv().DeleteMap = true   
getgenv().DeleteAllGui = false  
loadstring(game:HttpGet(""))()

]]

-- Function to disable the player list ( Leaderboard )
local function disablePlayerList()
    if getgenv().PlayerList then
        pcall(function()
            local playerList = game:GetService("CoreGui"):WaitForChild("PlayerList")
            if playerList then
                playerList.Enabled = false
                print("Laderboard disabled.")
            end
        end)
    end
end

-- Function to delete the map 
local function deleteMap()
    if getgenv().DeleteMap then
        -- Hide all current descendants in the workspace
        for _, v in ipairs(workspace:GetDescendants()) do
            pcall(function()
                if v:IsA("BasePart") or v:IsA("Decal") then  
                    v.Transparency = 1
                end
            end)
        end

        -- Hide all instances in nil (removed objects that can be referenced)
        for _, v in ipairs(getnilinstances()) do
            pcall(function()
                if v:IsA("BasePart") or v:IsA("Decal") then  
                    v.Transparency = 1
                end

                -- Hide descendants of the nil instances
                for _, v1 in ipairs(v:GetDescendants()) do
                    pcall(function()
                        if v1:IsA("BasePart") or v1:IsA("Decal") then  
                            v1.Transparency = 1
                        end
                    end)
                end
            end)
        end

        -- Automatically hide any newly added descendants in the workspace
        workspace.DescendantAdded:Connect(function(v)
            pcall(function()
                if v:IsA("BasePart") or v:IsA("Decal") then  
                    v.Transparency = 1
                end
            end)
        end)

        print("Map deleted")
    end
end

-- Function to remove leaderboard and other GUIs
local function removeAllGui()
    if getgenv().DeleteAllGui then
        local function removeLeaderboard()
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            local playerGui = player:WaitForChild("PlayerGui")

            for _, gui in pairs(playerGui:GetChildren()) do
                -- Check if it's a ScreenGui and contains specific elements related to the leaderboard
                if gui:IsA("ScreenGui") then
                    -- Check the children of the ScreenGui for specific leaderboard characteristics
                    -- You can modify this condition depending on what you find in the GUI tree
                    for _, element in pairs(gui:GetDescendants()) do
                        if element:IsA("TextLabel") and (string.find(element.Text, "Bounty") or string.find(element.Text, "Honor")) then
                            gui:Destroy()
                            print("Leaderboard GUI found and removed.")
                            return
                        end
                    end
                end
            end
        end

        -- Call the function to remove the leaderboard repeatedly
        while true do
            pcall(function()
                removeLeaderboard()
            end)
            wait(1)
        end
    end
end

disablePlayerList()
deleteMap()
removeAllGui()
