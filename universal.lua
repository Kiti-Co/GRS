-- Carrega a biblioteca Sirius
loadstring(game:HttpGet("https://raw.githubusercontent.com/kiti-sites/Sirius/refs/heads/request/source.lua"))()

-- Carrega Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Kiti-Co/Rayfield/refs/heads/main/source.lua'))()

-- Janela principal
local Window = Rayfield:CreateWindow({
    Name = "Gui Roblox Scripts",
    Icon = 0,
    LoadingTitle = "Gui Roblox Scripts",
    LoadingSubtitle = "by Rfonte",
    Theme = "Default",
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

-- Aba "Universal"
local Tab = Window:CreateTab("Universal", 4483362458)
local Section = Tab:CreateSection("Sessão")

-- Botão: Mira
Tab:CreateButton({
    Name = "Mira",
    Callback = function()
        local player = game.Players.LocalPlayer
        local playerGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")

        -- Remove se já existir
        if playerGui:FindFirstChild("CrosshairGUI") then
            playerGui.CrosshairGUI:Destroy()
        end

        -- Criar GUI da mira
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "CrosshairGUI"
        screenGui.Parent = playerGui

        local crosshair = Instance.new("Frame")
        crosshair.Size = UDim2.new(0, 30, 0, 30)
        crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
        crosshair.BackgroundTransparency = 1
        crosshair.Position = UDim2.new(0.5, 0, 0.5, 0)
        crosshair.Parent = screenGui

        for _, angle in ipairs({45, -45}) do
            local line = Instance.new("Frame")
            line.Size = UDim2.new(0, 15, 0, 2)
            line.AnchorPoint = Vector2.new(0.5, 0.5)
            line.Position = UDim2.new(0.5, 0, 0.5, 0)
            line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            line.Rotation = angle
            line.Parent = crosshair
        end
    end,
})

-- Botão: Explorador de arquivos
Tab:CreateButton({
    Name = "Veja os arquivos do jogo (CAUSA LAG &/OU CRASH)",
    Callback = function()
        local function CreateExplorer()
            local player = game.Players.LocalPlayer
            local playerGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")

            if playerGui:FindFirstChild("AdvancedExplorer") then
                playerGui.AdvancedExplorer:Destroy()
            end

            local gui = Instance.new("ScreenGui", playerGui)
            gui.Name = "AdvancedExplorer"

            local mainFrame = Instance.new("Frame", gui)
            mainFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
            mainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
            mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

            local titleBar = Instance.new("Frame", mainFrame)
            titleBar.Size = UDim2.new(1, 0, 0, 30)
            titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

            local title = Instance.new("TextLabel", titleBar)
            title.Size = UDim2.new(1, -30, 1, 0)
            title.BackgroundTransparency = 1
            title.Text = "  Game Explorer"
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14

            local contentFrame = Instance.new("ScrollingFrame", mainFrame)
            contentFrame.Size = UDim2.new(1, 0, 1, -30)
            contentFrame.Position = UDim2.new(0, 0, 0, 30)
            contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            contentFrame.ScrollBarThickness = 8

            local function PopulateExplorer(parent, depth)
                depth = depth or 0
                local yOffset = 0

                for _, item in ipairs(parent:GetChildren()) do
                    local button = Instance.new("TextButton", contentFrame)
                    button.Size = UDim2.new(1, -10, 0, 25)
                    button.Position = UDim2.new(0, 5, 0, yOffset)
                    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    button.Text = string.rep("    ", depth) .. item.Name
                    yOffset += 30

                    if #item:GetChildren() > 0 then
                        yOffset += PopulateExplorer(item, depth + 1)
                    end
                end

                return yOffset
            end

            contentFrame.CanvasSize = UDim2.new(0, 0, 0, PopulateExplorer(game))
        end

        CreateExplorer()
    end,
})

-- Botão: Voo (precisa de implementação segura)
Tab:CreateButton({
    Name = "Infinity Yield",
    Callback = function()
        warn("Função de voo precisa ser implementada com cuidado. Evite usar em jogos com anti-cheat.")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end,
})

-- Carrega Configuração
Rayfield:LoadConfiguration()
