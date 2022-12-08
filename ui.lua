local genel     = {}
local panel     = {}
local button    = {}
local liste     = {}
local checkbox  = {}
local radiobut  = {}
local editbox   = {}
local memobox   = {}
local scrollbar = {}
local tarayici  = {}
local keywindow = {}
--fontlar
baslikfont = guiCreateFont("lib/font.ttf",12)
butonfont  = guiCreateFont("lib/font.ttf",10)
editfont   = guiCreateFont("lib/font.ttf",10.5)
listefont  = guiCreateFont("lib/font.ttf",8.9)
--renk
--açık;5fc2c2
--koyu;2e4961
--A13DB8
--tema
sunucutema = {189, 142, 30}--açık
--koyu:140, 106, 24
temarengi  = "1a1a1a"
temahovercolor = "a40163"
logorengi = "bd8e1e"

function elementerenkver(resim,hex)
	guiSetProperty(resim,"ImageColours","tl:FF"..hex.." tr:FF"..hex.." bl:FF"..hex.." br:FF"..hex)
end
--window
function guiCreateWindow(x,y,w,h,yazi,relative,parent,kapatbool)
    panelsayi = #panel + 1
    if not panel[panelsayi] then panel[panelsayi] = {} end
    p = panel[panelsayi]
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,w,h = x*px,y*pu,w*px,h*pu
		relative = false
	end
    p.movedurum = {}
    p.arkataraf = guiCreateStaticImage(x,y,w,h,"lib/beyaz.dds",false,parent)
    elementerenkver(p.arkataraf,"1c1c1c")
	-- guiSetAlpha(p.arkataraf,0.8)
	
	-- local ortaust = guiCreateStaticImage(1, 0, w - 2, 1,"lib/beyaz.dds",false,p.arkataraf)
	-- elementerenkver(ortaust,"e600ff")
	-- local ortaalt = guiCreateStaticImage(1, h-1, w - 2, 1,"lib/beyaz.dds",false,p.arkataraf)
	-- elementerenkver(ortaalt,"e600ff")
	-- local sol = guiCreateStaticImage(0, 1, 1, h-2,"lib/beyaz.dds",false,p.arkataraf)
	-- elementerenkver(sol,"e600ff")
	-- local sag = guiCreateStaticImage(w-1, 1, 1, h-2,"lib/beyaz.dds",false,p.arkataraf)	
	-- elementerenkver(sag,"e600ff")	
	
    p.baslik = guiCreateStaticImage(0,0,w,24,"lib/beyaz.dds",false,p.arkataraf)
    elementerenkver(p.baslik,"141414")
	-- local ortaust = guiCreateStaticImage(1, 0, w - 2, 1,"lib/beyaz.dds",false,p.baslik)
	-- elementerenkver(ortaust,"e600ff")
	local ortaalt = guiCreateStaticImage(0, 22, w, 5,"lib/beyaz.dds",false,p.baslik)
	elementerenkver(ortaalt,"a40163")
	-- local sol = guiCreateStaticImage(0, 1, 1, h-2,"lib/beyaz.dds",false,p.baslik)
	-- elementerenkver(sol,"e600ff")
	-- local sag = guiCreateStaticImage(w-1, 1, 1, h-2,"lib/beyaz.dds",false,p.baslik)	
	-- elementerenkver(sag,"e600ff")	
	-- p.logo = guiCreateStaticImage(1,1,28,28,"lib/logo.dds",false,p.baslik)
	-- elementerenkver(p.logo,logorengi)
    p.label = guiCreateLabel((w/2)-((string.len(yazi)*7)/2),0.5,(string.len(yazi)*10),20, yazi, false, p.baslik)
	guiSetFont(p.label, baslikfont or "default-bold-small")
    -- guiSetAlpha(p.label,0.8)
    if kapatbool == true then 
        p.kapat = guiCreateStaticImage(w-25,5,20,20,"lib/kapaticon.dds",relative,p.baslik)
        elementerenkver(p.kapat,"ffffff")
      	-- guiSetAlpha(p.kapat,0.7)
    end
    return p.arkataraf
