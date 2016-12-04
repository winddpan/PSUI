﻿--[[-------------------------------------------------------------------------
-- Simple Configuration Panel for SIA and STA
--
-- Copyright 2012-2015 BeathsCurse (Saphod - Draenor EU)
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-------------------------------------------------------------------------]]--

-- Get the name and table of the addon for which this is the configuration
local addonName = string.gsub((...), '_Config$', '')
local addon = _G[addonName]

-- Local shorthands for accessing the configuration and panel
local cfg = addon.cfg
local panel = addon.panel

-- Will hold controls with values
-- Note: Each control in this table should have a defaultValue and functions
-- LoadValue, SaveValue, and UpdateValue.
panel.controls = {}

-- Sound file and name pairs for the sound dropdowns
local soundList = {
	'', '关',
	'Sound\\Doodad\\BellTollAlliance.ogg', 'Bell 1',
	'Sound\\Doodad\\BellTollHorde.ogg', 'Bell 2',
	'Sound\\Doodad\\FX_Ice_Shard_Impact_03.OGG', 'Ice Shard',
	'Sound\\Doodad\\FX_MK_IMPACT_MED_03.OGG', 'Impact',
	'Sound\\Doodad\\BE_ScryingOrb_Explode.ogg', 'Orb Explode',
	'Sound\\SPELLS\\PetCall.ogg', 'Pet Call',
	'Sound\\character\\PlayerRoars\\CharacterRoarsDwarfMale.ogg', 'Roar Dwarf',
	'Sound\\character\\PlayerRoars\\CharacterRoarsOrcMale.ogg', 'Roar Orc',
	'Sound\\Doodad\\FX_GEN_KUNGFU_02.OGG', 'Swoosh',
	'Sound\\character\\EmoteCatCallWhistle05.ogg', 'Whistle',
	-- Custom sound files user can add to addon folder
	'Interface\\AddOns\\' .. addonName .. '\\sound1.mp3', 'Custom sound1.mp3',
	'Interface\\AddOns\\' .. addonName .. '\\sound2.mp3', 'Custom sound2.mp3',
	'Interface\\AddOns\\' .. addonName .. '\\sound1.ogg', 'Custom sound1.ogg',
	'Interface\\AddOns\\' .. addonName .. '\\sound2.ogg', 'Custom sound2.ogg',
}

-- Create a unique name for a control
local UniqueName
do
	local controlID = 1

	function UniqueName(name)
		controlID = controlID + 1
		return string.format('%s_%s_%02d', addonName, name, controlID)
	end
end

-- Function called when Okay button is pressed on configuration panel
function panel:ConfigOkay()
	-- Go through the controls of the configuration frame
	for _, control in pairs(self.controls) do
		-- Call the controls function to save it's value
		control.SaveValue(control.currentValue)
	end
end

-- Function called when Defaults button is pressed on configuration panel
function panel:ConfigDefault()
	-- Go through the controls of the configuration frame
	for _, control in pairs(self.controls) do
		-- Set the controls value to the default
		control.currentValue = control.defaultValue

		-- Call the controls function to save it's value
		control.SaveValue(control.currentValue)
	end
end

-- Function called to refresh values
-- Note: I haven't found a good place to load the configuration into the
-- panel to allow both the Okay/Cancel and Defaults buttons to work the way
-- you would expect. As a compromise, the configuration is loaded on refresh,
-- and saved when the defaults button is pressed.
function panel:ConfigRefresh()
	-- Go through the controls of the configuration frame
	for _, control in pairs(self.controls) do
		-- Call the controls function to load it's value
		control.currentValue = control.LoadValue()

		-- Call the update function to make it reflect any change
		control:UpdateValue()
	end
end

-- Create a heading in the configuration panel
function panel:CreateHeading(text)
	local title = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLeft')
	title:SetText(text)

	return title
end

-- Create a text box in the configuration panel
function panel:CreateText(text)
	local blob = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmallLeft')
	blob:SetText(text)

	return blob
end

-- Create a checkbox in the configuration panel
function panel:CreateCheckBox(text, LoadValue, SaveValue, defaultValue)
	local checkBox = CreateFrame('CheckButton', UniqueName('CheckButton'), self, 'InterfaceOptionsCheckButtonTemplate')

	checkBox.LoadValue = LoadValue
	checkBox.SaveValue = SaveValue
	checkBox.defaultValue = defaultValue
	checkBox.UpdateValue = function(self) self:SetChecked(self.currentValue) end

	getglobal(checkBox:GetName() .. 'Text'):SetText(text)

	-- Update currentValue on click
	checkBox:SetScript('OnClick', function(self) self.currentValue = self:GetChecked() end)

	self.controls[checkBox:GetName()] = checkBox

	return checkBox
end

-- Function used by each 'button' of the dropdown to select it
-- Note: dropDown and selectedValue are arg1 and arg2.
local function DropDownOnClick(_, dropDown, selectedValue)
	dropDown.currentValue = selectedValue
	UIDropDownMenu_SetText(dropDown, dropDown.valueTexts[selectedValue])
