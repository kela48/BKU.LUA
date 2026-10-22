local workspaceService = game:GetService("Workspace")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local soundService = game:GetService("SoundService")
local starterGui = game:GetService("StarterGui")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

local function f1(title, text, p1)
  starterGui:SetCore("SendNotification", { Title = title, Text = text, Duration = p1 or 3 })
end

for index, value in ipairs(localPlayer:WaitForChild("PlayerGui"):GetChildren()) do
  if value:IsA("ScreenGui") and (value.Name:match("NpcVisualSkin") or value.Name == "BTMUI") then
    value:Destroy()
  end
end

pcall(function()
  for index2, value2 in ipairs(coreGui:GetChildren()) do
    if value2:IsA("ScreenGui")
      and (value2.Name:match("NpcVisualSkin") or value2.Name == "BTMUI") then
      value2:Destroy()
    end
  end
end)

local btmui = Instance.new("ScreenGui")
btmui.Name = "BTMUI"
btmui.ResetOnSpawn = false

pcall(function() btmui.Parent = coreGui end)

if not btmui.Parent then
  btmui.Parent = localPlayer.PlayerGui
end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 365)
frame.Position = UDim2.new(0.05, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = btmui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 5)
uiCorner.Parent = frame

local frame2 = Instance.new("Frame")
frame2.Size = UDim2.new(1, 0, 0, 24)
frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame2.Parent = frame

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 5)
uiCorner2.Parent = frame2

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "BTM UI"
textLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
textLabel.TextSize = 13
textLabel.Font = Enum.Font.SourceSansBold
textLabel.Parent = frame2

local frame3 = Instance.new("Frame")
frame3.Size = UDim2.new(1, -12, 1, -32)
frame3.Position = UDim2.new(0, 6, 0, 28)
frame3.BackgroundTransparency = 1
frame3.Parent = frame

local textLabel2 = Instance.new("TextLabel")
textLabel2.Size = UDim2.new(1, 0, 0, 14)
textLabel2.Position = UDim2.new(0, 0, 0, 0)
textLabel2.BackgroundTransparency = 1
textLabel2.Text = "NPC 名称"
textLabel2.TextColor3 = Color3.fromRGB(160, 160, 180)
textLabel2.TextSize = 11
textLabel2.Font = Enum.Font.SourceSansBold
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.Parent = frame3

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, 0, 0, 22)
textBox.Position = UDim2.new(0, 0, 0, 15)
textBox.PlaceholderText = "输入 NPC 模型名称"
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(240, 240, 240)
textBox.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
textBox.TextSize = 11
textBox.Font = Enum.Font.SourceSans
textBox.Parent = frame3

Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 3)

local textLabel3 = Instance.new("TextLabel")
textLabel3.Size = UDim2.new(0.5, 0, 0, 14)
textLabel3.Position = UDim2.new(0, 0, 0, 41)
textLabel3.BackgroundTransparency = 1
textLabel3.Text = "偏移量"
textLabel3.TextColor3 = Color3.fromRGB(160, 160, 180)
textLabel3.TextSize = 11
textLabel3.Font = Enum.Font.SourceSansBold
textLabel3.TextXAlignment = Enum.TextXAlignment.Left
textLabel3.Parent = frame3

local frame4 = Instance.new("Frame")
frame4.Size = UDim2.new(0.4, 0, 0, 20)
frame4.Position = UDim2.new(0.6, 0, 0, 40)
frame4.BackgroundTransparency = 1
frame4.Parent = frame3

local textLabel4 = Instance.new("TextLabel")
textLabel4.Size = UDim2.new(0.4, 0, 1, 0)
textLabel4.BackgroundTransparency = 1
textLabel4.Text = "步长"
textLabel4.TextColor3 = Color3.fromRGB(140, 140, 160)
textLabel4.TextSize = 10
textLabel4.Font = Enum.Font.SourceSans
textLabel4.TextXAlignment = Enum.TextXAlignment.Right
textLabel4.Parent = frame4

