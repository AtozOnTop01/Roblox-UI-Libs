local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Backpack = Player:WaitForChild("Backpack")

local function getChildrenFromSword(tool)
    if tool and tool:IsA("Tool") then
        print("Children of the tool:", tool.Name)
        for _, child in ipairs(tool:GetChildren()) do
            print("Child:", child.Name, "Class:", child.ClassName)
        end
    else
        print("No valid tool found!")
    end
end

local function findSword()
    for _, item in pairs(Character:GetChildren()) do
        if item:IsA("Tool") and item:FindFirstChild("Handle") then
            return item
        end
    end

    for _, item in pairs(Backpack:GetChildren()) do
        if item:IsA("Tool") and item:FindFirstChild("Handle") then
            return item
        end
    end

    return nil
end

local sword = findSword()
if sword then
    getChildrenFromSword(sword)
else
    print("No sword found in the Character or Backpack!")
end