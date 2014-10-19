local _G = _G
local ReplaceBags = 0
local LastButtonBag, LastButtonBank, LastButtonReagent
local NUM_CONTAINER_FRAMES = NUM_CONTAINER_FRAMES
local NUM_BAG_FRAMES = NUM_BAG_FRAMES
local ContainerFrame_GetOpenFrame = ContainerFrame_GetOpenFrame
local BankFrame = BankFrame
local ReagentBankFrame = ReagentBankFrame
local BagHelpBox = BagHelpBox
local ButtonSetSize = 36
local ButtonSpacing = 4
local ItemsPerRow = 10
local ItemsPerRowBank = 14
local glow = "Interface\\Addons\\PSUICore\\media\\glow.tga"
local font = STANDARD_TEXT_FONT
local OpenBankFlag = false

local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = function() return end
	object:Hide()
end

local function SetTemplate(f, t)		
	f:SetBackdrop({
	  bgFile = "Interface\\Buttons\\WHITE8x8",
	  edgeFile = glow,
	  tile = false, edgeSize = 3,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
	})
		
	f:SetBackdropColor(0.05, 0.05, 0.05,.66)
	f:SetBackdropBorderColor(0, 0, 0,1)
end

local function SetTemplate2(f, t)		
	f:SetBackdrop({
	  bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	  edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
	  tile = false, edgeSize = 1,
	})
		
	f:SetBackdropColor(.15, 0.15, 0.15, .77)
	f:SetBackdropBorderColor(0, 0, 0)
end


local function CreateBackdrop(f, t)
	if f.backdrop then return end
	if not t then t = "Default" end

	local b = CreateFrame("Frame", nil, f)
	b:SetPoint("TOPLEFT", -1 , 1 )
	b:SetPoint("BOTTOMRIGHT", 1 , -1)
	SetTemplate(b,t)

	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end
	
	f.backdrop = b
end


local function SkinEditBox(frame)
	if _G[frame:GetName().."Left"] then Kill(_G[frame:GetName().."Left"]) end
	if _G[frame:GetName().."Middle"] then Kill(_G[frame:GetName().."Middle"]) end
	if _G[frame:GetName().."Right"] then Kill(_G[frame:GetName().."Right"]) end
	if _G[frame:GetName().."Mid"] then Kill(_G[frame:GetName().."Mid"]) end
	
	if frame:GetName() and frame:GetName():find("Silver") or frame:GetName():find("Copper") then
		frame.backdrop:SetPoint( "BOTTOMRIGHT", -12, -2)
	end
	if(frame.Left) then Kill(frame.Left) end
	if(frame.Right) then Kill(frame.Right) end
	if(frame.Middle) then Kill(frame.Middle) end
end


