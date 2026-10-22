--by kela_er
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local coreGui = game:GetService("CoreGui")
local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/BK-PE-SCRIPT/refs/heads/main/UI.txt"))()
local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera
local walkSpeed = 16

if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
  walkSpeed = localPlayer.Character.Humanoid.WalkSpeed
end

local v1 = {
  Speed = walkSpeed,
  FOV = currentCamera.FieldOfView,
  SpeedEn = false,
  FOVEn = false,
  InfJump = false,
  Noclip = false,
  FreezeSelf = false,
  AnchorOnly = false,
  NightVis = false,
  InfStamina = false,
  ThirdPerson = false,
  MonkeyESP = false,
  ItemESP = false,
  MonsterWarning = false,
  MuteMonsterSound = false,
  PlayerESP = false,
  ShowNames = false,
  ShowTracers = false,
  PlayerHighlight = false,
  RainbowESP = false,
  ShowDistance = false,
  TracerFromTop = false,
  InstantInteract = false,
  HideBodies = false,
  DisableJumpscareAnim = false,
  ChaseSpeedEn = false,
  EscapeSpeed = 45,
  DeathEffectEn = false,
}

local window = ui:MakeWindow({
  Name = "BKU SCRIPT (Scary Baboon)",
  SubTitle = "By Baloksxin",
  HidePremium = true,
  SaveConfig = false,
  IntroText = "BKU SCRIPT",
})

ui:MakeNotification({
  Name = "BKU SCRIPT",
  Content = "辛巴爸爸卢比呀 (已深度优化流畅度)",
  Time = 3,
})

local v2 = {}

local function f1(p1)
  local playerScripts = localPlayer:FindFirstChild("PlayerScripts")

  if not playerScripts then
    return
  end

  for key, value in pairs(playerScripts:GetDescendants()) do
    if value:IsA("LocalScript") then
      local v3 = string.lower(value.Name)

      if string.find(v3, "play") and string.find(v3, "jumpscareanim") then
        if p1 then
          if value.Disabled == false then
            value.Disabled = true
            v2[value] = true
          end
        elseif v2[value] then
          value.Disabled = false
          v2[value] = nil
        end
      end
    end
  end
end

local v4 = {}

task.spawn(function()
  while true do
    task.wait(0.1)

    for i = #v4, 1, -1 do
      local v5 = v4[i]

      if v5.Part and v5.Part.Parent and v5.Target and v5.Target.Parent then
        if v5.IsBone then
          v5.Part.CFrame = v5.Target.WorldCFrame * v5.Offset
        end
      else
        table.remove(v4, i)
      end
    end
  end
end)

local function makeSpotLight(character)
  local v6

  if not character then
    return
  else
    task.wait(0.5)

    local backpack = localPlayer:FindFirstChildOfClass("Backpack")
      or localPlayer:WaitForChild("Backpack", 2)

    local v7 = false

    if backpack then
      for index, value2 in ipairs(backpack:GetChildren()) do
        if string.find(string.lower(value2.Name), "flashlight") then
          v7 = true
          break
        end
      end
    end

    for index2, value3 in ipairs(character:GetChildren()) do
      if value3:IsA("Tool") and string.find(string.lower(value3.Name), "flashlight") then
        v7 = true
        break
      end
    end

    if not v7 then
      v6 = nil

      for index3, value4 in ipairs(workspace:GetDescendants()) do
        if value4:IsA("Tool") and string.find(string.lower(value4.Name), "flashlight") then
          v6 = value4
          break
        end
      end

      if v6 and backpack then
        pcall(function()
          local v8 = v6
          v8:Clone().Parent = backpack
        end)
      else
        local head = character:FindFirstChild("Head")

        local humanoidRootPart = head
        humanoidRootPart = head or character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart and not humanoidRootPart:FindFirstChild("BKU_AutoLight") then
          local bkuAutoLight = Instance.new("SpotLight")
          bkuAutoLight.Name = "BKU_AutoLight"
          bkuAutoLight.Brightness = 3
          bkuAutoLight.Range = 60
          bkuAutoLight.Angle = 70
          bkuAutoLight.Parent = humanoidRootPart
        end
      end
    end

    return
  end
