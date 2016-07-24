-- ---------------------------
-- -- DCS Durability Frames --
-- ---------------------------

local DCSITEM_SLOT_FRAMES = {
	CharacterHeadSlot,CharacterShoulderSlot,CharacterChestSlot,CharacterWristSlot,CharacterSecondaryHandSlot,
	CharacterHandsSlot,CharacterWaistSlot,CharacterLegsSlot,CharacterFeetSlot,CharacterMainHandSlot,
}

local DCSITEM_SLOT_FRAMES_RIGHT = {
	CharacterHeadSlot,CharacterShoulderSlot,CharacterChestSlot,CharacterWristSlot,CharacterSecondaryHandSlot,
}

local DCSITEM_SLOT_FRAMES_LEFT = {
	CharacterHandsSlot,CharacterWaistSlot,CharacterLegsSlot,CharacterFeetSlot,CharacterMainHandSlot,
}

local durFinite = 0
local duraMean = 0
local duraTotal = 0
local duraMaxTotal = 0

local duraMeanFS = CharacterShirtSlot:CreateFontString("FontString","OVERLAY","GameTooltipText")
	duraMeanFS:SetPoint("CENTER",CharacterShirtSlot,"CENTER",0,0)
	duraMeanFS:SetFont("Fonts\\FRIZQT__.TTF", 16, "THINOUTLINE")
	duraMeanFS:SetFormattedText("")

	duraMeanTexture = CharacterShirtSlot:CreateTexture(nil,"ARTWORK")

local duraDurabilityFrameFS = DurabilityFrame:CreateFontString("FontString","OVERLAY","GameTooltipText")
	duraDurabilityFrameFS:SetPoint("CENTER",DurabilityFrame,"CENTER",0,0)
	duraDurabilityFrameFS:SetFont("Fonts\\FRIZQT__.TTF", 16, "THINOUTLINE")
	duraDurabilityFrameFS:SetFormattedText("")

for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
	v.duratexture = duraColorTexture
	v.duratexture = v:CreateTexture(nil,"ARTWORK")

	v.durability = duraFS
    v.durability = v:CreateFontString("FontString","OVERLAY","GameTooltipText")
    v.durability:SetPoint("TOP",v,"TOP",0,-3)
    v.durability:SetFont("Fonts\\FRIZQT__.TTF", 11, "THINOUTLINE")
    v.durability:SetFormattedText("")

    v.itemrepair = itemrepairFS
    v.itemrepair = v:CreateFontString("FontString","OVERLAY","GameTooltipText")
    v.itemrepair:SetPoint("BOTTOM",v,"BOTTOM",0,3)
    v.itemrepair:SetFont("Fonts\\FRIZQT__.TTF", 11, "THINOUTLINE")
    v.itemrepair:SetFormattedText("")
end

local durStatFinite = 0
local duraStatMean = 0
local duraStatTotal = 0
local duraStatMaxTotal = 0

local function DCS_Mean_DurabilityStatDisplay()
	duraStatMean = 0
	duraStatTotal = 0
	duraStatMaxTotal = 0
	for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
		-- -----------------------------
		-- -- Durability Stat Display --
		-- -----------------------------
		local slotId = v:GetID()
		--print(slotId)
		local durCur, durMax = GetInventoryItemDurability(slotId)
		--print(durCur, durMax)
		
		-- --------------------------
		-- -- Mean Durability Calc --
		-- --------------------------
		if durCur == nil or durMax == nil then
			duraStatTotal = duraStatTotal
			duraStatMaxTotal = duraStatMaxTotal
			duraStatMean = duraStatMean
		else
			duraStatTotal = duraStatTotal + durCur
			duraStatMaxTotal = duraStatMaxTotal + durMax
			duraStatMean = ((duraStatTotal/duraStatMaxTotal)*100)
		--	print(duraStatMean)
		end
	end
end

local function DCS_Durability_Frame_Mean_Display()
	-- -----------------------------------
	-- -- Durability Frame Mean Display --
	-- -----------------------------------
	duraDurabilityFrameFS:SetFormattedText("%.0f%%", duraMean)
	duraDurabilityFrameFS:Show()
--	print(duraMean)
	if duraMean == 100 then 
		duraDurabilityFrameFS:Hide()
	elseif duraMean >= 80 then
		duraDurabilityFrameFS:SetTextColor(0.753, 0.753, 0.753)
	elseif duraMean > 66 then
		duraDurabilityFrameFS:SetTextColor(0, 1, 0)
	elseif duraMean > 33 then
		duraDurabilityFrameFS:SetTextColor(1, 1, 0)
	elseif duraMean >= 0 then
		duraDurabilityFrameFS:SetTextColor(1, 0, 0)
	end
