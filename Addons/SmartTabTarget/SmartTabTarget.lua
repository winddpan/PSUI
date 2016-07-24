local addonName, addon 	= ...

local SmartTabTarget    = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog 	= LibStub("AceConfigDialog-3.0")

local configDefaults = {
	profile = {
		switch = {
			flagged = false,
			bg = true,
			arena = true,
			arenaSkirmish = true,
			world = nil,
			ashran = true,
		},
		verbose = true,
	}
}

local optionsTable = {
	type = "group",
	args = {
		enable = {
			order = 100,
			name = "Enable",
			type = "toggle",

			set = function(info, value)
				if SmartTabTarget:IsEnabled() then
					SmartTabTarget:Disable()
				else
					SmartTabTarget:Enable()
				end
			end,

			get = function(info)
				return SmartTabTarget:IsEnabled()
			end,
		},
		verbose = {
			order = 200,
			name = "Verbose",
			desc = "Show a message in the chat window when tab-targetting changes",
			type = "toggle",

			set = function(info, value)
				SmartTabTarget.db.profile.verbose = value
			end,

			get = function(info)
				return SmartTabTarget.db.profile.verbose
			end,

			disabled = function()
				return (not SmartTabTarget:IsEnabled())
			end,
		},
		switchWhen = {
			order = 300,
			name = "Switch when...",
			type = "header",
		},
		flagged = {
			order = 400,
			name = "Flagged",
			desc = "Switch tab-targetting to players-only whenever you are flagged for PvP",
			type = "toggle",

			set = function(info, value)
				SmartTabTarget.db.profile.switch.flagged = value
				SmartTabTarget:CheckSwitch()
			end,

			get = function(info)
				return SmartTabTarget.db.profile.switch.flagged
			end,

			disabled = function()
				return (not SmartTabTarget:IsEnabled())
			end,
		},
		bg = {
			order = 500,
			name = "In Battlegrounds",
			desc = "Switch tab-targetting to players-only whenever you are in a battleground",
			type = "toggle",

			set = function(info, value)
				SmartTabTarget.db.profile.switch.bg = value
				SmartTabTarget:CheckSwitch()
			end,

			get = function(info)
				return SmartTabTarget.db.profile.switch.bg
			end,

			disabled = function()
				return (not SmartTabTarget:IsEnabled())
			end,
		},
		boss = {
			order = 550,
			name = "All Enemies in Boss Rooms",
			desc = "Switches to \"all enemies\" when in the enemy boss' room in Alterac Valley. (Note: Please keep in mind that bindings can not be changed while in combat)",
			type = "toggle",

			set = function(info, value)
				SmartTabTarget.db.profile.switch.boss = value
				SmartTabTarget:CheckSwitch()
			end,

			get = function(info)
				return SmartTabTarget.db.profile.switch.boss
			end,

			disabled = function()
				return (not SmartTabTarget:IsEnabled() or not SmartTabTarget.db.profile.switch.bg)
			end,
		},
		arena = {
			order = 600,
			name = "In Arenas",
			desc = "Switch tab-targetting to players-only whenever you are in an arena",
			type = "toggle",

			set = function(info, value)
				SmartTabTarget.db.profile.switch.arena = value
				SmartTabTarget:CheckSwitch()
			end,

			get = function(info)
				return SmartTabTarget.db.profile.switch.arena
			end,

			disabled = function()
				return (not SmartTabTarget:IsEnabled())
			end,
		},
		arenaSkirmish = {
			order = 650,
			name = "In Arena Skirmish",
			desc = "Switch tab-targetting to players-only whenever you are in an arena skirmish",
			type = "toggle",

			set = function(info, value)
				SmartTabTarget.db.profile.switch.arenaSkirmish = value
				SmartTabTarget:CheckSwitch()
			end,

			get = function(info)
				return SmartTabTarget.db.profile.switch.arenaSkirmish
			end,

			disabled = function()
				return (not SmartTabTarget:IsEnabled())
			end,
		},
		world = {
			order = 700,
			name = "In World PvP Zones",
			desc = "Switch tab-targetting to players-only whenever you are in a world PvP zone such as Wintergrasp or Tol Barad. A grey check will only switch when the battle is active.",
			type = "toggle",
			tristate = true,

			set = function(info, value)
				SmartTabTarget.db.profile.switch.world = value
				SmartTabTarget:CheckSwitch()
			end,

			get = function(info)
				return SmartTabTarget.db.profile.switch.world
			end,

			disabled = function()
				return (not SmartTabTarget:IsEnabled())
			end,
		},
		ashran = {
			order = 800,
			name = "In Ashran",
			desc = "Switch tab-targetting to players-only whenever you are in Ashran.",
			type = "toggle",
			tristate = true,

			set = function(info, value)
				SmartTabTarget.db.profile.switch.ashran = value
				SmartTabTarget:CheckSwitch()
			end,

			get = function(info)
				return SmartTabTarget.db.profile.switch.ashran
			end,

			disabled = function()
				return (not SmartTabTarget:IsEnabled())
			end,
		},

	},
}

