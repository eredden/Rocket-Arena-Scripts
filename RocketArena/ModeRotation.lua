local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChangeGuiEvent = ReplicatedStorage:WaitForChild("Change GUI")

local Notification = script.Notification


--[[

BASE FUNCTIONS

--]]


-- Calls local script ChangeGui.lua with parameters.
function ChangeGuiText(gui, textbox, text)
	ChangeGuiEvent:FireAllClients(gui, textbox, text)
end

-- Change of property of Humanoid for all players.
function ChangeAttributeForAll(attribute, value)
	local StarterPlayer = game.StarterPlayer
	print("MODE EVENT: Changing " .. attribute .. " to " .. value .. " for all players!")
	
	for i, descendant in game.workspace:GetDescendants() do
		if descendant.ClassName == "Humanoid" then
			descendant[attribute] = value
		end
	end
	
	-- Ensures that changes persist even if players die.
	StarterPlayer["Character" .. attribute] = value
end

-- Sets name and description for modes.
function StartMode(name, description)
	Notification:Play()
	ChangeGuiText("Mode GUI", "Mode", name)
	ChangeGuiText("Mode GUI", "Description", description)
end


--[[

UNIQUE GAMEMODE FUNCTIONS

--]]


function RegularMode(roundTime)
	local name = "REGULAR MODE"
	local description = "Just like the good old days, eh?"

	StartMode(name, description)
	wait(roundTime * 60)
end

-- x1.5 player speed.
function HermesMode(roundTime)
	local name = "HERMES MODE"
	local description = "Faster than wind in a hurricane!"
	local attribute = "WalkSpeed"
	local oldValue = 30
	local newValue = 45
	
	StartMode(name, description)
	
	ChangeAttributeForAll(attribute, newValue)
	wait(roundTime * 60)
	ChangeAttributeForAll(attribute, oldValue)
end

-- x2 player jump height.
function ZephyrusMode(roundTime)
	local name = "ZEPHYRUS MODE"
	local description = "Float like a butterfly, sting like a bee."
	local attribute = "JumpPower"
	local oldValue = 50
	local newValue = 100

	StartMode(name, description)

	ChangeAttributeForAll(attribute, newValue)
	wait(roundTime * 60)
	ChangeAttributeForAll(attribute, oldValue)
end

-- ~25% gravity.
function GravitasMode(roundTime)
	local name = "GRAVITAS MODE"
	local description = "Houston, we have a problem."
	local ChangeGravityEvent = ReplicatedStorage:WaitForChild("Change Gravity")
	local gravity = game.Workspace.Gravity

	StartMode(name, description)
	
    -- Calls local script ChangeGravity.lua with gravity values.
	ChangeGravityEvent:FireAllClients(50)
	wait(roundTime * 60)
	ChangeGravityEvent:FireAllClients(196.2)
end

-- Speeds up day/night cycle.
function ChronosMode(roundTime)
	local name = "CHRONOS MODE"
	local description = "Have you checked the clock?"
	local lighting = game.Lighting
	
	roundTime = roundTime * 60

	StartMode(name, description)

	-- Changes in-game time by thirty minutes, every second.
	while roundTime > 0 do
		if lighting.ClockTime < 24 then
			lighting.ClockTime = lighting.ClockTime + 0.5
		else 
			lighting.ClockTime = 0
		end
		
		roundTime = roundTime - 1
		wait(1)
	end

	lighting.ClockTime = 17
end


--[[

MAIN EXECUTION

--]]


local RoundTime = 2 -- In minutes.

wait(2)

while true do
	print("MODE EVENT: Mode rotation has started!")
	GravitasMode(RoundTime)
	HermesMode(RoundTime)
	RegularMode(RoundTime)
	ZephyrusMode(RoundTime)
	ChronosMode(RoundTime)
end
