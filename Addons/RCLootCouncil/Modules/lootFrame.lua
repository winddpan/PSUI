--- lootFrame.lua	Adds the interface for selecting a response to a session.
-- DefaultModule.
-- @author	Potdisc
-- Create Date : 12/16/2014 8:24:04 PM

local addon = LibStub("AceAddon-3.0"):GetAddon("RCLootCouncil")
local LootFrame = addon:NewModule("RCLootFrame", "AceTimer-3.0")
local LibDialog = LibStub("LibDialog-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale("RCLootCouncil")

local items = {} -- item.i = {name, link, lvl, texture} (i == session)
local entries = {}
local ENTRY_HEIGHT = 75
local MAX_ENTRIES = 5
local numRolled = 0
local MIN_BUTTON_WIDTH = 40

function LootFrame:Start(table)
	addon:DebugLog("LootFrame:Start()")
	for k = 1, #table do
		if table[k].autopass then
			items[k] = { rolled = true} -- it's autopassed, so pretend we rolled it
			numRolled = numRolled + 1
		else
			items[k] = {
				name = table[k].name,
				link = table[k].link,
				ilvl = table[k].ilvl,
				texture = table[k].texture,
				rolled = false,
				note = nil,
				session = k,
				equipLoc = table[k].equipLoc,
				timeLeft = addon.mldb.timeout,
				subType = table[k].subType,
			}
		end
	end
	self:Show()
end

function LootFrame:ReRoll(table)
	addon:DebugLog("LootFrame:ReRoll(#table)", #table)
	for k,v in ipairs(table) do
		tinsert(items,  {
			name = v.name,
			link = v.link,
			ilvl = v.ilvl,
			texture = v.texture,
			rolled = false,
			note = nil,
			session = v.session,
			equipLoc = v.equipLoc,
			timeLeft = addon.mldb.timeout,
			subType = table[k].subType,
		})
	end
	self:Show()
end

function LootFrame:OnEnable()
	self.frame = self:GetFrame()
end

function LootFrame:OnDisable()
	self.frame:Hide() -- We don't disable the frame as we probably gonna need it later
	items = {}
	numRolled = 0
end

function LootFrame:Show()
	self.frame:Show()
	self:Update()
end

--function LootFrame:Hide()
--	self.frame:Hide()
--end

function LootFrame:Update()
	local width = 150
	local numEntries = 0
	for k,v in ipairs(items) do
		if numEntries >= MAX_ENTRIES then break end -- Only show a certain amount of items at a time
		if not v.rolled then -- Only show unrolled items
			numEntries = numEntries + 1
			width = 150 -- reset it
			if not entries[numEntries] then entries[numEntries] = self:GetEntry(numEntries) end
			-- Actually update entries
			entries[numEntries].realID = k
			entries[numEntries].link = v.link
			entries[numEntries].icon:SetNormalTexture(v.texture)
			entries[numEntries].itemText:SetText(v.link)
			entries[numEntries].itemLvl:SetText(format(L["ilvl: x"], v.ilvl))
			if not entries[numEntries].buttons[addon.mldb.numButtons+1] or (entries[numEntries].buttons[addon.mldb.numButtons+1]:GetText() ~= L["Pass"]) then
				 -- mldb have probably updated since we created the buttons
				 addon:Debug("Updating buttons")
				 entries[numEntries]:UpdateButtons()
			end
			-- Update the buttons and get frame width
			-- IDEA There might be a better way of doing this instead of SetText() on every update?
			local but = entries[numEntries].buttons[addon.mldb.numButtons+1]
			but:SetWidth(but:GetTextWidth() + 10)
			if but:GetWidth() < MIN_BUTTON_WIDTH then but:SetWidth(MIN_BUTTON_WIDTH) end -- ensure minimum width
			width = width + but:GetWidth()
			for i = 1, addon.mldb.numButtons do
				but = entries[numEntries].buttons[i]
				but:SetText(addon:GetButtonText(i))
				but:SetWidth(but:GetTextWidth() + 10)
				if but:GetWidth() < MIN_BUTTON_WIDTH then but:SetWidth(MIN_BUTTON_WIDTH) end
				width = width + but:GetWidth()
			end
			entries[numEntries]:SetWidth(width)
			entries[numEntries]:Show()
			if addon.mldb.timeout then
				entries[numEntries].timeoutBar:SetMinMaxValues(0, addon.mldb.timeout or 30)
				entries[numEntries].timeoutBar:Show()
			else
				entries[numEntries].timeoutBar:Hide()
			end
		end
	end
	self.frame:SetHeight(numEntries * ENTRY_HEIGHT + 2)
	self.frame:SetWidth(width)
	for i = MAX_ENTRIES, numEntries + 1, -1 do -- Hide unused
		if entries[i] then entries[i]:Hide() end
	end
	if numRolled == #items then -- We're through them all, so hide the frame
		self:Disable()
	end
end

function LootFrame:OnRoll(entry, button)
	addon:Debug("LootFrame:OnRoll", entry, button, "Response:", addon:GetResponseText(button))
	local index = entries[entry].realID

	addon:SendCommand("group", "response", addon:CreateResponse(items[index].session, items[index].link, items[index].ilvl, button, items[index].equipLoc, items[index].note, items[index].subType))

	numRolled = numRolled + 1
	items[index].rolled = true
	self:Update()
end

function LootFrame:ResetTimers()
	for _, entry in ipairs(entries) do
		entry.timeoutBar:Reset()
	end
end

function LootFrame:GetFrame()
	if self.frame then return self.frame end
	addon:DebugLog("LootFrame","GetFrame()")
	return addon:CreateFrame("DefaultRCLootFrame", "lootframe", L["RCLootCouncil Loot Frame"], 250, 375)
end

function LootFrame:GetEntry(entry)
	addon:DebugLog("GetEntry("..entry..")")
	if entry == 0 then entry = 1 end
	local f = CreateFrame("Frame", nil, self.frame.content)
	f:SetWidth(self.frame:GetWidth())
	f:SetHeight(ENTRY_HEIGHT)
	if entry == 1 then
		f:SetPoint("TOPLEFT", self.frame, "TOPLEFT")
	else
		f:SetPoint("TOPLEFT", entries[entry-1], "BOTTOMLEFT")
	end

	local icon = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
	icon:SetSize(ENTRY_HEIGHT*2/3, ENTRY_HEIGHT*2/3)
	icon:SetPoint("TOPLEFT", f, "TOPLEFT", 12, -13)
	icon:SetScript("OnEnter", function()
		if not f.link then return end
		addon:CreateHypertip(f.link)
	end)
	icon:SetScript("OnLeave", function() addon:HideTooltip() end)
	icon:SetScript("OnClick", function()
		if not f.link then return end
	   if ( IsModifiedClick() ) then
		 	HandleModifiedItemClick(f.link);
      end
   end)
	f.icon = icon

	-------- Buttons -------------
	function f:UpdateButtons()
		if not f.buttons then f.buttons = {} end -- Reuse if already created
		for i = 1, addon.mldb.numButtons do
			f.buttons[i] = f.buttons[i] or addon:CreateButton(addon:GetButtonText(i), f)
			if i == 1 then
				f.buttons[i]:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 5, 0)
			else
				f.buttons[i]:SetPoint("LEFT", f.buttons[i-1], "RIGHT", 5, 0)
			end
			f.buttons[i]:SetScript("OnClick", function() LootFrame:OnRoll(entry, i) end)
		end
		-- Pass button
		f.buttons[addon.mldb.numButtons + 1] = f.buttons[addon.mldb.numButtons + 1] or addon:CreateButton(L["Pass"], f)
		f.buttons[addon.mldb.numButtons + 1]:SetText(L["Pass"])
		f.buttons[addon.mldb.numButtons + 1]:SetPoint("LEFT", f.buttons[addon.mldb.numButtons], "RIGHT", 5, 0)
		f.buttons[addon.mldb.numButtons + 1]:SetScript("OnClick", function() LootFrame:OnRoll(entry, "PASS") end)
		if #f.buttons > addon.mldb.numButtons + 1 then
			for i = addon.mldb.numButtons +2, #f.buttons do f.buttons[i]:Hide() end
		end
	end
	f:UpdateButtons()

	-------- Note button ---------
	local noteButton = CreateFrame("Button", nil, f)
	noteButton:SetSize(20,20)
   noteButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	noteButton:SetNormalTexture("Interface\\Buttons\\UI-GuildButton-PublicNote-Up")
   noteButton:SetPoint("BOTTOMRIGHT", -12, 12)
	noteButton:SetScript("OnEnter", function()
		if items[entries[entry].realID].note then -- If they already entered a note:
			addon:CreateTooltip(L["Your note:"], items[entries[entry].realID].note, "\nClick to change your note.")
		else
			addon:CreateTooltip(L["Add Note"], L["Click to add note to send to the council."])
		end
	end)
	noteButton:SetScript("OnLeave", function() addon:HideTooltip() end)
	noteButton:SetScript("OnClick", function() LibDialog:Spawn("LOOTFRAME_NOTE", entry) end)
	f.noteButton = noteButton

	----- item text/lvl ---------------
	local iTxt = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	iTxt:SetPoint("TOPLEFT", f.icon, "TOPRIGHT", 5, -5)
	iTxt:SetText("Item name goes here!!!!") -- Set text for reasons
	f.itemText = iTxt

	local ilvl = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	ilvl:SetPoint("TOPRIGHT", f, "TOPRIGHT", -12, -13)
	ilvl:SetTextColor(1, 1, 1) -- White
	ilvl:SetText("ilvl: 670")
	f.itemLvl = ilvl

	------------ Timeout -------------
	local bar = CreateFrame("StatusBar", nil, f, "TextStatusBar")
	bar:SetSize(f:GetWidth(), 6)
	bar:SetPoint("BOTTOMLEFT", 12,4)
	bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	--bar:SetStatusBarColor(0.1, 0, 0.6, 0.8) -- blue
	bar:SetStatusBarColor(0.5, 0.5, 0.5, 1) -- grey
	bar:SetMinMaxValues(0, addon.mldb.timeout or 30)
	bar:SetScript("OnUpdate", function(this, elapsed)
		if items[f.realID].timeLeft <= 0 then --Timeout!
			this.text:SetText(L["Timeout"])
			this:SetValue(0)
			return self:OnRoll(entry, "TIMEOUT")
		end
		items[f.realID].timeLeft = items[f.realID].timeLeft - elapsed
		this.text:SetText(format(L["Time left (num seconds)"], ceil(items[f.realID].timeLeft)))
		this:SetValue(items[f.realID].timeLeft)
	end)
	f.timeoutBar = bar

	-- We want to update the width of the timeout bar everytime the width of the whole frame changes:
	local main_width = f.SetWidth
	function f:SetWidth(width)
		self.timeoutBar:SetWidth(width - 24) -- 12 indent on each side
		main_width(self, width)
	end

	local tof = bar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	tof:SetPoint("CENTER", bar)
	tof:SetTextColor(1,1,1)
	tof:SetText("Timeout")
	f.timeoutBar.text = tof
	return f
end


-- Note button
LibDialog:Register("LOOTFRAME_NOTE", {
	text = L["Enter your note:"],
	on_show = function(self)
		self:SetFrameStrata("FULLSCREEN")
	end,
	editboxes = {
		{
			on_enter_pressed = function(self, entry)
				items[entries[entry].realID].note = self:GetText()
				LibDialog:Dismiss("LOOTFRAME_NOTE")
			end,
			on_escape_pressed = function(self)
				LibDialog:Dismiss("LOOTFRAME_NOTE")
			end,
			auto_focus = true,
		}
	},
})
