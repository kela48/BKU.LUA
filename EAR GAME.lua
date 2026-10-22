--by kela_er
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local virtualInputManager = game:GetService("VirtualInputManager")
local replicatedStorage = game:GetService("ReplicatedStorage")
local coreGui = game:GetService("CoreGui")
local userInputService = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/BK-PE-SCRIPT/refs/heads/main/UI.txt"))()

local function f1()
  for key, value in pairs(workspace:GetDescendants()) do
    if value:IsA("Model") then
      for key2, value2 in pairs(value:GetChildren()) do
      end
    end
  end
end

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
  AutoGold = false,
  ScrapESP = false,
  CardESP = false,
  MonsterESP = false,
  AutoEarMoney = false,
  RecyclerESP = false,
  PlayerESP = false,
  ShowNames = false,
  ShowTracers = false,
  PlayerHighlight = false,
  RainbowESP = false,
  ShowDistance = false,
  TracerFromTop = false,
  InstantInteract = false,
  HideBodies = false,
  DeathEffectEn = false,
  DisableWalkTo = false,
  BandageESP = false,
  NoFallDamage = false,
  RemovePuddles = false,
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

local v2 = { Enabled = false, Speed = 1, Direction = 1 }

local v3 = {
  FOV = currentCamera.FieldOfView,
  Bright = lighting.Brightness,
  FogEnd = lighting.FogEnd,
  FogStart = lighting.FogStart,
  Ambient = lighting.Ambient,
  Clock = lighting.ClockTime,
  Speed = walkSpeed,
}

ESPCache = {}
local v4 = false

local function f3(parent)
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

local v5 = {}

local function f4(key4)
  return key4 and v5[key4] == true
end

local function f5()
  table.clear(v5)

  local humanoid = localPlayer.Character
    and localPlayer.Character:FindFirstChildOfClass("Humanoid")

  if humanoid then
    v5[humanoid] = true
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

    if humanoid2 and not f3(humanoid2.Parent) then
      v5[humanoid2] = true
    end
  end
end

local v6

v6 = hookmetamethod(game, "__namecall", function(...)
  local v7 = { ... }

  if not v1.DisableWalkTo or v4 then
    return v6(unpack(v7))
  else
    v4 = true
    local v8 = getnamecallmethod()
    local v9 = v7[1]
    v4 = false

    if v8 == "MoveTo" and f4(v9) then
      return
    end

    return v6(unpack(v7))
  end
end)

local v10 = {}
local v11 = {}

local function f6(key5)
  if v10[key5] then
    return
  end

  v10[key5] = true
  v11[key5] = false

  key5:GetPropertyChangedSignal("WalkToPoint"):Connect(function()
    if not v1.DisableWalkTo or v11[key5] then
      return
    elseif not f4(key5) then
      return
    else
      v11[key5] = true

      local rootPart = key5.RootPart
        or key5.Parent and key5.Parent:FindFirstChild("HumanoidRootPart")

      key5.WalkToPoint = rootPart and rootPart.Position or Vector3.new()
      key5.WalkToPart = nil

      v11[key5] = false
      return
    end
  end)

  key5:GetPropertyChangedSignal("WalkToPart"):Connect(function()
    if not v1.DisableWalkTo or v11[key5] then
      return
    end

    if not f4(key5) then
      return
    end

    v11[key5] = true
    key5.WalkToPart = nil
    v11[key5] = false
  end)
end

task.spawn(function()
  while true do
    f5()

    for key6 in pairs(v5) do
      f6(key6)
    end

    task.wait(1)
  end
end)

local v12 = {}
local v13 = {}
local v14 = {}
local v15 = {}

local function f7(character, value5)
  if not character then
    return
  else
    local humanoid3 = character:FindFirstChildOfClass("Humanoid")

    if humanoid3 then
      local animator = humanoid3:FindFirstChildOfClass("Animator")

      if animator then
        if value5 then
          for index2, value6 in ipairs(animator:GetPlayingAnimationTracks()) do
            v14[value6] = value6.Speed
            value6:AdjustSpeed(0)
          end
        else
          for index3, value7 in ipairs(animator:GetPlayingAnimationTracks()) do
            if v14[value7] then
              value7:AdjustSpeed(v14[value7])
            else
              value7:AdjustSpeed(1)
            end
          end

          table.clear(v14)
          humanoid3:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
      end
    end

    return
  end
end

task.spawn(function()
  while true do
    task.wait(0.1)
    local v16 = #v15 - -1

    while true do
      v16 = -1 + v16

      if not (1 <= v16 or false) then
        break
      end

      local v17 = v16
      local v18 = v15[v17]

      if v18.Part and v18.Part.Parent and v18.Target and v18.Target.Parent then
        if v18.IsBone then
          v18.Part.CFrame = v18.Target.WorldCFrame * v18.Offset
        end
      else
        table.remove(v15, v17)
      end
    end
  end
end)

local connect = nil
local v19 = {}

local function f8(value8)
  v1.InstantInteract = value8

  if connect then
    connect:Disconnect()
    connect = nil
  end

  local function f9(key7)
    if not key7:IsA("ProximityPrompt") then
      return
    end

    if value8 then
      if not v19[key7] then
        v19[key7] = key7.HoldDuration
      end

      key7.HoldDuration = 0

      local connect2 = key7:GetPropertyChangedSignal("HoldDuration"):Connect(function()
        if key7.HoldDuration ~= 0 then
          key7.HoldDuration = 0
        end
      end)
    else
      local v20 = v19[key7]

      if v20 ~= nil then
        key7.HoldDuration = v20
        v19[key7] = nil
      end
    end
  end

  for index4, value9 in ipairs(game:GetDescendants()) do
    if value9:IsA("ProximityPrompt") then
      f9(value9)
    end
  end

  if value8 then
    connect = game.DescendantAdded:Connect(function(descendant)
      if descendant:IsA("ProximityPrompt") then
        f9(descendant)
      end
    end)
  end
end

