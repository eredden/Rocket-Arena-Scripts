local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChangeGuiEvent = ReplicatedStorage:WaitForChild("Change Gravity")

function changeGravity(value)
	game.Workspace.Gravity = value
end

-- activated from GravitasMode() in ModeRotation.lua
ChangeGuiEvent.OnClientEvent:Connect(changeGravity)
