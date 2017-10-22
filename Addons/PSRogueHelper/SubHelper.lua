if select(2, UnitClass("player")) ~= "ROGUE" then return end

local Gains = {
	{name = "终结技：刺骨", unit = "player", filter = "BUFF", valueIndex = 1},
	{name = "袖剑连击", unit = "player", filter = "BUFF", valueIndex = 1},
	{name = "死亡符记", unit = "player", filter = "BUFF", tooltipSize = true},
	{name = "潜行", unit = "player", filter = "BUFF", value = 0.12, talent = "2/1"},
	{name = "暗影之舞", unit = "player", filter = "BUFF", value = 0.12, talent = "2/1"},
	{name = "暗影之舞", unit = "player", filter = "BUFF", value = 0.3, talent = "6/1"},
	{name = "敏锐大师", unit = "player", filter = "BUFF", value = 0.1},
	{name = "夜刃", unit = "target", filter = "DEBUFF", value = 0.15},
	{name = "偷袭", unit = "target", filter = "DEBUFF", value = 0.1, talent = "5/2"},
	{name = "肾击", unit = "target", filter = "DEBUFF", value = 0.1, talent = "5/2"},
}

local function lua_string_split(str, split_char)
    local sub_str_tab = {};
    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

    return sub_str_tab;
end

local function SelectedTalent(talent)
	local talentInfo = lua_string_split(talent, "/")
	local tier, column = talentInfo[1], talentInfo[2]
	local talentID, name, texture, selected, available, spellid, tier, column, selectedIndex = GetTalentInfo(tier, column, 1)
	return selected
end

do
  local hiddenTooltip;
  function GetHiddenTooltip()
    if not(hiddenTooltip) then
      hiddenTooltip = CreateFrame("GameTooltip", "SubHelperTooltip", nil, "GameTooltipTemplate");
      hiddenTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
      hiddenTooltip:AddFontStrings(
        hiddenTooltip:CreateFontString("$parentTextLeft1", nil, "GameTooltipText"),
        hiddenTooltip:CreateFontString("$parentTextRight1", nil, "GameTooltipText")
      );
    end
    return hiddenTooltip;
  end
end

function GetAuraTooltipInfo(unit, spellName)
	local tooltip = GetHiddenTooltip()
	tooltip:SetUnitAura(unit, spellName);
	local debuffTypeLine, tooltipTextLine = select(11, tooltip:GetRegions())
	local tooltipText = tooltipTextLine and tooltipTextLine:GetObjectType() == "FontString" and tooltipTextLine:GetText() or "";

	local tooltipSize,_;
	if(tooltipText) then
		local n2
		_, _, tooltipSize, n2 = tooltipText:find("(%d+),(%d%d%d)")  -- Blizzard likes american digit grouping, e.g. "9123="9,123"   /mikk
		if tooltipSize then
		  tooltipSize = tooltipSize..n2
		else
		  _, _, tooltipSize = tooltipText:find("(%d+)")
		end
	end
	return tooltipText, tonumber(tooltipSize) or 0;
end

local f = CreateFrame("frame","SubHelper", UIParent)
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
f.text:SetFont(STANDARD_TEXT_FONT, SubHelperFontSize or 20, "OUTLINE")
f.text:SetAllPoints(f)
f.text:SetJustifyH('CENTER')

local function OnEvent(event, unit) 
	local percent = 1
	for i = 1, #Gains, 1 do
		local data = Gains[i]
		local values = {}
		local name, caster
		if data.filter == "BUFF" then
			name, rank, icon, count, dispelType, duration, expires, caster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, _, nameplateShowAll, timeMod, values[1], values[2], values[3], values[4] = UnitBuff(data.unit, data.name, nil, "PLAYER")
		elseif data.filter == "DEBUFF" then
			name, rank, icon, count, dispelType, duration, expires, caster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, _, nameplateShowAll, timeMod, values[1], values[2], values[3], values[4] = UnitDebuff(data.unit, data.name, nil, "PLAYER")
		end
		if name == data.name and caster == "player" then
			local contains = true
			if data.talent then
				contains = SelectedTalent(data.talent)
			end
			if contains then
				local value = data.value
				if data.valueIndex then
					value = tonumber(values[data.valueIndex])
					if value then
						value = value/100.0
					end
				elseif data.tooltipSize and not data.value then
					_, value = GetAuraTooltipInfo(data.unit, data.name)
					if value then 
						value = value/100.0
						data.value = value
					end
				end
				if value then
					percent = percent * (1 + value)
				end
			end
		end
	end
	
	f.text:SetTextColor(1, 1, 1, 1)
	local text = ("%.0f"):format(percent * 100).."%"
	if UnitBuff("player", "大师刺客的决意") then
		f.text:SetTextColor(1, 0.1, 0.1, 1)
	end
	f.text:SetText(text)
end

f.eventFrame = CreateFrame("Frame", "SubHelper_Event", f)
f.eventFrame:RegisterEvent("UNIT_AURA")
f.eventFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
f.eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
f.eventFrame:SetScript("OnEvent", OnEvent)

local SpecWatch = CreateFrame("Frame") 
SpecWatch:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
SpecWatch:RegisterEvent("PLAYER_ENTERING_WORLD")
SpecWatch:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
SpecWatch:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, arg4 ,arg5, ...)
	if GetSpecialization() ~= 3 then
		f.eventFrame:SetScript("OnEvent", function() end)
		f:Hide()
	else
		f.eventFrame:SetScript("OnEvent", OnEvent)
		f:Show()
	end
end)

local tooltipUpdateWatch = CreateFrame("Frame") 
tooltipUpdateWatch:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
tooltipUpdateWatch:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, arg4 ,arg5, ...)
	for i = 1, #Gains, 1 do
		local data = Gains[i]
		if data.tooltipSize then
			data.value = nil
		end
	end
end)

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_ENTERING_WORLD")
loader:SetScript("OnEvent", function()
	ChangeFont(SubHelperFontSize or 20)
	loader:UnregisterEvent("PLAYER_ENTERING_WORLD") 
end)

function ChangeFont(size)
	SubHelperFontSize = size
	local size = SubHelperFontSize or 20
	f:SetSize(size * 4 , size * 1.5)
	f.text:SetFont(STANDARD_TEXT_FONT, size, "OUTLINE")
end

SlashCmdList["SUBHELPER"] = function(msg) 
	if msg:lower() == "" then
		print("subhelper reset -> 重置")
		print("subhelper 字号  -> 修改字号")
	elseif msg:lower() == "reset" then
		ChangeFont(nil)
		f:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
	elseif tonumber(msg:lower()) then
		ChangeFont(tonumber(msg:lower()))
	end
end
SLASH_SUBHELPER1 = "/subhelper"