local function SetInside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or 1
	yOffset = yOffset or 1
	anchor = anchor or obj:GetParent()

	if obj:GetPoint() then obj:ClearAllPoints() end
	
	obj:SetPoint("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
	obj:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", -xOffset, yOffset)
end
local function StyleButton(button) 
	if button.SetHighlightTexture and not button.hover then
		local hover = button:CreateTexture("frame", nil, self)
		hover:SetTexture(1, 1, 1, 0.2)
		SetInside(hover)
		button.hover = hover
		button:SetHighlightTexture(hover)
	end

	if button.SetPushedTexture and not button.pushed then
		local pushed = button:CreateTexture("frame", nil, self)
		pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
		SetInside(pushed)
		button.pushed = pushed
		button:SetPushedTexture(pushed)
	end

	if button.SetCheckedTexture and not button.checked then
		local checked = button:CreateTexture("frame", nil, self)
		checked:SetTexture(0,1,0,.3)
		SetInside(checked)
		button.checked = checked
		button:SetCheckedTexture(checked)
	end

	local cooldown = button:GetName() and _G[button:GetName().."Cooldown"]
	if cooldown then
		cooldown:ClearAllPoints()
		SetInside(cooldown)
	end
end
local function FontString(parent, name, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
--	fs:SetShadowColor(0, 0, 0)
--	fs:SetShadowOffset(4, -4)
	
	if not name then
		parent.text = fs
	else
		parent[name] = fs
	end
	
	return fs
end


-- Skinning
local function SetModifiedBackdrop(self)
	
	local Class = select(2, UnitClass("player"))
	local color = RAID_CLASS_COLORS[Class]
	--self:SetBackdropColor(color.r * .15, color.g * .15, color.b * .15)
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

local function SetOriginalBackdrop(self) self:SetBackdropBorderColor(0, 0, 0, 1) end

local function SkinButton(f, strip)
	if f:GetName() then
		local l = _G[f:GetName().."Left"]
		local m = _G[f:GetName().."Middle"]
		local r = _G[f:GetName().."Right"]

		if l then l:SetAlpha(0) end
		if m then m:SetAlpha(0) end
		if r then r:SetAlpha(0) end
	end

	if f.Left then f.Left:SetAlpha(0) end
	if f.Right then f.Right:SetAlpha(0) end	
	if f.Middle then f.Middle:SetAlpha(0) end
	if f.SetNormalTexture then f:SetNormalTexture("") end
	if f.SetHighlightTexture then f:SetHighlightTexture("") end
	if f.SetPushedTexture then f:SetPushedTexture("") end
	if f.SetDisabledTexture then f:SetDisabledTexture("") end
	if strip then StripTextures(f) end
	
	SetTemplate(f, "Default")
	f:HookScript("OnEnter", SetModifiedBackdrop)
	f:HookScript("OnLeave", SetOriginalBackdrop)
end

local function SkinButton2(f, strip)
	if f:GetName() then
		local l = _G[f:GetName().."Left"]
		local m = _G[f:GetName().."Middle"]
		local r = _G[f:GetName().."Right"]

		if l then l:SetAlpha(0) end
		if m then m:SetAlpha(0) end
		if r then r:SetAlpha(0) end
	end

	if f.Left then f.Left:SetAlpha(0) end
	if f.Right then f.Right:SetAlpha(0) end	
	if f.Middle then f.Middle:SetAlpha(0) end
	if f.SetNormalTexture then f:SetNormalTexture("") end
	if f.SetHighlightTexture then f:SetHighlightTexture("") end
	if f.SetPushedTexture then f:SetPushedTexture("") end
	if f.SetDisabledTexture then f:SetDisabledTexture("") end
	if strip then StripTextures(f) end
	
	SetTemplate2(f, "Default")
	f:HookScript("OnEnter", SetModifiedBackdrop)
	f:HookScript("OnLeave", SetOriginalBackdrop)
end



local function StripTextures(object, kill)
	for i=1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region:GetObjectType() == "Texture" then
			if kill then Kill(region) else region:SetTexture(nil) end
		end
	end
end



local Boxes = {
	BagItemSearchBox,
	BankItemSearchBox,
}

local BlizzardBags = {
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
}

local BlizzardBank = {
	BankFrameBag1,
	BankFrameBag2,
	BankFrameBag3,
	BankFrameBag4,
	BankFrameBag5,
	BankFrameBag6,
	BankFrameBag7,
}

function SkinBagButton(Button)
	if Button.IsSkinned then return end

	local Icon = _G[Button:GetName()  ..  "IconTexture"]
	local Quest = _G[Button:GetName()  ..  "IconQuestTexture"]
	local JunkIcon = Button.JunkIcon
	local border = Button.IconBorder
	local BattlePay = Button.BattlepayItemTexture

	border:SetAlpha(0)
	Icon:SetTexCoord(.08, .92, .08, .92)
	SetInside(Icon,Button)
	if Quest then Quest:SetAlpha(0) end
	if JunkIcon then JunkIcon:SetAlpha(0) end
	if BattlePay then BattlePay:SetAlpha(0) end

	Button:SetNormalTexture("")
	Button:SetPushedTexture("")
	SkinButton2(Button)
	StyleButton(Button)
	
	Button.IsSkinned = true
end

function HideBlizzard()
	local TokenFrame = _G["BackpackTokenFrame"]
	local Inset = _G["BankFrameMoneyFrameInset"]
	local Border = _G["BankFrameMoneyFrameBorder"]
	local BankClose = _G["BankFrameCloseButton"]
	local BankPortraitTexture = _G["BankPortraitTexture"]
	local BankSlotsFrame = _G["BankSlotsFrame"]

	TokenFrame:GetRegions():SetAlpha(0)
	Inset:Hide()
	Border:Hide()
	BankClose:Hide()
	BankPortraitTexture:Hide()
	Kill(BagHelpBox)
	--BankFrame:SetAlpha(0) --卧槽！！！

	for i = 1, 12 do
		local CloseButton = _G["ContainerFrame" .. i .. "CloseButton"]
		CloseButton:Hide()
		for k = 1, 7 do
			local Container = _G["ContainerFrame" .. i]
			select(k, Container:GetRegions()):SetAlpha(0)
		end
	end

	for i = 1, BankFrame:GetNumRegions() do
		local Region = select(i, BankFrame:GetRegions())
		Region:SetAlpha(0)
	end

	for i = 1, BankSlotsFrame:GetNumRegions() do
		local Region = select(i, BankSlotsFrame:GetRegions())
		Region:SetAlpha(0)
	end

	for i = 1, 2 do
		local Tab = _G["BankFrameTab" .. i]
		Tab:Hide()
	end
end

function CreateReagentContainer()
	StripTextures(ReagentBankFrame)

	local Reagent = CreateFrame("Frame", "DuffedUI_Reagent", UIParent)
	local SwitchBankButton = CreateFrame("Button", nil, Reagent)
	local SortButton = CreateFrame("Button", nil, Reagent)
	local NumButtons = ReagentBankFrame.size
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ReagentBankFrameItem1, 1, ReagentBankFrameItem1
	local Deposit = ReagentBankFrame.DespositButton

	Reagent:SetWidth(((ButtonSetSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	Reagent:SetPoint("BOTTOMRIGHT", _G["DuffedUI_Bag"], "BOTTOMLEFT", 0, 0)
	SetTemplate(Reagent)
	Reagent:SetFrameStrata(_G["DuffedUI_Bank"]:GetFrameStrata())
	Reagent:SetFrameLevel(_G["DuffedUI_Bank"]:GetFrameLevel())

	SwitchBankButton:SetSize(72, 22)
	SkinButton(SwitchBankButton)
	SwitchBankButton:SetPoint("BOTTOMLEFT", Reagent, "BOTTOMLEFT", 10, 7)
	FontString(SwitchBankButton,"Text", STANDARD_TEXT_FONT , 13, "THINOUTLINE")
	SwitchBankButton.Text:SetPoint("CENTER")
	SwitchBankButton.Text:SetText(BANK)
	SwitchBankButton:SetScript("OnClick", function()
		Reagent:Hide()
		_G["DuffedUI_Bank"]:Show()
		BankFrame_ShowPanel(BANK_PANELS[1].name)
		for i = 5, 11 do
			if (not IsBagOpen(i)) then OpenBag(i) end
		end
		OpenBankFlag = fasle
		--_G["DuffedUI_Reagent"]:Hide()
	end)

	Deposit:SetParent(Reagent)
	Deposit:ClearAllPoints()
	Deposit:SetSize(120, 23)
	Deposit:SetPoint("BOTTOM", Reagent, "BOTTOM", 0, 7)
	SkinButton(Deposit)

	SortButton:SetSize(72, 22)
	SortButton:SetPoint("BOTTOMRIGHT", Reagent, "BOTTOMRIGHT", -10, 7)
	SkinButton(SortButton)
	FontString(SortButton,"Text", STANDARD_TEXT_FONT, 13,"THINOUTLINE")
	SortButton.Text:SetPoint("CENTER")
	SortButton.Text:SetText("整理")
	SortButton:SetScript("OnClick", BankFrame_AutoSortButtonOnClick)	

	for i = 1, 98 do
		local Button = _G["ReagentBankFrameItem" .. i]
		local Icon = _G[Button:GetName() .. "IconTexture"]

		ReagentBankFrame:SetParent(Reagent)
		ReagentBankFrame:ClearAllPoints()
		ReagentBankFrame:SetAllPoints()

		Button:ClearAllPoints()
		Button:SetSize(ButtonSetSize, ButtonSetSize)
		Button:SetNormalTexture("")
		Button:SetPushedTexture("")
		Button:SetHighlightTexture("")
		Button.IconBorder:SetAlpha(0)
		SkinButton2(Button)
		StyleButton(Button)

		if (i == 1) then
			Button:SetPoint("TOPLEFT", Reagent, "TOPLEFT", 10, -10)
			LastRowButton = Button
			LastButton = Button
		elseif (NumButtons == ItemsPerRow) then
			Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSetSize))
			Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSetSize))
			LastRowButton = Button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing + ButtonSetSize), 0)
			Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing + ButtonSetSize), 0)
			NumButtons = NumButtons + 1
		end
		Icon:SetTexCoord(.08, .92, .08, .92)
		SetInside(Icon)
		LastButton = Button
	end
	Reagent:SetHeight(((ButtonSetSize + ButtonSpacing) * (NumRows + 1) + 50) - ButtonSpacing)

	local Unlock = ReagentBankFrameUnlockInfo
	local UnlockButton = ReagentBankFrameUnlockInfoPurchaseButton
	StripTextures(Unlock)
	Unlock:ClearAllPoints()
	Unlock:SetAllPoints(Reagent)
	SetTemplate(Unlock)
	Unlock:SetBackdropColor(0, 0, 0,0)
	SkinButton(UnlockButton)
