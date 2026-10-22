local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local getPlatform = userInputService:GetPlatform()

local v1 = getPlatform == Enum.Platform.Windows or getPlatform == Enum.Platform.OSX
  or getPlatform == Enum.Platform.Linux or not userInputService.TouchEnabled

local f1, vector, shiftLockBtn, v2, connect

if v1 then
  warn("仅支持移动端")
  return
else
  vector = Vector3.new(1.7, 0.6, 0)

  if coreGui:FindFirstChild("MobileShiftLockGUI") then
    coreGui.MobileShiftLockGUI:Destroy()
  end

  local mobileShiftLockGUI = Instance.new("ScreenGui")
  mobileShiftLockGUI.Name = "MobileShiftLockGUI"
  mobileShiftLockGUI.Parent = coreGui
  mobileShiftLockGUI.ResetOnSpawn = false

  shiftLockBtn = Instance.new("TextButton")
  shiftLockBtn.Name = "ShiftLockBtn"
  shiftLockBtn.Parent = mobileShiftLockGUI
  shiftLockBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  shiftLockBtn.BackgroundTransparency = 0.4
  shiftLockBtn.Position = UDim2.new(0.85, -30, 0.65, -30)
  shiftLockBtn.Size = UDim2.new(0, 48, 0, 48)
  shiftLockBtn.Text = "🔒"
  shiftLockBtn.TextSize = 22
  shiftLockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
  shiftLockBtn.Active = true
  shiftLockBtn.Draggable = true

  local uiCorner = Instance.new("UICorner")
  uiCorner.CornerRadius = UDim.new(1, 0)
  uiCorner.Parent = shiftLockBtn

  v2 = false

  function f1()
    v2 = not v2
    local character = localPlayer.Character

    if not character then
      return
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if v2 then
      shiftLockBtn.BackgroundTransparency = 0.15

      if humanoid then
        humanoid.AutoRotate = false
      end

      connect = runService.RenderStepped:Connect(function()
        if not character or not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
          v2 = false

          if humanoid then
            humanoid.AutoRotate = true
          end

          if connect then
            connect:Disconnect()
          end

          shiftLockBtn.BackgroundTransparency = 0.4
          return
        else
          local currentCamera = workspace.CurrentCamera

          if not currentCamera then
            return
          else
            local lookVector = currentCamera.CFrame.LookVector
            local unit = Vector3.new(lookVector.X, 0, lookVector.Z).Unit

            if unit.Magnitude > 0 then
              humanoidRootPart.CFrame = CFrame.lookAt(
                humanoidRootPart.Position, humanoidRootPart.Position + unit
              )
            end

            currentCamera.CFrame = currentCamera.CFrame * CFrame.new(vector)
            return
          end
        end
      end)
    else
      shiftLockBtn.BackgroundTransparency = 0.4

      if humanoid then
        humanoid.AutoRotate = true
      end

      if connect then
        connect:Disconnect()
        connect = nil
      end
    end
  end

  connect = nil
  shiftLockBtn.MouseButton1Click:Connect(f1)

  localPlayer.CharacterAdded:Connect(function(character2)
    if v2 then
      f1()
    end
  end)

  return
end
