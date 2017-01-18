-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.PowerBar", version) then
	return
end

__Doc__[[The power bar]]
class "PowerBar"
	inherit "StatusBar"
	extend "IFPower"

	local function OnValueChanged(self, value)
		self.Owner:SetValue(value)
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetUnitPower(self, power, max)
		if max then self:SetMinMaxValues(0, max) end
		if power then
			if self.Smoothing then
				if not self._SmoothValueObj then
					self._SmoothValueObj = SmoothValue()
					self._SmoothValueObj.SmoothDelay = self.SmoothDelay
					self._SmoothValueObj.Owner = self
					self._SmoothValueObj.OnValueChanged = OnValueChanged

					self:SetValue(power)
				end

				self._SmoothValueObj.RealValue = power
			else
				self:SetValue(power)
			end
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether smoothing the value changes]]
	property "Smoothing" { Type = Boolean }

	__Doc__[[The delay time for smoothing value changes]]
	property "SmoothDelay" { Type = PositiveNumber, Default = 1 }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function PowerBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
		self.FrameStrata = "LOW"
		self.MouseEnabled = false
	end
endclass "PowerBar"

__Doc__[[The frequent power bar]]
class "PowerBarFrequent"
	inherit "StatusBar"
	extend "IFPowerFrequent"

	local function OnValueChanged(self, value)
		self.Owner:SetValue(value)
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetUnitPower(self, power, max)
		if max then self:SetMinMaxValues(0, max) end
		if power then
			if self.Smoothing then
				if not self._SmoothValueObj then
					self._SmoothValueObj = SmoothValue()
					self._SmoothValueObj.SmoothDelay = self.SmoothDelay
					self._SmoothValueObj.Owner = self
					self._SmoothValueObj.OnValueChanged = OnValueChanged

					self:SetValue(power)
				end

				self._SmoothValueObj.RealValue = power
			else
				self:SetValue(power)
			end
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether smoothing the value changes]]
	property "Smoothing" { Type = Boolean }

	__Doc__[[The delay time for smoothing value changes]]
	property "SmoothDelay" { Type = PositiveNumber, Default = 1 }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function PowerBarFrequent(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
		self.FrameStrata = "LOW"
		self.MouseEnabled = false
	end
endclass "PowerBarFrequent"