end

localPlayer.CharacterAdded:Connect(function(character2)
  task.wait(0.5)

  if v1.DisableJumpscareAnim then
    f1(true)
  end

  makeSpotLight(character2)
end)

if localPlayer.Character then
  task.spawn(function() makeSpotLight(localPlayer.Character) end)
end

task.spawn(function()
  local playerScripts2 = localPlayer:FindFirstChild("PlayerScripts")

  if playerScripts2 then
    playerScripts2.DescendantAdded:Connect(function(descendant)
      if v1.DisableJumpscareAnim and descendant:IsA("LocalScript") then
        local v9 = string.lower(descendant.Name)

        if string.find(v9, "play") and string.find(v9, "jumpscareanim") then
          descendant.Disabled = true
          v2[descendant] = true
        end
      end
    end)
  end
end)

local v10 = {
  FOV = currentCamera.FieldOfView,
  Bright = lighting.Brightness,
  FogEnd = lighting.FogEnd,
  FogStart = lighting.FogStart,
  Ambient = lighting.Ambient,
  Clock = lighting.ClockTime,
  Speed = walkSpeed,
}

local v11 = {}
local v12 = {}
local v13 = {}

local bkuPlayerESPGui = Instance.new("ScreenGui")
bkuPlayerESPGui.Name = "BKU_PlayerESP_Gui"
bkuPlayerESPGui.ResetOnSpawn = false
bkuPlayerESPGui.IgnoreGuiInset = true

pcall(function()
  if gethui then
    bkuPlayerESPGui.Parent = gethui()
  elseif syn and syn.protect_gui then
    syn.protect_gui(bkuPlayerESPGui)
    bkuPlayerESPGui.Parent = coreGui
  else
    bkuPlayerESPGui.Parent = coreGui
  end
end)

if not bkuPlayerESPGui.Parent then
  bkuPlayerESPGui.Parent = localPlayer:WaitForChild("PlayerGui")
end

local v14 = {}

local v15 = {
  meatman = true,
  meatmanfast = true,
  white = true,
  blackgoogoo = true,
  biglarry = true,
  scarylarry = true,
  fred = true,
  unknown = true,
  ["3rr0r"] = true,
  ["cave monster"] = true,
  cavemonster = true,
  ["mines monster"] = true,
  minesmonster = true,
  dotman = true,
  ["blue takis"] = true,
  bluetakis = true,
  tweaker = true,
  baboon = true,
}

local function f2(value5)
  if value5 and value5:IsA("Model") and value5:FindFirstChildOfClass("Humanoid") then
    local v16 = string.lower(value5.Name)

    if string.find(v16, "jumpscare") then
      return false
    else
      local v17 = false

      for key2, value6 in pairs(players:GetPlayers()) do
        if value6.Character == value5 then
          v17 = true
          break
        end
      end

      if not v17 then
        if v15[v16] then
          return true
        end

        for key3, value7 in pairs(v15) do
          if string.find(v16, key3) then
            return true
          end
        end

        return false
      end

      return false
    end
  else
    return false
  end
end

local function f3()
  local character3 = localPlayer.Character

  if not character3 then
    return
  else
    local humanoid = character3:FindFirstChildOfClass("Humanoid")
    local v18 = not humanoid
    local humanoidRootPart2 = character3:FindFirstChild("HumanoidRootPart")

    if v18 or not humanoidRootPart2 or humanoid.Health <= 0 then
      return
    else
      local assemblyLinearVelocity = humanoidRootPart2.AssemblyLinearVelocity
      local moveDirection = humanoid.MoveDirection
      local walkSpeed2 = humanoid.WalkSpeed

      if walkSpeed2 <= 0 or walkSpeed2 > 200 then
        return
      end

      if moveDirection.Magnitude < 0.05 then
        if math.abs(assemblyLinearVelocity.X) > 0.01
          or math.abs(assemblyLinearVelocity.Z) > 0.01 then
          humanoidRootPart2.AssemblyLinearVelocity = Vector3.new(0, assemblyLinearVelocity.Y, 0)
        end
      else
        local v19 = moveDirection.Unit * walkSpeed2

        humanoidRootPart2.AssemblyLinearVelocity = Vector3.new(
          v19.X, assemblyLinearVelocity.Y, v19.Z
        )
      end

      return
    end
  end
