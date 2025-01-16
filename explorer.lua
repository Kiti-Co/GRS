-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Criar o ícone flutuante que abre o explorador
local function CreateFloatingButton()
    local button = Instance.new("ImageButton")
    button.Name = "OpenExplorerButton"
    button.Size = UDim2.new(0, 50, 0, 50)
    button.Position = UDim2.new(0, 10, 0.5, -25)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.Image = "rbxassetid://6034925618" -- Ícone de pasta
    button.BackgroundTransparency = 0.2
    button.Visible = false -- Começa invisível

    -- Efeitos visuais do botão
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0.2, 0)
    uiCorner.Parent = button

    -- Animação de hover
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            Size = UDim2.new(0, 55, 0, 55)
        }):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45),
            Size = UDim2.new(0, 50, 0, 50)
        }):Play()
    end)

    return button
end

-- Modificar a função de criar o explorador para incluir animações
local function CreateExplorer()
    local gui = Instance.new("ScreenGui")
    gui.Name = "AdvancedExplorer"
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
    mainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.Parent = gui

    -- Adicionar efeito de arredondamento
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0.02, 0)
    uiCorner.Parent = mainFrame

    -- Barra de título com gradiente
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    titleBar.Parent = mainFrame

    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 45))
    })
    uiGradient.Parent = titleBar

    -- Botão de fechar animado
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar

    -- Animação do botão de fechar
    closeButton.MouseEnter:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(200, 0, 0),
            TextSize = 20
        }):Play()
    end)

    closeButton.MouseLeave:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(255, 0, 0),
            TextSize = 18
        }):Play()
    end)

    -- Botão flutuante para reabrir
    local floatingButton = CreateFloatingButton()
    floatingButton.Parent = gui

    -- Lógica de fechar/abrir
    closeButton.MouseButton1Click:Connect(function()
        -- Animação de fechamento
        TweenService:Create(mainFrame, TweenInfo.new(0.5), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        
        wait(0.5)
        mainFrame.Visible = false
        floatingButton.Visible = true

        -- Animação do botão flutuante aparecendo
        floatingButton.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(floatingButton, TweenInfo.new(0.5), {
            Size = UDim2.new(0, 50, 0, 50)
        }):Play()
    end)

    floatingButton.MouseButton1Click:Connect(function()
        -- Animação do botão flutuante sumindo
        TweenService:Create(floatingButton, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        wait(0.3)
        floatingButton.Visible = false
        mainFrame.Visible = true

        -- Animação de abertura
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.5), {
            Size = UDim2.new(0.6, 0, 0.7, 0),
            Position = UDim2.new(0.2, 0, 0.15, 0)
        }):Play()
    end)

    -- [Resto do seu código do explorador aqui...]
    -- Mantenha todas as outras funcionalidades do explorador

    return gui
end

-- Initialize
local function Initialize()
    local player = Players.LocalPlayer
    if not player then
        player = Players.PlayerAdded:Wait()
    end
    
    local explorer = CreateExplorer()
    explorer.Parent = player.PlayerGui
end

Initialize()
