-- =========================================================================
-- 🪐 RISEI-HUB OFFICIAL MAIN MOTOR (RAYFIELD EDITION)
-- =========================================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🪐 Risei-HUB | Ultimate Edition",
   LoadingTitle = "Risei-HUB Yükleniyor...",
   LoadingSubtitle = "by Risei",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false -- Amelelik olmasın diye anahtar sistemini kapattık
})

-- =========================================================================
-- SEKMELER (TABS)
-- =========================================================================
local MainTab = Window:CreateTab("🏠 Ana Sayfa", 4483362458) -- Ev ikonu
local LogTab = Window:CreateTab("📡 Webhook Log", 4483345909) -- Sinyal ikonu

-- =========================================================================
-- ANA SAYFA İÇERİĞİ
-- =========================================================================
MainTab:CreateParagraph({Title = "Selamlar Reis!", Content = "Risei-HUB siber laboratuvarına hoş geldin. Dızladığın paketleri sisteme işlemeye buradan devam edebilirsin."})

-- =========================================================================
-- WEBHOOK LOG SEKME İÇERİĞİ (BİZİM KRAL ÖZELLİK)
-- =========================================================================
LogTab:CreateParagraph({Title = "📡 Paket Casusu Sistemi", Content = "Bu butonu açtığında arka planda görünmez bir kanca (hook) atılır ve akan CommF_ / CommE paketleri direkt Discord sunucuna fırlatılır."})

LogTab:CreateToggle({
   Name = "Casus Protokolünü Aktif Et",
   CurrentValue = false,
   Flag = "WebhookSpyFlag",
   Callback = function(Value)
      _G.SpyAktif = Value
      
      if _G.SpyAktif then
         Rayfield:Notify({
            Title = "📡 SİNSİ PLUG-IN TETİKLENDİ",
            Content = "GitHub'daki Log.lua casus motoru uzaktan başarıyla indirildi ve hafızaya enjekte edildi!",
            Duration = 5,
            Image = 4483345909,
         })
         -- Senin kurduğun depodaki log.lua dosyasını uzaktan zınk diye çağırıyoruz!
         loadstring(game:HttpGet("https://raw.githubusercontent.com/Risei-HUB/Risei-HUB/main/Log.lua"))()
      else
         Rayfield:Notify({
            Title = "🚨 CASUS PASİF",
            Content = "Paket dinleme durduruldu. Sistem temiz.",
            Duration = 3,
            Image = 4483345909,
         })
      end
   end,
})
