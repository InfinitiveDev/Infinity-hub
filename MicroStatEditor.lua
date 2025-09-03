local player = game.Players.LocalPlayer

-- Prevent duplicate GUI
if player:FindFirstChild("PlayerGui"):FindFirstChild("StatEditorGUI") then return end

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "StatEditorGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Create panel
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 220, 0, 200)
panel.Position = UDim2.new(0.5, -110, 0.5, -100)
panel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
panel.Active = true
panel.Draggable = true
panel.Parent = gui

-- X Button to close
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

-- WalkSpeed Label
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 200, 0, 20)
speedLabel.Position = UDim2.new(0, 10, 0, yOffset)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "WalkSpeed:"
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.Font = Enum.Font.SourceSans
speedLabel.TextSize = 18
speedLabel.Parent = panel

yOffset += 25

-- WalkSpeed Input
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 140, 0, 25)
speedBox.Position = UDim2.new(0, 10, 0, yOffset)
speedBox.PlaceholderText = "Enter speed"
speedBox.Text = ""
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
speedBox.Font = Enum.Font.SourceSans
speedBox.TextSize = 18
speedBox.Parent = panel

-- WalkSpeed Apply Button
local speedApply = Instance.new("TextButton")
speedApply.Size = UDim2.new(0, 60, 0, 25)
speedApply.Position = UDim2.new(0, 160, 0, yOffset)
speedApply.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
speedApply.Text = "Apply"
speedApply.TextColor3 = Color3.new(1, 1, 1)
speedApply.Font = Enum.Font.SourceSansBold
speedApply.TextSize = 18
speedApply.Parent = panel

speedApply.MouseButton1Click:Connect(function()
	local value = tonumber(speedBox.Text)
	if value and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = value
	end
end)

yOffset += 35

-- JumpPower Label
local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(0, 200, 0, 20)
jumpLabel.Position = UDim2.new(0, 10, 0, yOffset)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Text = "JumpPower:"
jumpLabel.TextColor3 = Color3.new(1, 1, 1)
jumpLabel.Font = Enum.Font.SourceSans
jumpLabel.TextSize = 18
jumpLabel.Parent = panel

yOffset += 25

-- JumpPower Input
local jumpBox = Instance.new("TextBox")
jumpBox.Size = UDim2.new(0, 140, 0, 25)
jumpBox.Position = UDim2.new(0, 10, 0, yOffset)
jumpBox.PlaceholderText = "Enter jump power"
jumpBox.Text = ""
jumpBox.TextColor3 = Color3.new(1, 1, 1)
jumpBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
jumpBox.Font = Enum.Font.SourceSans
jumpBox.TextSize = 18
jumpBox.Parent = panel

-- JumpPower Apply Button
local jumpApply = Instance.new("TextButton")
jumpApply.Size = UDim2.new(0, 60, 0, 25)
jumpApply.Position = UDim2.new(0, 160, 0, yOffset)
jumpApply.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
jumpApply.Text = "Apply"
jumpApply.TextColor3 = Color3.new(1, 1, 1)
jumpApply.Font = Enum.Font.SourceSansBold
jumpApply.TextSize = 18
jumpApply.Parent = panel

jumpApply.MouseButton1Click:Connect(function()
	local value = tonumber(jumpBox.Text)
	if value and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.JumpPower = value
	end
end)
