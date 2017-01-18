-- Author      : Kurapica
-- Create Date : 2012/06/28
-- Change Log  :

-- Check Version
local version = 5
if not IGAS:NewAddon("IGAS.Widget.IFMovableResizable", version) then
	return
end

----------------------------------------------------------
-- Manage Functions
----------------------------------------------------------
do
	_Global = "Global"

	_GroupListMovable = _GroupListMovable or setmetatable({},
		{
			__index = function(self, group)
				group = tostring(group or _Global):upper()

				if not rawget(self, group) then
					rawset(self, group, setmetatable({}, _WeakMode))
				end

				return rawget(self, group)
			end,
			__call = function(self, group)
				group = tostring(group or _Global):upper()

				return rawget(self, group)
			end,
		}
	)

	_GroupListResizable = _GroupListResizable or setmetatable({}, getmetatable(_GroupListMovable))
	_GroupListToggleable = _GroupListToggleable or setmetatable({}, getmetatable(_GroupListMovable))

	_IFMovable_ModeOn = _IFMovable_ModeOn or {}
	_IFResizable_ModeOn = _IFResizable_ModeOn or {}
	_IFToggleable_ModeOn = _IFToggleable_ModeOn or {}

	_IFMaskParent = Frame("IGAS_IFMovableResizable_Mask")
	_IFMaskParent.Visible = false

	_IFMask_Recycle = _IFMask_Recycle or Recycle(Mask, "IFMovableResizable_Mask_%d", _IFMaskParent)

	function _IFMask_Recycle:OnPush(mask)
		mask.Parent = _IFMaskParent
		mask.Visible = false
	end

	function _IFMask_Recycle:OnInit(mask)
		mask.OnMoveStarted = Mask_OnMoveStarted
		mask.OnResizeStarted = Mask_OnResizeStarted
		mask.OnMoveFinished = Mask_OnMoveFinished
		mask.OnResizeFinished = Mask_OnResizeFinished
		mask.OnToggle = Mask_OnToggle
	end

	function Mask_OnMoveStarted(self)
		self.Parent:BlockEvent("OnPositionChanged", "OnSizeChanged")
	end

	function Mask_OnResizeStarted(self)
		self.Parent:BlockEvent("OnPositionChanged", "OnSizeChanged")
	end

	function Mask_OnMoveFinished(self)
		self.Parent:UnBlockEvent("OnPositionChanged", "OnSizeChanged")
		self.Parent:Fire("OnPositionChanged")
	end

	function Mask_OnResizeFinished(self)
		self.Parent:UnBlockEvent("OnPositionChanged", "OnSizeChanged")
		self.Parent:Fire("OnSizeChanged")
	end

	function Mask_OnToggle(self)
		self.Parent.ToggleState = self.ToggleState
		return self.Parent:Fire("OnToggle")
	end

	function _MaskOn(IF, group)
		group = tostring(group or _Global):upper()

		local lst

		if IF == IFMovable then
			lst = _GroupListMovable(group)
			_IFMovable_ModeOn[group] = true
		elseif IF == IFResizable then
			lst = _GroupListResizable(group)
			_IFResizable_ModeOn[group] = true
		elseif IF == IFToggleable then
			lst = _GroupListToggleable(group)
			_IFToggleable_ModeOn[group] = true
		end

		if not lst or not next(lst) then return end

		local cnt = 1
		local needMask

		for frm in pairs(lst) do
			-- Check if item no need move or resize
			if IF == IFMovable then
				needMask = frm.IFMovable
			elseif IF == IFResizable then
				needMask = frm.IFResizable
			elseif IF == IFToggleable then
				needMask = frm.IFToggleable
			end

			if needMask then
				if not frm.__IFMovableResizable_Mask then
					frm.__IFMovableResizable_Mask = _IFMask_Recycle()

					frm.__IFMovableResizable_Mask.Parent = frm
					frm.__IFMovableResizable_Mask.ParentVisible = frm.Visible
				end

				if IF == IFMovable then
					frm.__IFMovableResizable_Mask.AsMove = true
				elseif IF == IFResizable then
					frm.__IFMovableResizable_Mask.AsResize = true
				elseif IF == IFToggleable then
					frm.__IFMovableResizable_Mask.AsToggle = true
					frm.__IFMovableResizable_Mask.ToggleState = frm.ToggleState
				end

				frm.Visible = true
				frm.__IFMovableResizable_Mask.Visible = true
			end
		end
	end

	function _MaskOff(IF, group)
		group = tostring(group or _Global):upper()

		if _UsingMask then error("Can't turn off mode when mouse is down", 3) end

		local lst

		if IF == IFMovable then
			lst = _GroupListMovable(group)
			_IFMovable_ModeOn[group] = nil
		elseif IF == IFResizable then
			lst = _GroupListResizable(group)
			_IFResizable_ModeOn[group] = nil
		elseif IF == IFToggleable then
			lst = _GroupListToggleable(group)
			_IFToggleable_ModeOn[group] = nil
		end

		if not lst or not next(lst) then return end

		local mask

		for frm in pairs(lst) do
			mask = frm.__IFMovableResizable_Mask
			if mask then
				if IF == IFMovable then
					mask.AsMove = false
				elseif IF == IFResizable then
					mask.AsResize = false
				elseif IF == IFToggleable then
					mask.AsToggle = false
				end

				if not mask.AsMove and not mask.AsResize and not mask.AsToggle then
					frm.Visible = mask.ParentVisible
					frm.__IFMovableResizable_Mask = nil
					_IFMask_Recycle(mask)
				end
			end
		end
	end

	function _MaskToggle(IF, group)
		group = tostring(group or _Global):upper()
		local on

		if IF == IFMovable then
			on = _IFMovable_ModeOn[group]
		elseif IF == IFResizable then
			on = _IFResizable_ModeOn[group]
		elseif IF == IFToggleable then
			on = _IFToggleable_ModeOn[group]
		end
		if on then
			_MaskOff(IF, group)
		else
			_MaskOn(IF, group)
		end
	end
