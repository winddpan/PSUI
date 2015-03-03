local _, Addon = ...

local API = Addon.API
local GarrisonFollowerTooltip_Owner = Addon.GarrisonFollowerTooltip_Owner
local FGFTData = {}
local GFTData = {}
local AbilitiesData
local strLPair = Addon.L.AbilityPair

local GetFollowerAbilityCounterMechanicInfo = C_Garrison.GetFollowerAbilityCounterMechanicInfo

local bShiftKeyDown
local bAltKeyDown
local frameCheckModifier = CreateFrame("Frame")
local tModifierCheck
local TooltipMode = 0 --0="NORMAL",1="SHIFT",2="ALT"

local function UpdateFollowerTooltips()
	if FloatingGarrisonFollowerTooltip:IsShown() then
		GarrisonFollowerTooltipTemplate_SetGarrisonFollower(FloatingGarrisonFollowerTooltip, FGFTData)
	end
	if GarrisonFollowerTooltip:IsShown() and (GFTData.noAbilityDescriptions ~= true) then
		GarrisonFollowerTooltipTemplate_SetGarrisonFollower(GarrisonFollowerTooltip, GFTData);
	end
end
local function ModifierStateChanged(self, event, key, state)
	if key ~= "LSHIFT" and key ~= "RSHIFT" and key ~= "LALT" and key ~= "RALT" then
		return
	end
	bShiftKeyDown = IsShiftKeyDown()
	bAltKeyDown = IsAltKeyDown()
	
	if (not bShiftKeyDown) and (not bAltKeyDown) then
		TooltipMode = 0	--NORMAL
	elseif bShiftKeyDown and (not bAltKeyDown) then
		TooltipMode = 1	--SHIFT
	elseif (not bShiftKeyDown) and bAltKeyDown then
		TooltipMode = 2	--ALT
	end
	
	UpdateFollowerTooltips()
end
local function ModifierStateCheck(self, elapsed)
	if tModifierCheck and tModifierCheck < 1 then
		tModifierCheck = tModifierCheck + elapsed
		return
	end
	
	tModifierCheck = 0
	if bShiftKeyDown ~= IsShiftKeyDown() then
		ModifierStateChanged(nil, "MODIFIER_STATE_CHANGED", "LSHIFT", bShiftKeyDown and 0 or 1)
	end
	if bAltKeyDown ~= IsAltKeyDown() then
		ModifierStateChanged(nil, "MODIFIER_STATE_CHANGED", "LALT", bAltKeyDown and 0 or 1)
	end
end
frameCheckModifier:RegisterEvent("MODIFIER_STATE_CHANGED")
frameCheckModifier:SetScript("OnEvent", ModifierStateChanged)
frameCheckModifier:SetScript("OnUpdate", ModifierStateCheck)

local function GetAbilityPairIndex(c1, c2)
	if c1 > c2 then
		c1, c2 = c2, c1
	end
	
	return c1 * 100 + c2
end
local function GetAbilityPairNum(c1, c2)
	local ix = GetAbilityPairIndex(c1, c2)
	local nActive, nInactive
	
	if AbilitiesData.Pair[ix] then
		nActive = #AbilitiesData.Pair[ix][1]
		nInactive = #AbilitiesData.Pair[ix][2]
	else
		nActive = 0
		nInactive = 0
	end
	
	return nActive, nInactive, nActive+nInactive
