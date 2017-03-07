function PLH_CreateOptionsPanel()

	local VERTICAL_SPACE_BETWEEN_ELEMENTS = 15

	--[[ Main Panel ]]--
	local PLHConfigFrame = CreateFrame('Frame', 'PLHConfigFrame', InterfaceOptionsFramePanelContainer)
	PLHConfigFrame:Hide()
	PLHConfigFrame.name = PLH_LONG_ADDON_NAME
	InterfaceOptions_AddCategory(PLHConfigFrame)

	--[[ Title ]]--
	local TitleLabel = PLHConfigFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	TitleLabel:SetPoint('TOPLEFT', PLHConfigFrame, 'TOPLEFT', 16, -16)
	TitleLabel:SetText(PLH_LONG_ADDON_NAME)

	-- [[ Version ]] --
	local AddonVersion = GetAddOnMetadata("PersonalLootHelper", "Version")
	local VersionLabel = PLHConfigFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
	VersionLabel:SetPoint('BOTTOMLEFT', TitleLabel, 'BOTTOMRIGHT', 8, 0)
	VersionLabel:SetText('v' .. AddonVersion)

	--[[ Author ]]--
	local AuthorLabel = PLHConfigFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
	AuthorLabel:SetPoint('TOPRIGHT', PLHConfigFrame, 'TOPRIGHT', -16, -24)
	AuthorLabel:SetText('Author: ' .. PLH_AUTHOR_NAME)

	--[[ PLH_INCLUDE_BOE ]]--
	PLH_IncludeBOECheckbox = CreateFrame('CheckButton', 'PLHIncludeBOE', PLHConfigFrame, 'InterfaceOptionsCheckButtonTemplate')
	PLH_IncludeBOECheckbox:SetPoint('TOPLEFT', TitleLabel, 'BOTTOMLEFT', 0, -VERTICAL_SPACE_BETWEEN_ELEMENTS)
	PLH_IncludeBOECheckbox:SetChecked(PLH_INCLUDE_BOE)

	local IncludeBOELabel = PLH_IncludeBOECheckbox:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	IncludeBOELabel:SetPoint('LEFT', PLH_IncludeBOECheckbox, 'RIGHT', 0, 0)
	IncludeBOELabel:SetText('Include Bind on Equip items')

	--[[ PLH_CURRENT_SPEC_ONLY ]]--
	PLH_CurrentSpecOnlyCheckbox = CreateFrame('CheckButton', 'PLHCurrentSpecOnly', PLHConfigFrame, 'InterfaceOptionsCheckButtonTemplate')
	PLH_CurrentSpecOnlyCheckbox:SetPoint('TOPLEFT', PLH_IncludeBOECheckbox, 'BOTTOMLEFT', 0, -VERTICAL_SPACE_BETWEEN_ELEMENTS)
	PLH_CurrentSpecOnlyCheckbox:SetChecked(PLH_CURRENT_SPEC_ONLY)

	local CurrentSpecOnlyLabel = PLH_CurrentSpecOnlyCheckbox:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	CurrentSpecOnlyLabel:SetPoint('LEFT', PLH_CurrentSpecOnlyCheckbox, 'RIGHT', 0, 0)
	CurrentSpecOnlyLabel:SetText('Evaluate based on current spec only')

	--[[ PLH_NOTIFY_MODE ]]--
	PLH_NotifyGroupCheckbox = CreateFrame('CheckButton', 'PLHNotifyGroup', PLHConfigFrame, 'InterfaceOptionsCheckButtonTemplate')
	PLH_NotifyGroupCheckbox:SetPoint('TOPLEFT', PLH_CurrentSpecOnlyCheckbox, 'BOTTOMLEFT', 0, -VERTICAL_SPACE_BETWEEN_ELEMENTS)
	PLH_NotifyGroupCheckbox:SetChecked(PLH_NOTIFY_MODE == 2 or PLH_NOTIFY_MODE == 3)
	PLH_NotifyGroupCheckbox:SetScript('OnClick', function(frame)
		if PLH_NotifyGroupCheckbox:GetChecked() then
			PLH_CoordinateRollsCheckbox:Show()
			PLH_CoordinateRollsLabel1:Show()
			PLH_CoordinateRollsLabel2:Show()
		else
			PLH_CoordinateRollsCheckbox:Hide()
			PLH_CoordinateRollsLabel1:Hide()
			PLH_CoordinateRollsLabel2:Hide()
		end
	end)

	local NotifyGroupLabel = PLH_NotifyGroupCheckbox:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	NotifyGroupLabel:SetPoint('LEFT', PLH_NotifyGroupCheckbox, 'RIGHT', 0, 0)
	NotifyGroupLabel:SetText('Notify Group (automatically turned off in LFR)')
	NotifyGroupLabel:SetWordWrap(true)
	NotifyGroupLabel:SetJustifyH('LEFT')
	NotifyGroupLabel:SetWidth(400)

	PLH_CoordinateRollsCheckbox = CreateFrame('CheckButton', 'PLHCoordinateRolls', PLHConfigFrame, 'InterfaceOptionsCheckButtonTemplate')
	PLH_CoordinateRollsCheckbox:SetPoint('TOPLEFT', PLH_NotifyGroupCheckbox, 'BOTTOMLEFT', 25, -VERTICAL_SPACE_BETWEEN_ELEMENTS / 2)
	PLH_CoordinateRollsCheckbox:SetChecked(PLH_NOTIFY_MODE == 3)

	PLH_CoordinateRollsLabel1 = PLH_CoordinateRollsCheckbox:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	PLH_CoordinateRollsLabel1:SetPoint('LEFT', PLH_CoordinateRollsCheckbox, 'RIGHT', 0, 0)
	PLH_CoordinateRollsLabel1:SetText('Coordinate Rolls (group leader only)')
	PLH_CoordinateRollsLabel1:SetWordWrap(true)
	PLH_CoordinateRollsLabel1:SetJustifyH('LEFT')
	PLH_CoordinateRollsLabel1:SetWidth(375)

	PLH_CoordinateRollsLabel2 = PLH_CoordinateRollsCheckbox:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	PLH_CoordinateRollsLabel2:SetPoint('TOPLEFT', PLH_CoordinateRollsLabel1, 'BOTTOMLEFT', 20, -10)
	PLH_CoordinateRollsLabel2:SetText('Prompt for and manage loot rolls. Players can whisper the group leader with "trade" or "trade [item]" to initiate rolls.')
	PLH_CoordinateRollsLabel2:SetWordWrap(true)
	PLH_CoordinateRollsLabel2:SetJustifyH('LEFT')
	PLH_CoordinateRollsLabel2:SetWidth(450)

	--[[ Thank you message ]] --
	local ThankYouLabel = PLHConfigFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	ThankYouLabel:SetPoint('BOTTOM', PLHConfigFrame, 'BOTTOM', 0, 48)
	ThankYouLabel:SetText('Thank you to all of the players who trade loot to others who can use it! Your generosity is part of what makes the WoW community great.\nYou rock!!!')
	ThankYouLabel:SetWidth(300)
	ThankYouLabel:SetWordWrap(true)

	--[[ OnShow Event]]
	PLHConfigFrame:SetScript('OnShow', function(frame)
		if PLH_NOTIFY_MODE == 2 or PLH_NOTIFY_MODE == 3 then
			PLH_CoordinateRollsCheckbox:Show()
			PLH_CoordinateRollsLabel1:Show()
			PLH_CoordinateRollsLabel2:Show()
		else
			PLH_CoordinateRollsCheckbox:Hide()
			PLH_CoordinateRollsLabel1:Hide()
			PLH_CoordinateRollsLabel2:Hide()
		end
		PLH_IncludeBOECheckbox:SetChecked(PLH_INCLUDE_BOE)
		PLH_CurrentSpecOnlyCheckbox:SetChecked(PLH_CURRENT_SPEC_ONLY)
		PLH_NotifyGroupCheckbox:SetChecked(PLH_NOTIFY_MODE == 2 or PLH_NOTIFY_MODE == 3)
		PLH_CoordinateRollsCheckbox:SetChecked(PLH_NOTIFY_MODE == 3)
	end)

	--[[ Okay Action ]]--
	function PLHConfigFrame.okay(arg1, arg2, arg3, ...)
		PLH_INCLUDE_BOE = PLH_IncludeBOECheckbox:GetChecked()
		PLH_CURRENT_SPEC_ONLY = PLH_CurrentSpecOnlyCheckbox:GetChecked()
		local selectedNotifyMode
		if PLH_NotifyGroupCheckbox:GetChecked() then
			if PLH_CoordinateRollsCheckbox:GetChecked() then
				selectedNotifyMode = 3
			else
				selectedNotifyMode = 2
			end
		else
			selectedNotifyMode = 1
		end
		if PLH_NOTIFY_MODE ~= selectedNotifyMode then
			PLH_NOTIFY_MODE = selectedNotifyMode
			PLH_SendStatusMessage(true)
		end
	end

end