local CrustyLib = {}
CrustyLib.__index = CrustyLib
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Icons = {}
local IconsLoaded = false
local function LoadIcons()
    if IconsLoaded then return end
    local success, result = pcall(function()
        local response = HttpService:GetAsync("https://raw.githubusercontent.com/platinww/CrustyUI/refs/heads/main/icons.json")
        local iconData = HttpService:JSONDecode(response)
        for iconName, iconId in pairs(iconData) do
            Icons[iconName] = iconId
        end
        IconsLoaded = true
        print("🎯 CrustyLib: Successfully loaded", #iconData, "dynamic icons!")
        return true
    end)
    if not success then
        warn("🚨 CrustyLib: Failed to load dynamic icons, using fallback icons")
        Icons = {
            home = "rbxassetid://10734884979",
            settings = "rbxassetid://10734886006",
            user = "rbxassetid://10734893696",
            search = "rbxassetid://10734896301",
            heart = "rbxassetid://10734898092",
            star = "rbxassetid://10734899534",
            shield = "rbxassetid://10734901537",
            lock = "rbxassetid://10734903034",
            unlock = "rbxassetid://10734904467",
            eye = "rbxassetid://10734905914",
            eyeoff = "rbxassetid://10734907111",
            bell = "rbxassetid://10734908499",
            mail = "rbxassetid://10734910001",
            phone = "rbxassetid://10734911751",
            camera = "rbxassetid://10734913388",
            image = "rbxassetid://10734914595",
            file = "rbxassetid://10734916044",
            folder = "rbxassetid://10734917540",
            download = "rbxassetid://10734919412",
            upload = "rbxassetid://10734921500",
            play = "rbxassetid://10734922835",
            pause = "rbxassetid://10734924532",
            stop = "rbxassetid://10734926207",
            volume = "rbxassetid://10734927992",
            check = "rbxassetid://10734959674",
            x = "rbxassetid://10734961224",
            plus = "rbxassetid://10734962774",
            minus = "rbxassetid://10734964324",
            edit = "rbxassetid://10734965874",
            trash = "rbxassetid://10734967424",
            zap = "rbxassetid://10734978274"
        }
        IconsLoaded = true
    end
end
LoadIcons()
local function getIcon(name)
    return Icons[name] or Icons.home or "rbxassetid://10734884979"
end
local Themes = {
    Dark = {
        Name = "Dark",
        Primary = Color3.fromRGB(13, 13, 13),
        Secondary = Color3.fromRGB(20, 20, 20),
        Tertiary = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(138, 43, 226),
        AccentHover = Color3.fromRGB(148, 53, 236),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(239, 68, 68),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(200, 200, 200),
        TextDim = Color3.fromRGB(160, 160, 160),
        Border = Color3.fromRGB(45, 45, 45),
        Glow = Color3.fromRGB(138, 43, 226),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Blue = {
        Name = "Ocean Blue",
        Primary = Color3.fromRGB(8, 17, 32),
        Secondary = Color3.fromRGB(15, 28, 48),
        Tertiary = Color3.fromRGB(25, 45, 75),
        Accent = Color3.fromRGB(59, 130, 246),
        AccentHover = Color3.fromRGB(79, 150, 255),
        Success = Color3.fromRGB(16, 185, 129),
        Warning = Color3.fromRGB(245, 158, 11),
        Error = Color3.fromRGB(239, 68, 68),
        Text = Color3.fromRGB(248, 250, 252),
        TextSecondary = Color3.fromRGB(226, 232, 240),
        TextDim = Color3.fromRGB(148, 163, 184),
        Border = Color3.fromRGB(30, 58, 138),
        Glow = Color3.fromRGB(59, 130, 246),
        Shadow = Color3.fromRGB(0, 0, 15)
    },
    White = {
        Name = "Pure White",
        Primary = Color3.fromRGB(255, 255, 255),
        Secondary = Color3.fromRGB(249, 250, 251),
        Tertiary = Color3.fromRGB(243, 244, 246),
        Accent = Color3.fromRGB(99, 102, 241),
        AccentHover = Color3.fromRGB(119, 122, 255),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(239, 68, 68),
        Text = Color3.fromRGB(17, 24, 39),
        TextSecondary = Color3.fromRGB(55, 65, 81),
        TextDim = Color3.fromRGB(107, 114, 128),
        Border = Color3.fromRGB(229, 231, 235),
        Glow = Color3.fromRGB(99, 102, 241),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Neon = {
        Name = "Cyber Neon",
        Primary = Color3.fromRGB(5, 5, 15),
        Secondary = Color3.fromRGB(10, 10, 25),
        Tertiary = Color3.fromRGB(20, 20, 35),
        Accent = Color3.fromRGB(0, 255, 157),
        AccentHover = Color3.fromRGB(50, 255, 180),
        Success = Color3.fromRGB(0, 255, 157),
        Warning = Color3.fromRGB(255, 193, 7),
        Error = Color3.fromRGB(255, 20, 147),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(220, 255, 240),
        TextDim = Color3.fromRGB(180, 255, 220),
        Border = Color3.fromRGB(0, 255, 157),
        Glow = Color3.fromRGB(0, 255, 157),
        Shadow = Color3.fromRGB(0, 50, 30)
    },
    Purple = {
        Name = "Royal Purple",
        Primary = Color3.fromRGB(16, 7, 30),
        Secondary = Color3.fromRGB(25, 15, 45),
        Tertiary = Color3.fromRGB(40, 25, 65),
        Accent = Color3.fromRGB(147, 51, 234),
        AccentHover = Color3.fromRGB(167, 71, 254),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(239, 68, 68),
        Text = Color3.fromRGB(250, 245, 255),
        TextSecondary = Color3.fromRGB(230, 220, 240),
        TextDim = Color3.fromRGB(190, 180, 210),
        Border = Color3.fromRGB(88, 28, 135),
        Glow = Color3.fromRGB(147, 51, 234),
        Shadow = Color3.fromRGB(20, 0, 40)
    }
}
local Sounds = {
    Click = "6518811702",
    Hover = "12221967",
    Success = "6518811702",
    Error = "131961136",
    Notification = "9118137008",
    Switch = "10734903034",
    KeyValid = "3398620867",
    KeyInvalid = "2865228021",
    KeyType = "8283001240"
}
local function playSound(soundId, volume, pitch)
    if not soundId then return end
    spawn(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. soundId
        sound.Volume = volume or 0.2
        sound.PlaybackSpeed = pitch or 1
        sound.Parent = SoundService
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
end
local function createRippleEffect(obj, x, y)
    local ripple = Instance.new("Frame")
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0, x, 0, y)
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.8
    ripple.BorderSizePixel = 0
    ripple.ZIndex = obj.ZIndex + 1
    ripple.Parent = obj
    local rippleCorner = Instance.new("UICorner")
    rippleCorner.CornerRadius = UDim.new(1, 0)
    rippleCorner.Parent = ripple
    TweenService:Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 200, 0, 200),
        Position = UDim2.new(0, x - 100, 0, y - 100),
        BackgroundTransparency = 1
    }):Play()
    spawn(function()
        task.wait(0.5)
        ripple:Destroy()
    end)
end
local function createGlowEffect(obj, color, intensity)
    local glow = Instance.new("ImageLabel")
    glow.Name = "GlowEffect"
    glow.Size = UDim2.new(1, 40, 1, 40)
    glow.Position = UDim2.new(0, -20, 0, -20)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://4996891970"
    glow.ImageColor3 = color or Color3.fromRGB(138, 43, 226)
    glow.ImageTransparency = intensity or 0.7
    glow.ZIndex = obj.ZIndex - 1
    glow.Parent = obj.Parent
    return glow
end
local function createParticleExplosion(obj, color)
    spawn(function()
        for i = 1, 12 do
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
            particle.Position = UDim2.new(0.5, math.random(-10, 10), 0.5, math.random(-10, 10))
            particle.BackgroundColor3 = color or Color3.fromHSV(math.random(), 1, 1)
            particle.BorderSizePixel = 0
            particle.ZIndex = obj.ZIndex + 2
            particle.Parent = obj
            local particleCorner = Instance.new("UICorner")
            particleCorner.CornerRadius = UDim.new(1, 0)
            particleCorner.Parent = particle
            local angle = math.rad(i * (360 / 12))
            local distance = math.random(60, 120)
            TweenService:Create(particle, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, math.cos(angle) * distance, 0.5, math.sin(angle) * distance),
                BackgroundTransparency = 1
            }):Play()
            spawn(function()
                task.wait(0.8)
                particle:Destroy()
            end)
        end
    end)
