-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFResting", version) then
	return
end

_IFRestingUnitList = _IFRestingUnitList or UnitList(_Name)

function _IFRestingUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_UPDATE_RESTING")

	self.OnUnitListChanged = nil
end

function _IFRestingUnitList:ParseEvent(event)
	self:EachK("player", OnForceRefresh)
end

function OnForceRefresh(self)
	self:SetRestState(self.Unit == "player" and IsResting())
end

__Doc__[[
	<desc>IFResting is used to handle the unit resting state's updating</desc>
	<optional name="Visible" type="property" valuetype="boolean"></optional>
]]
interface "IFResting"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Unit == "player" then
			_IFRestingUnitList[self] = self.Unit
		else
			_IFRestingUnitList[self] = nil
			self:SetRestState(false)
		end
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Set the rest state to the element, overridable]]
	__Optional__() function SetRestState(self, underRest)
		self.Visible = underRest
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFRestingUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFResting(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFResting"
