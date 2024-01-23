-- note that script.Music is a folder with music inside
music = script.Music

function playTrack(track)
	track:Play()
	print("MUSIC EVENT: " .. track.Name .. " is being played.")
	
	if track.Playing == true then
		track.Ended:Wait()
	end
	
	print("MUSIC EVENT: " .. track.Name .. " has finished.")
end

print("MUSIC EVENT: The music player has begun running!")

-- iterate through music folder and play all tracks repeatedly
while true do
	for i, track in ipairs(music:GetChildren()) do
		if track:IsA("Sound") and track.IsPlaying == false then
			playTrack(track)
		end
	end
end
