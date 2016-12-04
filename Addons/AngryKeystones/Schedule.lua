local ADDON, Addon = ...
local Mod = Addon:NewModule('Schedule')

local rowCount = 4

local requestKeystoneCheck

-- 1: Overflowing, 2: Skittish, 3: Volcanic, 4: Necrotic, 5: Teeming, 6: Raging, 7: Bolstering, 8: Sanguine, 9: Tyrannical, 10: Fortified
local affixSchedule = {
	{ 6, 4, 10 },
	{ 7, 1, 9 },
	{ 8, 3, 10 },
	{ 5, 4, 9 },
	{ 6, 3, 9 },
	{ 7, 2, 10 },
	{ 8, 1, 9 },
	{ 5, 2, 10 },
}
local currentWeek

local function UpdateAffixes()
	if requestKeystoneCheck then
		Mod:CheckInventoryKeystone()
	end
	if currentWeek then
		ChallengesFrame.GuildBest:ClearAllPoints()
		ChallengesFrame.GuildBest:SetPoint("TOPLEFT", ChallengesFrame.WeeklyBest.Child.Star, "BOTTOMRIGHT", 9, 0)
		Mod.Frame:Show()
		for i = 1, rowCount do
			local entry = Mod.Frame.Entries[i]

			local scheduleWeek = (currentWeek - 2 + i) % (#affixSchedule) + 1
			local affixes = affixSchedule[scheduleWeek]
			for j = 1, #affixes do
				local affix = entry.Affixes[j]
				affix:SetUp(affixes[j])
			end
		end
	else
		ChallengesFrame.GuildBest:ClearAllPoints()
		ChallengesFrame.GuildBest:SetPoint("TOPLEFT", ChallengesFrame.WeeklyBest.Child.Star, "BOTTOMRIGHT", -16, 10)
		Mod.Frame:Hide()
	end
end

local function makeAffix(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetSize(16, 16)

	local border = frame:CreateTexture(nil, "OVERLAY")
	border:SetAllPoints()
	border:SetAtlas("ChallengeMode-AffixRing-Sm")
	frame.Border = border

	local portrait = frame:CreateTexture(nil, "ARTWORK")
	portrait:SetSize(14, 14)
	portrait:SetPoint("CENTER", border)
	frame.Portrait = portrait

	frame.SetUp = ScenarioChallengeModeAffixMixin.SetUp
	frame:SetScript("OnEnter", ScenarioChallengeModeAffixMixin.OnEnter)
	frame:SetScript("OnLeave", GameTooltip_Hide)

	return frame
end

local function setupFrame()

	local frame = CreateFrame("Frame", nil, ChallengesFrame)
	frame:SetSize(206, 110)
	frame:SetPoint("TOP", ChallengesFrame.WeeklyBest.Child.Star, "BOTTOM", 0, 0)
	frame:SetPoint("LEFT", ChallengesFrame, "LEFT", 40, 0)
	Mod.Frame = frame

	local bg = frame:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetAtlas("ChallengeMode-guild-background")
	bg:SetAlpha(0.4)

	local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalMed2")
	title:SetText(Addon.Locale.scheduleTitle)
	title:SetPoint("TOPLEFT", 15, -7)

	local line = frame:CreateTexture(nil, "ARTWORK")
	line:SetSize(192, 9)
	line:SetAtlas("ChallengeMode-RankLineDivider", false)
	line:SetPoint("TOP", 0, -20)

	local entries = {}
	for i = 1, rowCount do
		local entry = CreateFrame("Frame", nil, frame)
		entry:SetSize(176, 18)

		local text = entry:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		text:SetWidth(120)
		text:SetJustifyH("LEFT")
		text:SetWordWrap(false)
		text:SetText( Addon.Locale["scheduleWeek"..i] )
		text:SetPoint("LEFT")
		entry.Text = text

		local affixes = {}
		local prevAffix
		for j = 3, 1, -1 do
			local affix = makeAffix(entry)
			if prevAffix then
				affix:SetPoint("RIGHT", prevAffix, "LEFT", -4, 0)
			else
				affix:SetPoint("RIGHT")
			end
			affix:Hide()
			prevAffix = affix
			affixes[j] = affix
		end
		entry.Affixes = affixes

		if i == 1 then
			entry:SetPoint("TOP", line, "BOTTOM")
		else
			entry:SetPoint("TOP", entries[i-1], "BOTTOM")
		end

		entries[i] = entry
	end
	frame.Entries = entries

	hooksecurefunc("ChallengesFrame_Update", UpdateAffixes)
end

function Mod:ADDON_LOADED(name)
	if name == 'Blizzard_ChallengesUI' then
		if setupFrame then
			setupFrame()
			setupFrame = nil
		end
	end
end

function Mod:CheckInventoryKeystone()
	currentWeek = nil
	for container=BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local slots = GetContainerNumSlots(container)
		for slot=1, slots do
			local _, _, _, _, _, _, slotLink, _, _, slotItemID = GetContainerItemInfo(container, slot)
			if slotItemID == 138019 then
				local itemString = slotLink:match("|Hitem:138019:([0-9:]+)|h(%b[])|h")
				local info = { strsplit(":", itemString) }
				local mapLevel = tonumber(info[14])
				if mapLevel >= 7 then
					local affix1, affix2 = tonumber(info[15]), tonumber(info[16])
					for index, affixes in ipairs(affixSchedule) do
						if affix1 == affixes[1] and affix2 == affixes[2] then
							currentWeek = index
						end
					end
				end
			end
		end
	end
	requestKeystoneCheck = false
end

function Mod:BAG_UPDATE()
	requestKeystoneCheck = true
end

function Mod:Startup()
	if ChallengesFrame then
		self:ADDON_LOADED("Blizzard_ChallengesUI")
	else
		self:RegisterEvent('ADDON_LOADED')
	end
	self:RegisterEvent('BAG_UPDATE')
	requestKeystoneCheck = true
end
