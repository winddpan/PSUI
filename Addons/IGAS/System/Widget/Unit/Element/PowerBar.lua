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
				self.SmoothValue:SetValue(power, max)
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
	property "SmoothDelay" {
		Type = PositiveNumber,
		Set  = function(self, delay) self.SmoothValue.SmoothDelay = delay end,
		Get  = function(self) return self.SmoothValue.SmoothDelay end,
	}

	property "SmoothValue" {
		Set = false,
		Default = function(self)
			local obj = SmoothValue()
			obj.Owner = self
			obj.OnValueChanged = OnValueChanged
			return obj
		end,
	}

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
				self.SmoothValue:SetValue(power, max)
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
	property "SmoothDelay" {
		Type = PositiveNumber,
		Set  = function(self, delay) self.SmoothValue.SmoothDelay = delay end,
		Get  = function(self) return self.SmoothValue.SmoothDelay end,
	}

	property "SmoothValue" {
		Set = false,
		Default = function(self)
			local obj = SmoothValue()
			obj.Owner = self
			obj.OnValueChanged = OnValueChanged
			return obj
		end,
	}

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
