------------------------------------------------------
-- Author      : Kurapica
-- Create Date : 2012/06/28
-- ChangeLog

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.IFFont", version) then
	return
end

__Doc__[[IFFont is the interface for the font frames]]
__AutoProperty__()
interface "IFFont"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Returns the font instance's basic font properties</desc>
		<return type="filename">string, path to a font file (string)</return>
		<return type="fontHeight">number, height (point size) of the font to be displayed (in pixels) (number)</return>
		<return type="flags">string, additional properties for the font specified by one or more (separated by commas)</return>
	]]

	__Doc__[[
		<desc>Returns the Font object from which the font instance's properties are inherited</desc>
		<return type="System.Widget.Font">the Font object from which the font instance's properties are inherited, or nil if the font instance has no inherited properties</return>
	]]
	function GetFontObject(self)
		return IGAS:GetWrapper(self.__UI:GetFontObject())
	end

	__Doc__[[
		<desc>Returns the font instance's horizontal text alignment style</desc>
		<return type="System.Widget.JustifyHType"></return>
	]]

	__Doc__[[
		<desc>Returns the font instance's vertical text alignment style</desc>
		<return type="System.Widget.JustifyVType"></return>
	]]

	__Doc__[[
		<desc>Returns the color of the font's text shadow</desc>
		<return type="shadowR">number, Red component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowG">number, Green component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowB">number, Blue component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowAlpha">number, Alpha (opacity) of the text's shadow (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__[[
		<desc>Returns the offset of the font instance's text shadow from its text</desc>
		<return type="xOffset">number, Horizontal distance between the text and its shadow (in pixels)</return>
		<return type="yOffset">number, Vertical distance between the text and its shadow (in pixels)</return>
	]]

	__Doc__[[
		<desc>Returns the font instance's amount of spacing between lines</desc>
		<return type="number">amount of space between lines of text (in pixels)</return>
	]]

	__Doc__[[
		<desc>Returns the font instance's default text color</desc>
		<return type="textR">number, Red component of the text color (0.0 - 1.0)</return>
		<return type="textG">number, Green component of the text color (0.0 - 1.0)</return>
		<return type="textB">number, Blue component of the text color (0.0 - 1.0)</return>
		<return type="textAlpha">number, Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__[[
		<desc>Sets the font instance's basic font properties</desc>
		<param name="filename">string, path to a font file</param>
		<param name="fontHeight">number, height (point size) of the font to be displayed (in pixels)</param>
		<param name="flags">string, additional properties for the font specified by one or more (separated by commas) of the following tokens: MONOCHROME, OUTLINE, THICKOUTLINE</param>
		<return type="boolean">1 if filename refers to a valid font file; otherwise nil</return>
	]]

	__Doc__[[
		<desc>Sets the Font object from which the font instance's properties are inherited</desc>
		<format>fontObject|fontName</format>
		<param name="fontObject">System.Widget.Font, a font object</param>
		<param name="fontName">string, global font object's name</param>
	]]

	__Doc__[[
		<desc>Sets the font instance's horizontal text alignment style</desc>
		<param name="justifyH">System.Widget.JustifyHType</param>
	]]

	__Doc__[[
		<desc>Sets the font instance's vertical text alignment style</desc>
		<param name="justifyV">System.Widget.JustifyVType</param>
	]]

	__Doc__[[
		<desc>Sets the color of the font's text shadow</desc>
		<param name="shadowR">number, Red component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowG">number, Green component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowB">number, Blue component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowAlpha">number, Alpha (opacity) of the text's shadow (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__[[
		<desc>Sets the offset of the font instance's text shadow from its text</desc>
		<param name="xOffset">number, Horizontal distance between the text and its shadow (in pixels)</param>
		<param name="yOffset">number, Vertical distance between the text and its shadow (in pixels)</param>
	]]

	__Doc__[[
		<desc>Sets the font instance's amount of spacing between lines</desc>
		<param name="spacing">number, amount of space between lines of text (in pixels)</param>
	]]

	__Doc__[[
		<desc>Sets the font instance's default text color. This color is used for otherwise unformatted text displayed using the font instance</desc>
		<param name="textR">number, Red component of the text color (0.0 - 1.0)</param>
		<param name="textG">number, Green component of the text color (0.0 - 1.0)</param>
		<param name="textB">number, Blue component of the text color (0.0 - 1.0)</param>
		<param name="textAlpha">number, Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	------------------------------------------------------
	-- Property
	------------------------------------------------------
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
	property "FontObject" {
		Get = function(self)
			return self:GetFontObject()
		end,
		Set = function(self, fontObject)
			self:SetFontObject(fontObject)
		end,
		Type = FontObject,
	}

	__Doc__[[the fontstring's horizontal text alignment style]]
	property "JustifyH" {
		Get = function(self)
			return self:GetJustifyH()
		end,
		Set = function(self, justifyH)
			self:SetJustifyH(justifyH)
		end,
		Type = JustifyHType,
	}

	__Doc__[[the fontstring's vertical text alignment style]]
	property "JustifyV" {
		Get = function(self)
			return self:GetJustifyV()
		end,
		Set = function(self, justifyV)
			self:SetJustifyV(justifyV)
		end,
		Type = JustifyVType,
	}

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
	property "Spacing" {
		Get = function(self)
			return self:GetSpacing()
		end,
		Set = function(self, spacing)
			self:SetSpacing(spacing)
		end,
		Type = Number,
	}

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
endinterface "IFFont"
