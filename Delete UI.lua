-- This script will find and remove any ScreenGui that resembles the leaderboard.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Function to remove leaderboard-like GUIs
local function removeLeaderboard()
    for _, gui in pairs(playerGui:GetChildren()) do
        -- Check if it's a ScreenGui and contains specific elements related to the leaderboard
        if gui:IsA("ScreenGui") then
            -- Check the children of the ScreenGui for specific leaderboard characteristics
            if gui:FindFirstChildOfClass("Frame") or gui:FindFirstChild("Bounty") then
                gui:Destroy()
                print("Found and removed a leaderboard GUI.")
            end
        end
    end
end

-- Call the function to remove the leaderboard on script execution
removeLeaderboard()
