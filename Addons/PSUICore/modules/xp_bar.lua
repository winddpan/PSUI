local addon, ns = ...
local cfg = ns.cfg

local enableExperienceBar = true
if UnitLevel("player") == MAX_PLAYER_LEVEL then
	--enableExperienceBar = false
end

if not enableExperienceBar then return  end

local myscale = 1
local width = 142
local height = 7
local ypos = 14
local xpcolor = {r = 0/255, g = 132/255, b = 176/255}

local bf = CreateFrame("Frame", nil, UIParent)
bf:SetFrameStrata("LOW")
bf:SetFrameLevel(2)
bf:SetWidth(width*myscale)
bf:SetHeight((height+2)*myscale)
--bf:SetPoint("BOTTOM", 0, (ypos-1)*myscale)
bf:SetPoint("TOP", Minimap, "BOTTOM" , 0, -4)
bf:Show()
	Shadow = CreateFrame("Frame", nil,bf)
	Shadow:SetPoint("TOPLEFT",  -2, 2)
	Shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	Shadow:SetBackdrop({edgeFile = "Interface\\addons\\PSUICore\\media\\glow.tga", edgeSize = 3,
									insets = {top = 3, left = 3, bottom = 3, right = 3}})
	Shadow:SetBackdropBorderColor(0, 0, 0, 1)
	
local bbg = bf:CreateTexture(nil,"BACKGROUND")
bbg:SetTexture("Interface\\Buttons\\WHITE8x8")
bbg:SetVertexColor(xpcolor.r,xpcolor.g,xpcolor.b, 0.2)
bbg:SetWidth(bf:GetWidth())
bbg:SetHeight(bf:GetHeight())
bbg:SetPoint("CENTER", 0, 0)
bbg:Show()

local rbar = CreateFrame("StatusBar", "RestBar", UIParent)
rbar:SetStatusBarTexture("Interface\\AddOns\\\PSUICore\\media\\statusbar.tga")
rbar:SetStatusBarColor(1,.6,0, 0.7)
rbar:SetFrameStrata("LOW")
rbar:SetFrameLevel(1)
rbar:SetWidth(width*myscale)
rbar:SetHeight(height*myscale)
--rbar:SetPoint("BOTTOM", 0, ypos*myscale)
rbar:SetPoint("TOP", Minimap, "BOTTOM" , 0, -5)
rbar:SetMinMaxValues(0,1)
rbar:SetValue(0)
rbar:Show()

local xbar = CreateFrame("StatusBar", "ExpBar", UIParent)
xbar:SetStatusBarTexture("Interface\\AddOns\\\PSUICore\\media\\statusbar.tga")
xbar:SetStatusBarColor(xpcolor.r,xpcolor.g,xpcolor.b, 0.95)
xbar:SetFrameStrata("LOW")
xbar:SetFrameLevel(3)
xbar:SetWidth(width*myscale)
xbar:SetHeight(height*myscale)
--xbar:SetPoint("BOTTOM", 0, ypos*myscale)
xbar:SetPoint("TOP", Minimap, "BOTTOM" , 0, -5)
xbar:Show()

function rbar_ReSetValue(rxp, xp, mxp)
	if rxp then
		if rxp+xp >= mxp then
			rbar:SetValue(mxp)
		else
			rbar:SetValue(rxp+xp)
		end
	else
		rbar:SetValue(0)
	end
end	

function bf_ShowRep()
	name, standing, minrep, maxrep, value = GetWatchedFactionInfo()
	if name then
		bf:Show()
		xbar:Show()
		bbg:Show()
		bbg:SetVertexColor(FACTION_BAR_COLORS[standing].r, FACTION_BAR_COLORS[standing].g, FACTION_BAR_COLORS[standing].b, 0.2)
		xbar:SetStatusBarColor(FACTION_BAR_COLORS[standing].r, FACTION_BAR_COLORS[standing].g, FACTION_BAR_COLORS[standing].b, 0.85)
		xbar:SetMinMaxValues(minrep,maxrep)
		xbar:SetValue(value)
		rbar:SetValue(0)
	else
		bf:Hide()
		xbar:Hide()
		bbg:Hide()
		--[[
		mxp = UnitXPMax("player")
		xp = UnitXP("player")
		rxp = GetXPExhaustion()
		bf_ShowXP(rxp, xp, mxp)]]
	end
end

