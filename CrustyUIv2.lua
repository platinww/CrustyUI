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

local Library = {}
Library.__index = Library

-- Tween ayarları
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function Library:CreateWindow(config)
	config = config or {}
	local windowTitle = config.Title or "Crusty HUB V1"
	
	local window = {}
	window.CurrentTab = nil
	window.Tabs = {}
	
	-- ScreenGui oluştur
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "CrustyLibrary"
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	
	-- Ana Frame (Arka plan)
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.BorderSizePixel = 0
	MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainFrame.Size = UDim2.new(0, 252, 0, 294)
	MainFrame.Position = UDim2.new(0.5, -126, 0.5, -147)
	MainFrame.BackgroundTransparency = 0.5
	MainFrame.Parent = ScreenGui
	
	local MainCorner = Instance.new("UICorner")
	MainCorner.Parent = MainFrame
	
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
	
	-- Başlık TextBox
	local TitleText = Instance.new("TextBox")
	TitleText.Name = "TitleText"
	TitleText.CursorPosition = -1
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.ZIndex = 2
	TitleText.BorderSizePixel = 0
	TitleText.TextSize = 17
	TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleText.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TitleText.Size = UDim2.new(1, -8, 1, 0)
	TitleText.Position = UDim2.new(0, 4, 0, 0)
	TitleText.Text = "📂 " .. windowTitle
	TitleText.BackgroundTransparency = 10
	TitleText.TextEditable = false
	TitleText.Parent = TitleFrame
	
	-- Tab Container
	local TabContainer = Instance.new("Frame")
	TabContainer.Name = "TabContainer"
	TabContainer.BorderSizePixel = 0
	TabContainer.BackgroundTransparency = 1
	TabContainer.Size = UDim2.new(1, -16, 0, 26)
	TabContainer.Position = UDim2.new(0, 8, 0, 50)
	TabContainer.Parent = MainFrame
	
	local TabLayout = Instance.new("UIListLayout")
	TabLayout.FillDirection = Enum.FillDirection.Horizontal
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 8)
	TabLayout.Parent = TabContainer
	
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
	
	-- Dragging System
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
	
	-- Tab oluşturma fonksiyonu
	function window:CreateTab(tabName)
		local tab = {}
		tab.Elements = {}
		tab.Container = nil
		
		-- Tab Button
		local TabButton = Instance.new("TextBox")
		TabButton.Name = tabName
		TabButton.CursorPosition = -1
		TabButton.ZIndex = 2
		TabButton.BorderSizePixel = 0
		TabButton.TextSize = 14
		TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		TabButton.Size = UDim2.new(0, 74, 0, 26)
		TabButton.Text = tabName
		TabButton.BackgroundTransparency = 0.1
		TabButton.TextEditable = false
		TabButton.Parent = TabContainer
		
		local TabCorner = Instance.new("UICorner")
		TabCorner.Parent = TabButton
		
		-- Tab Content Frame
		local TabContent = Instance.new("ScrollingFrame")
		TabContent.Name = tabName .. "Content"
		TabContent.BorderSizePixel = 0
		TabContent.BackgroundTransparency = 1
		TabContent.Size = UDim2.new(1, -8, 1, -8)
		TabContent.Position = UDim2.new(0, 4, 0, 4)
		TabContent.ScrollBarThickness = 4
		TabContent.Visible = false
		TabContent.Parent = ContentContainer
		
		local ContentLayout = Instance.new("UIListLayout")
		ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ContentLayout.Padding = UDim.new(0, 6)
		ContentLayout.Parent = TabContent
		
		tab.Container = TabContent
		
		-- Tab değiştirme
		TabButton.MouseButton1Click:Connect(function()
			for _, otherTab in pairs(window.Tabs) do
				if otherTab.Container then
					otherTab.Container.Visible = false
				end
			end
			TabContent.Visible = true
			window.CurrentTab = tab
		end)
		
		-- İlk tab'ı aktif et
		if #window.Tabs == 0 then
			TabContent.Visible = true
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
			
			-- Toggle Container
			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.BorderSizePixel = 0
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleFrame.Size = UDim2.new(1, 0, 0, 36)
			ToggleFrame.BackgroundTransparency = 0.1
			ToggleFrame.Parent = TabContent
			
			local ToggleCorner = Instance.new("UICorner")
			ToggleCorner.Parent = ToggleFrame
			
			-- Toggle Text
			local ToggleText = Instance.new("TextBox")
			ToggleText.Name = "ToggleText"
			ToggleText.CursorPosition = -1
			ToggleText.TextXAlignment = Enum.TextXAlignment.Left
			ToggleText.ZIndex = 2
			ToggleText.BorderSizePixel = 0
			ToggleText.TextSize = 15
			ToggleText.BackgroundTransparency = 1
			ToggleText.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			ToggleText.Size = UDim2.new(1, -54, 1, 0)
			ToggleText.Position = UDim2.new(0, 6, 0, 0)
			ToggleText.Text = toggleName
			ToggleText.TextEditable = false
			ToggleText.Parent = ToggleFrame
			
			-- Toggle Switch
			local ToggleSwitch = Instance.new("Frame")
			ToggleSwitch.Name = "ToggleSwitch"
			ToggleSwitch.ZIndex = 3
			ToggleSwitch.BorderSizePixel = 0
			ToggleSwitch.BackgroundColor3 = toggleState and Color3.fromRGB(0, 139, 255) or Color3.fromRGB(200, 200, 200)
			ToggleSwitch.Size = UDim2.new(0, 44, 0, 20)
			ToggleSwitch.Position = UDim2.new(1, -48, 0.5, -10)
			ToggleSwitch.Parent = ToggleFrame
			
			local SwitchCorner = Instance.new("UICorner")
			SwitchCorner.CornerRadius = UDim.new(0, 30)
			SwitchCorner.Parent = ToggleSwitch
			
			-- Toggle Circle
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
			
			-- Toggle fonksiyonu
			local function toggle()
				toggleState = not toggleState
				
				local colorTween = TweenService:Create(
					ToggleSwitch,
					tweenInfo,
					{BackgroundColor3 = toggleState and Color3.fromRGB(0, 139, 255) or Color3.fromRGB(200, 200, 200)}
				)
				
				local positionTween = TweenService:Create(
					ToggleCircle,
					tweenInfo,
					{Position = toggleState and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)}
				)
				
				colorTween:Play()
				positionTween:Play()
				
				callback(toggleState)
			end
			
			-- Click event
			ToggleSwitch.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					toggle()
				end
			end)
			
			-- Return toggle object
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
			
			-- Button Frame
			local ButtonFrame = Instance.new("Frame")
			ButtonFrame.Name = "ButtonFrame"
			ButtonFrame.BorderSizePixel = 0
			ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonFrame.Size = UDim2.new(1, 0, 0, 36)
			ButtonFrame.BackgroundTransparency = 0.1
			ButtonFrame.Parent = TabContent
			
			local ButtonCorner = Instance.new("UICorner")
			ButtonCorner.Parent = ButtonFrame
			
			-- Button Text
			local ButtonText = Instance.new("TextButton")
			ButtonText.Name = "ButtonText"
			ButtonText.ZIndex = 2
			ButtonText.BorderSizePixel = 0
			ButtonText.TextSize = 15
			ButtonText.BackgroundTransparency = 1
			ButtonText.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			ButtonText.Size = UDim2.new(1, -12, 1, 0)
			ButtonText.Position = UDim2.new(0, 6, 0, 0)
			ButtonText.Text = buttonName
			ButtonText.Parent = ButtonFrame
			
			-- Click effect
			ButtonText.MouseButton1Click:Connect(function()
				local originalTransparency = ButtonFrame.BackgroundTransparency
				ButtonFrame.BackgroundTransparency = 0.3
				
				TweenService:Create(
					ButtonFrame,
					TweenInfo.new(0.2),
					{BackgroundTransparency = originalTransparency}
				):Play()
				
				callback()
			end)
		end
		
		return tab
	end
	
	return window
end

return Library
