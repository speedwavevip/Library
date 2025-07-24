local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local CleanUI = {}

local function PlaySound(soundId: string)
    for _, sound in pairs(workspace:GetChildren()) do
        if sound.Name == "CleanUISound" and sound:IsA("Sound") then
            sound:Destroy()
        end
    end

    local newSound = Instance.new("Sound")
    newSound.Name = "CleanUISound"
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
}

function CleanUI:CreateWindow(windowName: string?)
    windowName = windowName or "CleanUI Library"
    local currentTheme = Themes["Dark"]

    for _, gui in pairs(game.CoreGui:GetChildren()) do
        if gui.Name == "CleanUI" then
            gui:Destroy()
        end
    end

    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICornerMain = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local UICornerClose = Instance.new("UICorner")
    local ContentFrame = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")
    local UICornerTabContainer = Instance.new("UICorner")
    local TabScroll = Instance.new("ScrollingFrame")
    local TabLayout = Instance.new("UIListLayout")
    local TabPadding = Instance.new("UIPadding")
    local ItemContainer = Instance.new("Frame")
    local UICornerItemContainer = Instance.new("UICorner")

    local PlayerInfoFrame = Instance.new("Frame")
    local PlayerAvatar = Instance.new("ImageLabel")
    local AvatarCorner = Instance.new("UICorner")
    local PlayerName = Instance.new("TextLabel")
    local FPSLabel = Instance.new("TextLabel")
    local PingLabel = Instance.new("TextLabel")

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
    UICornerMain.CornerRadius = UDim.new(0, 8)
    UICornerMain.Parent = MainFrame

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
    CloseButton.BackgroundColor3 = currentTheme.Secondary
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = currentTheme.Text
    CloseButton.TextSize = 18
    UICornerClose.CornerRadius = UDim.new(0, 4)
    UICornerClose.Parent = CloseButton

    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(255, 50, 50) }):Play()
    end)
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.15), { BackgroundColor3 = currentTheme.Secondary }):Play()
    end)

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
    UICornerTabContainer.CornerRadius = UDim.new(0, 8)
    UICornerTabContainer.Parent = TabContainer

    TabScroll.Name = "TabScroll"
    TabScroll.Parent = TabContainer
    TabScroll.BackgroundTransparency = 1
    TabScroll.Size = UDim2.new(1, 0, 1, 0)
    TabScroll.ScrollBarThickness = 3
    TabScroll.ScrollBarImageColor3 = currentTheme.Accent

    TabLayout.Parent = TabScroll
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 5)
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    TabPadding.Parent = TabScroll
    TabPadding.PaddingTop = UDim.new(0, 5)
    TabPadding.PaddingBottom = UDim.new(0, 5)
    TabPadding.PaddingLeft = UDim.new(0, 5)
    TabPadding.PaddingRight = UDim.new(0, 5)

    ItemContainer.Name = "ItemContainer"
    ItemContainer.Parent = ContentFrame
    ItemContainer.BackgroundColor3 = currentTheme.Secondary
    ItemContainer.Position = UDim2.new(0, 170, 0, 10)
    ItemContainer.Size = UDim2.new(1, -180, 1, -20)
    UICornerItemContainer.CornerRadius = UDim.new(0, 8)
    UICornerItemContainer.Parent = ItemContainer

    PlayerInfoFrame.Name = "PlayerInfoFrame"
    PlayerInfoFrame.Parent = ItemContainer
    PlayerInfoFrame.BackgroundColor3 = currentTheme.Primary
    PlayerInfoFrame.Size = UDim2.new(1, -20, 0, 80)
    PlayerInfoFrame.Position = UDim2.new(0, 10, 0, 10)
    PlayerInfoFrame.Visible = false

    PlayerAvatar.Name = "PlayerAvatar"
    PlayerAvatar.Parent = PlayerInfoFrame
    PlayerAvatar.BackgroundColor3 = currentTheme.Secondary
    PlayerAvatar.Size = UDim2.new(0, 60, 0, 60)
    PlayerAvatar.Position = UDim2.new(0, 10, 0, 10)
    AvatarCorner.CornerRadius = UDim.new(0.5, 0)
    AvatarCorner.Parent = PlayerAvatar

    PlayerName.Name = "PlayerName"
    PlayerName.Parent = PlayerInfoFrame
    PlayerName.BackgroundTransparency = 1
    PlayerName.Position = UDim2.new(0, 80, 0, 10)
    PlayerName.Size = UDim2.new(1, -90, 0, 20)
    PlayerName.Font = Enum.Font.SourceSansSemibold
    PlayerName.Text = "Player: " .. LocalPlayer.Name
    PlayerName.TextColor3 = currentTheme.Text
    PlayerName.TextSize = 16
    PlayerName.TextXAlignment = Enum.TextXAlignment.Left

    FPSLabel.Name = "FPSLabel"
    FPSLabel.Parent = PlayerInfoFrame
    FPSLabel.BackgroundTransparency = 1
    FPSLabel.Position = UDim2.new(0, 80, 0, 35)
    FPSLabel.Size = UDim2.new(1, -90, 0, 20)
    FPSLabel.Font = Enum.Font.SourceSansSemibold
    FPSLabel.Text = "FPS: Calculating..."
    FPSLabel.TextColor3 = currentTheme.Text
    FPSLabel.TextSize = 14
    FPSLabel.TextXAlignment = Enum.TextXAlignment.Left

    PingLabel.Name = "PingLabel"
    PingLabel.Parent = PlayerInfoFrame
    PingLabel.BackgroundTransparency = 1
    PingLabel.Position = UDim2.new(0, 80, 0, 55)
    PingLabel.Size = UDim2.new(1, -90, 0, 20)
    PingLabel.Font = Enum.Font.SourceSansSemibold
    PingLabel.Text = "Ping: Calculating..."
    PingLabel.TextColor3 = currentTheme.Text
    PingLabel.TextSize = 14
    PingLabel.TextXAlignment = Enum.TextXAlignment.Left

    local userId = LocalPlayer.UserId
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
    PlayerAvatar.Image = content

    local fps = 0
    local fpsCount = 0
    local fpsTime = 0
    RunService.Heartbeat:Connect(function(deltaTime)
        fpsTime = fpsTime + deltaTime
        fpsCount = fpsCount + 1
        if fpsTime >= 1 then
            fps = math.floor(fpsCount / fpsTime)
            fpsCount = 0
            fpsTime = 0
            FPSLabel.Text = "FPS: " .. fps
        end
    end)

    local function getPing(): number
        return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    end
    spawn(function()
        while task.wait(1) do
            PingLabel.Text = "Ping: " .. getPing() .. "ms"
        end
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local WindowObject = {
        _tabs = {}
    }
    local isFirstTabCreated = false

    function WindowObject:CreateTab(tabName: string)
        tabName = tabName or "New Tab"

        local TabButton = Instance.new("TextButton")
        local UICornerTabButton = Instance.new("UICorner")
        local TabText = Instance.new("TextLabel")
        local TabFrame = Instance.new("ScrollingFrame")
        local ItemLayout = Instance.new("UIListLayout")
        local ItemPadding = Instance.new("UIPadding")

        TabButton.Name = tabName:gsub("%s+", "") .. "TabButton"
        TabButton.Parent = TabScroll
        TabButton.BackgroundColor3 = currentTheme.Primary
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.Text = ""
        TabButton.AutoButtonColor = false
        UICornerTabButton.CornerRadius = UDim.new(0, 6)
        UICornerTabButton.Parent = TabButton

        TabButton.MouseEnter:Connect(function()
            if TabButton.BackgroundColor3 ~= currentTheme.Accent then
                TweenService:Create(TabButton, TweenInfo.new(0.1), {
                    BackgroundColor3 = currentTheme.Primary:Lerp(currentTheme.Accent, 0.2)
                }):Play()
            end
        end)
        TabButton.MouseLeave:Connect(function()
            if TabButton.BackgroundColor3 ~= currentTheme.Accent then
                TweenService:Create(TabButton, TweenInfo.new(0.1), {
                    BackgroundColor3 = currentTheme.Primary
                }):Play()
            end
        end)

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

        TabFrame.Name = tabName:gsub("%s+", "") .. "TabFrame"
        TabFrame.Parent = ItemContainer
        TabFrame.BackgroundTransparency = 1
        TabFrame.Size = UDim2.new(1, -20, 1, -20)
        TabFrame.Position = UDim2.new(0, 10, 0, 10)
        TabFrame.Visible = false

        ItemLayout.Parent = TabFrame
        ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ItemLayout.Padding = UDim.new(0, 8)
        ItemLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        ItemLayout.VerticalAlignment = Enum.VerticalAlignment.Top

        ItemPadding.Parent = TabFrame
        ItemPadding.PaddingTop = UDim.new(0, 5)
        ItemPadding.PaddingBottom = UDim.new(0, 5)
        ItemPadding.PaddingLeft = UDim.new(0, 5)
        ItemPadding.PaddingRight = UDim.new(0, 5)

        local TabObject = {}
        WindowObject._tabs[tabName] = {
            Button = TabButton,
            Frame = TabFrame,
            PlayerInfoVisible = false
        }

        TabButton.MouseButton1Click:Connect(function()
            for _, tabData in pairs(WindowObject._tabs) do
                tabData.Frame.Visible = false
                tabData.Button.BackgroundColor3 = currentTheme.Primary
            end

            TabFrame.Visible = true
            TabButton.BackgroundColor3 = currentTheme.Accent

            if WindowObject._tabs[tabName].PlayerInfoVisible then
                PlayerInfoFrame.Visible = true
                TabFrame.Position = UDim2.new(0, 10, 0, 100)
                TabFrame.Size = UDim2.new(1, -20, 1, -110)
            else
                PlayerInfoFrame.Visible = false
                TabFrame.Position = UDim2.new(0, 10, 0, 10)
                TabFrame.Size = UDim2.new(1, -20, 1, -20)
            end
        end)

        if not isFirstTabCreated then
            TabButton:SetCore("Selected", true)
            TabButton.BackgroundColor3 = currentTheme.Accent
            TabFrame.Visible = true
            PlayerInfoFrame.Visible = true
            TabFrame.Position = UDim2.new(0, 10, 0, 100)
            TabFrame.Size = UDim2.new(1, -20, 1, -110)
            WindowObject._tabs[tabName].PlayerInfoVisible = true
            isFirstTabCreated = true
        end

        function TabObject:CreateLabel(text: string)
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Parent = TabFrame
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(1, 0, 0, 20)
            Label.Font = Enum.Font.SourceSansSemibold
            Label.Text = text or "Label"
            Label.TextColor3 = currentTheme.Text
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextWrapped = true

            return {
                SetText = function(newText: string)
                    Label.Text = newText or ""
                end,
                Instance = Label
            }
        end

        function TabObject:CreateSubtitle(text: string)
            local Subtitle = Instance.new("TextLabel")
            Subtitle.Name = "Subtitle"
            Subtitle.Parent = TabFrame
            Subtitle.BackgroundTransparency = 1
            Subtitle.Size = UDim2.new(1, 0, 0, 25)
            Subtitle.Font = Enum.Font.SourceSansBold
            Subtitle.Text = text or "Subtitle"
            Subtitle.TextColor3 = currentTheme.Accent
            Subtitle.TextSize = 16
            Subtitle.TextXAlignment = Enum.TextXAlignment.Left
            Subtitle.TextWrapped = true

            local Spacer = Instance.new("Frame")
            Spacer.Name = "Spacer"
            Spacer.Parent = TabFrame
            Spacer.BackgroundTransparency = 1
            Spacer.Size = UDim2.new(1, 0, 0, 5)

            return Subtitle
        end

        function TabObject:CreateButton(buttonText: string, callback: (() -> ())?)
            local Button = Instance.new("TextButton")
            local UICornerButton = Instance.new("UICorner")

            Button.Name = "Button"
            Button.Parent = TabFrame
            Button.BackgroundColor3 = currentTheme.Primary
            Button.Size = UDim2.new(1, 0, 0, 35)
            Button.Text = buttonText or "Button"
            Button.TextColor3 = currentTheme.Text
            Button.TextSize = 15
            Button.Font = Enum.Font.SourceSansSemibold
            Button.AutoButtonColor = false
            UICornerButton.CornerRadius = UDim.new(0, 6)
            UICornerButton.Parent = Button

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

            Button.MouseButton1Click:Connect(function()
                if callback then
                    pcall(callback)
                end
                PlaySound("rbxassetid://1061989504")
            end)

            return {
                Instance = Button,
                SetText = function(newText: string)
                    Button.Text = newText
                end
            }
        end

        function TabObject:CreateTextBox(placeholderText: string?, defaultText: string?, callback: ((text: string) -> ())?)
            local TextBox = Instance.new("TextBox")
            local UICornerTextBox = Instance.new("UICorner")

            TextBox.Name = "TextBox"
            TextBox.Parent = TabFrame
            TextBox.BackgroundColor3 = currentTheme.Primary
            TextBox.Size = UDim2.new(1, 0, 0, 35)
            TextBox.PlaceholderText = placeholderText or "Enter text here..."
            TextBox.Text = defaultText or ""
            TextBox.Font = Enum.Font.SourceSansRegular
            TextBox.TextColor3 = currentTheme.Text
            TextBox.TextSize = 14
            TextBox.TextXAlignment = Enum.TextXAlignment.Left
            TextBox.TextWrapped = true
            TextBox.ClearTextOnFocus = false
            TextBox.TextInsets = UDim.new(0, 10)
            UICornerTextBox.CornerRadius = UDim.new(0, 6)
            UICornerTextBox.Parent = TextBox

            TextBox.Focused:Connect(function()
                TweenService:Create(TextBox, TweenInfo.new(0.15), { BorderColor3 = currentTheme.Accent, BorderSizePixel = 2 }):Play()
            end)
            TextBox.FocusLost:Connect(function()
                TweenService:Create(TextBox, TweenInfo.new(0.15), { BorderColor3 = currentTheme.Primary, BorderSizePixel = 0 }):Play()
                if callback then
                    pcall(callback, TextBox.Text)
                end
            end)

            return {
                Instance = TextBox,
                GetText = function(): string
                    return TextBox.Text
                end,
                SetText = function(newText: string)
                    TextBox.Text = newText
                end
            }
        end

        function TabObject:CreateToggle(toggleText: string, defaultState: boolean?, callback: ((state: boolean) -> ())?)
            toggleText = toggleText or "Toggle"
            local currentState = defaultState or false
            callback = callback or function() end

            local ToggleFrame = Instance.new("Frame")
            local ToggleLabel = Instance.new("TextLabel")
            local ToggleButton = Instance.new("TextButton")
            local ToggleIndicator = Instance.new("Frame")
            local UICornerToggleFrame = Instance.new("UICorner")
            local UICornerToggleButton = Instance.new("UICorner")
            local UICornerToggleIndicator = Instance.new("UICorner")

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = TabFrame
            ToggleFrame.BackgroundColor3 = currentTheme.Primary
            ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
            UICornerToggleFrame.CornerRadius = UDim.new(0, 6)
            UICornerToggleFrame.Parent = ToggleFrame

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
            ToggleButton.AutoButtonColor = false
            UICornerToggleButton.Parent = ToggleButton
            UICornerToggleButton.CornerRadius = UDim.new(1, 0)

            ToggleIndicator.Name = "Indicator"
            ToggleIndicator.Parent = ToggleButton
            ToggleIndicator.BackgroundColor3 = currentTheme.Text
            ToggleIndicator.Position = currentState and UDim2.new(0, 22, 0, 2) or UDim2.new(0, 2, 0, 2)
            ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            UICornerToggleIndicator.Parent = ToggleIndicator
            UICornerToggleIndicator.CornerRadius = UDim.new(1, 0)

            ToggleButton.MouseEnter:Connect(function()
                if not currentState then
                    TweenService:Create(ToggleButton, TweenInfo.new(0.1), {
                        BackgroundColor3 = currentTheme.Secondary:Lerp(currentTheme.Accent, 0.2)
                    }):Play()
                end
            end)
            ToggleButton.MouseLeave:Connect(function()
                if not currentState then
                    TweenService:Create(ToggleButton, TweenInfo.new(0.1), {
                        BackgroundColor3 = currentTheme.Secondary
                    }):Play()
                end
            end)

            local function updateToggle(state: boolean)
                local targetPosition = state and UDim2.new(0, 22, 0, 2) or UDim2.new(0, 2, 0, 2)
                local indicatorColor = state and currentTheme.Accent or currentTheme.Text
                local buttonColor = state and currentTheme.Accent or currentTheme.Secondary

                TweenService:Create(ToggleIndicator, TweenInfo.new(0.15), {
                    Position = targetPosition,
                    BackgroundColor3 = indicatorColor
                }):Play()
                TweenService:Create(ToggleButton, TweenInfo.new(0.15), {
                    BackgroundColor3 = buttonColor
                }):Play()

                currentState = state
                pcall(callback, currentState)
                PlaySound("rbxassetid://1061989504")
            end

            ToggleButton.MouseButton1Click:Connect(function()
                updateToggle(not currentState)
            end)

            updateToggle(currentState)

            return {
                SetState = function(self, state: boolean)
                    if currentState ~= state then
                        updateToggle(state)
                    end
                end,
                GetState = function(self): boolean
                    return currentState
                end,
                SetText = function(self, newText: string)
                    ToggleLabel.Text = newText or toggleText
                end,
                Destroy = function(self)
                    ToggleFrame:Destroy()
                end,
                Instance = ToggleFrame
            }
        end

        function TabObject:CreateDiscordButton()
            local DiscordButton = Instance.new("TextButton")
            local UICornerDiscord = Instance.new("UICorner")
            local DiscordLogo = Instance.new("ImageLabel")
            local DiscordTitle = Instance.new("TextLabel")

            DiscordButton.Name = "DiscordButton"
            DiscordButton.Parent = TabFrame
            DiscordButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            DiscordButton.BorderSizePixel = 0
            DiscordButton.Size = UDim2.new(0, 150, 0, 35)
            DiscordButton.AutoButtonColor = false
            DiscordButton.Text = ""
            UICornerDiscord.CornerRadius = UDim.new(0, 6)
            UICornerDiscord.Parent = DiscordButton

            DiscordLogo.Name = "DiscordLogo"
            DiscordLogo.Parent = DiscordButton
            DiscordLogo.BackgroundTransparency = 1
            DiscordLogo.Position = UDim2.new(0, 10, 0.5, -12)
            DiscordLogo.Size = UDim2.new(0, 24, 0, 24)
            DiscordLogo.Image = "rbxassetid://12058969086"

            DiscordTitle.Name = "DiscordTitle"
            DiscordTitle.Parent = DiscordButton
            DiscordTitle.BackgroundTransparency = 1
            DiscordTitle.Position = UDim2.new(0, 45, 0, 0)
            DiscordTitle.Size = UDim2.new(0, 100, 1, 0)
            DiscordTitle.Font = Enum.Font.SourceSansSemibold
            DiscordTitle.Text = "Join Discord"
            DiscordTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DiscordTitle.TextSize = 14
            DiscordTitle.TextXAlignment = Enum.TextXAlignment.Left

            DiscordButton.MouseEnter:Connect(function()
                TweenService:Create(DiscordButton, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                }):Play()
                TweenService:Create(DiscordLogo, TweenInfo.new(0.15), {
                    ImageTransparency = 0.3
                }):Play()
                TweenService:Create(DiscordTitle, TweenInfo.new(0.15), {
                    TextTransparency = 0.3
                }):Play()
            end)
            DiscordButton.MouseLeave:Connect(function()
                TweenService:Create(DiscordButton, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                }):Play()
                TweenService:Create(DiscordLogo, TweenInfo.new(0.15), {
                    ImageTransparency = 0
                }):Play()
                TweenService:Create(DiscordTitle, TweenInfo.new(0.15), {
                    TextTransparency = 0
                }):Play()
            end)

            DiscordButton.MouseButton1Click:Connect(function()
                local discordLink = "https://discord.gg/YOUR_DISCORD_INVITE"
                local success = pcall(function()
                    if setclipboard then
                        setclipboard(discordLink)
                    elseif toclipboard then
                        toclipboard(discordLink)
                    else
                        warn("Clipboard functions not available. Please manually copy the link: " .. discordLink)
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "Discord",
                            Text = "Couldn't copy link. Manually copy: " .. discordLink,
                            Button1 = "Okay",
                            Duration = 7
                        })
                    end
                end)
                if success then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Discord",
                        Text = "Discord invite link copied to clipboard!",
                        Button1 = "Okay",
                        Duration = 5
                    })
                end
            end)

            return DiscordButton
        end
        
        function TabObject:CreateSlider(text: string, defaultValue: number?, minValue: number?, maxValue: number?, callback: ((value: number) -> ())?)
            local SliderFrame = Instance.new("Frame")
            local Label = Instance.new("TextLabel")
            local Slider = Instance.new("Frame")
            local Button = Instance.new("Frame")
            local ValueLabel = Instance.new("TextLabel")
            local UICornerFrame = Instance.new("UICorner")
            local UICornerSlider = Instance.new("UICorner")
            local UICornerButton = Instance.new("UICorner")

            local isDragging = false
            local lastMouseX = 0

            local min = minValue or 0
            local max = maxValue or 100
            local currentValue = defaultValue or 0
            callback = callback or function() end

            SliderFrame.Name = "SliderFrame"
            SliderFrame.Parent = TabFrame
            SliderFrame.BackgroundColor3 = currentTheme.Primary
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            UICornerFrame.CornerRadius = UDim.new(0, 6)
            UICornerFrame.Parent = SliderFrame

            Label.Name = "Label"
            Label.Parent = SliderFrame
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 5)
            Label.Size = UDim2.new(0.5, -10, 0, 20)
            Label.Font = Enum.Font.SourceSansSemibold
            Label.Text = text or "Slider"
            Label.TextColor3 = currentTheme.Text
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left

            ValueLabel.Name = "ValueLabel"
            ValueLabel.Parent = SliderFrame
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Position = UDim2.new(0.5, 0, 0, 5)
            ValueLabel.Size = UDim2.new(0.5, -10, 0, 20)
            ValueLabel.Font = Enum.Font.SourceSansSemibold
            ValueLabel.Text = tostring(math.floor(currentValue))
            ValueLabel.TextColor3 = currentTheme.Accent
            ValueLabel.TextSize = 14
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

            Slider.Name = "Slider"
            Slider.Parent = SliderFrame
            Slider.BackgroundColor3 = currentTheme.Secondary
            Slider.Size = UDim2.new(1, -20, 0, 10)
            Slider.Position = UDim2.new(0, 10, 0, 30)
            Slider.Active = true
            UICornerSlider.CornerRadius = UDim.new(1, 0)
            UICornerSlider.Parent = Slider

            Button.Name = "Button"
            Button.Parent = Slider
            Button.BackgroundColor3 = currentTheme.Accent
            Button.Size = UDim2.new(0, 16, 0, 16)
            Button.Position = UDim2.new(0, 0, 0.5, -8)
            UICornerButton.CornerRadius = UDim.new(1, 0)
            UICornerButton.Parent = Button

            local function updateSliderVisuals(value)
                local ratio = (value - min) / (max - min)
                ratio = math.max(0, math.min(1, ratio))

                Button.Position = UDim2.new(ratio, -8, 0.5, -8)
                ValueLabel.Text = tostring(math.floor(value))
            end

            local function onDrag(input)
                local x = input.Position.X - Slider.AbsolutePosition.X
                local newRatio = x / Slider.AbsoluteSize.X
                newRatio = math.max(0, math.min(1, newRatio))

                local newValue = min + newRatio * (max - min)
                currentValue = newValue

                updateSliderVisuals(newValue)

                pcall(callback, currentValue)
            end

            Button.MouseButton1Down:Connect(function()
                isDragging = true
                lastMouseX = Mouse.X
                UserInputService.InputChanged:Connect(onDrag)
                UserInputService.InputEnded:Wait()
                isDragging = false
            end)

            UserInputService.InputChanged:Connect(function(input)
                if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    onDrag(input)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = false
                end
            end)

            updateSliderVisuals(currentValue)

            return {
                Instance = SliderFrame,
                SetValue = function(self, value: number)
                    currentValue = math.max(min, math.min(max, value))
                    updateSliderVisuals(currentValue)
                end,
                GetValue = function(self): number
                    return currentValue
                end
            }
        end

        return TabObject
    end

    return WindowObject
end

return CleanUI
