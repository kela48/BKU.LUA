当地的玩家=游戏：GetService("玩家")
当地的coreGui=游戏：GetService("CoreGui")
当地的virtualInputManager=游戏：GetService("VirtualInputManager")
当地的replicatedStorage=游戏：GetService("ReplicatedStorage")
当地的runService=game:GetService("运行服务")
当地的userInputService=game:GetService("UserInputService")
当地的照明=游戏：GetService("照明")
当地的UI=loadstring(游戏：HttpGet("https://raw.githubusercontent.com/Baloksxin/BK-PE-SCRIPT/refs/heads/main/UI.txt"))()

当地的功能F1()
为键、值在……内对(工作区：GetDescendants())在
    如果值：Isa("型号") 然后
为key2，value2在...inner pairs(value:GetChildren())在
      end
    end
  end
end

当地的 localPlayer = players.LocalPlayer
当地的 currentCamera = workspace.CurrentCamera
当地的 walkSpeed = 16

如果 localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") 然后
  walkSpeed = localPlayer.Character.Humanoid.WalkSpeed
end

当地的 v1 = {
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
  AutoGold = false,
  ScrapESP = false,
  MonkeyESP = false,
  RecyclerESP = false,
  PlayerESP = false,
  ShowNames = false,
  ShowTracers = false,
  PlayerHighlight = false,
  RainbowESP = false,
  ShowDistance = false,
  TracerFromTop = false,
  CandyRainbow = false,
  CandyShowDistance = false,
  MonsterRainbow = false,
  MonsterShowDistance = false,
  ScrapRainbow = false,
  ScrapShowDistance = false,
  RecyclerRainbow = false,
  RecyclerShowDistance = false,
  LiquidRainbow = false,
  LiquidShowDistance = false,
  ExpandCollision = false,
  DisableGusBlind = false,
  ShowCollisionBox = false,
  CollisionSize = 8,
  AutoAimBloodMan = false,
  InstantInteract = false,
  HideBodies = false,
  DisableJumpscareAnim = false,
  DeathEffectEn = false,
  DisableWalkTo = false,
  LiquidESP = false,
  CandyESP = false,
}

local function f2()
  local playerScripts = localPlayer:FindFirstChild("PlayerScripts")

  if not playerScripts then
    return
  end

  for key3, value3 in pairs(playerScripts:GetChildren()) do
    if value3.Name == "Damage" and value3:IsA("LocalScript") then
      value3.Enabled = not v1.DisableWalkTo
    end
  end
end

local v2 = false
local v3 = {}

local function f3(key4)
  return key4 and v3[key4] == true
end

local function f4(parent)
  if not parent then
    return false
  end

  for index, value4 in ipairs(players:GetPlayers()) do
    if value4.Character == parent then
      return true
    end
  end

  return false
end

local function f5()
  table.clear(v3)

  local humanoid = localPlayer.Character
    and localPlayer.Character:FindFirstChildOfClass("Humanoid")

  if humanoid then
    v3[humanoid] = true
  end

  local currentCamera2 = workspace.CurrentCamera
  local cameraSubject = currentCamera2 and currentCamera2.CameraSubject
  local humanoid2

  if cameraSubject then
    if cameraSubject.ClassName == "Humanoid" then
      humanoid2 = cameraSubject
    else
      local model = cameraSubject:IsA("Model") and cameraSubject
        or cameraSubject:FindFirstAncestorWhichIsA("Model")

      humanoid2 = model and model:FindFirstChildOfClass("Humanoid")
    end

    if humanoid2 and not f4(humanoid2.Parent) then
      v3[humanoid2] = true
    end
  end
end

local v4

v4 = hookmetamethod(game, "__namecall", function(...)
  local v5 = { ... }

  if not v1.DisableWalkTo or v2 then
    return v4(unpack(v5))
  else
    v2 = true
    local v6 = getnamecallmethod()
    local v7 = v5[1]
    v2 = false

    if v6 == "MoveTo" and f3(v7) then
      return
    end

    return v4(unpack(v5))
  end
end)

local v8 = {}
local v9 = {}

local function f6(key5)
  if v8[key5] then
    return
  end

  v8[key5] = true
  v9[key5] = false

  key5:GetPropertyChangedSignal("WalkToPoint"):Connect(function()
    if not v1.DisableWalkTo or v9[key5] then
      return
    elseif not f3(key5) then
      return
    else
      v9[key5] = true

      local rootPart = key5.RootPart
        or key5.Parent and key5.Parent:FindFirstChild("HumanoidRootPart")

      key5.WalkToPoint = rootPart and rootPart.Position or Vector3.new()
      key5.WalkToPart = nil

      v9[key5] = false
      return
    end
  end)

  key5:GetPropertyChangedSignal("WalkToPart"):Connect(function()
    if not v1.DisableWalkTo or v9[key5] then
      return
    end

    if not f3(key5) then
      return
    end

    v9[key5] = true
    key5.WalkToPart = nil
    v9[key5] = false
  end)
end

task.spawn(function()
  while true do
    f5()

    for key6 in pairs(v3) do
      f6(key6)
    end

    task.wait(1)
  end
end)

local bkuSCRIPTWindow = ui:MakeWindow({
  Name = "BKU SCRIPT (致命猴子)",
  SubTitle = "By Baloksxin",
  HidePremium = true,
  SaveConfig = false,
  IntroText = "BKU SCRIPT",
})

ui:MakeNotification({ Name = "BKU SCRIPT", Content = "辛巴爸爸卢比呀", Time = 3 })
local v10 = {}

local function f7(value5)
  local playerScripts2 = localPlayer:FindFirstChild("PlayerScripts")

  if not playerScripts2 then
    return
  end

  for key7, value6 in pairs(playerScripts2:GetDescendants()) do
    if value6:IsA("LocalScript") then
      local v11 = string.lower(value6.Name)

      if string.find(v11, "play") and string.find(v11, "jumpscareanim") then
        if value5 then
          if value6.Disabled == false then
            value6.Disabled = true
            v10[value6] = true
          end
        elseif v10[value6] then
          value6.Disabled = false
          v10[value6] = nil
        end
      end
    end
  end
end

local v12 = {}

task.spawn(function()
  while true do
    task.wait(0.05)
    local v13 = #v12 - -1

    while true do
      v13 = -1 + v13

      if not (v13 >= 1 or false) then
        break
      end

      local v14 = v13
      local v15 = v12[v14]

      if v15.Part and v15.Part.Parent and v15.Target and v15.Target.Parent then
        if v15.IsBone then
          v15.Part.CFrame = v15.Target.WorldCFrame * v15.Offset
        end
      else
        table.remove(v12, v14)
      end
    end
  end
end)

local function makeExplosion(value7)
  local function makeExplosion2(character)
    local waitForChild = character:WaitForChild("Humanoid", 5)
    local v16 = not waitForChild
    local waitForChild2 = character:WaitForChild("HumanoidRootPart", 5)

    if v16 or not waitForChild2 then
      return
    end

    waitForChild.Died:Connect(function()
      local position

      if not v1.DeathEffectEn then
        return
      else
        position = waitForChild2.Position

        local explosion = Instance.new("Explosion")
        explosion.Position = position
        explosion.BlastRadius = 15
        explosion.BlastPressure = 0
        explosion.DestroyJointRadiusPercent = 0
        explosion.Parent = workspace

        task.delay(0.15, function()
          local raycastParams = RaycastParams.new()
          raycastParams.FilterType = Enum.RaycastFilterType.Exclude

          local v17 = { character }

          for index2, value8 in ipairs(character:GetDescendants()) do
            table.insert(v17, value8)
          end

          local overlapParams = OverlapParams.new()
          overlapParams.FilterType = Enum.RaycastFilterType.Exclude
          overlapParams.FilterDescendantsInstances = v17

          for index3, value9 in ipairs((workspace:GetPartBoundsInRadius(
            position, 12, overlapParams
          ))) do
            if value9.Name == "HumanoidRootPart" or value9.Name:lower() == "camera" then
              table.insert(v17, value9)
            end
          end

          raycastParams.FilterDescendantsInstances = v17
          raycastParams.IgnoreWater = true

          local v18 = position + Vector3.new(0, 1, 0)
          local count = 0

          while true do
            count = 1 + count

            if not (30 >= count) then
              break
            end

            local v19 = count / 30 * math.pi * 2 + (math.random() - 0.5) * 0.3
            local v20 = math.random(5, 16)
            local vector = Vector3.new(math.cos(v19), 0, math.sin(v19))
            local v21 = v18 + vector * 1

            local raycast = workspace:Raycast(v21, v18 + Vector3.new(
              vector.X * v20, math.random(-3, 4), vector.Z * v20
            ) - v21, raycastParams)

            if raycast and raycast.Instance then
              local instance = raycast.Instance

              if instance:IsA("BasePart") and not instance:IsDescendantOf(character)
                and instance.Name:lower() ~= "camera" and instance ~= workspace.Terrain then
                local position2 = raycast.Position
                local normal = raycast.Normal

                local part = Instance.new("Part")
                part.Size = Vector3.new(math.random(6, 18) / 10, 0.04, math.random(6, 18) / 10)
                part.Color = Color3.fromRGB(120 + math.random(-20, 20), 0, 0)
                part.Material = Enum.Material.SmoothPlastic
                part.Anchored = false
                part.Massless = true
                part.CanCollide = false
                part.CastShadow = false

                local specialMesh = Instance.new("SpecialMesh")
                specialMesh.MeshType = Enum.MeshType.Sphere

                specialMesh.Scale = Vector3.new(
                  1 + math.random(-3, 3) / 10, 0.15, 1 + math.random(-3, 3) / 10
                )

                specialMesh.Parent = part

                part.CFrame = CFrame.new(
                  position2 + normal * 0.02, position2 + normal * 0.02 + normal
                ) * CFrame.Angles(
                  math.pi / 2, math.random() * math.pi * 2, math.random() * 0.3
                )

                part.Parent = workspace

                local weldConstraint = Instance.new("WeldConstraint")
                weldConstraint.Part0 = part
                weldConstraint.Part1 = instance
                weldConstraint.Parent = part

                task.delay(45, function()
                  if part and part.Parent then
                    part:Destroy()
                  end
                end)
              end
            end
          end
        end)

        return
      end
    end)
  end

  if value7.Character then
    makeExplosion2(value7.Character)
  end

  value7.CharacterAdded:Connect(makeExplosion2)
