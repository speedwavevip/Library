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

local Themes = {
    ["Dark"] = {
        Primary = Color3.fromRGB(32, 32, 32),
        Secondary = Color3.fromRGB(26, 26, 26), 
        Accent = Color3.fromRGB(176, 148, 255),
        Text = Color3.fromRGB(255, 255, 255),
        IsLight = false
    },
    
    ["Blood"] = {
        Primary = Color3.fromRGB(32, 32, 32),
        Secondary = Color3.fromRGB(26, 26, 26),
        Accent = Color3.fromRGB(138, 3, 3),
        Text = Color3.fromRGB(255, 255, 255),
        IsLight = false
    },
    
    ["Ocean"] = {
        Primary = Color3.fromRGB(32, 32, 32),
        Secondary = Color3.fromRGB(26, 26, 26),
        Accent = Color3.fromRGB(0, 162, 255),
        Text = Color3.fromRGB(255, 255, 255),
        IsLight = false
    },
    
    ["Emerald"] = {
        Primary = Color3.fromRGB(32, 32, 32),
        Secondary = Color3.fromRGB(26, 26, 26),
        Accent = Color3.fromRGB(68, 207, 108),
        Text = Color3.fromRGB(255, 255, 255),
        IsLight = false
    },
    
    ["Red"] = {
        Primary = Color3.fromRGB(32, 32, 32),
        Secondary = Color3.fromRGB(26, 26, 26),
        Accent = Color3.fromRGB(255, 0, 0),
        Text = Color3.fromRGB(255, 0, 0),
        IsLight = true
    }
}

function Library:CreateWindow(windowName, themeName)
    windowName = windowName or "Modern GUI"
    themeName = themeName or "Dark"
    
    local currentTheme = Themes[themeName] or Themes["Dark"]
    
    for _, gui in pairs(game.CoreGui:GetChildren()) do
        if gui.Name == "ModernGUI" then
            gui:Destroy()
        end
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local ToggleButton = Instance.new("TextButton")
    local ContentFrame = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")
    local TabScroll = Instance.new("ScrollingFrame")
    local TabLayout = Instance.new("UIListLayout")
    local ItemContainer = Instance.new("Frame")
    
    ScreenGui.Name = "ModernGUI"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = currentTheme.Primary
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame
    
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = currentTheme.Secondary
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 8)
    TopCorner.Parent = TopBar
    
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
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = TopBar
    ToggleButton.BackgroundTransparency = 1
    ToggleButton.Position = UDim2.new(1, -35, 0, 5)
    ToggleButton.Size = UDim2.new(0, 25, 0, 25)
    ToggleButton.Font = Enum.Font.SourceSansBold
    ToggleButton.Text = "-"
    ToggleButton.TextColor3 = currentTheme.Text
    ToggleButton.TextSize = 18
    
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 0, 0, 35)
    ContentFrame.Size = UDim2.new(1, 0, 1, -35)
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = ContentFrame
    TabContainer.BackgroundColor3 = currentTheme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 10, 0, 10)
    TabContainer.Size = UDim2.new(0, 150, 1, -20)
    TabContainer.ClipsDescendants = true
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabContainer
    
    TabScroll.Name = "TabScroll"
    TabScroll.Parent = TabContainer
    TabScroll.BackgroundTransparency = 1
    TabScroll.BorderSizePixel = 0
    TabScroll.Position = UDim2.new(0, 5, 0, 5)
    TabScroll.Size = UDim2.new(1, -10, 1, -10)
    TabScroll.ScrollBarThickness = 3
    TabScroll.ScrollBarImageColor3 = currentTheme.Accent
    TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    TabLayout.Parent = TabScroll
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 5)
    
    ItemContainer.Name = "ItemContainer"
    ItemContainer.Parent = ContentFrame
    ItemContainer.BackgroundColor3 = currentTheme.Secondary
    ItemContainer.BorderSizePixel = 0
    ItemContainer.Position = UDim2.new(0, 170, 0, 10)
    ItemContainer.Size = UDim2.new(1, -180, 1, -20)
    
    local ItemCorner = Instance.new("UICorner")
    ItemCorner.CornerRadius = UDim.new(0, 6)
    ItemCorner.Parent = ItemContainer
    
    local isMinimized = false
    ToggleButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        PlaySound("rbxassetid://131961136")
        
        if isMinimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 600, 0, 35)}):Play()
            ToggleButton.Text = "+"
            ContentFrame.Visible = false
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 600, 0, 400)}):Play()
            ToggleButton.Text = "-"
            ContentFrame.Visible = true
        end
    end)
    
    local WindowObject = {}

    function WindowObject:CreateTab(tabName, icon)
    tabName = tabName or "New Tab"

    local TabButton = Instance.new("TextButton")
    local TabFrame = Instance.new("ScrollingFrame")
    local ItemLayout = Instance.new("UIListLayout")
    local TabText = Instance.new("TextLabel")

    TabButton.Name = tabName .. "Button"
    TabButton.Parent = TabScroll
    TabButton.BackgroundColor3 = currentTheme.Primary
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, -10, 0, 35)
    TabButton.Font = Enum.Font.SourceSansSemibold
    TabButton.Text = ""
    TabButton.TextColor3 = currentTheme.Text
    TabButton.TextSize = 14

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Parent = TabButton

    if icon then
        local IconLabel = Instance.new("TextLabel")
        IconLabel.Name = "Icon"
        IconLabel.Parent = TabButton
        IconLabel.BackgroundTransparency = 1
        IconLabel.Position = UDim2.new(0, 10, 0, 0)
        IconLabel.Size = UDim2.new(0, 20, 1, 0)
        IconLabel.Font = Enum.Font.FontAwesome
        IconLabel.Text = icon
        IconLabel.TextColor3 = currentTheme.Text
        IconLabel.TextSize = 14
        IconLabel.TextXAlignment = Enum.TextXAlignment.Left
    end

    TabText.Name = "TabText"
    TabText.Parent = TabButton
    TabText.BackgroundTransparency = 1
    TabText.Position = UDim2.new(0, icon and 35 or 10, 0, 0)
    TabText.Size = UDim2.new(1, icon and -40 or -20, 1, 0)
    TabText.Font = Enum.Font.SourceSansSemibold
    TabText.Text = tabName
    TabText.TextColor3 = currentTheme.Text
    TabText.TextSize = 14
    TabText.TextXAlignment = Enum.TextXAlignment.Left

    TabFrame.Name = tabName .. "Frame"
    TabFrame.Parent = ItemContainer
    TabFrame.BackgroundTransparency = 1
    TabFrame.BorderSizePixel = 0
    TabFrame.Position = UDim2.new(0, -6, 0, 10)
    TabFrame.Size = UDim2.new(1, -20, 1, -20)
    TabFrame.ScrollBarThickness = 3
    TabFrame.ScrollBarImageColor3 = currentTheme.Accent
    TabFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
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
                TweenService:Create(child, TweenInfo.new(0.15), {
                    BackgroundColor3 = currentTheme.Primary,
                    TextColor3 = currentTheme.Text
                }):Play()
            end
        end

        TabFrame.Visible = true
        TweenService:Create(TabButton, TweenInfo.new(0.15), {
            BackgroundColor3 = currentTheme.Accent,
            TextColor3 = currentTheme.IsLight and currentTheme.Primary or Color3.fromRGB(255, 255, 255)
        }):Play()

        PlaySound("rbxassetid://131961136")
    end)

    ItemLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, ItemLayout.AbsoluteContentSize.Y + 10)
    end)

    local TabObject = {}

    return TabObject
