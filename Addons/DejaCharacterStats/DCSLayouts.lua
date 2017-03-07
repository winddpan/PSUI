--Elvis is the greatest!

local ADDON_NAME, namespace = ... 	--localization
local L = namespace.L 				--localization

DCS_ClassSpecDB = {}

local _, DCS_TableData = ...

local _, gdbprivate = ...
	gdbprivate.gdbdefaults.gdbdefaults.dejacharacterstatsScrollbarChecked = {
		ScrollbarSetChecked = false,
	}
	gdbprivate.gdbdefaults.gdbdefaults.dejacharacterstatsClassBackgroundChecked = {
		ClassBackgroundChecked = true,
	}

local StatScrollFrame = CreateFrame("ScrollFrame", nil, CharacterFrameInsetRight, "UIPanelScrollFrameTemplate")
	StatScrollFrame:ClearAllPoints()
	StatScrollFrame:SetPoint("TOPLEFT", CharacterFrameInsetRight, "TOPLEFT", 5, -6)
	StatScrollFrame:SetPoint("BOTTOMRIGHT", CharacterFrameInsetRight, "BOTTOMRIGHT", 0, 3)
	StatScrollFrame.ScrollBar:ClearAllPoints()
	StatScrollFrame.ScrollBar:SetPoint("TOPLEFT", StatScrollFrame, "TOPRIGHT", -16, -16)
	StatScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", StatScrollFrame, "BOTTOMRIGHT", -16, 16)
	StatScrollFrame.ScrollBar:Hide()
	
	StatScrollFrame:HookScript("OnScrollRangeChanged", function(self, xrange, yrange)
		local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsScrollbarChecked
		if checked.ScrollbarSetChecked == true then
			self.ScrollBar:SetShown(floor(yrange) ~= 0)
		elseif not checked.ScrollbarSetChecked == true then
			self.ScrollBar:Hide()
		end
	end)
	
	StatFrame = CreateFrame("Frame", nil, StatScrollFrame)
	StatFrame:SetWidth(191)
	StatFrame:SetPoint("TOPLEFT")
	StatFrame.AnchorFrame = CreateFrame("Frame", nil, StatFrame)
	StatFrame.AnchorFrame:SetSize(StatFrame:GetWidth(), 2)
	StatFrame.AnchorFrame:SetPoint("TOPLEFT")
	StatScrollFrame:SetScrollChild(StatFrame)

	CharacterStatsPane.ItemLevelFrame:SetParent(StatFrame)
	CharacterStatsPane.ItemLevelFrame.Value:SetFont(CharacterStatsPane.ItemLevelFrame.Value:GetFont(), 22, "THINOUTLINE")
	CharacterStatsPane.ItemLevelFrame.Value:SetPoint("CENTER",CharacterStatsPane.ItemLevelFrame.Background, "CENTER", 0, 1)

	CharacterStatsPane.AttributesCategory:SetParent(StatFrame)
	CharacterStatsPane.AttributesCategory:SetHeight(28)
	CharacterStatsPane.AttributesCategory.Background:SetHeight(28)

	CharacterStatsPane.ClassBackground:SetParent(StatScrollFrame)

	CharacterStatsPane.EnhancementsCategory:SetParent(StatFrame)
	CharacterStatsPane.EnhancementsCategory:SetHeight(28)
	CharacterStatsPane.EnhancementsCategory.Background:SetHeight(28)

local DefaultData = DCS_TableData:MergeTable({
    { statKey = "ItemLevelFrame" },
    { statKey = "AttributesCategory" },
        { statKey = "HEALTH" },
        { statKey = "DCS_POWER" },
        { statKey = "DCS_ALTERNATEMANA" },
        { statKey = "ARMOR" },
        { statKey = "STRENGTH" },
        { statKey = "AGILITY" },
        { statKey = "INTELLECT" },
        { statKey = "STAMINA" },
        { statKey = "ATTACK_DAMAGE" },
        { statKey = "ATTACK_AP" },
        { statKey = "DCS_ATTACK_ATTACKSPEED" },
		{ statKey = "WEAPON_DPS" },
        { statKey = "SPELLPOWER" },
        { statKey = "MANAREGEN" },
        { statKey = "ENERGY_REGEN" },
        { statKey = "DCS_RUNEREGEN" },
        { statKey = "FOCUS_REGEN" },		
        { statKey = "MOVESPEED" },
        { statKey = "GCD" },
		{ statKey = "DURABILITY_STAT" },
        { statKey = "REPAIR_COST" },
    { statKey = "EnhancementsCategory" },
        { statKey = "CRITCHANCE", hideAt = 0 },
		{ statKey = "HASTE", hideAt = 0 },
        { statKey = "VERSATILITY", hideAt = 0 },
        { statKey = "MASTERY", hideAt = 0 },
        { statKey = "LIFESTEAL", hideAt = 0 },
        { statKey = "AVOIDANCE", hideAt = 0 },
        { statKey = "DODGE", hideAt = 0 },
        { statKey = "PARRY", hideAt = 0 },
        { statKey = "BLOCK", hideAt = 0 },
		{ statKey = "CRITCHANCE_RATING", hideAt = 0 },
		{ statKey = "HASTE_RATING", hideAt = 0 },
		{ statKey = "VERSATILITY_RATING", hideAt = 0 },
		{ statKey = "MASTERY_RATING", hideAt = 0 },
		{ statKey = "LIFESTEAL_RATING", hideAt = 0 },
		{ statKey = "AVOIDANCE_RATING", hideAt = 0 },
		{ statKey = "DODGE_RATING", hideAt = 0 },
		{ statKey = "PARRY_RATING", hideAt = 0 },
        { statKey = "ITEMLEVEL", hidden = true },
})

