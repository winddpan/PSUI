return

AnchorRaidUtilityPanel = CreateFrame("Frame","Move_RaidUtilityPanel",UIParent)
AnchorRaidUtilityPanel:SetPoint("TOP", UIParent, "TOP", 220, -25)
CreateAnchor(AnchorRaidUtilityPanel, "Move Raid Utility Panel", 120, 20)


local RaidUtilityPanel = CreateFrame("Frame", "RaidUtilityPanel", UIParent)
CreatePanel(RaidUtilityPanel, 125, (5)*4 + (18)*3, "TOP", AnchorRaidUtilityPanel, 0, 0)
local r,g,b,_ = Qulight["media"].backdropcolor
RaidUtilityPanel:SetBackdropColor(.05,.05,.05,0)
CreateStyle(RaidUtilityPanel, 2)
RaidUtilityPanel:Hide()
 
--Check if We are Raid Leader or Raid Officer
local function CheckRaidStatus()
	local inInstance, instanceType = IsInInstance()
	if (UnitIsRaidOfficer("player")) and not (inInstance and (instanceType == "pvp" or instanceType == "arena")) then
		return true
	else
		return false
	end
end
 
--Change border when mouse is inside the button
local function ButtonEnter(self)
	local color = RAID_CLASS_COLORS[myclass]
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end
 
--Change border back to normal when mouse leaves button
local function ButtonLeave(self)
	self:SetBackdropBorderColor(.15,.15,.15,0)
end
 
--Create button for when frame is hidden
local HiddenToggleButton = CreateFrame("Button", nil, UIParent)
HiddenToggleButton:SetHeight(16)
HiddenToggleButton:SetWidth(106)
frame1px(HiddenToggleButton)
CreateStyle(HiddenToggleButton, 2)
HiddenToggleButton:SetPoint( "TOP", AnchorRaidUtilityPanel)
HiddenToggleButton:SetScript("OnEnter", ButtonEnter)
HiddenToggleButton:SetScript("OnLeave", ButtonLeave)
HiddenToggleButton:SetScript("OnMouseUp", function(self)
	RaidUtilityPanel:Show()
	HiddenToggleButton:Hide()
end)
 
local HiddenToggleButtonText = HiddenToggleButton:CreateFontString(nil,"OVERLAY",HiddenToggleButton)
HiddenToggleButtonText:SetFont(Qulight["media"].font,10,"OUTLINE")
HiddenToggleButtonText:SetText("Raid Utility")
HiddenToggleButtonText:SetPoint("CENTER")
HiddenToggleButtonText:SetJustifyH("CENTER")
 
--Create button for when frame is shown
local ShownToggleButton = CreateFrame("Button", nil, RaidUtilityPanel)
ShownToggleButton:SetHeight(16)
ShownToggleButton:SetWidth(RaidUtilityPanel:GetWidth() / 2.5)
frame1px(ShownToggleButton)
CreateStyle(ShownToggleButton, 2)
ShownToggleButton:SetPoint("TOP", RaidUtilityPanel, "BOTTOM", 0, -5)
ShownToggleButton:SetScript("OnEnter", ButtonEnter)
ShownToggleButton:SetScript("OnLeave", ButtonLeave)
ShownToggleButton:SetScript("OnMouseUp", function(self)
	RaidUtilityPanel:Hide()
	HiddenToggleButton:Show()
end)
 
local ShownToggleButtonText = ShownToggleButton:CreateFontString(nil,"OVERLAY",ShownToggleButton)
ShownToggleButtonText:SetFont(Qulight["media"].font,10,"OUTLINE")
ShownToggleButtonText:SetText("Close")
ShownToggleButtonText:SetPoint("CENTER")
ShownToggleButtonText:SetJustifyH("CENTER")
 
--Disband Raid button
local DisbandRaidButton = CreateFrame("Button", nil, RaidUtilityPanel)
DisbandRaidButton:SetHeight(16)
DisbandRaidButton:SetWidth(RaidUtilityPanel:GetWidth() * 0.8)
frame1px(DisbandRaidButton)
DisbandRaidButton:SetPoint("TOP", RaidUtilityPanel, "TOP", 0, -5)
DisbandRaidButton:SetScript("OnEnter", ButtonEnter)
DisbandRaidButton:SetScript("OnLeave", ButtonLeave)
DisbandRaidButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		StaticPopup_Show("DISBAND_RAID")
		RaidUtilityPanel:Hide()
		HiddenToggleButton:Show()
	end
end)
 
