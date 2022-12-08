local screenx,screeny = guiGetScreenSize()
local g, u = 410, 360 
local x, y = (screenx/2-g/2), (screeny/2-u/2)

local lp = getLocalPlayer()
local font = guiCreateFont("lib/font.ttf", 12)

local panel = guiCreateWindow(x, y, g, u, "Jail System", false)
guiSetVisible(panel, false)

local label_ara = guiCreateLabel(10, 40, 180, 32, "Oyuncu Ara", false, panel) 
guiSetFont(label_ara, font)
local ara = guiCreateEdit(10, 70, 200, 30, "", false, panel)

local grid_list = guiCreateGridList(10, 110, 200, 200, false, panel)
local column_oyuncu = guiGridListAddColumn(grid_list, "Oyuncu", 0.5)
local column_durum = guiGridListAddColumn(grid_list, "Durum", 0.4)

local label_hesap = guiCreateLabel(220, 40, 180, 32, "Hesap", false, panel) 
guiSetFont(label_hesap, font)
local hesap = guiCreateEdit(220, 70, 180, 30, "", false, panel)

local label_reason = guiCreateLabel(220, 110, 180, 32, "Sebep", false, panel)
guiSetFont(label_reason, font)
local reason = guiCreateMemo(220, 140, 180, 60, "", false, panel)

local label_sure = guiCreateLabel(220, 210, 180, 32, "Süre", false, panel) 
guiSetFont(label_sure, font)
local sure = guiCreateEdit(220, 240, 180, 30, "", false, panel)

local radio = {
    ["radio_dakika"] = guiCreateRadioButton(220, 280, 55, 20, "Dakika", false, panel),
    ["radio_saat"] = guiCreateRadioButton(295, 280, 55, 20, "Saat", false, panel),
    ["radio_gun"] = guiCreateRadioButton(360, 280, 55, 20, "Gün", false, panel),
}

guiRadioButtonSetSelected(radio["radio_dakika"], true)



local buton_hapis_online = guiCreateButton(10, 320, 110, 30, "Hapise at (Online)", false, panel)
local buton_hapis_offline = guiCreateButton(130, 320, 110, 30, "Hapise at (Offline)", false, panel)
local buton_cikar = guiCreateButton(250, 320, 80, 30, "Çıkar", false, panel)
local buton_kapat = guiCreateButton(340, 320, 60, 30, "Kapat", false, panel)



addEvent("jail:panel:ac", true)
addEventHandler("jail:panel:ac", root, function()
    guiGridListClear(grid_list)
    for i, oyuncu in pairs(getElementsByType("player")) do
        local row = guiGridListAddRow(grid_list)
        local isim = string.gsub(getPlayerName(oyuncu), "#%x%x%x%x%x%x", "")
        local hapis_durum = getElementData(oyuncu, "hapis:sure") or false
        if hapis_durum then
            hapis_durum = "Hapiste"
        else
            hapis_durum = "Hapiste Değil"
        end
        guiGridListSetItemText(grid_list, row, 1, tostring(isim), false, false)
        guiGridListSetItemText(grid_list, row, 2, tostring(hapis_durum), false, false)
    
        guiGridListSetItemData(grid_list, row, 1, oyuncu)
    end

    guiSetVisible(panel, not guiGetVisible(panel))
    showCursor(guiGetVisible(panel))
end)


-- Event