local ShownData = DefaultData

for k, v in pairs(DCS_TableData.StatData) do
	if (not v.frame) then
		if (v.category) then
			v.frame = CreateFrame("FRAME", nil, StatFrame, "CharacterStatFrameCategoryTemplate")
		else
			v.frame = CreateFrame("FRAME", nil, StatFrame, "CharacterStatFrameTemplate")
		end
	end
	v.frame.statKey = k
end

local function UpdateStatFrameWidth(width)
	local stat
	for _, v in ipairs(ShownData) do
		stat = DCS_TableData.StatData[v.statKey]
		if (stat) then
			stat.frame:SetWidth(width)
			if (stat.frame.Background) then
				stat.frame.Background:SetWidth(width)
			end
		end
	end
end

	local DCS_TableRelevantStatstooltipText
	local relevantStatsSetChecked = true
	local function DCS_TableRelevantStats_init()
		if relevantStatsSetChecked then
			--print(checked)
			--print("Show Relevant Button")
			DCS_TableRelevantStatstooltipText = L["Show only stats relevant to your class spec."] --Creates a tooltip on mouseover.
			_G[DCS_TableRelevantStats:GetName() .. "Text"]:SetText(L["Relevant Stats"])
		else
			--print(checked)
			--print("Show All Button")
			DCS_TableRelevantStatstooltipText = L["Show all stats."] --Creates a tooltip on mouseover.
			_G[DCS_TableRelevantStats:GetName() .. "Text"]:SetText(L["All Stats"])
			return
		end
	end





-----------------------
-- Config Mode Setup --
-----------------------

local function set_relevant_stat_state()
	local stat
	local ccount = 0
	for _, v in ipairs(ShownData) do
        stat = DCS_TableData.StatData[v.statKey]
		if stat then
			if not v.hidden then ccount = ccount +1 end
		end
	end
	local temp = ccount/#ShownData
	--print(temp)
	--if gdbprivate.gdb.gdbdefaults.DCS_TableRelevantStatsChecked.RelevantStatsSetChecked then
	--	print("Wants to show Relevant Stats button")
	--else
	--	print("Wants to show All Stats button")
	--end
	if temp < 1 then --playing safe, probably 0.9 is sufficient; maybe epsilon check is needed?
	--	print("All Stats due to number of stats")
		relevantStatsSetChecked = false
	else
	--	print("Relevant Stats due to number of stats")
		relevantStatsSetChecked = true
	end
	DCS_TableRelevantStats_init()
end

local configMode = false

local function ShowCharacterStats(unit)
    local stat
    local count, backgroundcount, height = 0, false, 4
	local hideatzero = true --placeholder for the checkbox hideatzero
	local butshowstatifchecked = false --placeholder for the checkbox butshowstatifchecked
    for _, v in ipairs(ShownData) do
        stat = DCS_TableData.StatData[v.statKey]
		if stat then -- if some stat gets removed or if experimenting with adding stats
			stat.updateFunc(stat.frame, unit)
			if (configMode) then
				stat.frame:Show()
				stat.frame.checkButton:Show()
				stat.frame.checkButton:SetChecked(not v.hidden)
				if (v.hidden) then
					stat.frame:SetAlpha(0.32)
				else
					stat.frame:SetAlpha(1)
				end
			else
				if hideatzero and not butshowstatifchecked then
					if v.hideAt then
						if v.hideAt == stat.frame.numericValue then
							stat.frame:Hide()
						end
					end
				end
				if (v.hidden) then
					stat.frame:Hide()
				else
					if (stat.frame.checkButton) then
						stat.frame.checkButton:Hide()
					end
				end
			end
			if (stat.frame:IsShown()) then
				stat.frame:ClearAllPoints()
				stat.frame:SetPoint("TOPLEFT", StatFrame.AnchorFrame, "TOPLEFT", 0, -height)
				if (stat.category) then
					count = count + 2
				else
					count = count + 1
				end
				if (stat.category) then
					backgroundcount = false
				else
					stat.frame.Background:SetShown(backgroundcount)
					backgroundcount = not backgroundcount
				end
				if not (configMode) then
					stat.frame:SetAlpha(1)
				end
				height = height + stat.frame:GetHeight()
			end
			--print(count)
		end
		
	end
	height = floor(height)
	StatFrame:SetHeight(height)
	--local statheight = StatFrame:GetHeight()
	--local baseheight = CharacterFrameInsetRight:GetHeight()
	if count <= 24 then
		UpdateStatFrameWidth(191)
		StatScrollFrame.ScrollBar:Hide()
	else
		local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsScrollbarChecked
		if checked.ScrollbarSetChecked == true then
			UpdateStatFrameWidth(180)
			StatScrollFrame.ScrollBar:Show()
		else
			UpdateStatFrameWidth(191)
			StatScrollFrame.ScrollBar:Hide()
		end			
	end
	set_relevant_stat_state()