local textBox2 = Instance.new("TextBox")
textBox2.Size = UDim2.new(0.55, 0, 1, 0)
textBox2.Position = UDim2.new(0.45, 0, 0, 0)
textBox2.Text = "0.5"
textBox2.TextColor3 = Color3.fromRGB(240, 240, 240)
textBox2.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
textBox2.TextSize = 11
textBox2.Font = Enum.Font.SourceSans
textBox2.Parent = frame4

Instance.new("UICorner", textBox2).CornerRadius = UDim.new(0, 3)
local v1 = 0.5

textBox2.FocusLost:Connect(function()
  local v2 = tonumber(textBox2.Text)

  if v2 and v2 > 0 then
    v1 = v2
  else
    textBox2.Text = tostring(v1)
  end
end)

local function makeTextButton(p2, text2, fn)
  local frame5 = Instance.new("Frame")
  frame5.Size = UDim2.new(1, 0, 0, 20)
  frame5.Position = UDim2.new(0, 0, 0, p2)
  frame5.BackgroundTransparency = 1
  frame5.Parent = frame3

  local textLabel5 = Instance.new("TextLabel")
  textLabel5.Size = UDim2.new(0.12, 0, 1, 0)
  textLabel5.BackgroundTransparency = 1
  textLabel5.Text = text2
  textLabel5.TextColor3 = Color3.fromRGB(180, 180, 200)
  textLabel5.TextSize = 11
  textLabel5.Font = Enum.Font.SourceSansBold
  textLabel5.TextXAlignment = Enum.TextXAlignment.Left
  textLabel5.Parent = frame5

  local textLabel6 = Instance.new("TextLabel")
  textLabel6.Size = UDim2.new(0.18, 0, 1, 0)
  textLabel6.Position = UDim2.new(0.14, 0, 0, 0)
  textLabel6.BackgroundTransparency = 1
  textLabel6.Text = "0.00"
  textLabel6.TextColor3 = Color3.fromRGB(80, 180, 240)
  textLabel6.TextSize = 11
  textLabel6.Font = Enum.Font.SourceSansBold
  textLabel6.TextXAlignment = Enum.TextXAlignment.Left
  textLabel6.Parent = frame5

  local textButton = Instance.new("TextButton")
  textButton.Size = UDim2.new(0.1, 0, 1, 0)
  textButton.Position = UDim2.new(0.38, 0, 0, 0)
  textButton.Text = "<"
  textButton.TextColor3 = Color3.fromRGB(240, 240, 240)
  textButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
  textButton.TextSize = 11
  textButton.Font = Enum.Font.SourceSansBold
  textButton.Parent = frame5

  Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 3)

  local textButton2 = Instance.new("TextButton")
  textButton2.Size = UDim2.new(0.1, 0, 1, 0)
  textButton2.Position = UDim2.new(0.5, 0, 0, 0)
  textButton2.Text = ">"
  textButton2.TextColor3 = Color3.fromRGB(240, 240, 240)
  textButton2.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
  textButton2.TextSize = 11
  textButton2.Font = Enum.Font.SourceSansBold
  textButton2.Parent = frame5

  Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 3)
  local v3 = 0

  local function f2(p3)
    v3 = p3
    textLabel6.Text = string.format("%.2f", v3)
    fn(v3)
  end

  textButton.MouseButton1Click:Connect(function() f2(v3 - v1) end)
  textButton2.MouseButton1Click:Connect(function() f2(v3 + v1) end)
  return { Reset = function() f2(0) end }
end

local v4 = 0
local v5 = 0
local v6 = 0
local v7 = makeTextButton(62, "X", function(p4) v4 = p4 end)
local v8 = makeTextButton(84, "Y", function(p5) v5 = p5 end)
local v9 = makeTextButton(106, "Z", function(p6) v6 = p6 end)

