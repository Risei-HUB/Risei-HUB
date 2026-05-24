-- =========================================================================
-- 🪐 RISEI-HUB | QUANTUM ENGINE INTEGRATION (MAIN.LUA - FIXED LINK)
-- =========================================================================

-- The stable official link that successfully executes on Delta
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🪐 Risei-HUB | Quantum Edition",
   LoadingTitle = "Booting Risei-HUB Engine...",
   LoadingSubtitle = "by Risei",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false
})

-- =========================================================================
-- NETWORK COMMUNICATION CHANNELS (QUANTUM ANALYSIS)
-- =========================================================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local CommE = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommE")

-- =========================================================================
-- TABS
-- =========================================================================
local MainTab = Window:CreateTab("🏠 Home", 4483362458)
local FarmTab = Window:CreateTab("🌾 Auto Farm", 4483345909)
local CombatTab = Window:CreateTab("⚔️ Combat & Stats", 4483345909)

-- =========================================================================
-- CONTENTS & DIRECT COMMAND INJECTIONS
-- =========================================================================

MainTab:CreateParagraph({
   Title = "Welcome to the Lab!", 
   Content = "The intermediary spy tools have been dismantled. Clean remote packets filtered from the QuantumOnyx framework are now fully integrated as automated buttons below."
})

-- --- AUTO FARM TAB ---
FarmTab:CreateButton({
   Name = "Take Level 1 Quest (Bandit Quest)",
   Callback = function()
      -- Original packet bypassed directly to the server:
      pcall(function()
         CommF:InvokeServer("StartQuest", "BanditQuest1", 1)
      end)
      Rayfield:Notify({Title = "🪐 Risei-HUB", Content = "Quest packet successfully injected!", Duration = 2})
   end,
})

FarmTab:CreateButton({
   Name = "Abandon Current Quest",
   Callback = function()
      -- Direct packet to clear/cancel the current quest active on the server
      pcall(function()
         CommF:InvokeServer("AbandonQuest")
      end)
      Rayfield:Notify({Title = "🪐 Risei-HUB", Content = "Quest abandoned successfully.", Duration = 2})
   end,
})

-- --- COMBAT & STATS TAB ---
CombatTab:CreateToggle({
   Name = "Auto Clicker (M1)",
   CurrentValue = false,
   Flag = "AutoClickToggle",
   Callback = function(Value)
      _G.AutoClick = Value
      task.spawn(function()
         while _G.AutoClick do
            -- Virtual network packet to bypass and trigger melee or sword attacks instantly
            pcall(function()
               local VirtualUser = game:GetService("VirtualUser")
               VirtualUser:CaptureController()
               VirtualUser:ClickButton1(Vector2.new(850, 520))
            end)
            task.wait(0.1) -- Attack speed delay (10 clicks per second)
         end
      end)
   end,
})

CombatTab:CreateButton({
   Name = "Upgrade Melee (+5 Points)",
   Callback = function()
      -- QuantumOnyx stat allocation packet for combat optimization
      pcall(function()
         CommF:InvokeServer("AddPoint", "Melee", 5)
      end)
   end,
})

CombatTab:CreateButton({
   Name = "Upgrade Defense (+5 Points)",
   Callback = function()
      pcall(function()
         CommF:InvokeServer("AddPoint", "Defense", 5)
      end)
   end,
})
