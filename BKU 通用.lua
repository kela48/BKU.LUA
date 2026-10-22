-- by kela_er
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")
local textChatService = game:GetService("TextChatService")
local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")
local virtualUser = game:GetService("VirtualUser")
local coreGui = game:GetService("CoreGui")
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
  ThirdPerson = false,
  InstantInteract = false,
  PlayerESP = false,
  ShowNames = false,
  ShowTracers = false,
  PlayerHighlight = false,
  RainbowESP = false,
  ShowDistance = false,
  TracerFromTop = false,
  CustomESP = false,
  CustomRainbow = false,
  CustomShowDistance = false,
  CustomNames = {},
}

local v2 = false
local connect

local function f1(value)
  if value then
    if not connect then
      connect = localPlayer.Idled:Connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new(0, 0))
      end)
    end
  elseif connect then
    connect:Disconnect()
    connect = nil
  end
end

local v3 = false

local v4 = {
  Parts = {},
  MeshParts = {},
  SpecialMeshes = {},
  Textures = {},
  HiddenInstances = {},
  GlobalShadows = nil,
}

local bkuLowGraphicsBackup = Instance.new("Folder")
bkuLowGraphicsBackup.Name = "BKU_LowGraphics_Backup"
bkuLowGraphicsBackup.Parent = workspace

local function f2(key)
  if not key or not key.Parent or key:IsDescendantOf(bkuLowGraphicsBackup) then
    return
  end

  pcall(function()
    if key:IsA("Decal") or key:IsA("Texture") then
      if v4.Textures[key] == nil then
        v4.Textures[key] = key.Transparency
      end

      key.Transparency = 1
    elseif key:IsA("SurfaceAppearance") or key:IsA("MaterialVariant") then
      if v4.HiddenInstances[key] == nil then
        v4.HiddenInstances[key] = key.Parent
      end

      key.Parent = bkuLowGraphicsBackup
    elseif key:IsA("BasePart") then
      if v4.Parts[key] == nil then
        v4.Parts[key] = {
          Material = key.Material,
          Reflectance = key.Reflectance,
          MaterialVariant = key.MaterialVariant,
        }
      end

      key.Material = Enum.Material.SmoothPlastic
      key.Reflectance = 0
      key.MaterialVariant = ""

      if key:IsA("MeshPart") then
        if v4.MeshParts[key] == nil then
          v4.MeshParts[key] = key.TextureID
        end

        key.TextureID = ""
      end
    elseif key:IsA("SpecialMesh") then
      if v4.SpecialMeshes[key] == nil then
        v4.SpecialMeshes[key] = key.TextureId
      end

      key.TextureId = ""
    end
  end)
end

local function f3(value2)
  v3 = value2

  pcall(function()
    if value2 then
      if v4.GlobalShadows == nil then
        v4.GlobalShadows = lighting.GlobalShadows
      end

      lighting.GlobalShadows = false

      for index, value3 in ipairs(workspace:GetDescendants()) do
        f2(value3)
      end
    else
      if v4.GlobalShadows ~= nil then
        lighting.GlobalShadows = v4.GlobalShadows
      end

      for key2, value4 in pairs(v4.Parts) do
        if key2 and key2.Parent then
          key2.Material = value4.Material
          key2.Reflectance = value4.Reflectance
          key2.MaterialVariant = value4.MaterialVariant
        end
      end

      for key3, value5 in pairs(v4.MeshParts) do
        if key3 and key3.Parent then
          key3.TextureID = value5
        end
      end

      for key4, value6 in pairs(v4.SpecialMeshes) do
        if key4 and key4.Parent then
          key4.TextureId = value6
        end
      end

      for key5, value7 in pairs(v4.Textures) do
        if key5 and key5.Parent then
          key5.Transparency = value7
        end
      end

      for key6, value8 in pairs(v4.HiddenInstances) do
        if key6 and value8 then
          key6.Parent = value8
        end
      end

      table.clear(v4.Parts)
      table.clear(v4.MeshParts)
      table.clear(v4.SpecialMeshes)
      table.clear(v4.Textures)
      table.clear(v4.HiddenInstances)

      v4.GlobalShadows = nil
    end
  end)
end

local v5 = { Enabled = false, Message = "BKU SCRIPT", Delay = 0.5 }

local function f4(message)
end

task.spawn(function()
  while true do
    if v5.Enabled and v5.Message ~= "" then
      f4(v5.Message)
      task.wait(math.max(0.5, v5.Delay))
    else
      task.wait(1)
    end
  end
end)

local v6 = {
  Enabled = false,
  ShowFOV = false,
  FOVRadius = 120,
  FOVPosition = "屏幕中心",
  TargetPart = "Head",
  Smoothness = 0.2,
  TeamCheck = true,
  WallCheck = false,
  Mode = "右键按住",
  IsAiming = false,
}

local bkuAimbotFOVGui = Instance.new("ScreenGui")
bkuAimbotFOVGui.Name = "BKU_AimbotFOV_Gui"
bkuAimbotFOVGui.ResetOnSpawn = false
bkuAimbotFOVGui.IgnoreGuiInset = true

pcall(function()
  if gethui then
    bkuAimbotFOVGui.Parent = gethui()
  else
    bkuAimbotFOVGui.Parent = coreGui
  end
end)

if not bkuAimbotFOVGui.Parent then
  bkuAimbotFOVGui.Parent = localPlayer:WaitForChild("PlayerGui")
end