local textLabel7 = Instance.new("TextLabel")
textLabel7.Size = UDim2.new(1, 0, 0, 14)
textLabel7.Position = UDim2.new(0, 0, 0, 130)
textLabel7.BackgroundTransparency = 1
textLabel7.Text = "音频列表"
textLabel7.TextColor3 = Color3.fromRGB(160, 160, 180)
textLabel7.TextSize = 11
textLabel7.Font = Enum.Font.SourceSansBold
textLabel7.TextXAlignment = Enum.TextXAlignment.Left
textLabel7.Parent = frame3

local frame6 = Instance.new("Frame")
frame6.Size = UDim2.new(1, 0, 0, 100)
frame6.Position = UDim2.new(0, 0, 0, 146)
frame6.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
frame6.Parent = frame3

Instance.new("UICorner", frame6).CornerRadius = UDim.new(0, 3)

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, -4, 1, -4)
scrollingFrame.Position = UDim2.new(0, 2, 0, 2)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.ScrollBarThickness = 3
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollingFrame.Parent = frame6

local frame7 = Instance.new("Frame")
frame7.Size = UDim2.new(1, 0, 0, 24)
frame7.Position = UDim2.new(0, 0, 0, 250)
frame7.BackgroundTransparency = 1
frame7.Parent = frame3

local textButton3 = Instance.new("TextButton")
textButton3.Size = UDim2.new(0.48, 0, 1, 0)
textButton3.Position = UDim2.new(0, 0, 0, 0)
textButton3.Text = "播放选中"
textButton3.TextColor3 = Color3.fromRGB(240, 240, 240)
textButton3.BackgroundColor3 = Color3.fromRGB(0, 160, 110)
textButton3.TextSize = 11
textButton3.Font = Enum.Font.SourceSansBold
textButton3.Parent = frame7

Instance.new("UICorner", textButton3).CornerRadius = UDim.new(0, 3)

local textButton4 = Instance.new("TextButton")
textButton4.Size = UDim2.new(0.48, 0, 1, 0)
textButton4.Position = UDim2.new(0.52, 0, 0, 0)
textButton4.Text = "停止全部"
textButton4.TextColor3 = Color3.fromRGB(240, 240, 240)
textButton4.BackgroundColor3 = Color3.fromRGB(160, 50, 50)
textButton4.TextSize = 11
textButton4.Font = Enum.Font.SourceSansBold
textButton4.Parent = frame7

Instance.new("UICorner", textButton4).CornerRadius = UDim.new(0, 3)

local frame8 = Instance.new("Frame")
frame8.Size = UDim2.new(1, 0, 0, 28)
frame8.Position = UDim2.new(0, 0, 0, 278)
frame8.BackgroundTransparency = 1
frame8.Parent = frame3

local textButton5 = Instance.new("TextButton")
textButton5.Size = UDim2.new(0.68, 0, 1, 0)
textButton5.Position = UDim2.new(0, 0, 0, 0)
textButton5.Text = "应用"
textButton5.TextColor3 = Color3.fromRGB(240, 240, 240)
textButton5.BackgroundColor3 = Color3.fromRGB(0, 160, 110)
textButton5.TextSize = 11
textButton5.Font = Enum.Font.SourceSansBold
textButton5.Parent = frame8

Instance.new("UICorner", textButton5).CornerRadius = UDim.new(0, 3)

local textButton6 = Instance.new("TextButton")
textButton6.Size = UDim2.new(0.28, 0, 1, 0)
textButton6.Position = UDim2.new(0.72, 0, 0, 0)
textButton6.Text = "重置"
textButton6.TextColor3 = Color3.fromRGB(240, 240, 240)
textButton6.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
textButton6.TextSize = 11
textButton6.Font = Enum.Font.SourceSansBold
textButton6.Parent = frame8

Instance.new("UICorner", textButton6).CornerRadius = UDim.new(0, 3)

textButton6.MouseButton1Click:Connect(function()
  v7.Reset()
  v8.Reset()
  v9.Reset()
end)

local v10 = {}
local v11 = {}
local v12 = {}