end

local v22 = { Enabled = false, Speed = 1, Direction = 1 }

local v23 = {
  FOV = currentCamera.FieldOfView,
  Bright = lighting.Brightness,
  FogEnd = lighting.FogEnd,
  FogStart = lighting.FogStart,
  Ambient = lighting.Ambient,
  Clock = lighting.ClockTime,
  Speed = walkSpeed,
}

local v24 = {}
local v25 = {}

local bkuPlayerESPGui = Instance.new("ScreenGui")
bkuPlayerESPGui.Name = "BKU_PlayerESP_Gui"
bkuPlayerESPGui.ResetOnSpawn = false
bkuPlayerESPGui.IgnoreGuiInset = true

pcall(function() bkuPlayerESPGui.Parent = coreGui end)

if not bkuPlayerESPGui.Parent then
  bkuPlayerESPGui.Parent = localPlayer:WaitForChild("PlayerGui")
end

local v26 = {}
local v27 = {}

local function f8(player)
  if v26[player] then
    if v26[player].Line then
      v26[player].Line:Destroy()
    end

    if v26[player].Billboard then
      v26[player].Billboard:Destroy()
    end

    v26[player] = nil
  end
end

local v28 = {}
local v29 = {}

local function f9(character2)
  return character2:FindFirstChild("UpperTorso") or character2:FindFirstChild("LowerTorso")
    or character2:FindFirstChild("Torso") or character2:FindFirstChild("HumanoidRootPart")
    or character2:FindFirstChild("Head") or character2:FindFirstChildOfClass("BasePart")
end

local v30 = {}
local v31 = {}
local v32 = {}
local v33 = {}

local function f10()
  table.clear(v33)

  for key8, value10 in pairs(workspace:GetDescendants()) do
    if value10:IsA("Model") and value10:FindFirstChildOfClass("Humanoid") then
      table.insert(v33, value10)
    end
  end
end

local f11

local function f12(player2, p1)
  local v34 = p1
  v34 = v34 or 5

  task.spawn(function()
    local v35 = v34
    local count2 = 0

    while true do
      count2 = 1 + count2

      if not (v35 >= count2) then
        break
      end

      local v36 = count2

      if not player2 or not player2.Parent then
        return
      end

      f11(player2)

      if v26[player2] then
        return
      end

      task.wait(0.5 + v36 * 0.2)
    end
  end)
end

function f11(key9)
  f8(key9)

  if key9 == localPlayer then
    return
  else
    local character3 = key9.Character

    if not character3 then
      return
    else
      local v37 = f9(character3)

      if not v37 then
        return
      else
        local bkuPlayerNameESP = Instance.new("BillboardGui")
        bkuPlayerNameESP.Name = "BKU_PlayerName_ESP"
        bkuPlayerNameESP.Size = UDim2.new(0, 180, 0, 40)
        bkuPlayerNameESP.AlwaysOnTop = true
        bkuPlayerNameESP.Adornee = v37
        bkuPlayerNameESP.Enabled = false

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = key9.DisplayName
        nameLabel.TextColor3 = key9.Team and key9.TeamColor.Color or Color3.fromRGB(0, 255, 0)
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextStrokeTransparency = 0
        nameLabel.Parent = bkuPlayerNameESP

        bkuPlayerNameESP.Parent = character3

        local frame = Instance.new("Frame")
        frame.Name = "Tracer_" .. key9.Name
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.BorderSizePixel = 0
        frame.Visible = false
        frame.Parent = bkuPlayerESPGui

        v26[key9] = { Billboard = bkuPlayerNameESP, Label = nameLabel, Line = frame }
        return
      end
    end
  end
end

f10()

task.spawn(function()
  while true do
    f10()
    task.wait(3)
  end
end)

workspace.DescendantAdded:Connect(function(descendant)
  if descendant:IsA("Model") and descendant:FindFirstChildOfClass("Humanoid") then
    table.insert(v33, descendant)
  elseif descendant:IsA("Humanoid") and descendant.Parent and descendant.Parent:IsA("Model") then
    table.insert(v33, descendant.Parent)
  end
end)

local v38

task.spawn(function()
  while true do
    v38 = nil

    for index4, value11 in ipairs(v33) do
      if value11.Name == "BloodMan" then
        v38 = value11
        break
      end
    end

    task.wait(1)
  end
end)

local function f13()
  local character4 = localPlayer.Character

  if not character4 then
    return
  else
    local humanoid3 = character4:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character4:FindFirstChild("HumanoidRootPart")

    if not humanoid3 or not humanoidRootPart or humanoid3.Health <= 0 then
      return
    else
      local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
      local moveDirection = humanoid3.MoveDirection
      local walkSpeed2 = humanoid3.WalkSpeed

      if walkSpeed2 <= 0 or walkSpeed2 > 200 then
        return
      end

      if moveDirection.Magnitude < 0.05 then
        if math.abs(assemblyLinearVelocity.X) > 0.01
          or math.abs(assemblyLinearVelocity.Z) > 0.01 then
          humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, assemblyLinearVelocity.Y, 0)
        end
      else
        local v39 = moveDirection.Unit * walkSpeed2

        humanoidRootPart.AssemblyLinearVelocity = Vector3.new(
          v39.X, assemblyLinearVelocity.Y, v39.Z
        )
      end

      return
    end
  end
end

local function makeTextLabel(p2)
  if p2:IsA("Model") and p2.Name == "baloksxin_real" then
    if not p2:FindFirstChild("BKUCreator_Highlight_ESP") then
      local bkuCreatorHighlightESP = Instance.new("Highlight")
      bkuCreatorHighlightESP.Name = "BKUCreator_Highlight_ESP"
      bkuCreatorHighlightESP.FillColor = Color3.fromRGB(0, 120, 255)
      bkuCreatorHighlightESP.FillTransparency = 1
      bkuCreatorHighlightESP.OutlineColor = Color3.fromRGB(0, 120, 255)
      bkuCreatorHighlightESP.OutlineTransparency = 0
      bkuCreatorHighlightESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
      bkuCreatorHighlightESP.Parent = p2
    end

    if not p2:FindFirstChild("BKUCreator_Text_ESP") then
      local primaryPart = p2.PrimaryPart or p2:FindFirstChild("HumanoidRootPart")
        or p2:FindFirstChild("Head") or p2:FindFirstChildOfClass("BasePart")

      if primaryPart then
        local bkuCreatorTextESP = Instance.new("BillboardGui")
        bkuCreatorTextESP.Name = "BKUCreator_Text_ESP"
        bkuCreatorTextESP.Size = UDim2.new(0, 180, 0, 50)
        bkuCreatorTextESP.AlwaysOnTop = true
        bkuCreatorTextESP.ExtentsOffset = Vector3.new(0, 3.5, 0)
        bkuCreatorTextESP.Adornee = primaryPart
        bkuCreatorTextESP.Parent = p2

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
end

local connect

local function f14()
  if connect then
    connect:Disconnect()
    connect = nil
  end

  if not v22.Enabled then
    if localPlayer.Character then
      local humanoid4 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid4 then
        humanoid4.AutoRotate = true
      end
    end

    return
  end

  if localPlayer.Character then
    local humanoid5 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

    if humanoid5 then
      humanoid5.AutoRotate = false
    end
  end

  connect = runService.RenderStepped:Connect(function()
    if not v22.Enabled then
      return
    else
      local character5 = localPlayer.Character

      if not character5 then
        return
      else
        local humanoidRootPart2 = character5:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart2 then
          return
        else
          local v40 = math.rad(v22.Speed * v22.Direction)
          humanoidRootPart2.CFrame = humanoidRootPart2.CFrame * CFrame.Angles(0, v40, 0)
          return
        end
      end
    end
  end)
end

local function f15(character6, value12)
  if not character6 then
    return
  else
    local humanoid6 = character6:FindFirstChildOfClass("Humanoid")

    if humanoid6 then
      local animator = humanoid6:FindFirstChildOfClass("Animator")

      if animator then
        if value12 then
          for index5, value13 in ipairs(animator:GetPlayingAnimationTracks()) do
            v25[value13] = value13.Speed
            value13:AdjustSpeed(0)
          end
        else
          for index6, value14 in ipairs(animator:GetPlayingAnimationTracks()) do
            if v25[value14] then
              value14:AdjustSpeed(v25[value14])
            else
              value14:AdjustSpeed(1)
            end
          end

          table.clear(v25)
          humanoid6:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
      end
    end

    return
  end
end

local connect2 = nil

local function f16()
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

local v41 = false
local connect3

local function f17()
  if not v41 then
    return
  end

  if connect3 then
    connect3:Disconnect()
    connect3 = nil
  end

  v41 = false
end

local function f18()
  if v41 then
    return
  end

  connect3 = runService.Heartbeat:Connect(f13)
  v41 = true
end

local connect4 = nil
local v42 = {}

local function f19(value15)
  v1.InstantInteract = value15

  if connect4 then
    connect4:Disconnect()
    connect4 = nil
  end

  local function f20(key10)
    if not key10:IsA("ProximityPrompt") then
      return
    end

    if value15 then
      if not v42[key10] then
        v42[key10] = key10.HoldDuration
      end

      key10.HoldDuration = 0

      local connect5 = key10:GetPropertyChangedSignal("HoldDuration"):Connect(function()
        if key10.HoldDuration ~= 0 then
          key10.HoldDuration = 0
        end
      end)
    else
      local v43 = v42[key10]

      if v43 ~= nil then
        key10.HoldDuration = v43
        v42[key10] = nil
      end
    end
  end

  for index7, value16 in ipairs(game:GetDescendants()) do
    if value16:IsA("ProximityPrompt") then
      f20(value16)
    end
  end

  if value15 then
    connect4 = game.DescendantAdded:Connect(function(descendant2)
      if descendant2:IsA("ProximityPrompt") then
        f20(descendant2)
      end
    end)
  end