end

function CreateContainer(storagetype, ...)
	local Container = CreateFrame("Frame", "DuffedUI_" .. storagetype, UIParent)
	Container:SetScale(1)
	Container:SetPoint(...)
	Container:SetFrameStrata("HIGH")
	Container:SetFrameLevel(1)
	Container:Hide()
	Container:EnableMouse(true)
	SetTemplate(Container)

	if (storagetype == "Bag") then
		Container:SetWidth(((ButtonSetSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
		Container:SetMovable(true)
		Container:SetClampedToScreen(true)
		Container:SetScript("OnMouseDown", function() Container:ClearAllPoints() Container:StartMoving() end)
		Container:SetScript("OnMouseUp", function() Container:StopMovingOrSizing() end)
	
		local Sort = BagItemAutoSortButton
		local SortButton = CreateFrame("Button", nil, Container)
		local BagsContainer = CreateFrame("Frame", nil, UIParent)
		local ToggleBagsContainer = CreateFrame("Frame")

		BagsContainer:SetParent(Container)
		BagsContainer:SetWidth(10)
		BagsContainer:SetHeight(10)
		BagsContainer:SetPoint("BOTTOMRIGHT", Container, "TOPRIGHT", 0, 3)
		BagsContainer:Hide()
		SetTemplate(BagsContainer)

		SortButton:SetSize(72, 22)
		SortButton:ClearAllPoints()
		SortButton:SetPoint("BOTTOMRIGHT", Container, "BOTTOMRIGHT", -10, 7)
		SortButton:SetFrameLevel(Container:GetFrameLevel() + 1)
		SortButton:SetFrameStrata(Container:GetFrameStrata())
		StripTextures(SortButton)
		SkinButton(SortButton)
		SortButton:SetScript('OnMouseDown', function(self, button) 
		if InCombatLockdown() then return end
		if button == "RightButton" then JPack:Pack(nil, 2) else JPack:Pack(nil, 1) end
		end)
		FontString(SortButton,"Text", STANDARD_TEXT_FONT, 13, "THINOUTLINE")
		SortButton.Text:SetPoint("CENTER")
		SortButton.Text:SetText("整理")
		SortButton.ClearAllPoints = function() return end

		ToggleBagsContainer:SetHeight(18)
		ToggleBagsContainer:SetWidth(24)
		SkinButton(ToggleBagsContainer)
		ToggleBagsContainer:SetPoint("BOTTOMLEFT", Container, "BOTTOMLEFT", 10, 8)
		ToggleBagsContainer:SetParent(Container)
		ToggleBagsContainer.Text = ToggleBagsContainer:CreateFontString("button")
		ToggleBagsContainer.Text:SetPoint("CENTER", ToggleBagsContainer, "CENTER")
		ToggleBagsContainer.Text:SetFont(STANDARD_TEXT_FONT, 12)
		ToggleBagsContainer.Text:SetText("X")
		ToggleBagsContainer.Text:SetTextColor(1, 1, 1)
		ToggleBagsContainer:SetScript("OnMouseUp", function(self, button)
			local Purchase = BankFramePurchaseInfo
			if (button == "RightButton") then
				local BanksContainer = _G["DuffedUI_Bank"].BagsContainer
				local Purchase = BankFramePurchaseInfo
				local ReagentButton = _G["DuffedUI_Bank"].ReagentButton
				if (ReplaceBags == 0) then
					ReplaceBags = 1
					BagsContainer:Show()
					BanksContainer:Show()
					BanksContainer:ClearAllPoints()
					ToggleBagsContainer.Text:SetTextColor(1, 1, 1)
					if Purchase:IsShown() then
						BanksContainer:SetPoint("BOTTOMLEFT", Purchase, "TOPLEFT", 0, 2)
					else
						BanksContainer:SetPoint("BOTTOMLEFT", ReagentButton, "TOPLEFT", 0, 2)
					end
				else
					ReplaceBags = 0
					BagsContainer:Hide()
					BanksContainer:Hide()
					ToggleBagsContainer.Text:SetTextColor(1, 1, 1)
				end
			else
				if BankFrame:IsShown() then
					CloseBankFrame()
				end
				for i = 0, 4 do CloseBag(i) end
			end
		end)

		for _, Button in pairs(BlizzardBags) do
			local Icon = _G[Button:GetName() .. "IconTexture"]

			Button:SetParent(BagsContainer)
			Button:ClearAllPoints()
			Button:SetWidth(ButtonSetSize)
			Button:SetHeight(ButtonSetSize)
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)
			Button:SetNormalTexture("")
			Button:SetPushedTexture("")
			Button:SetCheckedTexture("")
			SetTemplate(Button)
			Button.IconBorder:SetAlpha(0)
			SkinButton(Button)
			if LastButtonBag then Button:SetPoint("LEFT", LastButtonBag, "RIGHT", 4, 0) else Button:SetPoint("TOPLEFT", BagsContainer, "TOPLEFT", 4, -4) end

			Icon:SetTexCoord(.08, .92, .08, .92)
			SetInside(Icon)
			LastButtonBag = Button
			BagsContainer:SetWidth((ButtonSetSize * getn(BlizzardBags)) + (ButtonSpacing * (getn(BlizzardBags) + 1)))
			BagsContainer:SetHeight(ButtonSetSize + (ButtonSpacing * 2))
		end
		
		Container.BagsContainer = BagsContainer
		Container.CloseButton = ToggleBagsContainer
		Container.SortButton = Sort
	else
		Container:SetWidth(((ButtonSetSize + ButtonSpacing) * ItemsPerRowBank) + 22 - ButtonSpacing)

		local PurchaseButton = BankFramePurchaseButton
		local CostText = BankFrameSlotCost
		local TotalCost = BankFrameDetailMoneyFrame
		local Purchase = BankFramePurchaseInfo
		local SortButton = CreateFrame("Button", nil, Container)
		local BankBagsContainer = CreateFrame("Frame", nil, Container)

		CostText:ClearAllPoints()
		CostText:SetPoint("BOTTOMLEFT", 60, 10)
		TotalCost:ClearAllPoints()
		TotalCost:SetPoint("LEFT", CostText, "RIGHT", 0, 0)
		PurchaseButton:ClearAllPoints()
		PurchaseButton:SetPoint("BOTTOMRIGHT", -10, 10)
		SkinButton(PurchaseButton)
		BankItemAutoSortButton:Hide()

		local SwitchReagentButton = CreateFrame("Button", nil, Container)
		SwitchReagentButton:SetSize(72, 22)
		SkinButton(SwitchReagentButton)
		SwitchReagentButton:SetPoint("BOTTOMLEFT", Container, "BOTTOMLEFT", 10, 7)
		FontString(SwitchReagentButton,"Text", STANDARD_TEXT_FONT , 13, "THINOUTLINE")
		SwitchReagentButton.Text:SetPoint("CENTER")
		SwitchReagentButton.Text:SetText(REAGENT_BANK)
		SwitchReagentButton:SetScript("OnClick", function()
			BankFrame_ShowPanel(BANK_PANELS[2].name)
			if (not ReagentBankFrame.isMade) then
				CreateReagentContainer()
				ReagentBankFrame.isMade = true
			else
				_G["DuffedUI_Reagent"]:Show()
			end
			for i = 5, 11 do CloseBag(i) end
			--_G["DuffedUI_Bank"]:Hide()
		end)

		SortButton:SetSize(72, 22)
		SortButton:SetPoint("BOTTOMRIGHT", Container, "BOTTOMRIGHT", -10, 7)
		SkinButton(SortButton)
		FontString(SortButton,"Text", STANDARD_TEXT_FONT, 13, "THINOUTLINE")
		SortButton.Text:SetPoint("CENTER")
		SortButton.Text:SetText("整理")
--		SortButton:SetScript("OnClick", BankFrame_AutoSortButtonOnClick)
		SortButton:SetScript('OnMouseDown', function(self, button) 
		if InCombatLockdown() then return end
		if button == "RightButton" then JPack:Pack(nil, 2) else JPack:Pack(nil, 1) end
		end)

		Purchase:ClearAllPoints()
		Purchase:SetWidth(Container:GetWidth() + 50)
		Purchase:SetHeight(80)
		Purchase:SetWidth(_G["DuffedUI_Bank"]:GetWidth())
		Purchase:SetPoint("BOTTOM", _G["DuffedUI_Bank"], "TOP", 0, 5)
		SetTemplate(Purchase)
		
		BankBagsContainer:SetSize(Container:GetWidth(), BankSlotsFrame.Bag1:GetHeight() + ButtonSpacing + ButtonSpacing)
		SetTemplate(BankBagsContainer)
		BankBagsContainer:SetPoint("BOTTOMLEFT", SwitchReagentButton, "TOPLEFT", 0, 2)
		BankBagsContainer:SetFrameLevel(Container:GetFrameLevel())
		BankBagsContainer:SetFrameStrata(Container:GetFrameStrata())

		for i = 1, 7 do
			local Bag = BankSlotsFrame["Bag" .. i]
			Bag:SetParent(BankBagsContainer)
			Bag:SetWidth(ButtonSetSize)
			Bag:SetHeight(ButtonSetSize)
			Bag.IconBorder:SetAlpha(0)
			Bag.icon:SetTexCoord(.08, .92, .08, .92)
			SetInside(Bag.icon)
			SkinButton(Bag)
			Bag:ClearAllPoints()
			if i == 1 then Bag:SetPoint("TOPLEFT", BankBagsContainer, "TOPLEFT", ButtonSpacing, -ButtonSpacing) else Bag:SetPoint("LEFT", BankSlotsFrame["Bag" .. i-1], "RIGHT", ButtonSpacing, 0) end
		end

		BankBagsContainer:SetWidth((ButtonSetSize * 7) + (ButtonSpacing * (7 + 1)))
		BankBagsContainer:SetHeight(ButtonSetSize + (ButtonSpacing * 2))
		BankBagsContainer:Hide()

		BankFrame:EnableMouse(false)

		_G["DuffedUI_Bank"].BagsContainer = BankBagsContainer
		_G["DuffedUI_Bank"].ReagentButton = SwitchReagentButton
		Container.SortButton = SortButton
	end
end

function SetBagsSearchPosition()
	local BagItemSearchBox = BagItemSearchBox
	local BankItemSearchBox = BankItemSearchBox
	
	BagItemSearchBox:SetParent(_G["DuffedUI_Bag"])
	BagItemSearchBox:SetWidth(_G["DuffedUI_Bag"]:GetWidth() - ContainerFrame1MoneyFrame:GetWidth() -140)
	BagItemSearchBox:SetFrameLevel(_G["DuffedUI_Bag"]:GetFrameLevel() + 2)
	BagItemSearchBox:SetFrameStrata(_G["DuffedUI_Bag"]:GetFrameStrata())
	BagItemSearchBox:ClearAllPoints()
	BagItemSearchBox:SetPoint("BOTTOMRIGHT", _G["DuffedUI_Bag"], "BOTTOMRIGHT", -90, 9)
	StripTextures(BagItemSearchBox)
	SetTemplate2(BagItemSearchBox)
	BagItemSearchBox:SetBackdropColor(0, 0, 0, 0.3)
	
	BagItemSearchBox:SetText("")
	BagItemSearchBox.SetParent = function() return end
	BagItemSearchBox.ClearAllPoints = function() return end
	BagItemSearchBox.SetPoint = function() return end

	BankItemSearchBox:Hide()
end

function SkinEditBoxes()
	for _, Frame in pairs(Boxes) do
		SkinEditBox(Frame)
--		StripTextures(Frame.backdrop)
	end
end

function SlotUpdate(id, button)
	local ItemLink = GetContainerItemLink(id, button:GetID())
	local Texture, Count, Lock = GetContainerItemInfo(id, button:GetID())
	local IsQuestItem, QuestId, IsActive = GetContainerItemQuestInfo(id, button:GetID())
	local IsNewItem = C_NewItems.IsNewItem(id, button:GetID())
	local IsBattlePayItem = IsBattlePayItem(id, button:GetID())
	local NewItem = button.NewItemTexture

	if Texture then
		-- update cooldown code here
	end

	if IsNewItem then
		NewItem:SetAlpha(0)
		if not button.Animation then
			button.Animation = button:CreateAnimationGroup()
			button.Animation:SetLooping("BOUNCE")
			button.FadeOut = button.Animation:CreateAnimation("Alpha")
			button.FadeOut:SetChange(1)
			button.FadeOut:SetDuration(1)
			button.FadeOut:SetSmoothing("IN_OUT")
		end
		button.Animation:Play()
	else
		if button.Animation and button.Animation:IsPlaying() then button.Animation:Stop() end
	end

	if IsQuestItem then
		button:SetBackdropBorderColor(1, 1, 0)
		return
	end

	if ItemLink then
		local Name, _, Rarity, _, _, Type = GetItemInfo(ItemLink)
		if not Lock and Rarity and Rarity > 1 then  button:SetBackdropBorderColor(GetItemQualityColor(Rarity)) else button:SetBackdropBorderColor(0, 0, 0,.9) end
	else
		button:SetBackdropBorderColor(0, 0, 0,.9)
	end
end

function BagUpdate(id)
	local SetSize = GetContainerNumSlots(id)
	for Slot = 1, SetSize do
		local Button = _G["ContainerFrame" .. (id + 1) .. "Item" .. Slot]
		SlotUpdate(id, Button)
	end
end

function UpdateAllBags()
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
	for Bag = 1, 5 do
		local ID = Bag - 1
		local Slots = GetContainerNumSlots(ID)
		for Item = Slots, 1, -1 do
			local Button = _G["ContainerFrame"  ..  Bag  ..  "Item"  ..  Item]
			local Money = ContainerFrame1MoneyFrame

			Button:ClearAllPoints()
			Button:SetSize(ButtonSetSize, ButtonSetSize)
			Button:SetScale(1)
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)

			Money:ClearAllPoints()
			Money:Show()
			Money:SetPoint("BOTTOMLEFT",DuffedUI_Bag,"BOTTOMLEFT", 42, 8)
			Money:SetFrameStrata("HIGH")
			Money:SetFrameLevel(2)
			Money:SetScale(1)
			if (Bag == 1 and Item == 16) then
				Button:SetPoint("TOPLEFT", _G["DuffedUI_Bag"], "TOPLEFT", 10, -10)
				LastRowButton = Button
				LastButton = Button
			elseif (NumButtons == ItemsPerRow) then
				Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSetSize))
				Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSetSize))
				LastRowButton = Button
				NumRows = NumRows + 1
				NumButtons = 1
			else
				Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing + ButtonSetSize), 0)
				Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing + ButtonSetSize), 0)
				NumButtons = NumButtons + 1
			end
			SkinBagButton(Button)
			LastButton = Button
		end
		BagUpdate(ID)
	end
	_G["DuffedUI_Bag"]:SetHeight(((ButtonSetSize + ButtonSpacing) * (NumRows + 1) + 50) - ButtonSpacing)
