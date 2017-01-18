-- Author      : Kurapica
-- Create Date : 7/16/2008 12:21
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.Minimap", version) then
	return
end

__Doc__[[Minimap is a frame type whose backdrop is filled in with a top-down representation of the area around the character being played.]]
__AutoProperty__()
class "Minimap"
	inherit "Frame"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"GetPingPosition" [[
		<desc>Returns the location of the last "ping" on the minimap. Coordinates are pixel distances relative to the center of the minimap (not fractions of the minimap's size as with :GetPingPosition()); positive coordinates are above or to the right of the center, negative are below or to the left.</desc>
		<return type="x">number, horizontal coordinate of the "ping" position</return>
		<return type="y">number, vertical coordinate of the "ping" position</return>
	]]

	__Doc__"GetZoom" [[
		<desc>Returns the minimap's current zoom level</desc>
		<return type="number">Index of the current zoom level (between 0 for the widest possible zoom and (minimap:GetZoomLevels()- 1) for the narrowest possible zoom)</return>
	]]

	__Doc__"GetZoomLevels" [[
		<desc>Returns the number of available zoom settings for the minimap</desc>
		<return type="number">Number of available zoom settings for the minimap</return>
	]]

	__Doc__"PingLocation" [[
		<desc>"Pings" the minimap at a given location. Coordinates are pixel distances relative to the center of the minimap (not fractions of the minimap's size as with :GetPingPosition()); positive coordinates are above or to the right of the center, negative are below or to the left.</desc>
		<param name="x">number, horizontal coordinate of the "ping" position (in pixels)</param>
		<param name="y">number, vertical coordinate of the "ping" position (in pixels)</param>
	]]

	__Doc__"SetBlipTexture" [[
		<desc>Sets the texture used to display quest and tracking icons on the minimap. The replacement texture must match the specifications of the default texture (Interface\\Minimap\\ObjectIcons): 256 pixels wide by 64 pixels tall, containing an 8x2 grid of icons each 32x32 pixels square.</desc>
		<param name="filename">string, path to a texture containing display quest and tracking icons for the minimap</param>
	]]

	__Doc__"SetClassBlipTexture" [[
		<desc>Sets the texture used to display party and raid members on the minimap. Usefulness of this method to addons is limited, as the replacement texture must match the specifications of the default texture (Interface\\Minimap\\PartyRaidBlips): 256 pixels wide by 128 pixels tall, containing an 8x4 grid of icons each 32x32 pixels square.</desc>
		<param name="filename">string, path to a texture containing icons for party and raid members</param>
		]]

	__Doc__"SetCorpsePOIArrowTexture" [[
		<desc>Sets the texture used to the player's corpse when located beyond the scope of the minimap. The default texture is Interface\\Minimap\\ROTATING-MINIMAPCORPSEARROW.</desc>
		<param name="filename">string, path to a texture image</param>
	]]

	__Doc__"SetIconTexture" [[
		<desc>Sets the texture used to display various points of interest on the minimap. Usefulness of this method to addons is limited, as the replacement texture must match the specifications of the default texture (Interface\\Minimap\\POIIcons): a 256x256 pixel square containing a 16x16 grid of icons each 16x16 pixels square.</desc>
		<param name="filename">string, path to a texture containing icons for various map landmarks</param>
	]]

	__Doc__"SetMaskTexture" [[
		<desc>Sets the texture used to mask the shape of the minimap. White areas in the texture define where the dynamically drawn minimap is visible. The default mask (Textures\\MinimapMask) is circular; a texture image consisting of an all-white square will result in a square minimap.</desc>
		<param name="filename">string, path to a texture used to mask the shape of the minimap</param>
	]]

	__Doc__"SetPlayerTexture" [[
		<desc>Sets the texture used to represent the player on the minimap. The default texture is Interface\Minimap\MinimapArrow.</desc>
		<param name="filename">string, path to a texture image</param>
	]]

	__Doc__"SetPlayerTextureHeight" [[
		<desc>Sets the height of the texture used to represent the player on the minimap</desc>
		<param name="height">number, Height of the texture used to represent the player on the minimap</param>
	]]

	__Doc__"SetPlayerTextureWidth" [[
		<desc>Sets the width of the texture used to represent the player on the minimap</desc>
		<param name="width">number, Width of the texture used to represent the player on the minimap</param>
	]]

	__Doc__"SetPOIArrowTexture" [[
		<desc>Sets the texture used to represent points of interest located beyond the scope of the minimap. This texture is used for points of interest such as those which appear when asking a city guard for directions. The default texture is Interface\Minimap\ROTATING-MINIMAPGUIDEARROW.</desc>
		<param name="filename">string, ath to a texture image</param>
	]]

	__Doc__"SetStaticPOIArrowTexture" [[
		<desc>Sets the texture used to represent static points of interest located beyond the scope of the minimap. This texture is used for static points of interest such as nearby towns and cities. The default texture is Interface\\Minimap\\ROTATING-MINIMAPARROW.</desc>
		<param name="filename">string, path to a texture image</param>
	]]

	__Doc__"SetZoom" [[
		<desc>Sets the minimap's zoom level</desc>
		<param name="zoomLevel">number, index of a zoom level (between 0 for the widest possible zoom and (minimap:GetZoomLevels()- 1) for the narrowest possible zoom)</param>
	]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("Minimap", nil, parent, ...)
	end
endclass "Minimap"

class "Minimap"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(_G.Minimap, nil, nil, Frame)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the minimap's current zoom level]]
	property "Zoom" { Type = Number }
endclass "Minimap"
