local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Moon Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "MoonC", IntroIcon = "rbxassetid://16924654288"})
local Tab = Window:MakeTab({
	Name = "Info",
	Icon = "rbxassetid://16924652746",
	PremiumOnly = false
})
local Section = Tab:AddSection({
	Name = "Test"
})
