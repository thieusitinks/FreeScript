-- # Fps Boost Script V0.0.2 ( Delete Map - Gui )

-- Disable the PlayerList GUI if it exists in CoreGui
pcall(function()
    local playerList = game:GetService("CoreGui"):WaitForChild("PlayerList")
    if playerList then
        playerList.Enabled = false
        print("PlayerList disabled.")
    end
end)

-- Hide all current descendants in the workspace
for _, v in ipairs(workspace:GetDescendants()) do
    pcall(function()
        if v:IsA("BasePart") or v:IsA("Decal") then  -- Apply to relevant object types
            v.Transparency = 1
        end
    end)
end

-- Hide all instances in nil (removed objects that can be referenced)
for _, v in ipairs(getnilinstances()) do
    pcall(function()
        if v:IsA("BasePart") or v:IsA("Decal") then  -- Apply to relevant object types
            v.Transparency = 1
        end

        -- Hide descendants of the nil instances
        for _, v1 in ipairs(v:GetDescendants()) do
            pcall(function()
                if v1:IsA("BasePart") or v1:IsA("Decal") then  -- Apply to relevant object types
                    v1.Transparency = 1
                end
            end)
        end
    end)
end

-- Automatically hide any newly added descendants in the workspace
workspace.DescendantAdded:Connect(function(v)
    pcall(function()
        if v:IsA("BasePart") or v:IsA("Decal") then  -- Apply to relevant object types
            v.Transparency = 1
        end
    end)
end)

-- Wait a bit before attempting to remove the leaderboard
wait(1)

-- Function to remove leaderboard-like GUIs
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
