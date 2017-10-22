-- LightCT by Alza
-- NDUI MOD

local fadeTime = 3						-- 文字消失时间
local fontType = DAMAGE_TEXT_FONT	-- 字体路径："Fonts\\xxx.ttf"
local fontSize = 20					-- 承受/输出框架字体大小
local infoFont = 20					-- 信息框架字体大小

local enable = true	-- 启用插件
local showHD = false	-- 显示HOT和DOT
local showPET = true	-- 显示宠物伤害/治疗

local hdSize = {200, 150}	-- 承受/输出框架大小
local ifSize = {300, 150}	-- 信息框架大小

local infoP = {"BOTTOM", UIParent, "CENTER", 0, 300}		-- 信息框架位置
local inputDP = {"CENTER", UIParent, "CENTER", -200, -70}		-- 承受伤害位置
local inputHP = {"CENTER", UIParent, "CENTER", -205, -70}		-- 承受治疗位置
local outputDP = {"BOTTOMLEFT", UIParent, "CENTER", 430, -25}		-- 输出伤害位置
local outputHP = {"TOPLEFT", UIParent, "CENTER", 430, -30}		-- 输出治疗位置

local frames = {}

local eventFilter = {
	["SWING_DAMAGE"] = {suffix = "DAMAGE", index = 12, iconType = "swing"},
	["RANGE_DAMAGE"] = {suffix = "DAMAGE", index = 15, iconType = "range"},
	["SPELL_DAMAGE"] = {suffix = "DAMAGE", index = 15, iconType = "spell"},
	["SPELL_PERIODIC_DAMAGE"] = {suffix = "DAMAGE", index = 15, iconType = "spell", isPeriod = true},

	["SPELL_HEAL"] = {suffix = "HEAL", index = 15, iconType = "spell"},
	["SPELL_PERIODIC_HEAL"] = {suffix = "HEAL", index = 15, iconType = "spell", isPeriod = true},

	["SWING_MISSED"] = {suffix = "MISS", index = 12, iconType = "swing"},
	["RANGE_MISSED"] = {suffix = "MISS", index = 15, iconType = "range"},
	["SPELL_MISSED"] = {suffix = "MISS", index = 15, iconType = "spell"},

	["SPELL_DISPEL"] = {suffix = "FAILED", index = 15, msg = "驱散"},
	["SPELL_STOLEN"] = {suffix = "FAILED", index = 15, msg = "偷取"},
	["SPELL_INTERRUPT"] = {suffix = "FAILED", index = 15, msg = "打断"},
}

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:SetScript("OnEvent", function(self, event, ...)
	if not enable then return end
	self[event](self, ...)
end)

local function FormatNumb(val)
	if type(val) == "number" then
		if val >= 1e8 then
			return ("%.2f亿"):format(val / 1e8)
		elseif val >= 1e4 then
			return ("%.1f万"):format(val / 1e4)
		else
			return ("%.0f"):format(val)
		end
	else
		return val
	end
end

local function GetFloatingIcon(iconType, spellID, isPet)
	local texture, icon
	if iconType == "spell" then
		texture = GetSpellTexture(spellID)
	elseif iconType == "swing" then
		if isPet then
			texture = PET_ATTACK_TEXTURE
		else
			texture = GetSpellTexture(6603)
		end
	elseif iconType == "range" then
		texture = GetSpellTexture(75)
	end
	local size = fontSize - 6
	icon = "|T"..texture..":"..size..":"..size..":0:-5:64:64:5:59:5:59|t"
	return icon
end

local function CreateCTFrame(name, justify, fontSize, framesize, point)
	local frame = CreateFrame("ScrollingMessageFrame", name, UIParent)

	frame:SetSpacing(5)
	frame:SetMaxLines(20)
	frame:SetSize(unpack(framesize))
	frame:SetFadeDuration(0.2)
	frame:SetJustifyH(justify)
	frame:SetTimeVisible(fadeTime)
	frame:SetFont(fontType, fontSize, "OUTLINE")
	frame:SetPoint(unpack(point))

	return frame
end

frames["Information"] = CreateCTFrame("Information", "CENTER", infoFont, ifSize, infoP)
frames["InputDamage"] = CreateCTFrame("InputDamage", "LEFT", fontSize, hdSize, inputDP)
frames["InputHealing"] = CreateCTFrame("InputHealing", "RIGHT", fontSize, hdSize, inputHP)
frames["OutputDamage"] = CreateCTFrame("OutputDamage", "LEFT", fontSize, hdSize, outputDP)
frames["OutputHealing"] = CreateCTFrame("OutputHealing", "LEFT", fontSize, hdSize, outputHP)

