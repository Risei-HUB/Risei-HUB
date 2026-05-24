-- =========================================================================
-- 🪐 RISEI-HUB | INDEPENDENT FRUIT ENGINE (FRUIT.LUA)
-- =========================================================================

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- Sinsi Süzülme Fonksiyonu (Fly to Fruit)
local function flyToFruit(pos)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for i = 1, 25 do
        if not _G.AutoFruitFarm then break end
        hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(pos), 0.3)
        task.wait(0.01)
    end
end

-- Meyve Toplama ve Sunucu Deposuna Atma Paketi (Collect & Store)
local function collectFruits()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if not _G.AutoFruitFarm then break end
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") and string.lower(obj.Name):find("fruit") then
            flyToFruit(obj.Handle.Position)
            LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(obj)
            task.wait(0.5)
            CommF:InvokeServer("StoreFruit", obj.Name)
            task.wait(1)
        end
    end
end

-- Sunucu Değiştirici (Server Hop Engine)
local function serverHop()
    local pid = game.PlaceId
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. pid .. "/servers/Public?limit=100")).data
    end)
    
    if success and result then
        for _, s in pairs(result) do
            if s.id ~= game.JobId and s.playing < s.maxPlayers then
                TeleportService:TeleportToPlaceInstance(pid, s.id, LocalPlayer)
                break
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

                local found = false
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Tool") and string.lower(obj.Name):find("fruit") then
                        found = true
                        break
                    end
                end

                if not found and _G.AutoFruitFarm then
                    task.wait(1)
                    serverHop()
                end
            end)
            task.wait(5)
        end
    end)
end
