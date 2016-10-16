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

local TimerFrame
local keystoneLevel
local function StartTime()
	keystoneLevel = C_ChallengeMode.GetActiveKeystoneInfo()

	if not TimerFrame then
		TimerFrame = CreateFrame("Frame", ADDON.."Frame", ScenarioChallengeModeBlock)
		TimerFrame:SetAllPoints(ScenarioChallengeModeBlock)
		
		TimerFrame.Text = TimerFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
		TimerFrame.Text:SetPoint("BOTTOMLEFT", ScenarioChallengeModeBlock.TimeLeft, "BOTTOMRIGHT", 2, 2)
		
		TimerFrame.Text2 = TimerFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		TimerFrame.Text2:SetPoint("BOTTOMLEFT", TimerFrame.Text, "BOTTOMRIGHT", 4, 1)

		TimerFrame.Bar3 = TimerFrame:CreateTexture(nil, "OVERLAY")
		TimerFrame.Bar3:SetPoint("TOPLEFT", ScenarioChallengeModeBlock.StatusBar, "TOPLEFT", ScenarioChallengeModeBlock.StatusBar:GetWidth() * (1 - TIME_FOR_3) - 4, 0)
		TimerFrame.Bar3:SetSize(8, 10)
		TimerFrame.Bar3:SetTexture("Interface\\Addons\\AngryKeystones\\bar")
		TimerFrame.Bar3:SetTexCoord(0, 0.5, 0, 1)

		TimerFrame.Bar2 = TimerFrame:CreateTexture(nil, "OVERLAY")
		TimerFrame.Bar2:SetPoint("TOPLEFT", ScenarioChallengeModeBlock.StatusBar, "TOPLEFT", ScenarioChallengeModeBlock.StatusBar:GetWidth() * (1 - TIME_FOR_2) - 4, 0)
		TimerFrame.Bar2:SetSize(8, 10)
		TimerFrame.Bar2:SetTexture("Interface\\Addons\\AngryKeystones\\bar")
		TimerFrame.Bar2:SetTexCoord(0.5, 1, 0, 1)
	end
	TimerFrame:Show()
end

local function StopTime()
	TimerFrame:Hide()
end

local function UpdateTime(block, elapsedTime)
	if not TimerFrame then return end

	local time3 = block.timeLimit * TIME_FOR_3
	local time2 = block.timeLimit * TIME_FOR_2

	TimerFrame.Bar3:SetShown(elapsedTime < time3)
	TimerFrame.Bar2:SetShown(elapsedTime < time2)

	if elapsedTime < time3 then
		TimerFrame.Text:SetText( timeFormat(time3 - elapsedTime) )
		TimerFrame.Text:SetTextColor(1, 0.843, 0)
		TimerFrame.Text:Show()
		if Addon.Config.silverGoldTimer and keystoneLevel and keystoneLevel < 10 then
			TimerFrame.Text2:SetText( timeFormat(time2 - elapsedTime) )
			TimerFrame.Text2:SetTextColor(0.78, 0.78, 0.812)
			TimerFrame.Text2:Show()
		else
			TimerFrame.Text2:Hide()
		end
	elseif elapsedTime < time2 then
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
end

hooksecurefunc("Scenario_ChallengeMode_ShowBlock", StartTime)
hooksecurefunc("Scenario_ChallengeMode_UpdateTime", UpdateTime)
