-- InfiniteHub V4 — Full Unified Script
local player    = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local RunService= game:GetService("RunService")

--── Create ScreenGui & Main Frame ─────────────────────────────────────────────
local hubGui = Instance.new("ScreenGui")
hubGui.Name           = "InfiniteHubGUI"
hubGui.ResetOnSpawn   = false
hubGui.Parent         = playerGui

local hubFrame = Instance.new("Frame")
hubFrame.Size         = UDim2.new(0, 420, 0, 320)
hubFrame.Position     = UDim2.new(0.5, -210, 0.5, -160)
hubFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
hubFrame.Active       = true
hubFrame.Draggable    = true
hubFrame.Parent       = hubGui

--── Close Button ───────────────────────────────────────────────────────────────
local closeBtn = Instance.new("TextButton")
closeBtn.Size            = UDim2.new(0, 30, 0, 30)
closeBtn.Position        = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3= Color3.fromRGB(255,50,50)
closeBtn.Text            = "X"
closeBtn.TextColor3      = Color3.new(1,1,1)
closeBtn.Font            = Enum.Font.SourceSansBold
closeBtn.TextSize        = 20
closeBtn.Parent          = hubFrame
closeBtn.MouseButton1Click:Connect(function()
    hubGui:Destroy()
end)

--── Tab Buttons & Frames ──────────────────────────────────────────────────────
local tabNames   = {"Player","Environment","Chat"}
local tabButtons = {}
local tabFrames  = {}

for i, name in ipairs(tabNames) do
    -- Button
    local btn = Instance.new("TextButton")
    btn.Name            = name .. "TabBtn"
    btn.Size            = UDim2.new(0, 120, 0, 30)
    btn.Position        = UDim2.new(0, 10 + 130*(i-1), 0, 10)
    btn.BackgroundColor3= Color3.fromRGB(60,60,60)
    btn.Text            = name
    btn.TextColor3      = Color3.new(1,1,1)
    btn.Font            = Enum.Font.SourceSansBold
    btn.TextSize        = 18
    btn.Parent          = hubFrame
    tabButtons[name]    = btn

    -- Frame
    local frame = Instance.new("Frame")
    frame.Name           = name .. "Frame"
    frame.Size           = UDim2.new(0, 400, 0, 260)
    frame.Position       = UDim2.new(0, 10, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.Visible        = (i == 1)
    frame.Parent         = hubFrame
    tabFrames[name]      = frame

    -- Switch logic
    btn.MouseButton1Click:Connect(function()
        for t, f in pairs(tabFrames) do
            f.Visible = (t == name)
        end
    end)
end

--── Utility Constructors ──────────────────────────────────────────────────────
local function createStatInput(parent, labelText, posY, applyFunc)
    local lbl = Instance.new("TextLabel")
    lbl.Size            = UDim2.new(0, 100, 0, 25)
    lbl.Position        = UDim2.new(0, 10, 0, posY)
    lbl.BackgroundTransparency = 1
    lbl.Text            = labelText
    lbl.TextColor3      = Color3.new(1,1,1)
    lbl.Font            = Enum.Font.SourceSans
    lbl.TextSize        = 18
    lbl.Parent          = parent

    local box = Instance.new("TextBox")
    box.Size            = UDim2.new(0, 100, 0, 25)
    box.Position        = UDim2.new(0, 120, 0, posY)
    box.PlaceholderText = "Value"
    box.TextColor3      = Color3.new(1,1,1)
    box.BackgroundColor3= Color3.fromRGB(60,60,60)
    box.Font            = Enum.Font.SourceSans
    box.TextSize        = 18
    box.Parent          = parent

    local applyBtn = Instance.new("TextButton")
    applyBtn.Size            = UDim2.new(0, 60, 0, 25)
    applyBtn.Position        = UDim2.new(0, 230, 0, posY)
    applyBtn.BackgroundColor3= Color3.fromRGB(100,255,100)
    applyBtn.Text            = "Apply"
    applyBtn.TextColor3      = Color3.new(0,0,0)
    applyBtn.Font            = Enum.Font.SourceSansBold
    applyBtn.TextSize        = 18
    applyBtn.Parent          = parent
    applyBtn.MouseButton1Click:Connect(function()
        local val = tonumber(box.Text)
        if val and player.Character and player.Character:FindFirstChild("Humanoid") then
            applyFunc(val)
        end
    end)
end

local function createToggle(parent, labelText, posY, toggleFunc)
    local btn = Instance.new("TextButton")
    btn.Size            = UDim2.new(0, 280, 0, 25)
    btn.Position        = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3= Color3.fromRGB(100,100,255)
    btn.Text            = labelText .. ": OFF"
    btn.TextColor3      = Color3.new(1,1,1)
    btn.Font            = Enum.Font.SourceSansBold
    btn.TextSize        = 18
    btn.Parent          = parent

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = labelText .. ": " .. (active and "ON" or "OFF")
        toggleFunc(active)
    end)
