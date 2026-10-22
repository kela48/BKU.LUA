local coreGui = game:GetService("CoreGui")
local workspaceService = game:GetService("Workspace")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local httpService = game:GetService("HttpService")
local starterGui = game:GetService("StarterGui")

local function f1(title, text, p1)
  pcall(function()
    starterGui:SetCore("SendNotification", { Title = title, Text = text, Duration = p1 or 3 })
  end)
end

if coreGui:FindFirstChild("CameraPartMoverUI") then
  coreGui.CameraPartMoverUI:Destroy()
end

local cameraPartMoverUI = Instance.new("ScreenGui")
cameraPartMoverUI.Name = "CameraPartMoverUI"
cameraPartMoverUI.Parent = coreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 520)
frame.Position = UDim2.new(0.5, -170, 0.5, -260)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = cameraPartMoverUI

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 30)
textLabel.BackgroundTransparency = 1
textLabel.Text = "跳杀镜头修改工具"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 14
textLabel.Font = Enum.Font.SourceSansBold
textLabel.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.55, 0, 0, 26)
textBox.Position = UDim2.new(0.075, 0, 0, 32)
textBox.PlaceholderText = "输入 怪物 名称..."
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textBox.BorderSizePixel = 0
textBox.TextSize = 13
textBox.Font = Enum.Font.SourceSans
textBox.Parent = frame

local textBox2 = Instance.new("TextBox")
textBox2.Size = UDim2.new(0.27, 0, 0, 26)
textBox2.Position = UDim2.new(0.655, 0, 0, 32)
textBox2.PlaceholderText = "步长/角度"
textBox2.Text = "1"
textBox2.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textBox2.BorderSizePixel = 0
textBox2.TextSize = 13
textBox2.Font = Enum.Font.SourceSans
textBox2.Parent = frame

local textLabel2 = Instance.new("TextLabel")
textLabel2.Size = UDim2.new(0.85, 0, 0, 20)
textLabel2.Position = UDim2.new(0.075, 0, 0, 62)
textLabel2.BackgroundTransparency = 1
textLabel2.Text = "当前配置名称:"
textLabel2.TextColor3 = Color3.fromRGB(200, 200, 200)
textLabel2.TextSize = 12
textLabel2.Font = Enum.Font.SourceSansBold
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.Parent = frame

local textBox3 = Instance.new("TextBox")
textBox3.Size = UDim2.new(0.85, 0, 0, 26)
textBox3.Position = UDim2.new(0.075, 0, 0, 82)
textBox3.PlaceholderText = "输入配置名称..."
textBox3.Text = "默认配置"
textBox3.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox3.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textBox3.BorderSizePixel = 0
textBox3.TextSize = 13
textBox3.Font = Enum.Font.SourceSans
textBox3.Parent = frame

local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0.26, 0, 0, 24)
textButton.Position = UDim2.new(0.075, 0, 0, 112)
textButton.Text = "新建配置"
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.BackgroundColor3 = Color3.fromRGB(0, 130, 180)
textButton.BorderSizePixel = 0
textButton.TextSize = 12
textButton.Font = Enum.Font.SourceSansBold
textButton.Parent = frame

local textButton2 = Instance.new("TextButton")
textButton2.Size = UDim2.new(0.26, 0, 0, 24)
textButton2.Position = UDim2.new(0.37, 0, 0, 112)
textButton2.Text = "重命名配置"
textButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton2.BackgroundColor3 = Color3.fromRGB(140, 100, 0)
textButton2.BorderSizePixel = 0
textButton2.TextSize = 12
textButton2.Font = Enum.Font.SourceSansBold
textButton2.Parent = frame

local textButton3 = Instance.new("TextButton")
textButton3.Size = UDim2.new(0.26, 0, 0, 24)
textButton3.Position = UDim2.new(0.665, 0, 0, 112)
textButton3.Text = "删除配置"
textButton3.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton3.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
textButton3.BorderSizePixel = 0
textButton3.TextSize = 12
textButton3.Font = Enum.Font.SourceSansBold
textButton3.Parent = frame

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(0.85, 0, 0, 100)
scrollingFrame.Position = UDim2.new(0.075, 0, 0, 140)
scrollingFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
scrollingFrame.BorderSizePixel = 0
scrollingFrame.ScrollBarThickness = 6
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollingFrame.Parent = frame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 2)
uiListLayout.Parent = scrollingFrame