local function f3()
  for index3, value3 in ipairs(v12) do
  end

  v12 = {}
end

local function makeTextButton2(p7)
  v10 = {}
  v11 = {}

  for index4, value4 in ipairs(scrollingFrame:GetChildren()) do
    if value4:IsA("TextButton") then
      value4:Destroy()
    end
  end

  if not p7 then
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    return
  else
    local v13 = 1

    for index5, value5 in ipairs(p7:GetDescendants()) do
      if value5:IsA("Sound") then
        local name = value5.Name ~= "" and value5.Name or "未命名音频 #" .. v13

        table.insert(v10, {
          Name = name,
          Sound = value5,
          Index = v13,
          Selected = false,
        })

        v13 = v13 + 1
      end
    end

    if #v10 == 0 then
      local textLabel8 = Instance.new("TextLabel")
      textLabel8.Size = UDim2.new(1, 0, 1, 0)
      textLabel8.BackgroundTransparency = 1
      textLabel8.Text = "此 NPC 没有音频文件"
      textLabel8.TextColor3 = Color3.fromRGB(140, 140, 160)
      textLabel8.TextSize = 11
      textLabel8.Font = Enum.Font.SourceSans
      textLabel8.Parent = scrollingFrame

      scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
      return
    else
      local total = 0

      for index6, value6 in ipairs(v10) do
        local v14 = value6

        local textButton7 = Instance.new("TextButton")
        textButton7.Size = UDim2.new(1, 0, 0, 22)
        textButton7.Position = UDim2.new(0, 0, 0, total)
        textButton7.Text = "[ ] " .. v14.Name
        textButton7.TextColor3 = Color3.fromRGB(200, 200, 220)
        textButton7.BackgroundColor3 = Color3.fromRGB(42, 42, 52)
        textButton7.TextSize = 11
        textButton7.Font = Enum.Font.SourceSans
        textButton7.TextXAlignment = Enum.TextXAlignment.Left
        textButton7.TextTruncate = Enum.TextTruncate.AtEnd
        textButton7.Parent = scrollingFrame

        Instance.new("UICorner", textButton7).CornerRadius = UDim.new(0, 3)

        textButton7.MouseEnter:Connect(function()
          if not v14.Selected then
            textButton7.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
          end
        end)

        textButton7.MouseLeave:Connect(function()
          if not v14.Selected then
            textButton7.BackgroundColor3 = Color3.fromRGB(42, 42, 52)
          end
        end)

        textButton7.MouseButton1Click:Connect(function()
          v14.Selected = not v14.Selected

          if v14.Selected then
            textButton7.Text = "[X] " .. v14.Name
            textButton7.BackgroundColor3 = Color3.fromRGB(0, 100, 170)
            table.insert(v11, v14)
          else
            textButton7.Text = "[ ] " .. v14.Name
            textButton7.BackgroundColor3 = Color3.fromRGB(42, 42, 52)

            for i = #v11, 1, -1 do
              if v11[i] == v14 then
                table.remove(v11, i)
              end
            end
          end

          if #v11 > 0 then
            textButton3.Text = "播放选中 (" .. #v11 .. ")"
          else
            textButton3.Text = "播放选中"
          end
        end)

        total = total + 24
      end

      scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, total + 2)
      textButton3.Text = "播放选中"
      return
    end
  end
end

