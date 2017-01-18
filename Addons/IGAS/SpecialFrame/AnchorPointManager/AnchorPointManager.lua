-- AnchorPoint manager

local version = 1

if not IGAS:NewAddon("IGAS.Special.AnchorPointManager", version) then
	return
end

import "System"
import "System.Widget"

------------------------------------
-- Definition
------------------------------------
do
	class "AnchorMask"
		inherit "Button"

		local _ClickStart

		local function OnClick(self)
			if self.IsChildAnchor then
				if _ClickStart then
					_ClickStart.NormalTexture:SetVertexColor(1, 1, 1)
				end
				_ClickStart = self
				self.NormalTexture:SetVertexColor(1, 0, 0)
			elseif _ClickStart then
				_ClickStart.AttachTo = self
				_ClickStart.NormalTexture:SetVertexColor(1, 1, 1)

				if _ClickStart.IsSingleAnchor then
					for k in System.Reflector.GetEnums(FramePoint) do
						local mask = AnchorMask(k, _AnchorPointManager_ChildMaskFrame)
						if mask ~= _ClickStart then
							mask.AttachTo = nil
						end
					end
				end

				_ClickStart = nil
			end
		end

		local function OnDoubleClick(self)
			if self.AttachFrom then
				self.AttachFrom.AttachTo = nil
			end
			if self.AttachTo then
				self.AttachTo = nil
			end

			if _ClickStart then
				_ClickStart.NormalTexture:SetVertexColor(1, 1, 1)
				_ClickStart = nil
			end
		end

		property "IsChildAnchor" { Type = Boolean }

		property "AttachFrom" { Type = AnchorMask }

		__Handler__(function(self, val, old)
			if val then
				if val.AttachFrom and val.AttachFrom ~= self then
					val.AttachFrom.AttachTo = nil
				end

				local line = self:GetChild("Line")
				if not line then
					line = Line("Line", self)
					line:SetThickness(2)
					line:SetColorTexture(1, 1, 1)
				end
				line:SetStartPoint("CENTER", self)
				line:SetEndPoint("CENTER", val)
				line:Show()

				val.AttachFrom = self
			else
				if self:GetChild("Line") then
					self:GetChild("Line"):Hide()
				end

				if old and old.AttachFrom == self then
					old.AttachFrom = nil
				end
			end
		end)
		property "AttachTo" { Type = AnchorMask }

		__Handler__(function(self, val)
			if val then
				self:ClearAllPoints()
				self:SetPoint("CENTER", self.Parent, val, 0, 0)
			end
		end)
		property "AnchorPoint" { Type = FramePoint }

		property "IsSingleAnchor" { Type = Boolean }

		function AnchorMask(self, ...)
			Super(self, ...)

			self.FrameStrata = "TOOLTIP"
			self.FrameLevel = 3

			self:SetSize(8, 8)
			self.NormalTexturePath = "Interface\\Tooltips\\UI-Tooltip-Background"
			self.NormalTexture:SetVertexColor(1, 1, 1)

			self.OnClick = self.OnClick + OnClick
			self.OnDoubleClick = self.OnDoubleClick + OnDoubleClick
		end
	endclass "AnchorMask"
end

------------------------------------
-- Designer
------------------------------------
do
	_AnchorPointManager_MsgBox = PopupDialog "IGAS_AnchorPointManager_MsgBox" {
		Style = "LIGHT",
		OkayButtonText = L"Okay",
		NoButtonText = L"No",
		CancelButtonText = L"Cancel",
		Message = L"Click the child's anchor point and then click the parent's to bind them, or double-click the anchor point to unbind them.",
		ShowNoButton = false,
		ShowCancelButton = true,
		ShowInputBox = false,
		FrameStrata = "TOOLTIP",
		TopLevel = true,
		FrameLevel = 5,
	}

	_AnchorPointManager_ParentMaskFrame = Frame "IGAS_AnchorPointManager_ParentMaskFrame" {
		Visible = false,
		TopLevel = true,
		FrameStrata = "TOOLTIP",
		FrameLevel = 1,
		MouseEnabled = true,
	}

	_AnchorPointManager_ChildMaskFrame = Frame "IGAS_AnchorPointManager_ChildMaskFrame" {
		Visible = false,
		TopLevel = true,
		FrameStrata = "TOOLTIP",
		FrameLevel = 2,
		MouseEnabled = true,
	}

	for k in System.Reflector.GetEnums(FramePoint) do
		AnchorMask(k, _AnchorPointManager_ParentMaskFrame).AnchorPoint = k
		AnchorMask(k, _AnchorPointManager_ChildMaskFrame).AnchorPoint = k
		AnchorMask(k, _AnchorPointManager_ChildMaskFrame).IsChildAnchor = true
	end
