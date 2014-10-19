local addon, ns = ...
local cfg = ns.cfg
local init = ns.init
local panel = CreateFrame("Frame", nil, UIParent)

if cfg.Spec == true then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("HIGH")
	Stat:SetFrameLevel(3)
	 
	local Text = panel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(unpack(cfg.Fonts))
	Text:SetPoint(unpack(cfg.SpecPoint))
	 
	local function SetTitle()
		if not GetSpecialization() then
			Text:SetText(cfg.ColorClass and init.Colored.."No Talents" or "No Talents") 
		return end
		local tree1 = select(5,GetSpecializationInfo(1))
		local tree2 = select(5,GetSpecializationInfo(2))
		local tree3 = select(5,GetSpecializationInfo(3))
		--local primaryTree = GetSpecialization()
		local text = cfg.ColorClass and init.Colored..select(2,GetSpecializationInfo(GetSpecialization(false,false))) or select(2,GetSpecializationInfo(GetSpecialization(false,false)))
		Text:SetText(text)
	end
	
	local function Update(self, t)
	end

	local function Checktalentgroup(index)
		return GetSpecialization(false,false,index)
	end

	local function OnEvent(self, event, ...)
		SetTitle()
		
		if event == "PLAYER_LOGIN" then
			self:UnregisterEvent("PLAYER_LOGIN")
		end

		-- Setup Talents Tooltip
		self:SetAllPoints(Text)
		self:SetScript("OnEnter", function(self)
				local c = GetActiveSpecGroup(false,false)
				local majorTree1 = GetSpecialization(false,false,1)
				local spec1 = { }
				for i = 1, 7 do 
					for j =1, 3 do
						local id, name, texture, selected, available = GetTalentInfo(i,j,1)
						if selected then
							table.insert(spec1,name)
						end
					end
				end
				local majorTree2 = GetSpecialization(false,false,2)
				local spec2 = { }
				for i = 1, 7 do 
					for j =1, 3 do
						local id, name, texture, selected, available = GetTalentInfo(i,j,2)
						if selected then
							table.insert(spec2,name)
						end
					end
				end
				GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 6)
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(TALENTS_BUTTON,0,.6,1)
				GameTooltip:AddLine(" ")
				
				if GetNumSpecGroups() == 1 then
					GameTooltip:AddLine("|cff00FF00* |r" .. (GetSpecialization() and select(2,GetSpecializationInfo(majorTree1)) or infoL["none"])..": ",1,1,1)
					for i = 1, #spec1 do
						GameTooltip:AddDoubleLine(" ",init.Colored..spec1[i],1,1,1,1,1,1)
					end
				else
					GameTooltip:AddLine("|cff00FF00"..(c == 1 and "* " or "   ") .. "|r" .. select(2,GetSpecializationInfo(majorTree1))..": ",1,1,1)
					for i = 1, #spec1 do
						GameTooltip:AddDoubleLine(" ",init.Colored..spec1[i],1,1,1,1,1,1)
					end
					GameTooltip:AddLine("|cff00FF00"..(c == 2 and "* " or "   ") .. "|r" .. select(2,GetSpecializationInfo(majorTree2))..": ",1,1,1)
					for i = 1, #spec2 do
						GameTooltip:AddDoubleLine(" ",init.Colored..spec2[i],1,1,1,1,1,1)
					end
				end
				GameTooltip:Show()
			end)
		
		self:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end
	 
	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	Stat:SetScript("OnEvent", OnEvent)
	--Stat:SetScript("OnUpdate", Update)
	Stat:SetScript("OnMouseDown", function(_,btn)
		if btn == "LeftButton" then
			ToggleTalentFrame()
		else
			c = GetActiveSpecGroup(false,false)
			SetActiveSpecGroup(c == 1 and 2 or 1)
		end
	end)
end
