-- Modern Siyah Tema UI Kütüphanesi
-- ICONS FROM https://lucide.dev/
-- Professional Roblox Executor Library with AutoSave

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- Load Icons from GitHub
local Icons = {}
local success, result = pcall(function()
    return HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/platinww/CrustyUI/refs/heads/main/icons.json"))
end)
if success then
    Icons = result
else
    warn("Failed to load icons, using defaults")
    Icons = {
        home = "rbxassetid://10723345405",
        settings = "rbxassetid://10734950309",
        x = "rbxassetid://10747384394"
    }
end

-- Library Constructor
local Library = {}
Library.__index = Library

-- Utility Functions
local function getIcon(iconName)
    if iconName:match("rbxassetid://") then
        return iconName
    end
    return Icons[iconName:lower():gsub("-", "")] or Icons.box or ""
end

local function saveConfig(title, data)
    if not writefile then return end
    local fileName = title:gsub("%s+", "_"):gsub("[^%w_]", "") .. "_data.json"
    local success, err = pcall(function()
        writefile(fileName, HttpService:JSONEncode(data))
    end)
    if not success then
        warn("AutoSave failed: " .. tostring(err))
    end
end

local function loadConfig(title)
    if not readfile or not isfile then return {} end
    local fileName = title:gsub("%s+", "_"):gsub("[^%w_]", "") .. "_data.json"
    if not isfile(fileName) then return {} end
    
    local success, data = pcall(function()
        return readfile(fileName)
    end)
    if success and data then
        local decoded = pcall(function()
            return HttpService:JSONDecode(data)
        end)
        if decoded then
            return HttpService:JSONDecode(data)
        end
    end
    return {}
end

-- Create Library Instance
function Library.new()
    local self = setmetatable({}, Library)
    self.Toggles = {}
    self.Options = {}
    self.Flags = {}
    return self
end

