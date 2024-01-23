local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChangeGuiEvent = ReplicatedStorage:WaitForChild("Change GUI")
local StarterGui = script.Parent

function changeGuiText(gui, textbox, text)
	StarterGui[gui][textbox].Text = text
end

ChangeGuiEvent.OnClientEvent:Connect(changeGuiText)
