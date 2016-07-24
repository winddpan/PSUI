--[[----------------------------------------------------------------------------

  LiteBag/UIOptionsPanelTemplate.lua

  Copyright 2015-2016 Mike Battersby

----------------------------------------------------------------------------]]--

function LiteBagOptionsPanel_Open()
    local f = LiteBagOptions
    if not f.CurrentOptionsPanel then
        f.CurrentOptionsPanel = LiteBagOptionsMounts
    end
    InterfaceOptionsFrame:Show()
    InterfaceOptionsFrame_OpenToCategory(f.CurrentOptionsPanel)
end


function LiteBagOptionsPanel_Refresh(self)
    for _,control in ipairs(self.controls or {}) do
        control:SetControl(control:GetOption())
    end
end

function LiteBagOptionsPanel_Default(self)
    for _,control in ipairs(self.controls or {}) do
        if control.GetOptionDefault then
            control:SetOption(control:GetOptionDefault())
        end
    end
end

function LiteBagOptionsPanel_Okay(self)
    for i,control in ipairs(self.controls or {}) do
        control:SetOption(control:GetControl())
    end
end

function LiteBagOptionsPanel_Cancel(self)
end

function LiteBagOptionsPanel_RegisterControl(control, parent)
    parent = parent or control:GetParent()
    parent.controls = parent.controls or { }
    tinsert(parent.controls, control)
end

function LiteBagOptionsPanel_OnShow(self)
    LiteBagOptions.CurrentOptionsPanel = self
    LiteBagOptionsPanel_Refresh(self)
end

function LiteBagOptionsPanel_OnLoad(self)

    if self ~= LiteBagOptions then
        self.parent = LiteBagOptions.name
        if not self.name then
            local n = self:GetAttribute("panel-name")
            self.name = _G[n] or n
        end
        self.title:SetText("LiteBag : " .. self.name)
    else
        self.name = "LiteBag"
        self.title:SetText("LiteBag")
    end

    self.okay = self.okay or LiteBagOptionsPanel_Okay
    self.cancel = self.cancel or LiteBagOptionsPanel_Cancel
    self.default = self.default or LiteBagOptionsPanel_Default
    self.refresh = self.refresh or LiteBagOptionsPanel_Refresh

    InterfaceOptions_AddCategory(self)
end

function LiteBagOptionsControl_GetControl(self)
    if self.GetValue then
        return self:GetValue()
    elseif self.GetChecked then
        return self:GetChecked()
    elseif self.GetText then
        self:GetText()
    end
end

function LiteBagOptionsControl_SetControl(self, v)
    if self.SetValue then
        self:SetValue(v)
    elseif self.SetChecked then
        if v then self:SetChecked(true) else self:SetChecked(false) end
    elseif self.SetText then
        self:SetText(v or "")
    end
end

function LiteBagOptionsControl_OnLoad(self, parent)
    self.GetOption = self.GetOption or function (self) end
    self.SetOption = self.SetOption or function (self, v) end
    self.GetControl = self.GetControl or LiteBagOptionsControl_GetControl
    self.SetControl = self.SetControl or LiteBagOptionsControl_SetControl

    -- Note we don't set an OnShow per control, the panel handler takes care
    -- of running the refresh for all the controls in its OnShow

    LiteBagOptionsPanel_RegisterControl(self, parent)
end
