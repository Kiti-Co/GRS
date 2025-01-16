-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Constants
local COLORS = {
    BACKGROUND = Color3.fromRGB(35, 35, 35),
    HEADER = Color3.fromRGB(45, 45, 45),
    ITEM = Color3.fromRGB(50, 50, 50),
    ITEM_HOVER = Color3.fromRGB(60, 60, 60),
    TEXT = Color3.fromRGB(255, 255, 255),
    PROPERTY = Color3.fromRGB(200, 200, 200)
}

-- Função para criar botões de item
local function CreateItemButton(text, size, position)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = COLORS.ITEM
    button.Text = text
    button.TextColor3 = COLORS.TEXT
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Font = Enum.Font.SourceSans
    button.TextSize = 14
    button.AutoButtonColor = true
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = COLORS.ITEM_HOVER
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = COLORS.ITEM
    end)
    
    return button
end

local function CreateExplorer()
    local gui = Instance.new("ScreenGui")
    gui.Name = "AdvancedExplorer"
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
    mainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
    mainFrame.BackgroundColor3 = COLORS.BACKGROUND
    mainFrame.Parent = gui
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = COLORS.HEADER
    titleBar.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -30, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = "  Game Explorer"
    title.TextColor3 = COLORS.TEXT
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = titleBar
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = COLORS.TEXT
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar
    
    -- Content Frame
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundColor3 = COLORS.BACKGROUND
    contentFrame.ScrollBarThickness = 8
    contentFrame.Parent = mainFrame
    
    -- Floating Button
    local floatingButton = Instance.new("ImageButton")
    floatingButton.Name = "OpenExplorerButton"
    floatingButton.Size = UDim2.new(0, 50, 0, 50)
    floatingButton.Position = UDim2.new(0, 10, 0.5, -25)
    floatingButton.BackgroundColor3 = COLORS.HEADER
    floatingButton.Image = "rbxassetid://6034925618"
    floatingButton.Visible = false
    floatingButton.Parent = gui
    
    -- Função para popular o explorador
    local function PopulateExplorer(parent, depth, yOffset)
        local currentY = yOffset or 0
        depth = depth or 0
        
        for _, item in ipairs(parent:GetChildren()) do
            local button = CreateItemButton(
                string.rep("    ", depth) .. item.Name,
                UDim2.new(1, -10, 0, 25),
                UDim2.new(0, 5, 0, currentY)
            )
            button.Parent = contentFrame
            
            currentY = currentY + 30
            
            if #item:GetChildren() > 0 then
                currentY = PopulateExplorer(item, depth + 1, currentY)
            end
        end
        
        return currentY
    end
    
    -- Popular conteúdo inicial
    local totalHeight = PopulateExplorer(game)
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
    
    -- Animations
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
    
    -- Close/Open Logic
    closeButton.MouseButton1Click:Connect(function()
        TweenService:Create(mainFrame, TweenInfo.new(0.5), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        
        wait(0.5)
        mainFrame.Visible = false
        floatingButton.Visible = true
        
        TweenService:Create(floatingButton, TweenInfo.new(0.5), {
            Size = UDim2.new(0, 50, 0, 50)
        }):Play()
    end)
    
    floatingButton.MouseButton1Click:Connect(function()
        TweenService:Create(floatingButton, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        wait(0.3)
        floatingButton.Visible = false
        mainFrame.Visible = true
        
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.5), {
            Size = UDim2.new(0.6, 0, 0.7, 0),
            Position = UDim2.new(0.2, 0, 0.15, 0)
        }):Play()
    end)
    
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
