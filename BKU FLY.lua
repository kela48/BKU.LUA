local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local v1 = 60

local flyControlGui = Instance.new("ScreenGui")
flyControlGui.Name = "FlyControlGui"
flyControlGui.Parent = coreGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 190)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -95)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = flyControlGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.BorderSizePixel = 0
title.Text = "飞行Ui--由Baloksxin汉化"
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.Font = Enum.Font.Gotham
title.TextSize = 14
title.Parent = mainFrame

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 8)
uiCorner2.Parent = title

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0.9, 0, 0, 30)
toggleButton.Position = UDim2.new(0.05, 0, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "开启飞行"
toggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleButton.Font = Enum.Font.Gotham
toggleButton.TextSize = 12
toggleButton.Parent = mainFrame

local uiCorner3 = Instance.new("UICorner")
uiCorner3.CornerRadius = UDim.new(0, 6)
uiCorner3.Parent = toggleButton

local noclipButton = Instance.new("TextButton")
noclipButton.Name = "NoclipButton"
noclipButton.Size = UDim2.new(0.9, 0, 0, 30)
noclipButton.Position = UDim2.new(0.05, 0, 0, 80)
noclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
noclipButton.BorderSizePixel = 0
noclipButton.Text = "穿墙: 关闭"
noclipButton.TextColor3 = Color3.fromRGB(200, 200, 200)
noclipButton.Font = Enum.Font.Gotham
noclipButton.TextSize = 12
noclipButton.Parent = mainFrame

local uiCorner4 = Instance.new("UICorner")
uiCorner4.CornerRadius = UDim.new(0, 6)
uiCorner4.Parent = noclipButton

local speedSlider = Instance.new("Frame")
speedSlider.Name = "SpeedSlider"
speedSlider.Size = UDim2.new(0.9, 0, 0, 50)
speedSlider.Position = UDim2.new(0.05, 0, 0, 120)
speedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedSlider.BorderSizePixel = 0
speedSlider.Parent = mainFrame

local uiCorner5 = Instance.new("UICorner")
uiCorner5.CornerRadius = UDim.new(0, 6)
uiCorner5.Parent = speedSlider

local speedText = Instance.new("TextLabel")
speedText.Name = "SpeedText"
speedText.Size = UDim2.new(1, 0, 0, 20)
speedText.Position = UDim2.new(0, 0, 0, 0)
speedText.BackgroundTransparency = 1
speedText.Text = "速度: " .. v1
speedText.TextColor3 = Color3.fromRGB(200, 200, 200)
speedText.Font = Enum.Font.Gotham
speedText.TextSize = 12
speedText.Parent = speedSlider

local sliderBar = Instance.new("Frame")
sliderBar.Name = "SliderBar"
sliderBar.Size = UDim2.new(0.9, 0, 0, 6)
sliderBar.Position = UDim2.new(0.05, 0, 0, 25)
sliderBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
sliderBar.BorderSizePixel = 0
sliderBar.Parent = speedSlider

local uiCorner6 = Instance.new("UICorner")
uiCorner6.CornerRadius = UDim.new(0, 3)
uiCorner6.Parent = sliderBar

local sliderFill = Instance.new("Frame")
sliderFill.Name = "SliderFill"
sliderFill.Size = UDim2.new((v1 - 30) / 470, 0, 1, 0)
sliderFill.Position = UDim2.new(0, 0, 0, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = sliderBar

local uiCorner7 = Instance.new("UICorner")
uiCorner7.CornerRadius = UDim.new(0, 3)
uiCorner7.Parent = sliderFill

local sliderButton = Instance.new("TextButton")
sliderButton.Name = "SliderButton"
sliderButton.Size = UDim2.new(0, 20, 0, 20)
sliderButton.Position = UDim2.new((v1 - 30) / 470, -10, 0.5, -10)
sliderButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
sliderButton.BorderSizePixel = 0
sliderButton.Text = ""
sliderButton.Parent = sliderBar

local uiCorner8 = Instance.new("UICorner")
uiCorner8.CornerRadius = UDim.new(0, 10)
uiCorner8.Parent = sliderButton

local v2 = false
local v3 = false
local v4 = {}
local localPlayer = players.LocalPlayer

runService.Stepped:Connect(function()
  if v3 and localPlayer.Character then
    for index, value in ipairs(localPlayer.Character:GetDescendants()) do
      if value:IsA("BasePart") then
        if v4[value] == nil then
          v4[value] = value.CanCollide
        end

        value.CanCollide = false
      end
    end
  end
end)

noclipButton.MouseButton1Click:Connect(function()
  v3 = not v3

  if v3 then
    noclipButton.Text = "穿墙: 开启"
    noclipButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
  else
    noclipButton.Text = "穿墙: 关闭"
    noclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

-- https://discord.gg/AwGHNh7Z7T
    for key, value2 in pairs(v4) do
      if key and key.Parent then
        key.CanCollide = value2
      end
    end

    table.clear(v4)
  end
end)

local connect, f1

local function makeBodyVelocity()
  local currentCamera, v5, velocityHandler, gyroHandler

  if not v2 then
    v2 = true

    toggleButton.Text = "关闭飞行"
    toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

    currentCamera = Workspace.CurrentCamera
    v5 = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))

    velocityHandler = localPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler")
      or Instance.new("BodyVelocity")

    velocityHandler.Name = "VelocityHandler"
    velocityHandler.Parent = localPlayer.Character.HumanoidRootPart
    velocityHandler.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
    velocityHandler.Velocity = Vector3.new(0, 0, 0)

    gyroHandler = localPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler")
      or Instance.new("BodyGyro")

    gyroHandler.Name = "GyroHandler"
    gyroHandler.Parent = localPlayer.Character.HumanoidRootPart
    gyroHandler.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
    gyroHandler.P = 1000
    gyroHandler.D = 50

    localPlayer.Character.Humanoid.PlatformStand = true

    connect = runService.RenderStepped:Connect(function()
      if not v2 or not localPlayer.Character
        or not localPlayer.Character:FindFirstChildOfClass("Humanoid")
        or not localPlayer.Character.Humanoid.RootPart
        or localPlayer.Character.Humanoid.Health <= 0 then
        f1()
        return
      else
        gyroHandler.CFrame = currentCamera.CoordinateFrame
        local getMoveVector = v5:GetMoveVector()
        velocityHandler.Velocity = Vector3.new()

        if getMoveVector.X ~= 0 then
          velocityHandler.Velocity = velocityHandler.Velocity
            + currentCamera.CFrame.RightVector * (getMoveVector.X * v1)
        end

        if getMoveVector.Z ~= 0 then
          velocityHandler.Velocity = velocityHandler.Velocity
            - currentCamera.CFrame.LookVector * (getMoveVector.Z * v1)
        end

        return
      end
    end)
  end