end

local function f4(value8)
  if not value8 or not value8.Parent then
    return false
  else
    for key4, value9 in pairs(players:GetPlayers()) do
      if value9.Character and value8:IsDescendantOf(value9.Character) then
        return false
      else
        local backpack2 = value9:FindFirstChildOfClass("Backpack")

        if backpack2 and value8:IsDescendantOf(backpack2) then
          return false
        end
      end
    end

    local v20 = string.lower(value8.Name)
    local v21 = string.find(v20, "tracker")

    local v22 = v21 or string.find(v20, "gold") or string.find(v20, "egg")
      or string.find(v20, "cone") or string.find(v20, "key") or string.find(v20, "coin")
      or string.find(v20, "dollar") or string.find(v20, "gem") or string.find(v20, "flashlight")

    if v22 then
      return true
    end

    return false
  end
end

local v23 = false
local connect

local function f5()
  if not v23 then
    return
  end

  if connect then
    connect:Disconnect()
    connect = nil
  end

  v23 = false
end

local function f6()
  if v23 then
    return
  end

  connect = runService.Heartbeat:Connect(f3)
  v23 = true
end

local v24 = {}
local connect2

local function f7(value10)
  v1.InstantInteract = value10

  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  local function f8(key5)
    if not key5:IsA("ProximityPrompt") then
      return
    end

    if value10 then
      if not v24[key5] then
        v24[key5] = key5.HoldDuration
      end

      key5.HoldDuration = 0

      key5:GetPropertyChangedSignal("HoldDuration"):Connect(function()
        if key5.HoldDuration ~= 0 then
          key5.HoldDuration = 0
        end
      end)
    else
      local v25 = v24[key5]

      if v25 ~= nil then
        key5.HoldDuration = v25
        v24[key5] = nil
      end
    end
  end

  for index4, value11 in ipairs(game:GetDescendants()) do
    if value11:IsA("ProximityPrompt") then
      f8(value11)
    end
  end

  if value10 then
    connect2 = game.DescendantAdded:Connect(function(descendant2)
      if descendant2:IsA("ProximityPrompt") then
        f8(descendant2)
      end
    end)
  end
end

local function f9(p2)
  if p2:IsA("Model") and string.lower(p2.Name) == "ragdoll" then
    task.defer(function()
      if p2 and p2.Parent then
        p2.Archivable = true
        p2.Parent = nil
      end
    end)
  end
end

local f10

local function makeTextLabel(value12)
  if not f4(value12) then
    f10(value12)
    return
  end

  if not value12:FindFirstChild("BKU_Item_ESP") then
    local bkuItemESP = Instance.new("Highlight")
    bkuItemESP.Name = "BKU_Item_ESP"
    bkuItemESP.FillColor = Color3.fromRGB(255, 215, 0)
    bkuItemESP.FillTransparency = 0.4
    bkuItemESP.OutlineColor = Color3.fromRGB(255, 255, 255)
    bkuItemESP.OutlineTransparency = 0
    bkuItemESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    bkuItemESP.Parent = value12
  end

  if not value12:FindFirstChild("BKU_Item_Text_ESP") then
    local basePart = value12:IsA("BasePart") and value12
      or value12:IsA("Model")
        and (value12.PrimaryPart or value12:FindFirstChildOfClass("BasePart"))

    if basePart then
      local bkuItemTextESP = Instance.new("BillboardGui")
      bkuItemTextESP.Name = "BKU_Item_Text_ESP"
      bkuItemTextESP.Size = UDim2.new(0, 180, 0, 50)
      bkuItemTextESP.AlwaysOnTop = true
      bkuItemTextESP.ExtentsOffset = Vector3.new(0, 2, 0)
      bkuItemTextESP.Adornee = basePart
      bkuItemTextESP.Parent = value12

      local textLabel = Instance.new("TextLabel")
      textLabel.Size = UDim2.new(1, 0, 1, 0)
      textLabel.BackgroundTransparency = 1
      textLabel.Text = value12.Name
      textLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
      textLabel.TextSize = 14
      textLabel.Font = Enum.Font.SourceSansBold
      textLabel.TextStrokeTransparency = 0
      textLabel.Parent = bkuItemTextESP
    end
  end