end
--buton
function guiCreateButton(x,y,w,h,yazi,relative,parent)
    buttonsayi = #button + 1
    if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,w,h = x*px,y*pu,w*px,h*pu
		relative = false
	end
    if not button[buttonsayi] then button[buttonsayi] = {} end
    b = button[buttonsayi]
    button[buttonsayi].hoverenk = temahovercolor
    b.arkataraf = guiCreateStaticImage(x,y,w,h,"lib/buton.dds",relative,parent)
    elementerenkver(b.arkataraf,temarengi)
	local ortaust = guiCreateStaticImage(1, 0, w - 2, 1,"lib/beyaz.dds",false,b.arkataraf)
	elementerenkver(ortaust,"a40163")
	local ortaalt = guiCreateStaticImage(1, h-1, w - 2, 1,"lib/beyaz.dds",false,b.arkataraf)
	elementerenkver(ortaalt,"a40163")
	local sol = guiCreateStaticImage(0, 1, 1, h-2,"lib/beyaz.dds",false,b.arkataraf)
	elementerenkver(sol,"a40163")
	local sag = guiCreateStaticImage(w-1, 1, 1, h-2,"lib/beyaz.dds",false,b.arkataraf)	
	elementerenkver(sag,"a40163")	
    b.label = guiCreateLabel(0,-2,w,h,yazi,relative,b.arkataraf)
	guiLabelSetHorizontalAlign(b.label, "center")
	guiLabelSetVerticalAlign(b.label, "center")
	guiSetFont(b.label, butonfont)
    return b.label
end
--keywindow
function guiCreateKeyWindow(x,y,w,h,yazi,yazi2,relative,parent,a)
    keywindowsayi = #keywindow + 1
    if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,w,h = x*px,y*pu,w*px,h*pu
		relative = false
	end
    if not keywindow[keywindowsayi] then keywindow[keywindowsayi] = {} end
    key = keywindow[keywindowsayi]
    key.arkataraf = guiCreateStaticImage(x,y,w,h,"lib/beyaz.dds",relative,parent)
    elementerenkver(key.arkataraf,"5453F8A")
    key.label = guiCreateLabel(0,-2,w,h,yazi,relative,key.arkataraf)
	guiLabelSetHorizontalAlign(key.label, "center")
	guiLabelSetVerticalAlign(key.label, "center")
	guiSetFont(key.label, butonfont)

	key.label2 = guiCreateLabel(x+(a or 30),y+1,350,20,yazi2,relative,parent)
	--guiLabelSetHorizontalAlign(key.label2, "center")
	guiLabelSetVerticalAlign(key.label2, "center")
	guiSetFont(key.label2, butonfont)
	
    return key.label
end
--keywindow

--girdlist
--girdlist
_guiCreateGridList = guiCreateGridList
function guiCreateGridList(x,y,g,u,relative,parent,listekenarrenk,a,ua,au)
	listesayi =  #liste + 1
	if not liste[listesayi] then liste[listesayi] = {} end
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
		relative = false
	end
	local a = a or 30.5
	liste[listesayi].resim = guiCreateLabel(x,y,g,u, "", relative, parent)
	liste[listesayi].listee = _guiCreateGridList(-5,-8,g+(ua or 12), u+(au or 30),false, liste[listesayi].resim)
	guiGridListSetSortingEnabled (liste[listesayi].listee , false )
	guiSetFont(liste[listesayi].listee,listefont)
	liste[listesayi].kenarlar = {
		ortaust = guiCreateStaticImage(1, 0, g - 2, 1,"lib/beyaz.dds",false,liste[listesayi].resim),
		ortaalt = guiCreateStaticImage(1, u-1, g - 2, 1,"lib/beyaz.dds",false,liste[listesayi].resim),
		sol = guiCreateStaticImage(0, 1, 1, u-2,"lib/beyaz.dds",false,liste[listesayi].resim),
		sag = guiCreateStaticImage(g-1, 1, 1, u-2,"lib/beyaz.dds",false,liste[listesayi].resim)		
	}
	for i,v in pairs(liste[listesayi].kenarlar) do
		elementerenkver(v,listekenarrenk or "a40163")
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v,0.5)
	end	
	genel[liste[listesayi].listee] = liste[listesayi].kenarlar
	return liste[listesayi].listee
end

