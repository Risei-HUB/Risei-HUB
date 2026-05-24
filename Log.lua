-- =========================================================================
-- 🪐 RISEI-HUB | MINIMALIST FLEXIBLE SPY ENGINE & IGNORE SYSTEM
-- =========================================================================

local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- 🛑 IGNORE (KARA LİSTE) SİSTEMİ
-- Sürekli dönüp ekranı kirleten sinir bozucu paketleri buraya yazarak susturabilirsin reis
local IgnoreList = {
    ["FruitCheck"] = true,
    ["DızlananGereksizPaket"] = true,
    -- Blox Fruits içindeki testlerine göre burayı doldurabilirsin
}

-- =========================================================================
-- 🎨 ESNEK & MİNİMALİST UI TASARIMI (MOBILE FRIENDLY)
-- =========================================================================
local RiseiSpyGui = Instance.new("ScreenGui")
RiseiSpyGui.Name = "RiseiSpyGui"
RiseiSpyGui.ResetOnSpawn = false
RiseiSpyGui.Parent = game:GetService("CoreGui")

-- Ana Panel (Esnek ve Sinsi Siyah)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 220)
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0) -- Ekranın solunda temiz dursun
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = RiseiSpyGui

-- Yuvarlatılmış Köşeler (UI Estetiği)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Üst Bar (Siber Yeşil Çizgili)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.LucidaConsole
Title.Text = "🪐 RISEI-SPY // ACTIVE"
Title.TextColor3 = Color3.fromRGB(0, 255, 150) -- Siber Yeşil
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Kapatma Butonu
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
CloseBtn.TextSize = 16
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function() RiseiSpyGui:Destroy() end)

-- Paketlerin Akacağı Liste Bölümü
local LogContainer = Instance.new("ScrollingFrame")
LogContainer.Size = UDim2.new(1, -10, 1, -40)
LogContainer.Position = UDim2.new(0, 5, 0, 35)
LogContainer.BackgroundTransparency = 1
LogContainer.BorderSizePixel = 0
LogContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
LogContainer.ScrollBarThickness = 3
LogContainer.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 4)
UIList.Parent = LogContainer

-- =========================================================================
-- 🔀 DRAG (SÜRÜKLEME) SİSTEMİ - TELEFONDA GÖRE PANELİ KAYDIRMAK İÇIN
-- =========================================================================
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- =========================================================================
-- 📦 LOG EKLEME VE KOPYALAMA PROSESİ
-- =========================================================================
local function createLogEntry(method, name, args)
    local Entry = Instance.new("Frame")
    Entry.Size = UDim2.new(1, -6, 0, 26)
    Entry.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
    Entry.BorderSizePixel = 0
    Entry.Parent = LogContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Entry

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(0.75, 0, 1, 0)
    TextLabel.Position = UDim2.new(0, 6, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = string.format("[%s] -> %s", method == "FireServer" and "E" or "F", name)
    TextLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    TextLabel.TextSize = 13
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = Entry

    -- Tek Tıkla Kodu Panoya Kopyalayan Akıllı Buton
    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Size = UDim2.new(0, 60, 0, 20)
    CopyBtn.Position = UDim2.new(1, -65, 0, 3)
    CopyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 42)
    CopyBtn.Font = Enum.Font.SourceSansBold
    CopyBtn.Text = "DIZLA"
    CopyBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
    CopyBtn.TextSize = 11
    CopyBtn.Parent = Entry
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = CopyBtn

    -- Argümanları dızlanabilir Lua koduna çevirme lojiği
    local argsString = ""
    for i, v in pairs(args) do
        argsString = argsString .. string.format("[%d] = %s,\n", i, typeof(v) == "string" and '"'..tostring(v)..'"' or tostring(v))
    end
    local formattedCode = string.format("local args = {\n%s}\ngame:GetService(\"ReplicatedStorage\").Remotes[\"%s\"]: %s(unpack(args))", argsString, name, method)

    CopyBtn.MouseButton1Click:Connect(function()
        setclipboard(formattedCode)
        CopyBtn.Text = "KOPYALANDI"
        CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
        task.wait(1)
        CopyBtn.Text = "DIZLA"
        CopyBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
    end)

    -- Listeyi otomatik aşağı kaydır
    LogContainer.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y)
end

-- =========================================================================
-- METATABLE HOOK MOTORU (SADECE GEREKLİ REMOTE'LAR)
-- =========================================================================
local mt = getrawmetatable(game)
local oldInstance = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    local remoteName = tostring(self)
    
    if method == "FireServer" or method == "InvokeServer" then
        if string.find(remoteName, "CommF_") or string.find(remoteName, "CommE") then
            -- 🛑 İGNRE KONTROLÜ: Eğer paket kara listedeyse direkt es geç, ekrana basma!
            if not IgnoreList[remoteName] then
                task.spawn(function()
                    createLogEntry(method, remoteName, args)
                end)
            end
        end
    end
    
    return oldInstance(self, ...)
end)

setreadonly(mt, true)
