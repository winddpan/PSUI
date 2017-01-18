-- Author      : Kurapica
-- Create Date : 7/12/2008 14:38
-- Change Log  :
--				2010.10.18	Remove Style properties, since button is a base widget, should not have style.
--				2011/03/13	Recode as class

-- Check Version
local version = 8
if not IGAS:NewAddon("IGAS.Widget.Button", version) then
	return
end

__Doc__[[Button is the primary means for users to control the game and their characters.]]
__AutoProperty__()
class "Button"
	inherit "Frame"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the button is clicked</desc>
		<param name="button">string, name of the mouse button responsible for the click action:Button4, Button5, LeftButton, MiddleButton, RightButton</param>
		<param name="down">boolean, true for a mouse button down action; false for button up or other actions</param>
	]]
	__WidgetEvent__() event "OnClick"

	__Doc__[[
		<desc>Run when the button is double-clicked</desc>
		<param name="button">string, name of the mouse button responsible for the click action:Button4, Button5, LeftButton, MiddleButton, RightButton</param>
	]]
	__WidgetEvent__() event "OnDoubleClick"

	__Doc__[[
		<desc>Run immediately following the button's `OnClick` handler with the same arguments</desc>
		<param name="button">string, name of the mouse button responsible for the click action:Button4, Button5, LeftButton, MiddleButton, RightButton</param>
		<param name="down">boolean, true for a mouse button down action; false for button up or other actions</param>
	]]
	__WidgetEvent__() event "PostClick"

	__Doc__[[
		<desc>Run immediately before the button's `OnClick` handler with the same arguments</desc>
		<param name="button">string, name of the mouse button responsible for the click action:Button4, Button5, LeftButton, MiddleButton, RightButton</param>
		<param name="down">boolean, true for a mouse button down action; false for button up or other actions</param>
	]]
	__WidgetEvent__() event "PreClick"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"Click" [[
		<desc>Performs a (virtual) mouse click on the button.</desc>
		<param name="button">string, name of the mouse button responsible for the click action:Button4, Button5, LeftButton, MiddleButton, RightButton</param>
	]]

	__Doc__"Disable" [[Disallows user interaction with the button. Automatically changes the visual state of the button if its DisabledTexture, DisabledTextColor or DisabledFontObject are set.]]

	__Doc__"Enable" [[Allows user interaction with the button. If a disabled appearance was specified for the button, automatically returns the button to its normal appearance.]]

	__Doc__"GetButtonState" [[
		<desc>Returns the button's current state</desc>
		<return type="System.Widget.ButtonStateType">State of the button</return>
	]]

	__Doc__[[
		<desc>Returns the font object used for the button's disabled state</desc>
		<return type="System.Widget.Font"></return>
	]]
	function GetDisabledFontObject(self)
		return IGAS:GetWrapper(self.__UI:GetDisabledFontObject())
	end

	__Doc__[[
		<desc>Returns the texture used when the button is disabled</desc>
		<return type="System.Widget.Texture"></return>
	]]
	function GetDisabledTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetDisabledTexture(...))
	end

	__Doc__[[
		<desc>Returns the FontString object used for the button's label text</desc>
		<return type="System.Widget.FontString">Reference to the FontString object used for the button's label text</return>
	]]
	function GetFontString(self, ...)
		return IGAS:GetWrapper(self.__UI:GetFontString(...))
	end

	__Doc__[[
		<desc> Returns the font object used when the button is highlighted</desc>
		<return type="System.Widget.Font">Reference to the Font object used when the button is highlighted</return>
	]]
	function GetHighlightFontObject(self)
		return IGAS:GetWrapper(self.__UI:GetHighlightFontObject())
	end

	__Doc__[[
		<desc>Returns the texture used when the button is highlighted</desc>
		<return type="System.Widget.Texture">Reference to the Texture object used when the button is highlighted</return>
	]]
	function GetHighlightTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetHighlightTexture(...))
	end

	__Doc__"GetMotionScriptsWhileDisabled" [[
		<desc>Determines whether OnEnter/OnLeave scripts will fire while the button is disabled</desc>
		<return type="boolean">1 if motion scripts run while hidden; otherwise nil</return>
	]]

	__Doc__[[
		<desc>Returns the font object used for the button's normal state</desc>
		<return type="System.Widget.Font">Reference to the Font object used for the button's normal state</return>
	]]
	function GetNormalFontObject(self)
		return IGAS:GetWrapper(self.__UI:GetNormalFontObject())
	end

	__Doc__[[
		<desc>Returns the texture used for the button's normal state</desc>
		<return type="System.Widget.Texture">Reference to the Texture object used for the button's normal state</return>
	]]
	function GetNormalTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetNormalTexture(...))
	end

	__Doc__"GetPushedTextOffset" [[
		<desc>Returns the offset for moving the button's label text when pushed</desc>
		<return type="x">number, horizontal offset for the text (in pixels; values increasing to the right)</return>
		<return type="y">number, vertical offset for the text (in pixels; values increasing upward)</return>
	]]

	__Doc__[[
		<desc>Returns the texture used when the button is pushed</desc>
		<return type="System.Widget.Texture">Reference to the Texture object used when the button is pushed</return>
	]]
	function GetPushedTexture(self, ...)
		return IGAS:GetWrapper(self.__UI:GetPushedTexture(...))
	end

	__Doc__"GetText" [[
		<desc>Returns the text of the button's label</desc>
		<return type="string">Text of the button's label</return>
	]]

	__Doc__"GetTextHeight" [[
		<desc>Returns the height of the button's text label. Reflects the height of the rendered text (which increases if the text wraps onto two lines), not the point size of the text's font.</desc>
		<return type="number">Height of the button's text (in pixels)</return>
	]]

	__Doc__"GetTextWidth" [[
		<desc>Returns the width of the button's text label</desc>
		<return type="number">Width of the button's text (in pixels)</return>
	]]

	__Doc__"IsEnabled" [[
		<desc>Returns whether user interaction with the button is allowed</desc>
		<return type="boolean">1 if user interaction with the button is allowed; otherwise nil</return>
	]]

	__Doc__"LockHighlight" [[Locks the button in its highlight state. When the highlight state is locked, the button will always appear highlighted regardless of whether it is moused over.]]

	__Doc__"RegisterForClicks" [[
		<desc>Registers a button to receive mouse clicks</desc>
		<param name="...">A list of strings, each the combination of a button name and click action for which the button's click-related script handlers should be run.</param>
	]]

	__Doc__[[
		<desc>Sets the button's state</desc>
		<format>state[, locked]</format>
		<param name="state">System.Widget.ButtonStateType</param>
		<param name="locked">boolean</param>
	]]
	function SetButtonState(self, state, locked)
		self.ButtonState = state
		if locked ~= nil then self.Locked = locked end
	end

	__Doc__"SetDisabledFontObject" [[
		<desc>Sets the font object used for the button's disabled state</desc>
		<param name="font">System.Widget.Font, reference to a Font object to be used when the button is disabled</param>
	]]

	__Doc__"SetDisabledTexture" [[
		<desc>Sets the texture used when the button is disabled</desc>
		<format>texture|filename</format>
		<param name="texture">System.Widget.Texture, reference to an existing Texture object</param>
		<param name="filename">string, path to a texture image file</param>
	]]

	__Doc__"SetFontString" [[
		<desc>Sets the FontString object used for the button's label text</desc>
		<param name="fontstring">System.Widget.FontString, reference to a FontString object to be used for the button's label text</param>
	]]

	__Doc__"SetFormattedText" [[
		<desc>Sets the button's label text using format specifiers.</desc>
		<param name="formatString">string, a string containing format specifiers (as with string.format())</param>
		<param name="...">A list of values to be included in the formatted string</param>
	]]

	__Doc__"SetHighlightFontObject" [[
		<desc>Sets the font object used when the button is highlighted</desc>
		<param name="font">System.Widget.Font, reference to a Font object to be used when the button is highlighted</param>
	]]

	__Doc__"SetHighlightTexture" [[
		<desc>Sets the texture used when the button is highlighted. Unlike the other button textures for which only one is visible at a time, the button's highlight texture is drawn on top of its existing (normal or pushed) texture; thus, this method also allows specification of the texture's blend mode.</desc>
		<format>texture|filename[, mode]</format>
		<param name="texture">System.Widget.Texture, reference to an existing Texture object</param>
		<param name="filename">string, path to a texture image file</param>
		<param name="mode">System.Widget.AlphaMode, Blend mode for the texture; defaults to ADD if omitted</param>
	]]

	__Doc__"SetMotionScriptsWhileDisabled" [[
		<desc>Sets whether the button should fire OnEnter/OnLeave events while disabled</desc>
		<param name="enable">boolean, true to enable the scripts while the button is disabled, false otherwise</param>
	]]

	__Doc__"SetNormalFontObject" [[
		<desc>Sets the font object used for the button's normal state</desc>
		<param name="font">System.Widget.Font, reference to a Font object to be used in the button's normal state</param>
	]]

	__Doc__"SetNormalTexture" [[
		<desc>Sets the texture used for the button's normal state</desc>
		<format>texture|filename</format>
		<param name="texture">System.Widget.Texture, reference to an existing Texture object</param>
		<param name="filename">string, path to a texture image file</param>
	]]

	__Doc__"SetPushedTextOffset" [[
		<desc>Sets the offset for moving the button's label text when pushed. Moving the button's text while it is being clicked can provide an illusion of 3D depth for the button -- in the default UI's standard button templates, this offset matches the apparent movement seen in the difference between the buttons' normal and pushed textures.</desc>
		<param name="x">number, horizontal offset for the text (in pixels; values increasing to the right)</param>
		<param name="y">number, vertical offset for the text (in pixels; values increasing upward)</param>
	]]

	__Doc__"SetPushedTexture" [[
		<desc>Sets the texture used when the button is pushed</desc>
		<format>texture|filename</format>
		<param name="texture">System.Widget.Texture, reference to an existing Texture object</param>
		<param name="filename">string, path to a texture image file</param>
	]]

	__Doc__"SetText" [[
		<desc>Sets the text displayed as the button's label</desc>
		<param name="text">string, text to be displayed as the button's label</param>
	]]

	__Doc__"UnlockHighlight" [[Unlocks the button's highlight state. Can be used after a call to :LockHighlight() to restore the button's normal mouseover behavior.]]

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("Button", nil, parent, ...)
	end
