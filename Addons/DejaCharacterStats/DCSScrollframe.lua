-- Scroll Frame	

-- Scrollframe Parent Frame
	local DCS_ScrollframeParentFrame = CreateFrame("Frame", nil, CharacterFrameInsetRight)
		DCS_ScrollframeParentFrame:SetSize(198, 352)
		DCS_ScrollframeParentFrame:SetPoint("TOP", CharacterFrameInsetRight, "TOP", 0, -4)

 -- Scrollframe 
	local DCS_ScrollFrame = CreateFrame("ScrollFrame", nil, DCS_ScrollframeParentFrame)
		DCS_ScrollFrame:SetPoint("TOP")
		DCS_ScrollFrame:SetSize(DCS_ScrollframeParentFrame:GetSize())

--	local DCS_scrollframetexture = DCS_ScrollFrame:CreateTexture() 
--		DCS_scrollframetexture:SetAllPoints() 
--		DCS_scrollframetexture:SetColorTexture(.5,.5,.5,1) 

-- DCS_Scrollbar 
	local DCS_Scrollbar = CreateFrame("Slider", nil, DCS_ScrollFrame, "UIPanelScrollBarTemplate") 
		DCS_Scrollbar:SetPoint("TOPLEFT", CharacterFrameInsetRight, "TOPRIGHT", -18, -20) 
		DCS_Scrollbar:SetPoint("BOTTOMLEFT", CharacterFrameInsetRight, "BOTTOMRIGHT", -18, 18) 
		DCS_Scrollbar:SetMinMaxValues(1, 2) 
		DCS_Scrollbar:SetValueStep(1) 
		DCS_Scrollbar.scrollStep = 1
		DCS_Scrollbar:SetValue(0) 
		DCS_Scrollbar:SetWidth(16) 
		DCS_Scrollbar:SetScript("OnValueChanged", function (self, value) 
			self:GetParent():SetVerticalScroll(value) 
		end) 
--		DCS_Scrollbar:Hide() 

 -- Scrollbar Check

	local _, private = ...
	private.defaults.dcsdefaults.dejacharacterstatsScrollbarChecked = {
		ScrollbarSetChecked = false,
	}	
	
local DCS_ScrollbarCheck = CreateFrame("CheckButton", "DCS_ScrollbarCheck", DejaCharacterStatsPanel, "InterfaceOptionsCheckButtonTemplate")
	DCS_ScrollbarCheck:RegisterEvent("PLAYER_LOGIN")
	DCS_ScrollbarCheck:ClearAllPoints()
	DCS_ScrollbarCheck:SetPoint("LEFT", 25, -100)
	DCS_ScrollbarCheck:SetScale(1.25)
	DCS_ScrollbarCheck.tooltipText = 'Displays the DCS scrollbar.' --Creates a tooltip on mouseover.
	_G[DCS_ScrollbarCheck:GetName() .. "Text"]:SetText("Scrollbar")
	
	DCS_ScrollbarCheck:SetScript("OnEvent", function(self, event, arg1)
		if event == "PLAYER_LOGIN" then
		local checked = private.db.dcsdefaults.dejacharacterstatsScrollbarChecked
			self:SetChecked(checked.ScrollbarSetChecked)
			if self:GetChecked(true) then
				DCS_Scrollbar:Show() 
				private.db.dcsdefaults.dejacharacterstatsScrollbarChecked.ScrollbarSetChecked = true
			else
				DCS_Scrollbar:Hide() 
				private.db.dcsdefaults.dejacharacterstatsScrollbarChecked.ScrollbarSetChecked = false
			end
		end
	end)

	DCS_ScrollbarCheck:SetScript("OnClick", function(self,event,arg1) 
		local checked = private.db.dcsdefaults.dejacharacterstatsScrollbarChecked
		if self:GetChecked(true) then
			DCS_Scrollbar:Show() 
			private.db.dcsdefaults.dejacharacterstatsScrollbarChecked.ScrollbarSetChecked = true
		else
			DCS_Scrollbar:Hide() 
			private.db.dcsdefaults.dejacharacterstatsScrollbarChecked.ScrollbarSetChecked = false
		end
	end)
 
-- DCS_ScrollChild Frame
	local DCS_ScrollChild = CreateFrame("Frame", nil, DCS_ScrollFrame)
		DCS_ScrollChild:SetSize(DCS_ScrollFrame:GetSize())
		DCS_ScrollFrame:SetScrollChild(DCS_ScrollChild)

-- 	Debugging Texture
--	local DCS_ScrollChildtexture = DCS_ScrollChild:CreateTexture() 
--		DCS_ScrollChildtexture:SetAllPoints(DCS_ScrollChild) 
--		DCS_ScrollChildtexture:SetColorTexture(.5,.5,.5,1) 
--		DCS_ScrollChildtexture:SetTexture("Interface\\GLUES\\MainMenu\\Glues-BlizzardLogo") 

	CharacterStatsPane:ClearAllPoints()
	CharacterStatsPane:SetParent(DCS_ScrollChild)
	CharacterStatsPane:SetSize(DCS_ScrollChild:GetSize())
	CharacterStatsPane:SetPoint("TOP", DCS_ScrollChild, "TOP", 0, 0) 

	CharacterStatsPane.ClassBackground:ClearAllPoints()
	CharacterStatsPane.ClassBackground:SetParent(CharacterFrameInsetRight)
	CharacterStatsPane.ClassBackground:SetPoint("CENTER")
	
