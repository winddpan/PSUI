local iconSize = 22
local anchor_x = 82
local anchor_y = -220

local class = select(2,UnitClass"player") 

CS=CreateFrame("Frame") 
CS.c=CreateFrame("Cooldown","CST",CS.t)
CS:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") 
CS.c:SetAllPoints(CS)
CS:SetPoint("CENTER",anchor_x,anchor_y)
CS:SetSize(iconSize,iconSize)
CS.t=CS:CreateTexture(nil,"Border")
CS.t:SetAllPoints()
CS.t:SetTexture("Interface\\Icons\\ability_cheapshot") 
CS:Hide()
CS:SetScript("OnEvent",function(self,event,...)
	if   not class == "ROGUE" then  return end
	 if UnitName(select(1,...))==UnitName("player") and select(5,...)==1833 then 
		CST:SetCooldown(GetTime(), 23)
		CS:Show()
		end
	if UnitName(select(1,...))==UnitName("player") and select(5,...)==408 then 
		CST:SetCooldown(GetTime(), 25) 
		CS:Show()
	end
end) 


SP=CreateFrame("Frame")
SP.c=CreateFrame("Cooldown","SAP",SP.t)
SP:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") 
SP.c:SetAllPoints(SP)
SP:SetPoint("CENTER",anchor_x+iconSize+1,anchor_y)
SP:SetSize(iconSize,iconSize)
SP.t=SP:CreateTexture(nil,"Border")
SP.t:SetAllPoints()
SP.t:SetTexture("Interface\\Icons\\ability_sap") 
SP:Hide()
SP:SetScript("OnEvent",function(self,event,...)
	if   not class == "ROGUE" then  return end
	 if UnitName(select(1,...))==UnitName("player") and select(5,...)==6770 then
		SAP:SetCooldown(GetTime(), 27)
		SP:Show()
	end 
	if UnitName(select(1,...))==UnitName("player") and select(5,...)==1776 then 
		SAP:SetCooldown(GetTime(), 23) 
		SP:Show()
	end
end) 


GR=CreateFrame("Frame") 
GR.c=CreateFrame("Cooldown","GARROTE",GR.t) 
GR:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") 
GR.c:SetAllPoints(GR) 
GR:SetPoint("CENTER",anchor_x+2*iconSize+2,anchor_y)
GR:SetSize(iconSize,iconSize)
GR.t=GR:CreateTexture(nil,"Border")
GR.t:SetAllPoints()
GR.t:SetTexture("Interface\\Icons\\ability_Rogue_Garrote")
GR:Hide() 
GR:SetScript("UNIT_SPELLCAST_SUCCEEDED",function(self,event,...) 
	if   not class == "ROGUE" then  return end
	if UnitName(select(1,...))==UnitName("player") and select(5,...)==703 then 
		GARROTE:SetCooldown(GetTime(), 23)
		GR:Show() 
	else
		GR:Hide()
	end
	if UnitName(select(1,...))==UnitName("player") and select(5,...)==102926 then 
		GARROTE:SetCooldown(GetTime(), 20)
		GR:Show() 
	else
		GR:Hide()
	end
end)