local fovCircle = Instance.new("Frame")
fovCircle.Name = "FOVCircle"
fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
fovCircle.BackgroundTransparency = 1
fovCircle.BorderSizePixel = 0
fovCircle.Visible = false
fovCircle.Parent = bkuAimbotFOVGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = fovCircle

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(255, 50, 50)
uiStroke.Thickness = 1.5
uiStroke.Parent = fovCircle

local function f5()
  if v6.FOVPosition == "屏幕中心" then
    local viewportSize = currentCamera.ViewportSize
    return Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
  end

  return userInputService:GetMouseLocation()
end

local v7 = {
  FOV = currentCamera.FieldOfView,
  Bright = lighting.Brightness,
  FogEnd = lighting.FogEnd,
  FogStart = lighting.FogStart,
  Ambient = lighting.Ambient,
  Clock = lighting.ClockTime,
  Speed = walkSpeed,
}

local v8 = {}
local v9 = {}
local v10 = {}

local bkuPlayerESPGui = Instance.new("ScreenGui")
bkuPlayerESPGui.Name = "BKU_PlayerESP_Gui"
bkuPlayerESPGui.ResetOnSpawn = false
bkuPlayerESPGui.IgnoreGuiInset = true

pcall(function()
  if gethui then
    bkuPlayerESPGui.Parent = gethui()
  else
    bkuPlayerESPGui.Parent = coreGui
  end
end)

if not bkuPlayerESPGui.Parent then
  bkuPlayerESPGui.Parent = localPlayer:WaitForChild("PlayerGui")
end

local function f6(value9)
  if not v1.CustomESP or #v1.CustomNames == 0 then
    return false
  else
    local name = value9.Name

    for index2, value10 in ipairs(v1.CustomNames) do
      if value10 ~= "" and name == value10 then
        return true
      end
    end

    return false
  end
end

local v11 = {}

local function f7(player)
  if v11[player] then
    if v11[player].Line then
      v11[player].Line:Destroy()
    end

    if v11[player].Billboard then
      v11[player].Billboard:Destroy()
    end

    v11[player] = nil
  end
end

local function makeTextLabel(p1)
  if not p1:IsA("Model") then
    return
  end

  if p1.Name ~= "baloksxin_real" and not string.find(p1.Name, "baloksxin_real") then
    return
  end

  if not p1:FindFirstChild("BKUCreator_Highlight_ESP") then
    local bkuCreatorHighlightESP = Instance.new("Highlight")
    bkuCreatorHighlightESP.Name = "BKUCreator_Highlight_ESP"
    bkuCreatorHighlightESP.Adornee = p1
    bkuCreatorHighlightESP.FillColor = Color3.fromRGB(0, 120, 255)
    bkuCreatorHighlightESP.OutlineColor = Color3.fromRGB(0, 120, 255)
    bkuCreatorHighlightESP.FillTransparency = 1
    bkuCreatorHighlightESP.OutlineTransparency = 0
    bkuCreatorHighlightESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    bkuCreatorHighlightESP.Parent = p1
  end

  if not p1:FindFirstChild("BKUCreator_Text_ESP") then
    local primaryPart = p1.PrimaryPart or p1:FindFirstChild("HumanoidRootPart")
      or p1:FindFirstChild("Head")

    if primaryPart then
      local bkuCreatorTextESP = Instance.new("BillboardGui")
      bkuCreatorTextESP.Name = "BKUCreator_Text_ESP"
      bkuCreatorTextESP.Size = UDim2.new(0, 180, 0, 50)
      bkuCreatorTextESP.AlwaysOnTop = true
      bkuCreatorTextESP.ExtentsOffset = Vector3.new(0, 3.5, 0)
      bkuCreatorTextESP.Adornee = primaryPart
      bkuCreatorTextESP.Parent = p1

      local textLabel = Instance.new("TextLabel")
      textLabel.Size = UDim2.new(1, 0, 1, 0)
      textLabel.BackgroundTransparency = 1
      textLabel.Text = "BKU创作者"
      textLabel.TextColor3 = Color3.fromRGB(0, 120, 255)
      textLabel.TextSize = 16
      textLabel.Font = Enum.Font.SourceSansBold
      textLabel.TextStrokeTransparency = 0
      textLabel.Parent = bkuCreatorTextESP
    end
  end
end

local function makeTextLabel2(key7)
  f7(key7)

  if key7 == localPlayer then
    return
  else
    local character = key7.Character

    if not character then
      return
    else
      local upperTorso = character:FindFirstChild("UpperTorso")
        or character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart")

      if not upperTorso then
        return
      else
        local bkuPlayerNameESP = Instance.new("BillboardGui")
        bkuPlayerNameESP.Name = "BKU_PlayerName_ESP"
        bkuPlayerNameESP.Size = UDim2.new(0, 180, 0, 40)
        bkuPlayerNameESP.AlwaysOnTop = true
        bkuPlayerNameESP.Adornee = upperTorso
        bkuPlayerNameESP.Enabled = false

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = key7.DisplayName
        nameLabel.TextColor3 = key7.Team and key7.TeamColor.Color or Color3.fromRGB(0, 255, 0)
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextStrokeTransparency = 0
        nameLabel.Parent = bkuPlayerNameESP

        bkuPlayerNameESP.Parent = character

        local frame = Instance.new("Frame")
        frame.Name = "Tracer_" .. key7.Name
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.BorderSizePixel = 0
        frame.Visible = false
        frame.Parent = bkuPlayerESPGui

        v11[key7] = { Billboard = bkuPlayerNameESP, Label = nameLabel, Line = frame }
        return
      end
    end
  end
end

