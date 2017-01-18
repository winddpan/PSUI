-- Author : kurapica.igas@gmail.com
-- Create Date 	: 2011/03/01
-- ChangeLog
--                2011/10/31 code added as ColorType's member
--                2012/12/03 Add more color to FontColor
--                2014/08/24 Add default value for several enums

local version = 6

if not IGAS:NewAddon("IGAS.Widget", version) then
	return
end

------------------------------------------------------
-- Header for System.Widget.*
------------------------------------------------------
import "System"

namespace "System.Widget"

------------------------------------------------------
-- Enums
------------------------------------------------------
-- FramePoint
enum "FramePoint" {
	"TOPLEFT",
	"TOPRIGHT",
	"BOTTOMLEFT",
	"BOTTOMRIGHT",
	"TOP",
	"BOTTOM",
	"LEFT",
	"RIGHT",
	"CENTER",
}
-- FrameStrata
enum "FrameStrata" {
	"PARENT",
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
	"FULLSCREEN",
	"FULLSCREEN_DIALOG",
	"TOOLTIP",
}
-- DrawLayer
enum "DrawLayer" {
	"BACKGROUND",
	"BORDER",
	"ARTWORK",
	"OVERLAY",
	"HIGHLIGHT",
}
-- AlphaMode
__Default__"ADD"
enum "AlphaMode" {
	"DISABLE",
	"BLEND",
	"ALPHAKEY",
	"ADD",
	"MOD",
}
-- OutLineType
__Default__"NONE"
enum "OutLineType" {
	"NONE",
	"NORMAL",
	"THICK",
}
-- JustifyVType
enum "JustifyVType" {
	"TOP",
	"MIDDLE",
	"BOTTOM",
}
-- JustifyHType
enum "JustifyHType" {
	"LEFT",
	"CENTER",
	"RIGHT",
}
-- InsertMode
enum "InsertMode" {
	"TOP",
	"BOTTOM",
}
-- Orientation
enum "Orientation" {
	"HORIZONTAL",
	"VERTICAL",
}
-- AttributeType
__Default__"nil"
enum "AttributeType" {
	"nil",
	"boolean",
	"number",
	"string",
}
-- AnimLoopType
__Default__"NONE"
enum "AnimLoopType" {
	"NONE",
	"REPEAT",
	"BOUNCE",
}
-- AnimLoopStateType
__Default__"NONE"
enum "AnimLoopStateType" {
	"NONE",
	"FORWARD",
	"REVERSE",
}
-- AnimSmoothType
__Default__"NONE"
enum "AnimSmoothType" {
	"NONE",
	"IN",
	"OUT",
	"IN_OUT",
	"OUT_IN",
}
-- AnimCurveType
__Default__"NONE"
enum "AnimCurveType" {
	"NONE",
	"SMOOTH",
}
-- AnchorType
enum "AnchorType" {
	"ANCHOR_TOPRIGHT",
	"ANCHOR_RIGHT",
	"ANCHOR_BOTTOMRIGHT",
	"ANCHOR_TOPLEFT",
	"ANCHOR_LEFT",
	"ANCHOR_BOTTOMLEFT",
	"ANCHOR_CURSOR",
	"ANCHOR_PRESERVE",
	"ANCHOR_NONE",
}
-- ButtonState
enum "ButtonStateType" {
	"PUSHED",
	"NORMAL",
}
-- ButtonClickType
enum "ButtonClickType" {
	"LeftButtonUp",
	"RightButtonUp",
	"MiddleButtonUp",
	"Button4Up",
	"Button5Up",
	"LeftButtonDown",
	"RightButtonDown",
	"MiddleButtonDown",
	"Button4Down",
	"Button5Down",
	"AnyUp",
	"AnyDown",
}
-- FontColor
enum "FontColor" {
	NORMAL = "|cffffd200",
	HIGHLIGHT = "|cffffffff",
	ACHIEVEMENT = "|cffffff00",
	CLOSE = "|r",
	-- NormalColors
	ALICEBLUE = "|cfff0f8ff",
	ANTIQUEWHITE = "|cfffaebd7",
	AQUA = "|cff00ffff",
	AQUAMARINE = "|cff7fffd4",
	AZURE = "|cfff0ffff",
	BEIGE = "|cfff5f5dc",
	BISQUE = "|cffffe4c4",
	BLACK = "|cff000000",
	BLANCHEDALMOND = "|cffffebcd",
	BLUE = "|cff0000ff",
	BLUEVIOLET = "|cff8a2be2",
	BROWN = "|cffa52a2a",
	BURLYWOOD = "|cffdeb887",
	CADETBLUE = "|cff5f9ea0",
	CHARTREUSE = "|cff7fff00",
	CHOCOLATE = "|cffd2691e",
	CORAL = "|cffff7f50",
	CORNFLOWERBLUE = "|cff6495ed",
	CORNSILK = "|cfffff8dc",
	CRIMSON = "|cffdc143c",
	CYAN = "|cff00ffff",
	DARKBLUE = "|cff00008b",
	DARKCYAN = "|cff008b8b",
	DARKGOLDENROD = "|cffb8860b",
	DARKGRAY = "|cffa9a9a9",
	DARKGREEN = "|cff006400",
	DARKKHAKI = "|cffbdb76b",
	DARKMAGENTA = "|cff8b008b",
	DARKOLIVEGREEN = "|cff556b2f",
	DARKORANGE = "|cffff8c00",
	DARKORCHID = "|cff9932cc",
	DARKRED = "|cff8b0000",
	DARKSALMON = "|cffe9967a",
	DARKSEAGREEN = "|cff8fbc8f",
	DARKSLATEBLUE = "|cff483d8b",
	DARKSLATEGRAY = "|cff2f4f4f",
	DARKTURQUOISE = "|cff00ced1",
	DARKVIOLET = "|cff9400d3",
	DEEPPINK = "|cffff1493",
	DEEPSKYBLUE = "|cff00bfff",
	DIMGRAY = "|cff696969",
	DODGERBLUE = "|cff1e90ff",
	FIREBRICK = "|cffb22222",
	FLORALWHITE = "|cfffffaf0",
	FORESTGREEN = "|cff228b22",
	FUCHSIA = "|cffff00ff",
	GAINSBORO = "|cffdcdcdc",
	GHOSTWHITE = "|cfff8f8ff",
	GOLD = "|cffffd700",
	GOLDENROD = "|cffdaa520",
	GRAY = "|cff808080",
	GREEN = "|cff008000",
	GREENYELLOW = "|cffadff2f",
	HONEYDEW = "|cfff0fff0",
	HOTPINK = "|cffff69b4",
	INDIANRED = "|cffcd5c5c",
	INDIGO = "|cff4b0082",
	IVORY = "|cfffffff0",
	KHAKI = "|cfff0e68c",
	LAVENDER = "|cffe6e6fa",
	LAVENDERBLUSH = "|cfffff0f5",
	LAWNGREEN = "|cff7cfc00",
	LEMONCHIFFON = "|cfffffacd",
	LIGHTBLUE = "|cffadd8e6",
	LIGHTCORAL = "|cfff08080",
	LIGHTCYAN = "|cffe0ffff",
	LIGHTGOLDENRODYELLOW = "|cfffafad2",
	LIGHTGRAY = "|cffd3d3d3",
	LIGHTGREEN = "|cff90ee90",
	LIGHTPINK = "|cffffb6c1",
	LIGHTSALMON = "|cffffa07a",
	LIGHTSEAGREEN = "|cff20b2aa",
	LIGHTSKYBLUE = "|cff87cefa",
	LIGHTSLATEGRAY = "|cff778899",
	LIGHTSTEELBLUE = "|cffb0c4de",
	LIGHTYELLOW = "|cffffffe0",
	LIME = "|cff00ff00",
	LIMEGREEN = "|cff32cd32",
	LINEN = "|cfffaf0e6",
	MAGENTA = "|cffff00ff",
	MAROON = "|cff800000",
	MEDIUMAQUAMARINE = "|cff66cdaa",
	MEDIUMBLUE = "|cff0000cd",
	MEDIUMORCHID = "|cffba55d3",
	MEDIUMPURPLE = "|cff9370db",
	MEDIUMSEAGREEN = "|cff3cb371",
	MEDIUMSLATEBLUE = "|cff7b68ee",
	MEDIUMSPRINGGREEN = "|cff00fa9a",
	MEDIUMTURQUOISE = "|cff48d1cc",
	MEDIUMVIOLETRED = "|cffc71585",
	MIDNIGHTBLUE = "|cff191970",
	MINTCREAM = "|cfff5fffa",
	MISTYROSE = "|cffffe4e1",
	MOCCASIN = "|cffffe4b5",
	NAVAJOWHITE = "|cffffdead",
	NAVY = "|cff000080",
	OLDLACE = "|cfffdf5e6",
	OLIVE = "|cff808000",
	OLIVEDRAB = "|cff6b8e23",
	ORANGE = "|cffffa500",
	ORANGERED = "|cffff4500",
	ORCHID = "|cffda70d6",
	PALEGOLDENROD = "|cffeee8aa",
	PALEGREEN = "|cff98fb98",
	PALETURQUOISE = "|cffafeeee",
	PALEVIOLETRED = "|cffdb7093",
	PAPAYAWHIP = "|cffffefd5",
	PEACHPUFF = "|cffffdab9",
	PERU = "|cffcd853f",
	PINK = "|cffffc0cb",
	PLUM = "|cffdda0dd",
	POWDERBLUE = "|cffb0e0e6",
	PURPLE = "|cff800080",
	RED = "|cffff0000",
	ROSYBROWN = "|cffbc8f8f",
	ROYALBLUE = "|cff4169e1",
	SADDLEBROWN = "|cff8b4513",
	SALMON = "|cfffa8072",
	SANDYBROWN = "|cfff4a460",
	SEAGREEN = "|cff2e8b57",
	SEASHELL = "|cfffff5ee",
	SIENNA = "|cffa0522d",
	SILVER = "|cffc0c0c0",
	SKYBLUE = "|cff87ceeb",
	SLATEBLUE = "|cff6a5acd",
	SLATEGRAY = "|cff708090",
	SNOW = "|cfffffafa",
	SPRINGGREEN = "|cff00ff7f",
	STEELBLUE = "|cff4682b4",
	TAN = "|cffd2b48c",
	TEAL = "|cff008080",
	THISTLE = "|cffd8bfd8",
	TOMATO = "|cffff6347",
	TURQUOISE = "|cff40e0d0",
	VIOLET = "|cffee82ee",
	WHEAT = "|cfff5deb3",
	WHITE = "|cffffffff",
	WHITESMOKE = "|cfff5f5f5",
	YELLOW = "|cffffff00",
	YELLOWGREEN = "|cff9acd32",
}

