local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Prevent duplicate GUI
if playerGui:FindFirstChild("MobilityRelicGUI") then return end

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MobilityRelicGUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Create Panel
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 240, 0, 160)
panel.Position = UDim2.new(0.5, -120, 0.5, -80)
panel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
panel.BorderSizePixel = 0
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
local noclipScriptName = "NoclipRelic"

noclipToggle.MouseButton1Click:Connect(function()
	noclipActive = not noclipActive
	noclipToggle.Text = "Toggle Noclip: " .. (noclipActive and "ON" or "OFF")

	local existing = playerGui:FindFirstChild(noclipScriptName)
	if existing then existing:Destroy() end

	if noclipActive then
		local script = Instance.new("LocalScript")
		script.Name = noclipScriptName
		script.Source = [[
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
		script.Parent = playerGui
	end
end)

yOffset += 40

-- Wall Climb Toggle
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
local climbScriptName = "ClimbRelic"

climbToggle.MouseButton1Click:Connect(function()
	climbActive = not climbActive
	climbToggle.Text = "Toggle Climb: " .. (climbActive and "ON" or "OFF")

	local existing = playerGui:FindFirstChild(climbScriptName)
	if existing then existing:Destroy() end

	if climbActive then
		local script = Instance.new("LocalScript")
		script.Name = climbScriptName
		script.Source = [[
			local player = game.Players.LocalPlayer
			local RunService = game:GetService("RunService")

			RunService.Stepped:Connect(function()
				local char = player.Character
				if not char then return end
				local head = char:FindFirstChild("Head")
				local root = char:FindFirstChild("HumanoidRootPart")
				if not head or not root then return end

				for _, part in pairs(workspace:GetDescendants()) do
					if part:IsA("BasePart") and not part:IsDescendantOf(char) then
						if (head.Position - part.Position).Magnitude < 2 or (root.Position - part.Position).Magnitude < 2 then
							char:SetPrimaryPartCFrame(part.CFrame + Vector3.new(0, part.Size.Y + 3, 0))
						end
					end
				end
			end)
		]]
		script.Parent = playerGui
	end
end)
