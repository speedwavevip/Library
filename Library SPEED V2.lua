local ModernUI = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local TextService = game:GetService("TextService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local function CreateSound(soundId, volume)
    volume = volume or 0.3
    
    for _, sound in pairs(workspace:GetChildren()) do
        if sound.Name == "UISound" then
            sound:Destroy()
        end
    end
    
    local sound = Instance.new("Sound")
    sound.Name = "UISound"
    sound.Parent = workspace
    sound.Volume = volume
    sound.SoundId = soundId
    sound:Play()
    
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local function CreateRipple(parent, x, y)
    local ripple = Instance.new("Frame")
    local corner = Instance.new("UICorner")
    
    ripple.Name = "Ripple"
    ripple.Parent = parent
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.8
    ripple.BorderSizePixel = 0
    ripple.Position = UDim2.new(0, x - 5, 0, y - 5)
    ripple.Size = UDim2.new(0, 10, 0, 10)
    ripple.ZIndex = parent.ZIndex + 10
    
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
    local tween = TweenService:Create(ripple, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
        Size = UDim2.new(0, 100, 0, 100),
        Position = UDim2.new(0, x - 50, 0, y - 50),
        BackgroundTransparency = 1
    })
    
    tween:Play()
    tween.Completed:Connect(function()
        ripple:Destroy()
    end)
end

local Themes = {
    ["Red"] = {
        Background = Color3.fromRGB(10, 10, 15),
        Surface = Color3.fromRGB(35, 15, 15),
        Card = Color3.fromRGB(50, 20, 20),
        Primary = Color3.fromRGB(220, 50, 50),
        Secondary = Color3.fromRGB(180, 40, 40),
        Success = Color3.fromRGB(50, 180, 50),
        Warning = Color3.fromRGB(220, 150, 50),
        Error = Color3.fromRGB(220, 50, 50),
        Text = Color3.fromRGB(255, 0, 0),
        TextSecondary = Color3.fromRGB(200, 160, 160),
        Border = Color3.fromRGB(70, 30, 30)
    }
}

