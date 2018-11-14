local itemFrame = CreateFrame('Frame', 'EasyScrapItemFrame', EasyScrapMainFrame)
itemFrame:SetPoint('TOPLEFT', 12, -50)
--itemFrame:SetPoint('BOTTOMRIGHT', -32, 42)
itemFrame:SetSize(273, 172)
itemFrame:SetBackdrop({
    -- bgFile="Interface\\FrameGeneral\\UI-Background-Marble", 
    edgeFile='Interface/Tooltips/UI-Tooltip-Border', 
    tile = false, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }})
itemFrame:SetBackdropBorderColor(.9, .9, .9, 1)
itemFrame.contentState = 2
itemFrame.maxTabWidth = 300
itemFrame.timeElapsed = 0
--[[
itemFrame.bg = itemFrame:CreateTexture(nil, 'BACKGROUND')
itemFrame.bg:SetPoint('TOPLEFT', 4, -4)
itemFrame.bg:SetPoint('BOTTOMRIGHT', -4, 4)
itemFrame.bg:SetColorTexture(0, 0, 0, 1)
--]]
--[[
Scrollframe/ScrollBar
"UIPanelScrollFrameTemplate"
--]]
itemFrame:SetScript('OnUpdate', function(self, dt)
    self.timeElapsed = self.timeElapsed + dt
    if self.timeElapsed > 0.25 then
        self.timeElapsed = 0
        if EasyScrap.mouseInItem and IsModifiedClick("COMPAREITEMS") then
            GameTooltip_ShowCompareItem(GameTooltip)
        elseif EasyScrap.mouseInItem and not IsModifiedClick("COMPAREITEMS") then
            GameTooltip_HideShoppingTooltips(GameTooltip)
        end
    end
end)

itemFrame.scrollFrame = CreateFrame('ScrollFrame', nil, itemFrame, "UIPanelScrollFrameTemplate")
itemFrame.scrollFrame:SetPoint('TOPLEFT', 0, -4)
itemFrame.scrollFrame:SetPoint('BOTTOMRIGHT', 0, 4)
itemFrame.scrollFrame:SetClipsChildren(false)
itemFrame.scrollFrame:SetScript('OnScrollRangeChanged', ScrollFrame_OnScrollRangeChanged_EasyScrap)


itemFrame.scrollFrame.ScrollBar.scrollStep = 25

itemFrame.scrollFrame.ScrollBar.t = itemFrame.scrollFrame.ScrollBar:CreateTexture(nil, 'BACKGROUND')
itemFrame.scrollFrame.ScrollBar.t:SetAllPoints()
itemFrame.scrollFrame.ScrollBar.t:SetColorTexture(0, 0, 0, 0.6)


--[[
Frame that holds the item buttons
--]]
itemFrame.contentFrame = CreateFrame('Frame', 'EasyScrapItemFrameContent', itemFrame.scrollFrame)
itemFrame.contentFrame:SetFrameLevel(9)
itemFrame.contentFrame:SetWidth(itemFrame:GetWidth())
itemFrame.contentFrame:SetHeight(itemFrame:GetHeight())
--print(itemFrame:GetHeight())

itemFrame.contentFrame.bg = itemFrame.contentFrame:CreateTexture(nil, 'BACKGROUND')
--itemFrame.contentFrame.bg:SetPoint('TOPLEFT', 4, -4)
--itemFrame.contentFrame.bg:SetPoint('BOTTOMRIGHT', -4, 4)
itemFrame.contentFrame.bg:SetPoint('TOP')
itemFrame.contentFrame.bg:SetSize(itemFrame.contentFrame:GetWidth()-8, 1024)

itemFrame.contentFrame.bg:SetColorTexture(0, 0, 0, 1)

itemFrame.scrollFrame:SetScrollChild(itemFrame.contentFrame)

--[[
Frame tab buttons
button:SetPoint('BOTTOMLEFT', 0+((i-1)*90), -30) --64
--]]
itemFrame.tabButtons = {}
local tabText = {'队列 (%d)', '可选 (%d)', '隐藏 (%d)'}