end

------------------------------------
-- Script
------------------------------------
do
	local _Thread
	local _Callback
	local _Parent
	local _Child

	function _AnchorPointManager_MsgBox:OnOkay()
		local loc = {}
		local parent

		if _Parent ~= _Child.Parent then parent = _Parent:GetName() end

		for k in System.Reflector.GetEnums(FramePoint) do
			local mask = AnchorMask(k, _AnchorPointManager_ChildMaskFrame)
			local maskTo = mask.AttachTo

			if maskTo then
				tinsert(loc, AnchorPoint(mask.AnchorPoint, 0, 0, parent, maskTo.AnchorPoint))
			end
		end

		if #loc > 0 then
			_Child:UpdateWithAnchorSetting(loc)
		end
	end

	function _AnchorPointManager_MsgBox:OnHide()
		_AnchorPointManager_ParentMaskFrame:ClearAllPoints()
		_AnchorPointManager_ParentMaskFrame.Visible = false

		_AnchorPointManager_ChildMaskFrame:ClearAllPoints()
		_AnchorPointManager_ChildMaskFrame.Visible = false

		for k in System.Reflector.GetEnums(FramePoint) do
			AnchorMask(k, _AnchorPointManager_ChildMaskFrame).AttachTo = nil
		end

		_Child = nil
		_Parent = nil

		if _Callback then
			return _Callback()
		elseif _Thread then
			return coroutine.resume(_Thread)
		end
	end

	function IGAS:ManageAnchorPoint(child, parent, isSingleAnchor, callback)
		if _AnchorPointManager_ParentMaskFrame.Visible then return end
		if not child then return end

		_Child = IGAS:GetWrapper(child)
		_Parent = IGAS:GetWrapper(parent or _Child.Parent)

		_AnchorPointManager_ParentMaskFrame:ClearAllPoints()
		_AnchorPointManager_ParentMaskFrame:SetAllPoints(_Parent)

		_AnchorPointManager_ChildMaskFrame:ClearAllPoints()
		_AnchorPointManager_ChildMaskFrame:SetAllPoints(_Child)

		local psize = math.min(_Parent.Width, _Parent.Height)
		psize = math.min(48, math.max(6, math.floor(psize / 3)))

		local csize = math.min(_Child.Width, _Child.Height)
		csize = math.min(48, math.max(6, math.floor(csize / 3)))

		for k in System.Reflector.GetEnums(FramePoint) do
			AnchorMask(k, _AnchorPointManager_ParentMaskFrame):SetSize(psize, psize)
			AnchorMask(k, _AnchorPointManager_ChildMaskFrame):SetSize(csize, csize)
			AnchorMask(k, _AnchorPointManager_ChildMaskFrame).IsSingleAnchor = isSingleAnchor
		end

		for i = 1, _Child:GetNumPoints() do
			local point, relativeTo, relativePoint, x, y = _Child:GetPoint(i)
			relativeTo = IGAS:GetWrapper(relativeTo)

			if relativeTo == _Parent then
				AnchorMask(point, _AnchorPointManager_ChildMaskFrame).AttachTo = AnchorMask(relativePoint, _AnchorPointManager_ParentMaskFrame)
			end
		end

		_AnchorPointManager_ParentMaskFrame.Visible = true
		_AnchorPointManager_ChildMaskFrame.Visible = true
		_AnchorPointManager_MsgBox.Visible = true

		if type(_Callback) == "function" then
			_Callback = callback
		else
			_Callback = nil
		end
		if coroutine.running() then
			_Thread = coroutine.running()
			coroutine.yield()
		else
			_Thread = nil
		end
	end
end
