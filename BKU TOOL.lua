local players = game:GetService("Players")
local debris = game:GetService("Debris")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local backpack = localPlayer:WaitForChild("Backpack")

local tool = Instance.new("Tool")
tool.Name = "点击传送"
tool.RequiresHandle = false
tool.CanBeDropped = true
tool.ToolTip = "点击任意地方传送"

tool.Equipped:Connect(function(index)
  index.Icon = "rbxasset://textures/GunCursor.png"

  index.Button1Down:Connect(function()
    if not index.Target then
      return
    else
      local v1 = index.Hit.Position + Vector3.new(0, 5, 0)
      local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart then
        humanoidRootPart.CFrame = CFrame.new(v1)

        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxassetid://243098098"
        particleEmitter.Lifetime = NumberRange.new(1)
        particleEmitter.Speed = NumberRange.new(10)
        particleEmitter.Rate = 100
        particleEmitter.Parent = humanoidRootPart

        debris:AddItem(particleEmitter, 1.5)
      end

      return
    end
  end)
end)

tool.Parent = backpack

wait(0.5)

if character then
  tool.Parent = character
end
