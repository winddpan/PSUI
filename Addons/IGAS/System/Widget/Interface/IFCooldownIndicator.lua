-- Author      : Kurapica
-- Create Date : 2012/07/24
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.IFCooldownIndicator", version) then
	return
end

__Doc__[[IFCooldownLabel is used to provide a CooldownIndicator to display the cooldown]]
__AutoProperty__()
interface "IFCooldownIndicator"
	extend "IFCooldown"

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Custom the cooldown indicator</desc>
		<param name="indicator">System.Widget.Cooldown</param>
	]]
	function SetUpCooldownIndicator(self, indicator)
		indicator:SetHideCountdownNumbers(true)
		indicator:SetAllPoints(self)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnCooldownUpdate(self, start, duration)
		if start and start > 0 and duration and duration > 0 then
			self:GetChild("CooldownIndicator"):SetCooldown(start, duration)
			self:GetChild("CooldownIndicator").Visible = true
		else
			self:GetChild("CooldownIndicator").Visible = false
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFCooldownIndicator(self)
		if not Reflector.ObjectIsClass(self, Frame) then return end

		local cd = self:GetChild("CooldownIndicator")

		if cd and cd:IsClass(Cooldown) then
			-- pass
		else
			if cd then cd:Dispose() end
			self:SetUpCooldownIndicator(Cooldown("CooldownIndicator", self))
		end

		self.OnCooldownUpdate = self.OnCooldownUpdate + OnCooldownUpdate
	end
endinterface "IFCooldownIndicator"
