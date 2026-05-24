-- =========================================================================
-- 🪐 RISEI-HUB | PURE CONTROL PANEL SHELL (MAIN.LUA)
-- =========================================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🪐 Risei-HUB | Quantum Edition",
   LoadingTitle = "Booting Pure UI Shell...",
   LoadingSubtitle = "by Risei",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false
})

local TeleportService = game:GetService("TeleportService")

-- --- TABS ---
local MainTab = Window:CreateTab("🏠 Home", 4483362458)
local FarmTab = Window:CreateTab("🌾 Auto Farm", 4483345909)
local FruitTab = Window:CreateTab("🍓 Fruit Farm", 4483345909)
local CombatTab = Window:CreateTab("⚔️ Combat & Stats", 4483345909)
local SeaSelectTab = Window:CreateTab("Sea Select", 4483345909)

MainTab:CreateParagraph({
   Title = "Pure Shell Active!", 
   Content = "Zero backend logic remains inside this panel. Every action invokes a dedicated cloud module from your repository."
})

-- =========================================================================
-- 🌾 AUTO FARM MODULE INJECTIONS
-- =========================================================================
FarmTab:CreateButton({
   Name = "Take Level 1 Quest (Bandit Quest)",
   Callback = function()
      _G.FarmAction = "StartQuest"
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Risei-HUB/Risei-HUB/main/Farm.lua"))()
      Rayfield:Notify({Title = "🪐 Risei-HUB", Content = "Farm module invoked.", Duration = 2})
   end,
})

FarmTab:CreateButton({
   Name = "Abandon Current Quest",
   Callback = function()
      _G.FarmAction = "AbandonQuest"
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Risei-HUB/Risei-HUB/main/Farm.lua"))()
   end,
})

-- =========================================================================
-- 🍓 FRUIT MODULE INJECTIONS (NEW CONFIGURATION)
-- =========================================================================
_G.AutoFruitFarm = false
_G.FruitTween = false
_G.AutoStoreFruit = false

FruitTab:CreateToggle({
   Name = "Auto Fruit Collect",
   CurrentValue = false,
   Flag = "FruitFarmToggle",
   Callback = function(Value)
      _G.AutoFruitFarm = Value
      if _G.AutoFruitFarm then
         Rayfield:Notify({Title = "🍓 FRUIT ENGINE", Content = "Deploying fruit harvester...", Duration = 2})
         loadstring(game:HttpGet("https://raw.githubusercontent.com/Risei-HUB/Risei-HUB/main/Fruit.lua"))()
      end
   end,
})

FruitTab:CreateToggle({
   Name = "Fruit Tween (Smooth Fly)",
   CurrentValue = false,
   Flag = "FruitTweenToggle",
   Callback = function(Value)
      _G.FruitTween = Value -- Açılırsa süzülür, kapanırsa direkt teleport atar
   end,
})

FruitTab:CreateToggle({
   Name = "Auto Store Fruit (Inventory)",
   CurrentValue = false,
   Flag = "AutoStoreToggle",
   Callback = function(Value)
      _G.AutoStoreFruit = Value -- Açılırsa envantere atar, kapanırsa sadece elde tutar
   end,
})

-- =========================================================================
SeaSelectTab:CreateButton({Name = "Teleport to: First Sea", Callback = function() TeleportService:Teleport(2753915549) end})
SeaSelectTab:CreateButton({Name = "Teleport to: Second Sea", Callback = function() TeleportService:Teleport(4442272183) end})
SeaSelectTab:CreateButton({Name = "Teleport to: Third Sea", Callback = function() TeleportService:Teleport(7449423635) end})

-- =========================================================================
-- ⚔️ COMBAT MODULE INJECTIONS
-- =========================================================================
_G.AutoClick = false
CombatTab:CreateToggle({
   Name = "Auto Clicker (M1)",
   CurrentValue = false,
   Flag = "AutoClickToggle",
   Callback = function(Value)
      _G.AutoClick = Value
      _G.CombatAction = "ToggleClick"
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Risei-HUB/Risei-HUB/main/Combat.lua"))()
   end,
})

CombatTab:CreateButton({
   Name = "Upgrade Melee (+5 Points)",
   Callback = function() 
      _G.CombatAction = "UpgradeMelee"
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Risei-HUB/Risei-HUB/main/Combat.lua"))()
   end
})

CombatTab:CreateButton({
   Name = "Upgrade Defense (+5 Points)",
   Callback = function() 
      _G.CombatAction = "UpgradeDefense"
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Risei-HUB/Risei-HUB/main/Combat.lua"))()
   end
})