end
local tAbilitiesDataUpdate
local function UpdateAbilitiesData(self, elapsed)
	if UnitLevel("player") < 90 then
		return
	end
	
	if tAbilitiesDataUpdate and elapsed and tAbilitiesDataUpdate < 1 then
		tAbilitiesDataUpdate = tAbilitiesDataUpdate + elapsed
		return
	end
	tAbilitiesDataUpdate = 0
	
	local followers = C_Garrison.GetFollowers()
	if not AbilitiesData then
		AbilitiesData = {}
		AbilitiesData.Count = {}
		AbilitiesData.Pair = {}
	end
	
	--  clear old data
	local wipe = wipe
	local tinsert = table.insert
	for _, t in pairs(AbilitiesData.Count) do
		wipe(t[1])
		wipe(t[2])
	end
	for _, t in pairs(AbilitiesData.Pair) do
		wipe(t[1])
		wipe(t[2])
	end
	
	local follower, id, aid, ix, gid, updateData
	local abilities = {}
	for i = 1, #followers do
		follower = followers[i]
		wipe(abilities)
		if follower.isCollected then
			id = follower.followerID
			for j = 1, 4 do
				aid = C_Garrison.GetFollowerAbilityAtIndex(id, j)
				if aid and aid > 0 then
					aid = GetFollowerAbilityCounterMechanicInfo(aid)
					tinsert(abilities, aid)
					
					if not AbilitiesData.Count[aid] then
						AbilitiesData.Count[aid] = {{}, {}}
					end
					if follower.status ~= GARRISON_FOLLOWER_INACTIVE then
						tinsert(AbilitiesData.Count[aid][1], id)
					else
						tinsert(AbilitiesData.Count[aid][2], id)
					end
				end
			end
			if #abilities == 2 then
				ix = GetAbilityPairIndex(unpack(abilities))
				
				if not AbilitiesData.Pair[ix] then
					AbilitiesData.Pair[ix] = {{}, {}}
				end
				if follower.status ~= GARRISON_FOLLOWER_INACTIVE then
					tinsert(AbilitiesData.Pair[ix][1], id)
				else
					tinsert(AbilitiesData.Pair[ix][2], id)
				end
			end
			
			-- Update GarrisonFollowerTooltip because it may change
			gid = follower.garrFollowerID
			if GarrisonFollowerTooltip:IsShown() and GFTData.garrisonFollowerID == gid and (GFTData.noAbilityDescriptions ~= true) then
				updateData = {gid, follower.isCollected, follower.quality, follower.level, follower.xp, follower.levelXP, follower.iLevel, C_Garrison.GetFollowerAbilityAtIndex(id, 1), C_Garrison.GetFollowerAbilityAtIndex(id, 2), C_Garrison.GetFollowerAbilityAtIndex(id, 3), C_Garrison.GetFollowerAbilityAtIndex(id, 4), C_Garrison.GetFollowerTraitAtIndex(id, 1), C_Garrison.GetFollowerTraitAtIndex(id, 2), C_Garrison.GetFollowerTraitAtIndex(id, 3), C_Garrison.GetFollowerTraitAtIndex(id, 4), GFTData.noAbilityDescriptions}
			end
		end
	end
	if updateData then
		GarrisonFollowerTooltip_Show(unpack(updateData))
		wipe(updateData)
	end
	collectgarbage("collect")
end
local function ModifyAbilityDetailsText(fontString, ab)
	local cid, cname = GetFollowerAbilityCounterMechanicInfo(ab)
	local nActive, nInactive
	
	if AbilitiesData.Count[cid] then
		nActive = #AbilitiesData.Count[cid][1]
		nInactive = #AbilitiesData.Count[cid][2]
	else
		nActive = 0
		nInactive = 0
	end
	fontString:SetFormattedText("%s(%d/%d)", cname, nActive, nActive + nInactive)
end
local function SetAbilityPairText(fontString, ab1, ab2)
	local c1 = GetFollowerAbilityCounterMechanicInfo(ab1)
	local c2 = GetFollowerAbilityCounterMechanicInfo(ab2)
	local nActive, nTotal
	
	nActive, _, nTotal = GetAbilityPairNum(c1, c2)
	
	fontString:SetFormattedText(strLPair, nActive, nTotal)