end

local v44 = {
  Screw = 1,
  Pipe = 1,
  Bucket = 1,
  Baterry = 1,
  Battery = 1,
  Gear = 1,
  Cleaner = 1,
  Emerald = 14,
  Amethyst = 10,
  AmethystCrystal = 10,
  Diamond = 7,
  Gold = 2,
  Copper = 1,
  Meat = 3,
}

local function f21(p3)
  local getPlayers = players:GetPlayers()

  for i = 1, #getPlayers do
    local v45 = getPlayers[i]

    if v45.Character and p3:IsDescendantOf(v45.Character) then
      return false
    else
      local backpack = v45:FindFirstChild("Backpack")

      if backpack and p3:IsDescendantOf(backpack) then
        return false
      end
    end
  end

  if p3:IsA("BasePart") then
    if p3.Transparency >= 0.99 or p3.Position.Y < -500 then
      return false
    end

    return true
  else
    local primaryPart2 = p3.PrimaryPart or p3:FindFirstChildWhichIsA("BasePart")

    if primaryPart2 then
      if primaryPart2.Transparency >= 0.99 or primaryPart2.Position.Y < -500 then
        return false
      end

      return true
    end

    if p3:GetPivot().Position.Y < -500 then
      return false
    end

    return true
  end
end

local scraps = workspace:FindFirstChild("Scraps")

local function f22(p4)
  if not (p4:IsA("BasePart") or p4:IsA("Model")) then
    return false
  elseif v44[p4.Name] then
    return true
  else
    if scraps and p4:IsDescendantOf(scraps) then
      return true
    end

    return false
  end
end

local function makeTextLabel2(text)
  local primaryPart3 = text:IsA("Model")
      and (text.PrimaryPart or text:FindFirstChildWhichIsA("BasePart"))
    or text

  if not primaryPart3 or not primaryPart3:IsA("BasePart") then
    return
  else
    if not text:FindFirstChild("Scrap_Box_ESP") then
      local scrapBoxESP = Instance.new("BoxHandleAdornment")
      scrapBoxESP.Name = "Scrap_Box_ESP"
      scrapBoxESP.Color3 = Color3.fromRGB(0, 255, 100)
      scrapBoxESP.Transparency = 0.5
      scrapBoxESP.Size = primaryPart3.Size
      scrapBoxESP.Adornee = primaryPart3
      scrapBoxESP.AlwaysOnTop = true
      scrapBoxESP.ZIndex = 0
      scrapBoxESP.Parent = text
    end

    if not text:FindFirstChild("Scrap_Text_ESP") then
      local scrapTextESP = Instance.new("BillboardGui")
      scrapTextESP.Name = "Scrap_Text_ESP"
      scrapTextESP.Size = UDim2.new(0, 150, 0, 40)
      scrapTextESP.AlwaysOnTop = true
      scrapTextESP.ExtentsOffset = Vector3.new(0, 2, 0)
      scrapTextESP.Adornee = primaryPart3
      scrapTextESP.Parent = text

      local textLabel2 = Instance.new("TextLabel")
      textLabel2.Size = UDim2.new(1, 0, 1, 0)
      textLabel2.BackgroundTransparency = 1
      textLabel2.Text = text.Name
      textLabel2.TextColor3 = Color3.fromRGB(0, 255, 100)
      textLabel2.TextSize = 14
      textLabel2.Font = Enum.Font.SourceSansBold
      textLabel2.TextStrokeTransparency = 0
      textLabel2.Parent = scrapTextESP
    end

    local scrapBoxESP2 = text:FindFirstChild("Scrap_Box_ESP")

    if scrapBoxESP2 then
      v28[scrapBoxESP2] = text
    end

    return
  end
end

local function makeTextLabel3(p5)
  local primaryPart4 = p5:IsA("Model")
      and (p5.PrimaryPart or p5:FindFirstChildWhichIsA("BasePart"))
    or p5

  if not primaryPart4 then
    return
  else
    if not p5:FindFirstChild("Recycler_Box_ESP") then
      local recyclerBoxESP = Instance.new("BoxHandleAdornment")
      recyclerBoxESP.Name = "Recycler_Box_ESP"
      recyclerBoxESP.Color3 = Color3.fromRGB(170, 85, 255)
      recyclerBoxESP.Transparency = 0.4
      recyclerBoxESP.Size = primaryPart4.Size
      recyclerBoxESP.Adornee = primaryPart4
      recyclerBoxESP.AlwaysOnTop = true
      recyclerBoxESP.ZIndex = 0
      recyclerBoxESP.Parent = p5
    end

    if not p5:FindFirstChild("Recycler_Text_ESP") then
      local recyclerTextESP = Instance.new("BillboardGui")
      recyclerTextESP.Name = "Recycler_Text_ESP"
      recyclerTextESP.Size = UDim2.new(0, 160, 0, 40)
      recyclerTextESP.AlwaysOnTop = true
      recyclerTextESP.ExtentsOffset = Vector3.new(0, 4, 0)
      recyclerTextESP.Adornee = primaryPart4
      recyclerTextESP.Parent = p5

      local textLabel3 = Instance.new("TextLabel")
      textLabel3.Size = UDim2.new(1, 0, 1, 0)
      textLabel3.BackgroundTransparency = 1
      textLabel3.Text = "废品回收机"
      textLabel3.TextColor3 = Color3.fromRGB(170, 85, 255)
      textLabel3.TextSize = 15
      textLabel3.Font = Enum.Font.SourceSansBold
      textLabel3.TextStrokeTransparency = 0
      textLabel3.Parent = recyclerTextESP
    end

    local recyclerBoxESP2 = p5:FindFirstChild("Recycler_Box_ESP")

    if recyclerBoxESP2 then
      v29[recyclerBoxESP2] = p5
    end

    return
  end
end

local function f23()
  for key11, value17 in pairs(workspace:GetDescendants()) do
    if f22(value17) and f21(value17) then
      makeTextLabel2(value17)
    end
  end
end

local function f24(value18)
  local scrapBoxESP3 = value18:FindFirstChild("Scrap_Box_ESP")
  local scrapTextESP2 = value18:FindFirstChild("Scrap_Text_ESP")

  if scrapBoxESP3 then
    v28[scrapBoxESP3] = nil
    scrapBoxESP3:Destroy()
  end

  if scrapTextESP2 then
    scrapTextESP2:Destroy()
  end
end

local v46 = {
  Lava = true,
  CrystalizedGoo = true,
  InfectionPart = true,
  Ground = true,
}

local function f25(p6)
  if not (p6:IsA("BasePart") or p6:IsA("Model")) then
    return false
  elseif v46[p6.Name] then
    return true
  else
    local v47 = string.lower(p6.Name)
    return string.find(v47, "infectionpart") ~= nil or string.find(v47, "ground") ~= nil
  end
end

local function makeTextLabel4(text2)
  local primaryPart5 = text2:IsA("Model")
      and (text2.PrimaryPart or text2:FindFirstChildWhichIsA("BasePart"))
    or text2

  local v48 = not primaryPart5
  local color

  if v48 or not primaryPart5:IsA("BasePart") then
    return
  else
    if text2.Name == "Lava" then
      color = Color3.fromRGB(255, 80, 0)
    elseif string.find(string.lower(text2.Name), "infectionpart") then
      color = Color3.fromRGB(120, 255, 120)
    elseif string.find(string.lower(text2.Name), "ground") then
      color = Color3.fromRGB(139, 69, 19)
    else
      color = Color3.fromRGB(0, 200, 255)
    end

    if not text2:FindFirstChild("Liquid_Highlight_ESP") then
      local liquidHighlightESP = Instance.new("Highlight")
      liquidHighlightESP.Name = "Liquid_Highlight_ESP"
      liquidHighlightESP.FillColor = color
      liquidHighlightESP.FillTransparency = 0.55
      liquidHighlightESP.OutlineColor = Color3.fromRGB(255, 255, 255)
      liquidHighlightESP.OutlineTransparency = 0
      liquidHighlightESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
      liquidHighlightESP.Parent = text2
    end

    if not text2:FindFirstChild("Liquid_Text_ESP") then
      local liquidTextESP = Instance.new("BillboardGui")
      liquidTextESP.Name = "Liquid_Text_ESP"
      liquidTextESP.Size = UDim2.new(0, 180, 0, 40)
      liquidTextESP.AlwaysOnTop = true
      liquidTextESP.ExtentsOffset = Vector3.new(0, 3, 0)
      liquidTextESP.Adornee = primaryPart5
      liquidTextESP.Parent = text2

      local textLabel4 = Instance.new("TextLabel")
      textLabel4.Size = UDim2.new(1, 0, 1, 0)
      textLabel4.BackgroundTransparency = 1
      textLabel4.Text = text2.Name
      textLabel4.TextColor3 = color
      textLabel4.TextSize = 15
      textLabel4.Font = Enum.Font.SourceSansBold
      textLabel4.TextStrokeTransparency = 0
      textLabel4.Parent = liquidTextESP
    end

    local liquidHighlightESP2 = text2:FindFirstChild("Liquid_Highlight_ESP")

    if liquidHighlightESP2 then
      v30[liquidHighlightESP2] = text2
    end

    return
  end
end

local function f26(p7)
  if p7:IsA("Model") or p7:IsA("BasePart") then
    local lower = p7.Name:lower()
    local humanoid7 = p7:IsA("Model") and p7:FindFirstChildOfClass("Humanoid") or nil

    if lower == "dead" or lower:find("dead") or lower:find("corpse") or lower:find("ragdoll")
      or lower:find("chimpragdoll") or humanoid7 and humanoid7.Health <= 0 then
      task.defer(function()
        if p7 and p7.Parent then
          p7.Archivable = true
          p7.Parent = nil
        end
      end)
    end
  end
end