for i = 1, 3 do
    local button = CreateFrame('Button', 'EasyScrapItemFrameTabButton'..i, itemFrame, 'EasyScrapFrameTabButtonTemplate')
    
    if i > 1 then
        button:SetPoint('LEFT', itemFrame.tabButtons[i-1], 'RIGHT', -18, 0)
    else
        button:SetPoint('BOTTOMLEFT', -1, -30) 
    end
    button:SetText(tabText[i])
    button.state = i
    PanelTemplates_DeselectTab(button)

    button:SetScript('OnClick', function()
        EasyScrapItemFrame.switchContentState(i)
    end)
    
    function button:SetCount(count)
        if self.state == 1 then
            if count > 0 then
                AutoCastShine_AutoCastStart(itemFrame.tabButtons[1].shineFrame)
            else
                AutoCastShine_AutoCastStop(itemFrame.tabButtons[1].shineFrame)
            end
        end
        self:SetText(string.format(tabText[i], count))
    end
    
    itemFrame.tabButtons[i] = button
end

ignoreItemFrame = CreateFrame('Frame', nil, itemFrame)
ignoreItemFrame:SetFrameLevel(itemFrame.contentFrame:GetFrameLevel()+1)
ignoreItemFrame:SetAllPoints()

ignoreItemFrame.bg = ignoreItemFrame:CreateTexture(nil, 'BACKGROUND')
ignoreItemFrame.bg:SetPoint('TOPLEFT', 4, -4)
ignoreItemFrame.bg:SetPoint('BOTTOMRIGHT', -4, 4)
ignoreItemFrame.bg:SetColorTexture(0, 0, 0, 1)

ignoreItemFrame.headerText = ignoreItemFrame:CreateFontString()
ignoreItemFrame.headerText:SetFontObject("GameFontNormalLarge")
ignoreItemFrame.headerText:SetText('添加装备到忽略列表?')
ignoreItemFrame.headerText:SetPoint('TOP', 0, -14)

ignoreItemFrame.itemName = ignoreItemFrame:CreateFontString()
ignoreItemFrame.itemName:SetFontObject("GameFontNormal")
ignoreItemFrame.itemName:SetText('A Test Item')
ignoreItemFrame.itemName:SetPoint('TOP', ignoreItemFrame.headerText, 'BOTTOM', 0, -8)


ignoreItemFrame.itemButton = CreateFrame('Button', 'EasyScrapIgnoreItemButton', ignoreItemFrame, "EasyScrapItemButtonTemplate")
--ignoreItemFrame.itemButton:SetPoint('TOP', ignoreItemFrame.itemName, 'BOTTOM', 0, -8)
ignoreItemFrame.itemButton:SetPoint('LEFT', 16, -6)
ignoreItemFrame.itemButton:SetScale(1.4, 1.4)


ignoreItemFrame.ignoreItemText = ignoreItemFrame:CreateFontString()
ignoreItemFrame.ignoreItemText:SetFontObject("GameFontNormalSmall")
ignoreItemFrame.ignoreItemText:SetText('忽略此装备将阻止它显示在符合条件的选项卡中.如果装备被修改,您将不得不再次忽略它.')
ignoreItemFrame.ignoreItemText:SetTextColor(1, 1, 1, 1)
ignoreItemFrame.ignoreItemText:SetWidth(180)
ignoreItemFrame.ignoreItemText:SetPoint('LEFT', ignoreItemFrame.itemButton, 'RIGHT', 8, 0)

ignoreItemFrame.okayButton = CreateFrame('Button', nil, ignoreItemFrame, 'GameMenuButtonTemplate')
ignoreItemFrame.okayButton:SetText('确定')
ignoreItemFrame.okayButton:SetWidth(96)
ignoreItemFrame.okayButton:SetPoint('BOTTOMLEFT', 32, 12)
ignoreItemFrame.okayButton:SetScript('OnClick', function() EasyScrap:addItemToIgnoreList(EasyScrap.scrappableItems[ignoreItemFrame.itemRef].itemID, EasyScrap.scrappableItems[ignoreItemFrame.itemRef].itemLink) EasyScrap:filterScrappableItems() itemFrame:updateContent() end)

