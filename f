--Abaixo estará a Lib da nossa Ui

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/7yhx/kwargs_Ui_Library/main/source.lua"))()

local UI = Lib:Create{
    Theme = "Dark", -- or any other theme
    Size = UDim2.new(0, 555, 0, 400) -- default
 }
 
 local Main = UI:Tab{
    Name = "Inicio"
 }
 
 local Divider = Main:Divider{
    Name = "Inicio shit"
 }
 
 local QuitDivider = Main:Divider{
    Name = "Sair"
 }

 local Players = game:GetService("Players")
 local LocalPlayer = Players.LocalPlayer
 local Mouse = LocalPlayer:GetMouse()
 local RunService = game:GetService("RunService")
 local UserInputService = game:GetService("UserInputService")
 local Camera = workspace.CurrentCamera
 
 local aimbotEnabled = false
 
 -- Função para obter o jogador mais próximo
 function GetClosestPlayer()
     local closestPlayer = nil
     local shortestDistance = math.huge
 
     for _, player in pairs(Players:GetPlayers()) do
         if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and player.Character and player.Character:FindFirstChild("Head") then
             local distance = (player.Character.Head.Position - LocalPlayer.Character.Head.Position).magnitude
             if distance < shortestDistance then
                 closestPlayer = player
                 shortestDistance = distance
             end
         end
     end
 
     return closestPlayer
 end
 
 -- Função para desenhar ESP
 function DrawESP(player)
     local espBox = Drawing.new("Square")
     espBox.Visible = true
     espBox.Color = player.Team == LocalPlayer.Team and Color3.new(0, 0, 1) or Color3.new(1, 0, 0)
     espBox.Thickness = 2
     espBox.Transparency = 1
 
     RunService.RenderStepped:Connect(function()
         if player.Character and player.Character:FindFirstChild("Head") then
             local headPos = Camera:WorldToViewportPoint(player.Character.Head.Position)
             espBox.Size = Vector2.new(50, 50)
             espBox.Position = Vector2.new(headPos.X - 25, headPos.Y - 25)
         else
             espBox.Visible = false
         end
     end)
 end
 
 -- Ativar/Desativar Aimbot
 UserInputService.InputBegan:Connect(function(input)
     if input.KeyCode == Enum.KeyCode.c then
         aimbotEnabled = not aimbotEnabled
     end
 end)
 
 -- Aimbot
 RunService.RenderStepped:Connect(function()
     if aimbotEnabled then
         local target = GetClosestPlayer()
         if target then
             Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
         end
     end
 end)
 
 -- Desenhar ESP para todos os jogadores
 for _, player in pairs(Players:GetPlayers()) do
     if player ~= LocalPlayer then
         DrawESP(player)
     end
 end
 
 Players.PlayerAdded:Connect(function(player)
     if player ~= LocalPlayer then
         DrawESP(player)
     end
 end)
