-- =========================================================================
-- 🪐 RISEI-HUB | ULTIMATE MAIN MOTOR (STABLE RAYFIELD)
-- =========================================================================

-- Rayfield linkini en stabil ve patlamayan alternatif hatla güncelledik:
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftware-Design/Rayfield/main/source.lua'))()

local Window = Rayfield:CreateWindow({
   Name = "🪐 Risei-HUB | Ultimate Edition",
   LoadingTitle = "Risei-HUB Yükleniyor...",
   LoadingSubtitle = "by Risei",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false
})

-- =========================================================================
-- SEKMELER (TABS)
-- =========================================================================
local MainTab = Window:CreateTab("🏠 Ana Sayfa", 4483362458)
local LogTab = Window:CreateTab("📡 Paket Casusu", 4483345909)

-- =========================================================================
-- İÇERİKLER & PROTOKOLLER
-- =========================================================================
MainTab:CreateParagraph({
   Title = "Selamlar Reis!", 
   Content = "Risei-HUB siber laboratuvarına hoş geldin. Buradan oyun içi fonksiyonları dızlayıp kendi optimizasyon testlerini yapabilirsin."
})

LogTab:CreateParagraph({
   Title = "📡 Esnek Paket Casusu Sistemi", 
   Content = "Aşağıdaki butonu açtığında, o eski sinir bozucu arayüz yerine senin için özel tasarladığımız minimalist Risei-Spy paneli ekrana gelecektir."
})

LogTab:CreateToggle({
   Name = "Risei-Spy Arayüzünü Patlat",
   CurrentValue = false,
   Flag = "RiseiSpyToggle",
   Callback = function(Value)
      if Value then
         Rayfield:Notify({
            Title = "📡 SPY AKTİFLEŞTİRİLDİ", 
            Content = "Minimalist casus motoru GitHub'dan başarıyla çekiliyor...", 
            Duration = 3
         })
         loadstring(game:HttpGet("https://raw.githubusercontent.com/Risei-HUB/Risei-HUB/main/Log.lua"))()
      end
   end,
})