end

function f10(p3)
  if p3 then
    local bkuItemESP2 = p3:FindFirstChild("BKU_Item_ESP")

    if bkuItemESP2 then
      bkuItemESP2:Destroy()
    end

    local bkuItemTextESP2 = p3:FindFirstChild("BKU_Item_Text_ESP")

    if bkuItemTextESP2 then
      bkuItemTextESP2:Destroy()
    end
  end
end

local function makeTextLabel2(value13)
  if not value13:FindFirstChild("Monkey_Highlight_ESP") then
    local monkeyHighlightESP = Instance.new("Highlight")
    monkeyHighlightESP.Name = "Monkey_Highlight_ESP"
    monkeyHighlightESP.FillColor = Color3.fromRGB(255, 60, 0)
    monkeyHighlightESP.FillTransparency = 0.5
    monkeyHighlightESP.OutlineColor = Color3.fromRGB(255, 255, 255)
    monkeyHighlightESP.OutlineTransparency = 0
    monkeyHighlightESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    monkeyHighlightESP.Parent = value13
  end

  if not value13:FindFirstChild("Monkey_Text_ESP") then
    local humanoidRootPart3 = value13:FindFirstChild("HumanoidRootPart")
      or value13:FindFirstChild("Head") or value13:FindFirstChildOfClass("BasePart")

    if humanoidRootPart3 then
      local monkeyTextESP = Instance.new("BillboardGui")
      monkeyTextESP.Name = "Monkey_Text_ESP"
      monkeyTextESP.Size = UDim2.new(0, 180, 0, 50)
      monkeyTextESP.AlwaysOnTop = true
      monkeyTextESP.ExtentsOffset = Vector3.new(0, 3.5, 0)
      monkeyTextESP.Adornee = humanoidRootPart3
      monkeyTextESP.Parent = value13

      local textLabel2 = Instance.new("TextLabel")
      textLabel2.Size = UDim2.new(1, 0, 1, 0)
      textLabel2.BackgroundTransparency = 1
      textLabel2.Text = value13.Name
      textLabel2.TextColor3 = Color3.fromRGB(255, 60, 0)
      textLabel2.TextSize = 16
      textLabel2.Font = Enum.Font.SourceSansBold
      textLabel2.TextStrokeTransparency = 0
      textLabel2.Parent = monkeyTextESP
    end
  end
end

local bkuWarningGui = Instance.new("ScreenGui")
bkuWarningGui.Name = "BKU_WarningGui"
bkuWarningGui.ResetOnSpawn = false

pcall(function()
  if gethui then
    bkuWarningGui.Parent = gethui()
  elseif syn and syn.protect_gui then
    syn.protect_gui(bkuWarningGui)
    bkuWarningGui.Parent = coreGui
  else
    bkuWarningGui.Parent = coreGui
  end
end)

if not bkuWarningGui.Parent then
  bkuWarningGui.Parent = localPlayer:WaitForChild("PlayerGui")
end

local textLabel3 = Instance.new("TextLabel")
textLabel3.Size = UDim2.new(0, 500, 0, 40)
textLabel3.Position = UDim2.new(0.5, -250, 0, 80)
textLabel3.BackgroundTransparency = 1
textLabel3.TextColor3 = Color3.fromRGB(255, 30, 30)
textLabel3.TextSize = 22
textLabel3.Font = Enum.Font.SourceSansBold
textLabel3.TextStrokeTransparency = 0
textLabel3.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
textLabel3.Text = ""
textLabel3.Visible = false
textLabel3.Parent = bkuWarningGui

