-- Author      : Kurapica
-- Create Date : 2013/11/25
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Action.IFActionHandler", version) then
	return
end

------------------------------------------------------
-- Module
--
-- DB :
--		_DBCharNoDrag
--		_DBCharUseDown
--
-- Function List :
--		GetGroup(group) : True Group name
------------------------------------------------------
do
	-- Manager Frame
	_IFActionHandler_ManagerFrame = SecureFrame("IGAS_IFActionHandler_Manager", IGAS.UIParent, "SecureHandlerStateTemplate")
	_IFActionHandler_ManagerFrame.Visible = false

	_FlashInterval = 0.4
	_UpdateRangeInterval = 0.2

	_IFActionTypeHandler = {}

	_ActionTypeMap = {}
	_ActionTargetMap = {}
	_ActionTargetDetail = {}
	_ReceiveMap = {}

	_AutoAttackButtons = setmetatable({}, {__mode = "k"})
	_AutoRepeatButtons = setmetatable({}, getmetatable(_AutoAttackButtons))
	_Spell4Buttons = setmetatable({}, getmetatable(_AutoAttackButtons))
	_RangeCheckButtons = setmetatable({}, getmetatable(_AutoAttackButtons))

	_GlobalGroup = "Global"

	function GetGroup(group)
		return tostring(type(group) == "string" and strtrim(group) ~= "" and strtrim(group) or _GlobalGroup):upper()
	end

	function GetFormatString(param)
		return type(param) == "string" and ("%q"):format(param) or tostring(param)
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	function OnLoad(self)
		-- DB
		IGAS_DB_Char.Action_IFActionHandler_DB = IGAS_DB_Char.Action_IFActionHandler_DB or {}
		IGAS_DB_Char.Action_IFActionHandler_DB.NoDragGroup = IGAS_DB_Char.Action_IFActionHandler_DB.NoDragGroup or {}
		IGAS_DB_Char.Action_IFActionHandler_DB.UseDownGroup = IGAS_DB_Char.Action_IFActionHandler_DB.UseDownGroup or {}

		_DBCharNoDrag = IGAS_DB_Char.Action_IFActionHandler_DB.NoDragGroup
		_DBCharUseDown = IGAS_DB_Char.Action_IFActionHandler_DB.UseDownGroup
	end

	function OnEnable(self)
		for grp in pairs(_DBCharNoDrag) do
			Task.NoCombatCall(DisableDrag, grp)
		end
	end
end