end

local function DCS_Mean_Durability()
	for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
		-- print(v)

		-- ---------------------
		-- -- Item Durability --
		-- ---------------------
		local slotId = v:GetID()
		--print(slotId)
		local durCur, durMax = GetInventoryItemDurability(slotId)
		--print(durCur, durMax)
		
		-- --------------------------
		-- -- Mean Durability Calc --
		-- --------------------------
		if durCur == nil or durMax == nil then
			duraTotal = duraTotal
			duraMaxTotal = duraMaxTotal
			duraMean = duraMean
		else
			duraTotal = duraTotal + durCur
			duraMaxTotal = duraMaxTotal + durMax
			duraMean = ((duraTotal/duraMaxTotal)*100)
		--	print(duraMean)
		end

		-- -----------------------------
		-- -- Mean Durability Display --
		-- -----------------------------
		--	print(duraMean)
		duraMeanTexture:SetSize(4, (31*(duraMean/100)))
		duraMeanFS:SetFormattedText("%.0f%%", duraMean)
		if duraMean == 100 then 
			duraMeanTexture:SetColorTexture(0, 0, 0, 0)
			duraMeanFS:SetFormattedText("")
		elseif duraMean < 10 then
			duraMeanTexture:SetColorTexture(1, 0, 0)
			duraMeanFS:SetTextColor(1, 0, 0)
		elseif duraMean < 33 then
			duraMeanTexture:SetColorTexture(1, 0, 0)
			duraMeanFS:SetTextColor(1, 0, 0)
		elseif duraMean < 66 then
			duraMeanTexture:SetColorTexture(1, 1, 0)
			duraMeanFS:SetTextColor(1, 1, 0)
		elseif duraMean < 80 then
			duraMeanTexture:SetColorTexture(0, 1, 0)
			duraMeanFS:SetTextColor(0, 1, 0)
		elseif duraMean < 100 then
			duraMeanTexture:SetColorTexture(0.753, 0.753, 0.753)
			duraMeanFS:SetTextColor(0.753, 0.753, 0.753)
		end
		if duraMean > 10 then 
			duraMeanTexture:ClearAllPoints()
			duraMeanTexture:SetPoint("BOTTOMLEFT",CharacterShirtSlot,"BOTTOMRIGHT",1,3)
		elseif duraMean <= 10 then 
			duraMeanTexture:ClearAllPoints()
			duraMeanTexture:SetAllPoints(CharacterShirtSlot)
			duraMeanTexture:SetColorTexture(1, 0, 0, 0.15)
		end
		DCS_Durability_Frame_Mean_Display()
	end
end

local repairitemCostTotal
local function DCS_Item_RepairTotal()
	for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
		local slotId = v:GetID()
		--print(slotId)
		local durCur, durMax = GetInventoryItemDurability(slotId)
		--print(durCur, durMax)
		local scanTool = CreateFrame("GameTooltip")
			scanTool:ClearLines()
		local repairnewitemCost = select(3, scanTool:SetInventoryItem("player", slotId))
		if repairitemCostTotal == nil then
			repairitemCostTotal = 0
		end
		local repairTotal = repairitemCostTotal + repairnewitemCost
		repairitemCostTotal = repairTotal
		--print(repairitemCostTotal)
	end
end