-- Create Window
function Library:CreateWindow(config)
    config = config or {}
    
    local Window = {}
    Window.Title = config.Title or "Modern UI"
    Window.Subtitle = config.Subtitle or "v1.0"
    Window.AutoSave = config.AutoSave == true
    Window.Tabs = {}
    Window.TabButtons = {}
    Window.ActiveTab = nil
    Window.Library = self
    
    -- Load saved data
    if Window.AutoSave then
        self.SaveData = loadConfig(Window.Title)
    else
        self.SaveData = {}
    end
    
    -- Detect platform
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernUI_" .. Window.Title:gsub("%s+", "")
    ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 100
    
    -- Open/Toggle Button
    local OpenButton = Instance.new("TextButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Parent = ScreenGui
    OpenButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    OpenButton.BorderSizePixel = 0
    OpenButton.Position = UDim2.new(0, 10, 0, 10)
    OpenButton.Size = isMobile and UDim2.new(0, 50, 0, 50) or UDim2.new(0, 140, 0, 40)
    OpenButton.Font = Enum.Font.GothamBold
    OpenButton.Text = isMobile and "" or " Open"
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.TextSize = 13
    OpenButton.TextXAlignment = Enum.TextXAlignment.Left
    OpenButton.AutoButtonColor = false
    OpenButton.Active = true
    OpenButton.Draggable = true
    OpenButton.ZIndex = 200
    
    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(0, isMobile and 25 or 8)
    OpenCorner.Parent = OpenButton
    
    local OpenGradient = Instance.new("UIGradient")
    OpenGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(59, 130, 246))
    }
    OpenGradient.Rotation = 45
    OpenGradient.Parent = OpenButton
    
    local OpenIcon = Instance.new("ImageLabel")
    OpenIcon.Parent = OpenButton
    OpenIcon.BackgroundTransparency = 1
    OpenIcon.Position = isMobile and UDim2.new(0.5, -10, 0.5, -10) or UDim2.new(0, 6, 0.5, -8)
    OpenIcon.Size = UDim2.new(0, 16, 0, 16)
    OpenIcon.Image = getIcon("sparkles")
    OpenIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Main UI Container
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainUI"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = isMobile and UDim2.new(0.5, -160, 0.5, -220) or UDim2.new(0.5, -375, 0.5, -235)
    MainFrame.Size = isMobile and UDim2.new(0, 320, 0, 440) or UDim2.new(0, 750, 0, 470)
    MainFrame.Visible = false
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame
    
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(139, 92, 246)
    MainStroke.Thickness = 1.5
    MainStroke.Transparency = 0.5
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Parent = MainFrame
    
    -- Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    TopBar.BackgroundTransparency = 0.2
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 12)
    TopBarCorner.Parent = TopBar
    
    local TitleIcon = Instance.new("ImageLabel")
    TitleIcon.Parent = TopBar
    TitleIcon.BackgroundTransparency = 1
    TitleIcon.Position = UDim2.new(0, 12, 0, 10)
    TitleIcon.Size = UDim2.new(0, 28, 0, 28)
    TitleIcon.Image = getIcon("gamepad")
    TitleIcon.ImageColor3 = Color3.fromRGB(139, 92, 246)
    
    local Title = Instance.new("TextLabel")
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 45, 0, 8)
    Title.Size = UDim2.new(0, 300, 0, 20)
    Title.Font = Enum.Font.GothamBold
    Title.Text = Window.Title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = isMobile and 16 or 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Parent = TopBar
    Subtitle.BackgroundTransparency = 1
    Subtitle.Position = UDim2.new(0, 45, 0, 28)
    Subtitle.Size = UDim2.new(0, 300, 0, 14)
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Text = Window.Subtitle
    Subtitle.TextColor3 = Color3.fromRGB(139, 92, 246)
    Subtitle.TextSize = 10
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = TopBar
    CloseButton.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -38, 0.5, -12)
    CloseButton.Size = UDim2.new(0, 32, 0, 24)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = ""
    CloseButton.AutoButtonColor = false
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton
    
    local CloseIcon = Instance.new("ImageLabel")
    CloseIcon.Parent = CloseButton
    CloseIcon.BackgroundTransparency = 1
    CloseIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
    CloseIcon.Size = UDim2.new(0, 16, 0, 16)
    CloseIcon.Image = getIcon("x")
    CloseIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Tabs Section
    local TabsContainer = Instance.new("Frame")
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Parent = MainFrame
    TabsContainer.BackgroundTransparency = 1
    TabsContainer.Position = UDim2.new(0, 0, 0, 55)
    TabsContainer.Size = UDim2.new(1, 0, 0, isMobile and 35 or 40)
    TabsContainer.ClipsDescendants = false
    
    local TabsScroll = Instance.new("ScrollingFrame")
    TabsScroll.Name = "TabsScroll"
    TabsScroll.Parent = TabsContainer
    TabsScroll.BackgroundTransparency = 1
    TabsScroll.BorderSizePixel = 0
    TabsScroll.Position = UDim2.new(0, 5, 0, 0)
    TabsScroll.Size = UDim2.new(1, -10, 1, 0)
    TabsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsScroll.ScrollBarThickness = 0
    TabsScroll.ScrollingDirection = Enum.ScrollingDirection.X
    TabsScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
    
    local TabsList = Instance.new("UIListLayout")
    TabsList.Parent = TabsScroll
    TabsList.FillDirection = Enum.FillDirection.Horizontal
    TabsList.SortOrder = Enum.SortOrder.LayoutOrder
    TabsList.Padding = UDim.new(0, 6)
    
    local TabsPadding = Instance.new("UIPadding")
    TabsPadding.Parent = TabsScroll
    TabsPadding.PaddingLeft = UDim.new(0, 2)
    TabsPadding.PaddingRight = UDim.new(0, 2)
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 0, 0, isMobile and 95 or 100)
    ContentContainer.Size = UDim2.new(1, 0, 1, isMobile and -95 or -100)
    
    -- Functions
    local function tweenButton(button, hoverColor, normalColor)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = normalColor}):Play()
        end)
    end
    
    -- Open/Close Toggle
    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        if MainFrame.Visible then
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                Size = isMobile and UDim2.new(0, 320, 0, 440) or UDim2.new(0, 750, 0, 470)
            }):Play()
        end
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.wait(0.25)
        MainFrame.Visible = false
    end)
    
    tweenButton(OpenButton, Color3.fromRGB(25, 25, 30), Color3.fromRGB(20, 20, 25))
    tweenButton(CloseButton, Color3.fromRGB(239, 68, 68), Color3.fromRGB(220, 38, 38))
    
    -- Make UI Draggable
    local dragging, dragInput, dragStart, startPos
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- AddTab Function
    function Window:AddTab(config)
        if type(config) == "string" then
            config = {Name = config}
        end
        
        local Tab = {}
        Tab.Name = config.Name or "Tab"
        Tab.Icon = config.Icon or "box"
        Tab.Elements = {}
        Tab.Window = Window
        
        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "Tab_" .. Tab.Name
        TabButton.Parent = TabsScroll
        TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(0, isMobile and 90 or 110, 1, -4)
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Text = "  " .. Tab.Name
        TabButton.TextColor3 = Color3.fromRGB(180, 180, 190)
        TabButton.TextSize = isMobile and 11 or 12
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.AutoButtonColor = false
        TabButton.LayoutOrder = #Window.Tabs + 1
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabButton
        
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Parent = TabButton
        TabIcon.BackgroundTransparency = 1
        TabIcon.Position = UDim2.new(0, 6, 0.5, -8)
        TabIcon.Size = UDim2.new(0, 16, 0, 16)
        TabIcon.Image = getIcon(Tab.Icon)
        TabIcon.ImageColor3 = Color3.fromRGB(180, 180, 190)
        
        local TabPadding = Instance.new("UIPadding")
        TabPadding.Parent = TabButton
        TabPadding.PaddingLeft = UDim.new(0, 26)
        
        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "TabContent_" .. Tab.Name
        TabContent.Parent = ContentContainer
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.Visible = false
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(139, 92, 246)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.Parent = TabContent
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 8)
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.Parent = TabContent
        ContentPadding.PaddingTop = UDim.new(0, 8)
        ContentPadding.PaddingBottom = UDim.new(0, 8)
        ContentPadding.PaddingLeft = UDim.new(0, 10)
        ContentPadding.PaddingRight = UDim.new(0, 10)
        
        -- Tab Click
        TabButton.MouseButton1Click:Connect(function()
            -- Deactivate all tabs
            for _, btn in pairs(Window.TabButtons) do
                TweenService:Create(btn.Button, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(25, 25, 32),
                    TextColor3 = Color3.fromRGB(180, 180, 190)
                }):Play()
                TweenService:Create(btn.Icon, TweenInfo.new(0.15), {
                    ImageColor3 = Color3.fromRGB(180, 180, 190)
                }):Play()
                btn.Content.Visible = false
            end
            
            -- Activate this tab
            TweenService:Create(TabButton, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(139, 92, 246),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            TweenService:Create(TabIcon, TweenInfo.new(0.15), {
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            TabContent.Visible = true
            Window.ActiveTab = Tab
        end)
        
        tweenButton(TabButton, Color3.fromRGB(35, 35, 42), Color3.fromRGB(25, 25, 32))
        
        table.insert(Window.Tabs, Tab)
        table.insert(Window.TabButtons, {
            Button = TabButton,
            Icon = TabIcon,
            Content = TabContent,
            Tab = Tab
        })
        
        -- Auto-select first tab
        if #Window.Tabs == 1 then
            TabButton.MouseButton1Click:Fire()
        end
        
        -- Add Elements Functions
        function Tab:AddToggle(flag, config)
            if type(flag) == "table" then
                config = flag
                flag = config.Flag or config.Text or "Toggle"
            end
            
            config = config or {}
            local Toggle = {}
            Toggle.Flag = flag
            Toggle.Text = config.Text or flag
            Toggle.Default = config.Default or false
            Toggle.Callback = config.Callback or function() end
            
            -- Load saved value
            if Window.AutoSave and self.Window.Library.SaveData[flag] ~= nil then
                Toggle.Value = self.Window.Library.SaveData[flag]
            else
                Toggle.Value = Toggle.Default
            end
            
            -- Toggle Container
            local Container = Instance.new("Frame")
            Container.Name = "Toggle_" .. flag
            Container.Parent = TabContent
            Container.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, -8, 0, 38)
            Container.LayoutOrder = #Tab.Elements + 1
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Container
            
            local Label = Instance.new("TextLabel")
            Label.Parent = Container
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 12, 0, 0)
            Label.Size = UDim2.new(1, -80, 1, 0)
            Label.Font = Enum.Font.GothamSemibold
            Label.Text = Toggle.Text
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Parent = Container
            ToggleButton.BackgroundColor3 = Toggle.Value and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(45, 45, 55)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Position = UDim2.new(1, -58, 0.5, -12)
            ToggleButton.Size = UDim2.new(0, 46, 0, 24)
            ToggleButton.Text = ""
            ToggleButton.AutoButtonColor = false
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCorner.Parent = ToggleButton
            
            local Indicator = Instance.new("Frame")
            Indicator.Parent = ToggleButton
            Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Indicator.BorderSizePixel = 0
            Indicator.Position = Toggle.Value and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
            Indicator.Size = UDim2.new(0, 20, 0, 20)
            
            local IndicatorCorner = Instance.new("UICorner")
            IndicatorCorner.CornerRadius = UDim.new(1, 0)
            IndicatorCorner.Parent = Indicator
            
            function Toggle:SetValue(value)
                self.Value = value
                
                TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = value and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(45, 45, 55)
                }):Play()
                
                TweenService:Create(Indicator, TweenInfo.new(0.2), {
                    Position = value and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
                }):Play()
                
                -- Save to config
                if Window.AutoSave then
                    self.Window.Library.SaveData[self.Flag] = value
                    saveConfig(self.Window.Title, self.Window.Library.SaveData)
                end
                
                pcall(self.Callback, value)
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                Toggle:SetValue(not Toggle.Value)
            end)
            
            tweenButton(Container, Color3.fromRGB(28, 28, 34), Color3.fromRGB(22, 22, 28))
            
            table.insert(Tab.Elements, Toggle)
            self.Window.Library.Toggles[flag] = Toggle
            self.Window.Library.Flags[flag] = Toggle
            
            return Toggle
        end
        
        function Tab:AddButton(config)
            if type(config) == "string" then
                config = {Text = config}
            end
            
            config = config or {}
            local Button = {}
            Button.Text = config.Text or "Button"
            Button.Callback = config.Func or config.Callback or function() end
            
            local Container = Instance.new("TextButton")
            Container.Name = "Button_" .. Button.Text
            Container.Parent = TabContent
            Container.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, -8, 0, 38)
            Container.Font = Enum.Font.GothamBold
            Container.Text = Button.Text
            Container.TextColor3 = Color3.fromRGB(255, 255, 255)
            Container.TextSize = 13
            Container.AutoButtonColor = false
            Container.LayoutOrder = #Tab.Elements + 1
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Container
            
            Container.MouseButton1Click:Connect(function()
                pcall(Button.Callback)
            end)
            
            tweenButton(Container, Color3.fromRGB(149, 102, 255), Color3.fromRGB(139, 92, 246))
            
            table.insert(Tab.Elements, Button)
            return Button
        end
        
        function Tab:AddSlider(flag, config)
            if type(flag) == "table" then
                config = flag
                flag = config.Flag or config.Text or "Slider"
            end
            
            config = config or {}
            local Slider = {}
            Slider.Flag = flag
            Slider.Text = config.Text or flag
            Slider.Min = config.Min or 0
            Slider.Max = config.Max or 100
            Slider.Default = config.Default or Slider.Min
            Slider.Rounding = config.Rounding or 0
            Slider.Callback = config.Callback or function() end
            Slider.Suffix = config.Suffix or ""
            
            -- Load saved value
            if Window.AutoSave and self.Window.Library.SaveData[flag] ~= nil then
                Slider.Value = self.Window.Library.SaveData[flag]
            else
                Slider.Value = Slider.Default
            end
            
            local Container = Instance.new("Frame")
            Container.Name = "Slider_" .. flag
            Container.Parent = TabContent
            Container.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, -8, 0, 55)
            Container.LayoutOrder = #Tab.Elements + 1
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Container
            
            local Label = Instance.new("TextLabel")
            Label.Parent = Container
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 12, 0, 6)
            Label.Size = UDim2.new(1, -24, 0, 16)
            Label.Font = Enum.Font.GothamSemibold
            Label.Text = Slider.Text
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Parent = Container
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Position = UDim2.new(1, -70, 0, 6)
            ValueLabel.Size = UDim2.new(0, 60, 0, 16)
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.Text = tostring(Slider.Value) .. Slider.Suffix
            ValueLabel.TextColor3 = Color3.fromRGB(139, 92, 246)
            ValueLabel.TextSize = 12
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            
            local SliderBack = Instance.new("Frame")
            SliderBack.Parent = Container
            SliderBack.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            SliderBack.BorderSizePixel = 0
            SliderBack.Position = UDim2.new(0, 12, 0, 32)
            SliderBack.Size = UDim2.new(1, -24, 0, 16)
            
            local SliderBackCorner = Instance.new("UICorner")
            SliderBackCorner.CornerRadius = UDim.new(1, 0)
            SliderBackCorner.Parent = SliderBack
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Parent = SliderBack
            SliderFill.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
            SliderFill.BorderSizePixel = 0
            SliderFill.Size = UDim2.new((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
            
            local SliderFillCorner = Instance.new("UICorner")
            SliderFillCorner.CornerRadius = UDim.new(1, 0)
            SliderFillCorner.Parent = SliderFill
            
            local SliderDot = Instance.new("Frame")
            SliderDot.Parent = SliderBack
            SliderDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderDot.BorderSizePixel = 0
            SliderDot.Position = UDim2.new((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), -6, 0.5, -6)
            SliderDot.Size = UDim2.new(0, 12, 0, 12)
            SliderDot.ZIndex = 2
            
            local DotCorner = Instance.new("UICorner")
            DotCorner.CornerRadius = UDim.new(1, 0)
            DotCorner.Parent = SliderDot
            
            function Slider:SetValue(value)
                value = math.clamp(value, self.Min, self.Max)
                if self.Rounding > 0 then
                    value = math.floor(value * (10 ^ self.Rounding) + 0.5) / (10 ^ self.Rounding)
                else
                    value = math.floor(value + 0.5)
                end
                
                self.Value = value
                ValueLabel.Text = tostring(value) .. self.Suffix
                
                local percent = (value - self.Min) / (self.Max - self.Min)
                TweenService:Create(SliderFill, TweenInfo.new(0.1), {Size = UDim2.new(percent, 0, 1, 0)}):Play()
                TweenService:Create(SliderDot, TweenInfo.new(0.1), {Position = UDim2.new(percent, -6, 0.5, -6)}):Play()
                
                -- Save to config
                if Window.AutoSave then
                    self.Window.Library.SaveData[self.Flag] = value
                    saveConfig(self.Window.Title, self.Window.Library.SaveData)
                end
                
                pcall(self.Callback, value)
            end
            
            local dragging = false
            SliderBack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    local function update()
                        local mousePos = UserInputService:GetMouseLocation().X
                        local relativePos = mousePos - SliderBack.AbsolutePosition.X
                        local percent = math.clamp(relativePos / SliderBack.AbsoluteSize.X, 0, 1)
                        local value = Slider.Min + (Slider.Max - Slider.Min) * percent
                        Slider:SetValue(value)
                    end
                    update()
                    
                    local connection
                    connection = input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                            connection:Disconnect()
                        end
                    end)
                end
            end)
            
            SliderBack.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local mousePos = UserInputService:GetMouseLocation().X
                    local relativePos = mousePos - SliderBack.AbsolutePosition.X
                    local percent = math.clamp(relativePos / SliderBack.AbsoluteSize.X, 0, 1)
                    local value = Slider.Min + (Slider.Max - Slider.Min) * percent
                    Slider:SetValue(value)
                end
            end)
            
            tweenButton(Container, Color3.fromRGB(28, 28, 34), Color3.fromRGB(22, 22, 28))
            
            table.insert(Tab.Elements, Slider)
            self.Window.Library.Options[flag] = Slider
            self.Window.Library.Flags[flag] = Slider
            
            -- Apply initial value
            Slider:SetValue(Slider.Value)
            
            return Slider
        end
        
        function Tab:AddDropdown(flag, config)
            if type(flag) == "table" then
                config = flag
                flag = config.Flag or config.Text or "Dropdown"
            end
            
            config = config or {}
            local Dropdown = {}
            Dropdown.Flag = flag
            Dropdown.Text = config.Text or flag
            Dropdown.Values = config.Values or {}
            Dropdown.Default = config.Default or Dropdown.Values[1] or ""
            Dropdown.Multi = config.Multi or false
            Dropdown.Callback = config.Callback or function() end
            
            -- Load saved value
            if Window.AutoSave and self.Window.Library.SaveData[flag] ~= nil then
                Dropdown.Value = self.Window.Library.SaveData[flag]
            else
                Dropdown.Value = Dropdown.Multi and {} or Dropdown.Default
            end
            
            local Container = Instance.new("Frame")
            Container.Name = "Dropdown_" .. flag
            Container.Parent = TabContent
            Container.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, -8, 0, 38)
            Container.LayoutOrder = #Tab.Elements + 1
            Container.ClipsDescendants = true
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Container
            
            local Label = Instance.new("TextLabel")
            Label.Parent = Container
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 12, 0, 0)
            Label.Size = UDim2.new(1, -40, 0, 38)
            Label.Font = Enum.Font.GothamSemibold
            Label.Text = Dropdown.Text
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local DropButton = Instance.new("TextButton")
            DropButton.Parent = Container
            DropButton.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            DropButton.BorderSizePixel = 0
            DropButton.Position = UDim2.new(1, -28, 0, 9)
            DropButton.Size = UDim2.new(0, 20, 0, 20)
            DropButton.Text = ""
            DropButton.AutoButtonColor = false
            
            local DropCorner = Instance.new("UICorner")
            DropCorner.CornerRadius = UDim.new(0, 4)
            DropCorner.Parent = DropButton
            
            local DropIcon = Instance.new("ImageLabel")
            DropIcon.Parent = DropButton
            DropIcon.BackgroundTransparency = 1
            DropIcon.Position = UDim2.new(0.5, -6, 0.5, -6)
            DropIcon.Size = UDim2.new(0, 12, 0, 12)
            DropIcon.Image = getIcon("chevrondown")
            DropIcon.ImageColor3 = Color3.fromRGB(180, 180, 190)
            
            local OptionsContainer = Instance.new("Frame")
            OptionsContainer.Parent = Container
            OptionsContainer.BackgroundTransparency = 1
            OptionsContainer.Position = UDim2.new(0, 0, 0, 38)
            OptionsContainer.Size = UDim2.new(1, 0, 0, 0)
            OptionsContainer.Visible = false
            
            local OptionsList = Instance.new("UIListLayout")
            OptionsList.Parent = OptionsContainer
            OptionsList.SortOrder = Enum.SortOrder.LayoutOrder
            OptionsList.Padding = UDim.new(0, 2)
            
            local isOpen = false
            
            function Dropdown:SetValue(value)
                self.Value = value
                
                -- Save to config
                if Window.AutoSave then
                    self.Window.Library.SaveData[self.Flag] = value
                    saveConfig(self.Window.Title, self.Window.Library.SaveData)
                end
                
                pcall(self.Callback, value)
            end
            
            function Dropdown:Refresh()
                OptionsContainer:ClearAllChildren()
                OptionsList.Parent = OptionsContainer
                
                for i, value in ipairs(self.Values) do
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Parent = OptionsContainer
                    OptionButton.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
                    OptionButton.BorderSizePixel = 0
                    OptionButton.Size = UDim2.new(1, 0, 0, 32)
                    OptionButton.Font = Enum.Font.Gotham
                    OptionButton.Text = "  " .. tostring(value)
                    OptionButton.TextColor3 = Color3.fromRGB(200, 200, 210)
                    OptionButton.TextSize = 12
                    OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                    OptionButton.AutoButtonColor = false
                    OptionButton.LayoutOrder = i
                    
                    local OptCorner = Instance.new("UICorner")
                    OptCorner.CornerRadius = UDim.new(0, 6)
                    OptCorner.Parent = OptionButton
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        Dropdown:SetValue(value)
                        isOpen = false
                        OptionsContainer.Visible = false
                        TweenService:Create(Container, TweenInfo.new(0.2), {Size = UDim2.new(1, -8, 0, 38)}):Play()
                        TweenService:Create(DropIcon, TweenInfo.new(0.2), {Rotation = 0}):Play()
                    end)
                    
                    tweenButton(OptionButton, Color3.fromRGB(38, 38, 44), Color3.fromRGB(28, 28, 34))
                end
                
                local totalHeight = #self.Values * 34
                OptionsContainer.Size = UDim2.new(1, 0, 0, totalHeight)
            end
            
            DropButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                OptionsContainer.Visible = isOpen
                
                if isOpen then
                    Dropdown:Refresh()
                    local totalHeight = #Dropdown.Values * 34
                    TweenService:Create(Container, TweenInfo.new(0.2), {Size = UDim2.new(1, -8, 0, 38 + totalHeight + 4)}):Play()
                    TweenService:Create(DropIcon, TweenInfo.new(0.2), {Rotation = 180}):Play()
                else
                    TweenService:Create(Container, TweenInfo.new(0.2), {Size = UDim2.new(1, -8, 0, 38)}):Play()
                    TweenService:Create(DropIcon, TweenInfo.new(0.2), {Rotation = 0}):Play()
                end
            end)
            
            tweenButton(Container, Color3.fromRGB(28, 28, 34), Color3.fromRGB(22, 22, 28))
            
            table.insert(Tab.Elements, Dropdown)
            self.Window.Library.Options[flag] = Dropdown
            self.Window.Library.Flags[flag] = Dropdown
            
            return Dropdown
        end
        
        function Tab:AddInput(flag, config)
            if type(flag) == "table" then
                config = flag
                flag = config.Flag or config.Text or "Input"
            end
            
            config = config or {}
            local Input = {}
            Input.Flag = flag
            Input.Text = config.Text or flag
            Input.Default = config.Default or ""
            Input.Placeholder = config.Placeholder or "Enter text..."
            Input.Callback = config.Callback or function() end
            
            -- Load saved value
            if Window.AutoSave and self.Window.Library.SaveData[flag] ~= nil then
                Input.Value = self.Window.Library.SaveData[flag]
            else
                Input.Value = Input.Default
            end
            
            local Container = Instance.new("Frame")
            Container.Name = "Input_" .. flag
            Container.Parent = TabContent
            Container.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, -8, 0, 55)
            Container.LayoutOrder = #Tab.Elements + 1
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Container
            
            local Label = Instance.new("TextLabel")
            Label.Parent = Container
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 12, 0, 6)
            Label.Size = UDim2.new(1, -24, 0, 16)
            Label.Font = Enum.Font.GothamSemibold
            Label.Text = Input.Text
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local InputBox = Instance.new("TextBox")
            InputBox.Parent = Container
            InputBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            InputBox.BorderSizePixel = 0
            InputBox.Position = UDim2.new(0, 12, 0, 28)
            InputBox.Size = UDim2.new(1, -24, 0, 22)
            InputBox.Font = Enum.Font.Gotham
            InputBox.PlaceholderText = Input.Placeholder
            InputBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
            InputBox.Text = Input.Value
            InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            InputBox.TextSize = 12
            InputBox.TextXAlignment = Enum.TextXAlignment.Left
            InputBox.ClearTextOnFocus = false
            
            local InputCorner = Instance.new("UICorner")
            InputCorner.CornerRadius = UDim.new(0, 6)
            InputCorner.Parent = InputBox
            
            local InputPadding = Instance.new("UIPadding")
            InputPadding.Parent = InputBox
            InputPadding.PaddingLeft = UDim.new(0, 8)
            InputPadding.PaddingRight = UDim.new(0, 8)
            
            function Input:SetValue(value)
                self.Value = value
                InputBox.Text = value
                
                -- Save to config
                if Window.AutoSave then
                    self.Window.Library.SaveData[self.Flag] = value
                    saveConfig(self.Window.Title, self.Window.Library.SaveData)
                end
                
                pcall(self.Callback, value)
            end
            
            InputBox.FocusLost:Connect(function()
                Input:SetValue(InputBox.Text)
            end)
            
            tweenButton(Container, Color3.fromRGB(28, 28, 34), Color3.fromRGB(22, 22, 28))
            
            table.insert(Tab.Elements, Input)
            self.Window.Library.Options[flag] = Input
            self.Window.Library.Flags[flag] = Input
            
            return Input
        end
        
        function Tab:AddLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Parent = TabContent
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(1, -8, 0, 25)
            Label.Font = Enum.Font.Gotham
            Label.Text = text or "Label"
            Label.TextColor3 = Color3.fromRGB(180, 180, 190)
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.LayoutOrder = #Tab.Elements + 1
            
            local LabelPadding = Instance.new("UIPadding")
            LabelPadding.Parent = Label
            LabelPadding.PaddingLeft = UDim.new(0, 4)
            
            table.insert(Tab.Elements, Label)
            return Label
        end
        
        function Tab:AddDivider()
            local Divider = Instance.new("Frame")
            Divider.Parent = TabContent
            Divider.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
            Divider.BackgroundTransparency = 0.7
            Divider.BorderSizePixel = 0
            Divider.Size = UDim2.new(1, -8, 0, 2)
            Divider.LayoutOrder = #Tab.Elements + 1
            
            table.insert(Tab.Elements, Divider)
            return Divider
        end
        
        return Tab
    end
    
    -- Notification System
    function Window:Notify(config)
        if type(config) == "string" then
            config = {Text = config}
        end
        
        config = config or {}
        local text = config.Text or config.Description or "Notification"
        local duration = config.Time or config.Duration or 3
        
        local NotifContainer = ScreenGui:FindFirstChild("Notifications")
        if not NotifContainer then
            NotifContainer = Instance.new("Frame")
            NotifContainer.Name = "Notifications"
            NotifContainer.Parent = ScreenGui
            NotifContainer.BackgroundTransparency = 1
            NotifContainer.Position = UDim2.new(1, -320, 0, 10)
            NotifContainer.Size = UDim2.new(0, 310, 1, -20)
            
            local NotifList = Instance.new("UIListLayout")
            NotifList.Parent = NotifContainer
            NotifList.SortOrder = Enum.SortOrder.LayoutOrder
            NotifList.Padding = UDim.new(0, 8)
        end
        
        local Notif = Instance.new("Frame")
        Notif.Parent = NotifContainer
        Notif.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
        Notif.BorderSizePixel = 0
        Notif.Size = UDim2.new(1, 0, 0, 0)
        Notif.ClipsDescendants = true
        
        local NotifCorner = Instance.new("UICorner")
        NotifCorner.CornerRadius = UDim.new(0, 8)
        NotifCorner.Parent = Notif
        
        local NotifStroke = Instance.new("UIStroke")
        NotifStroke.Color = Color3.fromRGB(139, 92, 246)
        NotifStroke.Thickness = 1
        NotifStroke.Transparency = 0.5
        NotifStroke.Parent = Notif
        
        local NotifText = Instance.new("TextLabel")
        NotifText.Parent = Notif
        NotifText.BackgroundTransparency = 1
        NotifText.Position = UDim2.new(0, 12, 0, 8)
        NotifText.Size = UDim2.new(1, -24, 1, -16)
        NotifText.Font = Enum.Font.Gotham
        NotifText.Text = text
        NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotifText.TextSize = 12
        NotifText.TextWrapped = true
        NotifText.TextXAlignment = Enum.TextXAlignment.Left
        NotifText.TextYAlignment = Enum.TextYAlignment.Top
        
        -- Calculate height based on text
        local textBounds = NotifText.TextBounds.Y
        local height = math.max(40, textBounds + 16)
        
        TweenService:Create(Notif, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(1, 0, 0, height)
        }):Play()
        
        task.delay(duration, function()
            TweenService:Create(Notif, TweenInfo.new(0.2), {
                Size = UDim2.new(1, 0, 0, 0)
            }):Play()
            task.wait(0.2)
            Notif:Destroy()
        end)
    end
    
    return Window
end

-- Return Library
return Library.new()