end


local function DCS_Table_ShowAllStats()
	for _, v in ipairs(ShownData) do
		--if v.hidden == true then v.hidden = false end
		v.hidden = false -- should be slightly faster because when this function gets called the most of stats are invisible
	end
	ShowCharacterStats("player")
end

local function DCS_Table_Relevant()
	local uniqueKey = UnitName("player") .. ":" .. GetRealmName() .. ":" .. GetSpecialization()
	--print(uniqueKey)
	--print("Select only relevant stats")
	--ShownData = DCS_TableData:CopyTable(DefaultData)

	for _, v in ipairs(ShownData) do
		if v.hidden then v.hidden = false end
	end 

	local spec = GetSpecialization();
		--print(spec)
	local role = GetSpecializationRole(spec)
		--print(role)
	local primaryStat = select(6, GetSpecializationInfo(spec, nil, nil, nil, UnitSex("player")));
		--print(primaryStat)
    for _, v in ipairs(ShownData) do
		--print (v.statKey, " ", v.hidden)
		--if v.statKey == 0 then v.hidden = true end
		if primaryStat ~= LE_UNIT_STAT_STRENGTH then
				--print("Not Strength")
			if v.statKey == "STRENGTH" then v.hidden = true end
			if v.statKey == "DCS_RUNEREGEN" then v.hidden = true end
		end
		if primaryStat ~= LE_UNIT_STAT_AGILITY then
				--print("Not Agility")
			if v.statKey == "AGILITY" then v.hidden = true end
			--if v.statKey == "ENERGY_REGEN" then v.hidden = true end
		end
		if primaryStat ~= LE_UNIT_STAT_INTELLECT then
				--print("Not intellect")
			if v.statKey == "INTELLECT" then v.hidden = true end
			if v.statKey == "SPELLPOWER" then v.hidden = true end
			if v.statKey == "MANAREGEN" then v.hidden = true end
		end
		if primaryStat == LE_UNIT_STAT_INTELLECT  then
		--if role ~= "TANK" and role ~="DAMAGER" then -- is this check even needed?
			if v.statKey == "ATTACK_DAMAGE" then v.hidden = true end
			if v.statKey == "ATTACK_AP" then v.hidden = true end
			if v.statKey == "DCS_ATTACK_ATTACKSPEED" then v.hidden = true end
			if v.statKey == "WEAPON_DPS" then v.hidden = true end
		--end
		end
		if role ~= "TANK" then
				--print("Not Tank")
			if v.statKey == "DODGE" then v.hidden = true end
			if v.statKey == "PARRY" then v.hidden = true end
			if v.statKey == "BLOCK" then v.hidden = true end
		end
		--visibility of ratings is off by default
		if v.statKey == "CRITCHANCE_RATING" then v.hidden = true end
		if v.statKey == "HASTE_RATING" then v.hidden = true end
		if v.statKey == "VERSATILITY_RATING" then v.hidden = true end
		if v.statKey == "MASTERY_RATING" then v.hidden = true end
		if v.statKey == "LIFESTEAL_RATING" then v.hidden = true end
		if v.statKey == "AVOIDANCE_RATING" then v.hidden = true end
		if v.statKey == "DODGE_RATING" then v.hidden = true end
		if v.statKey == "PARRY_RATING" then v.hidden = true end
		if v.statKey == "ITEMLEVEL" then v.hidden = true end
	end
	--gdbprivate.gdb.gdbdefaults.DCS_TableRelevantStatsChecked.RelevantStatsSetChecked = false
	ShownData.uniqueKey = uniqueKey
	DCS_ClassSpecDB[uniqueKey] = ShownData
	ShowCharacterStats("player")
end

local function DCS_Login_Initialization()
	ShownData = DCS_TableData:CopyTable(DefaultData)

	local uniqueKey = UnitName("player") .. ":" .. GetRealmName() .. ":" .. GetSpecialization()
	--print(uniqueKey)
	if (DCS_ClassSpecDB[uniqueKey]) then
		if (ShownData.uniqueKey ~= uniqueKey) then
		ShownData = DCS_TableData:MergeTable(DCS_ClassSpecDB[uniqueKey])
		--print("Set saved variables.")
		end
		ShowCharacterStats("player")
	else
		--print("Set default initialization")
		DCS_Table_Relevant()
	end
	--ShowCharacterStats("player") --DCS_Table_Relevant in the end calls it
