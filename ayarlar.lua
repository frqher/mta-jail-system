mekan_jail = { --Hapise atıldığında gideceği konum
    konum = {-2422.83472, -608.87958, 132.56250}, --x, y, z
    interior = 0,
    dimension = 0,
}

mekan_unjail = { --Hapisten çıktığında gideceği konum
    konum = {-2402.22925, -595.52716, 132.64844}, --x, y, z
    interior = 0,
    dimension = 0,
}

-- Dakika başına kaç bin kefalet ödeyecek (2 dakika, 10.000$)
kefalet_parasi = 5000 


-- Hangi yetkilerin hapis paneli aça bilecek, sondaki , unutmayın
acl = {
    "Console",
    "Admin",
    "SuperModerator",
    "Moderator", 
    -- "Console",
}

-- Panelin açılma komutu
panel_komut = "jailpanel"


-- Hapisten çıkarmak için komut
-- Örnek /hapiscikar oyuncu sebep

hapicikar_komut = "hapiscikar"

-- Engellenecek tuşlar (bu tuşlara basıldığında çalışmaz)
butons = {   
    ["F1"] = true,
    ["F2"] = true,
    ["F4"] = true,
    ["j"] = true,
    ["p"] = true,
    ["b"] = true,  
 }

--  Bu komut sadece server tarafında kullanılan komutları engeller. Client de olan komutları engellemez, Örnek (fr, freeroam)
 komutlar = {
    ["whois"] = true,
 }