function bf_ShowXP(rxp, xp, mxp)
	bf:Show()
	xbar:Show()
	bbg:Show()
		
	bbg:SetVertexColor(xpcolor.r,xpcolor.g,xpcolor.b, 0.2)
	xbar:SetStatusBarColor(xpcolor.r,xpcolor.g,xpcolor.b, 0.85)
	xbar:SetMinMaxValues(0,mxp)
	xbar:SetValue(xp)
	rbar:SetMinMaxValues(0,mxp)
	rbar_ReSetValue(rxp, xp, mxp)
end

function bf_OnEvent(this, event, arg1, arg2, arg3, arg4, ...)
	mxp = UnitXPMax("player")
	xp = UnitXP("player")
	rxp = GetXPExhaustion()
	
	if event == "PLAYER_ENTERING_WORLD" then
		if UnitLevel("player") == MAX_PLAYER_LEVEL then
			bf_ShowRep()
		else
			bf_ShowXP(rxp, xp, mxp)
		end
	elseif event == "PLAYER_XP_UPDATE" and arg1 == "player" then
		bf_ShowXP(rxp, xp, mxp)
		xbar:SetValue(xp)
		rbar_ReSetValue(rxp, xp, mxp)
	elseif event == "PLAYER_LEVEL_UP" then
		if UnitLevel("player") == MAX_PLAYER_LEVEL then
			bf_ShowRep()
		else
			bf_ShowXP(rxp, xp, mxp)
		end
	elseif event == "MODIFIER_STATE_CHANGED" then
		if arg1 == "LCTRL" or arg1 == "RCTRL" then
			if arg2 == 1 then
				bf_ShowRep()
			elseif arg2 == 0 and UnitLevel("player") ~= MAX_PLAYER_LEVEL then
				bf_ShowXP(rxp, xp, mxp)
			end
		end
	elseif event == "UPDATE_FACTION" then
		if UnitLevel("player") == MAX_PLAYER_LEVEL then
			bf_ShowRep()
		end
	end
end

function bf_OnEnter()
	mxp = UnitXPMax("player")
	xp = UnitXP("player")
	rxp = GetXPExhaustion()
	name, standing, minrep, maxrep, value = GetWatchedFactionInfo()

	GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
	--GameTooltip:AddLine("jExp")
	if UnitLevel("player") ~= MAX_PLAYER_LEVEL then
		GameTooltip:AddDoubleLine(COMBAT_XP_GAIN, xp.."|cffffd100/|r"..mxp.." |cffffd100/|r "..floor((xp/mxp)*1000)/10 .."%",NORMAL_FONT_COLOR.r,NORMAL_FONT_COLOR.g,NORMAL_FONT_COLOR.b,1,1,1)
		if rxp then
			GameTooltip:AddDoubleLine(TUTORIAL_TITLE26, rxp .." |cffffd100/|r ".. floor((rxp/mxp)*1000)/10 .."%", NORMAL_FONT_COLOR.r,NORMAL_FONT_COLOR.g,NORMAL_FONT_COLOR.b,1,1,1)
		end
		if name then
			GameTooltip:AddLine(" ")			
		end
	end
	if name then
		GameTooltip:AddDoubleLine(FACTION, name, NORMAL_FONT_COLOR.r,NORMAL_FONT_COLOR.g,NORMAL_FONT_COLOR.b,1,1,1)
		GameTooltip:AddDoubleLine(STANDING, getglobal("FACTION_STANDING_LABEL"..standing), NORMAL_FONT_COLOR.r,NORMAL_FONT_COLOR.g,NORMAL_FONT_COLOR.b,FACTION_BAR_COLORS[standing].r, FACTION_BAR_COLORS[standing].g, FACTION_BAR_COLORS[standing].b)
		GameTooltip:AddDoubleLine(REPUTATION, value-minrep .."|cffffd100/|r"..maxrep-minrep.." |cffffd100/|r "..floor((value-minrep)/(maxrep-minrep)*1000)/10 .."%", NORMAL_FONT_COLOR.r,NORMAL_FONT_COLOR.g,NORMAL_FONT_COLOR.b,1,1,1)
	end
		
	GameTooltip:Show()
end

function bf_OnLeave()
	GameTooltip:Hide()
end

bf:EnableMouse(true)
bf:SetScript("OnEvent", bf_OnEvent)
bf:SetScript("OnEnter", bf_OnEnter)
bf:SetScript("OnLeave", bf_OnLeave)
bf:RegisterEvent("PLAYER_XP_UPDATE")
bf:RegisterEvent("PLAYER_LEVEL_UP")
bf:RegisterEvent("PLAYER_ENTERING_WORLD")
bf:RegisterEvent("UPDATE_FACTION")
bf:RegisterEvent("MODIFIER_STATE_CHANGED")
