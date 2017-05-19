--- lootHistory.lua	Adds the interface for displaying the collected loot history.
-- DefaultModule
-- @author Potdisc
-- Create Date : 8/6/2015

local addon = LibStub("AceAddon-3.0"):GetAddon("RCLootCouncil")
local LootHistory = addon:NewModule("RCLootHistory")
local L = LibStub("AceLocale-3.0"):GetLocale("RCLootCouncil")
local AG = LibStub("AceGUI-3.0")
local lootDB, scrollCols, data, db, numLootWon;
--[[ data structure:
data[date][playerName] = {
	["class"] = CLASS,
	[i] = { -- Num item given to player, lowest first
		-- Remaining content in lootDB[playerName]
	}
}
]]
local selectedDate, selectedName, filterMenu, moreInfo, moreInfoData
local ROW_HEIGHT = 20;
local NUM_ROWS = 15;

function LootHistory:OnInitialize()
	self.exportSelection = "lua"
	-- Pointer to export functions. Expected to return a string containing the export
	self.exports = {
		lua = 		{func = self.ExportLua, 		name = "Lua",					tip = L["Raw lua output. Doesn't work well with date selection."]},
		csv = 		{func = self.ExportCSV,			name = "CSV",					tip = L["Standard .csv output."]},
		tsv = 		{func = self.ExportTSV,			name = "TSV (Excel)",		tip = L["A tab delimited output for Excel. Might work with other spreadsheets."]},
		bbcode = 	{func = self.ExportBBCode,		name = "BBCode", 				tip = L["Simple BBCode output."]},
		bbcodeSmf = {func = self.ExportBBCodeSMF, name = "BBCode SMF",			tip = L["BBCode export, tailored for SMF."],},
		eqxml = 		{func = self.ExportEQXML,		name = "EQdkp-Plus XML",	tip = L["EQdkp-Plus XML output, tailored for Enjin import."]},
		player = 	{func = self.PlayerExport,		name = "Player Export",		tip = L["A format to copy/paste to another player."]},
		--html = self.ExportHTML
	}
	scrollCols = {
		{name = "",					width = ROW_HEIGHT, },			-- Class icon, should be same row as player
		{name = L["Name"],		width = 100, 				},		-- Name of the player
		{name = L["Time"],		width = 125, comparesort = self.DateTimeSort, sort = "dsc",},			-- Time of awarding
		{name = "",					width = ROW_HEIGHT, },			-- Item at index icon
		{name = L["Item"],		width = 250, 				}, 	-- Item string
		{name = L["Reason"],		width = 220, comparesort = self.ResponseSort,  sortnext = 2},	-- Response aka the text supplied to lootDB...response
		{name = "",					width = ROW_HEIGHT},				-- Delete button
	}
	filterMenu = CreateFrame("Frame", "RCLootCouncil_LootHistory_FilterMenu", UIParent, "Lib_UIDropDownMenuTemplate")
	Lib_UIDropDownMenu_Initialize(filterMenu, self.FilterMenu, "MENU")
	--MoreInfo
	self.moreInfo = CreateFrame( "GameTooltip", "RCLootHistoryMoreInfo", nil, "GameTooltipTemplate" )
end

local tierLookUpTable = { -- MapID to Tier text
	[1530] = L["Tier 19"],
}

local difficultyLookupTable = {
	[14] = L["tier_token_normal"],
	[15] = L["tier_token_heroic"],
	[16] = L["tier_token_mythic"],
}

function LootHistory:OnEnable()
	addon:Debug("OnEnable()")
	moreInfo = true
	db = addon:Getdb()
	lootDB = addon:GetHistoryDB()
	self.frame = self:GetFrame()
	self:BuildData()
	self:Show()
end

function LootHistory:OnDisable()
	self:Hide()
	self.frame:SetParent(nil)
	self.frame = nil
	data = {}
end

--- Show the LootHistory frame.
function LootHistory:Show()
	moreInfoData = addon:GetLootDBStatistics()
	self.frame:Show()
end

--- Hide the LootHistory frame.
function LootHistory:Hide()
	self.frame:Hide()
	self.moreInfo:Hide()
	moreInfo = false
end

