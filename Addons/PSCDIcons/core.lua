local A, L = ...
local Misc = {}
local PSCD = {}
local Activate = L.Activate
local Media = "Interface\\AddOns\\"..A.."\\Media\\"
Misc.font = Media.."number.ttf"
Misc.back = Media.."HalBackground"
Misc.border = Media.."GlowTex"
Misc.numsize = 14
Misc.mult = 1 

local class = select(2, UnitClass("player"))

function lua_string_split(str, split_char)
    local sub_str_tab = {};
    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

    return sub_str_tab;
end

local function SetTemplate(Parent)
	local F = CreateFrame("Frame", nil, Parent)
	F:SetFrameLevel(Parent:GetFrameLevel())

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
	F.Border:SetBackdropBorderColor(0, 0, 0, 1)
    --F.Border:SetBackdropBorderColor(49/255, 213/255, 78/255, 1)
    F.Border:SetFrameLevel(Parent:GetFrameLevel()+1)

	return F
end

function PSCD:OnEvent(event, unit)
	if event ~= "SPELL_UPDATE_COOLDOWN" then
		PSCD:CheckSpells(self)
	end
	PSCD:UpdateCD(self)
end

function PSCD:CheckSpells(self)
	local id = self.Id
	local index = 1
	local icons = {}

	for i = 1, #Cooldowns[class][id], 1 do
		local data = Cooldowns[class][id][i]
		local contians = true

		if data.spec then
			local spec = GetSpecialization()
			local specName = select(2, GetSpecializationInfo(spec))
			contians = specName == data.spec
		end
		if contians and data.talent then
			local talentInfo = lua_string_split(data.talent, "/")
			local tier, column = talentInfo[1], talentInfo[2]
			local talentID, name, texture, selected, available, spellid, tier, column, selectedIndex = GetTalentInfo(tier, column, 1)
			contians = selected 
		end

		if contians then
			icons[index] = {data = data}
			index = index + 1
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

		local count = #self.icons
		if self.NumPerLine then
			count = min(#self.icons, self.NumPerLine)
		end
		if index == 1 then
			if self.Direction == "CENTER" then
				bar:SetPoint("LEFT", self, "CENTER", floor(count * -(self.Interval + self.IconSize)/2), 0)
			else
				bar:SetAllPoints(self)
			end
		----- The next line ----
		elseif self.NumPerLine and index % self.NumPerLine == 1 then
			previous = self.bars[index - self.NumPerLine]
			if self.Direction == "RIGHT" or self.Direction == "LEFT" or self.Direction == "CENTER" then
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
	if self.icons == nil then return end
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
		if charges and charges >= 1 then
			bar.count:SetText(charges)
			bar.count:Show()
		else
			bar.count:Hide()
		end
		if duration and duration > 1.5 and (maxCharges == nil or charges < maxCharges) then
			Activate:Stop(bar.cooldown)

			bar.cooling = true
			bar.value = value
			bar.activeIndex = activeIndex
			CooldownFrame_Set(bar.cooldown, start, duration, 1)
			bar.cooldown:Show()
			bar.icon:SetDesaturated(true)
			
			if maxCharges ~= nil and charges > 0 then
				bar.icon:SetDesaturated(false)
			end
		else
			if bar.cooling then
				bar.cooling = nil
				Activate:Run(bar.cooldown)
			end
			bar.cooldown:Hide()
			bar.icon:SetDesaturated(false)
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
					--print("|cffff0000WARNING: spell/slot ID ["..(data[j].spellID or data[j].slotID or "UNKNOWN").."] no longer exists!|r")
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
			frame.IconSize = data.IconSize or 40
			frame.Position = data.Position or "CENTER"
			frame:SetPoint(unpack(frame.Position))
			frame:SetSize(frame.IconSize, frame.IconSize)
			
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
