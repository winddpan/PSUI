--[[----------------------------------------------------------------------------

  LiteBag/UIOptions.lua

  Copyright 2015-2016 Mike Battersby

----------------------------------------------------------------------------]]--


function LiteBagOptionsConfirmSort_OnLoad(self)
    self.Text:SetText("Confirm before sorting.")
    self.SetOption =
        function (self, setting)
            if not setting or setting == "0" then
                LiteBag_SetGlobalOption("NoConfirmSort", true)
            else
                LiteBag_SetGlobalOption("NoConfirmSort", nil)
            end
        end
    self.GetOption =
        function (self)
            return not LiteBag_GetGlobalOption("NoConfirmSort")
        end
    self.GetOptionDefault =
        function (self) return true end
    LiteBagOptionsControl_OnLoad(self)
end

function LiteBagOptionsEquipsetDisplay_OnLoad(self)
    self.Text:SetText("Display equipment set membership icons.")
    self.SetOption =
        function (self, setting)
            if not setting or setting == "0" then
                LiteBag_SetGlobalOption("HideEquipsetIcon", true)
            else
                LiteBag_SetGlobalOption("HideEquipsetIcon", nil)
            end
            LiteBagPanel_UpdateItemButtons(LiteBagInventoryPanel)
            LiteBagPanel_UpdateItemButtons(LiteBagBankPanel)
        end
    self.GetOption =
        function (self)
            return not LiteBag_GetGlobalOption("HideEquipsetIcon")
        end
    self.GetOptionDefault =
        function (self) return true end
    LiteBagOptionsControl_OnLoad(self)
end

function LiteBagOptionsSnapToPosition_OnLoad(self)
    self.Text:SetText("Snap inventory frame to default backpack position.")
    self.SetOption =
        function (self, setting)
            if not setting or setting == "0" then
                LiteBag_SetGlobalOption("NoSnapToPosition", true)
            else
                LiteBag_SetGlobalOption("NoSnapToPosition", false)
            end
        end
    self.GetOption =
        function (self)
            return not LiteBag_GetGlobalOption("NoSnapToPosition")
        end
    self.GetOptionDefault =
        function (self) return false end
    LiteBagOptionsControl_OnLoad(self)
end

local function SetupColumnsControl(self, panel, default)
    local n = self:GetName()

    _G[n.."Low"]:SetText("8")
    _G[n.."High"]:SetText("24")
    self.SetOption =
            function (self, v)
            LiteBag_SetFrameOption(panel, "columns", v)
        end
    self.GetOption =
        function (self)
            return LiteBag_GetFrameOption(panel, "columns") or default
        end
    self.GetOptionDefault =
            function (self) return default end
end

local function SetupScaleControl(self, frame)
    local n = self:GetName()
    _G[n.."Low"]:SetText(0.75)
    _G[n.."High"]:SetText(1.25)
    self.SetOption =
            function (self, v)
            LiteBag_SetFrameOption(frame, "scale", v)
        end
    self.GetOption =
            function (self)
            return LiteBag_GetFrameOption(frame, "scale") or 1.0
        end
    self.GetOptionDefault =
            function (self) return 1.0 end
end

function LiteBagOptionsInventoryColumns_OnLoad(self)
    SetupColumnsControl(self, "LiteBagInventoryPanel", 8)
    LiteBagOptionsControl_OnLoad(self)
end

function LiteBagOptionsInventoryColumns_OnValueChanged(self)
    local n = self:GetName()
    _G[n.."Text"]:SetText(format("Inventory columns: %d", self:GetValue()))
    LiteBagOptionsControl_OnChanged(self)
end

function LiteBagOptionsInventoryScale_OnLoad(self)
    SetupScaleControl(self, "LiteBagInventory")
    LiteBagOptionsControl_OnLoad(self)
end

function LiteBagOptionsInventoryScale_OnValueChanged(self)
    local n = self:GetName()
    _G[n.."Text"]:SetText(format("Inventory scale: %0.2f", self:GetValue()))
    LiteBagOptionsControl_OnChanged(self)
end

function LiteBagOptionsBankColumns_OnLoad(self)
    SetupColumnsControl(self, "LiteBagBankPanel", 14)
    LiteBagOptionsControl_OnLoad(self)
end

function LiteBagOptionsBankColumns_OnValueChanged(self)
    local n = self:GetName()
    _G[n.."Text"]:SetText(format("Bank columns: %d", self:GetValue()))
    LiteBagOptionsControl_OnChanged(self)
end

function LiteBagOptionsBankScale_OnLoad(self)
    SetupScaleControl(self, "LiteBagBank")
    LiteBagOptionsControl_OnLoad(self)
end

function LiteBagOptionsBankScale_OnValueChanged(self)
    local n = self:GetName()
    _G[n.."Text"]:SetText(format("Bank scale: %0.2f", self:GetValue()))
    LiteBagOptionsControl_OnChanged(self)
end