function LootHistory:BuildData()
	addon:Debug("LootHistory:BuildData()")
	data = {}
	numLootWon = {} -- playerName = #
	local date
	-- We want to rebuild lootDB to the "data" format:
	--local i = 1
	for name, v in pairs(lootDB) do
		numLootWon[name] = 0
		-- Now we actually add the data
		for i,v in ipairs(v) do
			numLootWon[name] = numLootWon[name] + 1
			date = v.date
			if not date then -- Unknown date
				date = L["Unknown date"]
			end
			if not data[date] then -- We haven't added the date to data, do it
				data[date] = {}
			end
			if not data[date][name] then
				data[date][name] = {}
			end
			if not data[date][name][i] then
				data[date][name][i] = {}
			end
			for k, t in pairs(v) do
				if k == "class" then -- we need the class at a different level
					data[date][name].class = t
				elseif k ~= "date" then -- We don't need date
					data[date][name][i][k] = t
				end
			end
			if not data[date][name][i].instance then
				data[date][name][i].instance = L["Unknown"]
			end
		end
	end
	table.sort(data)
	-- Now create a blank data table for lib-st to init with
	self.frame.rows = {}
	local dateData, nameData, insertedNames = {}, {}, {}
	local row = 1;
	for date, v in pairs(data) do
		for name, x in pairs(v) do
			for num, i in pairs(x) do
				if num ~= "class" then
					self.frame.rows[row] = {
						date = date,
						class = x.class,
						name = name,
						num = num,
						response = i.responseID,
						cols = {
							{DoCellUpdate = addon.SetCellClassIcon, args = {x.class}},
							{value = addon.Ambiguate(name), color = addon:GetClassColor(x.class)},
							{value = date.. "-".. i.time or "", args = {time = i.time, date = date},},
							{DoCellUpdate = self.SetCellGear, args={i.lootWon}},
							{value = i.lootWon},
							{DoCellUpdate = self.SetCellResponse, args = {color = i.color, response = i.response, responseID = i.responseID or 0, isAwardReason = i.isAwardReason}},
							{DoCellUpdate = self.SetCellDelete},
						}
					}
					row = row + 1
				end
			end
			if not tContains(insertedNames, name) then -- we only want each name added once
				tinsert(nameData,
					{
						{DoCellUpdate = addon.SetCellClassIcon, args = {x.class}},
						{value = addon.Ambiguate(name), color = addon:GetClassColor(x.class), name = name}
					}
				)
				tinsert(insertedNames, name)
			elseif x.class then -- it already exists, but we might need to add the class which we now have
				for i in pairs(nameData) do
					if nameData[i][2].name == name then
						nameData[i][1].args = {x.class}
					end
				end
			end
		end
		tinsert(dateData, {date})
	end
	self.frame.st:SetData(self.frame.rows)
	self.frame.date:SetData(dateData, true) -- True for minimal data	format
	self.frame.name:SetData(nameData, true)
end

function LootHistory.FilterFunc(table, row)
	local nameAndDate = true -- default to show everything
	if selectedName and selectedDate then
		nameAndDate = row.name == selectedName and row.date == selectedDate
	elseif selectedName then
		nameAndDate = row.name == selectedName
	elseif selectedDate then
		nameAndDate = row.date == selectedDate
	end

	local responseFilter = true -- default to show
	if not db.modules["RCLootHistory"].filters then return nameAndDate end -- db hasn't been initialized
	local response = row.response
	if response == "AUTOPASS" or response == "PASS" or type(response) == "number" then
		responseFilter = db.modules["RCLootHistory"].filters[response]
	else -- Filter out the status texts
		responseFilter = db.modules["RCLootHistory"].filters["STATUS"]
	end

	return nameAndDate and responseFilter -- Either one can filter the entry
end

