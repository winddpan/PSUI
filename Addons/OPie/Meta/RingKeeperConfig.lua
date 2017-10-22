local api, L, RK, conf, ORI, _, T = {}, OneRingLib.lang, OneRingLib.ext.RingKeeper, OneRingLib.ext.config, OneRingLib.ext.OPieUI, ...
local AB = assert(T.ActionBook:compatible(2,19), "A compatible version of ActionBook is required")
local gfxBase, EV = [[Interface\AddOns\OPie\gfx\]], T.Evie

local FULLNAME, SHORTNAME do
	function EV.PLAYER_LOGIN()
		local name, realm = UnitFullName("player")
		FULLNAME, SHORTNAME = name .. "-" .. realm, name
	end
end

local function prepEditBoxCancel(self)
	self.oldValue = self:GetText()
	if self.placeholder then self.placeholder:Hide() end
end
local function cancelEditBoxInput(self)
	local h = self:GetScript("OnEditFocusLost")
	self:SetText(self.oldValue or self:GetText())
	self:SetScript("OnEditFocusLost", nil)
	self:ClearFocus()
	self:SetScript("OnEditFocusLost", h)
	if self.placeholder and self:GetText() == "" then self.placeholder:Show() end
end
local function prepEditBox(self, save)
	if self:IsMultiLine() then
		self:SetScript("OnEscapePressed", self.ClearFocus)
	else
		self:SetScript("OnEditFocusGained", prepEditBoxCancel)
		self:SetScript("OnEscapePressed", cancelEditBoxInput)
		self:SetScript("OnEnterPressed", self.ClearFocus)
	end
	self:SetScript("OnEditFocusLost", save)
end
local function createIconButton(name, parent, id)
	local f = CreateFrame("CheckButton", name, parent)
	f:SetSize(32,32)
	f:SetNormalTexture("")
	f:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
	f:GetHighlightTexture():SetBlendMode("ADD")
	f:SetCheckedTexture("Interface/Buttons/CheckButtonHilight")
	f:GetCheckedTexture():SetBlendMode("ADD")
	f:SetPushedTexture("Interface/Buttons/UI-Quickslot-Depress")
	f.tex = f:CreateTexture() f.tex:SetAllPoints()
	f:SetID(id or 0)
	return f
end
local function SetCursor(tex)
	_G.SetCursor(tex == (gfxBase .. "icon") and "PICKUP_CURSOR" or tex)
end
local function SaveRingVersion(name, liveData)
	local key = "RKRing#" .. name
	if not conf.undo.search(key) then
		conf.undo.push(key, RK.SetRing, RK, name, liveData == true and RK:GetRingDescription(name) or liveData or false)
	end
end
local function CreateToggleButton(parent)
	local button = CreateFrame("CHECKBUTTON", nil, parent)
	button:SetSize(175, 30)
	button:SetNormalFontObject(GameFontHighlightMedium)
	button:SetPushedTextOffset(-1, -1)
	button:SetNormalTexture("Interface\\PVPFrame\\PvPMegaQueue")
	button:GetNormalTexture():SetTexCoord(0.00195313,0.58789063, 0.87304688,0.92773438)
	button:SetPushedTexture("Interface\\PVPFrame\\PvPMegaQueue")
	button:GetPushedTexture():SetTexCoord(0.00195313,0.58789063,0.92968750,0.98437500)
	button:SetHighlightTexture("Interface\\PVPFrame\\PvPMegaQueue")
	button:GetHighlightTexture():SetTexCoord(0.00195313,0.63867188, 0.70703125,0.76757813)
	button:SetCheckedTexture("Interface\\PVPFrame\\PvPMegaQueue")
	button:GetCheckedTexture():SetTexCoord(0.00195313,0.63867188, 0.76953125,0.83007813)
	for i=1,2 do
		local tex = i == 1 and button:GetHighlightTexture() or button:GetCheckedTexture()
		tex:ClearAllPoints()
		tex:SetPoint("TOPLEFT", button, "LEFT", -1.5, 12.3)
		tex:SetPoint("BOTTOMRIGHT", button, "RIGHT", 1.5, -12.3)
		tex:SetBlendMode("ADD")
	end
	return button
end
local function CreateButton(parent, width)
	local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	btn:SetWidth(width or 150)
	return btn
end
local function setIcon(self, path, ext, slice)
	if type(slice) == "table" and slice[1] == "macrotext" and type(slice[2]) == "string" then
		local p2 = path or "interface/icons/temp"
		local lp = type(p2) == "string" and p2:gsub("\\", "/"):lower()
		if lp == "interface/icons/temp" or lp == "interface/icons/inv_misc_questionmark" then
			for sidlist in slice[2]:gmatch("{{spell:([%d/]+)}}") do
				for sid in sidlist:gmatch("%d+") do
					local _,_,sico = GetSpellInfo(tonumber(sid))
					if sico then
						path = sico
						break
					end
				end
				if path then break end
			end
		end
	end
	self:SetTexture(path or "Interface/Icons/Inv_Misc_QuestionMark")
	self:SetTexCoord(0,1,0,1)
	if not ext then return end
	if type(ext.iconR) == "number" and type(ext.iconG) == "number" and type(ext.iconB) == "number" then
		self:SetVertexColor(ext.iconR, ext.iconG, ext.iconB)
	end
	if type(ext.iconCoords) == "table" then
		self:SetTexCoord(unpack(ext.iconCoords))
	elseif type(ext.iconCoords) == "function" or type(ext.iconCoords) == "userdata" then
		self:SetTexCoord(ext:iconCoords())
	end
end

local ringContainer, ringDetail, sliceDetail, newSlice, newRing
local panel = conf.createFrame(L"Custom Rings", "OPie")
	panel.version:SetFormattedText("%d.%d", RK:GetVersion())
local ringDropDown = CreateFrame("FRAME", "RKC_RingSelectionDropDown", panel, "UIDropDownMenuTemplate")
	ringDropDown:SetPoint("TOP", -70, -60)
	UIDropDownMenu_SetWidth(ringDropDown, 260)
local btnNewRing = CreateButton(panel)
	btnNewRing:SetPoint("LEFT", ringDropDown, "RIGHT", -5, 3)

newRing = CreateFrame("FRAME") do
	newRing:SetSize(400, 110)
	local title = newRing:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	local toggle1, toggle2 = CreateToggleButton(newRing), CreateToggleButton(newRing)
	local name, snap = conf.ui.lineInput(newRing, true, 240), conf.ui.lineInput(newRing, true, 240)
	local nameLabel, snapLabel = newRing:CreateFontString(nil, "OVERLAY", "GameFontHighlight"), snap:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	local accept, cancel = CreateButton(newRing, 125), CreateButton(newRing, 125)
	title:SetPoint("TOP")
	toggle1:SetPoint("TOPLEFT", 20, -22)
	toggle2:SetPoint("TOPRIGHT", -20, -22)
	name:SetPoint("TOPRIGHT", -15, -60)
	nameLabel:SetPoint("TOPLEFT", newRing, "TOPLEFT", 15, -65)
	snap:SetPoint("TOPRIGHT", -15, -85)
	snapLabel:SetPoint("TOPLEFT", newRing, "TOPLEFT", 15, -90)
	accept:SetPoint("BOTTOMRIGHT", newRing, "BOTTOM", -2, 2)
	cancel:SetPoint("BOTTOMLEFT", newRing, "BOTTOM", 2, 2)
	toggle1:SetChecked(1)
	snap:Hide()
	toggle1.other, toggle2.other = toggle2, toggle1
	local function validate()
		local nameText, snapText, snapOK = name:GetText() or "", snap:GetText() or "", true
		if toggle2:GetChecked() then
			if snapText ~= snap.cachedText then
				snap.cachedText, snap.cachedValue = snapText, snapText ~= "" and RK:GetSnapshotRing(snapText) or nil
				if type(snap.cachedValue) == "table" and nameText == "" then
					snap:SetCursorPosition(0)
					name:SetText(snap.cachedValue.name or "")
					name:SetFocus()
					name:HighlightText()
				end
			end
			snapOK = type(snap.cachedValue) == "table"
			if snapOK then
				snap:SetTextColor(GameFontGreen:GetTextColor())
			else
				snap:SetTextColor(ChatFontNormal:GetTextColor())
			end
		elseif #nameText > 32 and nameText:match("^%s*oetohH7") then
			local val = RK:GetSnapshotRing(nameText)
			if type(val) == "table" then
				snap.cachedText, snap.cachedValue = nameText, val
				name:SetText("")
				toggle2:Click()
				snap:SetText(nameText)
			end
		end
		accept:SetEnabled(type(nameText) == "string" and nameText:match("%S") and snapOK)
	end
	local function toggle(self)
		if not self:GetChecked() ~= not self.other:GetChecked() then
		elseif not self:GetChecked() then
			self:SetChecked(1)
		else
			PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON)
			self.other:SetChecked(nil)
			newRing:SetSize(400, self == toggle1 and 110 or 135)
			snap:SetShown(self ~= toggle1)
			if newRing:IsVisible() then
				conf.overlay(panel, newRing)
				validate(name);
				(self == toggle1 and name or snap):SetFocus()
			end
		end
	end
	local function navigate(self)
		if IsControlKeyDown() then
			(toggle1:GetChecked() and toggle2 or toggle1):Click()
		elseif self ~= snap and snap:IsShown() then
			snap:SetFocus()
		else
			name:SetFocus()
		end
	end
	local function submit(self)
		if accept:IsEnabled() then
			accept:Click()
		else
			navigate(self)
		end
	end
	cancel:SetScript("OnClick", function() newRing:Hide() end)
	accept:SetScript("OnClick", function()
		local ringData = toggle2:GetChecked() and type(snap.cachedValue) == "table" and snap.cachedValue or {limit="PLAYER"}
		if api.createRing(name:GetText(), ringData) then
			newRing:Hide()
		end
	end)
	toggle1:SetScript("OnClick", toggle)
	toggle2:SetScript("OnClick", toggle)
	for i=1,2 do
		local v = i == 1 and name or snap
		v:SetScript("OnTabPressed", navigate)
		v:SetScript("OnEnterPressed", submit)
		v:SetScript("OnTextChanged", validate)
		v:SetScript("OnEditFocusLost", EditBox_ClearHighlight)
	end
	btnNewRing:SetScript("OnClick", function()
		title:SetText(L"Create a New Ring")
		toggle1:SetText(L"Empty ring")
		toggle2:SetText(L"Import snapshot")
		local w1, w2 = 32+toggle1:GetFontString():GetStringWidth(), 32+toggle2:GetFontString():GetStringWidth()
		toggle1:SetWidth(math.max(w1, 350 - math.max(175, w2)))
		toggle2:SetWidth(math.max(w2, 350 - math.max(175, w1)))
		nameLabel:SetText(L"Ring name:")
		snapLabel:SetText(L"Snapshot:")
		accept:SetText(L"Add Ring")
		cancel:SetText(L"Cancel")
		snap:SetText("")
		snap.cachedText, snap.cachedValue = nil
		name:SetText("")
		toggle1:Click()
		accept:Disable()
		conf.overlay(panel, newRing)
		name:SetFocus()
	end)
