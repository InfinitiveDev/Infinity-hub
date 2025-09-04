local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("InfiniteHubGUI") then return end

local hubGui = Instance.new("ScreenGui")
hubGui.Name = "InfiniteHubGUI"
hubGui.ResetOnSpawn = false
hubGui.Parent = playerGui

local hubPanel = Instance.new("Frame")
hubPanel.Size = UDim2.new(0, 400, 0, 300)
hubPanel.Position = UDim2.new(0.5, -200, 0.5, -150)
hubPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hubPanel.Active = true
hubPanel.Draggable = true
hubPanel.Parent = hubGui

local tabButtons = {}
local tabFrames = {}

local function createTab(name, index)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 120, 0, 30)
	btn.Position = UDim2.new(0, 10 + (130 * (index - 1)), 0, 10)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Text = name
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	btn.Parent = hubPanel
	tabButtons[name] = btn

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 380, 0, 240)
	frame.Position = UDim2.new(0, 10, 0, 50)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.Visible = false
	frame.Parent = hubPanel
	tabFrames[name] = frame

	btn.MouseButton1Click:Connect(function()
		for tab, f in pairs(tabFrames) do
			f.Visible = (tab == name)
		end
	end)
end

createTab("Player", 1)
createTab("Environment", 2)
createTab("Chat", 3)

tabFrames["Player"].Visible = true

-- 🧍 PLAYER TAB
local function createStatInput(labelText, y, applyFunc)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 100, 0, 25)
	label.Position = UDim2.new(0, 10, 0, y)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.SourceSans
	label.TextSize = 18
	label.Parent = tabFrames["Player"]

	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0, 100, 0, 25)
	box.Position = UDim2.new(0, 120, 0, y)
	box.PlaceholderText = "Value"
	box.Text = ""
	box.TextColor3 = Color3.new(1, 1, 1)
	box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	box.Font = Enum.Font.SourceSans
	box.TextSize = 18
	box.Parent = tabFrames["Player"]

	local apply = Instance.new("TextButton")
	apply.Size = UDim2.new(0, 60, 0, 25)
	apply.Position = UDim2.new(0, 230, 0, y)
	apply.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
	apply.Text = "Apply"
	apply.TextColor3 = Color3.new(0, 0, 0)
	apply.Font = Enum.Font.SourceSansBold
	apply.TextSize = 18
	apply.Parent = tabFrames["Player"]

	apply.MouseButton1Click:Connect(function()
		local val = tonumber(box.Text)
		if val and player.Character and player.Character:FindFirstChild("Humanoid") then
			applyFunc(val)
		end
	end)
end

createStatInput("Speed", 10, function(v) player.Character.Humanoid.WalkSpeed = v end)
createStatInput("JumpPower", 45, function(v) player.Character.Humanoid.JumpPower = v end)
createStatInput("Spin", 80, function(v)
	local root = player.Character:FindFirstChild("HumanoidRootPart")
	if root then root.RotVelocity = Vector3.new(0, v, 0) end
end)
createStatInput("Item Range", 115, function(v)
	for _, tool in pairs(player.Backpack:GetChildren()) do
		if tool:IsA("Tool") then tool.GripPos = Vector3.new(0, 0, -v) end
	end
end)

local function createToggle(labelText, y, scriptName, scriptSource)
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(0, 280, 0, 25)
	toggle.Position = UDim2.new(0, 10, 0, y)
	toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
	toggle.Text = labelText .. ": OFF"
	toggle.TextColor3 = Color3.new(1, 1, 1)
	toggle.Font = Enum.Font.SourceSansBold
	toggle.TextSize = 18
	toggle.Parent = tabFrames["Player"]

	local active = false

	toggle.MouseButton1Click:Connect(function()
		active = not active
		toggle.Text = labelText .. ": " .. (active and "ON" or "OFF")
		local existing = playerGui:FindFirstChild(scriptName)
		if existing then existing:Destroy() end
		if active then
			local script = Instance.new("LocalScript")
			script.Name = scriptName
			script.Source = scriptSource
			script.Parent = playerGui
		end
	end)
end

createToggle("Wall Climb", 150, "ClimbRelic", [[
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
]])

createToggle("Noclip", 180, "NoclipRelic", [[
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
]])

-- 🌍 ENVIRONMENT TAB
createToggle("Push Mode", 10, "PushRelic", [[
	local player = game.Players.LocalPlayer
	local RunService = game:GetService("RunService")
	RunService.Stepped:Connect(function()
		local char = player.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		for _, part in pairs(workspace:GetDescendants()) do
			if part:IsA("BasePart") and not part:IsDescendantOf(char) then
				if (part.Position - root.Position).Magnitude < 10 then
					part.Velocity = (part.Position - root.Position).Unit * 50
				end
			end
		end
	end)
]])

createToggle("Magnet Mode", 45, "MagnetRelic", [[
	local player = game.Players.LocalPlayer
	local RunService = game:GetService("RunService")
	RunService.Stepped:Connect(function()
		local char = player.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		for _, part in pairs(workspace:GetDescendants()) do
			if part:IsA("BasePart") and not part:IsDescendantOf(char) then
				if (part.Position - root.Position).Magnitude < 10 then
					part.Velocity = (root.Position - part.Position).Unit *
