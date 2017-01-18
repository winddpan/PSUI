-- Author      : Kurapica
-- Create Date : 6/13/2008 9:27:45 PM
-- ChangeLog
--				2011/03/12	Recode as class
--              2012/09/04  Rotate & Shear method added
--              2013/11/04  Reduce memory cost

-- Check Version
local version = 14
if not IGAS:NewAddon("IGAS.Widget.Texture", version) then
	return
end

_SetPortraitTexture = SetPortraitTexture

__Doc__[[Texture is used to display pic or color]]
 __AutoProperty__()
class "Texture"
	inherit "LayeredRegion"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetBlendMode" [[
		<desc>Returns the blend mode of the texture</desc>
		<return type="System.Widget.AlphaMode"></return>
	]]

	__Doc__"GetHorizTile" [[
		@desc
		<return type="boolean"></return>
	]]

	__Doc__"GetNonBlocking" [[
		<desc>Returns whether the texture object loads its image file in the background</desc>
		<return type="boolean">1 if the texture object loads its image file in the background</return>
	]]

	__Doc__"GetTexCoord" [[
		<desc>Returns corner coordinates for scaling or cropping the texture image</desc>
		<return type="ULx">number, Upper left corner X position, as a fraction of the image's width from the left</return>
		<return type="ULy">number, Upper left corner Y position, as a fraction of the image's height from the top</return>
		<return type="LLx">number, Lower left corner X position, as a fraction of the image's width from the left</return>
		<return type="LLy">number, Lower left corner Y position, as a fraction of the image's height from the top</return>
		<return type="URx">number, Upper right corner X position, as a fraction of the image's width from the left</return>
		<return type="URy">number, Upper right corner Y position, as a fraction of the image's height from the top</return>
		<return type="LRx">number, Lower right corner X position, as a fraction of the image's width from the left</return>
		<return type="LRy">number, Lower right corner Y position, as a fraction of the image's height from the top</return>
	]]

	__Doc__[[
		<desc>Returns the path to the texture's image file or the color settings</desc>
		<returnformat>texturePath</returnformat>
		<returnformat>red, green, blue, alpha</returnformat>
		<return type="texturePath">string, the path of the texture's image file</return>
		<return type="red">number, the color's red part</return>
		<return type="green">number, the color's green part</return>
		<return type="blue">number, the color's blue part</return>
		<return type="alpha">number, the color's alpha</return>
	]]
	function GetTexture(self, ...)
		local value = self.__UI:GetTexture(...)

		if not value then return nil end

		if strmatch(value, "^RTPortrait%d*") then
			return self.__Unit
		elseif strmatch(value, "^Color%-") then
			return self.__R, self.__G, self.__B, self.__A
		end

		return value
	end

	__Doc__"GetVertexColor" [[
		<desc>Returns the shading color of the texture. For details about vertex color shading</desc>
		<return type="red">number, the color's red part</return>
		<return type="green">number, the color's green part</return>
		<return type="blue">number, the color's blue part</return>
		<return type="alpha">number, the color's alpha</return>
	]]

	__Doc__"GetVertTile" [[
		@desc
		<return type="boolean"></return>
	]]

	__Doc__"IsDesaturated" [[
		<desc>Returns whether the texture image should be displayed with zero saturation (i.e. converted to grayscale). The texture may not actually be displayed in grayscale if the current display hardware doesn't support that feature;</desc>
		<return type="boolean">1 if the texture should be displayed in grayscale, otherwise nil</return>
	]]

	__Doc__"SetBlendMode" [[
		<desc>Sets the blend mode of the texture</desc>
		<param name="mode">System.Widget.AlphaMode, Blend mode of the texture</param>
	]]

	__Doc__"SetDesaturated" [[
		<desc>Sets whether the texture image should be displayed with zero saturation (i.e. converted to grayscale). Returns nil if the current system does not support texture desaturation; in such cases, this method has no visible effect</desc>
		<param name="desaturate">boolean, true to display the texture in grayscale, false to display original texture colors</param>
	]]

	__Doc__"SetGradient" [[
		<desc>Sets a gradient color shading for the texture. Gradient color shading does not change the underlying color of the texture image, but acts as a filter</desc>
		<param name="orientation">System.Widget.Orientation, Token identifying the direction of the gradient</param>
		<param name="startR">number, Red component of the start color (0.0 - 1.0)</param>
		<param name="startG">number, Green component of the start color (0.0 - 1.0)</param>
		<param name="startB">number, Blue component of the start color (0.0 - 1.0)</param>
		<param name="endR">number, Red component of the end color (0.0 - 1.0)</param>
		<param name="endG">number, Green component of the end color (0.0 - 1.0)</param>
		<param name="endB">number, Blue component of the end color (0.0 - 1.0)</param>
	]]

	__Doc__"SetGradientAlpha" [[
		<desc>Sets a gradient color shading for the texture (including opacity in the gradient). Gradient color shading does not change the underlying color of the texture image, but acts as a filter</desc>
		<param name="orientation">System.Widget.Orientation, Token identifying the direction of the gradient (string)</param>
		<param name="startR">number, Red component of the start color (0.0 - 1.0)</param>
		<param name="startG">number, Green component of the start color (0.0 - 1.0)</param>
		<param name="startB">number, Blue component of the start color (0.0 - 1.0)</param>
		<param name="startAlpha">number, Alpha (opacity) for the start side of the gradient (0.0 = fully transparent, 1.0 = fully opaque)</param>
		<param name="endR">number, Red component of the end color (0.0 - 1.0)</param>
		<param name="endG">number, Green component of the end color (0.0 - 1.0)</param>
		<param name="endB">number, Blue component of the end color (0.0 - 1.0)</param>
		<param name="endAlpha">number, Alpha (opacity) for the end side of the gradient (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__"SetHorizTile" [[
		<param name="boolean"></param>
	]]

	__Doc__"SetNonBlocking" [[
		<desc>Sets whether the texture object loads its image file in the background. Texture loading is normally synchronous, so that UI objects are not shown partially textured while loading; however, non-blocking (asynchronous) texture loading may be desirable in some cases where large numbers of textures need to be loaded in a short time. This feature is used in the default UI's icon chooser window for macros and equipment sets, allowing a large number of icon textures to be loaded without causing the game's frame rate to stagger.</desc>
		<param name="nonBlocking">boolean, true to allow texture object to load it's image file in background</param>
	]]

	__Doc__"SetRotation" [[
		<desc>Rotates the texture image</desc>
		<param name="radians">number, Amount by which the texture image should be rotated, positive values for counter-clockwise rotation, negative for clockwise</param>
	]]

	__Doc__"SetTexCoord" [[
		<desc>Sets corner coordinates for scaling or cropping the texture image</desc>
		<format>left, right, top, bottom</format>
		<format>ULx, ULy, LLx, LLy, URx, URy, LRx, LRy</format>
		<param name="left">number, Left edge of the scaled/cropped image, as a fraction of the image's width from the left</param>
		<param name="right">number, Right edge of the scaled/cropped image, as a fraction of the image's width from the left</param>
		<param name="top">number, Top edge of the scaled/cropped image, as a fraction of the image's height from the top</param>
		<param name="bottom">number, Bottom edge of the scaled/cropped image, as a fraction of the image's height from the top</param>
		<param name="ULx">number, Upper left corner X position, as a fraction of the image's width from the left</param>
		<param name="ULy">number, Upper left corner Y position, as a fraction of the image's height from the top</param>
		<param name="LLx">number, Lower left corner X position, as a fraction of the image's width from the left</param>
		<param name="LLy">number, Lower left corner Y position, as a fraction of the image's height from the top</param>
		<param name="URx">number, Upper right corner X position, as a fraction of the image's width from the left</param>
		<param name="URy">number, Upper right corner Y position, as a fraction of the image's height from the top</param>
		<param name="LRx">number, Lower right corner X position, as a fraction of the image's width from the left</param>
		<param name="LRy">number, Lower right corner Y position, as a fraction of the image's height from the top</param>
	]]

	__Doc__[[
		<desc>Sets the texture object's image or color</desc>
		<param name="texture">string, Path to a texture image</param>
		<param name="red">number, Red component of the color (0.0 - 1.0)</param>
		<param name="green">number, Green component of the color (0.0 - 1.0)</param>
		<param name="blue">number, Blue component of the color (0.0 - 1.0)</param>
		<param name="alpha">number, Alpha (opacity) for the color (0.0 = fully transparent, 1.0 = fully opaque)</param>
		<return type="boolean">1 if the texture was successfully changed; otherwise nil (1nil)</return>
	]]
	function SetTexture(self, ...)
		self.__R = nil
		self.__G = nil
		self.__B = nil
		self.__A = nil
		self.__Unit = nil
		self.__OriginTexCoord = nil

		SetTexCoord(self, 0, 1, 0, 1)

		local cnt = select("#", ...)
		local val = ...

		if cnt > 0 then
			if type(val) == "string" or (cnt == 1 and type(val) == "number" and val >= 1) then
				return self.__UI:SetTexture(val)
			elseif type(val) == "number" then
				local r, g, b, a = ...

				r = (r and type(r) == "number" and ((r < 0 and 0) or (r > 1 and 1) or r)) or 0
				g = (g and type(g) == "number" and ((g < 0 and 0) or (g > 1 and 1) or g)) or 0
				b = (b and type(b) == "number" and ((b < 0 and 0) or (b > 1 and 1) or b)) or 0
				a = (a and type(a) == "number" and ((a < 0 and 0) or (a > 1 and 1) or a)) or 1

				self.__R = r
				self.__G = g
				self.__B = b
				self.__A = a

				return self.__UI:SetColorTexture(r, g, b, a)
			end
		end
		return self.__UI:SetTexture(nil)
	end

	__Doc__"SetVertTile" [[
		<param name="boolean"></param>
	]]

	__Doc__[[
		<desc>Paint a Texture object with the specified unit's portrait</desc>
		<param name="unit">string, the unit to be painted</param>
	]]
	function SetPortraitUnit(self, ...)
		self.__R = nil
		self.__G = nil
		self.__B = nil
		self.__A = nil
		self.__Unit = nil
		self.__OriginTexCoord = nil

		local unit = select(1, ...)

		SetTexCoord(self, 0, 1, 0, 1)

		if unit and type(unit) == "string" and UnitExists(unit) then
			self.__Unit = unit
			return _SetPortraitTexture(self.__UI, unit)
		else
			return self.__UI:SetTexture(nil)
		end
	end

	__Doc__[[
		<desc>Sets the texture to be displayed from a file applying circular opacity mask making it look round like portraits</desc>
		<param name="texture">string, the texture file path</param>
	]]
	function SetPortraitTexture(self, ...)
		local path = select(1, ...)

		self.__Portrait = nil

		if path and type(path) == "string" then
			self.__Portrait = path
			return SetPortraitToTexture(self.__UI, path)
		end

		return SetPortraitToTexture(self.__UI, nil)
	end

	__Doc__[[
		<desc>Rotate texture for radian with current texcoord settings</desc>
		<param name="radian">number, the rotation raidian</param>
	]]
	function RotateRadian(self, radian)
		if type(radian) ~= "number" then
			error("Usage: Texture:RotateRadian(radian) - 'radian' must be number.", 2)
		end

		if not self.__OriginTexCoord then
			self.__OriginTexCoord = {self:GetTexCoord()}
			self.__OriginWidth = self.Width
			self.__OriginHeight = self.Height
		end

		while radian < 0 do
			radian = radian + 2 * math.pi
		end
		radian = radian % (2 * math.pi)

		local angle = radian % (math.pi /2)

		local left = self.__OriginTexCoord[1]
		local top = self.__OriginTexCoord[2]
		local right = self.__OriginTexCoord[7]
		local bottom = self.__OriginTexCoord[8]

		local dy = self.__OriginWidth * math.cos(angle) * math.sin(angle) * (bottom-top) / self.__OriginHeight
		local dx = self.__OriginHeight * math.cos(angle) * math.sin(angle) * (right - left) / self.__OriginWidth
		local ox = math.cos(angle) * math.cos(angle) * (right-left)
		local oy = math.cos(angle) * math.cos(angle) * (bottom-top)

		local newWidth = self.__OriginWidth*math.cos(angle) + self.__OriginHeight*math.sin(angle)
		local newHeight = self.__OriginWidth*math.sin(angle) + self.__OriginHeight*math.cos(angle)

		local ULx	-- Upper left corner X position, as a fraction of the image's width from the left (number)
		local ULy 	-- Upper left corner Y position, as a fraction of the image's height from the top (number)
		local LLx 	-- Lower left corner X position, as a fraction of the image's width from the left (number)
		local LLy 	-- Lower left corner Y position, as a fraction of the image's height from the top (number)
		local URx	-- Upper right corner X position, as a fraction of the image's width from the left (number)
		local URy 	-- Upper right corner Y position, as a fraction of the image's height from the top (number)
		local LRx 	-- Lower right corner X position, as a fraction of the image's width from the left (number)
		local LRy 	-- Lower right corner Y position, as a fraction of the image's height from the top (number)

		if radian < math.pi / 2 then
			-- 0 ~ 90
			ULx = left - dx
			ULy = bottom - oy

			LLx = right - ox
			LLy = bottom + dy

			URx = left + ox
			URy = top - dy

			LRx = right + dx
			LRy = top + oy
		elseif radian < math.pi then
			-- 90 ~ 180
			URx = left - dx
			URy = bottom - oy

			ULx = right - ox
			ULy = bottom + dy

			LRx = left + ox
			LRy = top - dy

			LLx = right + dx
			LLy = top + oy

			newHeight, newWidth = newWidth, newHeight
		elseif radian < 3 * math.pi / 2 then
			-- 180 ~ 270
			LRx = left - dx
			LRy = bottom - oy

			URx = right - ox
			URy = bottom + dy

			LLx = left + ox
			LLy = top - dy

			ULx = right + dx
			ULy = top + oy
		else
			-- 270 ~ 360
			LLx = left - dx
			LLy = bottom - oy

			LRx = right - ox
			LRy = bottom + dy

			ULx = left + ox
			ULy = top - dy

			URx = right + dx
			URy = top + oy

			newHeight, newWidth = newWidth, newHeight
		end

		self:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
		self.Width = newWidth
		self.Height = newHeight
	end

	__Doc__[[
		<desc>Rotate texture for degree with current texcoord settings</desc>
		<param name="degree">number, the rotation degree</param>
	]]
	function RotateDegree(self, degree)
		if type(degree) ~= "number" then
			error("Usage: Texture:RotateDegree(degree) - 'degree' must be number.", 2)
		end
		return RotateRadian(self, math.rad(degree))
	end

	__Doc__[[
		<desc>Shear texture for raidian</desc>
		<param name="radian">number, the shear radian</param>
	]]
	function ShearRadian(self, radian)
		if type(radian) ~= "number" then
			error("Usage: Texture:ShearRadian(radian) - 'radian' must be number.", 2)
		end

		if not self.__OriginTexCoord then
			self.__OriginTexCoord = {self:GetTexCoord()}
			self.__OriginWidth = self.Width
			self.__OriginHeight = self.Height
		end

		while radian < - math.pi/2 do
			radian = radian + 2 * math.pi
		end
		radian = radian % (2 * math.pi)

		if radian > math.pi /2 then
			error("Usage: Texture:ShearRadian(radian) - 'radian' must be between -pi/2 and pi/2.", 2)
		end

		local left = self.__OriginTexCoord[1]
		local top = self.__OriginTexCoord[2]
		local right = self.__OriginTexCoord[7]
		local bottom = self.__OriginTexCoord[8]

		local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy = unpack(self.__OriginTexCoord)

		if radian > 0 then
			ULx = left - (bottom-top)*math.sin(radian)
			LRx = right + (bottom-top)*math.sin(radian)
		elseif radian < 0 then
			radian = math.abs(radian)
			LLx = left - (bottom-top)*math.sin(radian)
			URx = right + (bottom-top)*math.sin(radian)
		end

		self:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
	end

	__Doc__[[
		<desc>Shear texture with degree</desc>
		<param name="degree">number, the shear degree</param>
	]]
	function ShearDegree(self, degree)
		if type(degree) ~= "number" then
			error("Usage: Texture:ShearDegree(degree) - 'degree' must be number.", 2)
		end

		return ShearRadian(self, math.rad(degree))
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		if not Object.IsClass(parent, UIObject) or not IGAS:GetUI(parent).CreateTexture then
			error("Usage : Texture(name, parent) : 'parent' - UI element expected.", 2)
		end
		return IGAS:GetUI(parent):CreateTexture(nil, ...)
	end
endclass "Texture"

class "Texture"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Texture)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the blend mode of the texture]]
	property "BlendMode" { Type = AlphaMode }

	__Doc__[[whether the texture image should be displayed with zero saturation]]
	property "Desaturated" {
		Get = "IsDesaturated",
		Set = function(self, desaturation)
			if ( not self:SetDesaturated(desaturation) ) then
				return desaturation and self:SetVertexColor(0.5, 0.5, 0.5) or self:SetVertexColor(1.0, 1.0, 1.0)
			end
		end,
		Type = Boolean,
	}

	__Doc__[[the texture object's image file path]]
	property "TexturePath" {
		Get = function(self)
			local path = self:GetTexture()

			if type(path) == "string" and not strmatch(path, "^Color%-") and not strmatch(path, "^RTPortrait%d*") then
				return path
			elseif type(path) == "number" then
				return path
			end
		end,
		Set = "SetTexture",
		Type = String+Number,
	}

	__Doc__[[the unit be de displayed as a portrait, such as "player", "target"]]
	property "PortraitUnit" {
		Get = function(self)
			local texture = self:GetTexture()

			if type(texture) == "string" and strmatch(texture, "^RTPortrait%d*") then
				return self.__Unit
			end
		end,
		Set = "SetPortraitUnit",
		Type = String,
	}

	__Doc__[[the texture to be displayed from a file applying circular opacity mask making it look round like portraits.]]
	property "PortraitTexture" {
		Field = "__Portrait",
		Set = "SetPortraitTexture",
		Type = String,
	}

	__Doc__[[the texture's color]]
	property "Color" {
		Get = function(self)
			if self:GetTexture() and strmatch(self:GetTexture(), "^Color%-") then
				return ColorType(self.__R or 0, self.__G or 0, self.__B or 0, self.__A or 1)
			end
		end,
		Set = function(self, color)
			self:SetColorTexture(color.r, color.g, color.b, color.a)
		end,
		Type = ColorType,
	}

	__Doc__[[the color shading for the region's graphics]]
	property "VertexColor" {
		Get = function(self)
			return ColorType(self:GetVertexColor())
		end,
		Set = function(self, color)
			self:SetVertexColor(color.r, color.g, color.b, color.a)
		end,
		Type = ColorType,
	}

	__Doc__[[]]
	property "HorizTile" { Type = Boolean }

	__Doc__[[]]
	property "VertTile" { Type = Boolean }

	__Doc__[[whether the texture object loads its image file in the background]]
	property "NonBlocking" { Type = Boolean }
endclass "Texture"
