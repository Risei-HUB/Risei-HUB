-- RISEI-HUB Webhook Sekmesi Buton Yapısı
LogSekmesi:CreateToggle({
    Name = "📡 Paket Casusunu Aktif Et (Discord Log)",
    Callback = function(Value)
        _G.SpyAktif = Value
        
        if _G.SpyAktif then
            -- Kanca (Hook) Motorunu buraya ateşliyoruz
            local mt = getrawmetatable(game)
            local oldInstance = mt.__namecall
            setreadonly(mt, false)
            
            mt.__namecall = newcclosure(function(self, ...)
                -- Eğer kullanıcı menüden toggle'ı kapattıysa dinlemeyi pas geç
                if not _G.SpyAktif then 
                    return oldInstance(self, ...) 
                end
                
                local method = getnamecallmethod()
                local args = {...}
                local remoteName = tostring(self)
                
                -- Buraya o sana verdiğim 'CommF_' ve 'CommE' filtreleme / sendToDiscord lojiği gelecek...
                -- (Yukarıdaki fonksiyonları bu bloğun içine veya üstüne yerleştirebilirsin)
                
                return oldInstance(self, ...)
            end)
            setreadonly(mt, true)
        else
            print("📡 Risei-Spy: Paket dinleme durduruldu.")
        end
    end
})