local function f8(character2, value11)
  if not character2 then
    return
  else
    local humanoid = character2:FindFirstChildOfClass("Humanoid")

    if humanoid then
      local animator = humanoid:FindFirstChildOfClass("Animator")

      if animator then
        if value11 then
          for index3, value12 in ipairs(animator:GetPlayingAnimationTracks()) do
            v10[value12] = value12.Speed
            value12:AdjustSpeed(0)
          end
        else
          for index4, value13 in ipairs(animator:GetPlayingAnimationTracks()) do
            if v10[value13] then
              value13:AdjustSpeed(v10[value13])
            else
              value13:AdjustSpeed(1)
            end
          end

          table.clear(v10)
          humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
      end
    end

    return
  end
end

local function f9(player2, p2)
  local v12 = p2
  v12 = v12 or 5

  task.spawn(function()
    local v13 = v12
    local count = 0

    while true do
      count = 1 + count

      if not (v13 >= count) then
        break
      end

      if not player2 or not player2.Parent then
        return
      end

      makeTextLabel2(player2)

      if v11[player2] then
        return
      end

      task.wait(0.3)
    end
  end)
end

local function makeTextLabel3(key8)
  if not key8 or not key8.Parent then
    return
  elseif not f6(key8) then
    if key8:FindFirstChild("Custom_Highlight_ESP") then
      key8.Custom_Highlight_ESP:Destroy()
    end

    if key8:FindFirstChild("Custom_Text_ESP") then
      key8.Custom_Text_ESP:Destroy()
    end

    v8[key8] = nil
    return
  else
    if v8[key8] then
      return
    end

    if not key8:FindFirstChild("Custom_Highlight_ESP") then
      local customHighlightESP = Instance.new("Highlight")
      customHighlightESP.Name = "Custom_Highlight_ESP"
      customHighlightESP.Adornee = key8
      customHighlightESP.FillColor = Color3.fromRGB(255, 200, 0)
      customHighlightESP.OutlineColor = Color3.fromRGB(255, 200, 0)
      customHighlightESP.FillTransparency = 0.5
      customHighlightESP.OutlineTransparency = 0
      customHighlightESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
      customHighlightESP.Parent = key8
    end

    if not key8:FindFirstChild("Custom_Text_ESP") then
      local primaryPart2 = key8:IsA("Model")
          and (key8.PrimaryPart or key8:FindFirstChild("HumanoidRootPart")
            or key8:FindFirstChild("Head"))
        or key8:IsA("BasePart") and key8

      if primaryPart2 then
        local customTextESP = Instance.new("BillboardGui")
        customTextESP.Name = "Custom_Text_ESP"
        customTextESP.Size = UDim2.new(0, 200, 0, 50)
        customTextESP.AlwaysOnTop = true
        customTextESP.ExtentsOffset = Vector3.new(0, 3, 0)
        customTextESP.Adornee = primaryPart2
        customTextESP.Parent = key8

        local textLabel2 = Instance.new("TextLabel")
        textLabel2.Size = UDim2.new(1, 0, 1, 0)
        textLabel2.BackgroundTransparency = 1
        textLabel2.Text = key8.Name
        textLabel2.TextColor3 = Color3.fromRGB(255, 200, 0)
        textLabel2.TextSize = 16
        textLabel2.Font = Enum.Font.SourceSansBold
        textLabel2.TextStrokeTransparency = 0
        textLabel2.Parent = customTextESP
      end
    end

    v8[key8] = true
    return
  end
end

local function f10()
  table.clear(v8)

  for key9, value14 in pairs(workspace:GetDescendants()) do
    if value14:FindFirstChild("Custom_Highlight_ESP") then
      value14.Custom_Highlight_ESP:Destroy()
    end

    if value14:FindFirstChild("Custom_Text_ESP") then
      value14.Custom_Text_ESP:Destroy()
    end

    if f6(value14) then
      makeTextLabel3(value14)
    end
  end
end

local connect2 = nil

local function f11()
  if connect2 then
    connect2:Disconnect()
  end

  if currentCamera then
    connect2 = currentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
      if v1.FOVEn and currentCamera.FieldOfView ~= v1.FOV then
        currentCamera.FieldOfView = v1.FOV
      end
    end)
  end
end

local v14 = {}
local connect3

local function f12(value15)
  v1.InstantInteract = value15

  if connect3 then
    connect3:Disconnect()
    connect3 = nil
  end

  local function f13(key10)
    if not key10:IsA("ProximityPrompt") then
      return
    end

    if value15 then
      if not v14[key10] then
        v14[key10] = key10.HoldDuration
      end

      key10.HoldDuration = 0

      local connect4 = key10:GetPropertyChangedSignal("HoldDuration"):Connect(function()
        if key10.HoldDuration ~= 0 then
          key10.HoldDuration = 0
        end
      end)
    else
      local v15 = v14[key10]

      if v15 ~= nil then
        key10.HoldDuration = v15
        v14[key10] = nil
      end
    end
  end

  for index5, value16 in ipairs(game:GetDescendants()) do
    if value16:IsA("ProximityPrompt") then
      f13(value16)
    end
  end

  if value15 then
    connect3 = game.DescendantAdded:Connect(function(descendant)
      if descendant:IsA("ProximityPrompt") then
        f13(descendant)
      end
    end)
  end
end

local connect5

local function f14()
  if not v2 then
    return
  end

  if connect5 then
    connect5:Disconnect()
    connect5 = nil
  end

  v2 = false
end

local f15

local function f16()
  if v2 then
    return
  end

  connect5 = runService.Heartbeat:Connect(f15)
  v2 = true
end

