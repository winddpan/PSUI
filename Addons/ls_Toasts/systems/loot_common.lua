local _, addonTable = ...
local E, L, C = addonTable.E, addonTable.L, addonTable.C

-- Lua
local _G = getfenv(0)
local m_random = _G.math.random
local s_split = _G.string.split
local tonumber = _G.tonumber

-- Blizz
local BattlePetToolTip_Show = _G.BattlePetToolTip_Show
local C_PetJournal_GetPetInfoBySpeciesID = _G.C_PetJournal.GetPetInfoBySpeciesID
local C_Timer_After = _G.C_Timer.After
local GetItemInfo = _G.GetItemInfo
local OpenBag = _G.OpenBag
local UnitName = _G.UnitName

-- Mine
local PLAYER_NAME = UnitName("player")

local function Toast_OnClick(self)
	if self._data then
		local bag = E:SearchBagsForItemID(self._data.item_id)

		if bag >= 0 then
			OpenBag(bag)
		end
	end
end

local function Toast_OnEnter(self)
	if self._data.tooltip_link:find("item") then
		GameTooltip:SetHyperlink(self._data.tooltip_link)
		GameTooltip:Show()
	elseif self._data.tooltip_link:find("battlepet") then
		local _, speciesID, level, breedQuality, maxHealth, power, speed = s_split(":", self._data.tooltip_link)
		BattlePetToolTip_Show(tonumber(speciesID), tonumber(level), tonumber(breedQuality), tonumber(maxHealth), tonumber(power), tonumber(speed))
	end
end

local function PostSetAnimatedValue(self, value)
	self:SetText(value == 1 and "" or value)
end

local function Toast_SetUp(event, link, quantity)
	local sanitizedLink, originalLink, linkType, itemID = E:SanitizeLink(link)
	local toast, isNew, isQueued

	-- Check if there's a toast for this item from another event
	toast, isQueued = E:FindToast(nil, "link", sanitizedLink)

	if toast then
		if toast._data.event ~= event then
			return
		end
	else
		toast, isNew, isQueued = E:GetToast()
	end

	if isNew then
		local name, quality, icon, _, classID, subClassID, bindType, isQuestItem

		if linkType == "battlepet" then
			local _, speciesID, _, breedQuality, _ = s_split(":", originalLink)
			name, icon = C_PetJournal_GetPetInfoBySpeciesID(speciesID)
			quality = tonumber(breedQuality)
		else
			name, _, quality, _, _, _, _, _, _, icon, _, classID, subClassID, bindType = GetItemInfo(originalLink)
			isQuestItem = bindType == 4 or (classID == 12 and subClassID == 0)
		end

		if (quality >= C.db.profile.types.loot_common.threshold and quality <= 5)
			or (C.db.profile.types.loot_common.quest and isQuestItem) then
			local color = ITEM_QUALITY_COLORS[quality] or ITEM_QUALITY_COLORS[1]

			toast.IconText1.PostSetAnimatedValue = PostSetAnimatedValue

			if C.db.profile.colors.name then
				name = color.hex..name.."|r"
			end

			if C.db.profile.types.loot_common.ilvl then
				local iLevel = E:GetItemLevel(originalLink)

				if iLevel > 0 then
					name = "["..color.hex..iLevel.."|r] "..name
				end
			end

			if C.db.profile.colors.border then
				toast.Border:SetVertexColor(color.r, color.g, color.b)
			end

			if C.db.profile.colors.icon_border then
				toast.IconBorder:SetVertexColor(color.r, color.g, color.b)
			end

			toast.Title:SetText(L["YOU_RECEIVED"])
			toast.Text:SetText(name)
			toast.Icon:SetTexture(icon)
			toast.IconBorder:Show()
			toast.IconHL:SetShown(isQuestItem)
			toast.IconText1:SetAnimatedValue(quantity, true)

			toast._data = {
				count = quantity,
				event = event,
				link = sanitizedLink,
				sound_file = 31578, -- SOUNDKIT.UI_EPICLOOT_TOAST
				tooltip_link = originalLink,
				item_id = itemID,
			}

			toast:HookScript("OnClick", Toast_OnClick)
			toast:HookScript("OnEnter", Toast_OnEnter)
			toast:Spawn(C.db.profile.types.loot_common.dnd)
		else
			toast:Recycle()
		end
	else
		if isQueued then
			toast._data.count = toast._data.count + quantity
			toast.IconText1:SetAnimatedValue(toast._data.count, true)
		else
			toast._data.count = toast._data.count + quantity
			toast.IconText1:SetAnimatedValue(toast._data.count)

			toast.IconText2:SetText("+"..quantity)
			toast.IconText2.Blink:Stop()
			toast.IconText2.Blink:Play()

			toast.AnimOut:Stop()
			toast.AnimOut:Play()
		end
	end
end

local LOOT_ITEM_PATTERN
local LOOT_ITEM_PUSHED_PATTERN
local LOOT_ITEM_MULTIPLE_PATTERN
local LOOT_ITEM_PUSHED_MULTIPLE_PATTERN