end

ringContainer = CreateFrame("FRAME", nil, panel) do
	ringContainer:SetPoint("TOP", ringDropDown, "BOTTOM", 75, 0)
	ringContainer:SetPoint("BOTTOM", panel, 0, 10)
	ringContainer:SetPoint("LEFT", panel, 50, 0)
	ringContainer:SetPoint("RIGHT", panel, -10, 0)
	ringContainer:SetBackdrop({edgeFile="Interface/Tooltips/UI-Tooltip-Border", tile=true, edgeSize=8})
	ringContainer:SetBackdropBorderColor(.6, .6, .6, 1)
	local function UpdateOnShow(self) self:SetScript("OnUpdate", nil) api.refreshDisplay() end
	ringContainer:SetScript("OnHide", function(self) if self:IsShown() then self:SetScript("OnUpdate", UpdateOnShow) end end)
	do -- up/down arrow buttons: ringContainer.prev and ringContainer.next
		local prev, next = CreateFrame("BUTTON", nil, ringContainer), CreateFrame("BUTTON", nil, ringContainer)
		prev:SetSize(22, 22) next:SetSize(22, 22)
		next:SetPoint("TOPRIGHT", ringContainer, "TOPLEFT", 2, 0)
		prev:SetPoint("RIGHT", next, "LEFT", 4, 0)
		prev:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Up")
		prev:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Down")
		prev:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Disabled")
		prev:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
		next:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Up")
		next:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Down")
		next:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Disabled")
		next:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
		next:SetID(1) prev:SetID(-1)
		local function handler(self) api.scrollSliceList(self:GetID()) end
		next:SetScript("OnClick", handler) prev:SetScript("OnClick", handler)
		ringContainer.prev, ringContainer.next = prev, next
		local cap = CreateFrame("Frame", nil, ringContainer)
		cap:SetPoint("TOPLEFT", ringContainer, "TOPLEFT", -38, 0)
		cap:SetPoint("BOTTOMRIGHT", ringContainer, "BOTTOMLEFT", -1, 0)
		cap:SetScript("OnMouseWheel", function(_, delta)
			local b = delta == 1 and prev or next
			if b:IsEnabled() then b:Click() end
		end)
	end
	ringContainer.slices = {} do
		local function onClick(self)
			PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON)
			api.selectSlice(self:GetID(), self:GetChecked())
		end
		local function dragStart(self)
			PlaySound(832)
			self.source = api.resolveSliceOffset(self:GetID())
			SetCursor(self.tex:GetTexture())
		end
		local function dragStop(self)
			PlaySound(833)
			SetCursor(nil)
			local x, y = GetCursorPosition()
			local scale, l, b, w, h = self:GetEffectiveScale(), self:GetRect()
			local dy, dx = math.floor(-(y / scale - b - h-1)/(h+2)), x / scale - l
			if dx < -2*w or dx > 2*w then return api.deleteSlice(self.source) end
			if dx < -w/2 or dx > 3*w/2 then return end
			local source, dest = self.source, self:GetID() + dy
			if not ringContainer.slices[dest+1] or not ringContainer.slices[dest+1]:IsShown() then return end
			dest = api.resolveSliceOffset(dest)
			if dest ~= source then api.moveSlice(source, dest) end
		end
		for i=0,11 do
			local ico = createIconButton(nil, ringContainer, i)
			ico:SetPoint("TOP", ringContainer.prev, "BOTTOMRIGHT", -2, -34*i+2)
			ico:SetScript("OnClick", onClick)
			ico:RegisterForDrag("LeftButton")
			ico:SetScript("OnDragStart", dragStart)
			ico:SetScript("OnDragStop", dragStop)
			ico.check = ico:CreateTexture(nil, "OVERLAY")
			ico.check:SetSize(8,8) ico.check:SetPoint("BOTTOMRIGHT", -1, 1)
			ico.check:SetTexture("Interface/FriendsFrame/StatusIcon-Online")
			ringContainer.slices[i+1] = ico
		end
	end
	ringContainer.newSlice = createIconButton(nil, ringContainer) do
		local b = ringContainer.newSlice
		b:SetSize(24,24) b.tex:SetTexture("Interface/GuildBankFrame/UI-GuildBankFrame-NewTab")
		b:SetScript("OnClick", function()
			local shown = newSlice:IsShown()
			if sliceDetail:IsShown() then
				api.selectSlice()
				for i=1,#ringContainer.slices do
					ringContainer.slices[i]:SetChecked(nil)
				end
			end
			ringDetail:SetShown(shown)
			newSlice:SetShown(not shown)
			PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON)
		end)
		b:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:SetPoint("LEFT", self, "RIGHT", 2, 0)
			GameTooltip:AddLine(L"Add a new slice", 1, 1, 1)
			GameTooltip:Show()
		end)
		b:SetScript("OnLeave", conf.ui.HideTooltip)
		b:SetPoint("TOP", ringContainer.slices[12], "BOTTOM", 0, -2)
	end
