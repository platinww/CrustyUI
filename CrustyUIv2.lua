--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  LIBRARY V2

Crusty Library V2 - Advanced Modern UI Library
]=]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Library = {}
Library.__index = Library

-- Tema Renkleri
local Themes = {
	Dark = {
		Background = Color3.fromRGB(25, 25, 35),
		Secondary = Color3.fromRGB(35, 35, 50),
		Accent = Color3.fromRGB(88, 101, 242),
		Text = Color3.fromRGB(255, 255, 255),
		TextSecondary = Color3.fromRGB(180, 180, 190),
		Button = Color3.fromRGB(50, 50, 70),
		ButtonHover = Color3.fromRGB(60, 60, 85),
		Toggle = Color3.fromRGB(88, 101, 242),
		ToggleOff = Color3.fromRGB(60, 60, 75),
		NotifyBg = Color3.fromRGB(30, 30, 45),
		Success = Color3.fromRGB(67, 181, 129),
		Error = Color3.fromRGB(240, 71, 71),
		Warning = Color3.fromRGB(250, 166, 26),
		Info = Color3.fromRGB(52, 152, 219)
	},
	White = {
		Background = Color3.fromRGB(245, 245, 250),
		Secondary = Color3.fromRGB(255, 255, 255),
		Accent = Color3.fromRGB(88, 101, 242),
		Text = Color3.fromRGB(20, 20, 30),
		TextSecondary = Color3.fromRGB(100, 100, 110),
		Button = Color3.fromRGB(240, 240, 245),
		ButtonHover = Color3.fromRGB(230, 230, 240),
		Toggle = Color3.fromRGB(88, 101, 242),
		ToggleOff = Color3.fromRGB(200, 200, 210),
		NotifyBg = Color3.fromRGB(255, 255, 255),
		Success = Color3.fromRGB(67, 181, 129),
		Error = Color3.fromRGB(240, 71, 71),
		Warning = Color3.fromRGB(250, 166, 26),
		Info = Color3.fromRGB(52, 152, 219)
	}
}

-- Tween ayarları
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local fastTween = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local notifyTween = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

