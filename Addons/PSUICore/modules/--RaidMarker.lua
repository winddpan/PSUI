-- Config
local font = STANDARD_TEXT_FONT         
fontsize = 10                     		
buttonwidth = 27    		
buttonheight = 27  
 		
local function CreateAnchor(f, text, width, height)
	f:SetScale(1)
	f:SetFrameStrata("TOOLTIP")
	f:SetScript("OnDragStart", OnDragStart)
	f:SetScript("OnDragStop", OnDragStop)
	f:SetWidth(width)
	f:SetHeight(height)
	
	local h = CreateFrame("Frame", nil)
	h:SetFrameLevel(30)
	h:SetAllPoints(f)
	f.dragtexture = h
	
	local v = CreateFrame("Frame", nil, h)
	v:SetPoint("TOPLEFT",0,0)
	v:SetPoint("BOTTOMRIGHT",0,0)
	--framemove(v)

	f:SetMovable(true)
	f.dragtexture:SetAlpha(0)
	f:EnableMouse(nil)
	f:RegisterForDrag(nil)

	f.text = f:CreateFontString(nil, "OVERLAY")
	f.text:SetFont(font, 10)
	f.text:SetJustifyH("LEFT")
	f.text:SetShadowColor(0, 0, 0)
	f.text:SetShadowOffset(1, -1)
	f.text:SetAlpha(0)
	f.text:SetPoint("CENTER")
	f.text:SetText(text)

	--tinsert(AnchorFrames, f:GetName())
end

local function CreatePanel(f, w, h, a1, p, a2, x, y)
	local _, class = UnitClass("player")
	local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	sh = h
	sw = w
	mult = 1
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
	  bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
      edgeFile = "Interface\\Buttons\\WHITE8x8", 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(.05,.05,.05, .5)
	f:SetBackdropBorderColor(.15,.15,.15,0)
end

AnchorMarkBar = CreateFrame("Frame","Move_MarkBar",UIParent)
AnchorMarkBar:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", 440, 0)
AnchorMarkBar:SetFrameLevel(11)
CreateAnchor(AnchorMarkBar, "Move Mark Bar", 100, 16)						

local anchor = {}
anchor = {"TOP", AnchorMarkBar}

--Background Frame
local MarkBarBG = CreateFrame("Frame", "MarkBarBackground", UIParent)
CreatePanel(MarkBarBG, buttonwidth * 4 + 15, buttonheight * 3, "TOP", AnchorMarkBar, "TOP", 0, 0)
MarkBarBG:SetBackdropColor(.05,.05,.05,0)
MarkBarBG:SetFrameLevel(0)
MarkBarBG:SetFrameStrata("HIGH")
MarkBarBG:ClearAllPoints()
MarkBarBG:SetPoint(unpack(anchor))
MarkBarBG:Hide()
--CreateStyle(MarkBarBG, 2)

--Change border when mouse is inside the button
local function ButtonEnter(self)
	local _, class = UnitClass("player")
	local color = RAID_CLASS_COLORS[class]
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end
 
--Change border back to normal when mouse leaves button
local function ButtonLeave(self)
	self:SetBackdropBorderColor(.15,.15,.15,0)
end

icon = CreateFrame("Button", "tmb_Icon", MarkBarBG)
mark = CreateFrame("Button", "tmb_Menu", MarkBarBG)
for i = 1, 8 do
	mark[i] = CreateFrame("Button", "tbm_Mark"..i, MarkBarBG)
	CreatePanel(mark[i], buttonwidth, buttonheight, "LEFT", MarkBarBG, "LEFT", 3, -3)
	if i == 1 then
		mark[i]:SetPoint("BOTTOMLEFT", MarkBarBG, "TOPLEFT",  3, 3)
	elseif i%2 ==1 then
		mark[i]:SetPoint("BOTTOM", mark[i-2], "TOP", 0, 3)
	else
		mark[i]:SetPoint("LEFT", mark[i-1], "RIGHT", 3, 0)
	end
	mark[i]:EnableMouse(true)
	mark[i]:SetScript("OnEnter", ButtonEnter)
	mark[i]:SetScript("OnLeave", ButtonLeave)
	mark[i]:RegisterForClicks("AnyUp")
	mark[i]:SetFrameStrata("HIGH")
	
	icon[i] = CreateFrame("Button", "icon"..i, MarkBarBG)
	icon[i]:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	icon[i]:SetSize(25, 25)
	icon[i]:SetPoint("CENTER", mark[i])
	icon[i]:SetFrameStrata("HIGH")
	
	-- Set up each button
	if i == 1 then -- Skull
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 8) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.75,1,0.25,0.5)
	elseif i == 2 then -- Cross
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 7) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.5,0.75,0.25,0.5)
	elseif i == 3 then -- Square
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 6) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.25,0.5,0.25,0.5)
	elseif i == 4 then -- Moon
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 5) end)
		icon[i]:GetNormalTexture():SetTexCoord(0,0.25,0.25,0.5)
	elseif i == 5 then -- Triangle
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 4) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.75,1,0,0.25)
	elseif i == 6 then -- Diamond
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 3) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.5,0.75,0,0.25)
	elseif i == 7 then -- Circle
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 2) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.25,0.5,0,0.25)
	elseif i == 8 then -- Star
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 1) end)
		icon[i]:GetNormalTexture():SetTexCoord(0,0.25,0,0.25)
	end
