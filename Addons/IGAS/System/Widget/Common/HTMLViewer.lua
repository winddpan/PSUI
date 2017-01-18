-- Author      : Kurapica
-- Create Date : 2012/12/2
-- Change Log  :

-- Check Version
local version = 2

if not IGAS:NewAddon("IGAS.Widget.HTMLViewer", version) then
	return
end

__Doc__[[HTMLViewer is used to view simple html]]
__AutoProperty__()
class "HTMLViewer"
	inherit "ScrollForm"

	------------------------------------------------------
	-- Translate
	------------------------------------------------------
	_HTML_Color_Stack = {}

	local function ParseColorToken(token, isEnd, args)
		if isEnd then
			local last
			for i = #_HTML_Color_Stack, 1, -1 do
				last = tremove(_HTML_Color_Stack)
				if last == token then
					if i > 1 then
						return FontColor[_HTML_Color_Stack[i-1]] or FontColor.NORMAL
					else
						return FontColor.CLOSE
					end
				end
			end
			return ""
		else
			tinsert(_HTML_Color_Stack, token)
			if FontColor[token] then
				return FontColor[token]
			else
				return FontColor.NORMAL
			end
		end
	end

	------------------------------------------------------
	-- Tokens
	------------------------------------------------------
	_HTML_TOKEN_MAP = {}

	------------------------------------------------------
	--- Colors : <red>some text</red>
	------------------------------------------------------
	for colorname in Reflector.GetEnums(FontColor) do
		colorname = colorname:lower()

		if colorname ~= "close" then
			_HTML_TOKEN_MAP[colorname] = ParseColorToken
		end
	end

	------------------------------------------------------
	-- Parse Html
	------------------------------------------------------
	local function ParseToken(set)
		if set and set:len() >= 3 then
			if set:sub(2, 2) == "/" then
			local token = set:match("</(%w+)")

				if token and _HTML_TOKEN_MAP[token:lower()] then
					return _HTML_TOKEN_MAP[token:lower()](token:lower(), true)
				else
					return set
				end
			else
				local token, args = set:match("<(%w+)%s*(.*)>")

				if token and _HTML_TOKEN_MAP[token:lower()] then
					return _HTML_TOKEN_MAP[token:lower()](token:lower(), false, args)
				else
					return set
				end
			end
		else
			return set
		end
	end

	local function ParseHTML(text)
		wipe(_HTML_Color_Stack)

		if type(text) == "string" and text ~= "" then
			text = text:gsub("<.->", ParseToken)
		else
			text = ""
		end
		return text
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when the mouse clicks a hyperlink in the SimpleHTML frame</desc>
		<param name="linkData">string, essential data (linktype:linkdata portion) of the hyperlink (e.g. "quest:982:17")</param>
		<param name="link">string, complete hyperlink text (e.g. "|cffffff00|Hquest:982:17|h[Deep Ocean, Vast Sea]|h|r")</param>
		<param name="button">string, name of the mouse button responsible for the click action</param>
	]]
	event "OnHyperlinkClick"

	__Doc__[[
		<desc>Run when the mouse moves over a hyperlink in the SimpleHTML frame</desc>
		<param name="linkData">string, essential data (linktype:linkdata portion) of the hyperlink (e.g. "quest:982:17")</param>
		<param name="link">string, complete hyperlink text (e.g. "|cffffff00|Hquest:982:17|h[Deep Ocean, Vast Sea]|h|r")</param>
	]]
	event "OnHyperlinkEnter"

	__Doc__[[
		<desc>Run when the mouse moves away from a hyperlink in the SimpleHTML frame</desc>
		<param name="linkData">string, essential data (linktype:linkdata portion) of the hyperlink (e.g. "quest:982:17")</param>
		<param name="link">string, complete hyperlink text (e.g. "|cffffff00|Hquest:982:17|h[Deep Ocean, Vast Sea]|h|r")</param>
	]]
	event "OnHyperlinkLeave"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Returns basic properties of a font used in the frame</desc>
		<param name="element">Optional,Name of an HTML element (e.g. p, h1); if omitted, returns information about the frame's default</param>
		<return type="filename">string, Path to a font file (string)</return>
		<return type="fontHeight">number, Height (point size) of the font to be displayed (in pixels) (number)</return>
		<return type="flags">string, Additional properties for the font specified by one or more (separated by commas) of the following tokens: (string)</return>
	]]
	function GetFont(self, ...)
		return self.__HTMLViewer:GetFont(...)
	end

	__Doc__[[
		<desc>Returns the Font object from which the properties of a font used in the frame are inherited</desc>
		<param name="element">string, name of an HTML element (e.g. p, h1); if omitted, returns information about the frame's default</param>
		<return type="System.Widget.Font">the Font object from which font properties are inherited, or nil if no properties are inherited</return>
	]]
	function GetFontObject(self, ...)
		return self.__HTMLViewer:GetFontObject(...)
	end

	__Doc__[[
		<desc>Returns the format string used for displaying hyperlinks in the frame</desc>
		<return type="string">Format string used for displaying hyperlinks in the frame</param>
	]]
	function GetHyperlinkFormat(self, ...)
		return self.__HTMLViewer:GetHyperlinkFormat(...)
	end

	__Doc__[[
		<desc>Returns whether hyperlinks in the frame's text are interactive</desc>
		<return type="boolean">1 if hyperlinks in the frame's text are interactive; otherwise nil</return>
	]]
	function GetHyperlinksEnabled(self, ...)
		return self.__HTMLViewer:GetHyperlinksEnabled(...)
	end

	__Doc__[[
		<desc>Returns whether long lines of text are indented when wrapping</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="boolean">1 if long lines of text are indented when wrapping; otherwise nil</return>
	]]
	function GetIndentedWordWrap(self, ...)
		return self.__HTMLViewer:GetIndentedWordWrap(...)
	end

	__Doc__[[
		<desc>Returns the horizontal alignment style for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="System.Widget.JustifyHType">horizontal text alignment style</return>
	]]
	function GetJustifyH(self, ...)
		return self.__HTMLViewer:GetJustifyH(...)
	end

	__Doc__[[
		<desc>Returns the vertical alignment style for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="System.Widget.JustifyVType">vertical text alignment style</return>
	]]
	function GetJustifyV(self, ...)
		return self.__HTMLViewer:GetJustifyV(...)
	end

	__Doc__[[
		<desc>Returns the shadow color for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="shadowR">number, Red component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowG">number, Green component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowB">number, Blue component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowAlpha">number, Alpha (opacity) of the text's shadow (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]
	function GetShadowColor(self, ...)
		return self.__HTMLViewer:GetShadowColor(...)
	end

	__Doc__[[
		<desc>Returns the offset of text shadow from text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="xOffset">number, Horizontal distance between the text and its shadow (in pixels)</return>
		<return type="yOffset">number, Vertical distance between the text and its shadow (in pixels)</return>
	]]
	function GetShadowOffset(self, ...)
		return self.__HTMLViewer:GetShadowOffset(...)
	end

	__Doc__[[
		<desc>Returns the amount of spacing between lines of text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="number">amount of space between lines of text (in pixels)</return>
	]]
	function GetSpacing(self, ...)
		return self.__HTMLViewer:GetSpacing(...)
	end

	__Doc__[[
		<desc>Returns the color of text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<return type="textR">number, Red component of the text color (0.0 - 1.0)</return>
		<return type="textG">number, Green component of the text color (0.0 - 1.0)</return>
		<return type="textB">number, Blue component of the text color (0.0 - 1.0)</return>
		<return type="textAlpha">number, Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]
	function GetTextColor(self, ...)
		return self.__HTMLViewer:GetTextColor(...)
	end

	__Doc__[[
		<desc>Sets the font instance's basic font properties</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="filename">string, path to a font file</param>
		<param name="fontHeight">number, height (point size) of the font to be displayed (in pixels)</param>
		<param name="flags">string, additional properties for the font specified by one or more (separated by commas) of the following tokens: MONOCHROME, OUTLINE, THICKOUTLINE</param>
		<return type="boolean">1 if filename refers to a valid font file; otherwise nil</return>
	]]
	function SetFont(self, ...)
		return self.__HTMLViewer:SetFont(...)
	end

	__Doc__[[
		<desc>Sets the Font object from which the font instance's properties are inherited</desc>
		<format>[element, ]fontObject|fontName</format>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="fontObject">System.Widget.Font, a font object</param>
		<param name="fontName">string, global font object's name</param>
	]]
	function SetFontObject(self, ...)
		return self.__HTMLViewer:SetFontObject(...)
	end

	__Doc__[[
		<desc>Sets the format string used for displaying hyperlinks in the frame</desc>
		<param name="format">string, format string used for displaying hyperlinks in the frame</param>
	]]
	function SetHyperlinkFormat(self, ...)
		return self.__HTMLViewer:SetHyperlinkFormat(...)
	end

	__Doc__[[
		<desc>Enables or disables hyperlink interactivity in the frame</desc>
		<param name="enable">boolean, true to enable hyperlink interactivity in the frame; false to disable</param>
	]]
	function SetHyperlinksEnabled(self, ...)
		return self.__HTMLViewer:SetHyperlinksEnabled(...)
	end

	__Doc__[[
		<desc>Sets whether long lines of text are indented when wrapping</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="indent">boolean, true to indent wrapped lines of text; false otherwise</param>
	]]
	function SetIndentedWordWrap(self, ...)
		return self.__HTMLViewer:SetIndentedWordWrap(...)
	end

	__Doc__[[
		<desc>Sets the horizontal alignment style for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="justifyH">System.Widget.JustifyHType</param>
	]]
	function SetJustifyH(self, ...)
		return self.__HTMLViewer:SetJustifyH(...)
	end


	__Doc__[[
		<desc>Sets the vertical alignment style for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="justifyV">System.Widget.JustifyVType</param>
	]]
	function SetJustifyV(self, ...)
		return self.__HTMLViewer:SetJustifyV(...)
	end

	__Doc__[[
		<desc>Sets the shadow color for text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="shadowR">number, Red component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowG">number, Green component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowB">number, Blue component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowAlpha">number, Alpha (opacity) of the text's shadow (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]
	function SetShadowColor(self, ...)
		return self.__HTMLViewer:SetShadowColor(...)
	end

	__Doc__[[
		<desc>Sets the offset of text shadow from text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="xOffset">number, Horizontal distance between the text and its shadow (in pixels)</param>
		<param name="yOffset">number, Vertical distance between the text and its shadow (in pixels)</param>
	]]
	function SetShadowOffset(self, ...)
		return self.__HTMLViewer:SetShadowOffset(...)
	end

	__Doc__[[
		<desc>Sets the amount of spacing between lines of text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="spacing">number, amount of space between lines of text (in pixels)</param>
	]]
	function SetSpacing(self, ...)
		return self.__HTMLViewer:SetSpacing(...)
	end

	__Doc__[[
		<desc>
			For HTML formatting, the entire text must be enclosed in &lt;html&gt;&lt;body&gt; and &lt;/body&gt;&lt;/html&gt; tags.
			All tags must be closed (img and br must use self-closing syntax; e.g. &lt;br/&gt;, not &lt;br &gt;).
			Tags are case insensitive, but closing tags must match the case of opening tags.
			Attribute values must be enclosed in single or double quotation marks (" or ').
			Characters occurring in HTML markup must be entity-escaped (&amp;quot; &amp;lt; &amp;gt; &amp;amp;); no other entity-escapes are supported.
			Unrecognized tags and their contents are ignored (e.g. given &lt;h1&gt;&lt;foo&gt;bar&lt;/foo&gt;baz&lt;/h1&gt;, only "baz" will appear).
			Any HTML parsing error will result in the raw HTML markup being displayed.
			Only the following tags and attributes are supported:

			p, h1, h2, h3 - Block elements; e.g. &lt;p align="left"&gt;

			align - Text alignment style (optional); allowed values are left, center, and right.
			img - Image; may only be used as a block element (not inline with text); e.g. &lt;img src="Interface\Icons\INV_Misc_Rune_01" /&gt;.

			src - Path to the image file (filename extension omitted).
			align - Alignment of the image block in the frame (optional); allowed values are left, center, and right.
			width - Width at which to display the image (in pixels; optional).
			height - Height at which to display the image (in pixels; optional).
			a - Inline hyperlink; e.g. &lt;a href="aLink"&gt;text&lt;/a&gt;

			href - String identifying the link; passed as argument to hyperlink-related scripts when the player interacts with the link.
			br - Explicit line break in text; e.g. &lt;br /&gt;.
		</desc>
		<param name="text">string, text(with HTML markup) to be displayed</param>
	]]
	function SetText(self, text)
		self.__HTMLContent = text
		self.__HTMLViewer:SetText(ParseHTML(text))
		self.Value = 0
	end

	__Doc__[[
		<desc>Gets the contents of the htmlViewer</desc>
		<return type="string"></return>
	]]
	function GetText(self)
		return self.__HTMLContent
	end

	__Doc__[[
		<desc>Sets the color of text in the frame</desc>
		<param name="element">string, name of an HTML element for which to return text style information (e.g. p, h1); if omitted, returns information about the frame's default text style</param>
		<param name="textR">number, Red component of the text color (0.0 - 1.0)</param>
		<param name="textG">number, Green component of the text color (0.0 - 1.0)</param>
		<param name="textB">number, Blue component of the text color (0.0 - 1.0)</param>
		<param name="textAlpha">number, Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]
	function SetTextColor(self, ...)
		return self.__HTMLViewer:SetTextColor(...)
	end

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

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnHyperlinkClick(self, linkData, link, button)
		return self.Parent:Fire("OnHyperlinkClick", linkData, link, button)
	end

	local function OnHyperlinkEnter(self, linkData, link)
		return self.Parent:Fire("OnHyperlinkEnter", linkData, link)
	end

	local function OnHyperlinkLeave(self, linkData, link)
		return self.Parent:Fire("OnHyperlinkLeave", linkData, link)
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function HTMLViewer(self, name, parent, ...)
    	Super(self, name, parent, ...)

		local html = SimpleHTML("HTMLViewer", self)
		self.ScrollChild = html

		html:SetFontObject("GameFontNormal")
		html.HyperlinksEnabled = true
		html:SetHyperlinkFormat("|cff00FF00|H%s|h%s|h|r")
		html:SetTextColor(1, 1, 1)

		self.__HTMLViewer = html

		html.OnHyperlinkClick = html.OnHyperlinkClick + OnHyperlinkClick
		html.OnHyperlinkEnter = html.OnHyperlinkEnter + OnHyperlinkEnter
		html.OnHyperlinkLeave = html.OnHyperlinkLeave + OnHyperlinkLeave
	end
endclass "HTMLViewer"
