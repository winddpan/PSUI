-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :
--               2013/07/05 IFGroup now extend from IFElementPanel
--               2013/07/22 ShadowGroupHeader added to refresh the unit panel
--               2013/07/23 IFSecurePanel instead of IFElementPanel to do the resize job
--               2013/10/19 Support unit panel only contains dead people

-- Check Version
local version = 4
if not IGAS:NewAddon("IGAS.Widget.Unit.IFGroup", version) then
	return
end

__Doc__[[Common features for unit group and pet group]]
interface "IFGroup"
	extend "IFSecurePanel"

	enum "GroupType" {
		"NONE",
		"GROUP",
		"CLASS",
		"ROLE",
		"ASSIGNEDROLE"
	}

	enum "SortType" {
		"INDEX",
		"NAME"
	}

	enum "RoleType" {
		"MAINTANK",
		"MAINASSIST",
		"TANK",
		"HEALER",
		"DAMAGER",
		"NONE"
	}

	enum "PlayerClass" {
		"WARRIOR",
		"DEATHKNIGHT",
		"PALADIN",
		"MONK",
		"PRIEST",
		"SHAMAN",
		"DRUID",
		"ROGUE",
		"MAGE",
		"WARLOCK",
		"HUNTER",
		"DEMONHUNTER",
	}

	struct "GroupFilter" { System.Number }

	struct "ClassFilter" { PlayerClass }

	struct "RoleFilter" { RoleType }

	DEFAULT_CLASS_SORT_ORDER = {
		"WARRIOR",
		"DEATHKNIGHT",
		"PALADIN",
		"MONK",
		"PRIEST",
		"SHAMAN",
		"DRUID",
		"ROGUE",
		"MAGE",
		"WARLOCK",
		"HUNTER",
		"DEMONHUNTER",
	}
	DEFAULT_ROLE_SORT_ORDER = {"MAINTANK", "MAINASSIST", "TANK", "HEALER", "DAMAGER", "NONE"}
	DEFAULT_GROUP_SORT_ORDER = {1, 2, 3, 4, 5, 6, 7, 8}

	-------------------------------------
	-- Shadow SecureGroupHeader
	-- A shadow refresh system based on the SecureGroupHeaderTemplate
	-------------------------------------
	__Doc__[[Used to handle the refresh in shadow]]
	class "ShadowGroupHeader"
		inherit "Frame"
		extend "IFSecureHandler"

		_InitHeader = [=[
			Manager = self
			-- UnitPanel = Manager:GetFrameRef("UnitPanel")

			UnitFrames = newtable()
			ShadowFrames = newtable()
			DeadFrames = newtable()

			Manager:SetAttribute("useAttributeChildCnt", 0)

			refreshDeadPlayer = [[
				for i = 1, #DeadFrames do
					local unitFrame = UnitFrames[i]

					if unitFrame then
						unitFrame:SetAttribute("unit", DeadFrames[i]:GetAttribute("unit"))
					else
						break
					end
				end

				for i = #DeadFrames + 1, #UnitFrames do
					local unitFrame = UnitFrames[i]

					if unitFrame:GetAttribute("unit") then
						unitFrame:SetAttribute("unit", nil)
					else
						break
					end
				end
			]]

			Manager:SetAttribute("newDeadPlayer", [[
				local id = ...

				if id then
					-- Follow the order
					for i = 1, #DeadFrames + 1 do
						if DeadFrames[i] then
							local oid = DeadFrames[i]:GetID()

							if oid > id then
								tinsert(DeadFrames, i, ShadowFrames[id])
								break
							elseif oid == id then
								break
							end
						else
							tinsert(DeadFrames, i, ShadowFrames[id])
						end
					end

					return self:Run(refreshDeadPlayer)
				end
			]])

			Manager:SetAttribute("removeDeadPlayer", [[
				local id = ...

				if id then
					local shadow = ShadowFrames[id]

					for i = 1, #DeadFrames do
						if DeadFrames[i] == shadow then
							tremove(DeadFrames, i)
							return self:Run(refreshDeadPlayer)
						end
					end
				end
			]])

			Manager:SetAttribute("updateStateForChild", [[
				local id = ...

				if id then
					local shadow = ShadowFrames[id]
					local unit = shadow:GetAttribute("unit")

					UnregisterAttributeDriver(shadow, "isdead")
					shadow:SetAttribute("isdead", nil)

					if unit then
						RegisterAttributeDriver(shadow, "isdead", format("[@%s,dead]true;false;", unit))
					end
				end
			]])

			Manager:SetAttribute("refreshRestUnitFrame", [[
				if Manager:GetAttribute("useAttributeChildCnt") >= #ShadowFrames then return end

				local id = ...
				if id then
					-- To safely clear unit frame generated in combat
					for i = id + 1, #UnitFrames do
						if UnitFrames[i]:GetAttribute("unit") then
							UnitFrames[i]:SetAttribute("unit", nil)
						end
					end
				end
			]])

			refreshUnitChange = [[
				local unit = self:GetAttribute("unit")
				local frame = self:GetAttribute("UnitFrame")

				if frame then
					frame:SetAttribute("unit", unit)
					self:GetAttribute("Manager"):RunAttribute("refreshRestUnitFrame", self:GetID())
				elseif self:GetAttribute("Manager"):GetAttribute("showDeadOnly") then
					self:GetAttribute("Manager"):RunAttribute("removeDeadPlayer", self:GetID())
					self:GetAttribute("Manager"):RunAttribute("updateStateForChild", self:GetID())
				end
			]]
		]=]

		_Onattributechanged = [[
			if name == "unit" then
				if type(value) == "string" then
					value = strlower(value)
				else
					value = nil
				end

				local frame = self:GetAttribute("UnitFrame")

				if frame then
					frame:SetAttribute("unit", value)
					self:GetAttribute("Manager"):RunAttribute("refreshRestUnitFrame", self:GetID())
				elseif self:GetAttribute("Manager"):GetAttribute("showDeadOnly") then
					self:GetAttribute("Manager"):RunAttribute("removeDeadPlayer", self:GetID())
					self:GetAttribute("Manager"):RunAttribute("updateStateForChild", self:GetID())
				end
			elseif name == "isdead" then
				if value == "true" then
					self:GetAttribute("Manager"):RunAttribute("newDeadPlayer", self:GetID())
				else
					self:GetAttribute("Manager"):RunAttribute("removeDeadPlayer", self:GetID())
				end
			end
		]]

		_InitialConfigFunction = [=[
			tinsert(ShadowFrames, self)

			self:SetWidth(0)
			self:SetHeight(0)
			self:SetID(#ShadowFrames)

			-- Binding
			local frame = UnitFrames[#ShadowFrames]

			self:SetAttribute("Manager", Manager)

			if frame and not Manager:GetAttribute("showDeadOnly") then
				self:SetAttribute("UnitFrame", frame)
			end

			-- Only for the entering game combat
			-- refreshUnitChange won't fire when the unit is set to nil
			self:SetAttribute("refreshUnitChange", refreshUnitChange)

			Manager:CallMethod("ShadowGroupHeader_UpdateUnitCount", #ShadowFrames)
		]=]

		_RegisterUnitFrame = [=[
			local frame = Manager:GetFrameRef("UnitFrame")

			if frame then
				tinsert(UnitFrames, frame)

				-- Binding
				if not Manager:GetAttribute("showDeadOnly") then
					local shadow = ShadowFrames[#UnitFrames]

					if shadow then
						shadow:SetAttribute("UnitFrame", frame)
						frame:SetAttribute("unit", shadow:GetAttribute("unit"))
					end
				else
					if #DeadFrames >= #UnitFrames then
						frame:SetAttribute("unit", DeadFrames[#UnitFrames]:GetAttribute("unit"))
					end
				end
			end
		]=]

		_Hide = [[
			for i = #ShadowFrames, 1, -1 do
				ShadowFrames[i]:SetAttribute("unit", nil)
			end
			-- Make sure hide all unit frames
			for i = #UnitFrames, 1, -1 do
				UnitFrames[i]:SetAttribute("unit", nil)
			end
		]]

		_ToggleShowOnlyPlayer = [[
			if self:GetAttribute("showDeadOnly") then
				for i = 1, #ShadowFrames do
					ShadowFrames[i]:SetAttribute("UnitFrame", nil)
				end
				for i = 1, #UnitFrames do
					UnitFrames[i]:SetAttribute("unit", nil)
				end
				for i = 1, #ShadowFrames do
					self:RunAttribute("updateStateForChild", i)
				end
			else
				wipe(DeadFrames)

				for i = 1, #ShadowFrames do
					local shadow = ShadowFrames[i]
					local frame = UnitFrames[i]

					UnregisterAttributeDriver(shadow, "isdead")

					if frame then
						ShadowFrames[i]:SetAttribute("UnitFrame", frame)
						frame:SetAttribute("unit", ShadowFrames[i]:GetAttribute("unit"))
					end
				end
				for i = #ShadowFrames + 1, #UnitFrames do
					UnitFrames[i]:SetAttribute("unit", nil)
				end
			end
		]]

		local function GenerateUnitFrames(self, count)
			-- Init the child
			local child = self:GetAttribute("child"..count)

			child:SetAttribute("refreshUnitChange", nil)	-- only used for the entering game combat
			child:SetAttribute("isdead", nil)
			child:SetAttribute("_onattributechanged", _Onattributechanged)

			self:SetAttribute("useAttributeChildCnt", count)

			-- Init the panel
			self = IGAS:GetWrapper(self).Parent

			if self and count and self.Count < count then
				self.Count = count

				return self:UpdatePanelSize()
			end
		end

		local function UpdateUnitCount(self, count)
			if InCombatLockdown() then
				return Task.NoCombatCall(GenerateUnitFrames, self, count)
			else
				-- Wait the SecureGroupHeader finished the init
				return Task.DelayCall(0.1, Task.NoCombatCall, GenerateUnitFrames, self, count)
			end
		end

		------------------------------------------------------
		-- Event
		------------------------------------------------------

		------------------------------------------------------
		-- Method
		------------------------------------------------------
		__Doc__[[The default refresh method]]
		function Refresh(self)
			if self.Visible and not InCombatLockdown() then
				-- Well, it's ugly
				self:Hide()
				self:Show()
			end
		end

		__Doc__[[Register an unit frame]]
		function RegisterUnitFrame(self, frame)
			self:SetFrameRef("UnitFrame", frame)
			self:Execute(_RegisterUnitFrame)
		end

		__Doc__[[Activate the unit panel]]
		function Activate(self)
			if not self.Visible then
				Task.NoCombatCall(function()
					self.Visible = true
				end)
			end
		end

		__Doc__[[Deactivate the unit panel]]
		function Deactivate(self)
			if self.Visible then
				Task.NoCombatCall(function()
					self.Visible = false
				end)
			end
		end

		__Doc__[[
			<desc>Set whether only show dead players</desc>
			<param name="flag"></param>
			]]
		function SetShowDeadOnly(self, flag)
			flag = flag and true or false

			if flag ~= self.ShowDeadOnly then
				Task.NoCombatCall(function()
					self:SetAttribute("showDeadOnly", flag)

					self:Execute(_ToggleShowOnlyPlayer)
				end)
			end
		end

		__Doc__[[
			<desc>Whether only show the dead players</desc>
			<return type="boolean">true if only show dead players</return>
		]]
		function IsShowDeadOnly(self)
			return self:GetAttribute("showDeadOnly") and true or false
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[Whether the unit panel is activated]]
		property "Activated" {
			Get = function(self)
				return self.Visible
			end,
			Set = function(self, value)
				if value then
					self:Activate()
				else
					self:Deactivate()
				end
			end,
			Type = Boolean,
		}

		__Doc__[[Whether only show the dead players]]
		property "ShowDeadOnly" {
			Get = "IsShowDeadOnly",
			Set = "SetShowDeadOnly",
			Type = Boolean,
		}

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	    function ShadowGroupHeader(self, ...)
	    	Super(self, ...)

			IGAS:GetUI(self).ShadowGroupHeader_UpdateUnitCount = UpdateUnitCount

			self.Visible = false

    		self:Execute(_InitHeader)

    		self:SetAttribute("template", "SecureHandlerAttributeTemplate")
    		self:SetAttribute("initialConfigFunction", _InitialConfigFunction)
    		self:SetAttribute("strictFiltering", true)
    		self:SetAttribute("groupingOrder", "")

    		self:WrapScript(self, "OnHide", _Hide)

    		-- Throw out of the screen
    		self:SetPoint("TOPRIGHT", UIParent, "TOPLEFT")
    		self.Alpha = 0
	    end
	endclass "ShadowGroupHeader"

	------------------------------------------------------
	-- Helper functions
	------------------------------------------------------
	_Cache = {}

	local function SecureSetAttribute(self, attr, value)
		return Task.NoCombatCall(self.SetAttribute, self, attr, value)
	end

	local function SetupGroupFilter(self)
		local groupFilter = self.GroupFilter or DEFAULT_GROUP_SORT_ORDER
		local classFilter = self.ClassFilter or DEFAULT_CLASS_SORT_ORDER

		wipe(_Cache)

		for _, v in ipairs(groupFilter) do
			tinsert(_Cache, v)
		end

		for _, v in ipairs(classFilter) do
			tinsert(_Cache, v)
		end

		SecureSetAttribute(self.GroupHeader, "groupFilter", table.concat(_Cache, ","))

		wipe(_Cache)
	end

	local function SetupRoleFilter(self)
		local roleFilter = self.RoleFilter or DEFAULT_ROLE_SORT_ORDER

		wipe(_Cache)

		for _, v in ipairs(roleFilter) do
			tinsert(_Cache, v)
		end

		SecureSetAttribute(self.GroupHeader, "roleFilter", table.concat(_Cache, ","))

		wipe(_Cache)
	end

	local function SetupGroupingOrder(self)
		local groupBy = self.GroupBy
		local filter

		if groupBy == "GROUP" then
			filter = self.GroupFilter or DEFAULT_GROUP_SORT_ORDER
		elseif groupBy == "CLASS" then
			filter = self.ClassFilter or DEFAULT_CLASS_SORT_ORDER
		elseif groupBy == "ROLE" or groupBy == "ASSIGNEDROLE" then
			filter = self.RoleFilter or DEFAULT_ROLE_SORT_ORDER
		end

		wipe(_Cache)

		if filter then
			for _, v in ipairs(filter) do
				tinsert(_Cache, v)
			end
		end

		SecureSetAttribute(self.GroupHeader, "groupingOrder", table.concat(_Cache, ","))

		wipe(_Cache)
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[The default refresh method]]
	function Refresh(self)
		if InCombatLockdown() then return end

		self.GroupHeader:Refresh()

		return self:UpdatePanelSize()
	end

	__Doc__[[
		<desc>Init the unit panel with a unit count</desc>
		<param name="count">number, the units count</param>
	]]
	__Delegate__(Task.NoCombatCall)
	function InitWithCount(self, count)
		self.Count = count
	end

	__Doc__[[Activate the unit panel]]
	function Activate(self)
		self.GroupHeader:Activate()
	end

	__Doc__[[Deactivate the unit panel]]
	function Deactivate(self)
		self.GroupHeader:Deactivate()
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether the unit panel is activated]]
	property "Activated" {
		Get = function(self)
			return self.GroupHeader.Activated
		end,
		Set = function(self, value)
			if value then
				self:Activate()
			else
				self:Deactivate()
			end
		end,
		Type = Boolean,
	}

	__Doc__[[Whether the panel should be shown while in a raid]]
	property "ShowRaid" {
		Get = function(self)
			return self.GroupHeader:GetAttribute("showRaid")
		end,
		Set = function(self, value)
			SecureSetAttribute(self.GroupHeader, "showRaid", value)
		end,
		Type = Boolean,
	}

	__Doc__[[Whether the panel should be shown while in a party and not in a raid]]
	property "ShowParty" {
		Get = function(self)
			return self.GroupHeader:GetAttribute("showParty")
		end,
		Set = function(self, value)
			SecureSetAttribute(self.GroupHeader, "showParty", value)
		end,
		Type = Boolean,
	}

	__Doc__[[Whether the panel should show the player while not in a raid]]
	property "ShowPlayer" {
		Get = function(self)
			return self.GroupHeader:GetAttribute("showPlayer")
		end,
		Set = function(self, value)
			SecureSetAttribute(self.GroupHeader, "showPlayer", value)
		end,
		Type = Boolean,
	}

	__Doc__[[Whether the panel should be shown while not in a group]]
	property "ShowSolo" {
		Get = function(self)
			return self.GroupHeader:GetAttribute("showSolo")
		end,
		Set = function(self, value)
			SecureSetAttribute(self.GroupHeader, "showSolo", value)
		end,
		Type = Boolean,
	}

	__Doc__[[A list of raid group numbers, used as the filter settings and order settings(if GroupBy is "GROUP")]]
	__Handler__(function (self, value)
		if value and not next(value) then self.GroupFilter = nil return end
		SetupGroupFilter(self)
		if self.GroupBy == "GROUP" then SetupGroupingOrder(self) end
	end)
	__Setter__("Clone") property "GroupFilter" { Type = GroupFilter }

	__Doc__[[A list of uppercase class names, used as the filter settings and order settings(if GroupBy is "CLASS")]]
	__Handler__(function (self, value)
		if value and not next(value) then self.ClassFilter = nil return end
		SetupGroupFilter(self)
		if self.GroupBy == "CLASS" then SetupGroupingOrder(self) end
	end)
	__Setter__("Clone") property "ClassFilter" { Type = ClassFilter }

	__Doc__[[A list of uppercase role names, used as the filter settings and order settings(if GroupBy is "ROLE")]]
	__Handler__(function (self, value)
		if value and not next(value) then self.RoleFilter = nil return end
		SetupRoleFilter(self)
		if self.GroupBy == "ROLE" or self.GroupBy == "ASSIGNEDROLE" then
			SetupGroupingOrder(self)
		end
	end)
	__Setter__("Clone") property "RoleFilter" { Type = RoleFilter }

	__Doc__[[Specifies a "grouping" type to apply before regular sorting (Default: nil)]]
	__Handler__(function (self, value)
		if value == "NONE" then value = nil end
		SecureSetAttribute(self.GroupHeader, "groupBy", value)
		SetupGroupingOrder(self)
	end)
	property "GroupBy" { Type = GroupType, Default = "NONE" }

	__Doc__[[Defines how the group is sorted (Default: "INDEX")]]
	property "SortBy" {
		Get = function(self)
			return self.GroupHeader:GetAttribute("sortMethod")
		end,
		Set = function(self, value)
			SecureSetAttribute(self.GroupHeader, "sortMethod", value)
		end,
		Type = SortType, Default = "INDEX"
	}

	__Doc__[[The group header based on the blizzard's SecureGroupHeader]]
	property "GroupHeader" {
		Get = function(self)
			return self:GetChild("ShadowGroupHeader") or ShadowGroupHeader("ShadowGroupHeader", self, "SecureGroupHeaderTemplate")
		end,
	}

	__Doc__[[Whether only show the dead players]]
	property "ShowDeadOnly" {
		Get = function(self)
			return self.GroupHeader.ShowDeadOnly
		end,
		Set = function(self, value)
			self.GroupHeader.ShowDeadOnly = value
		end,
		Type = Boolean,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnElementAdd(self, element)
		element.NoUnitWatch = true
		element:SetAttribute("unit", nil)

		self.GroupHeader:RegisterUnitFrame(element)
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFGroup(self)
		self.OnElementAdd = self.OnElementAdd + OnElementAdd

		SetupGroupFilter(self)
	end
endinterface "IFGroup"
