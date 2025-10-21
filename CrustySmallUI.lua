-- Crusty Tools Library v2.0 (Bildirim Sistemi Ekli)
local Library = {}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Notification System
local NotificationSystem = {}
NotificationSystem.Notifications = {}
NotificationSystem.NotificationHeight = 60
NotificationSystem.NotificationSpacing = 10

function NotificationSystem:CreateNotification(title, message, duration)
    duration = duration or 5
    
    -- Play notification sound
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://103483400726411"
    sound.Volume = 0.5
    sound.Parent = game:GetService("SoundService")
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 3)
    
    -- Create notification frame
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Name = "Notification"
    NotifFrame.BorderSizePixel = 0
    NotifFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NotifFrame.Size = UDim2.new(0, 250, 0, self.NotificationHeight)
    NotifFrame.BackgroundTransparency = 0.25
    NotifFrame.AnchorPoint = Vector2.new(1, 0)
    
    local NotifCorner = Instance.new("UICorner", NotifFrame)
    NotifCorner.CornerRadius = UDim.new(0, 10)
    
    -- Accent bar (left side)
    local AccentBar = Instance.new("Frame", NotifFrame)
    AccentBar.Name = "AccentBar"
    AccentBar.BorderSizePixel = 0
    AccentBar.BackgroundColor3 = Color3.fromRGB(77, 0, 0)
    AccentBar.Size = UDim2.new(0, 4, 1, 0)
    AccentBar.Position = UDim2.new(0, 0, 0, 0)
    
    local AccentCorner = Instance.new("UICorner", AccentBar)
    AccentCorner.CornerRadius = UDim.new(0, 10)
    
    -- Title
    local TitleLabel = Instance.new("TextLabel", NotifFrame)
    TitleLabel.Name = "Title"
    TitleLabel.BorderSizePixel = 0
    TitleLabel.TextSize = 14
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.FontFace = Font.new("rbxasset://fonts/families/Arcade.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Size = UDim2.new(1, -15, 0, 20)
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.Text = title
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextYAlignment = Enum.TextYAlignment.Top
    
    -- Message
    local MessageLabel = Instance.new("TextLabel", NotifFrame)
    MessageLabel.Name = "Message"
    MessageLabel.BorderSizePixel = 0
    MessageLabel.TextSize = 11
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.FontFace = Font.new("rbxasset://fonts/families/Arcade.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    MessageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    MessageLabel.Size = UDim2.new(1, -15, 1, -30)
    MessageLabel.Position = UDim2.new(0, 10, 0, 25)
    MessageLabel.Text = message
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
    MessageLabel.TextWrapped = true
    
    -- Add to notifications table
    table.insert(self.Notifications, NotifFrame)
    
    -- Update positions
    self:UpdatePositions()
    
    -- Slide in animation
    NotifFrame.Position = UDim2.new(1, 20, 0, 0)
    TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -20, 0, 0)
    }):Play()
    
    -- Auto remove after duration
    task.delay(duration, function()
        self:RemoveNotification(NotifFrame)
    end)
    
    return NotifFrame
end

function NotificationSystem:UpdatePositions()
    for i, notif in ipairs(self.Notifications) do
        local targetY = (i - 1) * (self.NotificationHeight + self.NotificationSpacing)
        TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(notif.Position.X.Scale, notif.Position.X.Offset, 0, targetY)
        }):Play()
    end
end

function NotificationSystem:RemoveNotification(notif)
    -- Find and remove from table
    for i, n in ipairs(self.Notifications) do
        if n == notif then
            table.remove(self.Notifications, i)
            break
        end
    end
    
    -- Slide out animation
    TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 20, notif.Position.Y.Scale, notif.Position.Y.Offset)
    }):Play()
    
    -- Destroy after animation
    task.delay(0.3, function()
        notif:Destroy()
    end)
    
    -- Update remaining notifications
    self:UpdatePositions()
end

