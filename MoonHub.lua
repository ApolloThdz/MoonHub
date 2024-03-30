local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "Moon Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MoonC",
    IntroIcon = "rbxassetid://16924654288",
    IntroText = "Moon Hub Loading..."
})
local Tab = Window:MakeTab({
    Name = "Info",
    Icon = "rbxassetid://16924652746",
    PremiumOnly = false
})
local Section = Tab:AddSection({
    Name = "Informations"
})

Tab:AddTextbox({
    Name = "Server Code",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        local serverCode = tostring(Value)
        if serverCode ~= "" then
            game:GetService("TeleportService"):TeleportToPlaceInstance(7449423635, serverCode, game:GetService("Players").LocalPlayer)
        end
    end	  
})
local Tab2 = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://16924662905",
    PremiumOnly = false
})
local Section = Tab2:AddSection({
    Name = "Farming Options"
})

local ToggleValue = false
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local Camera = require(game.ReplicatedStorage.Util.CameraShaker)

local FastAttackEnabled = false
local SuperFastAttackEnabled = false

local RigC = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local VirtualUser = game:GetService('VirtualUser')
local kkii = require(game.ReplicatedStorage.Util.CameraShaker)

local FastAttackConnection
local SuperFastAttackConnection

local function EnableFastAttack(value)
    FastAttackEnabled = value
    if FastAttackEnabled then
        FastAttackConnection = game:GetService("RunService").Stepped:Connect(function()
            if getupvalues(CombatFramework)[2]['activeController'].timeToNextAttack then
                getupvalues(CombatFramework)[2]['activeController'].timeToNextAttack = 0
                getupvalues(CombatFramework)[2]['activeController'].hitboxMagnitude = 50
                getupvalues(CombatFramework)[2]['activeController']:attack()
            end
        end)
    else
        if FastAttackConnection then
            FastAttackConnection:Disconnect()
        end
    end
end

local function EnableSuperFastAttack(value)
    SuperFastAttackEnabled = value
    if SuperFastAttackEnabled then
        SuperFastAttackConnection = game:GetService("RunService").Heartbeat:Connect(function()
            pcall(function()
                RigC.activeController.timeToNextAttack = 0
                RigC.activeController.attacking = false
                RigC.activeController.blocking = false
                RigC.activeController.timeToNextAttack = 0
                RigC.activeController.timeToNextBlock = 0
                RigC.activeController.increment = 3
                RigC.activeController.hitboxMagnitude = 100
                game.Players.LocalPlayer.Character.Stun.Value = 0
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
  
                VirtualUser:CaptureController()
                VirtualUser:Button1Down(Vector2.new(1280, 672))
                kkii:Stop()
            end)
        end)
    else
        if SuperFastAttackConnection then
            SuperFastAttackConnection:Disconnect()
        end
    end
end


local function AttackOptionSelected(option)
    if option == "Fast Attack" then
        EnableFastAttack(true)
        EnableSuperFastAttack(false)
    elseif option == "Super" then
        EnableFastAttack(false)
        EnableSuperFastAttack(true)
    end
end

-- Adiciona um dropdown menu na interface do usuário para selecionar o tipo de ataque
local attackOptionsDropdown = Tab:AddDropdown({
    Name = "Attack Options",
    Default = "Fast Attack",
    Options = {Fast Attack, Super},
    Callback = AttackOptionSelected
})