local function CHAT_MSG_LOOT(message, _, _, _, target)
	if target ~= PLAYER_NAME then
		return
	end

	local link, quantity = message:match(LOOT_ITEM_MULTIPLE_PATTERN)

	if not link then
		link, quantity = message:match(LOOT_ITEM_PUSHED_MULTIPLE_PATTERN)

		if not link then
			quantity, link = 1, message:match(LOOT_ITEM_PATTERN)

			if not link then
				quantity, link = 1, message:match(LOOT_ITEM_PUSHED_PATTERN)

				if not link then
					return
				end
			end
		end
	end

	C_Timer_After(0.125, function() Toast_SetUp("CHAT_MSG_LOOT", link, tonumber(quantity) or 0) end)
end

local function Enable()
	LOOT_ITEM_PATTERN = LOOT_ITEM_SELF:gsub("%%s", "(.+)"):gsub("^", "^")
	LOOT_ITEM_PUSHED_PATTERN = LOOT_ITEM_PUSHED_SELF:gsub("%%s", "(.+)"):gsub("^", "^")
	LOOT_ITEM_MULTIPLE_PATTERN = LOOT_ITEM_SELF_MULTIPLE:gsub("%%s", "(.+)"):gsub("%%d", "(%%d+)"):gsub("^", "^")
	LOOT_ITEM_PUSHED_MULTIPLE_PATTERN = LOOT_ITEM_PUSHED_SELF_MULTIPLE:gsub("%%s", "(.+)"):gsub("%%d", "(%%d+)"):gsub("^", "^")

	if C.db.profile.types.loot_common.enabled then
		E:RegisterEvent("CHAT_MSG_LOOT", CHAT_MSG_LOOT)
	end
end

local function Disable()
	E:UnregisterEvent("CHAT_MSG_LOOT", CHAT_MSG_LOOT)
end

local function Test()
	-- item, Chaos Crystal
	local _, link = GetItemInfo(124442)

	if link then
		Toast_SetUp("COMMON_LOOT_TEST", link, m_random(9, 99))
	end

	-- battlepet, Anubisath Idol
	Toast_SetUp("COMMON_LOOT_TEST", "battlepet:1155:25:3:1725:276:244:0000000000000000", 1)
end

E:RegisterOptions("loot_common", {
	enabled = true,
	dnd = false,
	threshold = 1,
	ilvl = true,
	quest = false,
}, {
	name = L["TYPE_LOOT_COMMON"],
	args = {
		desc = {
			order = 1,
			type = "description",
			name = L["TYPE_LOOT_COMMON_DESC"],
		},
		enabled = {
			order = 2,
			type = "toggle",
			name = L["ENABLE"],
			get = function()
				return C.db.profile.types.loot_common.enabled
			end,
			set = function(_, value)
				C.db.profile.types.loot_common.enabled = value

				if value then
					Enable()
				else
					Disable()
				end
			end
		},
		dnd = {
			order = 3,
			type = "toggle",
			name = L["DND"],
			desc = L["DND_TOOLTIP"],
			get = function()
				return C.db.profile.types.loot_common.dnd
			end,
			set = function(_, value)
				C.db.profile.types.loot_common.dnd = value

				if value then
					Enable()
				else
					Disable()
				end
			end
		},
		ilvl = {
			order = 4,
			type = "toggle",
			name = L["SHOW_ILVL"],
			desc = L["SHOW_ILVL_DESC"],
			get = function()
				return C.db.profile.types.loot_common.ilvl
			end,
			set = function(_, value)
				C.db.profile.types.loot_common.ilvl = value
			end
		},
		threshold = {
			order = 5,
			type = "select",
			name = L["LOOT_THRESHOLD"],
			values = {
				[1] = ITEM_QUALITY_COLORS[1].hex..ITEM_QUALITY1_DESC.."|r",
				[2] = ITEM_QUALITY_COLORS[2].hex..ITEM_QUALITY2_DESC.."|r",
				[3] = ITEM_QUALITY_COLORS[3].hex..ITEM_QUALITY3_DESC.."|r",
				[4] = ITEM_QUALITY_COLORS[4].hex..ITEM_QUALITY4_DESC.."|r",
			},
			get = function()
				return C.db.profile.types.loot_common.threshold
			end,
			set = function(_, value)
					C.db.profile.types.loot_common.threshold = value
			end,
		},
		quest = {
			order = 6,
			type = "toggle",
			name = L["SHOW_QUEST_ITEMS"],
			desc = L["SHOW_QUEST_ITEMS_DESC"],
			get = function()
				return C.db.profile.types.loot_common.quest
			end,
			set = function(_, value)
				C.db.profile.types.loot_common.quest = value
			end
		},
		test = {
			type = "execute",
			order = 99,
			width = "full",
			name = L["TEST"],
			func = Test,
		},
	},
})

E:RegisterSystem("loot_common", Enable, Disable, Test)
