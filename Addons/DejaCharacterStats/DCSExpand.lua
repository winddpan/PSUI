-- ------------------------------------------------
-- -- DCS Character Frame Expand/Collapse Button --
-- ------------------------------------------------
local DCS_tooltipText

local function DCS_ExpandCheck_OnEnter(self)
	GameTooltip:SetOwner(DCS_ExpandCheck, "ANCHOR_RIGHT");
	GameTooltip:SetText(DCS_tooltipText, 1, 1, 1, 1, true)
	GameTooltip:Show()
end

local function DCS_ExpandCheck_OnLeave(self)
	GameTooltip_Hide()
 end
 
local _, private = ...
	private.defaults.dcsdefaults.dejacharacterstatsExpandChecked = {
		ExpandSetChecked = true,
}
local DCS_ExpandCheck = CreateFrame("Button", "DCS_ExpandCheck", PaperDollFrame)
	DCS_ExpandCheck:RegisterForClicks("AnyDown")
	DCS_ExpandCheck:ClearAllPoints()
	DCS_ExpandCheck:SetPoint("TOPRIGHT", CharacterTrinket1Slot, "BOTTOMRIGHT", 2, -3)
	DCS_ExpandCheck:SetSize(32, 32)
	DCS_ExpandCheck:SetHighlightTexture("Interface\\BUTTONS\\UI-Common-MouseHilight")
	
DCS_ExpandCheck:SetScript("OnEnter", DCS_ExpandCheck_OnEnter)
DCS_ExpandCheck:SetScript("OnLeave", DCS_ExpandCheck_OnLeave)
		 
DCS_ExpandCheck:SetScript("OnMouseDown", function (self, button, up)
	checked = private.db.dcsdefaults.dejacharacterstatsExpandChecked.ExpandSetChecked
	if checked == true then
		DCS_ExpandCheck:SetPushedTexture("Interface\\BUTTONS\\UI-SpellbookIcon-PrevPage-Down")
		DCS_ExpandCheck:SetNormalTexture("Interface\\BUTTONS\\UI-SpellbookIcon-PrevPage-Down")
	else
		DCS_ExpandCheck:SetPushedTexture("Interface\\BUTTONS\\UI-SpellbookIcon-NextPage-Down")
		DCS_ExpandCheck:SetNormalTexture("Interface\\BUTTONS\\UI-SpellbookIcon-NextPage-Down")
	end
end)

DCS_ExpandCheck:SetScript("OnMouseUp", function (self, button, up)
	checked = private.db.dcsdefaults.dejacharacterstatsExpandChecked.ExpandSetChecked
	if checked == true then
	--	print(checked)
		CharacterFrame_Collapse()
		DCS_ExpandCheck:SetNormalTexture("Interface\\BUTTONS\\UI-SpellbookIcon-NextPage-Up")
		private.db.dcsdefaults.dejacharacterstatsExpandChecked.ExpandSetChecked = false
		DCS_tooltipText = 'Show Character Stats' --Creates a tooltip on mouseover.
	else
	--	print(checked)
		CharacterFrame_Expand()
		DCS_ExpandCheck:SetNormalTexture("Interface\\BUTTONS\\UI-SpellbookIcon-PrevPage-Up")
		private.db.dcsdefaults.dejacharacterstatsExpandChecked.ExpandSetChecked = true
		DCS_tooltipText = 'Hide Character Stats' --Creates a tooltip on mouseover.
	end
	DCS_ExpandCheck_OnEnter()
end)

-- -----------------------------
-- -- PaperDoll OnShow/OnHide --
-- -----------------------------
PaperDollFrame:SetScript("OnShow", function(self, event, arg1)
	CharacterStatsPane.initialOffsetY = 0
	CharacterFrameTitleText:SetText(UnitPVPName("player"))
	PaperDollFrame_SetLevel()
	PaperDollFrame_UpdateStats()

	SetPaperDollBackground(CharacterModelFrame, "player")
	PaperDollBgDesaturate(true)
	PaperDollSidebarTabs:Show()
	PaperDollFrame_UpdateInventoryFixupComplete(self)

	checked = private.db.dcsdefaults.dejacharacterstatsExpandChecked.ExpandSetChecked
	if checked == true then
	--	print(checked)
		CharacterFrame_Expand()
		DCS_tooltipText = 'Hide Character Stats' --Creates a tooltip on mouseover.
		DCS_ExpandCheck:SetNormalTexture("Interface\\BUTTONS\\UI-SpellbookIcon-PrevPage-Up")
	else
	--	print(checked)
		CharacterFrame_Collapse()
		DCS_tooltipText = 'Show Character Stats' --Creates a tooltip on mouseover.
		DCS_ExpandCheck:SetNormalTexture("Interface\\BUTTONS\\UI-SpellbookIcon-NextPage-Up")
	end
end)