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
        FolderName = nil,
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
local Tab = Window:CreateTab("Universal", 4483362458)

-- Create Section
local Section = Tab:CreateSection("Sessão")

-- Button: Crosshair
local Button = Tab:CreateButton({
    Name = "Mira",
    Callback = function()
        local player = game.Players.LocalPlayer
        local playerGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")

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
local Button = Tab:CreateButton({
    Name = "Veja os arquivos do jogo (CAUSA LAG &/OU CRASH)",
    Callback = function()
        -- Create the Explorer GUI
        local function CreateExplorer()
            local player = game.Players.LocalPlayer
            local playerGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")

            local gui = Instance.new("ScreenGui")
            gui.Name = "AdvancedExplorer"

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

            PopulateExplorer(game)
            contentFrame.CanvasSize = UDim2.new(0, 0, 0, PopulateExplorer(game))

            gui.Parent = playerGui
        end

        -- Initialize the Explorer
        CreateExplorer()
    end,
})

-- Button: fly?
local Button = Tab:CreateButton({
    Name = "Voe (PODE CAUSAR BANIMENTO EM ALGUNS JOGOS OU NO ROBLOX)",
    Callback = function()
loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")()
})

-- Load Rayfield Configuration
Rayfield:LoadConfiguration()