function LootHistory.SetCellGear(rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
	local gear = data[realrow].cols[column].args[1] -- gear1 or gear2
	if gear then
		local texture = select(10, GetItemInfo(gear))
		frame:SetNormalTexture(texture)
		frame:SetScript("OnEnter", function() addon:CreateHypertip(gear) end)
		frame:SetScript("OnLeave", function() addon:HideTooltip() end)
		frame:SetScript("OnClick", function()
		if IsModifiedClick() then
		   HandleModifiedItemClick(gear);
      end
	end)
		frame:Show()
	else
		frame:Hide()
	end
end

function LootHistory.SetCellResponse(rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
	local args = data[realrow].cols[column].args
	frame.text:SetText(args.response)

	if args.color then -- Never version saves the color with the entry
		frame.text:SetTextColor(unpack(args.color))
	elseif args.responseID and args.responseID > 0 then -- try to recreate color from ID
		frame.text:SetTextColor(addon:GetResponseColor(args.responseID))
	else -- default to white
		frame.text:SetTextColor(1,1,1,1)
	end
end

function LootHistory.SetCellDelete(rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
	if not frame.created then
		frame:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
		frame:SetScript("OnEnter", function()
			addon:CreateTooltip(L["Double click to delete this entry."])
		end)
		frame:SetScript("OnLeave", function() addon:HideTooltip() end)
		frame.created = true
	end
	frame:SetScript("OnClick", function()
		local name, num = data[realrow].name, data[realrow].num
		if frame.lastClick and GetTime() - frame.lastClick <= 0.5 then
			frame.lastClick = nil
			-- Do deleting
			addon:Debug("Deleting:", name, lootDB[name][num].lootWon)
			tremove(lootDB[name], num)
			tremove(data, realrow)
			table:SortData()
		else
			frame.lastClick = GetTime()
		end
	end)
end

local sinceEpoch = {} -- Stores epoch seconds for both, we should reuse it
function LootHistory.DateTimeSort(table, rowa, rowb, sortbycol)
	local cella, cellb = table:GetCell(rowa, sortbycol), table:GetCell(rowb, sortbycol);
	local timea, datea, timeb, dateb = cella.args.time, cella.args.date, cellb.args.time, cellb.args.date
	local d, m, y = strsplit("/", datea, 3)
	local h, min, s = strsplit(":", timea, 3)
	sinceEpoch.a = time({year = "20"..y, month = m, day = d, hour = h, min = min, sec = s})
	d, m, y = strsplit("/", dateb, 3)
	h, min, s = strsplit(":", timeb, 3)
	sinceEpoch.b = time({year = "20"..y, month = m, day = d, hour = h, min = min, sec = s})
	local direction = table.cols[sortbycol].sort or table.cols[sortbycol].defaultsort or "asc";
	if direction:lower() == "asc" then
		return sinceEpoch.a < sinceEpoch.b;
	else
		return sinceEpoch.a > sinceEpoch.b;
	end
end

function LootHistory.DateSort(table, rowa, rowb, sortbycol)
	local column = table.cols[sortbycol]
	rowa, rowb = table:GetRow(rowa), table:GetRow(rowb);
	local a, b = rowa[1], rowb[1]
	if not (a and b) then return false end
	local d, m, y = strsplit("/", a, 3)
	local aTime = time({year = "20"..y, month = m, day = d})
	d, m, y = strsplit("/", b, 3)
	local bTime = time({year = "20"..y, month = m, day = d})
	local direction = column.sort or column.defaultsort or "asc";
	if direction:lower() == "asc" then
		return aTime < bTime;
	else
		return aTime > bTime;
	end
end

function LootHistory.ResponseSort(table, rowa, rowb, sortbycol)
	local column = table.cols[sortbycol]
	rowa, rowb = table:GetRow(rowa), table:GetRow(rowb);
	local a,b
	local aID, bID = data[rowa.date][rowa.name][rowa.num].responseID, data[rowb.date][rowb.name][rowb.num].responseID

	-- NOTE: I'm pretty sure it can only be an awardReason when responseID is nil or 0
	if aID and aID ~= 0 then
		if data[rowa.date][rowa.name][rowa.num].isAwardReason then
			a = db.awardReasons[aID].sort
		else
			a = addon:GetResponseSort(aID)
		end
	else
		-- 500 will be below award reasons and just above status texts
		a = 500
	end

	if bID and bID ~= 0 then
		if data[rowb.date][rowb.name][rowb.num].isAwardReason then
			b = db.awardReasons[bID].sort
		else
			b = addon:GetResponseSort(bID)
		end

	else
		b = 500
	end

	local direction = column.sort or column.defaultsort or "asc";
	if direction:lower() == "asc" then
		return a < b;
	else
		return a > b;
	end
end

function LootHistory:EscapeItemLink(link)
	return gsub(link, "\124", "\124\124")
end

function LootHistory:ExportHistory()
	--debugprofilestart()
	local export = self.exports[self.exportSelection].func(self)
	--addon:Debug("Export time:", debugprofilestop(), "ms")
	if export and export ~= "" then -- do something
		--debugprofilestart()
		self.frame.exportFrame:Show()
		self:SetExportText(export)
		--addon:Debug("Display time:", debugprofilestop(), "ms")
	end
end

function LootHistory:ImportHistory(import)
	addon:Debug("Initiating import")
	lootDB = addon:GetHistoryDB()
	-- Start with validating the import:
	if type(import) ~= "string" then addon:Print("The imported text wasn't a string"); return addon:DebugLog("No string") end
	import = gsub(import, "\124\124", "\124") -- De escape itemslinks
	local test, import = addon:Deserialize(import)
	if not test then addon:Print("Deserialization failed - maybe wrong import type?"); return addon:DebugLog("Deserialization failed") end
	addon:Debug("Validation completed", #lootDB == 0, #lootDB)
	-- Now import should be a copy of the orignal exporter's lootDB, so insert any changes
	-- Start by seeing if we even have a lootDB
	--if #lootDB == 0 then lootDB = import; return end
	local number = 0
	for name, data in pairs(import) do
		if lootDB[name] then -- We've registered the name, so check all the awards
			for _, v in pairs(data) do
				local found = false
				for _, d in pairs(lootDB[name]) do -- REVIEW This is currently ~O(#lootDB[name]^2). Could probably be improved.
					-- Check if the time matches. If it does, we already have the data and can skip to the next
					if d.time == v.time then found = true; break end
				end
				if not found then -- add it
					tinsert(lootDB[name], v)
					number = number + 1
				end
			end
		else -- It's a new name, so add everything and move on to the next
			lootDB[name] = data
			number = number + #data
		end
	end
	addon.lootDB.factionrealm = lootDB -- save it
	addon:Print("Successfully imported "..number.." entries.")
	addon:Debug("Import successful")
	self:BuildData()
end

function LootHistory:GetWowheadLinkFromItemLink(link)
    local color, itemType, itemID, enchantID, gemID1, gemID2, gemID3, gemID4, suffixID, uniqueID, linkLevel, specializationID,
	 upgradeTypeID, upgradeID, instanceDifficultyID, numBonuses, bonusIDs = addon:DecodeItemLink(link)

    local itemurl = "https://www.wowhead.com/item="..itemID

	 -- It seems bonus id 1487 (and basically any other id that's -5 below Wowheads first ilvl upgrade doesn't work)
	 -- Neither does Warforged items it seems
    if numBonuses > 0 then
        itemurl = itemurl.."&bonus="
        for i, b in pairs(bonusIDs) do
            itemurl = itemurl..b
            if i < numBonuses then
                itemurl = itemurl..":"
            end
        end
    end

    return itemurl
end

---------------------------------------------------
-- Visuals.
-- @section Visuals.
---------------------------------------------------
function LootHistory:Update()
	self.frame.st:SortData()
end

function LootHistory:GetFrame()
	if self.frame then return self.frame end
	local f = addon:CreateFrame("DefaultRCLootHistoryFrame", "history", L["RCLootCouncil Loot History"], 250, 480)
	local st = LibStub("ScrollingTable"):CreateST(scrollCols, NUM_ROWS, ROW_HEIGHT, { ["r"] = 1.0, ["g"] = 0.9, ["b"] = 0.0, ["a"] = 0.5 }, f.content)
	st.frame:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 10, 10)
	st:SetFilter(self.FilterFunc)
	st:EnableSelection(true)
	st:RegisterEvents({
		["OnClick"] = function(rowFrame, cellFrame, data, cols, row, realrow, column, table, button, ...)
			if row or realrow then
				self:UpdateMoreInfo(rowFrame, cellFrame, data, cols, row, realrow, column, table, button, ...)
			end
			return false
		end
	})
	f.st = st

	--Date selection
	f.date = LibStub("ScrollingTable"):CreateST({{name = L["Date"], width = 70, comparesort = self.DateSort, sort = "desc"}}, 5, ROW_HEIGHT, { ["r"] = 1.0, ["g"] = 0.9, ["b"] = 0.0, ["a"] = 0.5 }, f.content)
	f.date.frame:SetPoint("TOPLEFT", f, "TOPLEFT", 10, -20)
	f.date:EnableSelection(true)
	f.date:RegisterEvents({
		["OnClick"] = function(rowFrame, cellFrame, data, cols, row, realrow, column, table, button, ...)
			if button == "LeftButton" and row then
				selectedDate = data[realrow][column] ~= selectedDate and data[realrow][column] or nil
				self:Update()
			end
			return false
		end
	})

	--Name selection
	f.name = LibStub("ScrollingTable"):CreateST({{name = "", width = ROW_HEIGHT},{name = L["Name"], width = 100, sort = "desc"}}, 5, ROW_HEIGHT, { ["r"] = 1.0, ["g"] = 0.9, ["b"] = 0.0, ["a"] = 0.5 }, f.content)
	f.name.frame:SetPoint("TOPLEFT", f.date.frame, "TOPRIGHT", 20, 0)
	f.name:EnableSelection(true)
	f.name:RegisterEvents({
		["OnClick"] = function(rowFrame, cellFrame, data, cols, row, realrow, column, table, button, ...)
			if button == "LeftButton" and row then
				selectedName = selectedName ~= data[realrow][column].name and data[realrow][column].name or nil
				self:Update()
			end
			return false
		end
	})

	-- Abort button
	local b1 = addon:CreateButton(L["Close"], f.content)
	b1:SetPoint("TOPRIGHT", f, "TOPRIGHT", -10, -100)
	b1:SetScript("OnClick", function() self:Disable() end)
	f.closeBtn = b1

	-- More info button
	local b2 = CreateFrame("Button", nil, f.content, "UIPanelButtonTemplate")
	b2:SetSize(25,25)
	b2:SetPoint("BOTTOMRIGHT", b1, "TOPRIGHT", 0, 10)
	b2:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
	b2:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
	b2:SetScript("OnClick", function(button)
		moreInfo = not moreInfo
		self.frame.st:ClearSelection()
		self:UpdateMoreInfo()
		if moreInfo then -- show the more info frame
			button:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
			button:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
			self.moreInfo:Show()
		else -- hide it
			button:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
			button:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
			self.moreInfo:Hide()
		end
		addon:Debug("moreInfo =",moreInfo)
	end)
	b2:SetScript("OnEnter", function() addon:CreateTooltip(L["Click to expand/collapse more info"]) end)
	b2:SetScript("OnLeave", function() addon:HideTooltip() end)
	f.moreInfoBtn = b2

	-- Export
	local b3 = addon:CreateButton(L["Export"], f.content)
	b3:SetPoint("RIGHT", b1, "LEFT", -10, 0)
	b3:SetScript("OnClick", function() self:ExportHistory() end)
	f.exportBtn = b3

	-- Import
	local b5 = addon:CreateButton("Import", f.content)
	b5:SetPoint("RIGHT", b3, "LEFT", -10, 0)
	b5:SetScript("OnClick", function() self.frame.importFrame:Show() end)
	f.importBtn = b5

	-- Filter
	local b4 = addon:CreateButton(L["Filter"], f.content)
	b4:SetPoint("RIGHT", f.importBtn, "LEFT", -10, 0)
	b4:SetScript("OnClick", function(self) Lib_ToggleDropDownMenu(1, nil, filterMenu, self, 0, 0) end )
	f.filter = b4
	Lib_UIDropDownMenu_Initialize(b4, self.FilterMenu)
	f.filter:SetSize(125,25) -- Needs extra convincing to stay at 25px height

	-- Export selection (AceGUI-3.0)
	local sel = AG:Create("Dropdown")
	sel:SetPoint("BOTTOMLEFT", f.importBtn, "TOPLEFT", 0, 10)
	sel:SetPoint("TOPRIGHT", b2, "TOPLEFT", -10, 0)
	local values = {}
	for k, v in pairs(self.exports) do
		values[k] = v.name
	end
	sel:SetList(values)
	sel:SetValue(self.exportSelection)
	sel:SetText(self.exports[self.exportSelection].name)
	sel:SetCallback("OnValueChanged", function(_,_, key)
		self.exportSelection = key
	end)
	sel:SetCallback("OnEnter", function()
		addon:CreateTooltip(self.exports[self.exportSelection].tip)
	end)
	sel:SetCallback("OnLeave", function()
		addon:HideTooltip()
	end)
	sel:SetParent(f)
	sel.frame:Show()
	f.moreInfoDropdown = sel

	-- Clear selection
	local b6 = addon:CreateButton(L["Clear Selection"], f.content)
	b6:SetPoint("RIGHT", sel.frame, "LEFT", -10, 0)
	b6:SetScript("OnClick", function()
		selectedDate, selectedName = nil, nil
		self.frame.date:ClearSelection()
		self.frame.name:ClearSelection()
		self:Update()
	end)
	b6:SetWidth(125)
	f.clearSelectionBtn = b6

	-- Export string
	local s = f.content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	s:SetPoint("BOTTOMRIGHT", sel.frame, "TOPRIGHT", 0, 5)
	s:SetPoint("BOTTOMLEFT", sel.frame, "TOPLEFT", 0, 5)
	s:SetHeight(10)
	s:SetTextColor(1,1,1)
	s:SetJustifyH("LEFT")
	s:SetText(L["Note: Huge exports will cause lag."])
	f.exportString = s

	-- Export frame
	local exp = AG:Create("Window")
	exp:SetLayout("Flow")
	exp:SetTitle("RCLootCouncil "..L["Export"])
	exp:SetWidth(400)
   exp:SetHeight(550)

	local edit = AG:Create("MultiLineEditBox")
	edit:SetNumLines(20)
	edit:SetFullWidth(true)
	edit:SetLabel(L["Export"])
	edit:SetFullHeight(true)
	exp:AddChild(edit)
	exp:Hide()
	f.exportFrame = exp
	self.SetExportText = function(self, text)
		edit:SetText(text)
		edit:HighlightText()
		edit:SetFocus()
	end

	-- Import frame
	local imp = AG:Create("Window")
	imp:SetLayout("Flow")
	imp:SetTitle("RCLootCouncil Import")
	imp:SetWidth(400)
   imp:SetHeight(550)

	local edit = AG:Create("MultiLineEditBox")
	edit:SetNumLines(20)
	edit:SetFullWidth(true)
	edit:SetLabel("Import")
	edit:SetFullHeight(true)
	edit:SetCallback("OnEnterPressed", function()
		self:ImportHistory(edit:GetText())
		imp:Hide()
	end)
	imp:AddChild(edit)
	imp:Hide()
	f.importFrame = imp

	-- Set a proper width
	f:SetWidth(st.frame:GetWidth() + 20)
	return f;
end

function LootHistory:UpdateMoreInfo(rowFrame, cellFrame, dat, cols, row, realrow, column, tabel, button, ...)
	if not dat then return end
	local tip = self.moreInfo -- shortening
	tip:SetOwner(self.frame, "ANCHOR_RIGHT")
	local row = dat[realrow]
	local color = addon:GetClassColor(row.class)
	local data = data[row.date][row.name][row.num]
	tip:AddLine(addon.Ambiguate(row.name), color.r, color.g, color.b)
	tip:AddLine("")
	tip:AddDoubleLine(L["Time"]..":", (data.time or L["Unknown"]) .." ".. row.date or L["Unknown"], 1,1,1, 1,1,1)
	tip:AddDoubleLine(L["Loot won:"], data.lootWon or L["Unknown"], 1,1,1, 1,1,1)
	if data.itemReplaced1 then
		tip:AddDoubleLine(L["Item(s) replaced:"], data.itemReplaced1, 1,1,1)
		if data.itemReplaced2 then
			tip:AddDoubleLine(" ", data.itemReplaced2)
		end
	end
	tip:AddDoubleLine(L["Dropped by:"], data.boss or L["Unknown"], 1,1,1, 0.862745, 0.0784314, 0.235294)
	tip:AddDoubleLine(L["From:"], data.instance or L["Unknown"], 1,1,1, 0.823529, 0.411765, 0.117647)
	tip:AddDoubleLine(L["Votes"]..":", data.votes or L["Unknown"], 1,1,1, 1,1,1)
	tip:AddLine(" ")
	tip:AddLine(L["Tokens received"])
	-- Add tier tokens
	for name, v in pairs(moreInfoData[row.name].totals.tokens) do
		if v.mapID and v.difficultyID and tierLookUpTable[v.mapID] then
			tip:AddDoubleLine(tierLookUpTable[v.mapID].." "..difficultyLookupTable[v.difficultyID]..":", v.num, 1,1,1, 1,1,1)
		end
	end
	tip:AddLine(" ")
	tip:AddLine(L["Total awards"])
	table.sort(moreInfoData[row.name].totals.responses, function(a,b) return type(a[4]) == "number" and type(b[4]) == "number" and a[4] < b[4] or false end)
	for i, v in pairs(moreInfoData[row.name].totals.responses) do
		local r,g,b 
		if v[3] then r,g,b = unpack(v[3],1,3) end
		tip:AddDoubleLine(v[1], v[2], r or 1, g or 1, b or 1, 1,1,1)
	end
	tip:AddDoubleLine(L["Total items won:"], numLootWon[row.name], 1,1,1, 0,1,0)



	-- Debug stuff
	if addon.debug then
		tip:AddLine("\nDebug:")
		tip:AddDoubleLine("ResponseID", tostring(data.responseID), 1,1,1, 1,1,1)
		tip:AddDoubleLine("Response:", data.response, 1,1,1, 1,1,1)
		tip:AddDoubleLine("isAwardReason:", tostring(data.isAwardReason), 1,1,1, 1,1,1)
		local r,g,b
		if data.color then r,g,b = unpack(data.color,1,3) end
		tip:AddDoubleLine("color:", data.color and (r..", "..g..", "..b) or "none", 1,1,1, r,g,b)
		tip:AddDoubleLine("DataIndex:", row.num, 1,1,1, 1,1,1)
		tip:AddDoubleLine("difficultyID:", data.difficultyID, 1,1,1, 1,1,1)
		tip:AddDoubleLine("mapID", data.mapID, 1,1,1, 1,1,1)
		tip:AddDoubleLine("groupSize", data.groupSize, 1,1,1, 1,1,1)
		tip:AddDoubleLine("tierToken", data.tierToken, 1,1,1, 1,1,1)
		tip:AddLine(" ")
		tip:AddLine("Total tokens won:")
 		for name, v in pairs(moreInfoData[row.name].totals.tokens) do
 			tip:AddDoubleLine(name, v.num, 1,1,1, 1,1,1)
 		end
		tip:AddLine(" ")

	end
	tip:SetScale(db.UI.history.scale)
	if moreInfo then
		tip:Show()
	else
		tip:Hide()
	end
	tip:SetAnchorType("ANCHOR_RIGHT", 0, -tip:GetHeight())
end



---------------------------------------------------
-- Dropdowns.
-- @section Dropdowns.
---------------------------------------------------
function LootHistory.FilterMenu(menu, level)
	local info = Lib_UIDropDownMenu_CreateInfo()
	if level == 1 then -- Redundant
		-- Build the data table:
		local data = {["STATUS"] = true, ["PASS"] = true, ["AUTOPASS"] = true}
		for i = 1, addon.mldb.numButtons or db.numButtons do
			data[i] = i
		end
		if not db.modules["RCLootHistory"].filters then -- Create the db entry
			addon:DebugLog("Created LootHistory filters")
			db.modules["RCLootHistory"].filters = {}
		end
		for k in pairs(data) do -- Update the db entry to make sure we have all buttons in it
			if type(db.modules["RCLootHistory"].filters[k]) ~= "boolean" then
				addon:Debug("Didn't contain "..k)
				db.modules["RCLootHistory"].filters[k] = true -- Default as true
			end
		end
		info.text = L["Filter"]
		info.isTitle = true
		info.notCheckable = true
		info.disabled = true
		Lib_UIDropDownMenu_AddButton(info, level)
		info = Lib_UIDropDownMenu_CreateInfo()

		for k in ipairs(data) do -- Make sure normal responses are on top
			info.text = addon:GetResponseText(k)
			info.colorCode = "|cff"..addon:RGBToHex(addon:GetResponseColor(k))
			info.func = function()
				addon:Debug("Update Filter")
				db.modules["RCLootHistory"].filters[k] = not db.modules["RCLootHistory"].filters[k]
				LootHistory:Update()
			end
			info.checked = db.modules["RCLootHistory"].filters[k]
			Lib_UIDropDownMenu_AddButton(info, level)
		end
		for k in pairs(data) do -- A bit redundency, but it makes sure these "specials" comes last
			if type(k) == "string" then
				if k == "STATUS" then
					info.text = L["Status texts"]
					info.colorCode = "|cffde34e2" -- purpleish
				else
					info.text = addon:GetResponseText(k)
					info.colorCode = "|cff"..addon:RGBToHex(addon:GetResponseColor(k))
				end
				info.func = function()
					addon:Debug("Update Filter")
					db.modules["RCLootHistory"].filters[k] = not db.modules["RCLootHistory"].filters[k]
					LootHistory:Update()
				end
				info.checked = db.modules["RCLootHistory"].filters[k]
				Lib_UIDropDownMenu_AddButton(info, level)
			end
		end
	end
end


---------------------------------------------------------------
-- Exports.
-- REVIEW A lot of optimizations can be done here.
-- @section Exports.
---------------------------------------------------------------

--- Lua
function LootHistory:ExportLua()
	local export = ""
	for player, v in pairs(lootDB) do
		if selectedName and selectedName == player or not selectedName then
			export = export .. "[\""..player.."\"] = {\r\n"
			for i, d in pairs(v) do
				if selectedDate and selectedDate == d.date or not selectedDate then
					export = export .."\t{\r\n"
					for label, d in pairs(d) do
						if label == "color" then -- thats a table
							export = export .. "\t\t[\""..label.."\"] = {\r\n"
							for i,d in pairs(d) do
								 export = export .. "\t\t\t"..d..", --"..i.."\r\n"
							end
							 export = export .."\t\t}\r\n"
						elseif label == "lootWon" or label == "itemReplaced1" or label == "itemReplaced2" then
							export = export .. "\t\t[\""..label.."\"] = "..self:EscapeItemLink(d).."\r\n"
						else
							export = export .. "\t\t[\""..label.."\"] = "..tostring(d).."\r\n"
						end
					end
					export = export .."\t} --"..i.."\r\n"
				end
			end
			export = export .."}\r\n"
		end
	end
return export
end

--- CSV with all stored data
-- ~14 ms (74%) improvement by switching to table and concat
function LootHistory:ExportCSV()
	-- Add headers
	local export = {}
	local ret = "player, date, time, item, itemID, itemString, response, votes, class, instance, boss, gear1, gear2, responseID, isAwardReason\r\n"
	for player, v in pairs(lootDB) do
		if selectedName and selectedName == player or not selectedName then
			for i, d in pairs(v) do
				if selectedDate and selectedDate == d.date or not selectedDate then
					-- We might have commas in various things here :/
					tinsert(export, tostring(player))
					tinsert(export, tostring(d.date))
					tinsert(export, tostring(d.time))
					tinsert(export, (gsub(tostring(d.lootWon),",","")))
					tinsert(export, addon:GetItemIDFromLink(d.lootWon))
					tinsert(export, addon:GetItemStringFromLink(d.lootWon))
					tinsert(export, (gsub(tostring(d.response),",","")))
					tinsert(export, tostring(d.votes))
					tinsert(export, tostring(d.class))
					tinsert(export, (gsub(tostring(d.instance),",","")))
					tinsert(export, (gsub(tostring(d.boss),",","")))
					tinsert(export, (gsub(tostring(d.itemReplaced1), ",","")))
					tinsert(export, (gsub(tostring(d.itemReplaced2), ",","")))
					tinsert(export, tostring(d.responseID))
					tinsert(export, tostring(d.isAwardReason))
					ret = ret..table.concat(export, ",").."\r\n"
					export = {}
				end
			end
		end
	end
	return ret
end

--- TSV (Tab Seperated Values) for Excel
-- Made specificly with excel in mind, but might work with other spreadsheets
function LootHistory:ExportTSV()
	-- Add headers
	local export = {}
	local ret = "player\tdate\ttime\titem\titemID\titemString\tresponse\tvotes\tclass\tinstance\tboss\tgear1\tgear2\tresponseID\tisAwardReason\r\n"
	for player, v in pairs(lootDB) do
		if selectedName and selectedName == player or not selectedName then
			for i, d in pairs(v) do
				if selectedDate and selectedDate == d.date or not selectedDate then
					tinsert(export, tostring(player))
					tinsert(export, tostring(d.date))
					tinsert(export, tostring(d.time))
					tinsert(export, "=HYPERLINK(\""..self:GetWowheadLinkFromItemLink(d.lootWon).."\",\""..tostring(d.lootWon).."\")")
					tinsert(export, addon:GetItemIDFromLink(d.lootWon))
					tinsert(export, addon:GetItemStringFromLink(d.lootWon))
					tinsert(export, tostring(d.response))
					tinsert(export, tostring(d.votes))
					tinsert(export, tostring(d.class))
					tinsert(export, tostring(d.instance))
					tinsert(export, tostring(d.boss))
					tinsert(export, "=HYPERLINK(\""..self:GetWowheadLinkFromItemLink(tostring(d.itemReplaced1)).."\",\""..tostring(d.itemReplaced1).."\")")
					tinsert(export, "=HYPERLINK(\""..self:GetWowheadLinkFromItemLink(tostring(d.itemReplaced2)).."\",\""..tostring(d.itemReplaced2).."\")")
					tinsert(export, tostring(d.responseID))
					tinsert(export, tostring(d.isAwardReason))
					ret = ret..table.concat(export, "\t").."\r\n"
					export = {}
				end
			end
		end
	end
	return ret
end

--- Simplified BBCode, as supported by CurseForge
-- ~24 ms (84%) improvement by switching to table and concat
function LootHistory:ExportBBCode()
	local export = {}
	for player, v in pairs(lootDB) do
		if selectedName and selectedName == player or not selectedName then
			tinsert(export, "[b]"..addon.Ambiguate(player)..":[/b]\r\n")
			tinsert(export, "[list=1]")
			local first = true
			for i, d in pairs(v) do
				if selectedDate and selectedDate == d.date or not selectedDate then
					if first then
						first = false
					else
						tinsert(export, "[*]")
					end
					tinsert(export, "[url="..self:GetWowheadLinkFromItemLink(d.lootWon).."]"..d.lootWon.."[/url]"
					.." Response: "..tostring(d.response)..".\r\n")
				end
			end
			tinsert(export, "[/list]\r\n\r\n")
		end
	end
	return table.concat(export)
end

--- BBCode, as supported by SMF
function LootHistory:ExportBBCodeSMF()
	local export = ""
	for player, v in pairs(lootDB) do
		if selectedName and selectedName == player or not selectedName then
			export = export.."[b]"..addon.Ambiguate(player)..":[/b]\r\n"
			export = export.."[list]"
			for i, d in pairs(v) do
				if selectedDate and selectedDate == d.date or not selectedDate then
					export = export.."[*]"
					export=export.."[url="..self:GetWowheadLinkFromItemLink(d.lootWon).."]"..d.lootWon.."[/url]"
					.." Response: "..tostring(d.response)..".\r\n"
				end
			end
			export=export.."[/list]\r\n\r\n"
		end
	end
	return export
end

--- EQdkp Plus XML, primarily for Enjin import
function LootHistory:ExportEQXML()
	local export = "<raidlog><head><export><name>EQdkp Plus XML</name><version>1.0</version></export>"
 		.."<tracker><name>RCLootCouncil</name><version>"..addon.version.."</version></tracker>"
 		.."<gameinfo><game>World of Warcraft</game><language>"..GetLocale().."</language><charactername>"..UnitName("Player").."</charactername></gameinfo></head>\r\n"
 		.."<raiddata>\r\n"
	local bossData = "\t<bosskills>\r\n"
	local zoneData = "\t<zones>\r\n"
	local itemsData = "\t<items>\r\n"
	local membersData = {}
	local raidData = {}
	local earliest = 9999999999
	local latest = 0
	for player, v in pairs(lootDB) do
		if selectedName and selectedName == player or not selectedName then
			for i, d in pairs(v) do
				if selectedDate and selectedDate == d.date or not selectedDate then
					local day, month, year = strsplit("/", d.date, 3)
					local hour,minute,second = strsplit(":",d.time,3)
					local sinceEpoch = time({year = "20"..year, month = month, day = day,hour = hour,min = minute,sec=second})
					itemsData = itemsData.."\t\t<item>\r\n"
					.."\t\t\t<itemid>" .. addon:GetItemStringFromLink(d.lootWon) .. "</itemid>\r\n"
					.."\t\t\t<name>" .. addon:GetItemNameFromLink(d.lootWon) .. "</name>\r\n"
					.."\t\t\t<member>" .. addon.Ambiguate(player) .. "</member>\r\n"
					.."\t\t\t<time>" .. sinceEpoch .. "</time>\r\n"
					.."\t\t\t<count>1</count>\r\n"
					.."\t\t\t<cost>" .. tostring(d.votes) .. "</cost>\r\n"
					.."\t\t\t<note>" .. tostring(d.response) .. "</note>\r\n"
					membersData[addon.Ambiguate(player)] = true
					bossData = bossData .. "\t\t<bosskill>\r\n"
					if d.boss then
						itemsData = itemsData .. "\t\t\t<boss>" .. gsub(tostring(d.boss),",","").. "</boss>\r\n"
						bossData = bossData.. "\t\t\t<name>"..gsub(tostring(d.boss),",","").."</name>\r\n"
					else
						itemsData = itemsData .. "\t\t\t<boss />\r\n"
						bossData = bossData.. "\t\t\t<name>Unknown</name>\r\n"
					end
					if d.instance then
						itemsData = itemsData .. "\t\t\t<zone>" .. gsub(tostring(d.instance),",","") .. "</zone>\r\n"
						raidData[time({year="20"..year,month=month,day=day})] = gsub(tostring(d.instance),",","")
						bossData = bossData.."\t\t\t<time>"..sinceEpoch.."</time>\r\n"
					else
						itemsData = itemsData .. "\t\t\t<zone />\r\n"
					end
					itemsData = itemsData.."\t\t</item>\r\n"
					bossData = bossData .. "\t\t</bosskill>\r\n"
				end
			end
		end
	end
	bossData = bossData .."\t</bosskills>\r\n"
	for id, name in pairs(raidData) do
		zoneData = zoneData .. "\t\t<zone>\r\n"
		.. "\t\t\t<enter>"..id.."</enter>\r\n"
		.. "\t\t\t<name>"..name.."</name>\r\n"
		.. "\t\t\t<leave>"..(id + 26000).."</leave>\r\n"
		.. "\t\t</zone>\r\n"
		earliest = min(earliest, id)
		latest = max(latest, id + 26000)
	end
	zoneData = zoneData .."\t</zones>\r\n"
	itemsData = itemsData.. "\t</items>\r\n"
	export = export..zoneData..bossData..itemsData
	.."\t<members>\r\n"
	for name in pairs(membersData) do
		export = export.. "\t\t<member>\r\n"
		.."\t\t\t<name>"..name.."</name>\r\n"
		.."\t\t\t<times>\r\n"
		.."\t\t\t\t<time type='join'>"..earliest.."</time>\r\n"
		.."\t\t\t\t<time type='leave'>"..latest.."</time>\r\n"
		.."\t\t\t</times>\r\n"
		.."\t\t</member>\r\n"
	end
	export=export.. "\t</members>\r\n</raiddata></raidlog>\r\n"
	return export
end

function LootHistory:ExportHTML()
	local export = "html test"
end

--- Generates a serialized string containing the entire DB.
-- For now it needs to be copied and pasted in another player's import field.
function LootHistory:PlayerExport()
	return self:EscapeItemLink(addon:Serialize(lootDB))
end
