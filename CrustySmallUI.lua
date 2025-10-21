-- Crusty Tools Library v5.0 (Original Design + Modern API)
local Library = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Sound System
local function PlaySound(soundId)
    task.spawn(function()
        pcall(function()
            local snd = Instance.new("Sound", workspace)
            snd.SoundId = soundId
            snd.Volume = 1
            snd:Play()
            task.wait(5)
            snd:Destroy()
        end)
    end)
end

-- Notification System
local NotificationSystem = {}
NotificationSystem.Notifications = {}
NotificationSystem.NotificationHeight = 60
NotificationSystem.NotificationSpacing = 10

function NotificationSystem:CreateNotification(title, message, duration)
    duration = duration or 5
    PlaySound("rbxassetid://103483400726411")
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.BorderSizePixel = 0
    NotifFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NotifFrame.Size = UDim2.new(0, 250, 0, self.NotificationHeight)
    NotifFrame.BackgroundTransparency = 0.25
    NotifFrame.AnchorPoint = Vector2.new(1, 0)
    
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 10)
    
    local AccentBar = Instance.new("Frame", NotifFrame)
    AccentBar.BorderSizePixel = 0
    AccentBar.BackgroundColor3 = Color3.fromRGB(77, 0, 0)
    AccentBar.Size = UDim2.new(0, 4, 1, 0)
    
    Instance.new("UICorner", AccentBar).CornerRadius = UDim.new(0, 10)
    
    local TitleLabel = Instance.new("TextLabel", NotifFrame)
    TitleLabel.BorderSizePixel = 0
    TitleLabel.TextSize = 14
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.Arcade
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Size = UDim2.new(1, -15, 0, 20)
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.Text = title
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextYAlignment = Enum.TextYAlignment.Top
    
    local MessageLabel = Instance.new("TextLabel", NotifFrame)
    MessageLabel.BorderSizePixel = 0
    MessageLabel.TextSize = 11
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Font = Enum.Font.Arcade
    MessageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    MessageLabel.Size = UDim2.new(1, -15, 1, -30)
    MessageLabel.Position = UDim2.new(0, 10, 0, 25)
    MessageLabel.Text = message
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
    MessageLabel.TextWrapped = true
    
    table.insert(self.Notifications, NotifFrame)
    self:UpdatePositions()
    
    NotifFrame.Position = UDim2.new(1, 20, 0, 0)
    TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -20, 0, 0)
    }):Play()
    
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
    for i, n in ipairs(self.Notifications) do
        if n == notif then
            table.remove(self.Notifications, i)
            break
        end
    end
    
    TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 20, notif.Position.Y.Scale, notif.Position.Y.Offset)
    }):Play()
    
    task.delay(0.3, function()
        notif:Destroy()
    end)
    
    self:UpdatePositions()
end

-- Create Main GUI
function Library:CreateWindow(config)
    config = config or {}
    local title = config.Title or "UI"
    local subtitle = config.Subtitle or ""
    local size = config.Size or UDim2.new(0, 168, 0, 236)
    
    PlaySound("rbxassetid://137759965542959")
    
    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Name = "CrustyToolsGUI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Notification Container
    local NotificationContainer = Instance.new("Frame", ScreenGui)
    NotificationContainer.Size = UDim2.new(0, 250, 1, 0)
    NotificationContainer.Position = UDim2.new(1, -270, 0, 20)
    NotificationContainer.BackgroundTransparency = 1
    NotificationSystem.Container = NotificationContainer
    
    -- Main Frame (Background) - ORIGINAL DESIGN
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.Size = size
    MainFrame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundTransparency = 0.25
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0, 10)
    
    -- Title Label
    local TitleLabel = Instance.new("TextLabel", MainFrame)
    TitleLabel.Name = "TitleLabel"
    TitleLabel.BorderSizePixel = 0
    TitleLabel.TextSize = 13
    TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.Arcade
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, 0, 0, 20)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.Text = title
    
    -- Subtitle (if provided)
    local subtitleOffset = 0
    if subtitle ~= "" then
        local SubtitleLabel = Instance.new("TextLabel", MainFrame)
        SubtitleLabel.BorderSizePixel = 0
        SubtitleLabel.TextSize = 10
        SubtitleLabel.BackgroundTransparency = 1
        SubtitleLabel.Font = Enum.Font.Arcade
        SubtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        SubtitleLabel.Size = UDim2.new(1, 0, 0, 15)
        SubtitleLabel.Position = UDim2.new(0, 0, 0, 20)
        SubtitleLabel.Text = subtitle
        subtitleOffset = 15
    end
    
    -- ScrollingFrame
    local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
    ScrollFrame.Name = "ScrollFrame"
    ScrollFrame.Size = UDim2.new(1, -20, 1, -(40 + subtitleOffset))
    ScrollFrame.Position = UDim2.new(0, 10, 0, 25 + subtitleOffset)
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
    
    function WindowObject:CreateToggle(config)
        config = config or {}
        local text = config.Text or "Toggle"
        local callback = config.Callback or function() end
        
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
        ToggleLabel.Font = Enum.Font.Arcade
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
            
            callback(toggleState)
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
    
    function WindowObject:CreateButton(config)
        config = config or {}
        local text = config.Text or "Button"
        local callback = config.Callback or function() end
        
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
        ButtonLabel.Font = Enum.Font.Arcade
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
            
            task.wait(0.1)
            
            TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(77, 0, 0)
            }):Play()
            
            callback()
        end)
        
        return {Frame = ButtonFrame}
    end
    
    function WindowObject:CreateLabel(config)
        config = config or {}
        local text = config.Text or "Label"
        
        local LabelFrame = Instance.new("Frame", ScrollFrame)
        LabelFrame.BorderSizePixel = 0
        LabelFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        LabelFrame.Size = UDim2.new(1, 0, 0, 30)
        LabelFrame.BackgroundTransparency = 0.5
        
        Instance.new("UICorner", LabelFrame)
        
        local Label = Instance.new("TextLabel", LabelFrame)
        Label.BorderSizePixel = 0
        Label.TextSize = 12
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.Arcade
        Label.TextColor3 = Color3.fromRGB(200, 200, 200)
        Label.Size = UDim2.new(1, -10, 1, 0)
        Label.Position = UDim2.new(0, 5, 0, 0)
        Label.Text = text
        Label.TextXAlignment = Enum.TextXAlignment.Left
        
        return {
            Frame = LabelFrame,
            SetText = function(newText)
                Label.Text = newText
            end
        }
    end
    
    function WindowObject:Destroy()
        ScreenGui:Destroy()
    end
    
    return WindowObject
end

return Library