end
local fAbilitiesDataUpdate = CreateFrame("Frame")
local bUpdateHasSet = false
fAbilitiesDataUpdate:RegisterEvent("GARRISON_UPDATE")
fAbilitiesDataUpdate:RegisterEvent("GARRISON_FOLLOWER_ADDED")
fAbilitiesDataUpdate:RegisterEvent("GARRISON_FOLLOWER_REMOVED")
fAbilitiesDataUpdate:SetScript("OnEvent", function() UpdateAbilitiesData() end)
local function ModifyFollowerTooltip(tooltipFrame, data)
	local backup
	if tooltipFrame == FloatingGarrisonFollowerTooltip then
		backup = FGFTData
	elseif tooltipFrame == GarrisonFollowerTooltip then
		backup = GFTData
	end
	if backup then
		for k, _ in pairs(data) do
			backup[k] = data[k]
		end
	end
	
	local abilities = {data.ability1, data.ability2, data.ability3, data.ability4}
	local traits = {data.trait1, data.trait2, data.trait3, data.trait4};
	local detailed = not data.noAbilityDescriptions
	local cAbility , cTrait = 0, 0
	local Ability, abilityCounterMechanicName, abilityCounterMechanicIcon, Trait
	local tooltipFrameHeight = tooltipFrame:GetHeight()
	
	local abiSpec = Addon.abiSpec[data.spec]
	local otherAbilities = {}
	local bHasGot, bShowPairInfo, bShowCurrentPairInfo
	
	local tooltipFrameHeightBase = 80;					-- this is the tooltip frame height w/ no abilities/traits being displayed
	local abilityOffset = 10;							-- distance between ability entries
	local abilityFrameHeightBase = 20;					-- ability frame height w/ no description/details being displayed
	local spacingBetweenLabelAndFirstAbility = 8;		-- distance between the &quot;Abilities&quot; label and the first ability below it
	local spacingBetweenNameAndDescription = 4;			-- must match the XML ability template setting
	local spacingBetweenDescriptionAndDetails = 8;		-- must match the XML ability template setting
	local labelPairXOffset = 15;
	local tOffset
	local followerSpecName, followerRaceName
	
	tooltipFrame.Name:SetWordWrap(false)
	tooltipFrame.Name:SetPoint("RIGHT")
	tooltipFrame.ClassSpecName:SetWordWrap(false)
	tooltipFrame.ClassSpecName:SetPoint("RIGHT")
	
	if ( data.spec ) then
		followerSpecName = C_Garrison.GetFollowerClassSpecName(data.garrisonFollowerID)
		followerRaceName = API.GetRaceName(data.garrisonFollowerID)
		tooltipFrame.ClassSpecName:SetFormattedText("%s %s", followerRaceName, followerSpecName)
	end
	
	for i = 1, 4 do
		if abilities[i] and abilities[i] > 0 then
			cAbility = cAbility + 1
		end
		if traits[i] and traits[i] > 0 then
			cTrait = cTrait + 1
		end
	end
	for i = 1, cAbility do
		Ability = tooltipFrame.Abilities[i];
		if not detailed then
			tooltipFrameHeight = tooltipFrameHeight - Ability:GetHeight();

			Ability.Details:Show();	
			
			_, abilityCounterMechanicName, abilityCounterMechanicIcon = GetFollowerAbilityCounterMechanicInfo(abilities[i]);
			Ability.Details:SetFormattedText(GARRISON_ABILITY_COUNTERS_FORMAT, abilityCounterMechanicName);
			Ability:SetHeight(Ability:GetHeight() + Ability.Details:GetHeight() + spacingBetweenDescriptionAndDetails);

			Ability.CounterIcon:SetTexture(abilityCounterMechanicIcon);
			Ability.CounterIcon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask");
			Ability.CounterIcon:SetPoint("TOPLEFT", Ability.Name, "BOTTOMLEFT", 0, -spacingBetweenDescriptionAndDetails)
			Ability.CounterIcon:Show();
			Ability.CounterIconBorder:Show();
			
			tooltipFrameHeight = tooltipFrameHeight + Ability:GetHeight();
		else
			Ability.CounterIcon:SetPoint("TOPLEFT", Ability.Description, "BOTTOMLEFT", 0, -spacingBetweenDescriptionAndDetails)
			ModifyAbilityDetailsText(Ability.Details, abilities[i])
		end
	end
	
	for i = 1, #abiSpec do
		bHasGot = false
		for j = 1, cAbility do
			if abiSpec[i] == abilities[j] then
				bHasGot = true
			end
		end
		if not bHasGot then
			otherAbilities[#otherAbilities+1] = abiSpec[i] 
		end
	end
	
	tooltipFrame.labelAbilityPair = tooltipFrame.labelAbilityPair or tooltipFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	local labelPair = tooltipFrame.labelAbilityPair
	bShowCurrentPairInfo = detailed and cAbility == 2
	
	if bShowCurrentPairInfo then
		labelPair:SetPoint("TOPLEFT", tooltipFrame.Abilities[2], "BOTTOMLEFT", labelPairXOffset, -abilityOffset);
		SetAbilityPairText(labelPair, abilities[1], abilities[2])
		tooltipFrameHeight = tooltipFrameHeight + labelPair:GetHeight() + abilityOffset
		labelPair:Show()
		
		tooltipFrame.TraitsLabel:SetPoint("TOPLEFT", labelPair, "BOTTOMLEFT", -labelPairXOffset, -abilityOffset);
	else
		labelPair:Hide()
	end
	
	tooltipFrame.OtherAbilitiesLabel = tooltipFrame.OtherAbilitiesLabel or tooltipFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	local label = tooltipFrame.OtherAbilitiesLabel
	label:SetJustifyH("LEFT")
	
	if cTrait > 0 and (TooltipMode == 0) then
		label:SetPoint("TOPLEFT", tooltipFrame.Traits[cTrait], "BOTTOMLEFT", 0, -abilityOffset);
	elseif bShowCurrentPairInfo then
		label:SetPoint("TOPLEFT", labelPair, "BOTTOMLEFT", -labelPairXOffset, -abilityOffset);
	elseif cAbility > 0 then
		label:SetPoint("TOPLEFT", tooltipFrame.Abilities[cAbility], "BOTTOMLEFT", 0, -abilityOffset);
	else
		label:SetPoint("TOPLEFT", tooltipFrame, "TOPLEFT", 15, -tooltipFrameHeightBase - 5);
	end
	
	tooltipFrame.OtherAbilities = tooltipFrame.OtherAbilities or {}
	for i = 1, #tooltipFrame.OtherAbilities do
		tooltipFrame.OtherAbilities[i]:Hide()
	end
	
	tooltipFrame.EpicRetrainingPairs = tooltipFrame.EpicRetrainingPairs or {}
	for i = 1, #tooltipFrame.EpicRetrainingPairs do
		tooltipFrame.EpicRetrainingPairs[i]:Hide()
	end
	
	local color, description, id, pair
	
	if #otherAbilities > 0 and detailed then
		if TooltipMode ~= 0 then
			-- Hide traits
			if cTrait > 0 then 
				tooltipFrameHeight = tooltipFrameHeight - tooltipFrame.TraitsLabel:GetHeight() - abilityOffset
				for i = 1, cTrait do
					Trait = tooltipFrame.Traits[i]
					tooltipFrameHeight = tooltipFrameHeight - Trait:GetHeight() - ((i == 1) and spacingBetweenLabelAndFirstAbility or abilityOffset)
					Trait:Hide()
				end
			end
			tooltipFrame.TraitsLabel:Hide();
		end
		if TooltipMode == 1 then
			bShowPairInfo = detailed and cAbility == 1
			label:SetText(Addon.L.ShiftDown)
			color = NORMAL_FONT_COLOR
			label:SetVertexColor(color.r, color.g, color.b);
			
			for i = 1, #otherAbilities do
				tooltipFrame.OtherAbilities[i] = tooltipFrame.OtherAbilities[i] or CreateFrame("Frame", nil, tooltipFrame, "GarrisonFollowerAbilityTemplate")
				Ability = tooltipFrame.OtherAbilities[i]
				id = otherAbilities[i]
				
				if i == 1 then
					Ability:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -spacingBetweenLabelAndFirstAbility)
					tooltipFrameHeight = tooltipFrameHeight + spacingBetweenLabelAndFirstAbility
				else
					pair = tooltipFrame.OtherAbilities[i-1].pair
					if pair and pair:IsShown() then
						tOffset = abilityOffset - spacingBetweenDescriptionAndDetails + spacingBetweenNameAndDescription
					else
						tOffset = abilityOffset
					end
					Ability:SetPoint("TOPLEFT", tooltipFrame.OtherAbilities[i-1], "BOTTOMLEFT", 0, -tOffset)
					tooltipFrameHeight = tooltipFrameHeight + tOffset
				end
				Ability.Name:SetText(C_Garrison.GetFollowerAbilityName(id))
				Ability.Icon:SetTexture(C_Garrison.GetFollowerAbilityIcon(id))
				Ability:SetHeight(abilityFrameHeightBase)
				
				Ability.Details:Show();	
				_, abilityCounterMechanicName, abilityCounterMechanicIcon = GetFollowerAbilityCounterMechanicInfo(id);
				Ability.Details:SetFormattedText(GARRISON_ABILITY_COUNTERS_FORMAT, abilityCounterMechanicName);
				ModifyAbilityDetailsText(Ability.Details, otherAbilities[i])
				Ability:SetHeight(Ability:GetHeight() + Ability.Details:GetHeight() + spacingBetweenDescriptionAndDetails);
				
				Ability.CounterIcon:SetTexture(abilityCounterMechanicIcon);
				Ability.CounterIcon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask");
				Ability.CounterIcon:Show();
				Ability.CounterIconBorder:Show();
			
				Ability.Description:Show();
				description = C_Garrison.GetFollowerAbilityDescription(otherAbilities[i]);
				if string.len(description) == 0 then description = "PH - Description Missing"; end
				Ability.Description:SetText(description);
				Ability:SetHeight(Ability:GetHeight() + Ability.Description:GetHeight() + spacingBetweenNameAndDescription);
				Ability.CounterIcon:SetPoint("TOPLEFT", Ability.Description, "BOTTOMLEFT", 0, -spacingBetweenDescriptionAndDetails)
				
				Ability.pair = Ability.pair or Ability:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
				pair = Ability.pair
				pair:SetPoint("LEFT", Ability, labelPairXOffset, 0)
				pair:SetPoint("TOP", Ability.Details, "BOTTOM", 0, -spacingBetweenDescriptionAndDetails)
				
				if bShowPairInfo then
					pair:Show()
					SetAbilityPairText(pair, abilities[1], id)
					Ability:SetHeight(Ability:GetHeight() + pair:GetHeight() + spacingBetweenDescriptionAndDetails)
				else
					pair:Hide()
				end

				Ability:Show();

				tooltipFrameHeight = tooltipFrameHeight + Ability:GetHeight();
			end
			tooltipFrameHeight = tooltipFrameHeight + label:GetHeight() + abilityOffset;
		elseif TooltipMode == 2 then
			local RetrainingPair
			local idC1, idC2, iconC1, iconC2
			local idPair, colorPair, idAbilCurrent
			local nActive, nTotal
			local idRP = 0
			if cAbility == 2 then
				idC1 = GetFollowerAbilityCounterMechanicInfo(abilities[1])
				idC2 = GetFollowerAbilityCounterMechanicInfo(abilities[2])
				idAbilCurrent = GetAbilityPairIndex(idC1, idC2)
			elseif cAbility == 1 then
				idAbilCurrent = abilities[1]
			end
			label:SetText(Addon.L.AltDown)
			color = NORMAL_FONT_COLOR
			label:SetVertexColor(color.r, color.g, color.b)
			
			for i = 1, #abiSpec do
				for j = i + 1, #abiSpec do 
					idRP = idRP + 1
					RetrainingPair = tooltipFrame.EpicRetrainingPairs[idRP]
					if not RetrainingPair then
						RetrainingPair = CreateFrame("Frame", nil, tooltipFrame)
						RetrainingPair:SetSize(20, 20)
						--RetrainingPair.CounterIcon1 = CreateFrame("Button", nil, RetrainingPair, "GarrisonAbilityCounterTemplate")
						--RetrainingPair.CounterIcon2 = CreateFrame("Button", nil, RetrainingPair, "GarrisonAbilityCounterTemplate")
						RetrainingPair.CounterIcon1 = RetrainingPair:CreateTexture()
						RetrainingPair.CounterIcon1:SetSize(20, 20)
						RetrainingPair.CounterIcon1:SetDrawLayer("ARTWORK", -1)
						RetrainingPair.CounterIcon1Border = RetrainingPair:CreateTexture()
						RetrainingPair.CounterIcon1Border:SetAtlas("GarrMission_EncounterAbilityBorder")
						RetrainingPair.CounterIcon1Border:SetPoint("CENTER", RetrainingPair.CounterIcon1, "CENTER")
						RetrainingPair.CounterIcon1Border:SetSize(30, 30)
						
						RetrainingPair.CounterIcon2 = RetrainingPair:CreateTexture()
						RetrainingPair.CounterIcon2:SetSize(20, 20)
						RetrainingPair.CounterIcon2:SetDrawLayer("ARTWORK", -1)
						RetrainingPair.CounterIcon2Border = RetrainingPair:CreateTexture()
						RetrainingPair.CounterIcon2Border:SetAtlas("GarrMission_EncounterAbilityBorder")
						RetrainingPair.CounterIcon2Border:SetPoint("CENTER", RetrainingPair.CounterIcon2, "CENTER")
						RetrainingPair.CounterIcon2Border:SetSize(30, 30)
						
						RetrainingPair.Text = RetrainingPair:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
						tooltipFrame.EpicRetrainingPairs[idRP] = RetrainingPair
					end
					
					if idRP == 1 then
						RetrainingPair:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 5, -spacingBetweenLabelAndFirstAbility)
					elseif idRP == 2 then
						RetrainingPair:SetPoint("TOPLEFT", tooltipFrame.EpicRetrainingPairs[1], "TOPLEFT", 120, 0)
					else
						RetrainingPair:SetPoint("TOPLEFT", tooltipFrame.EpicRetrainingPairs[idRP-2], "BOTTOMLEFT", 0, -10)
					end
					
					idC1, _, iconC1 = GetFollowerAbilityCounterMechanicInfo(abiSpec[i]);
					idC2, _, iconC2 = GetFollowerAbilityCounterMechanicInfo(abiSpec[j]);
					
					RetrainingPair.CounterIcon1:SetPoint("TOPLEFT");
					RetrainingPair.CounterIcon1:SetTexture(iconC1);
					
					RetrainingPair.CounterIcon2:SetPoint("TOPLEFT", RetrainingPair.CounterIcon1, "TOPRIGHT", 5, 0)
					RetrainingPair.CounterIcon2:SetTexture(iconC2);
					
					idPair = GetAbilityPairIndex(idC1, idC2)
					nActive, _, nTotal = GetAbilityPairNum(idC1, idC2)
					RetrainingPair.Text:SetPoint("LEFT", RetrainingPair.CounterIcon2, "RIGHT", 5, 0)
					RetrainingPair.Text:SetFormattedText("%d/%d", nActive, nTotal)
					if cAbility == 2 then
						colorPair = (idPair == idAbilCurrent) and NORMAL_FONT_COLOR or HIGHLIGHT_FONT_COLOR
					elseif cAbility == 1 then
						if idAbilCurrent == abiSpec[i] or idAbilCurrent == abiSpec[j] then
							colorPair = NORMAL_FONT_COLOR
						else
							colorPair = HIGHLIGHT_FONT_COLOR
						end
					else
						colorPair = HIGHLIGHT_FONT_COLOR
					end
					RetrainingPair.Text:SetVertexColor(colorPair.r, colorPair.g, colorPair.b);
					
					RetrainingPair:Show()
				end
			end
			tooltipFrameHeight = tooltipFrameHeight + label:GetHeight() + abilityOffset + 30*math.ceil(idRP/2)
		else
			label:SetText(Addon.L.UnPressed)
			color = ITEM_QUALITY_COLORS[3]
			label:SetVertexColor(color.r, color.g, color.b);
			
			tooltipFrameHeight = tooltipFrameHeight + label:GetHeight();
			
			bShowPairInfo = false
		end
		label:Show()
	else
		label:Hide()
	end
	
	if not detailed then
		tooltipFrame:SetHeight(tooltipFrameHeight - 5);
	else
		tooltipFrame:SetHeight(tooltipFrameHeight + 5);
	end