-- Enable mousewheel scrolling
	DCS_ScrollFrame:EnableMouseWheel(true)
	DCS_ScrollFrame:SetScript("OnMouseWheel", function(self, delta)
		if DCS_ShowAllStatsCheck:GetChecked(true) then
			DCS_Scrollbar:SetMinMaxValues(1, 128) 
		elseif DCS_SelectStatsCheck:GetChecked(true) then
			DCS_Scrollbar:SetMinMaxValues(1, 142) 
		elseif not DCS_ShowAllStatsCheck:GetChecked(true) then
			DCS_Scrollbar:SetMinMaxValues(1, 34) 
		end
			
		local cur_val = DCS_Scrollbar:GetValue()
		local min_val, max_val = DCS_Scrollbar:GetMinMaxValues()

		if delta < 0 and cur_val < max_val then
			if IsShiftKeyDown() then
				if DCS_ShowAllStatsCheck:GetChecked(true) then
					DCS_Scrollbar:SetValue(128)
				elseif DCS_SelectStatsCheck:GetChecked(true) then
					DCS_Scrollbar:SetValue(142)
				elseif not DCS_ShowAllStatsCheck:GetChecked(true) then
					DCS_Scrollbar:SetValue(34)
				end
			else
				cur_val = math.min(max_val, cur_val + 22)
				DCS_Scrollbar:SetValue(cur_val)
			end
		elseif delta > 0 and cur_val > min_val then
			if IsShiftKeyDown() then
				DCS_Scrollbar:SetValue(0)
			else
				cur_val = math.max(min_val, cur_val - 22)
				DCS_Scrollbar:SetValue(cur_val)
			end
		end
	end)
	
-- DejaCharacterStats
  
	CharacterStatsPane.ItemLevelCategory:Hide()
	CharacterStatsPane.ItemLevelCategory.Title:Hide()
	CharacterStatsPane.ItemLevelCategory.Background:Hide()

	CharacterStatsPane.ItemLevelFrame:ClearAllPoints()
	CharacterStatsPane.ItemLevelFrame:SetWidth(186)
	CharacterStatsPane.ItemLevelFrame:SetHeight(28)
	CharacterStatsPane.ItemLevelFrame:SetPoint(
		"TOP", CharacterStatsPane, "TOP", 0, -8)

	CharacterStatsPane.ItemLevelFrame.Background:ClearAllPoints()
	CharacterStatsPane.ItemLevelFrame.Background:SetWidth(186)
	CharacterStatsPane.ItemLevelFrame.Background:SetHeight(28)
	CharacterStatsPane.ItemLevelFrame.Background:SetPoint(
		"CENTER", CharacterStatsPane.ItemLevelFrame, "CENTER", 0, 0)

	CharacterStatsPane.ItemLevelFrame.Value:SetFont(
		"Fonts\\FRIZQT__.TTF", 22, "THINOUTLINE")

	hooksecurefunc(CharacterStatsPane.AttributesCategory,"SetPoint",function(self,_,_,_,_,_,flag)
		if flag~="CharacterStatsPane" then
			self:ClearAllPoints()
			self:SetWidth(186)
			self:SetHeight(28)
			self:SetPoint(
				"TOP", CharacterStatsPane.ItemLevelFrame, "BOTTOM", 0, -2, "CharacterStatsPane")
			-- Reset DCS_Scrollbar when the CharacterStatsPane is closed and reopened.
			DCS_Scrollbar:SetValue(0) 
		end
	end)

	hooksecurefunc(CharacterStatsPane.AttributesCategory.Background,"SetPoint",function(self,_,_,_,_,_,flag)
		if flag~="CharacterStatsPane" then
			self:ClearAllPoints()
			self:SetPoint(
				"CENTER", CharacterStatsPane.AttributesCategory, "CENTER", 0, 2, "CharacterStatsPane")
		end
	end)
	
	CharacterStatsPane.AttributesCategory.Background:SetWidth(186)
	CharacterStatsPane.AttributesCategory.Background:SetHeight(28)
		
	CharacterStatsPane.EnhancementsCategory:SetWidth(186)
	CharacterStatsPane.EnhancementsCategory:SetHeight(28)

	CharacterStatsPane.EnhancementsCategory.Background:SetWidth(186)
	CharacterStatsPane.EnhancementsCategory.Background:SetHeight(28)
	
	PaperDollSidebarTab1:HookScript("OnShow", function(self,event) 
		DCS_ScrollframeParentFrame:Show()
	end)

	PaperDollSidebarTab1:HookScript("OnClick", function(self,event) 
		DCS_ScrollframeParentFrame:Show()
	end)
	
	PaperDollSidebarTab2:HookScript("OnClick", function(self,event) 
		DCS_ScrollframeParentFrame:Hide()
	end)