end
ringDetail = CreateFrame("Frame", nil, ringContainer) do
	ringDetail:SetAllPoints()
	ringDetail:SetScript("OnKeyDown", function(self, key)
		self:SetPropagateKeyboardInput(key ~= "ESCAPE")
		if key == "ESCAPE" then
			api.deselectRing()
		end
	end)
	ringDetail.name = CreateFrame("EditBox", nil, ringDetail)
	ringDetail.name:SetHeight(20) ringDetail.name:SetPoint("TOPLEFT", 7, -7) ringDetail.name:SetPoint("TOPRIGHT", -7, -7) ringDetail.name:SetFontObject(GameFontNormalLarge) ringDetail.name:SetAutoFocus(false)
	prepEditBox(ringDetail.name, function(self) api.setRingProperty("name", self:GetText()) end)
	local tex = ringDetail.name:CreateTexture()
	tex:SetHeight(1) tex:SetPoint("BOTTOMLEFT", 0, -2) tex:SetPoint("BOTTOMRIGHT", 0, -2)
	tex:SetColorTexture(1,0.82,0, 0.5)
	ringDetail.scope = CreateFrame("Frame", "RKC_RingScopeDropDown", ringDetail, "UIDropDownMenuTemplate")
	ringDetail.scope:SetPoint("TOPLEFT", 250, -37) UIDropDownMenu_SetWidth(ringDetail.scope, 250)
	ringDetail.scope.label = ringDetail.scope:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	ringDetail.scope.label:SetPoint("TOPLEFT", ringDetail, "TOPLEFT", 10, -47)
	ringDetail.binding = conf.createBindingButton(ringDetail)
	ringDetail.binding:SetPoint("TOPLEFT", 267, -68) ringDetail.binding:SetWidth(265)
	function ringDetail:SetBinding(bind) return api.setRingProperty("hotkey", bind) end
	function ringDetail:OnBindingAltClick() self:ToggleAlternateEditor(api.getRingProperty("hotkey")) end
	ringDetail.binding.label = ringDetail.scope:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	ringDetail.binding.label:SetPoint("TOPLEFT", ringDetail, "TOPLEFT", 10, -73)
	ringDetail.bindingQuarantine = CreateFrame("CheckButton", nil, ringDetail, "InterfaceOptionsCheckButtonTemplate")
	ringDetail.bindingQuarantine:SetHitRectInsets(0,0,0,0)
	ringDetail.bindingQuarantine:SetPoint("RIGHT", ringDetail.binding, "LEFT", 0, 0)
	ringDetail.bindingQuarantine:SetScript("OnClick", function() api.setRingProperty("hotkey", api.getRingProperty("quarantineBind")) end)
	ringDetail.rotation = CreateFrame("Slider", "RKC_RingRotation", ringDetail, "OptionsSliderTemplate")
	ringDetail.rotation:SetPoint("TOPLEFT", 270, -95) ringDetail.rotation:SetWidth(260) ringDetail.rotation:SetMinMaxValues(0, 345) ringDetail.rotation:SetValueStep(15) ringDetail.rotation:SetObeyStepOnDrag(true)
	ringDetail.rotation:SetScript("OnValueChanged", function(_, value) api.setRingProperty("offset", value) end)
	RKC_RingRotationLow:SetText("0\194\176") RKC_RingRotationHigh:SetText("345\194\176")
	ringDetail.rotation.label = ringDetail.scope:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	ringDetail.rotation.label:SetPoint("TOPLEFT", ringDetail, "TOPLEFT", 10, -96)
	ringDetail.opportunistCA = CreateFrame("CheckButton", nil, ringDetail, "InterfaceOptionsCheckButtonTemplate")
	ringDetail.opportunistCA:SetPoint("TOPLEFT", 266, -118)
	ringDetail.opportunistCA:SetMotionScriptsWhileDisabled(1)
	ringDetail.opportunistCA:SetScript("OnClick", function(self) api.setRingProperty("noOpportunisticCA", (not self:GetChecked()) or nil) api.setRingProperty("noPersistentCA", (not self:GetChecked()) or nil) end)
	ringDetail.hiddenRing = CreateFrame("CheckButton", nil, ringDetail, "InterfaceOptionsCheckButtonTemplate")
	ringDetail.hiddenRing:SetPoint("TOPLEFT", ringDetail.opportunistCA, "BOTTOMLEFT", 0, 2)
	ringDetail.hiddenRing:SetScript("OnClick", function(self) api.setRingProperty("internal", self:GetChecked() and true or nil) end)
	ringDetail.embedRing = CreateFrame("CheckButton", nil, ringDetail, "InterfaceOptionsCheckButtonTemplate")
	ringDetail.embedRing:SetPoint("TOPLEFT", ringDetail.hiddenRing, "BOTTOMLEFT", 0, 2)
	ringDetail.embedRing:SetScript("OnClick", function(self) api.setRingProperty("embed", self:GetChecked() and true or nil) end)

	ringDetail.optionsLabel = ringDetail:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	ringDetail.optionsLabel:SetPoint("TOPLEFT", ringDetail, "TOPLEFT", 10, -125)
	ringDetail.shareLabel = ringDetail:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	ringDetail.shareLabel:SetPoint("TOPLEFT", ringDetail, "TOPLEFT", 10, -198)
	ringDetail.shareLabel2 = ringDetail:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmallLeft")
	ringDetail.shareLabel2:SetPoint("TOPLEFT", ringDetail, "TOPLEFT", 270, -198)
	ringDetail.shareLabel2:SetWidth(275)
	ringDetail.export = CreateButton(ringDetail)
	ringDetail.export:SetPoint("TOP", ringDetail.shareLabel2, "BOTTOM", 0, -2)
	ringDetail.export:SetScript("OnClick", function() PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON) api.exportRing() end)
	
	local exportBg, scroll = CreateFrame("Frame", nil, ringDetail)
	exportBg:SetBackdrop({edgeFile="Interface/Tooltips/UI-Tooltip-Border", bgFile="Interface/DialogFrame/UI-DialogBox-Background-Dark", tile=true, edgeSize=16, tileSize=16, insets={left=4,right=4,bottom=4,top=4}})
	exportBg:SetBackdropBorderColor(0.7,0.7,0.7) exportBg:SetBackdropColor(0,0,0,0.7)
	exportBg:SetSize(265, 124) exportBg:Hide()
	exportBg:SetPoint("TOPLEFT", ringDetail.shareLabel2, "BOTTOMLEFT", -2, -2)
	ringDetail.exportFrame, ringDetail.exportInput, scroll = exportBg, conf.ui.multilineInput("RKC_ExportInput", exportBg, 235)
	scroll:SetPoint("TOPLEFT", 5, -4) scroll:SetPoint("BOTTOMRIGHT", -26, 4)
	ringDetail.exportInput:SetFontObject(GameFontHighlightSmall)
	ringDetail.exportInput:SetScript("OnEscapePressed", function() exportBg:Hide() ringDetail.export:Show() end)
	ringDetail.exportInput:SetScript("OnChar", function(self) local text = self:GetText() if text ~= "" and text ~= self.text then self:SetText(self.text or "") self:SetCursorPosition(0) self:HighlightText() end end)
	ringDetail.exportInput:SetScript("OnTextSet", function(self) self.text = self:GetText() end)
	exportBg:SetScript("OnHide", function(self)
		self:Hide()
		ringDetail.export:Show()
		ringDetail.shareLabel2:SetText(L"Take a snapshot of this ring to share it with others.")
	end)
	exportBg:SetScript("OnShow", function()
		ringDetail.export:Hide()
		ringDetail.shareLabel2:SetText((L"Import snapshots by clicking %s above."):format(NORMAL_FONT_COLOR_CODE .. L"New Ring..." .. "|r"))
	end)
	
	ringDetail.remove = CreateButton(ringDetail)
	ringDetail.remove:SetPoint("BOTTOMRIGHT", -10, 10)
	ringDetail.remove:SetScript("OnClick", function() PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON) api.deleteRing() end)
	
	ringDetail.restore = CreateButton(ringDetail)
	ringDetail.restore:SetPoint("RIGHT", ringDetail.remove, "LEFT", -10, 0)
	ringDetail.restore:SetScript("OnClick", function() PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON) api.restoreDefault() end)

	ringDetail:Hide()