-- Create Main GUI
function Library:CreateWindow()
    -- Play UI load sound
    local loadSound = Instance.new("Sound")
    loadSound.SoundId = "rbxassetid://137759965542959"
    loadSound.Volume = 0.5
    loadSound.Parent = game:GetService("SoundService")
    loadSound:Play()
    game:GetService("Debris"):AddItem(loadSound, 3)
    
    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Name = "CrustyToolsGUI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Notification Container
    local NotificationContainer = Instance.new("Frame", ScreenGui)
    NotificationContainer.Name = "NotificationContainer"
    NotificationContainer.Size = UDim2.new(0, 250, 1, 0)
    NotificationContainer.Position = UDim2.new(1, -270, 0, 20)
    NotificationContainer.BackgroundTransparency = 1
    
    -- Update notification system parent
    NotificationSystem.Container = NotificationContainer
    for _, notif in ipairs(NotificationSystem.Notifications) do
        notif.Parent = NotificationContainer
    end
    
    -- Main Frame (Background)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.Size = UDim2.new(0, 168, 0, 236)
    MainFrame.Position = UDim2.new(0, 298, 0, -16)
    MainFrame.BackgroundTransparency = 0.25
    MainFrame.ClipsDescendants = true
    
    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0, 10)
    
    -- Title Label
    local TitleLabel = Instance.new("TextLabel", MainFrame)
    TitleLabel.Name = "TitleLabel"
    TitleLabel.BorderSizePixel = 0
    TitleLabel.TextSize = 13
    TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.FontFace = Font.new("rbxasset://fonts/families/Arcade.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.Text = "CRUSTY TOOLS"
    
    -- ScrollingFrame
    local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
    ScrollFrame.Name = "ScrollFrame"
    ScrollFrame.Size = UDim2.new(1, -20, 1, -40)
    ScrollFrame.Position = UDim2.new(0, 10, 0, 35)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 4
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.ClipsDescendants = true
    
    local UIListLayout = Instance.new("UIListLayout", ScrollFrame)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    
    -- Update CanvasSize when content changes
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    end)
    
    -- Dragging functionality
    local dragging = false
    local dragInput, mousePos, framePos
    
    MainFrame.InputBegan:Connect(function(input)
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
    
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            MainFrame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
    
    local WindowObject = {}
    WindowObject.ScreenGui = ScreenGui
    WindowObject.MainFrame = MainFrame
    WindowObject.ScrollFrame = ScrollFrame
    WindowObject.NotificationContainer = NotificationContainer
    
    function WindowObject:Notify(title, message, duration)
        local notif = NotificationSystem:CreateNotification(title, message, duration)
        notif.Parent = self.NotificationContainer
        return notif
    end
    
    function WindowObject:AddToggle(text, callback)
        local ToggleFrame = Instance.new("Frame", ScrollFrame)
        ToggleFrame.Name = "Toggle_" .. text
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(77, 0, 0)
        ToggleFrame.Size = UDim2.new(1, 0, 0, 34)
        ToggleFrame.BackgroundTransparency = 0.2
        
        local ToggleCorner = Instance.new("UICorner", ToggleFrame)
        
        local ToggleLabel = Instance.new("TextLabel", ToggleFrame)
        ToggleLabel.Name = "Label"
        ToggleLabel.BorderSizePixel = 0
        ToggleLabel.TextSize = 13
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.FontFace = Font.new("rbxasset://fonts/families/Arcade.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleLabel.Size = UDim2.new(1, 0, 1, 0)
        ToggleLabel.Text = text
        
        local toggleState = false
        
        local ToggleButton = Instance.new("TextButton", ToggleFrame)
        ToggleButton.Name = "Button"
        ToggleButton.Size = UDim2.new(1, 0, 1, 0)
        ToggleButton.BackgroundTransparency = 1
        ToggleButton.Text = ""
        
        ToggleButton.MouseButton1Click:Connect(function()
            toggleState = not toggleState
            
            if toggleState then
                TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                }):Play()
            else
                TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(77, 0, 0)
                }):Play()
            end
            
            if callback then
                callback(toggleState)
            end
        end)
        
        return {
            Frame = ToggleFrame,
            State = function() return toggleState end,
            SetState = function(state)
                toggleState = state
                if state then
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                else
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(77, 0, 0)
                end
            end
        }
    end
    
    function WindowObject:AddButton(text, callback)
        local ButtonFrame = Instance.new("Frame", ScrollFrame)
        ButtonFrame.Name = "Button_" .. text
        ButtonFrame.BorderSizePixel = 0
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(77, 0, 0)
        ButtonFrame.Size = UDim2.new(1, 0, 0, 34)
        ButtonFrame.BackgroundTransparency = 0.2
        
        local ButtonCorner = Instance.new("UICorner", ButtonFrame)
        
        local ButtonLabel = Instance.new("TextLabel", ButtonFrame)
        ButtonLabel.Name = "Label"
        ButtonLabel.BorderSizePixel = 0
        ButtonLabel.TextSize = 13
        ButtonLabel.BackgroundTransparency = 1
        ButtonLabel.FontFace = Font.new("rbxasset://fonts/families/Arcade.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        ButtonLabel.Size = UDim2.new(1, 0, 1, 0)
        ButtonLabel.Text = text
        
        local Button = Instance.new("TextButton", ButtonFrame)
        Button.Name = "Button"
        Button.Size = UDim2.new(1, 0, 1, 0)
        Button.BackgroundTransparency = 1
        Button.Text = ""
        
        Button.MouseButton1Click:Connect(function()
            TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(100, 0, 0)
            }):Play()
            
            wait(0.1)
            
            TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(77, 0, 0)
            }):Play()
            
            if callback then
                callback()
            end
        end)
        
        return {Frame = ButtonFrame}
    end
    
    function WindowObject:Destroy()
        ScreenGui:Destroy()
    end
    return WindowObject
end

return Library