function SmartTabTarget:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SmartTabTargetSavedVariables", configDefaults)
	self.db.RegisterCallback(self, "OnProfileChanged", "CheckSwitch")
	self.db.RegisterCallback(self, "OnProfileCopied", "CheckSwitch")
	self.db.RegisterCallback(self, "OnProfileReset", "CheckSwitch")
	
	if self.db.profile.switch.ashran == nil then
		self.db.profile.switch.ashran = true
	end
	
	AceConfigRegistry:RegisterOptionsTable(addonName, optionsTable)
	AceConfigDialog:AddToBlizOptions(addonName)
	AceConfigDialog:SetDefaultSize(addonName, 400, 250)

	self:RegisterChatCommand("stt", function()
		AceConfigDialog:Open(addonName)
	end)

	self:RegisterChatCommand("smarttabtarget", function()
		AceConfigDialog:Open(addonName)
	end)

end

local checkEvents = {					-- catches:
	["PLAYER_ENTERING_WORLD"] = true,	-- bg/arena
	["UNIT_FACTION"] = true,			-- pvp flag
	["ZONE_CHANGED"] = true,			-- boss rooms
	["ZONE_CHANGED_NEW_AREA"] = true,	-- world pvp zone
	["UPDATE_WORLD_STATES"] = true,		-- world pvp zone changing btwn active & not
}

function SmartTabTarget:OnEnable()
	self:CheckSwitch()

	for event in pairs(checkEvents) do
		self:RegisterEvent(event, "CheckSwitch")
	end
end

function SmartTabTarget:OnDisable()
	self:DoSwitch()

	for event in pairs(checkEvents) do
		self:UnregisterEvent(event)
	end
end

-- checks if tab-targetting should be switched based on current options
function SmartTabTarget:CheckSwitch()
	--pvp flagged
	if self.db.profile.switch.flagged and UnitIsPVP("player") then
		self:DoSwitch(true)
		return
	end

	--battleground/arena
	if self.db.profile.switch.bg or self.db.profile.switch.arena or self.db.profile.switch.arenaSkirmish then
		for i = 1, GetMaxBattlefieldID() do
			local status, _, _, _, _, queueType = GetBattlefieldStatus(i)
			if status == "active" then
				if (queueType == "ARENA") and self.db.profile.switch.arena then
					self:DoSwitch(true)
					return
				elseif (queueType == "ARENASKIRMISH") and self.db.profile.switch.arenaSkirmish then
					self:DoSwitch(true)
					return
				elseif (queueType == "BATTLEGROUND") and self.db.profile.switch.bg then
					if self.db.profile.switch.boss then
						local subZone = GetSubZoneText()
						local faction = UnitFactionGroup("player")
						if (faction == "Horde") then
							if (subZone == "Hall of the Stormpike") then
								self:DoSwitch()
								return
							end
						elseif (faction == "Alliance") then
							if (subZone == "Hall of the Frostwolf") then
								self:DoSwitch()
								return
							end
						end
					end
					self:DoSwitch(true)
					return
				end
			end
		end
	end

	--ashran
	if self.db.profile.switch.ashran then
		local _, name = GetWorldPVPAreaInfo(3)
		if name == GetRealZoneText() then
			self:DoSwitch(true)
			return
		end
	end
	
	--world pvp zone
	if self.db.profile.switch.world ~= false then
		local inWorldPvPZone = false
		for i = 1, GetNumWorldPVPAreas() do
			local _, name = GetWorldPVPAreaInfo(i)
			if name == GetRealZoneText() then
				inWorldPvPZone = true
				break
			end
		end
		if inWorldPvPZone then
			if self.db.profile.switch.world == nil then
				self:DoSwitch(IsInActiveWorldPVP())
				return
			else
				self:DoSwitch(true)
				return
			end
		end
	end

	self:DoSwitch() -- switches tab-targetting to all enemies if all else fails
end

-- switches tab-targetting based on passed argument
local bindingCoroutine
function SmartTabTarget:DoSwitch(toPlayerOnly)
	local bindingString = (toPlayerOnly and "TARGETNEARESTENEMYPLAYER") or "TARGETNEARESTENEMY"
	local chatString = (toPlayerOnly and "players only") or "any enemy"

	local currentBindings = {GetBindingKey(bindingString)}

	if (#currentBindings > 0) then
		for i, binding in ipairs(currentBindings) do
            if binding == "TAB" then
				return -- binding is already tab, don't need to do anything
			end
		end
	end

	bindingCoroutine = coroutine.create(function()

        while true do
			if not InCombatLockdown() then -- break loop if not in combat
				break
			end
			self:RegisterEvent("PLAYER_REGEN_ENABLED", function()
				coroutine.resume(bindingCoroutine)
			end)
			coroutine.yield()
		end

		self:UnregisterEvent("PLAYER_REGEN_ENABLED")

        local success = SetBinding("TAB", bindingString)

        if self.db.profile.verbose and success then
            print(string.format("Tab-targetting switched to %s.", chatString))
        end

        if not success then
            print("There was a problem changing the keybinding.")
        end
    end)

    coroutine.resume(bindingCoroutine)
end
