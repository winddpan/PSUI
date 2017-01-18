-- Author      : Kurapica
-- Create Date : 6/13/2008 5:22:03 PM
-- ChangeLog
--				2011/03/12	Recode as class

-- Check Version
local version = 4
if not IGAS:NewAddon("IGAS.Widget.LayeredRegion", version) then
	return
end

__Doc__[[LayeredRegion is an abstract UI type that groups together the functionality of layered graphical regions, specifically Textures and FontStrings.]]
__AutoProperty__()
class "LayeredRegion"
	inherit "Region"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetDrawLayer" [[
		<desc>Returns the draw layer for the Region</desc>
		<return type="System.Widget.DrawLayer"></return>
	]]

	__Doc__"SetDrawLayer" [[
		<desc>Sets the draw layer for the Region</desc>
		<param name="layer">System.Widget.DrawLayer</param>
	]]

	__Doc__[[
		<desc>Sets a color shading for the region's graphics.</desc>
		<param name="red">number, red component of the color (0.0 - 1.0)</param>
		<param name="green">number, green component of the color (0.0 - 1.0)</param>
		<param name="blue">number, blue component of the color (0.0 - 1.0)</param>
		<param name="alpha">number, alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]
	function SetVertexColor(self, r, g, b, a)
		self.__VertexColor = self.__VertexColor or {}
		self.__VertexColor.r = r
		self.__VertexColor.g = g
		self.__VertexColor.b = b
		self.__VertexColor.a = a

		return IGAS:GetUI(self):SetVertexColor(r, g, b, a)
	end

	__Doc__[[
		<desc>Gets a color shading for the region's graphics.</desc>
		<return type="red">number, red component of the color (0.0 - 1.0)</return>
		<return type="green">number, green component of the color (0.0 - 1.0)</return>
		<return type="blue">number, blue component of the color (0.0 - 1.0)</return>
		<return type="alpha">number, alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]
	function GetVertexColor(self)
		self.__VertexColor = self.__VertexColor or ColorType(1, 1, 1, 1)

		return self.__VertexColor.r, self.__VertexColor.g, self.__VertexColor.b, self.__VertexColor.a
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the layer at which the region's graphics are drawn relative to others in its frame]]
	property "DrawLayer" {
		Get = function(self)
			return self:GetDrawLayer()
		end,
		Set = function(self, layer)
			return self:SetDrawLayer(layer)
		end,
		Type = DrawLayer,
	}

	__Doc__[[the color shading for the region's graphics]]
	property "VertexColor" {
		Get = function(self)
			return self:GetVertexColor()
		end,
		Set = function(self, color)
			self:SetVertexColor(color.r, color.g, color.b, color.a)
		end,
		Type = ColorType,
	}
endclass "LayeredRegion"