textButton3.MouseButton1Click:Connect(function()
  f3()

  if #v11 == 0 then
    f1("音频选择", "请先选择音频", 2)
    return
  end

  f1("音频播放", "播放 " .. #v11 .. " 个音频", 2)

  for index7, value7 in ipairs(v11) do
    if value7 and value7.Sound then
      local clone = value7.Sound:Clone()
      clone.Parent = soundService
      clone.Volume = value7.Sound.Volume or 0.5
      clone.Looped = true

      pcall(function() clone:Play() end)
      table.insert(v12, clone)

      clone.Ended:Connect(function()
        if clone and clone.Parent then
          pcall(function() clone:Play() end)
        end
      end)
    end
  end
end)

textButton4.MouseButton1Click:Connect(f3)
local v15, connect

local function makeAnimator(text3)
  local character = localPlayer.Character

  if not character or not character:FindFirstChild("HumanoidRootPart") then
    f1("失败", "玩家角色未就绪", 2)
    return
  end

  local v16 = nil

  for index8, value8 in ipairs(workspaceService:GetDescendants()) do
    if value8:IsA("Model") and value8.Name == text3 then
      if value8:FindFirstChildOfClass("Humanoid") then
        v16 = value8
        break
      end
    end
  end

  if not v16 then
    f1("失败", "未找到 NPC: " .. text3, 3)
    return
  end

  if v15 then
    v15:Destroy()
    v15 = nil
  end

  if connect then
    connect:Disconnect()
    connect = nil
  end

  f3()
  v16.Archivable = true

  for index9, value9 in ipairs(v16:GetDescendants()) do
    local v17 = value9
    pcall(function() v17.Archivable = true end)
  end

  local clone2 = v16:Clone()
  local animator

  if not clone2 then
    f1("失败", "克隆 NPC 失败", 2)
    return
  else
    clone2.Name = "VisualSkin_" .. localPlayer.Name

    local humanoidRootPart = clone2:FindFirstChild("HumanoidRootPart")
      or clone2:FindFirstChild("Head") or clone2:FindFirstChildWhichIsA("BasePart")

    if not humanoidRootPart then
      clone2:Destroy()
      f1("失败", "NPC 缺少基础部件", 2)
      return
    else
      clone2.PrimaryPart = humanoidRootPart

      for index10, value10 in ipairs(clone2:GetDescendants()) do
        if value10:IsA("BasePart") then
          value10.Anchored = false
          value10.CanCollide = false
        end
      end

      local humanoid = clone2:FindFirstChildOfClass("Humanoid")

      if humanoid then
        animator = humanoid:FindFirstChildOfClass("Animator")

        if not animator then
          animator = Instance.new("Animator", humanoid)
        end

        task.spawn(function()
          task.wait(0.1)

          for index11, value11 in ipairs(v16:GetDescendants()) do
            local v18 = value11

            if v18:IsA("Animation") then
              pcall(function()
                local loadAnimation = animator:LoadAnimation(v18)
                loadAnimation.Looped = true
                loadAnimation:Play()
              end)
            end
          end
        end)
      end

      clone2.Parent = workspaceService
      v15 = clone2

      task.spawn(function()
        task.wait(0.3)
        makeTextButton2(v16)

        if #v10 > 0 then
          f1("音频列表", "找到 " .. #v10 .. " 个音频", 3)
        end
      end)

      for index12, value12 in ipairs(character:GetDescendants()) do
        if value12:IsA("BasePart") or value12:IsA("Decal") then
          value12.Transparency = 1
        elseif value12:IsA("Accessory") then
          local handle = value12:FindFirstChild("Handle")

          if handle then
            handle.Transparency = 1
          end
        end
      end

      connect = runService.RenderStepped:Connect(function()
        if not character or not character.Parent or not clone2.Parent then
          if connect then
            connect:Disconnect()
          end

          return
        else
          local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart2 and clone2.PrimaryPart then
            local cframe = CFrame.new(v4, v5, v6)
            clone2:SetPrimaryPartCFrame(humanoidRootPart2.CFrame * cframe)
          end

          return
        end
      end)

      localPlayer.CharacterAdded:Once(function()
        if v15 then
          v15:Destroy()
          v15 = nil
        end

        if connect then
          connect:Disconnect()
          connect = nil
        end

        f3()
      end)

      f1("成功", "已应用 " .. text3, 2)
      return
    end
  end
end

textButton5.MouseButton1Click:Connect(function()
  local text4 = textBox.Text

  if text4 ~= "" then
    pcall(function() makeAnimator(text4) end)
  else
    f1("输入错误", "请输入 NPC 名称", 2)
  end
end)