local function makeExplosion(value10)
  local function makeExplosion2(character2)
    local waitForChild = character2:WaitForChild("Humanoid", 5)
    local v21 = not waitForChild
    local waitForChild2 = character2:WaitForChild("HumanoidRootPart", 5)

    if v21 or not waitForChild2 then
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

          local v22 = { character2 }

          for index5, value11 in ipairs(character2:GetDescendants()) do
            table.insert(v22, value11)
          end

          local overlapParams = OverlapParams.new()
          overlapParams.FilterType = Enum.RaycastFilterType.Exclude
          overlapParams.FilterDescendantsInstances = v22

          for index6, value12 in ipairs((workspace:GetPartBoundsInRadius(
            position, 12, overlapParams
          ))) do
            if value12.Name == "HumanoidRootPart" or value12.Name:lower() == "camera" then
              table.insert(v22, value12)
            end
          end

          raycastParams.FilterDescendantsInstances = v22
          raycastParams.IgnoreWater = true

          local v23 = position + Vector3.new(0, 1, 0)
          local count = 0

          while true do
            count = 1 + count

            if not (count <= 30) then
              break
            end

            local v24 = count / 30 * math.pi * 2 + (math.random() - 0.5) * 0.3
            local v25 = math.random(5, 16)
            local vector = Vector3.new(math.cos(v24), 0, math.sin(v24))
            local v26 = v23 + vector * 1

            local raycast = workspace:Raycast(v26, v23 + Vector3.new(
              vector.X * v25, math.random(-3, 4), vector.Z * v25
            ) - v26, raycastParams)

            if raycast and raycast.Instance then
              local instance = raycast.Instance

              if instance:IsA("BasePart") and not instance:IsDescendantOf(character2)
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

                task.delay(30, function()
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

  if value10.Character then
    makeExplosion2(value10.Character)
  end

  value10.CharacterAdded:Connect(makeExplosion2)
end

local function makeTextLabel(p1)
  local v27 = { "baloksxin_real" }
  local v28 = false

  if p1:IsA("Model") then
    for index7, value13 in ipairs(v27) do
      if p1.Name == value13 or string.find(p1.Name, value13) then
        v28 = true
        break
      end
    end
  end

  if not v28 then
    return
  else
    local function makeTextLabel2()
      if not p1 or not p1.Parent then
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
          or p1:FindFirstChild("Head") or p1:FindFirstChildOfClass("BasePart")

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

    makeTextLabel2()
    return
  end
end

local connect3

local function f10()
  if connect3 then
    connect3:Disconnect()
    connect3 = nil
  end

  if not v2.Enabled then
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

  connect3 = runService.RenderStepped:Connect(function()
    if not v2.Enabled then
      return
    else
      local character3 = localPlayer.Character

      if not character3 then
        return
      else
        local humanoidRootPart = character3:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart then
          return
        else
          local v29 = math.rad(v2.Speed * v2.Direction)
          local cframe = CFrame.Angles(0, v29, 0)
          humanoidRootPart.CFrame = humanoidRootPart.CFrame * cframe
          return
        end
      end
    end
  end)
end

local v30 = false
local connect4 = nil

local function f11()
  if not v30 then
    return
  end

  if connect4 then
    connect4:Disconnect()
    connect4 = nil
  end

  v30 = false
end

local function f12()
  local character4 = localPlayer.Character

  if not character4 then
    return
  else
    local humanoid6 = character4:FindFirstChildOfClass("Humanoid")
    local v31 = not humanoid6
    local humanoidRootPart2 = character4:FindFirstChild("HumanoidRootPart")

    if v31 or not humanoidRootPart2 then
      return
    elseif humanoid6.Health <= 0 then
      return
    else
      local assemblyLinearVelocity = humanoidRootPart2.AssemblyLinearVelocity
      local moveDirection = humanoid6.MoveDirection
      local walkSpeed2 = humanoid6.WalkSpeed

      if walkSpeed2 <= 0 or walkSpeed2 > 200 then
        return
      end

      if moveDirection.Magnitude < 0.05 then
        if math.abs(assemblyLinearVelocity.X) > 0.01
          or math.abs(assemblyLinearVelocity.Z) > 0.01 then
          humanoidRootPart2.AssemblyLinearVelocity = Vector3.new(0, assemblyLinearVelocity.Y, 0)
        end
      else
        local v32 = moveDirection.Unit * walkSpeed2

        humanoidRootPart2.AssemblyLinearVelocity = Vector3.new(
          v32.X, assemblyLinearVelocity.Y, v32.Z
        )
      end

      return
    end
  end
end

local function f13()
  if v30 then
    return
  end

  connect4 = runService.Heartbeat:Connect(f12)
  v30 = true
end

local v33 = {
  Screw = 1,
  Pipe = 1,
  Bucket = 1,
  Baterry = 1,
  Battery = 1,
  Gear = 1,
  Cleaner = 1,
  Emerald = 14,
  Diamond = 7,
  Gold = 2,
  Copper = 1,
  Meat = 3,
}

local function makeTextLabel3(text)
  if not text:IsA("MeshPart") then
    return
  end

  if not text:FindFirstChild("Scrap_Box_ESP") then
    local scrapBoxESP = Instance.new("BoxHandleAdornment")
    scrapBoxESP.Name = "Scrap_Box_ESP"
    scrapBoxESP.Color3 = Color3.fromRGB(0, 255, 100)
    scrapBoxESP.Transparency = 0.5
    scrapBoxESP.Size = text.Size
    scrapBoxESP.Adornee = text
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
    scrapTextESP.Adornee = text
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
end

local function makeTextLabel4(p2)
  if not p2:FindFirstChild("Recycler_Box_ESP") then
    local primaryPart2 = p2:IsA("Model")
        and (p2.PrimaryPart or p2:FindFirstChildWhichIsA("BasePart"))
      or p2

    if primaryPart2 then
      local recyclerBoxESP = Instance.new("BoxHandleAdornment")
      recyclerBoxESP.Name = "Recycler_Box_ESP"
      recyclerBoxESP.Color3 = Color3.fromRGB(170, 85, 255)
      recyclerBoxESP.Transparency = 0.4
      recyclerBoxESP.Size = primaryPart2.Size
      recyclerBoxESP.Adornee = primaryPart2
      recyclerBoxESP.AlwaysOnTop = true
      recyclerBoxESP.ZIndex = 0
      recyclerBoxESP.Parent = p2
    end
  end

  if not p2:FindFirstChild("Recycler_Text_ESP") then
    local primaryPart3 = p2:IsA("Model")
        and (p2.PrimaryPart or p2:FindFirstChildWhichIsA("BasePart"))
      or p2

    if primaryPart3 then
      local recyclerTextESP = Instance.new("BillboardGui")
      recyclerTextESP.Name = "Recycler_Text_ESP"
      recyclerTextESP.Size = UDim2.new(0, 160, 0, 40)
      recyclerTextESP.AlwaysOnTop = true
      recyclerTextESP.ExtentsOffset = Vector3.new(0, 4, 0)
      recyclerTextESP.Adornee = primaryPart3
      recyclerTextESP.Parent = p2

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
  end
end

local f14

local function f15()
  local v34 = 0
  local v35 = workspace
  local v36

  for key8, value14 in pairs(v35:GetDescendants()) do
    if v33[value14.Name] and f14(value14) then
      local v37 = v33[value14.Name]

      if v37 > v34 then
        v36 = value14
        v34 = v37
      end
    end
  end

  return v36
end

local function f16(p3)
  if p3:IsA("Model") and p3:FindFirstChildOfClass("Humanoid") then
    for key9, value15 in pairs(players:GetPlayers()) do
      if value15.Character == p3 then
        return false
      end
    end

    local name = p3.Name

    if name == "Slender" or name == "Claw" or name == "Crawly" or name == "SawRunner"
      or name == "Faceless" then
      return true
    end

    return false
  end

  return false
end

local function makeTextLabel5(text2)
  if not text2:FindFirstChild("Card_Box_ESP") then
    local cardBoxESP = Instance.new("BoxHandleAdornment")
    cardBoxESP.Name = "Card_Box_ESP"
    cardBoxESP.Color3 = Color3.fromRGB(0, 200, 255)
    cardBoxESP.Transparency = 0.4
    cardBoxESP.Size = text2.Size
    cardBoxESP.Adornee = text2
    cardBoxESP.AlwaysOnTop = true
    cardBoxESP.ZIndex = 0
    cardBoxESP.Parent = text2
  end

  if not text2:FindFirstChild("Card_Text_ESP") then
    local cardTextESP = Instance.new("BillboardGui")
    cardTextESP.Name = "Card_Text_ESP"
    cardTextESP.Size = UDim2.new(0, 150, 0, 40)
    cardTextESP.AlwaysOnTop = true
    cardTextESP.ExtentsOffset = Vector3.new(0, 2, 0)
    cardTextESP.Adornee = text2
    cardTextESP.Parent = text2

    local textLabel4 = Instance.new("TextLabel")
    textLabel4.Size = UDim2.new(1, 0, 1, 0)
    textLabel4.BackgroundTransparency = 1
    textLabel4.Text = text2.Name
    textLabel4.TextColor3 = Color3.fromRGB(0, 200, 255)
    textLabel4.TextSize = 15
    textLabel4.Font = Enum.Font.SourceSansBold
    textLabel4.TextStrokeTransparency = 0
    textLabel4.Parent = cardTextESP
  end
end

local function f17(p4)
  return p4:IsA("MeshPart") and v33[p4.Name] ~= nil
end

function f14(p5)
  local getPlayers = players:GetPlayers()

  for i = 1, #getPlayers do
    local v38 = getPlayers[i]

    if v38.Character and p5:IsDescendantOf(v38.Character) then
      return false
    else
      local backpack = v38:FindFirstChild("Backpack")

      if backpack and p5:IsDescendantOf(backpack) then
        return false
      end
    end
  end

  if p5:IsA("BasePart") then
    if p5.Transparency >= 0.99 or p5.Position.Y < -500 then
      return false
    end

    return true
  else
    local primaryPart4 = p5.PrimaryPart or p5:FindFirstChildWhichIsA("BasePart")

    if primaryPart4 then
      if primaryPart4.Transparency >= 0.99 or primaryPart4.Position.Y < -500 then
        return false
      end

      return true
    end

    if p5:GetPivot().Position.Y < -500 then
      return false
    end

    return true
  end
end

local function makeTextLabel6(value16)
  if not value16:FindFirstChild("Bandage_Box_ESP") then
    local bandageBoxESP = Instance.new("BoxHandleAdornment")
    bandageBoxESP.Name = "Bandage_Box_ESP"
    bandageBoxESP.Color3 = Color3.fromRGB(0, 255, 0)
    bandageBoxESP.Transparency = 0.4
    bandageBoxESP.Size = value16.Size
    bandageBoxESP.Adornee = value16
    bandageBoxESP.AlwaysOnTop = true
    bandageBoxESP.ZIndex = 0
    bandageBoxESP.Parent = value16
  end

  if not value16:FindFirstChild("Bandage_Text_ESP") then
    local bandageTextESP = Instance.new("BillboardGui")
    bandageTextESP.Name = "Bandage_Text_ESP"
    bandageTextESP.Size = UDim2.new(0, 150, 0, 40)
    bandageTextESP.AlwaysOnTop = true
    bandageTextESP.ExtentsOffset = Vector3.new(0, 2, 0)
    bandageTextESP.Adornee = value16
    bandageTextESP.Parent = value16

    local textLabel5 = Instance.new("TextLabel")
    textLabel5.Size = UDim2.new(1, 0, 1, 0)
    textLabel5.BackgroundTransparency = 1
    textLabel5.Text = "绷带"
    textLabel5.TextColor3 = Color3.fromRGB(0, 255, 0)
    textLabel5.TextSize = 15
    textLabel5.Font = Enum.Font.SourceSansBold
    textLabel5.TextStrokeTransparency = 0
    textLabel5.Parent = bandageTextESP
  end
end

local f18

local function f19(p6)
  if not v1.ScrapESP then
    return
  end

  if f17(p6) then
    if f14(p6) then
      makeTextLabel3(p6)
    else
      f18(p6)
    end
  end
end

function f18(p7)
  local scrapBoxESP2 = p7:FindFirstChild("Scrap_Box_ESP")
  local scrapTextESP2 = p7:FindFirstChild("Scrap_Text_ESP")

  if scrapBoxESP2 then
    scrapBoxESP2:Destroy()
  end

  if scrapTextESP2 then
    scrapTextESP2:Destroy()
  end
end

local function f20(p8)
  local proximityPrompt = p8:FindFirstChildOfClass("ProximityPrompt")
    or p8:FindFirstChildWhichIsA("ProximityPrompt", true)

  if proximityPrompt then
    fireproximityprompt(proximityPrompt)
  else
    virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
  end
end

local function makeTextLabel7(text3)
  if not text3:FindFirstChild("Monster_Highlight_ESP") then
    local monsterHighlightESP = Instance.new("Highlight")
    monsterHighlightESP.Name = "Monster_Highlight_ESP"
    monsterHighlightESP.FillColor = Color3.fromRGB(255, 0, 0)
    monsterHighlightESP.FillTransparency = 0.4
    monsterHighlightESP.OutlineColor = Color3.fromRGB(255, 255, 255)
    monsterHighlightESP.OutlineTransparency = 0
    monsterHighlightESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    monsterHighlightESP.Parent = text3
  end

  if not text3:FindFirstChild("Monster_Text_ESP") then
    local primaryPart5 = text3.PrimaryPart or text3:FindFirstChildWhichIsA("BasePart")

    if primaryPart5 then
      local monsterTextESP = Instance.new("BillboardGui")
      monsterTextESP.Name = "Monster_Text_ESP"
      monsterTextESP.Size = UDim2.new(0, 160, 0, 40)
      monsterTextESP.AlwaysOnTop = true
      monsterTextESP.ExtentsOffset = Vector3.new(0, 4, 0)
      monsterTextESP.Adornee = primaryPart5
      monsterTextESP.Parent = text3

      local textLabel6 = Instance.new("TextLabel")
      textLabel6.Size = UDim2.new(1, 0, 1, 0)
      textLabel6.BackgroundTransparency = 1
      textLabel6.Text = text3.Name
      textLabel6.TextColor3 = Color3.fromRGB(255, 0, 0)
      textLabel6.TextSize = 15
      textLabel6.Font = Enum.Font.SourceSansBold
      textLabel6.TextStrokeTransparency = 0
      textLabel6.Parent = monsterTextESP
    end
  end
end

local function f21(p9)
  if p9:IsA("Model") or p9:IsA("BasePart") then
    local lower = p9.Name:lower()
    local humanoid7 = p9:IsA("Model") and p9:FindFirstChildOfClass("Humanoid") or nil

    if lower:find("dead") or lower:find("corpse") or lower:find("ragdoll")
      or lower:find("chimpragdoll") or humanoid7 and humanoid7.Health <= 0 then
      task.defer(function()
        if p9 and p9.Parent then
          p9.Archivable = true
          p9.Parent = nil
        end
      end)
    end
  end
end

local recycleItem = nil

local function f22()
  if recycleItem and recycleItem.Parent then
    return recycleItem
  end

  recycleItem = workspace:FindFirstChild("Recycle item")
  return recycleItem
end

local function f23()
  local character5 = localPlayer.Character
  local backpack2 = localPlayer:FindFirstChild("Backpack")

  if backpack2 then
    for key10, value17 in pairs(backpack2:GetChildren()) do
      if value17:IsA("Tool") and v33[value17.Name] then
        return true
      end
    end
  end

  if character5 then
    for key11, value18 in pairs(character5:GetChildren()) do
      if value18:IsA("Tool") and v33[value18.Name] then
        return true
      end
    end

    return false
  end

  return false
end

local function f24(p10)
  if not p10 or not p10.Parent then
    return
  end

  if p10.Name == "ScrapRecycler" and (p10:IsA("BasePart") or p10:IsA("Model")) then
    if v1.RecyclerESP then
      makeTextLabel4(p10)
    end
  elseif (p10.Name == "Card" or p10.Name == "BatteryItemm") and p10:IsA("MeshPart") then
    if v1.CardESP and f14(p10) then
      makeTextLabel5(p10)

      if not table.find(v12, p10) then
        table.insert(v12, p10)
      end
    end
  elseif p10.Name == "Bandage" and p10:IsA("MeshPart") then
    if v1.BandageESP and f14(p10) then
      makeTextLabel6(p10)
    end
  elseif v1.MonsterESP and f16(p10) then
    makeTextLabel7(p10)
  end
end

local function f25()
  for key12, value19 in pairs(workspace:GetDescendants()) do
    f24(value19)
    makeTextLabel(value19)
  end
end

local window = ui:MakeWindow({
  Name = "BKU SCRIPT (Ear Game)",
  SubTitle = "By Baloksxin",
  HidePremium = true,
  SaveConfig = false,
  IntroText = "BKU SCRIPT",
})

ui:MakeNotification({ Name = "BKU SCRIPT", Content = "辛巴爸爸卢比呀", Time = 3 })

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
  Callback = function(value20)
    v1.PlayerESP = value20

    if not value20 then
      for key13, value21 in pairs(ESPCache) do
        if value21.Line then
          value21.Line.Visible = false
        end

        if value21.Billboard then
          value21.Billboard.Enabled = false
        end

        if value21.Highlight then
          value21.Highlight.Enabled = false
        end
      end
    end
  end,
})