end

__Doc__[[IFMovable provide a frame moving system]]
__AutoProperty__()
interface "IFMovable"
	require "Region"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Fired when the object is moved by cursor]]
	event "OnPositionChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Start moving registered Object</desc>
		<param name="group">string, group name</param>
	]]
	__Static__() function _ModeOn(group)
		return _MaskOn(IFMovable, group)
	end

	__Doc__[[
		<desc>Stop moving registered Object</desc>
		<param name="group">string, group name</param>
	]]
	__Static__() function _ModeOff(group)
		return _MaskOff(IFMovable, group)
	end

	__Doc__[[
		<desc>Whether the group is mode on</desc>
		<param name="group">string, group name</param>
		<return type="boolean">true if the mode is turn on for the group</return>
	]]
	__Static__() function _IsModeOn(group)
		group = tostring(group or _Global):upper()
		return _IFMovable_ModeOn[group]
	end

	__Doc__[[
		<desc>Toggle the mode</desc>
		<param name="group">string, group name</param>
	]]
	__Static__() function _Toggle(group)
		_MaskToggle(IFMovable, group)
	end

	__Doc__[[
		<desc>Get all group name</desc>
		<return type="table">a list contains all groups</return>
	]]
	__Static__() function _GetGroupList()
		local ret = {}

		for grp in pairs(_GroupListMovable) do
			tinsert(ret, grp)
		end

		sort(ret)

		return ret
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The object's moving group name, default "Global"]]
	property "IFMovingGroup" {
		Get = function(self)
			return _Global
		end,
	}

	__Doc__[[Whether the object should be turn into the moving mode]]
	property "IFMovable" {
		Type = Boolean,
		Default = true,
	}

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_GroupListMovable[self.IFMovingGroup][self] = nil
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFMovable(self)
		_GroupListMovable[self.IFMovingGroup][self] = true
	end
endinterface "IFMovable"