ignoreItemFrame.cancelButton = CreateFrame('Button', nil, ignoreItemFrame, 'GameMenuButtonTemplate')
ignoreItemFrame.cancelButton:SetText('取消')
ignoreItemFrame.cancelButton:SetWidth(96)
ignoreItemFrame.cancelButton:SetPoint('BOTTOMRIGHT', -32, 12)
ignoreItemFrame.cancelButton:SetScript('OnClick', function() itemFrame:displayState() end)

ignoreItemFrame:Hide()

ignoreItemFrame:SetScript('OnShow', function(self)
    if self.itemRef and self.itemRef > 0 and EasyScrap.scrappableItems[self.itemRef] then
        local itemToIgnore = EasyScrap.scrappableItems[self.itemRef]
        
        self.itemName:SetText('['..itemToIgnore.itemName..']')
        self.itemName:SetTextColor(ITEM_QUALITY_COLORS[itemToIgnore.itemQuality].r, ITEM_QUALITY_COLORS[itemToIgnore.itemQuality].g, ITEM_QUALITY_COLORS[itemToIgnore.itemQuality].b)
        
        SetItemButtonTexture(self.itemButton, itemToIgnore.itemTexture)
        SetItemButtonCount(self.itemButton, itemToIgnore.itemCount);
        SetItemButtonQuality(self.itemButton, itemToIgnore.itemQuality, itemToIgnore.itemLink)  
        
        self.itemButton:SetScript('OnEnter', function(self) GameTooltip:SetOwner(self, "ANCHOR_RIGHT") GameTooltip:SetHyperlink(itemToIgnore.itemLink) GameTooltip:Show() end)
        self.itemButton:SetScript('OnLeave', function(self) GameTooltip_Hide() end)
        
        if not EasyScrap:itemInIgnoreList(self.itemRef) then
            ignoreItemFrame.headerText:SetText('添加装备到忽略列表?')
            ignoreItemFrame.ignoreItemText:SetText('忽略此装备将阻止具有此名称的所有装备显示在符合条件的选项卡中.')
            ignoreItemFrame.okayButton:SetScript('OnClick', function() EasyScrap:addItemToIgnoreList(self.itemRef) EasyScrap:filterScrappableItems() itemFrame:updateContent() end)
        else
            ignoreItemFrame.headerText:SetText('从忽略列表中移除装备?')
            ignoreItemFrame.ignoreItemText:SetText('这将会将装备移除忽略列表.')
            ignoreItemFrame.okayButton:SetScript('OnClick', function() EasyScrap:removeItemFromIgnoreList(self.itemRef) EasyScrap:filterScrappableItems() itemFrame:updateContent() end)
        end
    end
end)

ignoreItemFrame:SetScript('OnHide', function(self)
    self.itemRef = nil
end)

itemFrame.ignoreItemFrame = ignoreItemFrame
--[[
SetItemButtonTexture(itemButton, scrappableItem.itemTexture)
SetItemButtonCount(itemButton, scrappableItem.itemCount);
SetItemButtonQuality(itemButton, scrappableItem.itemQuality, scrappableItem.itemLink)
--]]


--[[
itemFrame.tabButtons[1].hintTexture:Show()
itemFrame.tabButtons[1].hintTexture:SetVertexColor(1, 1, 0, 1)
itemFrame.tabButtons[1].hintTexture:SetDesaturated(true)
--]]
--AutoCastShine_AutoCastStart(itemFrame.tabButtons[1].shineFrame)
--[[
Queued tab unavailable
--]]
itemFrame.contentFrame.tabInfo = itemFrame.contentFrame:CreateFontString()
itemFrame.contentFrame.tabInfo:SetFontObject("GameFontHighlight")
itemFrame.contentFrame.tabInfo:SetText("此选项卡显示当前正在拆除装备队列.拆除队列仅仅是当拆解器满时不停的添加装备到拆解器.")
itemFrame.contentFrame.tabInfo:SetPoint('TOPLEFT', 4, -4)
itemFrame.contentFrame.tabInfo:SetWidth(itemFrame.contentFrame:GetWidth()-16)
itemFrame.contentFrame.tabInfo:Hide()