end

-- Initialization function for dropdowns, adds all pairs in valueList
local function DropDownInitialize(frame)
	local info = UIDropDownMenu_CreateInfo()

	-- Add all pairs in valueList to dropdown
	for i=1,#frame.valueList,2 do
		local k, v = frame.valueList[i], frame.valueList[i + 1]
		info.text = v
		info.value = k
		info.checked = frame.currentValue == k
		info.func = DropDownOnClick
		info.arg1, info.arg2 = frame, k
		UIDropDownMenu_AddButton(info)
	end
end

-- Create a simple dropdown in the configuration panel
function panel:CreateDropDown(text, valueList, LoadValue, SaveValue, defaultValue)
	local dropDown = CreateFrame('Frame', UniqueName('DropDown'), self, 'UIDropDownMenuTemplate')

	-- Add a title at the top left corner of the dropdown
	local title = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmallLeft')
	title:SetText(text)
	title:SetPoint('BOTTOMLEFT', dropDown, 'TOPLEFT', 16, 0)

	dropDown.LoadValue = LoadValue
	dropDown.SaveValue = SaveValue
	dropDown.defaultValue = defaultValue
	dropDown.UpdateValue = function(self)
		UIDropDownMenu_SetText(self, self.valueTexts[self.currentValue])
	end

	-- Add elements in valueList to dropdown
	-- Note: valueList is an ordered list of values and the corresponding
	-- texts. We build valueTexts so we can look up the text for a given
	-- value.
	dropDown.valueList = valueList
	dropDown.valueTexts = {}
	for i=1,#valueList,2 do
		local k, v = valueList[i], valueList[i + 1]
		dropDown.valueTexts[k] = v
	end

	dropDown:SetScript('OnShow', function(self)
		UIDropDownMenu_Initialize(self, DropDownInitialize)
	end)

	UIDropDownMenu_JustifyText(dropDown, 'LEFT')
	UIDropDownMenu_SetWidth(dropDown, 120)
	UIDropDownMenu_SetButtonWidth(dropDown, 144)

	self.controls[dropDown:GetName()] = dropDown

	return dropDown
end