end

--── Player Tab Relics ─────────────────────────────────────────────────────────
local pF = tabFrames["Player"]
createStatInput(pF, "Speed",     10, function(v) player.Character.Humanoid.WalkSpeed = v end)
createStatInput(pF, "JumpPower", 45, function(v) player.Character.Humanoid.JumpPower = v end)
createStatInput(pF, "Spin",      80, function(v)
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if root then root.RotVelocity = Vector3.new(0, v, 0) end
end)
createStatInput(pF, "Item Range",115, function(v)
    for _, tool in ipairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then tool.GripPos = Vector3.new(0,0,-v) end
    end
end)

local climbConn, noclipConn
createToggle(pF, "Wall Climb", 150, function(on)
    if climbConn then climbConn:Disconnect() climbConn = nil end
    if on then
        climbConn = RunService.Stepped:Connect(function()
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    for _, part in ipairs(workspace:GetDescendants()) do
                        if part:IsA("BasePart") and not part:IsDescendantOf(char) then
                            if (root.Position - part.Position).Magnitude < 2 then
                                char:SetPrimaryPartCFrame(part.CFrame + Vector3.new(0, part.Size.Y + 3, 0))
                            end
                        end
                    end
                end
            end
        end)
    end
end)

createToggle(pF, "Noclip", 180, function(on)
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    if on then
        noclipConn = RunService.Stepped:Connect(function()
            local char = player.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

--── Environment Tab Relics ────────────────────────────────────────────────────
local eF = tabFrames["Environment"]
local pushConn, magnetConn
createToggle(eF, "Push Mode", 10, function(on)
    if pushConn then pushConn:Disconnect() pushConn = nil end
    if on then
        pushConn = RunService.Stepped:Connect(function()
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    for _, part in ipairs(workspace:GetDescendants()) do
                        if part:IsA("BasePart") and not part:IsDescendantOf(char) then
                            if (part.Position - root.Position).Magnitude < 10 then
                                part.Velocity = (part.Position - root.Position).Unit * 50
                            end
                        end
                    end
                end
            end
        end)
    end
end)

createToggle(eF, "Magnet Mode", 45, function(on)
    if magnetConn then magnetConn:Disconnect() magnetConn = nil end
    if on then
        magnetConn = RunService.Stepped:Connect(function()
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    for _, part in ipairs(workspace:GetDescendants()) do
                        if part:IsA("BasePart") and not part:IsDescendantOf(char) then
                            if (part.Position - root.Position).Magnitude < 10 then
                                part.Velocity = (root.Position - part.Position).Unit * 50
                            end
                        end
                    end
                end
            end
        end)
    end
end)

--── Chat Tab Relics ───────────────────────────────────────────────────────────
local cF = tabFrames["Chat"]

local msgLabel = Instance.new("TextLabel")
msgLabel.Size            = UDim2.new(0,100,0,25)
msgLabel.Position        = UDim2.new(0,10,0,10)
msgLabel.BackgroundTransparency = 1
msgLabel.Text            = "Message"
msgLabel.TextColor3      = Color3.new(1,1,1)
msgLabel.Font            = Enum.Font.SourceSans
msgLabel.TextSize        = 18
msgLabel.Parent          = cF

local msgBox = Instance.new("TextBox")
msgBox.Size              = UDim2.new(0,200,0,25)
msgBox.Position          = UDim2.new(0,120,0,10)
msgBox.PlaceholderText   = "Hello world!"
msgBox.TextColor3        = Color3.new(1,1,1)
msgBox.BackgroundColor3  = Color3.fromRGB(60,60,60)
msgBox.Font              = Enum.Font.SourceSans
msgBox.TextSize          = 18
msgBox.Parent            = cF

local intervalLabel = Instance.new("TextLabel")
intervalLabel.Size            = UDim2.new(0,100,0,25)
intervalLabel.Position        = UDim2.new(0,10,0,45)
intervalLabel.BackgroundTransparency = 1
intervalLabel.Text            = "Interval (s)"
intervalLabel.TextColor3      = Color3.new(1,1,1)
intervalLabel.Font            = Enum.Font.SourceSans
intervalLabel.TextSize        = 18
intervalLabel.Parent          = cF

local intervalBox = Instance.new("TextBox")
intervalBox.Size              = UDim2.new(0,200,0,25)
intervalBox.Position          = UDim2.new(0,120,0,45)
intervalBox.PlaceholderText   = "1"
intervalBox.TextColor3        = Color3.new(1,1,1)
intervalBox.BackgroundColor3  = Color3.fromRGB(60,60,60)
intervalBox.Font              = Enum.Font.SourceSans
intervalBox.TextSize          = 18
intervalBox.Parent            = cF

local spamToggle = Instance.new("TextButton")
spamToggle.Size            = UDim2.new(0,280,0,25)
spamToggle.Position        = UDim2.new(0,10,0,80)
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
