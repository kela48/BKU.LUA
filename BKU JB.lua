local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

if _G._JumpHeightCleanup then
  for index, value in ipairs(_G._JumpHeightCleanup) do
    value:Disconnect()
  end

  _G._JumpHeightCleanup = nil
end

local function f1(humanoid)
  if not humanoid then
    return
  end

  if jumph and jumph > 0 then
    humanoid.UseJumpPower = false
    humanoid.JumpHeight = jumph
  else
    humanoid.UseJumpPower = true
    humanoid.JumpPower = 0
  end
end

local v1 = {}

local function f2(character)
  local humanoid2 = character:FindFirstChild("Humanoid")

  if not humanoid2 then
    return
  else
    f1(humanoid2)
    local jumpHeight = humanoid2:GetPropertyChangedSignal("JumpHeight")

    table.insert(v1, jumpHeight:Connect(function()
      if jumph and jumph > 0 then
        if humanoid2.JumpHeight ~= jumph then
          humanoid2.JumpHeight = jumph
        end
      else
        if humanoid2.UseJumpPower ~= true then
          humanoid2.UseJumpPower = true
        end

        if humanoid2.JumpPower ~= 0 then
          humanoid2.JumpPower = 0
        end
      end
    end))

    local useJumpPower = humanoid2:GetPropertyChangedSignal("UseJumpPower")

    table.insert(v1, useJumpPower:Connect(function()
      if jumph and jumph > 0 then
        if humanoid2.UseJumpPower ~= false then
          humanoid2.UseJumpPower = false
        end

        if humanoid2.JumpHeight ~= jumph then
          humanoid2.JumpHeight = jumph
        end
      else
        if humanoid2.UseJumpPower ~= true then
          humanoid2.UseJumpPower = true
        end

        if humanoid2.JumpPower ~= 0 then
          humanoid2.JumpPower = 0
        end
      end
    end))

    local jumpPower = humanoid2:GetPropertyChangedSignal("JumpPower")

    table.insert(v1, jumpPower:Connect(function()
      if not jumph or jumph == 0 then
        if humanoid2.JumpPower ~= 0 then
          humanoid2.JumpPower = 0
        end

        if humanoid2.UseJumpPower ~= true then
          humanoid2.UseJumpPower = true
        end
      end
    end))

    return
  end
end

if localPlayer.Character then
  f2(localPlayer.Character)
end

local characterAdded = localPlayer.CharacterAdded
table.insert(v1, characterAdded:Connect(f2))
_G._JumpHeightCleanup = v1