local function DCS_Item_Durability()
	for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
		-- print(v)
		-- ---------------------
		-- -- Item Durability --
		-- ---------------------
		local slotId = v:GetID()
		--print(slotId)
		local durCur, durMax = GetInventoryItemDurability(slotId)
		--print(durCur, durMax)

		if durCur == nil or durMax == nil then
			v.duratexture:SetColorTexture(0, 0, 0, 0)
			v.durability:SetFormattedText("")
		elseif ( durCur == durMax ) then
			v.duratexture:SetColorTexture(0, 0, 0, 0)
			v.durability:SetFormattedText("")
		elseif ( durCur ~= durMax ) then
			durFinite = ((durCur/durMax)*100)
			--print(durFinite)
		    v.durability:SetFormattedText("%.0f%%", durFinite)
			if durFinite == 100 then
				v.duratexture:SetColorTexture(0,  0, 0, 0)
				v.durability:SetTextColor(0, 0, 0, 0)
			elseif durFinite > 66 then
				v.duratexture:SetColorTexture(0, 1, 0)
				v.durability:SetTextColor(0, 1, 0)
			elseif durFinite > 33 then
				v.duratexture:SetColorTexture(1, 1, 0)
				v.durability:SetTextColor(1, 1, 0)
			elseif durFinite > 10 then
				v.duratexture:SetColorTexture(1, 0, 0)
				v.durability:SetTextColor(1, 0, 0)
			elseif durFinite <= 10 then
				v.duratexture:SetAllPoints(v)
				v.duratexture:SetColorTexture(1, 0, 0, 0.10)
				v.durability:SetTextColor(1, 0, 0)
			end
		end

		---------------------------
		-- Get Item Repair Costs --
		---------------------------
		local scanTool = CreateFrame("GameTooltip")
			scanTool:ClearLines()
		local repairitemCost = select(3, scanTool:SetInventoryItem("player", slotId))
		if (repairitemCost<=0) then
			v.itemrepair:SetFormattedText("")
		elseif (repairitemCost>9999999) then
			v.itemrepair:SetTextColor(1, 0.843, 0)
			v.itemrepair:SetFormattedText("%.0fg", (repairitemCost/10000))
		elseif (repairitemCost<10000000) then
			v.itemrepair:SetTextColor(1, 0.843, 0)
			v.itemrepair:SetFormattedText("%.2fg", (repairitemCost/10000))
		elseif (repairitemCost<10000) then
			v.itemrepair:SetTextColor(0.753, 0.753, 0.753)
			v.itemrepair:SetFormattedText("%.2fs", (repairitemCost/100))
		elseif (repairitemCost<100) then
			v.itemrepair:SetTextColor(0.722, 0.451, 0.200)
			v.itemrepair:SetFormattedText("%.0fc", repairitemCost)
		end

		local slotId = v:GetID()
		--print(slotId)
		local durCur, durMax = GetInventoryItemDurability(slotId)
		--print(durCur, durMax)
		
		-- --------------------------
		-- -- Mean Durability Calc --
		-- --------------------------
		if durCur == nil or durMax == nil then
			duraTotal = duraTotal
			duraMaxTotal = duraMaxTotal
			duraMean = duraMean
		else
			duraTotal = duraTotal + durCur
			duraMaxTotal = duraMaxTotal + durMax
			duraMean = ((duraTotal/duraMaxTotal)*100)
		--	print(duraMean)
		end
	end
end

local function DCS_Durability_Bar_Textures()
	for k, v in ipairs(DCSITEM_SLOT_FRAMES_RIGHT) do
		local slotId = v:GetID()
		local durCur, durMax = GetInventoryItemDurability(slotId)

		if durCur == nil or durMax == nil then
			v.duratexture:SetColorTexture(0, 0, 0, 0)
		elseif ( durCur == durMax ) then
			v.duratexture:SetColorTexture(0, 0, 0, 0)
		elseif ( durCur ~= durMax ) then
			durFinite = ((durCur/durMax)*100)
		end
		v.duratexture:SetPoint("BOTTOMLEFT",v,"BOTTOMRIGHT",1,3)
		v.duratexture:SetSize(4, (31*(durFinite/100)))
		v.duratexture:Show()
		duraMeanTexture:Show()
	end
	for k, v in ipairs(DCSITEM_SLOT_FRAMES_LEFT) do
		local slotId = v:GetID()
		local durCur, durMax = GetInventoryItemDurability(slotId)

		if durCur == nil or durMax == nil then
			v.duratexture:SetColorTexture(0, 0, 0, 0)
		elseif ( durCur == durMax ) then
			v.duratexture:SetColorTexture(0, 0, 0, 0)
		elseif ( durCur ~= durMax ) then
			durFinite = ((durCur/durMax)*100)
		end
		v.duratexture:SetPoint("BOTTOMRIGHT",v,"BOTTOMLEFT",-2,3)
		v.duratexture:SetSize(3, (31*(durFinite/100)))
		v.duratexture:Show()
		duraMeanTexture:Show()
	end
    duraMean = 0
	duraTotal = 0
	duraMaxTotal = 0
end

local _, private = ...
private.defaults.dcsdefaults.dejacharacterstatsShowDuraRepairChecked = {
	ShowDuraRepairSetChecked = false,
}	

