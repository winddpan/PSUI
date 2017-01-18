-- Author      : Kurapica
-- Create Date : 2012/09/01
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Action.ActionButton", version) then
	return
end

__Doc__[[the base action button template]]
__AutoProperty__()
class "ActionButton"
	inherit "BaseActionButton"
	extend "IFKeyBinding"

	RANGE_INDICATOR = "●"

	local function UpdateHotKey(self, value)
		local hotKey = self:GetChild("HotKey")

		if hotKey.Text == RANGE_INDICATOR then
			if value == true then
				hotKey:Show()
				hotKey:SetVertexColor(1, 1, 1)
			elseif value == false then
				hotKey:Show()
				hotKey:SetVertexColor(1, 0, 0)
			else
				hotKey:Hide()
			end
		else
			hotKey:Show()
			if value == false then
				hotKey:SetVertexColor(1, 0, 0)
			else
				hotKey:SetVertexColor(1, 1, 1)
			end
		end
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Set flyoutDirection for action button</desc>
		<param name="dir">System.Widget.Action.IFActionHandler.FlyoutDirection</param>
	]]
	function SetFlyoutDirection(self, dir)
		IFActionHandler.SetFlyoutDirection(self, dir)

		dir = self:GetAttribute("flyoutDirection")

		dir = dir == "UP" and "TOP"
			or dir == "DOWN" and "BOTTOM"
			or dir

		self:GetChild("FlyoutArrow"):ClearAllPoints()
		local point = dir == "TOP" and "BOTTOM"
							or dir == "BOTTOM" and "TOP"
							or dir == "LEFT" and "RIGHT"
							or dir == "RIGHT" and "LEFT"
		local angle = dir == "TOP" and 0
							or dir == "BOTTOM" and 180
							or dir == "LEFT" and 270
							or dir == "RIGHT" and 90
		self:GetChild("FlyoutArrow"):SetPoint(point, self, dir)
		self:GetChild("FlyoutArrow"):RotateDegree(angle)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the visible of the flash, accessed by IFActionHandler]]
	property "FlashVisible" {
		Get = function(self)
			return self:GetChild("Flash").Visible
		end,
		Set = function(self, value)
			self:GetChild("Flash").Visible = value
		end,
	}

	__Doc__[[the visible of the flyout arrow, accessed by IFActionHandler]]
	property "FlyoutVisible" {
		Get = function(self)
			return self:GetChild("FlyoutArrow").Visible
		end,
		Set = function(self, value)
			self:GetChild("FlyoutArrow").Visible = value
		end,
		Type = Boolean,
	}

	__Doc__[[whether the flyout action bar is shown, accessed by IFActionHandler]]
	property "Flyouting" {
		Get = function(self)
			return self:GetChild("FlyoutBorder").Visible
		end,
		Set = function(self, value)
			self:GetChild("FlyoutBorder").Visible = value
			self:GetChild("FlyoutBorderShadow").Visible = value
		end,
		Type = Boolean,
	}

	__Doc__[[whether the action is auto castable, accessed by IFActionHandler]]
	__Handler__( function (self, value)
		if value then
			if not self:GetChild("AutoCastable") then
				local autoCast = Texture("AutoCastable", self, "OVERLAY")
				autoCast.Visible = false
				autoCast.TexturePath = [[Interface\Buttons\UI-AutoCastableOverlay]]
				autoCast:SetPoint("TOPLEFT", -14, 14)
				autoCast:SetPoint("BOTTOMRIGHT", 14, -14)
			end
			self:GetChild("AutoCastable").Visible = true
		else
			if self:GetChild("AutoCastable") then
				self:GetChild("AutoCastable").Visible = false
			end
		end
	end )
	property "AutoCastable" { Type = BooleanNil }

	__Doc__[[whether the action is now auto-casting, accessed by IFActionHandler]]
	__Handler__( function (self, value)
		if value then
			if not self:GetChild("AutoCastShine") then AutoCastShine("AutoCastShine", self) end
			self:GetChild("AutoCastShine"):Start()
		else
			if self:GetChild("AutoCastShine") then self:GetChild("AutoCastShine"):Stop() end
		end
	end )
	property "AutoCasting" { Type = BooleanNil }

	property "HotKey" {
		Get = function(self)
			return self:GetChild("HotKey").Text
		end,
		Set = function(self, value)
			self:GetChild("HotKey").Text = value or RANGE_INDICATOR
			UpdateHotKey(self)
		end,
		Type = String,
	}

	__Handler__( UpdateHotKey )
	property "InRange" { Type = BooleanNil_01 }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function ActionButton(self, ...)
		Super(self, ...)

		self.UseRangeCheck = true

		-- ARTWORK-1
		local flash = Texture("Flash", self, "ARTWORK", nil, 1)
		flash.Visible = false
		flash.TexturePath = [[Interface\Buttons\UI-QuickslotRed]]
		flash:SetAllPoints(self)

		local flyoutBorder = Texture("FlyoutBorder", self, "ARTWORK", nil, 1)
		flyoutBorder.Visible = false
		flyoutBorder.TexturePath = [[Interface\Buttons\ActionBarFlyoutButton]]
		flyoutBorder:SetTexCoord(0.01562500, 0.67187500, 0.39843750, 0.72656250)
		flyoutBorder:SetPoint("TOPLEFT", -3, 3)
		flyoutBorder:SetPoint("BOTTOMRIGHT", 3, -3)

		local flyoutBorderShadow = Texture("FlyoutBorderShadow", self, "ARTWORK", nil, 1)
		flyoutBorderShadow.Visible = false
		flyoutBorderShadow.TexturePath = [[Interface\Buttons\ActionBarFlyoutButton]]
		flyoutBorderShadow:SetTexCoord(0.01562500, 0.76562500, 0.00781250, 0.38281250)
		flyoutBorderShadow:SetPoint("TOPLEFT", -6, 6)
		flyoutBorderShadow:SetPoint("BOTTOMRIGHT", 6, -6)

		-- ARTWORK-2
		local flyoutArrow = Texture("FlyoutArrow", self, "ARTWORK", nil, 2)
		flyoutArrow.Visible = false
		flyoutArrow.TexturePath = [[Interface\Buttons\ActionBarFlyoutButton]]
		flyoutArrow:SetTexCoord(0.62500000, 0.98437500, 0.74218750, 0.82812500)
		flyoutArrow.Width = 23
		flyoutArrow.Height = 11
		flyoutArrow:SetPoint("BOTTOM", self, "TOP")

		local hotKey = FontString("HotKey", self, "ARTWORK", "NumberFontNormal", 2)
		hotKey.JustifyH = "Right"
		hotKey.Height = 10
		hotKey:SetPoint("TOPLEFT", 1, -3)
		hotKey:SetPoint("TOPRIGHT", -1, -3)
	end
endclass "ActionButton"
