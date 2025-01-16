-- Services
local Players = game:GetService("Players")

-- Constants for styling
local COLORS = {
    BACKGROUND = Color3.fromRGB(35, 35, 35),
    HEADER = Color3.fromRGB(45, 45, 45),
    ITEM = Color3.fromRGB(50, 50, 50),
    ITEM_HOVER = Color3.fromRGB(60, 60, 60),
    TEXT = Color3.fromRGB(255, 255, 255),
    PROPERTY = Color3.fromRGB(200, 200, 200),
    STRING = Color3.fromRGB(150, 255, 150),
    NUMBER = Color3.fromRGB(150, 150, 255),
    BOOL = Color3.fromRGB(255, 150, 150)
}

local function CreateStyledButton(text, size, position)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = COLORS.ITEM
    button.Text = text
    button.TextColor3 = COLORS.TEXT
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = true
    button.Font = Enum.Font.SourceSans
    button.TextSize = 14
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = COLORS.ITEM_HOVER
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = COLORS.ITEM
    end)
    
    return button
end

local function CreatePropertyViewer()
    local viewer = Instance.new("Frame")
    viewer.Name = "PropertyViewer"
    viewer.Size = UDim2.new(0.3, 0, 1, 0)
    viewer.Position = UDim2.new(0.7, 0, 0, 0)
    viewer.BackgroundColor3 = COLORS.BACKGROUND
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = COLORS.HEADER
    title.Text = "Properties"
    title.TextColor3 = COLORS.TEXT
    title.Parent = viewer
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, -30)
    scroll.Position = UDim2.new(0, 0, 0, 30)
    scroll.BackgroundColor3 = COLORS.BACKGROUND
    scroll.ScrollBarThickness = 8
    scroll.Parent = viewer
    
    return viewer, scroll
end

local function DisplayProperties(instance, propertyList)
    propertyList:ClearAllChildren()
    local yOffset = 5
    
    -- Function to add a property row
    local function AddProperty(name, value, propertyType)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, -10, 0, 25)
        container.Position = UDim2.new(0, 5, 0, yOffset)
        container.BackgroundTransparency = 1
        container.Parent = propertyList
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(0.4, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name
        nameLabel.TextColor3 = COLORS.PROPERTY
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = container
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0.6, 0, 1, 0)
        valueLabel.Position = UDim2.new(0.4, 0, 0, 0)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = tostring(value)
        valueLabel.TextColor3 = COLORS[propertyType]
        valueLabel.TextXAlignment = Enum.TextXAlignment.Left
        valueLabel.Parent = container
        
        yOffset = yOffset + 30
    end
    
    -- Try to get common properties
    local properties = {
        {"Name", instance.Name, "STRING"},
        {"ClassName", instance.ClassName, "STRING"},
        {"Parent", instance.Parent and instance.Parent.Name or "nil", "STRING"}
    }
    
    -- Try to get position/size for relevant instances
    if instance:IsA("BasePart") or instance:IsA("GuiObject") then
        if instance:IsA("BasePart") then
            properties[#properties + 1] = {"Position", instance.Position, "NUMBER"}
            properties[#properties + 1] = {"Size", instance.Size, "NUMBER"}
        else
            properties[#properties + 1] = {"Position", instance.Position, "NUMBER"}
            properties[#properties + 1] = {"Size", instance.Size, "NUMBER"}
        end
    end
    
    -- Add all properties
    for _, prop in ipairs(properties) do
        AddProperty(prop[1], prop[2], prop[3])
    end
    
    propertyList.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

local function CreateExplorer()
    local gui = Instance.new("ScreenGui")
    gui.Name = "AdvancedExplorer"
    
    -- Main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
    mainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
    mainFrame.BackgroundColor3 = COLORS.BACKGROUND
    mainFrame.Parent = gui
    
    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = COLORS.HEADER
    titleBar.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = "Advanced Game Explorer"
    title.TextColor3 = COLORS.TEXT
    title.Parent = titleBar
    
    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = COLORS.TEXT
    closeButton.Parent = titleBar
    
    closeButton.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    -- File explorer section
    local explorer = Instance.new("ScrollingFrame")
    explorer.Size = UDim2.new(0.7, 0, 1, -30)
    explorer.Position = UDim2.new(0, 0, 0, 30)
    explorer.BackgroundColor3 = COLORS.BACKGROUND
    explorer.ScrollBarThickness = 8
    explorer.Parent = mainFrame
    
    -- Property viewer
    local propertyViewer, propertyList = CreatePropertyViewer()
    propertyViewer.Parent = mainFrame
    
    -- Function to populate explorer
    local function PopulateExplorer(parent, depth, yOffset)
        local currentY = yOffset or 0
        depth = depth or 0
        
        for _, item in ipairs(parent:GetChildren()) do
            local button = CreateStyledButton(string.rep("    ", depth) .. item.Name,
                UDim2.new(1, -10, 0, 25),
                UDim2.new(0, 5, 0, currentY))
            
            button.Parent = explorer
            
            -- Show properties when clicked
            button.MouseButton1Click:Connect(function()
                DisplayProperties(item, propertyList)
            end)
            
            currentY = currentY + 30
            
            -- Recursively add children
            if #item:GetChildren() > 0 then
                currentY = PopulateExplorer(item, depth + 1, currentY)
            end
        end
        
        return currentY
    end
    
    -- Populate initial view
    local totalHeight = PopulateExplorer(game)
    explorer.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
    
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