end
local function createFloatingParticles(container, color, count)
    spawn(function()
        for i = 1, count or 15 do
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
            particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
            particle.BackgroundColor3 = color or Color3.fromRGB(255, 255, 255)
            particle.BackgroundTransparency = math.random(50, 80) / 100
            particle.BorderSizePixel = 0
            particle.ZIndex = 1
            particle.Parent = container
            local particleCorner = Instance.new("UICorner")
            particleCorner.CornerRadius = UDim.new(1, 0)
            particleCorner.Parent = particle
            local function animateParticle()
                while particle.Parent do
                    local randomX = math.random(-50, 50)
                    local randomY = math.random(-30, 30)
                    local duration = math.random(30, 60) / 10
                    TweenService:Create(particle, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Position = UDim2.new(particle.Position.X.Scale, randomX, particle.Position.Y.Scale, randomY),
                        BackgroundTransparency = math.random(30, 90) / 100
                    }):Play()
                    task.wait(duration)
                end
            end
            spawn(animateParticle)
        end
    end)
end
local function createRGBCycle(obj, property)
    spawn(function()
        local hue = 0
        while obj and obj.Parent do
            hue = (hue + 2) % 360
            obj[property] = Color3.fromHSV(hue / 360, 1, 1)
            task.wait(0.05)
        end
    end)
end
local KeySystem = {}
KeySystem.__index = KeySystem
function KeySystem:Create(config)
    local self = setmetatable({}, KeySystem)
    self.config = config or {}
    self.key = self.config.Key or ""
    self.title = self.config.KeyTitle or "🔑 Key Authentication"
    self.description = self.config.KeyDescription or "Enter your premium access key to continue"
    self.theme = Themes[self.config.Theme or "Purple"]
    self.onSuccess = self.config.OnSuccess or function() end
    self.onFail = self.config.OnFail or function() end
    self:CreateKeyWindow()
    return self
end
function KeySystem:CreateKeyWindow()
    local keyScreenGui = Instance.new("ScreenGui")
    keyScreenGui.Name = "CrustyKeySystem_" .. tick()
    keyScreenGui.ResetOnSpawn = false
    keyScreenGui.Parent = playerGui
    keyScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.2
    background.BorderSizePixel = 0
    background.Parent = keyScreenGui
    createFloatingParticles(background, self.theme.Accent, 25)
    local keyContainer = Instance.new("Frame")
    keyContainer.Size = UDim2.new(0, 450, 0, 320)
    keyContainer.Position = UDim2.new(0.5, -225, 0.5, -160)
    keyContainer.BackgroundColor3 = self.theme.Primary
    keyContainer.BorderSizePixel = 0
    keyContainer.Parent = background
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 20)
    containerCorner.Parent = keyContainer
    local containerBorder = Instance.new("UIStroke")
    containerBorder.Color = self.theme.Accent
    containerBorder.Thickness = 2
    containerBorder.Transparency = 0.3
    containerBorder.Parent = keyContainer
    local glow = createGlowEffect(keyContainer, self.theme.Accent, 0.6)
    createRGBCycle(glow, "ImageColor3")
    local headerContainer = Instance.new("Frame")
    headerContainer.Size = UDim2.new(1, 0, 0, 80)
    headerContainer.Position = UDim2.new(0, 0, 0, 0)
    headerContainer.BackgroundColor3 = self.theme.Secondary
    headerContainer.BackgroundTransparency = 0.2
    headerContainer.BorderSizePixel = 0
    headerContainer.Parent = keyContainer
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 20)
    headerCorner.Parent = headerContainer
    local lockIcon = Instance.new("ImageLabel")
    lockIcon.Size = UDim2.new(0, 40, 0, 40)
    lockIcon.Position = UDim2.new(0, 30, 0.5, -20)
    lockIcon.BackgroundTransparency = 1
    lockIcon.Image = getIcon("lock")
    lockIcon.ImageColor3 = self.theme.Accent
    lockIcon.Parent = headerContainer
    spawn(function()
        while lockIcon.Parent do
            TweenService:Create(lockIcon, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
                Size = UDim2.new(0, 45, 0, 45),
                Position = UDim2.new(0, 27.5, 0.5, -22.5),
                ImageTransparency = 0.3
            }):Play()
            task.wait(1.5)
            TweenService:Create(lockIcon, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
                Size = UDim2.new(0, 40, 0, 40),
                Position = UDim2.new(0, 30, 0.5, -20),
                ImageTransparency = 0
            }):Play()
            task.wait(1.5)
        end
    end)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -80, 0, 35)
    titleLabel.Position = UDim2.new(0, 80, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.title
    titleLabel.TextColor3 = self.theme.Text
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = headerContainer
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -80, 0, 25)
    descLabel.Position = UDim2.new(0, 80, 0, 45)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = self.description
    descLabel.TextColor3 = self.theme.TextDim
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 12
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextWrapped = true
    descLabel.Parent = headerContainer
    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -40, 1, -120)
    contentArea.Position = UDim2.new(0, 20, 0, 90)
    contentArea.BackgroundTransparency = 1
    contentArea.Parent = keyContainer
    local inputContainer = Instance.new("Frame")
    inputContainer.Size = UDim2.new(1, 0, 0, 60)
    inputContainer.Position = UDim2.new(0, 0, 0, 20)
    inputContainer.BackgroundColor3 = self.theme.Secondary
    inputContainer.BackgroundTransparency = 0.3
    inputContainer.BorderSizePixel = 0
    inputContainer.Parent = contentArea
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 12)
    inputCorner.Parent = inputContainer
    local inputBorder = Instance.new("UIStroke")
    inputBorder.Color = self.theme.Border
    inputBorder.Thickness = 2
    inputBorder.Transparency = 0.6
    inputBorder.Parent = inputContainer
    local keyIcon = Instance.new("ImageLabel")
    keyIcon.Size = UDim2.new(0, 24, 0, 24)
    keyIcon.Position = UDim2.new(0, 15, 0.5, -12)
    keyIcon.BackgroundTransparency = 1
    keyIcon.Image = getIcon("key")
    keyIcon.ImageColor3 = self.theme.TextDim
    keyIcon.Parent = inputContainer
    local keyTextBox = Instance.new("TextBox")
    keyTextBox.Size = UDim2.new(1, -60, 1, -10)
    keyTextBox.Position = UDim2.new(0, 50, 0, 5)
    keyTextBox.BackgroundTransparency = 1
    keyTextBox.Text = ""
    keyTextBox.PlaceholderText = "Enter your premium key..."
    keyTextBox.TextColor3 = self.theme.Text
    keyTextBox.PlaceholderColor3 = self.theme.TextDim
    keyTextBox.Font = Enum.Font.GothamBold
    keyTextBox.TextSize = 16
    keyTextBox.TextXAlignment = Enum.TextXAlignment.Left
    keyTextBox.ClearTextOnFocus = false
    keyTextBox.Parent = inputContainer
    keyTextBox.Focused:Connect(function()
        TweenService:Create(inputBorder, TweenInfo.new(0.2), {
            Color = self.theme.Accent,
            Transparency = 0.2
        }):Play()
        TweenService:Create(keyIcon, TweenInfo.new(0.2), {
            ImageColor3 = self.theme.Accent
        }):Play()
    end)
    keyTextBox.FocusLost:Connect(function()
        TweenService:Create(inputBorder, TweenInfo.new(0.2), {
            Color = self.theme.Border,
            Transparency = 0.6
        }):Play()
        TweenService:Create(keyIcon, TweenInfo.new(0.2), {
            ImageColor3 = self.theme.TextDim
        }):Play()
    end)
    keyTextBox:GetPropertyChangedSignal("Text"):Connect(function()
        if keyTextBox.Text ~= "" then
            playSound(Sounds.KeyType, 0.1, math.random(90, 110) / 100)
        end
    end)
    local submitButton = Instance.new("TextButton")
    submitButton.Size = UDim2.new(1, 0, 0, 50)
    submitButton.Position = UDim2.new(0, 0, 0, 100)
    submitButton.BackgroundColor3 = self.theme.Accent
    submitButton.BackgroundTransparency = 0.1
    submitButton.Text = "🚀 Authenticate"
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitButton.Font = Enum.Font.GothamBold
    submitButton.TextSize = 16
    submitButton.BorderSizePixel = 0
    submitButton.Parent = contentArea
    local submitCorner = Instance.new("UICorner")
    submitCorner.CornerRadius = UDim.new(0, 12)
    submitCorner.Parent = submitButton
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 20)
    statusLabel.Position = UDim2.new(0, 0, 0, 170)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = self.theme.TextDim
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    statusLabel.TextXAlignment = Enum.TextXAlignment.Center
    statusLabel.Parent = contentArea
    submitButton.MouseEnter:Connect(function()
        TweenService:Create(submitButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0,
            Size = UDim2.new(1, 5, 0, 52)
        }):Play()
        playSound(Sounds.Hover, 0.1)
    end)
    submitButton.MouseLeave:Connect(function()
        TweenService:Create(submitButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.1,
            Size = UDim2.new(1, 0, 0, 50)
        }):Play()
    end)
    local function validateKey(inputKey)
        local isValid = inputKey == self.key
        if isValid then
            playSound(Sounds.KeyValid, 0.3)
            createParticleExplosion(submitButton, self.theme.Success)
            submitButton.Text = "✅ Access Granted!"
            submitButton.BackgroundColor3 = self.theme.Success
            statusLabel.Text = "🎉 Welcome! Loading premium features..."
            statusLabel.TextColor3 = self.theme.Success
            lockIcon.Image = getIcon("unlock")
            lockIcon.ImageColor3 = self.theme.Success
            TweenService:Create(containerBorder, TweenInfo.new(0.5), {
                Color = self.theme.Success,
                Transparency = 0
            }):Play()
            spawn(function()
                task.wait(2)
                TweenService:Create(keyContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }):Play()
                TweenService:Create(background, TweenInfo.new(0.5), {
                    BackgroundTransparency = 1
                }):Play()
                task.wait(0.5)
                keyScreenGui:Destroy()
                self.onSuccess()
            end)
        else
            playSound(Sounds.KeyInvalid, 0.3)
            submitButton.Text = "❌ Invalid Key"
            submitButton.BackgroundColor3 = self.theme.Error
            statusLabel.Text = "🚨 Invalid key! Please try again."
            statusLabel.TextColor3 = self.theme.Error
            local originalPos = keyContainer.Position
            spawn(function()
                for i = 1, 10 do
                    local offsetX = math.random(-8, 8)
                    keyContainer.Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset + offsetX, originalPos.Y.Scale, originalPos.Y.Offset)
                    task.wait(0.05)
                end
                keyContainer.Position = originalPos
            end)
            spawn(function()
                task.wait(2)
                submitButton.Text = "🚀 Authenticate"
                submitButton.BackgroundColor3 = self.theme.Accent
                statusLabel.Text = ""
                keyTextBox.Text = ""
            end)
            self.onFail()
        end
    end
    submitButton.MouseButton1Click:Connect(function()
        if keyTextBox.Text ~= "" then
            validateKey(keyTextBox.Text)
            createRippleEffect(submitButton, submitButton.AbsoluteSize.X/2, submitButton.AbsoluteSize.Y/2)
        end
    end)
    keyTextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and keyTextBox.Text ~= "" then
            validateKey(keyTextBox.Text)
        end
    end)
    keyContainer.Size = UDim2.new(0, 0, 0, 0)
    keyContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(keyContainer, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 450, 0, 320),
        Position = UDim2.new(0.5, -225, 0.5, -160)
    }):Play()
    spawn(function()
        task.wait(0.8)
        keyTextBox:CaptureFocus()
    end)