------------------------------------------------------
-- IFActionTypeHandler
--
------------------------------------------------------
__Doc__[[Interface for action type handlers]]
__AutoProperty__()
interface "IFActionTypeHandler"

	_RegisterSnippetTemplate = "%s[%q] = %q"

	enum "HandleStyle" {
		"Keep",
		"Clear",
		"Block",
	}

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[Fired when the handler is enabled or disabled]]
	event "OnEnableChanged"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Refresh all action buttons of the same action type]]
	function Refresh(self, button, mode)
		if type(button) ~= "table" then
			return _IFActionHandler_Buttons:EachK(self.Name, button or UpdateActionButton)
		else
			return (mode or UpdateActionButton)(button)
		end
	end

	__Doc__[[
		<desc>Run the snippet in the global environment</desc>
		<param name="code">the snippet</param>
	]]
	function RunSnippet(self, code)
		return Task.NoCombatCall( SecureFrame.Execute, _IFActionHandler_ManagerFrame, code )
	end

	------------------------------------------------------
	-- Overridable Method
	------------------------------------------------------
	__Doc__[[Refresh the button]]
	function RefreshButton(self) end

	__Doc__[[
		<desc>Get the actions's kind, target, detail</desc>
		<return type="kind"></return>
		<return type="target"></return>
		<return type="detail"></return>
	]]
	function GetActionDetail(self)
		local name = self:GetAttribute("actiontype")
		return self:GetAttribute(_ActionTargetMap[name]), _ActionTargetDetail[name] and self:GetAttribute(_ActionTargetDetail[name])
	end

	__Doc__[[
		<desc>Custom pick up action</desc>
		<param name="target"></param>
		<param name="detail"></param>
	]]
	function PickupAction(self, target, detail)
	end

	__Doc__[[
		<desc>Custom receive action</desc>
		<param name="target"></param>
		<param name="detail"></param>
	]]
	function ReceiveAction(self, target, detail)
	end

	__Doc__[[
		<desc>Whether the action button has an action</desc>
		<return type="boolean"></return>
	]]
	function HasAction(self)
		return true
	end

	__Doc__[[
		<desc>Get the action's text</desc>
		<return type="string"></return>
	]]
	function GetActionText(self)
		return ""
	end

	__Doc__[[
		<desc>Get the action's texture</desc>
		<return type="string"></return>
	]]
	function GetActionTexture(self)
	end

	__Doc__[[
		<desc>Get the action's charges</desc>
		<return type="number"></return>
	]]
	function GetActionCharges(self)
	end

	__Doc__[[
		<desc>Get the action's count</desc>
		<return type="number"></return>
	]]
	function GetActionCount(self)
		return 0
	end

	__Doc__[[
		<desc>Get the action's cooldown</desc>
		<return type="start,">duration, enable</return>
	]]
	function GetActionCooldown(self)
		return 0, 0, 0
	end

	__Doc__[[
		<desc>Whether the action is attackable</desc>
		<return type="boolean"></return>
	]]
	function IsAttackAction(self)
		return false
	end

	__Doc__[[
		<desc>Whether the action is an item and can be equipped</desc>
		<return type="boolean"></return>
	]]
	function IsEquippedItem(self)
		return false
	end

	__Doc__[[
		<desc>Whether the action is actived</desc>
		<return type="boolean"></return>
	]]
	function IsActivedAction(self)
		return false
	end

	__Doc__[[
		<desc>Whether the action is auto-repeat</desc>
		<return type="boolean"></return>
	]]
	function IsAutoRepeatAction(self)
		return false
	end

	__Doc__[[
		<desc>Whether the action is usable</desc>
		<return type="boolean"></return>
	]]
	function IsUsableAction(self)
		return true
	end

	__Doc__[[
		<desc>Whether the action is consumable</desc>
		<return type="boolean"></return>
	]]
	function IsConsumableAction(self)
		return false
	end

	__Doc__[[
		<desc>Whether the action is in range of the target</desc>
		<return type="boolean"></return>
	]]
	function IsInRange(self)
		return
	end

	__Doc__[[
		<desc>Whether the action is auto-castable</desc>
		<return type="boolean"></return>
	]]
	function IsAutoCastAction(self)
		return false
	end

	__Doc__[[
		<desc>Whether the action is auto-casting now</desc>
		<return type="boolean"></return>
	]]
	function IsAutoCasting(self)
		return false
	end

	__Doc__[[
		<desc>Show the tooltip for the action</desc>
		<param name="GameTooltip"></param>
		<return type="boolean"></return>
	]]
	function SetTooltip(self, GameTooltip)
	end

	__Doc__[[
		<desc>Get the spell id of the action</desc>
		<return type="number"></return>
	]]
	function GetSpellId(self)
	end

	__Doc__[[
		<desc>Whether the action is a flyout spell</desc>
		<return type="boolean"></return>
	]]
	function IsFlyout(self)
		return false
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether the handler is enabled(has buttons)]]
	property "Enabled" { Type = Boolean, Event = "OnEnableChanged" }

	__Doc__[[The manager of the action system]]
	property "Manager" { Default = _IFActionHandler_ManagerFrame, Set = false }

	__Doc__[[The action's name]]
	property "Name" { Type = String }

	__Doc__[[The action type's type]]
	property "Type" { Type = String }

	__Doc__[[The target attribute name]]
	property "Target" { Type = String }

	__Doc__[[The detail attribute name]]
	property "Detail" { Type = String }

	__Doc__[[Whether the action is player action]]
	property "IsPlayerAction" { Type = Boolean, Default = true }

	__Doc__[[Whether the action is pet action]]
	property "IsPetAction" { Type = Boolean, Default = false }

	__Doc__[[The drag style of the action type]]
	property "DragStyle" { Type = HandleStyle, Default = HandleStyle.Clear }

	__Doc__[[The receive style of the action type]]
	property "ReceiveStyle" { Type = HandleStyle, Default = HandleStyle.Clear }

	__Doc__[[The receive map]]
	property "ReceiveMap" { Type = String }

	__Doc__[[The pickup map]]
	property "PickupMap" { Type = String }

	__Doc__[[The snippet to setup environment for the action type]]
	property "InitSnippet" { Type = String }

	__Doc__[[The snippet used when pick up action]]
	property "PickupSnippet" { Type = String }

	__Doc__[[The snippet used to update for new action settings]]
	property "UpdateSnippet" { Type = String }

	__Doc__[[The snippet used to receive action]]
	property "ReceiveSnippet" { Type = String }

	__Doc__[[The snippet used to clear action]]
	property "ClearSnippet" { Type = String }

	__Doc__[[The snippet used for pre click]]
	property "PreClickSnippet" { Type = String }

	__Doc__[[The snippet used for post click]]
	property "PostClickSnippet" { Type = String }

	------------------------------------------------------
	-- Initialize
	------------------------------------------------------
    function IFActionTypeHandler(self)
    	-- No repeat definition for action types
    	if _IFActionTypeHandler[self.Name] then return end

    	-- Register the action type handler
    	_IFActionTypeHandler[self.Name] = self

    	-- Default map
    	if self.Type == nil then self.Type = self.Name end
    	if self.Target == nil then self.Target = self.Type end
    	if self.ReceiveMap == nil and self.ReceiveStyle == "Clear" then self.ReceiveMap = self.Type end
    	if self.PickupMap == nil then self.PickupMap = self.Type end

		-- Register action type map
		_ActionTypeMap[self.Name] = self.Type
		_ActionTargetMap[self.Name] = self.Target
		_ActionTargetDetail[self.Name]  = self.Detail
		self:RunSnippet( _RegisterSnippetTemplate:format("_ActionTypeMap", self.Name, self.Type) )
		self:RunSnippet( _RegisterSnippetTemplate:format("_ActionTargetMap", self.Name, self.Target) )
		if self.Detail then self:RunSnippet( _RegisterSnippetTemplate:format("_ActionTargetDetail", self.Name, self.Detail) ) end

		-- Init the environment
		if self.InitSnippet then self:RunSnippet( self.InitSnippet ) end

		-- Register PickupSnippet
		if self.PickupSnippet then self:RunSnippet( _RegisterSnippetTemplate:format("_PickupSnippet", self.Name, self.PickupSnippet) ) end

		-- Register UpdateSnippet
		if self.UpdateSnippet then self:RunSnippet( _RegisterSnippetTemplate:format("_UpdateSnippet", self.Name, self.UpdateSnippet) ) end

		-- Register ReceiveSnippet
		if self.ReceiveSnippet then self:RunSnippet( _RegisterSnippetTemplate:format("_ReceiveSnippet", self.Name, self.ReceiveSnippet) ) end

		-- Register ClearSnippet
		if self.ClearSnippet then self:RunSnippet( _RegisterSnippetTemplate:format("_ClearSnippet", self.Name, self.ClearSnippet) ) end

		-- Register DragStyle
		self:RunSnippet( _RegisterSnippetTemplate:format("_DragStyle", self.Name, self.DragStyle) )

		-- Register ReceiveStyle
		self:RunSnippet( _RegisterSnippetTemplate:format("_ReceiveStyle", self.Name, self.ReceiveStyle) )

		-- Register ReceiveMap
		if self.ReceiveMap then
			self:RunSnippet( _RegisterSnippetTemplate:format("_ReceiveMap", self.ReceiveMap, self.Name) )
			_ReceiveMap[self.ReceiveMap] = self
		end

		-- Register PickupMap
		if self.PickupMap then self:RunSnippet( _RegisterSnippetTemplate:format("_PickupMap", self.Name, self.PickupMap) ) end

		-- Register PreClickMap
		if self.PreClickSnippet then self:RunSnippet( _RegisterSnippetTemplate:format("_PreClickSnippet", self.Name, self.PreClickSnippet) ) end

		-- Register PostClickMap
		if self.PostClickSnippet then self:RunSnippet( _RegisterSnippetTemplate:format("_PostClickSnippet", self.Name, self.PostClickSnippet) ) end

		-- Clear
		self.InitSnippet = nil
		self.PickupSnippet = nil
		self.UpdateSnippet = nil
		self.ReceiveSnippet = nil
		self.ClearSnippet = nil
		self.PreClickSnippet = nil
		self.PostClickSnippet = nil
    end
endinterface "IFActionTypeHandler"

------------------------------------------------------
-- ActionTypeHandler
--
------------------------------------------------------
__Doc__[[The handler for each action types]]
__AutoCache__() __AutoProperty__()
class "ActionTypeHandler"
	extend "IFActionTypeHandler"

	------------------------------------------------------
	-- Meta-methods
	------------------------------------------------------
	function __exist(name)
		return name and _IFActionTypeHandler[name]
	end

	function __call(self)
		return _IFActionHandler_Buttons(self.Type)
	end
endclass "ActionTypeHandler"

------------------------------------------------------
-- ActionList
--
------------------------------------------------------
__AutoProperty__()
class "ActionList"
	import "System.Collections"
	extend "IList"

	local function nextLink(data, kind)
		if type(kind) ~= "table" then
			return data[kind], data[kind]
		else
			local nxt = kind.__ActionList_Next
			return nxt, nxt
		end
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	------------------------------------
	--- Insert action button to the list
	------------------------------------
	Insert = tinsert

	------------------------------------
	--- Remove action button from the list
	------------------------------------
	function Remove(self, frame)
		for i, v in ipairs(self) do
			if v == frame then
				self[v] = nil -- remove it in __newindex
				return tremove(self, i)
			end
		end
	end

	------------------------------------
	--- Iterate with key
	------------------------------------
	local iterKey = setmetatable({}, {__mode="k"})

	function EachK(self, key, ...)
		iterKey[self] = key
		return IList.Each(self, ...)
	end

	function Each(self, ...)
		iterKey[self] = nil
		return IList.Each(self, ...)
	end

	------------------------------------
	--- Get the next element
	------------------------------------
	function GetIterator(self, key)
		key = key or iterKey[self]
		if type(key) == "string" then
			iterKey[self] = nil
			return nextLink, self, key:lower()
		else
			return ipairs(self)
		end
	end

	------------------------------------------------------
	-- MetaMethod
	------------------------------------------------------
	function __index(self, kind)
		return type(kind) == "string" and rawget(self, kind:lower()) or nil
	end

	function __newindex(self, frame, kind)
		if type(frame) == "string" and type(kind) == "function" then
			return rawset(self, frame, kind)
		end

		if type(frame) ~= "table" then error("key must be a table.", 2) end
		if kind ~= nil and not _IFActionTypeHandler[kind] then error("value not supported.", 2) end

		local prev = frame.__ActionList_Prev
		local next = frame.__ActionList_Next
		local header = prev

		while type(header) == "table" do header = header.__ActionList_Prev end

		-- no change
		if header == kind then return end

		-- Remove link
		if header then
			if prev == header then
				rawset(self, header, next)
				if next then
					next.__ActionList_Prev = prev
				else
					_IFActionTypeHandler[kind].Enabled = false
				end
			else
				prev.__ActionList_Next = next
				if next then next.__ActionList_Prev = prev end
			end

			frame.__ActionList_Prev = nil
			frame.__ActionList_Next = nil
		end

		-- Add link
		if kind then
			local tail = self[kind]

			rawset(self, kind, frame)
			frame.__ActionList_Prev = kind

			if tail then
				tail.__ActionList_Prev = frame
				frame.__ActionList_Next = tail
			end

			_IFActionTypeHandler[kind].Enabled = true
		end
	end

	__call = GetIterator
endclass "ActionList"

------------------------------------------------------
-- Action Manager
--
------------------------------------------------------
do
	_GameTooltip = _G.GameTooltip

	-- Object Array
	_IFActionHandler_Buttons = ActionList()

	-- Custom pick up handler
	IGAS:GetUI(_IFActionHandler_ManagerFrame).OnPickUp = function (self, kind, target, detail)
		return not InCombatLockdown() and PickupAny("clear", kind, target, detail)
	end

	IGAS:GetUI(_IFActionHandler_ManagerFrame).OnReceive = function (self, kind, target, detail)
		return not InCombatLockdown() and _IFActionTypeHandler[kind] and _IFActionTypeHandler[kind]:ReceiveAction(target, detail)
	end

	IGAS:GetUI(_IFActionHandler_ManagerFrame).UpdateActionButton = function (self, btnName)
		self = IGAS:GetWrapper(_G[btnName])

		local name = self:GetAttribute("actiontype")
		local target, detail = _IFActionTypeHandler[name].GetActionDetail(self)

		-- Some problem with battlepet
		-- target = tonumber(target) or target
		-- detail = tonumber(detail) or detail

		if self.__IFActionHandler_Kind ~= name
			or self.__IFActionHandler_Target ~= target
			or self.__IFActionHandler_Detail ~= detail then

			self.__IFActionHandler_Kind = name
			self.__IFActionHandler_Target = target
			self.__IFActionHandler_Detail = detail

			_IFActionHandler_Buttons[self] = name 	-- keep button in kind's link list

			return UpdateActionButton(self)
		end
	end

	-- Spell activation alert recycle manager
	_RecycleAlert = Recycle(SpellActivationAlert, "SpellActivationAlert%d", _IFActionHandler_ManagerFrame)

	-- Timer
	_IFActionHandler_UpdateRangeTimer = Timer("RangeTimer", _IFActionHandler_ManagerFrame) { Enabled = false, Interval = _UpdateRangeInterval }
	_IFActionHandler_FlashingTimer = Timer("FlashingTimer", _IFActionHandler_ManagerFrame) { Enabled = false, Interval = _FlashInterval }

	_IFActionHandler_FlashingList = setmetatable({}, getmetatable(_AutoAttackButtons))

	------------------------------------------------------
	-- Snippet Definition
	------------------------------------------------------
	-- Init manger frame's enviroment
	Task.NoCombatCall(function ()
		_IFActionHandler_ManagerFrame:Execute[[
			-- to fix blz error, use Manager not control
			Manager = self

			_NoDraggable = newtable()

			_ActionTypeMap = newtable()
			_ActionTargetMap = newtable()
			_ActionTargetDetail = newtable()

			_ReceiveMap = newtable()
			_PickupMap = newtable()

			_ClearSnippet = newtable()
			_UpdateSnippet = newtable()
			_PickupSnippet = newtable()
			_ReceiveSnippet = newtable()
			_PreClickSnippet = newtable()
			_PostClickSnippet = newtable()

			_DragStyle = newtable()
			_ReceiveStyle = newtable()

			UpdateAction = [=[
				local name = self:GetAttribute("actiontype")

				-- Custom update
				if _UpdateSnippet[name] then
					Manager:RunFor(
						self, _UpdateSnippet[name],
						self:GetAttribute(_ActionTargetMap[name]),
						_ActionTargetDetail[name] and self:GetAttribute(_ActionTargetDetail[name])
					)
				end

				return Manager:CallMethod("UpdateActionButton", self:GetName())
			]=]

			ClearAction = [=[
				local name = self:GetAttribute("actiontype")

				if name and name ~= "empty" then
					self:SetAttribute("actiontype", "empty")

					self:SetAttribute("type", nil)
					self:SetAttribute(_ActionTargetMap[name], nil)
					if _ActionTargetDetail[name] then
						self:SetAttribute(_ActionTargetDetail[name], nil)
					end

					-- Custom clear
					if _ClearSnippet[name] then
						Manager:RunFor(self, _ClearSnippet[name])
					end
				end
			]=]

			CopyAction = [=[
				local source = self:GetFrameRef("CopyTarget")
				self:SetAttribute("frameref-CopyTarget", nil)

				if not source then return end

				local name = source:GetAttribute("actiontype")
				local target = source:GetAttribute(_ActionTargetMap[name])
				local detail = _ActionTargetDetail[name] and source:GetAttribute(_ActionTargetDetail[name])

				Manager:RunFor(self, ClearAction)

				self:SetAttribute("actiontype", name)

				self:SetAttribute("type", _ActionTypeMap[name])
				self:SetAttribute(_ActionTargetMap[name], target)

				if detail ~= nil and _ActionTargetDetail[name] then
					self:SetAttribute(_ActionTargetDetail[name], detail)
				end

				Manager:RunFor(self, UpdateAction)
			]=]

			SwapAction = [=[
				local source = self:GetFrameRef("SwapTarget")
				self:SetAttribute("frameref-SwapTarget", nil)

				if not source then return end

				local name = source:GetAttribute("actiontype")
				local target = source:GetAttribute(_ActionTargetMap[name])
				local detail = _ActionTargetDetail[name] and source:GetAttribute(_ActionTargetDetail[name])

				local sname = self:GetAttribute("actiontype")
				local starget = self:GetAttribute(_ActionTargetMap[sname])
				local sdetail = _ActionTargetDetail[sname] and self:GetAttribute(_ActionTargetDetail[sname])

				Manager:RunFor(source, ClearAction)
				Manager:RunFor(self, ClearAction)

				-- Set for source
				source:SetAttribute("actiontype", sname)

				source:SetAttribute("type", _ActionTypeMap[sname])
				source:SetAttribute(_ActionTargetMap[sname], starget)

				if sdetail ~= nil and _ActionTargetDetail[sname] then
					source:SetAttribute(_ActionTargetDetail[sname], sdetail)
				end

				-- Set for self
				self:SetAttribute("actiontype", name)

				self:SetAttribute("type", _ActionTypeMap[name])
				self:SetAttribute(_ActionTargetMap[name], target)

				if detail ~= nil and _ActionTargetDetail[name] then
					self:SetAttribute(_ActionTargetDetail[name], detail)
				end

				Manager:RunFor(source, UpdateAction)
				Manager:RunFor(self, UpdateAction)
			]=]

			DragStart = [=[
				local name = self:GetAttribute("actiontype")

				if _DragStyle[name] == "Block" then return false end

				local target = self:GetAttribute(_ActionTargetMap[name])
				local detail = _ActionTargetDetail[name] and self:GetAttribute(_ActionTargetDetail[name])

				-- Clear and refresh
				if _DragStyle[name] == "Clear" then
					Manager:RunFor(self, ClearAction)
					Manager:RunFor(self, UpdateAction)
				end

				-- Pickup the target
				if _PickupSnippet[name] == "Custom" then
					Manager:CallMethod("OnPickUp", name, target, detail)
					return false
				elseif _PickupSnippet[name] then
					return Manager:RunFor(self, _PickupSnippet[name], target, detail)
				else
					return "clear", _PickupMap[name], target, detail
				end
			]=]

			ReceiveDrag = [=[
				local kind, value, extra, extra2 = ...

				if not kind or not value then return false end

				local oldName = self:GetAttribute("actiontype")

				if _ReceiveStyle[oldName] == "Block" then return false end

				local oldTarget = oldName and self:GetAttribute(_ActionTargetMap[oldName])
				local oldDetail = oldName and _ActionTargetDetail[oldName] and self:GetAttribute(_ActionTargetDetail[oldName])

				if _ReceiveStyle[oldName] == "Clear" then
					Manager:RunFor(self, ClearAction)

					local name, target, detail = _ReceiveMap[kind]

					if name then
						if _ReceiveSnippet[name] and _ReceiveSnippet[name] ~= "Custom" then
							target, detail = Manager:RunFor(self, _ReceiveSnippet[name], value, extra, extra2)
						else
							target, detail = value, extra
						end

						if target then
							self:SetAttribute("actiontype", name)

							self:SetAttribute("type", _ActionTypeMap[name])
							self:SetAttribute(_ActionTargetMap[name], target)

							if detail ~= nil and _ActionTargetDetail[name] then
								self:SetAttribute(_ActionTargetDetail[name], detail)
							end
						end
					end

					Manager:RunFor(self, UpdateAction)
				end

				if _ReceiveStyle[oldName] == "Keep" and _ReceiveSnippet[oldName] == "Custom" then
					Manager:CallMethod("OnReceive", oldName, oldTarget, oldDetail)
					return Manager:RunFor(self, UpdateAction) or false
				end

				-- Pickup the target
				if _PickupSnippet[oldName] == "Custom" then
					Manager:CallMethod("OnPickUp", oldName, oldTarget, oldDetail)
					return false
				elseif _PickupSnippet[oldName] then
					return Manager:RunFor(self, _PickupSnippet[oldName], oldTarget, oldDetail)
				else
					return "clear", _PickupMap[oldName], oldTarget, oldDetail
				end
			]=]

			UpdateActionAttribute = [=[
				local name, target, detail = ...

				-- Clear
				Manager:RunFor(self, ClearAction)

				if name and _ActionTypeMap[name] and target then
					self:SetAttribute("actiontype", name)

					self:SetAttribute("type", _ActionTypeMap[name])
					self:SetAttribute(_ActionTargetMap[name], target)

					if detail ~= nil and _ActionTargetDetail[name] then
						self:SetAttribute(_ActionTargetDetail[name], detail)
					end
				end

				return Manager:RunFor(self, UpdateAction)
			]=]
		]]
	end)

	_IFActionHandler_OnDragStartSnippet = [[
		if (IsModifierKeyDown() or _NoDraggable[self:GetAttribute("IFActionHandlerGroup")]) and not IsModifiedClick("PICKUPACTION") then return false end

		return Manager:RunFor(self, DragStart)
	]]

	_IFActionHandler_OnReceiveDragSnippet = [[
		return Manager:RunFor(self, ReceiveDrag, kind, value, ...)
	]]

	_IFActionHandler_PostReceiveSnippet = [[
		return Manager:RunFor(Manager:GetFrameRef("UpdatingButton"), ReceiveDrag, %s, %s, %s, %s)
	]]

	_IFActionHandler_UpdateActionSnippet = [[
		return Manager:RunFor(Manager:GetFrameRef("UpdatingButton"), UpdateActionAttribute, %s, %s, %s)
	]]

	_IFActionHandler_WrapClickPrev = [[
		local name = self:GetAttribute("actiontype")

		if _PreClickSnippet[name] then
			return Manager:RunFor(self, _PreClickSnippet[name], button, down)
		end
	]]

	_IFActionHandler_WrapClickPost = [[
		local name = self:GetAttribute("actiontype")

		if _PostClickSnippet[name] then
			return Manager:RunFor(self, _PostClickSnippet[name], message, button, down)
		end
	]]

	_IFActionHandler_WrapDragPrev = [[
		return "message", "update"
	]]

	_IFActionHandler_WrapDragPost = [[
		Manager:RunFor(self, UpdateAction)
	]]

	------------------------------------------------------
	-- Action Script Hanlder
	------------------------------------------------------
	function PickupAny(kind, target, detail, ...)
		if (kind == "clear") then
			ClearCursor()
			kind, target, detail = target, detail, ...
		end

		if _IFActionTypeHandler[kind] then
			return _IFActionTypeHandler[kind]:PickupAction(target, detail)
		end
	end

	function PreClick(self)
		local oldKind = self:GetAttribute("actiontype")

		if InCombatLockdown() or (oldKind and _IFActionTypeHandler[oldKind].ReceiveStyle ~= "Clear") then
			return
		end

		local kind, value = GetCursorInfo()
		if not kind or not value then return end

		self.__IFActionHandler_PreType = self:GetAttribute("type")
		self.__IFActionHandler_PreMsg = true

		-- Make sure no action used
		self:SetAttribute("type", nil)
	end

	function PostClick(self)
		UpdateButtonState(self)

		-- Restore the action
		if self.__IFActionHandler_PreMsg then
			if not InCombatLockdown() then
				if self.__IFActionHandler_PreType then
					self:SetAttribute("type", self.__IFActionHandler_PreType)
				end

				local kind, value, subtype, detail = GetCursorInfo()

				if kind and value and _ReceiveMap[kind] then
					local oldName = self.__IFActionHandler_Kind
					local oldTarget = self.__IFActionHandler_Target
					local oldDetail = self.__IFActionHandler_Detail

					_IFActionHandler_ManagerFrame:SetFrameRef("UpdatingButton", self)
					_IFActionHandler_ManagerFrame:Execute(_IFActionHandler_PostReceiveSnippet:format(GetFormatString(kind), GetFormatString(value), GetFormatString(subtype), GetFormatString(detail)))

					PickupAny("clear", oldName, oldTarget, oldDetail)
				end
			elseif self.__IFActionHandler_PreType then
				-- Keep safe
				Task.NoCombatCall(self.SetAttribute, self, "type", self.__IFActionHandler_PreType)
			end

			self.__IFActionHandler_PreType = nil
			self.__IFActionHandler_PreMsg = nil
		end
	end

	_IFActionHandler_OnTooltip = nil

	function OnEnter(self)
		UpdateTooltip(self)
	end

	function OnLeave(self)
		_IFActionHandler_OnTooltip = nil
		_GameTooltip:Hide()
	end

	function EnableDrag(group)
		group = GetGroup(group)

		_DBCharNoDrag[group] = nil
		_IFActionHandler_ManagerFrame:Execute( ("_NoDraggable[%q] = nil"):format(group) )
	end

	function DisableDrag(group)
		group = GetGroup(group)

		_DBCharNoDrag[group] = true
		_IFActionHandler_ManagerFrame:Execute( ("_NoDraggable[%q] = true"):format(group) )
	end

	function IsDragEnabled(group)
		group = GetGroup(group)

		return not _DBCharNoDrag[group]
	end

	function EnableButtonDown(group)
		group = GetGroup(group)

		if not _DBCharUseDown[group] then
			_DBCharUseDown[group] = true

			_IFActionHandler_Buttons:Each(function(self)
				if GetGroup(self.IFActionHandlerGroup) == group then
					self:RegisterForClicks("AnyDown")
				end
			end)
		end
	end

	function DisableButtonDown(group)
		group = GetGroup(group)

		if _DBCharUseDown[group] then
			_DBCharUseDown[group] = nil

			_IFActionHandler_Buttons:Each(function(self)
				if GetGroup(self.IFActionHandlerGroup) == group then
					self:RegisterForClicks("AnyUp")
				end
			end)
		end
	end

	function IsButtonDownEnabled(group)
		group = GetGroup(group)

		return _DBCharUseDown[group]
	end

	function SetupActionButton(self)
		_IFActionHandler_ManagerFrame:WrapScript(self, "OnDragStart", _IFActionHandler_OnDragStartSnippet)
		_IFActionHandler_ManagerFrame:WrapScript(self, "OnReceiveDrag", _IFActionHandler_OnReceiveDragSnippet)

    	_IFActionHandler_ManagerFrame:WrapScript(self, "OnClick", _IFActionHandler_WrapClickPrev, _IFActionHandler_WrapClickPost)
    	_IFActionHandler_ManagerFrame:WrapScript(self, "OnDragStart", _IFActionHandler_WrapDragPrev, _IFActionHandler_WrapDragPost)
    	_IFActionHandler_ManagerFrame:WrapScript(self, "OnReceiveDrag", _IFActionHandler_WrapDragPrev, _IFActionHandler_WrapDragPost)

    	-- Button UpdateAction method added to secure part
    	self:SetFrameRef("IFActionHandler_Manager", _IFActionHandler_ManagerFrame)
    	self:SetAttribute("UpdateAction", [[ return self:GetFrameRef("IFActionHandler_Manager"):RunFor(self, "Manager:RunFor(self, UpdateActionAttribute, ...)", ...) ]])
    	self:SetAttribute("ClearAction", [[ return self:GetFrameRef("IFActionHandler_Manager"):RunFor(self, "Manager:RunFor(self, ClearAction)") ]])
    	self:SetAttribute("CopyAction", [[ return self:GetFrameRef("IFActionHandler_Manager"):RunFor(self, "Manager:RunFor(self, CopyAction)") ]])
    	self:SetAttribute("SwapAction", [[ return self:GetFrameRef("IFActionHandler_Manager"):RunFor(self, "Manager:RunFor(self, SwapAction)") ]])

    	if not self:GetAttribute("actiontype") then
    		self:SetAttribute("actiontype", "empty")
    	end

		self.PreClick = self.PreClick + PreClick
		self.PostClick = self.PostClick + PostClick
		self.OnEnter = self.OnEnter + OnEnter
		self.OnLeave = self.OnLeave + OnLeave
    end

    function UninstallActionButton(self)
    	_IFActionHandler_ManagerFrame:UnwrapScript(self, "OnClick")
    	_IFActionHandler_ManagerFrame:UnwrapScript(self, "OnDragStart")
		_IFActionHandler_ManagerFrame:UnwrapScript(self, "OnReceiveDrag")

    	_IFActionHandler_ManagerFrame:UnwrapScript(self, "OnDragStart")
		_IFActionHandler_ManagerFrame:UnwrapScript(self, "OnReceiveDrag")
	end

	function SaveAction(self, kind, target, detail)
		_IFActionHandler_ManagerFrame:SetFrameRef("UpdatingButton", self)
		_IFActionHandler_ManagerFrame:Execute(_IFActionHandler_UpdateActionSnippet:format(GetFormatString(kind), GetFormatString(target), GetFormatString(detail)))
	end

	------------------------------------------------------
	-- Display functions
	------------------------------------------------------
	_IFActionHandler_GridCounter = 0
	_IFActionHandler_PetGridCounter = 0

	function UpdateGrid(self)
		if self.BlockGridUpdating then return end

		local kind = self.ActionType

		if _IFActionHandler_GridCounter > 0 or self.ShowGrid or _IFActionTypeHandler[kind].HasAction(self) then
			self.Alpha = 1
		else
			self.Alpha = 0
		end
	end

	function UpdatePetGrid(self)
		if self.BlockGridUpdating then return end

		local kind = self.ActionType

		if _IFActionHandler_PetGridCounter > 0 or self.ShowGrid or _IFActionTypeHandler[kind].HasAction(self) then
			self.Alpha = 1
		else
			self.Alpha = 0
		end
	end

	function UpdateButtonState(self)
		local kind = self.ActionType

		self.Checked = _IFActionTypeHandler[kind].IsActivedAction(self) or _IFActionTypeHandler[kind].IsAutoRepeatAction(self)
	end

	function UpdateUsable(self)
		self.Usable = _IFActionTypeHandler[self.ActionType].IsUsableAction(self)
	end

	function UpdateCount(self)
		local kind = self.ActionType

		if _IFActionTypeHandler[kind].IsConsumableAction(self) then
			local count = _IFActionTypeHandler[kind].GetActionCount(self)

			if count > self.MaxDisplayCount then
				self.Count = "*"
			else
				self.Count = self.CountFormat:format(tostring(count))
			end
		else
			local charges, maxCharges = _IFActionTypeHandler[kind].GetActionCharges(self)

			if maxCharges and maxCharges > 1 then
				self.Count = self.CountFormat:format(tostring(charges), tostring(maxCharges))
			else
				self.Count = ""
			end
		end
	end

	function UpdateCooldown(self)
		self:Fire("OnCooldownUpdate", _IFActionTypeHandler[self.ActionType].GetActionCooldown(self))
	end

	function UpdateFlash(self)
		local kind = self.ActionType

		if (_IFActionTypeHandler[kind].IsAttackAction(self) and _IFActionTypeHandler[kind].IsActivedAction(self)) or _IFActionTypeHandler[kind].IsAutoRepeatAction(self) then
			StartFlash(self)
		else
			StopFlash(self)
		end
	end

	function StartFlash(self)
		self.Flashing = true
		_IFActionHandler_FlashingList[self] = self.Flashing or nil
		_IFActionHandler_FlashingTimer.Enabled = true
		self.FlashVisible = true
		UpdateButtonState(self)
	end

	function StopFlash(self)
		self.Flashing = false
		_IFActionHandler_FlashingList[self] = nil
		self.FlashVisible = false
		UpdateButtonState(self)
	end

	function UpdateTooltip(self)
		self = IGAS:GetWrapper(self)
		local anchor = self.GameTooltipAnchor

		if anchor then
			_GameTooltip:SetOwner(self, anchor)
		else
			if (GetCVar("UberTooltips") == "1") then
				GameTooltip_SetDefaultAnchor(_GameTooltip, self)
			else
				_GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			end
		end
		_IFActionTypeHandler[self.ActionType].SetTooltip(self, _GameTooltip)
		_IFActionHandler_OnTooltip =self

		IGAS:GetUI(self).UpdateTooltip = UpdateTooltip

		_GameTooltip:Show()
	end

	function UpdateOverlayGlow(self)
		local spellId = _IFActionTypeHandler[self.ActionType].GetSpellId(self)

		if spellId and IsSpellOverlayed(spellId) then
			ShowOverlayGlow(self)
		else
			HideOverlayGlow(self)
		end
	end

	function ShowOverlayGlow(self)
		if not self._IFActionHandler_OverLay then
			local alert = _RecycleAlert()
			local width, height = self:GetSize()

			alert.Parent = self

			alert:ClearAllPoints()
			alert:SetSize(width*1.4, height*1.4)
			alert:SetPoint("CENTER", self, "CENTER")

			alert._ActionButton = self
			self._IFActionHandler_OverLay = alert
			self._IFActionHandler_OverLay.AnimInPlaying = true
		end
	end

	function HideOverlayGlow(self)
		if self._IFActionHandler_OverLay then
			if self.Visible then
				self._IFActionHandler_OverLay.AnimOutPlaying = true
			else
				SpellAlert_OnFinished(self._IFActionHandler_OverLay)
			end
		end
	end

	function UpdateRange(self)
		self.InRange = _IFActionTypeHandler[self.ActionType].IsInRange(self)
	end

	function UpdateFlyout(self)
		self.FlyoutVisible = self.ShowFlyOut or _IFActionTypeHandler[self.ActionType].IsFlyout(self)
	end

	function UpdateAutoCastable(self)
		self.AutoCastable = _IFActionTypeHandler[self.ActionType].IsAutoCastAction(self)
	end

	function UpdateAutoCasting(self)
		self.AutoCasting = _IFActionTypeHandler[self.ActionType].IsAutoCasting(self)
	end

	function UpdateActionButton(self)
		local kind = self.ActionType
		local handler = _IFActionTypeHandler[kind]

		if handler.IsAttackAction(self) then
			_AutoAttackButtons[self] = true
		elseif _AutoAttackButtons[self] then
			_AutoAttackButtons[self] = nil
		end

		if handler.IsAutoRepeatAction(self) then
			_AutoRepeatButtons[self] = true
		elseif _AutoRepeatButtons[self] then
			_AutoRepeatButtons[self] = nil
		end

		_Spell4Buttons[self] = handler.GetSpellId(self)

		if self.UseRangeCheck and handler.HasAction(self) then
			_RangeCheckButtons[self] = true
		elseif _RangeCheckButtons[self] then
			_RangeCheckButtons[self] = nil
		end

		if handler.IsPlayerAction and handler.ReceiveStyle ~= "Block" then
			UpdateGrid(self)
		end

		if handler.IsPetAction and handler.ReceiveStyle ~= "Block" then
			UpdatePetGrid(self)
		end

		UpdateButtonState(self)
		UpdateUsable(self)
		UpdateCooldown(self)
		UpdateFlyout(self)
		UpdateAutoCastable(self)
		UpdateAutoCasting(self)

		-- Whether the action is an equipped item
		self.EquippedItemIndicator = handler.IsEquippedItem(self)

		-- Update Action Text
		if not handler.IsConsumableAction(self) then
			self.Text = handler.GetActionText(self)
		else
			self.Text = ""
		end

		-- Update icon
		self.Icon = handler.GetActionTexture(self)

		UpdateCount(self)
		UpdateOverlayGlow(self)

		if _IFActionHandler_OnTooltip == self then
			UpdateTooltip(self)
		end

		handler.RefreshButton(self)

		return self:UpdateAction()
	end

	function RefreshTooltip()
		if _IFActionHandler_OnTooltip then
			return UpdateTooltip(_IFActionHandler_OnTooltip)
		end
	end

	-- Special definition
	__Final__() __Sealed__()
	interface "ActionRefreshMode"
		RefreshGrid = UpdateGrid
		RefreshPetGrid = UpdatePetGrid
		RefreshButtonState = UpdateButtonState
		RefreshUsable = UpdateUsable
		RefreshCooldown = UpdateCooldown
		RefreshFlash = UpdateFlash
		RefreshFlyout = UpdateFlyout
		RefreshAutoCastable = UpdateAutoCastable
		RefreshAutoCasting = UpdateAutoCasting
		RefreshActionButton = UpdateActionButton
		RefreshCount = UpdateCount
		RefreshOverlayGlow = UpdateOverlayGlow
		RefreshTooltip = RefreshTooltip
	endinterface "ActionRefreshMode"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	_IFActionHandler_InitEvent = false

	function InitEventHandler()
		if _IFActionHandler_InitEvent then return end
		_IFActionHandler_InitEvent = true

		-- Smart event register
		for evt, func in pairs(_IFActionHandler_ManagerFrame) do
			if type(func) == "function" and type(evt) == "string" and evt == strupper(evt) then
				_IFActionHandler_ManagerFrame:RegisterEvent(evt)
			end
		end
	end

	function UninstallEventHandler()
		_IFActionHandler_ManagerFrame:UnregisterAllEvents()
		_IFActionHandler_InitEvent = false
	end

	function _IFActionHandler_ManagerFrame:ACTIONBAR_SHOWGRID()
		_IFActionHandler_GridCounter = _IFActionHandler_GridCounter + 1
		if _IFActionHandler_GridCounter == 1 then
			for kind, handler in pairs(_IFActionTypeHandler) do
				if handler.IsPlayerAction and handler.ReceiveStyle ~= "Block" then
					_IFActionHandler_Buttons:EachK(kind, UpdateGrid)
				end
			end
		end
	end

	function _IFActionHandler_ManagerFrame:ACTIONBAR_HIDEGRID()
		if _IFActionHandler_GridCounter > 0 then
			_IFActionHandler_GridCounter = _IFActionHandler_GridCounter - 1
			if _IFActionHandler_GridCounter == 0 then
				for kind, handler in pairs(_IFActionTypeHandler) do
					if handler.IsPlayerAction and handler.ReceiveStyle ~= "Block" then
						_IFActionHandler_Buttons:EachK(kind, UpdateGrid)
					end
				end
			end
		end
	end

	function _IFActionHandler_ManagerFrame:ARCHAEOLOGY_CLOSED()
		_IFActionHandler_Buttons:Each(UpdateButtonState)
	end

	function _IFActionHandler_ManagerFrame:PET_BAR_SHOWGRID()
		_IFActionHandler_PetGridCounter = _IFActionHandler_PetGridCounter + 1
		if _IFActionHandler_PetGridCounter == 1 then
			for kind, handler in pairs(_IFActionTypeHandler) do
				if handler.IsPetAction and handler.ReceiveStyle ~= "Block" then
					_IFActionHandler_Buttons:EachK(kind, UpdatePetGrid)
				end
			end
		end
	end

	function _IFActionHandler_ManagerFrame:PET_BAR_HIDEGRID()
		if _IFActionHandler_PetGridCounter > 0 then
			_IFActionHandler_PetGridCounter = _IFActionHandler_PetGridCounter - 1
			if _IFActionHandler_PetGridCounter == 0 then
				for kind, handler in pairs(_IFActionTypeHandler) do
					if handler.IsPetAction and handler.ReceiveStyle ~= "Block" then
						_IFActionHandler_Buttons:EachK(kind, UpdatePetGrid)
					end
				end
			end
		end
	end

	function _IFActionHandler_ManagerFrame:PLAYER_ENTER_COMBAT()
		for button in pairs(_AutoAttackButtons) do
			StartFlash(button)
		end
	end

	function _IFActionHandler_ManagerFrame:PLAYER_LEAVE_COMBAT()
		for button in pairs(_AutoAttackButtons) do
			StopFlash(button)
		end
	end

	function _IFActionHandler_ManagerFrame:PLAYER_TARGET_CHANGED()
		_IFActionHandler_UpdateRangeTimer:OnTimer()
	end

	function _IFActionHandler_ManagerFrame:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(spellId)
		for button, id in pairs(_Spell4Buttons) do
			if id == spellId then
				ShowOverlayGlow(button)
			end
		end
	end

	function _IFActionHandler_ManagerFrame:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(spellId)
		for button, id in pairs(_Spell4Buttons) do
			if id == spellId then
				HideOverlayGlow(button, true)
			end
		end
	end

	function _IFActionHandler_ManagerFrame:SPELL_UPDATE_CHARGES()
		for button in pairs(_Spell4Buttons) do
			UpdateCount(button)
		end
	end

	function _IFActionHandler_ManagerFrame:START_AUTOREPEAT_SPELL()
		for button in pairs(_AutoRepeatButtons) do
			if not _AutoAttackButtons[button] then
				StartFlash(button)
			end
		end
	end

	function _IFActionHandler_ManagerFrame:STOP_AUTOREPEAT_SPELL()
		for button in pairs(_AutoRepeatButtons) do
			if button.Flashing and not _AutoAttackButtons[button] then
				StopFlash(button)
			end
		end
	end

	function _IFActionHandler_ManagerFrame:TRADE_SKILL_SHOW()
		_IFActionHandler_Buttons:Each(UpdateButtonState)
	end

	function _IFActionHandler_ManagerFrame:TRADE_SKILL_CLOSE()
		_IFActionHandler_Buttons:Each(UpdateButtonState)
	end

	function _IFActionHandler_ManagerFrame:UNIT_ENTERED_VEHICLE(unit)
		if unit == "player" then
			_IFActionHandler_Buttons:Each(UpdateButtonState)
		end
	end

	function _IFActionHandler_ManagerFrame:UNIT_EXITED_VEHICLE(unit)
		if unit == "player" then
			_IFActionHandler_Buttons:Each(UpdateButtonState)
		end
	end

	function _IFActionHandler_ManagerFrame:UNIT_INVENTORY_CHANGED(unit)
		if unit == "player" then
			return RefreshTooltip()
		end
	end

	function _IFActionHandler_UpdateRangeTimer:OnTimer()
		for btn in pairs(_RangeCheckButtons) do
			UpdateRange(btn)
		end
	end

	function _IFActionHandler_FlashingTimer:OnTimer()
		if not next(_IFActionHandler_FlashingList) then
			_IFActionHandler_FlashingTimer.Enabled = false
		end
		for button in pairs(_IFActionHandler_FlashingList) do
			button.FlashVisible = not button.FlashVisible
		end
	end

	function SpellAlert_OnFinished(self)
		if self._ActionButton then
			self._ActionButton._IFActionHandler_OverLay = nil
			self._ActionButton = nil
			self.Parent = _IFActionHandler_ManagerFrame
			self:StopAnimation()
			self:ClearAllPoints()
			self:Hide()

			return _RecycleAlert(self)
		end
	end

	function _RecycleAlert:OnInit(alert)
		alert.OnFinished = SpellAlert_OnFinished
	end
end

__Doc__[[IFActionHandler is used to manage action buttons]]
__AutoProperty__()
interface "IFActionHandler"
	extend "IFSecureHandler" "IFCooldown"
	require "CheckButton"

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnShow(self)
		if _IFActionTypeHandler[self.ActionType].IsPlayerAction then
			UpdateGrid(self)
		else
			UpdatePetGrid(self)
		end
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Object Method
	------------------------------------------------------
	__Doc__[[Used to customize action button when it's content is changed]]
	__Optional__() function UpdateAction(self) end

	__Doc__[[
		<desc>Set action for the actionbutton</desc>
		<param name="kind">System.Widget.Action.IFActionHandler.ActionType, the action type</param>
		<param name="target">the action't target</param>
		<param name="detail">the action's detail</param>
		]]
	function SetAction(self, kind, target, detail)
		if kind and not _ActionTypeMap[kind] then
			error("IFActionHandler:SetAction(kind, target, detail) - no such action kind", 2)
		end

		if not kind or not target then
			kind, target, detail = nil, nil, nil
		end

		Task.NoCombatCall(SaveAction, self, kind, target, detail)
	end

	__Doc__[[
		<desc>Get action for the actionbutton</desc>
		<return type="kind">System.Widget.Action.IFActionHandler.ActionType, the action type</return>
		<return type="target">any, the action's target</return>
		<return type="detail">any, the action's detail</return>
	]]
	function GetAction(self)
		return self.__IFActionHandler_Kind, self.__IFActionHandler_Target, self.__IFActionHandler_Detail
	end

	__Doc__[[
		<desc>Whether the action button has action content</desc>
		<return type="boolean">true if the button has action</return>
	]]
	function HasAction(self)
		return _IFActionTypeHandler[self.ActionType].HasAction(self)
	end

	__Doc__[[
		<desc>Set flyoutDirection for action button</desc>
		<param name="dir">System.Widget.Action.IFActionHandler.FlyoutDirection</param>
		]]
	function SetFlyoutDirection(self, dir)
		dir = Reflector.Validate(FlyoutDirection, dir, "dir", "Usage: IFActionHandler:SetFlyoutDirection(dir) -")

		self:SetAttribute("flyoutDirection", dir)
	end

	__Doc__[[
		<desc>Get flyoutDirection for action button</desc>
		<return type="dir">System.Widget.Action.IFActionHandler.FlyoutDirection</return>
	]]
	function GetFlyoutDirection(self)
		return self:GetAttribute("flyoutDirection") or FlyoutDirection.UP
	end

	__Doc__[[Refresh the button manually]]
	Refresh = UpdateActionButton

	------------------------------------------------------
	-- Interface Method
	------------------------------------------------------
	__Doc__[[
		<desc>Make the group's action buttons draggable</desc>
		<param name="group">string|nil, the action button's group</param>
		]]
	__Static__() function _EnableGroupDrag(group)
		Task.NoCombatCall(EnableDrag, group)
	end

	__Doc__[[
		<desc>Whether if the action button group draggable</desc>
		<param name="group">string|nil, the action button's group</param>
		<return type="boolean">true if the group's action buttons are draggable</return>
	]]
	__Static__() function _IsGroupDragEnabled(group)
		return IsDragEnabled(group)
	end

	__Doc__[[
		<desc>Make the group's action buttons un-draggable</desc>
		<param name="group">string|nil, the action button's group</param>
		]]
	__Static__() function _DisableGroupDrag(group)
		Task.NoCombatCall(DisableDrag, group)
	end

	__Doc__[[
		<desc>Make the group's action buttons using mouse down to trigger actions</desc>
		<param name="group">string|nil, the action button's group</param>
		]]
	__Static__() function _EnableGroupUseButtonDown(group)
		Task.NoCombatCall(EnableButtonDown, group)
	end

	__Doc__[[
		<desc>Whether if the action group buttons using mouse down</desc>
		<param name="boolean"> string|nil, the action button's group</param>
		<return type="boolean">true if the group action buttons are using mouse down</return>
	]]
	__Static__() function _IsGroupUseButtonDownEnabled(group)
		return IsButtonDownEnabled(group)
	end

	__Doc__[[
		<desc>Make the group's action buttons using mouse up to trigger actions</desc>
		<param name="group">string|nil, the action button's group</param>
		]]
	__Static__() function _DisableGroupUseButtonDown(group)
		Task.NoCombatCall(DisableButtonDown, group)
	end

	------------------------------------------------------
	-- Group Property
	------------------------------------------------------
	__Doc__[[Overridable, the action button's group name]]
	__Optional__() property "IFActionHandlerGroup" {
		Set = function (self, group)
			group = GetGroup(group)

			self:SetAttribute("IFActionHandlerGroup", group)

	    	if _DBCharUseDown[group] then
	    		self:RegisterForClicks("AnyDown")
			else
				self:RegisterForClicks("AnyUp")
			end
		end,
		Get = function (self)
			return self:GetAttribute("IFActionHandlerGroup")
		end,
		Default = _GlobalGroup,
		Type = String,
	}

	------------------------------------------------------
	-- Action Property
	------------------------------------------------------
	__Doc__[[The action button's type]]
	property "ActionType" {
		Default = "empty",
		Get = function(self)
			return self.__IFActionHandler_Kind
		end,
	}

	__Doc__[[The action button's content]]
	property "ActionTarget" {
		Get = function(self)
			return self.__IFActionHandler_Target
		end,
	}

	__Doc__[[The action button's detail]]
	property "ActionDetail" {
		Get = function(self)
			return self.__IFActionHandler_Detail
		end,
	}

	------------------------------------------------------
	-- Display Property
	------------------------------------------------------
	__Doc__[[Whether show the action button with no content, controlled by IFActionHandler]]
	__Handler__( OnShow )
	property "ShowGrid" { Type = Boolean }

	__Doc__[[Whether show the action button's flyout icon, controlled by IFActionHandler]]
	__Handler__( UpdateFlyout )
	property "ShowFlyOut" { Type = Boolean }

	__Doc__[[The action button's flyout direction, used to refresh the action count as a trigger]]
	property "FlyoutDirection" { Type = FlyoutDirection }

	__Doc__[[Whether the action is usable, used to refresh the action button as a trigger]]
	__Optional__() property "Usable" { Type = Boolean }

	__Doc__[[The action's count, used to refresh the action count as a trigger]]
	__Optional__() property "Count" { Type = String }

	__Doc__[[The format of the count string]]
	__Handler__(UpdateCount)
	property "CountFormat" { Type = String, Default = "%s" }

	__Doc__[[Whether need flash the action, used to refresh the action count as a trigger]]
	__Optional__() property "Flashing" { Type = Boolean }

	__Doc__[[The action button's flash texture's visible, used to refresh the action count as a trigger]]
	__Optional__() property "FlashVisible" { Type = Boolean }

	__Doc__[[The action button's flyout's visible, used to refresh the action count as a trigger]]
	__Optional__() property "FlyoutVisible" { Type = Boolean }

	__Doc__[[The action't text, used to refresh the action count as a trigger]]
	__Optional__() property "Text" { Type = String }

	__Doc__[[The action's icon path, used to refresh the action count as a trigger]]
	__Optional__() property "Icon" { Type = String + Number }

	__Doc__[[Whether the action is in range, used to refresh the action count as a trigger]]
	__Optional__() property "InRange" { Type = BooleanNil_01 }

	__Doc__[[Whether the action is auto-castable, used to refresh the action count as a trigger]]
	__Optional__() property "AutoCastable" { Type = Boolean }

	__Doc__[[Whether the action is now auto-casting, used to refresh the action count as a trigger]]
	__Optional__() property "AutoCasting" { Type = Boolean }

	__Doc__[[The max count to display]]
	__Optional__() property "MaxDisplayCount" { Type = Number, Default = 9999 }

	__Doc__[[Whether an indicator should be shown for equipped item]]
	__Optional__() property "EquippedItemIndicator" { Type = Boolean }

	__Doc__[[Whether the action should check the range]]
	__Optional__() property "UseRangeCheck" { Type = Boolean }

	__Doc__[[Whether the search overlay will be shown]]
	property "ShowSearchOverlay" { Type = Boolean }

	__Doc__[[Whether the action button's icon is locked]]
	__Optional__() property "IconLocked" { Type = Boolean }

	__Doc__[[The anchor point of the gametooltip]]
	property "GameTooltipAnchor" { Type = AnchorType }

	__Doc__[[Whether the button is block grid updating, should handle it by itself.]]
	__Handler__( OnShow )
	property "BlockGridUpdating" { Type = Boolean }

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		self:SetAction(nil)
		_IFActionHandler_Buttons:Remove(self)
		if #_IFActionHandler_Buttons == 0 then
			_IFActionHandler_UpdateRangeTimer.Enabled = false
			UninstallEventHandler()
		end
		return Task.NoCombatCall(UninstallActionButton, IGAS:GetUI(self))
	end

	------------------------------------------------------
	-- Initialize
	------------------------------------------------------
    function IFActionHandler(self)
    	_IFActionHandler_UpdateRangeTimer.Enabled = true
    	InitEventHandler()

    	-- Don't know what the authors would do with the property, so make sure all done here.
    	local group = GetGroup(self.IFActionHandlerGroup)

    	self:SetAttribute("IFActionHandlerGroup", group)

    	if _DBCharUseDown[group] then
    		self:RegisterForClicks("AnyDown")
		else
			self:RegisterForClicks("AnyUp")
		end
		self:RegisterForDrag("LeftButton", "RightButton")
		_IFActionHandler_Buttons:Insert(self)

		_IFActionHandler_Buttons[self] = self.ActionType

		self.OnShow = self.OnShow + OnShow

		return Task.NoCombatCall(SetupActionButton, self)
	end
endinterface "IFActionHandler"
