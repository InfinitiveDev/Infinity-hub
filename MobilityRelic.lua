local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local gui = Instance.new("ScreenGui")
gui.Name = "MobilityRelicGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 240, 0, 160)
panel.Position = UDim2.new(0.5, -120, 0.5, -80)
panel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
panel.Active = true
panel.Draggable = true
panel.Parent = gui

-- X Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 20
closeBtn.Parent = panel

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local yOffset = 40

-- Noclip Toggle
local noclipToggle = Instance.new("TextButton")
noclipToggle.Size = UDim2.new(0, 220, 0, 30)
noclipToggle.Position = UDim2.new(0, 10, 0, yOffset)
noclipToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
noclipToggle.Text = "Toggle Noclip: OFF"
noclipToggle.TextColor3 = Color3.new(1, 1, 1)
noclipToggle.Font = Enum.Font.SourceSansBold
noclipToggle.TextSize = 18
noclipToggle.Parent = panel

local noclipActive = false
local noclipScript

noclipToggle.MouseButton1Click:Connect(function()
	noclipActive = not noclipActive
	noclipToggle.Text = "Toggle Noclip: " .. (noclipActive and "ON" or "OFF")

	if noclipActive then
		noclipScript = Instance.new("LocalScript")
		noclipScript.Name = "NoclipRelic"
		noclipScript.Source = [[
			local player = game.Players.LocalPlayer
			local RunService = game:GetService("RunService")

			RunService.Stepped:Connect(function()
				local char = player.Character
				if char then
					for _, part in pairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)
		]]
		noclipScript.Parent = player:WaitForChild("PlayerGui")
	else
		local existing = player:FindFirstChild("PlayerGui"):FindFirstChild("NoclipRelic")
		if existing then existing:Destroy() end
	end
end)

yOffset += 40

-- Wall Climber Toggle
local climbToggle = Instance.new("TextButton")
climbToggle.Size = UDim2.new(0, 220, 0, 30)
climbToggle.Position = UDim2.new(0, 10, 0, yOffset)
climbToggle.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
climbToggle.Text = "Toggle Climb: OFF"
climbToggle.TextColor3 = Color3.new(1, 1, 1)
climbToggle.Font = Enum.Font.SourceSansBold
climbToggle.TextSize = 18
climbToggle.Parent = panel

local climbActive = false
local climbScript

climbToggle.MouseButton1Click:Connect(function()
	climbActive = not climbActive
	climbToggle.Text = "Toggle Climb: " .. (climbActive and "ON" or "OFF")

	if climbActive then
		climbScript = Instance.new("LocalScript")
		climbScript.Name = "ClimbRelic"
		climbScript.Source
