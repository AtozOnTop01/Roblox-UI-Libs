local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Tool = nil -- Replace with the name of your tool if needed

local mob = workspace:WaitForChild("TargetMob") -- Replace "TargetMob" with the name of the mob in the workspace
local behindOffset = Vector3.new(0, 0, 5) -- Offset to position behind the mob

local function tweenBehindMob(target)
    if target and target:IsA("Model") and target:FindFirstChild("HumanoidRootPart") then
        local targetPos = target.HumanoidRootPart.Position - (target.HumanoidRootPart.CFrame.LookVector * behindOffset.Z)
        local goal = {CFrame = CFrame.new(targetPos)}
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear) -- Adjust tween time and easing style here
        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, goal)
        tween:Play()
        tween.Completed:Wait()
    end
end

local function attack()
    if Tool then
        Tool:Activate() -- Trigger the tool's attack action
    else
        print("No tool equipped!")
    end
end

local function equipTool()
    if not Tool then
        for _, item in pairs(Player.Backpack:GetChildren()) do
            if item:IsA("Tool") then
                Tool = item
                Tool.Parent = Character -- Equip the tool
                break
            end
        end
    end
end

local function startAutoFarm()
    if mob then
        equipTool()
        while mob.Parent and mob.Humanoid.Health > 0 do
            tweenBehindMob(mob)
            attack()
            wait(0.5) -- Adjust attack interval
        end
        print("Mob defeated!")
    else
        print("No mob found!")
    end
end

startAutoFarm()