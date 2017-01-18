-- Author      : Kurapica
-- Create Date : 2012/07/14
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFReadyCheck", version) then
	return
end

_All = "all"
_IFReadyCheckUnitList = _IFReadyCheckUnitList or UnitList(_Name)

function _IFReadyCheckUnitList:OnUnitListChanged()
	self:RegisterEvent("READY_CHECK")
	self:RegisterEvent("READY_CHECK_CONFIRM")
	self:RegisterEvent("READY_CHECK_FINISHED")

	self.OnUnitListChanged = nil
end

function _IFReadyCheckUnitList:ParseEvent(event)
	self:EachK(_All, RefreshCheck, event)
end

function RefreshCheck(self, event)
	local unit = self.Unit
	if not unit or not UnitExists(unit) or not UnitIsPlayer(unit) then
		self.ReadyCheckStatus = nil
		self.Visible = false
		return
	end

	if event == "READY_CHECK" or event == "READY_CHECK_CONFIRM" then
		local status = GetReadyCheckStatus(unit)

		if status == "ready" then
			return self:Confirm(true)
		elseif status == "notready" then
			return self:Confirm(false)
		else
			return self:Start()
		end
	else
		return Object.ThreadCall(self, "Finish")
	end
end

__Doc__[[IFReadyCheck is used to handle the unit ready check state's updating]]
interface "IFReadyCheck"
	extend "IFUnitElement"

	FINISH_TIME = 10
	FADE_TIME = 1.5

	READY_CHECK_WAITING_TEXTURE = _G.READY_CHECK_WAITING_TEXTURE
	READY_CHECK_READY_TEXTURE = _G.READY_CHECK_READY_TEXTURE
	READY_CHECK_NOT_READY_TEXTURE = _G.READY_CHECK_NOT_READY_TEXTURE
	READY_CHECK_AFK_TEXTURE = _G.READY_CHECK_AFK_TEXTURE

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Start the ready check, overridable]]
	__Optional__() function Start(self)
		if self:IsClass(Texture) then
			self.TexturePath = READY_CHECK_WAITING_TEXTURE
			self.Alpha = 1
			self.Visible = true
			self.ReadyCheckStatus = "waiting"
		end
	end

	__Doc__[[
		<desc>Confirm the ready check, overridable</desc>
		<param name="ready">boolean</param>
	]]
	__Optional__() function Confirm(self, ready)
		if self:IsClass(Texture) then
			if ready then
				self.TexturePath = READY_CHECK_READY_TEXTURE
				self.ReadyCheckStatus = "ready"
			else
				self.TexturePath = READY_CHECK_NOT_READY_TEXTURE
				self.ReadyCheckStatus = "notready"
			end
			self.Alpha = 1
			self.Visible = true
		end
	end

	__Doc__[[Finish the ready check, overridable]]
	__Optional__() function Finish(self)
		if self:IsClass(Texture) then
			if self.ReadyCheckStatus == "waiting" then
				self.TexturePath = READY_CHECK_AFK_TEXTURE
				self.ReadyCheckStatus = "afk"
			end

			-- Wait to Fade
			Threading.Sleep(FINISH_TIME)

			-- Fading
			local alpha = self.Alpha
			local perSec = alpha / FADE_TIME / 10

			if alpha > 1 then alpha = 1 end

			while alpha > 0 do
				self.Alpha = alpha

				Threading.Sleep(0.1)

				alpha = alpha - perSec
			end

			self.Alpha = 0
			self.Visible = false
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFReadyCheckUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFReadyCheck(self)
		_IFReadyCheckUnitList[self] = _All
		self.Visible = false
	end
endinterface "IFReadyCheck"
