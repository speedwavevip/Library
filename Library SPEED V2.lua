local Library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Mouse = Players.LocalPlayer:GetMouse()

local function PlaySound(soundId)
    for _, sound in pairs(workspace:GetChildren()) do
        if sound.Name == "LibrarySound" then
            sound:Destroy()
        end
    end
    
    local newSound = Instance.new("Sound")
    newSound.Name = "LibrarySound"
    newSound.Parent = workspace
    newSound.Volume = 0.5
    newSound.SoundId = soundId
    newSound:Play()
    
    newSound.Ended:Connect(function()
        newSound:Destroy()
    end)
end

-- Themes
local Themes = {
    ["Dark"] = {
        Primary = Color3.fromRGB(32, 32, 32),
        Secondary = Color3.fromRGB(26, 26, 26), 
        Accent = Color3.fromRGB(176, 148, 255),
        Text = Color3.fromRGB(255, 255, 255),
        IsLight = false
    }
}

function Library:CreateWindow(windowName)
    windowName = windowName or "UI Library"
    local currentTheme = Themes["Dark"]
    
    for _, gui in pairs(game.CoreGui:GetChildren()) do
        if gui.Name == "CleanUI" then gui:Destroy() end
    end

    -- Instances
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local MinimizeButton = Instance.new("TextButton")
    local ContentFrame = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")
    local TabScroll = Instance.new("ScrollingFrame")
    local TabLayout = Instance.new("UIListLayout")
    local ItemContainer = Instance.new("Frame")
    
    ScreenGui.Name = "CleanUI"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = currentTheme.Primary
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = currentTheme.Secondary
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(1, -50, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = windowName
    Title.TextColor3 = currentTheme.Text
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = currentTheme.Text
    CloseButton.TextSize = 18
    
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TopBar
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Position = UDim2.new(1, -65, 0, 5)
    MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = currentTheme.Text
    MinimizeButton.TextSize = 18
    
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 0, 0, 35)
    ContentFrame.Size = UDim2.new(1, 0, 1, -35)
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = ContentFrame
    TabContainer.BackgroundColor3 = currentTheme.Secondary
    TabContainer.Position = UDim2.new(0, 10, 0, 10)
    TabContainer.Size = UDim2.new(0, 150, 1, -20)
    
    TabScroll.Name = "TabScroll"
    TabScroll.Parent = TabContainer
    TabScroll.BackgroundTransparency = 1
    TabScroll.Size = UDim2.new(1, 0, 1, 0)
    TabScroll.ScrollBarThickness = 3
    TabScroll.ScrollBarImageColor3 = currentTheme.Accent
    
    TabLayout.Parent = TabScroll
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 5)
    
    ItemContainer.Name = "ItemContainer"
    ItemContainer.Parent = ContentFrame
    ItemContainer.BackgroundColor3 = currentTheme.Secondary
    ItemContainer.Position = UDim2.new(0, 170, 0, 10)
    ItemContainer.Size = UDim2.new(1, -180, 1, -20)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    local isMinimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            MainFrame.Size = UDim2.new(0, 600, 0, 35)
        else
            MainFrame.Size = UDim2.new(0, 600, 0, 400)
        end
    end)
    
    local WindowObject = {}
    
    function WindowObject:MakeNotifi(title, text, duration)
        duration = duration or 5
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "Notification",
            Text = text or "Message",
            Duration = duration
        })
    end
    
    function WindowObject:KeySystem(key, callback)
        local keyFrame = Instance.new("Frame")
        keyFrame.Name = "KeySystemFrame"
        keyFrame.BackgroundColor3 = currentTheme.Primary
        keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
        keyFrame.Size = UDim2.new(0, 300, 0, 150)
        keyFrame.Parent = ScreenGui
        
        local keyTitle = Instance.new("TextLabel")
        keyTitle.Name = "KeyTitle"
        keyTitle.BackgroundTransparency = 1
        keyTitle.Position = UDim2.new(0, 0, 0, 10)
        keyTitle.Size = UDim2.new(1, 0, 0, 30)
        keyTitle.Font = Enum.Font.SourceSansBold
        keyTitle.Text = "Key System"
        keyTitle.TextColor3 = currentTheme.Text
        keyTitle.TextSize = 20
        keyTitle.Parent = keyFrame
        
        local keyInput = Instance.new("TextBox")
        keyInput.Name = "KeyInput"
        keyInput.BackgroundColor3 = currentTheme.Secondary
        keyInput.Position = UDim2.new(0.5, -100, 0.5, -15)
        keyInput.Size = UDim2.new(0, 200, 0, 30)
        keyInput.Font = Enum.Font.SourceSans
        keyInput.PlaceholderText = "Enter key..."
        keyInput.Text = ""
        keyInput.TextColor3 = currentTheme.Text
        keyInput.TextSize = 14
        keyInput.Parent = keyFrame
        
        local keySubmit = Instance.new("TextButton")
        keySubmit.Name = "KeySubmit"
        keySubmit.BackgroundColor3 = currentTheme.Accent
        keySubmit.Position = UDim2.new(0.5, -50, 0.8, -15)
        keySubmit.Size = UDim2.new(0, 100, 0, 30)
        keySubmit.Font = Enum.Font.SourceSansBold
        keySubmit.Text = "Submit"
        keySubmit.TextColor3 = currentTheme.Text
        keySubmit.TextSize = 14
        keySubmit.Parent = keyFrame
        
        keySubmit.MouseButton1Click:Connect(function()
            if keyInput.Text == key then
                keyFrame:Destroy()
                if callback then
                    callback(true)
                end
            else
                if callback then
                    callback(false)
                end
            end
        end)
    end
    
    function WindowObject:CreateTab(tabName)
        tabName = tabName or "Tab"
        
        local TabButton = Instance.new("TextButton")
        local TabFrame = Instance.new("ScrollingFrame")
        local TabText = Instance.new("TextLabel")
        local ItemLayout = Instance.new("UIListLayout")
        
        TabButton.Name = tabName.."Button"
        TabButton.Parent = TabScroll
        TabButton.BackgroundColor3 = currentTheme.Primary
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.Text = ""
        
        TabText.Name = "TabText"
        TabText.Parent = TabButton
        TabText.BackgroundTransparency = 1
        TabText.Size = UDim2.new(1, -20, 1, 0)
        TabText.Position = UDim2.new(0, 10, 0, 0)
        TabText.Font = Enum.Font.SourceSansSemibold
        TabText.Text = tabName
        TabText.TextColor3 = currentTheme.Text
        TabText.TextSize = 14
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        
        TabFrame.Name = tabName.."Frame"
        TabFrame.Parent = ItemContainer
        TabFrame.BackgroundTransparency = 1
        TabFrame.Size = UDim2.new(1, -20, 1, -20)
        TabFrame.Position = UDim2.new(0, 10, 0, 10)
        TabFrame.Visible = false
        
        ItemLayout.Parent = TabFrame
        ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ItemLayout.Padding = UDim.new(0, 8)
        
        TabButton.MouseButton1Click:Connect(function()
            for _, child in pairs(ItemContainer:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            
            for _, child in pairs(TabScroll:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = currentTheme.Primary
                end
            end
            
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = currentTheme.Accent
        end)
        
        local TabObject = {}
        
        function TabObject:CreateLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Parent = TabFrame
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(1, 0, 0, 30)
            Label.Font = Enum.Font.SourceSansSemibold
            Label.Text = text or "Label"
            Label.TextColor3 = currentTheme.Text
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            return {
                SetText = function(newText)
                    Label.Text = newText or ""
                end
            }
        end

        function TabObject:CreateButton(config)
            config = config or {}
            local Button = Instance.new("TextButton")
            local UICorner = Instance.new("UICorner")
            
            Button.Name = "Button"
            Button.Parent = TabFrame
            Button.BackgroundColor3 = currentTheme.Primary
            Button.Size = UDim2.new(1, 0, 0, 35)
            Button.Text = config.Name or "Button"
            Button.TextColor3 = currentTheme.Text
            Button.TextSize = 14
            Button.AutoButtonColor = false
            
            UICorner.CornerRadius = UDim.new(0, 5)
            UICorner.Parent = Button
            
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    BackgroundColor3 = Color3.fromRGB(
                        math.floor(currentTheme.Primary.R * 255 + 20),
                        math.floor(currentTheme.Primary.G * 255 + 20),
                        math.floor(currentTheme.Primary.B * 255 + 20)
                    )
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    BackgroundColor3 = currentTheme.Primary
                }):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                if config.Callback then
                    pcall(config.Callback)
                end
            end)
            
            return {
                SetText = function(text)
                    Button.Text = text or ""
                end,
                SetCallback = function(callback)
                    config.Callback = callback
                end
            }
        end

        function TabObject:CreateToggle(config)
            config = config or {}
            local Toggle = {}
            Toggle.Value = config.CurrentValue or false
            
            local ToggleFrame = Instance.new("Frame")
            local ToggleCorner = Instance.new("UICorner")
            local ToggleLabel = Instance.new("TextLabel")
            local ToggleButton = Instance.new("TextButton")
            local ToggleButtonCorner = Instance.new("UICorner")
            local ToggleIndicator = Instance.new("Frame")
            local ToggleIndicatorCorner = Instance.new("UICorner")
            
            ToggleFrame.Name = "Toggle"
            ToggleFrame.Parent = TabFrame
            ToggleFrame.BackgroundColor3 = currentTheme.Primary
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
            
            ToggleCorner.CornerRadius = UDim.new(0, 5)
            ToggleCorner.Parent = ToggleFrame
            
            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.Size = UDim2.new(0, 200, 1, 0)
            ToggleLabel.Text = config.Name or "Toggle"
            ToggleLabel.TextColor3 = currentTheme.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleButton.Text = ""
            
            ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
            ToggleButtonCorner.Parent = ToggleButton
            
            ToggleIndicator.Name = "ToggleIndicator"
            ToggleIndicator.Parent = ToggleButton
            ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
            
            ToggleIndicatorCorner.CornerRadius = UDim.new(1, 0)
            ToggleIndicatorCorner.Parent = ToggleIndicator
            
            local function updateToggle()
                if Toggle.Value then
                    TweenService:Create(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        BackgroundColor3 = currentTheme.Accent
                    }):Play()
                    TweenService:Create(ToggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        Position = UDim2.new(1, -18, 0, 2)
                    }):Play()
                else
                    TweenService:Create(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        BackgroundColor3 = Color3.fromRGB(60, 60, 65)
                    }):Play()
                    TweenService:Create(ToggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        Position = UDim2.new(0, 2, 0, 2)
                    }):Play()
                end
            end
            
            updateToggle()
            
            ToggleButton.MouseButton1Click:Connect(function()
                Toggle.Value = not Toggle.Value
                updateToggle()
                if config.Callback then
                    pcall(config.Callback, Toggle.Value)
                end
            end)
            
            function Toggle:Set(value)
                if Toggle.Value ~= value then
                    Toggle.Value = value
                    updateToggle()
                    if config.Callback then
                        pcall(config.Callback, Toggle.Value)
                    end
                end
            end
            
            function Toggle:Get()
                return Toggle.Value
            end
            
            return Toggle
        end
        
        function TabObject:CreateDiscordButton()
            local Discord = Instance.new("TextButton")
            local UICorner = Instance.new("UICorner")
            local Disc_Logo = Instance.new("ImageLabel")
            local Disc_Title = Instance.new("TextLabel")
            
            Discord.Name = "Discord"
            Discord.Parent = TabFrame
            Discord.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Discord.BorderSizePixel = 0
            Discord.Position = UDim2.new(0, 0, 0, 0)
            Discord.Size = UDim2.new(0, 120, 0, 30)
            Discord.AutoButtonColor = false
            Discord.Text = ""
            
            UICorner.CornerRadius = UDim.new(0, 5)
            UICorner.Parent = Discord
            
            Disc_Logo.Name = "Disc_Logo"
            Disc_Logo.Parent = Discord
            Disc_Logo.BackgroundTransparency = 1
            Disc_Logo.Position = UDim2.new(0, 5, 0.5, -10)
            Disc_Logo.Size = UDim2.new(0, 20, 0, 20)
            Disc_Logo.Image = "http://www.roblox.com/asset/?id=12058969086"
            
            Disc_Title.Name = "Disc_Title"
            Disc_Title.Parent = Discord
            Disc_Title.BackgroundTransparency = 1
            Disc_Title.Position = UDim2.new(0, 30, 0, 0)
            Disc_Title.Size = UDim2.new(0, 80, 1, 0)
            Disc_Title.Font = Enum.Font.SourceSansSemibold
            Disc_Title.Text = "Discord"
            Disc_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Disc_Title.TextSize = 14
            Disc_Title.TextXAlignment = Enum.TextXAlignment.Left
            
            Discord.MouseEnter:Connect(function()
                TweenService:Create(Discord, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                }):Play()
                TweenService:Create(Disc_Logo, TweenInfo.new(0.15), {
                    ImageTransparency = 0.7
                }):Play()
                TweenService:Create(Disc_Title, TweenInfo.new(0.15), {
                    TextTransparency = 0.7
                }):Play()
            end)
            
            Discord.MouseLeave:Connect(function()
                TweenService:Create(Discord, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                }):Play()
                TweenService:Create(Disc_Logo, TweenInfo.new(0.15), {
                    ImageTransparency = 0
                }):Play()
                TweenService:Create(Disc_Title, TweenInfo.new(0.15), {
                    TextTransparency = 0
                }):Play()
            end)
            
            Discord.MouseButton1Click:Connect(function()
                if setclipboard then
                    setclipboard("https://discord.gg/SPEEDWAVE")
                elseif toclipboard then
                    toclipboard("https://discord.gg/SPEEDWAVE")
                end
                
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Discord",
                    Text = "Discord link copied to clipboard",
                    Button1 = "Okay",
                    Duration = 5
                })
            end)
            
            return Discord
        end
        
        if #TabScroll:GetChildren() == 1 then
            TabButton.BackgroundColor3 = currentTheme.Accent
            TabFrame.Visible = true
        end
        
        return TabObject
    end
    
    return WindowObject
end

return Library