--edit
_guiCreateEdit = guiCreateEdit
function guiCreateEdit(x,y,g,u,yazi,relative,parent)
	editsayi = #button + 1
    if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
		relative = false
	end
    if not editbox[editsayi] then editbox[editsayi] = {} end
    e = editbox[editsayi]
	e.arkataraf = guiCreateLabel(x,y,g,u, "", relative, parent)
	e.editbox = _guiCreateEdit(-5.4,-5,g+15, u+8,yazi,false, e.arkataraf)
	guiSetProperty(e.editbox, "ActiveSelectionColour", "E3262338")
	guiSetAlpha(e.editbox,0.7)
	guiSetFont(e.editbox,editfont)
	
	e.kenarlar = {
		ortaust = guiCreateStaticImage(0,0,g,1,"lib/beyaz.dds",false,e.arkataraf),
		ortaalt = guiCreateStaticImage(0,u-1,g,1,"lib/beyaz.dds",false,e.arkataraf),
		sol = guiCreateStaticImage(0,0,1,u,"lib/beyaz.dds",false,e.arkataraf),
		sag = guiCreateStaticImage(g-1,0,1,u,"lib/beyaz.dds",false,e.arkataraf)		
	}
	for i,v in pairs(e.kenarlar) do
		elementerenkver(v,"000000")
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v,1)
	end	
	return e.editbox
end
--memo
_guiCreateMemo = guiCreateMemo
function guiCreateMemo(x,y,g,u,yazi,relative,parent)
	memosayi = #memobox + 1
    if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
		relative = false
	end
    if not memobox[memosayi] then memobox[memosayi] = {} end
    m = memobox[memosayi]
	m.arkataraf = guiCreateLabel(x,y,g,u, "", relative, parent)
	m.memogui = _guiCreateMemo(-5.4,-5,g+30, u+8,yazi,false, m.arkataraf)
	guiSetProperty(m.memogui, "ActiveSelectionColour", "E30089A5")
	guiSetAlpha(m.memogui,0.7)
	guiSetFont(m.memogui,editfont)
	m.kenarlar = {
		ortaust = guiCreateStaticImage(0,0,g,1,"lib/beyaz.dds",false,m.arkataraf),
		ortaalt = guiCreateStaticImage(0,u-1,g,1,"lib/beyaz.dds",false,m.arkataraf),
		sol = guiCreateStaticImage(0,0,1,u,"lib/beyaz.dds",false,m.arkataraf),
		sag = guiCreateStaticImage(g-1,0,1,u,"lib/beyaz.dds",false,m.arkataraf)		
	}
	for i,v in pairs(m.kenarlar) do
		elementerenkver(v,"000000")
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v,1)
	end	
	return m.memogui
end

--checkbox
function guiCreateCheckBox(x,y,g,u,yazi,secilimi,relative,parent,kenarenk)
	checkboxsayi = #checkbox + 1
    if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
		relative = false
	end
    if not checkbox[checkboxsayi] then checkbox[checkboxsayi] = {} end
    c = checkbox[checkboxsayi]
    c.secili = secilimi
    if secilimi == true then 
        renk = temarengi
        else
        renk = "555555"
    end
	c.arkataraf = guiCreateStaticImage(x,y,25,25,"lib/kutu.dds",relative,parent)
    elementerenkver(c.arkataraf,renk)
	c.label = guiCreateLabel(x+25,y+5,g,25,yazi,false,parent)
	guiSetFont(c.label,butonfont)
	return c.arkataraf
end

--radiobuton
-- function guiCreateRadioButton(x,y,g,u,yazi,secilimi,relative,parent,kenarenk)
-- 	radiobutsayi = #radiobut + 1
--     if relative  then
-- 		px,pu = guiGetSize(parent,false)
-- 		x,y,g,u = x*px,y*pu,g*px,u*pu
-- 		relative = false
-- 	end
--     if not radiobut[radiobutsayi] then radiobut[radiobutsayi] = {} end
--     r = radiobut[radiobutsayi]
--     r.durum = secilimi
--     if secilimi == true then 
-- 		src  = "lib/radiodolu.dds"
--         renk = temarengi
--     else
-- 		src  = "lib/radiobos.dds"
--         renk = "555555"
--     end
-- 	r.arkataraf = guiCreateStaticImage(x,y,20,20,src,relative,parent)
--     elementerenkver(r.arkataraf,renk)
-- 	r.label = guiCreateLabel(x+22,y+1,g,25,yazi,false,parent)
-- 	guiSetFont(r.label,butonfont)
-- 	return r.label
-- end

