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
    ScreenGui.ResetOnSpawn = false
    CollectionService:AddTag(ScreenGui, "main")
    
    -- Toggle Butonu (Açma/Kapama) - Sadece bu sürüklenebilir
    local ToggleOpenButton = Instance.new("ImageButton", ScreenGui)
    ToggleOpenButton.Size = toggleSize
    ToggleOpenButton.Position = togglePosition
    ToggleOpenButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleOpenButton.BorderSizePixel = 0
    ToggleOpenButton.Image = toggleImageId
    ToggleOpenButton.ZIndex = 10
    ToggleOpenButton.Active = true
    
    local ToggleOpenCorner = Instance.new("UICorner", ToggleOpenButton)
    ToggleOpenCorner.CornerRadius = UDim.new(1, 0)
    
    -- Toggle Butonu Draggable (Sadece Toggle Butonu)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function updateToggleButton(input)
        local delta = input.Position - dragStart
        ToggleOpenButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
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
            updateToggleButton(input)
        end
    end)
    
    -- Ana Container Frame (Tüm UI elementlerini içerir)
    local MainContainer = Instance.new("Frame", ScreenGui)
    MainContainer.BorderSizePixel = 0
    MainContainer.BackgroundTransparency = 1
    MainContainer.Size = UDim2.new(0, 250, 0, 284)
    MainContainer.Position = UDim2.new(0.5, -125, 0.5, -142)
    MainContainer.Visible = true
    MainContainer.Active = false
    
    -- Ana Frame (Arka Plan)
    local MainFrame = Instance.new("Frame", MainContainer)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.Size = UDim2.new(1, 0, 1, 0)
    MainFrame.Position = UDim2.new(0, 0, 0, 0)
    MainFrame.BackgroundTransparency = 0.3
    
    local MainCorner = Instance.new("UICorner", MainFrame)
    
    -- Üst Beyaz Frame
    local TopFrame = Instance.new("Frame", MainContainer)
    TopFrame.BorderSizePixel = 0
    TopFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopFrame.Size = UDim2.new(1, 0, 0, 36)
    TopFrame.Position = UDim2.new(0, 0, 0, 0)
    TopFrame.BackgroundTransparency = 0.1
    TopFrame.Active = true
    TopFrame.ZIndex = 2
    
    local TopCorner = Instance.new("UICorner", TopFrame)
    
    -- Başlık
    local Title = Instance.new("TextLabel", MainContainer)
    Title.BorderSizePixel = 0
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 15
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    Title.ZIndex = 3
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(0, 230, 0, 32)
    Title.Text = "📂 Crusty HUB V1"
    Title.Position = UDim2.new(0, 10, 0, 2)
    Title.TextColor3 = Color3.fromRGB(0, 0, 0)
    
    -- Tab Butonları Container
    local TabContainer = Instance.new("Frame", MainContainer)
    TabContainer.BorderSizePixel = 0
    TabContainer.BackgroundTransparency = 1
    TabContainer.Size = UDim2.new(0, 232, 0, 26)
    TabContainer.Position = UDim2.new(0, 8, 0, 42)
    TabContainer.ZIndex = 3
    
    -- Tab Butonları
    local StealingTab = Instance.new("TextButton", TabContainer)
    StealingTab.BorderSizePixel = 0
    StealingTab.TextSize = 14
    StealingTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StealingTab.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    StealingTab.Size = UDim2.new(0, 74, 0, 26)
    StealingTab.Text = "⚡ Stealing"
    StealingTab.Position = UDim2.new(0, 0, 0, 0)
    StealingTab.ZIndex = 4
    local StealingCorner = Instance.new("UICorner", StealingTab)
    
    local VisualTab = Instance.new("TextButton", TabContainer)
    VisualTab.BorderSizePixel = 0
    VisualTab.TextSize = 14
    VisualTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    VisualTab.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    VisualTab.Size = UDim2.new(0, 76, 0, 26)
    VisualTab.Text = "👁️ Visual"
    VisualTab.Position = UDim2.new(0, 80, 0, 0)
    VisualTab.ZIndex = 4
    local VisualCorner = Instance.new("UICorner", VisualTab)
    
    local PlayerTab = Instance.new("TextButton", TabContainer)
    PlayerTab.BorderSizePixel = 0
    PlayerTab.TextSize = 14
    PlayerTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerTab.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    PlayerTab.Size = UDim2.new(0, 74, 0, 26)
    PlayerTab.Text = "👥 Player"
    PlayerTab.Position = UDim2.new(0, 162, 0, 0)
    PlayerTab.ZIndex = 4
    local PlayerCorner = Instance.new("UICorner", PlayerTab)
    
    -- İçerik Frameleri
    local ContentFrames = {}
    ContentFrames["Stealing"] = Instance.new("ScrollingFrame", MainContainer)
    ContentFrames["Visual"] = Instance.new("ScrollingFrame", MainContainer)
    ContentFrames["Player"] = Instance.new("ScrollingFrame", MainContainer)
    
    for _, frame in pairs(ContentFrames) do
        frame.BorderSizePixel = 0
        frame.BackgroundTransparency = 1
        frame.Size = UDim2.new(0, 238, 0, 200)
        frame.Position = UDim2.new(0, 6, 0, 74)
        frame.Visible = false
        frame.ZIndex = 3
        frame.ScrollBarThickness = 4
        frame.CanvasSize = UDim2.new(0, 0, 0, 0)
        frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    end
    ContentFrames["Stealing"].Visible = true
    
    -- GUI Draggable Sistemi (Sadece UIDraggable true ise)
    if UIDraggable then
        local guiDragging = false
        local guiDragInput
        local guiDragStart
        local guiStartPos
        
        TopFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                guiDragging = true
                guiDragStart = input.Position
                guiStartPos = MainContainer.Position
                
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
                MainContainer.Position = UDim2.new(
                    guiStartPos.X.Scale,
                    guiStartPos.X.Offset + delta.X,
                    guiStartPos.Y.Scale,
                    guiStartPos.Y.Offset + delta.Y
                )
            end
        end)
    end
    
    -- Toggle Açma/Kapama Fonksiyonu
    local UIOpen = true
    local clicking = false
    
    ToggleOpenButton.MouseButton1Down:Connect(function()
        clicking = true
    end)
    
    ToggleOpenButton.MouseButton1Up:Connect(function()
        if clicking and not dragging then
            UIOpen = not UIOpen
            MainContainer.Visible = UIOpen
        end
        clicking = false
    end)
    
    -- Tab Değiştirme Fonksiyonu
    local function SwitchTab(tabName)
        CurrentTab = tabName
        for name, frame in pairs(ContentFrames) do
            frame.Visible = (name == tabName)
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
        Container.Size = UDim2.new(1, -10, 0, 36)
        Container.BackgroundTransparency = 0.1
        Container.ZIndex = 4
        local ContainerCorner = Instance.new("UICorner", Container)
        
        -- Toggle Text Label
        local ToggleLabel = Instance.new("TextLabel", Container)
        ToggleLabel.BorderSizePixel = 0
        ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        ToggleLabel.TextSize = 15
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
        ToggleLabel.Text = text
        ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
        ToggleLabel.ZIndex = 5
        ToggleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        -- Toggle Switch (Dış Frame)
        local ToggleSwitch = Instance.new("TextButton", Container)
        ToggleSwitch.BorderSizePixel = 0
        ToggleSwitch.BackgroundColor3 = default and Color3.fromRGB(0, 139, 255) or Color3.fromRGB(200, 200, 200)
        ToggleSwitch.Size = UDim2.new(0, 44, 0, 20)
        ToggleSwitch.Position = UDim2.new(1, -48, 0.5, -10)
        ToggleSwitch.Text = ""
        ToggleSwitch.AutoButtonColor = false
        ToggleSwitch.ZIndex = 5
        local SwitchCorner = Instance.new("UICorner", ToggleSwitch)
        SwitchCorner.CornerRadius = UDim.new(0, 30)
        
        -- Toggle Circle (İç Daire)
        local ToggleCircle = Instance.new("Frame", ToggleSwitch)
        ToggleCircle.BorderSizePixel = 0
        ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleCircle.Size = UDim2.new(0, 18, 0, 16)
        ToggleCircle.Position = default and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)
        ToggleCircle.ZIndex = 6
        local CircleCorner = Instance.new("UICorner", ToggleCircle)
        CircleCorner.CornerRadius = UDim.new(0, 50)
        
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
        
        ToggleSwitch.MouseButton1Click:Connect(Toggle)
        
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
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    end
    
    return GUI
end

return Library
