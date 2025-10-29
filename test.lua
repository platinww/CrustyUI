-- Crusty HUB Library V1
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Library = {}

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Ana Frame (Arka Plan)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.Size = UDim2.new(0, 250, 0, 284)
    MainFrame.Position = UDim2.new(0, 274, 0, -30)
    MainFrame.BackgroundTransparency = 0.5
    
    local MainCorner = Instance.new("UICorner", MainFrame)
    
    -- Üst Frame (Header)
    local HeaderFrame = Instance.new("Frame", ScreenGui)
    HeaderFrame.BorderSizePixel = 0
    HeaderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HeaderFrame.Size = UDim2.new(0, 250, 0, 36)
    HeaderFrame.Position = UDim2.new(0, 274, 0, -30)
    HeaderFrame.BackgroundTransparency = 0.1
    
    local HeaderCorner = Instance.new("UICorner", HeaderFrame)
    
    -- Title Button
    local TitleButton = Instance.new("TextButton", ScreenGui)
    TitleButton.BorderSizePixel = 0
    TitleButton.TextXAlignment = Enum.TextXAlignment.Left
    TitleButton.TextSize = 15
    TitleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleButton.FontFace = Font.new([[rbxasset://fonts/families/Arimo.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TitleButton.ZIndex = 2
    TitleButton.BackgroundTransparency = 100
    TitleButton.Size = UDim2.new(0, 230, 0, 32)
    TitleButton.Text = title or "📂 Crusty HUB V1"
    TitleButton.Position = UDim2.new(0, 284, 0, -28)
    
    -- Sürükleme Sistemi
    local dragging = false
    local dragInput, mousePos, framePos
    
    TitleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - mousePos
            local targetPos = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
            
            MainFrame.Position = targetPos
            HeaderFrame.Position = targetPos
            TitleButton.Position = UDim2.new(targetPos.X.Scale, targetPos.X.Offset + 10, targetPos.Y.Scale, targetPos.Y.Offset + 2)
            
            -- Tab butonlarını da taşı
            for _, child in pairs(ScreenGui:GetChildren()) do
                if child.Name == "TabButton" then
                    local offset = child:GetAttribute("OffsetFromMain")
                    if offset then
                        child.Position = UDim2.new(targetPos.X.Scale, targetPos.X.Offset + offset.X, targetPos.Y.Scale, targetPos.Y.Offset + offset.Y)
                    end
                end
            end
        end
    end)
    
    local Window = {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        HeaderFrame = HeaderFrame,
        CurrentTab = nil,
        Tabs = {},
        TabButtons = {},
        TabYOffset = 12
    }
    
    return Window
end

function Library:AddTab(window, tabName, icon)
    local tabIcon = icon or "📂"
    local tabButton = Instance.new("TextButton", window.ScreenGui)
    tabButton.Name = "TabButton"
    tabButton.BorderSizePixel = 0
    tabButton.TextSize = 14
    tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.FontFace = Font.new([[rbxasset://fonts/families/Arimo.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    tabButton.ZIndex = 2
    tabButton.Size = UDim2.new(0, 74, 0, 26)
    tabButton.Text = tabIcon .. " " .. tabName
    tabButton.Position = UDim2.new(0, window.MainFrame.Position.X.Offset + 8, 0, window.TabYOffset)
    
    -- Pozisyon offset'ini kaydet
    tabButton:SetAttribute("OffsetFromMain", {X = 8, Y = window.TabYOffset})
    
    local tabCorner = Instance.new("UICorner", tabButton)
    
    -- Tab için içerik frame'i
    local contentFrame = Instance.new("Frame", window.ScreenGui)
    contentFrame.BorderSizePixel = 0
    contentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    contentFrame.Size = UDim2.new(0, 238, 0, 36)
    contentFrame.Position = UDim2.new(0, window.MainFrame.Position.X.Offset + 6, 0, 44)
    contentFrame.BackgroundTransparency = 0.1
    contentFrame.Visible = false
    
    local contentCorner = Instance.new("UICorner", contentFrame)
    
    local Tab = {
        Name = tabName,
        Button = tabButton,
        ContentFrame = contentFrame,
        Elements = {},
        ElementYOffset = 0
    }
    
    table.insert(window.Tabs, Tab)
    table.insert(window.TabButtons, tabButton)
    
    window.TabYOffset = window.TabYOffset + 80
    
    -- Tab değiştirme animasyonu
    tabButton.MouseButton1Click:Connect(function()
        -- Animasyon ile büyüt-küçült
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local shrink = TweenService:Create(tabButton, tweenInfo, {Size = UDim2.new(0, 70, 0, 24)})
        local grow = TweenService:Create(tabButton, tweenInfo, {Size = UDim2.new(0, 74, 0, 26)})
        
        shrink:Play()
        shrink.Completed:Wait()
        grow:Play()
        
        -- Tüm tab'ları gizle
        for _, tab in pairs(window.Tabs) do
            tab.ContentFrame.Visible = false
            tab.Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        end
        
        -- Seçili tab'ı göster
        contentFrame.Visible = true
        tabButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        window.CurrentTab = Tab
    end)
    
    -- İlk tab'ı otomatik seç
    if #window.Tabs == 1 then
        tabButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        contentFrame.Visible = true
        window.CurrentTab = Tab
    end
    
    return Tab
end

function Library:AddToggle(tab, text, default, callback)
    local isToggled = default or false
    
    -- Toggle Frame
    local toggleFrame = Instance.new("Frame", tab.ContentFrame)
    toggleFrame.Active = true
    toggleFrame.ZIndex = 3
    toggleFrame.BorderSizePixel = 0
    toggleFrame.BackgroundColor3 = isToggled and Color3.fromRGB(0, 139, 255) or Color3.fromRGB(100, 100, 100)
    toggleFrame.Size = UDim2.new(0, 44, 0, 20)
    toggleFrame.Position = UDim2.new(0, 190, 0, tab.ElementYOffset + 8)
    
    local toggleCorner = Instance.new("UICorner", toggleFrame)
    toggleCorner.CornerRadius = UDim.new(0, 30)
    
    -- Toggle İç Frame (Kaydırıcı)
    local toggleInner = Instance.new("Frame", toggleFrame)
    toggleInner.BorderSizePixel = 0
    toggleInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleInner.Size = UDim2.new(0, 18, 0, 16)
    toggleInner.Position = isToggled and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)
    
    local innerCorner = Instance.new("UICorner", toggleInner)
    innerCorner.CornerRadius = UDim.new(0, 50)
    
    -- Toggle Butonu
    local toggleButton = Instance.new("TextButton", tab.ContentFrame)
    toggleButton.BorderSizePixel = 0
    toggleButton.TextXAlignment = Enum.TextXAlignment.Left
    toggleButton.TextSize = 15
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.FontFace = Font.new([[rbxasset://fonts/families/Arimo.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    toggleButton.ZIndex = 2
    toggleButton.BackgroundTransparency = 100
    toggleButton.Size = UDim2.new(0, 180, 0, 32)
    toggleButton.Text = text
    toggleButton.Position = UDim2.new(0, 10, 0, tab.ElementYOffset)
    
    -- Toggle İşlevi
    local function toggle()
        isToggled = not isToggled
        
        -- Animasyonlu geçiş
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        local colorTween = TweenService:Create(toggleFrame, tweenInfo, {
            BackgroundColor3 = isToggled and Color3.fromRGB(0, 139, 255) or Color3.fromRGB(100, 100, 100)
        })
        
        local positionTween = TweenService:Create(toggleInner, tweenInfo, {
            Position = isToggled and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)
        })
        
        colorTween:Play()
        positionTween:Play()
        
        if callback then
            callback(isToggled)
        end
    end
    
    toggleButton.MouseButton1Click:Connect(toggle)
    toggleFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggle()
        end
    end)
    
    tab.ElementYOffset = tab.ElementYOffset + 42
    
    -- Eğer çok fazla element varsa yeni frame ekle
    if tab.ElementYOffset > 150 then
        local newFrame = Instance.new("Frame", tab.ContentFrame)
        newFrame.BorderSizePixel = 0
        newFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        newFrame.Size = UDim2.new(0, 238, 0, 36)
        newFrame.Position = UDim2.new(0, 0, 0, 42)
        newFrame.BackgroundTransparency = 0.1
        
        local newCorner = Instance.new("UICorner", newFrame)
        
        tab.ContentFrame = newFrame
        tab.ElementYOffset = 0
    end
    
    return {
        Toggle = toggle,
        SetState = function(state)
            if state ~= isToggled then
                toggle()
            end
        end
    }
end

function Library:AddButton(tab, text, callback)
    local button = Instance.new("TextButton", tab.ContentFrame)
    button.BorderSizePixel = 0
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.TextSize = 15
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.FontFace = Font.new([[rbxasset://fonts/families/Arimo.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    button.ZIndex = 2
    button.BackgroundTransparency = 100
    button.Size = UDim2.new(0, 230, 0, 32)
    button.Text = text
    button.Position = UDim2.new(0, 10, 0, tab.ElementYOffset)
    
    -- Hover efekti
    button.MouseEnter:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {BackgroundTransparency = 0.9})
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {BackgroundTransparency = 100})
        tween:Play()
    end)
    
    -- Tıklama animasyonu
    button.MouseButton1Click:Connect(function()
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local shrink = TweenService:Create(button, tweenInfo, {Size = UDim2.new(0, 225, 0, 30)})
        local grow = TweenService:Create(button, tweenInfo, {Size = UDim2.new(0, 230, 0, 32)})
        
        shrink:Play()
        shrink.Completed:Wait()
        grow:Play()
        
        if callback then
            callback()
        end
    end)
    
    tab.ElementYOffset = tab.ElementYOffset + 42
    
    return button
end

return Library
