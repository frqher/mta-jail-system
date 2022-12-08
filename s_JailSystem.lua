addCommandHandler(panel_komut, function(oyuncu)
    for i, v in pairs(acl) do 
        local hesap = getAccountName(getPlayerAccount(oyuncu))
        if isObjectInACLGroup("user."..hesap, aclGetGroup(v)) then
            triggerClientEvent(oyuncu, "jail:panel:ac", oyuncu)
            break
        end
    end
end)

addCommandHandler(hapicikar_komut, function(player, cmd, oyuncu, sebep)
    if oyuncu and sebep then
        for i, v in pairs(acl) do 
            local hesap = getAccountName(getPlayerAccount(player))
            if isObjectInACLGroup("user."..hesap, aclGetGroup(v)) then
                    local oyuncu = getPlayerFromPartialName(oyuncu) or false
                    if oyuncu then
                        triggerClientEvent(player, "unjail:komut:calistir", player, oyuncu, sebep)
                    else
                        outputChatBox("Oyuncu bulunamadı !", player, 255, 0, 0, true)
                    end
                break
            end
        end
    else
        outputChatBox("/hapiscikar oyuncu sebep", player, 255, 0, 0, true)
    end
end)

addEventHandler("onPlayerLogin", root, function(_, hesap)
    setElementData(source, "girisyapti", true)
    hapisKontrol(source)
end)

addEventHandler("onPlayerLogout", root, function()
    setElementData(source, "girisyapti", false)
end)

addEventHandler("onPlayerQuit", root, function()
    hapisKaydet(source)
end)

addEvent("hapis:at", true)
addEventHandler("hapis:at", root, function(oyuncu, sebep, sure, hapis_tipi, hapis_durum)
    hapiseVer(hapis_durum, hapis_tipi, oyuncu, sure, sebep, source)
end)

addEvent("hapis:kefalet", true)
addEventHandler("hapis:kefalet", root, function(kefalet)
    if getPlayerMoney(source) >= tonumber(kefalet) then
        takePlayerMoney(source, tonumber(kefalet))
        hapisCikar(source)
    else
        local para = kefalet - getPlayerMoney(source)
        outputChatBox("Kefaleti ödemek için yeterli paranız yok, gereken para: #00ff00"..formatNumber(para, ".").."$", source, 255, 0, 0, true)
    end
end)

addEvent("hapis:cikar", true)
addEventHandler("hapis:cikar", root, function(oyuncu, sebep)
    if oyuncu and sebep then
        hapisCikar(oyuncu, source, sebep)
    else
        hapisCikar(source)
    end
end)

function formatNumber(amount, spacer)
	if not spacer then
		spacer = ","
	end
	
	amount = math.floor(amount)
	
	local left, num, right = string.match(tostring(amount), "^([^%d]*%d)(%d*)(.-)$")
	return left .. (num:reverse():gsub("(%d%d%d)", "%1" .. spacer):reverse()) .. right
end

addEventHandler("onPlayerCommand",root, function(command)
	if komutlar[command] then
	    cancelEvent()
	end
end)