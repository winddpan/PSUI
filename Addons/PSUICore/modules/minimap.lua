local addon, ns = ...
local _G = _G

-- Config
local font = "Fonts\\ARIALN.TTF"
local Scale = 1				-- Minimap scale
local ClassColorBorder = false	-- Should border around minimap be classcolored? Enabling it disables color settings below
local zoneTextYOffset = 10		-- Zone text position
local Size = 220
local rawMinimap = Minimap
local Minimap = Minimap

-- Shape, location and scale
MinimapCluster:SetScale(1)
MinimapCluster:ClearAllPoints()
MinimapCluster:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 25, min(0, -25 + floor(Size/7.5)))
MinimapCluster:EnableMouse(false)
MinimapCluster:SetClampedToScreen(false)
MinimapCluster:SetSize(Size*Scale, Size*Scale)

Minimap:SetClampedToScreen(false)
Minimap:SetSize(Size*Scale, Size*Scale)
Minimap:SetMaskTexture[[Interface\AddOns\PSUICore\media\rectangle]]
Minimap:SetHitRectInsets(0, 0, 34*Scale, 34*Scale)
--Minimap:SetFrameStrata("BACKGROUND")
Minimap:ClearAllPoints()
Minimap:SetAllPoints(MinimapCluster)
Minimap:SetFrameLevel(2)

function GetMinimapShape() return "SQUARE" end

Minimap.mnMap = CreateFrame("Frame", nil, Minimap)
Minimap.mnMap:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, -(floor(Size/7.5)*Scale))
Minimap.mnMap:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 0, (floor(Size/7.5)*Scale))
Minimap.mnMap:SetBackdrop({
	bgFile = [[Interface/Buttons/WHITE8X8]],
	tiled = false,
	insets = {left = 0, right = 0, top = 0, bottom = 0}
})
Minimap.mnMap:SetBackdropColor(0, 0, 0, .75)
Minimap.mnMap:SetFrameLevel(0)
Minimap.mnMap:SetFrameStrata("BACKGROUND")

Minimap.mnMap.Shadow = CreateFrame("Frame", nil, Minimap.mnMap)
Minimap.mnMap.Shadow:SetPoint("TOPLEFT", Minimap.mnMap, "TOPLEFT", -3, 3)
Minimap.mnMap.Shadow:SetPoint("BOTTOMRIGHT", Minimap.mnMap, "BOTTOMRIGHT", 3, -3)
Minimap.mnMap.Shadow:SetBackdrop({edgeFile = [[Interface\AddOns\PSUICore\media\glow]], edgeSize = 3})
Minimap.mnMap.Shadow:SetBackdropBorderColor(0, 0, 0, 1)

-- Background
if(ClassColorBorder==true) then
    local _, class = UnitClass("player")
    local t = RAID_CLASS_COLORS[class]
    Minimap.mnMap:SetBackdropColor(t.r, t.g, t.b, a)
else
    Minimap.mnMap:SetBackdropColor(0, 0, 0, .75)
end

-- Mask texture hint => addon will work with Carbonite
local hint = CreateFrame("Frame")
local total = 0
local SetTextureTrick = function(self, elapsed)
    total = total + elapsed
    if(total > 2) then
        --Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8")
        hint:SetScript("OnUpdate", nil)
    end
end

hint:RegisterEvent("PLAYER_LOGIN")
hint:SetScript("OnEvent", function()
    hint:SetScript("OnUpdate", SetTextureTrick)
end)

-- Mousewheel zoom
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(_, zoom)
    if zoom > 0 then
        Minimap_ZoomIn()
    else
        Minimap_ZoomOut()
    end
end)

-- Hiding ugly things
local dummy = function() end

local frames = {
    "GameTimeFrame",
    "MinimapBorderTop",
    "MinimapNorthTag",
    "MinimapBorder",
    "MinimapZoneTextButton",
    "MinimapZoomOut",
    "MinimapZoomIn",
    "MiniMapVoiceChatFrame",
    "MiniMapWorldMapButton",
	
    "MiniMapMailBorder",
--    "MiniMapBattlefieldBorder",
--    "FeedbackUIButton",
--	"MinimapBackdrop",
}

for i in pairs(frames) do
    _G[frames[i]]:Hide()
    _G[frames[i]].Show = dummy
end
MinimapCluster:EnableMouse(false)

Minimap = Minimap.mnMap

-- Tracking
MiniMapTrackingBackground:SetAlpha(0)
MiniMapTrackingButton:SetAlpha(0)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("BOTTOMLEFT", Minimap, -5, -7)

-- BG icon
--MiniMapBattlefieldFrame:ClearAllPoints()
--MiniMapBattlefieldFrame:SetPoint("TOP", Minimap, "TOP", 2, 8)

-- LFG icon
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("TOP", Minimap, "TOP", 1, 8)
QueueStatusMinimapButtonBorder:Hide()
-- QueueStatusMinimapButtonBorder:SetFrameStrata("MEDIUM")

-- Instance Difficulty flag
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 2, 2)
MiniMapInstanceDifficulty:SetScale(0.75)
MiniMapInstanceDifficulty:SetFrameStrata("LOW")

-- Guild Instance Difficulty flag
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 2, 2)
GuildInstanceDifficulty:SetScale(0.75)
GuildInstanceDifficulty:SetFrameStrata("LOW")

-- Mail icon
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 2, -6)
--MiniMapMailIcon:SetTexture(cfg.media.mail_icon)

