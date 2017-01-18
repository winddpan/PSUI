-- Author      : Kurapica
-- Create Date : 7/16/2008 12:29
-- Change Log  :
--				2011/03/13	Recode as class

-- Check Version
local version = 6
if not IGAS:NewAddon("IGAS.Widget.Model", version) then
	return
end

__Doc__[[Model provide a rendering environment which is drawn into the backdrop of their frame, allowing you to display the contents of an .m2 file and set facing, scale, light and fog information, or run motions associated]]
__AutoProperty__()
class "Model"
	inherit "Frame"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Run when the model's animation finishes]]
	__WidgetEvent__() event "OnAnimFinished"

	__Doc__[[Run when a model changes or animates]]
	__WidgetEvent__() event "OnUpdateModel"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"AdvanceTime" [[Advances to the model's next animation frame. (Applies to 3D animations defined within the model file, not UI Animations.)]]

	__Doc__"ClearFog" [[Disables fog display for the model.]]

	__Doc__"ClearModel" [[Removes the 3D model currently displayed]]

	__Doc__"GetFacing" [[
		<desc>Returns the model's current rotation setting. The 3D model displayed by the model object can be rotated about its vertical axis. For example, a model of a player race faces towards the viewer when its facing is set to 0; setting facing to math.pi faces it away from the viewer.</desc>
		<return type="number">Current rotation angle of the model (in radians)</return>
	]]

	__Doc__"GetFogColor" [[
		<desc>Returns the model's current fog color. Does not indicate whether fog display is enabled.</desc>
		<return type="red">number, red component of the color (0.0 - 1.0)</return>
		<return type="green">number, green component of the color (0.0 - 1.0)</return>
		<return type="blue">number, blue component of the color (0.0 - 1.0)</return>
	]]

	__Doc__"GetFogFar" [[
		<desc>Returns the far clipping distance for the model's fog. This determines how far from the camera the fog ends.</desc>
		<return type="number">The distance to the fog far clipping plane</return>
	]]

	__Doc__"GetFogNear" [[
		<desc>Returns the near clipping distance for the model's fog. This determines how close to the camera the fog begins.</desc>
		<return type="number">The distance to the fog near clipping plane</return>
	]]

	__Doc__"GetLight" [[
		<desc>Returns properties of the light sources used when rendering the model</desc>
		<return type="enabled">boolean, 1 if lighting is enabled; otherwise nil</return>
		<return type="omni">number, 1 if omnidirectional lighting is enabled; otherwise 0</return>
		<return type="dirX">number, coordinate of the directional light in the axis perpendicular to the screen (negative values place the light in front of the model, positive values behind)</return>
		<return type="dirY">number, coordinate of the directional light in the horizontal axis (negative values place the light to the left of the model, positive values to the right)</return>
		<return type="dirZ">number, coordinate of the directional light in the vertical axis (negative values place the light below the model, positive values above</return>
		<return type="ambIntensity">number, intensity of the ambient light (0.0 - 1.0)</return>
		<return type="ambR">number, red component of the ambient light color (0.0 - 1.0); omitted if ambIntensity is 0</return>
		<return type="ambG">number, green component of the ambient light color (0.0 - 1.0); omitted if ambIntensity is 0</return>
		<return type="ambB">number, blue component of the ambient light color (0.0 - 1.0); omitted if ambIntensity is 0</return>
		<return type="dirIntensity">number, intensity of the directional light (0.0 - 1.0)</return>
		<return type="dirR">number, red component of the directional light color (0.0 - 1.0); omitted if dirIntensity is 0</return>
		<return type="dirG">number, green component of the directional light color (0.0 - 1.0); omitted if dirIntensity is 0</return>
		<return type="dirB">number, blue component of the directional light color (0.0 - 1.0); omitted if dirIntensity is 0</return>
	]]

	__Doc__"GetModel" [[
		<desc>Returns the model file currently displayed. May instead return a reference to the Model object itself if a filename is not available.</desc>
		<return type="string">Path to the model file currently displayed</return>
	]]

	__Doc__"GetModelScale" [[
		<desc>Returns the scale factor determining the size at which the 3D model appears</desc>
		<return type="number">Scale factor determining the size at which the 3D model appears</return>
	]]

	__Doc__"GetPosition" [[
		<desc>Returns the position of the 3D model within the frame</desc>
		@<return type="x">number, position of the model on the axis perpendicular to the plane of the screen (positive values make the model appear closer to the viewer; negative values place it further away)</return>
		<return type="y">number, position of the model on the horizontal axis (positive values place the model to the right of its default position; negative values place it to the left)</return>
		<return type="z">number, position of the model on the vertical axis (positive values place the model above its default position; negative values place it below)</return>
	]]

	__Doc__"ReplaceIconTexture" [[
		<desc>Sets the icon texture used by the model. Only affects models that use icons (e.g. the model producing the default UI's animation which appears when an item goes into a bag).</desc>
		<param name="filename">string, Path to an icon texture for use in the model</param>
	]]

	__Doc__"SetCamera" [[
		<desc>Sets the view angle on the model to a pre-defined camera location. Camera view angles are defined within the model files and not otherwise available to the scripting system.</desc>
		<param name="index">number, index of a camera view defined by the model file</param>
	]]

	__Doc__"SetFacing" [[
		<desc>Sets the model's current rotation. The 3D model displayed by the model object can be rotated about its vertical axis. For example, if the model faces towards the viewer when its facing is set to 0, setting facing to math.pi faces it away from the viewer.</desc>
		<param name="facing">number, rotation angle for the model (in radians)</param>
	]]

	__Doc__"SetFogColor" [[
		<desc>Sets the model's fog color, enabling fog display if disabled</desc>
		<param name="red">number, red component of the color (0.0 - 1.0)</param>
		<param name="green">number, green component of the color (0.0 - 1.0)</param>
		<param name="blue">number, blue component of the color (0.0 - 1.0)</param>
	]]

	__Doc__"SetFogFar" [[
		<desc>Sets the far clipping distance for the model's fog. This sets how far from the camera the fog ends.</desc>
		<param name="distance">number, the distance to the fog far clipping plane</param>
	]]

	__Doc__"SetFogNear" [[
		<desc>Sets the near clipping distance for the model's fog. This sets how close to the camera the fog begins.</desc>
		<param name="distance">number, The distance to the fog near clipping plane</param>
	]]

	__Doc__"SetGlow" [[
		<desc>Sets the model's glow amount</desc>
		<param name="amount">number, glow amount for the model</param>
	]]

	__Doc__"SetLight" [[
		<desc>Sets properties of the light sources used when rendering the model</desc>
		<param name="enabled">boolean, 1 if lighting is enabled; otherwise nil</param>
		<param name="omni">number, 1 if omnidirectional lighting is enabled; otherwise 0</param>
		<param name="dirX">number, coordinate of the directional light in the axis perpendicular to the screen (negative values place the light in front of the model, positive values behind)</param>
		<param name="dirY">number, coordinate of the directional light in the horizontal axis (negative values place the light to the left of the model, positive values to the right)</param>
		<param name="dirZ">number, coordinate of the directional light in the vertical axis (negative values place the light below the model, positive values above</param>
		<param name="ambIntensity">number, intensity of the ambient light (0.0 - 1.0)</param>
		<param name="ambR">number, red component of the ambient light color (0.0 - 1.0); omitted if ambIntensity is 0</param>
		<param name="ambG">number, green component of the ambient light color (0.0 - 1.0); omitted if ambIntensity is 0</param>
		<param name="ambB">number, blue component of the ambient light color (0.0 - 1.0); omitted if ambIntensity is 0</param>
		<param name="dirIntensity">number, intensity of the directional light (0.0 - 1.0)</param>
		<param name="dirR">number, red component of the directional light color (0.0 - 1.0); omitted if dirIntensity is 0</param>
		<param name="dirG">number, green component of the directional light color (0.0 - 1.0); omitted if dirIntensity is 0</param>
		<param name="dirB">number, blue component of the directional light color (0.0 - 1.0); omitted if dirIntensity is 0</param>
	]]

	__Doc__"SetModel" [[
		<desc>Sets the model file to be displayed</desc>
		<param name="filename">string, path to the model file to be displayed</param>
	]]

	__Doc__"SetModelScale" [[
		<desc>Sets the scale factor determining the size at which the 3D model appears</desc>
		<param name="scale">number, scale factor determining the size at which the 3D model appears</param>
	]]

	__Doc__"SetPosition" [[
		<desc>Set the position of the 3D model within the frame</desc>
		<param name="x">number, position of the model on the axis perpendicular to the plane of the screen (positive values make the model appear closer to the viewer; negative values place it further away)</param>
		<param name="y">number, position of the model on the horizontal axis (positive values place the model to the right of its default position; negative values place it to the left)</param>
		<param name="z">number, position of the model on the vertical axis (positive values place the model above its default position; negative values place it below)</param>
	]]

	__Doc__"SetSequence" [[
		<desc>Sets the animation sequence to be used by the model. The number of available sequences and behavior of each are defined within the model files and not available to the scripting system.</desc>
		<param name="sequence">number, index of an animation sequence defined by the model file</param>
	]]

	__Doc__"SetSequenceTime" [[
		<desc>Sets the animation sequence and time index to be used by the model. The number of available sequences and behavior of each are defined within the model files and not available to the scripting system.</desc>
		<param name="sequence">number, index of an animation sequence defined by the model file</param>
		<param name="time">number, time index within the sequence</param>
	]]

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("Model", nil, parent, ...)
	end
endclass "Model"

class "Model"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(Model)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the model's current fog color]]
	property "FogColor" {
		Get = function(self)
			return ColorType(self:GetFogColor())
		end,
		Set = function(self, colorTable)
			self:SetFogColor(colorTable.r, colorTable.g, colorTable.b, colorTable.a)
		end,
		Type = ColorType,
	}

	__Doc__[[the far clipping distance for the model's fog]]
	property "FogFar" { Type = Number }

	__Doc__[[the near clipping distance for the model's fog]]
	property "FogNear" { Type = Number }

	__Doc__[[the scale factor determining the size at which the 3D model appears]]
	property "ModelScale" { Type = Number }

	__Doc__[[the model file to be displayed]]
	property "Model" {
		Set = function(self, file)
			if file and type(file) == "string" and file ~= "" then
				self:SetModel(file)
			else
				self:ClearModel()
			end
		end,
		--Get = "GetModel",
		Type = String,
	}

	__Doc__[[the position of the 3D model within the frame]]
	property "Position" {
		Get = function(self)
			return Position(self:GetPosition())
		end,
		Set = function(self, value)
			self:SetPosition(value.x, value.y, value.z)
		end,
		Type = Position,
	}

	__Doc__[[the light sources used when rendering the model]]
	property "Light" {
		Get = function(self)
			return LightType(self:GetLight())
		end,
		Set = function(self, set)
			self:SetLight(set.enabled, set.omni, set.dirX, set.dirY, set.dirZ, set.ambIntensity, set.ambR, set.ambG, set.ambB, set.dirIntensity, set.dirR, set.dirG, set.dirB)
		end,
		Type = LightType,
	}
endclass "Model"
