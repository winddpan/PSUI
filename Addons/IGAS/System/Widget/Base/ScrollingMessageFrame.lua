-- Author      : Kurapica
-- Create Date : 7/16/2008 14:28
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 7
if not IGAS:NewAddon("IGAS.Widget.ScrollingMessageFrame", version) then
	return
end

__Doc__[[ScrollingMessageFrame expands on MessageFrame with the ability to store a much longer series of messages.]]
__AutoProperty__()
class "ScrollingMessageFrame"
	inherit "Frame"
	extend "IFFont"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the mouse clicks a hyperlink in the ScrollingMessageFrame</desc>
		<param name="linkData">string, essential data (linktype:linkdata portion) of the hyperlink (e.g. "quest:982:17")</param>
		<param name="link">string, complete hyperlink text (e.g. "|cffffff00|Hquest:982:17|h[Deep Ocean, Vast Sea]|h|r")</param>
		<param name="button">string, name of the mouse button responsible for the click action</param>
	]]
	__WidgetEvent__() event "OnHyperlinkClick"

	__Doc__[[
		<desc>Run when the mouse moves over a hyperlink in the ScrollingMessageFrame</desc>
		<param name="linkData">string, essential data (linktype:linkdata portion) of the hyperlink (e.g. "quest:982:17")</param>
		<param name="link">string, complete hyperlink text (e.g. "|cffffff00|Hquest:982:17|h[Deep Ocean, Vast Sea]|h|r")</param>
	]]
	__WidgetEvent__() event "OnHyperlinkEnter"

	__Doc__[[
		<desc>Run when the mouse moves away from a hyperlink in the ScrollingMessageFrame</desc>
		<param name="linkData">string, essential data (linktype:linkdata portion) of the hyperlink (e.g. "quest:982:17")</param>
		<param name="link">string, complete hyperlink text (e.g. "|cffffff00|Hquest:982:17|h[Deep Ocean, Vast Sea]|h|r")</param>
	]]
	__WidgetEvent__() event "OnHyperlinkLeave"

	__Doc__[[Run when the scrolling message frame's scroll position changes]]
	__WidgetEvent__() event "OnMessageScrollChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"AddMessage" [[
		<desc>Adds a message to those listed in the frame</desc>
		<param name="text">string, text of the message</param>
		<param name="red">number, red component of the text color for the message (0.0 - 1.0)</param>
		<param name="green">number, green component of the text color for the message (0.0 - 1.0)</param>
		<param name="blue">number, blue component of the text color for the message (0.0 - 1.0)</param>
		<param name="id">number, identifier for the message's type (see :UpdateColorByID())</param>
		<param name="addToTop">boolean, true to insert the message above all others listed in the frame, even if the frame's insert mode is set to BOTTOM; false to insert according to the frame's insert mode</param>
	]]

	__Doc__"AtBottom" [[
		<desc>Returns whether the message frame is currently scrolled to the bottom of its contents</desc>
		<return type="boolean">1 if the message frame is currently scrolled to the bottom of its contents; otherwise nil</return>
	]]

	__Doc__"AtTop" [[
		<desc>Returns whether the message frame is currently scrolled to the top of its contents</desc>
		<return type="boolean">1 if the message frame is currently scrolled to the top of its contents; otherwise nil</return>
	]]

	__Doc__"Clear" [[Removes all messages stored or displayed in the frame]]

	__Doc__"GetCurrentLine" [[
		<desc>Returns a number identifying the last message added to the frame. This number starts at 0 when the frame is created and increments with each message AddMessage to the frame; however, it resets to 0 when a message is added beyond the frame's GetMaxLines</desc>
		<return type="number">A number identifying the last message added to the frame</return>
	]]

	__Doc__"GetCurrentScroll" [[
		<desc>Returns the message frame's current scroll position</desc>
		<return type="number">Number of lines by which the frame is currently scrolled back from the end of its message history</return>
	]]

	__Doc__"GetFadeDuration" [[
		<desc>Returns the duration of the fade-out animation for disappearing messages. For the amount of time a message remains in the frame before beginning to fade</desc>
		<return type="number">Duration of the fade-out animation for disappearing messages (in seconds)</return>
	]]

	__Doc__"GetFading" [[
		<desc>Returns whether messages added to the frame automatically fade out after a period of time</desc>
		<return type="boolean">1 if messages added to the frame automatically fade out after a period of time; otherwise nil</return>
	]]

	__Doc__"GetHyperlinksEnabled" [[
		<desc>Returns whether hyperlinks in the frame's text are interactive</desc>
		<return type="boolean">1 if hyperlinks in the frame's text are interactive; otherwise nil</return>
	]]

	__Doc__"GetIndentedWordWrap" [[
		<desc>Returns whether long lines of text are indented when wrapping</desc>
		<return type="boolean">1 if long lines of text are indented when wrapping; otherwise nil</return>
	]]

	__Doc__"GetInsertMode" [[
		<desc>Returns the position at which new messages are added to the frame</desc>
		<return type="System.Widget.InsertMode">Token identifying the position at which new messages are added to the frame</return>
	]]

	__Doc__"GetMaxLines" [[
		<desc>Returns the maximum number of messages kept in the frame</desc>
		<return type="number">Maximum number of messages kept in the frame</return>
	]]

	__Doc__"GetMessageInfo" [[
		<desc>Return information about a previously added chat message.</desc>
		<format>index[, accessID]</format>
		<param name="index">Index of the message (between 1 and object:GetNumMessages(accessID)) for which information should be retrieved. Out of range values will non-silently fail</param>
		<param name="accessID">If specified, only messages for this accessID are included in the index count</param>
		<return type="text">string, the line's displayed text.</return>
		<return type="accessID">number, accessID for the message. For chat frames, can be passed to ChatHistory_GetChatType(accessID) to determine the message's chat type.</return>
		<return type="lineID">number, arg5 to object:AddMessage(). For default chat frames, is always zero as of 4.3.4 live. Instead, the lineID is embedded into the message text's player link.</return>
		<return type="extraData">number, arg8 to object:AddMessage(). Unknown use in the chat frames.</return>
	]]

	__Doc__"GetNumLinesDisplayed" [[
		<desc>Returns the number of lines displayed in the message frame. This number reflects the list of messages currently displayed, not including those which are stored for display if the frame is scrolled.</desc>
		<return type="number">Number of messages currently displayed in the frame.</return>
	]]

	__Doc__"GetNumMessages" [[
		<desc>Returns the number of messages currently kept in the frame's message history. This number reflects the list of messages which can be seen by scrolling the frame, including (but not limited to) the list of messages currently displayed.</desc>
		<return type="number">Number of messages currently kept in the frame's message history</return>
	]]

	__Doc__"GetTimeVisible" [[
		<desc>Returns the amount of time for which a message remains visible before beginning to fade out</desc>
		<return type="number">Amount of time for which a message remains visible before beginning to fade out (in seconds)</return>
	]]

	__Doc__"PageDown" [[Scrolls the message frame's contents down by one page. One "page" is slightly less than the number of lines displayed in the frame.]]

	__Doc__"PageUp" [[Scrolls the message frame's contents up by one page. One "page" is slightly less than the number of lines displayed in the frame.]]

	__Doc__"RemoveMessagesByAccessID" [[
		<desc>Remove message by accessID</desc>
		<param name="accessID"></param>
	]]

	__Doc__"ScrollDown" [[Scrolls the message frame's contents down by two lines]]

	__Doc__"ScrollToBottom" [[Scrolls to the bottom of the message frame's contents]]

	__Doc__"ScrollToTop" [[Scrolls to the top of the message frame's contents]]

	__Doc__"ScrollUp" [[Scrolls the message frame's contents up by two lines]]

	__Doc__"SetFadeDuration" [[
		<desc>Sets the duration of the fade-out animation for disappearing messages. For the amount of time a message remains in the frame before beginning to fade.</desc>
		<param name="duration">number, duration of the fade-out animation for disappearing messages (in seconds)</param>
	]]

	__Doc__"SetFading" [[
		<desc>Sets whether messages added to the frame automatically fade out after a period of time</desc>
		<param name="fading">boolean, true to cause messages added to the frame to automatically fade out after a period of time; false to leave message visible</param>
	]]

	__Doc__"SetHyperlinksEnabled" [[
		<desc>Enables or disables hyperlink interactivity in the frame. The frame's hyperlink-related script handlers will only be run if hyperlinks are enabled.</desc>
		<param name="enable">boolean, true to enable hyperlink interactivity in the frame; false to disable</param>
	]]

	__Doc__"SetIndentedWordWrap" [[
		<desc>Sets whether long lines of text are indented when wrapping</desc>
		<param name="indent">boolean, true to indent wrapped lines of text; false otherwise</param>
	]]

	__Doc__"SetInsertMode" [[
		<desc>Sets the position at which new messages are added to the frame</desc>
		<param name="position">System.Widget.InsertMode, token identifying the position at which new messages should be added to the frame</param>
	]]

	__Doc__"SetMaxLines" [[
		<desc>Sets the maximum number of messages to be kept in the frame. If additional messages are added beyond this number, the oldest lines are discarded and can no longer be seen by scrolling.</desc>
		<param name="maxLines">number, maximum number of messages to be kept in the frame</param>
	]]

	__Doc__"SetScrollOffset" [[
		<desc>Sets the message frame's scroll position</desc>
		@param  offset number, number of lines to scroll back from the end of the frame's message history
	]]

	__Doc__"SetTimeVisible" [[
		<desc>Sets the amount of time for which a message remains visible before beginning to fade out.</desc>
		<param name="duration">number, amount of time for which a message remains visible before beginning to fade out (in seconds)</param>
	]]

	__Doc__"UpdateColorByID" [[
		<desc>Updates the color of a set of messages already added to the frame. Used in the default UI to allow customization of chat window message colors by type: each type of chat window message (party, raid, emote, system message, etc.) has a numeric identifier found in the global table ChatTypeInfo; this is passed as the fifth argument to :AddMessage() when messages are added to the frame, allowing them to be identified for recoloring via this method.</desc>
		<param name="id"> number, Identifier for a message's type (as set when the messages were added to the frame)</param>
		<param name="red"> number, Red component of the new text color (0.0 - 1.0)</param>
		<param name="green"> number, Green component of the new text color (0.0 - 1.0)</param>
		<param name="blue"> number, Blue component of the new text color (0.0 - 1.0)</param>
	]]

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("ScrollingMessageFrame", nil, parent, ...)
	end
endclass "ScrollingMessageFrame"

class "ScrollingMessageFrame"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(ScrollingMessageFrame)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[whether messages added to the frame automatically fade out after a period of time]]
	property "Fading" { Type = Boolean }

	__Doc__[[whether hyperlinks in the frame's text are interactive]]
	property "HyperlinksEnabled" { Type = Boolean }

	__Doc__[[the amount of time for which a message remains visible before beginning to fade out]]
	property "TimeVisible" { Type = Number }

	__Doc__[[the duration of the fade-out animation for disappearing messages]]
	property "FadeDuration" { Type = Number }

	__Doc__[[the position at which new messages are added to the frame]]
	property "InsertMode" { Type = InsertMode }

	__Doc__[[the maximum number of messages to be kept in the frame]]
	property "MaxLines" { Type = Number }
endclass "ScrollingMessageFrame"