-- Initialize configuration panel
function panel:Initialize()
	-- Add methods called by the frame
	self.okay = self.ConfigOkay
	self.default = self.ConfigDefault
	self.refresh = self.ConfigRefresh

	-- Add configuration panel controls
	local controlCheckBoxEnabled = self:CreateCheckBox(
		'开启插件',
		function() return cfg.isEnabled end,
		function(v) if v then addon:Enable() else addon:Disable() end end,
		true)
	controlCheckBoxEnabled:SetPoint('TOPLEFT', 16, -64)

	local controlDropDownSoundOwn = self:CreateDropDown(
		'自己打断时播放声音',
		soundList,
		function() return cfg.soundOwn end,
		function(v) cfg.soundOwn = v end,
		'')
	controlDropDownSoundOwn:SetPoint('TOPLEFT', controlCheckBoxEnabled, 'BOTTOMLEFT', 0, -24)

	local controlButtonSoundOwn = CreateFrame('Button', nil, panel)
	controlButtonSoundOwn:SetWidth(16)
	controlButtonSoundOwn:SetHeight(16)
	controlButtonSoundOwn:SetPoint('LEFT', controlDropDownSoundOwn, 'RIGHT', 0, 0)
	controlButtonSoundOwn:SetScript('OnClick', function()
		PlaySoundFile(controlDropDownSoundOwn.currentValue or '', 'MASTER')
	end)
	local speakerOwnOff = controlButtonSoundOwn:CreateTexture(nil, 'BACKGROUND')
	speakerOwnOff:SetTexture('Interface\\Common\\VoiceChat-Speaker')
	speakerOwnOff:SetAllPoints(controlButtonSoundOwn)
	local speakerOwnOn = controlButtonSoundOwn:CreateTexture(nil, 'HIGHLIGHT')
	speakerOwnOn:SetTexture('Interface\\Common\\VoiceChat-On')
	speakerOwnOn:SetAllPoints(controlButtonSoundOwn)

	local controlDropDownSoundOther = self:CreateDropDown(
		'其他人打断时播放声音',
		soundList,
		function() return cfg.soundOther end,
		function(v) cfg.soundOther = v end,
		'')
	controlDropDownSoundOther:SetPoint('TOPLEFT', controlDropDownSoundOwn, 'TOPRIGHT', 32, 0)

	local controlButtonSoundOther = CreateFrame('Button', nil, panel)
	controlButtonSoundOther:SetWidth(16)
	controlButtonSoundOther:SetHeight(16)
	controlButtonSoundOther:SetPoint('LEFT', controlDropDownSoundOther, 'RIGHT', 0, 0)
	controlButtonSoundOther:SetScript('OnClick', function()
		PlaySoundFile(controlDropDownSoundOther.currentValue or '', 'MASTER')
	end)
	local speakerOtherOff = controlButtonSoundOther:CreateTexture(nil, 'BACKGROUND')
	speakerOtherOff:SetTexture('Interface\\Common\\VoiceChat-Speaker')
	speakerOtherOff:SetAllPoints(controlButtonSoundOther)
	local speakerOtherOn = controlButtonSoundOther:CreateTexture(nil, 'HIGHLIGHT')
	speakerOtherOn:SetTexture('Interface\\Common\\VoiceChat-On')
	speakerOtherOn:SetAllPoints(controlButtonSoundOther)

	local controlHeadingSolo = self:CreateHeading('独自一人时')
	controlHeadingSolo:SetPoint('TOPLEFT', controlDropDownSoundOwn, 'BOTTOMLEFT', 0, -20)

	local controlDropDownSoloOwn = self:CreateDropDown(
		'自己打断通告',
		{ 'off', '关', 'self', '自己可见', 'say', '说' },
		function() return cfg.solo.own end,
		function(v) cfg.solo.own = v end,
		'self')
	controlDropDownSoloOwn:SetPoint('TOPLEFT', controlHeadingSolo, 'BOTTOMLEFT', 0, -24)

	local controlHeadingInstance = self:CreateHeading('在副本队伍时')
	controlHeadingInstance:SetPoint('TOPLEFT', controlDropDownSoloOwn, 'BOTTOMLEFT', 0, -20)

	local controlDropDownInstanceOwn = self:CreateDropDown(
		'自己打断通告',
		{ 'off', '关', 'self', '自己可见', 'say', '说', 'instance', '副本频道' },
		function() return cfg.instance.own end,
		function(v) cfg.instance.own = v end,
		'self')
	controlDropDownInstanceOwn:SetPoint('TOPLEFT', controlHeadingInstance, 'BOTTOMLEFT', 0, -24)

	local controlDropDownInstanceOther = self:CreateDropDown(
		'队友打断通告',
		{ 'off', '关', 'self', '自己可见', 'say', '说', 'instance', '副本频道' },
		function() return cfg.instance.other end,
		function(v) cfg.instance.other = v end,
		'self')
	controlDropDownInstanceOther:SetPoint('TOPLEFT', controlDropDownInstanceOwn, 'TOPRIGHT', 32, 0)

	local controlHeadingGroup = self:CreateHeading('在小队中时')
	controlHeadingGroup:SetPoint('TOPLEFT', controlDropDownInstanceOwn, 'BOTTOMLEFT', 0, -20)

	local controlDropDownGroupOwn = self:CreateDropDown(
		'自己打断通告',
		{ 'off', '关', 'self', '自己可见', 'say', '说', 'party', '队伍频道' },
		function() return cfg.party.own end,
		function(v) cfg.party.own = v end,
		'self')
	controlDropDownGroupOwn:SetPoint('TOPLEFT', controlHeadingGroup, 'BOTTOMLEFT', 0, -24)

	local controlDropDownGroupOther = self:CreateDropDown(
		'队友打断通告',
		{ 'off', '关', 'self', '自己可见', 'say', '说', 'party', '队伍频道' },
		function() return cfg.party.other end,
		function(v) cfg.party.other = v end,
		'self')
	controlDropDownGroupOther:SetPoint('TOPLEFT', controlDropDownGroupOwn, 'TOPRIGHT', 32, 0)

	local controlHeadingRaid = self:CreateHeading('在团队中时')
	controlHeadingRaid:SetPoint('TOPLEFT', controlDropDownGroupOwn, 'BOTTOMLEFT', 0, -20)

	local controlDropDownRaidOwn = self:CreateDropDown(
		'自己打断通告',
		{ 'off', '关', 'self', '自己可见', 'say', '说', 'party', '队伍频道', 'raid', '团队频道' },
		function() return cfg.raid.own end,
		function(v) cfg.raid.own = v end,
		'say')
	controlDropDownRaidOwn:SetPoint('TOPLEFT', controlHeadingRaid, 'BOTTOMLEFT', 0, -24)

	local controlDropDownRaidOther = self:CreateDropDown(
		'队友打断通告',
		{ 'off', '关', 'self', '自己可见', 'say', '说', 'party', '队伍频道', 'raid', '团队频道' },
		function() return cfg.raid.other end,
		function(v) cfg.raid.other = v end,
		'self')
	controlDropDownRaidOther:SetPoint('TOPLEFT', controlDropDownRaidOwn, 'TOPRIGHT', 32, 0)

	local controlTextExplain = self:CreateText('小贴士:副本队伍是指通过队伍查找器建立的队伍')
	controlTextExplain:SetPoint('TOPLEFT', controlDropDownRaidOwn, 'BOTTOMLEFT', 0, -30)
	controlTextExplain:SetPoint('RIGHT', -16, 0)
end

-- Add controls to the configuration panel
panel:Hide()
panel:Initialize()
panel:ConfigRefresh()
panel:Show()
