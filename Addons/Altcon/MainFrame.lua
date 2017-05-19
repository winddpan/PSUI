------------------------------------------------------------
-- MainFrame.lua
--
-- Abin
-- 2016-10-20
------------------------------------------------------------

local type = type
local pairs = pairs
local format = format
local CreateFrame = CreateFrame

local _, addon = ...
local L = addon.L

local frame = CreateFrame("Frame", "AltconFrame", UIParent)
addon.frame = frame
frame:Hide()
frame:SetSize(558, 330)
frame:SetPoint("CENTER")
frame:SetBackdrop({ bgFile = "Interface\\FrameGeneral\\UI-Background-Marble", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 } })
frame:SetFrameStrata("DIALOG")
frame:SetMovable(true)
frame:SetToplevel(true)
frame:SetUserPlaced(true)
frame:EnableMouse(true)
frame:SetClampedToScreen(true)
tinsert(UISpecialFrames, frame:GetName())

frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

frame:SetScript("OnShow", function() C_ChallengeMode.RequestMapInfo() end)

local topClose = CreateFrame("Button", frame:GetName().."TopClose", frame, "UIPanelCloseButton")
topClose:SetSize(24, 24)
topClose:SetPoint("TOPRIGHT", -5, -5)

local title = frame:CreateFontString(frame:GetName().."Title", "ARTWORK", "GameFontNormal")
title:SetPoint("TOP", 0, -17)
title:SetText(L["title"])

local list = UICreateVirtualScrollList(frame:GetName().."List", frame, 12)
list:SetPoint("TOPLEFT", 12, -44)
list:SetPoint("TOPRIGHT", -12, -44)
list:SetHeight(242)

local function DeleteProfile(data)
	local index = list:FindData(data)
	list:RemoveData(index)
	addon:DeleteProfile(data.profile)
end

local function DelButton_OnClick(self)
	addon:PopupShowConfirm(format(L["delete confirm"], self.data.profile), DeleteProfile, self.data)
end

local function Button_OnDragStart(self)
	frame:StartMoving()
end

local function Button_OnDragStop(self)
	frame:StopMovingOrSizing()
end

function list:OnButtonCreated(button)
	button:RegisterForDrag("LeftButton")
	button:SetScript("OnDragStart", Button_OnDragStart)
	button:SetScript("OnDragStop", Button_OnDragStop)

	button.delButton = CreateFrame("Button", button:GetName().."Delete", button, "UIPanelCloseButton")
	button.delButton:SetSize(24, 24)
	button.delButton:SetPoint("RIGHT")
	button.delButton:SetScript("OnClick", DelButton_OnClick)

	button.completedLevel = button:CreateText("CENTER", 0, 1, 1)
	button.completedLevel:SetPoint("LEFT")
	button.completedLevel:SetWidth(22)

	button.name = button:CreateText()
	button.name:SetPoint("LEFT", button.completedLevel, "RIGHT")
	button.name:SetWidth(130)

	button.keyIcon = button:CreateTexture(nil, "ARTWORK")
	button.keyIcon:SetSize(14, 14)
	button.keyIcon:SetPoint("LEFT", button.name, "RIGHT", 2, 0)
	button.keyIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.keyIcon:SetTexture(525134)

	button.keyLevel = button:CreateText("CENTER", 1, 1, 1)
	button.keyLevel:SetPoint("LEFT", button.keyIcon, "RIGHT")
	button.keyLevel:SetWidth(24)

	button.keystone = button:CreateText("LEFT")
	button.keystone:SetPoint("LEFT", button.keyLevel, "RIGHT")
	button.keystone:SetWidth(130)

	button.resIcon = button:CreateTexture(nil, "ARTWORK")
	button.resIcon:SetSize(14, 14)
	button.resIcon:SetPoint("LEFT", button.keystone, "RIGHT", 2, 0)
	button.resIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.resIcon:SetTexture("Interface\\Icons\\Inv_Orderhall_OrderResources")

	button.resource = button:CreateText()
	button.resource:SetPoint("LEFT", button.resIcon, "RIGHT", 2, 0)
	button.resource:SetWidth(55)

	button.orderIcon = button:CreateTexture(nil, "ARTWORK")
	button.orderIcon:SetSize(14, 14)
	button.orderIcon:SetPoint("LEFT", button.resource, "RIGHT", 2, 0)
	button.orderIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.orderIcon:SetTexture(237446)

	button.orders = button:CreateText("CENTER", 1, 1, 1)
	button.orders:SetPoint("LEFT", button.orderIcon, "RIGHT", 4, 0)

	button.remain = button:CreateText("RIGHT")
	button.remain:SetPoint("RIGHT", button.delButton, "LEFT")
