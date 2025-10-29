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

-- Sürükleme fonksiyonu
local function MakeDraggable(gui)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function Library:Create(config)
    local GUI = {}
    local CurrentTab = nil
    local Tabs = {}
    
    -- Konfigürasyon
    local toggleButtonConfig = config or {}
    local toggleImageId = toggleButtonConfig.ImageId or "rbxassetid://0"
    local toggleSize = toggleButtonConfig.Size or UDim2.new(0, 50, 0, 50)
    local guiTitle = toggleButtonConfig.Title or "📂 Crusty HUB V1"
    
    -- Ana ScreenGui oluştur
    local ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    CollectionService:AddTag(ScreenGui, "main")
    
    -- Toggle Butonu (Açma/Kapama) - Ekranın sol üst köşesinde
    local ToggleOpenButton = Instance.new("ImageButton", ScreenGui)
    ToggleOpenButton.Size = toggleSize
    ToggleOpenButton.Position = UDim2.new(0, 10, 0, 10)
    ToggleOpenButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleOpenButton.BorderSizePixel = 0
    ToggleOpenButton.Image = toggleImageId
    ToggleOpenButton.ZIndex = 10
    
    local ToggleOpenCorner = Instance.new("UICorner", ToggleOpenButton)
    ToggleOpenCorner.CornerRadius = UDim.new(1, 0)
    
    -- Ana Frame (Arka Plan) - Ekranın tam ortasında
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.Size = UDim2.new(0, 250, 0, 284)
    MainFrame.Position = UDim2.new(0.5, -125, 0.5, -142)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundTransparency = 0.3
    MainFrame.Visible = true
    
    local MainCorner = Instance.new("UICorner", MainFrame)
    
    -- Üst Beyaz Frame
    local TopFrame = Instance.new("Frame", MainFrame)
    TopFrame.BorderSizePixel = 0
    TopFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopFrame.Size = UDim2.new(1, 0, 0, 36)
    TopFrame.Position = UDim2.new(0, 0, 0, 0)
    TopFrame.BackgroundTransparency = 0.05
    TopFrame.Visible = true
    
    local TopCorner = Instance.new("UICorner", TopFrame)
    
    -- Ana Frame'i sürüklenebilir yap (TopFrame'den sürükle)
    MakeDraggable(MainFrame)
    
    -- Başlık
    local Title = Instance.new("TextLabel", TopFrame)
    Title.BorderSizePixel = 0
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 15
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    Title.ZIndex = 2
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Text = "  " .. guiTitle
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.TextColor3 = Color3.fromRGB(0, 0, 0)
    Title.Visible = true
    
    -- Tab Butonları Container
    local TabContainer = Instance.new("Frame", MainFrame)
    TabContainer.BorderSizePixel = 0
    TabContainer.BackgroundTransparency = 1
    TabContainer.Size = UDim2.new(1, -16, 0, 26)
    TabContainer.Position = UDim2.new(0, 8, 0, 42)
    TabContainer.ZIndex = 2
    TabContainer.Visible = true
    
    local TabLayout = Instance.new("UIListLayout", TabContainer)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 6)
    
    -- İçerik Container
    local ContentContainer = Instance.new("Frame", MainFrame)
    ContentContainer.BorderSizePixel = 0
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Size = UDim2.new(1, -24, 1, -80)
    ContentContainer.Position = UDim2.new(0, 12, 0, 74)
    ContentContainer.Visible = true
    
    -- Toggle Açma/Kapama Fonksiyonu
    local UIOpen = true
    ToggleOpenButton.MouseButton1Click:Connect(function()
        UIOpen = not UIOpen
        MainFrame.Visible = UIOpen
    end)
    
    -- Tab Oluşturma Fonksiyonu
    function GUI:CreateTab(tabName)
        -- Tab butonu oluştur
        local TabButton = Instance.new("TextButton", TabContainer)
        TabButton.BorderSizePixel = 0
        TabButton.TextSize = 14
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        TabButton.AutomaticSize = Enum.AutomaticSize.X
        TabButton.Size = UDim2.new(0, 0, 1, 0)
        TabButton.Text = " " .. tabName .. " "
        TabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        local TabCorner = Instance.new("UICorner", TabButton)
        
        local TabPadding = Instance.new("UIPadding", TabButton)
        TabPadding.PaddingLeft = UDim.new(0, 10)
        TabPadding.PaddingRight = UDim.new(0, 10)
        
        -- Tab içerik frame'i oluştur
        local ContentFrame = Instance.new("Frame", ContentContainer)
        ContentFrame.BorderSizePixel = 0
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.Size = UDim2.new(1, 0, 1, 0)
        ContentFrame.Position = UDim2.new(0, 0, 0, 0)
        ContentFrame.Visible = false
        
        -- Auto Layout ekle
        local layout = Instance.new("UIListLayout", ContentFrame)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 6)
        
        -- Tab'ı kaydet
        Tabs[tabName] = {
            Button = TabButton,
            Frame = ContentFrame
        }
        
        -- İlk tab ise otomatik aç
        if CurrentTab == nil then
            CurrentTab = tabName
            ContentFrame.Visible = true
        end
        
        -- Tab değiştirme
        TabButton.MouseButton1Click:Connect(function()
            for name, tab in pairs(Tabs) do
                tab.Frame.Visible = (name == tabName) and UIOpen
            end
            CurrentTab = tabName
        end)
        
        return ContentFrame
    end
    
    -- Toggle Oluşturma Fonksiyonu
    function GUI:CreateToggle(toggleConfig)
        local tab = toggleConfig.Tab
        local text = toggleConfig.Text or "Toggle"
        local callback = toggleConfig.Callback or function() end
        local default = toggleConfig.Default or false
        
        if not Tabs[tab] then
            error("Tab '" .. tab .. "' bulunamadı! Önce tab oluşturun.")
        end
        
        local toggleData = {Value = default}
        
        -- Toggle Container
        local Container = Instance.new("Frame", Tabs[tab].Frame)
        Container.BorderSizePixel = 0
        Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Container.Size = UDim2.new(1, 0, 0, 36)
        Container.BackgroundTransparency = 0.05
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
        ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        
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
    
    return GUI
end

return Library