--scrollbar
function guiCreateScrollBar(x,y,g,u,horizontal,relative,parent,kenarrenk)
	scrollsayi = #scrollbar + 1
    if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
		relative = false
	end
	if not scrollbar[scrollsayi] then scrollbar[scrollsayi] = {} end
    sb = scrollbar[scrollsayi]
	sb.cubuk = guiCreateStaticImage(x,y,g,3, "lib/beyaz.dds", relative, parent)
	elementerenkver(sb.cubuk,"262338")
	
	sb.daire = guiCreateStaticImage(x-2,y-6,15,15, "lib/round.dds", false,parent)
	elementerenkver(sb.daire,"262525")
	guiSetProperty(sb.daire, "AlwaysOnTop", "True")
	guiSetAlpha(sb.daire,1)
	return sb.daire
end

local _guiCreateBrowser = guiCreateBrowser
function guiCreateBrowser(x,y,w,h,state1,state2,relative,parent,kenarrenk)
	tarayicisayi = #tarayici + 1
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,w,h = x*px,y*pu,w*px,h*pu
		relative = false
	end
	if not tarayici[tarayicisayi] then tarayici[tarayicisayi] = {} end
	t = scrollbar[scrollsayi]
	t.brow = _guiCreateBrowser(x, y, w,h,state1,state2,relative,parent)
	t.kenarlar = {
		ortaust = guiCreateStaticImage(0,0,w,1,"lib/beyaz.dds",false,t.brow),
		ortaalt = guiCreateStaticImage(0,h-1,w,1,"lib/beyaz.dds",false,t.brow),
		sol = guiCreateStaticImage(0,0,1,h,"lib/beyaz.dds",false,t.brow),
		sag = guiCreateStaticImage(w-1,0,1,h,"lib/beyaz.dds",false,t.brow)		
	}
	for i,v in pairs(t.kenarlar) do
		elementerenkver(v,kenarrenk or "000000")
		guiSetProperty(v, "AlwaysOnTop", "True")
		--guiSetAlpha(v,1)
		guiSetAlpha(v,0.7)
	end	
	--genel[tarayici[tarayicisayi].brow] = tarayici[tarayicisayi].kenarlar
	return t.brow
end

--utlist
function scrollmu(element)
	for i,v in pairs(scrollbar) do
		if v.cubuk == element then
			return v,i
		end	
	end
end
function dairemi(element)
	for i,v in pairs(scrollbar) do
		if v.daire == element then
			return v.daire
		end	
	end
	return false	
end
function seriusmu(element)
	for i,v in pairs(scrollbar) do
		if v.daire == element or v.cubuk == element then
			return i
		end	
	end
	return false	
end

function guiScrollBarGetScrollPosition(scroll)
	if seriusmu(scroll) then 
	local x,y = guiGetPosition(scrollbar[seriusmu(scroll)].daire,false)
	local w,h = guiGetSize(scrollbar[seriusmu(scroll)].daire,false)
	local aw,ah = guiGetSize(scrollbar[seriusmu(scroll)].cubuk,false)
	if x >= 0 then x = x-1 end
	--if y  0 then y = y-1 end
	if aw-w == 0 then 
		return 0
	else
		return 100*x/(aw-w)-5
		end
	end
end
function guiScrollBarSetScrollPosition(elementscroll,deger)
	if seriusmu(elementscroll) then 
		if deger <= 0 then deger = 1 end
		if deger > 100 then deger = 100 end
		local aw = guiGetSize(scrollbar[seriusmu(elementscroll)].cubuk,false)
		local w = guiGetSize(scrollbar[seriusmu(elementscroll)].daire,false)
		local x,y = guiGetPosition(scrollbar[seriusmu(elementscroll)].daire,false)
		olusandeger = (aw-w)*deger/100-5
		if olusandeger <= 0  then x = x-1 end
		guiSetPosition(scrollbar[seriusmu(elementscroll)].daire,olusandeger,y,false)
	end
end
addEventHandler( "onClientGUIMouseDown", resourceRoot,function ( btn, x, y )
	local sira = dairemi(source) 
	if btn == "left" and sira then
		tiklananelement = source
		local ax, ay = guiGetPosition(source,false)
		moveposition = {x-ax,y-ay}
		elementerenkver(tiklananelement,logorengi)
		guiSetAlpha(tiklananelement,0.6)
	end
end)

addEventHandler( "onClientClick", root,function ( btn, state )
	if btn == "left" and tiklananelement and state == "up" then
		guiSetAlpha(tiklananelement,1)
		elementerenkver(tiklananelement,"262525")
		tiklananelement = nil
	end
end)