__Doc__[[IFResizable provide a frame resize system]]
__AutoProperty__()
interface "IFResizable"
	require "Region"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Fired when a frame's size changes]]
	event "OnSizeChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Start resizing registered Object</desc>
		<param name="group">string, group name</param>
	]]
	__Static__() function _ModeOn(group)
		return _MaskOn(IFResizable, group)
	end

	__Doc__[[
		<desc>Stop resizing registered Object</desc>
		<param name="group">string, group name</param>
	]]
	__Static__() function _ModeOff(group)
		return _MaskOff(IFResizable, group)
	end

	__Doc__[[
		<desc>Whether the group is mode on</desc>
		<param name="group">string, group name</param>
		<return type="boolean">true if the mode is turn on for the group</return>
	]]
	__Static__() function _IsModeOn(group)
		group = tostring(group or _Global):upper()
		return _IFResizable_ModeOn[group]
	end

	__Doc__[[
		<desc>Toggle the mode</desc>
		<param name="group">string, group name</param>
	]]
	__Static__() function _Toggle(group)
		_MaskToggle(IFResizable, group)
	end

	__Doc__[[
		<desc>Get all group name</desc>
		<return type="table">a list contains all groups</return>
	]]
	__Static__() function _GetGroupList()
		local ret = {}

		for grp in pairs(_GroupListResizable) do
			tinsert(ret, grp)
		end

		sort(ret)

		return ret
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The object's resizing group name, default "Global"]]
	property "IFResizingGroup" {
		Get = function(self)
			return _Global
		end,
	}

	__Doc__[[Whether the object should be turn into the resizing mode]]
	property "IFResizable" {
		Type = Boolean,
		Default = true,
	}

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_GroupListResizable[self.IFResizingGroup][self] = nil
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFResizable(self)
		_GroupListResizable[self.IFResizingGroup][self] = true
	end
endinterface "IFResizable"

__Doc__[[IFToggleable provide a frame toggle system]]
__AutoProperty__()
interface "IFToggleable"
	require "Region"

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Fired when a frame's toggle state changes]]
	event "OnToggle"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[
		<desc>Start toggling registered Object</desc>
		<param name="group">string, group name</param>
	]]
	__Static__() function _ModeOn(group)
		return _MaskOn(IFToggleable, group)
	end

	__Doc__[[
		<desc>Stop toggling registered Object</desc>
		<param name="group">string, group name</param>
	]]
	__Static__() function _ModeOff(group)
		return _MaskOff(IFToggleable, group)
	end

	__Doc__[[
		<desc>Whether the group is mode on</desc>
		<param name="group">string, group name</param>
		<return type="boolean">true if the mode is turn on for the group</return>
	]]
	__Static__() function _IsModeOn(group)
		group = tostring(group or _Global):upper()
		return _IFToggleable_ModeOn[group]
	end

	__Doc__[[
		<desc>Toggle the mode</desc>
		<param name="group">string, group name</param>
	]]
	__Static__() function _Toggle(group)
		_MaskToggle(IFToggleable, group)
	end

	__Doc__[[
		<desc>Get all group name</desc>
		<return type="table">a list contains all groups</return>
	]]
	__Static__() function _GetGroupList()
		local ret = {}

		for grp in pairs(_GroupListToggleable) do
			tinsert(ret, grp)
		end

		sort(ret)

		return ret
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The object's toggling group name, default "Global"]]
	property "IFTogglingGroup" {
		Get = function(self)
			return _Global
		end,
	}

	__Doc__[[Whether the object should be turn into the toggling mode]]
	property "IFToggleable" {
		Type = Boolean,
		Default = true,
	}

	__Doc__[[The toggle state of the frame]]
	__Require__()
	property "ToggleState" { Type = Boolean }

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_GroupListToggleable[self.IFTogglingGroup][self] = nil
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFToggleable(self)
		_GroupListToggleable[self.IFTogglingGroup][self] = true
	end
endinterface "IFToggleable"
