local coreGui = game:GetService("CoreGui")

if not isfolder("MySounds") then
  makefolder("MySounds")
end

local soundReplacerGUI = Instance.new("ScreenGui")
soundReplacerGUI.Name = "SoundReplacerGUI"
soundReplacerGUI.Parent = coreGui

local instance = Instance.new("TextButton", soundReplacerGUI)
instance.Size = UDim2.new(0, 100, 0, 30)
instance.Position = UDim2.new(0, 10, 0, 10)
instance.Text = "开关 UI"
instance.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
instance.TextColor3 = Color3.new(1, 1, 1)

local instance2 = Instance.new("Frame", soundReplacerGUI)
instance2.Size = UDim2.new(0, 600, 0, 400)
instance2.Position = UDim2.new(0.5, -300, 0.5, -200)
instance2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
instance2.Active = true
instance2.Draggable = true
instance2.Visible = true

instance.MouseButton1Click:Connect(function() instance2.Visible = not instance2.Visible end)

local instance3 = Instance.new("TextLabel", instance2)
instance3.Size = UDim2.new(1, 0, 0, 30)
instance3.Position = UDim2.new(0, 0, 0, 0)
instance3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
instance3.TextColor3 = Color3.fromRGB(255, 100, 100)
instance3.Text = "放入: workspace/MySounds (支持: mp3, wav, ogg, flac, aac, m4a, wma, mpeg)"
instance3.Font = Enum.Font.SourceSansBold
instance3.TextScaled = true

local instance4 = Instance.new("ScrollingFrame", instance2)
instance4.Size = UDim2.new(0.5, 0, 0.55, 0)
instance4.Position = UDim2.new(0, 0, 0, 30)
instance4.AutomaticCanvasSize = Enum.AutomaticSize.XY
instance4.ScrollBarThickness = 12
instance4.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

Instance.new("UIListLayout", instance4)

local instance5 = Instance.new("ScrollingFrame", instance2)
instance5.Size = UDim2.new(0.5, 0, 0.55, 0)
instance5.Position = UDim2.new(0.5, 0, 0, 30)
instance5.AutomaticCanvasSize = Enum.AutomaticSize.XY
instance5.ScrollBarThickness = 12
instance5.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

Instance.new("UIListLayout", instance5)

local instance6 = Instance.new("Frame", instance2)
instance6.Size = UDim2.new(1, 0, 0, 40)
instance6.Position = UDim2.new(0, 0, 0.65, 0)
instance6.BackgroundTransparency = 1

local instance7 = Instance.new("TextButton", instance6)
instance7.Size = UDim2.new(0.48, 0, 1, 0)
instance7.Position = UDim2.new(0.01, 0, 0, 0)
instance7.Text = "刷新数据"
instance7.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
instance7.TextColor3 = Color3.new(1, 1, 1)

local instance8 = Instance.new("TextButton", instance6)
instance8.Size = UDim2.new(0.48, 0, 1, 0)
instance8.Position = UDim2.new(0.51, 0, 0, 0)
instance8.Text = "替换为空白"
instance8.BackgroundColor3 = Color3.fromRGB(150, 60, 60)
instance8.TextColor3 = Color3.new(1, 1, 1)

local instance9 = Instance.new("TextLabel", instance2)
instance9.Size = UDim2.new(1, 0, 0, 90)
instance9.Position = UDim2.new(0, 0, 0.75, 0)
instance9.BackgroundTransparency = 1
instance9.TextColor3 = Color3.new(1, 1, 1)
instance9.Text = "请选择左侧音效"
instance9.TextWrapped = true

local v1

local function makeTextButton()
  instance4:ClearAllChildren()
  Instance.new("UIListLayout", instance4)
  local v2 = {}
  local v3 = game
  local v4 = game

  for key, value in pairs({ v3:GetService("Workspace"), v4:GetService("SoundService") }) do
    local v5 = value
    local v6, v7 = pcall(function() return v5:GetDescendants() end)

    if v6 then
      for key2, value2 in pairs(v7) do
        if value2:IsA("Sound") then
          table.insert(v2, value2)
        end
      end
    end
  end

  table.sort(v2, function(p1, p2) return p1:GetFullName():lower() < p2:GetFullName():lower() end)

  for key3, value3 in pairs(v2) do
    local v8 = value3

    local instance10 = Instance.new("TextButton", instance4)
    instance10.Text = v8:GetFullName()
    instance10.Size = UDim2.new(0, 800, 0, 30)
    instance10.TextXAlignment = Enum.TextXAlignment.Left
    instance10.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    instance10.TextColor3 = Color3.new(1, 1, 1)

    instance10.MouseButton1Click:Connect(function()
      v1 = v8
      instance9.Text = "已选中: " .. v8:GetFullName()
    end)
  end
end

local v9 = { ".mp3", ".wav", ".ogg", ".flac", ".aac", ".m4a", ".wma", ".mpeg" }

local function f1(value4)
  local lower = value4:lower()

  for key4, value5 in pairs(v9) do
    if lower:sub(-#value5) == value5 then
      return true
    end
  end

  return false
end

local function f2(value6)
  local v10 = {}
  local v11, v12 = pcall(listfiles, value6)

  if not v11 then
    return v10
  end

  for key5, value7 in pairs(v12) do
    if isfolder(value7) then
      for key6, value8 in pairs((f2(value7))) do
        table.insert(v10, value8)
      end
    elseif f1(value7) then
      table.insert(v10, value7)
    end
  end

  return v10
end

local function makeTextButton2()
  instance5:ClearAllChildren()
  Instance.new("UIListLayout", instance5)
  local mySounds = f2("MySounds")
  table.sort(mySounds)

  for key7, value9 in pairs(mySounds) do
    local v13 = value9

    local instance11 = Instance.new("TextButton", instance5)
    instance11.Text = v13:match("([^/]+)$")
    instance11.Size = UDim2.new(0, 800, 0, 30)
    instance11.TextXAlignment = Enum.TextXAlignment.Left
    instance11.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    instance11.TextColor3 = Color3.new(1, 1, 1)

    instance11.MouseButton1Click:Connect(function()
      if v1 then
        v1.SoundId = getcustomasset(v13)
        instance9.Text = "已替换: " .. v1.Name
      else
        instance9.Text = "请先选择左侧音效！"
      end
    end)
  end
end

instance7.MouseButton1Click:Connect(function()
  makeTextButton()
  makeTextButton2()
end)

instance8.MouseButton1Click:Connect(function()
  if v1 then
    v1.SoundId = ""
    instance9.Text = "已清空: " .. v1.Name
  else
    instance9.Text = "请先选择左侧音效！"
  end
end)

makeTextButton()
makeTextButton2()