addEventHandler("onClientGUIClick", resourceRoot, function()
    if source == buton_hapis_online then
        local oyuncu = guiGridListGetSelectedItem(grid_list)
		if oyuncu ~= -1 then 
            local oyuncu = guiGridListGetItemData(grid_list, oyuncu, column_oyuncu)
            local oyuncu_hapistemi = getElementData(oyuncu, "hapis:sure") or false
            local oyuncu_hesap_durum = getElementData(oyuncu, "girisyapti") or false
            if oyuncu_hesap_durum == false then
                outputChatBox("Hapise atmaya çalıştığınzı oyuncu hesabına giriş yapmadı.", 255, 0, 0, true)
                return
            end
            if oyuncu_hapistemi then
                outputChatBox("Hapise atmaya çalıştığınzı oyuncu zaten hapiste, önce hapisten çıkarın.", 255, 0, 0, true)
                return
            end
            local sebep = guiGetText(reason)
            local sure = tonumber(guiGetText(sure))
            if sure >= 1 then
                local sure_radio = guiGetText(getSelectedRadio())
                if sure then
                    local sure = timeCalculator(sure_radio, sure)
                    triggerServerEvent("hapis:at", lp, oyuncu, sebep, sure, "Online", "Online")
                end
            else
                outputChatBox("Hapis süresi minumum 1 ola bilir.", 255, 0, 0)
            end

        else
            local oyuncu = guiGetText(hesap)
            local sebep = guiGetText(reason)
            local sure = tonumber(guiGetText(sure))
            if sure >= 1 then
                local sure_radio = guiGetText(getSelectedRadio())
                if sure then
                    local sure = timeCalculator(sure_radio, sure)
                    triggerServerEvent("hapis:at", lp, oyuncu, sebep, sure, "Online", "Offline")
                end
            else
                outputChatBox("Hapis süresi minumum 1 ola bilir.", 255, 0, 0)
            end
        end

    elseif source == buton_hapis_offline then
        local oyuncu = guiGridListGetSelectedItem(grid_list)
		if oyuncu ~= -1 then 
            local oyuncu = guiGridListGetItemData(grid_list, oyuncu, column_oyuncu)
            local oyuncu_hapistemi = getElementData(oyuncu, "hapis:sure") or false
            local oyuncu_hesap_durum = getElementData(oyuncu, "girisyapti") or false
            if oyuncu_hesap_durum == false then
                outputChatBox("Hapise atmaya çalıştığınzı oyuncu hesabına giriş yapmadı.", 255, 0, 0, true)
                return
            end
            if oyuncu_hapistemi then
                outputChatBox("Hapise atmaya çalıştığınzı oyuncu zaten hapiste, önce hapisten çıkarın.", 255, 0, 0, true)
                return
            end
            local sebep = guiGetText(reason)
            local sure = tonumber(guiGetText(sure))
            if sure >= 1 then
                local sure_radio = guiGetText(getSelectedRadio())
                if sure then
                    local sure = timeCalculator(sure_radio, sure)
                    triggerServerEvent("hapis:at", lp, oyuncu, sebep, sure, "Offline", "Online")
                end
            else
                outputChatBox("Hapis süresi minumum 1 ola bilir.", 255, 0, 0)
            end

        else
            local oyuncu = guiGetText(hesap)
            local sebep = guiGetText(reason)
            local sure = tonumber(guiGetText(sure))
            if sure >= 1 then
                local sure_radio = guiGetText(getSelectedRadio())
                if sure then
                    local sure = timeCalculator(sure_radio, sure)
                    triggerServerEvent("hapis:at", lp, oyuncu, sebep, sure, "Offline", "Offline")
                end
            else
                outputChatBox("Hapis süresi minumum 1 ola bilir.", 255, 0, 0)
            end
        end
        
    elseif source == buton_cikar then
        local oyuncu = guiGridListGetSelectedItem(grid_list)
		if oyuncu ~= -1 then 
            local oyuncu = guiGridListGetItemData(grid_list, oyuncu, column_oyuncu)
            local oyuncu_hapistemi = getElementData(oyuncu, "hapis:sure") or false
            if oyuncu_hapistemi == false then
                outputChatBox("Hapisten çıkarmaya çalıştığınız oyuncu hapiste değil.", 255, 0, 0, true)
                return
            end
            local sebep = guiGetText(reason)
            triggerServerEvent("hapis:cikar", lp, oyuncu, sebep)
        end

    elseif source == buton_kapat then
        guiSetVisible(panel, false)
        showCursor(false)
    end
end)

-- More Functions

function getSelectedRadio()
    local durum = false
    for i, v in pairs(radio) do
        if guiRadioButtonGetSelected(v) then
            durum = v
            break
        end
    end
    return durum
end

function timeCalculator(durum, sure)
    if durum == "Dakika" then
        local toplam = sure * 60
        return toplam
    elseif durum == "Saat" then
        local toplam = sure * 3600
        return toplam
    elseif durum == "Gün" then
        local toplam = sure * 86400
        return toplam
    end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
	    local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end
	return false
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

function formatNumber(amount, spacer)
	if not spacer then
		spacer = ","
	end
	
	amount = math.floor(amount)
	
	local left, num, right = string.match(tostring(amount), "^([^%d]*%d)(%d*)(.-)$")
	return left .. (num:reverse():gsub("(%d%d%d)", "%1" .. spacer):reverse()) .. right
end

-- More event

addEventHandler("onClientGUIChanged", ara, function()
    guiGridListClear(grid_list)
    local name = guiGetText(source)
    for index, players in pairs(getElementsByType("player")) do
		local newName = getPlayerName(players)
		if (string.find(newName:lower(), name:lower(), 1, true)) then
			local row = guiGridListAddRow(grid_list)
			local isim = string.gsub(getPlayerName(players), "#%x%x%x%x%x%x", "")
            local hapis_durum = getElementData(players, "hapis") or "Hapiste Değil"
            guiGridListSetItemText(grid_list, row, 1, tostring(isim), false, false)
            guiGridListSetItemText(grid_list, row, 2, tostring(hapis_durum), false, false)

            guiGridListSetItemData(grid_list, row, 1, players)
		end
    end
end)

