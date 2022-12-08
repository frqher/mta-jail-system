db = dbConnect("sqlite", "data.db")

function hapiseAt(oyuncu)
    if oyuncu then
        setElementInterior(oyuncu, mekan_jail.interior)
        setElementDimension(oyuncu, mekan_jail.dimension)
        setElementPosition(oyuncu, unpack(mekan_jail.konum))

        triggerClientEvent(oyuncu, "hapis:sure:baslat", oyuncu)
    end
end

addEventHandler("onPlayerSpawn", root, function()
    hapis_sure = getElementData(source, "hapis:sure") or false
    if hapis_sure then
        setElementInterior(source, mekan_jail.interior)
        setElementDimension(source, mekan_jail.dimension)
        setElementPosition(source, unpack(mekan_jail.konum))
    end
end)

function hapisCikar(oyuncu, yetkili, sebep)
    if oyuncu then
        local serial = getPlayerSerial(oyuncu)
        local hesap = getPlayerAccount(oyuncu)
        if not isGuestAccount(hesap) then
            setAccountData(hesap, "hapis:sure", false) 
            setAccountData(hesap, "hapis:tipi", false)
        end
        setElementData(oyuncu, "hapis:sure", false)
        setElementData(oyuncu, "hapis:tipi", false)

        setElementInterior(oyuncu, mekan_unjail.interior)
        setElementDimension(oyuncu, mekan_unjail.dimension)
        setElementPosition(oyuncu, unpack(mekan_unjail.konum))

        triggerClientEvent(oyuncu, "hapis:sure:kapat", oyuncu)
        outputChatBox("Hapis süreniz doldu, lütfen bu topluluğa daha iyi birisi olmaya çalışın.", oyuncu, 0, 255, 0, true)

        dbExec(db, "DELETE FROM jails WHERE serial=?", serial)

        if yetkili ~= nil then
            local isim = string.gsub(getPlayerName(oyuncu), "#%x%x%x%x%x%x", "")
            local isim_yetkili = string.gsub(getPlayerName(yetkili), "#%x%x%x%x%x%x", "")
            outputChatBox(isim.." adlı oyuncu "..isim_yetkili.." adlı yetkili tarafından hapisten çıkarıldı. Sebep("..sebep..")", root, 255, 0, 0, true)
        end
    end
end

function hapiseVer(hapis_durum, hapis_tipi, oyuncu, sure, sebep, yetkili)
    if hapis_tipi == "Online" then
        if hapis_durum == "Online" then
            if oyuncu and sure then
                local serial = getPlayerSerial(oyuncu)

                dbExec(db, "INSERT INTO jails (serial, hapis_sure, hapis_tipi) VALUES(?,?,?)", serial, sure, hapis_tipi)

                setElementData(oyuncu, "hapis:sure", getRealTime().timestamp + sure)
                setElementData(oyuncu, "hapis:tipi", hapis_tipi)

                hapiseAt(oyuncu)
                local sure = getRealTime().timestamp + sure
                local sure = sureKontrol(sure-getRealTime().timestamp)
                local isim = string.gsub(getPlayerName(oyuncu), "#%x%x%x%x%x%x", "")
                local isim_yetkili = string.gsub(getPlayerName(yetkili), "#%x%x%x%x%x%x", "")
                outputChatBox(isim.." adlı oyuncu "..isim_yetkili.." adlı yetkili tarafından hapise atıldı. Sebep("..sebep..") Süre("..sure..")", root, 255, 0, 0, true)
            end
        elseif hapis_durum == "Offline" then
            local hesap = getAccount(oyuncu)
            if hesap then
                local hesap_isim = getAccountName(hesap) or "Bilinmiyor"
                setAccountData(hesap, "hapis:sure", sure) 
                setAccountData(hesap, "hapis:tipi", hapis_tipi)

                local sure = getRealTime().timestamp + sure
                local sure = sureKontrol(sure-getRealTime().timestamp)
                outputChatBox(hesap_isim.." adlı hesabı başarıyla hapise attınız ! Sebep("..sebep..") Süre("..sure..") Hapis tipi("..hapis_tipi..")", yetkili, 255, 0, 0, true)
            else
                outputChatBox("Böyle bir hesap sunucuya kayıtlı değil !", yetkili, 255, 0, 0, true)
            end
        end


    elseif hapis_tipi == "Offline" then
       if hapis_durum == "Online" then
            if oyuncu and sure then
                local sure = getRealTime().timestamp + sure
                local serial = getPlayerSerial(oyuncu)

                dbExec(db, "INSERT INTO jails (serial, hapis_sure, hapis_tipi) VALUES(?,?,?)", serial, sure, hapis_tipi)

                setElementData(oyuncu, "hapis:sure", sure)
                setElementData(oyuncu, "hapis:tipi", hapis_tipi)

                hapiseAt(oyuncu)
                
                local sure = sureKontrol(sure-getRealTime().timestamp)
                local isim = string.gsub(getPlayerName(oyuncu), "#%x%x%x%x%x%x", "")
                local isim_yetkili = string.gsub(getPlayerName(yetkili), "#%x%x%x%x%x%x", "")
                outputChatBox(isim.." adlı oyuncu "..isim_yetkili.." adlı yetkili tarafından hapise atıldı. Sebep("..sebep..") Süre("..sure..")", root, 255, 0, 0, true)
            end
        elseif hapis_durum == "Offline" then
            local hesap = getAccount(oyuncu)
            if hesap then
                local sure = getRealTime().timestamp + sure
                local hesap_isim = getAccountName(hesap) or "Bilinmiyor"
                setAccountData(hesap, "hapis:sure", sure) 
                setAccountData(hesap, "hapis:tipi", hapis_tipi)
                
                local sure = sureKontrol(sure-getRealTime().timestamp)
                outputChatBox(hesap_isim.." adlı hesabı başarıyla hapise attınız ! Sebep("..sebep..") Süre("..sure..") Hapis tipi("..hapis_tipi..")", yetkili, 255, 0, 0, true)
            else
                outputChatBox("Böyle bir hesap sunucuya kayıtlı değil !", yetkili, 255, 0, 0, true)
            end
        end
    end
