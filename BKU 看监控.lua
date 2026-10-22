local workspaceService = game:GetService("Workspace")
local coreGui = game:GetService("CoreGui")
local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local currentCamera = workspaceService.CurrentCamera
local v1 = tick()
_G.SecCameraSession = v1
local secCameraSelectorGui = coreGui:FindFirstChild("SecCameraSelectorGui")

if secCameraSelectorGui then
  secCameraSelectorGui:Destroy()
end

local secCameraBlur = lighting:FindFirstChild("SecCameraBlur")

if secCameraBlur then
  secCameraBlur:Destroy()
end

local secCameraBlur2 = Instance.new("BlurEffect")
secCameraBlur2.Name = "SecCameraBlur"
secCameraBlur2.Size = 0
secCameraBlur2.Parent = lighting

local randomColorBlindnessEffect = lighting:FindFirstChild("RandomColorBlindnessEffect")

if not randomColorBlindnessEffect then
  randomColorBlindnessEffect = Instance.new("ColorCorrectionEffect")
  randomColorBlindnessEffect.Name = "RandomColorBlindnessEffect"
  randomColorBlindnessEffect.Enabled = false
  randomColorBlindnessEffect.Parent = lighting
end

local v2 = {}

local function f1()
  v2 = {}

  for index, value in ipairs(workspaceService:GetDescendants()) do
    if value.Name == "Chair" then
      local v3 = false

      for index2, value2 in ipairs(v2) do
        if value2 == value then
          v3 = true
          break
        end
      end

      if not v3 then
        table.insert(v2, value)
      end
    end
  end
end

f1()

local v4 = {}

for index3, value3 in ipairs(workspaceService:GetDescendants()) do
  if value3.Name == "SecCamera" and value3:IsA("BasePart") then
    local v5 = false

    for index4, value4 in ipairs(v4) do
      if value4 == value3 then
        v5 = true
        break
      end
    end

    if not v5 then
      table.insert(v4, value3)
    end
  end
end

local f2, f3, f4, f5, f6, v6, v7, secCameraSelectorGui2, crtOverlay, darknessFrame,
  crackContainer, v8, v9, fatigueGui, leftButton, rightButton, exitButton, v10, v11, v12, v13,
  v14, f7

if #v4 == 0 then
  return
