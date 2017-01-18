-- Author      : Kurapica
-- Create Date : 6/12/2008 1:14:03 AM
-- ChangeLog
--				2011/03/12	Recode as class

-- Check Version
local version = 10
if not IGAS:NewAddon("IGAS.Widget.Frame", version) then
	return
end

__Doc__[[Frame is in many ways the most fundamental widget object. Other types of widget derivatives such as FontStrings, Textures and Animations can only be created attached to a Frame or other derivative of a Frame.]]
__AutoProperty__()
class "Frame"
	inherit "Region"

	local OnEvent

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when a frame attribute is changed</desc>
		<param name="name">string, name of the changed attribute, always lower case</param>
		<param name="value">any, new value of the attribute</param>
	]]
	__WidgetEvent__() event "OnAttributeChanged"

	__Doc__[[
		<desc>Run for each text character typed in the frame</desc>
		<param name="char">string, the text character typed</param>
	]]
	__WidgetEvent__() event "OnChar"

	__Doc__[[Run when the frame is disabled]]
	__WidgetEvent__() event "OnDisable"

	__Doc__[[
		<desc>Run when the mouse is dragged starting in the frame</desc>
		<param name="button">string, name of the mouse button responsible for the click action:Button4, Button5, LeftButton, MiddleButton, RightButton</param>
	]]
	__WidgetEvent__() event "OnDragStart"

	__Doc__[[Run when the mouse button is released after a drag started in the frame]]
	__WidgetEvent__() event "OnDragStop"

	__Doc__[[Run when the frame is enabled]]
	__WidgetEvent__() event "OnEnable"

	__Doc__[[
		<desc>Run when the mouse cursor enters the frame's interactive area</desc>
		<param name="motion">boolean, true if the handler is being run due to actual mouse movement; false if the cursor entered the frame due to other circumstances (such as the frame being created underneath the cursor)</param>
	]]
	__WidgetEvent__() event "OnEnter"

	__Doc__[[
		<desc>Run whenever an event fires for which the frame is registered</desc>
		<format>event[, ...]</format>
		<param name="event">string, the event's name</param>
		<param name="...">the event's parameters</param>
	]]
	__WidgetEvent__() event "OnEvent"

	__Doc__[[Run when the frame's visbility changes to hidden]]
	__WidgetEvent__() event "OnHide"

	__Doc__[[
		<desc>Run when a keyboard key is pressed if the frame is keyboard enabled</desc>
		<param name="key">string, name of the key pressed</param>
	]]
	__WidgetEvent__() event "OnKeyDown"

	__Doc__[[
		<desc>Run when a keyboard key is released if the frame is keyboard enabled</desc>
		<param name="key">string, name of the key pressed</param>
	]]
	__WidgetEvent__() event "OnKeyUp"

	__Doc__[[
		<desc>Run when the mouse cursor leaves the frame's interactive area</desc>
		<param name="motion">boolean, true if the handler is being run due to actual mouse movement; false if the cursor left the frame due to other circumstances (such as the frame being created underneath the cursor)</param>
	]]
	__WidgetEvent__() event "OnLeave"

	__Doc__[[Run when the frame is created, no using in IGAS coding]]
	__WidgetEvent__() event "OnLoad"

	__Doc__[[
		<desc>Run when a mouse button is pressed while the cursor is over the frame</desc>
		<param name="button">string, name of the mouse button responsible for the click action:Button4, Button5, LeftButton, MiddleButton, RightButton</param>
	]]
	__WidgetEvent__() event "OnMouseDown"

	__Doc__[[
		<desc>Run when the mouse button is released following a mouse down action in the frame</desc>
		<param name="button">string, name of the mouse button responsible for the click action:Button4, Button5, LeftButton, MiddleButton, RightButton</param>
	]]
	__WidgetEvent__() event "OnMouseUp"

	__Doc__[[
		<desc>Run when the frame receives a mouse wheel scrolling action</desc>
		<param name="delta">number, 1 for a scroll-up action, -1 for a scroll-down action</param>
	]]
	__WidgetEvent__() event "OnMouseWheel"

	__Doc__[[Run when the mouse button is released after dragging into the frame]]
	__WidgetEvent__() event "OnReceiveDrag"

	__Doc__[[Run when the frame becomes visible]]
	__WidgetEvent__() event "OnShow"

	__Doc__[[
		<desc>Run when a frame's size changes</desc>
		<param name="width">number, new width of the frame</param>
		<param name="height">number, new height of the frame</param>
	]]
	__WidgetEvent__() event "OnSizeChanged"

	__Doc__[[
		<desc>Run each time the screen is drawn by the game engine</desc>
		<param name="elapsed">number, number of seconds since the OnUpdate handlers were last run (likely a fraction of a second)</param>
	]]
	__WidgetEvent__() event "OnUpdate"

	__Doc__[[
		<desc>Run when a frame's minresize changes</desc>
		<param name="width">number, new width of the frame</param>
		<param name="height">number, new height of the frame</param>
	]]
	__WidgetEvent__() event "OnMinResizeChanged"

	__Doc__[[
		<desc>Run when a frame's minresize changes</desc>
		<param name="width">number, new width of the frame</param>
		<param name="height">number, new height of the frame</param>
	]]
	__WidgetEvent__() event "OnMaxResizeChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"AllowAttributeChanges" [[Temporarily allows insecure code to modify the frame's attributes during combat. This permission is automatically rescinded when the frame's OnUpdate script next runs.]]

	__Doc__"CanChangeAttribute" [[
		<desc>Returns whether secure frame attributes can currently be changed. Applies only to protected frames inheriting from one of the secure frame templates; frame attributes may only be changed by non-Blizzard scripts while the player is not in combat (or for a short time after a secure script calls :AllowAttributeChanges()).</desc>
		<return type="boolean">1 if secure frame attributes can currently be changed; otherwise nil</return>
	]]

	__Doc__[[
		<desc>Creates a new FontString as a child of the frame</desc>
		<param name="name">string, global name for the new font string</param>
		<param name="layer" optional="true">System.Widget.DrawLayer, graphic layer on which to create the font string; defaults to ARTWORK if not specified</param>
		<param name="inherits" optional="true">string, name of a template from which the new front string should inherit</param>
		<return type="System.Widget.FontString">Reference to the new FontString object</return>
	]]
	function CreateFontString(self, name, ...)
		return Widget["FontString"] and Widget["FontString"](name, self, ...)
	end

	__Doc__[[
		<desc>Creates a new Texture as a child of the frame. The sublevel argument can be used to provide layering of textures within a draw layer. As it can be difficult to compute the proper layering, addon authors should avoid using this option, and it's XML equivalent textureSubLevel without reason. It should also be noted that FontStrings will always appear on top of all textures in a given draw layer.</desc>
		<format>name[, layer[, inherits][, sublevel] ]</format>
		<param name="name">string, global name for the new texture</param>
		<param name="layer">System.Widget.DrawLayer, graphic layer on which to create the texture; defaults to ARTWORK if not specified</param>
		<param name="inherits">string, name of a template from which the new texture should inherit</param>
		<param name="sublevel">number, the sub-level on the given graphics layer ranging from -8- to 7. The default value of this argument is 0</param>
		<return type="System.Widget.Texture">Reference to the new Texture object</return>
	]]
	function CreateTexture(self, name, ...)
		return Widget["Texture"] and Widget["Texture"](name, self, ...)
	end

	__Doc__[[
		<desc>Creates a title region for dragging the frame. Creating a title region allows a frame to be repositioned by the user (by clicking and dragging in the region) without requiring additional scripts. (This behavior only applies if the frame is mouse enabled.)</desc>
		<return type="System.Widget.Region">Reference to the new Region object</return>
	]]
	function CreateTitleRegion(self, ...)
		return IGAS:GetWrapper(self.__UI:CreateTitleRegion(...))
	end

	__Doc__"DisableDrawLayer" [[
		<desc>Prevents display of all child objects of the frame on a specified graphics layer</desc>
		<param name="layer">System.Widget.DrawLayer, name of a graphics layer</param>
	]]

	__Doc__"EnableDrawLayer" [[
		<desc>Allows display of all child objects of the frame on a specified graphics layer</desc>
		<param name="layer">System.Widget.DrawLayer, name of a graphics layer</param>
	]]

	__Doc__"EnableJoystick" [[
		<desc>Enables or disables joystick interactivity. Joystick interactivity must be enabled in order for a frame's joystick-related script handlers to be run.</desc>
		<param name="enable">boolean, true to enable joystick interactivity; false to disable</param>
	]]

	__Doc__"EnableKeyboard" [[
		<desc>Enables or disables keyboard interactivity for the frame. Keyboard interactivity must be enabled in order for a frame's OnKeyDown, OnKeyUp, or OnChar scripts to be run.</desc>
		<param name="enable">boolean, true to enable keyboard interactivity; false to disable</param>
	]]

	__Doc__"EnableMouse" [[
		<desc>Enables or disables mouse interactivity for the frame. Mouse interactivity must be enabled in order for a frame's mouse-related script handlers to be run.</desc>
		<param name="enable">boolean, true to enable mouse interactivity; false to disable</param>
	]]

	__Doc__"EnableMouseWheel" [[
		<desc>Enables or disables mouse wheel interactivity for the frame. Mouse wheel interactivity must be enabled in order for a frame's OnMouseWheel script handler to be run.</desc>
		<param name="enable">boolean, true to enable mouse wheel interactivity; false to disable</param>
	]]

	__Doc__"GetAttribute" [[
		<desc>Returns the value of a secure frame attribute. See the secure template documentation for more information about frame attributes.</desc>
		<param name="name">string, name of an attribute to query, case insensitive</param>
		<return type="any">Value of the named attribute</return>
	]]

	__Doc__"GetBackdrop" [[
		<desc>Returns information about the frame's backdrop graphic.</desc>
		<return type="System.Widget.BackdropType">A table containing the backdrop settings, or nil if the frame has no backdrop</return>
	]]

	__Doc__"GetBackdropBorderColor" [[
		<desc>Returns the shading color for the frame's border graphic</desc>
		<return type="red">number, red component of the color (0.0 - 1.0)</return>
		<return type="green">number, green component of the color (0.0 - 1.0)</return>
		<return type="blue">number, blue component of the color (0.0 - 1.0)</return>
		<return type="alpha">number, alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__"GetBackdropColor" [[
		<desc>Returns the shading color for the frame's background graphic</desc>
		<return type="red">number, red component of the color (0.0 - 1.0)</return>
		<return type="green">number, green component of the color (0.0 - 1.0)</return>
		<return type="blue">number, blue component of the color (0.0 - 1.0)</return>
		<return type="alpha">number, alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__"GetBoundsRect" [[
		<desc>Returns the position and dimension of the smallest area enclosing the frame and its children. This information may not match that returned by :GetRect() if the frame contains textures, font strings, or child frames whose boundaries lie outside its own.</desc>
		<return type="left">number, distance from the left edge of the screen to the left edge of the area (in pixels)</return>
		<return type="bottom">number, distance from the bottom edge of the screen to the bottom of the area (in pixels)</return>
		<return type="width">number, width of the area (in pixels)</return>
		<return type="height">number, height of the area (in pixels)</return>
	]]

	__Doc__[[
		<desc>Returns a list of child frames of the frame</desc>
		<return type="...">A list of the frames which are children of this frame</return>
	]]
	function GetChildren(self, ...)
		local lst = {self.__UI:GetChildren()}

		for i, v in ipairs(lst) do
			lst[i] = IGAS:GetWrapper(v)
		end

		return unpack(lst)
	end

	__Doc__"GetClampRectInsets" [[
		<desc>Returns offsets from the frame's edges used when limiting user movement or resizing of the frame. Note: despite the name of this method, the values are all offsets along the normal axes, so to inset the frame's clamping area from its edges, the left and bottom measurements should be positive and the right and top measurements should be negative.</desc>
		<return type="left">number, offset from the left edge of the frame to the left edge of its clamping area (in pixels)</return>
		<return type="right">number, offset from the right edge of the frame's clamping area to the right edge of the frame (in pixels)</return>
		<return type="top">number, offset from the top edge of the frame's clamping area to the top edge of the frame (in pixels)</return>
		<return type="bottom">number, offset from the bottom edge of the frame to the bottom edge of its clamping area (in pixels)</return>
	]]

	__Doc__"GetDepth" [[
		<desc>Returns the 3D depth of the frame (for stereoscopic 3D setups)</desc>
		<return type="number">apparent 3D depth of this frame relative to that of its parent frame</return>
	]]

	__Doc__"GetDontSavePosition" [[
		@desc
		<return type="boolean"></return>
	]]

	__Doc__"GetEffectiveAlpha" [[
		<desc>Returns the overall opacity of the frame. Unlike :GetAlpha() which returns the opacity of the frame relative to its parent, this function returns the absolute opacity of the frame, taking into account the relative opacity of parent frames.</desc>
		<return type="number,">effective alpha (opacity) of the region (0.0 = fully transparent, 1.0 = fully opaque)</return>
	]]

	__Doc__"GetEffectiveDepth" [[
		<desc>Returns the overall 3D depth of the frame (for stereoscopic 3D configurations). Unlike :GetDepth() which returns the apparent depth of the frame relative to its parent, this function returns the absolute depth of the frame, taking into account the relative depths of parent frames.</desc>
		<return type="number,">apparent 3D depth of this frame relative to the screen</return>
	]]

	__Doc__"GetEffectiveScale" [[
		<desc>Returns the overall scale factor of the frame. Unlike :GetScale() which returns the scale factor of the frame relative to its parent, this function returns the absolute scale factor of the frame, taking into account the relative scales of parent frames.</desc>
		<return type="number,">scale factor for the frame relative to its parent</return>
	]]

	__Doc__"GetFrameLevel" [[
		<desc>Gets the level at which the frame is layered relative to others in its strata. Frames with higher frame level are layered "in front of" frames with a lower frame level. When not set manually, a frame's level is determined by its place in the frame hierarchy -- e.g. UIParent's level is 1, children of UIParent are at level 2, children of those frames are at level 3, etc.</desc>
		<return type="number,">layering level of the frame relative to others in its frameStrata</return>
	]]

	__Doc__"GetFrameStrata" [[
		<desc>Returns the general layering strata of the frame</desc>
		<return type="System.Widget.FrameStrata">Token identifying the strata in which the frame should be layered</return>
	]]

	__Doc__"GetHitRectInsets" [[
		<desc>Returns the insets from the frame's edges which determine its mouse-interactable area</desc>
		<return type="left">number, distance from the left edge of the frame to the left edge of its mouse-interactive area (in pixels)</return>
		<return type="right">number, distance from the right edge of the frame to the right edge of its mouse-interactive area (in pixels)</return>
		<return type="top">number, distance from the top edge of the frame to the top edge of its mouse-interactive area (in pixels)</return>
		<return type="bottom">number, distance from the bottom edge of the frame to the bottom edge of its mouse-interactive area (in pixels)</return>
	]]

	__Doc__"GetID" [[
		<desc>Returns the frame's numeric identifier. Frame IDs have no effect on frame behavior, but can be a useful way to keep track of multiple similar frames, especially in cases where a list of frames is created from a template (such as for action buttons, loot slots, or lines in a FauxScrollFrame).</desc>
		<return type="number,">a numeric identifier for the frame</return>
	]]

	__Doc__"GetMaxResize" [[
		<desc>Returns the maximum size of the frame for user resizing. Applies when resizing the frame with the mouse via :StartSizing().</desc>
		<return type="maxWidth">number, maximum width of the frame (in pixels), or 0 for no limit</return>
		<return type="maxHeight">number, maximum height of the frame (in pixels), or 0 for no limit</return>
	]]

	__Doc__"GetMinResize" [[
		<desc>Returns the minimum size of the frame for user resizing. Applies when resizing the frame with the mouse via :StartSizing().</desc>
		<return type="minWidth">number, minimum width of the frame (in pixels), or 0 for no limit</return>
		<return type="minHeight">number, minimum height of the frame (in pixels), or 0 for no limit</return>
	]]

	__Doc__"GetNumChildren" [[
		<desc>Returns the number of child frames belonging to the frame</desc>
		<return type="number">Number of child frames belonging to the frame</return>
	]]

	__Doc__"GetNumRegions" [[
		<desc>Returns the number of non-Frame child regions belonging to the frame</desc>
		<return type="number">Number of non-Frame child regions (FontStrings and Textures) belonging to the frame</return>
	]]

	__Doc__"GetPropagateKeyboardInput" [[
		<return type="boolean"></return>
	]]

	__Doc__[[
		<desc>Returns a list of non-Frame child regions belonging to the frame</desc>
		<return type="...">- A list of each non-Frame child region (FontString or Texture) belonging to the frame (list)</return>
	]]
	function GetRegions(self, ...)
		local lst = {self.__UI:GetRegions(...)}

		for i, v in ipairs(lst) do
			lst[i] = IGAS:GetWrapper(v)
		end

		return unpack(lst)
	end

	__Doc__"GetScale" [[
		<desc>Returns the frame's scale factor</desc>
		<return type="number">Scale factor for the frame relative to its parent</return>
	]]

	__Doc__[[
		<desc>Returns the frame's TitleRegion object.</desc>
		<return type="System.Widget.Region">Reference to the frame's TitleRegion object</return>
	]]
	function GetTitleRegion(self, ...)
		return IGAS:GetWrapper(self.__UI:GetTitleRegion(...))
	end

	__Doc__"IgnoreDepth" [[
		<desc>Sets whether the frame's depth property is ignored (for stereoscopic 3D setups). If a frame's depth property is ignored, the frame itself is not rendered with stereoscopic 3D separation, but 3D graphics within the frame may be; this property is used on the default UI's WorldFrame.</desc>
		<param name="enable">boolean, true to ignore the frame's depth property; false to disable</param>
	]]

	__Doc__"IsClampedToScreen" [[
		<desc>Returns whether the frame's boundaries are limited to those of the screen</desc>
		<return type="boolean">1 if the frame's boundaries are limited to those of the screen when user moving/resizing; otherwise nil</return>
	]]

	__Doc__"IsIgnoringDepth" [[
		<desc>Returns whether the frame's depth property is ignored (for stereoscopic 3D setups)</desc>
		<return type="boolean">1 if the frame's depth property is ignored; otherwise nil</return>
	]]

	__Doc__"IsJoystickEnabled" [[
		<desc>Returns whether joystick interactivity is enabled for the frame. (As of this writing, joystick support is partially implemented but not enabled in the current version of World of Warcraft.)</desc>
		<return type="boolean">1 if joystick interactivity is enabled for the frame; otherwise nil</return>
	]]

	__Doc__"IsKeyboardEnabled" [[
		<desc>Returns whether keyboard interactivity is enabled for the frame</desc>
		<return type="boolean">1 if keyboard interactivity is enabled for the frame; otherwise nil</return>
	]]

	__Doc__"IsMouseEnabled" [[
		<desc>Returns whether mouse interactivity is enabled for the frame</desc>
		<return type="boolean">1 if mouse interactivity is enabled for the frame; otherwise nil</return>
	]]

	__Doc__"IsMouseWheelEnabled" [[
		<desc>Returns whether mouse wheel interactivity is enabled for the frame</desc>
		<return type="boolean">1 if mouse wheel interactivity is enabled for the frame; otherwise nil</return>
	]]

	__Doc__"IsMovable" [[
		<desc>Returns whether the frame can be moved by the user</desc>
		<return type="boolean">1 if the frame can be moved by the user; otherwise nil</return>
	]]

	__Doc__"IsResizable" [[
		<desc>Returns whether the frame can be resized by the user</desc>
		<return type="boolean">1 if the frame can be resized by the user; otherwise nil</return>
	]]

	__Doc__"IsToplevel" [[
		<desc>Returns whether the frame is automatically raised to the front when clicked</desc>
		<return type="boolean">1 if the frame is automatically raised to the front when clicked; otherwise nil</return>
	]]

	__Doc__"IsUserPlaced" [[
		<desc>Returns whether the frame is flagged for automatic saving and restoration of position and dimensions</desc>
		<return type="boolean">1 if the frame is flagged for automatic saving and restoration of position and dimensions; otherwise nil</return>
	]]

	__Doc__"Lower" [[Reduces the frame's frame level below all other frames in its strata]]

	__Doc__"Raise" [[Increases the frame's frame level above all other frames in its strata]]

	__Doc__"RegisterAllEvents" [[Registers the frame for all events. This method is recommended for debugging purposes only, as using it will cause the frame's OnEvent script handler to be run very frequently for likely irrelevant events. (For code that needs to be run very frequently, use an OnUpdate script handler.)]]

	__Doc__"RegisterForDrag" [[
		<desc>Registers the frame for dragging. Once the frame is registered for dragging (and mouse enabled), the frame's OnDragStart and OnDragStop scripts will be called when the specified mouse button(s) are clicked and dragged starting from within the frame (or its mouse-interactive area).</desc>
		<param name="...">A list of strings, each the name of a mouse button for which the frame should respond to drag actions</param>
	]]

	__Doc__"SetAttribute" [[
		<desc>Sets a secure frame attribute. See the secure template documentation for more information about frame attributes.</desc>
		<param name="name">string, name of an attribute, case insensitive</param>
		<param name="value">any, new value to set for the attribute</param>
	]]

	__Doc__[[
		<desc>Sets a backdrop graphic for the frame. See example for details of the backdrop table format.</desc>
		<param name="backdrop">System.Widget.BackdropType A table containing the backdrop settings, or nil to remove the frame's backdrop</param>
	]]
	function SetBackdrop(self, backdropTable)
		return self.__UI:SetBackdrop(backdropTable or nil)
	end

	__Doc__"SetBackdropBorderColor" [[
		<desc>Sets a shading color for the frame's border graphic. As with Texture:SetVertexColor(), this color is a shading applied to the colors of the texture image; a color of (1, 1, 1) allows the image's original colors to show.</desc>
		<param name="red">number, red component of the color (0.0 - 1.0)</param>
		<param name="green">number, green component of the color (0.0 - 1.0)</param>
		<param name="blue">number, blue component of the color (0.0 - 1.0)</param>
		<param name="alpha">number, alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__"SetBackdropColor" [[
		<desc>Sets a shading color for the frame's background graphic. As with Texture:SetVertexColor(), this color is a shading applied to the colors of the texture image; a color of (1, 1, 1) allows the image's original colors to show.</desc>
		<param name="red">number, red component of the color (0.0 - 1.0)</param>
		<param name="green">number, green component of the color (0.0 - 1.0)</param>
		<param name="blue">number, blue component of the color (0.0 - 1.0)</param>
		<param name="alpha">number, alpha (opacity) for the graphic (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__"SetClampedToScreen" [[
		<desc>Sets whether the frame's boundaries should be limited to those of the screen. Applies to user moving/resizing of the frame (via :StartMoving(), :StartSizing(), or title region); attempting to move or resize the frame beyond the edges of the screen will move/resize it no further than the edge of the screen closest to the mouse position. Does not apply to programmatically setting the frame's position or size.</desc>
		<param name="enable">boolean, true to limit the frame's boundaries to those of the screen; false to allow the frame to be moved/resized without such limits</param>
	]]

	__Doc__"SetClampRectInsets" [[
		<desc>Sets offsets from the frame's edges used when limiting user movement or resizing of the frame. Note: despite the name of this method, the parameters are offsets along the normal axes -- to inset the frame's clamping area from its edges, the left and bottom measurements should be positive and the right and top measurements should be negative.</desc>
		<param name="left">number, offset from the left edge of the frame to the left edge of its clamping area (in pixels)</param>
		<param name="right">number, offset from the right edge of the frame's clamping area to the right edge of the frame (in pixels)</param>
		<param name="top">number, offset from the top edge of the frame's clamping area to the top edge of the frame (in pixels)</param>
		<param name="bottom">number, offset from the bottom edge of the frame to the bottom edge of its clamping area (in pixels)</param>
	]]

	__Doc__"SetDepth" [[
		<desc>Sets the 3D depth of the frame (for stereoscopic 3D configurations)</desc>
		<param name="depth">number, apparent 3D depth of this frame relative to that of its parent frame</param>
		]]

	__Doc__"SetDontSavePosition" [[
		<param name="boolean"></param>
	]]

	__Doc__"SetFrameLevel" [[
		<desc>Sets the level at which the frame is layered relative to others in its strata. Frames with higher frame level are layered "in front of" frames with a lower frame level.</desc>
		<param name="level">number, layering level of the frame relative to others in its frameStrata</param>
	]]

	__Doc__"SetFrameStrata" [[
		<desc>Sets the general layering strata of the frame. Where frame level provides fine control over the layering of frames, frame strata provides a coarser level of layering control: frames in a higher strata always appear "in front of" frames in lower strata regardless of frame level.</desc>
		<param name="strata">System.Widget.FrameStrata, token identifying the strata in which the frame should be layered</param>
	]]

	__Doc__"SetHitRectInsets" [[
		<desc>Sets the insets from the frame's edges which determine its mouse-interactable area</desc>
		<param name="left">number, distance from the left edge of the frame to the left edge of its mouse-interactive area (in pixels)</param>
		<param name="right">number, distance from the right edge of the frame to the right edge of its mouse-interactive area (in pixels)</param>
		<param name="top">number, distance from the top edge of the frame to the top edge of its mouse-interactive area (in pixels)</param>
		<param name="bottom">number, distance from the bottom edge of the frame to the bottom edge of its mouse-interactive area (in pixels)</param>
	]]

	__Doc__"SetID" [[
		<desc>Sets a numeric identifier for the frame. Frame IDs have no effect on frame behavior, but can be a useful way to keep track of multiple similar frames, especially in cases where a list of frames is created from a template (such as for action buttons, loot slots, or lines in a FauxScrollFrame).</desc>
		<param name="id">number, a numeric identifier for the frame</param>
	]]

	__Doc__[[
		<desc>Sets the maximum size of the frame for user resizing. Applies when resizing the frame with the mouse via :StartSizing().</desc>
		<param name="maxWidth">number, maximum width of the frame (in pixels), or 0 for no limit</param>
		 <param name="maxHeight">number, maximum height of the frame (in pixels), or 0 for no limit</param>
	]]
	function SetMaxResize(self, maxWidth, maxHeight)
		self.__UI:SetMaxResize(maxWidth, maxHeight)
		return self:Fire("OnMaxResizeChanged", maxWidth, maxHeight)
	end

	__Doc__[[
		<desc>Sets the minimum size of the frame for user resizing. Applies when resizing the frame with the mouse via :StartSizing().</desc>
		<param name="minWidth">number, minimum width of the frame (in pixels), or 0 for no limit</param>
		<param name="minHeight">number, minimum height of the frame (in pixels), or 0 for no limit</param>
	]]
	function SetMinResize(self, minWidth, minHeight)
		self.__UI:SetMinResize(minWidth, minHeight)
		return self:Fire("OnMinResizeChanged", minWidth, minHeight)
	end

	__Doc__"SetMovable" [[
		<desc>Sets whether the frame can be moved by the user. Enabling this property does not automatically implement behaviors allowing the frame to be dragged by the user -- such behavior must be implemented in the frame's mouse script handlers. If this property is not enabled, Frame:StartMoving() causes a Lua error.</desc>
		<param name="enable">boolean, true to allow the frame to be moved by the user; false to disable</param>
	]]

	__Doc__"SetPropagateKeyboardInput" [[
		<param name="enable">boolean</param>
	]]

	__Doc__"SetResizable" [[
		<desc>Sets whether the frame can be resized by the user. Enabling this property does not automatically implement behaviors allowing the frame to be drag-resized by the user -- such behavior must be implemented in the frame's mouse script handlers. If this property is not enabled, Frame:StartSizing() causes a Lua error.</desc>
		<param name="enable">boolean, true to allow the frame to be resized by the user; false to disable</param>
		]]

	__Doc__"SetScale" [[
		<desc>Sets the frame's scale factor. A frame's scale factor affects the size at which it appears on the screen relative to that of its parent. The entire interface may be scaled by changing UIParent's scale factor (as can be done via the Use UI Scale setting in the default interface's Video Options panel).</desc>
		<param name="scale">number, scale factor for the frame relative to its parent</param>
	]]

	__Doc__"SetToplevel" [[
		<desc>Sets whether the frame should automatically come to the front when clicked. When a frame with Toplevel behavior enabled is clicked, it automatically changes its frame level such that it is greater than (and therefore drawn "in front of") all other frames in its strata.</desc>
		<param name="enable">boolean, true to cause the frame to automatically come to the front when clicked; false otherwise</param>
	]]

	__Doc__"SetUserPlaced" [[
		<desc>Flags the frame for automatic saving and restoration of position and dimensions. The position and size of frames so flagged is automatically saved when the UI is shut down (as when quitting, logging out, or reloading) and restored when the UI next starts up (as when logging in or reloading). If the frame does not have a name (set at creation time) specified, its position will not be saved. As implied by its name, enabling this property is useful for frames which can be moved or resized by the user.</desc>
		<param name="enable">boolean, true to enable automatic saving and restoration of the frame's position and dimensions; false to disable</param>
	]]

	__Doc__"StartMoving" [[Begins repositioning the frame via mouse movement]]

	__Doc__"StartSizing" [[Begins resizing the frame via mouse movement]]

	__Doc__"StopMovingOrSizing" [[Ends movement or resizing of the frame initiated with object:StartMoving() or object:StartSizing()]]

	__Doc__"IsEventRegistered" [[
		<desc>Check if the widget object has registered the given name event</desc>
		<param name="name">string, the event's name</param>
		<return type="boolean">true if the event is registered</return>
	]]

	__Doc__[[
		<desc>Register event for the object</desc>
		<param name="event">string, the event's name</param>
	]]
	function RegisterEvent(self, event)
		IGAS:GetUI(self):RegisterEvent(event)
		self.OnEvent = self.OnEvent + OnEvent
	end

	__Doc__"UnregisterAllEvents" [[Un-register all events]]

	__Doc__"UnregisterEvent" [[
		<desc>Un-register given name event</desc>
		<param name="event">string, the event's name</param>
	]]

	function RegisterUnitEvent(self, evt, ...)
		IGAS:GetUI(self):RegisterUnitEvent(evt, ...)
		self.OnEvent = self.OnEvent + OnEvent
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	function OnEvent(self, event, ...)
		if type(self[event]) == "function" then
			return self[event](self, ...)
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		self:UnregisterAllEvents()
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("Frame", nil, parent, ...)
	end
endclass "Frame"

class "Frame"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Frame)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[whether keyboard interactivity is enabled for the frame]]
	property "KeyboardEnabled" { Type = Boolean }

	__Doc__[[whether mouse interactivity is enabled for the frame]]
	property "MouseEnabled" { Type = Boolean }

	__Doc__[[whether the frame can be moved by the user]]
	property "Movable" { Type = Boolean }

	__Doc__[[whether the frame can be resized by the user]]
	property "Resizable" { Type = Boolean }

	__Doc__[[whether mouse wheel interactivity is enabled for the frame]]
	property "MouseWheelEnabled" { Type = Boolean }

	__Doc__[[the backdrop graphic for the frame]]
	property "Backdrop" { Type = BackdropType }

	__Doc__[[the shading color for the frame's border graphic]]
	property "BackdropBorderColor" {
		Get = function(self)
			return ColorType(self:GetBackdropBorderColor())
		end,
		Set = function(self, colorTable)
			self:SetBackdropBorderColor(colorTable.r, colorTable.g, colorTable.b, colorTable.a)
		end,
		Type = ColorType,
	}

	__Doc__[[the shading color for the frame's background graphic]]
	property "BackdropColor" {
		Get = function(self)
			return ColorType(self:GetBackdropColor())
		end,
		Set = function(self, colorTable)
			self:SetBackdropColor(colorTable.r, colorTable.g, colorTable.b, colorTable.a)
		end,
		Type = ColorType,
	}

	__Doc__[[whether the frame's boundaries are limited to those of the screen]]
	property "ClampedToScreen" { Type = Boolean }

	__Doc__[[offsets from the frame's edges used when limiting user movement or resizing of the frame]]
	property "ClampRectInsets" {
		Get = function(self)
			return Inset(self:GetClampRectInsets())
		end,
		Set = function(self, RectInset)
			self:SetClampRectInsets(RectInset.left, RectInset.right, RectInset.top, RectInset.bottom)
		end,
		Type = Inset,
	}

	__Doc__[[the level at which the frame is layered relative to others in its strata]]
	property "FrameLevel" { Type = Number }

	__Doc__[[the general layering strata of the frame]]
	property "FrameStrata" { Type = FrameStrata }

	__Doc__[[the insets from the frame's edges which determine its mouse-interactable area]]
	property "HitRectInsets" {
		Get = function(self)
			return Inset(self:GetHitRectInsets())
		end,
		Set = function(self, RectInset)
			self:SetHitRectInsets(RectInset.left, RectInset.right, RectInset.top, RectInset.bottom)
		end,
		Type = Inset,
	}

	__Doc__[[a numeric identifier for the frame]]
	property "ID" { Type = Number }

	__Doc__[[the maximum size of the frame for user resizing]]
	property "MaxResize" {
		Get = function(self)
			return Size(self:GetMaxResize())
		end,
		Set = function(self, size)
			self:SetMaxResize(size.width, size.height)
		end,
		Type = Size,
	}

	__Doc__[[the minimum size of the frame for user resizing]]
	property "MinResize" {
		Get = function(self)
			return Size(self:GetMinResize())
		end,
		Set = function(self, size)
			self:SetMinResize(size.width, size.height)
		end,
		Type = Size,
	}

	__Doc__[[the frame's scale factor]]
	property "Scale" { Type = Number }

	__Doc__[[whether the frame should automatically come to the front when clicked]]
	property "Toplevel" { Type = Boolean }

	__Doc__[[the 3D depth of the frame (for stereoscopic 3D setups)]]
	property "Depth" { Type = Number }

	__Doc__[[whether the frame's depth property is ignored (for stereoscopic 3D setups)]]
	property "DepthIgnored" { Type = Boolean }

	property "FlattensRenderLayers" { Type = Boolean }
endclass "Frame"
