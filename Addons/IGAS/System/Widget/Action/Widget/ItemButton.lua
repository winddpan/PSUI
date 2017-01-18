-- Author      : Kurapica
-- Create Date : 2016/08/01
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Action.ItemButton", version) then
	return
end

__Doc__[[the base item button template]]
__AutoProperty__()
class "ItemButton"
	inherit "BaseActionButton"

	TEXTURE_ITEM_QUEST_BANG = _G.TEXTURE_ITEM_QUEST_BANG
	TEXTURE_ITEM_QUEST_BORDER = _G.TEXTURE_ITEM_QUEST_BORDER
	NEW_ITEM_ATLAS_BY_QUALITY = System.Reflector.Clone(NEW_ITEM_ATLAS_BY_QUALITY, true)
	BAG_ITEM_QUALITY_COLORS = System.Reflector.Clone(BAG_ITEM_QUALITY_COLORS, true)
	DEFAULT_ITEM_ATLAS = "bags-glow-white"
	LE_ITEM_QUALITY_COMMON = _G.LE_ITEM_QUALITY_COMMON

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Handler__(function(self, val)
		if val then
			local itemID = GetContainerItemID(self.ActionTarget, self.ActionDetail)
			if IsArtifactRelicItem(itemID) then
				self.Border.TexturePath = [[Interface\Artifacts\RelicIconFrame]]
			else
				self.Border.TexturePath = [[Interface\Common\WhiteIconFrame]]
			end

			if val >= LE_ITEM_QUALITY_COMMON and BAG_ITEM_QUALITY_COLORS[val] then
				self.Border.VertexColor = BAG_ITEM_QUALITY_COLORS[val]
				self.Border.Visible = true
			else
				self.Border.Visible = false
			end
		else
			self.Border.Visible = false
		end
	end)
	property "ItemQuality" { Type = NumberNil }

	__Handler__(function(self, val)
		local questIcon = self:GetChild("QuestIcon")

		if val then
			questIcon.TexturePath = TEXTURE_ITEM_QUEST_BORDER
			questIcon.Visible = true
		elseif val == false then
			questIcon.TexturePath = TEXTURE_ITEM_QUEST_BANG
			questIcon.Visible = true
		else
			questIcon.Visible = false
		end
	end)
	property "ItemQuestStatus" { Type = BooleanNil }

	__Handler__(function(self, val)
		local newItem = self:GetChild("NewItemTexture")
		local battlePay = self:GetChild("BattlepayItemTexture")
		local glowFlash = self:GetChild("GlowFlash"):GetChild("GlowFlashAnim")
		local newItemAnim = self:GetChild("NewItemTexture"):GetChild("NewItemGlowAnim")
		if self.IsNewItem then
			if self.IsBattlePayItem then
				newItem.Visible = false
				battlePay.Visible = true
			else
				if self.ItemQuality and NEW_ITEM_ATLAS_BY_QUALITY[self.ItemQuality] then
					newItem.TexturePath = NEW_ITEM_ATLAS_BY_QUALITY[self.ItemQuality]
				else
					newItem.TexturePath = DEFAULT_ITEM_ATLAS
				end
				battlePay.Visible = false
				newItem.Visible = true
			end
			if not glowFlash.Playing and not newItemAnim.Playing then
				glowFlash.Playing = true
				newItemAnim.Playing = true
			end
		else
			battlePay.Visible = false
			newItem.Visible = false
			glowFlash.Playing = false
			newItemAnim.Playing = false
		end
	end)
	property "IsNewItem" { Type = Boolean }

	__Doc__[[Whether the item is a battle pay item]]
	property "IsBattlePayItem" { Type = Boolean }

	__Handler__(function(self, val)
		self:GetChild("JunkIcon").Visible = val
	end)
	property "ShowJunkIcon" { Type = Boolean }

	property "Count" {
		Get = function(self)
			return self:GetChild("Count").Text
		end,
		Set = function(self, value)
			if tonumber(value) == 1 then value = nil end
			self:GetChild("Count").Text = tostring(value or "")
		end,
		Type = StringNumber,
	}

	__Handler__(function(self, val)
		if val then
			self:GetChild("Icon"):SetVertexColor(1, 1, 1)
		else
			self:GetChild("Icon"):SetVertexColor(1, 0.1, 0.1)
		end
	end)
	property "BagUsable" { Type = Boolean, Default = true }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function ItemButton(self, ...)
		Super(self, ...)

		-- Quest Texture
		local questIcon = Texture("QuestIcon", self, "OVERLAY", nil, 1)
		questIcon:SetAllPoints()
		questIcon.Visible = false

		local junkIcon = Texture("JunkIcon", self, "OVERLAY")
		junkIcon:SetAtlas("bags-junkcoin", true)
		junkIcon:SetPoint("TOPLEFT", 1, 0)
		junkIcon.Visible = false

		local glowFlash = Texture("GlowFlash", self, "OVERLAY", nil, 1)
		glowFlash:SetAtlas("bags-glow-flash")
		glowFlash.Alpha = 0
		glowFlash.BlendMode = "ADD"
		glowFlash:SetAllPoints()

		local newItem = Texture("NewItemTexture", self, "OVERLAY", nil, 1)
		newItem:SetAtlas("bags-glow-green")
		newItem.Alpha = 0
		newItem.BlendMode = "ADD"
		newItem:SetAllPoints()

		local battlePay = Texture("BattlepayItemTexture", self, "OVERLAY", nil, 1)
		battlePay.TexturePath = [[Interface\Store\store-item-highlight]]
		battlePay:SetPoint("CENTER")
		battlePay.Visible = false

		local newItemGlow = AnimationGroup("NewItemGlowAnim", newItem)
		newItemGlow.ToFinalAlpha = true
		newItemGlow.Looping = "REPEAT"

		local alpha = Alpha("Alpha1", newItemGlow)
		alpha.Smoothing = "NONE"
		alpha.Order = 1
		alpha.Duration = 0.8
		alpha.FromAlpha = 1
		alpha.ToAlpha = 0.4

		alpha = Alpha("Alpha2", newItemGlow)
		alpha.Smoothing = "NONE"
		alpha.Order = 2
		alpha.Duration = 0.8
		alpha.FromAlpha = 0.4
		alpha.ToAlpha = 1

		local glowFlashAnim = AnimationGroup("GlowFlashAnim", glowFlash)
		glowFlashAnim.ToFinalAlpha = true

		alpha = Alpha("Alpha1", glowFlashAnim)
		alpha.Smoothing = "OUT"
		alpha.Duration = 0.6
		alpha.Order = 1
		alpha.FromAlpha = 1
		alpha.ToAlpha = 0
	end
endclass "ItemButton"
