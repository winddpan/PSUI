-- Author      : Kurapica
-- Create Date : 2012/07/22
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.PaladinPowerBar", version) then
	return
end

__Doc__[[The holy power bar for the paladin]]
class "PaladinPowerBar"
	inherit "Frame"
	extend "IFClassPower"

	GameTooltip = _G.GameTooltip
	HOLY_POWER = _G.HOLY_POWER
	HOLY_POWER_TOOLTIP = _G.HOLY_POWER_TOOLTIP
	SPELL_POWER_HOLY_POWER = _G.SPELL_POWER_HOLY_POWER

	HOLY_POWER_FULL = _G.HOLY_POWER_FULL

	local function ToggleRune(self, visible)
		if visible then
			self.Deactivate:Play()
		else
			self.Activate:Play()
		end
	end

	local function Delay(self)
		Threading.Sleep(0.5)
		self.__InDelay = false
		self.Value = UnitPower( "player", SPELL_POWER_HOLY_POWER )
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------

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
				if value.max > HOLY_POWER_FULL then
					self.BankBG.ShowAnim:Play()
				else
					self.BankBG.ShowAnim:Stop()
					self.BankBG.Alpha = 0
				end
			end
			self.__Min, self.__Max = value.min, value.max
		end,
		Type = MinMax,
	}
	-- Value
	property "Value" {
		Get = function(self)
			return self.__Value
		end,
		Set = function(self, value)
			if self.__InDelay then return end

			if self.__Value ~= value then
				if self.__Value > HOLY_POWER_FULL and value == self.__Value - HOLY_POWER_FULL then
					for i = 1, HOLY_POWER_FULL do
						ToggleRune(self["Rune"..i], true)
					end
					self.__Value = 0
					self.__InDelay = true
					return self:ThreadCall(Delay)
				end

				local rune, isShown, shouldShow
				for i = 1, self.__Max do
					rune = self["Rune"..i]
					isShown = rune.Alpha > 0 or rune.Activate:IsPlaying()
					shouldShow = i <= value

					if isShown ~= shouldShow then
						ToggleRune(rune, isShown)
					end
				end

				if value >= HOLY_POWER_FULL then
					self.GlowBG.StopPulse = false
					self.GlowBG.Pulse:Play()
				else
					self.GlowBG.StopPulse = true
				end

				self.__Value = value
			end
		end,
		Type = Number,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function ShowAnim_OnFinished(self)
		self.Parent.Alpha = 1
	end

	local function Glow_OnFinished(self)
		if not self.Parent.StopPulse then
			self:Play()
		end
	end

	local function Activate_OnFinished(self)
		self.Parent.Alpha = 1
	end

	local function Deactivate_OnFinished(self)
		self.Parent.Alpha = 0
	end

	local function OnEnter(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, IGAS:GetUI(self))
		GameTooltip:SetText(HOLY_POWER, 1, 1, 1)
		GameTooltip:AddLine(HOLY_POWER_TOOLTIP, nil, nil, nil, true)
		GameTooltip:Show()
	end

	local function OnLeave(self)
		GameTooltip:Hide()
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function PaladinPowerBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.__Value = 0
		self.__Min = 0
		self.__Max = 0

		self.FrameStrata = "LOW"
		self.Toplevel = true
		self:SetSize(136, 39)
		self.HitRectInsets = Inset(17, 17, 7, 4)
		self.MouseEnabled = true

		self.OnEnter = self.OnEnter + OnEnter
		self.OnLeave = self.OnLeave + OnLeave

		-------------------------------------
		-- BACKGROUND
		-------------------------------------
		local bankBG = Texture("BankBG", self, "BACKGROUND", nil, -7)
		bankBG:SetSize(69, 16)
		bankBG:SetPoint("TOP", 0, -29)
		bankBG.Alpha = 0
		bankBG.TexturePath = [[Interface\PlayerFrame\PaladinPowerTextures]]
		bankBG:SetTexCoord(0.00390625, 0.27343750, 0.64843750, 0.77343750)

		local bg = Texture("BG", self, "BACKGROUND", nil, -5)
		bg:SetAllPoints()
		bg.TexturePath = [[Interface\PlayerFrame\PaladinPowerTextures]]
		bg:SetTexCoord(0.00390625, 0.53515625, 0.00781250, 0.31250000)

		local showAnim = AnimationGroup("ShowAnim", self)
		showAnim.OnFinished = ShowAnim_OnFinished

		local alpha = Alpha("Alpha", showAnim)
		alpha.Duration = 0.5
		alpha.Order = 1
		alpha.Change = 1

		showAnim = AnimationGroup("ShowAnim", bankBG)
		showAnim.OnFinished = ShowAnim_OnFinished

		alpha = Alpha("Alpha", showAnim)
		alpha.Duration = 0.5
		alpha.Order = 1
		alpha.Change = 1

		-------------------------------------
		-- GlowBG
		-------------------------------------
		local glow = Frame("GlowBG", self)
		glow:SetAllPoints()
		glow.FrameLevel = self.FrameLevel
		glow.Alpha = 0

		local texture = Texture("Texture", glow, "BACKGROUND", nil, -1)
		texture:SetAllPoints()
		texture.TexturePath = [[Interface\PlayerFrame\PaladinPowerTextures]]
		texture:SetTexCoord(0.00390625, 0.53515625, 0.32812500, 0.63281250)

		local pulse = AnimationGroup("Pulse", glow)
		pulse.OnFinished = Glow_OnFinished

		alpha = Alpha("FadeIn", pulse)
		alpha.Duration = 0.5
		alpha.Order = 1
		alpha.Change = 1

		alpha = Alpha("FadeOut", pulse)
		alpha.Duration = 0.6
		alpha.StartDelay = 0.3
		alpha.Order = 2
		alpha.Change = -1

		-------------------------------------
		-- Rune1
		-------------------------------------
		local rune1 = Frame("Rune1", self)
		rune1:SetSize(36, 22)
		rune1:SetPoint("TOPLEFT", 21, -11)
		rune1.Alpha = 0

		texture = Texture("Texture", rune1, "OVERLAY")
		texture:SetAllPoints()
		texture.TexturePath = [[Interface\PlayerFrame\PaladinPowerTextures]]
		texture:SetTexCoord(0.00390625, 0.14453125, 0.78906250, 0.96093750)

		local activate = AnimationGroup("Activate", rune1)
		activate.OnFinished = Activate_OnFinished

		alpha = Alpha("Alpha", activate)
		alpha.Duration = 0.2
		alpha.Order = 1
		alpha.Change = 1

		local deactivate = AnimationGroup("Deactivate", rune1)
		deactivate.OnFinished = Deactivate_OnFinished

		alpha = Alpha("Alpha", deactivate)
		alpha.Duration = 0.3
		alpha.Order = 1
		alpha.Change = -1

		-------------------------------------
		-- Rune2
		-------------------------------------
		local rune2 = Frame("Rune2", self)
		rune2:SetPoint("LEFT", rune1, "RIGHT")
		rune2:SetSize(31, 17)
		rune2.Alpha = 0

		texture = Texture("Texture", rune2, "OVERLAY")
		texture:SetAllPoints()
		texture.TexturePath = [[Interface\PlayerFrame\PaladinPowerTextures]]
		texture:SetTexCoord(0.15234375, 0.27343750, 0.78906250, 0.92187500)

		activate = AnimationGroup("Activate", rune2)
		activate.OnFinished = Activate_OnFinished

		alpha = Alpha("Alpha", activate)
		alpha.Duration = 0.2
		alpha.Order = 1
		alpha.Change = 1

		deactivate = AnimationGroup("Deactivate", rune2)
		deactivate.OnFinished = Deactivate_OnFinished

		alpha = Alpha("Alpha", deactivate)
		alpha.Duration = 0.3
		alpha.Order = 1
		alpha.Change = -1

		-------------------------------------
		-- Rune3
		-------------------------------------
		local rune3 = Frame("Rune3", self)
		rune3:SetPoint("LEFT", rune2, "RIGHT", 2, -1)
		rune3:SetSize(27, 21)
		rune3.Alpha = 0

		texture = Texture("Texture", rune3, "OVERLAY")
		texture:SetAllPoints()
		texture.TexturePath = [[Interface\PlayerFrame\PaladinPowerTextures]]
		texture:SetTexCoord(0.28125000, 0.38671875, 0.64843750, 0.81250000)

		activate = AnimationGroup("Activate", rune3)
		activate.OnFinished = Activate_OnFinished

		alpha = Alpha("Alpha", activate)
		alpha.Duration = 0.2
		alpha.Order = 1
		alpha.Change = 1

		deactivate = AnimationGroup("Deactivate", rune3)
		deactivate.OnFinished = Deactivate_OnFinished

		alpha = Alpha("Alpha", deactivate)
		alpha.Duration = 0.3
		alpha.Order = 1
		alpha.Change = -1

		-------------------------------------
		-- Rune4
		-------------------------------------
		local rune4 = Frame("Rune4", self)
		rune4:SetPoint("TOPLEFT", 43, -28)
		rune4:SetSize(27, 12)
		rune4.Alpha = 0

		texture = Texture("Texture", rune4, "BACKGROUND", nil, -6)
		texture:SetAllPoints()
		texture.TexturePath = [[Interface\PlayerFrame\PaladinPowerTextures]]
		texture:SetTexCoord(0.28125000, 0.38671875, 0.82812500, 0.92187500)

		activate = AnimationGroup("Activate", rune4)
		activate.OnFinished = Activate_OnFinished

		alpha = Alpha("Alpha", activate)
		alpha.Duration = 0.2
		alpha.Order = 1
		alpha.Change = 1

		deactivate = AnimationGroup("Deactivate", rune4)
		deactivate.OnFinished = Deactivate_OnFinished

		alpha = Alpha("Alpha", deactivate)
		alpha.Duration = 0.3
		alpha.Order = 1
		alpha.Change = -1

		-------------------------------------
		-- Rune5
		-------------------------------------
		local rune5 = Frame("Rune5", self)
		rune5:SetPoint("TOPLEFT", 67, -28)
		rune5:SetSize(26, 12)
		rune5.Alpha = 0

		texture = Texture("Texture", rune5, "BACKGROUND", nil, -6)
		texture:SetAllPoints()
		texture.TexturePath = [[Interface\PlayerFrame\PaladinPowerTextures]]
		texture:SetTexCoord(0.39453125, 0.49609375, 0.64843750, 0.74218750)

		activate = AnimationGroup("Activate", rune5)
		activate.OnFinished = Activate_OnFinished

		alpha = Alpha("Alpha", activate)
		alpha.Duration = 0.2
		alpha.Order = 1
		alpha.Change = 1

		deactivate = AnimationGroup("Deactivate", rune5)
		deactivate.OnFinished = Deactivate_OnFinished

		alpha = Alpha("Alpha", deactivate)
		alpha.Duration = 0.3
		alpha.Order = 1
		alpha.Change = -1
	end
endclass "PaladinPowerBar"
