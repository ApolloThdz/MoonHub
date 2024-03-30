local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Moon Hub",HidePremium = false,SaveConfig = true,ConfigFolder = "MoonC",IntroIcon = "rbxassetid://16924654288",IntroText = "Moon Hub Loading..."
})
OrionLib:MakeNotification({
	Name = "Moon Hub!",
	Content = "Bem Vindo ao Moon Hub",
	Image = "rbxassetid://4483345998",
	Time = 5
})

local Tab = Window:MakeTab({
    Name = "Info",
    Icon = "rbxassetid://16924652746",
    PremiumOnly = false
})
local InfoSection = Tab:AddSection({
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
local FarmSection = Tab2:AddSection({
    Name = "Farming Options"
})

local ToggleValue = false
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local Camera = require(game:GetService("ReplicatedStorage").Util.CameraShaker)

Camera:Stop()

local CombatConnection

local function ToggleCombatScript(Value)
    ToggleValue = Value
    if ToggleValue then
        CombatConnection = game:GetService("RunService").Stepped:Connect(function()
            if getupvalues(CombatFramework)[2].activeController.timeToNextAttack then
                getupvalues(CombatFramework)[2].activeController.timeToNextAttack = 0.000000000000001
                getupvalues(CombatFramework)[2].activeController.hitboxMagnitude = 50
                getupvalues(CombatFramework)[2].activeController:attack()
            end
        end)
    else
        if CombatConnection then
            CombatConnection:Disconnect()
        end
    end
end
Tab2:AddToggle({
    Name = "Ataques Rápidos",
    Default = false,
    Callback = function(Value)
        ToggleCombatScript(Value)
    end
})
local function SetPoints(Value)
    local player = game:GetService("Players").LocalPlayer
    if player.PlayerStats.Points.Value ~= Value then
        player.PlayerStats.Points.Value = Value
    end
end

Tab:AddSlider({
    Name = "Points Set",
    Min = 1,
    Max = 100,
    Default = 1,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Points Set.",
    Callback = function(Value)
        SetPoints(Value)
    end    
})