-- Invites Icon
GameTimeCalendarInvitesTexture:ClearAllPoints()
GameTimeCalendarInvitesTexture:SetParent("Minimap")
GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT")

if FeedbackUIButton then
FeedbackUIButton:ClearAllPoints()
FeedbackUIButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 6, -6)
FeedbackUIButton:SetScale(0.8)
end

if StreamingIcon then
StreamingIcon:ClearAllPoints()
StreamingIcon:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 8, 8)
StreamingIcon:SetScale(0.8)
end


-- Clock
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
end
local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:SetFont(font, 12, "THINOUTLINE")
clockTime:SetTextColor(1,1,1)
TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -8)
TimeManagerClockButton:SetScript("OnClick", function(_,btn)
 	if btn == "LeftButton" then
		TimeManager_Toggle()
	end 
	if btn == "RightButton" then
		if not CalendarFrame then
			LoadAddOn("Blizzard_Calendar")
		end
		Calendar_Toggle()
	end
end)
	
-- Zone text
local zoneTextFrame = CreateFrame("Frame", nil, UIParent)
zoneTextFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, zoneTextYOffset)
zoneTextFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, zoneTextYOffset)
zoneTextFrame:SetHeight(19)
zoneTextFrame:SetAlpha(0)
MinimapZoneText:SetParent(zoneTextFrame)
MinimapZoneText:ClearAllPoints()
MinimapZoneText:SetPoint("LEFT", 2, 1)
MinimapZoneText:SetPoint("RIGHT", -2, 1)
MinimapZoneText:SetFont(font, 12, "THINOUTLINE")
Minimap:SetScript("OnEnter", function(self)
	UIFrameFadeIn(zoneTextFrame, 0.3, 0, 1)
end)
Minimap:SetScript("OnLeave", function(self)
	UIFrameFadeOut(zoneTextFrame, 0.3, 1, 0)
end)


-- Creating right click menu
local menuFrame = CreateFrame("Frame", "m_MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
	{text = CHARACTER_BUTTON, notCheckable = 1, func = function()
		ToggleCharacter("PaperDollFrame")
	end},
	{text = SPELLBOOK_ABILITIES_BUTTON, notCheckable = 1, func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return
		end
		ToggleSpellBook(BOOKTYPE_SPELL)
	end},
	{text = TALENTS_BUTTON, notCheckable = 1, func = function()
		if not PlayerTalentFrame then
			TalentFrame_LoadUI()
		end
		--ToggleTalentFrame()
		if not IsAddOnLoaded("Blizzard_TalentUI") then LoadAddOn("Blizzard_TalentUI") end 
			ToggleFrame(PlayerTalentFrame)
	end},
	{text = ACHIEVEMENT_BUTTON, notCheckable = 1, func = function()
		ToggleAchievementFrame()
	end},
	{text = QUESTLOG_BUTTON, notCheckable = 1, func = function()
		ToggleFrame(QuestLogFrame)
	end},
	{text = ACHIEVEMENTS_GUILD_TAB, notCheckable = 1, func = function()
		if IsInGuild() then
			if not GuildFrame then
				LoadAddOn("Blizzard_GuildUI")
			end
			ToggleGuildFrame()
			GuildFrame_TabClicked(GuildFrameTab2)
		else
			if not LookingForGuildFrame then
				LoadAddOn("Blizzard_LookingForGuildUI")
			end
			if not LookingForGuildFrame then return end
			LookingForGuildFrame_Toggle()
		end
	end},
	{text = SOCIAL_BUTTON, notCheckable = 1, func = function()
		ToggleFriendsFrame(1)
	end},
   {text = PLAYER_V_PLAYER, notCheckable = 1,
		func = function() TogglePVPUI() end},
	{text = DUNGEONS_BUTTON, notCheckable = 1, func = function()
			PVEFrame_ToggleFrame()
	end},
	{text = COLLECTIONS, notCheckable = 1, func = function()
		ToggleCollectionsJournal()
	end},
	{text = ENCOUNTER_JOURNAL, notCheckable = 1, func = function()
		if not IsAddOnLoaded("Blizzard_EncounterJournal") then
			LoadAddOn("Blizzard_EncounterJournal")
		end
		ToggleEncounterJournal()
	end},
	{text = BATTLEFIELD_MINIMAP, notCheckable = true, func = function()
		ToggleBattlefieldMinimap()
	end},
	--[[
	{text = HELP_BUTTON, notCheckable = 1, func = function()
		ToggleHelpFrame()
	end},
	{text = "商城", notCheckable = 1, 
		func = function() ToggleStoreUI() end},
		
	{text = L_MINIMAP_CALENDAR, notCheckable = 1, func = function()
		if not CalendarFrame then
			LoadAddOn("Blizzard_Calendar")
		end
		Calendar_Toggle()
	end},]]
}

Minimap = rawMinimap

-- Click func
Minimap:SetScript("OnMouseUp", function(_, btn)
    if(btn=="MiddleButton") then
        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "cursor", 0, 0)
    elseif(btn=="RightButton") then
        EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 1)
	else
		local x, y = GetCursorPosition()
		x = x / Minimap:GetEffectiveScale()
		y = y / Minimap:GetEffectiveScale()
		local cx, cy = Minimap:GetCenter()
		x = x - cx
		y = y - cy
		if ( sqrt(x * x + y * y) < (Minimap:GetWidth() / 2) ) then
			Minimap:PingLocation(x, y)
		end
		Minimap_SetPing(x, y, 1)
	end
end) 