end
local NotificationSystem = {}
NotificationSystem.queue = {}
NotificationSystem.active = {}
NotificationSystem.maxNotifications = 6
function NotificationSystem:CreateNotification(config)
    local notification = {
        Title = config.Title or "Notification",
        Content = config.Content or "No content provided.",
        Duration = config.Duration or 4,
        Type = config.Type or "Info",
        Icon = config.Icon,
        Action = config.Action,
        Sound = config.Sound ~= false
    }
    table.insert(self.queue, notification)
    self:ProcessQueue()
end
function NotificationSystem:ProcessQueue()
    if #self.queue == 0 or #self.active >= self.maxNotifications then return end
    local notification = table.remove(self.queue, 1)
    table.insert(self.active, notification)
    self:ShowNotification(notification)
end
function NotificationSystem:ShowNotification(config)
    local colors = {
        Info = Themes.Dark.Accent,
        Success = Themes.Dark.Success,
        Warning = Themes.Dark.Warning,
        Error = Themes.Dark.Error
    }
    local icons = {
        Info = getIcon("bell"),
        Success = getIcon("check"),
        Warning = getIcon("alert-triangle"),
        Error = getIcon("x")
    }
    if config.Sound then
        playSound(config.Type == "Error" and Sounds.Error or Sounds.Notification, 0.3)
    end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CrustyNotification_" .. tick()
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 380, 0, 110)
    notification.Position = UDim2.new(1, 20, 0, 20 + (#self.active - 1) * 120)
    notification.BackgroundColor3 = Themes.Dark.Secondary
    notification.BorderSizePixel = 0
    notification.ClipsDescendants = false
    notification.Parent = screenGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = notification
    local stroke = Instance.new("UIStroke")
    stroke.Color = colors[config.Type]
    stroke.Thickness = 2
    stroke.Transparency = 0.2
    stroke.Parent = notification
    local glow = createGlowEffect(notification, colors[config.Type], 0.5)
    local iconContainer = Instance.new("Frame")
    iconContainer.Size = UDim2.new(0, 50, 0, 50)
    iconContainer.Position = UDim2.new(0, 20, 0, 15)
    iconContainer.BackgroundColor3 = colors[config.Type]
    iconContainer.BackgroundTransparency = 0.9
    iconContainer.BorderSizePixel = 0
    iconContainer.Parent = notification
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 12)
    iconCorner.Parent = iconContainer
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 28, 0, 28)
    icon.Position = UDim2.new(0.5, -14, 0.5, -14)
    icon.BackgroundTransparency = 1
    icon.Image = config.Icon and getIcon(config.Icon) or icons[config.Type] or getIcon("bell")
    icon.ImageColor3 = colors[config.Type]
    icon.Parent = iconContainer
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -140, 0, 28)
    titleLabel.Position = UDim2.new(0, 85, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = config.Title
    titleLabel.TextColor3 = Themes.Dark.Text
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    titleLabel.Parent = notification
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Size = UDim2.new(1, -140, 0, 50)
    contentLabel.Position = UDim2.new(0, 85, 0, 35)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = config.Content
    contentLabel.TextColor3 = Themes.Dark.TextDim
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextSize = 13
    contentLabel.TextWrapped = true
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.Parent = notification
    notification.Position = UDim2.new(1, 20, 0, notification.Position.Y.Offset)
    TweenService:Create(notification, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -400, 0, notification.Position.Y.Offset)
    }):Play()
    spawn(function()
        task.wait(config.Duration)
        self:HideNotification(screenGui)
    end)
end
function NotificationSystem:HideNotification(screenGui)
    if not screenGui or not screenGui.Parent then return end
    for i, _ in ipairs(self.active) do
        table.remove(self.active, i)
        break
    end
    local notification = screenGui:GetChildren()[1]
    if notification then
        TweenService:Create(notification, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 50, 0, notification.Position.Y.Offset),
            Size = UDim2.new(0, 0, 0, notification.Size.Y.Offset),
            BackgroundTransparency = 1
        }):Play()
    end
    spawn(function()
        task.wait(0.4)
        screenGui:Destroy()
        self:ProcessQueue()
    end)