addEventHandler( "onClientCursorMove", getRootElement(),function ( _, _, x, y )
	if tiklananelement then
		local ax, ay = moveposition[1], moveposition[2] 
		local posX, posY = x-ax, y-ay
		local ex, ey = guiGetPosition(tiklananelement,false)
		w, h = guiGetSize(tiklananelement,false)
		aw, ah = guiGetSize(scrollbar[seriusmu(tiklananelement)].cubuk,false)
		if posX <= 5 then posX = 5 end
		if posX > aw-w+15 then posX = aw-w+15 end
		guiSetPosition(tiklananelement,posX, ey,false)
		triggerEvent("onClientGUIScroll",tiklananelement,tiklananelement)
	end
end)

addEventHandler("onClientMouseLeave",resourceRoot,function()
    for i,v in pairs(scrollbar) do 
        if source == v.daire then 
			if tiklananelement == nil then
				guiSetAlpha(v.daire,1)
				elementerenkver(v.daire,"262525")
			end
        end
    end
end)

--scrollbar taşıma
--[[
addEventHandler( "onClientCursorMove", getRootElement( ),function ( _, _, x, y )
	if clickedElementSB then
		local farkx = x-offsetPosSB[3]
		local x,y = farkx + offsetPosSB[ 1 ], offsetPosSB[ 2 ]
		guiSetPosition( clickedElementSB, (x<2 and 2) or (x>(offsetPosSB[4]-7) and offsetPosSB[4]-7) or x, y, false )
		--print(clickedElementSB,clickedElementSB)
		--setCursorPosition(farkx + offsetPosSB[ 1 ], offsetPosSB[ 2 ])
		triggerEvent("onClientGUIScroll",clickedElementSB,clickedElementSB)
	end
end)

addEventHandler( "onClientGUIMouseDown", resourceRoot,function ( btn, x, y )
	if btn == "left" and dairemi(source) then
		clickedElementSB = source
		local elementPos = { guiGetPosition( source, false ) }
		local parent = getElementParent(source)
		local w = guiGetSize(parent,false)
		
		offsetPosSB = { elementPos[ 1 ], elementPos[ 2 ], x, w };
	end
end)

addEventHandler( "onClientCursorMove", getRootElement( ),function ( _, _, x, y )
	if clickedElementSB then
		local farkx = x-offsetPosSB[3]
		local x,y = farkx + offsetPosSB[ 1 ], offsetPosSB[ 2 ]
		guiSetPosition( clickedElementSB, (x<2 and 2) or (x>(offsetPosSB[4]-7) and offsetPosSB[4]-7) or x, y, false )
		--print(clickedElementSB,clickedElementSB)
		--setCursorPosition(farkx + offsetPosSB[ 1 ], offsetPosSB[ 2 ])
		triggerEvent("onClientGUIScroll",clickedElementSB,clickedElementSB)
	end
end)
--]]


function panelmi(element)
	for i,v in pairs(panel) do
		if v.arkataraf == element then
			return v,i
		end	
	end
end

function keywindowmu(element)
	for i,v in pairs(keywindow) do
		if v.label == element then
			return v,i
		end	
	end
end

function setColorKeyWindow(element,durum)
	local sira = keywindowmu(element)
	if not sira then return end
	if durum == true then 
		guiLabelSetColor(sira.label,95, 194, 194)
		guiLabelSetColor(sira.label2,95, 194, 194)
		else
		guiLabelSetColor(sira.label,255, 255, 255)
		guiLabelSetColor(sira.label2,255, 255, 255)
	end
end

function setColorKeyWindowRGB(element,r,g,b)
	local sira = keywindowmu(element)
	if not sira then return end
	guiLabelSetColor(sira.label,r, g, b)
	guiLabelSetColor(sira.label2,r, g, b)
end

--[[

function setHoverColor(element,renk)
    local sira = butonmud(element)
    if sira then 
        button[sira].hoverrenk = renk
    end
end
]]
--keywindow
function basliklabelmi(element)
	for i,v in pairs(panel) do
		if v.baslik == element or v.label == element  then
			return v,i
		end	
	end
	return false	
end
function movemi(element)
	for i,v in pairs(panel) do
		if v.arkataraf == element or v.baslik == element or v.label == element then
			return i
		end	
	end
	return false	
