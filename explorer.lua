-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create the main GUI
local FileExplorerGui = Instance.new("ScreenGui")
FileExplorerGui.Name = "FileExplorerGui"
FileExplorerGui.ResetOnSpawn = false

-- Create the main frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = FileExplorerGui

-- Create title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Add title text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -10, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Game File Explorer"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 16
TitleText.Parent = TitleBar

-- Create the scroll frame for file list
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "FileList"
ScrollFrame.Size = UDim2.new(1, -20, 1, -40)
ScrollFrame.Position = UDim2.new(0, 10, 0, 35)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.Parent = MainFrame

-- Function to create a file/folder entry
local function CreateFileEntry(name, isFolder, parent, depth)
    local entry = Instance.new("TextButton")
    entry.Size = UDim2.new(1, -20, 0, 25)
    entry.Position = UDim2.new(0, depth * 20, 0, #parent:GetChildren() * 25)
    entry.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    entry.BorderSizePixel = 0
    entry.Text = (isFolder and "📁 " or "📄 ") .. name
    entry.TextColor3 = Color3.fromRGB(255, 255, 255)
    entry.TextXAlignment = Enum.TextXAlignment.Left
    entry.Font = Enum.Font.SourceSans
    entry.TextSize = 14
    entry.Parent = parent
    
    return entry
end

-- Function to populate the file explorer
local function PopulateFileExplorer(instance, parent, depth)
    for _, child in ipairs(instance:GetChildren()) do
        local entry = CreateFileEntry(child.Name, #child:GetChildren() > 0, parent, depth)
        
        -- Make entries clickable to show children
        entry.MouseButton1Click:Connect(function()
            -- Clear existing children entries
            for _, existing in ipairs(parent:GetChildren()) do
                if existing.Position.Y.Offset > entry.Position.Y.Offset then
                    existing:Destroy()
                end
            end
            
            -- Show children if it's a folder
            if #child:GetChildren() > 0 then
                PopulateFileExplorer(child, parent, depth + 1)
            end
        end)
    end
end

-- Function to initialize the explorer
local function InitializeExplorer()
    ScrollFrame:ClearAllChildren()
    PopulateFileExplorer(game, ScrollFrame, 0)
end

-- Make the frame draggable
local isDragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Add close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

CloseButton.MouseButton1Click:Connect(function()
    FileExplorerGui:Destroy()
end)

-- Initialize the explorer when a player joins
local function onPlayerAdded(player)
    if player.PlayerGui then
        local gui = FileExplorerGui:Clone()
        gui.Parent = player.PlayerGui
        InitializeExplorer()
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Handle existing players
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end
