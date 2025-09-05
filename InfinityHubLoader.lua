spamToggle.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
spamToggle.Text             = "Spam: OFF"
spamToggle.TextColor3       = Color3.new(1, 1, 1)
spamToggle.Font             = Enum.Font.SourceSansBold
spamToggle.TextSize         = 18
spamToggle.Parent           = cF

local spamActive = false
local spamConn

spamToggle.MouseButton1Click:Connect(function()
	spamActive = not spamActive
	spamToggle.Text = "Spam: " .. (spamActive and "ON" or "OFF")

	if spamConn then
		spamConn:Disconnect()
		spamConn = nil
	end

	if spamActive then
		spamConn = RunService.Heartbeat:Connect(function()
			local interval = tonumber(intervalBox.Text)
			if not interval or interval <= 0 then interval = 1 end
			local msg = msgBox.Text
			if msg and msg ~= "" then
				game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
				task.wait(interval)
			end
		end)
	end
end)