local function makeWeldConstraint(p2, value)
  if p2 and p2 ~= value then
    local weldConstraint = Instance.new("WeldConstraint")
    weldConstraint.Part0 = p2
    weldConstraint.Part1 = value
    weldConstraint.Parent = value
  end
end

local function f2(p3)
  return "SavedCamra/" .. p3
end

local function f3(p4, value2)
  local part1

  for index, value3 in ipairs(p4:GetDescendants()) do
    local v1 = false

    if value3:IsA("JointInstance") or value3:IsA("WeldConstraint") then
      if value3.Part0 == value2 then
        v1 = true
        part1 = value3.Part1
      elseif value3.Part1 == value2 then
        v1 = true
        part1 = value3.Part0
      end
    elseif value3:IsA("Constraint") then
      if value3.Attachment0 and value3.Attachment0.Parent == value2 then
        local attachment1 = value3.Attachment1
        v1 = true

        if attachment1 and value3.Attachment1.Parent and value3.Attachment1.Parent ~= value2 then
          part1 = value3.Attachment1.Parent
        end
      elseif value3.Attachment1 and value3.Attachment1.Parent == value2 then
        v1 = true

        if value3.Attachment0 and value3.Attachment0.Parent
          and value3.Attachment0.Parent ~= value2 then
          part1 = value3.Attachment0.Parent
        end
      end
    end

    if v1 then
      value3:Destroy()
    end
  end

  if not part1 then
    part1 = p4.PrimaryPart

    if not part1 then
      for index2, value4 in ipairs(p4:GetDescendants()) do
        if value4:IsA("BasePart") and value4 ~= value2 then
          part1 = value4
          break
        end
      end
    end
  end

  return part1
end

local function f4(text2)
  for index3, value5 in ipairs(workspaceService:GetDescendants()) do
    if value5:IsA("Model") and value5.Name == text2 then
      return value5
    end
  end

  return nil
end

local function f5(text3, text4)
  return f2(text3) .. "/" .. text4 .. ".txt"
end

local function f6(text5)
  local v2 = {}

  if not (isfolder and listfiles) then
    return v2
  else
    local v3 = f2(text5)

    if not isfolder(v3) then
      return v2
    end

    for index4, value6 in ipairs(listfiles(v3)) do
      local txt = value6:match("([^/\\]+)%.txt$")

      if txt then
        table.insert(v2, txt)
      end
    end

    table.sort(v2)
    return v2
  end
end

local function f7()
  if not (isfolder and listfiles and isfile and readfile and writefile and delfile and makefolder) then
    return
  end

  if not isfolder("SavedCamra") then
    return
  end

  for index5, value7 in ipairs(listfiles("SavedCamra")) do
    local v4 = value7

    if v4:match("^SavedCamra/[^/]+%.txt$") then
      local txt2 = v4:match("([^/\\]+)%.txt$")

      if txt2 then
        local v5, v6 = pcall(function() return readfile(v4) end)

        if v5 and v6 then
          local v7, v8 = pcall(function() return httpService:JSONDecode(v6) end)

          if v7 and v8 and v8.modelName then
            local v9 = f2(v8.modelName)

            pcall(function()
              if not isfolder(v9) then
                makefolder(v9)
              end
            end)

            local v10 = v9 .. "/" .. txt2 .. ".txt"

            if not isfile(v10) then
              pcall(function()
                writefile(v10, v6)
                delfile(v4)
              end)
            end
          end
        end
      end
    end
  end
end

local v11, v12

