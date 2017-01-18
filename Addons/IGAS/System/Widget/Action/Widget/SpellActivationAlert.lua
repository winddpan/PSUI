-- Author      : Kurapica
-- Create Date : 2012/09/22
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Action.SpellActivationAlert", version) then
	return
end

__Doc__[[SpellActivationAlert is used to alert the activation of the action button]]
__AutoProperty__()
class "SpellActivationAlert"
	inherit "Frame"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Fired when the animation finished]]
	event "OnFinished"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Stop all animation]]
	function StopAnimation(self)
		self.Spark.AnimIn.Playing = false
		self.InnerGlow.AnimIn.Playing = false
		self.InnerGlowOver.AnimIn.Playing = false
		self.OuterGlow.AnimIn.Playing = false
		self.OuterGlowOver.AnimIn.Playing = false
		self.Ants.AnimIn.Playing = false

		self.OuterGlowOver.AnimOut.Playing = false
		self.OuterGlow.AnimOut.Playing = false
		self.Ants.AnimOut.Playing = false
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[whether the fadein animation is playing]]
	property "AnimInPlaying" {
		Get = function(self)
			return self.InnerGlow.AnimIn.Playing
		end,
		Set = function(self, value)
			self.Spark.AnimIn.Playing = value
			self.InnerGlow.AnimIn.Playing = value
			self.InnerGlowOver.AnimIn.Playing = value
			self.OuterGlow.AnimIn.Playing = value
			self.OuterGlowOver.AnimIn.Playing = value
			self.Ants.AnimIn.Playing = value

			self.OuterGlowOver.AnimOut.Playing = not value
			self.OuterGlow.AnimOut.Playing = not value
			self.Ants.AnimOut.Playing = not value
		end,
		Type = Boolean,
	}

	__Doc__[[whether the fadeout animation is playing]]
	property "AnimOutPlaying" {
		Get = function(self)
			return self.OuterGlowOver.AnimOut.Playing
		end,
		Set = function(self, value)
			self.Spark.AnimIn.Playing = not value
			self.InnerGlow.AnimIn.Playing = not value
			self.InnerGlowOver.AnimIn.Playing = not value
			self.OuterGlow.AnimIn.Playing = not value
			self.OuterGlowOver.AnimIn.Playing = not value
			self.Ants.AnimIn.Playing = not value

			self.OuterGlowOver.AnimOut.Playing = value
			self.OuterGlow.AnimOut.Playing = value
			self.Ants.AnimOut.Playing = value
		end,
		Type = Boolean,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUpdate(self, elapsed)
		-- well, just use blz global method
		AnimateTexCoords(self.Ants, 256, 256, 48, 48, 22, elapsed, 0.01)
	end

	local function OnHide(self)
		if self.OuterGlowOver.AnimOut.Playing then
			self.OuterGlowOver.AnimOut.Playing = false
			self.OuterGlow.AnimOut.Playing = false
			self.Ants.AnimOut.Playing = false
			self:Fire("OnFinished")
		end
	end

	local function AnimIn_OnPlay(self)
		local frame = self.Parent.Parent;
		local frameWidth, frameHeight = frame:GetSize();
		frame.Spark:SetSize(frameWidth, frameHeight);
		frame.Spark:SetAlpha(0.3)
		frame.InnerGlow:SetSize(frameWidth / 2, frameHeight / 2);
		frame.InnerGlow:SetAlpha(1.0);
		frame.InnerGlowOver:SetAlpha(1.0);
		frame.OuterGlow:SetSize(frameWidth * 2, frameHeight * 2);
		frame.OuterGlow:SetAlpha(1.0);
		frame.OuterGlowOver:SetAlpha(1.0);
		frame.Ants:SetSize(frameWidth * 0.85, frameHeight * 0.85)
		frame.Ants:SetAlpha(0);
		frame:Show();
	end

	local function AnimIn_OnFinished(self)
		local frame = self.Parent.Parent;
		local frameWidth, frameHeight = frame:GetSize();
		frame.Spark:SetAlpha(0);
		frame.InnerGlow:SetAlpha(0);
		frame.InnerGlow:SetSize(frameWidth, frameHeight);
		frame.InnerGlowOver:SetAlpha(0.0);
		frame.OuterGlow:SetSize(frameWidth, frameHeight);
		frame.OuterGlowOver:SetAlpha(0.0);
		frame.OuterGlowOver:SetSize(frameWidth, frameHeight);
		frame.Ants:SetAlpha(1.0);
	end

	local function AnimOut_OnFinished(self)
		self.Parent.Parent:Fire("OnFinished")
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function SpellActivationAlert(self, ...)
    	Super(self, ...)

		self.FrameStrata = "DIALOG"
		self.Visible = false
		self.OnUpdate = self.OnUpdate + OnUpdate
		self.OnHide = self.OnHide + OnHide

		-- BACKGROUND
		local spark = Texture("Spark", self, "BACKGROUND")
		spark.TexturePath = [[Interface\SpellActivationOverlay\IconAlert]]
		spark:SetTexCoord(0.00781250, 0.61718750, 0.00390625, 0.26953125)
		spark:SetAllPoints(self)
		spark.Alpha = 0

		-- ARTWORK
		local innerGlow = Texture("InnerGlow", self, "ARTWORK")
		innerGlow.TexturePath = [[Interface\SpellActivationOverlay\IconAlert]]
		innerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
		innerGlow:SetAllPoints(self)
		innerGlow.Alpha = 0

		local innerGlowOver = Texture("InnerGlowOver", self, "ARTWORK")
		innerGlowOver.TexturePath = [[Interface\SpellActivationOverlay\IconAlert]]
		innerGlow:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)
		innerGlowOver:SetPoint("TOPLEFT", innerGlow, "TOPLEFT")
		innerGlowOver:SetPoint("BOTTOMRIGHT", innerGlow, "BOTTOMRIGHT")
		innerGlowOver.Alpha = 0

		local outerGlow = Texture("OuterGlow", self, "ARTWORK")
		outerGlow.TexturePath = [[Interface\SpellActivationOverlay\IconAlert]]
		outerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
		outerGlow:SetAllPoints(self)
		outerGlow.Alpha = 1

		local outerGlowOver = Texture("OuterGlowOver", self, "ARTWORK")
		outerGlowOver.TexturePath = [[Interface\SpellActivationOverlay\IconAlert]]
		outerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)
		outerGlowOver:SetPoint("TOPLEFT", outerGlow, "TOPLEFT")
		outerGlowOver:SetPoint("BOTTOMRIGHT", outerGlow, "BOTTOMRIGHT")
		outerGlowOver.Alpha = 1

		-- OVERLAY
		local ants = Texture("Ants", self, "OVERLAY")
		ants.TexturePath = [[Interface\SpellActivationOverlay\IconAlertAnts]]
		ants:SetAllPoints(self)
		ants.Alpha = 1

		local scale, alpha

		-- Animations InGroup
		--- For Spark
		local animInSpark = AnimationGroup("AnimIn", spark)

		scale = Scale("Scale1", animInSpark)
		scale.Order = 1
		scale.Duration = 0.2
		scale.Scale = Dimension(1.5, 1.5)

		alpha = Alpha("Alpha1", animInSpark)
		alpha.Order = 1
		alpha.Duration = 0.2
		alpha.FromAlpha = 0
		alpha.ToAlpha = 1

		scale = Scale("Scale2", animInSpark)
		scale.Order = 1
		scale.Duration = 0.2
		scale.StartDelay = 0.2
		scale.Scale = Dimension(0.666666, 0.666666)

		alpha = Alpha("Alpha2", animInSpark)
		alpha.Order = 1
		alpha.Duration = 0.2
		alpha.StartDelay = 0.2
		alpha.FromAlpha = 1
		alpha.ToAlpha = 0

		--- For InnerGlow
		local animInInnerGlow = AnimationGroup("AnimIn", innerGlow)

		scale = Scale("Scale1", animInInnerGlow)
		scale.Order = 1
		scale.Duration = 0.3
		scale.Scale = Dimension(2, 2)

		alpha = Alpha("Alpha1", animInInnerGlow)
		alpha.Order = 1
		alpha.Duration = 0.2
		alpha.StartDelay = 0.3
		alpha.FromAlpha = 1
		alpha.ToAlpha = 0

		--- For InnerGlowOver
		local animInInnerGlowOver = AnimationGroup("AnimIn", innerGlowOver)

		scale = Scale("Scale1", animInInnerGlowOver)
		scale.Order = 1
		scale.Duration = 0.3
		scale.Scale = Dimension(2, 2)

		alpha = Alpha("Alpha1", animInInnerGlowOver)
		alpha.Order = 1
		alpha.Duration = 0.3
		alpha.FromAlpha = 1
		alpha.ToAlpha = 0

		--- For OuterGlow
		local animInOuterGlow = AnimationGroup("AnimIn", outerGlow)

		scale = Scale("Scale1", animInOuterGlow)
		scale.Order = 1
		scale.Duration = 0.3
		scale.Scale = Dimension(0.5, 0.5)

		--- For OuterGlowOver
		local animInOuterGlowOver = AnimationGroup("AnimIn", outerGlowOver)

		scale = Scale("Scale1", animInOuterGlowOver)
		scale.Order = 1
		scale.Duration = 0.3
		scale.Scale = Dimension(0.5, 0.5)

		alpha = Alpha("Alpha1", animInOuterGlowOver)
		alpha.Order = 1
		alpha.Duration = 0.3
		alpha.FromAlpha = 1
		alpha.ToAlpha = 0

		--- For Ants
		local animInAnts = AnimationGroup("AnimIn", ants)

		alpha = Alpha("Alpha1", animInAnts)
		alpha.Order = 1
		alpha.Duration = 0.2
		alpha.StartDelay = 0.2
		alpha.FromAlpha = 0
		alpha.ToAlpha = 1

		animInInnerGlow.OnPlay = AnimIn_OnPlay
		animInInnerGlow.OnFinished = AnimIn_OnFinished

		-- Animations OutGroup
		--- For OuterGlowOver
		local animOutOuterGlowOver = AnimationGroup("AnimOut", outerGlowOver)

		alpha = Alpha("Alpha1", animOutOuterGlowOver)
		alpha.Order = 1
		alpha.Duration = 0.2
		alpha.FromAlpha = 0
		alpha.ToAlpha = 1

		alpha = Alpha("Alpha2", animOutOuterGlowOver)
		alpha.Order = 2
		alpha.Duration = 0.2
		alpha.FromAlpha = 1
		alpha.ToAlpha = 0

		--- For OuterGlow
		local animOutOuterGlow = AnimationGroup("AnimOut", outerGlow)

		alpha = Alpha("Alpha1", animOutOuterGlow)
		alpha.Order = 1
		alpha.Duration = 0.2
		alpha.StartDelay = 0.2
		alpha.FromAlpha = 1
		alpha.ToAlpha = 0

		--- For Ants
		local animOutAnts = AnimationGroup("AnimOut", ants)

		alpha = Alpha("Alpha1", animOutOuterGlow)
		alpha.Order = 1
		alpha.Duration = 0.2
		alpha.FromAlpha = 1
		alpha.ToAlpha = 0

		animOutOuterGlowOver.OnFinished = AnimOut_OnFinished
    end
endclass "SpellActivationAlert"
