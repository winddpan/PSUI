local addon, ns = ...
local cfg = ns.cfg
local panel = CreateFrame("Frame", nil, UIParent)

if cfg.Coords == true then
    local Stat = CreateFrame("Frame")
    Stat:EnableMouse(true)

    local Text  = panel:CreateFontString(nil, "OVERLAY")
    Text:SetFont(unpack(cfg.Fonts))
    Text:SetPoint(unpack(cfg.CoordsPoint))
	Stat:SetAllPoints(Text)
	
	local coordX, coordY = 0, 0
	local function formatCoords() return format("%d,%d", coordX*100, coordY*100) end
	
	Stat:SetScript("OnUpdate", function()
		coordX, coordY = GetPlayerMapPosition("player")
		Text:SetText(formatCoords())
	end)
	Stat:SetScript("OnMousedown", function(_,btn)
		if btn == "LeftButton" then
			ToggleFrame(WorldMapFrame)
		else
			ChatFrame_OpenChat(format("%s: %s",infoL["My Coordinate"],formatCoords()), chatFrame)
		end
	end)
end