local function makeTextLabel5(text3)
  if not text3:FindFirstChild("Monkey_Highlight_ESP") then
    local monkeyHighlightESP = Instance.new("Highlight")
    monkeyHighlightESP.Name = "Monkey_Highlight_ESP"
    monkeyHighlightESP.FillColor = Color3.fromRGB(255, 60, 0)
    monkeyHighlightESP.FillTransparency = 0.5
    monkeyHighlightESP.OutlineColor = Color3.fromRGB(255, 255, 255)
    monkeyHighlightESP.OutlineTransparency = 0
    monkeyHighlightESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    monkeyHighlightESP.Parent = text3
  end

  if not text3:FindFirstChild("Monkey_Text_ESP") then
    local humanoidRootPart3 = text3:FindFirstChild("HumanoidRootPart")
      or text3:FindFirstChild("Head") or text3:FindFirstChildOfClass("BasePart")

    if humanoidRootPart3 then
      local monkeyTextESP = Instance.new("BillboardGui")
      monkeyTextESP.Name = "Monkey_Text_ESP"
      monkeyTextESP.Size = UDim2.new(0, 180, 0, 50)
      monkeyTextESP.AlwaysOnTop = true
      monkeyTextESP.ExtentsOffset = Vector3.new(0, 3.5, 0)
      monkeyTextESP.Adornee = humanoidRootPart3
      monkeyTextESP.Parent = text3

      local textLabel5 = Instance.new("TextLabel")
      textLabel5.Size = UDim2.new(1, 0, 1, 0)
      textLabel5.BackgroundTransparency = 1
      textLabel5.Text = text3.Name
      textLabel5.TextColor3 = Color3.fromRGB(255, 60, 0)
      textLabel5.TextSize = 16
      textLabel5.Font = Enum.Font.SourceSansBold
      textLabel5.TextStrokeTransparency = 0
      textLabel5.Parent = monkeyTextESP
    end
  end

  local monkeyHighlightESP2 = text3:FindFirstChild("Monkey_Highlight_ESP")

  if monkeyHighlightESP2 then
    v27[monkeyHighlightESP2] = text3
  end
end

local function f27(p8)
  local proximityPrompt = p8:FindFirstChildOfClass("ProximityPrompt")
    or p8:FindFirstChildWhichIsA("ProximityPrompt", true)

  if proximityPrompt then
    fireproximityprompt(proximityPrompt)
  else
    virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
  end
end

local function makeTextLabel6(value19)
  if not value19 or not value19.Parent then
    return
  elseif value19:FindFirstChild("Candy_Highlight_ESP") then
    return
  else
    local candyHighlightESP = Instance.new("Highlight")
    candyHighlightESP.Name = "Candy_Highlight_ESP"
    candyHighlightESP.FillColor = Color3.fromRGB(255, 100, 200)
    candyHighlightESP.OutlineColor = Color3.fromRGB(255, 255, 255)
    candyHighlightESP.Parent = value19

    local candyTextESP = Instance.new("BillboardGui")
    candyTextESP.Name = "Candy_Text_ESP"
    candyTextESP.Size = UDim2.new(0, 100, 0, 30)
    candyTextESP.AlwaysOnTop = true

    candyTextESP.Adornee = value19:IsA("BasePart") and value19
      or value19:FindFirstChildOfClass("BasePart")

    candyTextESP.Parent = value19

    local textLabel6 = Instance.new("TextLabel")
    textLabel6.Size = UDim2.new(1, 0, 1, 0)
    textLabel6.BackgroundTransparency = 1
    textLabel6.Text = "Candy"
    textLabel6.TextColor3 = Color3.fromRGB(255, 100, 200)
    textLabel6.TextSize = 12
    textLabel6.Font = Enum.Font.SourceSansBold
    textLabel6.TextStrokeTransparency = 0
    textLabel6.Parent = candyTextESP

    v31[value19] = textLabel6
    return
  end
end

local v49 = {
  Lurker = true,
  Stalker = true,
  Kus = true,
  Dus = true,
  Gus = true,
  SandMan = true,
  Ashy = true,
  Lost = true,
  Scar = true,
  Billy = true,
  SandGuy = true,
  Meat = true,
  ["???"] = true,
  Taller = true,
  Slender = true,
  BloodMan = true,
  Lengthy = true,
  Gooba = true,
  john = true,
  Saw = true,
  Ghost = true,
  BigGuy = true,
  workshop = true,
  Workshop = true,
  Noxar = true,
  Fearful = true,
}

local function f28()
  local backpack2 = localPlayer:FindFirstChild("Backpack")

  if backpack2 then
    for key12, value20 in pairs(backpack2:GetChildren()) do
      if value20:IsA("Tool") and v44[value20.Name] then
        return true
      end
    end
  end

  local character7 = localPlayer.Character

  if character7 then
    for key13, value21 in pairs(character7:GetChildren()) do
      if value21:IsA("Tool") and v44[value21.Name] then
        return true
      end
    end

    return false
  end

  return false
end

local function f29(p9)
  if p9:IsA("Model") and p9:FindFirstChildOfClass("Humanoid") then
    if players:GetPlayerFromCharacter(p9) then
      return false
    end

    return v49[p9.Name] == true
  end

  return false
end

local function f30()
  local v50 = 0
  local v51

  local function f31(value22)
    if not value22 then
      return
    end

    if not (value22:IsA("BasePart") or value22:IsA("Model") or value22:IsA("Tool")) then
      return
    else
      local v52 = v44[value22.Name]

      if not v52 then
        return
      end

      if not f21(value22) then
        return
      end

      if v52 > v50 then
        v50 = v52
        v51 = value22
      end

      return
    end
  end

  local scraps2 = workspace:FindFirstChild("Scraps")

  if scraps2 then
    for index8, value23 in ipairs(scraps2:GetChildren()) do
      f31(value23)
    end
  end

  for index9, value24 in ipairs(workspace:GetChildren()) do
    if value24.Name ~= "Scraps" then
      f31(value24)
    end
  end

  return v51
end

local findFirstChild

local function f32()
  if findFirstChild and findFirstChild.Parent then
    return findFirstChild
  end

  findFirstChild = workspace:FindFirstChild("ScrapRecycler", true)
  return findFirstChild
end

local f33

local function f34()
  for key14, value25 in pairs(workspace:GetDescendants()) do
    f33(value25)
  end
end

function f33(p10)
  if not p10 or not p10.Parent then
    return
  end

  if p10.Name == "ScrapRecycler" and (p10:IsA("BasePart") or p10:IsA("Model")) then
    if v1.RecyclerESP then
      makeTextLabel3(p10)
    end
  elseif v1.MonkeyESP and f29(p10) then
    makeTextLabel5(p10)
  elseif v1.LiquidESP and f25(p10) then
    makeTextLabel4(p10)
  end
end

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

local tab2 = bkuSCRIPTWindow:MakeTab({ Name = "视觉", Icon = "rbxassetid://77348087165494" })
tab2:AddSection({ Name = "玩家Esp" })

tab2:AddToggle({
  Name = "开启 ESP",
  Callback = function(value26)
    v1.PlayerESP = value26

    if not value26 then
      for key15, value27 in pairs(v26) do
        if value27.Line then
          value27.Line.Visible = false
        end

        if value27.Billboard then
          value27.Billboard.Enabled = false
        end
      end

      for key16, value28 in pairs(players:GetPlayers()) do
        if value28.Character and value28.Character:FindFirstChild("PlayerHighlight") then
          value28.Character.PlayerHighlight:Destroy()
        end
      end
    end
  end,
})

tab2:AddToggle({ Name = "显示名字", Callback = function(value29) v1.ShowNames = value29 end })

tab2:AddToggle({
  Name = "显示射线",
  Callback = function(value30) v1.ShowTracers = value30 end,
})

tab2:AddToggle({
  Name = "显示高亮",
  Callback = function(value31) v1.PlayerHighlight = value31 end,
})

tab2:AddSection({ Name = "游戏类Esp" })

tab2:AddToggle({
  Name = "糖果Esp",
  Callback = function(value32)
    v1.CandyESP = value32

    if value32 then
      local candies = workspace:FindFirstChild("Candies")

      if candies then
        for index10, value33 in ipairs(candies:GetChildren()) do
          if value33.Name == "Candy" then
            makeTextLabel6(value33)
          end
        end
      end
    else
      for key17, value34 in pairs(v31) do
        local candyHighlightESP2 = key17:FindFirstChild("Candy_Highlight_ESP")
        local candyTextESP2 = key17:FindFirstChild("Candy_Text_ESP")

        if candyHighlightESP2 then
          candyHighlightESP2:Destroy()
        end

        if candyTextESP2 then
          candyTextESP2:Destroy()
        end
      end

      table.clear(v31)
      local candies2 = workspace:FindFirstChild("Candies")

      if candies2 then
        for index11, value35 in ipairs(candies2:GetChildren()) do
          local candyHighlightESP3 = value35:FindFirstChild("Candy_Highlight_ESP")
          local candyTextESP3 = value35:FindFirstChild("Candy_Text_ESP")

          if candyHighlightESP3 then
            candyHighlightESP3:Destroy()
          end

          if candyTextESP3 then
            candyTextESP3:Destroy()
          end
        end
      end
    end
  end,
})

tab2:AddToggle({
  Name = "开关怪物Esp",
  Callback = function(value36)
    v1.MonkeyESP = value36

    if value36 then
      f34()
    else
      for key18, value37 in pairs(v27) do
        if key18 and key18.Parent then
          key18:Destroy()
        end

        if value37 then
          local monkeyTextESP2 = value37:FindFirstChild("Monkey_Text_ESP")

          if monkeyTextESP2 then
            monkeyTextESP2:Destroy()
          end
        end
      end

      table.clear(v27)
    end
  end,
})

tab2:AddToggle({
  Name = "开关废品Esp",
  Callback = function(value38)
    v1.ScrapESP = value38

    if value38 then
      f23()
    else
      for key19, value39 in pairs(v28) do
        if key19 and key19.Parent then
          key19:Destroy()
        end

        if value39 then
          local scrapTextESP3 = value39:FindFirstChild("Scrap_Text_ESP")

          if scrapTextESP3 then
            scrapTextESP3:Destroy()
          end
        end
      end

      table.clear(v28)
    end
  end,
})