local DisbandRaidButtonText = DisbandRaidButton:CreateFontString(nil,"OVERLAY",DisbandRaidButton)
DisbandRaidButtonText:SetFont(Qulight["media"].font,10,"OUTLINE")
DisbandRaidButtonText:SetText("Disband Group")
DisbandRaidButtonText:SetPoint("CENTER")
DisbandRaidButtonText:SetJustifyH("CENTER")
 
--Role Check button
local RoleCheckButton = CreateFrame("Button", nil, RaidUtilityPanel)
RoleCheckButton:SetHeight(16)
RoleCheckButton:SetWidth(RaidUtilityPanel:GetWidth() * 0.8)
frame1px(RoleCheckButton)
RoleCheckButton:SetPoint("TOP", DisbandRaidButton, "BOTTOM", 0, -5)
RoleCheckButton:SetScript("OnEnter", ButtonEnter)
RoleCheckButton:SetScript("OnLeave", ButtonLeave)
RoleCheckButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		InitiateRolePoll()
		RaidUtilityPanel:Hide()
		HiddenToggleButton:Show()
	end
end)
 
local RoleCheckButtonText = RoleCheckButton:CreateFontString(nil,"OVERLAY",RoleCheckButton)
RoleCheckButtonText:SetFont(Qulight["media"].font,10,"OUTLINE")
RoleCheckButtonText:SetText(ROLE_POLL)
RoleCheckButtonText:SetPoint("CENTER")
RoleCheckButtonText:SetJustifyH("CENTER")
 
--Ready Check button
local ReadyCheckButton = CreateFrame("Button", nil, RaidUtilityPanel)
ReadyCheckButton:SetHeight(16)
ReadyCheckButton:SetWidth(RoleCheckButton:GetWidth() * 0.75)
frame1px(ReadyCheckButton)
ReadyCheckButton:SetPoint("TOPLEFT", RoleCheckButton, "BOTTOMLEFT", 0, -5)
ReadyCheckButton:SetScript("OnEnter", ButtonEnter)
ReadyCheckButton:SetScript("OnLeave", ButtonLeave)
ReadyCheckButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		DoReadyCheck()
		RaidUtilityPanel:Hide()
		HiddenToggleButton:Show()
	end
end)
 
local ReadyCheckButtonText = ReadyCheckButton:CreateFontString(nil,"OVERLAY",ReadyCheckButton)
ReadyCheckButtonText:SetFont(Qulight["media"].font,10,"OUTLINE")
ReadyCheckButtonText:SetText(READY_CHECK)
ReadyCheckButtonText:SetPoint("CENTER")
ReadyCheckButtonText:SetJustifyH("CENTER")
 
--World Marker button
local WorldMarkerButton = CreateFrame("Button", nil, RaidUtilityPanel)
WorldMarkerButton:SetHeight(18)
WorldMarkerButton:SetWidth(RoleCheckButton:GetWidth() * 0.2)
frame1px(WorldMarkerButton)
WorldMarkerButton:SetPoint("TOPRIGHT", RoleCheckButton, "BOTTOMRIGHT", 0, -5)
 
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:ClearAllPoints()
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:SetAllPoints(WorldMarkerButton)
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:SetParent(WorldMarkerButton)
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:SetAlpha(0)
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:HookScript("OnEnter", function()
	local color = RAID_CLASS_COLORS[myclass]
	WorldMarkerButton:SetBackdropBorderColor(color.r, color.g, color.b)
end)
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:HookScript("OnLeave", function()
	WorldMarkerButton:SetBackdropBorderColor(.15,.15,.15,0)
end)

--Put other stuff back
CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck:ClearAllPoints()
CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck:SetPoint("BOTTOMLEFT", CompactRaidFrameManagerDisplayFrameLockedModeToggle, "TOPLEFT", 0, 1)
CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck:SetPoint("BOTTOMRIGHT", CompactRaidFrameManagerDisplayFrameHiddenModeToggle, "TOPRIGHT", 0, 1)

CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll:ClearAllPoints()
CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll:SetPoint("BOTTOMLEFT", CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck, "TOPLEFT", 0, 1)
CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll:SetPoint("BOTTOMRIGHT", CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck, "TOPRIGHT", 0, 1)

 
local WorldMarkerButtonTexture = WorldMarkerButton:CreateTexture(nil,"OVERLAY",nil)
WorldMarkerButtonTexture:SetTexture("Interface\\RaidFrame\\Raid-WorldPing")
WorldMarkerButtonTexture:SetPoint("TOPLEFT", WorldMarkerButton, "TOPLEFT", 1, -1)
WorldMarkerButtonTexture:SetPoint("BOTTOMRIGHT", WorldMarkerButton, "BOTTOMRIGHT", -1, 1)