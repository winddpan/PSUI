-- Author      : Kurapica
-- Create Date : 2012/07/18
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.RuneBar", version) then
	return
end

__Doc__[[The rune bar for the deathknight]]
class "RuneBar"
	inherit "LayoutPanel"
	extend "IFRune"

	GameTooltip = _G.GameTooltip
	RUNES_TOOLTIP = _G.RUNES_TOOLTIP

	MAX_RUNES = 6

	RUNETYPE_COMMON = 0
	RUNETYPE_BLOOD = 1
	RUNETYPE_UNHOLY = 2
	RUNETYPE_FROST = 3
	RUNETYPE_DEATH = 4

	IconTextures = {
		[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood",
		[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy",
		[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost",
		[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death",
	}

	RuneTextures = {
		[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Blood-Off.tga",
		[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Death-Off.tga",
		[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost-Off.tga",
		[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Chromatic-Off.tga",
	}

	RuneEnergizeTextures = {
		[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\Deathknight-Energize-Blood",
		[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\Deathknight-Energize-Unholy",
		[RUNETYPE_FROST] = "Interface\\PlayerFrame\\Deathknight-Energize-Frost",
		[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\Deathknight-Energize-White",
	}

	RuneColors = {
		[RUNETYPE_COMMON] = ColorType(1, 1, 1),
		[RUNETYPE_BLOOD] = ColorType(1, 0, 0),
		[RUNETYPE_UNHOLY] = ColorType(0, 0.5, 0),
		[RUNETYPE_FROST] = ColorType(0, 1, 1),
		[RUNETYPE_DEATH] = ColorType(0.8, 0.1, 1),
	}

	RuneMapping = {
		[1] = "BLOOD",
		[2] = "UNHOLY",
		[3] = "FROST",
		[4] = "DEATH",
	}

	RuneBtnMapping = {
		[1] = 1,
		[2] = 2,
		[3] = 5,
		[4] = 6,
		[5] = 3,
		[6] = 4,
	}

	class "RuneButton"
		inherit "Button"
		extend "IFCooldownIndicator"

		ALPHA_PER = 0.2

		------------------------------------------------------
		-- Event
		------------------------------------------------------

		------------------------------------------------------
		-- Method
		------------------------------------------------------
		------------------------------------
		--- Custom the indicator
		-- -- @class function
		-- <param name="indicator">the cooldown object</param>
		------------------------------------
		function SetUpCooldownIndicator(self, indicator)
			indicator.FrameStrata = "LOW"
			indicator:SetPoint("TOPLEFT", 2, -2)
			indicator:SetPoint("BOTTOMRIGHT", -1, 1)
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Handler__( function (self, value)
			self.Glow.RuneColorGlow.TexturePath = RuneEnergizeTextures[value]

			if value then
				self.Rune.TexturePath = IconTextures[value]

				self.Rune.Visible = true

				self.Tooltip = _G["COMBAT_TEXT_RUNE_"..RUNE_MAPPING[value]]

				self.Shine.Texture.VertexColor = RuneColors[value]
				self.Shine.Texture.Energize.Playing = true
			else
				self.Rune.Visible = false
				self.Tooltip = nil
			end
		end )
		property "RuneType" { Type = NumberNil }

		__Handler__( function (self, value)
			if value then
				self.Shine.Texture.VertexColor = RuneColors[0]
				self.Shine.Texture.Energize.Playing = true
			else
				self.Glow.RuneWhiteGlow.Energize:Stop()
				self.Glow.RuneColorGlow.Energize:Stop()
			end
		end )
		property "Ready" { Type = Boolean }

		__Handler__( function (self, value)
			if value then
				self.Glow.RuneWhiteGlow.Energize:Play()
				self.Glow.RuneColorGlow.Energize:Play()
			else
				self.Glow.RuneWhiteGlow.Energize:Stop()
				self.Glow.RuneColorGlow.Energize:Stop()
			end
		end )
		property "Energize" { Type = Boolean }

		------------------------------------------------------
		-- Event Handler
		------------------------------------------------------
		local function OnEnter(self)
			if self.Tooltip then
				GameTooltip_SetDefaultAnchor(GameTooltip, IGAS:GetUI(self))
				GameTooltip:SetText(self.Tooltip, 1, 1, 1)
				GameTooltip:AddLine(RUNES_TOOLTIP, nil, nil, nil, true)
				GameTooltip:Show()
			end
		end

		local function OnLeave(self)
			GameTooltip:Hide()
		end

		local function Shine_OnFinished(self)
			self.Parent.Alpha = 0
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
		function RuneButton(self, name, parent, ...)
			Super(self, name, parent, ...)

			self.Height = 18
			self.Width = 18

			-- Border
			local border = Frame("Border", self)
			border.FrameStrata = "LOW"
			border:SetPoint("TOPLEFT", -3, 3)
			border:SetPoint("BOTTOMRIGHT", 3, -3)

			local borderTexture = Texture("Texture", border, "OVERLAY")
			borderTexture.TexturePath = [[Interface\PlayerFrame\UI-PlayerFrame-Deathknight-Ring]]
			borderTexture.VertexColor = ColorType(0.6, 0.6, 0.6, 1)
			borderTexture:SetAllPoints(border)

			border.FrameLevel = border.FrameLevel + 1

			-- Shine
			local shine = Frame("Shine", self)
			shine.FrameStrata = "MEDIUM"
			shine:SetAllPoints(self)

			local shineTexture = Texture("Texture", shine, "OVERLAY")
			shineTexture.TexturePath = [[Interface\ComboFrame\ComboPoint]]
			shineTexture.BlendMode = "ADD"
			shineTexture.Alpha = 0
			shineTexture:SetPoint("TOPLEFT", -21, 9)
			shineTexture:SetPoint("BOTTOMRIGHT", 21, -9)
			shineTexture:SetTexCoord(0.5625, 1, 0, 1)

			-- Glow
			local glow = Frame("Glow", self)
			glow.FrameStrata = "HIGH"
			glow:SetAllPoints(self)

			local glowWhite = Texture("RuneWhiteGlow", glow, "OVERLAY", nil, -1)
			glowWhite.TexturePath = [[Interface\PlayerFrame\Deathknight-Energize-White]]
			glowWhite.Alpha = 0
			glowWhite:SetPoint("TOPLEFT", 5, -5)
			glowWhite:SetPoint("BOTTOMRIGHT", -5, 5)

			local glowColor = Texture("RuneColorGlow", glow, "OVERLAY")
			glowColor.TexturePath = [[Interface\PlayerFrame\Deathknight-Energize-Blood]]
			glowColor.Alpha = 0
			glowColor:SetPoint("TOPLEFT", -7, 7)
			glowColor:SetPoint("BOTTOMRIGHT", 7, -7)

			-- RuneTexture
			local rune = Texture("Rune", self, "ARTWORK")
			rune.TexturePath = [[Interface\PlayerFrame\UI-PlayerFrame-Deathknight-Blood]]
			rune:SetPoint("TOPLEFT", -3, 3)
			rune:SetPoint("BOTTOMRIGHT", 3, -3)

			-- Animation for RuneWhiteGlow
			local energize = AnimationGroup("Energize", glowWhite)

			local scale = Scale("Scale", energize)
			scale.Order = 1
			scale.Duration = 0.15
			scale.EndDelay = 1
			scale.Scale = Dimension(4, 4)

			local alpha = Alpha("Alpha1", energize)
			alpha.Order = 1
			alpha.Duration = 0.2
			alpha.EndDelay = 1
			alpha.Change = 1

			alpha = Alpha("Alpha2", energize)
			alpha.Order = 2
			alpha.Duration = 0.1
			alpha.Smoothing = "IN_OUT"
			alpha.Change = -1

			-- Animation for RuneColorGlow
			energize = AnimationGroup("Energize", glowColor)

			alpha = Alpha("Alpha1", energize)
			alpha.Order = 1
			alpha.Duration = 0.1
			alpha.StartDelay = 0.3
			alpha.EndDelay = 4
			alpha.Smoothing = "IN_OUT"
			alpha.Change = 1

			alpha = Alpha("Alpha2", energize)
			alpha.Order = 2
			alpha.Duration = 0.1
			alpha.Smoothing = "IN_OUT"
			alpha.Change = -1

			energize = AnimationGroup("Energize", shineTexture)

			energize.OnFinished = Shine_OnFinished

			alpha = Alpha("Alpha1", energize)
			alpha.Duration = 0.5
			alpha.Order = 1
			alpha.Change = 1

			alpha = Alpha("Alpha2", energize)
			alpha.Duration = 0.5
			alpha.Order = 2
			alpha.Change = -1

			self.OnEnter = self.OnEnter + OnEnter
			self.OnLeave = self.OnLeave + OnLeave
		end
	endclass "RuneButton"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function RuneBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		local pct = floor(100 / MAX_RUNES)
		local margin = (100 - pct * MAX_RUNES + 3) / 2

		self.FrameStrata = "LOW"
		self.Toplevel = true
		self.Width = 130
		self.Height = 18

		local btnRune, pos

		for i = 1, MAX_RUNES do
			btnRune = RuneButton("Individual"..i, self)
			btnRune.ID = i

			self:AddWidget(btnRune)

			pos = RuneBtnMapping[i]

			self:SetWidgetLeftWidth(btnRune, margin + (pos-1)*pct, "pct", pct-3, "pct")

			self[i] = btnRune
		end
	end
endclass "RuneBar"