end
sliceDetail = CreateFrame("Frame", nil, ringContainer) do
	sliceDetail:SetAllPoints()
	sliceDetail.desc = sliceDetail:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	sliceDetail.desc:SetPoint("TOPLEFT", 7, -9) sliceDetail.desc:SetPoint("TOPRIGHT", -7, -7) sliceDetail.desc:SetJustifyH("LEFT")
	sliceDetail:SetScript("OnKeyDown", function(self, key)
		self:SetPropagateKeyboardInput(key ~= "ESCAPE")
		if key == "ESCAPE" then
			api.selectSlice()
		end
	end)
	local oy = 37
	sliceDetail.skipSpecs = CreateFrame("Frame", "RKC_SkipSpecDropdown", sliceDetail, "UIDropDownMenuTemplate") do
		local s = sliceDetail.skipSpecs
		s:SetPoint("TOPLEFT", 250, -oy); UIDropDownMenu_SetWidth(s, 250)
		oy = oy + 31
		s.label = s:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		s.label:SetPoint("TOPLEFT", sliceDetail, "TOPLEFT", 10, -47)
	end
	sliceDetail.showConditional = conf.ui.lineInput(sliceDetail, true, 260) do
		local c = sliceDetail.showConditional
		c:SetPoint("TOPLEFT", 274, -oy)
		oy = oy + 23
		c.label = c:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		c.label:SetPoint("TOPLEFT", sliceDetail, "TOPLEFT", 10, -73)
		prepEditBox(c, function(self) api.setSliceProperty("show", self:GetText()) end)
		c:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOP")
			GameTooltip:AddLine(L"Conditional Visibility")
			GameTooltip:AddLine((L"If this macro conditional evaluates to %shide|r, or if none of its clauses apply, this slice will be hidden."):format(GREEN_FONT_COLOR_CODE), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, 1)
			GameTooltip:AddLine((L"You may use extended macro conditionals; see |cff33DDFF%s|r for details."):format("http://townlong-yak.com/opie/extended-conditionals"), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, 1)
			GameTooltip:AddLine((L"Example: %s."):format(GREEN_FONT_COLOR_CODE .. "[nocombat][mod]|r"), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			GameTooltip:AddLine((L"Example: %s."):format(GREEN_FONT_COLOR_CODE .. "[combat,@target,noexists] hide; show|r"), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			GameTooltip:Show()
		end)
		c:SetScript("OnLeave", conf.ui.HideTooltip)
	end
	sliceDetail.caption = conf.ui.lineInput(sliceDetail, true, 260) do
		local c = sliceDetail.caption
		c:SetPoint("TOPLEFT", 274, -oy)
		oy = oy + 23
		c.label = c:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		c.label:SetPoint("TOPLEFT", sliceDetail, "TOPLEFT", 10, -96)
		prepEditBox(c, function(self) api.setSliceProperty("caption", self:GetText()) end)
	end
	sliceDetail.color = conf.ui.lineInput(sliceDetail, true, 85) do
		local c = sliceDetail.color
		c:SetPoint("TOPLEFT", 274, -oy)
		oy = oy + 23
		c:SetTextInsets(22, 0, 0, 0) c:SetMaxBytes(7)
		prepEditBox(c, function(self)
			local r,g,b = self:GetText():match("(%x%x)(%x%x)(%x%x)")
			if self:GetText() == "" then
				api.setSliceProperty("color")
			elseif not r then
				if self.oldValue == "" then self.placeholder:Show() end
				self:SetText(self.oldValue)
			else
				api.setSliceProperty("color", tonumber(r,16)/255, tonumber(g,16)/255, tonumber(b,16)/255)
			end
		end)
		c.label = c:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		c.label:SetPoint("TOPLEFT", sliceDetail, "TOPLEFT", 10, -119)
		c.placeholder = c:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		c.placeholder:SetPoint("LEFT", 18, 0)
		c.button = CreateFrame("Button", nil, c)
		local b = sliceDetail.color.button
		b:SetSize(14, 14) b:SetPoint("LEFT")
		b.bg = sliceDetail.color.button:CreateTexture(nil, "BACKGROUND")
		b.bg:SetSize(12, 12) b.bg:SetPoint("CENTER")
		b.bg:SetColorTexture(1,1,1)
		b:SetNormalTexture("Interface/ChatFrame/ChatFrameColorSwatch")
		b:SetScript("OnEnter", function(self) self.bg:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b) end)
		b:SetScript("OnLeave", function(self) self.bg:SetVertexColor(1, 1, 1) end)
		b:SetScript("OnShow", b:GetScript("OnLeave"))
		local ctex = b:GetNormalTexture()
		local function update(v)
			if ColorPickerFrame:IsShown() or v then return end
			api.setSliceProperty("color", ColorPickerFrame:GetColorRGB())
		end
		b:SetScript("OnClick", function()
			local cp = ColorPickerFrame
			cp.previousValues, cp.hasOpacity, cp.func, cp.cancelFunc = true
			cp:SetColorRGB(ctex:GetVertexColor()) cp:Show()
			cp.func, cp.cancelFunc = update, update
		end)
		local ceil = math.ceil
		function c:SetColor(r,g,b, custom)
			if r and g and b and custom then
				c:SetText(("%02X%02X%02X"):format(ceil((r or 0)*255),ceil((g or 0)*255),ceil((b or 0)*255)))
				c.placeholder:Hide()
			else
				c:SetText("")
				c.placeholder:Show()
			end
			ctex:SetVertexColor(r or 0,g or 0,b or 0)
		end
	end
	sliceDetail.icon = CreateFrame("Button", nil, sliceDetail) do
		local f = sliceDetail.icon
		f:SetHitRectInsets(0,-280,0,0) f:SetSize(18, 18)
		f:SetPoint("TOPLEFT", 270, -oy)
		oy = oy + 23
		f:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
		f:SetNormalFontObject(GameFontHighlightSmall) f:SetHighlightFontObject(GameFontGreenSmall) f:SetPushedTextOffset(3/4, -3/4)
		f:SetText(" ") f:GetFontString():ClearAllPoints() f:GetFontString():SetPoint("LEFT", f, "RIGHT", 4, 0)
		f.icon = f:CreateTexture() f.icon:SetAllPoints()
		f.label = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		f.label:SetPoint("TOPLEFT", sliceDetail, "TOPLEFT", 10, -142)
		
		local frame = CreateFrame("Frame", nil, f)
		frame:SetBackdrop({bgFile = "Interface/ChatFrame/ChatFrameBackground", edgeFile = "Interface/DialogFrame/UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 11, top = 12, bottom = 10 }})
		frame:SetSize(554, 19+34*6) frame:SetPoint("TOPLEFT", f, "TOPLEFT", -265, -18) frame:SetFrameStrata("DIALOG")
		frame:SetBackdropColor(0,0,0, 0.85) frame:EnableMouse(1) frame:SetToplevel(1) frame:Hide()
		f:SetScript("OnClick", function() frame:SetShown(not frame:IsShown()) PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON) end)
		frame:SetScript("OnHide", frame.Hide)
		do
			local ed = conf.ui.lineInput(frame, false, 280)
			local hint = ed:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
			hint:SetPoint("CENTER")
			hint:SetText("|cffa0a0a0" .. L"(enter an icon name or path here)")
			local bg = ed:CreateTexture(nil, "BACKGROUND", nil, -8)
			bg:SetColorTexture(0,0,0,0.95)
			bg:SetPoint("TOPLEFT", -3, 3)
			bg:SetPoint("BOTTOMRIGHT", 3, -3)
			ed:SetPoint("BOTTOM", 0, 8)
			ed:SetFrameLevel(ed:GetFrameLevel()+5)
			ed:SetScript("OnEditFocusGained", function() hint:Hide() end)
			ed:SetScript("OnEditFocusLost", function(self) hint:SetShown(not self:GetText():match("%S")) end)
			ed:SetScript("OnEnterPressed", function(self)
				local text = self:GetText()
				if text:match("%S") then
					local path = GetFileIDFromPath(text)
					path = path or GetFileIDFromPath("Interface\\Icons\\" .. text)
					api.setSliceProperty("icon", path or text)
				end
				self:SetText("")
				self:ClearFocus()
			end)
			ed:SetScript("OnEscapePressed", function(self) self:SetText("") self:ClearFocus() end)
			frame.textInput, frame.textInputHint = ed, hint
			frame:SetScript("OnKeyDown", function(self, key)
				self:SetPropagateKeyboardInput(key ~= "TAB" and key ~= "ESCAPE")
				if key == "TAB" then
					ed:SetFocus()
				elseif key == "ESCAPE" then
					frame:Hide()
				end
			end)
		end
		local icons, selectedIcon = {}
		local function onClick(self)
			if selectedIcon then selectedIcon:SetChecked(nil) end
			PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON)
			api.setSliceProperty("icon", self:GetChecked() and self.tex:GetTexture() or nil)
			selectedIcon = self:GetChecked() and self or nil
		end
		for i=0,89 do
			local j = createIconButton(nil, frame, i)
			j:SetPoint("TOPLEFT", (i % 15)*34+12, -11 - 34*math.floor(i / 15))
			j:SetScript("OnClick", onClick)
			icons[i] = j
		end
		local icontex, initTexture = {}, nil
		local slider = CreateFrame("Slider", "RKC_IconSelectionSlider", frame, "UIPanelScrollBarTrimTemplate")
			slider:SetPoint("TOPRIGHT",-11, -26) slider:SetPoint("BOTTOMRIGHT", -11, 25)
			slider:SetValueStep(15) slider:SetObeyStepOnDrag(true) slider.scrollStep = 45
			slider.Up, slider.Down = RKC_IconSelectionSliderScrollUpButton, RKC_IconSelectionSliderScrollDownButton
			slider:SetScript("OnValueChanged", function(self, value)
				self.Up:SetEnabled(value > 1)
				self.Down:SetEnabled(icontex[value + #icons + 1] ~= nil)
				for i=0,#icons do
					local ico, tex = icons[i].tex, i == 0 and value == 1 and (initTexture or "Interface/Icons/INV_Misc_QuestionMark") or icontex[i+value-1]
					ico:SetShown(not not tex)
					if tex then
						ico:SetTexture(tex)
						local tex = ico:GetTexture()
						icons[i]:SetChecked(f.selection == tex)
						selectedIcon = f.selection == tex and icons[i] or selectedIcon
					end
				end
			end)
		frame:SetScript("OnShow", function(self)
			self:SetFrameStrata("DIALOG")
			self:SetFrameLevel(sliceDetail.icon:GetFrameLevel()+10)
			icontex = GetMacroIcons()
			GetMacroItemIcons(icontex)
			slider:SetMinMaxValues(1, #icontex-#icons+16)
			if slider:GetValue() == 1 then
				slider:GetScript("OnValueChanged")(slider, slider:GetValue())
			else
				slider:SetValue(1)
			end
		end)
		frame:SetScript("OnMouseWheel", function(_, delta)
			slider:SetValue(slider:GetValue()-delta*15)
		end)
		function f:SetIcon(ico, forced, ext, slice)
			setIcon(self.icon, forced or ico, ext, slice)
			initTexture = self.icon:GetTexture()
			self.selection = forced
			self:SetText(forced and L"Customized icon" or L"Based on slice action")
			if frame:IsShown() then slider:GetScript("OnValueChanged")(slider, slider:GetValue()) end
		end
		function f:HidePanel()
			frame:Hide()
		end
	end
	sliceDetail.optionBoxes = {} do
		local function update(self)
			return api.setSliceProperty(self.prop, self:GetChecked() and true or nil)
		end
		for i=1,4 do
			local e = CreateFrame("CheckButton", nil, sliceDetail, "InterfaceOptionsCheckButtonTemplate")
			e:SetHitRectInsets(0, -200, 0, 0) e:SetMotionScriptsWhileDisabled(1) e:SetScript("OnClick", update)
			if i > 1 then e:SetPoint("TOPLEFT", sliceDetail.optionBoxes[i-1], "BOTTOMLEFT", 0, 5) end
			sliceDetail.optionBoxes[i] = e
		end
		sliceDetail.optionBoxes[1]:SetPoint("TOPLEFT", 266, -oy)
		oy = oy + 4*23
		sliceDetail.optionBoxes.label = sliceDetail:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		sliceDetail.optionBoxes.label:SetPoint("TOPLEFT", sliceDetail, "TOPLEFT", 10, -165)
	end
	
	do -- .editorContainer
		local f = CreateFrame("Frame", nil, sliceDetail)
		f:SetPoint("TOPLEFT", sliceDetail.optionBoxes.label, "BOTTOMLEFT", 0, -10)
		f:SetPoint("BOTTOMRIGHT", -10, 36)
		function f:SaveAction()
			return api.setSliceProperty("*", self.curEditor)
		end
		function f:SetEditor(editor, ...)
			if self.curEditor then
				self.curEditor:Release(self)
			end
			self.curEditor = editor
			if editor then
				editor:SetAction(self, ...)
			end
		end
		sliceDetail.editorContainer = f
	end
	sliceDetail.remove = CreateButton(sliceDetail)
	sliceDetail.remove:SetPoint("BOTTOMRIGHT", -10, 10)
	sliceDetail.remove:SetScript("OnClick", function() api.deleteSlice() end)
end
newSlice = CreateFrame("Frame", nil, ringContainer) do
	newSlice:SetAllPoints()
	newSlice:Hide()
	newSlice.slider = CreateFrame("Slider", "RKC_NewSliceCategorySlider", newSlice, "UIPanelScrollBarTrimTemplate") do
		local s = newSlice.slider
		s:SetPoint("TOPLEFT", 162, -19)
		s:SetPoint("BOTTOMLEFT", 162, 17)
		s:SetMinMaxValues(0, 20)
		s:SetValueStep(1)
		s:SetObeyStepOnDrag(true)
		s.scrollStep = 5
		s.Up, s.Down = RKC_NewSliceCategorySliderScrollUpButton, RKC_NewSliceCategorySliderScrollDownButton
		local cap = CreateFrame("Frame", nil, newSlice)
		cap:SetPoint("TOPLEFT")
		cap:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT")
		cap:SetScript("OnMouseWheel", function(_, delta)
			s:SetValue(s:GetValue()-delta)
		end)
	end
	
	local cats, actions, searchCat, selectCategory, selectedCategory, selectedCategoryId = {}, {}
	local performSearch do
		local function matchAction(q, ...)
			local _, aname = AB:GetActionDescription(...)
			if type(aname) ~= "string" then return end
			aname = aname:match("|") and aname:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-|t", ""):lower() or aname:lower()
			return not not aname:match(q)
		end
		function performSearch(query, inCurrentCategory)
			searchCat = selectedCategory
			if not inCurrentCategory then
				searchCat = AB:GetCategoryContents(1)
				for i=2,AB:GetNumCategories() do
					searchCat = AB:GetCategoryContents(i, searchCat)
				end
			end
			searchCat:filter(matchAction, query:lower())
			selectCategory(-1)
		end
	end
	do -- newSlice.search
		local s = conf.ui.lineInput(newSlice, true, 153)
		s:SetPoint("TOPLEFT", 7, -1) s:SetTextInsets(16, 0, 0, 0)
		local i = s:CreateTexture(nil, "OVERLAY")
		i:SetSize(14, 14) i:SetPoint("LEFT", 0, -1)
		i:SetTexture("Interface/Common/UI-Searchbox-Icon")
		local l, tip = s:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall"), CreateFrame("GameTooltip", "RKC_SearchTip", newSlice, "GameTooltipTemplate")
		l:SetPoint("LEFT", 16, 0)
		s:SetScript("OnEditFocusGained", function(s)
			l:Hide()
			i:SetVertexColor(0.90, 0.90, 0.90)
			tip:SetFrameStrata("TOOLTIP")
			tip:SetOwner(s, "ANCHOR_BOTTOM")
			tip:AddLine(L"Press |cffffffffEnter|r to search")
			tip:AddLine(L"|cffffffffCtrl+Enter|r to search within current results", nil, nil, nil, true)
			tip:AddLine(L"|cffffffffEscape|r to cancel", true)
			tip:Show()
		end)
		s:SetScript("OnEditFocusLost", function(s)
			l:SetShown(not s:GetText():match("%S"))
			i:SetVertexColor(0.75, 0.75, 0.75)
			tip:Hide()
		end)
		s:SetScript("OnEnterPressed", function(s)
			s:ClearFocus()
			if s:GetText():match("%S") then
				performSearch(s:GetText(), IsControlKeyDown() and selectedCategory)
			end
		end)
		newSlice.search, s.ico, s.label = s, i, l
	end
	
	local catbg = newSlice:CreateTexture(nil, "BACKGROUND")
	catbg:SetPoint("TOPLEFT", 2, -2) catbg:SetPoint("RIGHT", newSlice, "RIGHT", -2, 0) catbg:SetPoint("BOTTOM", 0, 2)
	catbg:SetColorTexture(0,0,0, 0.65)
	local function onClick(self) PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON) selectCategory(self:GetID()) end
	for i=1,22 do
		local b = CreateFrame("Button", nil, newSlice)
		b:SetSize(159, 20)
		b:SetNormalTexture("Interface/AchievementFrame/UI-Achievement-Category-Background")
		b:SetHighlightTexture("Interface/AchievementFrame/UI-Achievement-Category-Highlight")
		b:GetNormalTexture():SetTexCoord(7/256, 162/256, 5/32, 24/32)
		b:GetHighlightTexture():SetTexCoord(7/256, 163/256, 5/32, 24/32)
		b:GetNormalTexture():SetVertexColor(0.6, 0.6, 0.6)
		b:SetNormalFontObject(GameFontHighlight)
		b:SetPushedTextOffset(0,0)
		b:SetText(" ") b:GetFontString():SetPoint("CENTER", 0, 1)
		b:SetScript("OnClick", onClick)
		cats[i] = b
		if i > 1 then cats[i]:SetPoint("TOP", cats[i-1], "BOTTOM") end
	end
	cats[1]:SetPoint("TOPLEFT", 2, -22)

	newSlice.desc = newSlice:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	newSlice.desc:SetPoint("TOPLEFT", newSlice.slider, "TOPRIGHT", 2, 10)
	newSlice.desc:SetPoint("RIGHT", -24, 0)
	newSlice.desc:SetHeight(26)
	newSlice.desc:SetJustifyV("TOP") newSlice.desc:SetJustifyH("CENTER")
	
	newSlice.close = CreateFrame("Button", "RKC_CloseNewSliceBrowser", newSlice, "UIPanelCloseButton")
	newSlice.close:SetPoint("TOPRIGHT", 3, 4)
	newSlice.close:SetSize(30, 30)
	newSlice.close:SetScript("OnClick", function() ringContainer.newSlice:Click() end)
	local b = newSlice.close:CreateTexture(nil, "BACKGROUND", "UI-Frame-TopCornerRight")
	b:SetTexCoord(90/128, 113/128, 2/128, 25/128)
	b:SetPoint("TOPLEFT", 4, -5) b:SetPoint("BOTTOMRIGHT", -5, 4)
	b:SetVertexColor(0.6,0.6,0.6)
	
	newSlice.slider2 = CreateFrame("Slider", "RKC_NewSliceActionSlider", newSlice, "UIPanelScrollBarTrimTemplate") do
		local s = newSlice.slider2
		s:SetPoint("TOPRIGHT", -2, -38)
		s:SetPoint("BOTTOMRIGHT", -2, 16)
		s:SetMinMaxValues(0, 20)
		s:SetValueStep(1)
		s:SetObeyStepOnDrag(true)
		s.scrollStep = 4
		s.Up, s.Down = RKC_NewSliceActionSliderScrollUpButton, RKC_NewSliceActionSliderScrollDownButton
		local cap = CreateFrame("Frame", nil, newSlice)
		cap:SetPoint("TOPRIGHT")
		cap:SetPoint("BOTTOMLEFT", newSlice.slider, "BOTTOMRIGHT")
		cap:SetScript("OnMouseWheel", function(_, delta)
			s:SetValue(s:GetValue()-delta)
		end)
	end

	local function onClick(self)
		PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON)
		api.addSlice(nil, selectedCategory(self:GetID()))
	end
	local function onDragStart(self)
		PlaySound(832)
		SetCursor(self.ico:GetTexture())
	end
	local function onDragStop(self)
		PlaySound(833)
		SetCursor(nil)
		local e, x, y = ringContainer.slices[1], GetCursorPosition()
		if not e:GetLeft() then e = ringContainer.prev end
		local scale, l, b, w, h = e:GetEffectiveScale(), e:GetRect()
		local dy, dx = math.floor(-(y / scale - b - h-1)/(h+2)+0.5), x / scale - l
		if dx < -w/2 or dx > 3*w/2 then return end
		if dy < -1 or dy > (#ringContainer.slices+1) then return end
		api.addSlice(dy, selectedCategory(self:GetID()))
	end
	local function onEnter(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		if type(self.tipFunc) == "function" then
			securecall(self.tipFunc, GameTooltip, self.tipFuncArg)
		else
			GameTooltip:AddLine(self.name:GetText())
		end
		GameTooltip:Show()
	end
	for i=1,24 do
		local f = CreateFrame("Button", nil, newSlice)
		f:SetSize(176, 34) f:SetPoint("TOPLEFT", newSlice.desc, "BOTTOMLEFT", 178*(1 - i % 2), -math.floor((i-1)/2)*36+3)
		f:RegisterForDrag("LeftButton")
		actions[i] = f
		f:SetScript("OnDragStart", onDragStart)
		f:SetScript("OnDragStop", onDragStop)
		f:SetScript("OnDoubleClick", onClick)
		f:SetScript("OnEnter", onEnter)
		f:SetScript("OnLeave", conf.ui.HideTooltip)
		f.ico = f:CreateTexture(nil, "ARTWORK")
		f.ico:SetSize(32,32) f.ico:SetPoint("LEFT", 1, 0)
		f.name = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		f.name:SetPoint("TOPLEFT", f.ico, "TOPRIGHT", 3, -2)
		f.name:SetPoint("RIGHT", -2, 0)
		f.name:SetJustifyH("LEFT")
		f.sub = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		f.sub:SetPoint("TOPLEFT", f.name, "BOTTOMLEFT", 0, -2)
		f.sub:SetPoint("RIGHT", -2, 0)
		f.sub:SetJustifyH("LEFT")
		f:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
		f:GetHighlightTexture():SetAllPoints(f.ico)
	end

	local function syncActions()
		local slider = newSlice.slider2
		local base, _, maxV = math.floor(slider:GetValue())*2, slider:GetMinMaxValues()
		slider.Up:SetEnabled(base > 0)
		slider.Down:SetEnabled(base < maxV*2)
		for i=1,#actions do
			local e, id = actions[i], i + base
			if id <= #selectedCategory then
				local stype, sname, sicon, extico, tipfunc, tiparg = AB:GetActionDescription(selectedCategory(id))
				pcall(setIcon, e.ico, sicon, extico)
				e.tipFunc, e.tipFuncArg = tipfunc, tiparg
				e.name:SetText(sname)
				e.sub:SetText(stype)
				e:SetID(id)
				e:Show()
			else
				e:Hide()
			end
		end
	end
	local function syncCats(self, base)
		self.Up:SetEnabled(base > 0)
		self.Down:SetEnabled(base < select(2, self:GetMinMaxValues()))
		for i=1,#cats do
			local e, category, id = cats[i], AB:GetCategoryInfo(i+base), i+base
			e:SetShown(not not category)
			e:SetID(id)
			e[id == selectedCategoryId and "LockHighlight" or "UnlockHighlight"](e)
			e:SetText(L(category))
		end
		if selectedCategoryId == -1 then
			newSlice.search.ico:SetVertexColor(0.3, 1, 0)
		else
			newSlice.search.ico:SetVertexColor(0.75, 0.75, 0.75)
		end
	end
	function selectCategory(id)
		selectedCategoryId, selectedCategory = id, id == -1 and searchCat or AB:GetCategoryContents(id)
		if id ~= -1 then
			newSlice.search:SetText("")
			newSlice.search.label:Show()
		end
		syncCats(newSlice.slider, newSlice.slider:GetValue())
		newSlice.slider2:SetMinMaxValues(0, math.max(0, math.ceil((#selectedCategory - #actions)/2)))
		newSlice.slider2:SetValue(0)
		syncActions()
		newSlice.search:ClearFocus()
	end
	newSlice.slider:SetScript("OnValueChanged", syncCats)
	newSlice.slider2:SetScript("OnValueChanged", syncActions)
	newSlice:SetScript("OnShow", function(self)
		selectCategory(1)
		self.slider:SetMinMaxValues(0, math.max(0, AB:GetNumCategories() - #cats))
		self.slider:SetValue(0)
	end)
end

local knownProps = {lockRotation="Forget sub-ring rotation", fastClick="Allow as quick action", byName="Also use items with the same name", forceShow="Always show this slice", onlyEquipped="Only show when equipped", clickUsingRightButton="Simulate a right-click", embed1="Display as embedded in this ring", embed2="Display as nested in this ring"}
local function displaySliceOptions(id, ringName, slice, a, ...)
	local b, enabled, v = sliceDetail.optionBoxes[id], 1
	if not a or not b then return id end
	if knownProps[a] then
		b.prop, id, v, b.tooltipText = a, id + 1, slice[a]
		if a == "embed1" then v = slice.embed == true
		elseif a == "embed2" then v = slice.embed == false end
		b:SetChecked(v)
		if (a == "fastClick" and not OneRingLib:GetOption("CenterAction", ringName)) then
			b.tooltipText, enabled = (L"You must enable the %s option for this ring in OPie options to use quick actions."):format("|cffffffff" .. L"Quick action at ring center" .. "|r"), nil
			b:SetChecked(nil)
		end
		b.Text:SetText(L(knownProps[a]))
		b:SetEnabled(enabled)
		b.Text:SetVertexColor(enabled or 0.6, enabled or 0.6, enabled or 0.6)
	end
	return displaySliceOptions(id, ringName, slice, ...)
end

local PLAYER_CLASS, PLAYER_CLASS_UC = UnitClass("player")
local PLAYER_CLASS_COLOR_HEX = RAID_CLASS_COLORS[PLAYER_CLASS_UC].colorStr:sub(3)

local function getSliceInfo(slice)
	return securecall(AB.GetActionDescription, AB, RK:UnpackABAction(slice))
end
local function getSliceColor(slice, sicon)
	local c, r,g,b = true, (type(slice.c) == "string" and slice.c or ""):match("(%x%x)(%x%x)(%x%x)")
	if ORI and not r then
		c, r,g,b = false, ORI:GetTexColor(slice.icon or sicon or "Interface\\Icons\\INV_Misc_QuestionMark")
	elseif r then
		r,g,b = tonumber(r,16)/255, tonumber(g,16)/255, tonumber(b,16)/255
	end
	return r,g,b, c
end

local ringNameMap, ringOrderMap, ringTypeMap, ringNames, currentRing, currentRingName, sliceBaseIndex, currentSliceIndex = {}, {}, {}, {}
local typePrefix = {MINE="|cff25bdff|TInterface/FriendsFrame/UI-Toast-FriendOnlineIcon:14:14:0:1:32:32:8:24:8:24:30:190:255|t ", PERSONAL="|cffd659ff|TInterface/FriendsFrame/UI-Toast-FriendOnlineIcon:14:14:0:1:32:32:8:24:8:24:180:0:255|t "}
do
	for k, v in pairs(CLASS_ICON_TCOORDS) do
		typePrefix[k] = ("|cff%s|TInterface/GLUES/CHARACTERCREATE/UI-CharacterCreate-Classes:14:14:0:1:256:256:%d:%d:%d:%d|t "):format(RAID_CLASS_COLORS[k].colorStr:sub(3), v[1]*256+6,v[2]*256-6,v[3]*256+6,v[4]*256-6)
	end
end
local function sortNames(a,b)
	local oa, ob, na, nb, ta, tb = ringOrderMap[a] or 5, ringOrderMap[b] or 5, ringNameMap[a] or "", ringNameMap[b] or "", ringTypeMap[a] or "", ringTypeMap[b] or ""
	return oa < ob or (oa == ob and ta < tb) or (oa == ob and ta == tb and na < nb) or false
end
function ringDropDown:initialize(level, nameList)
	local info, playerName, playerServer = UIDropDownMenu_CreateInfo(), UnitFullName("player")
	local playerFullName = playerName .. "-" .. playerServer
	info.func, info.minWidth = api.selectRing, level == 1 and (self:GetWidth()-40) or nil
	if level == 1 then
		ringNames = {hidden={}, other={}}
		for name, dname, active, _slices, internal, limit in RK:GetManagedRings() do
			table.insert(active and (internal and ringNames.hidden or ringNames) or ringNames.other, name)
			local rtype = type(limit) ~= "string" and "GLOBAL" or limit == playerFullName and "MINE" or limit:match("[^A-Z]") and "PERSONAL" or limit
			ringNameMap[name], ringOrderMap[name], ringTypeMap[name] = dname, (not active and (rtype == "PERSONAL" and 12 or 10)) or (limit and (limit:match("[^A-Z]") and 0 or 2)), rtype
		end
		table.sort(ringNames, sortNames)
		table.sort(ringNames.hidden, sortNames)
		table.sort(ringNames.other, sortNames)
	end
	local t = nameList or ringNames
	for i=1,#t do
		local prefix = (typePrefix[ringTypeMap[t[i]]] or "")
		info.arg1, info.checked, info.text = t[i], currentRingName == t[i], prefix .. (ringNameMap[t[i]] or "?")
		UIDropDownMenu_AddButton(info, level)
	end
	if level == 1 then
		info.hasArrow, info.notCheckable, info.fontObject, info.text, info.func, info.checked = 1, 1, GameFontNormalSmall
		info.padding=32
		if t.hidden and #t.hidden > 0 then
			info.menuList, info.text = ringNames.hidden, L"Hidden rings"
			UIDropDownMenu_AddButton(info, level)
		end
		if t.other and #t.other > 0 then
			info.menuList, info.text = ringNames.other, L"Inactive rings"
			UIDropDownMenu_AddButton(info, level)
		end
	end
end
function api.createRing(name, data)
	local name = name:match("^%s*(.-)%s*$")
	if name == "" then return false end
	local iname = RK:GenFreeRingName(name)
	SaveRingVersion(iname, false)
	data.name, data.limit = name, data.limit == "PLAYER" and FULLNAME or (type(data.limit) == "string" and not data.limit:match("[^A-Z]") and data.limit or nil)
	api.saveRing(iname, data)
	api:selectRing(iname)
	return true
end
function api.selectRing(_, name)
	CloseDropDownMenus()
	ringDetail:Hide()
	sliceDetail:Hide()
	newSlice:Hide()
	ringContainer.newSlice:SetChecked(nil)
	local desc = RK:GetRingDescription(name)
	currentRing, currentRingName = nil
	if not desc then return end
	RK:SoftSync(name)
	UIDropDownMenu_SetText(ringDropDown, desc.name or name)
	ringDetail.rotation:SetValue(desc.offset or 0)
	ringDetail.name:SetText(desc.name or name)
	ringDetail.hiddenRing:SetChecked(desc.internal)
	ringDetail.embedRing:SetChecked(desc.embed)
	currentRing, currentRingName, sliceBaseIndex, currentSliceIndex = desc, name, 1
	api.refreshDisplay()
	ringDetail:Show()
	ringDetail.scope:text()
	api.updateRingLine()
	ringContainer:Show()
end
function api.updateRingLine()
	ringContainer.prev:SetEnabled(sliceBaseIndex > 1)
	ringContainer.next:Disable()
	local lastWidget
	for i=sliceBaseIndex,#currentRing do
		local e = ringContainer.slices[i-sliceBaseIndex+1]
		if not e then ringContainer.next:Enable() break end
		local _, _, sicon, icoext = getSliceInfo(currentRing[i])
		pcall(setIcon, e.tex, currentRing[i].icon or sicon, icoext, currentRing[i])
		e.check:SetShown(RK:IsRingSliceActive(currentRingName, i))
		e:SetChecked(currentSliceIndex == i)
		e:Show()
		lastWidget = e
	end
	ringContainer.newSlice:SetPoint("TOP", lastWidget or ringContainer.slices[1], lastWidget and "BOTTOM" or "TOP", 0, -2)
	for i=#currentRing-sliceBaseIndex+2,#ringContainer.slices do
		ringContainer.slices[i]:Hide()
	end
end
function api.scrollSliceList(dir)
	sliceBaseIndex = math.max(1,sliceBaseIndex + dir)
	api.updateRingLine()
end
function api.resolveSliceOffset(id)
	return sliceBaseIndex + id
end
function sliceDetail.skipSpecs:toggle(id)
	self = sliceDetail.skipSpecs
	local v, c = self.val:gsub("/" .. id .. "/", "/")
	if c == 0 then v = "/" .. id .. v end
	self.val = v
	api.setSliceProperty("skipSpecs")
	self:text()
end
function sliceDetail.skipSpecs:SetValue(skip)
	self.val = type(skip) == "string" and skip ~= "" and ("/" .. skip .. "/") or "/"
	self:text()
end
function sliceDetail.skipSpecs:GetValue()
	return self.val:match("^/(.+)/$")
end
function sliceDetail.skipSpecs:text()
	local text, u, skipSpecs = "", GetNumSpecializations(), self.val
	for i=1, u do
		local id, name = GetSpecializationInfo(i)
		if not skipSpecs:match("/" .. id .. "/") then
			text, u = text .. (text == "" and "" or ", ") .. name, u - 1
		end
	end
	if u == 0 then
		text = (L"All %s specializations"):format("|cff" .. PLAYER_CLASS_COLOR_HEX .. PLAYER_CLASS .. "|r")
	elseif text == "" then
		text = (L"No %s specializations"):format("|cff" .. PLAYER_CLASS_COLOR_HEX .. PLAYER_CLASS .. "|r")
	else
		text = (L"Only %s"):format("|cff" .. PLAYER_CLASS_COLOR_HEX .. text .. "|r")
	end
	UIDropDownMenu_SetText(self, text)
end
function sliceDetail.skipSpecs:initialize()
	local info, skip = UIDropDownMenu_CreateInfo(), self.val or ""
	info.func, info.isNotRadio, info.minWidth, info.keepShownOnClick = self.toggle, true, self:GetWidth()-40, true
	for i=1, GetNumSpecializations() do
		local id, name, _, icon = GetSpecializationInfo(i)
		info.text, info.arg1, info.checked = "|T" .. icon .. ":16:16:0:0:64:64:4:60:4:60|t " .. name, id, not skip:match("/" .. id .. "/")
		UIDropDownMenu_AddButton(info)
	end
end
function ringDetail.scope:initialize()
	local info = UIDropDownMenu_CreateInfo()
	info.func, info.minWidth, info.text, info.checked = self.set, self:GetWidth()-40, L"All characters", currentRing.limit == nil
	UIDropDownMenu_AddButton(info)
	info.text, info.checked, info.arg1 = (L"All %s characters"):format("|cff" .. PLAYER_CLASS_COLOR_HEX .. PLAYER_CLASS .. "|r"), currentRing.limit == PLAYER_CLASS_UC, PLAYER_CLASS_UC
	UIDropDownMenu_AddButton(info)
	info.text, info.checked, info.arg1 = (L"Only %s"):format("|cff" .. PLAYER_CLASS_COLOR_HEX .. SHORTNAME .. "|r"), currentRing.limit == FULLNAME, FULLNAME
	UIDropDownMenu_AddButton(info)
end
function ringDetail.scope:set(arg1)
	api.setRingProperty("limit", arg1)
end
function ringDetail.scope:text()
	local limit = currentRing.limit
	UIDropDownMenu_SetText(self, type(limit) ~= "string" and L"All characters" or
		limit:match("[^A-Z]") and (L"Only %s"):format("|cff" .. (limit == FULLNAME and PLAYER_CLASS_COLOR_HEX .. SHORTNAME or ("d659ff" .. limit)) .. "|r") or
		RAID_CLASS_COLORS[limit] and (L"All %s characters"):format("|cff" .. RAID_CLASS_COLORS[limit].colorStr:sub(3) .. (UnitSex("player") == 3 and LOCALIZED_CLASS_NAMES_FEMALE or LOCALIZED_CLASS_NAMES_MALE)[limit] .. "|r")
	)
end
function api.getRingProperty(key)
	if key == "hotkey" then
		if OneRingLib:GetRingInfo(currentRingName) then
			local skey, _, over = OneRingLib:GetRingBinding(currentRingName)
			if over then return skey end
		end
		if currentRing.hotkey and not OneRingLib:GetOption("UseDefaultBindings", currentRingName) then
			return currentRing.hotkey, "|cffa0a0a0"
		elseif currentRing.quarantineBind and not currentRing.hotkey then
			return currentRing.quarantineBind, "|cffa0a0a0"
		end
	end
	return currentRing[key]
end
function api.setRingProperty(name, value)
	if not currentRing then return end
	currentRing[name] = value
	if name == "limit" then
		ringDetail.scope:text()
		ringOrderMap[currentRingName] = value ~= nil and (value:match("[^A-Z]") and 0 or 2) or nil
	elseif name == "hotkey" then
		currentRing.quarantineBind = nil
		ringDetail.bindingQuarantine:Hide()
		ringDetail.binding:SetBindingText(value)
		if OneRingLib:GetRingInfo(currentRingName) then
			conf.undo.saveProfile()
			OneRingLib:SetRingBinding(currentRingName, value)
		end
	elseif name == "internal" then
		local source, dest = value and ringNames or ringNames.hidden, value and ringNames.hidden or ringNames
		for i=1,#source do if source[i] == currentRingName then
			table.remove(source, i)
			break
		end end
		table.insert(dest, currentRingName)
	end
	api.saveRing(currentRingName, currentRing)
end
function api.setSliceProperty(prop, ...)
	local slice = assert(currentRing[currentSliceIndex], "Setting a slice property on an unknown slice")
	if prop == "color" then
		local r, g, b = ...
		slice.c = r and ("%02x%02x%02x"):format(r*255, g*255, b*255) or nil
	elseif prop == "*" then
		(...):GetAction(slice)
		api.updateSliceDisplay(currentSliceIndex, slice)
	elseif prop == "skipSpecs" or prop == "show" then
		local ss = sliceDetail.skipSpecs:GetValue()
		local sh = sliceDetail.showConditional:GetText()
		slice.show = (ss or sh ~= "") and ((ss and ("[spec:" .. ss .. "] hide;") or "") .. sh) or nil
	elseif prop == "embed1" or prop == "embed2" then
		if ... then
			slice.embed = prop == "embed1"
		else
			slice.embed = nil
		end
	else
		slice[prop] = (...)
	end
	api.saveRing(currentRingName, currentRing)
	if prop == "icon" or prop == "color" then
		local _, _, ico, icoext = getSliceInfo(currentRing[currentSliceIndex])
		if prop ~= "color" then sliceDetail.icon:SetIcon(ico, slice.icon, icoext, currentRing[currentSliceIndex]) end
		sliceDetail.color:SetColor(getSliceColor(slice, ico))
	elseif prop == "embed1" or prop == "embed2" then
		api.updateSliceOptions(slice)
	end
	api.updateRingLine()
end
function api.updateSliceOptions(slice)
	local isCollection = slice[1] == "ring"
	local last = displaySliceOptions(1, currentRingName, slice, "fastClick", isCollection and "lockRotation", isCollection and "embed1", isCollection and "embed2")
	last = displaySliceOptions(last, currentRingName, slice, AB:GetActionOptions(slice[1]))
	for i=1,#sliceDetail.optionBoxes do
		sliceDetail.optionBoxes[i]:SetShown(i < last)
	end
end
function api.selectSlice(offset, select)
	if not select then
		sliceDetail:Hide()
		ringDetail:Show()
		currentSliceIndex = nil
		return
	end
	ringDetail:Hide() newSlice:Hide() sliceDetail:Hide() ringContainer.newSlice:SetChecked(nil)
	local old, id = ringContainer.slices[(currentSliceIndex or 0) + 1 - sliceBaseIndex], sliceBaseIndex + offset
	local desc = currentRing[id]
	if old then old:SetChecked(nil) end
	currentSliceIndex = nil
	if not desc then return ringDetail:Show() end
	return api.updateSliceDisplay(id, desc)
end
local function socall(f, s, ...)
	return true, f[s](f, ...)
end
function api.updateSliceDisplay(id, desc)
	local stype, sname, sicon, icoext = getSliceInfo(desc)
	if sname ~= "" then
		sliceDetail.desc:SetFormattedText("%s: |cffffffff%s|r", L(stype or "?"), L(sname or "?"))
	else
		sliceDetail.desc:SetText(stype or "?")
	end
	local skipSpecs, showConditional = (desc.show or ""):match("^%[spec:([%d/]+)%] hide;(.*)")
	sliceDetail.icon:HidePanel()
	sliceDetail.icon:SetIcon(sicon, desc.icon, icoext, desc)
	sliceDetail.color:SetColor(getSliceColor(desc, sicon))
	sliceDetail.skipSpecs:SetValue(skipSpecs)
	sliceDetail.showConditional:SetText(showConditional or desc.show or "")
	sliceDetail.caption:SetText(desc.caption or "")
	if not securecall(socall, sliceDetail.editorContainer, "SetEditor", T.TEMP_AB_EDITORS and T.TEMP_AB_EDITORS[desc[1]], desc) then
		securecall(socall, sliceDetail.editorContainer, "SetEditor", nil)
	end
	api.updateSliceOptions(desc)
	sliceDetail:Show()
	currentSliceIndex = id
end
function api.moveSlice(source, dest)
	if not (currentRing and currentRing[source] and currentRing[dest]) then return end
	table.insert(currentRing, dest, table.remove(currentRing, source))
	if currentSliceIndex == source then currentSliceIndex = dest end
	api.saveRing(currentRingName, currentRing)
	api.updateRingLine()
end
function api.deleteSlice(id)
	if id == nil then id = currentSliceIndex end
	if id and currentRing and currentRing[id] then
		table.remove(currentRing, id)
		if sliceBaseIndex == id and sliceBaseIndex > 1 then
			sliceBaseIndex = sliceBaseIndex - 1
		end
		if id == currentSliceIndex then
			currentSliceIndex = nil
			sliceDetail:Hide()
			ringDetail:Show()
		end
		api.saveRing(currentRingName, currentRing)
		api.updateRingLine()
	end
end
function api.deleteRing()
	if currentRing then
		ringContainer:Hide()
		conf.undo.saveProfile()
		api.saveRing(currentRingName, false)
		api.deselectRing()
	end
end
function api.deselectRing()
	ringContainer:Hide()
	currentRing, currentRingName, ringNames = nil
	UIDropDownMenu_SetText(ringDropDown, L"Select a ring to modify")
end
function api.restoreDefault()
	if currentRingName then
		local _, _, isDefaultAvailable, isDefaultOverriden = RK:GetRingInfo(currentRingName)
		if isDefaultAvailable and isDefaultOverriden then
			SaveRingVersion(currentRingName, true)
			RK:RestoreDefaults(currentRingName)
		end
		api.selectRing(nil, currentRingName)
	end
end
function api.addSlice(pos, ...)
	pos = math.max(1, math.min(#currentRing+1, pos and (pos + sliceBaseIndex) or (#currentRing+1)))
	table.insert(currentRing, pos, {...})
	api.saveRing(currentRingName, currentRing)
	if pos < sliceBaseIndex then sliceBaseIndex = pos end
	api.updateRingLine()
end
function api.saveRing(name, data)
	SaveRingVersion(name, true)
	if data ~= nil then
		if type(data) == "table" then
			data.save = true
		end
		RK:SetRing(name, data)
	end
	ringDetail.exportFrame:Hide()
end
function api.refreshDisplay()
	if currentRing and currentRing[currentSliceIndex] then
		api.updateSliceOptions(currentRing[currentSliceIndex])
	end
	if currentRing then
		ringDetail.binding:SetBindingText(api.getRingProperty("hotkey"))
		ringDetail.exportFrame:GetScript("OnHide")(ringDetail.exportFrame)
		local noCA = not OneRingLib:GetOption("CenterAction", currentRingName) and (L"You must enable the %s option for this ring in OPie options to use quick actions."):format("|cffffffff" .. L"Quick action at ring center" .. "|r") or nil
		ringDetail.opportunistCA.tooltipText = noCA
		ringDetail.opportunistCA:SetEnabled(not noCA)
		ringDetail.opportunistCA:SetChecked(not noCA and not currentRing.noOpportunisticCA)
		ringDetail.opportunistCA.Text:SetVertexColor(noCA and 0.6 or 1,noCA and 0.6 or 1,noCA and 0.6 or 1)
		ringDetail.bindingQuarantine:SetShown(not not currentRing.quarantineBind)
		ringDetail.bindingQuarantine:SetChecked(nil)
	end
end
function api.exportRing()
	local input = ringDetail.exportInput
	ringDetail.export:Hide()
	ringDetail.exportFrame:Show()
	input:SetText(RK:GetRingSnapshot(currentRingName))
	input:SetCursorPosition(0)
	input:HighlightText()
	input:SetFocus()
end

ringDetail:SetScript("OnShow", function()
	local _,_, isDefaultAvailable, isDefaultOverriden = RK:GetRingInfo(currentRingName)
	ringDetail.restore:SetText(isDefaultAvailable and L"Restore default" or L"Undo changes")
	ringDetail.restore:SetShown(isDefaultAvailable and isDefaultOverriden)
end)

function panel:refresh()
	btnNewRing:SetText(L"New Ring...")
	panel.desc:SetText(L"Customize OPie by modifying existing rings, or creating your own.")
	UIDropDownMenu_SetText(ringDropDown, L"Select a ring to modify")
	ringDetail.scope.label:SetText(L"Make this ring available to:")
	ringDetail.binding.label:SetText(L"Binding:")
	ringDetail.bindingQuarantine.tooltipText = L"To enable the default binding for this ring, check this box or change the binding."
	ringDetail.rotation.label:SetText(L"Rotation:")
	ringDetail.optionsLabel:SetText(L"Options:")
	ringDetail.hiddenRing.Text:SetText(L"Hide this ring")
	ringDetail.embedRing.Text:SetText(L"Embed into other rings by default")
	ringDetail.opportunistCA.Text:SetText(L"Pre-select a quick action slice")
	ringDetail.shareLabel:SetText(L"Snapshot:")
	
	ringDetail.export:SetText(L"Share ring")
	sliceDetail.showConditional.label:SetText(L"Visibility conditional:")
	sliceDetail.color.label:SetText(L"Color:")
	sliceDetail.caption.label:SetText(L"Caption:")
	sliceDetail.icon.label:SetText(L"Icon:")
	sliceDetail.optionBoxes.label:SetText(L"Options:")
	sliceDetail.remove:SetText(L"Delete slice")
	ringDetail.restore:SetText(L"Restore default")
	ringDetail.remove:SetText(L"Delete ring")
	newSlice.desc:SetText(L"Double click an action to add it to the ring.")
	newSlice.search.label:SetText(L"Search")
	sliceDetail.skipSpecs.label:SetText(L"Show this slice for:")
	sliceDetail.color.placeholder:SetText("|cffa0a0a0" .. L"(default)")
	
	currentRingName, currentRing, currentSliceIndex, ringNames = nil
	ringContainer:Hide()
	ringDetail:Hide()
	sliceDetail:Hide()
	newSlice:Hide()
end
function panel:okay()
	ringContainer:Hide()
end
function panel:default()
	for key in RK:GetManagedRings() do
		local _, _, isDefault, isOverriden = RK:GetRingInfo(key)
		if isDefault and isOverriden then
			SaveRingVersion(key, true)
		end
	end
	for key in RK:GetDeletedRings() do
		SaveRingVersion(key, false)
	end
	RK:RestoreDefaults()
	panel:refresh()
end
local function prot(f)
	return function() return securecall(f) end
end
panel.okay, panel.default, panel.refresh = prot(panel.okay), prot(panel.default), prot(panel.refresh)
panel:SetScript("OnShow", conf.checkSVState)

OneRingLib.ext.CustomRingsConfig = {}
function OneRingLib.ext.CustomRingsConfig:addProp(key, text)
	knownProps[key] = text
end

SLASH_OPIE_CUSTOM_RINGS1 = "/rk"
function SlashCmdList.OPIE_CUSTOM_RINGS()
	conf.open(panel)
end
conf.AddSlashSuffix(SlashCmdList.OPIE_CUSTOM_RINGS, "custom", "rings")