-- Author      : Kurapica
-- Create Date : 7/16/2008 11:55
-- Change Log  :
--				2011/03/13	Recode as class
--				2011/06/01	Fix name conflict

-- Check Version
local version = 8
if not IGAS:NewAddon("IGAS.Widget.GameTooltip", version) then
	return
end

__Doc__[[GameTooltips are used to display explanatory information relevant to a particular element of the game world.]]
__AutoProperty__()
class "GameTooltip"
	inherit "Frame"

	COPPER_PER_SILVER = COPPER_PER_SILVER
	SILVER_PER_GOLD = SILVER_PER_GOLD

	------------------------------------------------------
	-- Event
	------------------------------------------------------
	__Doc__[[
		<desc>Run when an amount of money should be added to the tooltip</desc>
		<param name="amount">number, amount of money to be added to the tooltip (in copper)</param>
		<param name="maxAmount">number, a second amount of money to be added to the tooltip (in copper); if non-nil, the first amount is treated as the minimum and this amount as the maximum of a price range</param>
	]]
	__WidgetEvent__() event "OnTooltipAddMoney"

	__Doc__[[Run when the tooltip is hidden or its content is cleared]]
	__WidgetEvent__() event "OnTooltipCleared"

	__Doc__[[Run when the tooltip is filled with information about an achievement]]
	__WidgetEvent__() event "OnTooltipSetAchievement"

	__Doc__[[Run when the tooltip is repositioned to its default anchor location]]
	__WidgetEvent__() event "OnTooltipSetDefaultAnchor"

	__Doc__[[Run when the tooltip is filled with information about an equipment set]]
	__WidgetEvent__() event "OnTooltipSetEquipmentSet"

	__Doc__[[Run when the tooltip is filled with a list of frames under the mouse cursor]]
	__WidgetEvent__() event "OnTooltipSetFrameStack"

	__Doc__[[Run when the tooltip is filled with information about an item]]
	__WidgetEvent__() event "OnTooltipSetItem"

	__Doc__[[Run when the tooltip is filled with information about a quest]]
	__WidgetEvent__() event "OnTooltipSetQuest"

	__Doc__[[Run when the tooltip is filled with information about a spell]]
	__WidgetEvent__() event "OnTooltipSetSpell"

	__Doc__[[Run when the tooltip is filled with information about a unit]]
	__WidgetEvent__() event "OnTooltipSetUnit"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"AddDoubleLine" [[
		<desc>Adds a line to the tooltip with both left-side and right-side portions. The tooltip is not automatically resized to fit the added line; to do so, call the tooltip's :Show() method after adding lines.</desc>
		<param name="textLeft">string, text to be displayed on the left side of the new line</param>
		<param name="textRight">string, text to be displayed on the right side of the new line</param>
		<param name="rL">number, red component of the color for the left-side text (0.0 - 1.0)</param>
		<param name="gL">number, green component of the color for the left-side text (0.0 - 1.0)</param>
		<param name="bL">number, blue component of the color for the left-side text (0.0 - 1.0)</param>
		<param name="rR">number, red component of the color for the right-side text (0.0 - 1.0)</param>
		<param name="gR">number, green component of the color for the right-side text (0.0 - 1.0)</param>
		<param name="bR">number, blue component of the color for the right-side text (0.0 - 1.0)</param>
	]]

	__Doc__"AddFontStrings" [[
		<desc> Adds FontString objects to the tooltip, allowing it to display an additional line of text. This method is of little utility outside of Blizzard scripts, as the tooltip automatically creates new font strings for additional lines as needed.</desc>
		<param name="left">System.Widget.FontString, reference to a FontString object for the left-side text of a new line</param>
		<param name="right">System.Widget.FontString, reference to a FontString object for the right-side text of a new line</param>
	]]

	__Doc__"AddLine" [[
		<desc>Adds a line of text to the tooltip. The tooltip is not automatically resized to fit the added line (and wrap it, if applicable); to do so, call the tooltip's :Show() method after adding lines.</desc>
		<param name="text">string, text to be added as a new line in the tooltip</param>
		<param name="r">number, red component of the text color (0.0 - 1.0)</param>
		<param name="g">number, green component of the text color (0.0 - 1.0)</param>
		<param name="b">number, blue component of the text color (0.0 - 1.0)</param>
		<param name="wrap">boolean, true to cause the line to wrap if it is longer than other, non-wrapping lines in the tooltip or longer than the tooltip's forced width</param>
	]]

	__Doc__"AddSpellByID" [[
		<param name="spellId">number</param>
	]]

	__Doc__"AddTexture" [[
		<desc>Adds a texture to the last tooltip line. The texture is sized to match the height of the line's text and positioned to the left of the text (indenting the text to provide room).</desc>
		<param name="texture">string, path to a texture image file</param>
	]]

	__Doc__"AppendText" [[
		<desc>Adds text to the first line of the tooltip</desc>
		<param name="text">string, text to be appended to the tooltip's first line</param>
	]]

	__Doc__"ClearLines" [[Clears the tooltip's contents. Scripts scanning the tooltip contents should be aware that this method clears the text of all the tooltip's left-side font strings but hides the right-side font strings without clearing their text.]]

	__Doc__"FadeOut" [[Causes the tooltip to begin fading out]]

	__Doc__"GetAnchorType" [[
		<desc>Returns the method for anchoring the tooltip relative to its owner</desc>
		<return type="System.Widget.AnchorType"></return>
	]]

	__Doc__"GetItem" [[
		<desc>Returns the name and hyperlink for the item displayed in the tooltip</desc>
		<return type="name">string, name of the item whose information is displayed in the tooltip, or nil.</return>
		<return type="link">string, a hyperlink for the item</return>
	]]

	__Doc__"GetMinimumWidth" [[
		<desc>Returns the minimum width of the tooltip</desc>
		<return type="number">Minimum width of the tooltip frame (in pixels)</return>
	]]

	__Doc__[[
		<desc>Returns the frame to which the tooltip refers and is anchored</desc>
		<return type="System.Widget.Region">Reference to the Frame object to which the tooltip is anchored</return>
	]]
	function GetOwner(self, ...)
		return IGAS:GetWrapper(self.__UI:GetOwner(...))
	end

	__Doc__"GetPadding" [[
		<desc>Returns the amount of space between tooltip's text and its right-side edge</desc>
		<return type="padding">number, amount of space between the right-side edge of the tooltip's text and the right-side edge of the tooltip frame (in pixels)</return>
	]]

	__Doc__"GetSpell" [[
		<desc>Returns information about the spell displayed in the tooltip</desc>
		<return type="spellName">string, name of the spell, or nil if the information in the tooltip is not for a spell</return>
		<return type="spellRank">string, secondary text associated with the spell name (often a rank, e.g. "Rank 8")</return>
		<return type="spellID">number, numeric identifier for the spell and rank</return>
	]]

	__Doc__"GetUnit" [[
		<desc>Returns information about the unit displayed in the tooltip</desc>
		<return type="name">string, name of the unit displayed in the tooltip, or nil</return>
		<return type="unit">string, unit identifier of the unit, or nil if the unit cannot be referenced by a unitID</return>
	]]

	__Doc__"IsEquippedItem" [[
		<desc>Returns whether the tooltip is displaying an item currently equipped by the player</desc>
		<return type="boolean">1 if the tooltip is displaying information about an item currently equipped by the player; otherwise nil</return>
	]]

	__Doc__"IsOwned" [[
		<desc>Returns whether the tooltip has an owner frame</desc>
		<return type="boolean">1 if the tooltip has an owner frame; otherwise nil</return>
	]]

	__Doc__"IsUnit" [[
		<desc>Returns whether the tooltip is displaying information for a given unit</desc>
		<return type="boolean">1 if the tooltip is displaying information for the unit; otherwise nil</return>
	]]

	__Doc__"NumLines" [[
		<desc>Returns the number of lines of text currently shown in the tooltip</desc>
		<return type="number">Number of lines currently shown in the tooltip</return>
	]]

	__Doc__"SetAction" [[
		<desc>Fills the tooltip with information about the contents of an action slot</desc>
		<param name="slot">number, an action bar slot</param>
	]]

	__Doc__"SetAnchorType" [[
		<desc>Sets the method for anchoring the tooltip relative to its owner</desc>
		<param name="anchor">System.Widget.AnchorType</param>
	]]

	__Doc__"SetAuctionItem" [[
		<desc>Fills the tooltip with information about an item in the auction house</desc>
		<param name="list">string, type of auction listing: bidder|list|owner</param>
		<param name="index">number, index of an auction in the listing</param>
	]]

	__Doc__"SetBackpackToken" [[
		<desc>Fills the tooltip with information about a currency marked for watching on the Backpack UI</desc>
		<param name="index">number, index of a 'slot' for displaying currencies on the backpack (between 1 and MAX_WATCHED_TOKENS)</param>
	]]

	__Doc__"SetBagItem" [[
		<desc>Fills the tooltip with information about an item in the player's bags</desc>
		<param name="container">number, index of one of the player's bags or other containers</param>
		<param name="slot">number, index of an item slot within the container</param>
		<return type="hasCooldown">boolean, 1 if the item is currently on cooldown, otherwise nil</return>
		<return type="repairCost">number, cost of repairing the item (in copper, ignoring faction discounts)</return>
	]]

	__Doc__"SetBuybackItem" [[
		<desc>Fills the tooltip with information about item recently sold to a vendor and available to be repurchased</desc>
		<param name="index">number, ndex of an item in the buyback listing (between 1 and GetNumBuybackItems())</param>
	]]

	__Doc__"SetCurrencyByID" [[
		<desc>Fills the tooltip with information about a specified currency</desc>
		<param name="currencyID">number, a currencyID. All currently known currencyIDs</param>
	]]

	__Doc__"SetCurrencyToken" [[
		<desc>Fills the tooltip with information about a special currency type. Note that passing the index of a header will crash the client.</desc>
		<param name="index">number, index of a currency type in the currency list (between 1 and GetCurrencyListSize())</param>
	]]

	__Doc__"SetEquipmentSet" [[
		<desc>Fills the tooltip with information about an equipment set</desc>
		<param name="name">string, name of the equipment set</param>
	]]

	__Doc__"SetExistingSocketGem" [[
		<desc>Fills the tooltip with information about a permanently socketed gem</desc>
		<param name="index">number, index of a gem socket (between 1 and GetNumSockets())</param>
		<param name="toDestroy">boolean, true to alter the tooltip display to indicate that this gem will be destroyed by socketing a new gem; false to show the normal tooltip for the gem</param>
	]]

	__Doc__"SetFrameStack" [[
		<desc>Fills the tooltip with a list of frames under the mouse cursor. Not relevant outside of addon development and debugging.</desc>
		<param name="includeHidden">boolean, true to include hidden frames in the list; false to list only visible frames</param>
	]]

	__Doc__"SetGuildBankItem" [[
		<desc>Fills the tooltip with information about an item in the guild bank. Information is only available if the guild bank tab has been opened in the current play session.</desc>
		<param name="tab">number, index of a guild bank tab (between 1 and GetNumGuildBankTabs())</param>
		<param name="slot">number, index of an item slot in the guild bank tab (between 1 and MAX_GUILDBANK_SLOTS_PER_TAB)</param>
	]]

	__Doc__"SetHyperlink" [[
		<desc>Fills the tooltip with information about an item, quest, spell, or other entity represented by a hyperlink</desc>
		<param name="hyperlink">string, a full hyperlink, or the linktype:linkdata portion thereof</param>
	]]

	__Doc__"SetHyperlinkCompareItem" [[
		<desc>Fills the tooltip with information about the item currently equipped in the slot used the supplied item</desc>
		<param name="hyperlink">string, a full hyperlink, or the linktype:linkdata portion thereof, for an item to compare against the player's equipped similar item</param>
		<param name="index">number, index of the slot to compare against (1, 2, or 3), if more than one item of the equipment type can be equipped at once (e.g. rings and trinkets)</param>
		<return type="boolean">1 if an item's information was loaded into the tooltip; otherwise nil</return>
	]]

	__Doc__"SetInboxItem" [[
		<desc>Fills the tooltip with information about an item attached to a message in the player's inbox</desc>
		<param name="mailID">number, index of a message in the player's inbox (between 1 and GetInboxNumItems())</param>
		<param name="attachmentIndex">number, index of an attachment to the message (between 1 and select(8,GetInboxHeaderInfo(mailID)))</param>
	]]

	__Doc__"SetInstanceLockEncountersComplete" [[
		<param name="id">number</param>
	]]

	__Doc__"SetInventoryItem" [[
		<desc>Fills the tooltip with information about an equipped item</desc>
		<param name="unit">string, a unit to query; only valid for 'player' or the unit currently being inspected</param>
		<param name="slot">number, an inventory slot number, as can be obtained from GetInventorySlotInfo</param>
		<param name="nameOnly">boolean, true to omit much of the item's information (stat bonuses, sockets, and binding) from the tooltip; false to show all of the item's information</param>
		<return type="hasItem">boolean, 1 if the unit has an item in the given slot; otherwise nil</return>
		<return type="hasCooldown">boolean, 1 if the item is currently on cooldown; otherwise nil</return>
		<return type="repairCost">number, Cost to repair the item (in copper, ignoring faction discounts)</return>
	]]

	__Doc__"SetInventoryItemByID" [[
		<param name="id">number</param>
	]]

	__Doc__"SetLFGCompletionReward" [[
		<desc>Fills the tooltip with the information about the LFG completion reward</desc>
		<param name="index">number reward ID</param>
	]]

	__Doc__"SetLFGDungeonReward" [[
		<desc>Fills the tooltip with the information about the LFD completion reward</desc>
		<param name="index">number reward ID</param>
	]]

	__Doc__"SetLootCurrency" [[
		<desc>Fills the tooltip with information about the loot currency</desc>
		<param name="slot">number</param>
	]]

	__Doc__"SetLootItem" [[
		<desc>Fills the tooltip with information about an item available as loot</desc>
		<param name="slot">number, index of a loot slot (between 1 and GetNumLootItems())</param>
	]]

	__Doc__"SetLootRollItem" [[
		<desc>Fills the tooltip with information about an item currently up for loot rolling</desc>
		<param name="id">number, index of an item currently up for loot rolling (as provided in the START_LOOT_ROLL event)</param>
	]]

	__Doc__"SetMerchantCostItem" [[
		<desc>Fills the tooltip with information about an alternate currency required to purchase an item from a vendor. Only applies to item-based currencies, not honor or arena points.</desc>
		<param name="index">number, index of an item in the vendor's listing (between 1 and GetMerchantNumItems()) (number)</param>
		<param name="currency">number, index of one of the item currencies required to purchase the item (between 1 and select(3,GetMerchantItemCostInfo(index))) (number)</param>
	]]

	__Doc__"SetMerchantItem" [[
		<desc>Fills the tooltip with information about an item available for purchase from a vendor</desc>
		<param name="merchantIndex">number, the index of an item in the merchant window, between 1 and GetMerchantNumItems().</param>
	]]

	__Doc__"SetMinimumWidth" [[
		<desc>Sets the minimum width of the tooltip. Normally, a tooltip is automatically sized to match the width of its shortest line of text; setting a minimum width can be useful if the tooltip also contains non-text frames (such as an amount of money or a status bar)</desc>
		<param name="width">number, minimum width of the tooltip frame (in pixels)</param>
	]]

	__Doc__"SetOwner" [[
		<desc>Sets the frame to which the tooltip refers and is anchored</desc>
		<format>frame [, anchorType[, xOffset [, yOffset] ] ]</format>
		<param name="frame">System.Widget.Region, reference to the Frame to which the tooltip refers</param>
		<param name="anchorType">System.Widget.AnchorType, token identifying the positioning method for the tooltip relative to its owner frame</param>
		<param name="xOffset">number, the horizontal offset for the tooltip anchor</param>
		<param name="yOffset">number, the vertical offset for the tooltip anchor</param>
	]]

	__Doc__"SetPadding" [[
		<desc>Sets the amount of space between tooltip's text and its right-side edge. Used in the default UI's ItemRefTooltip to provide space for a close button.</desc>
		<param name="padding">number, amount of space between the right-side edge of the tooltip's text and the right-side edge of the tooltip frame (in pixels)</param>
	]]

	__Doc__"SetPetAction" [[
		<desc>Fills the tooltip with information about a pet action. Only provides information for pet action slots containing pet spells -- in the default UI, the standard pet actions (attack, follow, passive, aggressive, etc) are special-cased to show specific tooltip text.</desc>
		<param name="index">number, index of a pet action button (between 1 and NUM_PET_ACTION_SLOTS)</param>
	]]

	__Doc__"SetPossession" [[
		<desc>Fills the tooltip with information about one of the special actions available while the player possesses another unit</desc>
		<param name="index">number, index of a possession bar action (between 1 and NUM_POSSESS_SLOTS)</param>
	]]

	__Doc__"SetQuestCurrency" [[
		@desc
		<param name="type">string</param>
		<param name="id">number</param>
	]]

	__Doc__"SetQuestItem" [[
		<desc>Fills the tooltip with information about an item in a questgiver dialog</desc>
		<param name="itemType">string, token identifying one of the possible sets of items : choice|required|reward</param>
		<param name="index">number, index of an item in the set (between 1 and GetNumQuestChoices(), GetNumQuestItems(), or GetNumQuestRewards(), according to itemType)</param>
	]]

	__Doc__"SetQuestLogCurrency" [[
		<param name="type">string</param>
		<param name="id">number</param>
	]]

	__Doc__"SetQuestLogItem" [[
		<desc>Fills the tooltip with information about an item related to the selected quest in the quest log</desc>
		<param name="itemType">string, token identifying one of the possible sets of items : choice|reward</param>
		<param name="index">number, index of an item in the set (between 1 and GetNumQuestLogChoices() or GetNumQuestLogRewards(), according to itemType)</param>
	]]

	__Doc__"function_name" [[Fills the tooltip with information about the reward spell for the selected quest in the quest log]]

	__Doc__"SetQuestLogSpecialItem" [[
		<desc>Fills the tooltip with information about a usable item associated with a current quest</desc>
		<param name="questIndex">number, index of a quest log entry with an associated usable item (between 1 and GetNumQuestLogEntries())</param>
	]]

	__Doc__"SetQuestRewardSpell" [[Fills the tooltip with information about the spell reward in a questgiver dialog]]

	__Doc__"SetReforgeItem" [[Fills the tooltip with information about the reforged item]]

	__Doc__"SetSendMailItem" [[
		<desc>Fills the tooltip with information about an item attached to the outgoing mail message</desc>
		<param name="slot">number, index of an outgoing attachment slot (between 1 and ATTACHMENTS_MAX_SEND)</param>
	]]

	__Doc__"SetShapeshift" [[
		<desc>Fills the tooltip with information about an ability on the stance/shapeshift bar</desc>
		<param name="index">number, index of an ability on the stance/shapeshift bar (between 1 and GetNumShapeshiftForms())</param>
	]]

	__Doc__"SetSocketedItem" [[Fills the tooltip with information about the item currently being socketed]]

	__Doc__"SetSocketGem" [[
		<desc>Fills the tooltip with information about a gem added to a socket</desc>
		<param name="index">number, index of a gem socket (between 1 and GetNumSockets())</param>
	]]

	__Doc__"SetSpellBookItem" [[
		<param name="slot"></param>
		<param name="bookType"></param>
	]]

	__Doc__"SetSpellByID" [[
		<desc>Fills the tooltip with information about a spell specified by ID</desc>
		<param name="id">number, spell id</param>
	]]

	__Doc__"SetTalent" [[
		<desc>Fills the tooltip with information about a talent</desc>
		<param name="tabIndex">number, index of a talent tab (between 1 and GetNumTalentTabs())</param>
		<param name="talentIndex">number, index of a talent option (between 1 and GetNumTalents())</param>
		<param name="inspect">boolean, true to return information for the currently inspected unit; false to return information for the player</param>
		<param name="pet">boolean, true to return information for the player's pet; false to return information for the player</param>
		<param name="talentGroup">number, Which set of talents to edit, if the player has Dual Talent Specialization enabled: 1 - Primary Talents, 2 - Secondary Talents, nil - Currently active talents</param>
	]]

	__Doc__"SetText" [[
		<desc>Sets the tooltip's text. Any other content currently displayed in the tooltip will be removed or hidden, and the tooltip's size will be adjusted to fit the new text.</desc>
		<format>text[, r, g, b[, a] ]</format>
		<param name="text">string, text to be displayed in the tooltip</param>
		<param name="r">number, red component of the text color (0.0 - 1.0)</param>
		<param name="g">number, green component of the text color (0.0 - 1.0)</param>
		<param name="b">number, blue component of the text color (0.0 - 1.0)</param>
		<param name="a">number, alpha (opacity) for the text (0.0 = fully transparent, 1.0 = fully opaque)</param>
	]]

	__Doc__"SetTotem" [[
		<desc>Fills the tooltip with information about one of the player's active totems.</desc>
		<param name="slot">number, which totem to query</param>
	]]

	__Doc__"SetTradePlayerItem" [[
		<desc>Fills the tooltip with information about an item offered for trade by the player.</desc>
		<param name="index">number, index of an item offered for trade by the player (between 1 and MAX_TRADE_ITEMS)</param>
	]]

	__Doc__"SetTradeTargetItem" [[
		<desc>Fills the tooltip with information about an item offered for trade by the target. See :SetTradePlayerItem() for items to be traded away by the player.</desc>
		<param name="index">number, index of an item offered for trade by the target (between 1 and MAX_TRADE_ITEMS)</param>
	]]

	__Doc__"SetTrainerService" [[
		<desc>Fills the tooltip with information about a trainer service</desc>
		<param name="index">number, index of an entry in the trainer service listing (between 1 and GetNumTrainerServices())</param>
	]]

	__Doc__"SetUnit" [[
		<desc>Fills the tooltip with information about a unit</desc>
		<param name="unit">string, a unit to query</param>
	]]

	__Doc__"SetUnitAura" [[
		<desc>Fills the tooltip with information about a buff or debuff on a unit</desc>
		<param name="unit">string, a unit to query</param>
		<param name="index">number, index of a buff or debuff on the unit</param>
		<param name="filter">string, a list of filters to use when resolving the index, separated by the pipe '|' character; e.g. "RAID|PLAYER" will query group buffs cast by the player</param>
	]]

	__Doc__"SetUnitBuff" [[
		<desc>Fills the tooltip with information about a buff on a unit.</desc>
		<param name="unit">string, a unit to query</param>
		<param name="index">number, index of a buff or debuff on the unit</param>
		<param name="filter">string, a list of filters to use when resolving the index, separated by the pipe '|' character; e.g. "RAID|PLAYER" will query group buffs cast by the player</param>
	]]

	__Doc__"SetUnitDebuff" [[
		<desc>Fills the tooltip with information about a debuff on a unit.</desc>
		<param name="unit">string, a unit to query</param>
		<param name="index">number, index of a buff or debuff on the unit</param>
		<param name="filter">string, a list of filters to use when resolving the index, separated by the pipe '|' character; e.g. "CANCELABLE|PLAYER" will query cancelable debuffs cast by the player</param>
	]]

	__Doc__[[
		<desc>Get the left text of the given index line</desc>
		<param name="index">number, between 1 and self:NumLines()</param>
		<return type="string"></return>
	]]
	function GetLeftText(self, index)
		local name = self:GetName()

		if not name or not index or type(index) ~= "number" then
			return
		end

		name = name.."TextLeft"..index

		if _G[name] and type(_G[name]) == "table" and _G[name].GetText then
			return _G[name]:GetText()
		end
	end

	__Doc__[[
		<desc>Get the right text of the given index line</desc>
		<param name="index">number, between 1 and self:NumLines()</param>
		<return type="string"></return>
	]]
	function GetRightText(self, index)
		local name = self:GetName()

		if not name or not index or type(index) ~= "number" then
			return
		end

		name = name.."TextRight"..index

		if _G[name] and type(_G[name]) == "table" and _G[name].GetText then
			return _G[name]:GetText()
		end
	end

	__Doc__[[
		<desc>Set the left text of the given index line</desc>
		<param name="index">number, between 1 and self:NumLines()</param>
		<param name="text">string</param>
		<return type="string"></return>
	]]
	function SetLeftText(self, index, text)
		local name = self:GetName()

		if not name or not index or type(index) ~= "number" then
			return
		end

		name = name.."TextLeft"..index

		if _G[name] and type(_G[name]) == "table" and _G[name].GetText then
			return _G[name]:SetText(text)
		end
	end

	__Doc__[[
		<desc>Set the right text of the given index line</desc>
		<param name="index">number, between 1 and self:NumLines()</param>
		<param name="text">string</param>
		<return type="string"></return>
	]]
	function SetRightText(self, index, text)
		local name = self:GetName()

		if not name or not index or type(index) ~= "number" then
			return
		end

		name = name.."TextRight"..index

		if _G[name] and type(_G[name]) == "table" and _G[name].GetText then
			return _G[name]:SetText(text)
		end
	end

	__Doc__[[
		<desc>Get the texutre of the given index line</desc>
		<param name="index">number, between 1 and self:NumLines()</param>
		<return type="string"></return>
	]]
	function GetTexture(self, index)
		local name = self:GetName()

		if not name or not index or type(index) ~= "number" then
			return
		end

		name = name.."Texture"..index

		if _G[name] and type(_G[name]) == "table" and _G[name].GetTexture then
			return _G[name]:GetTexture()
		end
	end

	__Doc__[[
		<desc>Get the money of the given index, default 1</desc>
		<param name="index">number, between 1 and self:NumLines()</param>
		<return type="number"></return>
	]]
	function GetMoney(self, index)
		local name = self:GetName()

		index = index or 1

		if not name or not index or type(index) ~= "number" then
			return
		end

		name = name.."MoneyFrame"..index

		if _G[name] and type(_G[name]) == "table" then
			local gold = strmatch((_G[name.."GoldButton"] and _G[name.."GoldButton"]:GetText()) or "0", "%d*") or 0
			local silver = strmatch((_G[name.."SilverButton"] and _G[name.."SilverButton"]:GetText()) or "0", "%d*") or 0
			local copper = strmatch((_G[name.."CopperButton"] and _G[name.."CopperButton"]:GetText()) or "0", "%d*") or 0

			return gold * COPPER_PER_SILVER * SILVER_PER_GOLD + silver * COPPER_PER_SILVER + copper
		end
	end

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		local name = self:GetName()
		local index, chkName

		self:ClearLines()

		if name and _G[name] and IGAS:GetWrapper(_G[name]) == self then
			-- remove lefttext
			index = 1

			while _G[name.."TextLeft"..index] do
				_G[name.."TextLeft"..index] = nil
				index = index + 1
			end

			-- remove righttext
			index = 1

			while _G[name.."TextRight"..index] do
				_G[name.."TextRight"..index] = nil
				index = index + 1
			end

			-- remove texture
			index = 1

			while _G[name.."Texture"..index] do
				_G[name.."Texture"..index] = nil
				index = index + 1
			end

			-- remove self
			_G[name] = nil
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		local fullname = (parent:GetName() or "").."."..name

		return CreateFrame("GameTooltip", fullname, parent, ...)
	end
endclass "GameTooltip"

class "GameTooltip"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(GameTooltip)

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The owner of this gametooltip]]
	property "Owner" { Type = UIObject }
endclass "GameTooltip"