------------------------------------------------------
-- Structs
------------------------------------------------------
function assert(flag, msg, ...)
	if not flag then
		error(format(msg, ...), 2)
	end
end

-- BooleanNil_01
struct "BooleanNil_01"
	function __init(value)
		return value == 1 or value == true
	end
endstruct "BooleanNil_01"

-- Point
struct "Point"
	x = Number
	y = Number
endstruct "Point"

-- Dimension
struct "Dimension"
	x = Number
	y = Number
endstruct "Dimension"

-- Size
struct "Size"
	width = Number
	height = Number
endstruct "Size"

-- AnchorPoint
struct "AnchorPoint"
	point = FramePoint
	xOffset = Number
	yOffset = Number
	relativeTo = String
	relativePoint = FramePoint
endstruct "AnchorPoint"

-- struct Location
struct "Location" { AnchorPoint }

-- MinMax
struct "MinMax"
	min = Number
	max = Number

	function MinMax(value)
		assert(value.min <= value.max, "%s.min can't be greater than %s.max.")
	end
endstruct "MinMax"

-- Inset
struct "Inset"
	left = Number
	right = Number
	top = Number
	bottom = Number
endstruct "Inset"

-- ColorFloat
struct "ColorFloat"
	function ColorFloat(value)
		assert(type(value) == "number", "%s must be a number, got %s.", "%s", type(value))
		assert(value >= 0 and value <= 1, "%s must in [0-1].")
	end