end

function f1()
  if v2 then
    v2 = false

    toggleButton.Text = "开启飞行"
    toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

    if localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
      localPlayer.Character.Humanoid.PlatformStand = false
      local velocityHandler2 = localPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler")

      if velocityHandler2 then
        velocityHandler2:Destroy()
      end

      local gyroHandler2 = localPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler")

      if gyroHandler2 then
        gyroHandler2:Destroy()
      end
    end

    if connect then
      connect:Disconnect()
      connect = nil
    end
  end
end

toggleButton.MouseButton1Click:Connect(function()
  if v2 then
    f1()
  else
    makeBodyVelocity()
  end
end)

local v6 = false

local function f2(input)
  if v6 then
    local absolutePosition = sliderBar.AbsolutePosition
    local absoluteSize = sliderBar.AbsoluteSize

    local position = input.UserInputType == Enum.UserInputType.Touch and input.Position
      or userInputService:GetMouseLocation()

    local v7 = math.clamp((position.X - absolutePosition.X) / absoluteSize.X, 0, 1)
    sliderButton.Position = UDim2.new(v7, -10, 0.5, -10)
    sliderFill.Size = UDim2.new(v7, 0, 1, 0)
    v1 = math.floor(30 + 470 * v7)
    speedText.Text = "速度: " .. v1
  end
end

sliderButton.InputBegan:Connect(function(input2)
  if input2.UserInputType == Enum.UserInputType.Touch
    or input2.UserInputType == Enum.UserInputType.MouseButton1 then
    v6 = true
  end
end)

sliderBar.InputBegan:Connect(function(input3)
  if input3.UserInputType == Enum.UserInputType.Touch then
    v6 = true
    f2(input3)
  end
end)

userInputService.InputEnded:Connect(function(input4)
  if input4.UserInputType == Enum.UserInputType.Touch
    or input4.UserInputType == Enum.UserInputType.MouseButton1 then
    v6 = false
  end
end)

userInputService.InputChanged:Connect(function(input5)
  if v6
    and (input5.UserInputType == Enum.UserInputType.Touch
      or input5.UserInputType == Enum.UserInputType.MouseMovement) then
    f2(input5)
  end
end)