end
addEventHandler( "onClientGUIMouseDown", resourceRoot,function ( btn, x, y )
	if btn == "left" then
		local wsira = basliklabelmi(source)
		if wsira then
        if panel[movemi(source)].movedurum == true then 
			local source = wsira.arkataraf
			clickedElement = source
			local elementPos = { guiGetPosition( source, false ) }
			offsetPos = { x - elementPos[ 1 ], y - elementPos[ 2 ] };
		    end	
        end
	end
end)
addEventHandler( "onClientGUIMouseUp", resourceRoot,function ( btn, x, y )
	if btn == "left" and basliklabelmi(source) then
		clickedElement = nil
	end
end)
addEventHandler( "onClientCursorMove", getRootElement( ),function ( _, _, x, y )
	if clickedElement then
		guiSetPosition( clickedElement, x - offsetPos[ 1 ], y - offsetPos[ 2 ], false )
	end
end)
addEventHandler("onClientMouseEnter",resourceRoot,function()
	for i,v in pairs(panel) do 
		if source == v.kapat then 
			elementerenkver(v.kapat,"a40163")
		end
	end
end)
addEventHandler("onClientMouseLeave",resourceRoot,function()
	for i,v in pairs(panel) do 
		if source == v.kapat then 
			elementerenkver(v.kapat,"adadad")
		end
	end
end)
addEventHandler("onClientGUIClick", resourceRoot, function()
	for i,v in pairs(panel) do
		if source == v.kapat then
			--guiSetVisible(v.arkataraf,false)
			triggerEvent("seriuslib:closef3",localPlayer)
		end
	end
end)
_guiWindowSetMovable = guiWindowSetMovable
function guiWindowSetMovable(element,bool)
    local sira = movemi(element)
    if sira then 
        panel[sira].movedurum = bool
    end
end
--button
function butonmu(element)
	for i,v in pairs(button) do
		if v.label == element then
			return v,i
		end	
	end
end
function butonmud(element)
	for i,v in pairs(button) do
		if v.label == element then
			return i
		end	
	end
end
function getHoverColor(element)
    local sira = butonmud(element)
    return button[sira].hoverrenk
end
function setHoverColor(element,renk)
    local sira = butonmud(element)
    if sira then 
        button[sira].hoverrenk = renk
    end
end
addEventHandler("onClientMouseEnter",resourceRoot,function()
    for i,v in pairs(button) do 
        if source == v.label then 
            elementerenkver(button[butonmud(source)].arkataraf,getHoverColor(source) or temahovercolor)
            guiSetAlpha(button[butonmud(source)].arkataraf,0.7)
        end
    end
end)
addEventHandler("onClientMouseLeave",resourceRoot,function()
    for i,v in pairs(button) do 
        if source == v.label then 
            elementerenkver(button[butonmud(source)].arkataraf,temarengi)
            guiSetAlpha(button[butonmud(source)].arkataraf,1)
        end
    end
end)

--genel 
addEventHandler("onClientMouseEnter", resourceRoot, function()
	for i,v in pairs(genel) do
		if source == i then
			for i,v in pairs(v) do
				guiSetAlpha(v, 0.8)
			end	
		end
	end
end)
addEventHandler("onClientMouseLeave", resourceRoot, function()
	for i,v in pairs(genel) do
		if source == i then
			for i,v in pairs(v) do
				guiSetAlpha(v, 0.5)
			end	
		end
	end
end)
--checkbox
function tikmi(element)
	for i,v in pairs(checkbox) do
		--if v.label == element then
		if v.arkataraf == element then
			return v,i
		end	
	end
end
function tikmid(element)
	for i,v in pairs(checkbox) do
		--if v.label == element then
		if v.label == element or v.arkataraf == element then
			return v,i
		end	
	end
end
function labeltikmi(element)
	for i,v in pairs(checkbox) do
		if v.arkataraf == element or v.label == element  then
			return i
		end	
	end
	return false	
end
function guiCheckBoxGetSelected(element)
	local sira = tikmid(element) 
	if not sira then return end
	return sira.secili
end
function guiCheckBoxSetSelected(element,bool)
	local sira = tikmi(element)
	if sira then 
		if bool == true then 
			elementerenkver(sira.arkataraf,"e3652b")
		else
			elementerenkver(sira.arkataraf,"555555")
		end 
		sira.secili = bool
	end
