if select(2, UnitClass("player")) ~= "ROGUE" then return end

local Gains = {
	{name = "敏锐大师", unit = "player", filter = "BUFF", value = 0.1},
	{name = "死亡符记", unit = "player", filter = "BUFF", value = 0.15},
	{name = "暗影之舞", unit = "player", filter = "BUFF", value = 0.3},
	{name = "夜刃", unit = "target", filter = "DEBUFF", value = 0.15},
}

local f = CreateFrame("frame","SubHelper", UIParent)
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
          GameTooltip:AddLine("敏锐伤害助手", 0, 1, 0.5, 1, 1, 1)
          GameTooltip:AddLine("按住Shift可以拖动", 1, 1, 1, 1, 1, 1)
          GameTooltip:Show()
        end)
f:SetScript("OnLeave", function(s) GameTooltip:Hide() end)
f:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)

f.text = f:CreateFontString(nil, 'OVERLAY')
f.text:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
f.text:SetAllPoints(f)
f.text:SetJustifyH('RIGHT')

local function OnEvent(event, unit) 
	local value = 1
	for i = 1, #Gains, 1 do
		local data = Gains[i]
		if data.filter == "BUFF" then
			local name, _, icon, count, _, duration, expirationTime, caster, _, _, spid = UnitBuff(data.unit, data.name)
			if name == data.name and caster == "player" then
				value = value * (1 + data.value)
			end
		elseif data.filter == "DEBUFF" then
			local name, _, icon, count, _, duration, expirationTime, caster, _, _, spid = UnitDebuff(data.unit, data.name)
			if name == data.name and caster == "player" then
				value = value * (1 + data.value)
			end
		end
	end
	
	local text = ("%.0f"):format(value * 100).."%"
	if UnitBuff("player", "大师刺客的决意") then
		text = text.."×2"
	end
	f.text:SetText(text)
end

f.eventFrame = CreateFrame("Frame", "SubHelper_Event", f)
f.eventFrame:RegisterEvent("UNIT_AURA")
f.eventFrame:SetScript("OnEvent", OnEvent)

local SpecWatch = CreateFrame("Frame") 
SpecWatch:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
SpecWatch:RegisterEvent("PLAYER_ENTERING_WORLD")
SpecWatch:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, arg4 ,arg5, ...)
	if GetSpecialization() ~= 3 then
		f.eventFrame:UnregisterEvent("UNIT_AURA")
		f:Hide()
	else
		f.eventFrame:RegisterEvent("UNIT_AURA")
		f:Show()
	end
end)

SlashCmdList["SUBHELPER"] = function(msg) 
	if msg:lower() == "" then
		print("subhelper reset 重置位置")
	elseif msg:lower() == "reset" then
		f:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
	end
end
SLASH_SUBHELPER1 = "/subhelper"
