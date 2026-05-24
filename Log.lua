-- RISEI-HUB Webhook Sekmesi Buton Yapısı
-- =========================================================================
-- 📡 RISEI-HUB OFFICIAL PACKET SPY MOTOR (BACKEND)
-- =========================================================================

-- Main.lua'dan gelen dinamik siber hattı çekiyoruz
local WebhookURL = _G.DiscordWebhook
local HttpService = game:GetService("HttpService")

-- Güvenlik Protokolü: Link yoksa sistemi çalıştırma, çökmesin
if not WebhookURL or WebhookURL == "" then
    print("🚨 Risei-Spy: Webhook linki bulunamadı, sistem başlatılamadı!")
    return
end

-- Discord'a formatlı paket verisi fırlatan sinsi fonksiyon
local function sendToDiscord(remoteType, remoteName, args)
    -- Argümanları (paket içeriğini) okunabilir metne çeviriyoruz
    local argsString = ""
    for i, v in pairs(args) do
        argsString = argsString .. string.format("[%d] = %s (%s)\n", i, tostring(v), type(v))
    end
    if argsString == "" then argsString = "Argüman Yok (Boş Paket)" end

    -- Discord Gömülü Mesaj (Embed) Tasarımı
    local data = {
        ["embeds"] = {{
            ["title"] = "📡 **Risei-Spy: Paket Yakalandı!**",
            ["color"] = 65280, -- Siber Yeşil Renk
            ["fields"] = {
                {["name"] = "🔒 Paket Tipi", ["value"] = remoteType, ["inline"] = true},
                {["name"] = "🏷️ Remote Adı", ["value"] = "`" .. remoteName .. "`", ["inline"] = true},
                {["name"] = "📦 Paket İçeriği (Arguments)", ["value"] = "```lua\n" .. argsString .. "\n```"}
            },
            ["footer"] = {["text"] = "🪐 Risei-HUB Lab | " .. os.date("%X")}
        }}
    }

    -- Paketi Discord'a postalıyoruz
    local success, err = pcall(function()
        local headers = {["Content-Type"] = "application/json"}
        local request = http_request or request or (syn and syn.request) or (http and http.request)
        if request then
            request({Url = WebhookURL, Method = "POST", Headers = headers, Body = HttpService:JSONEncode(data)})
        else
            game:HttpGet(WebhookURL .. "?content=Request_Metodu_Bulunamadi")
        end
    end)
end

-- =========================================================================
-- KANCA (HOOK) MOTORU ACTIVATION
-- =========================================================================
local mt = getrawmetatable(game)
local oldInstance = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    -- Eğer kullanıcı menüden toggle'ı kapattıysa dinlemeyi anında pas geç
    if not _G.SpyAktif then 
        return oldInstance(self, ...) 
    end
    
    local method = getnamecallmethod()
    local args = {...}
    local remoteName = tostring(self)
    
    -- Blox Fruits paket filtreleme lojiği (Sadece CommF_ ve CommE paketlerini avla)
    if method == "FireServer" or method == "InvokeServer" then
        if string.find(remoteName, "CommF_") or string.find(remoteName, "CommE") then
            -- Yakalanan paketi Discord'a gönderilmek üzere sıraya al
            task.spawn(function()
                sendToDiscord(method, remoteName, args)
            end)
        end
    end
    
    return oldInstance(self, ...)
end)

setreadonly(mt, true)
print("📡 Risei-Spy: Kanca başarıyla atıldı, paket hattı aktif!")