local function makeTextButton()
  for index6, value8 in ipairs(scrollingFrame:GetChildren()) do
    if value8:IsA("TextButton") then
      value8:Destroy()
    end
  end

  v11 = nil
  v12 = nil
  local text6 = textBox.Text

  if text6 == "" or not (isfolder and listfiles) then
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    return
  else
    local v13 = f6(text6)

    for index7, value9 in ipairs(v13) do
      local v14 = value9

      local textButton4 = Instance.new("TextButton")
      textButton4.Size = UDim2.new(1, -6, 0, 24)
      textButton4.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
      textButton4.TextColor3 = Color3.fromRGB(255, 255, 255)
      textButton4.Text = v14
      textButton4.TextSize = 12
      textButton4.Font = Enum.Font.SourceSans
      textButton4.BorderSizePixel = 0
      textButton4.LayoutOrder = index7
      textButton4.Parent = scrollingFrame

      textButton4.MouseButton1Click:Connect(function()
        if v11 and v11.Parent then
          v11.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end

        v11 = textButton4
        v12 = v14
        textButton4.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        textBox3.Text = v14
      end)
    end

    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(#v13 * 26, 100))
    return
  end
end

textBox.FocusLost:Connect(function() makeTextButton() end)

textButton.MouseButton1Click:Connect(function()
  local text7 = textBox.Text
  local text8 = textBox3.Text

  if text7 == "" then
    return
  end

  if text8 == "" then
    return
  end

  local v15

  if makefolder and isfolder then
    v15 = f2(text7)

    pcall(function()
      if not isfolder("SavedCamra") then
        makefolder("SavedCamra")
      end

      if not isfolder(v15) then
        makefolder(v15)
      end
    end)
  end

  local v16 = f5(text7, text8)
  local v17

  if writefile then
    v17 = { modelName = text7, stepValue = textBox2.Text, cameras = {} }
    pcall(function() writefile(v16, httpService:JSONEncode(v17)) end)
    f1("成功", "配置 '" .. text8 .. "' 已创建！", 3)
    makeTextButton()
  end
end)

textButton2.MouseButton1Click:Connect(function()
  local text9 = textBox.Text
  local v18 = v12
  local text10 = textBox3.Text

  if text9 == "" then
    return
  end

  local v19, v20

  if v18 == nil or v18 == "" then
    return
  elseif text10 == "" then
    return
  elseif text10 == v18 then
    return
  else
    if not (isfile and readfile and writefile and delfile) then
      return
    end

    v19 = f5(text9, v18)
    v20 = f5(text9, text10)

    if not isfile(v19) then
      return
    elseif isfile(v20) then
      return
    else
      if pcall(function()
        writefile(v20, httpService:JSONEncode((httpService:JSONDecode((readfile(v19))))))
        delfile(v19)
      end) then
        f1("成功", "配置已重命名为 '" .. text10 .. "'！", 3)
        v12 = text10
        makeTextButton()
      end

      return
    end
  end
end)

textButton3.MouseButton1Click:Connect(function()
  local text11 = textBox.Text
  local text12 = textBox3.Text

  if text11 == "" or text12 == "" then
    return
  end

  if not (isfile and delfile) then
    return
  end

  local v21 = f5(text11, text12)

  if not isfile(v21) then
    return
  end

  if pcall(function() delfile(v21) end) then
    f1("成功", "配置 '" .. text12 .. "' 已删除！", 3)
    textBox3.Text = ""
    v12 = nil
    makeTextButton()
  end
end)

local textButton5 = Instance.new("TextButton")
textButton5.Size = UDim2.new(0.41, 0, 0, 26)
textButton5.Position = UDim2.new(0.075, 0, 0, 248)
textButton5.Text = "保存当前镜头配置"
textButton5.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton5.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
textButton5.BorderSizePixel = 0
textButton5.TextSize = 12
textButton5.Font = Enum.Font.SourceSansBold
textButton5.Parent = frame

textButton5.MouseButton1Click:Connect(function()
  local text13 = textBox.Text
  local text14 = textBox3.Text
  local v22, v23

  if text13 == "" then
    return
  elseif text14 == "" then
    return
  else
    local v24 = f4(text13)

    if not v24 then
      f1("错误", "未找到 怪物：" .. text13, 3)
      return
    else
      if makefolder and isfolder then
        pcall(function()
          if not isfolder("SavedCamra") then
            makefolder("SavedCamra")
          end

          local v25 = f2(text13)

          if not isfolder(v25) then
            makefolder(v25)
          end
        end)
      end

      local humanoidRootPart = v24:FindFirstChild("HumanoidRootPart")

      local cframe = humanoidRootPart and humanoidRootPart:IsA("BasePart")
          and humanoidRootPart.CFrame
        or v24:GetPivot()

      local v26 = {}

      for index8, value10 in ipairs(v24:GetDescendants()) do
        if value10:IsA("BasePart") and value10.Name:lower() == "camera" then
          local toObjectSpace = cframe:ToObjectSpace(value10.CFrame)

          table.insert(v26, {
            name = value10.Name,
            components = { toObjectSpace:GetComponents() },
          })
        end
      end

      v22 = { modelName = text13, stepValue = textBox2.Text, cameras = v26 }
      v23 = f5(text13, text14)

      if writefile then
        local v27, v28 = pcall(function() writefile(v23, httpService:JSONEncode(v22)) end)

        if v27 then
          textButton5.Text = "保存成功"
          textButton5.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

          task.delay(1, function()
            if textButton5 and textButton5.Parent then
              textButton5.Text = "保存当前镜头配置"
              textButton5.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
            end
          end)

          print("配置文件已成功写入: " .. v23)
          makeTextButton()
        else
          warn("写入文件失败: " .. tostring(v28))
          f1("错误", "写入文件失败: " .. tostring(v28), 3)
        end
      else
        warn("当前 执行器 不支持 writefile 函数！")
      end

      return
    end
  end
end)

local textButton6 = Instance.new("TextButton")
textButton6.Size = UDim2.new(0.41, 0, 0, 26)
textButton6.Position = UDim2.new(0.515, 0, 0, 248)
textButton6.Text = "加载镜头配置"
textButton6.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton6.BackgroundColor3 = Color3.fromRGB(180, 120, 0)
textButton6.BorderSizePixel = 0
textButton6.TextSize = 12
textButton6.Font = Enum.Font.SourceSansBold
textButton6.Parent = frame

textButton6.MouseButton1Click:Connect(function()
  local text15 = textBox.Text
  local text16 = textBox3.Text
  local v29

  if text15 == "" then
    return
  elseif text16 == "" then
    return
  else
    v29 = f5(text15, text16)

    if readfile and isfile and isfile(v29) then
      local v30, v31 = pcall(function()
        local jsonDecode = httpService:JSONDecode((readfile(v29)))

        if jsonDecode then
          if jsonDecode.stepValue then
            textBox2.Text = tostring(jsonDecode.stepValue)
          end

          local v32 = f4(text15)

          if v32 and jsonDecode.cameras then
            local humanoidRootPart2 = v32:FindFirstChild("HumanoidRootPart")

            local cframe2 = humanoidRootPart2 and humanoidRootPart2:IsA("BasePart")
                and humanoidRootPart2.CFrame
              or v32:GetPivot()

            for index9, value11 in ipairs(jsonDecode.cameras) do
              for index10, value12 in ipairs(v32:GetDescendants()) do
                if value12:IsA("BasePart") and value12.Name == value11.name then
                  local v33 = f3(v32, value12)
                  local canCollide = value12.CanCollide

                  value12.CanCollide = false
                  value12.CFrame = cframe2 * CFrame.new(unpack(value11.components))
                  value12.CanCollide = canCollide

                  makeWeldConstraint(v33, value12)
                  break
                end
              end
            end
          else
            warn("未找到对应的 怪物，或配置文件无 camera 数据！")
          end
        end
      end)

      if v30 then
        textButton6.Text = "加载成功"
        textButton6.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

        task.delay(1, function()
          if textButton6 and textButton6.Parent then
            textButton6.Text = "加载镜头配置"
            textButton6.BackgroundColor3 = Color3.fromRGB(180, 120, 0)
          end
        end)

        f1("成功", "配置 '" .. text16 .. "' 已成功加载并应用！", 3)
        print("配置已成功加载并应用到 Model: " .. text15)
      else
        warn("解析或应用配置失败: " .. tostring(v31))
        f1("错误", "解析或应用配置失败: " .. tostring(v31), 3)
      end
    else
      warn("未找到对应的配置文件: " .. v29)
    end

    return
  end
end)

local function f8(offset)
  local text17 = textBox.Text
  local vectorToWorldSpace

  if text17 == "" then
    warn("请输入 怪物 名称！")
    return
  else
    local v34 = f4(text17)

    if not v34 then
      warn("未找到 怪物！")
      return
    else
      local v35 = tonumber(textBox2.Text) or 1
      local humanoidRootPart3 = v34:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart3 and humanoidRootPart3:IsA("BasePart") then
        vectorToWorldSpace = humanoidRootPart3.CFrame:VectorToWorldSpace(offset * v35)
      else
        vectorToWorldSpace = v34:GetPivot():VectorToWorldSpace(offset * v35)
      end

      local count = 0

      for index11, value13 in ipairs(v34:GetDescendants()) do
        if value13:IsA("BasePart") and value13.Name:lower() == "camera" then
          local v36 = f3(v34, value13)
          local canCollide2 = value13.CanCollide

          value13.CanCollide = false
          value13.CFrame = value13.CFrame + vectorToWorldSpace
          value13.CanCollide = canCollide2

          makeWeldConstraint(v36, value13)
          count = count + 1
        end
      end

      if count > 0 then
        print("移动完成，步长: " .. v35)
      end

      return
    end
  end
end

local function f9(axis)
  local text18 = textBox.Text

  if text18 == "" then
    warn("请输入 怪物 名称！")
    return
  else
    local v37 = f4(text18)

    if not v37 then
      warn("未找到 怪物！")
      return
    else
      local v38 = tonumber(textBox2.Text) or 15
      local v39 = math.rad(v38)
      local humanoidRootPart4 = v37:FindFirstChild("HumanoidRootPart")

      local cframe3 = humanoidRootPart4 and humanoidRootPart4:IsA("BasePart")
          and humanoidRootPart4.CFrame
        or v37:GetPivot()

      local count2 = 0

      for index12, value14 in ipairs(v37:GetDescendants()) do
        if value14:IsA("BasePart") and value14.Name:lower() == "camera" then
          local v40 = f3(v37, value14)
          local canCollide3 = value14.CanCollide
          value14.CanCollide = false
          local vectorToWorldSpace2 = cframe3:VectorToWorldSpace(axis)
          local cframe4 = value14.CFrame
          local cframe5 = CFrame.fromAxisAngle(vectorToWorldSpace2, v39)

          value14.CFrame = CFrame.new(cframe4.Position) * cframe5
            * CFrame.new(-cframe4.Position) * cframe4

          value14.CanCollide = canCollide3

          makeWeldConstraint(v40, value14)
          count2 = count2 + 1
        end
      end

      if count2 > 0 then
        print("旋转完成，角度: " .. v38 .. "度")
      end

      return
    end
  end
end

for index13, value15 in ipairs({
  {
    text = "前 (Z-)",
    pos = UDim2.new(0.075, 0, 0, 282),
    size = UDim2.new(0.26, 0, 0, 30),
    offset = Vector3.new(0, 0, -1),
  },
  {
    text = "上 (Y+)",
    pos = UDim2.new(0.37, 0, 0, 282),
    size = UDim2.new(0.26, 0, 0, 30),
    offset = Vector3.new(0, 1, 0),
  },
  {
    text = "后 (Z+)",
    pos = UDim2.new(0.665, 0, 0, 282),
    size = UDim2.new(0.26, 0, 0, 30),
    offset = Vector3.new(0, 0, 1),
  },
  {
    text = "左 (X-)",
    pos = UDim2.new(0.075, 0, 0, 316),
    size = UDim2.new(0.26, 0, 0, 30),
    offset = Vector3.new(-1, 0, 0),
  },
  {
    text = "下 (Y-)",
    pos = UDim2.new(0.37, 0, 0, 316),
    size = UDim2.new(0.26, 0, 0, 30),
    offset = Vector3.new(0, -1, 0),
  },
  {
    text = "右 (X+)",
    pos = UDim2.new(0.665, 0, 0, 316),
    size = UDim2.new(0.26, 0, 0, 30),
    offset = Vector3.new(1, 0, 0),
  },
}) do
  local v41 = value15

  local textButton7 = Instance.new("TextButton")
  textButton7.Size = v41.size
  textButton7.Position = v41.pos
  textButton7.Text = v41.text
  textButton7.TextColor3 = Color3.fromRGB(255, 255, 255)
  textButton7.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
  textButton7.BorderSizePixel = 0
  textButton7.TextSize = 13
  textButton7.Font = Enum.Font.SourceSansBold
  textButton7.Parent = frame
  textButton7.MouseButton1Click:Connect(function() f8(v41.offset) end)
end

for index14, value16 in ipairs({
  {
    text = "转X-",
    pos = UDim2.new(0.075, 0, 0, 352),
    size = UDim2.new(0.26, 0, 0, 30),
    axis = Vector3.new(-1, 0, 0),
  },
  {
    text = "转Y+",
    pos = UDim2.new(0.37, 0, 0, 352),
    size = UDim2.new(0.26, 0, 0, 30),
    axis = Vector3.new(0, 1, 0),
  },
  {
    text = "转X+",
    pos = UDim2.new(0.665, 0, 0, 352),
    size = UDim2.new(0.26, 0, 0, 30),
    axis = Vector3.new(1, 0, 0),
  },
  {
    text = "转Z-",
    pos = UDim2.new(0.075, 0, 0, 386),
    size = UDim2.new(0.26, 0, 0, 30),
    axis = Vector3.new(0, 0, -1),
  },
  {
    text = "转Y-",
    pos = UDim2.new(0.37, 0, 0, 386),
    size = UDim2.new(0.26, 0, 0, 30),
    axis = Vector3.new(0, -1, 0),
  },
  {
    text = "转Z+",
    pos = UDim2.new(0.665, 0, 0, 386),
    size = UDim2.new(0.26, 0, 0, 30),
    axis = Vector3.new(0, 0, 1),
  },
}) do
  local v42 = value16

  local textButton8 = Instance.new("TextButton")
  textButton8.Size = v42.size
  textButton8.Position = v42.pos
  textButton8.Text = v42.text
  textButton8.TextColor3 = Color3.fromRGB(255, 255, 255)
  textButton8.BackgroundColor3 = Color3.fromRGB(150, 80, 0)
  textButton8.BorderSizePixel = 0
  textButton8.TextSize = 13
  textButton8.Font = Enum.Font.SourceSansBold
  textButton8.Parent = frame
  textButton8.MouseButton1Click:Connect(function() f9(v42.axis) end)
end

local currentCamera = workspaceService.CurrentCamera
local localPlayer = players.LocalPlayer
local v43 = false

local textButton9 = Instance.new("TextButton")
textButton9.Size = UDim2.new(0.85, 0, 0, 28)
textButton9.Position = UDim2.new(0.075, 0, 0, 425)
textButton9.Text = "锁定镜头到 camera"
textButton9.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton9.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
textButton9.BorderSizePixel = 0
textButton9.TextSize = 13
textButton9.Font = Enum.Font.SourceSansBold
textButton9.Parent = frame

local connect

textButton9.MouseButton1Click:Connect(function()
  v43 = not v43
  local v44

  if v43 then
    local text19 = textBox.Text

    if text19 == "" then
      warn("请输入 怪物 名称！")
      v43 = false
      return
    else
      local v45 = f4(text19)

      if not v45 then
        warn("未找到 怪物！")
        v43 = false
        return
      else
        local getDescendants = v45.GetDescendants
        v44 = nil

        for index15, value17 in ipairs(getDescendants(v45)) do
          if value17:IsA("BasePart") and value17.Name:lower() == "camera" then
            v44 = value17
            break
          end
        end

        if not v44 then
          warn("未找到 [camera] 部件！")
          v43 = false
          return
        end

        currentCamera.CameraType = Enum.CameraType.Scriptable

        connect = runService.RenderStepped:Connect(function()
          if v44 and v44.Parent then
            currentCamera.CFrame = v44.CFrame
          else
            v43 = false

            if connect then
              connect:Disconnect()
            end

            currentCamera.CameraType = Enum.CameraType.Custom

            textButton9.Text = "锁定镜头到 camera"
            textButton9.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
          end
        end)

        textButton9.Text = "解除镜头锁定"
        textButton9.BackgroundColor3 = Color3.fromRGB(180, 100, 0)

        return
      end
    end
  else
    if connect then
      connect:Disconnect()
      connect = nil
    end

    currentCamera.CameraType = Enum.CameraType.Custom

    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
      currentCamera.CameraSubject = localPlayer.Character.Humanoid
    end

    textButton9.Text = "锁定镜头到 camera"
    textButton9.BackgroundColor3 = Color3.fromRGB(0, 150, 100)

    return
  end
end)

local textButton10 = Instance.new("TextButton")
textButton10.Size = UDim2.new(0.85, 0, 0, 28)
textButton10.Position = UDim2.new(0.075, 0, 0, 463)
textButton10.Text = "关闭界面"
textButton10.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton10.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
textButton10.BorderSizePixel = 0
textButton10.TextSize = 13
textButton10.Font = Enum.Font.SourceSansBold
textButton10.Parent = frame

textButton10.MouseButton1Click:Connect(function()
  if connect then
    connect:Disconnect()
  end

  currentCamera.CameraType = Enum.CameraType.Custom

  if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
    currentCamera.CameraSubject = localPlayer.Character.Humanoid
  end

  cameraPartMoverUI:Destroy()
end)

f7()
makeTextButton()
