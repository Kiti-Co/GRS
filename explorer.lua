-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Debug print to confirm script is running
print("File Explorer Script Started")

-- Create the main GUI
local FileExplorerGui = Instance.new("ScreenGui")
FileExplorerGui.Name = "FileExplorerGui"
FileExplorerGui.ResetOnSpawn = false

-- Check if we're in a client context
if not game:GetService("RunService"):IsClient() then
    warn("This script must run on the client!")
    return
end

-- Create the main frame (com cores mais visíveis para debug)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Vermelho para debug
MainFrame.BorderSizePixel = 2
MainFrame.Parent = FileExplorerGui

-- Function to populate the file explorer with debug prints
local function PopulateFileExplorer(instance, parent, depth)
    print("Populating files for:", instance:GetFullName())
    for _, child in ipairs(instance:GetChildren()) do
        print("Found child:", child.Name)
        local entry = Instance.new("TextButton")
        entry.Size = UDim2.new(1, -20, 0, 25)
        entry.Position = UDim2.new(0, depth * 20, 0, #parent:GetChildren() * 25)
        entry.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        entry.Text = child.Name
        entry.TextColor3 = Color3.fromRGB(255, 255, 255)
        entry.TextXAlignment = Enum.TextXAlignment.Left
        entry.Parent = parent
        
        if #child:GetChildren() > 0 then
            PopulateFileExplorer(child, parent, depth + 1)
        end
    end
end

-- Initialize function with debug prints
local function InitializeExplorer()
    print("Initializing Explorer...")
    local player = Players.LocalPlayer
    if not player then
        warn("No LocalPlayer found!")
        return
    end
    
    print("Creating GUI for player:", player.Name)
    local gui = FileExplorerGui:Clone()
    gui.Parent = player.PlayerGui
    
    -- Create a simple scroll frame
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -20, 1, -40)
    ScrollFrame.Position = UDim2.new(0, 10, 0, 35)
    ScrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ScrollFrame.Parent = gui.MainFrame
    
    print("Starting file population...")
    PopulateFileExplorer(game, ScrollFrame, 0)
    print("File population completed")
end

-- Wait for player to load
Players.PlayerAdded:Connect(function(player)
    print("Player added:", player.Name)
    InitializeExplorer()
end)

-- Handle existing players
if Players.LocalPlayer then
    print("Local player already exists:", Players.LocalPlayer.Name)
    InitializeExplorer()
end