tab2:AddToggle({ Name = "显示名字", Callback = function(value22) v1.ShowNames = value22 end })

-- https://discord.gg/AwGHNh7Z7T
tab2:AddToggle({
  Name = "显示射线",
  Callback = function(value23) v1.ShowTracers = value23 end,
})

tab2:AddToggle({
  Name = "显示高亮",
  Callback = function(value24)
    v1.PlayerHighlight = value24

    for key14, value25 in pairs(ESPCache) do
      if value25.Highlight then
        value25.Highlight.Enabled = value24
      end
    end
  end,
})

tab2:AddSection({ Name = "游戏类Esp" })

tab2:AddToggle({
  Name = "开关怪物Esp",
  Callback = function(value26)
    v1.MonsterESP = value26

    if value26 then
      f25()
    else
      for key15, value27 in pairs(workspace:GetDescendants()) do
        if value27.Name == "Monster_Highlight_ESP" or value27.Name == "Monster_Text_ESP" then
          value27:Destroy()
        end
      end
    end
  end,
})

tab2:AddToggle({
  Name = "开关废品Esp",
  Callback = function(value28)
    v1.ScrapESP = value28

    if value28 then
      for key16, value29 in pairs(workspace:GetDescendants()) do
        f19(value29)
      end
    else
      for key17, value30 in pairs(workspace:GetDescendants()) do
        if value30.Name == "Scrap_Box_ESP" or value30.Name == "Scrap_Text_ESP" then
          value30:Destroy()
        end
      end
    end
  end,
})