end
hooksecurefunc("GarrisonFollowerTooltipTemplate_SetGarrisonFollower", ModifyFollowerTooltip)

local function FollowerButton_OnEnter(self)
	local info = self.info
	local fid = info.followerID
	local abilities = {0, 0, 0, 0}
	local traits = {0, 0, 0, 0}
	local GetAbility = info.garrFollowerID and C_Garrison.GetFollowerAbilityAtIndex or C_Garrison.GetFollowerAbilityAtIndexByID
	local GetTrait = info.garrFollowerID and C_Garrison.GetFollowerTraitAtIndex or C_Garrison.GetFollowerTraitAtIndexByID
	
	for i = 1, 4 do
		abilities[i] = GetAbility(fid, i)
		traits[i] = GetTrait(fid, i)
	end
	
	GarrisonFollowerTooltip_Owner = self
	GarrisonFollowerTooltip:ClearAllPoints()
	GarrisonFollowerTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT")
	
	GarrisonFollowerTooltip_Show(info.garrFollowerID or info.followerID, info.isCollected, info.quality, info.level, info.xp, info.levelXP, info.iLevel, abilities[1], abilities[2], abilities[3], abilities[4], traits[1], traits[2], traits[3], traits[4], false)
end
local function FollowerButton_OnLeave(self)
	if GarrisonFollowerTooltip_Owner == self then
		GarrisonFollowerTooltip:Hide()
		GarrisonFollowerTooltip_Owner = nil
	end
