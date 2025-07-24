local Library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Mouse = Players.LocalPlayer:GetMouse()

local function PlaySound(soundId)
    for _, sound in pairs(workspace:GetChildren()) do
        if sound.Name == "LibrarySound" then -- Soon
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
    local ContentFrame = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")
    local TabScroll = Instance.new("ScrollingFrame")
    local TabLayout = Instance.new("UIListLayout")
    local ItemContainer = Instance.new("Frame")
    local Discord = Instance.new("TextButton")
    
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
    
    local WindowObject = {}
    
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

        Discord.Name = "Discord"
    Discord.Parent = Body
    Discord.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Discord.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Discord.BorderSizePixel = 0
    Discord.Position = UDim2.new(0, 5, 0, 320)
    Discord.Size = UDim2.new(0, 85, 0, 25)
    Discord.AutoButtonColor = false
    Discord.Font = Enum.Font.SourceSans
    Discord.Text = ""
    Discord.TextColor3 = Color3.fromRGB(0, 0, 0)
    Discord.TextSize = 14.000

    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Discord

    Disc_Logo.Name = "Disc_Logo"
    Disc_Logo.Parent = Discord
    Disc_Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Disc_Logo.BackgroundTransparency = 1.000
    Disc_Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Disc_Logo.BorderSizePixel = 0
    Disc_Logo.Position = UDim2.new(0, 5, 0, 1)
    Disc_Logo.Size = UDim2.new(0, 23, 0, 23)
    Disc_Logo.Image = "http://www.roblox.com/asset/?id=12058969086"

    Disc_Title.Name = "Disc_Title"
    Disc_Title.Parent = Discord
    Disc_Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Disc_Title.BackgroundTransparency = 1.000
    Disc_Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Disc_Title.BorderSizePixel = 0
    Disc_Title.Position = UDim2.new(0, 35, 0, 0)
    Disc_Title.Size = UDim2.new(0, 40, 0, 25)
    Disc_Title.Font = Enum.Font.SourceSansSemibold
    Disc_Title.Text = "Discord"
    Disc_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Disc_Title.TextSize = 14.000
    Disc_Title.TextXAlignment = Enum.TextXAlignment.Left

    Discord.MouseEnter:Connect(function()
        utility:Tween(Discord, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, .15)
        utility:Tween(Disc_Logo, {ImageTransparency = 0.7}, .15)
        utility:Tween(Disc_Title, {TextTransparency = 0.7}, .15)
    end)

    Discord.MouseLeave:connect(function()
        utility:Tween(Discord, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, .15)
        utility:Tween(Disc_Logo, {ImageTransparency = 0}, .15)
        utility:Tween(Disc_Title, {TextTransparency = 0}, .15)
    end)

    Discord.MouseButton1Click:Connect(function()
        (setclipboard or toclipboard)("https://discord.gg/SPEEDWAVE")
        wait(.1)
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Discord",
            Text = "Discord copied on your clipboard",
            Button1 = "Okay",
            Duration = 20
        })
    end)
        
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
            ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
            
            ToggleLabel.Name = "Label"
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.Size = UDim2.new(0, 200, 1, 0)
            ToggleLabel.Font = Enum.Font.SourceSansSemibold
            ToggleLabel.Text = toggleText
            ToggleLabel.TextColor3 = currentTheme.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundColor3 = currentTheme.Secondary
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Text = ""
            
            ToggleIndicator.Name = "Indicator"
            ToggleIndicator.Parent = ToggleButton
            ToggleIndicator.BackgroundColor3 = currentTheme.Text
            ToggleIndicator.Position = defaultState and UDim2.new(0, 22, 0, 2) or UDim2.new(0, 2, 0, 2)
            ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            
            local function updateToggle(state)
                if state then
                    TweenService:Create(ToggleIndicator, TweenInfo.new(0.1), {
                        Position = UDim2.new(0, 22, 0, 2),
                        BackgroundColor3 = currentTheme.Accent
                    }):Play()
                else
                    TweenService:Create(ToggleIndicator, TweenInfo.new(0.1), {
                        Position = UDim2.new(0, 2, 0, 2),
                        BackgroundColor3 = currentTheme.Text
                    }):Play()
                end
                pcall(callback, state)
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                defaultState = not defaultState
                updateToggle(defaultState)
            end)
            
            return {
                SetState = function(state)
                    defaultState = state
                    updateToggle(state)
                end,
                GetState = function()
                    return defaultState
                end
            }
        end
        
        if #TabScroll:GetChildren() == 1 then
            TabButton:Fire("MouseButton1Click")
        end
        
        return TabObject
    end
    
    return WindowObject
end

return Library
