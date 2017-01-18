-- Author      : Kurapica
-- Create Date : 2015/01/03
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Action.IFPushItemAnim", version) then
	return
end

_BagMap = {}

__Doc__[[IFPushItemAnim is used to provide the animation that push item into a bag.]]
__AutoProperty__()
interface "IFPushItemAnim"

	__AutoProperty__()
	class "PushItemAnim"
		inherit "Frame"

		local function flyin_OnPlay(self)
			self.Parent.Parent.Visible = true
		end

		local function flyin_OnFinished(self)
			local parent = self.Parent.Parent
			parent.Visible = false

			parent.Parent = IGAS.UIParent
			parent:ClearAllPoints()
			rycPushItemAnim:Push(parent)
		end

		------------------------------------------------------
		-- Method
		------------------------------------------------------
		function Play(self)
			return self.AnimIcon.Flyin:Play(true)
		end

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		__Doc__[[The Item's icon]]
		property "Icon" {
			Set = function (self, icon)
				self.AnimIcon.TexturePath = icon
			end
		}

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	    function PushItemAnim(self, ...)
	    	Super(self, ...)

			self.FrameStrata = "HIGH"
			self.MouseEnabled = false

	    	local animIcon = Texture("AnimIcon", self, "OVERLAY")
	    	animIcon:SetAllPoints(self)

	    	local flyin = AnimationGroup("Flyin", animIcon)

			local scale = Scale("Scale", flyin)
			scale.Duration = 1
			scale.Order = 1
			scale.FromScale = Dimension(0.125, 0.125)
			scale.ToScale = Dimension(1, 1)

			local alpha = Alpha("Alpha", flyin)
			alpha.Duration = 1
			alpha.Order = 1
			alpha.FromAlpha = 0
			alpha.ToAlpha = 1

			local path = Path("Path", flyin)
			path.Duration = 1
			path.Order = 1
			path.Curve = "SMOOTH"

			local cp1 = ControlPoint("Cp1", path)
			cp1.Offset = Dimension(-15, 30)

			local cp2 = ControlPoint("Cp2", path)
			cp2.Offset = Dimension(-75, 60)

			flyin.OnPlay = flyin_OnPlay
			flyin.OnFinished = flyin_OnFinished
	    end
	endclass "PushItemAnim"

	__Doc__[[
		<desc>Attach bag with id</desc>
		<param name="bag">the region used for the bag</param>
		<param name="id" optional="true">the bag slot index</param>
	]]
	__Static__() __Arguments__{ Region, Argument(Number) }
	function AttachBag(bag, id)
		_BagMap[bag] = id
	end

	__Static__() __Arguments__{ Region, Argument(Boolean, true, true) }
	function AttachBag(bag, id)
		_BagMap[bag] = id or nil
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
    function Dispose(self) _BagMap[self] = nil end

	------------------------------------------------------
	-- Initialize
	------------------------------------------------------
    function IFPushItemAnim(self) AttachBag(self) end
endinterface "IFPushItemAnim"

rycPushItemAnim = Recycle(IFPushItemAnim.PushItemAnim, "IGAS_PushItemAnim%d")

function ITEM_PUSH(self, bagid, icon)
	for bag, id in pairs(_BagMap) do
		if id == true then id = bag.ID end
		if id == bagid and bag.Visible then
			local anim = rycPushItemAnim()
			anim.Parent = bag
			anim:SetAllPoints(bag)

			anim.Icon = icon
			anim:Play()
		end
	end
end

-- Start Listening
_M:RegisterEvent("ITEM_PUSH")