end

function UpdateAllBankBags()
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
	for Bank = 1, 28 do
		local Button = _G["BankFrameItem" .. Bank]
		local Money = ContainerFrame2MoneyFrame
		local BankFrameMoneyFrame = BankFrameMoneyFrame

		Button:ClearAllPoints()
		Button:SetSize(ButtonSetSize, ButtonSetSize)
		Button:SetFrameStrata("HIGH")
		Button:SetFrameLevel(2)
		Button:SetScale(1)
		Button.IconBorder:SetAlpha(0)
		
		BankFrameMoneyFrame:Hide()
		if (Bank == 1) then
			Button:SetPoint("TOPLEFT", _G["DuffedUI_Bank"], "TOPLEFT", 10, -10)
			LastRowButton = Button
			LastButton = Button
		elseif (NumButtons == ItemsPerRowBank) then
			Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSetSize))
			Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSetSize))
			LastRowButton = Button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing + ButtonSetSize), 0)
			Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing + ButtonSetSize), 0)
			NumButtons = NumButtons + 1
		end
		SkinBagButton(Button)
		SlotUpdate(-1, Button)
		LastButton = Button
	end

	for Bag = 6, 12 do
		local Slots = GetContainerNumSlots(Bag - 1)
		for Item = Slots, 1, -1 do
			local Button = _G["ContainerFrame"  ..  Bag  ..  "Item" .. Item]
			Button:ClearAllPoints()
			Button:SetWidth(ButtonSetSize, ButtonSetSize)
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)
			Button:SetScale(1)
			Button.IconBorder:SetAlpha(0)
			if (NumButtons == ItemsPerRowBank) then
				Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSetSize))
				Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSetSize))
				LastRowButton = Button
				NumRows = NumRows + 1
				NumButtons = 1
			else
				Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing+ButtonSetSize), 0)
				Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing+ButtonSetSize), 0)
				NumButtons = NumButtons + 1
			end
			SkinBagButton(Button)
			SlotUpdate(Bag - 1, Button)
			LastButton = Button
		end
	end
	_G["DuffedUI_Bank"]:SetHeight(((ButtonSetSize + ButtonSpacing) * (NumRows + 1) + 50) - ButtonSpacing)