end

local function DCS_Table_Reset()
	local uniqueKey = UnitName("player") .. ":" .. GetRealmName() .. ":" .. GetSpecialization()
	--print(uniqueKey)
	--print("reseting just order of stata")
	--ShownData = DCS_TableData:CopyTable(DefaultData)
	local temp = DCS_TableData:CopyTable(DefaultData)
	for _, v1 in ipairs(temp) do
		for _, v2 in ipairs(ShownData) do
			if v1.statKey == v2.statKey then
				v1.hidden = v2.hidden
			end
		end
	end
	ShownData = temp
	ShownData.uniqueKey = uniqueKey
	DCS_ClassSpecDB[uniqueKey] = ShownData
	--DCS_Table_ShowAllStats()
	ShowCharacterStats("player")
end


-------------------------
-- Drag 'n' Drop Stats --
-------------------------

local DragSourceFrame, DragTargetFrame

local function OnDragStart(self)
	if (not configMode) then return end
	DragSourceFrame = self
	local cursorX, cursorY = GetCursorPosition()
	local uiScale = UIParent:GetScale()
	local adjust = select(5, UIParent:GetPoint(2)) or 0
	self:StartMoving()
	self:ClearAllPoints()
	self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cursorX / uiScale, (cursorY-adjust) / uiScale)
end

local function OnDragStop(self)
	if (not configMode) then return end
	DragSourceFrame = false
	self:StopMovingOrSizing()
	local stat, dst
	for i, v in ipairs(ShownData) do
		stat = DCS_TableData.StatData[v.statKey]
		if (stat.frame.statKey ~= self.statKey and stat.frame:IsMouseOver()) then
			DCS_TableData:SwapStat(ShownData, self.statKey, v)
			break
		end
	end
	if (DragTargetFrame) then
		DragTargetFrame.anchorBar:Hide()
	end
	ShowCharacterStats("player")
end

local function onCheckClick(self)
	local checked = self:GetChecked()
	local statKey = self:GetParent().statKey
	if (checked) then
		self:GetParent():SetAlpha(1)
	else
		self:GetParent():SetAlpha(0.32)
	end
	for _, v in ipairs(ShownData) do
		if (v.statKey == statKey) then
			v.hidden = not checked
			break
		end
	end
	set_relevant_stat_state()
	--ShowCharacterStats("player") --seems a waste to call whole function
end

for k, v in pairs(DCS_TableData.StatData) do
	v.frame:SetMovable(true)
	v.frame:RegisterForDrag("LeftButton")
	v.frame:HookScript("OnDragStart", OnDragStart)
	v.frame:HookScript("OnDragStop", OnDragStop)
	v.frame.checkButton = CreateFrame("CheckButton", nil, v.frame, "UICheckButtonTemplate")
	v.frame.checkButton:SetSize(14, 14)
	v.frame.checkButton:SetPoint("LEFT", -1, 0)
	v.frame.checkButton:SetScript("OnClick", onCheckClick)
	v.frame.checkButton:Hide()
	v.frame.anchorBar = v.frame:CreateTexture(nil, "OVERLAY")
	v.frame.anchorBar:SetPoint("TOPLEFT", 0, 2)
	v.frame.anchorBar:SetPoint("TOPRIGHT", 0, -2)
	v.frame.anchorBar:SetColorTexture(1, 0.8, 0)
	v.frame.anchorBar:Hide()
end

StatScrollFrame:HookScript("OnUpdate", function(self, elasped)
	if (DragSourceFrame) then
		self.timer = (self.timer or 0) + elasped
		if (self.timer > 0.2) then
			local stat
			for i, v in ipairs(ShownData) do
				stat = DCS_TableData.StatData[v.statKey]
				if (stat.frame.statKey ~= DragSourceFrame.statKey and stat.frame:IsMouseOver()) then
					DragTargetFrame = stat.frame
					stat.frame.anchorBar:Show()
				else
					stat.frame.anchorBar:Hide()
				end
			end
			self.timer = 0
		end
	end
end)


---------------------
-- Show/Hide Logic --
---------------------

CharacterStatsPane:HookScript("OnShow", function(self)
	self:Hide()
	StatScrollFrame:Show()
end)

hooksecurefunc("PaperDollFrame_UpdateStats", function()
	ShowCharacterStats("player")
end)

hooksecurefunc("PaperDollFrame_SetSidebar", function(self, index)
	if (PaperDollFrame.currentSideBar and PaperDollFrame.currentSideBar:GetName() == "CharacterStatsPane") then
		StatScrollFrame:Show()
	else
		StatScrollFrame:Hide()
	end
end)


------------------------
-- Relevant Stats Button --
------------------------

local function DCS_TableRelevantStats_OnEnter(self)
	GameTooltip:SetOwner(DCS_TableRelevantStats, "ANCHOR_RIGHT");
	GameTooltip:SetText(DCS_TableRelevantStatstooltipText, 1, 1, 1, 1, true)
	GameTooltip:Show()
end