end

function list:OnButtonUpdate(button, data)
	if data.profile == addon:GetCurProfileName() then
		button.delButton:Disable()
	else
		button.delButton:Enable()
	end

	button.delButton.data = data

	button.name:SetText(addon:GetDisplayName(data.profile))
	local r, g, b = addon:GetDisplayColor(data.class)
	button.name:SetTextColor(r, g, b)

	if data.challenge.completed then
		button.completedLevel:SetFormattedText("%d", data.challenge.completed)
	else
		button.completedLevel:SetText()
	end

	if data.challenge.key then
		button.keyLevel:SetFormattedText("%d", data.challenge.level)
		button.keystone:SetText(data.challenge.key)

		if data.challenge.depleted then
			button.keyIcon:SetVertexColor(1, 0, 0)
			button.keyLevel:SetTextColor(0.5, 0.5, 0.5)
			button.keystone:SetTextColor(0.5, 0.5, 0.5)
		else
			button.keyIcon:SetVertexColor(1, 1, 1)
			button.keyLevel:SetTextColor(0, 1, 0)
			button.keystone:SetTextColor(1, 1, 1)
		end
	else
		button.keyIcon:SetVertexColor(1, 1, 1)
		button.keystone:SetText()
		button.keyLevel:SetText()
	end

	if data.resource then
		button.resource:SetFormattedText("%d", data.resource)
		if data.resource < 500 then
			button.resource:SetTextColor(1, 0, 0)
		else
			button.resource:SetTextColor(1, 1, 1)
		end
	else
		button.resource:SetText()
	end

	if data.research.start then
		local ready, total, remain = addon:GetDataReadyCount(data)
		button.orders:SetFormattedText("%d/%d", ready, total)

		if ready > 0 then
			button.orders:SetTextColor(0, 1, 0)
		else
			button.orders:SetTextColor(1, 1, 1)
		end

		if remain > 0 then
			button.remain:SetFormattedText("%d:%02d:%02d", remain / 3600, (remain % 3600) / 60, remain % 60)
			if remain < 3600 then
				button.remain:SetTextColor(1, 0, 0)
			else
				button.remain:SetTextColor(1, 1, 1)
			end
		else
			button.remain:SetText()
		end
	else
		button.orders:SetText()
		button.remain:SetText()
	end
end

frame:SetScript("OnUpdate", function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed > 1 then
		self.elapsed = 0
		list:UpdateList()
	end
end)

addon:RegisterEventCallback("OnInitialize", function()
	local profile, data
	for profile, data in pairs(addon.db.profiles) do
		list:InsertData(data)
	end
end)

addon:RegisterEventCallback("OnDataUpdate", function(data)
	local index = list:FindData(data)
	if index then
		if addon:IsDataEmpty(data) then
			list:RemoveData(index)
		else
			list:UpdateData(index)
		end
	else
		list:InsertData(data)
	end
end)

function addon:ToggleFrame()
	if frame:IsShown() then
		frame:Hide()
	else
		frame:Show()
	end
end

function addon:OnSlashCmd(commands)
	self:ToggleFrame()
end