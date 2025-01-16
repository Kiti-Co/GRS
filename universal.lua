local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/kiti-sites/GRS/refs/heads/main/rayfield.lua'))()

local Window = Rayfield:CreateWindow({
   Name = "Gui Roblox Scripts",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Sirius",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "GRS"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Universal", 4483362458) -- Title, Image

local Section = Tab:CreateSection("Sessão")

local Button = Tab:CreateButton({
   Name = "Mira",
   Callback = function()
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = game:GetService("Workspace").CurrentCamera

-- Criação de um ScreenGui para conter a mira
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Criação do Frame para a mira (a base do X)
local crosshair = Instance.new("Frame")
crosshair.Size = UDim2.new(0, 30, 0, 30)  -- Tamanho reduzido para a mira
crosshair.AnchorPoint = Vector2.new(0.5, 0.5)  -- Faz a mira centralizada
crosshair.BackgroundTransparency = 1  -- Tornando o fundo transparente
crosshair.Parent = screenGui

-- Calculando a posição no centro da tela com base no ViewportSize
crosshair.Position = UDim2.new(0.5, 0, 0.5, 0)

-- Criando a linha diagonal para o X (da esquerda para a direita)
local diagonalLine1 = Instance.new("Frame")
diagonalLine1.Size = UDim2.new(0, 15, 0, 2)  -- Linha diagonal pequena
diagonalLine1.Position = UDim2.new(0.5, 0, 0.5, 0)  -- Posiciona no centro
diagonalLine1.AnchorPoint = Vector2.new(0.5, 0.5)
diagonalLine1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Cor da linha
diagonalLine1.Rotation = 45  -- Rotaciona a linha para formar o X
diagonalLine1.Parent = crosshair

-- Criando a outra linha diagonal para o X (da direita para a esquerda)
local diagonalLine2 = Instance.new("Frame")
diagonalLine2.Size = UDim2.new(0, 15, 0, 2)  -- Linha diagonal pequena
diagonalLine2.Position = UDim2.new(0.5, 0, 0.5, 0)  -- Posiciona no centro
diagonalLine2.AnchorPoint = Vector2.new(0.5, 0.5)
diagonalLine2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Cor da linha
diagonalLine2.Rotation = -45  -- Rotaciona a linha para formar o X
diagonalLine2.Parent = crosshair
   end,
})

local Button = Tab:CreateButton({
   Name = "Veja os arquivos do jogo",
   Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/kiti-sites/GRS/refs/heads/main/explorer.lua'))()
})

Rayfield:LoadConfiguration()