local tab = window:MakeTab({ Name = "信息", Icon = "rbxassetid://77348087165494" })
tab:AddSection({ Name = "信息" })
tab:AddLabel("使用者: " .. localPlayer.DisplayName)
tab:AddLabel("执行器: " .. (identifyexecutor and identifyexecutor() or "未知"))
tab:AddLabel("游戏 ID (PlaceId): " .. tostring(game.PlaceId))
tab:AddLabel("服务器 ID (JobId): " .. (game.JobId ~= "" and game.JobId or "单人/私服"))

tab:AddButton({
  Name = "点击复制服务器 ID",
  Callback = function() setclipboard(game.JobId) end,
})

tab:AddButton({
  Name = "复制作者B站UID",
  Callback = function() setclipboard("UID:3494351988590880") end,
})

local tab2 = window:MakeTab({ Name = "视觉", Icon = "rbxassetid://77348087165494" })
tab2:AddSection({ Name = "玩家Esp" })

tab2:AddToggle({
  Name = "开启 ESP",
  Callback = function(value14)
    v1.PlayerESP = value14

    if not value14 then
      for key6, value15 in pairs(v14) do
        if value15.Line then
          value15.Line.Visible = false
        end

        if value15.Billboard then
          value15.Billboard.Enabled = false
        end
      end

      for key7, value16 in pairs(players:GetPlayers()) do
        if value16.Character and value16.Character:FindFirstChild("PlayerHighlight") then
          value16.Character.PlayerHighlight:Destroy()
        end
      end
    end
  end,
})

tab2:AddToggle({ Name = "显示名字", Callback = function(value17) v1.ShowNames = value17 end })

tab2:AddToggle({
  Name = "显示射线",
  Callback = function(value18) v1.ShowTracers = value18 end,
})

tab2:AddToggle({
  Name = "显示高亮",
  Callback = function(value19) v1.PlayerHighlight = value19 end,
})

tab2:AddSection({ Name = "游戏类Esp" })

tab2:AddToggle({
  Name = "开关怪物Esp",
  Callback = function(value20)
    v1.MonkeyESP = value20

    if value20 then
      for index5, value21 in ipairs(v12) do
        if value21 and value21.Parent and f2(value21) then
          makeTextLabel2(value21)
        end
      end
    else
      for key8, value22 in pairs(workspace:GetDescendants()) do
        if value22.Name == "Monkey_Highlight_ESP" or value22.Name == "Monkey_Text_ESP" then
          value22:Destroy()
        end
      end
    end
  end,
})

tab2:AddToggle({
  Name = "道具Esp(更新正式版后可能有用)",
  Callback = function(value23)
    v1.ItemESP = value23

    if value23 then
      for index6, value24 in ipairs(v13) do
        if value24 and value24.Parent and f4(value24) then
          makeTextLabel(value24)
        end
      end
    else
      for key9, value25 in pairs(workspace:GetDescendants()) do
        if value25.Name == "BKU_Item_ESP" or value25.Name == "BKU_Item_Text_ESP" then
          value25:Destroy()
        end
      end
    end
  end,
})

tab2:AddToggle({
  Name = "怪物预警",
  Callback = function(value26) v1.MonsterWarning = value26 end,
})

tab2:AddToggle({
  Name = "夜视模式",
  Callback = function(value27)
    v1.NightVis = value27

    if not value27 then
      local ambient = v10.Ambient
      local clock = v10.Clock

      lighting.Brightness = v10.Bright
      lighting.Ambient = ambient
      lighting.ClockTime = clock
      lighting.FogEnd = v10.FogEnd or 100000
      lighting.FogStart = v10.FogStart or 0
    end
  end,
})

local connect3

tab2:AddToggle({
  Name = "隐藏尸体",
  Default = false,
  Callback = function(value28)
    v1.HideBodies = value28

    if value28 then
      for index7, value29 in ipairs(workspace:GetDescendants()) do
        f9(value29)
      end

      if not connect3 then
        connect3 = workspace.DescendantAdded:Connect(function(descendant3)
          if v1.HideBodies then
            f9(descendant3)
          end
        end)
      end
    elseif connect3 then
      connect3:Disconnect()
      connect3 = nil
    end
  end,
})

