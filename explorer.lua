-- Services
local Players = game:GetService("Players")

-- Constants
local COLORS = {
    BACKGROUND = Color3.fromRGB(35, 35, 35),
    HEADER = Color3.fromRGB(45, 45, 45),
    ITEM = Color3.fromRGB(50, 50, 50),
    TEXT = Color3.fromRGB(255, 255, 255)
}

-- Configurações de Performance
local MAX_ITEMS_PER_FRAME = 50  -- Limite de itens por frame
local LOAD_DELAY = 0.03        -- Delay entre carregamentos

local function CreateExplorer()
    local gui = Instance.new("ScreenGui")
    gui.Name = "LiteExplorer"
    
    -- Frame Principal
    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0.5, 0, 0.6, 0)
    main.Position = UDim2.new(0.25, 0, 0.2, 0)
    main.BackgroundColor3 = COLORS.BACKGROUND
    main.Parent = gui
    
    -- Barra de Título
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = COLORS.HEADER
    titleBar.Parent = main
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -30, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = "Game Explorer Lite"
    title.TextColor3 = COLORS.TEXT
    title.Parent = titleBar
    
    -- Botão Fechar
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 30, 0, 30)
    close.Position = UDim2.new(1, -30, 0, 0)
    close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    close.Text = "X"
    close.TextColor3 = COLORS.TEXT
    close.Parent = titleBar
    
    close.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    -- Lista de Itens
    local list = Instance.new("ScrollingFrame")
    list.Size = UDim2.new(1, 0, 1, -30)
    list.Position = UDim2.new(0, 0, 0, 30)
    list.BackgroundColor3 = COLORS.BACKGROUND
    list.ScrollBarThickness = 8
    list.Parent = main
    
    -- Properties Frame
    local props = Instance.new("Frame")
    props.Size = UDim2.new(0.4, 0, 1, 0)
    props.Position = UDim2.new(1, 10, 0, 0)
    props.BackgroundColor3 = COLORS.BACKGROUND
    props.Parent = main
    
    local propsTitle = Instance.new("TextLabel")
    propsTitle.Size = UDim2.new(1, 0, 0, 30)
    propsTitle.BackgroundColor3 = COLORS.HEADER
    propsTitle.Text = "Properties"
    propsTitle.TextColor3 = COLORS.TEXT
    propsTitle.Parent = props
    
    local propsContent = Instance.new("ScrollingFrame")
    propsContent.Size = UDim2.new(1, 0, 1, -30)
    propsContent.Position = UDim2.new(0, 0, 0, 30)
    propsContent.BackgroundColor3 = COLORS.BACKGROUND
    propsContent.ScrollBarThickness = 8
    propsContent.Parent = props
    
    return gui, list, propsContent
end

local function ShowProperties(instance, propsFrame)
    propsFrame:ClearAllChildren()
    local yPos = 0
    
    local function AddProperty(name, value)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 20)
        label.Position = UDim2.new(0, 5, 0, yPos)
        label.BackgroundTransparency = 1
        label.Text = name .. ": " .. tostring(value)
        label.TextColor3 = COLORS.TEXT
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = propsFrame
        yPos = yPos + 25
    end
    
    -- Mostrar propriedades básicas
    AddProperty("Name", instance.Name)
    AddProperty("ClassName", instance.ClassName)
    if instance:IsA("BasePart") then
        AddProperty("Position", tostring(instance.Position))
        AddProperty("Size", tostring(instance.Size))
    end
    
    propsFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

local function LoadItems(parent, listFrame, propsFrame, depth)
    depth = depth or 0
    local yPos = listFrame.CanvasSize.Y.Offset
    local count = 0
    
    for _, item in ipairs(parent:GetChildren()) do
        -- Criar botão do item
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -10, 0, 25)
        button.Position = UDim2.new(0, 5 + depth * 20, 0, yPos)
        button.BackgroundColor3 = COLORS.ITEM
        button.Text = string.rep("  ", depth) .. item.Name
        button.TextColor3 = COLORS.TEXT
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.Parent = listFrame
        
        button.MouseButton1Click:Connect(function()
            ShowProperties(item, propsFrame)
        end)
        
        yPos = yPos + 30
        count = count + 1
        
        -- Atualizar CanvasSize
        listFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
        
        -- Controle de performance
        if count >= MAX_ITEMS_PER_FRAME then
            task.wait(LOAD_DELAY)
            count = 0
        end
    end
end

local function Initialize()
    local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
    
    local gui, list, propsFrame = CreateExplorer()
    gui.Parent = player.PlayerGui
    
    -- Carregar itens iniciais
    task.spawn(function()
        LoadItems(game.Workspace, list, propsFrame)
    end)
end

Initialize()
