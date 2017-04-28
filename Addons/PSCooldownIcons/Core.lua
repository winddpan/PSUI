﻿local A, L = ...
local Misc = L.Misc
local Activate = L.Activate
local PSCD = {}
local class = select(2, UnitClass("player"))

local function SetTemplate(Parent)
	local F = CreateFrame("Frame", nil, Parent)
	F:SetFrameLevel(3)
	F:SetPoint("TOPLEFT", -1 * Misc.mult, 1 * Misc.mult)
	F:SetPoint("BOTTOMRIGHT", 1 * Misc.mult, -1 * Misc.mult)
	F:SetBackdrop({
		bgFile = Misc.back, 
		edgeFile = Misc.border, 
		insets = {left = 1 * Misc.mult, right = 1 * Misc.mult, top = 1 * Misc.mult, bottom = 1 * Misc.mult},
		tile = false, tileSize = 0, 
		edgeSize = 4 * Misc.mult,
	})
	F:SetBackdropColor(0, 0, 0, .2)
	F:SetBackdropBorderColor(0, 0, 0, 1)
	
	F.Border = CreateFrame("Frame", nil, F)
    F.Border:SetPoint("TOPLEFT", 3, -3)
    F.Border:SetPoint("BOTTOMRIGHT", -3, 3)
    F.Border:SetBackdrop({ 
		edgeFile = "Interface\\Buttons\\WHITE8x8" , edgeSize = 1,
	 })
    F.Border:SetBackdropBorderColor(49/255, 213/255, 78/255, 1)
	--F.Border:SetBackdropBorderColor(0, 0, 0, 1)
    F.Border:SetFrameLevel(4)
	
	return F
end

function PSCD:OnEvent(event, unit)
	if event == "PLAYER_ENTERING_WORLD"
	or event == "ACTIVE_TALENT_GROUP_CHANGED"
	or event == "PLAYER_TALENT_UPDATE" 
	or event == "ACTIVE_TALENT_GROUP_CHANGED" then
		PSCD:CheckSpells(self)
		PSCD:UpdateCD(self)
	end
	if event == "SPELL_UPDATE_COOLDOWN" then
		PSCD:UpdateCD(self)
	end
end

function PSCD:CheckSpells(self)
	local id = self.Id
	local index = 1
	local icons = {}

	for i = 1, #Cooldowns[class][id], 1 do
		local data = Cooldowns[class][id][i]
		local confirmSpec = true
		local name

		if self.SpecName then
			local inspect, pet = false, false
			local talentGroup = GetActiveTalentGroup(inspect, pet)
			local tabIndex = GetPrimaryTalentTree(inspect, pet, talentGroup)
			local _, specName = GetTalentTabInfo(tabIndex, inspect, pet, talentGroup)
			if specName ~= self.SpecName then
				confirmSpec = false
			end
		end
		if confirmSpec and data.spellID then
			name, _, icon = GetSpellInfo(data.spellID)
		end

		if name then
			local usable, nomana = IsUsableSpell(name)
			if usable or nomana then
				icons[index] = {data = data}
				index = index + 1
			end
		end
	end

	self.icons = icons
	PSCD:LayoutIcons(self)
end