end

        function TabObject:CreateButton(buttonText, callback)
            buttonText = buttonText or "Button"
            callback = callback or function() end
            
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Parent = TabFrame
            Button.BackgroundColor3 = currentTheme.Primary
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(1, 0, 0, 35)
            Button.Font = Enum.Font.SourceSansSemibold
            Button.Text = buttonText
            Button.TextColor3 = currentTheme.Text
            Button.TextSize = 14
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Parent = Button
            
            Button.MouseButton1Click:Connect(function()
                PlaySound("rbxassetid://131961136")
                pcall(callback)
            end)
            
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    BackgroundColor3 = currentTheme.Accent
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    BackgroundColor3 = currentTheme.Primary
                }):Play()
            end)
            
            return Button
        end

        function TabObject:CreateLabel(labelText)
            labelText = labelText or "Label"
            
            local LabelFrame = Instance.new("Frame")
            local Label = Instance.new("TextLabel")
            local Padding = Instance.new("UIPadding")
            
            LabelFrame.Name = "LabelFrame"
            LabelFrame.Parent = TabFrame
            LabelFrame.BackgroundColor3 = currentTheme.Primary
            LabelFrame.BorderSizePixel = 0
            LabelFrame.Size = UDim2.new(1, 0, 0, 35)
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = LabelFrame
            
            Padding.Parent = LabelFrame
            Padding.PaddingLeft = UDim.new(0, 10)
            
            Label.Name = "Label"
            Label.Parent = LabelFrame
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(1, -10, 1, 0)
            Label.Font = Enum.Font.SourceSansSemibold
            Label.Text = labelText
            Label.TextColor3 = currentTheme.Text
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            return {
                SetText = function(newText)
                    Label.Text = newText or ""
                end,
                SetColor = function(color)
                    Label.TextColor3 = color or currentTheme.Text
                end,
                SetBackground = function(color)
                    LabelFrame.BackgroundColor3 = color or currentTheme.Primary
                end
            }
        end
        
        function TabObject:CreateTextBox(textBoxText, placeholder, callback)
            textBoxText = textBoxText or "Text Box"
            placeholder = placeholder or "Enter text..."
            callback = callback or function() end
            
            local TextBoxFrame = Instance.new("Frame")
            local TextBoxLabel = Instance.new("TextLabel")
            local TextBox = Instance.new("TextBox")
            
            TextBoxFrame.Name = "TextBoxFrame"
            TextBoxFrame.Parent = TabFrame
            TextBoxFrame.BackgroundColor3 = currentTheme.Primary
            TextBoxFrame.BorderSizePixel = 0
            TextBoxFrame.Size = UDim2.new(1, 0, 0, 60)
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = TextBoxFrame
            
            TextBoxLabel.Name = "Label"
            TextBoxLabel.Parent = TextBoxFrame
            TextBoxLabel.BackgroundTransparency = 1
            TextBoxLabel.Position = UDim2.new(0, 10, 0, 5)
            TextBoxLabel.Size = UDim2.new(1, -20, 0, 15)
            TextBoxLabel.Font = Enum.Font.SourceSansSemibold
            TextBoxLabel.Text = textBoxText
            TextBoxLabel.TextColor3 = currentTheme.Text
            TextBoxLabel.TextSize = 14
            TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            TextBox.Name = "TextBox"
            TextBox.Parent = TextBoxFrame
            TextBox.BackgroundColor3 = currentTheme.Secondary
            TextBox.BorderSizePixel = 0
            TextBox.Position = UDim2.new(0, 10, 0, 25)
            TextBox.Size = UDim2.new(1, -20, 0, 25)
            TextBox.Font = Enum.Font.SourceSans
            TextBox.PlaceholderText = placeholder
            TextBox.Text = ""
            TextBox.TextColor3 = currentTheme.Text
            TextBox.TextSize = 14
            
            local TextBoxCorner = Instance.new("UICorner")
            TextBoxCorner.CornerRadius = UDim.new(0, 4)
            TextBoxCorner.Parent = TextBox
            
            TextBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    pcall(callback, TextBox.Text)
                end
            end)
            
            return {
                SetText = function(text)
                    TextBox.Text = text or ""
                end,
                GetText = function()
                    return TextBox.Text
                end
            }
        end
        
        function TabObject:CreateDiscord(inviteCode)
            inviteCode = inviteCode or "discord.gg/example"
            
            local DiscordFrame = Instance.new("Frame")
            local DiscordLabel = Instance.new("TextLabel")
            local DiscordButton = Instance.new("TextButton")
            
            DiscordFrame.Name = "DiscordFrame"
            DiscordFrame.Parent = TabFrame
            DiscordFrame.BackgroundColor3 = currentTheme.Primary
            DiscordFrame.BorderSizePixel = 0
            DiscordFrame.Size = UDim2.new(1, 0, 0, 35)
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = DiscordFrame
            
            DiscordLabel.Name = "Label"
            DiscordLabel.Parent = DiscordFrame
            DiscordLabel.BackgroundTransparency = 1
            DiscordLabel.Position = UDim2.new(0, 10, 0, 0)
            DiscordLabel.Size = UDim2.new(0, 100, 1, 0)
            DiscordLabel.Font = Enum.Font.SourceSansSemibold
            DiscordLabel.Text = "Discord:"
            DiscordLabel.TextColor3 = currentTheme.Text
            DiscordLabel.TextSize = 14
            DiscordLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            DiscordButton.Name = "Button"
            DiscordButton.Parent = DiscordFrame
            DiscordButton.BackgroundColor3 = currentTheme.Accent
            DiscordButton.BorderSizePixel = 0
            DiscordButton.Position = UDim2.new(0, 120, 0.5, -12)
            DiscordButton.Size = UDim2.new(0, 120, 0, 24)
            DiscordButton.Font = Enum.Font.SourceSansSemibold
            DiscordButton.Text = inviteCode
            DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DiscordButton.TextSize = 14
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Parent = DiscordButton
            
            DiscordButton.MouseButton1Click:Connect(function()
                PlaySound("rbxassetid://131961136")
                setclipboard("https://"..inviteCode)
            end)
        end
        
        function TabObject:AddColorPicker(colorText, defaultColor, callback)
            colorText = colorText or "Color Picker"
            defaultColor = defaultColor or Color3.fromRGB(255, 0, 0)
            callback = callback or function() end
            
            local ColorFrame = Instance.new("Frame")
            local ColorLabel = Instance.new("TextLabel")
            local ColorButton = Instance.new("TextButton")
            local ColorPreview = Instance.new("Frame")
            
            ColorFrame.Name = "ColorFrame"
            ColorFrame.Parent = TabFrame
            ColorFrame.BackgroundColor3 = currentTheme.Primary
            ColorFrame.BorderSizePixel = 0
            ColorFrame.Size = UDim2.new(1, 0, 0, 35)
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = ColorFrame
            
            ColorLabel.Name = "Label"
            ColorLabel.Parent = ColorFrame
            ColorLabel.BackgroundTransparency = 1
            ColorLabel.Position = UDim2.new(0, 10, 0, 0)
            ColorLabel.Size = UDim2.new(0, 100, 1, 0)
            ColorLabel.Font = Enum.Font.SourceSansSemibold
            ColorLabel.Text = colorText
            ColorLabel.TextColor3 = currentTheme.Text
            ColorLabel.TextSize = 14
            ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            ColorButton.Name = "Button"
            ColorButton.Parent = ColorFrame
            ColorButton.BackgroundColor3 = currentTheme.Secondary
            ColorButton.BorderSizePixel = 0
            ColorButton.Position = UDim2.new(1, -50, 0.5, -10)
            ColorButton.Size = UDim2.new(0, 40, 0, 20)
            ColorButton.Text = ""
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Parent = ColorButton
            
            ColorPreview.Name = "Preview"
            ColorPreview.Parent = ColorButton
            ColorPreview.BackgroundColor3 = defaultColor
            ColorPreview.BorderSizePixel = 0
            ColorPreview.Position = UDim2.new(0, 2, 0, 2)
            ColorPreview.Size = UDim2.new(1, -4, 1, -4)
            
            local PreviewCorner = Instance.new("UICorner")
            PreviewCorner.CornerRadius = UDim.new(0, 2)
            PreviewCorner.Parent = ColorPreview
            
            ColorButton.MouseButton1Click:Connect(function()
                local colorPicker = Instance.new("Frame")
                local colorMap = Instance.new("ImageButton")
                local colorCursor = Instance.new("Frame")
                local hueSlider = Instance.new("ImageButton")
                local hueCursor = Instance.new("Frame")
                local confirmButton = Instance.new("TextButton")
                
                colorPicker.Name = "ColorPicker"
                colorPicker.Parent = game.CoreGui
                colorPicker.BackgroundColor3 = currentTheme.Primary
                colorPicker.BorderSizePixel = 0
                colorPicker.Position = UDim2.new(0.5, -150, 0.5, -100)
                colorPicker.Size = UDim2.new(0, 300, 0, 200)
                colorPicker.ZIndex = 100
                
                local colorPickerCorner = Instance.new("UICorner")
                colorPickerCorner.CornerRadius = UDim.new(0, 8)
                colorPickerCorner.Parent = colorPicker
                
                colorMap.Name = "ColorMap"
                colorMap.Parent = colorPicker
                colorMap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorMap.BorderSizePixel = 0
                colorMap.Position = UDim2.new(0, 10, 0, 10)
                colorMap.Size = UDim2.new(0, 200, 0, 150)
                colorMap.Image = "rbxassetid://2615689005"
                colorMap.ZIndex = 101
                
                colorCursor.Name = "ColorCursor"
                colorCursor.Parent = colorMap
                colorCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorCursor.BorderColor3 = Color3.fromRGB(0, 0, 0)
                colorCursor.BorderSizePixel = 2
                colorCursor.Size = UDim2.new(0, 8, 0, 8)
                colorCursor.ZIndex = 103
                
                hueSlider.Name = "HueSlider"
                hueSlider.Parent = colorPicker
                hueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                hueSlider.BorderSizePixel = 0
                hueSlider.Position = UDim2.new(0, 220, 0, 10)
                hueSlider.Size = UDim2.new(0, 20, 0, 150)
                hueSlider.Image = "rbxassetid://2615692420"
                hueSlider.ZIndex = 101
                
                hueCursor.Name = "HueCursor"
                hueCursor.Parent = hueSlider
                hueCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                hueCursor.BorderColor3 = Color3.fromRGB(0, 0, 0)
                hueCursor.BorderSizePixel = 2
                hueCursor.Size = UDim2.new(1, 0, 0, 2)
                hueCursor.ZIndex = 103
                
                confirmButton.Name = "ConfirmButton"
                confirmButton.Parent = colorPicker
                confirmButton.BackgroundColor3 = currentTheme.Accent
                confirmButton.BorderSizePixel = 0
                confirmButton.Position = UDim2.new(0, 10, 0, 170)
                confirmButton.Size = UDim2.new(1, -20, 0, 20)
                confirmButton.Font = Enum.Font.SourceSansBold
                confirmButton.Text = "Confirm"
                confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                confirmButton.TextSize = 14
                confirmButton.ZIndex = 101
                
                local confirmCorner = Instance.new("UICorner")
                confirmCorner.CornerRadius = UDim.new(0, 4)
                confirmCorner.Parent = confirmButton
                
                local h, s, v = defaultColor:ToHSV()
                hueCursor.Position = UDim2.new(0, 0, 0, (1 - h) * 150)
                colorCursor.Position = UDim2.new(0, s * 200 - 4, 0, (1 - v) * 150 - 4)
                
                local function updateColor()
                    local hue = 1 - (hueCursor.Position.Y.Offset / 150)
                    local sat = (colorCursor.Position.X.Offset + 4) / 200
                    local val = 1 - (colorCursor.Position.Y.Offset + 4) / 150
                    local newColor = Color3.fromHSV(hue, sat, val)
                    ColorPreview.BackgroundColor3 = newColor
                    pcall(callback, newColor)
                end
                
                hueSlider.MouseButton1Down:Connect(function(x, y)
                    local pos = y - hueSlider.AbsolutePosition.Y
                    hueCursor.Position = UDim2.new(0, 0, 0, math.clamp(pos, 0, 150))
                    updateColor()
                end)
                
                colorMap.MouseButton1Down:Connect(function(x, y)
                    local xPos = x - colorMap.AbsolutePosition.X
                    local yPos = y - colorMap.AbsolutePosition.Y
                    colorCursor.Position = UDim2.new(0, math.clamp(xPos - 4, -4, 196), 0, math.clamp(yPos - 4, -4, 146))
                    updateColor()
                end)
                
                confirmButton.MouseButton1Click:Connect(function()
                    colorPicker:Destroy()
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        if hueSlider:IsActive() then
                            local pos = input.Position.Y - hueSlider.AbsolutePosition.Y
                            hueCursor.Position = UDim2.new(0, 0, 0, math.clamp(pos, 0, 150))
                            updateColor()
                        elseif colorMap:IsActive() then
                            local xPos = input.Position.X - colorMap.AbsolutePosition.X
                            local yPos = input.Position.Y - colorMap.AbsolutePosition.Y
                            colorCursor.Position = UDim2.new(0, math.clamp(xPos - 4, -4, 196), 0, math.clamp(yPos - 4, -4, 146))
                            updateColor()
                        end
                    end
                end)
            end)
            
            return {
                SetColor = function(color)
                    ColorPreview.BackgroundColor3 = color
                end,
                GetColor = function()
                    return ColorPreview.BackgroundColor3
                end
            }
        end
        
        function TabObject:Paragraph(text)
            text = text or "Paragraph text goes here..."
            
            local ParagraphFrame = Instance.new("Frame")
            local ParagraphLabel = Instance.new("TextLabel")
            local Padding = Instance.new("UIPadding")
            
            ParagraphFrame.Name = "ParagraphFrame"
            ParagraphFrame.Parent = TabFrame
            ParagraphFrame.BackgroundColor3 = currentTheme.Primary
            ParagraphFrame.BorderSizePixel = 0
            ParagraphFrame.Size = UDim2.new(1, 0, 0, 0)
            ParagraphFrame.AutomaticSize = Enum.AutomaticSize.Y
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = ParagraphFrame
            
            Padding.Parent = ParagraphFrame
            Padding.PaddingLeft = UDim.new(0, 10)
            Padding.PaddingRight = UDim.new(0, 10)
            Padding.PaddingTop = UDim.new(0, 10)
            Padding.PaddingBottom = UDim.new(0, 10)
            
            ParagraphLabel.Name = "Label"
            ParagraphLabel.Parent = ParagraphFrame
            ParagraphLabel.BackgroundTransparency = 1
            ParagraphLabel.Size = UDim2.new(1, -20, 0, 0)
            ParagraphLabel.Font = Enum.Font.SourceSans
            ParagraphLabel.Text = text
            ParagraphLabel.TextColor3 = currentTheme.Text
            ParagraphLabel.TextSize = 14
            ParagraphLabel.TextWrapped = true
            ParagraphLabel.TextXAlignment = Enum.TextXAlignment.Left
            ParagraphLabel.AutomaticSize = Enum.AutomaticSize.Y
            
            return {
                SetText = function(newText)
                    ParagraphLabel.Text = newText or ""
                end
            }
        end
        
        function TabObject:MakeNotifi(title, message, duration)
            title = title or "Notification"
            message = message or "This is a notification"
            duration = duration or 5
            
            local Notification = Instance.new("Frame")
            local TitleLabel = Instance.new("TextLabel")
            local MessageLabel = Instance.new("TextLabel")
            local CloseButton = Instance.new("TextButton")
            
            Notification.Name = "Notification"
            Notification.Parent = ScreenGui
            Notification.BackgroundColor3 = currentTheme.Primary
            Notification.BorderSizePixel = 0
            Notification.Position = UDim2.new(1, 5, 1, -100)
            Notification.Size = UDim2.new(0, 250, 0, 80)
            Notification.ZIndex = 100
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Notification
            
            TitleLabel.Name = "Title"
            TitleLabel.Parent = Notification
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 10, 0, 5)
            TitleLabel.Size = UDim2.new(1, -30, 0, 20)
            TitleLabel.Font = Enum.Font.SourceSansBold
            TitleLabel.Text = title
            TitleLabel.TextColor3 = currentTheme.Text
            TitleLabel.TextSize = 16
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            TitleLabel.ZIndex = 101
            
            MessageLabel.Name = "Message"
            MessageLabel.Parent = Notification
            MessageLabel.BackgroundTransparency = 1
            MessageLabel.Position = UDim2.new(0, 10, 0, 30)
            MessageLabel.Size = UDim2.new(1, -20, 1, -40)
            MessageLabel.Font = Enum.Font.SourceSans
            MessageLabel.Text = message
            MessageLabel.TextColor3 = currentTheme.Text
            MessageLabel.TextSize = 14
            MessageLabel.TextWrapped = true
            MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
            MessageLabel.ZIndex = 101
            
            CloseButton.Name = "CloseButton"
            CloseButton.Parent = Notification
            CloseButton.BackgroundTransparency = 1
            CloseButton.Position = UDim2.new(1, -25, 0, 5)
            CloseButton.Size = UDim2.new(0, 20, 0, 20)
            CloseButton.Font = Enum.Font.SourceSansBold
            CloseButton.Text = "X"
            CloseButton.TextColor3 = currentTheme.Text
            CloseButton.TextSize = 16
            CloseButton.ZIndex = 101
            
            TweenService:Create(Notification, TweenInfo.new(0.3), {
                Position = UDim2.new(1, -255, 1, -100)
            }):Play()
            
            CloseButton.MouseButton1Click:Connect(function()
                TweenService:Create(Notification, TweenInfo.new(0.3), {
                    Position = UDim2.new(1, 5, 1, -100)
                }):Play()
                wait(0.3)
                Notification:Destroy()
            end)
            
            delay(duration, function()
                if Notification then
                    TweenService:Create(Notification, TweenInfo.new(0.3), {
                        Position = UDim2.new(1, 5, 1, -100)
                    }):Play()
                    wait(0.3)
                    Notification:Destroy()
                end
            end)
        end
        
        function TabObject:CreateToggle(toggleText, defaultState, callback)
            toggleText = toggleText or "Toggle"
            defaultState = defaultState or false
            callback = callback or function() end
            
            local ToggleFrame = Instance.new("Frame")
            local ToggleLabel = Instance.new("TextLabel")
            local ToggleButton = Instance.new("TextButton")
            local ToggleIndicator = Instance.new("Frame")
            
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = TabFrame
            ToggleFrame.BackgroundColor3 = currentTheme.Primary
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 4)
            ToggleCorner.Parent = ToggleFrame
            
            ToggleLabel.Name = "Label"
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
            ToggleLabel.Font = Enum.Font.SourceSansSemibold
            ToggleLabel.Text = toggleText
            ToggleLabel.TextColor3 = currentTheme.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            ToggleButton.Name = "Button"
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundColor3 = currentTheme.Secondary
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
            ToggleButton.Size = UDim2.new(0, 35, 0, 20)
            ToggleButton.Text = ""
            
            local ToggleBtnCorner = Instance.new("UICorner")
            ToggleBtnCorner.CornerRadius = UDim.new(0, 10)
            ToggleBtnCorner.Parent = ToggleButton
            
            ToggleIndicator.Name = "Indicator"
            ToggleIndicator.Parent = ToggleButton
            ToggleIndicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
            ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            
            local IndicatorCorner = Instance.new("UICorner")
            IndicatorCorner.CornerRadius = UDim.new(0, 8)
            IndicatorCorner.Parent = ToggleIndicator
            
            local isEnabled = defaultState
            
            local function UpdateToggle()
                if isEnabled then
                    TweenService:Create(ToggleButton, TweenInfo.new(0.1), {
                        BackgroundColor3 = currentTheme.Accent
                    }):Play()
                    TweenService:Create(ToggleIndicator, TweenInfo.new(0.1), {
                        Position = UDim2.new(1, -18, 0, 2),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    }):Play()
                else
                    TweenService:Create(ToggleButton, TweenInfo.new(0.1), {
                        BackgroundColor3 = currentTheme.Secondary
                    }):Play()
                    TweenService:Create(ToggleIndicator, TweenInfo.new(0.1), {
                        Position = UDim2.new(0, 2, 0, 2),
                        BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                    }):Play()
                end
                pcall(callback, isEnabled)
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                isEnabled = not isEnabled
                PlaySound("rbxassetid://131961136")
                UpdateToggle()
            end)
            
            UpdateToggle()
            
            return {
                SetState = function(state)
                    isEnabled = state
                    UpdateToggle()
                end,
                GetState = function()
                    return isEnabled
                end
            }
        end        

        function TabObject:CreateSlider(sliderText, minValue, maxValue, defaultValue, callback)
            sliderText = sliderText or "Slider"
            minValue = minValue or 0
            maxValue = maxValue or 100
            defaultValue = defaultValue or minValue
            callback = callback or function() end
            
            local SliderFrame = Instance.new("Frame")
            local SliderLabel = Instance.new("TextLabel")
            local SliderValueLabel = Instance.new("TextLabel")
            local SliderTrack = Instance.new("Frame")
            local SliderFill = Instance.new("Frame")
            local SliderButton = Instance.new("TextButton")
            
            SliderFrame.Name = "SliderFrame"
            SliderFrame.Parent = TabFrame
            SliderFrame.BackgroundColor3 = currentTheme.Primary
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 4)
            SliderCorner.Parent = SliderFrame
            
            SliderLabel.Name = "Label"
            SliderLabel.Parent = SliderFrame
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Position = UDim2.new(0, 10, 0, 5)
            SliderLabel.Size = UDim2.new(1, -60, 0, 20)
            SliderLabel.Font = Enum.Font.SourceSansSemibold
            SliderLabel.Text = sliderText
            SliderLabel.TextColor3 = currentTheme.Text
            SliderLabel.TextSize = 14
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            SliderValueLabel.Name = "ValueLabel"
            SliderValueLabel.Parent = SliderFrame
            SliderValueLabel.BackgroundTransparency = 1
            SliderValueLabel.Position = UDim2.new(1, -50, 0, 5)
            SliderValueLabel.Size = UDim2.new(0, 40, 0, 20)
            SliderValueLabel.Font = Enum.Font.SourceSansBold
            SliderValueLabel.Text = tostring(defaultValue)
            SliderValueLabel.TextColor3 = currentTheme.Accent
            SliderValueLabel.TextSize = 14
            SliderValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            
            SliderTrack.Name = "Track"
            SliderTrack.Parent = SliderFrame
            SliderTrack.BackgroundColor3 = currentTheme.Secondary
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Position = UDim2.new(0, 10, 0, 30)
            SliderTrack.Size = UDim2.new(1, -20, 0, 6)
            
            local TrackCorner = Instance.new("UICorner")
            TrackCorner.CornerRadius = UDim.new(0, 3)
            TrackCorner.Parent = SliderTrack
            
            SliderFill.Name = "Fill"
            SliderFill.Parent = SliderTrack
            SliderFill.BackgroundColor3 = currentTheme.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            
            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(0, 3)
            FillCorner.Parent = SliderFill
            
            SliderButton.Name = "Button"
            SliderButton.Parent = SliderTrack
            SliderButton.BackgroundTransparency = 1
            SliderButton.Size = UDim2.new(1, 0, 1, 0)
            SliderButton.Text = ""
            
            local currentValue = defaultValue
            local isDragging = false
            
            local function UpdateSlider(value)
                currentValue = math.clamp(value, minValue, maxValue)
                local percentage = (currentValue - minValue) / (maxValue - minValue)
                TweenService:Create(SliderFill, TweenInfo.new(0.1), {
                    Size = UDim2.new(percentage, 0, 1, 0)
                }):Play()
                SliderValueLabel.Text = tostring(math.floor(currentValue))
                pcall(callback, currentValue)
            end
            
            SliderButton.MouseButton1Down:Connect(function()
                isDragging = true
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local posX = SliderTrack.AbsolutePosition.X
                    local sizeX = SliderTrack.AbsoluteSize.X
                    local mouseX = UserInputService:GetMouseLocation().X
                    local percentage = math.clamp((mouseX - posX) / sizeX, 0, 1)
                    UpdateSlider(minValue + (percentage * (maxValue - minValue)))
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = false
                end
            end)
            
            UpdateSlider(defaultValue)
            
            return {
                SetValue = function(value)
                    UpdateSlider(value)
                end,
                GetValue = function()
                    return currentValue
                end
            }
        end
        
        function TabObject:CreateDropdown(dropdownText, options, callback)
            dropdownText = dropdownText or "Dropdown"
            options = options or {}
            callback = callback or function() end
            
            local DropdownFrame = Instance.new("Frame")
            local DropdownButton = Instance.new("TextButton")
            local DropdownLabel = Instance.new("TextLabel")
            local DropdownArrow = Instance.new("TextLabel")
            local DropdownList = Instance.new("ScrollingFrame")
            local ListLayout = Instance.new("UIListLayout")
            
            DropdownFrame.Name = "DropdownFrame"
            DropdownFrame.Parent = TabFrame
            DropdownFrame.BackgroundColor3 = currentTheme.Primary
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Size = UDim2.new(1, 0, 0, 35)
            DropdownFrame.ClipsDescendants = true
            
            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 4)
            DropdownCorner.Parent = DropdownFrame
            
            DropdownButton.Name = "Button"
            DropdownButton.Parent = DropdownFrame
            DropdownButton.BackgroundTransparency = 1
            DropdownButton.Size = UDim2.new(1, 0, 0, 35)
            DropdownButton.Text = ""
            
            DropdownLabel.Name = "Label"
            DropdownLabel.Parent = DropdownButton
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
            DropdownLabel.Size = UDim2.new(1, -30, 1, 0)
            DropdownLabel.Font = Enum.Font.SourceSansSemibold
            DropdownLabel.Text = dropdownText
            DropdownLabel.TextColor3 = currentTheme.Text
            DropdownLabel.TextSize = 14
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownArrow.Name = "Arrow"
            DropdownArrow.Parent = DropdownButton
            DropdownArrow.BackgroundTransparency = 1
            DropdownArrow.Position = UDim2.new(1, -25, 0, 0)
            DropdownArrow.Size = UDim2.new(0, 20, 1, 0)
            DropdownArrow.Font = Enum.Font.SourceSansBold
            DropdownArrow.Text = "▼"
            DropdownArrow.TextColor3 = currentTheme.Accent
            DropdownArrow.TextSize = 14
            
            DropdownList.Name = "List"
            DropdownList.Parent = DropdownFrame
            DropdownList.BackgroundTransparency = 1
            DropdownList.BorderSizePixel = 0
            DropdownList.Position = UDim2.new(0, 0, 0, 35)
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.ScrollBarThickness = 2
            DropdownList.ScrollBarImageColor3 = currentTheme.Accent
            DropdownList.ScrollingDirection = Enum.ScrollingDirection.Y
            DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
            
            ListLayout.Parent = DropdownList
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            
            local isOpen = false
            
            for _, option in pairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = "Option"
                OptionButton.Parent = DropdownList
                OptionButton.BackgroundColor3 = currentTheme.Secondary
                OptionButton.BorderSizePixel = 0
                OptionButton.Size = UDim2.new(1, 0, 0, 30)
                OptionButton.Font = Enum.Font.SourceSans
                OptionButton.Text = option
                OptionButton.TextColor3 = currentTheme.Text
                OptionButton.TextSize = 14
                
                OptionButton.MouseButton1Click:Connect(function()
                    DropdownLabel.Text = dropdownText .. ": " .. option
                    pcall(callback, option)
                    PlaySound("rbxassetid://131961136")
                    
                    isOpen = false
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, 0, 0, 35)
                    }):Play()
                    TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, 0, 0, 0)
                    }):Play()
                    DropdownArrow.Text = "▼"
                end)
                
                OptionButton.MouseEnter:Connect(function()
                    TweenService:Create(OptionButton, TweenInfo.new(0.1), {
                        BackgroundColor3 = currentTheme.Accent
                    }):Play()
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    TweenService:Create(OptionButton, TweenInfo.new(0.1), {
                        BackgroundColor3 = currentTheme.Secondary
                    }):Play()
                end)
            end
            
            ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                DropdownList.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
            end)
            
            DropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                PlaySound("rbxassetid://131961136")
                
                if isOpen then
                    local listHeight = math.min(120, ListLayout.AbsoluteContentSize.Y)
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, 0, 0, 35 + listHeight)
                    }):Play()
                    TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, 0, 0, listHeight)
                    }):Play()
                    DropdownArrow.Text = "▲"
                else
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, 0, 0, 35)
                    }):Play()
                    TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, 0, 0, 0)
                    }):Play()
                    DropdownArrow.Text = "▼"
                end
            end)
            
            return {
                Refresh = function(newOptions)
                    for _, child in pairs(DropdownList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    for _, option in pairs(newOptions) do
                        local OptionButton = Instance.new("TextButton")
                        OptionButton.Name = "Option"
                        OptionButton.Parent = DropdownList
                        OptionButton.BackgroundColor3 = currentTheme.Secondary
                        OptionButton.BorderSizePixel = 0
                        OptionButton.Size = UDim2.new(1, 0, 0, 30)
                        OptionButton.Font = Enum.Font.SourceSans
                        OptionButton.Text = option
                        OptionButton.TextColor3 = currentTheme.Text
                        OptionButton.TextSize = 14
                        
                        OptionButton.MouseButton1Click:Connect(function()
                            DropdownLabel.Text = dropdownText .. ": " .. option
                            pcall(callback, option)
                            PlaySound("rbxassetid://131961136")
                            
                            isOpen = false
                            TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {
                                Size = UDim2.new(1, 0, 0, 35)
                            }):Play()
                            TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                                Size = UDim2.new(1, 0, 0, 0)
                            }):Play()
                            DropdownArrow.Text = "▼"
                        end)
                        
                        OptionButton.MouseEnter:Connect(function()
                            TweenService:Create(OptionButton, TweenInfo.new(0.1), {
                                BackgroundColor3 = currentTheme.Accent
                            }):Play()
                        end)
                        
                        OptionButton.MouseLeave:Connect(function()
                            TweenService:Create(OptionButton, TweenInfo.new(0.1), {
                                BackgroundColor3 = currentTheme.Secondary
                            }):Play()
                        end)
                    end
                end
            }
        end
        
        function TabObject:Show()
            for _, child in pairs(ItemContainer:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            
            for _, child in pairs(TabScroll:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = currentTheme.Primary
                    child.TextColor3 = currentTheme.Text
                end
            end
            
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = currentTheme.Accent
            TabButton.TextColor3 = currentTheme.IsLight and currentTheme.Primary or Color3.fromRGB(255, 255, 255)
        end
        
        return TabObject
    end
    
    TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabScroll.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
    end)
    
    coroutine.wrap(function()
        wait()
        if TabScroll:FindFirstChildOfClass("TextButton") then
            TabScroll:FindFirstChildOfClass("TextButton"):MouseButton1Click()
        end
    end)()
    
    function WindowObject:ChangeTheme(themeName)
        if Themes[themeName] then
            currentTheme = Themes[themeName]
            
            TweenService:Create(MainFrame, TweenInfo.new(0.2), {
                BackgroundColor3 = currentTheme.Primary
            }):Play()
            TweenService:Create(TopBar, TweenInfo.new(0.2), {
                BackgroundColor3 = currentTheme.Secondary
            }):Play()
            TweenService:Create(Title, TweenInfo.new(0.2), {
                TextColor3 = currentTheme.Text
            }):Play()
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                TextColor3 = currentTheme.Text
            }):Play()
            TweenService:Create(TabContainer, TweenInfo.new(0.2), {
                BackgroundColor3 = currentTheme.Secondary
            }):Play()
            TweenService:Create(ItemContainer, TweenInfo.new(0.2), {
                BackgroundColor3 = currentTheme.Secondary
            }):Play()
            
            TabScroll.ScrollBarImageColor3 = currentTheme.Accent
            
            for _, tabButton in pairs(TabScroll:GetChildren()) do
                if tabButton:IsA("TextButton") then
                    TweenService:Create(tabButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = currentTheme.Primary,
                        TextColor3 = currentTheme.Text
                    }):Play()
                    
                    local tabName = string.gsub(tabButton.Name, "Button", "")
                    local tabFrame = ItemContainer:FindFirstChild(tabName.."Frame")
                    if tabFrame then
                        tabFrame.ScrollBarImageColor3 = currentTheme.Accent
                        
                        for _, element in pairs(tabFrame:GetDescendants()) do
                            if element:IsA("TextButton") and element.Name == "Button" then
                                TweenService:Create(element, TweenInfo.new(0.2), {
                                    BackgroundColor3 = currentTheme.Primary,
                                    TextColor3 = currentTheme.Text
                                }):Play()
                            elseif element:IsA("TextLabel") then
                                TweenService:Create(element, TweenInfo.new(0.2), {
                                    TextColor3 = currentTheme.Text
                                }):Play()
                            elseif element:IsA("Frame") and element.Name == "ToggleFrame" then
                                TweenService:Create(element, TweenInfo.new(0.2), {
                                    BackgroundColor3 = currentTheme.Primary
                                }):Play()
                                TweenService:Create(element:FindFirstChild("Label"), TweenInfo.new(0.2), {
                                    TextColor3 = currentTheme.Text
                                }):Play()
                                local toggleBtn = element:FindFirstChild("Button")
                                if toggleBtn then
                                    TweenService:Create(toggleBtn, TweenInfo.new(0.2), {
                                        BackgroundColor3 = currentTheme.Secondary
                                    }):Play()
                                end
                            elseif element:IsA("Frame") and element.Name == "SliderFrame" then
                                TweenService:Create(element, TweenInfo.new(0.2), {
                                    BackgroundColor3 = currentTheme.Primary
                                }):Play()
                                TweenService:Create(element:FindFirstChild("Label"), TweenInfo.new(0.2), {
                                    TextColor3 = currentTheme.Text
                                }):Play()
                                TweenService:Create(element:FindFirstChild("ValueLabel"), TweenInfo.new(0.2), {
                                    TextColor3 = currentTheme.Accent
                                }):Play()
                                TweenService:Create(element:FindFirstChild("Track"), TweenInfo.new(0.2), {
                                    BackgroundColor3 = currentTheme.Secondary
                                }):Play()
                                TweenService:Create(element:FindFirstChild("Fill"), TweenInfo.new(0.2), {
                                    BackgroundColor3 = currentTheme.Accent
                                }):Play()
                            elseif element:IsA("Frame") and element.Name == "DropdownFrame" then
                                TweenService:Create(element, TweenInfo.new(0.2), {
                                    BackgroundColor3 = currentTheme.Primary
                                }):Play()
                                TweenService:Create(element:FindFirstChild("Button"):FindFirstChild("Label"), TweenInfo.new(0.2), {
                                    TextColor3 = currentTheme.Text
                                }):Play()
                                TweenService:Create(element:FindFirstChild("Button"):FindFirstChild("Arrow"), TweenInfo.new(0.2), {
                                    TextColor3 = currentTheme.Accent
                                }):Play()
                            end
                        end
                    end
                end
            end
            
            for _, tabButton in pairs(TabScroll:GetChildren()) do
                if tabButton:IsA("TextButton") and tabButton.BackgroundColor3 == currentTheme.Accent then
                    TweenService:Create(tabButton, TweenInfo.new(0.2), {
                        TextColor3 = currentTheme.IsLight and currentTheme.Primary or Color3.fromRGB(255, 255, 255)
                    }):Play()
                end
            end
        end
    end
    
    function WindowObject:SetPosition(position)
        MainFrame.Position = position
    end
    
    function WindowObject:SetSize(size)
        MainFrame.Size = size
    end
    
    function WindowObject:Toggle()
        ToggleButton:MouseButton1Click()
    end
    
    function WindowObject:Destroy()
        ScreenGui:Destroy()
    end
    
    return WindowObject
end

return Library
