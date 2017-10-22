local _, addonTable = ...
local E, L, C = addonTable.E, addonTable.L, addonTable.C

-- Lua
local _G = getfenv(0)

-- Blizz
local C_Timer_After = _G.C_Timer.After
local C_TransmogCollection_GetAppearanceSourceInfo = _G.C_TransmogCollection.GetAppearanceSourceInfo
local C_TransmogCollection_GetAppearanceSources = _G.C_TransmogCollection.GetAppearanceSources
local C_TransmogCollection_GetCategoryAppearances = _G.C_TransmogCollection.GetCategoryAppearances
local C_TransmogCollection_GetSourceInfo = _G.C_TransmogCollection.GetSourceInfo
local CollectionsJournal_LoadUI = _G.CollectionsJournal_LoadUI
local InCombatLockdown = _G.InCombatLockdown

-- Mine
local function Toast_OnClick(self)
	local data = self._data

	if data and not InCombatLockdown() then
		if not CollectionsJournal then
			CollectionsJournal_LoadUI()
		end

		if CollectionsJournal then
			WardrobeCollectionFrame_OpenTransmogLink(data.link)
		end
	end
end

local function IsAppearanceKnown(sourceID)
	local data = C_TransmogCollection_GetSourceInfo(sourceID)
	local sources = C_TransmogCollection_GetAppearanceSources(data.visualID)

	if sources then
		for i = 1, #sources do
			if sources[i].isCollected and sourceID ~= sources[i].sourceID then
				return true
			end
		end
	else
		return nil
	end

	return false
end

local function Toast_SetUp(event, sourceID, isAdded, attempt)
	local _, _, _, icon, _, _, link = C_TransmogCollection_GetAppearanceSourceInfo(sourceID)
	local name
	link, _, _, _, name = E:SanitizeLink(link)

	if not link then
		return attempt < 4 and C_Timer_After(0.25, function() Toast_SetUp(event, sourceID, isAdded, attempt + 1) end)
	end

	local toast, isNew, isQueued = E:GetToast(nil, "source_id", sourceID)

	if isNew then
		if isAdded then
			toast.Title:SetText(L["TRANSMOG_ADDED"])
		else
			toast.Title:SetText(L["TRANSMOG_REMOVED"])
		end

		if C.db.profile.colors.border then
			toast.Border:SetVertexColor(1, 0.5, 1)
		end

		if C.db.profile.colors.icon_border then
			toast.IconBorder:SetVertexColor(1, 0.5, 1)
		end

		toast.Text:SetText(name)
		toast.BG:SetTexture("Interface\\AddOns\\ls_Toasts\\media\\toast-bg-transmog")
		toast.Icon:SetTexture(icon)
		toast.IconBorder:Show()

		toast._data = {
			event = event,
			link = link,
			sound_file = 38326, -- SOUNDKIT.UI_DIG_SITE_COMPLETION_TOAST
			source_id = sourceID,
		}

		toast:HookScript("OnClick", Toast_OnClick)
		toast:Spawn(C.db.profile.types.transmog.dnd)
	else
		if isAdded then
			toast.Title:SetText(L["TRANSMOG_ADDED"])
		else
			toast.Title:SetText(L["TRANSMOG_REMOVED"])
		end

		if not isQueued then
			toast.AnimOut:Stop()
			toast.AnimOut:Play()
		end
	end
end

local function TRANSMOG_COLLECTION_SOURCE_ADDED(sourceID, attempt)
	local isKnown = IsAppearanceKnown(sourceID)
	attempt = attempt or 1

	if attempt < 4 then
		if isKnown == false then
			Toast_SetUp("TRANSMOG_COLLECTION_SOURCE_ADDED", sourceID, true, 1)
		elseif isKnown == nil then
			C_Timer_After(0.25, function() TRANSMOG_COLLECTION_SOURCE_ADDED(sourceID, attempt + 1) end)
		end
	end
end

local function TRANSMOG_COLLECTION_SOURCE_REMOVED(sourceID, attempt)
	local isKnown = IsAppearanceKnown(sourceID, true)
	attempt = attempt or 1

	if attempt < 4 then
		if isKnown == false then
			Toast_SetUp("TRANSMOG_COLLECTION_SOURCE_REMOVED", sourceID, nil, 1)
		elseif isKnown == nil then
			C_Timer_After(0.25, function() TRANSMOG_COLLECTION_SOURCE_REMOVED(sourceID, attempt + 1) end)
		end
	end
end

local function Enable()
	if C.db.profile.types.transmog.enabled then
		E:RegisterEvent("TRANSMOG_COLLECTION_SOURCE_ADDED", TRANSMOG_COLLECTION_SOURCE_ADDED)
		E:RegisterEvent("TRANSMOG_COLLECTION_SOURCE_REMOVED", TRANSMOG_COLLECTION_SOURCE_REMOVED)
	end
end

local function Disable()
	E:UnregisterEvent("TRANSMOG_COLLECTION_SOURCE_ADDED", TRANSMOG_COLLECTION_SOURCE_ADDED)
	E:UnregisterEvent("TRANSMOG_COLLECTION_SOURCE_REMOVED", TRANSMOG_COLLECTION_SOURCE_REMOVED)
end

local function Test()
	local appearance = C_TransmogCollection_GetCategoryAppearances(1) and C_TransmogCollection_GetCategoryAppearances(1)[1]
	local source = C_TransmogCollection_GetAppearanceSources(appearance.visualID) and C_TransmogCollection_GetAppearanceSources(appearance.visualID)[1]

	-- added
	Toast_SetUp("TRANSMOG_TEST", source.sourceID, true, 1)

	-- removed
	C_Timer_After(2, function() Toast_SetUp("TRANSMOG_TEST", source.sourceID, nil, 1) end )
end

E:RegisterOptions("transmog", {
	enabled = true,
	dnd = false,
}, {
	name = L["TYPE_TRANSMOG"],
	args = {
		enabled = {
			order = 1,
			type = "toggle",
			name = L["ENABLE"],
			get = function()
				return C.db.profile.types.transmog.enabled
			end,
			set = function(_, value)
				C.db.profile.types.transmog.enabled = value

				if value then
					Enable()
				else
					Disable()
				end
			end
		},
		dnd = {
			order = 2,
			type = "toggle",
			name = L["DND"],
			desc = L["DND_TOOLTIP"],
			get = function()
				return C.db.profile.types.transmog.dnd
			end,
			set = function(_, value)
				C.db.profile.types.transmog.dnd = value

				if value then
					Enable()
				else
					Disable()
				end
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

E:RegisterSystem("transmog", Enable, Disable, Test)
