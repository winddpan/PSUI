-- Author      : Kurapica
-- Create Date : 2016/08/07
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Action.BaseActionButton", version) then
	return
end

__Doc__[[the base action button template]]
__AutoProperty__()
class "BaseActionButton"
	inherit "SecureCheckButton"
	extend "IFActionHandler" "IFCooldownIndicator"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Update the action button when content is changed]]
	function UpdateAction(self)
		if self:HasAction() then
			self.NormalTexturePath = [[Interface\Buttons\UI-Quickslot2]]
		else
			self.NormalTexturePath = [[Interface\Buttons\UI-Quickslot]]
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the action button icon's image file path, accessed by IFActionHandler]]
	property "Icon" {
		Get = function(self)
			return self:GetChild("Icon").TexturePath
		end,
		Set = function(self, value)
			self:GetChild("Icon").TexturePath = value
		end,
		Type = String+Number,
	}

	__Doc__[[the action's count, like item's count, accessed by IFActionHandler]]
	property "Count" {
		Get = function(self)
			return self:GetChild("Count").Text
		end,
		Set = function(self, value)
			self:GetChild("Count").Text = tostring(value or "")
		end,
		Type = StringNumber,
	}

	__Doc__[[the action's text, accessed by IFActionHandler]]
	property "Text" {
		Get = function(self)
			return self:GetChild("Name").Text
		end,
		Set = function(self, value)
			self:GetChild("Name").Text = value or ""
		end,
		Type = String,
	}

	__Doc__[[whether the action is usable, accessed by IFActionHandler]]
	__Handler__( function (self, value)
		if value then
			self:GetChild("Icon"):SetVertexColor(1.0, 1.0, 1.0)
		else
			self:GetChild("Icon"):SetVertexColor(0.4, 0.4, 0.4)
		end
	end )
	property "Usable" { Type = BooleanNil }

	__Doc__[[Whether an indicator should be shown for equipped item]]
	__Handler__( function (self, value)
		if value then
			self.Border:SetVertexColor(0, 1.0, 0, 0.7)
			self.Border.Visible = true
		else
			self.Border.Visible = false
		end
	end )
	property "EquippedItemIndicator" { Type = BooleanNil }

	__Doc__[[Whether the search overlay will be shown]]
	__Handler__(function (self, value)
		-- Create it when needed
		local overlay = self:GetChild("SearchOverlay")
		if value then
			if not overlay then
				overlay = Texture("SearchOverlay", self, "OVERLAY", nil, 2)
				overlay:SetAllPoints(self)
				overlay:SetTexture(0, 0, 0, 0.8)
			end
			overlay.Visible = true
		elseif overlay then
			overlay.Visible = false
		end
	end)
	property "ShowSearchOverlay" { Type = Boolean }

	__Doc__[[Whether the action button's icon is locked]]
	__Handler__( function (self, value)
		self:GetChild("Icon"):SetDesaturated(value)
	end )
	property "IconLocked" { Type = BooleanNil }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function BaseActionButton(self, ...)
    	Super(self, ...)

		self.Height = 36
		self.Width = 36

		-- Button Texture
		--- NormalTexture
		self.NormalTexturePath = [[Interface\Buttons\UI-Quickslot]]
		self.NormalTexture:ClearAllPoints()
		self.NormalTexture:SetPoint("TOPLEFT", -15, 15)
		self.NormalTexture:SetPoint("BOTTOMRIGHT", 15, -15)

		--- PushedTexture
		self.PushedTexturePath = [[Interface\Buttons\UI-Quickslot-Depress]]

		--- HighlightTexture
		self.HighlightTexturePath = [[Interface\Buttons\ButtonHilight-Square]]
		self.HighlightTexture.BlendMode = "Add"

		--- CheckedTexture
		self.CheckedTexturePath = [[Interface\Buttons\CheckButtonHilight]]
		self.CheckedTexture.BlendMode = "Add"

		-- BACKGROUND
		local icon = Texture("Icon", self, "BACKGROUND")
		icon:SetAllPoints(self)

		-- ARTWORK
		local count = FontString("Count", self, "ARTWORK", "NumberFontNormal", 2)
		count.JustifyH = "Right"
		count:SetPoint("BOTTOMRIGHT", -2, 2)

		-- OVERLAY
		local name = FontString("Name", self, "OVERLAY", "GameFontHighlightSmallOutline")
		name.JustifyH = "Center"
		name.Height = 10
		name:SetPoint("BOTTOMLEFT", 0, 2)
		name:SetPoint("BOTTOMRIGHT", 0, 2)

		local border = Texture("Border", self, "OVERLAY")
		border.BlendMode = "Add"
		border.Visible = false
		border.TexturePath = [[Interface\Buttons\UI-ActionButton-Border]]
		border:SetPoint("TOPLEFT", -8, 8)
		border:SetPoint("BOTTOMRIGHT", 8, -8)
    end
endclass "BaseActionButton"
