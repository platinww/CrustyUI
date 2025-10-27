--// ✨ Ekran Butonu Scripti v2.0 (Sessiz & Geliştirilmiş Görünüm)
--// createScreenButton(text, baseColor, callback)
--// destroyScreenButton()

local ScreenButton = nil
local Dragging = false
local DragOffset = Vector2.new(0, 0)

-- 🧲 Sürükleme fonksiyonu
local function makeDraggable(gui)
	local UserInputService = game:GetService("UserInputService")
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			DragOffset = input.Position - gui.AbsolutePosition
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			gui.Position = UDim2.fromOffset(input.Position.X - DragOffset.X, input.Position.Y - DragOffset.Y)
		end
	end)
end

-- 🌈 RGB yazı efekti
local function rgbEffect(textButton)
	task.spawn(function()
		while textButton and textButton.Parent do
			textButton.TextColor3 = Color3.fromHSV((tick() * 0.3) % 1, 1, 1)
			task.wait(0.05)
		end
	end)
end

-- 💡 Hover animasyonu
local function hoverEffect(button)
	local TweenService = game:GetService("TweenService")
	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 130, 0, 45)
		}):Play()
	end)
	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 120, 0, 40)
		}):Play()
	end)
end

-- 🌟 Glow efekti (arka gölge)
local function addShadow(parent)
	local shadow = Instance.new("ImageLabel")
	shadow.Name = "Shadow"
	shadow.Parent = parent
	shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	shadow.Position = UDim2.new(0.5, 0, 0.5, 4)
	shadow.Size = UDim2.new(1, 20, 1, 20)
	shadow.ZIndex = 0
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://5028857472"
	shadow.ImageTransparency = 0.7
	shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
end

-- 🎨 createScreenButton()
function createScreenButton(text, baseColor, callback)
	if ScreenButton then return end

	local Player = game.Players.LocalPlayer
	local PlayerGui = Player:WaitForChild("PlayerGui")

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "ChatGPT_ScreenButton"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Parent = PlayerGui

	local Button = Instance.new("TextButton")
	Button.Name = "CoolButton"
	Button.Parent = ScreenGui
	Button.Size = UDim2.new(0, 120, 0, 40)
	Button.Position = UDim2.new(0.4, 0, 0.45, 0)
	Button.BackgroundColor3 = baseColor or Color3.fromRGB(40, 40, 40)
	Button.Text = text or "TIKLA"
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 18
	Button.AutoButtonColor = false
	Button.BorderSizePixel = 0

	local Corner = Instance.new("UICorner", Button)
	Corner.CornerRadius = UDim.new(0, 12)

	local Gradient = Instance.new("UIGradient", Button)
	Gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 60)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 200))
	}
	Gradient.Rotation = 45

	addShadow(Button)
	makeDraggable(Button)
	rgbEffect(Button)
	hoverEffect(Button)

	Button.MouseButton1Click:Connect(function()
		if callback and typeof(callback) == "function" then
			pcall(callback)
		end
	end)

	ScreenButton = ScreenGui
end

-- 🗑 destroyScreenButton()
function destroyScreenButton()
	if ScreenButton then
		ScreenButton:Destroy()
		ScreenButton = nil
	end
end