end


ContainerFrame1Item1:SetScript("OnHide", function()
	if _G["DuffedUI_Reagent"] and _G["DuffedUI_Reagent"]:IsShown() then
		_G["DuffedUI_Reagent"]:Hide()
	end
	_G["DuffedUI_Bag"]:Hide()	
end)


BankFrameItem1:SetScript("OnHide", function() 
	_G["DuffedUI_Bank"]:Hide() 		
	for i = 5, 11 do CloseBag(i) end
end)

BankFrameItem1:SetScript("OnShow", function() 
	OpenBankFlag = true
	_G["DuffedUI_Bank"]:Show() 	
	_G["DuffedUI_Bag"]:Show() 		
	for i = 0, 11 do
		if not IsBagOpen(i) then OpenBag(i, 1) end
	end 
end)

CreateContainer("Bag", "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -80, 200) 
--CreateContainer("Bank", "BOTTOMRIGHT", UIParent, "BOTTOMLEFT", 0, 0)
CreateContainer("Bank", "BOTTOMRIGHT", DuffedUI_Bag, "BOTTOMLEFT", 0, 0)

HideBlizzard()
SetBagsSearchPosition()
--SkinEditBoxes()

function OpenBag(id)
	if (not CanOpenPanels()) then
		if (UnitIsDead("player")) then NotWhileDeadError() end
		return
	end

	local SetSize = GetContainerNumSlots(id)
	local OpenFrame = ContainerFrame_GetOpenFrame()

	if OpenFrame.size and OpenFrame.size ~= SetSize then
		for i = 1, OpenFrame.size do
			local Button = _G[OpenFrame:GetName() .. "Item" .. i]
			Button:Hide()
		end
	end

	for i = 1, SetSize, 1 do
		local Index = SetSize - i + 1
		local Button = _G[OpenFrame:GetName() .. "Item" .. i]
		Button:SetID(Index)
		Button:Show()
	end
	OpenFrame.size = SetSize
	OpenFrame:SetID(id)
	OpenFrame:Show()

	if (id == 4) then UpdateAllBags() elseif (id == 11) then UpdateAllBankBags() end
end


function ToggleAllBags()
	if OpenBankFlag then OpenBankFlag = false return end
	
	if IsBagOpen(0) then
		if BankFrame:IsShown() then
			CloseBankFrame()
		end
		for i = 0, 4 do CloseBag(i) end
	else
		_G["DuffedUI_Bag"]:Show()
		OpenBag(0, 1)
		for i = 1, 4 do OpenBag(i, 1) end
	end
end

function UpdateContainerFrameAnchors() end
function ToggleBag() ToggleAllBags() end
function ToggleBackpack() ToggleAllBags() end
function OpenAllBags() ToggleAllBags() end
function OpenBackpack() ToggleAllBags() end


local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("BAG_UPDATE")
EventFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
EventFrame:RegisterEvent("BAG_UPDATE_COOLDOWN")
EventFrame:RegisterEvent("ITEM_LOCK_CHANGED")
EventFrame:RegisterEvent("BANKFRAME_OPENED")
EventFrame:RegisterEvent("BANKFRAME_CLOSED")
EventFrame:RegisterEvent("BAG_CLOSED")
EventFrame:RegisterEvent("REAGENTBANK_UPDATE")
EventFrame:RegisterEvent("BANK_BAG_SLOT_FLAGS_UPDATED")
EventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "BAG_UPDATE" then
		BagUpdate(...)
	elseif event == "PLAYERBANKSLOTS_CHANGED" then
		local ID = ...
		if ID <= 28 then
			local Button = _G["BankFrameItem" .. ID]
			SlotUpdate(-1, Button)
		end
	elseif event == "BANKFRAME_CLOSED" then
		if _G["DuffedUI_Reagent"] and _G["DuffedUI_Reagent"]:IsShown() then
			_G["DuffedUI_Reagent"]:Hide()
		end
	end
end)