end

function hapisKontrol(oyuncu)
    if oyuncu then
        local serial = getPlayerSerial(oyuncu)
        dbQuery(function(queryHandle) 
            local results = dbPoll(queryHandle, 0)
            local results = results[1]
            if results ~= nil then
                if results["hapis_tipi"] == "Online" then
                    setElementData(oyuncu, "hapis:sure", getRealTime().timestamp + results["hapis_sure"])
                    setElementData(oyuncu, "hapis:tipi", results["hapis_tipi"])
                elseif results["hapis_tipi"] == "Offline" then
                    setElementData(oyuncu, "hapis:sure", results["hapis_sure"])
                    setElementData(oyuncu, "hapis:tipi", results["hapis_tipi"])
                end

                hapiseAt(oyuncu)
            else
                local hesap = getPlayerAccount(oyuncu)
                local hapis_sure = getAccountData(hesap, "hapis:sure") or false
                local hapis_tipi = getAccountData(hesap, "hapis:tipi") or false
                if hapis_sure then
                    if hapis_tipi == "Online" then
                        local hapis_sure = getRealTime().timestamp + hapis_sure
                        setElementData(oyuncu, "hapis:sure", hapis_sure)
                        setElementData(oyuncu, "hapis:tipi", hapis_tipi)
                        dbExec(db, "INSERT INTO jails (serial, hapis_sure, hapis_tipi) VALUES(?,?,?)", serial, hapis_sure, hapis_tipi)
                    elseif hapis_tipi == "Offline" then
                        setElementData(oyuncu, "hapis:sure", hapis_sure)
                        setElementData(oyuncu, "hapis:tipi", hapis_tipi)
                        dbExec(db, "INSERT INTO jails (serial, hapis_sure, hapis_tipi) VALUES(?,?,?)", serial, hapis_sure, hapis_tipi)
                    end

                    setAccountData(hesap, "hapis:sure", false) 
                    setAccountData(hesap, "hapis:tipi", false)

                    hapiseAt(oyuncu)
                end
            end
        end, db, "SELECT * FROM jails WHERE serial=?", serial)
    end
end

function hapisKaydet(oyuncu)
    if oyuncu then
        local serial = getPlayerSerial(oyuncu)
        local hesap = getPlayerAccount(oyuncu)
        local hapis_sure = getElementData(oyuncu, "hapis:sure") or false
        local hapis_tipi = getElementData(oyuncu, "hapis:tipi") or false
        if hapis_sure then
            if hapis_tipi == "Online" then
                local hapis_sure = hapis_sure-getRealTime().timestamp
                dbQuery(function(queryHandle) 
                    local results = dbPoll(queryHandle, 0)
                    local results = results[1]
                    if results ~= nil then
                        dbExec(db, "UPDATE jails SET hapis_sure=?, hapis_tipi=? WHERE serial=?", hapis_sure, hapis_tipi, serial)
                        print(1)
                    else
                        dbExec(db, "INSERT INTO jails (serial, hapis_sure, hapis_tipi) VALUES(?,?,?)", serial, hapis_sure, hapis_tipi)
                    end
                end, db, "SELECT * FROM jails WHERE serial=?", serial)
            elseif hapis_tipi == "Offline" then
                dbQuery(function(queryHandle) 
                    local results = dbPoll(queryHandle, 0)
                    local results = results[1]
                    if results ~= nil then
                        dbExec(db, "UPDATE jails SET hapis_sure=?, hapis_tipi=? WHERE serial=?", hapis_sure, hapis_tipi, serial)
                    else
                        dbExec(db, "INSERT INTO jails (serial, hapis_sure, hapis_tipi) VALUES(?,?,?)", serial, hapis_sure, hapis_tipi)
                    end
                end, db, "SELECT * FROM jails WHERE serial=?", serial)
            end
        end
    end
end

function sureKontrol(sure)
	local sure = tonumber(sure)
	if sure <= 0 then
		return false
	else
		local gun = math.floor(sure/86400)
		local saat = string.format("%01.f", math.floor(sure/3600 - (gun*24)))
		local dakika = string.format("%01.f", math.floor(sure/60 - (gun*24 + saat)*60))
		local saniye = string.format("%01.f", math.floor(sure %60 ))
        if tonumber(gun) >= 1 then
            return gun.." Gün "..saat.." Saat "..dakika.." Dakika "..saniye.." Saniye"
        elseif tonumber(saat) >= 1 then
            return saat.." Saat "..dakika.." Dakika "..saniye.." Saniye"
        elseif tonumber(dakika) >= 1 then
            return dakika.." Dakika "..saniye.." Saniye"
        elseif tonumber(saniye) >= 0 then
            return saniye.." Saniye"
        end
	end
end



function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

setTimer(function()
    for i, oyuncu in pairs(getElementsByType("player")) do
        local hapis_sure = getElementData(oyuncu, "hapis:sure") or false
        if hapis_sure then
            hapiseAt(oyuncu)
        end
    end
end, 1000, 1)