function PSCD:LayoutIcons(self)
	if not self.bars then self.bars = {} end
	local id = self.Id
	
	for _, bar in pairs(self.bars) do
		bar:Hide()
	end
		
	for index, value in pairs(self.icons) do
		local bar = self.bars[index]
		if not bar then
			bar = CreateFrame("Frame", id, self)
			bar:SetScale(1)
			bar:SetFrameStrata("Medium")
			SetTemplate(bar)
			
			if bar.icon then
				bar.icon = _G[bar.icon:GetName()]
			else
				bar.icon = bar:CreateTexture("$parentIcon", "BORDER")
				bar.icon:SetPoint("TOPLEFT", 2 * Misc.mult, -2 * Misc.mult)
				bar.icon:SetPoint("BOTTOMRIGHT", -2 * Misc.mult, 2 * Misc.mult)
				bar.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end
			
			if bar.cooldown then
				bar.cooldown = _G[bar.cooldown:GetName()]
			else
				bar.cooldown = CreateFrame("Cooldown", "$parentCD", bar, "CooldownFrameTemplate")
				bar.cooldown:SetAllPoints(bar.icon)
				bar.cooldown:SetReverse()
				bar.cooldown:SetFrameLevel(2)
			end

			if bar.count then
				bar.count = _G[bar.count:GetName()]
			else
				bar.count = bar:CreateFontString("$parentCount", "OVERLAY")
				bar.count:SetFont(Misc.font, Misc.numsize, "THINOUTLINE")
				bar.count:SetShadowOffset(1 * Misc.mult, -1 * Misc.mult)
				bar.count:SetPoint("BOTTOMRIGHT", -1, 3)
				bar.count:SetJustifyH("CENTER")
			end
			
			bar.spellID = 0
			self.bars[index] = bar
		end
		bar:Show()

		if index == 1 then
			if self.Direction == "CENTER" then
				bar:SetPoint("LEFT", self, "CENTER", floor(#self.icons * -(self.Interval + self.IconSize)/2), 0)
			else
				bar:SetAllPoints(self)
			end
		----- The next line ----
		elseif self.NumPerLine and index % self.NumPerLine == 1 then
			previous = self.bars[index - self.NumPerLine]
			if self.Direction == "RIGHT" or self.Direction == "LEFT" then
				bar:SetPoint("TOP", previous, "BOTTOM", 0, -self.Interval)
			else
				bar:SetPoint("LEFT", previous, "RIGHT", self.Interval, 0)
			end
		---------------------------------------
		else
			if self.Direction == "UP" then
				bar:SetPoint("BOTTOM", previous, "TOP", 0, self.Interval)
			elseif self.Direction == "RIGHT" or self.Direction == "CENTER" then
				bar:SetPoint("LEFT", previous, "RIGHT", self.Interval, 0)
			elseif self.Direction == "LEFT" then
				bar:SetPoint("RIGHT", previous, "LEFT", -self.Interval, 0)
			else
				bar:SetPoint("TOP", previous, "BOTTOM", 0, -self.Interval)
			end
		end
		
		previous = bar
	end
end

function PSCD:UpdateCD(self)
	for i, n in pairs(self.icons) do
		local value = self.icons[i]
		local bar = self.bars[i]
		local charges, maxCharges, start, duration, spid
		local data = value.data
		
		local name, _, icon = GetSpellInfo(data.spellID)
		if name then
			if data.absID then
				charges, maxCharges, start, duration = GetSpellCharges(id)
				if maxCharges == nil then
					start, duration = GetSpellCooldown(data.spellID)
				end
			else
				charges, maxCharges, start, duration = GetSpellCharges(name)
				if maxCharges == nil then
					start, duration = GetSpellCooldown(name)
				end
			end
			spid = data.spellID
		elseif data.slotID then
			spid = data.slotID
			local slotLink = GetInventoryItemLink("player", data.slotID)
			if slotLink then
				name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotLink)
				start, duration = GetInventoryItemCooldown("player", data.slotID)
			end
		end
		
		bar.spellName = GetSpellInfo(spid)
		bar.icon:SetTexture(icon)
		if charges and charges > 1 then
			bar.count:SetText(charges)
			bar.count:Show()
		else
			bar.count:Hide()
		end
		if duration and duration > 1.5 and (maxCharges == nil or charges < maxCharges) then
			CooldownFrame_Set(bar.cooldown, start, duration, 1)
			bar.value = value
			bar.activeIndex = activeIndex
			bar.cooldown:Show()
			
			bar.cooling = true
			Activate:Stop(bar.cooldown)
		else
			if bar.cooling then
				bar.cooling = false
				Activate:Setup(bar.cooldown)
				Activate:Run(bar.cooldown)
			end
			bar.cooldown:Hide()
		end
		
		bar.spellID = spid
		bar:SetWidth(self.IconSize or 37)
		bar:SetHeight(self.IconSize or 37)
		bar:SetAlpha(data.opacity or 1)
		bar:Show()
	end
end

function PSCD:Init()
	if Cooldowns and Cooldowns[class] then
		for index in pairs(Cooldowns) do
			if index ~= class then
				Cooldowns[index] = nil
			end
		end

		local idx = {}
		for i = 1, #Cooldowns[class], 1 do
			local jdx = {}
			local data = Cooldowns[class][i]

			for j = 1, #data, 1 do
				local spn
				if data[j].spellID then
					spn = GetSpellInfo(data[j].spellID)
				else
					local slotLink = GetInventoryItemLink("player", data[j].slotID)
					if slotLink then
						spn = GetItemInfo(slotLink)
					end
				end
				if not spn and not data[j].slotID then
					--print("|cffff0000WARNING: spell/slot ID ["..(data[j].spellID or data[j].slotID or "UNKNOWN").."] no longer exists! Report this to Shestak.|r")
					table.insert(jdx, j)
				end
			end

			for _, v in ipairs(jdx) do
				table.remove(data, v)
			end

			if #data == 0 then
				table.insert(idx, i)
			end
		end

		for _, v in ipairs(idx) do
			table.remove(Cooldowns[class], v)
		end

		for i = 1, #Cooldowns[class], 1 do
			local data = Cooldowns[class][i]
						
			local frame = CreateFrame("Frame", "PSCD"..i, UIParent)
			frame.Id = i
			frame.Direction = data.Direction or "DOWN"
			frame.IconSide = data.IconSide or "LEFT"
			frame.NumPerLine = data.NumPerLine
			frame.Mode = data.Mode or "ICON"
			frame.enable = data.enable or "ON"
			frame.Interval = data.Interval * Misc.mult or 3 * Misc.mult
			frame:SetAlpha(data.Alpha or 1)
			frame.IconSize = data.IconSize or 37
			frame.Position = data.Position or "CENTER"
			frame:SetPoint(unpack(frame.Position))
			frame:SetSize(data.IconSize or 37, data.IconSize or 37)
			
			frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
			frame:RegisterEvent("PLAYER_ENTERING_WORLD")
			frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
			frame:RegisterEvent("PLAYER_TALENT_UPDATE")
			frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
			frame:SetScript("OnEvent", PSCD.OnEvent)
		end
	end
end

PSCD:Init() 