function f15()
  local character3 = localPlayer.Character

  if not character3 then
    return
  else
    local humanoid2 = character3:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character3:FindFirstChild("HumanoidRootPart")

    if not humanoid2 or not humanoidRootPart or humanoid2.Health <= 0 then
      return
    else
      local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
      local moveDirection = humanoid2.MoveDirection
      local walkSpeed2 = humanoid2.WalkSpeed

      if walkSpeed2 <= 0 or walkSpeed2 > 200 then
        return
      end

      if moveDirection.Magnitude < 0.05 then
        if math.abs(assemblyLinearVelocity.X) > 0.01
          or math.abs(assemblyLinearVelocity.Z) > 0.01 then
          humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, assemblyLinearVelocity.Y, 0)
        end
      else
        local v16 = moveDirection.Unit * walkSpeed2

        humanoidRootPart.AssemblyLinearVelocity = Vector3.new(
          v16.X, assemblyLinearVelocity.Y, v16.Z
        )
      end

      return
    end
  end
end

local bkuSCRIPTWindow = ui:MakeWindow({
  Name = "BKU SCRIPT 通用",
  SubTitle = "By Baloksxin",
  HidePremium = true,
  SaveConfig = false,
  IntroText = "BKU SCRIPT",
})

local tab = bkuSCRIPTWindow:MakeTab({ Name = "信息", Icon = "rbxassetid://77348087165494" })
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

tab:AddSection({ Name = "服务器" })

tab:AddButton({
  Name = "重新进服",
  Callback = function()
    if #players:GetPlayers() <= 1 then
      teleportService:Teleport(game.PlaceId, localPlayer)
    else
      teleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
    end
  end,
})

tab:AddButton({
  Name = "进入其他服务器",
  Callback = function()
    pcall(function()
      local jsonDecode = httpService:JSONDecode((game:HttpGet("https://games.roblox.com/v1/games/"
        .. tostring(game.PlaceId) .. "/servers/0?sortOrder=Asc&limit=100")))

      if jsonDecode and jsonDecode.data then
        for index6, value17 in ipairs(jsonDecode.data) do
          if value17.playing < value17.maxPlayers and value17.id ~= game.JobId then
            teleportService:TeleportToPlaceInstance(game.PlaceId, value17.id, localPlayer)
            return
          end
        end

        return
      end
    end)
  end,
})

local tab2 = bkuSCRIPTWindow:MakeTab({ Name = "玩家", Icon = "rbxassetid://77348087165494" })
tab2:AddSection({ Name = "玩家" })

local v17 = {}
local v18 = false

local function f17()
  table.clear(v17)
  local v19 = {}

  for index7, value18 in ipairs(players:GetPlayers()) do
    if value18 ~= localPlayer then
      local v20 = value18.DisplayName .. " (@" .. value18.Name .. ")"
      v17[v20] = value18
      table.insert(v19, v20)
    end
  end

  if #v19 == 0 then
    table.insert(v19, "暂无其他玩家")
  end

  return v19
end

local v21

local addDropdown = tab2:AddDropdown({
  Name = "玩家列表",
  Default = "",
  Options = f17(),
  Callback = function(value19) v21 = v17[value19] end,
})

tab2:AddButton({
  Name = "刷新列表",
  Callback = function() addDropdown:Refresh(f17(), true) end,
})

tab2:AddSection({ Name = "操作" })

tab2:AddButton({
  Name = "传送",
  Callback = function()
    if not v21 then
      return
    else
      local character4 = localPlayer.Character
      local character5 = v21.Character

      if character4 and character5 then
        local humanoidRootPart2 = character4:FindFirstChild("HumanoidRootPart")

        local humanoidRootPart3 = character5:FindFirstChild("HumanoidRootPart")
          or character5:FindFirstChild("Head")

        if humanoidRootPart2 and humanoidRootPart3 then
          humanoidRootPart2.CFrame = humanoidRootPart3.CFrame * CFrame.new(0, 0, 3)
        end
      end

      return
    end
  end,
})

tab2:AddToggle({
  Name = "观战",
  Default = false,
  Callback = function(value20)
    local character6 = value20
    v18 = value20

    if value20 then
      character6 = v21 and v21.Character
    end

    if character6 then
      local humanoid3 = v21.Character:FindFirstChildOfClass("Humanoid")

      if humanoid3 then
        currentCamera.CameraSubject = humanoid3
      end
    elseif not value20 and localPlayer.Character then
      local humanoid4 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid4 then
        currentCamera.CameraSubject = humanoid4
      end
    end
  end,
})

tab2:AddButton({
  Name = "复制用户名",
  Callback = function()
    if v21 then
      setclipboard(v21.Name)
    end
  end,
})

tab2:AddButton({
  Name = "复制显示名",
  Callback = function()
    if v21 then
      setclipboard(v21.DisplayName)
    end
  end,
})

tab2:AddButton({
  Name = "复制ID",
  Callback = function()
    if v21 then
      setclipboard(tostring(v21.UserId))
    end
  end,
})

local tab3 = bkuSCRIPTWindow:MakeTab({ Name = "自瞄", Icon = "rbxassetid://77348087165494" })
tab3:AddSection({ Name = "自瞄" })

tab3:AddToggle({
  Name = "开启自瞄",
  Default = false,
  Callback = function(value21) v6.Enabled = value21 end,
})

tab3:AddDropdown({
  Name = "触发模式",
  Default = "右键按住",
  Options = { "右键按住", "总是开启" },
  Callback = function(value22) v6.Mode = value22 end,
})

tab3:AddDropdown({
  Name = "瞄准部位",
  Default = "Head",
  Options = { "Head", "HumanoidRootPart", "Torso" },
  Callback = function(value23) v6.TargetPart = value23 end,
})

