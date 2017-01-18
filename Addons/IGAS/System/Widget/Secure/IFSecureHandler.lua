-- Author      : Kurapica
-- Create Date : 2012/07/02
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.IFSecureHandler", version) then
	return
end

_SecureHandlerExecute = SecureHandlerExecute
_SecureHandlerWrapScript = SecureHandlerWrapScript
_SecureHandlerUnwrapScript = SecureHandlerUnwrapScript
_SecureHandlerSetFrameRef = SecureHandlerSetFrameRef

_RegisterAttributeDriver = RegisterAttributeDriver
_UnregisterAttributeDriver = UnregisterAttributeDriver
_RegisterStateDriver = RegisterStateDriver
_UnregisterStateDriver = UnregisterStateDriver
_RegisterUnitWatch = RegisterUnitWatch
_UnregisterUnitWatch = UnregisterUnitWatch
_UnitWatchRegistered = UnitWatchRegistered

__Doc__[[IFSecureHandler contains several secure methods for secure frames]]
interface "IFSecureHandler"

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Execute a snippet against a header frame</desc>
		<param name="body">string, the snippet to be executed for the frame</param>
		<usage>object:Execute("print(1, 2, 3)"</usage>
	]]
	function Execute(self, body)
		self = IGAS:GetUI(self)

		return _SecureHandlerExecute(self, body)
	end

	__Doc__[[
		<desc>Wrap the script on a frame to invoke snippets against a header</desc>
		<param name="frame">System.Widget.Frame, the frame which's script is to be wrapped</param>
		<param name="script">string, the script handle name</param>
		<param name="preBody">string, the snippet to be executed before the original script handler</param>
		<param name="postBody">string, the snippet to be executed after the original script handler</param>
		<usage>object:WrapScript(button, "OnEnter", "")</usage>
	]]
	function WrapScript(self, frame, script, preBody, postBody)
		self = IGAS:GetUI(self)
		frame = IGAS:GetUI(frame)

		return _SecureHandlerWrapScript(frame, script, self, preBody, postBody)
	end

	__Doc__[[
		<desc>Remove previously applied wrapping, returning its details</desc>
		<param name="frame">System.Widget.Frame, the frame which's script is to be wrapped</param>
		<param name="script">name, the script handle name</param>
		<return type="header">System.Widget.Frame, self's handler</return>
		<return type="preBody">string, the snippet to be executed before the original script handler</return>
		<return type="postBody">string, the snippet to be executed after the original script handler</return>
		<usage>object:UnwrapScript(button, "OnEnter")</usage>
	]]
	function UnwrapScript(self, frame, script)
		self = IGAS:GetUI(self)
		frame = IGAS:GetUI(frame)

		return _SecureHandlerUnwrapScript(frame, script)
	end

	__Doc__[[
		<desc>Create a frame handle reference and store it against a frame</desc>
		<param name="label">string, the frame handle's reference name</param>
		<param name="refFrame">System.Widget.Frame, the frame</param>
		<usage>object:SetFrameRef("MyButton", button)</usage>
	]]
	function SetFrameRef(self, label, refFrame)
		self = IGAS:GetUI(self)
		refFrame = IGAS:GetUI(refFrame)

		return _SecureHandlerSetFrameRef(self, label, refFrame)
	end

	__Doc__[[
		<desc>Register a frame attribute to be set automatically with changes in game state</desc>
		<param name="attribute">string</param>
		<param name="values">string</param>
		<usage>object:RegisterAttributeDriver("hasunit", "[@mouseover, exists] true; false")</usage>
	]]
	function RegisterAttributeDriver(self, attribute, values)
		self = IGAS:GetUI(self)

		return _RegisterAttributeDriver(self, attribute, values)
	end

	__Doc__[[
		<desc>Unregister a frame from the state driver manager</desc>
		<param name="attribute">string</param>
		<param name="values">string</param>
		<usage>object:UnregisterAttributeDriver("hasunit")</usage>
	]]
	function UnregisterAttributeDriver(self, attribute, values)
		self = IGAS:GetUI(self)

		return _UnregisterAttributeDriver(self, attribute, values)
	end

	__Doc__[[
		<desc>Register a frame state to be set automatically with changes in game state</desc>
		<param name="state"></param>
		<param name="values"></param>
		<usage>object:RegisterStateDriver("hasunit", "[@mouseover, exists] true; false")</usage>
	]]
	function RegisterStateDriver(self, state, values)
		self = IGAS:GetUI(self)

		return _RegisterStateDriver(self, state, values)
	end

	__Doc__[[
		<desc>Unregister a frame from the state driver manager</desc>
		<param name="state"></param>
		<param name="values"></param>
		<usage>object:UnregisterStateDriver("hasunit")</usage>
	]]
	function UnregisterStateDriver(self, state)
		self = IGAS:GetUI(self)

		return _UnregisterStateDriver(self, state)
	end

	__Doc__[[
		<desc>Register a frame to be notified when a unit's existence changes</desc>
		<format>[asState]</format>
		<usage>object:RegisterUnitWatch()</usage>
	]]
	function RegisterUnitWatch(self, asState)
		self = IGAS:GetUI(self)

		return _RegisterUnitWatch(self, asState)
	end

	__Doc__[[Unregister a frame from the unit existence monitor]]
	function UnregisterUnitWatch(self)
		self = IGAS:GetUI(self)

		return _UnregisterUnitWatch(self)
	end

	__Doc__[[
		<desc>Check to see if a frame is registered</desc>
		<return type="boolean"></return>
	]]
	function UnitWatchRegistered(self)
		self = IGAS:GetUI(self)

		return _UnitWatchRegistered(self)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
endinterface "IFSecureHandler"