endstruct "ColorFloat"

-- ColorType
struct "ColorType"
	__Require__() r = ColorFloat
	__Require__() g = ColorFloat
	__Require__() b = ColorFloat
	a = ColorFloat
	code = String

	function __init(value)
		value.a = value.a or 1	-- default
		value.code = value.code or ("\124cff%.2x%.2x%.2x"):format(value.r * 255, value.g * 255, value.b * 255)
	end
endstruct "ColorType"

-- Position
struct "Position"
	x = Number
	y = Number
	z = Number
endstruct "Position"

-- FontType
struct "FontType"
	path = String
	height = Number
	outline = OutLineType
	monochrome = Boolean
endstruct "FontType"

-- BackdropType
struct "BackdropType"
	bgFile = String
	edgeFile = String
	tile = Boolean
	tileSize = Number
	edgeSize = Number
	insets = Inset
endstruct "BackdropType"

-- AnimOrderType
struct "AnimOrderType"
	function AnimOrderType(value)
		assert(type(value) == "number", "%s must be a number, got %s.", "%s", type(value))
		assert(value >=0 and value <= 100, "%s must be in [0-100], got %s.")
	end

	function __init(value)
		return floor(value)
	end
endstruct "AnimOrderType"

-- AnimOriginType
struct "AnimOriginType"
	point = FramePoint
	x = Number
	y = Number
endstruct "AnimOriginType"

