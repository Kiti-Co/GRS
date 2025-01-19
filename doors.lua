-- Load MsdoorsNotify
local MsdoorsNotify = loadstring(game:HttpGet('https://raw.githubusercontent.com/Sc-Rhyan57/Notification-doorsAPI/refs/heads/main/Msdoors/MsdoorsApi.lua'))()
MsdoorsNotify("Rodando GRS", "Um simples script de doors", "139815072942572", "#8cc3e4", "5s")

-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/kiti-sites/GRS/refs/heads/main/rayfield.lua"))()

-- Create Rayfield Window
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

-- Create Tab and Section
local Tab = Window:CreateTab("Doors", 4483362458)
local Section = Tab:CreateSection("Sessão")

-- Button: Batatinha Frita Script
local Button = Tab:CreateButton({
   Name = "Batatinha frita 1.. 2.. 3... by Rhyan57",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/kiti-sites/GRS/refs/heads/main/batatinhafrita.lua"))()
   end,
})

-- Button: Permitir Pulo
local Button = Tab:CreateButton({
   Name = "Permitir pulo",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/kiti-sites/GRS/refs/heads/main/pulardoors.lua"))()
   end,
})

-- Button: Mira (Crosshair)
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
      loadstring(game:HttpGet('https://raw.githubusercontent.com/kiti-sites/GRS/refs/heads/main/explorer.lua'))()
   end,
})

-- Load Rayfield Configuration
Rayfield:LoadConfiguration()