tab2:AddToggle({
  Name = "开关回收机Esp",
  Callback = function(value31)
    v1.RecyclerESP = value31

    if value31 then
      f25()
    else
      for key18, value32 in pairs(workspace:GetDescendants()) do
        if value32.Name == "Recycler_Box_ESP" or value32.Name == "Recycler_Text_ESP" then
          value32:Destroy()
        end
      end
    end
  end,
})

tab2:AddToggle({
  Name = "开关卡片Esp",
  Callback = function(value33)
    v1.CardESP = value33

    if value33 then
      f25()
    else
      for key19, value34 in pairs(workspace:GetDescendants()) do
        if value34.Name == "Card_Box_ESP" or value34.Name == "Card_Text_ESP" then
          value34:Destroy()
        end
      end
    end
  end,
})

tab2:AddToggle({
  Name = "绷带Esp",
  Callback = function(value35)
    v1.BandageESP = value35

    if value35 then
      for key20, value36 in pairs(workspace:GetDescendants()) do
        if value36.Name == "Bandage" and value36:IsA("MeshPart") and f14(value36) then
          makeTextLabel6(value36)
        end
      end
    else
      for key21, value37 in pairs(workspace:GetDescendants()) do
        if value37.Name == "Bandage_Box_ESP" or value37.Name == "Bandage_Text_ESP" then
          value37:Destroy()
        end
      end
    end
  end,
})

