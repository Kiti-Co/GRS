local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/kiti-sites/GRS/refs/heads/main/rayfield.lua'))()

local Window = Rayfield:CreateWindow({
   Name = "Gui Roblox Scripts",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Gui Roblox Scripts",
   LoadingSubtitle = "by Rfonte",
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

local Tab = Window:CreateTab("Mini-games", 4483362458) -- Title, Image

local Section = Tab:CreateSection("Sessão")

local Button = Tab:CreateButton({
   Name = "Batatinha frita 1.. 2.. 3... by Rhyan57",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/kiti-sites/GRS/refs/heads/main/batatinhafrita.lua"))()
   end,
})
local Button = Tab:CreateButton({
   Name = "Permitir pulo",
   Callback = function()
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Configuração do impulso para o pulo
local JUMP_FORCE = 25  -- Ajuste o valor para definir a força do pulo (mais baixo)
local debounce = false -- Previne múltiplos pulos simultâneos

-- Função para realizar o pulo
local function performJump()
    if debounce then return end
    debounce = true

    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")

    if humanoid and humanoidRootPart then
        -- Aplica uma força para simular o pulo
        humanoidRootPart.Velocity = Vector3.new(
            humanoidRootPart.Velocity.X,
            JUMP_FORCE,
            humanoidRootPart.Velocity.Z
        )
    end

    -- Delay para evitar spam de pulo
    task.wait(0.5) -- Tempo de recarga para o próximo pulo
    debounce = false
end

-- Detecta quando a barra de espaço é pressionada
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Ignora se o input já foi processado pelo jogo
    if input.KeyCode == Enum.KeyCode.Space then
        performJump()
    end
end)

   end,
})

Rayfield:LoadConfiguration()
