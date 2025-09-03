local player = game.Players.LocalPlayer
local hubPanel = player:WaitForChild("PlayerGui"):WaitForChild("InfiniteHubGUI"):WaitForChild("InfiniteHub")

-- Tint Changer Button
local tintBtn = Instance.new("TextButton")
tintBtn.Size = UDim2.new(0, 280, 0, 40)
tintBtn.Position = UDim2.new(0, 10, 0, 40)
tintBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
tintBtn.Text = "Tint Changer"
tintBtn.TextColor3 = Color3.new(1, 1, 1)
tintBtn.Font = Enum.Font.SourceSansBold
tintBtn.TextSize = 20
tintBtn.Parent = hubPanel

tintBtn.MouseButton1Click:Connect(function()
	loadstring("https://raw.githubusercontent.com/InfinitiveDev/Infinity-hub/refs/heads/main/TintChanger.lua")()
end)

-- Micro Stat Editor Button
local statBtn = Instance.new("TextButton")
statBtn.Size = UDim2.new(0, 280, 0, 40)
statBtn.Position = UDim2.new(0, 10, 0, 90)
statBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
statBtn.Text = "Micro Stat Editor"
statBtn.TextColor3 = Color3.new(1, 1, 1)
statBtn.Font = Enum.Font.SourceSansBold
statBtn.TextSize = 20
statBtn.Parent = hubPanel

statBtn.MouseButton1Click:Connect(function()
	loadstring("https://raw.githubusercontent.com/InfinitiveDev/Infinity-hub/refs/heads/main/MicroStatEditor.lua")()
end)