function ModernUI:CreateWindow(config)
    config = config or {}
    local windowTitle = config.Title or "Modern UI"
    local theme = Themes[config.Theme or "Red"]
    local enableAnimations = config.Animations ~= false
    local enableSounds = config.Sounds ~= false
    
    for _, gui in pairs(CoreGui:GetChildren()) do
        if gui.Name == "ModernUILib" then 
            gui:Destroy() 
        end
    end

    local ScreenGui = Instance.new("ScreenGui")
    local BlurFrame = Instance.new("Frame")
    local MainContainer = Instance.new("Frame")
    local ShadowFrame = Instance.new("Frame")
    local HeaderFrame = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local ControlsFrame = Instance.new("Frame")
    local MinimizeBtn = Instance.new("TextButton")
    local CloseBtn = Instance.new("TextButton")
    local ContentFrame = Instance.new("Frame")
    local SidebarFrame = Instance.new("Frame")
    local TabContainer = Instance.new("ScrollingFrame")
    local MainContent = Instance.new("Frame")
    
    ScreenGui.Name = "ModernUILib"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    
    BlurFrame.Name = "BlurFrame"
    BlurFrame.Parent = ScreenGui
    BlurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BlurFrame.BackgroundTransparency = 0.7
    BlurFrame.Size = UDim2.new(1, 0, 1, 0)
    BlurFrame.Visible = false
    
    ShadowFrame.Name = "Shadow"
    ShadowFrame.Parent = ScreenGui
    ShadowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ShadowFrame.BackgroundTransparency = 0.8
    ShadowFrame.Position = UDim2.new(0.5, -303, 0.5, -203)
    ShadowFrame.Size = UDim2.new(0, 606, 0, 406)
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 20)
    shadowCorner.Parent = ShadowFrame
    
    MainContainer.Name = "MainContainer"
    MainContainer.Parent = ScreenGui
    MainContainer.BackgroundColor3 = theme.Background
    MainContainer.BorderSizePixel = 0
    MainContainer.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainContainer.Size = UDim2.new(0, 600, 0, 400)
    MainContainer.ClipsDescendants = true
    MainContainer.Active = true
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = MainContainer
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = theme.Border
    mainStroke.Thickness = 1
    mainStroke.Parent = MainContainer
    
    HeaderFrame.Name = "Header"
    HeaderFrame.Parent = MainContainer
    HeaderFrame.BackgroundColor3 = theme.Surface
    HeaderFrame.BorderSizePixel = 0
    HeaderFrame.Size = UDim2.new(1, 0, 0, 40)
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 16)
    headerCorner.Parent = HeaderFrame
    
    TitleLabel.Name = "Title"
    TitleLabel.Parent = HeaderFrame
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.Size = UDim2.new(1, -120, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = windowTitle
    TitleLabel.TextColor3 = theme.Text
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    ControlsFrame.Name = "Controls"
    ControlsFrame.Parent = HeaderFrame
    ControlsFrame.BackgroundTransparency = 1
    ControlsFrame.Position = UDim2.new(1, -80, 0, 5)
    ControlsFrame.Size = UDim2.new(0, 70, 0, 30)
    
    MinimizeBtn.Name = "Minimize"
    MinimizeBtn.Parent = ControlsFrame
    MinimizeBtn.BackgroundColor3 = theme.Card
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Position = UDim2.new(0, 0, 0, 0)
    MinimizeBtn.Size = UDim2.new(0, 30, 1, 0)
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Text = "−"
    MinimizeBtn.TextColor3 = theme.Text
    MinimizeBtn.TextSize = 14
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 8)
    minCorner.Parent = MinimizeBtn
    
    CloseBtn.Name = "Close"
    CloseBtn.Parent = ControlsFrame
    CloseBtn.BackgroundColor3 = theme.Error
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Position = UDim2.new(0, 40, 0, 0)
    CloseBtn.Size = UDim2.new(0, 30, 1, 0)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 16
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = CloseBtn
    
    ContentFrame.Name = "Content"
    ContentFrame.Parent = MainContainer
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    
    SidebarFrame.Name = "Sidebar"
    SidebarFrame.Parent = ContentFrame
    SidebarFrame.BackgroundColor3 = theme.Surface
    SidebarFrame.BorderSizePixel = 0
    SidebarFrame.Position = UDim2.new(0, 8, 0, 8)
    SidebarFrame.Size = UDim2.new(0, 160, 1, -16)
    
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 12)
    sidebarCorner.Parent = SidebarFrame
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = SidebarFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 10, 0, 10)
    TabContainer.Size = UDim2.new(1, -20, 1, -20)
    TabContainer.ScrollBarThickness = 2
    TabContainer.ScrollBarImageColor3 = theme.Primary
    TabContainer.BorderSizePixel = 0
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = TabContainer
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 8)
    
    MainContent.Name = "MainContent"
    MainContent.Parent = ContentFrame
    MainContent.BackgroundColor3 = theme.Surface
    MainContent.BorderSizePixel = 0
    MainContent.Position = UDim2.new(0, 176, 0, 8)
    MainContent.Size = UDim2.new(1, -184, 1, -16)
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 12)
    contentCorner.Parent = MainContent
    
    local dragStart, startPos
    local isMinimized = false
    local currentTab = nil
    
    HeaderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragStart = input.Position
            startPos = MainContainer.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragStart then
            local delta = input.Position - dragStart
            MainContainer.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
            ShadowFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X - 3,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y - 3
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragStart = nil
        end
    end)
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        if enableSounds then
            CreateSound("rbxassetid://131961136", 0.2)
        end
        
        isMinimized = not isMinimized
        local targetSize = isMinimized and UDim2.new(0, 600, 0, 40) or UDim2.new(0, 600, 0, 400)
        local shadowSize = isMinimized and UDim2.new(0, 606, 0, 46) or UDim2.new(0, 606, 0, 406)
        
        if enableAnimations then
            TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                Size = targetSize
            }):Play()
            TweenService:Create(ShadowFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                Size = shadowSize
            }):Play()
        else
            MainContainer.Size = targetSize
            ShadowFrame.Size = shadowSize
        end
        
        MinimizeBtn.Text = isMinimized and "□" or "−"
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        if enableSounds then
            CreateSound("rbxassetid://131961136", 0.3)
        end
        
        if enableAnimations then
            local closeTween = TweenService:Create(MainContainer, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 0, 0, 0)
            })
            local shadowTween = TweenService:Create(ShadowFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 0, 0, 0)
            })
            
            closeTween:Play()
            shadowTween:Play()
            
            closeTween.Completed:Connect(function()
                ScreenGui:Destroy()
            end)
        else
            ScreenGui:Destroy()
        end
    end)
    
    for _, button in pairs({MinimizeBtn, CloseBtn}) do
        button.MouseEnter:Connect(function()
            if enableAnimations then
                TweenService:Create(button, TweenInfo.new(0.15), {
                    BackgroundTransparency = 0.2
                }):Play()
            end
        end)
        
        button.MouseLeave:Connect(function()
            if enableAnimations then
                TweenService:Create(button, TweenInfo.new(0.15), {
                    BackgroundTransparency = 0
                }):Play()
            end
        end)
    end
    
    local WindowObject = {}
    WindowObject.Theme = theme
    WindowObject.Notifications = {}
    
    function WindowObject:Notify(config)
        config = config or {}
        local title = config.Title or "Notification"
        local content = config.Content or "Message"
        local duration = config.Duration or 5
        local type = config.Type or "Info"
        
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = content,
            Duration = duration,
            Button1 = "OK"
        })
    end
    
    function WindowObject:CreateKeySystem(config)
        config = config or {}
        local correctKey = config.Key or "defaultkey"
        local title = config.Title or "Key System"
        local subtitle = config.Subtitle or "Enter the access key"
        local callback = config.Callback or function() end
        
        BlurFrame.Visible = true
        
        local KeyFrame = Instance.new("Frame")
        local KeyCorner = Instance.new("UICorner")
        local KeyTitle = Instance.new("TextLabel")
        local KeySubtitle = Instance.new("TextLabel")
        local KeyInput = Instance.new("TextBox")
        local KeyInputCorner = Instance.new("UICorner")
        local SubmitBtn = Instance.new("TextButton")
        local SubmitCorner = Instance.new("UICorner")
        
        KeyFrame.Name = "KeySystem"
        KeyFrame.Parent = ScreenGui
        KeyFrame.BackgroundColor3 = theme.Card
        KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
        KeyFrame.Size = UDim2.new(0, 400, 0, 200)
        KeyFrame.BorderSizePixel = 0
        
        KeyCorner.CornerRadius = UDim.new(0, 16)
        KeyCorner.Parent = KeyFrame
        
        KeyTitle.Name = "Title"
        KeyTitle.Parent = KeyFrame
        KeyTitle.BackgroundTransparency = 1
        KeyTitle.Position = UDim2.new(0, 0, 0, 20)
        KeyTitle.Size = UDim2.new(1, 0, 0, 30)
        KeyTitle.Font = Enum.Font.GothamBold
        KeyTitle.Text = title
        KeyTitle.TextColor3 = theme.Text
        KeyTitle.TextSize = 20
        
        KeySubtitle.Name = "Subtitle"
        KeySubtitle.Parent = KeyFrame
        KeySubtitle.BackgroundTransparency = 1
        KeySubtitle.Position = UDim2.new(0, 0, 0, 50)
        KeySubtitle.Size = UDim2.new(1, 0, 0, 20)
        KeySubtitle.Font = Enum.Font.Gotham
        KeySubtitle.Text = subtitle
        KeySubtitle.TextColor3 = theme.TextSecondary
        KeySubtitle.TextSize = 14
        
        KeyInput.Name = "Input"
        KeyInput.Parent = KeyFrame
        KeyInput.BackgroundColor3 = theme.Background
        KeyInput.Position = UDim2.new(0, 30, 0, 90)
        KeyInput.Size = UDim2.new(1, -60, 0, 40)
        KeyInput.Font = Enum.Font.Gotham
        KeyInput.PlaceholderText = "Enter key here..."
        KeyInput.Text = ""
        KeyInput.TextColor3 = theme.Text
        KeyInput.TextSize = 14
        KeyInput.BorderSizePixel = 0
        
        KeyInputCorner.CornerRadius = UDim.new(0, 8)
        KeyInputCorner.Parent = KeyInput
        
        SubmitBtn.Name = "Submit"
        SubmitBtn.Parent = KeyFrame
        SubmitBtn.BackgroundColor3 = theme.Primary
        SubmitBtn.Position = UDim2.new(0, 30, 0, 145)
        SubmitBtn.Size = UDim2.new(1, -60, 0, 35)
        SubmitBtn.Font = Enum.Font.GothamBold
        SubmitBtn.Text = "Submit Key"
        SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        SubmitBtn.TextSize = 14
        SubmitBtn.BorderSizePixel = 0
        
        SubmitCorner.CornerRadius = UDim.new(0, 8)
        SubmitCorner.Parent = SubmitBtn
        
        SubmitBtn.MouseButton1Click:Connect(function()
            if KeyInput.Text == correctKey then
                BlurFrame.Visible = false
                KeyFrame:Destroy()
                callback(true)
            else
                callback(false)
                WindowObject:Notify({
                    Title = "Access Denied",
                    Content = "Invalid key entered",
                    Type = "Error"
                })
            end
        end)
        
        KeyInput.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local connection = SubmitBtn.MouseButton1Click:Connect(function() end)
                connection:Disconnect()
                if KeyInput.Text == correctKey then
                    BlurFrame.Visible = false
                    KeyFrame:Destroy()
                    callback(true)
                else
                    callback(false)
                    WindowObject:Notify({
                        Title = "Access Denied",
                        Content = "Invalid key entered",
                        Type = "Error"
                    })
                end
            end
        end)
    end
    
    function WindowObject:CreateTab(config)
        config = config or {}
        local tabName = config.Name or "Tab"
        local tabIcon = config.Icon or "rbxassetid://3926305904"
        
        local TabButton = Instance.new("TextButton")
        local TabCorner = Instance.new("UICorner")
        local TabIcon = Instance.new("ImageLabel")
        local TabLabel = Instance.new("TextLabel")
        local TabContent = Instance.new("ScrollingFrame")
        local ContentLayout = Instance.new("UIListLayout")
        
        TabButton.Name = tabName
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = theme.Card
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.Text = ""
        TabButton.BorderSizePixel = 0
        
        TabCorner.CornerRadius = UDim.new(0, 10)
        TabCorner.Parent = TabButton
        
        TabIcon.Name = "Icon"
        TabIcon.Parent = TabButton
        TabIcon.BackgroundTransparency = 1
        TabIcon.Position = UDim2.new(0, 8, 0.5, -8)
        TabIcon.Size = UDim2.new(0, 16, 0, 16)
        TabIcon.Image = tabIcon
        TabIcon.ImageColor3 = theme.TextSecondary
        
        TabLabel.Name = "Label"
        TabLabel.Parent = TabButton
        TabLabel.BackgroundTransparency = 1
        TabLabel.Position = UDim2.new(0, 30, 0, 0)
        TabLabel.Size = UDim2.new(1, -35, 1, 0)
        TabLabel.Font = Enum.Font.GothamSemibold
        TabLabel.Text = tabName
        TabLabel.TextColor3 = theme.TextSecondary
        TabLabel.TextSize = 12
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        TabContent.Name = tabName.."Content"
        TabContent.Parent = MainContent
        TabContent.BackgroundTransparency = 1
        TabContent.Position = UDim2.new(0, 10, 0, 10)
        TabContent.Size = UDim2.new(1, -20, 1, -20)
        TabContent.ScrollBarThickness = 2
        TabContent.ScrollBarImageColor3 = theme.Primary
        TabContent.BorderSizePixel = 0
        TabContent.Visible = false
        
        ContentLayout.Parent = TabContent
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 8)
        
        TabButton.MouseButton1Click:Connect(function()
            if enableSounds then
                CreateSound("rbxassetid://131961136", 0.1)
            end
            
            CreateRipple(TabButton, Mouse.X - TabButton.AbsolutePosition.X, Mouse.Y - TabButton.AbsolutePosition.Y)
            
            for _, child in pairs(MainContent:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            
            for _, child in pairs(TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = theme.Card
                    local icon = child:FindFirstChild("Icon")
                    local label = child:FindFirstChild("Label")
                    if icon then icon.ImageColor3 = theme.TextSecondary end
                    if label then label.TextColor3 = theme.TextSecondary end
                end
            end
            
            TabContent.Visible = true
            TabButton.BackgroundColor3 = theme.Primary
            TabIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            currentTab = TabContent
        end)
        
        TabButton.MouseEnter:Connect(function()
            if TabButton.BackgroundColor3 ~= theme.Primary then
                if enableAnimations then
                    TweenService:Create(TabButton, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(
                            math.min(255, theme.Card.R * 255 + 15),
                            math.min(255, theme.Card.G * 255 + 15),
                            math.min(255, theme.Card.B * 255 + 15)
                        )
                    }):Play()
                end
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if TabButton.BackgroundColor3 ~= theme.Primary then
                if enableAnimations then
                    TweenService:Create(TabButton, TweenInfo.new(0.15), {
                        BackgroundColor3 = theme.Card
                    }):Play()
                end
            end
        end)
        
        if #TabContainer:GetChildren() == 2 then
            spawn(function()
                wait(0.1)
                for _, child in pairs(MainContent:GetChildren()) do
                    if child:IsA("ScrollingFrame") then
                        child.Visible = false
                    end
                end
                
                for _, child in pairs(TabContainer:GetChildren()) do
                    if child:IsA("TextButton") then
                        child.BackgroundColor3 = theme.Card
                        local icon = child:FindFirstChild("Icon")
                        local label = child:FindFirstChild("Label")
                        if icon then icon.ImageColor3 = theme.TextSecondary end
                        if label then label.TextColor3 = theme.TextSecondary end
                    end
                end
                
                TabContent.Visible = true
                TabButton.BackgroundColor3 = theme.Primary
                TabIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                currentTab = TabContent
            end)
        end
        
        local TabObject = {}
        
        function TabObject:CreateSection(name)
            local SectionFrame = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")
            local SectionContent = Instance.new("Frame")
            local SectionLayout = Instance.new("UIListLayout")
            
            SectionFrame.Name = "Section"
            SectionFrame.Parent = TabContent
            SectionFrame.BackgroundColor3 = theme.Card
            SectionFrame.Size = UDim2.new(1, 0, 0, 60)
            SectionFrame.BorderSizePixel = 0
            
            SectionCorner.CornerRadius = UDim.new(0, 10)
            SectionCorner.Parent = SectionFrame
            
            SectionTitle.Name = "Title"
            SectionTitle.Parent = SectionFrame
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 15, 0, 0)
            SectionTitle.Size = UDim2.new(1, -30, 0, 35)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = name or "Section"
            SectionTitle.TextColor3 = theme.Text
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SectionContent.Name = "Content"
            SectionContent.Parent = SectionFrame
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 15, 0, 35)
            SectionContent.Size = UDim2.new(1, -30, 1, -45)
            
            SectionLayout.Parent = SectionContent
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 8)
            
            local SectionObject = {}
            
            local function updateSectionSize()
                local contentSize = SectionLayout.AbsoluteContentSize.Y
                SectionFrame.Size = UDim2.new(1, 0, 0, math.max(60, contentSize + 50))
                TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
            end
            
            SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSectionSize)
            
            function SectionObject:CreateLabel(config)
                config = config or {}
                local text = config.Text or "Label"
                
                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Parent = SectionContent
                Label.BackgroundTransparency = 1
                Label.Size = UDim2.new(1, 0, 0, 25)
                Label.Font = Enum.Font.Gotham
                Label.Text = text
                Label.TextColor3 = theme.Text
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextWrapped = true
                
                updateSectionSize()
                
                return {
                    SetText = function(newText)
                        Label.Text = newText or ""
                    end
                }
            end
            
            function SectionObject:CreateButton(config)
                config = config or {}
                local text = config.Text or "Button"
                local callback = config.Callback or function() end
                
                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")
                local ButtonStroke = Instance.new("UIStroke")
                
                Button.Name = "Button"
                Button.Parent = SectionContent
                Button.BackgroundColor3 = theme.Primary
                Button.Size = UDim2.new(1, 0, 0, 35)
                Button.Font = Enum.Font.GothamSemibold
                Button.Text = text
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 14
                Button.BorderSizePixel = 0
                Button.AutoButtonColor = false
                
                ButtonCorner.CornerRadius = UDim.new(0, 8)
                ButtonCorner.Parent = Button
                
                ButtonStroke.Color = theme.Primary
                ButtonStroke.Thickness = 1
                ButtonStroke.Transparency = 0.5
                ButtonStroke.Parent = Button
                
                Button.MouseEnter:Connect(function()
                    if enableAnimations then
                        TweenService:Create(Button, TweenInfo.new(0.15), {
                            BackgroundColor3 = Color3.fromRGB(
                                math.min(255, theme.Primary.R * 255 + 20),
                                math.min(255, theme.Primary.G * 255 + 20),
                                math.min(255, theme.Primary.B * 255 + 20)
                            )
                        }):Play()
                    end
                end)
                
                Button.MouseLeave:Connect(function()
                    if enableAnimations then
                        TweenService:Create(Button, TweenInfo.new(0.15), {
                            BackgroundColor3 = theme.Primary
                        }):Play()
                    end
                end)
                
                Button.MouseButton1Click:Connect(function()
                    if enableSounds then
                        CreateSound("rbxassetid://131961136", 0.2)
                    end
                    
                    CreateRipple(Button, Mouse.X - Button.AbsolutePosition.X, Mouse.Y - Button.AbsolutePosition.Y)
                    
                    if enableAnimations then
                        local clickTween = TweenService:Create(Button, TweenInfo.new(0.1), {
                            Size = UDim2.new(1, -4, 0, 33)
                        })
                        clickTween:Play()
                        clickTween.Completed:Connect(function()
                            TweenService:Create(Button, TweenInfo.new(0.1), {
                                Size = UDim2.new(1, 0, 0, 35)
                            }):Play()
                        end)
                    end
                    
                    pcall(callback)
                end)
                
                updateSectionSize()
                
                return {
                    SetText = function(newText)
                        Button.Text = newText or ""
                    end,
                    SetCallback = function(newCallback)
                        callback = newCallback or function() end
                    end
                }
            end
            
            function SectionObject:CreateToggle(config)
                config = config or {}
                local text = config.Text or "Toggle"
                local default = config.Default or false
                local callback = config.Callback or function() end
                
                local ToggleFrame = Instance.new("Frame")
                local ToggleCorner = Instance.new("UICorner")
                local ToggleLabel = Instance.new("TextLabel")
                local ToggleButton = Instance.new("TextButton")
                local ToggleButtonCorner = Instance.new("UICorner")
                local ToggleIndicator = Instance.new("Frame")
                local ToggleIndicatorCorner = Instance.new("UICorner")
                
                ToggleFrame.Name = "Toggle"
                ToggleFrame.Parent = SectionContent
                ToggleFrame.BackgroundColor3 = theme.Background
                ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
                ToggleFrame.BorderSizePixel = 0
                
                ToggleCorner.CornerRadius = UDim.new(0, 8)
                ToggleCorner.Parent = ToggleFrame
                
                ToggleLabel.Name = "Label"
                ToggleLabel.Parent = ToggleFrame
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
                ToggleLabel.Size = UDim2.new(1, -80, 1, 0)
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.Text = text
                ToggleLabel.TextColor3 = theme.Text
                ToggleLabel.TextSize = 14
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                ToggleButton.Name = "Button"
                ToggleButton.Parent = ToggleFrame
                ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                ToggleButton.Position = UDim2.new(1, -55, 0.5, -10)
                ToggleButton.Size = UDim2.new(0, 45, 0, 20)
                ToggleButton.Text = ""
                ToggleButton.BorderSizePixel = 0
                
                ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
                ToggleButtonCorner.Parent = ToggleButton
                
                ToggleIndicator.Name = "Indicator"
                ToggleIndicator.Parent = ToggleButton
                ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
                ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
                ToggleIndicator.BorderSizePixel = 0
                
                ToggleIndicatorCorner.CornerRadius = UDim.new(1, 0)
                ToggleIndicatorCorner.Parent = ToggleIndicator
                
                local toggleState = default
                
                local function updateToggle()
                    if enableAnimations then
                        TweenService:Create(ToggleButton, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
                            BackgroundColor3 = toggleState and theme.Success or Color3.fromRGB(60, 60, 70)
                        }):Play()
                        TweenService:Create(ToggleIndicator, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
                            Position = toggleState and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
                        }):Play()
                    else
                        ToggleButton.BackgroundColor3 = toggleState and theme.Success or Color3.fromRGB(60, 60, 70)
                        ToggleIndicator.Position = toggleState and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
                    end
                end
                
                updateToggle()
                
                ToggleButton.MouseButton1Click:Connect(function()
                    toggleState = not toggleState
                    updateToggle()
                    
                    if enableSounds then
                        CreateSound("rbxassetid://131961136", 0.15)
                    end
                    
                    pcall(callback, toggleState)
                end)
                
                updateSectionSize()
                
                return {
                    Set = function(value)
                        toggleState = value
                        updateToggle()
                        pcall(callback, toggleState)
                    end,
                    Get = function()
                        return toggleState
                    end
                }
            end
            
            function SectionObject:CreateSlider(config)
                config = config or {}
                local text = config.Text or "Slider"
                local min = config.Min or 0
                local max = config.Max or 100
                local default = config.Default or min
                local callback = config.Callback or function() end
                local increment = config.Increment or 1
                
                local SliderFrame = Instance.new("Frame")
                local SliderCorner = Instance.new("UICorner")
                local SliderLabel = Instance.new("TextLabel")
                local SliderValue = Instance.new("TextLabel")
                local SliderTrack = Instance.new("Frame")
                local SliderTrackCorner = Instance.new("UICorner")
                local SliderFill = Instance.new("Frame")
                local SliderFillCorner = Instance.new("UICorner")
                local SliderButton = Instance.new("TextButton")
                local SliderButtonCorner = Instance.new("UICorner")
                
                SliderFrame.Name = "Slider"
                SliderFrame.Parent = SectionContent
                SliderFrame.BackgroundColor3 = theme.Background
                SliderFrame.Size = UDim2.new(1, 0, 0, 50)
                SliderFrame.BorderSizePixel = 0
                
                SliderCorner.CornerRadius = UDim.new(0, 8)
                SliderCorner.Parent = SliderFrame
                
                SliderLabel.Name = "Label"
                SliderLabel.Parent = SliderFrame
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Position = UDim2.new(0, 15, 0, 5)
                SliderLabel.Size = UDim2.new(1, -100, 0, 20)
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.Text = text
                SliderLabel.TextColor3 = theme.Text
                SliderLabel.TextSize = 14
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                SliderValue.Name = "Value"
                SliderValue.Parent = SliderFrame
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(1, -80, 0, 5)
                SliderValue.Size = UDim2.new(0, 65, 0, 20)
                SliderValue.Font = Enum.Font.GothamSemibold
                SliderValue.Text = tostring(default)
                SliderValue.TextColor3 = theme.Primary
                SliderValue.TextSize = 14
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                
                SliderTrack.Name = "Track"
                SliderTrack.Parent = SliderFrame
                SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                SliderTrack.Position = UDim2.new(0, 15, 0, 30)
                SliderTrack.Size = UDim2.new(1, -30, 0, 6)
                SliderTrack.BorderSizePixel = 0
                
                SliderTrackCorner.CornerRadius = UDim.new(1, 0)
                SliderTrackCorner.Parent = SliderTrack
                
                SliderFill.Name = "Fill"
                SliderFill.Parent = SliderTrack
                SliderFill.BackgroundColor3 = theme.Primary
                SliderFill.Size = UDim2.new(0, 0, 1, 0)
                SliderFill.BorderSizePixel = 0
                
                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Parent = SliderFill
                
                SliderButton.Name = "Button"
                SliderButton.Parent = SliderTrack
                SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderButton.Position = UDim2.new(0, -6, 0, -3)
                SliderButton.Size = UDim2.new(0, 12, 0, 12)
                SliderButton.Text = ""
                SliderButton.BorderSizePixel = 0
                
                SliderButtonCorner.CornerRadius = UDim.new(1, 0)
                SliderButtonCorner.Parent = SliderButton
                
                local currentValue = default
                local dragging = false
                
                local function updateSlider(value)
                    value = math.clamp(value or currentValue, min, max)
                    if increment > 0 then
                        value = math.floor((value - min) / increment + 0.5) * increment + min
                    end
                    currentValue = value
                    
                    local percent = (currentValue - min) / (max - min)
                    SliderValue.Text = tostring(currentValue)
                    
                    if enableAnimations and not dragging then
                        TweenService:Create(SliderFill, TweenInfo.new(0.15), {
                            Size = UDim2.new(percent, 0, 1, 0)
                        }):Play()
                        TweenService:Create(SliderButton, TweenInfo.new(0.15), {
                            Position = UDim2.new(percent, -6, 0, -3)
                        }):Play()
                    else
                        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                        SliderButton.Position = UDim2.new(percent, -6, 0, -3)
                    end
                    
                    pcall(callback, currentValue)
                end
                
                updateSlider()
                
                SliderButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        if enableSounds then
                            CreateSound("rbxassetid://131961136", 0.1)
                        end
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local percent = math.clamp((Mouse.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                        local value = min + (max - min) * percent
                        updateSlider(value)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                SliderTrack.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local percent = math.clamp((Mouse.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                        local value = min + (max - min) * percent
                        updateSlider(value)
                    end
                end)
                
                updateSectionSize()
                
                return {
                    Set = function(value)
                        updateSlider(value)
                    end,
                    Get = function()
                        return currentValue
                    end
                }
            end
            
            function SectionObject:CreateDropdown(config)
                config = config or {}
                local text = config.Text or "Dropdown"
                local options = config.Options or {"Option 1", "Option 2", "Option 3"}
                local default = config.Default or options[1]
                local callback = config.Callback or function() end
                
                local DropdownFrame = Instance.new("Frame")
                local DropdownCorner = Instance.new("UICorner")
                local DropdownButton = Instance.new("TextButton")
                local DropdownButtonCorner = Instance.new("UICorner")
                local DropdownLabel = Instance.new("TextLabel")
                local DropdownArrow = Instance.new("TextLabel")
                local DropdownList = Instance.new("Frame")
                local DropdownListCorner = Instance.new("UICorner")
                local DropdownScroll = Instance.new("ScrollingFrame")
                local DropdownLayout = Instance.new("UIListLayout")
                
                DropdownFrame.Name = "Dropdown"
                DropdownFrame.Parent = SectionContent
                DropdownFrame.BackgroundColor3 = theme.Background
                DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
                DropdownFrame.BorderSizePixel = 0
                DropdownFrame.ClipsDescendants = true
                
                DropdownCorner.CornerRadius = UDim.new(0, 8)
                DropdownCorner.Parent = DropdownFrame
                
                DropdownButton.Name = "Button"
                DropdownButton.Parent = DropdownFrame
                DropdownButton.BackgroundColor3 = theme.Card
                DropdownButton.Size = UDim2.new(1, 0, 0, 40)
                DropdownButton.Text = ""
                DropdownButton.BorderSizePixel = 0
                
                DropdownButtonCorner.CornerRadius = UDim.new(0, 8)
                DropdownButtonCorner.Parent = DropdownButton
                
                DropdownLabel.Name = "Label"
                DropdownLabel.Parent = DropdownButton
                DropdownLabel.BackgroundTransparency = 1
                DropdownLabel.Position = UDim2.new(0, 15, 0, 0)
                DropdownLabel.Size = UDim2.new(1, -50, 1, 0)
                DropdownLabel.Font = Enum.Font.Gotham
                DropdownLabel.Text = text .. ": " .. default
                DropdownLabel.TextColor3 = theme.Text
                DropdownLabel.TextSize = 14
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                DropdownArrow.Name = "Arrow"
                DropdownArrow.Parent = DropdownButton
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Position = UDim2.new(1, -35, 0, 0)
                DropdownArrow.Size = UDim2.new(0, 20, 1, 0)
                DropdownArrow.Font = Enum.Font.GothamBold
                DropdownArrow.Text = "▼"
                DropdownArrow.TextColor3 = theme.TextSecondary
                DropdownArrow.TextSize = 12
                
                DropdownList.Name = "List"
                DropdownList.Parent = DropdownFrame
                DropdownList.BackgroundColor3 = theme.Card
                DropdownList.Position = UDim2.new(0, 0, 0, 40)
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.BorderSizePixel = 0
                DropdownList.Visible = false
                
                DropdownListCorner.CornerRadius = UDim.new(0, 8)
                DropdownListCorner.Parent = DropdownList
                
                DropdownScroll.Name = "Scroll"
                DropdownScroll.Parent = DropdownList
                DropdownScroll.BackgroundTransparency = 1
                DropdownScroll.Position = UDim2.new(0, 5, 0, 5)
                DropdownScroll.Size = UDim2.new(1, -10, 1, -10)
                DropdownScroll.ScrollBarThickness = 2
                DropdownScroll.ScrollBarImageColor3 = theme.Primary
                DropdownScroll.BorderSizePixel = 0
                
                DropdownLayout.Parent = DropdownScroll
                DropdownLayout.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownLayout.Padding = UDim.new(0, 2)
                
                local currentOption = default
                local isOpen = false
                
                local function createOption(option)
                    local OptionButton = Instance.new("TextButton")
                    local OptionCorner = Instance.new("UICorner")
                    
                    OptionButton.Name = option
                    OptionButton.Parent = DropdownScroll
                    OptionButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    OptionButton.BackgroundTransparency = 1
                    OptionButton.Size = UDim2.new(1, 0, 0, 30)
                    OptionButton.Font = Enum.Font.Gotham
                    OptionButton.Text = option
                    OptionButton.TextColor3 = theme.Text
                    OptionButton.TextSize = 13
                    OptionButton.BorderSizePixel = 0
                    
                    OptionCorner.CornerRadius = UDim.new(0, 6)
                    OptionCorner.Parent = OptionButton
                    
                    OptionButton.MouseEnter:Connect(function()
                        if enableAnimations then
                            TweenService:Create(OptionButton, TweenInfo.new(0.15), {
                                BackgroundTransparency = 0.9
                            }):Play()
                        end
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        if enableAnimations then
                            TweenService:Create(OptionButton, TweenInfo.new(0.15), {
                                BackgroundTransparency = 1
                            }):Play()
                        end
                    end)
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        currentOption = option
                        DropdownLabel.Text = text .. ": " .. option
                        
                        if enableSounds then
                            CreateSound("rbxassetid://131961136", 0.15)
                        end
                        
                        isOpen = false
                        DropdownList.Visible = false
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
                        
                        if enableAnimations then
                            TweenService:Create(DropdownArrow, TweenInfo.new(0.2), {
                                Rotation = 0
                            }):Play()
                        else
                            DropdownArrow.Rotation = 0
                        end
                        
                        pcall(callback, option)
                        updateSectionSize()
                    end)
                end
                
                for _, option in pairs(options) do
                    createOption(option)
                end
                
                DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, DropdownLayout.AbsoluteContentSize.Y)
                
                DropdownButton.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    
                    if enableSounds then
                        CreateSound("rbxassetid://131961136", 0.1)
                    end
                    
                    if isOpen then
                        local listHeight = math.min(120, DropdownLayout.AbsoluteContentSize.Y + 10)
                        DropdownList.Visible = true
                        DropdownList.Size = UDim2.new(1, 0, 0, listHeight)
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 40 + listHeight)
                        
                        if enableAnimations then
                            TweenService:Create(DropdownArrow, TweenInfo.new(0.2), {
                                Rotation = 180
                            }):Play()
                        else
                            DropdownArrow.Rotation = 180
                        end
                    else
                        DropdownList.Visible = false
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
                        
                        if enableAnimations then
                            TweenService:Create(DropdownArrow, TweenInfo.new(0.2), {
                                Rotation = 0
                            }):Play()
                        else
                            DropdownArrow.Rotation = 0
                        end
                    end
                    
                    updateSectionSize()
                end)
                
                updateSectionSize()
                
                return {
                    Set = function(option)
                        if table.find(options, option) then
                            currentOption = option
                            DropdownLabel.Text = text .. ": " .. option
                            pcall(callback, option)
                        end
                    end,
                    Get = function()
                        return currentOption
                    end,
                    SetOptions = function(newOptions)
                        options = newOptions
                        for _, child in pairs(DropdownScroll:GetChildren()) do
                            if child:IsA("TextButton") then
                                child:Destroy()
                            end
                        end
                        for _, option in pairs(options) do
                            createOption(option)
                        end
                        DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, DropdownLayout.AbsoluteContentSize.Y)
                    end
                }
            end
            
            function SectionObject:CreateTextBox(config)
                config = config or {}
                local text = config.Text or "TextBox"
                local placeholder = config.Placeholder or "Enter text..."
                local callback = config.Callback or function() end
                
                local TextBoxFrame = Instance.new("Frame")
                local TextBoxCorner = Instance.new("UICorner")
                local TextBoxLabel = Instance.new("TextLabel")
                local TextBoxInput = Instance.new("TextBox")
                local TextBoxInputCorner = Instance.new("UICorner")
                
                TextBoxFrame.Name = "TextBox"
                TextBoxFrame.Parent = SectionContent
                TextBoxFrame.BackgroundColor3 = theme.Background
                TextBoxFrame.Size = UDim2.new(1, 0, 0, 65)
                TextBoxFrame.BorderSizePixel = 0
                
                TextBoxCorner.CornerRadius = UDim.new(0, 8)
                TextBoxCorner.Parent = TextBoxFrame
                
                TextBoxLabel.Name = "Label"
                TextBoxLabel.Parent = TextBoxFrame
                TextBoxLabel.BackgroundTransparency = 1
                TextBoxLabel.Position = UDim2.new(0, 15, 0, 5)
                TextBoxLabel.Size = UDim2.new(1, -30, 0, 20)
                TextBoxLabel.Font = Enum.Font.Gotham
                TextBoxLabel.Text = text
                TextBoxLabel.TextColor3 = theme.Text
                TextBoxLabel.TextSize = 14
                TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                TextBoxInput.Name = "Input"
                TextBoxInput.Parent = TextBoxFrame
                TextBoxInput.BackgroundColor3 = theme.Card
                TextBoxInput.Position = UDim2.new(0, 15, 0, 30)
                TextBoxInput.Size = UDim2.new(1, -30, 0, 25)
                TextBoxInput.Font = Enum.Font.Gotham
                TextBoxInput.PlaceholderText = placeholder
                TextBoxInput.Text = ""
                TextBoxInput.TextColor3 = theme.Text
                TextBoxInput.TextSize = 13
                TextBoxInput.BorderSizePixel = 0
                TextBoxInput.ClearTextOnFocus = false
                
                TextBoxInputCorner.CornerRadius = UDim.new(0, 6)
                TextBoxInputCorner.Parent = TextBoxInput
                
                TextBoxInput.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        if enableSounds then
                            CreateSound("rbxassetid://131961136", 0.15)
                        end
                        pcall(callback, TextBoxInput.Text)
                    end
                end)
                
                updateSectionSize()
                
                return {
                    SetText = function(newText)
                        TextBoxInput.Text = newText or ""
                    end,
                    GetText = function()
                        return TextBoxInput.Text
                    end
                }
            end
            
            return SectionObject
        end
        
        return TabObject
    end
    
    return WindowObject
end

return ModernUI
