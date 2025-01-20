loadstring(game:HttpGet("https://raw.githubusercontent.com/kiti-sites/Sirius/refs/heads/request/source.lua"))()

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/kiti-sites/GRS/refs/heads/main/rayfield.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "Gui Roblox Scripts",
    Icon = 0, -- Icon in Topbar. Use Lucide Icons (string) or Roblox Image (number). 0 means no icon.
    LoadingTitle = "Gui Roblox Scripts",
    LoadingSubtitle = "by Rfonte",
    Theme = "Default", -- Check themes at https://docs.sirius.menu/rayfield/configuration/themes
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil, -- If not provided, it defaults to the game name.
        FileName = "GRS"
    },

    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },

    KeySystem = false
})

-- Create "Universal" Tab
local Tab = Window:CreateTab("Universal", 4483362458) -- 4483362458 is an example icon asset ID.

-- Create Section
local Section = Tab:CreateSection("Sessão")

-- Button: Crosshair
Tab:CreateButton({
    Name = "Mira",
    Callback = function()
        local player = game.Players.LocalPlayer
        local playerGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")

        -- Check if Crosshair already exists
        if playerGui:FindFirstChild("CrosshairGUI") then
            playerGui.CrosshairGUI:Destroy()
        end

        -- Create a ScreenGui for the crosshair
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "CrosshairGUI"
        screenGui.Parent = playerGui

        -- Create the crosshair frame
        local crosshair = Instance.new("Frame")
        crosshair.Size = UDim2.new(0, 30, 0, 30)
        crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
        crosshair.BackgroundTransparency = 1
        crosshair.Position = UDim2.new(0.5, 0, 0.5, 0)
        crosshair.Parent = screenGui

        -- Create diagonal line 1
        local diagonalLine1 = Instance.new("Frame")
        diagonalLine1.Size = UDim2.new(0, 15, 0, 2)
        diagonalLine1.AnchorPoint = Vector2.new(0.5, 0.5)
        diagonalLine1.Position = UDim2.new(0.5, 0, 0.5, 0)
        diagonalLine1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        diagonalLine1.Rotation = 45
        diagonalLine1.Parent = crosshair

        -- Create diagonal line 2
        local diagonalLine2 = Instance.new("Frame")
        diagonalLine2.Size = UDim2.new(0, 15, 0, 2)
        diagonalLine2.AnchorPoint = Vector2.new(0.5, 0.5)
        diagonalLine2.Position = UDim2.new(0.5, 0, 0.5, 0)
        diagonalLine2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        diagonalLine2.Rotation = -45
        diagonalLine2.Parent = crosshair
    end,
})

-- Button: Game Explorer
Tab:CreateButton({
    Name = "Veja os arquivos do jogo (CAUSA LAG &/OU CRASH)",
    Callback = function()
        local function CreateExplorer()
            local player = game.Players.LocalPlayer
            local playerGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")

            -- Check if Explorer already exists
            if playerGui:FindFirstChild("AdvancedExplorer") then
                playerGui.AdvancedExplorer:Destroy()
            end

            -- Create the Explorer GUI
            local gui = Instance.new("ScreenGui")
            gui.Name = "AdvancedExplorer"
            gui.Parent = playerGui

            -- Main Frame
            local mainFrame = Instance.new("Frame")
            mainFrame.Name = "MainFrame"
            mainFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
            mainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
            mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            mainFrame.Parent = gui

            -- Title Bar
            local titleBar = Instance.new("Frame")
            titleBar.Size = UDim2.new(1, 0, 0, 30)
            titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            titleBar.Parent = mainFrame

            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -30, 1, 0)
            title.BackgroundTransparency = 1
            title.Text = "  Game Explorer"
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14
            title.Parent = titleBar

            -- Content Frame
            local contentFrame = Instance.new("ScrollingFrame")
            contentFrame.Size = UDim2.new(1, 0, 1, -30)
            contentFrame.Position = UDim2.new(0, 0, 0, 30)
            contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            contentFrame.ScrollBarThickness = 8
            contentFrame.Parent = mainFrame

            -- Populate Explorer
            local function PopulateExplorer(parent, depth)
                depth = depth or 0
                local yOffset = 0

                for _, item in ipairs(parent:GetChildren()) do
                    local button = Instance.new("TextButton")
                    button.Size = UDim2.new(1, -10, 0, 25)
                    button.Position = UDim2.new(0, 5, 0, yOffset)
                    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    button.Text = string.rep("    ", depth) .. item.Name
                    button.Parent = contentFrame

                    yOffset = yOffset + 30

                    if #item:GetChildren() > 0 then
                        yOffset = PopulateExplorer(item, depth + 1) + yOffset
                    end
                end

                return yOffset
            end

            contentFrame.CanvasSize = UDim2.new(0, 0, 0, PopulateExplorer(game))
        end

        CreateExplorer()
    end,
})

-- Button: Fly
Tab:CreateButton({
    Name = "Voe (PODE CAUSAR BANIMENTO EM ALGUNS JOGOS OU NO ROBLOX)",
    Callback = function()
        print("Fly functionality placeholder. Verify fly script for safety!")
    end,
})

-- Button: Sirius
Tab:CreateButton({
    Name = "Sirius",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kiti-sites/Sirius/refs/heads/request/source.lua"))()
    end,
})

-- Load Rayfield Configuration
Rayfield:LoadConfiguration()