tab2:AddToggle({
  Name = "开关回收机Esp",
  Callback = function(value40)
    v1.RecyclerESP = value40

    if value40 then
      f34()
    else
      for key20, value41 in pairs(v29) do
        if key20 and key20.Parent then
          key20:Destroy()
        end

        if value41 then
          local recyclerTextESP2 = value41:FindFirstChild("Recycler_Text_ESP")

          if recyclerTextESP2 then
            recyclerTextESP2:Destroy()
          end
        end
      end

      table.clear(v29)
    end
  end,
})

tab2:AddToggle({
  Name = "液体Esp",
  Default = false,
  Callback = function(value42)
    v1.LiquidESP = value42

    if value42 then
      f34()
    else
      for key21, value43 in pairs(v30) do
        if key21 and key21.Parent then
          key21:Destroy()
        end

        if value43 then
          local liquidTextESP2 = value43:FindFirstChild("Liquid_Text_ESP")

          if liquidTextESP2 then
            liquidTextESP2:Destroy()
          end
        end
      end

-- https://discord.gg/AwGHNh7Z7T
      table.clear(v30)
    end
  end,
})

tab2:AddToggle({
  Name = "夜视模式",
  Callback = function(value44)
    v1.NightVis = value44

    if not value44 then
      local ambient = v23.Ambient
      local clock = v23.Clock

      lighting.Brightness = v23.Bright
      lighting.Ambient = ambient
      lighting.ClockTime = clock
      lighting.FogEnd = v23.FogEnd or 100000
      lighting.FogStart = v23.FogStart or 0
    end
  end,
})

local connect6

tab2:AddToggle({
  Name = "隐藏尸体",
  Default = false,
  Callback = function(value45)
    v1.HideBodies = value45

    if value45 then
      for index12, value46 in ipairs(workspace:GetDescendants()) do
        f26(value46)
      end

      if not connect6 then
        connect6 = workspace.DescendantAdded:Connect(function(descendant3)
          if v1.HideBodies then
            f26(descendant3)
          end
        end)
      end
    elseif connect6 then
      connect6:Disconnect()
      connect6 = nil
    end
  end,
})

local espTab = bkuSCRIPTWindow:MakeTab({
  Name = "ESP设置",
  Icon = "rbxassetid://77348087165494",
})

espTab:AddSection({ Name = "玩家" })

espTab:AddToggle({
  Name = "玩家彩虹色",
  Callback = function(value47) v1.RainbowESP = value47 end,
})

espTab:AddToggle({
  Name = "玩家显示距离",
  Callback = function(value48) v1.ShowDistance = value48 end,
})

espTab:AddDropdown({
  Name = "玩家射线位置",
  Options = { "从下方", "从上方" },
  Default = "从下方",
  Callback = function(value49) v1.TracerFromTop = value49 == "从上方" end,
})

espTab:AddSection({ Name = "糖果" })

espTab:AddToggle({
  Name = "糖果彩虹色",
  Callback = function(value50) v1.CandyRainbow = value50 end,
})

espTab:AddToggle({
  Name = "糖果显示距离",
  Callback = function(value51) v1.CandyShowDistance = value51 end,
})

espTab:AddSection({ Name = "怪物" })

espTab:AddToggle({
  Name = "怪物彩虹色",
  Callback = function(value52) v1.MonsterRainbow = value52 end,
})

espTab:AddToggle({
  Name = "怪物显示距离",
  Callback = function(value53) v1.MonsterShowDistance = value53 end,
})

espTab:AddSection({ Name = "废品" })

espTab:AddToggle({
  Name = "废品彩虹色",
  Callback = function(value54) v1.ScrapRainbow = value54 end,
})

espTab:AddToggle({
  Name = "废品显示距离",
  Callback = function(value55) v1.ScrapShowDistance = value55 end,
})

espTab:AddSection({ Name = "回收机" })

espTab:AddToggle({
  Name = "回收机彩虹色",
  Callback = function(value56) v1.RecyclerRainbow = value56 end,
})

espTab:AddToggle({
  Name = "回收机显示距离",
  Callback = function(value57) v1.RecyclerShowDistance = value57 end,
})

espTab:AddSection({ Name = "液体" })

espTab:AddToggle({
  Name = "液体彩虹色",
  Callback = function(value58) v1.LiquidRainbow = value58 end,
})

espTab:AddToggle({
  Name = "液体显示距离",
  Callback = function(value59) v1.LiquidShowDistance = value59 end,
})

local tab3 = bkuSCRIPTWindow:MakeTab({ Name = "玩家", Icon = "rbxassetid://77348087165494" })
tab3:AddSection({ Name = "属性修改" })

tab3:AddSlider({
  Name = "修改速度值",
  Min = 0,
  Max = 500,
  Default = v23.Speed,
  Increment = 1,
  ValueName = "",
  Callback = function(value60)
    v1.Speed = value60

    if v1.SpeedEn and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = value60
    end
  end,
})

tab3:AddToggle({
  Name = "开启速度修改",
  Callback = function(value61)
    v1.SpeedEn = value61

    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
      local humanoid8 = localPlayer.Character.Humanoid
      humanoid8.WalkSpeed = value61 and v1.Speed or v23.Speed
    end
  end,
})

tab3:AddSlider({
  Name = "修改FOV值",
  Min = 1,
  Max = 120,
  Default = v23.FOV,
  Increment = 1,
  ValueName = "",
  Callback = function(value62)
    v1.FOV = value62

    if v1.FOVEn and currentCamera then
      currentCamera.FieldOfView = value62
    end
  end,
})

tab3:AddToggle({
  Name = "开启 FOV 修改",
  Callback = function(value63)
    v1.FOVEn = value63
    local v53 = currentCamera
    v53.FieldOfView = value63 and v1.FOV or v23.FOV
  end,
})

tab3:AddSection({ Name = "其它类" })

tab3:AddToggle({
  Name = "防脚滑",
  Default = false,
  Callback = function(value64)
    if value64 then
      f18()
    else
      f17()
    end
  end,
})

tab3:AddToggle({
  Name = "第三人称",
  Callback = function(value65) v1.ThirdPerson = value65 end,
})

tab3:AddToggle({ Name = "无限跳跃", Callback = function(value66) v1.InfJump = value66 end })

tab3:AddToggle({
  Name = "穿墙模式",
  Callback = function(value67)
    v1.Noclip = value67

    if not value67 then
      for key22, value68 in pairs(v24) do
        if key22 and key22.Parent then
          key22.CanCollide = value68
        end
      end

      table.clear(v24)
    end
  end,
})

tab3:AddSection({ Name = "固定" })

tab3:AddToggle({
  Name = "固定自己",
  Callback = function(value69)
    v1.FreezeSelf = value69

    if localPlayer.Character then
      local humanoidRootPart4 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart4 then
        humanoidRootPart4.Anchored = value69
      end

      f15(localPlayer.Character, value69)
    end
  end,
})

tab3:AddToggle({
  Name = "固定自己(不固定动画)",
  Callback = function(value70)
    v1.AnchorOnly = value70

    if localPlayer.Character then
      local humanoidRootPart5 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart5 then
        humanoidRootPart5.Anchored = value70
      end
    end
  end,
})

tab3:AddSection({ Name = "跳跃" })

local v54 = 15

tab3:AddTextbox({
  Name = "跳跃高度",
  Default = "15",
  TextDisappear = false,
  Callback = function(value71) v54 = tonumber(value71) or 15 end,
})

