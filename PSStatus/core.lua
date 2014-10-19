﻿local f = CreateFrame("frame","PSStatus", UIParent); 
f:SetSize(100, 40)
f:SetMovable(true)
f:EnableMouse(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", function(self) 
	if IsShiftKeyDown() then 
		self:StartMoving() 
	end
end)
f:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
end)
f:SetScript("OnEnter", function(s) 
          GameTooltip:SetOwner(s, "ANCHOR_TOP")
          GameTooltip:AddLine("PSStatus攻强/法伤", 0, 1, 0.5, 1, 1, 1)
          GameTooltip:AddLine("按住Shift可以拖动", 1, 1, 1, 1, 1, 1)
          GameTooltip:Show()
        end)
f:SetScript("OnLeave", function(s) GameTooltip:Hide() end)
f:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
	
text = f:CreateFontString(nil, 'OVERLAY')
text:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
text:SetAllPoints(f)
text:SetJustifyH('RIGHT')

local function updateStatue()
	local prefix
	local buffed = 0
	local based = 0
	local effective = 0
	
	local rangedAp = UnitRangedAttackPower("player")
	local ap = UnitAttackPower("player")
	local sp = GetSpellBonusDamage(7)

	if rangedAp > sp then --hunter
		prefix = ""
		local base, posBuff, negBuff = UnitRangedAttackPower("player")
		effective = base + posBuff + negBuff;
	elseif ap > sp then	--近战
		prefix = ""
		local base, posBuff, negBuff = UnitAttackPower("player")
		effective = base + posBuff + negBuff;
	elseif sp > ap then --法系
		prefix = ""
		effective = sp
	end
	
	if buffed > based *0.3 then
		text:SetText("|cffff3333"..prefix..lib.formatNumber(effective))     
	else
		text:SetText(prefix..("%d"):format(effective))        		
	end			
end

local TimeSinceLastUpdate = 0
f:SetScript("OnUpdate", function(self, elapsed)
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
	if (TimeSinceLastUpdate > 0.3) then
		updateStatue()
		TimeSinceLastUpdate = 0
	end
end)

SlashCmdList["APANCHOR"] = function(msg) 
	if msg:lower() == "" then
		print("PSStatus reset 可重置位置")
	elseif msg:lower() == "reset" then
		f:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
	end
end
SLASH_APANCHOR1 = "/psstatus"
