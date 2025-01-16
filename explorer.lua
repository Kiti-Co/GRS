-- Services
local Players = game:GetService("Players")

-- Criar uma função de teste simples primeiro
local function CreateSimpleUI()
    -- Mensagem de início para debug
    print("[File Explorer] Iniciando criação da UI")
    
    -- Criar ScreenGui básico
    local gui = Instance.new("ScreenGui")
    gui.Name = "FileExplorerGUI"
    
    -- Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0.5, 0, 0.5, 0)  -- 50% da tela
    mainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)  -- Centralizado
    mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    mainFrame.Parent = gui
    
    -- Lista de arquivos
    local fileList = Instance.new("ScrollingFrame")
    fileList.Name = "FileList"
    fileList.Size = UDim2.new(0.95, 0, 0.9, 0)
    fileList.Position = UDim2.new(0.025, 0, 0.05, 0)
    fileList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    fileList.Parent = mainFrame
    
    -- Função para listar arquivos
    local function ListFiles(parent, yOffset)
        local yPos = yOffset or 0
        
        for _, item in ipairs(parent:GetChildren()) do
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0.95, 0, 0, 30)
            button.Position = UDim2.new(0.025, 0, 0, yPos)
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            button.Text = item.Name
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.TextXAlignment = Enum.TextXAlignment.Left
            button.Parent = fileList
            
            -- Atualizar posição para próximo item
            yPos = yPos + 35
        end
        
        -- Ajustar tamanho do ScrollingFrame
        fileList.CanvasSize = UDim2.new(0, 0, 0, yPos)
    end
    
    -- Começar listagem com o Workspace
    ListFiles(game.Workspace)
    
    -- Debug
    print("[File Explorer] UI criada com sucesso")
    
    return gui
end

-- Função principal
local function Initialize()
    local player = Players.LocalPlayer
    if not player then
        print("[File Explorer] Esperando pelo jogador...")
        Players.PlayerAdded:Wait()
        player = Players.LocalPlayer
    end
    
    print("[File Explorer] Inicializando para: " .. player.Name)
    
    -- Criar e mostrar UI
    local ui = CreateSimpleUI()
    ui.Parent = player.PlayerGui
    
    print("[File Explorer] Interface criada com sucesso!")
end

-- Iniciar o script
Initialize()
