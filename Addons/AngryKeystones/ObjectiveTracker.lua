local ADDON, Addon = ...
local Mod = Addon:NewModule('ObjectiveTracker')

local TIME_FOR_3 = 0.6
local TIME_FOR_2 = 0.8

local function timeFormat(seconds)
	local hours = floor(seconds / 3600)
	local minutes = floor((seconds / 60) - (hours * 60))
	seconds = seconds - hours * 3600 - minutes * 60

	if hours == 0 then
		return format("%d:%.2d", minutes, seconds)
	else
		return format("%d:%.2d:%.2d", hours, minutes, seconds)
	end
end

local function timeFormatMS(timeAmount)
	local seconds = floor(timeAmount / 1000)
	local ms = timeAmount - seconds * 1000
	local hours = floor(seconds / 3600)
	local minutes = floor((seconds / 60) - (hours * 60))
	seconds = seconds - hours * 3600 - minutes * 60

	if hours == 0 then
		return format("%d:%.2d.%.3d", minutes, seconds, ms)
	else
		return format("%d:%.2d:%.2d.%.3d", hours, minutes, seconds. ms)
	end
end

local function Deaths_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(DEATHS, HIGHLIGHT_FONT_COLOR:GetRGB())

	local list = {}
	local deathsCount = 0
	for unit,count in pairs(Addon.ProgressTracker.playerDeaths) do
		local _, class = UnitClass(unit)
		deathsCount = deathsCount + count
		table.insert(list, { count = count, unit = unit, class = class })
	end
	table.sort(list, function(a, b)
		if a.count ~= b.count then
			return a.count > b.count
		else
			return a.unit < b.unit
		end
	end)

	for _,item in ipairs(list) do
		local color = RAID_CLASS_COLORS[item.class] or HIGHLIGHT_FONT_COLOR
		GameTooltip:AddDoubleLine(item.unit, item.count, color.r, color.g, color.b, HIGHLIGHT_FONT_COLOR:GetRGB())
	end
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(Addon.Locale.timeLost, timeFormat(deathsCount*5))

	GameTooltip:Show()
end

local function Deaths_OnLeave()
	GameTooltip:Hide()
end

local function GetTimerFrame(block)
	if not block.TimerFrame then
		local TimerFrame = CreateFrame("Frame", nil, block)
		TimerFrame:SetAllPoints(block)
		
		TimerFrame.Text = TimerFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
		TimerFrame.Text:SetPoint("LEFT", block.TimeLeft, "RIGHT", 4, 0)
		
		TimerFrame.Text2 = TimerFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
		TimerFrame.Text2:SetPoint("LEFT", TimerFrame.Text, "RIGHT", 4, 0)

		TimerFrame.Bar3 = TimerFrame:CreateTexture(nil, "OVERLAY")
		TimerFrame.Bar3:SetPoint("TOPLEFT", block.StatusBar, "TOPLEFT", block.StatusBar:GetWidth() * (1 - TIME_FOR_3) - 4, 0)
		TimerFrame.Bar3:SetSize(8, 10)
		TimerFrame.Bar3:SetTexture("Interface\\Addons\\AngryKeystones\\bar")
		TimerFrame.Bar3:SetTexCoord(0, 0.5, 0, 1)

		TimerFrame.Bar2 = TimerFrame:CreateTexture(nil, "OVERLAY")
		TimerFrame.Bar2:SetPoint("TOPLEFT", block.StatusBar, "TOPLEFT", block.StatusBar:GetWidth() * (1 - TIME_FOR_2) - 4, 0)
		TimerFrame.Bar2:SetSize(8, 10)
		TimerFrame.Bar2:SetTexture("Interface\\Addons\\AngryKeystones\\bar")
		TimerFrame.Bar2:SetTexCoord(0.5, 1, 0, 1)

		TimerFrame.DeathsFrame = CreateFrame("Frame", nil, TimerFrame)
		TimerFrame.DeathsFrame:SetSize(32, 16)
		TimerFrame.DeathsFrame:SetScript("OnEnter", Deaths_OnEnter)
		TimerFrame.DeathsFrame:SetScript("OnLeave", Deaths_OnLeave)
		TimerFrame.DeathsFrame:SetPoint("BOTTOMRIGHT", TimerFrame, "BOTTOMRIGHT", -27, 27)

		TimerFrame.DeathsText = TimerFrame.DeathsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		TimerFrame.DeathsText:SetPoint("RIGHT", TimerFrame.DeathsFrame, "RIGHT", 0, 0)
		TimerFrame.DeathsText:Show()

		TimerFrame.DeathsIcon = TimerFrame.DeathsFrame:CreateTexture(nil, "OVERLAY")
		TimerFrame.DeathsIcon:SetPoint("RIGHT", TimerFrame.DeathsText, "LEFT", 0, 0)
		TimerFrame.DeathsIcon:SetSize(16, 16)
		TimerFrame.DeathsIcon:SetTexture("Interface\\Minimap\\POIIcons")
		TimerFrame.DeathsIcon:SetTexCoord( GetPOITextureCoords(8) )
		TimerFrame.DeathsIcon:Show()

		TimerFrame:Show()

		block.TimerFrame = TimerFrame
	end
	return block.TimerFrame
end

