-- Author      : Kurapica
-- Create Date : 7/16/2008 15:01
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 7
if not IGAS:NewAddon("IGAS.Widget.CheckButton", version) then
	return
end

__Doc__[[CheckButtons are a specialized form of Button; they maintain an on/off state, which toggles automatically when they are clicked, and additional textures for when they are checked, or checked while disabled.]]
__AutoProperty__()
class "CheckButton"
	inherit "Button"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetChecked" [[
		<desc>Returns whether the check button is checked</desc>
		<return type="boolean">1 if the button is checked; nil if the button is unchecked</return>
	]]

	__Doc__[[
		<desc>Returns the texture used when the button is checked</desc>
		<return type="System.Widget.Texture">Reference to the Texture object used when the button is checked</return>
	]]
	function GetCheckedTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetCheckedTexture(...))
	end

	__Doc__[[
		<desc>Returns the texture used when the button is disabled and checked</desc>
		<return type="System.Widget.Texture">Reference to the Texture object used when the button is disabled and checked</return>
	]]
	function GetDisabledCheckedTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetDisabledCheckedTexture(...))
	end

	__Doc__"SetChecked" [[
		<desc>Sets whether the check button is checked</desc>
		<param name="enable">boolean, true to check the button; false to uncheck</param>
	]]

	__Doc__"SetCheckedTexture" [[
		<desc>Sets the texture used when the button is checked</desc>
		<format>texture|filename</format>
		<param name="texture">System.Widget.Texture, reference to an existing Texture object</param>
		<param name="filename">string, path to a texture image file</param>
	]]

	__Doc__"SetDisabledCheckedTexture" [[
		<desc>Sets the texture used when the button is disabled and checked</desc>
		<format>texture|filename</format>
		<param name="texture">System.Widget.Texture, reference to an existing Texture object</param>
		<param name="filename">string, path to a texture image file</param>
	]]

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("CheckButton", nil, parent, ...)
	end
endclass "CheckButton"

class "CheckButton"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(CheckButton)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[true if the checkbutton is checked]]
	property "Checked" { Type = Boolean }

	__Doc__[[the texture object used when the button is checked]]
	property "CheckedTexture" { Type = Texture }

	__Doc__[[the texture file path used when the button is checked]]
	property "CheckedTexturePath" {
		Get = function(self)
			return self:GetCheckedTexture() and self:GetCheckedTexture().TexturePath
		end,
		Set = function(self, texture)
			self:SetCheckedTexture(texture)
		end,
		Type = String + Number,
	}

	__Doc__[[the texture object used when the button is disabled and checked]]
	property "DisabledCheckedTexture" { Type = Texture }

	__Doc__[[the texture file path used when the button is disabled and checked]]
	property "DisabledCheckedTexturePath" {
		Get = function(self)
			return self:GetDisabledCheckedTexture() and self:GetDisabledCheckedTexture().TexturePath
		end,
		Set = function(self, texture)
			self:SetDisabledCheckedTexture(texture)
		end,
		Type = String + Number,
	}
endclass "CheckButton"