end
local function FollowerList_OnMouseWheel(self)
	local buttons = self.buttons
	
	if GarrisonFollowerTooltip_Owner then
		FollowerButton_OnLeave(GarrisonFollowerTooltip_Owner)
	end
	for i = 1, #buttons do
		if GetMouseFocus() == buttons[i] then
			FollowerButton_OnEnter(buttons[i])
			return
		end
	end
end

local function HookFollowerButton(FollowerButton)
	FollowerButton:HookScript("OnEnter", FollowerButton_OnEnter)
	FollowerButton:HookScript("OnLeave", FollowerButton_OnLeave)
end
local function HookGarrisonFrame(GarrisonFrame)
	local buttons = GarrisonFrame.FollowerList.listScroll.buttons
	for i = 1, #buttons do
		HookFollowerButton(buttons[i])
	end
	GarrisonFrame.FollowerList.listScroll:HookScript("OnMouseWheel", FollowerList_OnMouseWheel)
	
	GarrisonFrame:HookScript("OnShow", function() fAbilitiesDataUpdate:SetScript("OnUpdate", UpdateAbilitiesData) end)
	GarrisonFrame:HookScript("OnHide", function() fAbilitiesDataUpdate:SetScript("OnUpdate", nil) end)
end

local function ShowRaceNameOnFollowerPage(self, followerID)
	local followerInfo = C_Garrison.GetFollowerInfo(followerID)
	local followerSpecName, followerRaceName
	if followerInfo then
		followerSpecName = followerInfo.className
		followerRaceName = API.GetRaceName(followerInfo.garrFollowerID or followerID)
		self.ClassSpec:SetFormattedText("%s %s", followerRaceName, followerSpecName)
	end
end

function Addon.LoadWithUI.FollowerTooltip()
	HookGarrisonFrame(GarrisonMissionFrame)
	HookGarrisonFrame(GarrisonLandingPage)
	HookGarrisonFrame(GarrisonRecruitSelectFrame)
	
	hooksecurefunc("GarrisonFollowerPage_ShowFollower", ShowRaceNameOnFollowerPage)
end