tab2:AddSection({ Name = "其他类" })

tab2:AddToggle({
  Name = "夜视模式",
  Callback = function(value38)
    v1.NightVis = value38

    if not value38 then
      local ambient = v3.Ambient
      local clock = v3.Clock

      lighting.Brightness = v3.Bright
      lighting.Ambient = ambient
      lighting.ClockTime = clock
      lighting.FogEnd = v3.FogEnd or 100000
      lighting.FogStart = v3.FogStart or 0
    end
  end,
})

local connect5

tab2:AddToggle({
  Name = "隐藏尸体",
  Default = false,
  Callback = function(value39)
    v1.HideBodies = value39

    if value39 then
      for index8, value40 in ipairs(workspace:GetDescendants()) do
        f21(value40)
      end

      if not connect5 then
        connect5 = workspace.DescendantAdded:Connect(function(descendant2)
          if v1.HideBodies then
            f21(descendant2)
          end
        end)
      end
    elseif connect5 then
      connect5:Disconnect()
      connect5 = nil
    end
  end,
})

local espTab = window:MakeTab({ Name = "ESP设置", Icon = "rbxassetid://77348087165494" })
espTab:AddSection({ Name = "玩家" })

espTab:AddToggle({
  Name = "玩家彩虹色",
  Callback = function(value41) v1.RainbowESP = value41 end,
})

espTab:AddToggle({
  Name = "玩家显示距离",
  Callback = function(value42) v1.ShowDistance = value42 end,
})

espTab:AddDropdown({
  Name = "玩家射线位置",
  Options = { "从下方", "从上方" },
  Default = "从下方",
  Callback = function(value43) v1.TracerFromTop = value43 == "从上方" end,
})

local tab3 = window:MakeTab({ Name = "玩家", Icon = "rbxassetid://77348087165494" })
tab3:AddSection({ Name = "属性修改" })

tab3:AddSlider({
  Name = "修改速度值",
  Min = 0,
  Max = 500,
  Default = v3.Speed,
  Increment = 1,
  ValueName = "",
  Callback = function(value44)
    v1.Speed = value44

    if v1.SpeedEn and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = value44
    end
  end,
})

tab3:AddToggle({
  Name = "开启速度修改",
  Callback = function(value45)
    v1.SpeedEn = value45

    if not value45 and localPlayer.Character
      and localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = v3.Speed
    elseif value45 and localPlayer.Character
      and localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = v1.Speed
    end
  end,
})

tab3:AddSlider({
  Name = "修改FOV值",
  Min = 1,
  Max = 120,
  Default = v3.FOV,
  Increment = 1,
  ValueName = "",
  Callback = function(value46)
    v1.FOV = value46

    if v1.FOVEn and currentCamera then
      currentCamera.FieldOfView = value46
    end
  end,
})

tab3:AddToggle({
  Name = "开启 FOV 修改",
  Callback = function(value47)
    v1.FOVEn = value47

    if not value47 then
      currentCamera.FieldOfView = v3.FOV
    else
      currentCamera.FieldOfView = v1.FOV
    end
  end,
})

tab3:AddSection({ Name = "其他类" })
tab3:AddToggle({ Name = "立即互动", Callback = function(value48) f8(value48) end })