function eventFrame:PLAYER_LOGIN()
	SetCVar("enableFloatingCombatText", 0)
	SetCVar("floatingCombatTextCombatDamage", 1)
	SetCVar("floatingCombatTextCombatHealing", 0)
end

function eventFrame:PLAYER_REGEN_DISABLED(...)
	frames["Information"]:AddMessage("> "..ENTERING_COMBAT.." <", 1, 0, 0)
end

function eventFrame:PLAYER_REGEN_ENABLED(...)
	frames["Information"]:AddMessage("> "..LEAVING_COMBAT.." <", 0, 1, 0)
end

function eventFrame:COMBAT_LOG_EVENT_UNFILTERED(...)
	local icon, text, info, color, critMark, inputD, inputH, outputD, outputH, outputIF
	local _, eventType, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, _, spellID, spellName, school = ...

	local noPlayer = UnitGUID("player") ~= sourceGUID

	local isPlayer = UnitGUID("player") == sourceGUID
	local isVehicle = UnitGUID("vehicle") == sourceGUID
	local isPet = UnitGUID("pet") == sourceGUID and showPET

	local atPlayer = UnitGUID("player") == destGUID
	local atTarget = UnitGUID("target") == destGUID

	if ((isPlayer or isVehicle or isPet or noPlayer) and atTarget) or atPlayer then
		local value = eventFilter[eventType]
		if value then
			if value.suffix == "DAMAGE" then
				if value.isPeriod and not showHD then return end
				local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(value.index, ...)
				color = _G.CombatLog_Color_ColorArrayBySchool(school) or {r = 1, g = 1, b = 1}
				icon = GetFloatingIcon(value.iconType, spellID, isPet)
				if isPlayer or isVehicle or isPet then
					text = FormatNumb(amount)..icon
					--outputD = true		-- 输出伤害显示
					outputD = eventType ~= "SWING_DAMAGE"
				elseif atPlayer then
					text = "-"..FormatNumb(amount)..icon
					inputD = true		-- 承受伤害显示
				end
				if text and (critical or crushing) then
					text = "*"..text
				end
			elseif value.suffix == "HEAL" then
				if value.isPeriod and not showHD then return end
				local amount, overhealing, absorbed, critical = select(value.index, ...)
				color = _G.CombatLog_Color_ColorArrayBySchool(school) or {r = 1, g = 1, b = 1}
				icon = GetFloatingIcon(value.iconType, spellID, isPet)
				if isPlayer or isVehicle or isPet then
					text = FormatNumb(amount)..icon
					outputH = true		-- 输出治疗显示
				elseif atPlayer then
					text = "+"..FormatNumb(amount)..icon
					inputH = true		-- 承受治疗显示
				end
				if text and critical then
					text = "*"..text
				end
			elseif value.suffix == "MISS" then
				local missType, isOffHand, amountMissed = select(value.index, ...)
				color = _G.CombatLog_Color_ColorArrayBySchool(school) or {r = 1, g = 1, b = 1}
				text = _G["COMBAT_TEXT_"..missType]
				if isPlayer or isVehicle or isPet then
					outputD = true		-- 输出伤害MISS（招架、格挡、未命中等）显示
				elseif atPlayer then
					inputD = true		-- 承受伤害MISS（招架、格挡、未命中等）显示
				end
			elseif value.suffix == "FAILED" then
				local extraSpellID, extraSpellName, extraSchool = select(value.index, ...)
				local intName = GetSpellInfo(extraSpellID)
				color = _G.CombatLog_Color_ColorArrayBySchool(extraSchool) or {r = 1, g = 1, b = 1}
				if isPlayer or isVehicle or isPet then
					text = value.msg.." > "..intName
					outputIF = true		-- 自己的打断提示
				else
					text = sourceName..value.msg.." > "..intName
					outputIF = true		-- 他人的打断提示
				end
			end
		end

		if text then
			if outputD then
				frames["OutputDamage"]:AddMessage(text, color.r, color.g, color.b)
			elseif outputH then
				frames["OutputHealing"]:AddMessage(text, color.r, color.g, color.b)
			elseif inputD then
				frames["InputDamage"]:AddMessage(text, color.r, color.g, color.b)
			elseif inputH then
				frames["InputHealing"]:AddMessage(text, color.r, color.g, color.b)
			elseif outputIF then
				frames["Information"]:AddMessage(text, color.r, color.g, color.b)
			end
		end
	end
end