-- LightType
struct "LightType"
	enabled = Boolean
	omni = Number
	dirX = Number
	dirY = Number
	dirZ = Number
	ambIntensity = ColorFloat
	ambR = ColorFloat
	ambG = ColorFloat
	ambB = ColorFloat
	dirIntensity = ColorFloat
	dirR = ColorFloat
	dirG = ColorFloat
	dirB = ColorFloat

	function LightType(value)
		assert(value.omni == 0 or value.omni == 1, "%s.omni must be 0 or 1.")
	end
endstruct "LightType"

-- MiniMapPosition
struct "MiniMapPosition"
	radius = Number
	rounding = Number
	angel = Number

	function MiniMapPosition(value)
		assert(value.radius > 0, "The %s.radius must be greater than 0.")
		assert(value.angel >= 0 and value.angel <= 360, "The %s.angel must in [0-360].")
	end
endstruct "MiniMapPosition"

struct "EventArgs"
	Cancel = Boolean
	Handled = Boolean
endstruct "EventArgs"

------------------------------------------------------
-- Global Settings
------------------------------------------------------
_WrapperMap = setmetatable({}, {__mode="k"})

------------------------------------
--- Get the true frame of a IGAS frame
-- <param name="frame">the IGAS frame</param>
-- <return type="the">true frame of the IGAS frame</return>
-- <usage>IGAS:GetUI(MyFrame1)</usage>
------------------------------------
function IGAS:GetUI(frame)
	if frame == nil or type(frame) ~= "table" then
		return frame
	else
		return frame.__UI or frame
	end
end

------------------------------------
--- Get the IGAS frame of a frame
-- <param name="frame">the frame</param>
-- <return type="the">IGAS frame of the frame</return>
-- <usage>IGAS:GetWrapper(UIParent)</usage>
------------------------------------
function IGAS:GetWrapper(frame)
	if type(frame) ~= "table" or type(frame[0]) ~= "userdata" then
		-- VirtualUIObject's instance will be return here.
		return frame
	end

	if Object.IsClass(frame, Widget["UIObject"]) then
		-- UIObject's instance will be return here.
		return frame
	end

	if _WrapperMap[frame] and Object.IsClass(_WrapperMap[frame], Widget["UIObject"]) then
		-- Check if the frame already has a wrapper
		-- Don't store it because I don't want a hashtable to be refreshed frequently.
		return _WrapperMap[frame]
	end

	-- Now build a new wrapper for it.
	if not frame.GetObjectType then
		return frame
	end

	local objType = frame:GetObjectType() or "UIObject"

	if Widget[objType] then
		return Widget[objType](frame) or frame
	else
		return Widget["UIObject"](frame) or frame
	end
end

_G = _G

------------------------------------
--- Get the IGAS frame for the full name
-- <param name="name"></param>
-- <return type="frame"></return>
-- <usage>IGAS:GetFrame("IGAS.UIParent.TestForm.Label")</usage>
------------------------------------
function IGAS:GetFrame(name)
	local ret = _G

	if type(name) ~= "string" then return end

	for sub in name:gmatch("[^%.]+") do
		sub = sub and strtrim(sub)
		if not sub or sub =="" then return end

		ret = ret[sub]

		if not ret then return end
	end

	if ret == _G then return end

	return ret
end

_BaseFrame = _BaseFrame or CreateFrame("Frame")
_BaseFrame:Hide()

------------------------------------
--- Store blz UI's methodes to IGAS's Widget
------------------------------------
function StoreBlzMethod(cls, managerCls, managerCls2, inheritCls)
	local clsEnv = getfenv(2)

	local sample
	local baseF = _BaseFrame

	if managerCls2 then
		if Reflector.IsClass(managerCls2) then
			baseF = managerCls2(Reflector.GetNameSpaceName(managerCls2), baseF)
		else
			baseF = managerCls2
		end
	end

	if managerCls then
		if Reflector.IsClass(managerCls) then
			baseF = managerCls(Reflector.GetNameSpaceName(managerCls), baseF)
		else
			baseF = managerCls
		end
	end

	if Reflector.IsClass(cls) then
		sample = cls(Reflector.GetNameSpaceName(cls), baseF)
	else
		sample = cls
	end

	if type(IGAS:GetUI(sample)) ~= "table" or getmetatable(IGAS:GetUI(sample)) == nil or type(getmetatable(IGAS:GetUI(sample)).__index) ~= "table" then
		return
	end

	for fname, func in pairs(getmetatable(IGAS:GetUI(sample)).__index) do
		if cls == sample then
			if not inheritCls or inheritCls[fname] == nil then
				clsEnv[fname] = func
			end
		elseif cls[fname] == nil then
			clsEnv[fname] = func
		end
	end
end
