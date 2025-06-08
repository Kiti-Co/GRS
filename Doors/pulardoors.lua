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
