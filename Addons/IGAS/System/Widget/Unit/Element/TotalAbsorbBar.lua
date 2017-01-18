-- Author      : Kurapica
-- Create Date : 2013/09/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.TotalAbsorbBar", version) then
	return
end

__Doc__[[The prediction heal of the player]]
class "TotalAbsorbBar"
	inherit "StatusBar"
	extend "IFAbsorb"

	_TotalAbsorbBarMap = _TotalAbsorbBarMap or setmetatable({}, {__mode = "kv"})

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function SetUnitOverAbsorb(self, isOver)
		self.OverGlow.Visible = isOver
	end

	------------------------------------------------------
	-- Script Handler
	------------------------------------------------------
	local function OnSizeChanged(self)
		if _TotalAbsorbBarMap[self] then
			_TotalAbsorbBarMap[self].Size = self.Size
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The target health bar the prediction bar should attach to]]
	property "HealthBar" {
		Field = "__HealthBar",
		Set = function(self, value)
			if type(value) == "string" then
				value = self.Parent:GetChild(value)

				if not value then return end
			end

			if self.__HealthBar ~= value then
				if self.__HealthBar then
					self.__HealthBar.OnSizeChanged = self.__HealthBar.OnSizeChanged - OnSizeChanged
					_TotalAbsorbBarMap[self.__HealthBar] = nil
				end

				self.__HealthBar = value
				_TotalAbsorbBarMap[value] = self

				self:ClearAllPoints()
				self:SetPoint("TOPLEFT", value.StatusBarTexture, "TOPRIGHT")
				self.FrameLevel = value.FrameLevel + 2
				self.Size = value.Size

				self.OverGlow:ClearAllPoints()
				self.OverGlow:SetPoint("TOPLEFT", value, "TOPRIGHT", -7, 0)
				self.OverGlow:SetPoint("BOTTOMLEFT", value, "BOTTOMRIGHT", -7, 0)

				value.OnSizeChanged = value.OnSizeChanged + OnSizeChanged
			end
		end,
		--Type = StatusBarString,
	}

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function TotalAbsorbBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.MouseEnabled = false

    	local overGlow = Texture("OverGlow", self)

    	overGlow.BlendMode = "ADD"
    	overGlow.TexturePath = [[Interface\RaidFrame\Shield-Overshield]]
    	overGlow.Width = 16
    	overGlow.Visible = false
    end
endclass "TotalAbsorbBar"