else
  v7 = 1

  secCameraSelectorGui2 = Instance.new("ScreenGui")
  secCameraSelectorGui2.Name = "SecCameraSelectorGui"
  secCameraSelectorGui2.ResetOnSpawn = false
  secCameraSelectorGui2.DisplayOrder = 99999

  pcall(function()
    if syn and syn.protect_gui then
      syn.protect_gui(secCameraSelectorGui2)
    elseif protectgui then
      protectgui(secCameraSelectorGui2)
    end
  end)

  secCameraSelectorGui2.Parent = coreGui

  crtOverlay = Instance.new("Frame")
  crtOverlay.Name = "CRTOverlay"
  crtOverlay.Size = UDim2.new(1, 0, 1, 0)
  crtOverlay.BackgroundTransparency = 1
  crtOverlay.Visible = false
  crtOverlay.ZIndex = 1
  crtOverlay.Parent = secCameraSelectorGui2

  local tint = Instance.new("Frame")
  tint.Name = "Tint"
  tint.Size = UDim2.new(1, 0, 1, 0)
  tint.BackgroundColor3 = Color3.fromRGB(30, 60, 40)
  tint.BackgroundTransparency = 0.85
  tint.BorderSizePixel = 0
  tint.ZIndex = 1
  tint.Parent = crtOverlay

  darknessFrame = Instance.new("Frame")
  darknessFrame.Name = "DarknessFrame"
  darknessFrame.Size = UDim2.new(1, 0, 1, 0)
  darknessFrame.BackgroundColor3 = Color3.new(0, 0, 0)
  darknessFrame.BackgroundTransparency = 1
  darknessFrame.BorderSizePixel = 0
  darknessFrame.ZIndex = 2
  darknessFrame.Parent = crtOverlay

  local scanlines = Instance.new("Frame")
  scanlines.Name = "Scanlines"
  scanlines.Size = UDim2.new(1, 0, 1, 0)
  scanlines.BackgroundTransparency = 1
  scanlines.ZIndex = 3
  scanlines.Parent = crtOverlay

  for i = 0, 100, 3 do
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 1)
    frame.Position = UDim2.new(0, 0, 0, i * 10)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.65
    frame.BorderSizePixel = 0
    frame.Parent = scanlines
  end

  local uiStroke = Instance.new("UIStroke")
  uiStroke.Thickness = 40
  uiStroke.Color = Color3.new(0, 0, 0)
  uiStroke.Parent = crtOverlay

  crackContainer = Instance.new("Folder")
  crackContainer.Name = "CrackContainer"
  crackContainer.Parent = crtOverlay

  local function makeFrame(udim, udim2, rotation)
    local frame2 = Instance.new("Frame")
    frame2.Size = udim2
    frame2.Position = udim
    frame2.Rotation = rotation
    frame2.BackgroundColor3 = Color3.new(0, 0, 0)
    frame2.BorderSizePixel = 0
    frame2.ZIndex = 5
    frame2.Parent = crackContainer

    return frame2
  end

  v8 = {
    makeFrame(UDim2.new(0.5, -50, 0.4, 0), UDim2.new(0, 120, 0, 3), 25),
    makeFrame(UDim2.new(0.45, 0, 0.45, 0), UDim2.new(0, 90, 0, 2), -45),
    makeFrame(UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0, 150, 0, 3), 80),
  }

  v9 = {
    makeFrame(UDim2.new(0.3, 0, 0.2, 0), UDim2.new(0, 180, 0, 2), 15),
    makeFrame(UDim2.new(0.6, 0, 0.3, 0), UDim2.new(0, 140, 0, 3), -60),
    makeFrame(UDim2.new(0.25, 0, 0.6, 0), UDim2.new(0, 200, 0, 2), 40),
    makeFrame(UDim2.new(0.5, 0, 0.7, 0), UDim2.new(0, 160, 0, 3), -20),
  }

  v6 = {
    makeFrame(UDim2.new(0.1, 0, 0.1, 0), UDim2.new(0, 250, 0, 3), 55),
    makeFrame(UDim2.new(0.7, 0, 0.6, 0), UDim2.new(0, 220, 0, 2), -30),
    makeFrame(UDim2.new(0.15, 0, 0.8, 0), UDim2.new(0, 300, 0, 3), -15),
    makeFrame(UDim2.new(0.6, 0, 0.85, 0), UDim2.new(0, 240, 0, 2), 70),
    makeFrame(UDim2.new(0.05, 0, 0.4, 0), UDim2.new(0, 180, 0, 3), 10),
  }

  function f2(p1, visible)
    for index5, value5 in ipairs(p1) do
      value5.Visible = visible
    end
  end

  f2(v8, false)
  f2(v9, false)
  f2(v6, false)

  fatigueGui = Instance.new("Frame")
  fatigueGui.Name = "FatigueGui"
  fatigueGui.Size = UDim2.new(1, 0, 1, 0)
  fatigueGui.BackgroundColor3 = Color3.new(0, 0, 0)
  fatigueGui.BackgroundTransparency = 0
  fatigueGui.Visible = false
  fatigueGui.ZIndex = 100
  fatigueGui.Parent = secCameraSelectorGui2

  local textLabel = Instance.new("TextLabel")
  textLabel.Size = UDim2.new(1, 0, 1, 0)
  textLabel.BackgroundTransparency = 1
  textLabel.Text = "眼部疲劳"
  textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
  textLabel.TextSize = 72
  textLabel.Font = Enum.Font.SourceSansBold
  textLabel.ZIndex = 101
  textLabel.Parent = fatigueGui

  leftButton = Instance.new("TextButton")
  leftButton.Name = "LeftButton"
  leftButton.Size = UDim2.new(0, 160, 0, 75)
  leftButton.Position = UDim2.new(0, 30, 0.8, -35)
  leftButton.Text = "< 上一个相机"
  leftButton.TextSize = 18
  leftButton.TextColor3 = Color3.new(1, 1, 1)
  leftButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
  leftButton.Visible = false
  leftButton.ZIndex = 10
  leftButton.Parent = secCameraSelectorGui2

  local uiCorner = Instance.new("UICorner")
  uiCorner.CornerRadius = UDim.new(0, 12)
  uiCorner.Parent = leftButton

  rightButton = Instance.new("TextButton")
  rightButton.Name = "RightButton"
  rightButton.Size = UDim2.new(0, 160, 0, 75)
  rightButton.Position = UDim2.new(1, -190, 0.8, -35)
  rightButton.Text = "下一个相机 >"
  rightButton.TextSize = 18
  rightButton.TextColor3 = Color3.new(1, 1, 1)
  rightButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
  rightButton.Visible = false
  rightButton.ZIndex = 10
  rightButton.Parent = secCameraSelectorGui2

  local uiCorner2 = Instance.new("UICorner")
  uiCorner2.CornerRadius = UDim.new(0, 12)
  uiCorner2.Parent = rightButton

  exitButton = Instance.new("TextButton")
  exitButton.Name = "ExitButton"
  exitButton.Size = UDim2.new(0, 180, 0, 50)
  exitButton.Position = UDim2.new(0.5, -90, 0.1, 0)
  exitButton.Text = "✕ 退出查看"

  function f3()
    leftButton.Visible = false
    rightButton.Visible = false
    exitButton.Visible = false
    crtOverlay.Visible = false
    fatigueGui.Visible = false
    darknessFrame.BackgroundTransparency = 1

    f2(v8, false)
    f2(v9, false)
    f2(v6, false)
  end

  exitButton.TextSize = 20
  exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
  exitButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
  exitButton.Visible = false
  exitButton.ZIndex = 10
  exitButton.Parent = secCameraSelectorGui2

  local uiCorner3 = Instance.new("UICorner")
  uiCorner3.CornerRadius = UDim.new(0, 12)

  function f4()
    local v15 = v4[v7]

    if not v15 then
      return
    end

    currentCamera.CameraType = Enum.CameraType.Scriptable
    currentCamera.CFrame = v15.CFrame

    rightButton.Text = "相机 [" .. v7 .. "/" .. #v4 .. "] >"
  end

  uiCorner3.Parent = exitButton
  v10 = false
  v11 = true
  v12 = 0

  function f5()
    currentCamera.CameraType = Enum.CameraType.Custom
    local character = localPlayer.Character

    if character then
      currentCamera.CameraSubject = character:FindFirstChildOfClass("Humanoid")
    end
  end

  v13 = 0

  function f6()
    local tool

    if v14 then
      return
    else
      local backpack = localPlayer:FindFirstChildOfClass("Backpack")

      if not backpack then
        return
      end

      v14 = true

      tool = Instance.new("Tool")
      tool.Name = "隐形眼镜"
      tool.ToolTip = "隐形眼镜，但好像有点不适配"
      tool.RequiresHandle = false

      tool.Activated:Connect(function()
        v13 = 1

        if secCameraBlur2 then
          secCameraBlur2.Size = 10
        end

        if randomColorBlindnessEffect then
          randomColorBlindnessEffect.Enabled = true
          local v16 = math.random(1, 4)

          if v16 == 1 then
            randomColorBlindnessEffect.Saturation = -0.35
            randomColorBlindnessEffect.TintColor = Color3.fromRGB(210, 190, 140)
          elseif v16 == 2 then
            randomColorBlindnessEffect.Saturation = -0.35
            randomColorBlindnessEffect.TintColor = Color3.fromRGB(170, 210, 220)
          elseif v16 == 3 then
            randomColorBlindnessEffect.Saturation = -1
            randomColorBlindnessEffect.TintColor = Color3.fromRGB(240, 240, 240)
          else
            randomColorBlindnessEffect.Saturation = -0.6
            randomColorBlindnessEffect.TintColor = Color3.fromRGB(200, 170, 200)
          end
        end

        tool:Destroy()
      end)

      tool.Parent = backpack

      return
    end
  end

  v14 = false

  rightButton.MouseButton1Click:Connect(function()
    if not v10 then
      return
    end

    v7 = v7 + 1

    if v7 > #v4 then
      v7 = 1
    end

    f4()
  end)

  leftButton.MouseButton1Click:Connect(function()
    if not v10 then
      return
    end

    v7 = v7 - 1

    if v7 < 1 then
      v7 = #v4
    end

    f4()
  end)

  exitButton.MouseButton1Click:Connect(function()
    f5()
    f3()
    v10 = false
    v12 = 0
    v11 = false
  end)

  function f7()
    local character2 = localPlayer.Character

    if not character2 or not character2:FindFirstChild("HumanoidRootPart") then
      return false
    end

    if #v2 == 0 then
      f1()
    end

    if #v2 == 0 then
      return false
    else
      local humanoidRootPart = character2.HumanoidRootPart

      local raycastParams = RaycastParams.new()
      raycastParams.FilterDescendantsInstances = v2
      raycastParams.FilterType = Enum.RaycastFilterType.Include
      raycastParams.IgnoreWater = true

      if workspaceService:Raycast(
        humanoidRootPart.Position, Vector3.new(0, -6, 0), raycastParams
      ) then
        return true
      end

      for index6, value6 in ipairs(v2) do
        local v17 = value6
        local position
        pcall(function() position = v17:GetPivot().Position end)

        if not position then
          local primaryPart = v17.PrimaryPart or v17:FindFirstChildWhichIsA("BasePart", true)

          if primaryPart then
            position = primaryPart.Position
          end
        end

        if position then
          local vector = Vector2.new(
            humanoidRootPart.Position.X - position.X, humanoidRootPart.Position.Z - position.Z
          )

          local v18 = humanoidRootPart.Position.Y - position.Y

          if vector.Magnitude <= 4 and v18 >= -2 and v18 <= 6 then
            return true
          end
        end
      end

      return false
    end
  end

  local function f8(character3)
    local waitForChild = character3:WaitForChild("Humanoid", 5)

    if waitForChild then
      waitForChild.Died:Connect(function()
        f5()
        f3()

        if secCameraBlur2 then
          secCameraBlur2.Size = 0
        end

        if randomColorBlindnessEffect then
          randomColorBlindnessEffect.Enabled = false
        end

        local backpack2 = localPlayer:FindFirstChildOfClass("Backpack")
          or character3:FindFirstChildOfClass("Backpack")

        if backpack2 then
          local findFirstChild = backpack2:FindFirstChild("隐形眼镜")

          if findFirstChild then
            findFirstChild:Destroy()
          end
        end

        v10 = false
        v12 = 0
        v13 = 0
        v14 = false
        v11 = true
      end)
    end
  end

  if localPlayer.Character then
    f8(localPlayer.Character)
  end

  localPlayer.CharacterAdded:Connect(f8)

  task.spawn(function()
    while true do
      task.wait(0.2)

      if _G.SecCameraSession ~= v1 then
        break
      else
        local v19 = f7()

        if not v10 then
          if not v19 then
            v11 = true
          elseif v19 and v11 then
            v10 = true
            v12 = 0
            leftButton.Visible = true
            rightButton.Visible = true
            exitButton.Visible = true
            crtOverlay.Visible = true
            darknessFrame.BackgroundTransparency = 1
            f4()
          end
        elseif not crtOverlay.Visible then
          v10 = false
          v12 = 0
        else
          v12 = v12 + 0.2
          darknessFrame.BackgroundTransparency = 1 - math.clamp(v12 / 22, 0, 0.85)

          if v12 >= 6 and v12 < 12 then
            f2(v8, true)
          elseif v12 >= 12 and v12 < 18 then
            f2(v9, true)
          elseif v12 >= 18 then
            f2(v6, true)
          end

          if v12 >= 22 then
            v13 = math.clamp(v13 + 1, 1, 3)
            local character4 = localPlayer.Character

            if character4 then
              local humanoid = character4:FindFirstChildOfClass("Humanoid")

              if humanoid and humanoid.Health > 0 then
                humanoid.Health = math.max(0, humanoid.Health - 25)
              end
            end

            leftButton.Visible = false
            rightButton.Visible = false
            exitButton.Visible = false
            fatigueGui.Visible = true

            if secCameraBlur2 then
              if v13 == 1 then
                secCameraBlur2.Size = 10
              elseif v13 == 2 then
                secCameraBlur2.Size = 20
                f6()
              elseif v13 >= 3 then
                secCameraBlur2.Size = 34
                f6()
              end
            end

            task.wait(2.5)
            f5()
            f3()
            v10 = false
            v12 = 0
            v11 = false
          end
        end
      end
    end
  end)

  return
end