tab3:AddToggle({
  Name = "防脚滑",
  Default = false,
  Callback = function(value49)
    if value49 then
      f13()
    else
      f11()
    end
  end,
})

tab3:AddToggle({
  Name = "第三人称",
  Callback = function(value50) v1.ThirdPerson = value50 end,
})

tab3:AddToggle({ Name = "无限跳跃", Callback = function(value51) v1.InfJump = value51 end })

tab3:AddToggle({
  Name = "穿墙模式",
  Callback = function(value52)
    v1.Noclip = value52

    if not value52 then
      for key22, value53 in pairs(v13) do
        if key22 and key22.Parent then
          key22.CanCollide = value53
        end
      end

      table.clear(v13)
    end
  end,
})

tab3:AddToggle({
  Name = "固定自己",
  Callback = function(value54)
    v1.FreezeSelf = value54

    if localPlayer.Character then
      local humanoidRootPart3 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart3 then
        humanoidRootPart3.Anchored = value54
      end

      f7(localPlayer.Character, value54)
    end
  end,
})

tab3:AddToggle({
  Name = "固定自己(不固定动画)",
  Callback = function(value55)
    v1.AnchorOnly = value55

    if localPlayer.Character then
      local humanoidRootPart4 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart4 then
        humanoidRootPart4.Anchored = value55
      end
    end
  end,
})

tab3:AddSection({ Name = "跳跃" })

local v39 = 15

tab3:AddTextbox({
  Name = "跳跃高度",
  Default = "15",
  TextDisappear = false,
  Callback = function(value56) v39 = tonumber(value56) or 15 end,
})