end
function CrustyLib:CreateWindow(config)
    config = config or {}
    if config.KeySystem and config.Key then
        local keyAuth = KeySystem:Create({
            Key = config.Key,
            KeyTitle = config.KeyTitle,
            KeyDescription = config.KeyDescription,
            Theme = config.Theme or "Purple",
            OnSuccess = function()
                self:_CreateMainWindow(config)
            end,
            OnFail = function()
            end
        })
        return nil
    else
        return self:_CreateMainWindow(config)
    end
end
function CrustyLib:_CreateMainWindow(config)
    config = config or {}
    local window = {}
    window.tabs = {}
    window.currentTheme = config.Theme or "Dark"
    window.theme = Themes[window.currentTheme]
    window.animationsEnabled = config.Animations ~= false
    window.soundsEnabled = config.Sounds ~= false
    window.keyToggle = config.KeyToggle or Enum.KeyCode.Insert
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = config.Name or "CrustyLibGUI_" .. tick()
    screenGui.ResetOnSpawn = config.ResetOnSpawn or false
    screenGui.Parent = playerGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local mainContainer = Instance.new("Frame")
    mainContainer.Name = "MainContainer"
    mainContainer.Size = UDim2.new(0, config.Size and config.Size.X or 650, 0, config.Size and config.Size.Y or 500)
    mainContainer.Position = UDim2.new(0.5, -(config.Size and config.Size.X or 650)/2, 0.5, -(config.Size and config.Size.Y or 500)/2)
    mainContainer.BackgroundTransparency = 1
    mainContainer.Parent = screenGui
    local backgroundBlur = Instance.new("Frame")
    backgroundBlur.Size = UDim2.new(1, 30, 1, 30)
    backgroundBlur.Position = UDim2.new(0, -15, 0, -15)
    backgroundBlur.BackgroundColor3 = window.theme.Shadow
    backgroundBlur.BackgroundTransparency = 0.3
    backgroundBlur.BorderSizePixel = 0
    backgroundBlur.Parent = mainContainer
    local blurCorner = Instance.new("UICorner")
    blurCorner.CornerRadius = UDim.new(0, 25)
    blurCorner.Parent = backgroundBlur
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = window.theme.Primary
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = mainContainer
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 18)
    frameCorner.Parent = frame
    local frameBorder = Instance.new("UIStroke")
    frameBorder.Color = window.theme.Border
    frameBorder.Thickness = 2
    frameBorder.Transparency = 0.6
    frameBorder.Parent = frame
    if config.Glow ~= false then
        local glow = createGlowEffect(frame, window.theme.Glow, 0.8)
        if config.RGBGlow then
            createRGBCycle(glow, "ImageColor3")
        end
    end
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 60)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = window.theme.Secondary
    titleBar.BackgroundTransparency = 0.3
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame
    local titleBarCorner = Instance.new("UICorner")
    titleBarCorner.CornerRadius = UDim.new(0, 18)
    titleBarCorner.Parent = titleBar
    local logoContainer = Instance.new("Frame")
    logoContainer.Size = UDim2.new(0, 45, 0, 45)
    logoContainer.Position = UDim2.new(0, 15, 0, 7.5)
    logoContainer.BackgroundColor3 = window.theme.Accent
    logoContainer.BackgroundTransparency = 0.1
    logoContainer.BorderSizePixel = 0
    logoContainer.Parent = titleBar
    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(0, 12)
    logoCorner.Parent = logoContainer
    local logo = Instance.new("ImageLabel")
    logo.Size = UDim2.new(0, 28, 0, 28)
    logo.Position = UDim2.new(0.5, -14, 0.5, -14)
    logo.BackgroundTransparency = 1
    logo.Image = getIcon(config.Logo or "zap")
    logo.ImageColor3 = window.theme.Accent
    logo.Parent = logoContainer
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -200, 0, 30)
    title.Position = UDim2.new(0, 70, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = config.Title or "🔥 CRUSTY LIBRARY"
    title.TextColor3 = window.theme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, -200, 0, 18)
    subtitle.Position = UDim2.new(0, 70, 0, 32)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = config.Subtitle or "v4.0 • Ultra Premium Modern GUI • " .. window.theme.Name .. " Theme"
    subtitle.TextColor3 = window.theme.TextDim
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextSize = 12
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = titleBar
    local controlsContainer = Instance.new("Frame")
    controlsContainer.Size = UDim2.new(0, 160, 0, 35)
    controlsContainer.Position = UDim2.new(1, -175, 0, 12.5)
    controlsContainer.BackgroundTransparency = 1
    controlsContainer.Parent = titleBar
    local controlsList = Instance.new("UIListLayout")
    controlsList.FillDirection = Enum.FillDirection.Horizontal
    controlsList.Padding = UDim.new(0, 8)
    controlsList.SortOrder = Enum.SortOrder.LayoutOrder
    controlsList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    controlsList.Parent = controlsContainer
    local themeButton = Instance.new("TextButton")
    themeButton.Name = "ThemeButton"
    themeButton.Size = UDim2.new(0, 35, 0, 35)
    themeButton.BackgroundColor3 = window.theme.Tertiary
    themeButton.BackgroundTransparency = 0.2
    themeButton.Text = ""
    themeButton.BorderSizePixel = 0
    themeButton.LayoutOrder = 1
    themeButton.Parent = controlsContainer
    local themeCorner = Instance.new("UICorner")
    themeCorner.CornerRadius = UDim.new(0, 8)
    themeCorner.Parent = themeButton
    local themeIcon = Instance.new("ImageLabel")
    themeIcon.Size = UDim2.new(0, 20, 0, 20)
    themeIcon.Position = UDim2.new(0.5, -10, 0.5, -10)
    themeIcon.BackgroundTransparency = 1
    themeIcon.Image = getIcon("palette")
    themeIcon.ImageColor3 = window.theme.Text
    themeIcon.Parent = themeButton
    local settingsButton = Instance.new("TextButton")
    settingsButton.Name = "SettingsButton"
    settingsButton.Size = UDim2.new(0, 35, 0, 35)
    settingsButton.BackgroundColor3 = window.theme.Tertiary
    settingsButton.BackgroundTransparency = 0.2
    settingsButton.Text = ""
    settingsButton.BorderSizePixel = 0
    settingsButton.LayoutOrder = 2
    settingsButton.Parent = controlsContainer
    local settingsCorner = Instance.new("UICorner")
    settingsCorner.CornerRadius = UDim.new(0, 8)
    settingsCorner.Parent = settingsButton
    local settingsIcon = Instance.new("ImageLabel")
    settingsIcon.Size = UDim2.new(0, 18, 0, 18)
    settingsIcon.Position = UDim2.new(0.5, -9, 0.5, -9)
    settingsIcon.BackgroundTransparency = 1
    settingsIcon.Image = getIcon("settings")
    settingsIcon.ImageColor3 = window.theme.Text
    settingsIcon.Parent = settingsButton
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 35, 0, 35)
    minimizeButton.BackgroundColor3 = window.theme.Warning
    minimizeButton.BackgroundTransparency = 0.2
    minimizeButton.Text = ""
    minimizeButton.BorderSizePixel = 0
    minimizeButton.LayoutOrder = 3
    minimizeButton.Parent = controlsContainer
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 8)
    minimizeCorner.Parent = minimizeButton
    local minimizeIcon = Instance.new("ImageLabel")
    minimizeIcon.Size = UDim2.new(0, 16, 0, 16)
    minimizeIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
    minimizeIcon.BackgroundTransparency = 1
    minimizeIcon.Image = getIcon("minimize")
    minimizeIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    minimizeIcon.Parent = minimizeButton
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 35, 0, 35)
    closeButton.BackgroundColor3 = window.theme.Error
    closeButton.BackgroundTransparency = 0.2
    closeButton.Text = ""
    closeButton.BorderSizePixel = 0
    closeButton.LayoutOrder = 4
    closeButton.Parent = controlsContainer
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    local closeIcon = Instance.new("ImageLabel")
    closeIcon.Size = UDim2.new(0, 16, 0, 16)
    closeIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
    closeIcon.BackgroundTransparency = 1
    closeIcon.Image = getIcon("x")
    closeIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    closeIcon.Parent = closeButton
    for _, button in pairs({themeButton, settingsButton, minimizeButton, closeButton}) do
        button.MouseEnter:Connect(function()
            if window.soundsEnabled then
                playSound(Sounds.Hover, 0.1, 1.2)
            end
            if window.animationsEnabled then
                TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Size = UDim2.new(0, 38, 0, 38),
                    BackgroundTransparency = 0
                }):Play()
            end
        end)
        button.MouseLeave:Connect(function()
            if window.animationsEnabled then
                TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Size = UDim2.new(0, 35, 0, 35),
                    BackgroundTransparency = 0.2
                }):Play()
            end
        end)
        button.MouseButton1Click:Connect(function()
            if window.soundsEnabled then
                playSound(Sounds.Click, 0.2)
            end
            if window.animationsEnabled then
                createRippleEffect(button, button.AbsoluteSize.X/2, button.AbsoluteSize.Y/2)
            end
        end)
    end
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 180, 1, -70)
    sidebar.Position = UDim2.new(0, 10, 0, 70)
    sidebar.BackgroundColor3 = window.theme.Secondary
    sidebar.BackgroundTransparency = 0.1
    sidebar.BorderSizePixel = 0
    sidebar.Parent = frame
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 14)
    sidebarCorner.Parent = sidebar
    local sidebarBorder = Instance.new("UIStroke")
    sidebarBorder.Color = window.theme.Border
    sidebarBorder.Thickness = 1
    sidebarBorder.Transparency = 0.8
    sidebarBorder.Parent = sidebar
    local tabContainer = Instance.new("ScrollingFrame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(1, -10, 1, -10)
    tabContainer.Position = UDim2.new(0, 5, 0, 5)
    tabContainer.BackgroundTransparency = 1
    tabContainer.ScrollBarThickness = 6
    tabContainer.ScrollBarImageColor3 = window.theme.Accent
    tabContainer.ScrollBarImageTransparency = 0.3
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContainer.Parent = sidebar
    local tabList = Instance.new("UIListLayout")
    tabList.Padding = UDim.new(0, 6)
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Parent = tabContainer
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 20)
    end)
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -210, 1, -70)
    contentArea.Position = UDim2.new(0, 200, 0, 70)
    contentArea.BackgroundColor3 = window.theme.Primary
    contentArea.BackgroundTransparency = 0.05
    contentArea.BorderSizePixel = 0
    contentArea.Parent = frame
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 14)
    contentCorner.Parent = contentArea
    local contentBorder = Instance.new("UIStroke")
    contentBorder.Color = window.theme.Border
    contentBorder.Thickness = 1
    contentBorder.Transparency = 0.8
    contentBorder.Parent = contentArea
    function window:CreateTab(config)
        if type(config) == "string" then
            config = {Name = config}
        end
        config = config or {}
        local tab = {}
        tab.name = config.Name or "Tab"
        tab.icon = config.Icon or "home"
        tab.visible = false
        tab.elements = {}
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tab.name .. "_Button"
        tabButton.Size = UDim2.new(1, -10, 0, 45)
        tabButton.BackgroundColor3 = window.theme.Tertiary
        tabButton.BackgroundTransparency = 0.7
        tabButton.Text = ""
        tabButton.BorderSizePixel = 0
        tabButton.LayoutOrder = #window.tabs + 1
        tabButton.Parent = tabContainer
        local tabButtonCorner = Instance.new("UICorner")
        tabButtonCorner.CornerRadius = UDim.new(0, 12)
        tabButtonCorner.Parent = tabButton
        local tabIcon = Instance.new("ImageLabel")
        tabIcon.Size = UDim2.new(0, 20, 0, 20)
        tabIcon.Position = UDim2.new(0, 15, 0.5, -10)
        tabIcon.BackgroundTransparency = 1
        tabIcon.Image = getIcon(tab.icon)
        tabIcon.ImageColor3 = window.theme.TextDim
        tabIcon.Parent = tabButton
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Size = UDim2.new(1, -45, 1, 0)
        tabLabel.Position = UDim2.new(0, 40, 0, 0)
        tabLabel.BackgroundTransparency = 1
        tabLabel.Text = tab.name
        tabLabel.TextColor3 = window.theme.TextDim
        tabLabel.Font = Enum.Font.GothamBold
        tabLabel.TextSize = 13
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        tabLabel.Parent = tabButton
        local activeIndicator = Instance.new("Frame")
        activeIndicator.Size = UDim2.new(0, 3, 0, 0)
        activeIndicator.Position = UDim2.new(0, 2, 0.5, 0)
        activeIndicator.BackgroundColor3 = window.theme.Accent
        activeIndicator.BorderSizePixel = 0
        activeIndicator.Visible = false
        activeIndicator.Parent = tabButton
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(0, 2)
        indicatorCorner.Parent = activeIndicator
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = tab.name .. "_Content"
        tabContent.Size = UDim2.new(1, -20, 1, -20)
        tabContent.Position = UDim2.new(0, 10, 0, 10)
        tabContent.BackgroundTransparency = 1
        tabContent.ScrollBarThickness = 8
        tabContent.ScrollBarImageColor3 = window.theme.Accent
        tabContent.ScrollBarImageTransparency = 0.5
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.Visible = false
        tabContent.Parent = contentArea
        local contentList = Instance.new("UIListLayout")
        contentList.Padding = UDim.new(0, 12)
        contentList.SortOrder = Enum.SortOrder.LayoutOrder
        contentList.Parent = tabContent
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
        end)
        tabButton.MouseButton1Click:Connect(function()
            if window.soundsEnabled then
                playSound(Sounds.Click, 0.2)
            end
            if window.animationsEnabled then
                createRippleEffect(tabButton, tabButton.AbsoluteSize.X/2, tabButton.AbsoluteSize.Y/2)
            end
            for _, existingTab in pairs(window.tabs) do
                existingTab:Hide()
            end
            tab:Show()
        end)
        function tab:Show()
            tab.visible = true
            tabButton.BackgroundTransparency = 0.2
            tabButton.BackgroundColor3 = window.theme.Accent
            tabIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            tabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            activeIndicator.Visible = true
            if window.animationsEnabled then
                TweenService:Create(activeIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 3, 1, -10)
                }):Play()
            else
                activeIndicator.Size = UDim2.new(0, 3, 1, -10)
            end
            tabContent.Visible = true
        end
        function tab:Hide()
            tab.visible = false
            tabButton.BackgroundTransparency = 0.7
            tabButton.BackgroundColor3 = window.theme.Tertiary
            tabIcon.ImageColor3 = window.theme.TextDim
            tabLabel.TextColor3 = window.theme.TextDim
            activeIndicator.Visible = false
            activeIndicator.Size = UDim2.new(0, 3, 0, 0)
            tabContent.Visible = false
        end
        function tab:CreateButton(config)
            config = config or {}
            local elementFrame = Instance.new("Frame")
            elementFrame.Size = UDim2.new(1, 0, 0, config.Size or 55)
            elementFrame.BackgroundColor3 = window.theme.Secondary
            elementFrame.BackgroundTransparency = 0.3
            elementFrame.BorderSizePixel = 0
            elementFrame.LayoutOrder = #tab.elements + 1
            elementFrame.Parent = tabContent
            local elementCorner = Instance.new("UICorner")
            elementCorner.CornerRadius = UDim.new(0, 12)
            elementCorner.Parent = elementFrame
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -20, 1, -10)
            button.Position = UDim2.new(0, 10, 0, 5)
            button.BackgroundColor3 = window.theme.Accent
            button.BackgroundTransparency = 0.1
            button.Text = config.Text or "Button"
            button.TextColor3 = window.theme.Text
            button.Font = Enum.Font.GothamBold
            button.TextSize = 14
            button.BorderSizePixel = 0
            button.Parent = elementFrame
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 10)
            buttonCorner.Parent = button
            if config.Icon then
                local buttonIcon = Instance.new("ImageLabel")
                buttonIcon.Size = UDim2.new(0, 20, 0, 20)
                buttonIcon.Position = UDim2.new(0, 15, 0.5, -10)
                buttonIcon.BackgroundTransparency = 1
                buttonIcon.Image = getIcon(config.Icon)
                buttonIcon.ImageColor3 = window.theme.Text
                buttonIcon.Parent = button
                local textPadding = Instance.new("UIPadding")
                textPadding.PaddingLeft = UDim.new(0, 35)
                textPadding.Parent = button
            end
            button.MouseEnter:Connect(function()
                if window.animationsEnabled then
                    TweenService:Create(button, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0,
                        Size = UDim2.new(1, -15, 1, -5)
                    }):Play()
                end
                if window.soundsEnabled then
                    playSound(Sounds.Hover, 0.1)
                end
            end)
            button.MouseLeave:Connect(function()
                if window.animationsEnabled then
                    TweenService:Create(button, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.1,
                        Size = UDim2.new(1, -20, 1, -10)
                    }):Play()
                end
            end)
            button.MouseButton1Click:Connect(function()
                if window.soundsEnabled then
                    playSound(Sounds.Click, 0.2)
                end
                if window.animationsEnabled then
                    createRippleEffect(button, button.AbsoluteSize.X/2, button.AbsoluteSize.Y/2)
                    createParticleExplosion(button, window.theme.Accent)
                end
                if config.Callback then
                    config.Callback()
                end
            end)
            table.insert(tab.elements, elementFrame)
            return button
        end
        function tab:CreateToggle(config)
            config = config or {}
            local elementFrame = Instance.new("Frame")
            elementFrame.Size = UDim2.new(1, 0, 0, 55)
            elementFrame.BackgroundColor3 = window.theme.Secondary
            elementFrame.BackgroundTransparency = 0.3
            elementFrame.BorderSizePixel = 0
            elementFrame.LayoutOrder = #tab.elements + 1
            elementFrame.Parent = tabContent
            local elementCorner = Instance.new("UICorner")
            elementCorner.CornerRadius = UDim.new(0, 12)
            elementCorner.Parent = elementFrame
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, -20, 1, -10)
            toggleFrame.Position = UDim2.new(0, 10, 0, 5)
            toggleFrame.BackgroundTransparency = 1
            toggleFrame.Parent = elementFrame
            if config.Icon then
                local toggleIcon = Instance.new("ImageLabel")
                toggleIcon.Size = UDim2.new(0, 20, 0, 20)
                toggleIcon.Position = UDim2.new(0, 10, 0.5, -10)
                toggleIcon.BackgroundTransparency = 1
                toggleIcon.Image = getIcon(config.Icon)
                toggleIcon.ImageColor3 = window.theme.Text
                toggleIcon.Parent = toggleFrame
            end
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(1, -100, 1, 0)
            toggleLabel.Position = UDim2.new(0, config.Icon and 40 or 10, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = config.Text or "Toggle"
            toggleLabel.TextColor3 = window.theme.Text
            toggleLabel.Font = Enum.Font.GothamBold
            toggleLabel.TextSize = 14
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Parent = toggleFrame
            local toggleValue = config.Default or false
            local toggleButton = Instance.new("TextButton")
            toggleButton.Size = UDim2.new(0, 50, 0, 25)
            toggleButton.Position = UDim2.new(1, -60, 0.5, -12.5)
            toggleButton.BackgroundColor3 = toggleValue and window.theme.Success or window.theme.Tertiary
            toggleButton.Text = ""
            toggleButton.BorderSizePixel = 0
            toggleButton.Parent = toggleFrame
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(1, 0)
            toggleCorner.Parent = toggleButton
            local toggleKnob = Instance.new("Frame")
            toggleKnob.Size = UDim2.new(0, 20, 0, 20)
            toggleKnob.Position = toggleValue and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
            toggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleKnob.BorderSizePixel = 0
            toggleKnob.Parent = toggleButton
            local knobCorner = Instance.new("UICorner")
            knobCorner.CornerRadius = UDim.new(1, 0)
            knobCorner.Parent = toggleKnob
            toggleButton.MouseButton1Click:Connect(function()
                toggleValue = not toggleValue
                if window.soundsEnabled then
                    playSound(Sounds.Switch, 0.15)
                end
                TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = toggleValue and window.theme.Success or window.theme.Tertiary
                }):Play()
                TweenService:Create(toggleKnob, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Position = toggleValue and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
                }):Play()
                if config.Callback then
                    config.Callback(toggleValue)
                end
            end)
            table.insert(tab.elements, elementFrame)
            return toggleButton
        end
        function tab:CreateSlider(config)
            config = config or {}
            local elementFrame = Instance.new("Frame")
            elementFrame.Size = UDim2.new(1, 0, 0, 75)
            elementFrame.BackgroundColor3 = window.theme.Secondary
            elementFrame.BackgroundTransparency = 0.3
            elementFrame.BorderSizePixel = 0
            elementFrame.LayoutOrder = #tab.elements + 1
            elementFrame.Parent = tabContent
            local elementCorner = Instance.new("UICorner")
            elementCorner.CornerRadius = UDim.new(0, 12)
            elementCorner.Parent = elementFrame
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Size = UDim2.new(1, -20, 1, -10)
            sliderFrame.Position = UDim2.new(0, 10, 0, 5)
            sliderFrame.BackgroundTransparency = 1
            sliderFrame.Parent = elementFrame
            local headerFrame = Instance.new("Frame")
            headerFrame.Size = UDim2.new(1, 0, 0, 35)
            headerFrame.Position = UDim2.new(0, 0, 0, 0)
            headerFrame.BackgroundTransparency = 1
            headerFrame.Parent = sliderFrame
            if config.Icon then
                local sliderIcon = Instance.new("ImageLabel")
                sliderIcon.Size = UDim2.new(0, 20, 0, 20)
                sliderIcon.Position = UDim2.new(0, 0, 0.5, -10)
                sliderIcon.BackgroundTransparency = 1
                sliderIcon.Image = getIcon(config.Icon)
                sliderIcon.ImageColor3 = window.theme.Text
                sliderIcon.Parent = headerFrame
            end
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(1, -120, 1, 0)
            sliderLabel.Position = UDim2.new(0, config.Icon and 25 or 0, 0, 0)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Text = config.Text or "Slider"
            sliderLabel.TextColor3 = window.theme.Text
            sliderLabel.Font = Enum.Font.GothamBold
            sliderLabel.TextSize = 14
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            sliderLabel.Parent = headerFrame
            local min = config.Min or 0
            local max = config.Max or 100
            local default = config.Default or min
            local increment = config.Increment or 1
            local suffix = config.Suffix or ""
            local sliderValue = default
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 100, 1, 0)
            valueLabel.Position = UDim2.new(1, -100, 0, 0)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(sliderValue) .. suffix
            valueLabel.TextColor3 = window.theme.Accent
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextSize = 14
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.Parent = headerFrame
            local sliderTrack = Instance.new("Frame")
            sliderTrack.Size = UDim2.new(1, -10, 0, 6)
            sliderTrack.Position = UDim2.new(0, 5, 1, -15)
            sliderTrack.BackgroundColor3 = window.theme.Tertiary
            sliderTrack.BorderSizePixel = 0
            sliderTrack.Parent = sliderFrame
            local trackCorner = Instance.new("UICorner")
            trackCorner.CornerRadius = UDim.new(0, 3)
            trackCorner.Parent = sliderTrack
            local sliderFill = Instance.new("Frame")
            sliderFill.Size = UDim2.new((sliderValue - min) / (max - min), 0, 1, 0)
            sliderFill.Position = UDim2.new(0, 0, 0, 0)
            sliderFill.BackgroundColor3 = window.theme.Accent
            sliderFill.BorderSizePixel = 0
            sliderFill.Parent = sliderTrack
            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(0, 3)
            fillCorner.Parent = sliderFill
            local sliderKnob = Instance.new("TextButton")
            sliderKnob.Size = UDim2.new(0, 20, 0, 20)
            sliderKnob.Position = UDim2.new((sliderValue - min) / (max - min), -10, 0.5, -10)
            sliderKnob.BackgroundColor3 = window.theme.Accent
            sliderKnob.Text = ""
            sliderKnob.BorderSizePixel = 0
            sliderKnob.Parent = sliderTrack
            local knobCorner = Instance.new("UICorner")
            knobCorner.CornerRadius = UDim.new(1, 0)
            knobCorner.Parent = sliderKnob
            local dragging = false
            local function updateSlider(input)
                local relativeX = math.clamp((input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X, 0, 1)
                sliderValue = math.floor((relativeX * (max - min) + min) / increment) * increment
                sliderValue = math.clamp(sliderValue, min, max)
                valueLabel.Text = tostring(sliderValue) .. suffix
                TweenService:Create(sliderFill, TweenInfo.new(0.1), {
                    Size = UDim2.new(relativeX, 0, 1, 0)
                }):Play()
                TweenService:Create(sliderKnob, TweenInfo.new(0.1), {
                    Position = UDim2.new(relativeX, -10, 0.5, -10)
                }):Play()
                if config.Callback then
                    config.Callback(sliderValue)
                end
            end
            sliderKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    updateSlider(input)
                    if window.soundsEnabled then
                        playSound(Sounds.Click, 0.1)
                    end
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            sliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    updateSlider(input)
                    if window.soundsEnabled then
                        playSound(Sounds.Click, 0.1)
                    end
                end
            end)
            table.insert(tab.elements, elementFrame)
            return sliderKnob
        end
        function tab:CreateDropdown(config)
            config = config or {}
            local elementFrame = Instance.new("Frame")
            elementFrame.Size = UDim2.new(1, 0, 0, 55)
            elementFrame.BackgroundColor3 = window.theme.Secondary
            elementFrame.BackgroundTransparency = 0.3
            elementFrame.BorderSizePixel = 0
            elementFrame.LayoutOrder = #tab.elements + 1
            elementFrame.Parent = tabContent
            local elementCorner = Instance.new("UICorner")
            elementCorner.CornerRadius = UDim.new(0, 12)
            elementCorner.Parent = elementFrame
            local dropdownFrame = Instance.new("Frame")
            dropdownFrame.Size = UDim2.new(1, -20, 1, -10)
            dropdownFrame.Position = UDim2.new(0, 10, 0, 5)
            dropdownFrame.BackgroundTransparency = 1
            dropdownFrame.Parent = elementFrame
            if config.Icon then
                local dropdownIcon = Instance.new("ImageLabel")
                dropdownIcon.Size = UDim2.new(0, 20, 0, 20)
                dropdownIcon.Position = UDim2.new(0, 10, 0.5, -10)
                dropdownIcon.BackgroundTransparency = 1
                dropdownIcon.Image = getIcon(config.Icon)
                dropdownIcon.ImageColor3 = window.theme.Text
                dropdownIcon.Parent = dropdownFrame
            end
            local dropdownLabel = Instance.new("TextLabel")
            dropdownLabel.Size = UDim2.new(0, 120, 1, 0)
            dropdownLabel.Position = UDim2.new(0, config.Icon and 40 or 10, 0, 0)
            dropdownLabel.BackgroundTransparency = 1
            dropdownLabel.Text = config.Text or "Dropdown"
            dropdownLabel.TextColor3 = window.theme.Text
            dropdownLabel.Font = Enum.Font.GothamBold
            dropdownLabel.TextSize = 14
            dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            dropdownLabel.Parent = dropdownFrame
            local options = config.Options or {"Option 1", "Option 2", "Option 3"}
            local selectedOption = config.Default or options[1]
            local dropdownOpen = false
            local dropdownButton = Instance.new("TextButton")
            dropdownButton.Size = UDim2.new(1, -140, 0, 35)
            dropdownButton.Position = UDim2.new(0, 130, 0.5, -17.5)
            dropdownButton.BackgroundColor3 = window.theme.Tertiary
            dropdownButton.BackgroundTransparency = 0.3
            dropdownButton.Text = selectedOption
            dropdownButton.TextColor3 = window.theme.Text
            dropdownButton.Font = Enum.Font.Gotham
            dropdownButton.TextSize = 12
            dropdownButton.TextXAlignment = Enum.TextXAlignment.Center
            dropdownButton.BorderSizePixel = 0
            dropdownButton.Parent = dropdownFrame
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 8)
            buttonCorner.Parent = dropdownButton
            local dropdownArrow = Instance.new("ImageLabel")
            dropdownArrow.Size = UDim2.new(0, 12, 0, 12)
            dropdownArrow.Position = UDim2.new(1, -20, 0.5, -6)
            dropdownArrow.BackgroundTransparency = 1
            dropdownArrow.Image = getIcon("chevron-down")
            dropdownArrow.ImageColor3 = window.theme.TextDim
            dropdownArrow.Parent = dropdownButton
            local dropdownList = nil
            dropdownButton.MouseButton1Click:Connect(function()
                if window.soundsEnabled then
                    playSound(Sounds.Click, 0.15)
                end
                if dropdownOpen then
                    dropdownOpen = false
                    TweenService:Create(dropdownArrow, TweenInfo.new(0.2), {
                        Rotation = 0
                    }):Play()
                    if dropdownList then
                        TweenService:Create(dropdownList, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                            Size = UDim2.new(1, -140, 0, 0),
                            BackgroundTransparency = 1
                        }):Play()
                        spawn(function()
                            task.wait(0.2)
                            if dropdownList then dropdownList:Destroy() end
                            dropdownList = nil
                        end)
                    end
                else
                    dropdownOpen = true
                    TweenService:Create(dropdownArrow, TweenInfo.new(0.2), {
                        Rotation = 180
                    }):Play()
                    dropdownList = Instance.new("Frame")
                    dropdownList.Size = UDim2.new(1, -140, 0, 0)
                    dropdownList.Position = UDim2.new(0, 130, 1, 5)
                    dropdownList.BackgroundColor3 = window.theme.Secondary
                    dropdownList.BorderSizePixel = 0
                    dropdownList.ZIndex = 10
                    dropdownList.Parent = dropdownFrame
                    local listCorner = Instance.new("UICorner")
                    listCorner.CornerRadius = UDim.new(0, 8)
                    listCorner.Parent = dropdownList
                    local listBorder = Instance.new("UIStroke")
                    listBorder.Color = window.theme.Border
                    listBorder.Thickness = 1
                    listBorder.Transparency = 0.5
                    listBorder.Parent = dropdownList
                    local listLayout = Instance.new("UIListLayout")
                    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    listLayout.Parent = dropdownList
                    for i, option in ipairs(options) do
                        local optionButton = Instance.new("TextButton")
                        optionButton.Size = UDim2.new(1, 0, 0, 30)
                        optionButton.BackgroundColor3 = selectedOption == option and window.theme.Accent or Color3.fromRGB(0, 0, 0)
                        optionButton.BackgroundTransparency = selectedOption == option and 0.2 or 1
                        optionButton.Text = option
                        optionButton.TextColor3 = window.theme.Text
                        optionButton.Font = Enum.Font.Gotham
                        optionButton.TextSize = 12
                        optionButton.BorderSizePixel = 0
                        optionButton.LayoutOrder = i
                        optionButton.Parent = dropdownList
                        optionButton.MouseButton1Click:Connect(function()
                            selectedOption = option
                            dropdownButton.Text = option
                            if config.Callback then
                                config.Callback(option)
                            end
                            dropdownOpen = false
                            TweenService:Create(dropdownArrow, TweenInfo.new(0.2), {
                                Rotation = 0
                            }):Play()
                            TweenService:Create(dropdownList, TweenInfo.new(0.2), {
                                Size = UDim2.new(1, -140, 0, 0)
                            }):Play()
                            spawn(function()
                                task.wait(0.2)
                                dropdownList:Destroy()
                                dropdownList = nil
                            end)
                        end)
                        optionButton.MouseEnter:Connect(function()
                            if selectedOption ~= option then
                                TweenService:Create(optionButton, TweenInfo.new(0.1), {
                                    BackgroundTransparency = 0.8
                                }):Play()
                            end
                        end)
                        optionButton.MouseLeave:Connect(function()
                            if selectedOption ~= option then
                                TweenService:Create(optionButton, TweenInfo.new(0.1), {
                                    BackgroundTransparency = 1
                                }):Play()
                            end
                        end)
                    end
                    TweenService:Create(dropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                        Size = UDim2.new(1, -140, 0, #options * 30)
                    }):Play()
                end
            end)
            table.insert(tab.elements, elementFrame)
            return dropdownButton
        end
        function tab:CreateSection(config)
            config = config or {}
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Size = UDim2.new(1, 0, 0, 40)
            sectionFrame.BackgroundTransparency = 1
            sectionFrame.LayoutOrder = #tab.elements + 1
            sectionFrame.Parent = tabContent
            local sectionLine = Instance.new("Frame")
            sectionLine.Size = UDim2.new(1, -40, 0, 2)
            sectionLine.Position = UDim2.new(0, 20, 1, -10)
            sectionLine.BackgroundColor3 = window.theme.Border
            sectionLine.BackgroundTransparency = 0.5
            sectionLine.BorderSizePixel = 0
            sectionLine.Parent = sectionFrame
            local lineCorner = Instance.new("UICorner")
            lineCorner.CornerRadius = UDim.new(0, 1)
            lineCorner.Parent = sectionLine
            if config.Text then
                local sectionLabel = Instance.new("TextLabel")
                sectionLabel.Size = UDim2.new(1, 0, 1, -10)
                sectionLabel.Position = UDim2.new(0, 0, 0, 0)
                sectionLabel.BackgroundTransparency = 1
                sectionLabel.Text = config.Text
                sectionLabel.TextColor3 = window.theme.Accent
                sectionLabel.Font = Enum.Font.GothamBold
                sectionLabel.TextSize = 16
                sectionLabel.TextXAlignment = Enum.TextXAlignment.Center
                sectionLabel.Parent = sectionFrame
                if config.Icon then
                    local sectionIcon = Instance.new("ImageLabel")
                    sectionIcon.Size = UDim2.new(0, 20, 0, 20)
                    sectionIcon.Position = UDim2.new(0.5, -60, 0.5, -15)
                    sectionIcon.BackgroundTransparency = 1
                    sectionIcon.Image = getIcon(config.Icon)
                    sectionIcon.ImageColor3 = window.theme.Accent
                    sectionIcon.Parent = sectionFrame
                    sectionLabel.Position = UDim2.new(0.5, -30, 0, 0)
                    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
                end
            end
            table.insert(tab.elements, sectionFrame)
            return sectionFrame
        end
        if #window.tabs == 0 then
            spawn(function()
                task.wait(0.1)
                tab:Show()
            end)
        end
        window.tabs[tab.name] = tab
        return tab
    end
    function window:ChangeTheme(themeName)
        if not Themes[themeName] then return end
        window.currentTheme = themeName
        window.theme = Themes[themeName]
        frame.BackgroundColor3 = window.theme.Primary
        titleBar.BackgroundColor3 = window.theme.Secondary
        sidebar.BackgroundColor3 = window.theme.Secondary
        contentArea.BackgroundColor3 = window.theme.Primary
        title.TextColor3 = window.theme.Text
        subtitle.TextColor3 = window.theme.TextDim
        subtitle.Text = config.Subtitle or "v4.0 • Ultra Premium Modern GUI • " .. window.theme.Name .. " Theme"
        logo.ImageColor3 = window.theme.Accent
        logoContainer.BackgroundColor3 = window.theme.Accent
        frameBorder.Color = window.theme.Border
        sidebarBorder.Color = window.theme.Border
        contentBorder.Color = window.theme.Border
        if window.soundsEnabled then
            playSound(Sounds.Success, 0.2)
        end
        window:Notify({
            Title = "Theme Changed!",
            Content = "Successfully changed to " .. window.theme.Name .. " theme",
            Type = "Success",
            Icon = "check",
            Duration = 3
        })
    end
    function window:Notify(config)
        spawn(function()
            NotificationSystem:CreateNotification(config)
        end)
    end
    local minimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        local targetSize = minimized and UDim2.new(0, mainContainer.Size.X.Offset, 0, 60) or UDim2.new(0, config.Size and config.Size.X or 650, 0, config.Size and config.Size.Y or 500)
        if window.animationsEnabled then
            TweenService:Create(mainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
                Size = targetSize
            }):Play()
        else
            mainContainer.Size = targetSize
        end
        minimizeIcon.Image = getIcon(minimized and "maximize" or "minimize")
        if window.soundsEnabled then
            playSound(Sounds.Success, 0.2)
        end
    end)
    closeButton.MouseButton1Click:Connect(function()
        if window.soundsEnabled then
            playSound(Sounds.Error, 0.25)
        end
        if window.animationsEnabled then
            createParticleExplosion(closeButton, window.theme.Error)
            TweenService:Create(mainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            spawn(function()
                task.wait(0.5)
                screenGui:Destroy()
            end)
        else
            screenGui:Destroy()
        end
    end)
    local dragging = false
    local dragStart = nil
    local startPos = nil
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainContainer.Position
            if window.soundsEnabled then
                playSound(Sounds.Click, 0.1)
            end
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            mainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    if config.KeyToggle then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == window.keyToggle then
                frame.Visible = not frame.Visible
                if window.soundsEnabled then
                    playSound(Sounds.Switch, 0.15)
                end
            end
        end)
    end
    function window:Show()
        frame.Visible = true
    end
    function window:Hide()
        frame.Visible = false
    end
    function window:Destroy()
        screenGui:Destroy()
    end
    if window.animationsEnabled then
        mainContainer.Position = UDim2.new(0.5, 0, 0.5, -250)
        mainContainer.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(mainContainer, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -(config.Size and config.Size.X or 650)/2, 0.5, -(config.Size and config.Size.Y or 500)/2),
            Size = UDim2.new(0, config.Size and config.Size.X or 650, 0, config.Size and config.Size.Y or 500)
        }):Play()
    end
    spawn(function()
        task.wait(1)
        window:Notify({
            Title = "Welcome! 🎉",
            Content = "Crusty Library v4.0 loaded successfully! Enjoy the premium experience.",
            Type = "Success",
            Icon = "check",
            Duration = 5
        })
    end)
    return window
