-- Author      : Kurapica
-- Create Date : 2012/07/22
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.MonkPowerBar", version) then
	return
end

__Doc__[[The monk power bar]]
class "MonkPowerBar"
	inherit "Frame"
	extend "IFClassPower"

	GameTooltip = _G.GameTooltip
	CHI_POWER = _G.CHI_POWER
	CHI_TOOLTIP = _G.CHI_TOOLTIP

	__Doc__[[The chi element]]
	class "LightEnergy"
		inherit "Frame"


		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[Whether the element is activated]]
		__Handler__( function (self, value)
			if value then
				self.Glow.Deactivate.Playing = false
				self.Glow.Active.Playing = true
			else
				self.Glow.Active.Playing = false
				self.Glow.Deactivate.Playing = true
			end
		end )
		property "Activated" { Type = Boolean }

		------------------------------------------------------
		-- Event Handler
		------------------------------------------------------
		local function Active_OnFinished(self)
			self.Parent.Alpha = 1
		end

		local function Deactivate_OnFinished(self)
			self.Parent.Alpha = 0
		end

		local function OnEnter(self)
			GameTooltip_SetDefaultAnchor(GameTooltip, IGAS:GetUI(self))
			GameTooltip:SetText(CHI_POWER, 1, 1, 1)
			GameTooltip:AddLine(CHI_TOOLTIP, nil, nil, nil, true)
			GameTooltip:Show()
		end

		local function OnLeave(self)
			GameTooltip:Hide()
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	    function LightEnergy(self, name, parent, ...)
			Super(self, name, parent, ...)

			self:SetSize(18, 17)

			-- BACKGROUND
			local bg = Texture("Bg", self, "BACKGROUND")
			bg.TexturePath = [[Interface\PlayerFrame\MonkUI]]
			bg:SetTexCoord(0.09375000, 0.17578125, 0.71093750, 0.87500000)
			bg:SetSize(21, 21)
			bg:SetPoint("CENTER")

			-- ARTWORK
			local glow = Texture("Glow", self, "ARTWORK")
			glow.Alpha = 0
			glow.TexturePath = [[Interface\PlayerFrame\MonkUI]]
			glow:SetTexCoord(0.00390625, 0.08593750, 0.71093750, 0.87500000)
			glow:SetSize(21, 21)
			glow:SetPoint("CENTER")

			-- Animation
			local active = AnimationGroup("Active", glow)
			local alpha = Alpha("Alpha", active)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = 1

			active.OnFinished = Active_OnFinished

			local deactivate = AnimationGroup("Deactivate", glow)
			alpha = Alpha("Alpha", deactivate)
			alpha.Duration = 0.3
			alpha.Order = 1
			alpha.Change = -1

			deactivate.OnFinished = Deactivate_OnFinished

			self.OnEnter = self.OnEnter + OnEnter
			self.OnLeave = self.OnLeave + OnLeave
	    end
	endclass "LightEnergy"

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	-- MinMaxValue
	property "MinMaxValue" {
		Get = function(self)
			return MinMax(self.__Min, self.__Max)
		end,
		Set = function(self, value)
			if self.__Max ~= value.max then
				self.LightEnergy1:SetPoint("LEFT", (self.Width - self.LightEnergy1.Width * value.max - 5 * (value.max-1)) / 2, 1)

				if value.max == 4 then
					self.LightEnergy5.Visible = false
				else
					self.LightEnergy5.Visible = true
				end
			end
			self.__Min, self.__Max = value.min, value.max
		end,
		Type = MinMax,
	}

	__Handler__( function (self, value)
		for  i = 1, self.__Max do
			self["LightEnergy"..i].Activated = i <= value
		end
	end )
	property "Value" { Type = Number }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function MonkPowerBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.__Min, self.__Max = 0, 0

		self.FrameStrata = "LOW"
		self.Toplevel = true
		self:SetSize(136, 60)
		self.MouseEnabled = true

		-- BACKGROUND
		local bgShadow = Texture("BgShadow", self, "BACKGROUND")
		bgShadow.TexturePath = [[Interface\PlayerFrame\MonkUI]]
		bgShadow:SetTexCoord(0.00390625, 0.53515625, 0.00781250, 0.34375000)
		bgShadow:SetAllPoints()

		-- BORDER
		local bg = Texture("Bg", self, "BORDER")
		bg.TexturePath = [[Interface\PlayerFrame\MonkUI]]
		bg:SetTexCoord(0.00390625, 0.53515625, 0.35937500, 0.69531250)
		bg:SetAllPoints()

		-- LightEnergy
		local prev

		for i = 1, 5 do
			local light = LightEnergy("LightEnergy"..i, self)

			if i == 1 then
				light:SetPoint("LEFT", (self.Width - light.Width * 4 - 5 * 3) / 2, 1)
			else
				light:SetPoint("LEFT", prev, "RIGHT", 5, 0)
			end

			prev = light
		end
	end
endclass "MonkPowerBar"