tab3:AddSlider({
  Name = "平滑度",
  Min = 0,
  Max = 90,
  Default = 20,
  Increment = 1,
  ValueName = "%",
  Callback = function(value24) v6.Smoothness = value24 / 100 end,
})

tab3:AddSection({ Name = "筛选" })

tab3:AddToggle({
  Name = "忽略队友",
  Default = true,
  Callback = function(value25) v6.TeamCheck = value25 end,
})

tab3:AddToggle({
  Name = "忽略遮挡",
  Default = false,
  Callback = function(value26) v6.WallCheck = value26 end,
})

tab3:AddSection({ Name = "范围圈" })

tab3:AddToggle({
  Name = "显示范围圈",
  Default = false,
  Callback = function(value27) v6.ShowFOV = value27 end,
})

tab3:AddDropdown({
  Name = "范围圈位置",
  Default = "屏幕中心",
  Options = { "屏幕中心", "跟随鼠标" },
  Callback = function(value28) v6.FOVPosition = value28 end,
})

tab3:AddSlider({
  Name = "范围圈大小",
  Min = 30,
  Max = 600,
  Default = 120,
  Increment = 5,
  ValueName = "px",
  Callback = function(value29) v6.FOVRadius = value29 end,
})

userInputService.InputBegan:Connect(function(input, p3)
  if p3 then
    return
  end

  if input.UserInputType == Enum.UserInputType.MouseButton2
    or input.KeyCode == Enum.KeyCode.ButtonL2 then
    v6.IsAiming = true
  end
end)

userInputService.InputEnded:Connect(function(input2)
  if input2.UserInputType == Enum.UserInputType.MouseButton2
    or input2.KeyCode == Enum.KeyCode.ButtonL2 then
    v6.IsAiming = false
  end
end)

local function f18()
  local fovRadius = v6.FOVRadius
  local v22 = f5()
  local v23

  for index8, value30 in ipairs(players:GetPlayers()) do
    if value30 ~= localPlayer then
      if not (v6.TeamCheck and value30.Team and localPlayer.Team and value30.Team == localPlayer.Team) then
        local character7 = value30.Character

        if character7 and character7:FindFirstChild("Humanoid")
          and character7.Humanoid.Health > 0 then
          local findFirstChild = character7:FindFirstChild(v6.TargetPart)
            or character7:FindFirstChild("Head")
            or character7:FindFirstChild("HumanoidRootPart")

          if findFirstChild then
            local v24, v25 = currentCamera:WorldToViewportPoint(findFirstChild.Position)

            if v25 then
              local magnitude = (Vector2.new(v24.X, v24.Y) - v22).Magnitude

              if magnitude < fovRadius then
                if v6.WallCheck then
                  local raycastParams = RaycastParams.new()
                  raycastParams.FilterType = Enum.RaycastFilterType.Exclude

                  raycastParams.FilterDescendantsInstances = {
                    localPlayer.Character, currentCamera,
                  }

                  local raycast = workspace:Raycast(currentCamera.CFrame.Position, findFirstChild.Position
                    - currentCamera.CFrame.Position, raycastParams)

                  if not (raycast and raycast.Instance
                    and not raycast.Instance:IsDescendantOf(character7)) then
                    ::L1405830::
                    v23 = findFirstChild
                    fovRadius = magnitude
                  end
                else
                  goto L1405830
                end
              end
            end
          end
        end
      end
    end
  end

  return v23
end

local espTab = bkuSCRIPTWindow:MakeTab({ Name = "ESP", Icon = "rbxassetid://77348087165494" })
espTab:AddSection({ Name = "玩家ESP" })

espTab:AddToggle({
  Name = "开启 ESP",
  Callback = function(value31)
    v1.PlayerESP = value31

    if not value31 then
      for key11, value32 in pairs(v11) do
        if value32.Line then
          value32.Line.Visible = false
        end

        if value32.Billboard then
          value32.Billboard.Enabled = false
        end
      end

      for key12, value33 in pairs(players:GetPlayers()) do
        if value33.Character and value33.Character:FindFirstChild("PlayerHighlight") then
          value33.Character.PlayerHighlight:Destroy()
        end
      end
    end
  end,
})

espTab:AddToggle({
  Name = "显示名字",
  Callback = function(value34) v1.ShowNames = value34 end,
})

espTab:AddToggle({
  Name = "显示射线",
  Callback = function(value35) v1.ShowTracers = value35 end,
})

espTab:AddToggle({
  Name = "显示高亮",
  Callback = function(value36) v1.PlayerHighlight = value36 end,
})

espTab:AddSection({ Name = "自定义ESP" })

espTab:AddTextbox({
  Name = "输入部件名称 (用逗号+空格分隔)",
  Default = "",
  TextDisappear = false,
  Callback = function(value37)
    v1.CustomNames = {}

    if value37 and value37 ~= "" then
      for match in string.gmatch(value37, "[^,]+") do
        local gsub = match:gsub("^%s+", ""):gsub("%s+$", "")

        if gsub ~= "" then
          table.insert(v1.CustomNames, gsub)
        end
      end
    end

    if v1.CustomESP then
      f10()
    end
  end,
})

espTab:AddToggle({
  Name = "开启自定义ESP",
  Callback = function(value38)
    v1.CustomESP = value38

    if value38 then
      f10()
    else
      for key13, value39 in pairs(workspace:GetDescendants()) do
        if value39:FindFirstChild("Custom_Highlight_ESP") then
          value39.Custom_Highlight_ESP:Destroy()
        end

        if value39:FindFirstChild("Custom_Text_ESP") then
          value39.Custom_Text_ESP:Destroy()
        end
      end

      table.clear(v8)
    end
  end,
})

