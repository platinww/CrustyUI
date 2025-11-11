-- Nameless Hub UI Library
local Library = {}

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Main Frame
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0, 170, 0, -14)
    
    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0, 10)
    
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 3.2
    MainStroke.Color = Color3.fromRGB(138, 43, 226)
    
    local StrokeGradient = Instance.new("UIGradient", MainStroke)
    StrokeGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 147))
    }
    StrokeGradient.Rotation = 90
    
    -- Top Gradient Bar
    local TopBar = Instance.new("Frame", ScreenGui)
    TopBar.BorderSizePixel = 0
    TopBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    TopBar.Size = UDim2.new(0, 376, 0, 4)
    TopBar.Position = UDim2.new(0, 182, 0, 28)
    
    local TopGradient = Instance.new("UIGradient", TopBar)
    TopGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 147))
    }
    TopGradient.Rotation = 0
    
    -- Left Gradient Bar
    local LeftBar = Instance.new("Frame", ScreenGui)
    LeftBar.BorderSizePixel = 0
    LeftBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    LeftBar.Size = UDim2.new(0, 4, 0, 234)
    LeftBar.Position = UDim2.new(0, 290, 0, 42)
    
    local LeftGradient = Instance.new("UIGradient", LeftBar)
    LeftGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 147))
    }
    LeftGradient.Rotation = 90
    
    -- Content Background
    local ContentBg = Instance.new("Frame", ScreenGui)
    ContentBg.BorderSizePixel = 0
    ContentBg.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    ContentBg.Size = UDim2.new(0, 264, 0, 232)
    ContentBg.Position = UDim2.new(0, 298, 0, 42)
    
    local ContentCorner = Instance.new("UICorner", ContentBg)
    
    -- Title Button
    local TitleButton = Instance.new("TextButton", ScreenGui)
    TitleButton.BorderSizePixel = 0
    TitleButton.TextSize = 20
    TitleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleButton.BackgroundColor3 = Color3.fromRGB(73, 73, 73)
    TitleButton.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TitleButton.BackgroundTransparency = 1
    TitleButton.Size = UDim2.new(0, 148, 0, 34)
    TitleButton.Text = title or "Nameless Hub"
    TitleButton.Position = UDim2.new(0, 296, 0, -10)
    
    -- Close Button
    local CloseButton = Instance.new("TextButton", ScreenGui)
    CloseButton.BorderSizePixel = 0
    CloseButton.TextSize = 18
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundColor3 = Color3.fromRGB(41, 45, 59)
    CloseButton.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    CloseButton.Size = UDim2.new(0, 30, 0, 28)
    CloseButton.Text = "X"
    CloseButton.Position = UDim2.new(0, 530, 0, -8)
    
    local CloseCorner = Instance.new("UICorner", CloseButton)
    CloseCorner.CornerRadius = UDim.new(0, 7)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Toggle Button (Mini Icon)
    local ToggleButton = Instance.new("TextButton", ScreenGui)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.TextSize = 18
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleButton.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    ToggleButton.ZIndex = 3
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Text = "NH"
    ToggleButton.Position = UDim2.new(0, 10, 0, 10)
    
    local ToggleCorner = Instance.new("UICorner", ToggleButton)
    ToggleCorner.CornerRadius = UDim.new(0, 12)
    
    local ToggleBorder = Instance.new("Frame", ScreenGui)
    ToggleBorder.BorderSizePixel = 0
    ToggleBorder.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    ToggleBorder.Size = UDim2.new(0, 58, 0, 58)
    ToggleBorder.Position = UDim2.new(0, 6, 0, 6)
    
    local ToggleBorderGradient = Instance.new("UIGradient", ToggleBorder)
    ToggleBorderGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 147))
    }
    ToggleBorderGradient.Rotation = 45
    
    local ToggleBorderCorner = Instance.new("UICorner", ToggleBorder)
    ToggleBorderCorner.CornerRadius = UDim.new(0, 15)
    
    local MinimizeButton = Instance.new("TextButton", ScreenGui)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.TextSize = 18
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(41, 45, 59)
    MinimizeButton.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    MinimizeButton.Size = UDim2.new(0, 30, 0, 28)
    MinimizeButton.Text = "<"
    MinimizeButton.Position = UDim2.new(0, 180, 0, -8)
    
    local MinimizeCorner = Instance.new("UICorner", MinimizeButton)
    MinimizeCorner.CornerRadius = UDim.new(0, 7)
    
    local isVisible = true
    local function toggleUI()
        isVisible = not isVisible
        MainFrame.Visible = isVisible
        TopBar.Visible = isVisible
        LeftBar.Visible = isVisible
        ContentBg.Visible = isVisible
        TitleButton.Visible = isVisible
        CloseButton.Visible = isVisible
        MinimizeButton.Visible = isVisible
        for _, tab in pairs(ScreenGui:GetChildren()) do
            if tab:IsA("TextButton") and tab.Name:match("^Tab_") then
                tab.Visible = isVisible
            end
        end
    end
    
    ToggleButton.MouseButton1Click:Connect(toggleUI)
    MinimizeButton.MouseButton1Click:Connect(toggleUI)
    
    -- Dragging
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TopBar.Position = UDim2.new(0, 182 + delta.X, 0, 28 + delta.Y)
        LeftBar.Position = UDim2.new(0, 290 + delta.X, 0, 42 + delta.Y)
        ContentBg.Position = UDim2.new(0, 298 + delta.X, 0, 42 + delta.Y)
        TitleButton.Position = UDim2.new(0, 296 + delta.X, 0, -10 + delta.Y)
        CloseButton.Position = UDim2.new(0, 530 + delta.X, 0, -8 + delta.Y)
        MinimizeButton.Position = UDim2.new(0, 180 + delta.X, 0, -8 + delta.Y)
    end
    
    TitleButton.InputBegan:Connect(function(input)
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
    
    TitleButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil
    
    function Window:CreateTab(name)
        local tabIndex = #self.Tabs + 1
        local yPos = 42 + (tabIndex - 1) * 44
        
        -- Tab Button
        local TabButton = Instance.new("TextButton", ScreenGui)
        TabButton.Name = "Tab_" .. name
        TabButton.BorderSizePixel = 0
        TabButton.TextSize = 12
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundColor3 = tabIndex == 1 and Color3.fromRGB(82, 48, 117) or Color3.fromRGB(55, 53, 69)
        TabButton.FontFace = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        TabButton.Size = UDim2.new(0, 108, 0, 34)
        TabButton.Text = name
        TabButton.Position = UDim2.new(0, 176, 0, yPos)
        
        local TabCorner = Instance.new("UICorner", TabButton)
        TabCorner.CornerRadius = UDim.new(0, 6)
        
        -- Tab Content Frame
        local TabContent = Instance.new("Frame", ScreenGui)
        TabContent.Name = "TabContent_" .. name
        TabContent.ZIndex = 2
        TabContent.BorderSizePixel = 0
        TabContent.BackgroundColor3 = Color3.fromRGB(45, 47, 62)
        TabContent.Size = UDim2.new(0, 244, 0, 34)
        TabContent.Position = UDim2.new(0, 308, 0, yPos + 10)
        TabContent.Visible = tabIndex == 1
        
        local TabContentCorner = Instance.new("UICorner", TabContent)
        TabContentCorner.CornerRadius = UDim.new(0, 7)
        
        local Tab = {}
        Tab.Name = name
        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.Elements = {}
        Tab.ElementCount = 0
        
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(self.Tabs) do
                tab.Button.BackgroundColor3 = Color3.fromRGB(55, 53, 69)
                tab.Content.Visible = false
            end
            TabButton.BackgroundColor3 = Color3.fromRGB(82, 48, 117)
            TabContent.Visible = true
            self.CurrentTab = Tab
        end)
        
        function Tab:AddToggle(text, default, callback)
            local elementIndex = self.ElementCount
            local yOffset = elementIndex * 46
            
            -- Adjust content frame size
            self.Content.Size = UDim2.new(0, 244, 0, 34 + yOffset)
            
            -- Label
            local Label = Instance.new("TextLabel", ScreenGui)
            Label.Name = "Label_" .. text
            Label.ZIndex = 2
            Label.BorderSizePixel = 0
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextColor3 = Color3.fromRGB(203, 203, 203)
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(0, 174, 0, 30)
            Label.Text = text
            Label.Position = UDim2.new(0, 320, 0, self.Content.Position.Y.Offset + 2 + yOffset)
            
            -- Toggle Frame
            local ToggleOuter = Instance.new("Frame", ScreenGui)
            ToggleOuter.Name = "Toggle_" .. text
            ToggleOuter.ZIndex = 3
            ToggleOuter.BorderSizePixel = 0
            ToggleOuter.BackgroundColor3 = default and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(87, 87, 87)
            ToggleOuter.Size = UDim2.new(0, 38, 0, 20)
            ToggleOuter.Position = UDim2.new(0, 504, 0, self.Content.Position.Y.Offset + 7 + yOffset)
            
            local ToggleOuterCorner = Instance.new("UICorner", ToggleOuter)
            ToggleOuterCorner.CornerRadius = UDim.new(100, 0)
            
            local ToggleInner = Instance.new("Frame", ToggleOuter)
            ToggleInner.BorderSizePixel = 0
            ToggleInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleInner.Size = UDim2.new(0, 16, 0, 16)
            ToggleInner.Position = default and UDim2.new(0, 20, 0, 2) or UDim2.new(0, 2, 0, 2)
            
            local ToggleInnerCorner = Instance.new("UICorner", ToggleInner)
            ToggleInnerCorner.CornerRadius = UDim.new(100, 0)
            
            local toggled = default or false
            
            local ToggleButton = Instance.new("TextButton", ScreenGui)
            ToggleButton.Name = "ToggleBtn_" .. text
            ToggleButton.ZIndex = 4
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Size = UDim2.new(0, 38, 0, 20)
            ToggleButton.Position = ToggleOuter.Position
            ToggleButton.Text = ""
            
            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                ToggleOuter.BackgroundColor3 = toggled and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(87, 87, 87)
                ToggleInner.Position = toggled and UDim2.new(0, 20, 0, 2) or UDim2.new(0, 2, 0, 2)
                if callback then
                    callback(toggled)
                end
            end)
            
            self.ElementCount = self.ElementCount + 1
            table.insert(self.Elements, {Label = Label, Toggle = ToggleOuter, Button = ToggleButton})
            
            return {
                SetValue = function(value)
                    toggled = value
                    ToggleOuter.BackgroundColor3 = toggled and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(87, 87, 87)
                    ToggleInner.Position = toggled and UDim2.new(0, 20, 0, 2) or UDim2.new(0, 2, 0, 2)
                end
            }
        end
        
        table.insert(self.Tabs, Tab)
        if tabIndex == 1 then
            self.CurrentTab = Tab
        end
        
        return Tab
    end
    
    return Window
end

return Library
