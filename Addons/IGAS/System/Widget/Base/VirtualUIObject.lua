-- Author      : Kurapica
-- ChangeLog
--				2011/03/07	Recode as class

-- Check Version
local version = 13

if not IGAS:NewAddon("IGAS.Widget.VirtualUIObject", version) then
	return
end

__Doc__[[VirtualUIObject is an abstract UI object type.]]
__InitTable__() __AutoProperty__()
class "VirtualUIObject"
	inherit "Object"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Active thread mode for special events.</desc>
		<param name="...">the event name list</param>
	]]
	function ActiveThread(self, ...)
		for i = 1, select('#', ...) do
			local name = select(i, ...)

			if self:HasEvent(name) then self[name].Delegate = System.Threading.ThreadCall end
		end
	end

	__Doc__[[
		<desc>Get the class name of the object</desc>
		<return type="string">the object's class name</return>
	]]
	function GetObjectType(self)
		return Reflector.GetNameSpaceName(self:GetClass())
	end

	__Doc__[[
		<desc>Check if the object is an instance of the class.</desc>
		<param name="objType">string the widget class's name</param>
		<return type="boolean">true if the object is an instance of the class</return>
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

	__Doc__[[
		<desc>Get the parent object of this widget object</desc>
		<return type="widgetObject">the parent of the object</return>
	]]
	function GetParent(self)
		return self.__Parent
	end

	__Doc__[[
		<desc>Set the parent widget object to this widget object</desc>
		<param name="parent">the parent widget object or nil</param>
		]]
	function SetParent(self, parent)
		-- Get frame from name
		if type(parent) == "string" then
			parent = _G[parent]

			if type(parent) ~= "table" then
				error("Usage : VirtualUIObject:SetParent(parent) : 'parent' - UI element expected.", 2)
			end
		end

		if parent then
			parent = IGAS:GetWrapper(parent)

			-- Check parent
			if not (Object.IsClass(parent, UIObject) or Object.IsClass(parent, VirtualUIObject)) then
				error("Usage : VirtualUIObject:SetParent(parent) : 'parent' - UI element expected.", 2)
			end
		end

		-- Set parent
		if parent then
			if self.__Name then
				-- Check
				parent.__Childs = parent.__Childs or {}

				if parent.__Childs[self.__Name] then
					if parent.__Childs[self.__Name] ~= self then
						error("Usage : VirtualUIObject:SetParent(parent) : parent has another child with same name.", 2)
					else
						return
					end
				end

				-- Remove ob from it's old parent
				if not Object.IsClass(self, VirtualUIObject) then
					-- mean now this is only Object
					SetParent(self, nil)
				else
					self:SetParent(nil)
				end

				-- Add ob to new parent
				self.__Parent = parent
				parent.__Childs[self.__Name] = self
			else
				error("Usage : VirtualUIObject:SetParent(parent) : 'VirtualUIObject' - must have a name.", 2)
			end
		else
			if self.__Name and self.__Parent and self.__Parent.__Childs then
				self.__Parent.__Childs[self.__Name] = nil
			end
			self.__Parent = nil
		end
	end

	__Doc__[[
		<desc>Add a virtual widget object as child</desc>
		<param name="child">the child virtual widget object</param>
		]]
	function AddChild(self, child)
		-- Get frame from name
		if type(child) == "string" then
			child = _G[child] or child

			if type(child) == "string" then
				error("Usage : VirtualUIObject:AddChild(child) : 'child' - UI element expected.", 2)
			end
		end

		child = IGAS:GetWrapper(child)

		if Object.IsClass(child, VirtualUIObject) then
			child:SetParent(self)
		else
			error("Usage : VirtualUIObject:AddChild(child) : 'child' - Virtual UI element expected.", 2)
		end
	end

	__Doc__[[
		<desc>Check if the widget object has child objects</desc>
		<return type="boolean">true if the object has child</return>
	]]
	function HasChilds(self)
		if type(self.__Childs) == "table" and next(self.__Childs) then
			return true
		else
			return false
		end
	end

	__Doc__[[
		<desc>Get the child list of the widget object, !!!IMPORTANT!!!, don't do any change to the return table, this table is the real table that contains the child objects.</desc>
		<return type="table">the child objects list</return>
	]]
	function GetChilds(self)
		self.__Childs = self.__Childs or {}
		return self.__Childs
	end

	__Doc__[[
		<desc>Get the child object for the given name</desc>
		<param name="name">string, the child's name</param>
		<return type="widgetObject">the child widget object if existed</return>
	]]
	function GetChild(self, name)
		if type(name) ~= "string" then
			error("Usage : VirtualUIObject:GetChild(name) : 'name' - string expected.", 2)
		end

		return rawget(self, "__Childs") and self.__Childs[name]
	end

	__Doc__[[
		<desc>Remove the child for the given name</desc>
		<param name="name">string, the child's name</param>
		]]
	function RemoveChild(self, name)
		local child = nil

		if name then
			if type(name) == "string" then
				child = self.__Childs and self.__Childs[name]
			elseif type(name) == "table" and name.Name then
				if self.__Childs and self.__Childs[name.Name] == name then
					child = name
				end
			end

			if child then
				return child:SetParent(nil)
			end
		end
	end

	local function GetFullName(self)
		if not self.Name then
			return ""
		end

		if IGAS[self.Name] == self then
			return "IGAS."..tostring(self.Name)
		end

		if self.Parent == nil then
			return tostring(self.Name)
		end

		return GetFullName(self.Parent).."."..tostring(self.Name)
	end

	__Doc__[[
		<desc>Not like property 'Name', this method return full name, it will concat the object's name with it's parent like 'UIParent.MyForm.MyObj'</desc>
		<return type="string">the full name of the object</return>
	]]
	function GetName(self)
		return GetFullName(self)
	end

	__Doc__[[
		<desc>Return the script handler of the given name (discarded)</desc>
		<param name="name">string, the script's name</param>
		<return type="function">the script handler if existed</return>
	]]
	function GetScript(self, name)
		error(("Usage : func = object.%s"):format(tostring(name)), 2)
	end

	__Doc__[[
		<desc>Set the script hanlder of the given name (discarded)</desc>
		<param name="name">string, the script's name</param>
		<param name="handler">function, the script handler</param>
		]]
	function SetScript(self, name, func)
		error(("Usage : object.%s = func"):format(tostring(name)), 2)
	end

	function HookScript(self, name, func)
		error(("Usage : object.%s = object.%s + func"):format(tostring(name), tostring(name)), 2)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	--- Name
	local function SetName(self, name)
		if self.__Parent then
			if name == self.__Name then
				return
			end

			if self.__Parent.__Childs and type(self.__Parent.__Childs) == "table" then
				if self.__Parent.__Childs[name] then
					error("the name is used by another child.",2)
				end

				if self.__Name then
					self.__Parent.__Childs[self.__Name] = nil
				end
			end

			if not (self.__Parent.__Childs and type(self.__Parent.__Childs) == "table") then
				self.__Parent.__Childs = {}
			end
			self.__Parent.__Childs[name] = self
		end

		self.__Name = name
	end

	__Doc__[[The virtual widget object's name, it's parent can use the name to access it by parent[self.Name] ]]
	property "Name" { Set = SetName, Field = "__Name", Type = String }

	__Doc__[[the virtual widget object's parent widget object, can be virtual or not.]]
	property "Parent" { Type = UIObject }

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		local name = self:GetName()

		self:SetParent(nil)

		-- Remove from _G if it exists
		if name and _G[name] == IGAS:GetUI(self) then
			_G[name] = nil
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	--- Name Creator
	local function NewName(cls, parent)
		local i = 1
		local name = Reflector.GetNameSpaceName(cls)

		if not name or name == "" then
			name = "Widget"
		end

		while true do
			if parent:GetChild(name..i) then
				i = i + 1
			else
				break
			end
		end

		return name..i
	end

	function VirtualUIObject(self, name, parent)
		parent = parent or IGAS.UIParent

		parent = IGAS:GetWrapper(parent)

		-- Check parent
		if not (Object.IsClass(parent, UIObject) or Object.IsClass(parent, VirtualUIObject)) then
			error(("Usage : %s(name, parent, ...) : 'parent' - UI element expected."):format(Reflector.GetNameSpaceName(cls)))
		end

		if type(name) ~= "string" then
			name = NewName(Object.GetClass(self), parent)
		end

		SetName(self, name)
		SetParent(self, parent)
	end

	------------------------------------------------------
	-- Exist checking
	------------------------------------------------------
	function __exist(name, parent, ...)
		parent = parent or IGAS.UIParent

		parent = IGAS:GetWrapper(parent)

		-- Check parent
		if not (Object.IsClass(parent, UIObject) or Object.IsClass(parent, VirtualUIObject)) then
			error(("Usage : %s(name, parent, ...) : 'parent' - UI element expected."):format(Reflector.GetNameSpaceName(cls)))
		end

		if type(name) == "string" then
			return parent:GetChild(name)
		end
	end

	------------------------------------------------------
	-- __index
	------------------------------------------------------
	function __index(self, key)
		if key == "__Childs" then
			rawset(self, key, {})
			return rawget(self, key, {})
		end
		if rawget(self, "__Childs") and type(rawget(self, "__Childs")) == "table" then
			return rawget(self.__Childs,  key)
		end
	end
endclass "VirtualUIObject"