espTab:AddButton({
  Name = "刷新自定义ESP",
  Callback = function()
    if v1.CustomESP then
      f10()
    end
  end,
})

local espTab2 = bkuSCRIPTWindow:MakeTab({
  Name = "ESP设置",
  Icon = "rbxassetid://77348087165494",
})

espTab2:AddSection({ Name = "玩家" })

espTab2:AddToggle({
  Name = "玩家彩虹色",
  Callback = function(value40) v1.RainbowESP = value40 end,
})

espTab2:AddToggle({
  Name = "玩家显示距离",
  Callback = function(value41) v1.ShowDistance = value41 end,
})

espTab2:AddDropdown({
  Name = "玩家射线位置",
  Options = { "从下方", "从上方" },
  Default = "从下方",
  Callback = function(value42) v1.TracerFromTop = value42 == "从上方" end,
})

espTab2:AddSection({ Name = "自定义" })

espTab2:AddToggle({
  Name = "自定义彩虹色",
  Callback = function(value43) v1.CustomRainbow = value43 end,
})

espTab2:AddToggle({
  Name = "自定义显示距离",
  Callback = function(value44) v1.CustomShowDistance = value44 end,
})

local tab4 = bkuSCRIPTWindow:MakeTab({ Name = "通用", Icon = "rbxassetid://77348087165494" })
tab4:AddSection({ Name = "角色属性修改" })

tab4:AddSlider({
  Name = "修改速度值",
  Min = 0,
  Max = 500,
  Default = v7.Speed,
  Increment = 1,
  ValueName = "",
  Callback = function(value45)
    v1.Speed = value45

    if v1.SpeedEn and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = value45
    end
  end,
})

tab4:AddToggle({
  Name = "开启速度修改",
  Callback = function(value46)
    v1.SpeedEn = value46

    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
      local humanoid5 = localPlayer.Character.Humanoid
      humanoid5.WalkSpeed = value46 and v1.Speed or v7.Speed
    end
  end,
})

tab4:AddSlider({
  Name = "修改FOV值",
  Min = 1,
  Max = 120,
  Default = v7.FOV,
  Increment = 1,
  ValueName = "",
  Callback = function(value47)
    v1.FOV = value47

    if v1.FOVEn and currentCamera then
      currentCamera.FieldOfView = value47
    end
  end,
})

tab4:AddToggle({
  Name = "开启 FOV 修改",
  Callback = function(value48)
    v1.FOVEn = value48
    local v26 = currentCamera
    v26.FieldOfView = value48 and v1.FOV or v7.FOV
  end,
})

tab4:AddToggle({
  Name = "第三人称",
  Callback = function(value49) v1.ThirdPerson = value49 end,
})

tab4:AddToggle({ Name = "无限跳跃", Callback = function(value50) v1.InfJump = value50 end })

tab4:AddToggle({
  Name = "穿墙模式",
  Callback = function(value51)
    v1.Noclip = value51

    if not value51 then
      for key14, value52 in pairs(v9) do
        if key14 and key14.Parent then
          key14.CanCollide = value52
        end
      end

      table.clear(v9)
    end
  end,
})

tab4:AddToggle({
  Name = "固定自己",
  Callback = function(value53)
    v1.FreezeSelf = value53

    if localPlayer.Character then
      local humanoidRootPart4 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart4 then
        humanoidRootPart4.Anchored = value53
      end

      f8(localPlayer.Character, value53)
    end
  end,
})

tab4:AddToggle({
  Name = "固定自己(不固定动画)",
  Callback = function(value54)
    v1.AnchorOnly = value54

    if localPlayer.Character then
      local humanoidRootPart5 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart5 then
        humanoidRootPart5.Anchored = value54
      end
    end
  end,
})

tab4:AddToggle({
  Name = "夜视模式",
  Callback = function(value55)
    v1.NightVis = value55

    if not value55 then
      local ambient = v7.Ambient
      local clock = v7.Clock

      lighting.Brightness = v7.Bright
      lighting.Ambient = ambient
      lighting.ClockTime = clock
      lighting.FogEnd = v7.FogEnd or 100000
      lighting.FogStart = v7.FogStart or 0
    end
  end,
})

tab4:AddToggle({ Name = "立即互动", Callback = function(value56) f12(value56) end })

tab4:AddToggle({
  Name = "防挂机",
  Default = false,
  Callback = function(value57) f1(value57) end,
})

tab4:AddToggle({
  Name = "低画质",
  Default = false,
  Callback = function(value58) f3(value58) end,
})

tab4:AddToggle({
  Name = "防脚滑",
  Default = false,
  Callback = function(value59)
    if value59 then
      f16()
    else
      f14()
    end
  end,
})

tab4:AddSection({ Name = "循环说话" })

tab4:AddTextbox({
  Name = "说话内容",
  Default = "BKU SCRIPT",
  TextDisappear = false,
  Callback = function(value60) v5.Message = value60 end,
})

tab4:AddSlider({
  Name = "间隔时间",
  Min = 0.5,
  Max = 30,
  Default = 0.5,
  Increment = 0.5,
  ValueName = "秒",
  Callback = function(value61) v5.Delay = value61 end,
})

tab4:AddToggle({
  Name = "开启循环说话",
  Default = false,
  Callback = function(value62) v5.Enabled = value62 end,
})

tab4:AddSection({ Name = "开启跳跃" })

local v27 = 15

tab4:AddTextbox({
  Name = "跳跃高度",
  Default = "15",
  TextDisappear = false,
  Callback = function(value63) v27 = tonumber(value63) or 15 end,
})

