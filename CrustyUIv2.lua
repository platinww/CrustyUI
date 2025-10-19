--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  LIBRARY V2

Crusty Library V2 - Modern UI Library
]=]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local Library = {}
Library.__index = Library

-- Tween ayarları
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local fastTween = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local notifyTween = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- Ses çalma fonksiyonu
local function PlaySound(soundId, volume)
	if not soundId then return end
	local sound = Instance.new("Sound")
	sound.SoundId = soundId
	sound.Volume = volume or 0.5
	sound.Parent = SoundService
	sound:Play()
	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

function Library:CreateWindow(config)
	config = config or {}
	local windowTitle = config.Title or "Crusty HUB V1"
	local iconId = config.Icon or "rbxassetid://7734053495"
	local draggable = config.Draggable ~= false
	local effectSounds = config.EffectSounds == true
	local loadSound = "rbxassetid://137759965542959"
	local notifySound = "rbxassetid://137759965542959"
	
	local window = {}
	window.CurrentTab = nil
	window.Tabs = {}
	window.ToggleButton = nil
	window.MainFrame = nil
	window.EffectSounds = effectSounds
	
	-- ScreenGui oluştur
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "CrustyLibrary"
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	
	-- Yükleme sesi çal
	if effectSounds then
		PlaySound(loadSound, 0.5)
	end
	
	-- Notification Container
	local NotificationContainer = Instance.new("Frame")
	NotificationContainer.Name = "NotificationContainer"
	NotificationContainer.BackgroundTransparency = 1
	NotificationContainer.Size = UDim2.new(0, 300, 1, 0)
	NotificationContainer.Position = UDim2.new(1, -320, 0, 20)
	NotificationContainer.Parent = ScreenGui
	
	local NotifyLayout = Instance.new("UIListLayout")
	NotifyLayout.SortOrder = Enum.SortOrder.LayoutOrder
	NotifyLayout.Padding = UDim.new(0, 10)
	NotifyLayout.Parent = NotificationContainer
	
	-- Notification fonksiyonu
	function window:Notify(notifConfig)
		notifConfig = notifConfig or {}
		local title = notifConfig.Title or "Notification"
		local message = notifConfig.Message or "No message provided"
		local duration = notifConfig.Duration or 3
		local notifType = notifConfig.Type or "Info"
		
		-- Bildirim sesi çal
		if window.EffectSounds then
			PlaySound(notifySound, 0.4)
		end
		
		local notifColor = Color3.fromRGB(0, 139, 255)
		local notifIcon = "ℹ️"
		
		if notifType == "Success" then
			notifColor = Color3.fromRGB(67, 181, 129)
			notifIcon = "✅"
		elseif notifType == "Warning" then
			notifColor = Color3.fromRGB(250, 166, 26)
			notifIcon = "⚠️"
		elseif notifType == "Error" then
			notifColor = Color3.fromRGB(237, 66, 69)
			notifIcon = "❌"
		end
		
		local NotifFrame = Instance.new("Frame")
		NotifFrame.Name = "Notification"
		NotifFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifFrame.BorderSizePixel = 0
		NotifFrame.Size = UDim2.new(1, 0, 0, 0)
		NotifFrame.BackgroundTransparency = 0.1
		NotifFrame.ClipsDescendants = false
		NotifFrame.Position = UDim2.new(1, 20, 0, 0)
		NotifFrame.Parent = NotificationContainer
		
		local NotifCorner = Instance.new("UICorner")
		NotifCorner.CornerRadius = UDim.new(0, 10)
		NotifCorner.Parent = NotifFrame
		
		local NotifStroke = Instance.new("UIStroke")
		NotifStroke.Color = Color3.fromRGB(200, 200, 200)
		NotifStroke.Thickness = 1
		NotifStroke.Parent = NotifFrame
		
		local NotifBorder = Instance.new("Frame")
		NotifBorder.Name = "Border"
		NotifBorder.BackgroundColor3 = notifColor
		NotifBorder.BorderSizePixel = 0
		NotifBorder.Size = UDim2.new(0, 4, 1, 0)
		NotifBorder.Parent = NotifFrame
		
		local BorderCorner = Instance.new("UICorner")
		BorderCorner.CornerRadius = UDim.new(0, 10)
		BorderCorner.Parent = NotifBorder
		
		local NotifIcon = Instance.new("TextLabel")
		NotifIcon.Name = "Icon"
		NotifIcon.BackgroundTransparency = 1
		NotifIcon.Size = UDim2.new(0, 30, 0, 30)
		NotifIcon.Position = UDim2.new(0, 8, 0, 8)
		NotifIcon.Font = Enum.Font.GothamBold
		NotifIcon.Text = notifIcon
		NotifIcon.TextColor3 = notifColor
		NotifIcon.TextSize = 18
		NotifIcon.Parent = NotifFrame
		
		local NotifTitle = Instance.new("TextLabel")
		NotifTitle.Name = "Title"
		NotifTitle.BackgroundTransparency = 1
		NotifTitle.Size = UDim2.new(1, -45, 0, 18)
		NotifTitle.Position = UDim2.new(0, 42, 0, 8)
		NotifTitle.Font = Enum.Font.GothamBold
		NotifTitle.Text = title
		NotifTitle.TextColor3 = Color3.fromRGB(0, 0, 0)
		NotifTitle.TextSize = 13
		NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
		NotifTitle.Parent = NotifFrame
		
		local NotifMessage = Instance.new("TextLabel")
		NotifMessage.Name = "Message"
		NotifMessage.BackgroundTransparency = 1
		NotifMessage.Size = UDim2.new(1, -45, 0, 32)
		NotifMessage.Position = UDim2.new(0, 42, 0, 26)
		NotifMessage.Font = Enum.Font.Gotham
		NotifMessage.Text = message
		NotifMessage.TextColor3 = Color3.fromRGB(100, 100, 100)
		NotifMessage.TextSize = 11
		NotifMessage.TextXAlignment = Enum.TextXAlignment.Left
		NotifMessage.TextYAlignment = Enum.TextYAlignment.Top
		NotifMessage.TextWrapped = true
		NotifMessage.Parent = NotifFrame
		
		-- Giriş animasyonu
		TweenService:Create(NotifFrame, notifyTween, {
			Size = UDim2.new(1, 0, 0, 65),
			Position = UDim2.new(0, 0, 0, 0)
		}):Play()
		
		-- Çıkış animasyonu
		task.delay(duration, function()
			local exitTween = TweenService:Create(NotifFrame, tweenInfo, {
				Position = UDim2.new(1, 20, 0, 0),
				BackgroundTransparency = 1
			})
			
			TweenService:Create(NotifTitle, tweenInfo, {TextTransparency = 1}):Play()
			TweenService:Create(NotifMessage, tweenInfo, {TextTransparency = 1}):Play()
			TweenService:Create(NotifBorder, tweenInfo, {BackgroundTransparency = 1}):Play()
			TweenService:Create(NotifIcon, tweenInfo, {TextTransparency = 1}):Play()
			TweenService:Create(NotifStroke, tweenInfo, {Transparency = 1}):Play()
			
			exitTween:Play()
			
			task.wait(0.3)
			NotifFrame:Destroy()
		end)
	end
	
	-- Toggle Button (Daire - Sürüklenebilir)
	local ToggleButton = Instance.new("ImageButton")
	ToggleButton.Name = "ToggleButton"
	ToggleButton.Image = iconId
	ToggleButton.Size = UDim2.new(0, 60, 0, 60)
	ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
	ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 139, 255)
	ToggleButton.BorderSizePixel = 0
	ToggleButton.ScaleType = Enum.ScaleType.Fit
	ToggleButton.ImageTransparency = 0.2
	ToggleButton.Parent = ScreenGui
	
	local ToggleCorner = Instance.new("UICorner")
	ToggleCorner.CornerRadius = UDim.new(1, 0)
	ToggleCorner.Parent = ToggleButton
	
	local ToggleStroke = Instance.new("UIStroke")
	ToggleStroke.Color = Color3.fromRGB(200, 200, 200)
	ToggleStroke.Thickness = 3
	ToggleStroke.Parent = ToggleButton
	
	window.ToggleButton = ToggleButton
	
	-- Toggle Button sürükleme
	local toggleDragging = false
	local toggleDragStart = nil
	local toggleStartPos = nil
	
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
	
	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and toggleDragging then
			local delta = input.Position - toggleDragStart
			ToggleButton.Position = UDim2.new(
				toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X,
				toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y
			)
		end
	end)
	
	-- Hover efekti
	ToggleButton.MouseEnter:Connect(function()
		TweenService:Create(ToggleButton, fastTween, {
			Size = UDim2.new(0, 67, 0, 67),
			ImageTransparency = 0
		}):Play()
		TweenService:Create(ToggleStroke, fastTween, {Thickness = 4}):Play()
	end)
	
	ToggleButton.MouseLeave:Connect(function()
		TweenService:Create(ToggleButton, fastTween, {
			Size = UDim2.new(0, 60, 0, 60),
			ImageTransparency = 0.2
		}):Play()
		TweenService:Create(ToggleStroke, fastTween, {Thickness = 3}):Play()
	end)
	
	-- Ana Frame (Arka plan)
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.BorderSizePixel = 0
	MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainFrame.Size = UDim2.new(0, 252, 0, 294)
	MainFrame.Position = UDim2.new(0.5, -126, 0.5, -147)
	MainFrame.BackgroundTransparency = 0.5
	MainFrame.ClipsDescendants = true
	MainFrame.Visible = false
	MainFrame.Parent = ScreenGui
	
	window.MainFrame = MainFrame
	
	local MainCorner = Instance.new("UICorner")
	MainCorner.Parent = MainFrame
	
	-- Toggle Button tıklama
	ToggleButton.MouseButton1Click:Connect(function()
		if MainFrame.Visible then
			TweenService:Create(MainFrame, tweenInfo, {
				Size = UDim2.new(0, 0, 0, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0)
			}):Play()
			
			task.wait(0.3)
			MainFrame.Visible = false
			MainFrame.Size = UDim2.new(0, 252, 0, 294)
			MainFrame.Position = UDim2.new(0.5, -126, 0.5, -147)
		else
			MainFrame.Visible = true
			MainFrame.Size = UDim2.new(0, 0, 0, 0)
			MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			
			TweenService:Create(MainFrame, tweenInfo, {
				Size = UDim2.new(0, 252, 0, 294),
				Position = UDim2.new(0.5, -126, 0.5, -147)
			}):Play()
		end
	end)
	
	-- Başlık Frame
	local TitleFrame = Instance.new("Frame")
	TitleFrame.Name = "TitleFrame"
	TitleFrame.BorderSizePixel = 0
	TitleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleFrame.Size = UDim2.new(0, 236, 0, 36)
	TitleFrame.Position = UDim2.new(0, 8, 0, 8)
	TitleFrame.BackgroundTransparency = 0.1
	TitleFrame.Parent = MainFrame
	
	local TitleCorner = Instance.new("UICorner")
	TitleCorner.Parent = TitleFrame
	
	-- Başlık Text (Emoji olmadan)
	local TitleText = Instance.new("TextLabel")
	TitleText.Name = "TitleText"
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.ZIndex = 2
	TitleText.BorderSizePixel = 0
	TitleText.TextSize = 17
	TitleText.BackgroundTransparency = 1
	TitleText.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TitleText.Size = UDim2.new(1, -40, 1, 0)
	TitleText.Position = UDim2.new(0, 8, 0, 0)
	TitleText.Text = windowTitle
	TitleText.TextColor3 = Color3.fromRGB(0, 0, 0)
	TitleText.Parent = TitleFrame
	
	-- Close Button (X)
	local CloseButton = Instance.new("TextButton")
	CloseButton.Name = "CloseButton"
	CloseButton.ZIndex = 3
	CloseButton.BorderSizePixel = 0
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
	CloseButton.Size = UDim2.new(0, 28, 0, 28)
	CloseButton.Position = UDim2.new(1, -32, 0, 4)
	CloseButton.Text = "✕"
	CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.TextSize = 16
	CloseButton.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	CloseButton.AutoButtonColor = false
	CloseButton.Parent = TitleFrame
	
	local CloseCorner = Instance.new("UICorner")
	CloseCorner.CornerRadius = UDim.new(0, 6)
	CloseCorner.Parent = CloseButton
	
	CloseButton.MouseButton1Click:Connect(function()
		TweenService:Create(MainFrame, tweenInfo, {
			Size = UDim2.new(0, 0, 0, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0)
		}):Play()
		
		task.wait(0.3)
		MainFrame.Visible = false
		MainFrame.Size = UDim2.new(0, 252, 0, 294)
		MainFrame.Position = UDim2.new(0.5, -126, 0.5, -147)
	end)
	
	CloseButton.MouseEnter:Connect(function()
		TweenService:Create(CloseButton, fastTween, {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
	end)
	
	CloseButton.MouseLeave:Connect(function()
		TweenService:Create(CloseButton, fastTween, {BackgroundColor3 = Color3.fromRGB(255, 75, 75)}):Play()
	end)
	
	-- Tab Container (Scrolling)
	local TabContainer = Instance.new("ScrollingFrame")
	TabContainer.Name = "TabContainer"
	TabContainer.BorderSizePixel = 0
	TabContainer.BackgroundTransparency = 1
	TabContainer.Size = UDim2.new(1, -16, 0, 26)
	TabContainer.Position = UDim2.new(0, 8, 0, 50)
	TabContainer.ScrollBarThickness = 0
	TabContainer.CanvasSize = UDim2.new(0, 0, 0, 26)
	TabContainer.ScrollingDirection = Enum.ScrollingDirection.X
	TabContainer.Parent = MainFrame
	
	local TabLayout = Instance.new("UIListLayout")
	TabLayout.FillDirection = Enum.FillDirection.Horizontal
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 8)
	TabLayout.Parent = TabContainer
	
	-- Auto resize tab canvas
	TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabContainer.CanvasSize = UDim2.new(0, TabLayout.AbsoluteContentSize.X, 0, 26)
	end)
	
	-- Content Container
	local ContentContainer = Instance.new("Frame")
	ContentContainer.Name = "ContentContainer"
	ContentContainer.BorderSizePixel = 0
	ContentContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ContentContainer.Size = UDim2.new(0, 238, 0, 200)
	ContentContainer.Position = UDim2.new(0, 6, 0, 82)
	ContentContainer.BackgroundTransparency = 0.1
	ContentContainer.Parent = MainFrame
	
	local ContentCorner = Instance.new("UICorner")
	ContentCorner.Parent = ContentContainer
	
	-- Dragging System (Sadece Draggable true ise)
	if draggable then
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
	
	-- Tab oluşturma fonksiyonu
	function window:CreateTab(tabName)
		local tab = {}
		tab.Elements = {}
		tab.Container = nil
		tab.Button = nil
		
		-- Tab Button
		local TabButton = Instance.new("TextButton")
		TabButton.Name = tabName
		TabButton.ZIndex = 2
		TabButton.BorderSizePixel = 0
		TabButton.TextSize = 14
		TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		TabButton.Size = UDim2.new(0, 74, 0, 26)
		TabButton.Text = tabName
		TabButton.BackgroundTransparency = 0.1
		TabButton.AutoButtonColor = false
		TabButton.Parent = TabContainer
		
		local TabCorner = Instance.new("UICorner")
		TabCorner.Parent = TabButton
		
		tab.Button = TabButton
		
		-- Tab Content Frame
		local TabContent = Instance.new("ScrollingFrame")
		TabContent.Name = tabName .. "Content"
		TabContent.BorderSizePixel = 0
		TabContent.BackgroundTransparency = 1
		TabContent.Size = UDim2.new(1, -8, 1, -8)
		TabContent.Position = UDim2.new(0, 4, 0, 4)
		TabContent.ScrollBarThickness = 4
		TabContent.Visible = false
		TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
		TabContent.Parent = ContentContainer
		
		local ContentLayout = Instance.new("UIListLayout")
		ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ContentLayout.Padding = UDim.new(0, 6)
		ContentLayout.Parent = TabContent
		
		ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
		end)
		
		tab.Container = TabContent
		
		-- Tab değiştirme
		TabButton.MouseButton1Click:Connect(function()
			for _, otherTab in pairs(window.Tabs) do
				if otherTab.Container then
					TweenService:Create(otherTab.Container, fastTween, {Size = UDim2.new(1, -8, 0, 0)}):Play()
					task.wait(0.15)
					otherTab.Container.Visible = false
					otherTab.Container.Size = UDim2.new(1, -8, 1, -8)
				end
				if otherTab.Button then
					TweenService:Create(otherTab.Button, fastTween, {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				end
			end
			
			TabContent.Visible = true
			TabContent.Size = UDim2.new(1, -8, 0, 0)
			TweenService:Create(TabContent, fastTween, {Size = UDim2.new(1, -8, 1, -8)}):Play()
			TweenService:Create(TabButton, fastTween, {BackgroundColor3 = Color3.fromRGB(220, 220, 220)}):Play()
			window.CurrentTab = tab
		end)
		
		TabButton.MouseEnter:Connect(function()
			if window.CurrentTab ~= tab then
				TweenService:Create(TabButton, fastTween, {BackgroundTransparency = 0.05}):Play()
			end
		end)
		
		TabButton.MouseLeave:Connect(function()
			if window.CurrentTab ~= tab then
				TweenService:Create(TabButton, fastTween, {BackgroundTransparency = 0.1}):Play()
			end
		end)
		
		-- İlk tab'ı aktif et
		if #window.Tabs == 0 then
			TabContent.Visible = true
			TabButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
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
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleFrame.Size = UDim2.new(1, 0, 0, 36)
			ToggleFrame.BackgroundTransparency = 0.1
			ToggleFrame.Parent = TabContent
			
			local ToggleCorner = Instance.new("UICorner")
			ToggleCorner.Parent = ToggleFrame
			
			local ToggleText = Instance.new("TextLabel")
			ToggleText.Name = "ToggleText"
			ToggleText.TextXAlignment = Enum.TextXAlignment.Left
			ToggleText.ZIndex = 2
			ToggleText.BorderSizePixel = 0
			ToggleText.TextSize = 15
			ToggleText.BackgroundTransparency = 1
			ToggleText.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			ToggleText.Size = UDim2.new(1, -54, 1, 0)
			ToggleText.Position = UDim2.new(0, 6, 0, 0)
			ToggleText.Text = toggleName
			ToggleText.TextColor3 = Color3.fromRGB(0, 0, 0)
			ToggleText.Parent = ToggleFrame
			
			local ToggleSwitch = Instance.new("TextButton")
			ToggleSwitch.Name = "ToggleSwitch"
			ToggleSwitch.ZIndex = 3
			ToggleSwitch.BorderSizePixel = 0
			ToggleSwitch.BackgroundColor3 = toggleState and Color3.fromRGB(0, 139, 255) or Color3.fromRGB(200, 200, 200)
			ToggleSwitch.Size = UDim2.new(0, 44, 0, 20)
			ToggleSwitch.Position = UDim2.new(1, -48, 0.5, -10)
			ToggleSwitch.Text = ""
			ToggleSwitch.AutoButtonColor = false
			ToggleSwitch.Parent = ToggleFrame
			
			local SwitchCorner = Instance.new("UICorner")
			SwitchCorner.CornerRadius = UDim.new(0, 30)
			SwitchCorner.Parent = ToggleSwitch
			
			local ToggleCircle = Instance.new("Frame")
			ToggleCircle.Name = "ToggleCircle"
			ToggleCircle.BorderSizePixel = 0
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleCircle.Size = UDim2.new(0, 18, 0, 16)
			ToggleCircle.Position = toggleState and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)
			ToggleCircle.Parent = ToggleSwitch
			
			local CircleCorner = Instance.new("UICorner")
			CircleCorner.CornerRadius = UDim.new(0, 50)
			CircleCorner.Parent = ToggleCircle
			
			local function toggle()
				toggleState = not toggleState
				
				TweenService:Create(ToggleSwitch, tweenInfo, {
					BackgroundColor3 = toggleState and Color3.fromRGB(0, 139, 255) or Color3.fromRGB(200, 200, 200)
				}):Play()
				
				TweenService:Create(ToggleCircle, tweenInfo, {
					Position = toggleState and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)
				}):Play()
				
				callback(toggleState)
			end
			
			ToggleSwitch.MouseButton1Click:Connect(toggle)
			
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
			ButtonFrame.BorderSizePixel = 2
			ButtonFrame.BorderColor3 = Color3.fromRGB(0, 139, 255)
			ButtonFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
			ButtonFrame.Size = UDim2.new(1, 0, 0, 36)
			ButtonFrame.AutoButtonColor = false
			ButtonFrame.Text = ""
			ButtonFrame.Parent = TabContent
			
			local ButtonCorner = Instance.new("UICorner")
			ButtonCorner.Parent = ButtonFrame
			
			local ButtonText = Instance.new("TextLabel")
			ButtonText.Name = "ButtonText"
			ButtonText.ZIndex = 2
			ButtonText.BorderSizePixel = 0
			ButtonText.TextSize = 15
			ButtonText.BackgroundTransparency = 1
			ButtonText.TextColor3 = Color3.fromRGB(0, 0, 0)
			ButtonText.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			ButtonText.Size = UDim2.new(1, -12, 1, 0)
			ButtonText.Position = UDim2.new(0, 6, 0, 0)
			ButtonText.Text = "▸ " .. buttonName
			ButtonText.Parent = ButtonFrame
			
			ButtonFrame.MouseButton1Click:Connect(function()
				TweenService:Create(ButtonFrame, fastTween, {BackgroundColor3 = Color3.fromRGB(0, 139, 255)}):Play()
				TweenService:Create(ButtonText, fastTween, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				
				task.wait(0.15)
				
				TweenService:Create(ButtonFrame, fastTween, {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}):Play()
				TweenService:Create(ButtonText, fastTween, {TextColor3 = Color3.fromRGB(0, 0, 0)}):Play()
				
				callback()
			end)
			
			ButtonFrame.MouseEnter:Connect(function()
				TweenService:Create(ButtonFrame, fastTween, {BackgroundColor3 = Color3.fromRGB(230, 230, 230)}):Play()
			end)
			
			ButtonFrame.MouseLeave:Connect(function()
				TweenService:Create(ButtonFrame, fastTween, {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}):Play()
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
			InputFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			InputFrame.Size = UDim2.new(1, 0, 0, 60)
			InputFrame.BackgroundTransparency = 0.1
			InputFrame.Parent = TabContent
			
			local InputCorner = Instance.new("UICorner")
			InputCorner.Parent = InputFrame
			
			local InputLabel = Instance.new("TextLabel")
			InputLabel.Name = "InputLabel"
			InputLabel.TextXAlignment = Enum.TextXAlignment.Left
			InputLabel.ZIndex = 2
			InputLabel.BorderSizePixel = 0
			InputLabel.TextSize = 14
			InputLabel.BackgroundTransparency = 1
			InputLabel.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			InputLabel.Size = UDim2.new(1, -12, 0, 20)
			InputLabel.Position = UDim2.new(0, 6, 0, 4)
			InputLabel.Text = inputName
			InputLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
			InputLabel.Parent = InputFrame
			
			local InputBox = Instance.new("TextBox")
			InputBox.Name = "InputBox"
			InputBox.ZIndex = 2
			InputBox.BorderSizePixel = 2
			InputBox.BorderColor3 = Color3.fromRGB(0, 139, 255)
			InputBox.TextSize = 14
			InputBox.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
			InputBox.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			InputBox.Size = UDim2.new(1, -12, 0, 28)
			InputBox.Position = UDim2.new(0, 6, 0, 26)
			InputBox.PlaceholderText = placeholder
			InputBox.Text = ""
			InputBox.TextColor3 = Color3.fromRGB(0, 0, 0)
			InputBox.ClearTextOnFocus = false
			InputBox.Parent = InputFrame
			
			local InputBoxCorner = Instance.new("UICorner")
			InputBoxCorner.CornerRadius = UDim.new(0, 6)
			InputBoxCorner.Parent = InputBox
			
			InputBox.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					callback(InputBox.Text)
				end
			end)
			
			InputBox.Focused:Connect(function()
				TweenService:Create(InputBox, fastTween, {BorderColor3 = Color3.fromRGB(0, 180, 255)}):Play()
			end)
			
			InputBox.FocusLost:Connect(function()
				TweenService:Create(InputBox, fastTween, {BorderColor3 = Color3.fromRGB(0, 139, 255)}):Play()
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
			DropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownFrame.Size = UDim2.new(1, 0, 0, 36)
			DropdownFrame.BackgroundTransparency = 0.1
			DropdownFrame.ClipsDescendants = true
			DropdownFrame.Parent = TabContent
			
			local DropdownCorner = Instance.new("UICorner")
			DropdownCorner.Parent = DropdownFrame
			
			local DropdownButton = Instance.new("TextButton")
			DropdownButton.Name = "DropdownButton"
			DropdownButton.ZIndex = 2
			DropdownButton.BorderSizePixel = 0
			DropdownButton.BackgroundTransparency = 1
			DropdownButton.Size = UDim2.new(1, 0, 0, 36)
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
			DropdownLabel.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			DropdownLabel.Size = UDim2.new(1, -40, 1, 0)
			DropdownLabel.Position = UDim2.new(0, 6, 0, 0)
			DropdownLabel.Text = dropdownName .. ": " .. selectedOption
			DropdownLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
			DropdownLabel.Parent = DropdownButton
			
			local DropdownArrow = Instance.new("TextLabel")
			DropdownArrow.Name = "DropdownArrow"
			DropdownArrow.ZIndex = 3
			DropdownArrow.BorderSizePixel = 0
			DropdownArrow.BackgroundTransparency = 1
			DropdownArrow.Size = UDim2.new(0, 30, 1, 0)
			DropdownArrow.Position = UDim2.new(1, -30, 0, 0)
			DropdownArrow.Text = "▼"
			DropdownArrow.TextColor3 = Color3.fromRGB(0, 0, 0)
			DropdownArrow.TextSize = 14
			DropdownArrow.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			DropdownArrow.Parent = DropdownButton
			
			local OptionsList = Instance.new("Frame")
			OptionsList.Name = "OptionsList"
			OptionsList.ZIndex = 2
			OptionsList.BorderSizePixel = 0
			OptionsList.BackgroundTransparency = 1
			OptionsList.Size = UDim2.new(1, -8, 0, 0)
			OptionsList.Position = UDim2.new(0, 4, 0, 40)
			OptionsList.Parent = DropdownFrame
			
			local OptionsLayout = Instance.new("UIListLayout")
			OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
			OptionsLayout.Padding = UDim.new(0, 2)
			OptionsLayout.Parent = OptionsList
			
			local function toggleDropdown()
				isOpen = not isOpen
				local targetSize = isOpen and UDim2.new(1, 0, 0, 36 + (#options * 32) + 8) or UDim2.new(1, 0, 0, 36)
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
				OptionButton.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
				OptionButton.Size = UDim2.new(1, 0, 0, 30)
				OptionButton.Text = option
				OptionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				OptionButton.TextSize = 14
				OptionButton.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
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
					TweenService:Create(OptionButton, fastTween, {BackgroundColor3 = Color3.fromRGB(0, 139, 255)}):Play()
					TweenService:Create(OptionButton, fastTween, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				end)
				
				OptionButton.MouseLeave:Connect(function()
					TweenService:Create(OptionButton, fastTween, {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}):Play()
					TweenService:Create(OptionButton, fastTween, {TextColor3 = Color3.fromRGB(0, 0, 0)}):Play()
				end)
			end
		end
		
		return tab
	end
	
	return window
end

return Library