endclass "Button"

class "Button"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Button)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[true if the button is enabled]]
	property "Enabled" {
		Get = "IsEnabled",
		Set = function(self, enabled)
			if enabled then
				self:Enable()
			else
				self:Disable()
			end
		end,
		Type = Boolean,
	}

	__Doc__[[the button's current state: NORMAL, PUSHED]]
	property "ButtonState" {
		Set = function(self, state)
			self.__UI:SetButtonState(state, self.Locked)
		end,
		Type = ButtonStateType,
	}

	__Doc__[[true if the button is locked]]
	__Handler__(function (self, value)
		self.__UI:SetButtonState(self.ButtonState, value)
	end)
	property "Locked" { Type = Boolean }

	__Doc__[[the font object used for the button's disabled state]]
	property "DisabledFontObject" { Type = FontObject }

	__Doc__[[the texture object used when the button is disabled]]
	property "DisabledTexture" { Type = Texture }

	__Doc__[[the texture file path used when the button is disabled]]
	property "DisabledTexturePath" {
		Get = function(self)
			return self:GetDisabledTexture() and self:GetDisabledTexture().TexturePath
		end,
		Set = "SetDisabledTexture",
		Type = String + Number,
	}

	__Doc__[[the texture object used when the button is highlighted]]
	property "HighlightTexture" { Type = Texture }

	__Doc__[[the texture file path used when the button is highlighted]]
	property "HighlightTexturePath" {
		Get = function(self)
			return self:GetHighlightTexture() and self:GetHighlightTexture().TexturePath
		end,
		Set = "SetHighlightTexture",
		Type = String + Number,
	}

	__Doc__[[the texture object used for the button's normal state]]
	property "NormalTexture" { Type = Texture }

	__Doc__[[the texture file used for the button's normal state]]
	property "NormalTexturePath" {
		Get = function(self)
			return self:GetNormalTexture() and self:GetNormalTexture().TexturePath
		end,
		Set = "SetNormalTexture",
		Type = String + Number,
	}

	__Doc__[[the texture object used when the button is pushed]]
	property "PushedTexture" { Type = Texture }

	__Doc__[[the texture file path used when the button is pushed]]
	property "PushedTexturePath" {
		Get = function(self)
			return self:GetPushedTexture() and self:GetPushedTexture().TexturePath
		end,
		Set = "SetPushedTexture",
		Type = String + Number,
	}

	__Doc__[[the FontString object used for the button's label text]]
	property "FontString" { Type = FontString }

	__Doc__[[the font object used when the button is highlighted]]
	property "HighlightFontObject" { Type = FontObject }

	__Doc__[[the font object used for the button's normal state]]
	property "NormalFontObject" { Type = FontObject }

	__Doc__[[the offset for moving the button's label text when pushed]]
	property "PushedTextOffset" {
		Get = function(self)
			return Dimension(self:GetPushedTextOffset())
		end,
		Set = function(self, offset)
			self:SetPushedTextOffset(offset.x, offset.y)
		end,
		Type = Dimension,
	}

	__Doc__[[the text displayed as the button's label]]
	property "Text" { Type = LocaleString }

	__Doc__[[true if the button's highlight state is locked]]
	__Handler__( function (self, value)
		if value then
			self:LockHighlight()
		else
			self:UnlockHighlight()
		end
	end )
	property "HighlightLocked" { Field = true, Type = Boolean }
endclass "Button"