function UpdatePlayerDeaths(block)
	local TimerFrame = GetTimerFrame(block)

	local deathsCount = 0
	for unit,count in pairs(Addon.ProgressTracker.playerDeaths) do
		deathsCount = deathsCount + count
	end
	if Addon.Config.deathTracker and deathsCount > 0 then
		TimerFrame.DeathsFrame:Show()
		TimerFrame.DeathsText:SetText(deathsCount)
	else
		TimerFrame.DeathsFrame:Hide()
	end
end

local function UpdateTime(block, elapsedTime)
	local TimerFrame = GetTimerFrame(block)

	local time3 = block.timeLimit * TIME_FOR_3
	local time2 = block.timeLimit * TIME_FOR_2

	TimerFrame.Bar3:SetShown(elapsedTime < time3)
	TimerFrame.Bar2:SetShown(elapsedTime < time2)

	if elapsedTime <= time3 then
		TimerFrame.Text:SetText( timeFormat(time3 - elapsedTime) )
		TimerFrame.Text:SetTextColor(1, 0.843, 0)
		TimerFrame.Text:Show()
		if Addon.Config.silverGoldTimer then
			TimerFrame.Text2:SetText( timeFormat(time2 - elapsedTime) )
			TimerFrame.Text2:SetTextColor(0.78, 0.78, 0.812)
			TimerFrame.Text2:Show()
		else
			TimerFrame.Text2:Hide()
		end
	elseif elapsedTime <= time2 then
		TimerFrame.Text:SetText( timeFormat(time2 - elapsedTime) )
		TimerFrame.Text:SetTextColor(0.78, 0.78, 0.812)
		TimerFrame.Text:Show()
		TimerFrame.Text2:Hide()
	else
		TimerFrame.Text:Hide()
		TimerFrame.Text2:Hide()
	end

	if elapsedTime > block.timeLimit then
		block.TimeLeft:SetText(GetTimeStringFromSeconds(elapsedTime - block.timeLimit, false, true))
	end

	UpdatePlayerDeaths(block)
end

local function SetUpAffixes(block, affixes)
	local frameWidth, spacing, distance
	if Addon.Config.smallAffixes then
		frameWidth, spacing, distance = 24, 3, -17
	else
		frameWidth, spacing, distance = 34, 4, -20
	end
	local num = #affixes
	local leftPoint = 28 + (spacing * (num - 1)) + (frameWidth * num)
	block.Affixes[1]:SetPoint("TOPLEFT", block, "TOPRIGHT", -leftPoint, distance)

	for i,affix in pairs(block.Affixes) do
		affix:SetSize(frameWidth, frameWidth)
		affix.Portrait:SetSize(frameWidth - 2, frameWidth - 2)
	end
end

hooksecurefunc("Scenario_ChallengeMode_UpdateTime", UpdateTime)
hooksecurefunc("Scenario_ChallengeMode_SetUpAffixes", SetUpAffixes)

function Mod:UpdatePlayerDeaths()
	UpdatePlayerDeaths(ScenarioChallengeModeBlock)
end

function Mod:CHALLENGE_MODE_COMPLETED()
	if not Addon.Config.completionMessage then return end

	local mapID, level, time, onTime, keystoneUpgradeLevels = C_ChallengeMode.GetCompletionInfo()
	-- mapID = 1458
	local name, _, timeLimit = C_ChallengeMode.GetMapInfo(mapID)
	-- time = timeLimit * 0.95
	-- onTime = time <= timeLimit

	timeLimit = timeLimit * 1000
	local timeLimit2 = timeLimit * TIME_FOR_2
	local timeLimit3 = timeLimit * TIME_FOR_3

	if time <= timeLimit3 then
		print( format("|cff33ff99<%s>|r |cffffd700%s|r", ADDON, format(Addon.Locale.completion3, name, timeFormatMS(time), timeFormatMS(timeLimit3 - time))) )
	elseif time <= timeLimit2 then
		print( format("|cff33ff99<%s>|r |cffc7c7cf%s|r", ADDON, format(Addon.Locale.completion2, name, timeFormatMS(time), timeFormatMS(timeLimit2 - time), timeFormatMS(time - timeLimit3))) )
	elseif onTime then
		print( format("|cff33ff99<%s>|r |cffeda55f%s|r", ADDON, format(Addon.Locale.completion1, name, timeFormatMS(time), timeFormatMS(timeLimit - time), timeFormatMS(time - timeLimit2))) )
	else
		print( format("|cff33ff99<%s>|r |cffff2020%s|r", ADDON, format(Addon.Locale.completion0, name, timeFormatMS(time), timeFormatMS(time - timeLimit))) )
	end

	local splitMsg = Addon.Splits:SplitOutput()
	if splitMsg then
		print(  format("%s%s|r", LIGHTYELLOW_FONT_COLOR_CODE, format(Addon.Locale.completionSplits, splitMsg)) )
	end
end

function Mod:Startup()
	self:RegisterEvent("CHALLENGE_MODE_COMPLETED")
	Addon.Config:RegisterCallback('deathTracker', function()
		self:UpdatePlayerDeaths()
	end)
	Addon.Config:RegisterCallback('smallAffixes', function()
		local level, affixes, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
		if affixes then
			SetUpAffixes(ScenarioChallengeModeBlock, affixes)
		end
	end)
end
