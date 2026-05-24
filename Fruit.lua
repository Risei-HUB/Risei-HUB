-- =========================================================================
-- 🪐 RISEI-HUB | ADVANCED FRUIT ENGINE (FRUIT.LUA)
-- =========================================================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- Gelişmiş Yumuşak Süzülme (Tween/Lerp Fly)
local function flyToFruit(pos)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if _G.FruitTween then
        -- Eğer Fruit Tween açık ise sinsi ve yumuşak bir şekilde meyveye süzülür
        for i = 1, 25 do
            if not _G.AutoFruitFarm then break end
            hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(pos), 0.3)
            task.wait(0.01)
        end
    else
        -- Eğer Fruit Tween kapalı ise direkt meyvenin tepesine ışınlanır (Instant Teleport)
        hrp.CFrame = CFrame.new(pos)
        task.wait(0.1)
    end
end

-- Meyve Toplama ve Karar Mekanizması
local function collectFruits()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if not _G.AutoFruitFarm then break end
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") and string.lower(obj.Name):find("fruit") then
            -- Meyveye git (Açık olan moda göre tween veya direkt teleport)
            flyToFruit(obj.Handle.Position)
            
            -- Meyveyi ele al
            LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(obj)
            task.wait(0.5)
            
            -- Eğer Auto Store açık ise QuantumOnyx paketiyle sunucuya kilitle
            if _G.AutoStoreFruit then
                CommF:InvokeServer("StoreFruit", obj.Name)
                task.wait(1)
            end
        end
    end
end

-- BAĞIMSIZ ARKA PLAN DÖNGÜSÜ
if _G.AutoFruitFarm then
    task.spawn(function()
        while _G.AutoFruitFarm do
            pcall(function()
                collectFruits()
            end)
            task.wait(3) -- Harita kontrol sıklığı (3 saniyeye düşürüldü, daha hızlı)
        end
    end)
end
