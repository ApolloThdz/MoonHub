local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Moon Hub",HidePremium = false,SaveConfig = true,ConfigFolder = "MoonC",IntroIcon = "rbxassetid://16924654288",IntroText = "Moon Hub Loading..."
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
                getupvalues(CombatFramework)[2].activeController.timeToNextAttack = 0.00001
                getupvalues(CombatFramework)[2].activeController.hitboxMagnitude = 500
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
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local playerHeightAboveGround = 10
local bringNpcsToggle = false

local function distance(point1, point2)
    return (point1 - point2).Magnitude
end

local function bringNPCsToPlayer()
    local playerPosition = LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart.Position

    if playerPosition then
        local ray = Ray.new(playerPosition + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0))
        local hit, hitPosition = Workspace:FindPartOnRay(ray, LocalPlayer.Character)

        if hit then
            local newPosition = hitPosition + Vector3.new(0, -playerHeightAboveGround, 0)
            local NPCs = Workspace:GetChildren()

            for _, NPC in ipairs(NPCs) do
                if NPC:IsA("Model") and NPC:FindFirstChildOfClass("Humanoid") then
                    NPC:SetPrimaryPartCFrame(CFrame.new(newPosition))
                end
            end
        end
    end
end

local function toggleBringNPCsScript(value)
    bringNpcsToggle = value
    while bringNpcsToggle do
        bringNPCsToPlayer()
        wait(1)
    end
end

Tab2:AddToggle({
    Name = "Bring NPCs",
    Default = false,
    Callback = toggleBringNPCsScript
})