tab3:AddButton({
  Name = "开启跳跃",
  Callback = function()
    local v40 = game

    loadstring("local jumph = " .. tostring(v39) .. " "
      .. v40:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/JB.LUA"))()
  end,
})

local tab4 = window:MakeTab({ Name = "杂项", Icon = "rbxassetid://77348087165494" })
tab4:AddSection({ Name = "旋转" })

tab4:AddToggle({
  Name = "开启旋转",
  Default = false,
  Callback = function(value57)
    v2.Enabled = value57

    if value57 then
      f10()
    else
      if connect3 then
        connect3:Disconnect()
        connect3 = nil
      end

      if localPlayer.Character then
        local humanoid8 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid8 then
          humanoid8.AutoRotate = true
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
  Callback = function(value58) v2.Speed = value58 end,
})

tab4:AddDropdown({
  Name = "旋转方向",
  Default = "顺时针",
  Options = { "顺时针", "逆时针" },
  Callback = function(value59)
    if value59 == "顺时针" then
      v2.Direction = 1
    else
      v2.Direction = -1
    end
  end,
})

tab4:AddSection({ Name = "Ear Game功能" })

tab4:AddToggle({
  Name = "开启刷钱",
  Default = false,
  Callback = function(value60)
    local autoGold = v1.AutoGold
    v1.AutoGold = value60

    if not value60 and autoGold then
      task.spawn(function()
        task.wait(0.05)

        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
          local humanoidRootPart5 = localPlayer.Character.HumanoidRootPart
          local v41 = f22()

          if v41 then
            local position3 = v41:IsA("BasePart") and v41.CFrame.Position
              or v41:GetPivot().Position

            humanoidRootPart5.CFrame = CFrame.new(position3 + Vector3.new(0, 4, 0))
          end
        end
      end)
    end
  end,
})

local function f26(defaultSpawn)
  if not defaultSpawn then
    return nil
  elseif defaultSpawn:IsA("BasePart") then
    return defaultSpawn.Position
  elseif defaultSpawn:IsA("Model") then
    local primaryPart6 = defaultSpawn.PrimaryPart
      or defaultSpawn:FindFirstChildWhichIsA("BasePart")

    if primaryPart6 then
      return primaryPart6.Position
    end

    return defaultSpawn:GetPivot().Position
  else
    if defaultSpawn:IsA("Attachment") then
      return defaultSpawn.WorldPosition
    end

    return nil
  end
end

local function f27(p11)
  local findFirstChild = workspace:FindFirstChild(p11)

  if findFirstChild then
    return findFirstChild
  else
    local findFirstChild2 = workspace:FindFirstChild(p11, true)

    if findFirstChild2 then
      return findFirstChild2
    end

    for index9, value61 in ipairs(workspace:GetDescendants()) do
      if value61.Name == p11 or value61.Name:lower() == p11:lower() then
        return value61
      end
    end

    return nil
  end
end

tab4:AddDropdown({
  Name = "传送地点",
  Default = "默认",
  Options = { "默认", "等级1", "等级2", "等级3", "等级4", "等级5" },
  Callback = function(value62) end,
})

tab4:AddButton({
  Name = "传送",
  Callback = function()
    local character6 = localPlayer.Character

    if not character6 then
      return
    else
      local humanoidRootPart6 = character6:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart6 then
        return
      else
        local defaultSpawn2 = f27("DefaultSpawn")

        if not defaultSpawn2 then
          return
        else
          local v42 = f26(defaultSpawn2)

          if not v42 then
            return
          end

          humanoidRootPart6.CFrame = CFrame.new(v42 + Vector3.new(0, 5, 0))
          return
        end
      end
    end
  end,
})

tab4:AddToggle({
  Name = "防摔落伤害(不能完全缓解)",
  Default = false,
  Callback = function(value63) v1.NoFallDamage = value63 end,
})

local connect6

tab4:AddToggle({
  Name = "删除水坑",
  Default = false,
  Callback = function(value64)
    v1.RemovePuddles = value64

    if value64 then
      for key23, value65 in pairs(workspace:GetDescendants()) do
        if value65:IsA("BasePart")
          and (value65.Name == "Puddle" or value65.Name == "PuddlePart") then
          value65:Destroy()
        end
      end

      if connect6 then
        connect6:Disconnect()
      end

      connect6 = workspace.DescendantAdded:Connect(function(descendant3)
        if v1.RemovePuddles and descendant3:IsA("BasePart")
          and (descendant3.Name == "Puddle" or descendant3.Name == "PuddlePart") then
          descendant3:Destroy()
        end
      end)
    elseif connect6 then
      connect6:Disconnect()
      connect6 = nil
    end
  end,
})

tab4:AddButton({
  Name = "删除安全阻挡(适合控制怪物时使用)",
  Callback = function()
    for index10, value66 in ipairs(workspace:GetDescendants()) do
      if (value66:IsA("BasePart") or value66:IsA("MeshPart"))
        and (value66.Name == "safe" or value66.Name == "SafeZone") then
        value66:Destroy()
      elseif value66:IsA("Folder") and value66.Name == "AntiVoid" then
        value66:Destroy()
      end
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

tab4:AddToggle({
  Name = "114514",
  Default = false,
  Callback = function(value67) v1.DeathEffectEn = value67 end,
})

tab4:AddToggle({
  Name = "控制怪物操控修复",
  Default = false,
  Callback = function(value68)
    v1.DisableWalkTo = value68
    f2()
  end,
})

tab4:AddButton({
  Name = "成为怪物脚本",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/Scripts/BTM.LUA"))()
  end,
})

tab4:AddSection({ Name = "工具" })

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

ui:Init()

task.spawn(function()
  f1()

  for index11, value69 in ipairs(players:GetPlayers()) do
    makeExplosion(value69)
  end

  players.PlayerAdded:Connect(makeExplosion)

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

  local function f28(player)
    if ESPCache[player] then
      if ESPCache[player].Line then
        ESPCache[player].Line:Destroy()
      end

      if ESPCache[player].Billboard then
        ESPCache[player].Billboard:Destroy()
      end

      if ESPCache[player].Highlight then
        ESPCache[player].Highlight:Destroy()
      end

      if ESPCache[player].TeamConn then
        ESPCache[player].TeamConn:Disconnect()
      end

      if ESPCache[player].TeamColorConn then
        ESPCache[player].TeamColorConn:Disconnect()
      end

      ESPCache[player] = nil
    end
  end

  local function f29(key24)
    local v43 = ESPCache[key24]

    if not v43 then
      return
    else
      local color = key24.Team and key24.TeamColor.Color or Color3.fromRGB(0, 255, 0)

      if v43.Label then
        v43.Label.TextColor3 = color
      end

      if v43.Line then
        v43.Line.BackgroundColor3 = color
      end

      if v43.Highlight then
        v43.Highlight.FillColor = color
      end

      return
    end
  end

  local function f30(character7)
    return character7:FindFirstChild("UpperTorso") or character7:FindFirstChild("LowerTorso")
      or character7:FindFirstChild("Torso") or character7:FindFirstChild("HumanoidRootPart")
      or character7:FindFirstChild("Head") or character7:FindFirstChildOfClass("BasePart")
  end

  local function makeTextLabel8(key25)
    f28(key25)

    if key25 == localPlayer then
      return
    else
      local character8 = key25.Character

      if not character8 then
        return
      else
        local v44 = f30(character8)

        if not v44 then
          return
        else
          local color2 = key25.Team and key25.TeamColor.Color or Color3.fromRGB(0, 255, 0)

          local bkuPlayerNameESP = Instance.new("BillboardGui")
          bkuPlayerNameESP.Name = "BKU_PlayerName_ESP"
          bkuPlayerNameESP.Size = UDim2.new(0, 180, 0, 40)
          bkuPlayerNameESP.AlwaysOnTop = true
          bkuPlayerNameESP.ExtentsOffset = Vector3.new(0, 0, 0)
          bkuPlayerNameESP.Adornee = v44
          bkuPlayerNameESP.Enabled = false

          local nameLabel = Instance.new("TextLabel")
          nameLabel.Name = "NameLabel"
          nameLabel.Size = UDim2.new(1, 0, 1, 0)
          nameLabel.BackgroundTransparency = 1
          nameLabel.Text = key25.DisplayName
          nameLabel.TextColor3 = color2
          nameLabel.TextSize = 14
          nameLabel.Font = Enum.Font.SourceSansBold
          nameLabel.TextStrokeTransparency = 0
          nameLabel.Parent = bkuPlayerNameESP

          bkuPlayerNameESP.Parent = character8

          local frame = Instance.new("Frame")
          frame.Name = "Tracer_" .. key25.Name
          frame.AnchorPoint = Vector2.new(0.5, 0.5)
          frame.BorderSizePixel = 0
          frame.BackgroundColor3 = color2
          frame.Visible = false
          frame.Parent = bkuPlayerESPGui

          local playerHighlight = Instance.new("Highlight")
          playerHighlight.Name = "PlayerHighlight"
          playerHighlight.FillColor = color2
          playerHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
          playerHighlight.Enabled = v1.PlayerHighlight
          playerHighlight.Parent = character8

          ESPCache[key25] = {
            Billboard = bkuPlayerNameESP,
            Label = nameLabel,
            Line = frame,
            Highlight = playerHighlight,
            TeamConn = key25:GetPropertyChangedSignal("Team"):Connect(function() f29(key25) end),
            TeamColorConn = key25:GetPropertyChangedSignal("TeamColor"):Connect(function()
              f29(key25)
            end),
          }

          return
        end
      end
    end
  end

  local function f31(player2, p12)
    local v45 = p12
    v45 = v45 or 5

    task.spawn(function()
      local v46 = v45
      local count2 = 0

      while true do
        count2 = 1 + count2

        if not (v46 >= count2) then
          break
        end

        local v47 = count2

        if not player2 or not player2.Parent then
          return
        end

        makeTextLabel8(player2)

        if ESPCache[player2] then
          return
        end

        task.wait(0.3 + v47 * 0.2)
      end
    end)
  end

  for index12, value70 in ipairs(players:GetPlayers()) do
    local v48 = value70

    if v48 ~= localPlayer then
      if v48.Character then
        f31(v48)
      end

      v48.CharacterAdded:Connect(function() f31(v48) end)
      v48.CharacterRemoving:Connect(function() f28(v48) end)
    end
  end

  players.PlayerAdded:Connect(function(player3)
    if player3.Character then
      f31(player3)
    end

    player3.CharacterAdded:Connect(function() f31(player3) end)
    player3.CharacterRemoving:Connect(function() f28(player3) end)
  end)

  players.PlayerRemoving:Connect(function(player4) f28(player4) end)

  workspace.DescendantAdded:Connect(function(descendant4)
    makeTextLabel(descendant4)
    f24(descendant4)
    f19(descendant4)

    if v1.HideBodies then
      f21(descendant4)
    end
  end)

  f25()

  task.spawn(function()
    while true do
      if v1.AutoGold and localPlayer.Character
        and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart7 = localPlayer.Character.HumanoidRootPart
        local humanoid9 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid9 and humanoid9.Health > 0 then
          if f23() then
            local v49 = f22()

            if v49 then
              local proximityPrompt2 = v49:FindFirstChildOfClass("ProximityPrompt")

              if proximityPrompt2 then
                humanoidRootPart7.CFrame = CFrame.new(v49.Position + Vector3.new(0, 4, 0))
                fireproximityprompt(proximityPrompt2)
              end
            end
          else
            local v50 = f15()

            if v50 then
              local position4 = v50:IsA("BasePart") and v50.CFrame.Position
                or v50:GetPivot().Position

              humanoidRootPart7.CFrame = CFrame.new(position4 + Vector3.new(0, 2, 0))
              f20(v50)
            end
          end
        end

        task.wait(0.1)
      else
        task.wait(0.5)
      end
    end
  end)

  runService.RenderStepped:Connect(function()
    if v1.SpeedEn and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = v1.Speed
    end

    if v1.NightVis then
      local color3 = Color3.new(1, 1, 1)

      lighting.Brightness = 2
      lighting.Ambient = color3
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

    if v1.NoFallDamage and localPlayer.Character then
      local humanoidRootPart8 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart8 then
        local assemblyLinearVelocity2 = humanoidRootPart8.AssemblyLinearVelocity

        if assemblyLinearVelocity2.Y < -45 then
          humanoidRootPart8.AssemblyLinearVelocity = Vector3.new(
            assemblyLinearVelocity2.X, -45, assemblyLinearVelocity2.Z
          )
        end
      end
    end

    if not v1.PlayerESP then
      for key26, value71 in pairs(ESPCache) do
        if value71.Line then
          value71.Line.Visible = false
        end

        if value71.Billboard then
          value71.Billboard.Enabled = false
        end

        if value71.Highlight then
          value71.Highlight.Enabled = false
        end
      end

      return
    else
      local viewportSize = currentCamera.ViewportSize
      local v51 = viewportSize.X / 2
      local y = viewportSize.Y

      for key27, value72 in pairs(ESPCache) do
        local character9 = key27.Character

        if not character9 or not character9.Parent then
          if value72.Line then
            value72.Line.Visible = false
          end

          if value72.Billboard then
            value72.Billboard.Enabled = false
          end

          if value72.Highlight then
            value72.Highlight.Enabled = false
          end
        else
          local head = character9:FindFirstChild("Head")
            or character9:FindFirstChild("HumanoidRootPart")

          if not head then
            if value72.Line then
              value72.Line.Visible = false
            end

            if value72.Billboard then
              value72.Billboard.Enabled = false
            end

            if value72.Highlight then
              value72.Highlight.Enabled = false
            end
          else
            if value72.Highlight then
              value72.Highlight.Enabled = v1.PlayerHighlight
            end

            if value72.Billboard then
              value72.Billboard.Enabled = v1.ShowNames
            end

            if v1.ShowTracers then
              local v52, v53 = currentCamera:WorldToViewportPoint(head.Position)

              if v53 then
                local vector2 = Vector2.new(v51, y)
                local vector3 = Vector2.new(v52.X, v52.Y)
                local v54 = (vector2 + vector3) / 2
                local deg = math.deg
                local atan2 = math.atan2
                local y2 = vector3.Y
                local y3 = vector2.Y
                local x = vector3.X
                local x2 = vector2.X
                local rotation = deg(atan2(y2 - y3, x - x2))

                value72.Line.Size = UDim2.new(0, (vector3 - vector2).Magnitude, 0, 1)
                value72.Line.Position = UDim2.new(0, v54.X, 0, v54.Y)
                value72.Line.Rotation = rotation
                value72.Line.Visible = true
              else
                value72.Line.Visible = false
              end
            else
              value72.Line.Visible = false
            end
          end
        end
      end

      return
    end
  end)

  runService.Stepped:Connect(function()
    if v1.Noclip and localPlayer.Character then
      for index13, value73 in ipairs(localPlayer.Character:GetDescendants()) do
        if value73:IsA("BasePart") then
          if v13[value73] == nil then
            v13[value73] = value73.CanCollide
          end

          value73.CanCollide = false
        end
      end
    end

    if v1.AnchorOnly and localPlayer.Character then
      local humanoidRootPart9 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart9 then
        humanoidRootPart9.Anchored = true
      end
    end

    if v1.FreezeSelf and localPlayer.Character then
      local humanoidRootPart10 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart10 then
        humanoidRootPart10.Anchored = true
      end

      local humanoid10 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid10 then
        local animator2 = humanoid10:FindFirstChildOfClass("Animator")

        if animator2 then
          for index14, value74 in ipairs(animator2:GetPlayingAnimationTracks()) do
            if value74.Speed ~= 0 then
              v14[value74] = value74.Speed
              value74:AdjustSpeed(0)
            end
          end
        end
      end
    end
  end)

  userInputService.JumpRequest:Connect(function()
    if v1.InfJump and localPlayer.Character then
      local humanoid11 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid11 then
        humanoid11:ChangeState("Jumping")
      end
    end
  end)
end)
