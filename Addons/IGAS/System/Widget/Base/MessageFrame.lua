-- Author      : Kurapica
-- Create Date : 7/16/2008 12:09
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 8
if not IGAS:NewAddon("IGAS.Widget.MessageFrame", version) then
	return
end

__Doc__[[MessageFrames are used to present series of messages or other lines of text, usually stacked on top of each other.]]
__AutoProperty__()
class "MessageFrame"
	inherit "Frame"
	extend "IFFont"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"AddMessage" [[
		<desc>Adds a message to those listed in the frame. If the frame was already 'full' with messages, then the oldest message is discarded when the new one is added.</desc>
		<param name="text">string, text of the message</param>
		<param name="red">number, red component of the text color for the message (0.0 - 1.0)</param>
		<param name="green">number, green component of the text color for the message (0.0 - 1.0)</param>
		<param name="blue">number, blue component of the text color for the message (0.0 - 1.0)</param>
		<param name="alpha">number, alpha (opacity) for the message (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__"Clear" [[Removes all messages displayed in the frame]]

	__Doc__"GetFadeDuration" [[
		<desc>Returns the duration of the fade-out animation for disappearing messages.</desc>
		<return type="number">Duration of the fade-out animation for disappearing messages (in seconds)</return>
	]]

	__Doc__"GetFading" [[
		<desc>Returns whether messages added to the frame automatically fade out after a period of time</desc>
		<return type="boolean">1 if messages added to the frame automatically fade out after a period of time; otherwise nil</return>
	]]

	__Doc__"GetIndentedWordWrap" [[
		<desc>Returns whether long lines of text are indented when wrapping</desc>
		<return type="boolean">1 if long lines of text are indented when wrapping; otherwise nil</return>
	]]

	__Doc__"GetInsertMode" [[
		<desc>Returns the position at which new messages are added to the frame</desc>
		<return type="System.Widget.InsertMode">Token identifying the position at which new messages are added to the frame</return>
	]]

	__Doc__"GetTimeVisible" [[
		<desc>Returns the amount of time for which a message remains visible before beginning to fade out. For the duration of the fade-out animation, see :GetFadeDuration().</desc>
		<return type="number">Amount of time for which a message remains visible before beginning to fade out (in seconds)</return>
	]]

	__Doc__"SetFadeDuration" [[
		<desc>Sets the duration of the fade-out animation for disappearing messages.</desc>
		<param name="duration">number, duration of the fade-out animation for disappearing messages (in seconds)</param>
	]]

	__Doc__"SetFading" [[
		<desc>Sets whether messages added to the frame automatically fade out after a period of time</desc>
		<param name="fading">boolean, true to cause messages added to the frame to automatically fade out after a period of time; false to leave message visible</param>
	]]

	__Doc__"SetIndentedWordWrap" [[
		<desc>Sets whether long lines of text are indented when wrapping</desc>
		<param name="indent">boolean, true to indent wrapped lines of text; false otherwise</param>
	]]

	__Doc__"SetInsertMode" [[
		<desc>Sets the position at which new messages are added to the frame</desc>
		<param name="position">System.Widget.InsertMode, token identifying the position at which new messages should be added to the frame</param>
	]]

	__Doc__"SetTimeVisible" [[
		<desc>Sets the amount of time for which a message remains visible before beginning to fade out.</desc>
		<param name="time">number, amount of time for which a message remains visible before beginning to fade out (in seconds)</param>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("MessageFrame", nil, parent, ...)
	end
endclass "MessageFrame"

class "MessageFrame"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(MessageFrame)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[whether messages added to the frame automatically fade out after a period of time]]
	property "Fading" { Type = Boolean }

	__Doc__[[whether long lines of text are indented when wrapping]]
	property "IndentedWordWrap" { Type = Boolean }

	__Doc__[[the amount of time for which a message remains visible before beginning to fade out]]
	property "TimeVisible" { Type = Number }

	__Doc__[[the duration of the fade-out animation for disappearing messages]]
	property "FadeDuration" { Type = Number }

	__Doc__[[the position at which new messages are added to the frame]]
	property "InsertMode" { Type = InsertMode }
endclass "MessageFrame"
