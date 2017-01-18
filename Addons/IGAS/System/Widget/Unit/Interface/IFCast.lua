-- Author      : Kurapica
-- Create Date : 2012/07/29
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFCast", version) then
	return
end

_IFCastUnitList = _IFCastUnitList or UnitList(_Name)

function _IFCastUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED")
	self:RegisterEvent("UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE")
	self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
	self:RegisterEvent("UNIT_SPELLCAST_DELAYED")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")

	self.OnUnitListChanged = nil
end

_IFCast_EVENT_HANDLER = {
	UNIT_SPELLCAST_START = "Start",
	UNIT_SPELLCAST_FAILED = "Fail",
	UNIT_SPELLCAST_STOP = "Stop",
	UNIT_SPELLCAST_INTERRUPTED = "Interrupt",
	UNIT_SPELLCAST_INTERRUPTIBLE = "Interruptible",
	UNIT_SPELLCAST_NOT_INTERRUPTIBLE = "UnInterruptible",
	UNIT_SPELLCAST_DELAYED = "Delay",
	UNIT_SPELLCAST_CHANNEL_START = "ChannelStart",
	UNIT_SPELLCAST_CHANNEL_UPDATE = "ChannelUpdate",
	UNIT_SPELLCAST_CHANNEL_STOP = "ChannelStop",
}

function _IFCastUnitList:ParseEvent(event, unit, ...)
	self:EachK(unit, _IFCast_EVENT_HANDLER[event], ...)
end

function OnForceRefresh(self)
	if self.Unit then
		if UnitCastingInfo(self.Unit) then
			local name, subText, _, _, _, _, _, castID, notInterruptible = UnitCastingInfo(self.Unit)
			self:Start(name, subText, castID)
		elseif UnitChannelInfo(self.Unit) then
			self:ChannelStart()
		else
			self:Stop()
		end
	else
		self:Stop()
	end
end

__Doc__[[IFCast is used to handle the unit's spell casting]]
interface "IFCast"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Be called when unit begins casting a spell</desc>
		<param name="spell">string, the name of the spell that's being casted</param>
		<param name="rank">string, the rank of the spell that's being casted</param>
		<param name="lineID">number, spell lineID counter</param>
		<param name="spellID">number, the id of the spell that's being casted</param>
	]]
	__Optional__() function Start(self, spell, rank, lineID, spellID)
		Log(1, "[%s][Start][%s][%s][%d][%d]", tostring(self:GetClass()), spell, rank, lineID, spellID)
	end

	__Doc__[[
		<desc>Be called when unit's spell casting failed</desc>
		<param name="spell">string, the name of the spell that's being casted</param>
		<param name="rank">string, the rank of the spell that's being casted</param>
		<param name="lineID">number, spell lineID counter</param>
		<param name="spellID">number, the id of the spell that's being casted</param>
	]]
	__Optional__() function Fail(self, spell, rank, lineID, spellID)
		Log(1, "[%s][Fail][%s][%s][%d][%d]", tostring(self:GetClass()), spell, rank, lineID, spellID)
	end

	__Doc__[[
		<desc>Be called when the unit stop or cancel the spell casting</desc>
		<param name="spell">string, the name of the spell that's being casted</param>
		<param name="rank">string, the rank of the spell that's being casted</param>
		<param name="lineID">number, spell lineID counter</param>
		<param name="spellID">number, the id of the spell that's being casted</param>
	]]
	__Optional__() function Stop(self, spell, rank, lineID, spellID)
		Log(1, "[%s][Stop][%s][%s][%d][%d]", tostring(self:GetClass()), spell, rank, lineID, spellID)
	end

	__Doc__[[
		<desc>Be called when the unit's spell casting is interrupted</desc>
		<param name="spell">string, the name of the spell that's being casted</param>
		<param name="rank">string, the rank of the spell that's being casted</param>
		<param name="lineID">number, spell lineID counter</param>
		<param name="spellID">number, the id of the spell that's being casted</param>
	]]
	__Optional__() function Interrupt(self, spell, rank, lineID, spellID)
		Log(1, "[%s][Interrupt][%s][%s][%d][%d]", tostring(self:GetClass()), spell, rank, lineID, spellID)
	end

	__Doc__[[Be called when the unit's spell casting becomes interruptible]]
	__Optional__() function Interruptible(self)
		Log(1, "[%s][Interruptible]", tostring(self:GetClass()))
	end

	__Doc__[[Be called when the unit's spell casting become uninterruptible]]
	__Optional__() function UnInterruptible(self)
		Log(1, "[%s][UnInterruptible]", tostring(self:GetClass()))
	end

	__Doc__[[
		<desc>Be called when the unit's spell casting is delayed</desc>
		<param name="spell">string, the name of the spell that's being casted</param>
		<param name="rank">string, the rank of the spell that's being casted</param>
		<param name="lineID">number, spell lineID counter</param>
		<param name="spellID">number, the id of the spell that's being casted</param>
	]]
	__Optional__() function Delay(self, spell, rank, lineID, spellID)
		Log(1, "[%s][Delay][%s][%s][%d][%d]", tostring(self:GetClass()), spell, rank, lineID, spellID)
	end

	__Doc__[[
		<desc>Be called when the unit start channeling a spell</desc>
		<param name="spell">string, the name of the spell that's being casted</param>
		<param name="rank">string, the rank of the spell that's being casted</param>
		<param name="lineID">number, spell lineID counter</param>
		<param name="spellID">number, the id of the spell that's being casted</param>
	]]
	__Optional__() function ChannelStart(self, spell, rank, lineID, spellID)
		Log(1, "[%s][ChannelStart][%s][%s][%d][%d]", tostring(self:GetClass()), spell, rank, lineID, spellID)
	end

	__Doc__[[
		<desc>Be called when the unit's channeling spell is interrupted or delayed</desc>
		<param name="spell">string, the name of the spell that's being casted</param>
		<param name="rank">string, the rank of the spell that's being casted</param>
		<param name="lineID">number, spell lineID counter</param>
		<param name="spellID">number, the id of the spell that's being casted</param>
	]]
	__Optional__() function ChannelUpdate(self, spell, rank, lineID, spellID)
		Log(1, "[%s][ChannelUpdate][%s][%s][%d][%d]", tostring(self:GetClass()), spell, rank, lineID, spellID)
	end

	__Doc__[[
		<desc>Be called when the unit stop or cancel the channeling spell</desc>
		<param name="spell">string, the name of the spell that's being casted</param>
		<param name="rank">string, the rank of the spell that's being casted</param>
		<param name="lineID">number, spell lineID counter</param>
		<param name="spellID">number, the id of the spell that's being casted</param>
	]]
	__Optional__() function ChannelStop(self, spell, rank, lineID, spellID)
		Log(1, "[%s][ChannelStop][%s][%s][%d][%d]", tostring(self:GetClass()), spell, rank, lineID, spellID)
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFCastUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFCastUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFCast(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
		self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
	end
endinterface "IFCast"