local espTab = window:MakeTab({ Name = "ESP设置", Icon = "rbxassetid://77348087165494" })
espTab:AddSection({ Name = "玩家" })

espTab:AddToggle({
  Name = "玩家彩虹色",
  Callback = function(value30) v1.RainbowESP = value30 end,
})

espTab:AddToggle({
  Name = "玩家显示距离",
  Callback = function(value31) v1.ShowDistance = value31 end,
})

espTab:AddDropdown({
  Name = "玩家射线位置",
  Options = { "从下方", "从上方" },
  Default = "从下方",
  Callback = function(value32) v1.TracerFromTop = value32 == "从上方" end,
})

local tab3 = window:MakeTab({ Name = "玩家", Icon = "rbxassetid://77348087165494" })
tab3:AddSection({ Name = "属性修改" })

tab3:AddSlider({
  Name = "修改速度值",
  Min = 0,
  Max = 500,
  Default = v10.Speed,
  Increment = 1,
  ValueName = "",
  Callback = function(value33)
    v1.Speed = value33

    if v1.SpeedEn and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = value33
    end
  end,
})

tab3:AddToggle({
  Name = "开启速度修改",
  Callback = function(value34)
    v1.SpeedEn = value34

    if not value34 and localPlayer.Character
      and localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = v10.Speed
    elseif value34 and localPlayer.Character
      and localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = v1.Speed
    end
  end,
})

tab3:AddSlider({
  Name = "修改FOV值",
  Min = 1,
  Max = 120,
  Default = v10.FOV,
  Increment = 1,
  ValueName = "",
  Callback = function(value35)
    v1.FOV = value35

    if v1.FOVEn and currentCamera then
      currentCamera.FieldOfView = value35
    end
  end,
})

tab3:AddToggle({
  Name = "开启 FOV 修改",
  Callback = function(value36)
    v1.FOVEn = value36

    if not value36 then
      currentCamera.FieldOfView = v10.FOV
    else
      currentCamera.FieldOfView = v1.FOV
    end
  end,
})

tab3:AddSection({ Name = "其它类" })

tab3:AddToggle({
  Name = "防脚滑",
  Default = false,
  Callback = function(value37)
    if value37 then
      f6()
    else
      f5()
    end
  end,
})

tab3:AddToggle({
  Name = "第三人称",
  Callback = function(value38) v1.ThirdPerson = value38 end,
})

tab3:AddToggle({ Name = "无限跳跃", Callback = function(value39) v1.InfJump = value39 end })

tab3:AddToggle({
  Name = "穿墙模式",
  Callback = function(value40)
    v1.Noclip = value40

    if not value40 then
      for key10, value41 in pairs(v11) do
        if key10 and key10.Parent then
          key10.CanCollide = value41
        end
      end

      table.clear(v11)
    end
  end,
})

tab3:AddSection({ Name = "固定" })

tab3:AddToggle({
  Name = "固定自己",
  Callback = function(value42)
    v1.FreezeSelf = value42

    if localPlayer.Character then
      local humanoidRootPart4 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart4 then
        humanoidRootPart4.Anchored = value42
      end
    end
  end,
})

tab3:AddToggle({
  Name = "固定自己(不固定动画)",
  Callback = function(value43)
    v1.AnchorOnly = value43

    if localPlayer.Character then
      local humanoidRootPart5 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart5 then
        humanoidRootPart5.Anchored = value43
      end
    end
  end,
})

tab3:AddSection({ Name = "跳跃" })

local v26 = 15

tab3:AddTextbox({
  Name = "跳跃高度",
  Default = "15",
  TextDisappear = false,
  Callback = function(value44) v26 = tonumber(value44) or 15 end,
})

tab3:AddButton({
  Name = "开启跳跃",
  Callback = function()
    local v27 = game

    loadstring("local jumph = " .. tostring(v26)
      .. v27:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/JB.LUA"))()
  end,
})

tab3:AddSection({ Name = "游戏的一些功能" })
tab3:AddToggle({ Name = "立即互动", Callback = function(value45) f7(value45) end })

window:MakeTab({ Name = "杂项", Icon = "rbxassetid://77348087165494" })
task.spawn(InitializeScript)