local function DCS_TableRelevantStats_OnLeave(self)
	GameTooltip_Hide()
 end
 
local DCS_TableRelevantStats = CreateFrame("Button", "DCS_TableRelevantStats", CharacterFrameInsetRight, "UIPanelButtonTemplate")
	DCS_TableRelevantStats:RegisterEvent("ADDON_LOADED")
	DCS_TableRelevantStats:RegisterEvent("PLAYER_TALENT_UPDATE")
	DCS_TableRelevantStats:ClearAllPoints()
	DCS_TableRelevantStats:SetPoint("BOTTOMRIGHT", -130,-36)
	DCS_TableRelevantStats:SetScale(0.80)
	DCS_TableRelevantStats:Hide()

--local LOCALE = GetLocale() --Debugging code
--print (LOCALE)
	--if (LOCALE == "ptBR" or LOCALE == "frFR" or LOCALE == "deDE") then
		--print ("ptBR, frFR, deDE = 175")
	--LOCALE = 175
	--else
	--print ("enUS = 125")
	--LOCALE = 125
	--end
	--LOCALE = 175
	--DCS_TableRelevantStats:SetWidth(LOCALE)

	DCS_TableRelevantStats:SetWidth(125)
	DCS_TableRelevantStats:SetHeight(30)

	DCS_TableRelevantStats:SetScript("OnEnter", DCS_TableRelevantStats_OnEnter)
	DCS_TableRelevantStats:SetScript("OnLeave", DCS_TableRelevantStats_OnLeave)

	DCS_TableRelevantStats:SetScript("OnClick", function(self, button, up)
		if relevantStatsSetChecked then
			--print(checked)
			DCS_Table_Relevant()
			--print("Show All Button")
			--DCS_TableRelevantStatstooltipText = L["Show all stats."] --Creates a tooltip on mouseover.
			--_G[DCS_TableRelevantStats:GetName() .. "Text"]:SetText(L["All Stats"])
			--gdbprivate.gdb.gdbdefaults.DCS_TableRelevantStatsChecked.RelevantStatsSetChecked = false
		--return
		--end
		else
		--if checked == false then
			--print(checked)
			DCS_Table_ShowAllStats()
			--print("Show Relevant Button")
			--DCS_TableRelevantStatstooltipText = L["Show only stats relevant to your class spec."] --Creates a tooltip on mouseover.
			--_G[DCS_TableRelevantStats:GetName() .. "Text"]:SetText(L["Relevant Stats"])
			--gdbprivate.gdb.gdbdefaults.DCS_TableRelevantStatsChecked.RelevantStatsSetChecked = true
		--return
		end
		DCS_TableRelevantStats_OnEnter()
	end)

	DCS_TableRelevantStats:SetScript("OnEvent", function(self, event, ...)

		if event == "ADDON_LOADED" or event == "PLAYER_TALENT_UPDATE" then
			if IsLoggedIn() then
				DCS_Login_Initialization()
				DCS_TableRelevantStats_init()
			end
		end
	end)

------------------------
-- Reset Stats Button --
------------------------

local DCS_TableResetCheck = CreateFrame("Button", "DCS_TableResetButton", CharacterFrameInsetRight, "UIPanelButtonTemplate")
	DCS_TableResetCheck:ClearAllPoints()
	DCS_TableResetCheck:SetPoint("BOTTOMRIGHT", 5, -36)
	DCS_TableResetCheck:SetScale(0.80)
	DCS_TableResetCheck:Hide()

--local LOCALE = GetLocale()
--print (LOCALE)
	--if (LOCALE == "ptBR" or LOCALE == "frFR" or LOCALE == "deDE") then
		--print ("ptBR, frFR, deDE = 175")
	--LOCALE = 175
	--else
	--print ("enUS = 125")
	--LOCALE = 125
	--end
	--DCS_TableResetCheck:SetWidth(LOCALE)
	DCS_TableResetCheck:SetWidth(125)
	DCS_TableResetCheck:SetHeight(30)
	DCS_TableResetCheck.tooltipText = L["Resets order of stats."] --Creates a tooltip on mouseover. --needs to be localised
	_G[DCS_TableResetCheck:GetName() .. "Text"]:SetText(L["Reset Stats"]) -- somehow now the name seems wrong

	DCS_TableResetCheck:SetScript("OnClick", function(self, button, down)
		DCS_Table_Reset()
		--print("Show Relevant Button")
		--DCS_TableRelevantStatstooltipText = L["Show only stats relevant to your class spec."] --Creates a tooltip on mouseover.
		--_G[DCS_TableRelevantStats:GetName() .. "Text"]:SetText(L["Relevant Stats"])
		--gdbprivate.gdb.gdbdefaults.DCS_TableRelevantStatsChecked.RelevantStatsSetChecked = true
		--print("true")
	end)


------------------------
-- Config Mode Toggle --
------------------------

local DCS_ConfigtooltipText = L["Unlock DCS"]