tab3:AddButton({
  Name = "开启跳跃",
  Callback = function()
    local v55 = game

    loadstring("local jumph = " .. tostring(v54) .. " "
      .. v55:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/JB.LUA"))()
  end,
})

tab3:AddSection({ Name = "游戏的一些功能" })

tab3:AddToggle({
  Name = "自动朝向BloodMan",
  Default = false,
  Callback = function(value72)
    v1.AutoAimBloodMan = value72

    if not value72 and localPlayer.Character then
      local humanoid9 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid9 then
        humanoid9.AutoRotate = true
      end
    end
  end,
})

tab3:AddToggle({ Name = "立即互动", Callback = function(value73) f19(value73) end })

local tab4 = bkuSCRIPTWindow:MakeTab({ Name = "杂项", Icon = "rbxassetid://77348087165494" })
tab4:AddSection({ Name = "旋转" })

tab4:AddToggle({
  Name = "开启旋转",
  Default = false,
  Callback = function(value74)
    v22.Enabled = value74

    if value74 then
      f14()
    else
      if connect then
        connect:Disconnect()
        connect = nil
      end

      if localPlayer.Character then
        local humanoid10 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid10 then
          humanoid10.AutoRotate = true
        end
      end
    end
  end,
})

tab4:AddSlider({
  Name = "旋转速度",
  Min = 1,
  Max = 500,
  Default = 1,
  Increment = 1,
  ValueName = "度/帧",
  Callback = function(value75) v22.Speed = value75 end,
})

tab4:AddDropdown({
  Name = "旋转方向",
  Default = "顺时针",
  Options = { "顺时针", "逆时针" },
  Callback = function(value76) v22.Direction = value76 == "顺时针" and 1 or -1 end,
})

tab4:AddSection({ Name = "致命猴子功能" })

tab4:AddToggle({
  Name = "114514",
  Default = false,
  Callback = function(value77) v1.DeathEffectEn = value77 end,
})

tab4:AddButton({
  Name = "监控视角 (要坐到椅子上)",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/SecCamera.LUA"))()
  end,
})

tab4:AddButton({
  Name = "Bone骨架修改工具",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/6D%E9%AA%A8%E6%9E%B6%E5%8A%A8%E7%94%BB%E8%A6%86%E7%9B%96%E5%B7%A5%E5%85%B7.LUA"))()
  end,
})

tab4:AddToggle({
  Name = "开启刷钱",
  Default = false,
  Callback = function(value78)
    local autoGold = v1.AutoGold
    v1.AutoGold = value78

    if not value78 and autoGold then
      task.spawn(function()
        task.wait(0.05)

        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
          local humanoidRootPart6 = localPlayer.Character.HumanoidRootPart
          local v56 = f32()

          if v56 then
            local position3 = v56:IsA("BasePart") and v56.CFrame.Position
              or v56:GetPivot().Position

            humanoidRootPart6.CFrame = CFrame.new(position3 + Vector3.new(0, 4, 0))
          end
        end
      end)
    end
  end,
})

tab4:AddButton({
  Name = "跳杀镜头修改工具",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/CAMERA.LUA"))()
  end,
})

tab4:AddButton({
  Name = "复活",
  Callback = function() replicatedStorage.RequestRespawn:FireServer() end,
})

tab4:AddButton({
  Name = "删除安全阻挡(适合控制怪物时使用)",
  Callback = function()
    for index13, value79 in ipairs(workspace:GetDescendants()) do
      if value79:IsA("BasePart") or value79:IsA("MeshPart") then
        if value79.Name == "safe" or value79.Name == "SafeZone" then
          value79:Destroy()
        end
      elseif value79:IsA("Folder")
        and (value79.Name == "SafeZone" or value79.Name == "AntiVoid") then
        value79:Destroy()
      end
    end
  end,
})

tab4:AddToggle({
  Name = "禁用跳杀动画",
  Default = false,
  Callback = function(value80)
    v1.DisableJumpscareAnim = value80
    f7(value80)
  end,
})

tab4:AddToggle({
  Name = "控制怪物操控修复",
  Default = false,
  Callback = function(value81)
    v1.DisableWalkTo = value81
    f2()
  end,
})

tab4:AddButton({
  Name = "成为怪物脚本",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/BTM.LUA"))()
  end,
})

tab4:AddSection({ Name = "通用工具" })

tab4:AddButton({
  Name = "固定在NPC脚下",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/%E8%84%9A%E5%BA%95.LUA"))()
  end,
})

tab4:AddButton({
  Name = "NPC控制",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty38.lua"))()
  end,
})

tab4:AddButton({
  Name = "汉化游戏",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/AUTOTL.LUA"))()
  end,
})

tab4:AddButton({
  Name = "AnimHubV2",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Emerson2-creator/Scripts-Roblox/refs/heads/main/ScriptR6/AnimGuiV2.lua"))()
  end,
})

tab4:AddButton({
  Name = "声音修改工具",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/%E5%A3%B0%E9%9F%B3%E4%BF%AE%E6%94%B9.LUA"))()
  end,
})

tab4:AddButton({
  Name = "手机版Shiftlock",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/MobileShiftlock.LUA"))()
  end,
})

tab4:AddButton({
  Name = "Infinite Yield",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
  end,
})

tab4:AddButton({
  Name = "TP Tool",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/TP%20TOOL.LUA"))()
  end,
})

tab4:AddButton({
  Name = "飞行 GUI",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/Fly%20Gui.LUA"))()
  end,
})

tab4:AddButton({
  Name = "R15动作脚本",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Gazer-Ha/Free-emote/refs/heads/main/Delta%20mad%20stuffs"))()
  end,
})

local tab5 = bkuSCRIPTWindow:MakeTab({
  Name = "面部替换",
  Icon = "rbxassetid://77348087165494",
})

local function f35()
  if game.PlaceId == 121604956428340 then
    return true
  end

  if game.Name
    and (game.Name == "BTM" or string.find(string.lower(game.Name), "be the monster")) then
    return true
  end

  return false
end

local v57 = false
pcall(function() v57 = f35() end)

if not v57 then
  task.delay(3, function()
    if f35() and not v57 then
      v57 = true
    end
  end)
end

local btmTab = bkuSCRIPTWindow:MakeTab({ Name = "BTM", Icon = "rbxassetid://77348087165494" })
btmTab:AddSection({ Name = "功能有点少:{" })

local v58 = false

btmTab:AddToggle({
  Name = "扩大玩家碰撞箱",
  Callback = function(value82) v1.ExpandCollision = value82 end,
})

btmTab:AddToggle({
  Name = "显示碰撞箱",
  Callback = function(value83) v1.ShowCollisionBox = value83 end,
})

btmTab:AddToggle({
  Name = "关闭Gus眼瞎",
  Callback = function(value84)
    v1.DisableGusBlind = value84
    local playerScripts3 = localPlayer:FindFirstChild("PlayerScripts")

    if playerScripts3 then
      local gusBlind = playerScripts3:FindFirstChild("GusBlind")

      if gusBlind and gusBlind:IsA("LocalScript") then
        gusBlind.Enabled = not value84
      end
    end
  end,
})

btmTab:AddTextbox({
  Name = "碰撞箱大小",
  Default = tostring(v1.CollisionSize or 8),
  TextDisappear = false,
  Callback = function(value85)
    local v59 = tonumber(value85)

    if v59 and v59 > 0 then
      v1.CollisionSize = v59
    else
      ui:MakeNotification({ Name = "BTM", Content = "请输入大于0的数字", Time = 2 })
    end
  end,
})

btmTab:AddButton({
  Name = "一键清图",
  Callback = function()
    if not localPlayer.Team or localPlayer.Team.Name ~= "Monsters" then
      ui:MakeNotification({ Name = "BTM", Content = "你当前不在 Monsters 队伍", Time = 3 })
      return
    elseif v58 then
      return
    else
      v58 = true
      ui:MakeNotification({ Name = "BTM", Content = "开始清理...", Time = 2 })

      task.spawn(function()
        while v58 do
          local v60 = {}

          for index14, value86 in ipairs(players:GetPlayers()) do
            if value86 ~= localPlayer and value86.Team and value86.Team.Name == "Apes"
              and value86.Character and value86.Character:FindFirstChild("HumanoidRootPart") then
              table.insert(v60, value86)
            end
          end

          if #v60 == 0 then
            ui:MakeNotification({ Name = "BTM", Content = "已清除", Time = 3 })
            v58 = false
            break
          else
            local v61 = v60[1]

            local humanoidRootPart7 = localPlayer.Character
              and localPlayer.Character:FindFirstChild("HumanoidRootPart")

            local humanoidRootPart8 = v61.Character
              and v61.Character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart7 and humanoidRootPart8 then
              humanoidRootPart7.CFrame = humanoidRootPart8.CFrame * CFrame.new(0, 0, 2)
            end

            task.wait(0.3)
          end
        end
      end)

      return
    end
  end,
})

local v62 = "玩家"

tab5:AddDropdown({
  Name = "被替换的怪物:",
  Default = "玩家",
  Options = {
    "玩家", "Dus", "Gus", "Kus", "Lurker", "Lost", "Billy", "SandGuy", "Fearful", "Noxar",
    "Scar",
  },
  Callback = function(value87) v62 = value87 end,
})

local function f36()
  local v63 = {}

  if v62 == "玩家" then
    local character8 = localPlayer.Character

    if character8 then
      v63 = { character8 }
    end
  else
    for key23, value88 in pairs(workspace:GetDescendants()) do
      if value88:IsA("Model") and value88.Name == v62 then
        table.insert(v63, value88)
      end
    end
  end

  return v63
end

local function f37(value89, p11)
  if not value89 or not value89.Parent then
    return nil
  end

  return value89:FindFirstChild(p11)
end

local v64 = {
  ["玩家"] = "rbxassetid://71643158500420",
  Dus = "rbxassetid://88852856555845",
  Gus = nil,
  Kus = "rbxassetid://74281186300854",
  Lurker = "rbxassetid://76034961660325",
  Lost = "rbxassetid://106250773698639",
  Billy = "rbxassetid://98931014974628",
  SandGuy = "rbxassetid://116901141358719",
  Fearful = "rbxassetid://138410978543813",
  Noxar = "rbxassetid://76034961660325",
  Scar = "rbxassetid://109974013717205",
}

local function makeSurfaceAppearance(p12, p13)
  if not p12 then
    return false
  end

  local surfaceAppearance = p12:FindFirstChildOfClass("SurfaceAppearance")

  if not surfaceAppearance then
    surfaceAppearance = Instance.new("SurfaceAppearance")
    surfaceAppearance.Parent = p12
  end

  pcall(function()
    surfaceAppearance.ColorMap = p13
    surfaceAppearance.TexturePack = p13
  end)

  return true
end

local function f38(p14)
  local v65 = f36()

  if #v65 == 0 then
    return
  end

  for index15, value90 in ipairs(v65) do
    local v66 = f37(value90, "Face")

    if v66 then
      makeSurfaceAppearance(v66, p14)
    end
  end
end

for index16, value91 in ipairs({
  "玩家", "Dus", "Kus", "Lurker", "Lost", "Billy", "SandGuy", "Fearful", "Noxar", "Scar",
}) do
  local v67 = value91

  tab5:AddButton({
    Name = "替换为" .. v67,
    Callback = function()
      local v68 = v64[v67]

      if v68 then
        f38(v68)
      end
    end,
  })
end

tab5:AddButton({
  Name = "替换为Blud/Dlud",
  Callback = function() f38("rbxassetid://104550436314649") end,
})

tab5:AddButton({
  Name = "替换为Gooba",
  Callback = function() f38("rbxassetid://119860546697100") end,
})

tab5:AddButton({
  Name = "替换为John",
  Callback = function() f38("rbxassetid://112946382920572") end,
})

tab5:AddButton({
  Name = "替换为旧Dus",
  Callback = function() f38("rbxassetid://140264211931340") end,
})

tab5:AddButton({
  Name = "替换为Lengthy",
  Callback = function() f38("rbxassetid://123532679732291") end,
})

ui:Init()

task.spawn(function()
  local v69 = {}

  while true do
    if v1.ExpandCollision then
      for index17, value92 in ipairs(players:GetPlayers()) do
        if value92 ~= localPlayer and value92.Character then
          local humanoidRootPart9 = value92.Character:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart9 and humanoidRootPart9:IsA("BasePart") then
            if not v69[humanoidRootPart9] then
              v69[humanoidRootPart9] = humanoidRootPart9.Size
            end

            humanoidRootPart9.Size = Vector3.new(
              v1.CollisionSize, v1.CollisionSize, v1.CollisionSize
            )

            humanoidRootPart9.CanCollide = true

            local collisionVisual = humanoidRootPart9:FindFirstChild("CollisionVisual")

            if v1.ShowCollisionBox then
              if not collisionVisual then
                collisionVisual = Instance.new("Part")
                collisionVisual.Name = "CollisionVisual"

                collisionVisual.Size = Vector3.new(
                  v1.CollisionSize, v1.CollisionSize, v1.CollisionSize
                )

                collisionVisual.Anchored = false
                collisionVisual.CanCollide = false
                collisionVisual.Transparency = 0.6
                collisionVisual.Material = Enum.Material.ForceField
                collisionVisual.Color = Color3.fromRGB(100, 180, 230)
                collisionVisual.CFrame = humanoidRootPart9.CFrame

                local weldConstraint2 = Instance.new("WeldConstraint")
                weldConstraint2.Part0 = humanoidRootPart9
                weldConstraint2.Part1 = collisionVisual
                weldConstraint2.Parent = collisionVisual

                collisionVisual.Parent = humanoidRootPart9
              end

              collisionVisual.Size = Vector3.new(
                v1.CollisionSize, v1.CollisionSize, v1.CollisionSize
              )
            elseif collisionVisual then
              collisionVisual:Destroy()
            end
          end
        end
      end
    else
      for key24, value93 in pairs(v69) do
        if key24 and key24.Parent then
          key24.Size = value93
          local collisionVisual2 = key24:FindFirstChild("CollisionVisual")

          if collisionVisual2 then
            collisionVisual2:Destroy()
          end
        end
      end

      table.clear(v69)
    end

    task.wait(0.5)
  end
end)

task.spawn(function()
  while true do
    local v70 = tick()
    local fromHSV = Color3.fromHSV
    local v71 = currentCamera
    local v72 = fromHSV(v70 % 5 / 5, 1, 1)
    local position4 = v71 and currentCamera.CFrame.Position or Vector3.new()

    if v1.MonkeyESP then
      for key25, value94 in pairs(v27) do
        if not key25.Parent or not value94 or not value94.Parent then
          v27[key25] = nil
        else
          local monsterRainbow = v1.MonsterRainbow and v72

          local color2 = monsterRainbow
          color2 = monsterRainbow or Color3.fromRGB(255, 60, 0)

          key25.FillColor = color2
          local monkeyTextESP3 = value94:FindFirstChild("Monkey_Text_ESP")

          if monkeyTextESP3 then
            local textLabel7 = monkeyTextESP3:FindFirstChildOfClass("TextLabel")

            if textLabel7 then
              textLabel7.TextColor3 = color2

              if v1.MonsterShowDistance and value94:IsA("Model") then
                local humanoidRootPart10 = value94:FindFirstChild("HumanoidRootPart")

                local basePart = humanoidRootPart10
                basePart = humanoidRootPart10 or value94:FindFirstChildOfClass("BasePart")

                if basePart then
                  textLabel7.Text = value94.Name .. string.format(
                    " [%.0fm]", (basePart.Position - position4).Magnitude
                  )
                end
              end
            end
          end
        end
      end
    end

    if v1.ScrapESP then
      for key26, value95 in pairs(v28) do
        if not key26.Parent or not value95 or not value95.Parent then
          v28[key26] = nil
        else
          local scrapRainbow = v1.ScrapRainbow and v72

          local color3 = scrapRainbow
          color3 = scrapRainbow or Color3.fromRGB(255, 215, 0)

          key26.Color3 = color3
          local scrapTextESP4 = value95:FindFirstChild("Scrap_Text_ESP")

          if scrapTextESP4 then
            local textLabel8 = scrapTextESP4:FindFirstChildOfClass("TextLabel")

            if textLabel8 then
              textLabel8.TextColor3 = color3

              if v1.ScrapShowDistance and value95:IsA("BasePart") then
                textLabel8.Text = value95.Name .. string.format(
                  " [%.0fm]", (value95.Position - position4).Magnitude
                )
              end
            end
          end
        end
      end
    end

    if v1.RecyclerESP then
      for key27, value96 in pairs(v29) do
        if not key27.Parent or not value96 or not value96.Parent then
          v29[key27] = nil
        else
          local recyclerRainbow = v1.RecyclerRainbow and v72

          local color4 = recyclerRainbow
          color4 = recyclerRainbow or Color3.fromRGB(0, 255, 100)

          key27.Color3 = color4
          local recyclerTextESP3 = value96:FindFirstChild("Recycler_Text_ESP")

          if recyclerTextESP3 then
            local textLabel9 = recyclerTextESP3:FindFirstChildOfClass("TextLabel")

            if textLabel9 then
              textLabel9.TextColor3 = color4

              if v1.RecyclerShowDistance then
                local basePart2 = value96:IsA("BasePart") and value96

                local basePart3 = basePart2
                basePart3 = basePart2 or value96:FindFirstChildOfClass("BasePart")

                if basePart3 then
                  textLabel9.Text = "Recycler" .. string.format(
                    " [%.0fm]", (basePart3.Position - position4).Magnitude
                  )
                end
              end
            end
          end
        end
      end
    end

    if v1.LiquidESP then
      for key28, value97 in pairs(v30) do
        if not key28.Parent or not value97 or not value97.Parent then
          v30[key28] = nil
        else
          local liquidRainbow = v1.LiquidRainbow and v72

          local color5 = liquidRainbow
          color5 = liquidRainbow or Color3.fromRGB(0, 150, 255)

          key28.FillColor = color5
          local liquidTextESP3 = value97:FindFirstChild("Liquid_Text_ESP")

          if liquidTextESP3 then
            local textLabel10 = liquidTextESP3:FindFirstChildOfClass("TextLabel")

            if textLabel10 then
              textLabel10.TextColor3 = color5

              if v1.LiquidShowDistance then
                local basePart4 = value97:IsA("BasePart") and value97

                local basePart5 = basePart4
                basePart5 = basePart4 or value97:FindFirstChildOfClass("BasePart")

                if basePart5 then
                  textLabel10.Text = "Liquid" .. string.format(
                    " [%.0fm]", (basePart5.Position - position4).Magnitude
                  )
                end
              end
            end
          end
        end
      end
    end

    task.wait(0.3)
  end
end)

task.spawn(function()
  while true do
    if v1.CandyESP then
      local humanoidRootPart11 = localPlayer.Character
        and localPlayer.Character:FindFirstChild("HumanoidRootPart")

      local candies3 = workspace:FindFirstChild("Candies")

      if candies3 then
        for index18, value98 in ipairs(candies3:GetChildren()) do
          if value98.Name == "Candy" and not v31[value98] then
            makeTextLabel6(value98)
          end
        end
      end

      if v1.CandyShowDistance and humanoidRootPart11 then
        for key29, value99 in pairs(v31) do
          if not key29.Parent then
            v31[key29] = nil
          elseif value99 and value99.Parent then
            local position5 = key29:IsA("BasePart") and key29.Position
              or key29:IsA("Model") and key29:GetPivot().Position

            if position5 then
              local candyRainbow = v1.CandyRainbow

              local color6 = candyRainbow
              color6 = candyRainbow and Color3.fromHSV(tick() % 5 / 5, 1, 1)

              local color7 = color6
              color7 = color6 or Color3.fromRGB(255, 100, 200)

              value99.TextColor3 = color7

              value99.Text = string.format(
                "Candy [%.0fm]", (position5 - humanoidRootPart11.Position).Magnitude
              )

              local candyHighlightESP4 = key29:FindFirstChild("Candy_Highlight_ESP")

              if candyHighlightESP4 then
                candyHighlightESP4.FillColor = color7
              end
            end
          end
        end
      elseif v1.CandyRainbow then
        local color8 = Color3.fromHSV(tick() % 5 / 5, 1, 1)

        for key30, value100 in pairs(v31) do
          if not key30.Parent then
            v31[key30] = nil
          else
            if value100 then
              value100.TextColor3 = color8
            end

            local candyHighlightESP5 = key30:FindFirstChild("Candy_Highlight_ESP")

            if candyHighlightESP5 then
              candyHighlightESP5.FillColor = color8
            end
          end
        end
      end
    end

    task.wait(0.5)
  end
end)

task.spawn(function()
  while true do
    if v1.DisableGusBlind then
      local playerScripts4 = localPlayer:FindFirstChild("PlayerScripts")

      if playerScripts4 then
        local gusBlind2 = playerScripts4:FindFirstChild("GusBlind")

        if gusBlind2 and gusBlind2:IsA("LocalScript") and gusBlind2.Enabled then
          gusBlind2.Enabled = false
        end
      end
    end

    task.wait(1)
  end
end)

task.spawn(function()
  f1()

  for index19, value101 in ipairs(players:GetPlayers()) do
    makeExplosion(value101)
  end

  players.PlayerAdded:Connect(makeExplosion)

  for index20, value102 in ipairs(players:GetPlayers()) do
    local v73 = value102

    if v73 ~= localPlayer then
      if v73.Character then
        f12(v73)
      end

      v73.CharacterAdded:Connect(function() f12(v73) end)
      v73.CharacterRemoving:Connect(function() f8(v73) end)
    end
  end

  players.PlayerAdded:Connect(function(player3)
    if player3.Character then
      f12(player3)
    end

    player3.CharacterAdded:Connect(function() f12(player3) end)
    player3.CharacterRemoving:Connect(function() f8(player3) end)
  end)

  players.PlayerRemoving:Connect(function(player4) f8(player4) end)

  task.spawn(function()
    while true do
      task.wait(3)

      for index21, value103 in ipairs(players:GetPlayers()) do
        if value103 ~= localPlayer and value103.Character and not v26[value103] then
          f11(value103)
        end
      end
    end
  end)

  for index22, value104 in ipairs(workspace:GetDescendants()) do
    makeTextLabel(value104)
  end

  localPlayer.CharacterAdded:Connect(function(character9)
    table.clear(v24)
    table.clear(v25)

    task.wait(0.5)

    if v1.DisableWalkTo then
      f2()
    end

    if v22.Enabled then
      local humanoid11 = character9:FindFirstChildOfClass("Humanoid")

      if humanoid11 then
        humanoid11.AutoRotate = false
      end

      if connect then
        connect:Disconnect()
        connect = nil
      end

      f14()
    end

    if v41 then
      if connect3 then
        connect3:Disconnect()
        connect3 = nil
      end

      if character9:FindFirstChildOfClass("Humanoid")
        and character9:FindFirstChild("HumanoidRootPart") then
        connect3 = runService.Heartbeat:Connect(f13)
      end
    end
  end)

  workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    currentCamera = workspace.CurrentCamera
    f16()

    if v1.FOVEn and currentCamera then
      currentCamera.FieldOfView = v1.FOV
    end
  end)

  f16()

  workspace.DescendantAdded:Connect(function(descendant4)
    makeTextLabel(descendant4)
    f33(descendant4)

    if v1.ScrapESP and f22(descendant4) and f21(descendant4) then
      makeTextLabel2(descendant4)
    end

    if v1.HideBodies then
      f26(descendant4)
    end
  end)

  task.spawn(function()
    while true do
      if v1.DisableWalkTo then
        f2()
      end

      task.wait(1)
    end
  end)

  task.spawn(function()
    while true do
      if v1.ScrapESP then
        for key31, value105 in pairs(workspace:GetDescendants()) do
          if f22(value105) then
            if f21(value105) then
              makeTextLabel2(value105)
            else
              f24(value105)
            end
          end
        end
      end

      task.wait(4)
    end
  end)

  task.spawn(function()
    while true do
      if v1.AutoGold and localPlayer.Character
        and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart12 = localPlayer.Character.HumanoidRootPart
        local humanoid12 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid12 and humanoid12.Health > 0 then
          if f28() then
            local v74 = f32()

            if v74 then
              local position6 = v74:IsA("BasePart") and v74.CFrame.Position
                or v74:GetPivot().Position

              humanoidRootPart12.CFrame = CFrame.new(position6 + Vector3.new(0, 4, 0))
              f27(v74)
            end
          else
            local v75 = f30()

            if v75 then
              local position7 = v75:IsA("BasePart") and v75.CFrame.Position
                or v75:GetPivot().Position

              humanoidRootPart12.CFrame = CFrame.new(position7 + Vector3.new(0, 2, 0))
              f27(v75)
            end
          end
        end
      end

      task.wait(0.1)
    end
  end)

  local raycastParams2 = RaycastParams.new()
  raycastParams2.FilterType = Enum.RaycastFilterType.Blacklist

  runService.RenderStepped:Connect(function()
    if v1.SpeedEn then
      local humanoid13 = localPlayer.Character
        and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid13 then
        humanoid13.WalkSpeed = v1.Speed
      end
    end

    if v1.NightVis then
      local color9 = Color3.new(1, 1, 1)

      lighting.Brightness = 2
      lighting.Ambient = color9
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

    if v1.InfStamina then
      pcall(function()
        local stamina = localPlayer.PlayerGui.Stamina.Handler.Stamina

        if stamina.Value < 100 then
          stamina.Value = 100
        end
      end)
    end

    if v1.AutoAimBloodMan then
      local character10 = localPlayer.Character

      if character10 then
        local humanoidRootPart13 = character10:FindFirstChild("HumanoidRootPart")
        local humanoid14 = character10:FindFirstChildOfClass("Humanoid")

        if humanoidRootPart13 and humanoid14 then
          local v76 = v38

          if v76 and v76.Parent then
            local humanoidRootPart14 = v76:FindFirstChild("HumanoidRootPart")
              or v76:FindFirstChild("Head") or v76:FindFirstChildWhichIsA("BasePart")

            if humanoidRootPart14 then
              local v77 = humanoidRootPart13.Position + Vector3.new(0, 1, 0)
              local v78 = humanoidRootPart14.Position + Vector3.new(0, 1, 0)
              local unit = (v78 - v77).Unit
              local magnitude = (v78 - v77).Magnitude
              raycastParams2.FilterDescendantsInstances = { character10, v76 }

              if workspace:Raycast(v77, unit * magnitude, raycastParams2) then
                humanoid14.AutoRotate = not v22.Enabled
              else
                humanoid14.AutoRotate = false

                humanoidRootPart13.CFrame = CFrame.new(humanoidRootPart13.Position, Vector3.new(
                  v78.X, humanoidRootPart13.Position.Y, v78.Z
                ))
              end
            else
              humanoid14.AutoRotate = true
            end
          else
            humanoid14.AutoRotate = true
          end
        end
      end
    end

    if not v1.PlayerESP then
      for key32, value106 in pairs(v26) do
        if value106.Line then
          value106.Line.Visible = false
        end

        if value106.Billboard then
          value106.Billboard.Enabled = false
        end
      end

      return
    else
      local viewportSize = currentCamera.ViewportSize
      local v79 = viewportSize.X / 2
      local y = viewportSize.Y

      for key33, value107 in pairs(v26) do
        local character11 = key33.Character

        if not character11 or not character11.Parent then
          if value107.Line then
            value107.Line.Visible = false
          end

          if value107.Billboard then
            value107.Billboard.Enabled = false
          end
        else
          local head = character11:FindFirstChild("Head")

          local humanoidRootPart15 = head
          humanoidRootPart15 = head or character11:FindFirstChild("HumanoidRootPart")

          if not humanoidRootPart15 then
            if value107.Line then
              value107.Line.Visible = false
            end

            if value107.Billboard then
              value107.Billboard.Enabled = false
            end
          else
            local color10 = key33.Team and key33.TeamColor.Color or Color3.fromRGB(0, 255, 0)

            if v1.RainbowESP then
              local v80 = tick()
              color10 = Color3.fromHSV(v80 % 5 / 5, 1, 1)
            end

            if v1.PlayerHighlight then
              local playerHighlight = character11:FindFirstChild("PlayerHighlight")

              if not playerHighlight then
                playerHighlight = Instance.new("Highlight")
                playerHighlight.Name = "PlayerHighlight"
                playerHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                playerHighlight.Parent = character11
              end

              playerHighlight.FillColor = color10
            elseif character11:FindFirstChild("PlayerHighlight") then
              character11.PlayerHighlight:Destroy()
            end

            if v1.ShowNames or v1.ShowDistance then
              value107.Billboard.Enabled = true
              local displayName = key33.DisplayName

              if v1.ShowDistance then
                displayName = displayName .. string.format(
                  " [%.0fm]",
                  (humanoidRootPart15.Position - currentCamera.CFrame.Position).Magnitude
                )
              end

              value107.Label.Text = displayName
              value107.Label.TextColor3 = color10
            else
              value107.Billboard.Enabled = false
            end

            if v1.ShowTracers then
              local v81, v82 = currentCamera:WorldToViewportPoint(humanoidRootPart15.Position)

              if v82 then
                local tracerFromTop = v1.TracerFromTop and 0 or y
                local vector2 = Vector2.new(v79, tracerFromTop)
                local vector3 = Vector2.new(v81.X, v81.Y)
                local v83 = (vector2 + vector3) / 2
                local deg = math.deg
                local atan2 = math.atan2
                local y2 = vector3.Y
                local y3 = vector2.Y
                local x = vector3.X
                local x2 = vector2.X
                local rotation = deg(atan2(y2 - y3, x - x2))

                value107.Line.Size = UDim2.new(0, (vector3 - vector2).Magnitude, 0, 1)
                value107.Line.Position = UDim2.new(0, v83.X, 0, v83.Y)
                value107.Line.Rotation = rotation
                value107.Line.BackgroundColor3 = color10
                value107.Line.Visible = true
              else
                value107.Line.Visible = false
              end
            else
              value107.Line.Visible = false
            end
          end
        end
      end

      return
    end
  end)

  local function f39(character12)
    table.clear(v32)

    if not character12 then
      return
    end

    for index23, value108 in ipairs(character12:GetDescendants()) do
      if value108:IsA("BasePart") then
        table.insert(v32, value108)
      end
    end
  end

  if localPlayer.Character then
    f39(localPlayer.Character)
  end

  localPlayer.CharacterAdded:Connect(function(character13)
    task.defer(function() f39(character13) end)
  end)

  if localPlayer.Character then
    localPlayer.Character.DescendantAdded:Connect(function(descendant5)
      if descendant5:IsA("BasePart") then
        table.insert(v32, descendant5)
      end
    end)
  end

  localPlayer.CharacterAdded:Connect(function(character14)
    character14.DescendantAdded:Connect(function(descendant6)
      if descendant6:IsA("BasePart") then
        table.insert(v32, descendant6)
      end
    end)
  end)

  runService.Stepped:Connect(function()
    if v1.Noclip then
      local v84 = #v32 - -1

      while true do
        v84 = -1 + v84

        if not (v84 >= 1 or false) then
          break
        end

        local v85 = v84
        local v86 = v32[v85]

        if not v86 or not v86.Parent then
          table.remove(v32, v85)
        else
          if v24[v86] == nil then
            v24[v86] = v86.CanCollide
          end

          v86.CanCollide = false
        end
      end
    end

    if v1.AnchorOnly and localPlayer.Character then
      local humanoidRootPart16 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart16 then
        humanoidRootPart16.Anchored = true
      end
    end

    if v1.FreezeSelf and localPlayer.Character then
      local humanoidRootPart17 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart17 then
        humanoidRootPart17.Anchored = true
      end

      local humanoid15 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid15 then
        local animator2 = humanoid15:FindFirstChildOfClass("Animator")

        if animator2 then
          for index24, value109 in ipairs(animator2:GetPlayingAnimationTracks()) do
            if value109.Speed ~= 0 then
              v25[value109] = value109.Speed
              value109:AdjustSpeed(0)
            end
          end
        end
      end
    end
  end)

  userInputService.JumpRequest:Connect(function()
    if v1.InfJump and localPlayer.Character then
      local humanoid16 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid16 then
        humanoid16:ChangeState("Jumping")
      end
    end
  end)

  local v87 = {}

  task.spawn(function()
    while true do
      for key34, value110 in pairs(workspace:GetDescendants()) do
        if value110:IsA("Model") and value110.Name == "baloksxin_real" and not v87[value110] then
          makeTextLabel(value110)
          v87[value110] = true
        end
      end

      task.wait(15)
    end
  end)
end)
