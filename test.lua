--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  LIBRARY 

designed using localmaze gui creator - converted to library
]=]

local Library = {}
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:Create(config)
    local GUI = {}
    local CurrentTab = "Stealing"
    
    -- Konfigürasyon
    local toggleButtonConfig = config or {}
    local toggleImageId = toggleButtonConfig.ImageId or "rbxassetid://0"
    local togglePosition = toggleButtonConfig.Position or UDim2.new(0, 10, 0.5, -25)
    local toggleSize = toggleButtonConfig.Size or UDim2.new(0, 50, 0, 50)
    local UIDraggable = toggleButtonConfig.Draggable ~= nil and toggleButtonConfig.Draggable or false
    
    -- Ana ScreenGui oluştur
    local ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    CollectionService:AddTag(ScreenGui, "main")
    
    -- Toggle Butonu (Açma/Kapama)
    local ToggleOpenButton = Instance.new("ImageButton", ScreenGui)
    ToggleOpenButton.Size = toggleSize
    ToggleOpenButton.Position = togglePosition
    ToggleOpenButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleOpenButton.BorderSizePixel = 0
    ToggleOpenButton.Image = toggleImageId
    ToggleOpenButton.ZIndex = 10
    
    local ToggleOpenCorner = Instance.new("UICorner", ToggleOpenButton)
    ToggleOpenCorner.CornerRadius = UDim.new(1, 0)
    
    -- Toggle Butonu Draggable
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    ToggleOpenButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = ToggleOpenButton.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    ToggleOpenButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            ToggleOpenButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Ana Frame (Arka Plan) - Ekranın ortasına sabitlendi
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.Size = UDim2.new(0, 250, 0, 284)
    MainFrame.Position = UDim2.new(0.5, -125, 0.5, -142)
    MainFrame.BackgroundTransparency = 0.3
    MainFrame.Visible = true
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local MainCorner = Instance.new("UICorner", MainFrame)
    
    -- Üst Beyaz Frame
    local TopFrame = Instance.new("Frame", ScreenGui)
    TopFrame.BorderSizePixel = 0
    TopFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopFrame.Size = UDim2.new(0, 250, 0, 36)
    TopFrame.Position = UDim2.new(0.5, -125, 0.5, -142)
    TopFrame.BackgroundTransparency = 0.1
    TopFrame.Visible = true
    TopFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local TopCorner = Instance.new("UICorner", TopFrame)
    
    -- Başlık
    local Title = Instance.new("TextButton", ScreenGui)
    Title.BorderSizePixel = 0
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 15
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    Title.ZIndex = 2
    Title.BackgroundTransparency = 100
    Title.Size = UDim2.new(0, 230, 0, 32)
    Title.Text = "📂 Crusty HUB V1"
    Title.Position = UDim2.new(0.5, -115, 0.5, -136)
    Title.AutoButtonColor = false
    Title.Visible = true
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- Tab Butonları Container
    local TabContainer = Instance.new("Frame", ScreenGui)
    TabContainer.BorderSizePixel = 0
    TabContainer.BackgroundTransparency = 1
    TabContainer.Size = UDim2.new(0, 232, 0, 26)
    TabContainer.Position = UDim2.new(0.5, -116, 0.5, -100)
    TabContainer.ZIndex = 2
    TabContainer.Visible = true
    TabContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- Tab Butonları
    local StealingTab = Instance.new("TextButton", TabContainer)
    StealingTab.BorderSizePixel = 0
    StealingTab.TextSize = 14
    StealingTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StealingTab.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    StealingTab.Size = UDim2.new(0, 74, 0, 26)
    StealingTab.Text = "⚡ Stealing"
    StealingTab.Position = UDim2.new(0, 0, 0, 0)
    local StealingCorner = Instance.new("UICorner", StealingTab)
    
    local VisualTab = Instance.new("TextButton", TabContainer)
    VisualTab.BorderSizePixel = 0
    VisualTab.TextSize = 14
    VisualTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    VisualTab.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    VisualTab.Size = UDim2.new(0, 76, 0, 26)
    VisualTab.Text = "👁️ Visual"
    VisualTab.Position = UDim2.new(0, 80, 0, 0)
    local VisualCorner = Instance.new("UICorner", VisualTab)
    
    local PlayerTab = Instance.new("TextButton", TabContainer)
    PlayerTab.BorderSizePixel = 0
    PlayerTab.TextSize = 14
    PlayerTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerTab.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    PlayerTab.Size = UDim2.new(0, 74, 0, 26)
    PlayerTab.Text = "👥 Player"
    PlayerTab.Position = UDim2.new(0, 162, 0, 0)
    local PlayerCorner = Instance.new("UICorner", PlayerTab)
    
    -- İçerik Frameleri
    local ContentFrames = {}
    ContentFrames["Stealing"] = Instance.new("Frame", ScreenGui)
    ContentFrames["Visual"] = Instance.new("Frame", ScreenGui)
    ContentFrames["Player"] = Instance.new("Frame", ScreenGui)
    
    for _, frame in pairs(ContentFrames) do
        frame.BorderSizePixel = 0
        frame.BackgroundTransparency = 1
        frame.Size = UDim2.new(0, 238, 0, 200)
        frame.Position = UDim2.new(0.5, -119, 0.5, -68)
        frame.Visible = false
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
    end
    ContentFrames["Stealing"].Visible = true
    
    -- GUI Draggable Sistemi
    if UIDraggable then
        local guiDragging = false
        local guiDragInput
        local guiDragStart
        local guiStartPos
        
        local function updatePositions(delta)
            -- MainFrame
            MainFrame.Position = UDim2.new(
                guiStartPos.MainFrame.X.Scale,
                guiStartPos.MainFrame.X.Offset + delta.X,
                guiStartPos.MainFrame.Y.Scale,
                guiStartPos.MainFrame.Y.Offset + delta.Y
            )
            -- TopFrame
            TopFrame.Position = UDim2.new(
                guiStartPos.TopFrame.X.Scale,
                guiStartPos.TopFrame.X.Offset + delta.X,
                guiStartPos.TopFrame.Y.Scale,
                guiStartPos.TopFrame.Y.Offset + delta.Y
            )
            -- Title
            Title.Position = UDim2.new(
                guiStartPos.Title.X.Scale,
                guiStartPos.Title.X.Offset + delta.X,
                guiStartPos.Title.Y.Scale,
                guiStartPos.Title.Y.Offset + delta.Y
            )
            -- TabContainer
            TabContainer.Position = UDim2.new(
                guiStartPos.TabContainer.X.Scale,
                guiStartPos.TabContainer.X.Offset + delta.X,
                guiStartPos.TabContainer.Y.Scale,
                guiStartPos.TabContainer.Y.Offset + delta.Y
            )
            -- ContentFrames
            for name, frame in pairs(ContentFrames) do
                frame.Position = UDim2.new(
                    guiStartPos.ContentFrames[name].X.Scale,
                    guiStartPos.ContentFrames[name].X.Offset + delta.X,
                    guiStartPos.ContentFrames[name].Y.Scale,
                    guiStartPos.ContentFrames[name].Y.Offset + delta.Y
                )
            end
        end
        
        TopFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                guiDragging = true
                guiDragStart = input.Position
                guiStartPos = {
                    MainFrame = MainFrame.Position,
                    TopFrame = TopFrame.Position,
                    Title = Title.Position,
                    TabContainer = TabContainer.Position,
                    ContentFrames = {}
                }
                for name, frame in pairs(ContentFrames) do
                    guiStartPos.ContentFrames[name] = frame.Position
                end
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        guiDragging = false
                    end
                end)
            end
        end)
        
        TopFrame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                guiDragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == guiDragInput and guiDragging then
                local delta = input.Position - guiDragStart
                updatePositions(delta)
            end
        end)
    end
    
    -- Toggle Açma/Kapama Fonksiyonu
    local UIOpen = true
    ToggleOpenButton.MouseButton1Click:Connect(function()
        UIOpen = not UIOpen
        MainFrame.Visible = UIOpen
        TopFrame.Visible = UIOpen
        Title.Visible = UIOpen
        TabContainer.Visible = UIOpen
        for _, frame in pairs(ContentFrames) do
            frame.Visible = UIOpen and (frame == ContentFrames[CurrentTab])
        end
    end)
    
    -- Tab Değiştirme Fonksiyonu
    local function SwitchTab(tabName)
        CurrentTab = tabName
        for name, frame in pairs(ContentFrames) do
            frame.Visible = UIOpen and (name == tabName)
        end
    end
    
    StealingTab.MouseButton1Click:Connect(function() SwitchTab("Stealing") end)
    VisualTab.MouseButton1Click:Connect(function() SwitchTab("Visual") end)
    PlayerTab.MouseButton1Click:Connect(function() SwitchTab("Player") end)
    
    -- Toggle Oluşturma Fonksiyonu
    function GUI:CreateToggle(toggleConfig)
        local tab = toggleConfig.Tab or "Stealing"
        local text = toggleConfig.Text or "Toggle"
        local callback = toggleConfig.Callback or function() end
        local default = toggleConfig.Default or false
        
        local toggleData = {Value = default}
        
        -- Toggle Container
        local Container = Instance.new("Frame", ContentFrames[tab])
        Container.BorderSizePixel = 0
        Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Container.Size = UDim2.new(0, 238, 0, 36)
        Container.BackgroundTransparency = 0.1
        local ContainerCorner = Instance.new("UICorner", Container)
        
        -- Toggle Butonu (Text Kısmı)
        local ToggleButton = Instance.new("TextButton", Container)
        ToggleButton.BorderSizePixel = 0
        ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
        ToggleButton.TextSize = 15
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleButton.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        ToggleButton.BackgroundTransparency = 1
        ToggleButton.Size = UDim2.new(1, 0, 1, 0)
        ToggleButton.Text = "  " .. text
        ToggleButton.Position = UDim2.new(0, 0, 0, 0)
        ToggleButton.AutoButtonColor = false
        ToggleButton.ZIndex = 4
        
        -- Toggle Switch (Dış Frame)
        local ToggleSwitch = Instance.new("Frame", Container)
        ToggleSwitch.Active = true
        ToggleSwitch.ZIndex = 3
        ToggleSwitch.BorderSizePixel = 0
        ToggleSwitch.BackgroundColor3 = default and Color3.fromRGB(0, 139, 255) or Color3.fromRGB(200, 200, 200)
        ToggleSwitch.Size = UDim2.new(0, 44, 0, 20)
        ToggleSwitch.Position = UDim2.new(1, -48, 0.5, -10)
        local SwitchCorner = Instance.new("UICorner", ToggleSwitch)
        SwitchCorner.CornerRadius = UDim.new(0, 30)
        
        -- Toggle Circle (İç Daire)
        local ToggleCircle = Instance.new("Frame", ToggleSwitch)
        ToggleCircle.BorderSizePixel = 0
        ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleCircle.Size = UDim2.new(0, 18, 0, 16)
        ToggleCircle.Position = default and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)
        local CircleCorner = Instance.new("UICorner", ToggleCircle)
        CircleCorner.CornerRadius = UDim.new(0, 50)
        
        -- Toggle Switch için tıklanabilir buton (görünmez)
        local ToggleSwitchButton = Instance.new("TextButton", ToggleSwitch)
        ToggleSwitchButton.Size = UDim2.new(1, 0, 1, 0)
        ToggleSwitchButton.BackgroundTransparency = 1
        ToggleSwitchButton.Text = ""
        ToggleSwitchButton.ZIndex = 5
        
        -- Toggle Animasyonu
        local function Toggle()
            toggleData.Value = not toggleData.Value
            
            local circleTween = TweenService:Create(
                ToggleCircle,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = toggleData.Value and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)}
            )
            
            local switchTween = TweenService:Create(
                ToggleSwitch,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = toggleData.Value and Color3.fromRGB(0, 139, 255) or Color3.fromRGB(200, 200, 200)}
            )
            
            circleTween:Play()
            switchTween:Play()
            
            task.spawn(function()
                callback(toggleData.Value)
            end)
        end
        
        ToggleButton.MouseButton1Click:Connect(Toggle)
        ToggleSwitchButton.MouseButton1Click:Connect(Toggle)
        
        function toggleData:SetValue(value)
            if self.Value ~= value then
                Toggle()
            end
        end
        
        return toggleData
    end
    
    -- Auto Layout için UIListLayout ekle
    for _, frame in pairs(ContentFrames) do
        local layout = Instance.new("UIListLayout", frame)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 6)
    end
    
    return GUI
end

return Library