itemFrame.contentFrame.noEligibleInfo = itemFrame.contentFrame:CreateFontString()
itemFrame.contentFrame.noEligibleInfo:SetFontObject("GameFontHighlight")
itemFrame.contentFrame.noEligibleInfo:SetText("您没有与当前筛选匹配的项目和/或可用于拆解.")
itemFrame.contentFrame.noEligibleInfo:SetPoint('TOPLEFT', 4, -4)
itemFrame.contentFrame.noEligibleInfo:SetWidth(itemFrame.contentFrame:GetWidth()-16)
itemFrame.contentFrame.noEligibleInfo:Hide()

local ignoreHeader = CreateFrame('Frame', nil, itemFrame.contentFrame)
ignoreHeader:SetSize(itemFrame.contentFrame:GetWidth(), 24)
ignoreHeader:SetPoint('TOP', 0, -4)

ignoreHeader.text = ignoreHeader:CreateFontString()
ignoreHeader.text:SetFontObject("GameFontNormalLarge")
ignoreHeader.text:SetText('忽略')
ignoreHeader.text:SetWidth(180)
ignoreHeader.text:SetPoint('CENTER')

ignoreHeader.subText = ignoreHeader:CreateFontString()
ignoreHeader.subText:SetFontObject("GameFontNormal")
ignoreHeader.subText:SetText("当前没有装备被忽略,想要忽略（解除忽略）只需右键单击装备.")
ignoreHeader.subText:SetTextColor(1, 1, 1, 1)
ignoreHeader.subText:SetWidth(itemFrame.contentFrame:GetWidth()-16)
ignoreHeader.subText:SetPoint('TOP', ignoreHeader, 'BOTTOM', 0, 0)

local r,g,b = ignoreHeader.text:GetTextColor()
ignoreHeader.l = ignoreHeader:CreateTexture(nil, 'BACKGROUND')
ignoreHeader.l:SetColorTexture(r,g,b, 0.8)
ignoreHeader.l:SetSize(85, 2)
ignoreHeader.l:SetPoint('LEFT', 12, 0)

ignoreHeader.r = ignoreHeader:CreateTexture(nil, 'BACKGROUND')
ignoreHeader.r:SetColorTexture(r,g,b, 0.8)
ignoreHeader.r:SetSize(85, 2)
ignoreHeader.r:SetPoint('RIGHT', -12, -0)




local filterHeader = CreateFrame('Frame', nil, itemFrame.contentFrame)
filterHeader:SetSize(itemFrame.contentFrame:GetWidth(), 24)
filterHeader:SetPoint('TOP', 0, -60)

filterHeader.text = filterHeader:CreateFontString()
filterHeader.text:SetFontObject("GameFontNormalLarge")
filterHeader.text:SetText('筛选')
filterHeader.text:SetWidth(180)
filterHeader.text:SetPoint('CENTER')

filterHeader.subText = ignoreHeader:CreateFontString()
filterHeader.subText:SetFontObject("GameFontNormal")
filterHeader.subText:SetText("当前没有筛选项目,设置筛选.")
filterHeader.subText:SetTextColor(1, 1, 1, 1)
filterHeader.subText:SetWidth(itemFrame.contentFrame:GetWidth()-16)
filterHeader.subText:SetPoint('TOP', filterHeader, 'BOTTOM', 0, 0)

filterHeader.l = filterHeader:CreateTexture(nil, 'BACKGROUND')
filterHeader.l:SetColorTexture(r,g,b, 0.8)
filterHeader.l:SetSize(85, 2)
filterHeader.l:SetPoint('LEFT', 12, 0)

filterHeader.r = filterHeader:CreateTexture(nil, 'BACKGROUND')
filterHeader.r:SetColorTexture(r,g,b, 0.8)
filterHeader.r:SetSize(85, 2)
filterHeader.r:SetPoint('RIGHT', -12, -0)

itemFrame.contentFrame.ignoreHeader = ignoreHeader
itemFrame.contentFrame.filterHeader = filterHeader

EasyScrap.itemFrame = itemFrame