local function set_config_mode(state)
	configMode = state
	if state then --on
		DCS_ConfigtooltipText = L["Lock DCS"]
		DCS_TableResetCheck:Show()
		DCS_TableRelevantStats:Show()
	else --off
		DCS_ConfigtooltipText = L["Unlock DCS"]
		DCS_TableRelevantStats:Hide()
		DCS_TableResetCheck:Hide()
	end
end

local DCS_configButton = CreateFrame("Button", "DCS_configButton", PaperDollSidebarTab1)
	DCS_configButton:SetSize(32, 32)
	DCS_configButton:SetPoint("BOTTOMLEFT", PaperDollSidebarTab1, "BOTTOMLEFT", 96, 34)
	DCS_configButton:SetNormalTexture("Interface\\Buttons\\LockButton-Locked-Up")
	DCS_configButton:SetPushedTexture("Interface\\Buttons\\LockButton-Unlocked-Down")
	DCS_configButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")

local function DCS_configButton_OnEnter(self)
	GameTooltip:SetOwner(DCS_configButton, "ANCHOR_RIGHT");
	GameTooltip:SetText(DCS_ConfigtooltipText, 1, 1, 1, 1, true)
	GameTooltip:Show()
end

local function DCS_configButton_OnLeave(self)
	GameTooltip_Hide()
 end
 
	DCS_configButton:SetScript("OnEnter", DCS_configButton_OnEnter)
	DCS_configButton:SetScript("OnLeave", DCS_configButton_OnLeave)

local function dcsRStatConfigButtonsHide()
	DCS_TableRelevantStats:ClearAllPoints()
	DCS_TableRelevantStats:SetParent(UIParent)
	DCS_TableRelevantStats:SetPoint("BOTTOMRIGHT", UIParent, "TOPLEFT", -100, 100)

	DCS_TableResetCheck:ClearAllPoints()
	DCS_TableResetCheck:SetParent(UIParent)
	DCS_TableResetCheck:SetPoint("BOTTOMRIGHT", UIParent, "TOPLEFT", -100, 100)
end
local function configButtonOnClose()
	StatScrollFrame:SetVerticalScroll(0)
	set_config_mode(false)
	dcsRStatConfigButtonsHide()

	DCS_configButton:SetNormalTexture("Interface\\Buttons\\LockButton-Locked-Up")
	DCS_InterfaceOptConfigButton:SetNormalTexture("Interface\\Buttons\\LockButton-Locked-Up")
	ShowCharacterStats("player")
end

local function DCS_ClassCrestBGCheck()
	if DCS_ClassBackgroundCheck:GetChecked(true) then
		CharacterStatsPane.ClassBackground:Show() 
	else
		CharacterStatsPane.ClassBackground:Hide()
	end
end
	
local function DCS_DefaultStatsAnchors()
	--configMode = false --seems like those four lines are not needed. Leaving incase they ARE needed
	--DCS_ConfigtooltipText = L["Unlock DCS"] 
	--DCS_TableResetCheck:Hide()
	--DCS_TableRelevantStats:Hide()
	StatScrollFrame:ClearAllPoints()
	StatScrollFrame:SetParent(CharacterFrameInsetRight)
	StatScrollFrame:SetPoint("TOPLEFT", CharacterFrameInsetRight, "TOPLEFT", 5, -6)
	StatScrollFrame:SetPoint("BOTTOMRIGHT", CharacterFrameInsetRight, "BOTTOMRIGHT", 0, 3)

	StatScrollFrame.ScrollBar:ClearAllPoints()
	StatScrollFrame.ScrollBar:SetParent(StatScrollFrame)
	StatScrollFrame.ScrollBar:SetPoint("TOPLEFT", StatScrollFrame, "TOPRIGHT", -16, -16)
	StatScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", StatScrollFrame, "BOTTOMRIGHT", -16, 16)
	StatScrollFrame.ScrollBar:Hide()

	CharacterStatsPane.ClassBackground:ClearAllPoints()
	CharacterStatsPane.ClassBackground:SetParent(StatScrollFrame)
	CharacterStatsPane.ClassBackground:SetPoint("TOP", StatScrollFrame, "TOP", -2.50, 3)
	
	configButtonOnClose()
	DCS_ClassCrestBGCheck()
	ShowCharacterStats("player")
end

