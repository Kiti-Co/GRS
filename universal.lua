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
})

local Button = Tab:CreateButton({
   Name = "Voar",
   Callback = function()
-- Gui to Lua
-- Version: 3.2

-- Instances:

local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")

--Properties:

main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)

up.Name = "up"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "UP"
up.TextColor3 = Color3.fromRGB(0, 0, 0)
up.TextSize = 14.000

down.Name = "down"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "DOWN"
down.TextColor3 = Color3.fromRGB(0, 0, 0)
down.TextSize = 14.000

onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
onof.Size = UDim2.new(0, 56, 0, 28)
onof.Font = Enum.Font.SourceSans
onof.Text = "fly"
onof.TextColor3 = Color3.fromRGB(0, 0, 0)
onof.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "gui by me_ozoneYT"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
speed.Size = UDim2.new(0, 44, 0, 28)
speed.Font = Enum.Font.SourceSans
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(0, 0, 0)
speed.TextScaled = true
speed.TextSize = 14.000
speed.TextWrapped = true

mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
mine.Size = UDim2.new(0, 45, 0, 29)
mine.Font = Enum.Font.SourceSans
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(0, 0, 0)
mine.TextScaled = true
mine.TextSize = 14.000
mine.TextWrapped = true

speeds = 1

local speaker = game:GetService("Players").LocalPlayer

local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = false

game:GetService("StarterGui"):SetCore("SendNotification", { 
    Title = "GO SUB TO HIM";
    Text = "fly gui by me_ozoneYT";
    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})
Duration = 16;

Frame.Active = true -- main = gui
Frame.Draggable = true

onof.MouseButton1Down:connect(function()

    if nowe == true then
        nowe = false

        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    else 
        nowe = true



        for i = 1, speeds do
            spawn(function()

                local hb = game:GetService("RunService").Heartbeat


                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end

            end)
        end
        game.Players.LocalPlayer.Character.Animate.Disabled = true
        local Char = game.Players.LocalPlayer.Character
        local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

        for i,v in next, Hum:GetPlayingAnimationTracks() do
            v:AdjustSpeed(0)
        end
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    end




    if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then



        local plr = game.Players.LocalPlayer
        local torso = plr.Character.Torso
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speed = 0


        local bg = Instance.new("BodyGyro", torso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = torso.CFrame
        local bv = Instance.new("BodyVelocity", torso)
        bv.velocity = Vector3.new(0,0.1,0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        if nowe == true then
            plr.Character.Humanoid.PlatformStand = true
        end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            game:GetService("RunService").RenderStepped:Wait()

            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed+.5+(speed/maxspeed)
                if speed > maxspeed then
                    speed = maxspeed
                end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed-1
                if speed < 0 then
                    speed = 0
                end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
                bv.velocity = Vector3.new(0,0,0)
            end
            --  game.Players.LocalPlayer.Character.Animate.Disabled = true
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speed = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false




    else
        local plr = game.Players.LocalPlayer
        local UpperTorso = plr.Character.UpperTorso
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speed = 0


        local bg = Instance.new("BodyGyro", UpperTorso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = UpperTorso.CFrame
        local bv = Instance.new("BodyVelocity", UpperTorso)
        bv.velocity = Vector3.new(0,0.1,0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        if nowe == true then
            plr.Character.Humanoid.PlatformStand = true
        end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            wait()

            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed+.5+(speed/maxspeed)
                if speed > maxspeed then
                    speed = maxspeed
                end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed-1
                if speed < 0 then
                    speed = 0
                end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
                bv.velocity = Vector3.new(0,0,0)
            end

            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speed = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false



    end





end)


up.MouseButton1Down:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)

end)


down.MouseButton1Down:connect(function()

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-2,0)

end)


game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.7)
    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
    game.Players.LocalPlayer.Character.Animate.Disabled = false

end)


plus.MouseButton1Down:connect(function()
    speeds = speeds + 1
    speed.Text = speeds
    if nowe == true then


    tpwalking = false
    for i = 1, speeds do
        spawn(function()

            local hb = game:GetService("RunService").Heartbeat


            tpwalking = true
            local chr = game.Players.LocalPlayer.Character
            local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
            while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                if hum.MoveDirection.Magnitude > 0 then
                    chr:TranslateBy(hum.MoveDirection)
                end
            end

        end)
        end
        end
end)
mine.MouseButton1Down:connect(function()
    if speeds == 1 then
        speed.Text = 'can not be less than 1'
        wait(1)
        speed.Text = speeds
    else
    speeds = speeds - 1
        speed.Text = speeds
        if nowe == true then
    tpwalking = false
    for i = 1, speeds do
        spawn(function()

            local hb = game:GetService("RunService").Heartbeat


            tpwalking = true
            local chr = game.Players.LocalPlayer.Character
            local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
            while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                if hum.MoveDirection.Magnitude > 0 then
                    chr:TranslateBy(hum.MoveDirection)
                end
            end

        end)
        end
        end
        end
end)
})

Rayfield:LoadConfiguration()
