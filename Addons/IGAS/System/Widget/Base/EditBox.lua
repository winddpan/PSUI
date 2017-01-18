-- Author      : Kurapica
-- Create Date : 7/16/2008 11:15
-- Change Log  :
--				2011/03/13	Recode as class
--              2013/06/14  Fix text won't display when create it in the game with no hardware trigger(Hate to fix things caused by blz)

-- Check Version
local version = 8
if not IGAS:NewAddon("IGAS.Widget.EditBox", version) then
	return
end

__Doc__[[EditBoxes are used to allow the player to type text into a UI component.]]
__AutoProperty__()
class "EditBox"
	inherit "Frame"
	extend "IFFont"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the edit box's input composition mode changes</desc>
		<param name="text">string, The text entered</param>
	]]
	__WidgetEvent__() event "OnCharComposition"

	__Doc__[[
		<desc>Run when the position of the text insertion cursor in the edit box changes</desc>
		<param name="x">number, horizontal position of the cursor relative to the top left corner of the edit box (in pixels)</param>
		<param name="y">number, vertical position of the cursor relative to the top left corner of the edit box (in pixels)</param>
		<param name="width">number, width of the cursor graphic (in pixels)</param>
		<param name="height">number, height of the cursor graphic (in pixels); matches the height of a line of text in the edit box</param>
	]]
	__WidgetEvent__() event "OnCursorChanged"

	__Doc__ [[Run when the edit box becomes focused for keyboard input]]
	__WidgetEvent__() event "OnEditFocusGained"

	__Doc__[[Run when the edit box loses keyboard input focus]]
	__WidgetEvent__() event "OnEditFocusLost"

	__Doc__[[Run when the Enter (or Return) key is pressed while the edit box has keyboard focus]]
	__WidgetEvent__() event "OnEnterPressed"

	__Doc__[[Run when the Escape key is pressed while the edit box has keyboard focus]]
	__WidgetEvent__() event "OnEscapePressed"

	__Doc__[[
		<desc>Run when the edit box's language input mode changes</desc>
		<param name="language">string, name of the new input language</param>
	]]
	__WidgetEvent__() event "OnInputLanguageChanged"

	__Doc__[[Run when the space bar is pressed while the edit box has keyboard focus]]
	__WidgetEvent__() event "OnSpacePressed"

	__Doc__[[Run when the Tab key is pressed while the edit box has keyboard focus]]
	__WidgetEvent__() event "OnTabPressed"

	__Doc__[[
		<desc>Run when the edit box's text is changed</desc>
		<param name="isUserInput">boolean</param>
	]]
	__WidgetEvent__() event "OnTextChanged"

	__Doc__[[Run when the edit box's text is set programmatically]]
	__WidgetEvent__() event "OnTextSet"

	_FirstLoadedFix = setmetatable({}, {__mode = "k",})

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"AddHistoryLine" [[
		<desc>Add text to the edit history</desc>
		<param name="text">string, text to be added to the edit box's list of history lines</param>
	]]

	__Doc__"ClearHistory" [[Clear history]]

	__Doc__"ClearFocus" [[Releases keyboard input focus from the edit box]]

	__Doc__"GetAltArrowKeyMode" [[
		<desc>Returns whether arrow keys are ignored by the edit box unless the Alt key is held</desc>
		<return type="boolean">1 if arrow keys are ignored by the edit box unless the Alt key is held; otherwise nil</return>
	]]

	__Doc__"GetBlinkSpeed" [[
		<desc>Returns the rate at which the text insertion blinks when the edit box is focused</desc>
		<return type="number">Amount of time for which the cursor is visible during each "blink" (in seconds)</return>
	]]

	__Doc__"GetCursorPosition" [[
		<desc>Returns the current cursor position inside edit box</desc>
		<return type="number">Current position of the keyboard input cursor (between 0, for the position before the first character, and editbox:GetNumLetters(), for the position after the last character)</return>
	]]

	__Doc__"GetHistoryLines" [[
		<desc>Returns the maximum number of history lines stored by the edit box</desc>
		<return type="number">Maximum number of history lines stored by the edit box</return>
	]]

	__Doc__"GetIndentedWordWrap" [[
		<desc>Returns whether long lines of text are indented when wrapping</desc>
		<return type="boolean">1 if long lines of text are indented when wrapping; otherwise nil</return>
	]]

	__Doc__"GetInputLanguage" [[
		<desc>Returns the currently selected keyboard input language (character set / input method). Applies to keyboard input methods, not in-game languages or client locales.</desc>
		<return type="string">the input language</return>
	]]

	__Doc__"GetMaxBytes" [[
		<desc>Returns the maximum number of bytes of text allowed in the edit box. Note: Unicode characters may consist of more than one byte each, so the behavior of a byte limit may differ from that of a character limit in practical use.</desc>
		<return type="number">Maximum number of text bytes allowed in the edit box</return>
	]]

	__Doc__"GetMaxLetters" [[
		<desc>Returns the maximum number of text characters allowed in the edit box</desc>
		<return type="number">Maximum number of text characters allowed in the edit box</return>
	]]

	__Doc__"GetNumber" [[
		<desc>Returns the contents of the edit box as a number. Similar to tonumber(editbox:GetText()); returns 0 if the contents of the edit box cannot be converted to a number.</desc>
		<return type="number">Contents of the edit box as a number</return>
	]]

	__Doc__"GetNumLetters" [[
		<desc>Returns the number of text characters in the edit box</desc>
		<return type="number">Number of text characters in the edit box</return>
	]]

	__Doc__"GetText" [[
		<desc>Returns the edit box's text contents</desc>
		<return type="string">Text contained in the edit box</return>
	]]

	__Doc__"GetTextInsets" [[
		<desc>Returns the insets from the edit box's edges which determine its interactive text area</desc>
		<return type="left">number, distance from the left edge of the edit box to the left edge of its interactive text area (in pixels)</return>
		<return type="right">number, distance from the right edge of the edit box to the right edge of its interactive text area (in pixels)</return>
		<return type="top">number, distance from the top edge of the edit box to the top edge of its interactive text area (in pixels)</return>
		<return type="bottom">number, distance from the bottom edge of the edit box to the bottom edge of its interactive text area (in pixels)</return>
	]]

	__Doc__"GetUTF8CursorPosition" [[
		<desc>Returns the cursor's numeric position in the edit box, taking UTF-8 multi-byte character into account. If the EditBox contains multi-byte Unicode characters, the GetCursorPosition() method will not return correct results, as it considers each eight byte character to count as a single glyph.  This method properly returns the position in the edit box from the perspective of the user.</desc>
		<return type="number">The cursor's numeric position (leftmost position is 0), taking UTF8 multi-byte characters into account.</return>
	]]

	__Doc__"HasFocus" [[
		<desc>Returns whether the edit box is currently focused for keyboard input</desc>
		<return type="boolean">1 if the edit box is currently focused for keyboard input; otherwise nil</return>
	]]

	__Doc__"HighlightText" [[
		<desc>Selects all or a portion of the text in the edit box</desc>
		<param name="start">number, character position at which to begin the selection (between 0, for the position before the first character, and editbox:GetNumLetters(), for the position after the last character); defaults to 0 if not specified</param>
		<param name="end">number, character position at which to end the selection; if not specified or if less than start, selects all characters after the start position; if equal to start, selects nothing and positions the cursor at the start position</param>
	]]

	__Doc__"Insert" [[
		<desc>Inserts text into the edit box at the current cursor position</desc>
		<param name="text">string, text to be inserted</param>
	]]

	__Doc__"IsAutoFocus" [[
		<desc>Returns whether the edit box automatically acquires keyboard input focus</desc>
		<return type="boolean">1 if the edit box automatically acquires keyboard input focus; otherwise nil</return>
	]]

	__Doc__"IsCountInvisibleLetters" [[
		<return type="boolean"></return>
	]]

	__Doc__"IsInIMECompositionMode" [[
		<desc>Returns whether the edit box is in Input Method Editor composition mode. Character composition mode is used for input methods in which multiple keypresses generate one printed character. In such input methods, the edit box's OnChar script is run for each keypress</desc>
		<return type="boolean">1 if the edit box is in IME character composition mode; otherwise nil</return>
	]]

	__Doc__"IsMultiLine" [[
		<desc>Returns whether the edit box shows more than one line of text</desc>
		<return type="boolean">1 if the edit box shows more than one line of text; otherwise nil</return>
	]]

	__Doc__"IsNumeric" [[
		<desc>Returns whether the edit box only accepts numeric input</desc>
		<return type="boolean">1 if only numeric input is allowed; otherwise nil</return>
	]]

	__Doc__"IsPassword" [[
		<desc>Returns whether the text entered in the edit box is masked</desc>
		<return type="boolean">1 if text entered in the edit box is masked with asterisk characters (*); otherwise nil</return>
	]]

	__Doc__"SetAltArrowKeyMode" [[
		<desc>Sets whether arrow keys are ignored by the edit box unless the Alt key is held</desc>
		<param name="enable">boolean, true to cause the edit box to ignore arrow key presses unless the Alt key is held; false to allow unmodified arrow key presses for cursor movement</param>
	]]

	__Doc__"SetAutoFocus" [[
		<desc>Sets whether the edit box automatically acquires keyboard input focus. If auto-focus behavior is enabled, the edit box automatically acquires keyboard focus when it is shown and when no other edit box is focused.</desc>
		<param name="enable">boolean, true to enable the edit box to automatically acquire keyboard input focus; false to disable</param>
	]]

	__Doc__"SetBlinkSpeed" [[
		<desc>Sets the rate at which the text insertion blinks when the edit box is focused. The speed indicates how long the cursor stays in each state (shown and hidden); e.g. if the blink speed is 0.5 (the default, the cursor is shown for one half second and then hidden for one half second (thus, a one-second cycle); if the speed is 1.0, the cursor is shown for one second and then hidden for one second (a two-second cycle).</desc>
		<param name="duration">number, Amount of time for which the cursor is visible during each "blink" (in seconds)</param>
	]]

	__Doc__"SetCountInvisibleLetters" [[
		<param name="..."></param>
	]]

	__Doc__"SetCursorPosition" [[
		<desc>Sets the cursor position in the edit box</desc>
		<param name="position">number, new position for the keyboard input cursor (between 0, for the position before the first character, and editbox:GetNumLetters(), for the position after the last character)</param>
	]]

	__Doc__"SetFocus" [[Focuses the edit box for keyboard input. Only one edit box may be focused at a time; setting focus to one edit box will remove it from the currently focused edit box.]]

	__Doc__"SetHistoryLines" [[
		<desc>Sets the maximum number of history lines stored by the edit box. Lines of text can be added to the edit box's history by calling :AddHistoryLine(); once added, the user can quickly set the edit box's contents to one of these lines by pressing the up or down arrow keys. (History lines are only accessible via the arrow keys if the edit box is not in multi-line mode.)</desc>
		<param name="count">number, Maximum number of history lines to be stored by the edit box</param>
	]]

	__Doc__"SetIndentedWordWrap" [[
		<desc>Sets whether long lines of text are indented when wrapping</desc>
		<param name="indent">boolean, true to indent wrapped lines of text; false otherwise</param>
	]]

	__Doc__"SetMaxBytes" [[
		<desc>Sets the maximum number of bytes of text allowed in the edit box</desc>
		<param name="maxBytes">number, Maximum number of text bytes allowed in the edit box, or 0 for no limit</param>
	]]

	__Doc__"SetMaxLetters" [[
		<desc>Sets the maximum number of text characters allowed in the edit box.</desc>
		<param name="maxLetters">number, Maximum number of text characters allowed in the edit box, or 0 for no limit</param>
	]]

	__Doc__"SetMultiLine" [[
		<desc>Sets whether the edit box shows more than one line of text. When in multi-line mode, the edit box's height is determined by the number of lines shown and cannot be set directly -- enclosing the edit box in a ScrollFrame may prove useful in such cases.</desc>
		<param name="multiLine">boolean, true to allow the edit box to display more than one line of text; false for single-line display</param>
	]]

	__Doc__"SetNumber" [[
		<desc>Sets the contents of the edit box to a number</desc>
		<param name="num">number, new numeric content for the edit box</param>
	]]

	__Doc__"SetNumeric" [[
		<desc>Sets whether the edit box only accepts numeric input. Note: an edit box in numeric mode <em>only</em> accepts numeral input -- all other characters, including those commonly used in numeric representations (such as ., E, and -) are not allowed.</desc>
		<param name="enable">boolean, true to allow only numeric input; false to allow any text</param>
		]]

	__Doc__"SetPassword" [[
		<desc>Sets whether the text entered in the edit box is masked</desc>
		<param name="enable">boolean, true to mask text entered in the edit box with asterisk characters (*); false to show the actual text entered</param>
		]]

	__Doc__[[
		<desc>Sets the edit box's text contents</desc>
		<param name="text">string, text to be placed in the edit box</param>
	]]
	function SetText(self, text)
		self.__UI:SetText(text)

		if _FirstLoadedFix[self] then
			_FirstLoadedFix[self] = nil

			self.__UI:SetCursorPosition(0)
		end
	end

	__Doc__"SetTextInsets" [[
		<desc>Sets the insets from the edit box's edges which determine its interactive text area</desc>
		<param name="left">number, distance from the left edge of the edit box to the left edge of its interactive text area (in pixels)</param>
		<param name="right">number, distance from the right edge of the edit box to the right edge of its interactive text area (in pixels)</param>
		<param name="top">number, distance from the top edge of the edit box to the top edge of its interactive text area (in pixels)</param>
		<param name="bottom">number, distance from the bottom edge of the edit box to the bottom edge of its interactive text area (in pixels)</param>
	]]

	__Doc__"ToggleInputLanguage" [[Switches the edit box's language input mode. If the edit box is in ROMAN mode and an alternate Input Method Editor composition mode is available (as determined by the client locale and system settings), switches to the alternate input mode. If the edit box is in IME composition mode, switches back to ROMAN.]]

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("EditBox", nil, parent, ...)
	end

	function EditBox(self, ...)
		Super(self, ...)

		_FirstLoadedFix[self] = true
	end
endclass "EditBox"

class "EditBox"

	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(EditBox)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[true if the edit box shows more than one line of text]]
	property "MultiLine" { Type = Boolean }

	__Doc__[[true if the edit box only accepts numeric input]]
	property "Numeric" { Type = Boolean }

	__Doc__[[true if the text entered in the edit box is masked]]
	property "Password" { Type = Boolean }

	__Doc__[[true if the edit box automatically acquires keyboard input focus]]
	property "AutoFocus" { Type = Boolean }

	__Doc__[[the maximum number of history lines stored by the edit box]]
	property "HistoryLines" { Type = Number }

	__Doc__[[true if the edit box is currently focused]]
	property "Focused" {
		Get = "HasFocus",
		Set = function(self, focus)
			if focus then
				self:SetFocus()
			else
				self:ClearFocus()
			end
		end,
		Type = Boolean,
	}

	__Doc__[[true if the arrow keys are ignored by the edit box unless the Alt key is held]]
	property "AltArrowKeyMode" { Type = Boolean }

	__Doc__[[the rate at which the text insertion blinks when the edit box is focused]]
	property "BlinkSpeed" { Type = Number }

	__Doc__[[the current cursor position inside edit box]]
	property "CursorPosition" { Type = Number }

	__Doc__[[the maximum number of bytes of text allowed in the edit box, default is 0(Infinite)]]
	property "MaxBytes" { Type = Number }

	__Doc__[[the maximum number of text characters allowed in the edit box]]
	property "MaxLetters" { Type = Number }

	__Doc__[[the contents of the edit box as a number]]
	property "Number" { Type = Number }

	__Doc__[[the edit box's text contents]]
	property "Text" { Type = String }

	__Doc__[[the insets from the edit box's edges which determine its interactive text area]]
	property "TextInsets" {
		Get = function(self)
			return Inset(self:GetTextInsets())
		end,
		Set = function(self, value)
			self:SetTextInsets(value.left, value.right, value.top, value.bottom)
		end,
		Type = Inset,
	}

	__Doc__[[true if the edit box is editable]]
	property "Editable" {
		Get = function(self)
			return self.MouseEnabled
		end,
		Set = function(self, flag)
			self.MouseEnabled = flag
			if not flag then
				self.AutoFocus = false
				if self:HasFocus() then
					self:ClearFocus()
				end
			end
		end,
		Type = Boolean,
	}
endclass "EditBox"
