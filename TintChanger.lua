local player = game.Players.LocalPlayer
local lighting = game:GetService("Lighting")

if player:FindFirstChild("PlayerGui"):FindFirstChild("TintPanelGUI") then return end

-- Create tint effect
local tintEffect = Instance.new("ColorCorrectionEffect")
tintEffect.Name = "TintRelic"
tintEffect.Enabled = true
tintEffect.TintColor = Color3.fromRGB(255, 255, 255)
tintEffect.Saturation = 1
tintEffect.Contrast = 0
tintEffect.Brightness = 0
tintEffect.Parent = lighting

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TintPanelGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 200, 0, 300)
panel.Position = UDim2.new(0.5, -100, 0.5, -150)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
panel.Active = true
panel.Draggable = true
panel.Parent = gui

-- Color buttons
local colors = {
	Red = Color3.fromRGB(255, 100, 100),
	Green = Color3.fromRGB(100, 255, 100),
	Blue = Color3.fromRGB(100, 100, 255),
	Purple = Color3.fromRGB(200, 100, 255),
	Yellow = Color3.fromRGB(255, 255, 100),
}

local yOffset = 10
for name, color in pairs(colors) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 180, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, yOffset)
	btn.BackgroundColor3 = color
	btn.Text = name
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	btn.Parent = panel

	btn.MouseButton1Click:Connect(function()
		tintEffect.TintColor = color
	end)

	yOffset += 35
end

-- Clear Tint Button
local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0, 180, 0, 30)
clearBtn.Position = UDim2.new(0, 10, 0, yOffset)
clearBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
clearBtn.Text = "Clear Tint"
clearBtn.TextColor3 = Color3.new(1, 1, 1)
clearBtn.Font = Enum.Font.SourceSansBold
clearBtn.TextSize = 18
clearBtn.Parent = panel

clearBtn.MouseButton1Click:Connect(function()
	tintEffect.TintColor = Color3.fromRGB(255, 255, 255)
end)

yOffset += 35

-- Wipe GUI Button
local wipeBtn = Instance.new("TextButton")
wipeBtn.Size = UDim2.new(0, 180, 0, 30)
wipeBtn.Position = UDim2.new(0, 10, 0, yOffset)
wipeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
wipeBtn.Text = "Wipe GUI"
wipeBtn.TextColor3 = Color3.new(1, 1, 1)
wipeBtn.Font = Enum.Font.SourceSansBold
wipeBtn.TextSize = 18
wipeBtn.Parent = panel

wipeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
	tintEffect:Destroy()
end)
