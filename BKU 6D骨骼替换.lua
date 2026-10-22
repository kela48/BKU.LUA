local coreGui = game:GetService("CoreGui")
local workspaceService = game:GetService("Workspace")
local tweenService = game:GetService("TweenService")

local boneReplacerUI = Instance.new("ScreenGui")
boneReplacerUI.Name = "BoneReplacerUI"
boneReplacerUI.Parent = coreGui

local instance = Instance.new("Frame", boneReplacerUI)
instance.Size = UDim2.new(0, 300, 0, 220)
instance.Position = UDim2.new(0.5, -150, 0.5, -110)
instance.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
instance.BorderSizePixel = 0
instance.Active = true
instance.Draggable = true

Instance.new("UICorner", instance).CornerRadius = UDim.new(0, 12)

local instance2 = Instance.new("UIStroke", instance)
instance2.Color = Color3.fromRGB(60, 60, 60)
instance2.Thickness = 2

local instance3 = Instance.new("TextLabel", instance)
instance3.Text = "骨架替换工具"
instance3.Size = UDim2.new(1, 0, 0, 40)
instance3.Font = Enum.Font.GothamBold
instance3.TextColor3 = Color3.new(1, 1, 1)
instance3.TextSize = 18
instance3.BackgroundTransparency = 1

local instance4 = Instance.new("TextButton", instance)
instance4.Text = "×"
instance4.Size = UDim2.new(0, 30, 0, 30)
instance4.Position = UDim2.new(1, -35, 0, 5)
instance4.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
instance4.TextColor3 = Color3.new(1, 1, 1)
instance4.Font = Enum.Font.GothamBold
instance4.TextSize = 18

Instance.new("UICorner", instance4).CornerRadius = UDim.new(0, 6)

instance4.MouseButton1Click:Connect(function() boneReplacerUI:Destroy() end)

instance4.MouseEnter:Connect(function()
  tweenService:Create(instance4, TweenInfo.new(0.2), {
    BackgroundColor3 = Color3.fromRGB(200, 60, 60),
  }):Play()
end)

instance4.MouseLeave:Connect(function()
  tweenService:Create(instance4, TweenInfo.new(0.2), {
    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
  }):Play()
end)

local function makeTextBox(placeholderText, udim)
  local instance5 = Instance.new("TextBox", instance)
  instance5.Size = UDim2.new(0.8, 0, 0, 35)
  instance5.Position = udim
  instance5.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
  instance5.TextColor3 = Color3.new(1, 1, 1)
  instance5.PlaceholderText = placeholderText
  instance5.Text = ""
  instance5.Font = Enum.Font.Gotham
  instance5.TextSize = 14

  Instance.new("UICorner", instance5).CornerRadius = UDim.new(0, 6)
  Instance.new("UIPadding", instance5).PaddingLeft = UDim.new(0, 10)

  return instance5
end

local v1 = makeTextBox("请输入源模型名称", UDim2.new(0.1, 0, 0.25, 0))
local v2 = makeTextBox("请输入目标模型名称", UDim2.new(0.1, 0, 0.45, 0))

local instance6 = Instance.new("TextButton", instance)
instance6.Text = "执行替换"
instance6.Size = UDim2.new(0.8, 0, 0, 40)
instance6.Position = UDim2.new(0.1, 0, 0.7, 0)
instance6.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
instance6.TextColor3 = Color3.new(1, 1, 1)
instance6.Font = Enum.Font.GothamBold
instance6.TextSize = 14

Instance.new("UICorner", instance6).CornerRadius = UDim.new(0, 6)

instance6.MouseEnter:Connect(function()
  tweenService:Create(instance6, TweenInfo.new(0.2), {
    BackgroundColor3 = Color3.fromRGB(80, 140, 255),
  }):Play()
end)

local mouseLeave = instance6.MouseLeave

local function f1(armature)
  armature.Archivable = true

  for key, value in pairs(armature:GetDescendants()) do
    value.Archivable = true
  end
end

mouseLeave:Connect(function()
  tweenService:Create(instance6, TweenInfo.new(0.2), {
    BackgroundColor3 = Color3.fromRGB(60, 120, 255),
  }):Play()
end)

local function f2(text)
  for key2, value2 in pairs(workspaceService:GetDescendants()) do
    if value2:IsA("Model") and value2.Name == text then
      return value2
    end
  end
end

local function f3(p1)
  return p1:FindFirstChild("HumanoidRootPart") or p1:FindFirstChild("RootPart")
end

instance6.MouseButton1Click:Connect(function()
  local v3 = f2(v1.Text)
  local v4 = f2(v2.Text)

  if v3 and v4 then
    local v5 = f3(v3)
    local v6 = f3(v4)

    if v5 and v6 then
      local armature2 = v5:FindFirstChild("Armature")

      if armature2 then
        local armature3 = v6:FindFirstChild("Armature")

        if armature3 then
          armature3:Destroy()
        end

        f1(armature2)
        armature2:Clone().Parent = v6
      end
    end
  end
end)