local function DCS_InterfaceOptionsStatsAnchors()
	if (DejaCharacterStatsPanel~=nil) then
		set_config_mode(true)
				
		StatScrollFrame:ClearAllPoints()
		StatScrollFrame:SetParent(DejaCharacterStatsPanel)
		StatScrollFrame:SetPoint("TOPLEFT", DejaCharacterStatsPanel, "TOPLEFT", 380, -80)
		StatScrollFrame:SetPoint("BOTTOMRIGHT", DejaCharacterStatsPanel, "BOTTOMRIGHT", -50, 126)
		StatScrollFrame:Show()

		StatScrollFrame.ScrollBar:ClearAllPoints()
		StatScrollFrame.ScrollBar:SetParent(StatScrollFrame)
		StatScrollFrame.ScrollBar:SetPoint("TOPLEFT", StatScrollFrame, "TOPRIGHT", -15, -16)
		StatScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", StatScrollFrame, "BOTTOMRIGHT", -15, 16)
		StatScrollFrame.ScrollBar:Hide()

		DCS_TableRelevantStats:ClearAllPoints()
		DCS_TableRelevantStats:SetParent(StatScrollFrame)
		DCS_TableRelevantStats:SetPoint("BOTTOMRIGHT", -122,-42)

		DCS_TableResetCheck:ClearAllPoints()
		DCS_TableResetCheck:SetParent(StatScrollFrame)
		DCS_TableResetCheck:SetPoint("BOTTOMRIGHT", 3, -42)

		CharacterStatsPane.ClassBackground:ClearAllPoints()
		CharacterStatsPane.ClassBackground:SetParent(DejaCharacterStatsPanel)
		CharacterStatsPane.ClassBackground:SetPoint("TOPLEFT", DejaCharacterStatsPanel, "TOPLEFT", 377, -80)
		CharacterStatsPane.ClassBackground:SetPoint("BOTTOMRIGHT", DejaCharacterStatsPanel, "BOTTOMRIGHT", -48, 126)
		CharacterStatsPane.ClassBackground:Show()

		DCS_ClassCrestBGCheck()
		ShowCharacterStats("player")
	end
end	
	
CharacterFrameInsetRight:HookScript("OnShow", function(self)
	DCS_DefaultStatsAnchors()
end)

CharacterFrameInsetRight:HookScript("OnHide", function(self)
	if InterfaceOptionsFrame:IsShown() then
		DCS_InterfaceOptionsStatsAnchors()
	else
		CharacterFrameInsetRightScrollBar:SetValue(0)
	
		StatScrollFrame:ClearAllPoints()
		StatScrollFrame:SetParent(UIParent)
		StatScrollFrame:SetPoint("BOTTOMRIGHT", UIParent, "TOPLEFT", -100, 100)
		StatScrollFrame:Hide()

		StatScrollFrame.ScrollBar:ClearAllPoints()
		StatScrollFrame.ScrollBar:SetParent(UIParent)
		StatScrollFrame.ScrollBar:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -160, 160)
		StatScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", UIParent, "TOPLEFT", -160, 160)
		StatScrollFrame.ScrollBar:Hide()

		DCS_TableRelevantStats:Hide() 	--For some reason these two have to be hidden again even tho they are hidden with configButtonOnClose() below.
		DCS_TableResetCheck:Hide()		--For some reason these two have to be hidden again even tho they are hidden with configButtonOnClose() below.

		CharacterStatsPane.ClassBackground:ClearAllPoints()
		CharacterStatsPane.ClassBackground:SetParent(UIParent)
		CharacterStatsPane.ClassBackground:SetPoint("BOTTOMRIGHT", UIParent, "TOPLEFT", 0, 0)
		CharacterStatsPane.ClassBackground:Show()

		configButtonOnClose()
	end
end)

	DCS_configButton:SetScript("OnMouseUp", function(self, button, up)
		configMode = not configMode
		if (configMode) then
			self:SetNormalTexture("Interface\\Buttons\\LockButton-Unlocked-Up")
			
			DCS_TableRelevantStats:ClearAllPoints()
			DCS_TableRelevantStats:SetParent(CharacterFrameInsetRight)
			DCS_TableRelevantStats:SetPoint("BOTTOMRIGHT", -130,-36)

			DCS_TableResetCheck:ClearAllPoints()
			DCS_TableResetCheck:SetParent(CharacterFrameInsetRight)
			DCS_TableResetCheck:SetPoint("BOTTOMRIGHT", 5, -36)
			
			set_config_mode(true)
		else
			configButtonOnClose()
		end
		ShowCharacterStats("player")
		DCS_configButton_OnEnter()
	end)

	
------------------------------------------
-- Interface Options Config Mode Toggle --
------------------------------------------

local DCS_InterfaceOptConfigButton = CreateFrame("Button", "DCS_InterfaceOptConfigButton", DejaCharacterStatsPanel)
	DCS_InterfaceOptConfigButton:RegisterEvent("PLAYER_LOGIN")
	DCS_InterfaceOptConfigButton:ClearAllPoints()
	DCS_InterfaceOptConfigButton:SetPoint("TOPRIGHT", 0, 29)
	DCS_InterfaceOptConfigButton:SetSize(36, 36)
	DCS_InterfaceOptConfigButton:SetScale(1.25)
	DCS_InterfaceOptConfigButton:SetNormalTexture("Interface\\Buttons\\LockButton-Locked-Up")
	DCS_InterfaceOptConfigButton:SetPushedTexture("Interface\\Buttons\\LockButton-Unlocked-Down")
	DCS_InterfaceOptConfigButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	
local function DCS_InterfaceOptConfigButton_OnEnter(self)
	GameTooltip:SetOwner(DCS_InterfaceOptConfigButton, "ANCHOR_RIGHT");
	GameTooltip:SetText(DCS_ConfigtooltipText, 1, 1, 1, 1, true)
	GameTooltip:Show()
