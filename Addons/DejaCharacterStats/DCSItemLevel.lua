-- Item Level Check

	local _, private = ...
	private.defaults.dcsdefaults.dejacharacterstatsItemLevelChecked = {
		ItemLevelSetChecked = true,
	}	
	
local function DCS_ItemLevelShow(self)
	function PaperDollFrame_SetItemLevel(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end

		local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel();
		avgItemLevel = floor(avgItemLevel);
		avgItemLevelEquipped = floor(avgItemLevelEquipped);
		if ( avgItemLevelEquipped == avgItemLevel ) then
			PaperDollFrame_SetLabelAndText(statFrame, STAT_AVERAGE_ITEM_LEVEL, avgItemLevelEquipped, false, avgItemLevelEquipped);
		else
			PaperDollFrame_SetLabelAndText(statFrame, STAT_AVERAGE_ITEM_LEVEL, ((avgItemLevelEquipped).."/"..avgItemLevel), false, avgItemLevelEquipped);
		end
		statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_AVERAGE_ITEM_LEVEL).." "..avgItemLevel;
		if ( avgItemLevelEquipped ~= avgItemLevel ) then
			statFrame.tooltip = statFrame.tooltip .. "  " .. format(STAT_AVERAGE_ITEM_LEVEL_EQUIPPED, avgItemLevelEquipped);
		end
		statFrame.tooltip = statFrame.tooltip .. FONT_COLOR_CODE_CLOSE;
		statFrame.tooltip2 = STAT_AVERAGE_ITEM_LEVEL_TOOLTIP;
	end
	PaperDollFrame_UpdateStats()
end

local function DCS_ItemLevelHide(self)
	function PaperDollFrame_SetItemLevel(statFrame, unit)
		if ( unit ~= "player" ) then
			statFrame:Hide();
			return;
		end

		local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel();
		avgItemLevel = floor(avgItemLevel);
		avgItemLevelEquipped = floor(avgItemLevelEquipped);
		PaperDollFrame_SetLabelAndText(statFrame, STAT_AVERAGE_ITEM_LEVEL, avgItemLevelEquipped, false, avgItemLevelEquipped);
		statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_AVERAGE_ITEM_LEVEL).." "..avgItemLevel;
		if ( avgItemLevelEquipped ~= avgItemLevel ) then
			statFrame.tooltip = statFrame.tooltip .. "  " .. format(STAT_AVERAGE_ITEM_LEVEL_EQUIPPED, avgItemLevelEquipped);
		end
		statFrame.tooltip = statFrame.tooltip .. FONT_COLOR_CODE_CLOSE;
		statFrame.tooltip2 = STAT_AVERAGE_ITEM_LEVEL_TOOLTIP;
	end
	PaperDollFrame_UpdateStats()
end

local DCS_ItemLevelCheck = CreateFrame("CheckButton", "DCS_ItemLevelCheck", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ItemLevelCheck:RegisterEvent("PLAYER_LOGIN")
	DCS_ItemLevelCheck:ClearAllPoints()
	DCS_ItemLevelCheck:SetPoint("TOPLEFT", 25, -35)
	DCS_ItemLevelCheck:SetScale(1.25)
	DCS_ItemLevelCheck.tooltipText = 'Displays Equipped/Available item levels unless equal.' --Creates a tooltip on mouseover.
	_G[DCS_ItemLevelCheck:GetName() .. "Text"]:SetText("Equipped/Available")
	
	DCS_ItemLevelCheck:SetScript("OnEvent", function(self, event, arg1)
		if event == "PLAYER_LOGIN" then
		local checked = private.db.dcsdefaults.dejacharacterstatsItemLevelChecked
			self:SetChecked(checked.ItemLevelSetChecked)
			if self:GetChecked(true) then
				DCS_ItemLevelShow()
				private.db.dcsdefaults.dejacharacterstatsItemLevelChecked.ItemLevelSetChecked = true
			else
				DCS_ItemLevelHide()
				private.db.dcsdefaults.dejacharacterstatsItemLevelChecked.ItemLevelSetChecked = false
			end
		end
	end)

	DCS_ItemLevelCheck:SetScript("OnClick", function(self,event,arg1) 
		local checked = private.db.dcsdefaults.dejacharacterstatsItemLevelChecked
		if self:GetChecked(true) then
			DCS_ItemLevelShow()
			private.db.dcsdefaults.dejacharacterstatsItemLevelChecked.ItemLevelSetChecked = true
		else
			DCS_ItemLevelHide()
			private.db.dcsdefaults.dejacharacterstatsItemLevelChecked.ItemLevelSetChecked = false
		end
	end)