local hapis_sure = 0
local hapis_count = 0
local hapis_durum = "Bilinmiyor"
local timer = nil
local hapis_bind = false
local kefalet = 0


function hapisSure()
    dxDrawText("Hapis Süresi\n"..hapis_count.."\nHapis Durum: "..hapis_durum.."\nKefalet parası: "..formatNumber(kefalet, ".").."$ /kefalet", screenx-screenx+10, screeny-600, 300, 300, tocolor ( 255, 255, 255, 255 ), 2, 2, "default-bold")
end


addEvent("hapis:sure:baslat", true)
addEventHandler("hapis:sure:baslat", root, function()
    if isTimer(timer) then killTimer(timer) end

    hapis_sure = getElementData(lp, "hapis:sure")
    hapis_durum = getElementData(lp, "hapis:tipi")
    if hapis_durum == "Online" then
        hapis_durum = "Süre sadece oyunda olduğunuzda azalır"
    else
        hapis_durum = "Süre oyundayken veya oyunda değilken azalır"
    end
    if not isEventHandlerAdded('onClientRender', root, hapisSure) then
        addEventHandler("onClientRender", root, hapisSure)
    end

    hapis_bind = true

    timer = setTimer(function()
        hapis_count = sureKontrol(hapis_sure-getRealTime().timestamp)
        if hapis_count == false then 
            if isEventHandlerAdded('onClientRender', root, hapisSure) then
                removeEventHandler("onClientRender", root, hapisSure)
            end
            
            hapis_bind = false
            triggerServerEvent("hapis:cikar", lp)

            killTimer(timer)
        end
        
        local hapis_sure = hapis_sure - 1
        setElementData(lp, "hapis:sure", hapis_sure)

        local kefalet_c = hapis_sure-getRealTime().timestamp
        local kefalet_c = kefalet_c / 60
        kefalet = math.floor(kefalet_c * kefalet_parasi)
    end, 1000, 0)
end)

addEvent("hapis:sure:kapat", true)
addEventHandler("hapis:sure:kapat", root, function()
    if isTimer(timer) then killTimer(timer) end

    if isEventHandlerAdded('onClientRender', root, hapisSure) then
        removeEventHandler("onClientRender", root, hapisSure)
    end

    hapis_sure = 0
    hapis_count = 0
    hapis_durum = "Bilinmiyor"
    hapis_bind = false
end)

-- More
 
 addEventHandler("onClientKey", root, function(button, press)
    if hapis_bind and butons[button] then 
        cancelEvent()
    end      
 end)
 

--  Command
addEvent("jail:komut:calistir", true)
addEventHandler("jail:komut:calistir", root, function(oyuncu, hapis_tipi, sebep, sure)
    if oyuncu and hapis_tipi and sebep and sure then
        local oyuncu_hapistemi = getElementData(oyuncu, "hapis:sure") or false
        if oyuncu_hapistemi then
            outputChatBox("Hapise atmaya çalıştığınzı oyuncu zaten hapiste, önce hapisten çıkarın.", 255, 0, 0, true)
            return
        end
        local sure = tonumber(sure)
        if sure >= 1 then
            local sure_radio = guiGetText(getSelectedRadio())
            if sure then
                local sure = timeCalculator(sure_radio, sure)
                triggerServerEvent("hapis:at", lp, oyuncu, sebep, sure, hapis_tipi, "Online")
            end
        else
            outputChatBox("Hapis süresi minumum 1 ola bilir.", 255, 0, 0)
        end
    end
end)

addEvent("unjail:komut:calistir", true)
addEventHandler("unjail:komut:calistir", root, function(oyuncu, sebep)
    if oyuncu and sebep then
        local oyuncu_hapistemi = getElementData(oyuncu, "hapis:sure") or false
        if oyuncu_hapistemi == false then
            outputChatBox("Hapisten çıkarmaya çalıştığınız oyuncu hapiste değil.", 255, 0, 0, true)
            return
        end
        triggerServerEvent("hapis:cikar", lp, oyuncu, sebep)
    end
end)

addCommandHandler("kefalet", function()
    local oyuncu_hapistemi = getElementData(lp, "hapis:sure") or false
    if oyuncu_hapistemi then
        if tonumber(kefalet) <= 1 then return end
        triggerServerEvent("hapis:kefalet", lp, kefalet)
    end
end)


addEventHandler("onClientPlayerDamage", root, function()
    local oyuncu_hapistemi = getElementData(lp, "hapis:sure") or false
    if oyuncu_hapistemi then
        cancelEvent()
    end
end)