-- Author      : Kurapica
-- Create Date : 2012/07/22
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.PriestPowerBar", version) then
	return
end

__Doc__[[The priest power bar for shadow orbs]]
class "PriestPowerBar"
	inherit "Frame"
	extend "IFClassPower"

	GameTooltip = _G.GameTooltip
	PRIEST_BAR_NUM_ORBS = _G.PRIEST_BAR_NUM_ORBS

	__Doc__[[The shadow orb element]]
	class "ShadowOrb"
		inherit "Frame"

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[Whether the element is activated]]
		__Handler__( function (self, value)
			if value then
				self.Bg.AnimOut.Playing = false
				self.Highlight.AnimOut.Playing = false
				self.Orb.AnimOut.Playing = false
				self.Glow.AnimOut.Playing = false

				self.Bg.AnimIn.Playing = true
				self.Highlight.AnimIn.Playing = true
				self.Orb.AnimIn.Playing = true
				self.Glow.AnimIn.Playing = true
			else
				self.Bg.AnimIn.Playing = false
				self.Highlight.AnimIn.Playing = false
				self.Orb.AnimIn.Playing = false
				self.Glow.AnimIn.Playing = false

				self.Bg.AnimOut.Playing = true
				self.Highlight.AnimOut.Playing = true
				self.Orb.AnimOut.Playing = true
				self.Glow.AnimOut.Playing = true
			end
		end )
		property "Activated" { Type = Boolean }

		------------------------------------------------------
		-- Event Handler
		------------------------------------------------------
		local function AnimIn_OnPlay(self)
			self.Parent.Parent.Orb.Alpha = 0.5
			self.Parent.Parent.Orb.Visible = true
			self.Parent.Parent.Highlight.Alpha = 0.5
		end

		local function AnimIn_OnFinished(self)
			self.Parent.Parent.Orb.Alpha = 1
			self.Parent.Parent.Bg.Alpha = 1
			self.Parent.Parent.Highlight.Alpha = 1
		end

		local function AnimOut_OnPlay(self)
			self.Parent.Parent.Glow.Alpha = 1
		end

		local function AnimOut_OnFinished(self)
			self.Parent.Parent.Orb.Alpha = 0
			self.Parent.Parent.Bg.Alpha = 0.5
			self.Parent.Parent.Highlight.Alpha = 0
			self.Parent.Parent.Glow.Alpha = 0
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	    function ShadowOrb(self, name, parent, ...)
			Super(self, name, parent, ...)

			self:SetSize(38, 37)

			-- BACKGROUND
			local bg = Texture("Bg", self, "BACKGROUND")
			bg.Alpha = 0.5
			bg.TexturePath = [[Interface\PlayerFrame\Priest-ShadowUI]]
			bg:SetTexCoord(0.30078125, 0.44921875, 0.44531250, 0.73437500)
			bg:SetSize(38, 37)
			bg:SetPoint("CENTER")

			-- ARTWORK
			local orb = Texture("Orb", self, "ARTWORK")
			orb.Alpha = 0
			orb.TexturePath = [[Interface\PlayerFrame\Priest-ShadowUI]]
			orb:SetTexCoord(0.45703125, 0.60546875, 0.44531250, 0.73437500)
			orb:SetSize(38, 37)
			orb:SetPoint("CENTER")

			local highlight = Texture("Highlight", self, "ARTWORK")
			highlight.Alpha = 0
			highlight.TexturePath = [[Interface\PlayerFrame\Priest-ShadowUI]]
			highlight:SetTexCoord(0.00390625, 0.29296875, 0.44531250, 0.78906250)
			highlight:SetSize(74, 44)
			highlight:SetPoint("TOP", 0, -1)

			-- OVERLAY
			local glow = Texture("Glow", self, "OVERLAY")
			glow.Alpha = 0
			glow.BlendMode = "ADD"
			glow.TexturePath = [[Interface\PlayerFrame\Priest-ShadowUI]]
			glow:SetTexCoord(0.45703125, 0.60546875, 0.44531250, 0.73437500)
			glow:SetSize(38, 37)
			glow:SetPoint("CENTER")

			-- AnimIn
			local animIn = AnimationGroup("AnimIn", bg)

			animIn.OnPlay = AnimIn_OnPlay
			animIn.OnFinished = AnimIn_OnFinished

			local alpha = Alpha("Alpha", animIn)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = 0.5

			animIn = AnimationGroup("AnimIn", highlight)

			alpha = Alpha("Alpha", animIn)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = 1

			animIn = AnimationGroup("AnimIn", orb)

			alpha = Alpha("Alpha", animIn)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = 1

			animIn = AnimationGroup("AnimIn", glow)

			alpha = Alpha("Alpha1", animIn)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = 1

			alpha = Alpha("Alpha2", animIn)
			alpha.Duration = 0.25
			alpha.Order = 2
			alpha.Change = -1

			-- AnimOut
			local animOut = AnimationGroup("AnimOut", bg)
			alpha = Alpha("Alpha", animOut)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = -0.5

			animOut = AnimationGroup("AnimOut", highlight)
			alpha = Alpha("Alpha", animOut)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = -1

			animOut = AnimationGroup("AnimOut", orb)
			alpha = Alpha("Alpha", animOut)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = -1

			animOut = AnimationGroup("AnimOut", glow)
			alpha = Alpha("Alpha", animOut)
			alpha.Duration = 0.2
			alpha.Order = 1
			alpha.Change = 1
			alpha = Alpha("Alpha", animOut)
			alpha.Duration = 0.25
			alpha.Order = 2
			alpha.Change = -1

			animOut.OnPlay = AnimOut_OnPlay
			animOut.OnFinished = AnimOut_OnFinished
	    end
	endclass "ShadowOrb"

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Handler__( function (self, value)
		for i = 1, PRIEST_BAR_NUM_ORBS do
			self["Orb"..i].Activated = i <= value
		end
	end )
	property "Value" { Type = Number }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function ShowAnim_OnFinished(self)
		self.Parent.Alpha = 1
	end

	local function OnShow(self)
		self.ShowAnim.Playing = true
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function PriestPowerBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.FrameStrata = "LOW"
		self.Toplevel = true
		self:SetSize(159, 54)
		self.HitRectInsets = Inset(28, 33, 2, 22)
		self.MouseEnabled = true

		-- BACKGROUND
		local bg = Texture("Bg", self, "BACKGROUND")
		bg.TexturePath = [[Interface\PlayerFrame\Priest-ShadowUI]]
		bg:SetTexCoord(0.00390625, 0.62500000, 0.00781250, 0.42968750)
		bg:SetAllPoints()

		-- ORBS
		local orb1 = ShadowOrb("Orb1", self)
		orb1:SetPoint("TOPLEFT", 26, -1)

		local orb2 = ShadowOrb("Orb2", self)
		orb2:SetPoint("LEFT", orb1, "RIGHT", -5, 0)

		local orb3 = ShadowOrb("Orb3", self)
		orb3:SetPoint("LEFT", orb2, "RIGHT", -5, 0)

		local showAnim = AnimationGroup("ShowAnim", self)
		local alpha = Alpha("Alpha", showAnim)
		alpha.Duration = 0.5
		alpha.Order = 1
		alpha.Change = 1

		showAnim.OnFinished = ShowAnim_OnFinished

		self.OnShow = self.OnShow + OnShow
	end
endclass "PriestPowerBar"