end
local CrustyLib = require(script.CrustyLib)
local window = CrustyLib:CreateWindow({
    Title = "🎮 Game Hub Premium",
    Subtitle = "Elite Gaming Experience v2.0",
    Size = {X = 700, Y = 600},
    Theme = "Purple",
    KeySystem = true,
    Key = "CrustyPremium2024",
    KeyTitle = "🔑 Premium Access Required",
    KeyDescription = "Enter your premium key to unlock advanced features",
    Animations = true,
    Sounds = true,
    RGBGlow = true
})
if window then
    local homeTab = window:CreateTab({
        Name = "Home",
        Icon = "home"
    })
    homeTab:CreateSection({Text = "Welcome Section", Icon = "star"})
    homeTab:CreateButton({
        Text = "Click Me!",
        Icon = "zap",
        Callback = function()
            window:Notify({
                Title = "Button Clicked!",
                Content = "The button was successfully clicked!",
                Type = "Success"
            })
        end
    })
    homeTab:CreateToggle({
        Text = "Auto Farm",
        Icon = "trending-up",
        Default = false,
        Callback = function(value)
            print("Auto Farm:", value)
        end
    })
    homeTab:CreateSlider({
        Text = "Speed",
        Icon = "zap",
        Min = 1,
        Max = 20,
        Default = 10,
        Suffix = " units/sec",
        Callback = function(value)
            print("Speed:", value)
        end
    })
    homeTab:CreateDropdown({
        Text = "Select Item",
        Icon = "package",
        Options = {"Sword", "Shield", "Bow", "Staff"},
        Default = "Sword",
        Callback = function(option)
            print("Selected:", option)
        end
    })
    local settingsTab = window:CreateTab({
        Name = "Settings",
        Icon = "settings"
    })
    settingsTab:CreateSection({Text = "Configuration", Icon = "settings"})
    settingsTab:CreateButton({
        Text = "Reset Settings",
        Icon = "refresh-cw",
        Callback = function()
            window:Notify({
                Title = "Settings Reset",
                Content = "All settings have been reset to defaults",
                Type = "Warning"
            })
        end
    })
end
return CrustyLib