tab4:AddButton({
  Name = "开启跳跃按钮(覆盖游戏原有)",
  Callback = function()
    local v28 = game

    loadstring("local jumph = " .. tostring(v27)
      .. v28:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/JB.LUA"))()
  end,
})

local tab5 = bkuSCRIPTWindow:MakeTab({ Name = "工具", Icon = "rbxassetid://77348087165494" })
tab5:AddSection({ Name = "工具" })

tab5:AddButton({
  Name = "固定在NPC脚下",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/%E8%84%9A%E5%BA%95.LUA"))()
  end,
})

tab5:AddButton({
  Name = "NPC控制",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty38.lua"))()
  end,
})

tab5:AddButton({
  Name = "AnimHubV2",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Emerson2-creator/Scripts-Roblox/refs/heads/main/ScriptR6/AnimGuiV2.lua"))()
  end,
})

tab5:AddButton({
  Name = "声音修改工具",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/%E5%A3%B0%E9%9F%B3%E4%BF%AE%E6%94%B9.LUA"))()
  end,
})

tab5:AddButton({
  Name = "手机版Shiftlock",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/MobileShiftlock.LUA"))()
  end,
})

tab5:AddButton({
  Name = "Infinite Yield",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
  end,
})

tab5:AddButton({
  Name = "TP Tool",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/TP%20TOOL.LUA"))()
  end,
})

tab5:AddButton({
  Name = "飞行 GUI",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/Fly%20Gui.LUA"))()
  end,
})

tab5:AddButton({
  Name = "R15动作脚本",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Gazer-Ha/Free-emote/refs/heads/main/Delta%20mad%20stuffs"))()
  end,
})

local tab6 = bkuSCRIPTWindow:MakeTab({ Name = "旋转", Icon = "rbxassetid://77348087165494" })
local v29 = { Enabled = false, Speed = 1, Direction = 1 }
local connect6

local function f19()
  if connect6 then
    connect6:Disconnect()
    connect6 = nil
  end

  if not v29.Enabled then
    if localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
      localPlayer.Character.Humanoid.AutoRotate = true
    end

    return
  end

  if localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
    localPlayer.Character.Humanoid.AutoRotate = false
  end

  connect6 = runService.RenderStepped:Connect(function()
    if not v29.Enabled then
      return
    else
      local character8 = localPlayer.Character

      if not character8 then
        return
      else
        local humanoidRootPart6 = character8:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart6 then
          return
        end

        humanoidRootPart6.CFrame = humanoidRootPart6.CFrame
          * CFrame.Angles(0, math.rad(v29.Speed * v29.Direction), 0)

        return
      end
    end
  end)
end

tab6:AddSection({ Name = "旋转功能" })

tab6:AddToggle({
  Name = "开启旋转",
  Default = false,
  Callback = function(value64)
    v29.Enabled = value64
    f19()

    if not value64 and localPlayer.Character
      and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
      localPlayer.Character.Humanoid.AutoRotate = true
    end
  end,
})

tab6:AddSlider({
  Name = "旋转速度",
  Min = 1,
  Max = 500,
  Default = 1,
  Increment = 1,
  ValueName = "度/帧",
  Callback = function(value65) v29.Speed = value65 end,
})

tab6:AddDropdown({
  Name = "旋转方向",
  Default = "顺时针",
  Options = { "顺时针", "逆时针" },
  Callback = function(value66) v29.Direction = value66 == "顺时针" and 1 or -1 end,
})

ui:Init()

task.spawn(function()
  for index9, value67 in ipairs(players:GetPlayers()) do
    local v30 = value67

    if v30 ~= localPlayer then
      f9(v30)
      v30.CharacterAdded:Connect(function() f9(v30) end)
      v30.CharacterRemoving:Connect(function() f7(v30) end)
    end
  end

  players.PlayerAdded:Connect(function(player3)
    player3.CharacterAdded:Connect(function() f9(player3) end)
    player3.CharacterRemoving:Connect(function() f7(player3) end)
  end)

  players.PlayerRemoving:Connect(function(player4) f7(player4) end)

  workspace.DescendantAdded:Connect(function(descendant2)
    makeTextLabel(descendant2)

    if v1.CustomESP then
      makeTextLabel3(descendant2)
    end

    if v3 then
      f2(descendant2)
    end
  end)

  game.DescendantAdded:Connect(function(descendant3)
    if v1.InstantInteract and descendant3:IsA("ProximityPrompt") then
      descendant3.HoldDuration = 0
    end
  end)

  for index10, value68 in ipairs(workspace:GetDescendants()) do
    makeTextLabel(value68)
  end

  workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    currentCamera = workspace.CurrentCamera
    f11()

    if v1.FOVEn and currentCamera then
      currentCamera.FieldOfView = v1.FOV
    end
  end)

  f11()

  localPlayer.CharacterAdded:Connect(function(character9)
    table.clear(v9)
    table.clear(v10)

    if v2 then
      if connect5 then
        connect5:Disconnect()
      end

      connect5 = runService.Heartbeat:Connect(f15)
    end
  end)

  runService.RenderStepped:Connect(function()
    if v18 and v21 and v21.Character then
      local humanoid6 = v21.Character:FindFirstChildOfClass("Humanoid")

      if humanoid6 and currentCamera.CameraSubject ~= humanoid6 then
        currentCamera.CameraSubject = humanoid6
      end
    end

    if fovCircle then
      local v31 = f5()

      fovCircle.Position = UDim2.new(0, v31.X, 0, v31.Y)
      fovCircle.Size = UDim2.new(0, v6.FOVRadius * 2, 0, v6.FOVRadius * 2)
      fovCircle.Visible = v6.ShowFOV and v6.Enabled
    end

    if v6.Enabled and (v6.Mode == "总是开启" or v6.Mode == "右键按住" and v6.IsAiming) then
      local v32 = f18()

      if v32 then
        local cframe = CFrame.lookAt(currentCamera.CFrame.Position, v32.Position)

        if v6.Smoothness < 0.95 then
          currentCamera.CFrame = currentCamera.CFrame:Lerp(cframe, 1 - v6.Smoothness)
        else
          currentCamera.CFrame = cframe
        end
      end
    end

    if v1.SpeedEn and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = v1.Speed
    end

    if v1.NightVis then
      local color = Color3.new(1, 1, 1)

      lighting.Brightness = 2
      lighting.Ambient = color
      lighting.ClockTime = 12
      lighting.FogEnd = 100000
      lighting.FogStart = 0
    end

    if v1.FOVEn and currentCamera then
      currentCamera.FieldOfView = v1.FOV
    end

    if v1.ThirdPerson then
      localPlayer.CameraMode = Enum.CameraMode.Classic
    end

    if not v1.PlayerESP then
      for key15, value69 in pairs(v11) do
        if value69.Line then
          value69.Line.Visible = false
        end

        if value69.Billboard then
          value69.Billboard.Enabled = false
        end
      end

      return
    else
      local viewportSize2 = currentCamera.ViewportSize
      local y = viewportSize2.Y
      local v33 = viewportSize2.X / 2

      for key16, value70 in pairs(v11) do
        local character10 = key16.Character

        if not character10 or not character10.Parent then
          if value70.Line then
            value70.Line.Visible = false
          end

          if value70.Billboard then
            value70.Billboard.Enabled = false
          end
        else
          local head = character10:FindFirstChild("Head")

          local humanoidRootPart7 = head
          humanoidRootPart7 = head or character10:FindFirstChild("HumanoidRootPart")

          if not humanoidRootPart7 then
            if value70.Line then
              value70.Line.Visible = false
            end

            if value70.Billboard then
              value70.Billboard.Enabled = false
            end
          else
            local color2 = key16.Team and key16.TeamColor.Color or Color3.fromRGB(0, 255, 0)

            if v1.RainbowESP then
              local v34 = tick()
              color2 = Color3.fromHSV(v34 % 5 / 5, 1, 1)
            end

            local v35 = color2

            if v1.PlayerHighlight then
              if not character10:FindFirstChild("PlayerHighlight") then
                local playerHighlight = Instance.new("Highlight")
                playerHighlight.Name = "PlayerHighlight"
                playerHighlight.FillColor = v35
                playerHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                playerHighlight.Parent = character10
              end
            else
              local playerHighlight2 = character10:FindFirstChild("PlayerHighlight")

              if playerHighlight2 then
                playerHighlight2:Destroy()
              end
            end

            if v1.ShowNames then
              value70.Billboard.Enabled = true

              local label = value70.Label

              label.Text = v1.ShowDistance and key16.DisplayName .. string.format(
                " [%.0fm]",
                (humanoidRootPart7.Position - currentCamera.CFrame.Position).Magnitude
              ) or key16.DisplayName

              value70.Label.TextColor3 = v35
            else
              value70.Billboard.Enabled = false
            end

            if v1.ShowTracers then
              local v36, v37 = currentCamera:WorldToViewportPoint(humanoidRootPart7.Position)

              if v37 then
                local tracerFromTop = v1.TracerFromTop and 0 or y
                local vector = Vector2.new(v33, tracerFromTop)
                local vector2 = Vector2.new(v36.X, v36.Y)
                local v38 = (vector + vector2) / 2
                local deg = math.deg
                local atan2 = math.atan2
                local y2 = vector2.Y
                local y3 = vector.Y
                local x = vector2.X
                local x2 = vector.X
                local rotation = deg(atan2(y2 - y3, x - x2))

                value70.Line.Size = UDim2.new(0, (vector2 - vector).Magnitude, 0, 1)
                value70.Line.Position = UDim2.new(0, v38.X, 0, v38.Y)
                value70.Line.Rotation = rotation
                value70.Line.BackgroundColor3 = v35
                value70.Line.Visible = true
              else
                value70.Line.Visible = false
              end
            else
              value70.Line.Visible = false
            end
          end
        end
      end

      return
    end
  end)

  runService.Stepped:Connect(function()
    if v1.Noclip and localPlayer.Character then
      for index11, value71 in ipairs(localPlayer.Character:GetDescendants()) do
        if value71:IsA("BasePart") then
          if v9[value71] == nil then
            v9[value71] = value71.CanCollide
          end

          value71.CanCollide = false
        end
      end
    end

    if v1.AnchorOnly and localPlayer.Character then
      local humanoidRootPart8 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart8 then
        humanoidRootPart8.Anchored = true
      end
    end

    if v1.FreezeSelf and localPlayer.Character then
      local humanoidRootPart9 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart9 then
        humanoidRootPart9.Anchored = true
      end

      local humanoid7 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid7 then
        local animator2 = humanoid7:FindFirstChildOfClass("Animator")

        if animator2 then
          for index12, value72 in ipairs(animator2:GetPlayingAnimationTracks()) do
            if value72.Speed ~= 0 then
              v10[value72] = value72.Speed
              value72:AdjustSpeed(0)
            end
          end
        end
      end
    end
  end)

  userInputService.JumpRequest:Connect(function()
    if v1.InfJump and localPlayer.Character then
      local humanoid8 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid8 then
        humanoid8:ChangeState("Jumping")
      end
    end
  end)
end)
