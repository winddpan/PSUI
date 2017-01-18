-- Author      : Kurapica
-- Create Date : 2012/06/24
-- Change Log  :
--               2013/05/25 Reduce memory cost
--               2013/07/04 UnitFrame can handle the change of attribute "unit"
--               2013/07/05 Use attribute "deactivated" instead of "__Deactivated"
--               2013/08/03 Add same unit check, reduce cost
--               2013/10/20 NoUnitWatch property added, used for unitframes on a unit panel, reduce cost for the SecureStateDriver
--               2016/02/28 Add monitor for hide un-expected shown NoUnitWatch Frames

-- Check Version
local version = 11
if not IGAS:NewAddon("IGAS.Widget.Unit.UnitFrame", version) then
	return
end

__Doc__[[UnitFrame is used to display information about an unit, and can be used to do the common actions on the unit]]
__AutoProperty__()
class "UnitFrame"
	inherit "Button"
	extend "IFContainer" "IFSecureHandler"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUpdate(self, elapsed)
		self.__OnUpdateTimer = (self.__OnUpdateTimer or 0) + elapsed

		if self.__OnUpdateTimer > self.Interval then
			self.__OnUpdateTimer = 0
			return self:UpdateElements()
		end
	end

	local function UNIT_NAME_UPDATE(self, unit)
		if self.Unit and UnitIsUnit(self.Unit, unit) then
			return self:UpdateElements()
		end
	end

	local function UNIT_PET(self, unit)
		if unit and self.Unit and UnitIsUnit(self.Unit, unit .. "pet") then
			return self:UpdateElements()
		end
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Add a unit element into the unit frame</desc>
		<format>elementType[, direction[, size, sizeunit] ]</format>
		<param name="elementType">class, the unit element's class</param>
		<param name="direction">System.Widget.DockLayoutPanel.Direction</param>
		<param name="size">number, the height size if the direction is 'NORTH' or 'SOUTH', the width size if the direction is 'WEST' or 'EAST'</param>
		<param name="sizeunit">System.Widget.LayoutPanel.Unit</param>
	]]
	function AddElement(self, ...)
		IFContainer.AddWidget(self, ...)

		self:Each("Unit", self.Unit)
	end

	__Doc__[[
		<desc>Insert a unit element into the unit frame</desc>
		<format>before, elementType[, direction[, size, sizeunit] ]</format>
		<param name="before">System.Widget.Region|System.Widget.VirtualUIObject, the element to be inserted before</param>
		<param name="elementType">class, the unit element's class</param>
		<param name="direction">System.Widget.DockLayoutPanel.Direction</param>
		<param name="size">number, the height size if the direction is 'NORTH' or 'SOUTH', the width size if the direction is 'WEST' or 'EAST'</param>
		<param name="sizeunit">System.Widget.LayoutPanel.Unit</param>
	]]
	function InsertElement(self, ...)
		IFContainer.InsertWidget(self, ...)

		self:Each("Unit", self.Unit)
	end

	__Doc__[[
		<desc>Gets the unit element</desc>
		<format>name|elementType</format>
		<param name="name">string, the unit element's name or its class's name</param>
		<param name="elementType">class, the unit elements's class type</param>
		<return type="System.Widget.Region|System.Widget.VirtualUIObject">the unit element</return>
	]]
	function GetElement(self, ...)
		return IFContainer.GetWidget(self, ...)
	end

	__Doc__[[
		<desc>Remove the unit element</desc>
		<format>name|elementType[, withoutDispose]</format>
		<param name="name">string, the unit element's name or its class's name</param>
		<param name="elementType">class, the unit elements's class type</param>
		<param name="withoutDispose">boolean, true if don't dispose the unit element</param>
		<return type="System.Widget.Region|System.Widget.VirtualUIObject">nil if the withoutDispose is false, or the unit element is the System.Widget.Region|System.Widget.VirtualUIObject is true</return>
	]]
	function RemoveElement(self, ...)
		return IFContainer.RemoveWidget(self, ...)
	end

	__Doc__[[
		<desc>Sets the Unit for the unit frame</desc>
		<param name="unit">string|nil, the unitid</param>
	]]
	function SetUnit(self, unit)
		if type(unit) == "string" then
			unit = strlower(unit)
		else
			unit = nil
		end

		if unit ~= self:GetAttribute("unit") then
			self:SetAttribute("unit", unit)
		else
			self:Each("Unit", unit)
		end
	end

	__Doc__[[
		<desc>Gets the unit frame's Unit</desc>
		<return type="string"></return>
	]]
	function GetUnit(self, unit)
		return self:GetAttribute("unit")
	end

	__Doc__[[Update all unit elements of the unit frame]]
	function UpdateElements(self)
		self:Each("Refresh")
	end

	__Doc__[[Activate the unit frame]]
	function Activate(self)
		if self:GetAttribute("deactivated") then
			local unitId = type(self:GetAttribute("deactivated")) == "string" and self:GetAttribute("deactivated") or nil

			self:SetAttribute("deactivated", nil)

			self:SetUnit(unitId)
		end
	end

	__Doc__[[Deactivate the unit frame]]
	function Deactivate(self)
		if not self:GetAttribute("deactivated") then
			self:SetAttribute("deactivated", self:GetUnit() or true)

			SetUnit(self, nil)
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The unit's ID]]
	property "Unit" { Type = String }

	__Doc__[[The refresh interval for special unit like 'targettarget']]
	property "Interval" { Type = PositiveNumber, Default = 0.5 }

	__Doc__[[Whether the unit frame is activated]]
	property "Activated" {
		Get = function(self)
			return not self:GetAttribute("deactivated")
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

	__Doc__[[Whether need unit watch, enable this when using on a raid panel]]
	property "NoUnitWatch" {
		Get = function(self)
			return self:GetAttribute("nounitwatch") and true or false
		end,
		Set = function(self, value)
			if self.NoUnitWatch ~= value then
				self:SetAttribute("nounitwatch", value)
			end
		end,
		Type = Boolean,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	_GameTooltip = _G.GameTooltip

	local function UpdateTooltip(self)
		GameTooltip_SetDefaultAnchor(_GameTooltip, self)
		if ( _GameTooltip:SetUnit(self.Unit) ) then
			self.UpdateTooltip = UpdateTooltip
		else
			self.UpdateTooltip = nil
		end
		local r, g, b = GameTooltip_UnitColor(self.Unit)
		_G.GameTooltipTextLeft1:SetTextColor(r, g, b)
	end

	local function OnEnter(self)
		if self.Unit then
			IGAS:GetUI(self).Unit = self.Unit
			UpdateTooltip(IGAS:GetUI(self))
		end
	end

	local function OnLeave(self)
		_GameTooltip:FadeOut()
	end

	local function OnShow(self)
		self:UpdateElements()
	end

	local function UpdateUnitFrame(self, unit)
		self = IGAS:GetWrapper(self)

		self:Each("Unit", unit)

		if unit == "target" then
			self:RegisterEvent("PLAYER_TARGET_CHANGED")
			self.PLAYER_TARGET_CHANGED = UpdateElements
		else
			self:UnregisterEvent("PLAYER_TARGET_CHANGED")
			self.PLAYER_TARGET_CHANGED = nil
		end

		if unit == "mouseover" then
			self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
			self.UPDATE_MOUSEOVER_UNIT = UpdateElements
		else
			self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
			self.UPDATE_MOUSEOVER_UNIT = nil
		end

		if unit == "focus" then
			self:RegisterEvent("PLAYER_FOCUS_CHANGED")
			self.PLAYER_FOCUS_CHANGED = UpdateElements
		else
			self:UnregisterEvent("PLAYER_FOCUS_CHANGED")
			self.PLAYER_FOCUS_CHANGED = nil
		end

		if unit and (unit:match("^party%d") or unit:match("^raid%d")) then
			self:RegisterEvent("UNIT_NAME_UPDATE")
			self.UNIT_NAME_UPDATE = UNIT_NAME_UPDATE
		else
			self:UnregisterEvent("UNIT_NAME_UPDATE")
			self.UNIT_NAME_UPDATE = nil
		end

		if unit and unit:match("pet") then
			self:RegisterEvent("UNIT_PET")
			self.UNIT_PET = UNIT_PET
		else
			self:UnregisterEvent("UNIT_PET")
			self.UNIT_PET = nil
		end

		--if unit and (unit:match("%w+target") or unit:match("(boss)%d?$")) then
		if unit and (unit:match("%w+target")) then
			self.OnUpdate = OnUpdate
		else
			self.OnUpdate = nil
		end
	end

	_onattributechanged = [[
		if name == "unit" then
			if self:GetAttribute("deactivated") and value then
				return self:SetAttribute("unit", nil)
			end

			if type(value) == "string" then
				value = strlower(value)
			else
				value = nil
			end

			local nounitwatch = self:GetAttribute("nounitwatch")

			if value == "player" then
				if not nounitwatch then
					UnregisterUnitWatch(self)
				end
				self:Show()
			elseif value then
				if not nounitwatch then
					RegisterUnitWatch(self)
				else
					self:Show()
				end
			else
				if not nounitwatch then
					UnregisterUnitWatch(self)
				end
				self:Hide()
			end

			self:CallMethod("UnitFrame_UpdateUnitFrame", value)
		elseif name == "nounitwatch" then
			local unit = self:GetAttribute("unit")

			if unit and unit ~= "player" then
				if value then
					UnregisterUnitWatch(self)
				else
					RegisterUnitWatch(self)
				end
			end
		end
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent)
		return CreateFrame("Button", name, parent, "SecureUnitButtonTemplate, SecureHandlerAttributeTemplate")
	end

    function UnitFrame(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Layout = DockLayoutPanel
		self.AutoLayout = true

		self:SetAttribute("*type1", "target")
		self:SetAttribute("shift-type1", "focus")	-- default
		self:SetAttribute("*type2", "togglemenu")

		self:RegisterForClicks("AnyUp")

		self.OnEnter = self.OnEnter + OnEnter
		self.OnLeave = self.OnLeave + OnLeave
		self.OnShow = self.OnShow + OnShow

		-- Prepare for secure handler
		self:SetAttribute("_onattributechanged", _onattributechanged)
		IGAS:GetUI(self).UnitFrame_UpdateUnitFrame = UpdateUnitFrame
    end

	------------------------------------------------------
	-- __index
	------------------------------------------------------
	local sindex = Super.__index
	local getwidget = IFContainer.GetWidget
    function __index(self, key) return sindex(self, key) or getwidget(self, key) end
endclass "UnitFrame"
