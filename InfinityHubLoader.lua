local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local hub = playerGui:FindFirstChild("InfiniteHubGUI")
if hub then
	hub:Destroy()
end
local player = game.Players.LocalPlayer

local hubGui = Instance.new("ScreenGui")
hubGui.Name = "InfiniteHubGUI"
hubGui.ResetOnSpawn = false
hubGui.Parent = player:WaitForChild("PlayerGui")

local hubPanel = Instance.new("Frame")
hubPanel.Name = "InfiniteHub"
hubPanel.Size = UDim2.new(0, 300, 0, 100)
hubPanel.Position = UDim2.new(0.5, -150, 0.1, 0)
hubPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hubPanel.BorderSizePixel = 0
hubPanel.Active = true
hubPanel.Draggable = true
hubPanel.Parent = hubGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "InfiniteHub"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = hubPanel

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 20
closeBtn.Parent = hubPanel

closeBtn.MouseButton1Click:Connect(function()
	local gui = player:FindFirstChild("PlayerGui"):FindFirstChild("InfiniteHubGUI")
	if gui then gui:Destroy() end
loadstring("https://raw.githubusercontent.com/InfinitiveDev/Infinity-hub/refs/heads/main/InjectButtons.lua")()
	end)