local DCS_ShowDuraRepairCheck = CreateFrame("CheckButton", "DCS_ShowDuraRepairCheck", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ShowDuraRepairCheck:RegisterEvent("PLAYER_LOGIN")
    DCS_ShowDuraRepairCheck:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	DCS_ShowDuraRepairCheck:ClearAllPoints()
	DCS_ShowDuraRepairCheck:SetPoint("LEFT", 25, -75)
	DCS_ShowDuraRepairCheck:SetScale(1.25)
	DCS_ShowDuraRepairCheck.tooltipText = "Displays each item's durability and repair cost." --Creates a tooltip on mouseover.
	_G[DCS_ShowDuraRepairCheck:GetName() .. "Text"]:SetText("Durability & Repair")
	
DCS_ShowDuraRepairCheck:SetScript("OnEvent", function(self, event, ...)
	local checked = private.db.dcsdefaults.dejacharacterstatsShowDuraRepairChecked
	self:SetChecked(checked.ShowDuraRepairSetChecked)
	if self:GetChecked(true) then
		DCS_Item_Durability()
		private.db.dcsdefaults.dejacharacterstatsShowDuraRepairChecked.ShowDuraRepairSetChecked = true
	else
		for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
			v.durability:SetFormattedText("")
			v.itemrepair:SetFormattedText("")
		end
		private.db.dcsdefaults.dejacharacterstatsShowDuraRepairChecked.ShowDuraRepairSetChecked = false
	end
end)

DCS_ShowDuraRepairCheck:SetScript("OnClick", function(self,event,arg1) 
	local checked = private.db.dcsdefaults.dejacharacterstatsShowDuraRepairChecked
	if self:GetChecked(true) then
		DCS_Item_Durability()
		private.db.dcsdefaults.dejacharacterstatsShowDuraRepairChecked.ShowDuraRepairSetChecked = true
	else
		for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
			v.durability:SetFormattedText("")
			v.itemrepair:SetFormattedText("")
		end
		private.db.dcsdefaults.dejacharacterstatsShowDuraRepairChecked.ShowDuraRepairSetChecked = false
	end
end)

---------

local _, private = ...
private.defaults.dcsdefaults.dejacharacterstatsShowDuraTextureChecked = {
	ShowDuraTextureSetChecked = false,
}	

local DCS_ShowDuraTextureCheck = CreateFrame("CheckButton", "DCS_ShowDuraTextureCheck", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ShowDuraTextureCheck:RegisterEvent("PLAYER_LOGIN")
    DCS_ShowDuraTextureCheck:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	DCS_ShowDuraTextureCheck:ClearAllPoints()
	DCS_ShowDuraTextureCheck:SetPoint("LEFT", 25, -25)
	DCS_ShowDuraTextureCheck:SetScale(1.25)
	DCS_ShowDuraTextureCheck.tooltipText = "Displays a durability bar next to each item." --Creates a tooltip on mouseover.
	_G[DCS_ShowDuraTextureCheck:GetName() .. "Text"]:SetText("Durability Bars")
	
DCS_ShowDuraTextureCheck:SetScript("OnEvent", function(self, event, ...)
	local checked = private.db.dcsdefaults.dejacharacterstatsShowDuraTextureChecked
	self:SetChecked(checked.ShowDuraTextureSetChecked)
	if self:GetChecked(true) then
		if DCS_ShowDuraRepairCheck:GetChecked(true) then
			DCS_Durability_Bar_Textures()
		else
			DCS_Item_Durability()
			DCS_Durability_Bar_Textures()
			for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
				v.durability:SetFormattedText("")
				v.itemrepair:SetFormattedText("")
			end
		end
		if DCS_ShowAverageRepairCheck:GetChecked(true) then
			duraMeanTexture:Show()
		else
			DCS_Mean_Durability()
			duraMeanTexture:Show()
			duraMeanFS:SetFormattedText("")
		end
		private.db.dcsdefaults.dejacharacterstatsShowDuraTextureChecked.ShowDuraTextureSetChecked = true
	else
		for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
			v.duratexture:Hide()
			duraMeanTexture:Hide()
		end
		private.db.dcsdefaults.dejacharacterstatsShowDuraTextureChecked.ShowDuraTextureSetChecked = false
	end
end)

DCS_ShowDuraTextureCheck:SetScript("OnClick", function(self,event,arg1) 
	local checked = private.db.dcsdefaults.dejacharacterstatsShowDuraTextureChecked
	if self:GetChecked(true) then
		if DCS_ShowDuraRepairCheck:GetChecked(true) then
			DCS_Durability_Bar_Textures()
		else
			DCS_Item_Durability()
			DCS_Durability_Bar_Textures()
			for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
				v.durability:SetFormattedText("")
				v.itemrepair:SetFormattedText("")
			end
		end
		if DCS_ShowAverageRepairCheck:GetChecked(true) then
			duraMeanTexture:Show()
		else
			DCS_Mean_Durability()
			duraMeanTexture:Show()
			duraMeanFS:SetFormattedText("")
		end
		private.db.dcsdefaults.dejacharacterstatsShowDuraTextureChecked.ShowDuraTextureSetChecked = true
	else
		for k, v in ipairs(DCSITEM_SLOT_FRAMES) do
			v.duratexture:Hide()
			duraMeanTexture:Hide()
		end
		private.db.dcsdefaults.dejacharacterstatsShowDuraTextureChecked.ShowDuraTextureSetChecked = false
	end
end)

-----------

local _, private = ...
private.defaults.dcsdefaults.dejacharacterstatsShowAverageRepairChecked = {
	ShowAverageRepairSetChecked = false,
}	

local DCS_ShowAverageRepairCheck = CreateFrame("CheckButton", "DCS_ShowAverageRepairCheck", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ShowAverageRepairCheck:RegisterEvent("PLAYER_LOGIN")
    DCS_ShowAverageRepairCheck:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	DCS_ShowAverageRepairCheck:ClearAllPoints()
	DCS_ShowAverageRepairCheck:SetPoint("LEFT", 25, -50)
	DCS_ShowAverageRepairCheck:SetScale(1.25)
	DCS_ShowAverageRepairCheck.tooltipText = "Displays average item durability on the character shirt slot and durability frames." --Creates a tooltip on mouseover.
	_G[DCS_ShowAverageRepairCheck:GetName() .. "Text"]:SetText("Average Durability")
	
	DCS_ShowAverageRepairCheck:SetScript("OnEvent", function(self, event, ...)
		local checked = private.db.dcsdefaults.dejacharacterstatsShowAverageRepairChecked
		self:SetChecked(checked.ShowAverageRepairSetChecked)
		if self:GetChecked(true) then
			DCS_Mean_Durability()
			private.db.dcsdefaults.dejacharacterstatsShowAverageRepairChecked.ShowAverageRepairSetChecked = true
		else
			duraMeanFS:SetFormattedText("")
			duraDurabilityFrameFS:Hide()
			private.db.dcsdefaults.dejacharacterstatsShowAverageRepairChecked.ShowAverageRepairSetChecked = false
		end
	end)

	DCS_ShowAverageRepairCheck:SetScript("OnClick", function(self,event,arg1) 
		local checked = private.db.dcsdefaults.dejacharacterstatsShowAverageRepairChecked
		if self:GetChecked(true) then
			DCS_Mean_Durability()
			private.db.dcsdefaults.dejacharacterstatsShowAverageRepairChecked.ShowAverageRepairSetChecked = true
		else
			duraMeanFS:SetFormattedText("")
			duraDurabilityFrameFS:Hide()
			private.db.dcsdefaults.dejacharacterstatsShowAverageRepairChecked.ShowAverageRepairSetChecked = false
		end
	end)
	
function PaperDollFrame_SetDurability(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

	local displayDura = format("%.2f%%", duraStatMean);

	PaperDollFrame_SetLabelAndText(statFrame, ("Durability"), displayDura, false, duraStatMean);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, format("Durability %s", displayDura));
	statFrame.tooltip2 = ("Average equipped item durability percentage.");

	DCS_Mean_DurabilityStatDisplay()
	local durStatFinite = 0
	statFrame:Show();
end

function PaperDollFrame_SetRepairTotal(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	DCS_Item_RepairTotal()
	local gold = floor(abs(repairitemCostTotal / 10000))
	local silver = floor(abs(mod(repairitemCostTotal / 100, 100)))
	local copper = floor(abs(mod(repairitemCostTotal, 100)))
	--print(format("I have %d gold %d silver %d copper.", gold, silver, copper))

	local displayRepairTotal = format("%dg %ds %dc", gold, silver, copper);

	--STAT_FORMAT
	-- PaperDollFrame_SetLabelAndText(statFrame, label, text, isPercentage, numericValue) -- Formatting

	PaperDollFrame_SetLabelAndText(statFrame, ("Repair Total"), displayRepairTotal, false, repairitemCostTotal);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, format("Repair Total %s", displayRepairTotal));
	statFrame.tooltip2 = ("Total equipped item repair cost before discounts.");

	statFrame:Show();
	repairitemCostTotal = 0
end