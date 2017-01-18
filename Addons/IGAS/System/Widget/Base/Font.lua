-- Author      : Kurapica
-- Create Date : 6/12/2008 1:13:42 AM
-- ChangeLog
--				2011/03/12	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.Font", version) then
	return
end

__Doc__[[The Font object is to be shared between other objects that share font characteristics.]]
__InitTable__() __AutoProperty__()
class "Font"
	inherit "Object"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Get the type of this object.</desc>
		<return type="string">the object's class' name</return>
	]]
	function GetObjectType(self)
		return Reflector.GetNameSpaceName(self:GetClass())
	end

	__Doc__[[
		<desc>Determine if this object is of the specified type, or a subclass of that type.</desc>
		<param name="type">string, the object type to determined</param>
		<return type="boolean">true if the frame's type is the given type or the given type's sub-type.</return>
	]]
	function IsObjectType(self, objType)
		if objType then
			if type(objType) == "string" then
				objType = Widget[objType]
			end

			return Reflector.IsClass(objType) and Object.IsClass(self, objType) or false
		end

		return false
	end

	__Doc__"GetName" [[
		<desc>Get the full path of this object.</desc>
		<return type="string">the full path of the object</return>
	]]

	__Doc__"GetFont" [[
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

	__Doc__"GetJustifyH" [[
		<desc>Returns the font instance's horizontal text alignment style</desc>
		<return type="System.Widget.JustifyHType"></return>
	]]

	__Doc__"GetJustifyV" [[
		<desc>Returns the font instance's vertical text alignment style</desc>
		<return type="System.Widget.JustifyVType"></return>
	]]

	__Doc__"GetShadowColor" [[
		<desc>Returns the color of the font's text shadow</desc>
		<return type="shadowR">number, Red component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowG">number, Green component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowB">number, Blue component of the shadow color (0.0 - 1.0)</return>
		<return type="shadowAlpha">number, Alpha (opacity) of the text's shadow (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__"GetShadowOffset" [[
		<desc>Returns the offset of the font instance's text shadow from its text</desc>
		<return type="xOffset">number, Horizontal distance between the text and its shadow (in pixels)</return>
		<return type="yOffset">number, Vertical distance between the text and its shadow (in pixels)</return>
	]]

	__Doc__"GetSpacing" [[
		<desc>Returns the font instance's amount of spacing between lines</desc>
		<return type="number">amount of space between lines of text (in pixels)</return>
	]]

	__Doc__"GetTextColor" [[
		<desc>Returns the font instance's default text color</desc>
		<return type="textR">number, Red component of the text color (0.0 - 1.0)</return>
		<return type="textG">number, Green component of the text color (0.0 - 1.0)</return>
		<return type="textB">number, Blue component of the text color (0.0 - 1.0)</return>
		<return type="textAlpha">number, Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__"SetFont" [[
		<desc>Sets the font instance's basic font properties</desc>
		<param name="filename">string, path to a font file</param>
		<param name="fontHeight">number, height (point size) of the font to be displayed (in pixels)</param>
		<param name="flags">string, additional properties for the font specified by one or more (separated by commas) of the following tokens: MONOCHROME, OUTLINE, THICKOUTLINE</param>
		<return type="boolean">1 if filename refers to a valid font file; otherwise nil</return>
	]]

	__Doc__"SetFontObject" [[
		<desc>Sets the Font object from which the font instance's properties are inherited</desc>
		<format>fontObject|fontName</format>
		<param name="fontObject">System.Widget.Font, a font object</param>
		<param name="fontName">string, global font object's name</param>
	]]

	__Doc__"SetJustifyH" [[
		<desc>Sets the font instance's horizontal text alignment style</desc>
		<param name="justifyH">System.Widget.JustifyHType</param>
	]]

	__Doc__"SetJustifyV" [[
		<desc>Sets the font instance's vertical text alignment style</desc>
		<param name="justifyV">System.Widget.JustifyVType</param>
	]]

	__Doc__"SetShadowColor" [[
		<desc>Sets the color of the font's text shadow</desc>
		<param name="shadowR">number, Red component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowG">number, Green component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowB">number, Blue component of the shadow color (0.0 - 1.0)</param>
		<param name="shadowAlpha">number, Alpha (opacity) of the text's shadow (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__"SetShadowOffset" [[
		<desc>Sets the offset of the font instance's text shadow from its text</desc>
		<param name="xOffset">number, Horizontal distance between the text and its shadow (in pixels)</param>
		<param name="yOffset">number, Vertical distance between the text and its shadow (in pixels)</param>
	]]

	__Doc__"SetSpacing" [[
		<desc>Sets the font instance's amount of spacing between lines</desc>
		<param name="spacing">number, amount of space between lines of text (in pixels)</param>
	]]

	__Doc__"SetTextColor" [[
		<desc>Sets the font instance's default text color. This color is used for otherwise unformatted text displayed using the font instance</desc>
		<param name="textR">number, Red component of the text color (0.0 - 1.0)</param>
		<param name="textG">number, Green component of the text color (0.0 - 1.0)</param>
		<param name="textB">number, Blue component of the text color (0.0 - 1.0)</param>
		<param name="textAlpha">number, Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__"CopyFontObject" [[
		<desc>Sets the font's properties to match those of another Font object. Unlike Font:SetFontObject(), this method allows one-time reuse of another font object's properties without continuing to inherit future changes made to the other object's properties.</desc>
		<format>object|name</format>
		<param name="object">System.Widget.Font, reference to a Font object</param>
		<param name="name">string, global name of a Font object</param>
	]]

	__Doc__"GetAlpha" [[
		<desc>Returns the opacity for text displayed by the font</desc>
		<return type="number">Alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__"GetIndentedWordWrap" [[
		<desc>Gets whether long lines of text are indented when wrapping</desc>
		<return type="boolean"></return>
	]]

	__Doc__"SetAlpha" [[
		<desc>Sets the opacity for text displayed by the font</desc>
		<param name="alpha">number, alpha (opacity) of the text (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__"SetIndentedWordWrap" [[
		<desc>Sets whether long lines of text are indented when wrapping</desc>
		<param name="boolean"></param>
	]]

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		-- Remove from _G if it exists
		if self:GetName() and IGAS:GetWrapper(_G[self:GetName()]) == self then
			_G[self:GetName()] = nil
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Font(self, name)
		local fontObject = type(name) == "string" and (_G[name] or CreateFont(name)) or name

		if not fontObject or type(fontObject) ~= "table" or type(fontObject[0]) ~= "userdata" then
			error("No font is found.", 2)
		end

		self[0] = fontObject[0]
		self.__UI = fontObject
		_WrapperMap[fontObject] = self
	end

	------------------------------------------------------
	-- Exist checking
	------------------------------------------------------
	function __exist(fontObject)
		if type(fontObject) == "string" then
			fontObject = _G[fontObject] or fontObject
		end

		if type(fontObject) == "table" and type(fontObject[0]) == "userdata" then
			-- Do Wrapper the blz's UI element

			-- VirtualUIObject's instance will not be checked here.
			if Object.IsClass(fontObject, Font) or not fontObject.GetObjectType then
				-- UIObject's instance will be return here.
				return fontObject
			end

			if _WrapperMap[fontObject] and Object.IsClass(_WrapperMap[fontObject], Font) then
				return _WrapperMap[fontObject]
			end
		end
	end
endclass "Font"

struct "FontObject" {
	function (value)
		assert(type(value) == "string" or Reflector.ObjectIsClass(value, Font), "%s must be a font object or font object's name.")
	end
}

class "Font"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Font, GameFontNormal)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the name of the font object]]
	property "Name" { }

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

	__Doc__[[the opacity for text displayed by the font]]
	property "Alpha" { Type = ColorFloat }

	__Doc__[[whether long lines of text are indented when wrapping]]
	property "IndentedWordWrap" { Type = Boolean }
endclass "Font"
