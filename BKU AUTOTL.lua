local coreGui = game:GetService("CoreGui")
local starterGui = game:GetService("StarterGui")
local workspaceService = game:GetService("Workspace")
local httpService = game:GetService("HttpService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

if not (syn and syn.request or http and http.request or http_request or request) then
  return
end

if localPlayer then
  localPlayer:WaitForChild("PlayerGui", 5)
end

task.delay(1, function() end)