function Library:CreateWindow(config)
	config = config or {}
	local windowTitle = config.Title or "Crusty HUB V1"
	local windowIcon = config.Icon or "rbxassetid://7734053495"
	local themeName = config.Theme or "Dark"
	local draggableUI = config.DraggableUI ~= false
	
	local currentTheme = Themes[themeName] or Themes.Dark
	
	local window = {}
	window.CurrentTab = nil
	window.Tabs = {}
	window.ToggleButton = nil
	window.MainFrame = nil
	window.Theme = currentTheme
	window.NotificationQueue = {}
	window.ActiveNotifications = 0
	
	-- ScreenGui oluştur
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "CrustyLibrary"
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	
	-- Notification Container
	local NotificationContainer = Instance.new("Frame")
	NotificationContainer.Name = "NotificationContainer"
	NotificationContainer.BackgroundTransparency = 1
	NotificationContainer.Size = UDim2.new(0, 300, 1, -20)
	NotificationContainer.Position = UDim2.new(1, -310, 0, 10)
	NotificationContainer.Parent = ScreenGui
	
	local NotifyLayout = Instance.new("UIListLayout")
	NotifyLayout.SortOrder = Enum.SortOrder.LayoutOrder
	NotifyLayout.Padding = UDim.new(0, 10)
	NotifyLayout.Parent = NotificationContainer
	
	-- Ana Frame (Arka plan)
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.BorderSizePixel = 0
	MainFrame.BackgroundColor3 = currentTheme.Background
	MainFrame.Size = UDim2.new(0, 500, 0, 400)
	MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
	MainFrame.ClipsDescendants = true
	MainFrame.Parent = ScreenGui
	
	window.MainFrame = MainFrame
	
	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 12)
	MainCorner.Parent = MainFrame
	
	-- Shadow Effect
	local Shadow = Instance.new("ImageLabel")
	Shadow.Name = "Shadow"
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(0, -15, 0, -15)
	Shadow.Size = UDim2.new(1, 30, 1, 30)
	Shadow.ZIndex = 0
	Shadow.Image = "rbxassetid://6014261993"
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.5
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
	Shadow.Parent = MainFrame
	
	-- Başlık Frame
	local TitleFrame = Instance.new("Frame")
	TitleFrame.Name = "TitleFrame"
	TitleFrame.BorderSizePixel = 0
	TitleFrame.BackgroundColor3 = currentTheme.Secondary
	TitleFrame.Size = UDim2.new(1, -16, 0, 48)
	TitleFrame.Position = UDim2.new(0, 8, 0, 8)
	TitleFrame.Parent = MainFrame
	
	local TitleCorner = Instance.new("UICorner")
	TitleCorner.CornerRadius = UDim.new(0, 8)
	TitleCorner.Parent = TitleFrame
	
	-- Icon (emoji için)
	local IconLabel = Instance.new("TextLabel")
	IconLabel.Name = "IconLabel"
	IconLabel.BackgroundTransparency = 1
	IconLabel.Size = UDim2.new(0, 32, 0, 32)
	IconLabel.Position = UDim2.new(0, 8, 0, 8)
	IconLabel.Text = "📂"
	IconLabel.TextSize = 24
	IconLabel.Parent = TitleFrame
	
	-- Başlık Text
	local TitleText = Instance.new("TextLabel")
	TitleText.Name = "TitleText"
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.ZIndex = 2
	TitleText.BorderSizePixel = 0
	TitleText.TextSize = 18
	TitleText.BackgroundTransparency = 1
	TitleText.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TitleText.Size = UDim2.new(1, -100, 1, 0)
	TitleText.Position = UDim2.new(0, 48, 0, 0)
	TitleText.Text = windowTitle
	TitleText.TextColor3 = currentTheme.Text
	TitleText.Parent = TitleFrame
	
	-- Theme Toggle Button
	local ThemeButton = Instance.new("TextButton")
	ThemeButton.Name = "ThemeButton"
	ThemeButton.ZIndex = 3
	ThemeButton.BorderSizePixel = 0
	ThemeButton.BackgroundColor3 = currentTheme.Button
	ThemeButton.Size = UDim2.new(0, 36, 0, 36)
	ThemeButton.Position = UDim2.new(1, -82, 0, 6)
	ThemeButton.Text = themeName == "Dark" and "🌙" or "☀️"
	ThemeButton.TextSize = 18
	ThemeButton.AutoButtonColor = false
	ThemeButton.Parent = TitleFrame
	
	local ThemeCorner = Instance.new("UICorner")
	ThemeCorner.CornerRadius = UDim.new(0, 8)
	ThemeCorner.Parent = ThemeButton
	
	-- Close Button (X)
	local CloseButton = Instance.new("TextButton")
	CloseButton.Name = "CloseButton"
	CloseButton.ZIndex = 3
	CloseButton.BorderSizePixel = 0
	CloseButton.BackgroundColor3 = Color3.fromRGB(240, 71, 71)
	CloseButton.Size = UDim2.new(0, 36, 0, 36)
	CloseButton.Position = UDim2.new(1, -40, 0, 6)
	CloseButton.Text = "✕"
	CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.TextSize = 18
	CloseButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	CloseButton.AutoButtonColor = false
	CloseButton.Parent = TitleFrame
	
	local CloseCorner = Instance.new("UICorner")
	CloseCorner.CornerRadius = UDim.new(0, 8)
	CloseCorner.Parent = CloseButton
	
	CloseButton.MouseButton1Click:Connect(function()
		TweenService:Create(MainFrame, tweenInfo, {
			Size = UDim2.new(0, 0, 0, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0)
		}):Play()
		
		task.wait(0.3)
		MainFrame.Visible = false
		MainFrame.Size = UDim2.new(0, 500, 0, 400)
		MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
	end)
	
	CloseButton.MouseEnter:Connect(function()
		TweenService:Create(CloseButton, fastTween, {BackgroundColor3 = Color3.fromRGB(220, 51, 51)}):Play()
	end)
	
	CloseButton.MouseLeave:Connect(function()
		TweenService:Create(CloseButton, fastTween, {BackgroundColor3 = Color3.fromRGB(240, 71, 71)}):Play()
	end)
	
	-- Theme değiştirme
	ThemeButton.MouseButton1Click:Connect(function()
		themeName = themeName == "Dark" and "White" or "Dark"
		currentTheme = Themes[themeName]
		window.Theme = currentTheme
		
		ThemeButton.Text = themeName == "Dark" and "🌙" or "☀️"
		
		-- UI elementlerini güncelle
		TweenService:Create(MainFrame, tweenInfo, {BackgroundColor3 = currentTheme.Background}):Play()
		TweenService:Create(TitleFrame, tweenInfo, {BackgroundColor3 = currentTheme.Secondary}):Play()
		TweenService:Create(TitleText, tweenInfo, {TextColor3 = currentTheme.Text}):Play()
		TweenService:Create(ThemeButton, tweenInfo, {BackgroundColor3 = currentTheme.Button}):Play()
		
		for _, tab in pairs(window.Tabs) do
			if tab.Button then
				TweenService:Create(tab.Button, tweenInfo, {
					BackgroundColor3 = window.CurrentTab == tab and currentTheme.Accent or currentTheme.Button,
					TextColor3 = currentTheme.Text
				}):Play()
			end
			if tab.Container then
				TweenService:Create(tab.Container.Parent, tweenInfo, {BackgroundColor3 = currentTheme.Secondary}):Play()
			end
		end
		
		window:Notify({
			Title = "Theme Changed",
			Description = "Switched to " .. themeName .. " theme",
			Duration = 2,
			Type = "Info"
		})
	end)
	
	ThemeButton.MouseEnter:Connect(function()
		TweenService:Create(ThemeButton, fastTween, {BackgroundColor3 = currentTheme.ButtonHover}):Play()
	end)
	
	ThemeButton.MouseLeave:Connect(function()
		TweenService:Create(ThemeButton, fastTween, {BackgroundColor3 = currentTheme.Button}):Play()
	end)
	
	-- Tab Container (Scrolling)
	local TabContainer = Instance.new("ScrollingFrame")
	TabContainer.Name = "TabContainer"
	TabContainer.BorderSizePixel = 0
	TabContainer.BackgroundTransparency = 1
	TabContainer.Size = UDim2.new(1, -16, 0, 38)
	TabContainer.Position = UDim2.new(0, 8, 0, 64)
	TabContainer.ScrollBarThickness = 0
	TabContainer.CanvasSize = UDim2.new(0, 0, 0, 38)
	TabContainer.ScrollingDirection = Enum.ScrollingDirection.X
	TabContainer.Parent = MainFrame
	
	local TabLayout = Instance.new("UIListLayout")
	TabLayout.FillDirection = Enum.FillDirection.Horizontal
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 8)
	TabLayout.Parent = TabContainer
	
	TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabContainer.CanvasSize = UDim2.new(0, TabLayout.AbsoluteContentSize.X, 0, 38)
	end)
	
	-- Content Container
	local ContentContainer = Instance.new("Frame")
	ContentContainer.Name = "ContentContainer"
	ContentContainer.BorderSizePixel = 0
	ContentContainer.BackgroundColor3 = currentTheme.Secondary
	ContentContainer.Size = UDim2.new(1, -16, 1, -120)
	ContentContainer.Position = UDim2.new(0, 8, 0, 110)
	ContentContainer.Parent = MainFrame
	
	local ContentCorner = Instance.new("UICorner")
	ContentCorner.CornerRadius = UDim.new(0, 8)
	ContentCorner.Parent = ContentContainer
	
	-- Dragging System
	if draggableUI then
		local dragging, dragInput, dragStart, startPos
		
		TitleFrame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				dragStart = input.Position
				startPos = MainFrame.Position
				
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)
		
		TitleFrame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				dragInput = input
			end
		end)
		
		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				local delta = input.Position - dragStart
				MainFrame.Position = UDim2.new(
					startPos.X.Scale, startPos.X.Offset + delta.X,
					startPos.Y.Scale, startPos.Y.Offset + delta.Y
				)
			end
		end)
	end
	
	-- Toggle Button oluşturma (Circular & Draggable)
	local ToggleButton = Instance.new("ImageButton")
	ToggleButton.Name = "ToggleButton"
	ToggleButton.Image = windowIcon
	ToggleButton.Size = UDim2.new(0, 60, 0, 60)
	ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
	ToggleButton.BackgroundColor3 = currentTheme.Accent
	ToggleButton.BorderSizePixel = 0
	ToggleButton.ScaleType = Enum.ScaleType.Fit
	ToggleButton.ImageTransparency = 0.1
	ToggleButton.Parent = ScreenGui
	
	local ToggleCorner = Instance.new("UICorner")
	ToggleCorner.CornerRadius = UDim.new(1, 0)
	ToggleCorner.Parent = ToggleButton
	
	local ToggleShadow = Instance.new("ImageLabel")
	ToggleShadow.Name = "Shadow"
	ToggleShadow.BackgroundTransparency = 1
	ToggleShadow.Position = UDim2.new(0, -10, 0, -10)
	ToggleShadow.Size = UDim2.new(1, 20, 1, 20)
	ToggleShadow.ZIndex = 0
	ToggleShadow.Image = "rbxassetid://6014261993"
	ToggleShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ToggleShadow.ImageTransparency = 0.6
	ToggleShadow.ScaleType = Enum.ScaleType.Slice
	ToggleShadow.SliceCenter = Rect.new(49, 49, 450, 450)
	ToggleShadow.Parent = ToggleButton
	
	window.ToggleButton = ToggleButton
	
	-- Toggle açma/kapama
	ToggleButton.MouseButton1Click:Connect(function()
		if MainFrame.Visible then
			TweenService:Create(MainFrame, tweenInfo, {
				Size = UDim2.new(0, 0, 0, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0)
			}):Play()
			
			task.wait(0.3)
			MainFrame.Visible = false
			MainFrame.Size = UDim2.new(0, 500, 0, 400)
			MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
		else
			MainFrame.Visible = true
			MainFrame.Size = UDim2.new(0, 0, 0, 0)
			MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			
			TweenService:Create(MainFrame, tweenInfo, {
				Size = UDim2.new(0, 500, 0, 400),
				Position = UDim2.new(0.5, -250, 0.5, -200)
			}):Play()
		end
	end)
	
	-- Toggle buton hover
	ToggleButton.MouseEnter:Connect(function()
		TweenService:Create(ToggleButton, fastTween, {
			Size = UDim2.new(0, 70, 0, 70),
			BackgroundColor3 = Color3.new(
				currentTheme.Accent.R * 1.1,
				currentTheme.Accent.G * 1.1,
				currentTheme.Accent.B * 1.1
			)
		}):Play()
	end)
	
	ToggleButton.MouseLeave:Connect(function()
		TweenService:Create(ToggleButton, fastTween, {
			Size = UDim2.new(0, 60, 0, 60),
			BackgroundColor3 = currentTheme.Accent
		}):Play()
	end)
	
	-- Toggle buton sürükleme
	local toggleDragging, toggleDragInput, toggleDragStart, toggleStartPos
	
	ToggleButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			toggleDragging = true
			toggleDragStart = input.Position
			toggleStartPos = ToggleButton.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					toggleDragging = false
				end
			end)
		end
	end)
	
	ToggleButton.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			toggleDragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == toggleDragInput and toggleDragging then
			local delta = input.Position - toggleDragStart
			ToggleButton.Position = UDim2.new(
				toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X,
				toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y
			)
		end
	end)
	
	-- Notification System
	function window:Notify(config)
		config = config or {}
		local title = config.Title or "Notification"
		local description = config.Description or "No description provided"
		local duration = config.Duration or 3
		local notifyType = config.Type or "Info"
		
		local typeColors = {
			Success = currentTheme.Success,
			Error = currentTheme.Error,
			Warning = currentTheme.Warning,
			Info = currentTheme.Info
		}
		
		local typeIcons = {
			Success = "✓",
			Error = "✕",
			Warning = "⚠",
			Info = "ℹ"
		}
		
		local accentColor = typeColors[notifyType] or currentTheme.Info
		local icon = typeIcons[notifyType] or "ℹ"
		
		window.ActiveNotifications = window.ActiveNotifications + 1
		
		local NotifyFrame = Instance.new("Frame")
		NotifyFrame.Name = "Notification"
		NotifyFrame.BorderSizePixel = 0
		NotifyFrame.BackgroundColor3 = currentTheme.NotifyBg
		NotifyFrame.Size = UDim2.new(1, 0, 0, 0)
		NotifyFrame.ClipsDescendants = true
		NotifyFrame.LayoutOrder = window.ActiveNotifications
		NotifyFrame.Parent = NotificationContainer
		
		local NotifyCorner = Instance.new("UICorner")
		NotifyCorner.CornerRadius = UDim.new(0, 10)
		NotifyCorner.Parent = NotifyFrame
		
		local NotifyStroke = Instance.new("UIStroke")
		NotifyStroke.Color = accentColor
		NotifyStroke.Thickness = 2
		NotifyStroke.Parent = NotifyFrame
		
		local NotifyShadow = Instance.new("ImageLabel")
		NotifyShadow.BackgroundTransparency = 1
		NotifyShadow.Position = UDim2.new(0, -10, 0, -10)
		NotifyShadow.Size = UDim2.new(1, 20, 1, 20)
		NotifyShadow.ZIndex = 0
		NotifyShadow.Image = "rbxassetid://6014261993"
		NotifyShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		NotifyShadow.ImageTransparency = 0.7
		NotifyShadow.ScaleType = Enum.ScaleType.Slice
		NotifyShadow.SliceCenter = Rect.new(49, 49, 450, 450)
		NotifyShadow.Parent = NotifyFrame
		
		local IconLabel = Instance.new("TextLabel")
		IconLabel.BackgroundTransparency = 1
		IconLabel.Size = UDim2.new(0, 32, 0, 32)
		IconLabel.Position = UDim2.new(0, 10, 0, 10)
		IconLabel.Text = icon
		IconLabel.TextSize = 20
		IconLabel.TextColor3 = accentColor
		IconLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		IconLabel.Parent = NotifyFrame
		
		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Size = UDim2.new(1, -55, 0, 20)
		TitleLabel.Position = UDim2.new(0, 50, 0, 8)
		TitleLabel.Text = title
		TitleLabel.TextSize = 15
		TitleLabel.TextColor3 = currentTheme.Text
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		TitleLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		TitleLabel.Parent = NotifyFrame
		
		local DescLabel = Instance.new("TextLabel")
		DescLabel.BackgroundTransparency = 1
		DescLabel.Size = UDim2.new(1, -55, 0, 18)
		DescLabel.Position = UDim2.new(0, 50, 0, 28)
		DescLabel.Text = description
		DescLabel.TextSize = 13
		DescLabel.TextColor3 = currentTheme.TextSecondary
		DescLabel.TextXAlignment = Enum.TextXAlignment.Left
		DescLabel.TextWrapped = true
		DescLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		DescLabel.Parent = NotifyFrame
		
		local ProgressBar = Instance.new("Frame")
		ProgressBar.BorderSizePixel = 0
		ProgressBar.BackgroundColor3 = accentColor
		ProgressBar.Size = UDim2.new(1, 0, 0, 3)
		ProgressBar.Position = UDim2.new(0, 0, 1, -3)
		ProgressBar.Parent = NotifyFrame
		
		local ProgressCorner = Instance.new("UICorner")
		ProgressCorner.CornerRadius = UDim.new(0, 2)
		ProgressCorner.Parent = ProgressBar
		
		-- Animasyon
		TweenService:Create(NotifyFrame, notifyTween, {Size = UDim2.new(1, 0, 0, 54)}):Play()
		
		task.wait(0.4)
		
		TweenService:Create(ProgressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
			Size = UDim2.new(0, 0, 0, 3)
		}):Play()
		
		task.wait(duration)
		
		TweenService:Create(NotifyFrame, fastTween, {
			Size = UDim2.new(1, 0, 0, 0)
		}):Play()
		
		task.wait(0.2)
		NotifyFrame:Destroy()
		window.ActiveNotifications = window.ActiveNotifications - 1
	end
	
	-- Tab oluşturma fonksiyonu
	function window:CreateTab(tabName)
		local tab = {}
		tab.Elements = {}
		tab.Container = nil
		tab.Button = nil
		
		local TabButton = Instance.new("TextButton")
		TabButton.Name = tabName
		TabButton.ZIndex = 2
		TabButton.BorderSizePixel = 0
		TabButton.TextSize = 14
		TabButton.BackgroundColor3 = currentTheme.Button
		TabButton.TextColor3 = currentTheme.Text
		TabButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		TabButton.Size = UDim2.new(0, 100, 0, 38)
		TabButton.Text = tabName
		TabButton.AutoButtonColor = false
		TabButton.Parent = TabContainer
		
		local TabCorner = Instance.new("UICorner")
		TabCorner.CornerRadius = UDim.new(0, 8)
		TabCorner.Parent = TabButton
		
		tab.Button = TabButton
		
		local TabContent = Instance.new("ScrollingFrame")
		TabContent.Name = tabName .. "Content"
		TabContent.BorderSizePixel = 0
		TabContent.BackgroundTransparency = 1
		TabContent.Size = UDim2.new(1, -16, 1, -16)
		TabContent.Position = UDim2.new(0, 8, 0, 8)
		TabContent.ScrollBarThickness = 4
		TabContent.ScrollBarImageColor3 = currentTheme.Accent
		TabContent.Visible = false
		TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
		TabContent.Parent = ContentContainer
		
		local ContentLayout = Instance.new("UIListLayout")
		ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ContentLayout.Padding = UDim.new(0, 8)
		ContentLayout.Parent = TabContent
		
		ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
		end)
		
		tab.Container = TabContent
		
		-- Tab değiştirme
		TabButton.MouseButton1Click:Connect(function()
			for _, otherTab in pairs(window.Tabs) do
				if otherTab.Container then
					TweenService:Create(otherTab.Container, fastTween, {Size = UDim2.new(1, -16, 0, 0)}):Play()
					task.wait(0.15)
					otherTab.Container.Visible = false
					otherTab.Container.Size = UDim2.new(1, -16, 1, -16)
				end
				if otherTab.Button then
					TweenService:Create(otherTab.Button, fastTween, {BackgroundColor3 = currentTheme.Button}):Play()
				end
			end
			
			TabContent.Visible = true
			TabContent.Size = UDim2.new(1, -16, 0, 0)
			TweenService:Create(TabContent, fastTween, {Size = UDim2.new(1, -16, 1, -16)}):Play()
			TweenService:Create(TabButton, fastTween, {BackgroundColor3 = currentTheme.Accent}):Play()
			window.CurrentTab = tab
		end)
		
		TabButton.MouseEnter:Connect(function()
			if window.CurrentTab ~= tab then
				TweenService:Create(TabButton, fastTween, {BackgroundColor3 = currentTheme.ButtonHover}):Play()
			end
		end)
		
		TabButton.MouseLeave:Connect(function()
			if window.CurrentTab ~= tab then
				TweenService:Create(TabButton, fastTween, {BackgroundColor3 = currentTheme.Button}):Play()
			end
		end)
		
		-- İlk tab'ı aktif et
		if #window.Tabs == 0 then
			TabContent.Visible = true
			TabButton.BackgroundColor3 = currentTheme.Accent
			window.CurrentTab = tab
		end
		
		table.insert(window.Tabs, tab)
		
		-- Toggle oluşturma
		function tab:CreateToggle(config)
			config = config or {}
			local toggleName = config.Name or "Toggle"
			local defaultValue = config.Default or false
			local callback = config.Callback or function() end
			
			local toggleState = defaultValue
			
			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.BorderSizePixel = 0
			ToggleFrame.BackgroundColor3 = currentTheme.Button
			ToggleFrame.Size = UDim2.new(1, 0, 0, 44)
			ToggleFrame.Parent = TabContent
			
			local ToggleCorner = Instance.new("UICorner")
			ToggleCorner.CornerRadius = UDim.new(0, 8)
			ToggleCorner.Parent = ToggleFrame
			
			local ToggleText = Instance.new("TextLabel")
			ToggleText.Name = "ToggleText"
			ToggleText.TextXAlignment = Enum.TextXAlignment.Left
			ToggleText.ZIndex = 2
			ToggleText.BorderSizePixel = 0
			ToggleText.TextSize = 15
			ToggleText.BackgroundTransparency = 1
			ToggleText.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
			ToggleText.Size = UDim2.new(1, -70, 1, 0)
			ToggleText.Position = UDim2.new(0, 12, 0, 0)
			ToggleText.Text = toggleName
			ToggleText.TextColor3 = currentTheme.Text
			ToggleText.Parent = ToggleFrame
			
			local ToggleSwitch = Instance.new("TextButton")
			ToggleSwitch.Name = "ToggleSwitch"
			ToggleSwitch.ZIndex = 3
			ToggleSwitch.BorderSizePixel = 0
			ToggleSwitch.BackgroundColor3 = toggleState and currentTheme.Toggle or currentTheme.ToggleOff
			ToggleSwitch.Size = UDim2.new(0, 50, 0, 24)
			ToggleSwitch.Position = UDim2.new(1, -58, 0.5, -12)
			ToggleSwitch.Text = ""
			ToggleSwitch.AutoButtonColor = false
			ToggleSwitch.Parent = ToggleFrame
			
			local SwitchCorner = Instance.new("UICorner")
			SwitchCorner.CornerRadius = UDim.new(1, 0)
			SwitchCorner.Parent = ToggleSwitch
			
			local ToggleCircle = Instance.new("Frame")
			ToggleCircle.Name = "ToggleCircle"
			ToggleCircle.BorderSizePixel = 0
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleCircle.Size = UDim2.new(0, 20, 0, 20)
			ToggleCircle.Position = toggleState and UDim2.new(0, 28, 0, 2) or UDim2.new(0, 2, 0, 2)
			ToggleCircle.Parent = ToggleSwitch
			
			local CircleCorner = Instance.new("UICorner")
			CircleCorner.CornerRadius = UDim.new(1, 0)
			CircleCorner.Parent = ToggleCircle
			
			local function toggle()
				toggleState = not toggleState
				
				TweenService:Create(ToggleSwitch, tweenInfo, {
					BackgroundColor3 = toggleState and currentTheme.Toggle or currentTheme.ToggleOff
				}):Play()
				
				TweenService:Create(ToggleCircle, tweenInfo, {
					Position = toggleState and UDim2.new(0, 28, 0, 2) or UDim2.new(0, 2, 0, 2)
				}):Play()
				
				callback(toggleState)
			end
			
			ToggleSwitch.MouseButton1Click:Connect(toggle)
			
			ToggleSwitch.MouseEnter:Connect(function()
				TweenService:Create(ToggleCircle, fastTween, {Size = UDim2.new(0, 22, 0, 22)}):Play()
			end)
			
			ToggleSwitch.MouseLeave:Connect(function()
				TweenService:Create(ToggleCircle, fastTween, {Size = UDim2.new(0, 20, 0, 20)}):Play()
			end)
			
			local toggleObj = {}
			function toggleObj:SetValue(value)
				if toggleState ~= value then
					toggle()
				end
			end
			
			return toggleObj
		end
		
		-- Button oluşturma
		function tab:CreateButton(config)
			config = config or {}
			local buttonName = config.Name or "Button"
			local callback = config.Callback or function() end
			
			local ButtonFrame = Instance.new("TextButton")
			ButtonFrame.Name = "ButtonFrame"
			ButtonFrame.BorderSizePixel = 0
			ButtonFrame.BackgroundColor3 = currentTheme.Accent
			ButtonFrame.Size = UDim2.new(1, 0, 0, 44)
			ButtonFrame.AutoButtonColor = false
			ButtonFrame.Text = ""
			ButtonFrame.Parent = TabContent
			
			local ButtonCorner = Instance.new("UICorner")
			ButtonCorner.CornerRadius = UDim.new(0, 8)
			ButtonCorner.Parent = ButtonFrame
			
			local ButtonText = Instance.new("TextLabel")
			ButtonText.Name = "ButtonText"
			ButtonText.ZIndex = 2
			ButtonText.BorderSizePixel = 0
			ButtonText.TextSize = 15
			ButtonText.BackgroundTransparency = 1
			ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			ButtonText.Size = UDim2.new(1, -24, 1, 0)
			ButtonText.Position = UDim2.new(0, 12, 0, 0)
			ButtonText.Text = "▸ " .. buttonName
			ButtonText.Parent = ButtonFrame
			
			ButtonFrame.MouseButton1Click:Connect(function()
				TweenService:Create(ButtonFrame, fastTween, {
					BackgroundColor3 = Color3.new(
						currentTheme.Accent.R * 0.8,
						currentTheme.Accent.G * 0.8,
						currentTheme.Accent.B * 0.8
					)
				}):Play()
				
				task.wait(0.15)
				
				TweenService:Create(ButtonFrame, fastTween, {BackgroundColor3 = currentTheme.Accent}):Play()
				callback()
			end)
			
			ButtonFrame.MouseEnter:Connect(function()
				TweenService:Create(ButtonFrame, fastTween, {
					BackgroundColor3 = Color3.new(
						currentTheme.Accent.R * 1.1,
						currentTheme.Accent.G * 1.1,
						currentTheme.Accent.B * 1.1
					)
				}):Play()
			end)
			
			ButtonFrame.MouseLeave:Connect(function()
				TweenService:Create(ButtonFrame, fastTween, {BackgroundColor3 = currentTheme.Accent}):Play()
			end)
		end
		
		-- Input oluşturma
		function tab:CreateInput(config)
			config = config or {}
			local inputName = config.Name or "Input"
			local placeholder = config.Placeholder or "Enter text..."
			local callback = config.Callback or function() end
			
			local InputFrame = Instance.new("Frame")
			InputFrame.Name = "InputFrame"
			InputFrame.BorderSizePixel = 0
			InputFrame.BackgroundColor3 = currentTheme.Button
			InputFrame.Size = UDim2.new(1, 0, 0, 70)
			InputFrame.Parent = TabContent
			
			local InputCorner = Instance.new("UICorner")
			InputCorner.CornerRadius = UDim.new(0, 8)
			InputCorner.Parent = InputFrame
			
			local InputLabel = Instance.new("TextLabel")
			InputLabel.Name = "InputLabel"
			InputLabel.TextXAlignment = Enum.TextXAlignment.Left
			InputLabel.ZIndex = 2
			InputLabel.BorderSizePixel = 0
			InputLabel.TextSize = 14
			InputLabel.BackgroundTransparency = 1
			InputLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
			InputLabel.Size = UDim2.new(1, -24, 0, 20)
			InputLabel.Position = UDim2.new(0, 12, 0, 8)
			InputLabel.Text = inputName
			InputLabel.TextColor3 = currentTheme.Text
			InputLabel.Parent = InputFrame
			
			local InputBox = Instance.new("TextBox")
			InputBox.Name = "InputBox"
			InputBox.ZIndex = 2
			InputBox.BorderSizePixel = 0
			InputBox.TextSize = 14
			InputBox.BackgroundColor3 = currentTheme.Secondary
			InputBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			InputBox.Size = UDim2.new(1, -24, 0, 32)
			InputBox.Position = UDim2.new(0, 12, 0, 30)
			InputBox.PlaceholderText = placeholder
			InputBox.PlaceholderColor3 = currentTheme.TextSecondary
			InputBox.Text = ""
			InputBox.TextColor3 = currentTheme.Text
			InputBox.TextXAlignment = Enum.TextXAlignment.Left
			InputBox.ClearTextOnFocus = false
			InputBox.Parent = InputFrame
			
			local InputBoxCorner = Instance.new("UICorner")
			InputBoxCorner.CornerRadius = UDim.new(0, 6)
			InputBoxCorner.Parent = InputBox
			
			local InputStroke = Instance.new("UIStroke")
			InputStroke.Color = currentTheme.Accent
			InputStroke.Thickness = 0
			InputStroke.Transparency = 0.5
			InputStroke.Parent = InputBox
			
			local InputPadding = Instance.new("UIPadding")
			InputPadding.PaddingLeft = UDim.new(0, 10)
			InputPadding.PaddingRight = UDim.new(0, 10)
			InputPadding.Parent = InputBox
			
			InputBox.FocusLost:Connect(function(enterPressed)
				TweenService:Create(InputStroke, fastTween, {Thickness = 0}):Play()
				if enterPressed then
					callback(InputBox.Text)
				end
			end)
			
			InputBox.Focused:Connect(function()
				TweenService:Create(InputStroke, fastTween, {Thickness = 2}):Play()
			end)
		end
		
		-- Dropdown oluşturma
		function tab:CreateDropdown(config)
			config = config or {}
			local dropdownName = config.Name or "Dropdown"
			local options = config.Options or {"Option 1", "Option 2", "Option 3"}
			local callback = config.Callback or function() end
			
			local isOpen = false
			local selectedOption = options[1] or "Select"
			
			local DropdownFrame = Instance.new("Frame")
			DropdownFrame.Name = "DropdownFrame"
			DropdownFrame.BorderSizePixel = 0
			DropdownFrame.BackgroundColor3 = currentTheme.Button
			DropdownFrame.Size = UDim2.new(1, 0, 0, 44)
			DropdownFrame.ClipsDescendants = true
			DropdownFrame.Parent = TabContent
			
			local DropdownCorner = Instance.new("UICorner")
			DropdownCorner.CornerRadius = UDim.new(0, 8)
			DropdownCorner.Parent = DropdownFrame
			
			local DropdownButton = Instance.new("TextButton")
			DropdownButton.Name = "DropdownButton"
			DropdownButton.ZIndex = 2
			DropdownButton.BorderSizePixel = 0
			DropdownButton.BackgroundTransparency = 1
			DropdownButton.Size = UDim2.new(1, 0, 0, 44)
			DropdownButton.Text = ""
			DropdownButton.AutoButtonColor = false
			DropdownButton.Parent = DropdownFrame
			
			local DropdownLabel = Instance.new("TextLabel")
			DropdownLabel.Name = "DropdownLabel"
			DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
			DropdownLabel.ZIndex = 3
			DropdownLabel.BorderSizePixel = 0
			DropdownLabel.TextSize = 15
			DropdownLabel.BackgroundTransparency = 1
			DropdownLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
			DropdownLabel.Size = UDim2.new(1, -50, 1, 0)
			DropdownLabel.Position = UDim2.new(0, 12, 0, 0)
			DropdownLabel.Text = dropdownName .. ": " .. selectedOption
			DropdownLabel.TextColor3 = currentTheme.Text
			DropdownLabel.Parent = DropdownButton
			
			local DropdownArrow = Instance.new("TextLabel")
			DropdownArrow.Name = "DropdownArrow"
			DropdownArrow.ZIndex = 3
			DropdownArrow.BorderSizePixel = 0
			DropdownArrow.BackgroundTransparency = 1
			DropdownArrow.Size = UDim2.new(0, 30, 1, 0)
			DropdownArrow.Position = UDim2.new(1, -40, 0, 0)
			DropdownArrow.Text = "▼"
			DropdownArrow.TextColor3 = currentTheme.Accent
			DropdownArrow.TextSize = 14
			DropdownArrow.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			DropdownArrow.Parent = DropdownButton
			
			local OptionsList = Instance.new("Frame")
			OptionsList.Name = "OptionsList"
			OptionsList.ZIndex = 2
			OptionsList.BorderSizePixel = 0
			OptionsList.BackgroundTransparency = 1
			OptionsList.Size = UDim2.new(1, -16, 0, 0)
			OptionsList.Position = UDim2.new(0, 8, 0, 50)
			OptionsList.Parent = DropdownFrame
			
			local OptionsLayout = Instance.new("UIListLayout")
			OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
			OptionsLayout.Padding = UDim.new(0, 4)
			OptionsLayout.Parent = OptionsList
			
			local function toggleDropdown()
				isOpen = not isOpen
				local targetSize = isOpen and UDim2.new(1, 0, 0, 44 + (#options * 38) + 12) or UDim2.new(1, 0, 0, 44)
				local targetRotation = isOpen and 180 or 0
				
				TweenService:Create(DropdownFrame, tweenInfo, {Size = targetSize}):Play()
				TweenService:Create(DropdownArrow, tweenInfo, {Rotation = targetRotation}):Play()
			end
			
			DropdownButton.MouseButton1Click:Connect(toggleDropdown)
			
			for i, option in ipairs(options) do
				local OptionButton = Instance.new("TextButton")
				OptionButton.Name = "Option_" .. i
				OptionButton.ZIndex = 3
				OptionButton.BorderSizePixel = 0
				OptionButton.BackgroundColor3 = currentTheme.Secondary
				OptionButton.Size = UDim2.new(1, 0, 0, 34)
				OptionButton.Text = option
				OptionButton.TextColor3 = currentTheme.Text
				OptionButton.TextSize = 14
				OptionButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				OptionButton.AutoButtonColor = false
				OptionButton.Parent = OptionsList
				
				local OptionCorner = Instance.new("UICorner")
				OptionCorner.CornerRadius = UDim.new(0, 6)
				OptionCorner.Parent = OptionButton
				
				OptionButton.MouseButton1Click:Connect(function()
					selectedOption = option
					DropdownLabel.Text = dropdownName .. ": " .. selectedOption
					toggleDropdown()
					callback(option)
				end)
				
				OptionButton.MouseEnter:Connect(function()
					TweenService:Create(OptionButton, fastTween, {BackgroundColor3 = currentTheme.Accent}):Play()
					TweenService:Create(OptionButton, fastTween, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				end)
				
				OptionButton.MouseLeave:Connect(function()
					TweenService:Create(OptionButton, fastTween, {BackgroundColor3 = currentTheme.Secondary}):Play()
					TweenService:Create(OptionButton, fastTween, {TextColor3 = currentTheme.Text}):Play()
				end)
			end
		end
		
		-- Slider oluşturma
		function tab:CreateSlider(config)
			config = config or {}
			local sliderName = config.Name or "Slider"
			local minValue = config.Min or 0
			local maxValue = config.Max or 100
			local defaultValue = config.Default or 50
			local callback = config.Callback or function() end
			
			local currentValue = defaultValue
			
			local SliderFrame = Instance.new("Frame")
			SliderFrame.Name = "SliderFrame"
			SliderFrame.BorderSizePixel = 0
			SliderFrame.BackgroundColor3 = currentTheme.Button
			SliderFrame.Size = UDim2.new(1, 0, 0, 60)
			SliderFrame.Parent = TabContent
			
			local SliderCorner = Instance.new("UICorner")
			SliderCorner.CornerRadius = UDim.new(0, 8)
			SliderCorner.Parent = SliderFrame
			
			local SliderLabel = Instance.new("TextLabel")
			SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			SliderLabel.BorderSizePixel = 0
			SliderLabel.TextSize = 14
			SliderLabel.BackgroundTransparency = 1
			SliderLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
			SliderLabel.Size = UDim2.new(1, -80, 0, 20)
			SliderLabel.Position = UDim2.new(0, 12, 0, 8)
			SliderLabel.Text = sliderName
			SliderLabel.TextColor3 = currentTheme.Text
			SliderLabel.Parent = SliderFrame
			
			local ValueLabel = Instance.new("TextLabel")
			ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
			ValueLabel.BorderSizePixel = 0
			ValueLabel.TextSize = 14
			ValueLabel.BackgroundTransparency = 1
			ValueLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			ValueLabel.Size = UDim2.new(0, 60, 0, 20)
			ValueLabel.Position = UDim2.new(1, -72, 0, 8)
			ValueLabel.Text = tostring(currentValue)
			ValueLabel.TextColor3 = currentTheme.Accent
			ValueLabel.Parent = SliderFrame
			
			local SliderBack = Instance.new("Frame")
			SliderBack.BorderSizePixel = 0
			SliderBack.BackgroundColor3 = currentTheme.Secondary
			SliderBack.Size = UDim2.new(1, -24, 0, 8)
			SliderBack.Position = UDim2.new(0, 12, 0, 40)
			SliderBack.Parent = SliderFrame
			
			local SliderBackCorner = Instance.new("UICorner")
			SliderBackCorner.CornerRadius = UDim.new(1, 0)
			SliderBackCorner.Parent = SliderBack
			
			local SliderFill = Instance.new("Frame")
			SliderFill.BorderSizePixel = 0
			SliderFill.BackgroundColor3 = currentTheme.Accent
			SliderFill.Size = UDim2.new((currentValue - minValue) / (maxValue - minValue), 0, 1, 0)
			SliderFill.Parent = SliderBack
			
			local SliderFillCorner = Instance.new("UICorner")
			SliderFillCorner.CornerRadius = UDim.new(1, 0)
			SliderFillCorner.Parent = SliderFill
			
			local SliderButton = Instance.new("TextButton")
			SliderButton.BorderSizePixel = 0
			SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderButton.Size = UDim2.new(0, 16, 0, 16)
			SliderButton.Position = UDim2.new((currentValue - minValue) / (maxValue - minValue), -8, 0.5, -8)
			SliderButton.Text = ""
			SliderButton.AutoButtonColor = false
			SliderButton.Parent = SliderBack
			
			local SliderButtonCorner = Instance.new("UICorner")
			SliderButtonCorner.CornerRadius = UDim.new(1, 0)
			SliderButtonCorner.Parent = SliderButton
			
			local dragging = false
			
			local function updateSlider(input)
				local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
				currentValue = math.floor(minValue + (maxValue - minValue) * pos)
				
				ValueLabel.Text = tostring(currentValue)
				TweenService:Create(SliderFill, fastTween, {Size = UDim2.new(pos, 0, 1, 0)}):Play()
				TweenService:Create(SliderButton, fastTween, {Position = UDim2.new(pos, -8, 0.5, -8)}):Play()
				
				callback(currentValue)
			end
			
			SliderButton.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					TweenService:Create(SliderButton, fastTween, {Size = UDim2.new(0, 20, 0, 20)}):Play()
				end
			end)
			
			SliderButton.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
					TweenService:Create(SliderButton, fastTween, {Size = UDim2.new(0, 16, 0, 16)}):Play()
				end
			end)
			
			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateSlider(input)
				end
			end)
			
			SliderBack.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					updateSlider(input)
				end
			end)
		end
		
		return tab
	end
	
	return window
end

return Library