end

local function DCS_InterfaceOptConfigButton_OnLeave(self)
	GameTooltip_Hide()
 end
 
	DCS_InterfaceOptConfigButton:SetScript("OnEnter", DCS_InterfaceOptConfigButton_OnEnter)
	DCS_InterfaceOptConfigButton:SetScript("OnLeave", DCS_InterfaceOptConfigButton_OnLeave)

	DCS_InterfaceOptConfigButton:SetScript("OnMouseUp", function(self, button, up)
		configMode = not configMode
		if (configMode) then
			self:SetNormalTexture("Interface\\Buttons\\LockButton-Unlocked-Up")
			set_config_mode(true)
		else
			self:SetNormalTexture("Interface\\Buttons\\LockButton-Locked-Up")
			set_config_mode(false)
		end
		ShowCharacterStats("player")
		DCS_InterfaceOptConfigButton_OnEnter()
	end)


----------------------------
-- Scrollbar Check Button --
----------------------------

local DCS_ScrollbarCheck = CreateFrame("CheckButton", "DCS_ScrollbarCheck", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ScrollbarCheck:RegisterEvent("PLAYER_LOGIN")
	DCS_ScrollbarCheck:ClearAllPoints()
	DCS_ScrollbarCheck:SetPoint("LEFT", 25, -175)
	DCS_ScrollbarCheck:SetScale(1.25)
	DCS_ScrollbarCheck.tooltipText = L["Displays the DCS scrollbar."] --Creates a tooltip on mouseover.
	_G[DCS_ScrollbarCheck:GetName() .. "Text"]:SetText(L["Scrollbar"])
	
	DCS_ScrollbarCheck:SetScript("OnEvent", function(self, event, arg1)
		if event == "PLAYER_LOGIN" then
			local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsScrollbarChecked
			self:SetChecked(checked.ScrollbarSetChecked)
			--Logic is built into ShowCharacterStats("player")
		end
		DCS_ScrollbarCheck:UnregisterAllEvents();
        ShowCharacterStats("player")
	end)

	DCS_ScrollbarCheck:SetScript("OnClick", function(self,event,arg1) 
		local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsScrollbarChecked
		if self:GetChecked(true) then
			--Show/Hide Logic is built into ShowCharacterStats("player")
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsScrollbarChecked.ScrollbarSetChecked = true
		else
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsScrollbarChecked.ScrollbarSetChecked = false
		end		
        ShowCharacterStats("player")
	end)


-----------------------------------
-- Class Background Check Button --
-----------------------------------

local DCS_ClassBackgroundCheck = CreateFrame("CheckButton", "DCS_ClassBackgroundCheck", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ClassBackgroundCheck:RegisterEvent("PLAYER_LOGIN")
	DCS_ClassBackgroundCheck:ClearAllPoints()
	DCS_ClassBackgroundCheck:SetPoint("TOPLEFT", 25, -120)
	DCS_ClassBackgroundCheck:SetScale(1.25)
	DCS_ClassBackgroundCheck.tooltipText = L["Displays the class crest background."] --Creates a tooltip on mouseover.
	_G[DCS_ClassBackgroundCheck:GetName() .. "Text"]:SetText(L["Class Crest Background"])
	
	DCS_ClassBackgroundCheck:SetScript("OnEvent", function(self, event, arg1)
		if event == "PLAYER_LOGIN" then
		local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsClassBackgroundChecked
			self:SetChecked(checked.ClassBackgroundChecked)
			if self:GetChecked(true) then
				CharacterStatsPane.ClassBackground:Show() 
				gdbprivate.gdb.gdbdefaults.dejacharacterstatsClassBackgroundChecked.ClassBackgroundChecked = true
			else
				CharacterStatsPane.ClassBackground:Hide() 
				gdbprivate.gdb.gdbdefaults.dejacharacterstatsClassBackgroundChecked.ClassBackgroundChecked = false
			end
		end
		DCS_ClassBackgroundCheck:UnregisterAllEvents();
	end)

	DCS_ClassBackgroundCheck:SetScript("OnClick", function(self,event,arg1) 
		local checked = gdbprivate.gdb.gdbdefaults.dejacharacterstatsClassBackgroundChecked
		if self:GetChecked(true) then
			CharacterStatsPane.ClassBackground:Show() 
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsClassBackgroundChecked.ClassBackgroundChecked = true
		else
			CharacterStatsPane.ClassBackground:Hide() 
			gdbprivate.gdb.gdbdefaults.dejacharacterstatsClassBackgroundChecked.ClassBackgroundChecked = false
		end		
        ShowCharacterStats("player")
	end)

InterfaceOptionsFrame:HookScript("OnShow", function(self)
	DCS_InterfaceOptionsStatsAnchors()
end)

InterfaceOptionsFrame:HookScript("OnHide", function(self)
	DCS_DefaultStatsAnchors()
end)