end

local function CreateMarkerButton(name, point, relativeto, point2, x, y)
    local f = CreateFrame("Button", name, MarkBarBG, "SecureActionButtonTemplate")
    f:SetPoint(point, relativeto, point2, x, y)
    f:SetWidth(9.5)
    f:SetHeight(9.5)
	--frame1px(f)
	CreateStyle(f, 5)
    f:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    f:SetAttribute("type", "macro")
end

CreateMarkerButton("BlueFlare", "TOPLEFT", MarkBarBG, "TOPRIGHT", 3, -3)
BlueFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button1
]])
BlueFlare:SetBackdropColor(0, 0, 1)
CreateMarkerButton("GreenFlare", "TOP", BlueFlare, "BOTTOM", 0, -4)
GreenFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button2
]])
GreenFlare:SetBackdropColor(0, 1, 0)
CreateMarkerButton("PurpleFlare", "TOP", GreenFlare, "BOTTOM", 0, -4)
PurpleFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button3
]])
PurpleFlare:SetBackdropColor(1, 0, 1)
CreateMarkerButton("RedFlare", "TOP", PurpleFlare, "BOTTOM", 0, -4)
RedFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button4
]])
RedFlare:SetBackdropColor(1, 0, 0)
CreateMarkerButton("YellowFlare", "TOP", RedFlare, "BOTTOM", 0, -4)
YellowFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button5
]])
YellowFlare:SetBackdropColor(1, 1, 0)
CreateMarkerButton("ClearFlare", "TOP", YellowFlare, "BOTTOM", 0, -2)
ClearFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button6
]])
ClearFlare:SetBackdropColor(.075, .075, .075)
 
local ClearTargetButton = CreateFrame("Button", "ClearTargetButton", MarkBarBackground)
CreatePanel(ClearTargetButton, (buttonwidth * 4) + 9, 16, "TOPLEFT", mark[5], "BOTTOMLEFT", 0, -3)
ClearTargetButton:SetScript("OnEnter", ButtonEnter)
ClearTargetButton:SetScript("OnLeave", ButtonLeave)
ClearTargetButton:SetScript("OnMouseUp", function() SetRaidTarget("target", 0) end)
ClearTargetButton:SetFrameStrata("HIGH")

local ClearTargetButtonText = ClearTargetButton:CreateFontString("ClearTargetButtonText","OVERLAY", ClearTargetButton)
ClearTargetButtonText:SetFont(font,fontsize,"OUTLINE")
ClearTargetButtonText:SetText("Clear Target")
ClearTargetButtonText:SetPoint("CENTER")
ClearTargetButtonText:SetJustifyH("CENTER", 1, 0)

local ToggleButton = CreateFrame("Frame", "ToggleButton", UIParent)
CreatePanel(ToggleButton, 100, 16, "CENTER", UIParent, "CENTER", 0, 0)
ToggleButton:ClearAllPoints()
ToggleButton:SetPoint(unpack(anchor))
ToggleButton:EnableMouse(true)
ToggleButton:SetScript("OnEnter", ButtonEnter)
ToggleButton:SetScript("OnLeave", ButtonLeave)
--CreateStyle(ToggleButton, 2)
local ToggleButtonText = ToggleButton:CreateFontString(nil ,"OVERLAY")
ToggleButtonText:SetFont(font, fontsize)
ToggleButtonText:SetText("Mark Bar")
ToggleButtonText:SetPoint("CENTER", ToggleButton, "CENTER")
	
local CloseButton = CreateFrame("Frame", "CloseButton", MarkBarBackground)
CreatePanel(CloseButton, 15, 15, "TOPRIGHT", MarkBarBackground, "TOPLEFT", -3, 0)
CloseButton:EnableMouse(true)
CloseButton:SetScript("OnEnter", ButtonEnter)
CloseButton:SetScript("OnLeave", ButtonLeave)
--CreateStyle(CloseButton, 2)
local CloseButtonText = CloseButton:CreateFontString(nil, "OVERLAY")
CloseButtonText:SetFont(font, fontsize)
CloseButtonText:SetText("x")
CloseButtonText:SetPoint("CENTER", CloseButton, "CENTER")

ToggleButton:SetScript("OnMouseDown", function()
	if MarkBarBackground:IsShown() then
		MarkBarBackground:Hide()
	else
		MarkBarBackground:Show()
	end
end)
	
CloseButton:SetScript("OnMouseDown", function()
	if MarkBarBackground:IsShown() then
		MarkBarBackground:Hide()
	else
		ToggleButton:Show()
	end
end)