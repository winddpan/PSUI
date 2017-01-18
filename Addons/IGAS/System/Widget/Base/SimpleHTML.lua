-- Author      : Kurapica
-- Create Date : 7/16/2008 14:36
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.SimpleHTML", version) then
	return
end

__Doc__[[The most sophisticated control over text display is offered by SimpleHTML widgets. When its text is set to a string containing valid HTML markup, a SimpleHTML widget will parse the content into its various blocks and sections, and lay the text out. While it supports most common text commands, a SimpleHTML widget accepts an additional argument to most of these; if provided, the element argument will specify the HTML elements to which the new style information should apply, such as formattedText:SetTextColor("h2", 1, 0.3, 0.1) which will cause all level 2 headers to display in red. If no element name is specified, the settings apply to the SimpleHTML widget's default font.]]
__AutoProperty__()
class "SimpleHTML"
	inherit "Frame"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the mouse clicks a hyperlink in the SimpleHTML frame</desc>
		<param name="linkData">string, essential data (linktype:linkdata portion) of the hyperlink (e.g. "quest:982:17")</param>
		<param name="link">string, complete hyperlink text (e.g. "|cffffff00|Hquest:982:17|h[Deep Ocean, Vast Sea]|h|r")</param>
		<param name="button">string, name of the mouse button responsible for the click action</param>
	]]
	__WidgetEvent__() event "OnHyperlinkClick"

	__Doc__[[
		<desc>Run when the mouse moves over a hyperlink in the SimpleHTML frame</desc>
		<param name="linkData">string, essential data (linktype:linkdata portion) of the hyperlink (e.g. "quest:982:17")</param>
		<param name="link">string, complete hyperlink text (e.g. "|cffffff00|Hquest:982:17|h[Deep Ocean, Vast Sea]|h|r")</param>
	]]
	__WidgetEvent__() event "OnHyperlinkEnter"

	__Doc__[[
		<desc>Run when the mouse moves away from a hyperlink in the SimpleHTML frame</desc>
		<param name="linkData">string, essential data (linktype:linkdata portion) of the hyperlink (e.g. "quest:982:17")</param>
		<param name="link">string, complete hyperlink text (e.g. "|cffffff00|Hquest:982:17|h[Deep Ocean, Vast Sea]|h|r")</param>
	]]
	__WidgetEvent__() event "OnHyperlinkLeave"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetFont" [[
		<desc>Returns basic properties of a font used in the frame</desc>
		<param name="element">Optional,Name of an HTML element (e.g. p, h1); if omitted, returns information about the frame's default</param>
		<return type="filename">string, Path to a font file (string)</return>
		<return type="fontHeight">number, Height (point size) of the font to be displayed (in pixels) (number)</return>
		<return type="flags">string, Additional properties for the font specified by one or more (separated by commas) of the following tokens: (string)</return>
	]]

	__Doc__[[
		<desc>Returns the Font object from which the properties of a font used in the frame are inherited</desc>
		<param name="element">string, name of an HTML element (e.g. p, h1); if omitted, returns information about the frame's default</param>
		<return type="System.Widget.Font">the Font object from which font properties are inherited, or nil if no properties are inherited</return>
	]]
	function GetFontObject(self, ...)
		return IGAS:GetWrapper(self.__UI:GetFontObject(...))
	end

	__Doc__"GetHyperlinkFormat" [[
		<desc>Returns the format string used for displaying hyperlinks in the frame</desc>
		<param name="format">string, Format string used for displaying hyperlinks in the frame</param>
	]]

	__Doc__"GetHyperlinksEnabled" [[
		<desc>Returns whether hyperlinks in the frame's text are interactive</desc>
		<return type="boolean">1 if hyperlinks in the frame's text are interactive; otherwise nil</return>
	]]

	__Doc__"GetIndentedWordWrap" [[
		<desc>Returns whether long lines of text are indented when wrapping</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="boolean">1 if long lines of text are indented when wrapping; otherwise nil</return>
	]]

	__Doc__"GetJustifyH" [[
		<desc>Returns the horizontal alignment style for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="System.Widget.JustifyHType">horizontal text alignment style</return>
	]]


	__Doc__"GetJustifyV" [[
		<desc>Returns the vertical alignment style for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="System.Widget.JustifyVType">vertical text alignment style</return>
	]]

	__Doc__"GetShadowColor" [[
		<desc>Returns the shadow color for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="shadowR">number, Red component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowG">number, Green component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowB">number, Blue component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowAlpha">number, Alpha (opacity) of the text's shadow (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__"GetShadowOffset" [[
		<desc>Returns the offset of text shadow from text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="xOffset">number, Horizontal distance between the text and its shadow (in pixels)</return>
		<return type="yOffset">number, Vertical distance between the text and its shadow (in pixels)</return>
	]]

	__Doc__"GetSpacing" [[
		<desc>Returns the amount of spacing between lines of text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="number">amount of space between lines of text (in pixels)</return>
	]]

	__Doc__"GetTextColor" [[
		<desc>Returns the color of text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="textR">number, Red component of the text color (0.0 - 1.0)</return>
		<return type="textG">number, Green component of the text color (0.0 - 1.0)</return>
		<return type="textB">number, Blue component of the text color (0.0 - 1.0)</return>
		<return type="textAlpha">number, Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__"SetFont" [[
		<desc>Sets the font instance's basic font properties</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="filename">string, path to a font file</param>
		<param name="fontHeight">number, height (point size) of the font to be displayed (in pixels)</param>
		<param name="flags">string, additional properties for the font specified by one or more (separated by commas) of the following tokens: MONOCHROME, OUTLINE, THICKOUTLINE</param>
		<return type="boolean">1 if filename refers to a valid font file; otherwise nil</return>
	]]

	__Doc__"SetFontObject" [[
		<desc>Sets the Font object from which the font instance's properties are inherited</desc>
		<format>[element, ]fontObject|fontName</format>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="fontObject">System.Widget.Font, a font object</param>
		<param name="fontName">string, global font object's name</param>
	]]

	__Doc__"SetHyperlinkFormat" [[
		<desc>Sets the format string used for displaying hyperlinks in the frame</desc>
		<param name="format">string, format string used for displaying hyperlinks in the frame</param>
	]]

	__Doc__"SetHyperlinksEnabled" [[
		<desc>Enables or disables hyperlink interactivity in the frame</desc>
		<param name="enable">boolean, true to enable hyperlink interactivity in the frame; false to disable</param>
	]]

	__Doc__"SetIndentedWordWrap" [[
		<desc>Sets whether long lines of text are indented when wrapping</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="indent">boolean, true to indent wrapped lines of text; false otherwise</param>
	]]

	__Doc__"SetJustifyH" [[
		<desc>Sets the horizontal alignment style for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="justifyH">System.Widget.JustifyHType</param>
	]]

	__Doc__"SetJustifyV" [[
		<desc>Sets the vertical alignment style for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="justifyV">System.Widget.JustifyVType</param>
	]]

	__Doc__"SetShadowColor" [[
		<desc>Sets the shadow color for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="shadowR">number, Red component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowG">number, Green component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowB">number, Blue component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowAlpha">number, Alpha (opacity) of the text's shadow (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__"SetShadowOffset" [[
		<desc>Sets the offset of text shadow from text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="xOffset">number, Horizontal distance between the text and its shadow (in pixels)</param>
		<param name="yOffset">number, Vertical distance between the text and its shadow (in pixels)</param>
	]]

	__Doc__"SetSpacing" [[
		<desc>Sets the amount of spacing between lines of text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="spacing">number, amount of space between lines of text (in pixels)</param>
	]]

	__Doc__"SetText" [[
		<desc>For HTML formatting, the entire text must be enclosed in &lt;html&gt;&lt;body&gt; and &lt;/body&gt;&lt;/html&gt; tags.</desc>
		<br>All tags must be closed (img and br must use self-closing syntax; e.g. &lt;br/&gt;, not &lt;br &gt;).
		<br>Tags are case insensitive, but closing tags must match the case of opening tags.
		<br>Attribute values must be enclosed in single or double quotation marks (" or ').
		<br>Characters occurring in HTML markup must be entity-escaped (&amp;quot; &amp;lt; &amp;gt; &amp;amp;); no other entity-escapes are supported.
		<br>Unrecognized tags and their contents are ignored (e.g. given &lt;h1&gt;&lt;foo&gt;bar&lt;/foo&gt;baz&lt;/h1&gt;, only "baz" will appear).
		<br>Any HTML parsing error will result in the raw HTML markup being displayed.
		<br>Only the following tags and attributes are supported:
		<br>
		<br>p, h1, h2, h3 - Block elements; e.g. &lt;p align="left"&gt;
		<br>
		<br>align - Text alignment style (optional); allowed values are left, center, and right.
		<br>img - Image; may only be used as a block element (not inline with text); e.g. &lt;img src="Interface\Icons\INV_Misc_Rune_01" /&gt;.
		<br>
		<br>src - Path to the image file (filename extension omitted).
		<br>align - Alignment of the image block in the frame (optional); allowed values are left, center, and right.
		<br>width - Width at which to display the image (in pixels; optional).
		<br>height - Height at which to display the image (in pixels; optional).
		<br>a - Inline hyperlink; e.g. &lt;a href="aLink"&gt;text&lt;/a&gt;
		<br>
		<br>href - String identifying the link; passed as argument to hyperlink-related scripts when the player interacts with the link.
		<br>br - Explicit line break in text; e.g. &lt;br /&gt;.
		<br>
		<br>
		<param name="text">string, text(with HTML markup) to be displayed</param>
	]]

	__Doc__"SetTextColor" [[
		<desc>Sets the color of text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="textR">number, Red component of the text color (0.0 - 1.0)</param>
		<param name="textG">number, Green component of the text color (0.0 - 1.0)</param>
		<param name="textB">number, Blue component of the text color (0.0 - 1.0)</param>
		<param name="textAlpha">number, Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("SimpleHTML", nil, parent, ...)
	end
endclass "SimpleHTML"

class "SimpleHTML"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(SimpleHTML)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the format string used for displaying hyperlinks in the frame]]
	property "HyperlinkFormat" { Type = String }

	__Doc__[[Whether hyperlinks in the frame's text are interactive]]
	property "HyperlinksEnabled" { Type = Boolean }

	__Doc__[[whether long lines of text are indented when wrapping]]
	property "IndentedWordWrap" { Type = Boolean }

	__Doc__[[The content of the html viewer]]
	property "Text" { Type = String }

	__Doc__[[the font's defined table, contains font path, height and flags' settings]]
	property "Font" {
		Get = function(self)
			local font = {}
			local flags

			font.path, font.height, flags = self:GetFont()
			flags = (flags or ""):upper()
			if flags:find("THICKOUTLINE") then
				font.outline = "THICK"
			elseif flags:find("OUTLINE") then
				font.outline = "NORMAL"
			else
				font.outline = "NONE"
			end
			if flags:find("MONOCHROME") then
				font.monochrome = true
			end

			return font
		end,
		Set = function(self, font)
			local flags = ""
			if font.outline then
				if font.outline == "NORMAL" then
					flags = flags.."OUTLINE"
				elseif font.outline == "THICK" then
					flags = flags.."THICKOUTLINE"
				end
			end
			if font.monochrome then
				if flags ~= "" then
					flags = flags..","
				end
				flags = flags.."MONOCHROME"
			end

			self:SetFont(font.path, font.height, flags)
		end,
		Type = FontType,
	}

	__Doc__[[the Font object]]
	property "FontObject" { Type = FontObject }

	__Doc__[[the fontstring's horizontal text alignment style]]
	property "JustifyH" { Type = JustifyHType }

	__Doc__[[the fontstring's vertical text alignment style]]
	property "JustifyV" { Type = JustifyVType }

	__Doc__[[the color of the font's text shadow]]
	property "ShadowColor" {
		Get = function(self)
			return ColorType(self:GetShadowColor())
		end,
		Set = function(self, color)
			self:SetShadowColor(color.r, color.g, color.b, color.a)
		end,
		Type = ColorType,
	}

	__Doc__[[the offset of the fontstring's text shadow from its text]]
	property "ShadowOffset" {
		Get = function(self)
			return Dimension(self:GetShadowOffset())
		end,
		Set = function(self, offset)
			self:SetShadowOffset(offset.x, offset.y)
		end,
		Type = Dimension,
	}

	__Doc__[[the fontstring's amount of spacing between lines]]
	property "Spacing" { Type = Number }

	__Doc__[[the fontstring's default text color]]
	property "TextColor" {
		Get = function(self)
			return ColorType(self:GetTextColor())
		end,
		Set = function(self, color)
			self:SetTextColor(color.r, color.g, color.b, color.a)
		end,
		Type = ColorType,
	}

	class "Element"
		--------------------------------------------------
		-- Property
		--------------------------------------------------
		__Doc__[[The owner of the element]]
		property "Owner" { Type = HTMLViewer }

		__Doc__[[The target element in the html like 'h2']]
		property "Element" { Type = String }

		__Doc__[[whether long lines of text are indented when wrapping]]
		property "IndentedWordWrap" {
			Get = function (self)
				return self.Owner:GetIndentedWordWrap(self.Element)
			end,
			Set = function (self, value)
				self.Owner:SetIndentedWordWrap(self.Element, value)
			end,
			Type = Boolean,
		}

		__Doc__[[the font's defined table, contains font path, height and flags' settings]]
		property "Font" {
			Get = function(self)
				local font = {}
				local flags

				font.path, font.height, flags = self.Owner:GetFont(self.Element)
				flags = (flags or ""):upper()
				if flags:find("THICKOUTLINE") then
					font.outline = "THICK"
				elseif flags:find("OUTLINE") then
					font.outline = "NORMAL"
				else
					font.outline = "NONE"
				end
				if flags:find("MONOCHROME") then
					font.monochrome = true
				end

				return font
			end,
			Set = function(self, font)
				local flags = ""
				if font.outline then
					if font.outline == "NORMAL" then
						flags = flags.."OUTLINE"
					elseif font.outline == "THICK" then
						flags = flags.."THICKOUTLINE"
					end
				end
				if font.monochrome then
					if flags ~= "" then
						flags = flags..","
					end
					flags = flags.."MONOCHROME"
				end

				self.Owner:SetFont(self.Element, font.path, font.height, flags)
			end,
			Type = FontType,
		}

		__Doc__[[the Font object]]
		property "FontObject" {
			Get = function (self)
				return self.Owner:GetFontObject(self.Element)
			end,
			Set = function (self, obj)
				self.Owner:SetFontObject(self.Element, obj)
			end,
			Type = FontObject,
		}

		__Doc__[[the fontstring's horizontal text alignment style]]
		property "JustifyH" {
			Get = function (self)
				return self.Owner:GetJustifyH(self.Element)
			end,
			Set = function (self, value)
				self.Owner:SetJustifyH(self.Element, value)
			end,
			Type = JustifyHType,
		}

		__Doc__[[the fontstring's vertical text alignment style]]
		property "JustifyV" {
			Get = function (self)
				return self.Owner:GetJustifyV(self.Element)
			end,
			Set = function (self, value)
				self.Owner:SetJustifyV(self.Element, value)
			end,
			Type = JustifyVType,
		}

		__Doc__[[the color of the font's text shadow]]
		property "ShadowColor" {
			Get = function(self)
				return ColorType(self.Owner:GetShadowColor(self.Element))
			end,
			Set = function(self, color)
				self.Owner:SetShadowColor(self.Element, color.r, color.g, color.b, color.a)
			end,
			Type = ColorType,
		}

		__Doc__[[the offset of the fontstring's text shadow from its text]]
		property "ShadowOffset" {
			Get = function(self)
				return Dimension(self.Owner:GetShadowOffset(self.Element))
			end,
			Set = function(self, offset)
				self.Owner:SetShadowOffset(self.Element, offset.x, offset.y)
			end,
			Type = Dimension,
		}

		__Doc__[[the fontstring's amount of spacing between lines]]
		property "Spacing" {
			Get = function (self)
				return self.Owner:GetSpacing(self.Element)
			end,
			Set = function (self, value)
				self.Owner:SetSpacing(self.Element, value)
			end,
			Type = Number,
		}

		__Doc__[[the fontstring's default text color]]
		property "TextColor" {
			Get = function(self)
				return ColorType(self.Owner:GetTextColor(self.Element))
			end,
			Set = function(self, color)
				self.Owner:SetTextColor(self.Element, color.r, color.g, color.b, color.a)
			end,
			Type = ColorType,
		}

		--------------------------------------------------
		-- Meta-method
		--------------------------------------------------
		function __index(self, key)
			self.Element = key
			return self
		end

		__call = __index
	endclass "Element"

	__Doc__[[The element accessor]]
	property "Element" {
		Get = function (self)
			local ele = self.__Element
			if not ele then
				ele = Element { Owner = self }
				self.__Element = ele
			end
			return ele
		end,
		Type = Element
	}
endclass "SimpleHTML"