end
function guiCheckModeSetState(element,bool)
	local sira = tikmi(element)
	sira.olay = bool
end
--[[
addEventHandler("onClientMouseEnter",resourceRoot,function()
    for i,v in pairs(checkbox) do 
        if source == v.arkataraf then 
			if v.secili == true then
				guiSetAlpha(v.arkataraf,0.3)
				guiSetAlpha(v.label,0.6)
				else
			end
			if v.olay == true then return end
            guiSetAlpha(v.arkataraf,0.3)
            guiSetAlpha(v.label,0.6)
			break
        end
    end
end)
addEventHandler("onClientMouseLeave",resourceRoot,function()
    for i,v in pairs(checkbox) do 
        if source == v.arkataraf  then 
			if v.olay == true then return end
            if v.secili == true then return end
            guiSetAlpha(v.arkataraf,1)
            guiSetAlpha(v.label,1)
			break
        end
    end
end)
--]]
--addEvent("seriuslib:checkboxselected",true)
addEventHandler("onClientGUIClick",resourceRoot,function()
	for i,v in pairs(checkbox) do
		if source == v.arkataraf  then 	
			--triggerEvent("seriuslib:checkboxselected",localPlayer,source)
			if v.olay == true then return end
			if v.secili == true then 
			v.secili = false
            elementerenkver(v.arkataraf,"555555")
			else
			v.secili = true
			guiSetAlpha(v.arkataraf,1)
            guiSetAlpha(v.label,1)
            elementerenkver(v.arkataraf,"e3652b")
			break
			end
		end
	end
end)
--radiobutton
-- function radiomu(element)
-- 	for i,v in pairs(radiobut) do
-- 		if v.label == element then
-- 			return v,i
-- 		end	
-- 	end
-- end
-- function radiomusayi(radiobut)
-- 	for i,v in pairs(checkbox) do
-- 		if v.label == element then
-- 			return i
-- 		end	
-- 	end
-- end
-- function guiRadioButtonGetSelected(element)
-- 	local sira = radiomu(element)
-- 	return sira.durum
-- end
-- function guiRadioButtonSetSelected(element,bool)
-- 	local sira = radiomu(element)
-- 	if sira then 
-- 		if bool == true then 
-- 			guiStaticImageLoadImage(sira.arkataraf,"lib/radiodolu.dds")
-- 			else
-- 			guiStaticImageLoadImage(sira.arkataraf,"lib/radiobos.dds")
-- 		end
-- 		sira.durum = bool
-- 	end
-- end
--gridlist
function gridlistmi(element)
	for i,v in pairs(liste) do
		if v.listee == element then
			return i
		end	
	end
	return false	
end
--editbox
function editmi(element)
	for i,v in pairs(editbox) do
		if v.editbox == element then
			return i
		end	
	end
	return false	
end
--tüm utlist
renderTimers = {}
function createRender(id, func)
    if not isTimer(renderTimers[id]) then
        renderTimers[id] = setTimer(func, 2, 0)
    end
end
function destroyRender(id)
    if isTimer(renderTimers[id]) then
        killTimer(renderTimers[id])
        renderTimers[id] = nil
        collectgarbage("collect")
    end
end
function checkRender(id)
    return renderTimers[id]
end
_guiSetVisible = guiSetVisible
function guiSetVisible(element, bool)
	if butonmu(element) then
		local sira = butonmu(element)
		_guiSetVisible(button[sira].arkataraf, bool)
	elseif gridlistmi(element) then
		local sira = gridlistmi(element)
		_guiSetVisible(liste[sira].arkataraf, bool)
	elseif editmi(element) then
		local sira = editmi(element)
		_guiSetVisible(editbox[sira].arkataraf, bool)
	elseif tikmi(element) then 
		local sira = tikmi(element)
		_guiSetVisible(sira.arkataraf, bool)
		_guiSetVisible(sira.label, bool)
	else
		_guiSetVisible(element, bool)
	end	
end

_guiSetText = guiSetText
function guiSetText(element, yazi)
	local sira = tikmi(element)
	local sira2 = panelmi(element)
	if sira then 
		_guiSetText(sira.label, yazi)
	elseif sira2 then 
		_guiSetText(sira2.label, yazi)
	else
		_guiSetText(element, yazi)
	end
end

function rgb2hex(r,g,b) 
	return string.format("%02X%02X%02X", r,g,b) 
end 