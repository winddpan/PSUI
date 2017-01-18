local LocalDatabase, GlobalDatabase, Locals = unpack(select(2, ...))

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

    local Saved_ColorSettings           = {}
    local Colors                        = {"b", "g", "r"}
    local MaxDropDownChildButtons       = 6     -- While the dropdown is active, this is the max shown before scrolling is used
    local ChildButtonHeight             = 24

--<<TITLE>>-----------------------------------------------------------------------------------------<<>>

    function LocalDatabase.Title(ParentFrame)
        local Divider = ParentFrame:CreateTexture(nil, "OVERLAY")
        Divider:SetColorTexture(1, 1, 1, 1)
        Divider:SetPoint("TOPLEFT", 4, -27)
        Divider:SetPoint("BOTTOMRIGHT", -4, 3)

        ParentFrame.Text_A:ClearAllPoints()
        ParentFrame.Text_A:SetPoint("TOPLEFT", 10, 0)
        ParentFrame.Text_A:SetPoint("BOTTOMRIGHT")
        ParentFrame.Text_A:SetJustifyH("CENTER")
    end

--<<CHECKBUTTON>>-----------------------------------------------------------------------------------<<>>

    local function CheckButton_OnClick(CheckButton, ParentFrame)
        local Value = nil
        if CheckButton:GetChecked() then Value = true else Value = false end

        if ParentFrame.Data.popup_text then
            LocalDatabase.Spawn_Popup(ParentFrame.Data.func, Value, ParentFrame.Data.popup_text) 
        else
            ParentFrame.Data.func(Value) 
            ParentFrame.Text_B:SetText(Value == true and Locals.Yes or Locals.No)
        end
    end

    function LocalDatabase.CheckButton(ParentFrame)
        local CheckButton = CreateFrame("CheckButton", nil, ParentFrame, "Kib_CheckButtonTemplate")
        CheckButton:SetChecked(ParentFrame.Data.value)

        ParentFrame.Text_B:ClearAllPoints()
        ParentFrame.Text_B:SetPoint("CENTER", CheckButton)
        ParentFrame.Text_B:SetText(ParentFrame.Data.value and Locals.Yes or Locals.No)

        CheckButton:SetScript("OnClick", function(self) CheckButton_OnClick(self, ParentFrame) end)
    end

--<<SLIDER>>----------------------------------------------------------------------------------------<<>>

    function LocalDatabase.Slider(ParentFrame)
        local Slider = CreateFrame("Slider", nil, ParentFrame, "Kib_SliderTemplate")
        Slider:SetObeyStepOnDrag(true)

        ParentFrame.Text_B:SetText(ParentFrame.Data.value)

        Slider:SetMinMaxValues(unpack(ParentFrame.Data.minmax))
        Slider:SetValue(ParentFrame.Data.value)
        Slider:SetValueStep(ParentFrame.Data.step)

        -- To prevent an outrageous amount of function calls, use OnMouseUp to trigger the function instead of OnValueChanged
        Slider:SetScript("OnMouseUp", function(self) ParentFrame.Data.func(math.floor((self:GetValue() * 100) + 0.5) / 100) end)
        Slider:SetScript("OnValueChanged", function(self, value) ParentFrame.Text_B:SetText(math.floor((value * 100) + 0.5) / 100) end)
    end

--<<DROPDOWN>>--------------------------------------------------------------------------------------<<>>

    local function ChildButtons_Layout(DropDown)
        local Scroll_Offset = DropDown.Container.Scroll_Offset

        if Scroll_Offset < (#DropDown.ChildButtons - MaxDropDownChildButtons) then DropDown.Container.ScrollDown:Show() else DropDown.Container.ScrollDown:Hide() end
        if Scroll_Offset > 0 then DropDown.Container.ScrollUp:Show() else DropDown.Container.ScrollUp:Hide() end

        local NumShownChildButtons = ((#DropDown.ChildButtons > MaxDropDownChildButtons) and MaxDropDownChildButtons) or #DropDown.ChildButtons

        DropDown.Container:SetPoint("TOPLEFT", DropDown, "BOTTOMLEFT")
        DropDown.Container:SetPoint("BOTTOMRIGHT", 0, NumShownChildButtons * -ChildButtonHeight)

        for _, ChildButton in pairs(DropDown.ChildButtons) do ChildButton:Hide() end

        for i = 1, NumShownChildButtons do
            local ChildButton = DropDown.ChildButtons[i + (Scroll_Offset or 0)]
            ChildButton:SetPoint("TOPLEFT", 0, -ChildButtonHeight * (i - 1))
            ChildButton:SetPoint("BOTTOMRIGHT", DropDown.Container, "TOPRIGHT", 0, -ChildButtonHeight * i)
            ChildButton:Show()
        end
    end

    function LocalDatabase.DropDown(ParentFrame)
        local Contents, IsConfigRelated = ParentFrame.Data.Contents, ParentFrame.Data and true or nil
        local Text = Contents[ParentFrame.Data.value][2] or tostring(Contents[ParentFrame.Data.value][1])

        local DropDown = CreateFrame("Button", nil, ParentFrame, "Kib_DropDownButtonTemplate") DropDown:Show()
        DropDown:SetPoint("TOPRIGHT", ParentFrame, "TOPRIGHT", -64, -5)
        DropDown:SetPoint("BOTTOMLEFT", ParentFrame, "BOTTOMRIGHT", -192, 5)
        DropDown.Text:SetFont(GlobalDatabase.Font, 12, "THINOUTLINE")
        DropDown.Text:SetText((IsConfigRelated and Text) or "")

        DropDown:SetScript("OnEnter", function() LocalDatabase.AddTipMessage(Text) end)

        DropDown.Container:SetScript("OnMouseWheel", function(_, delta) 
            local Scroll_Offset = DropDown.Container.Scroll_Offset
            
            if delta == -1 then 
                if Scroll_Offset < (#DropDown.ChildButtons - MaxDropDownChildButtons) then Scroll_Offset = Scroll_Offset + 1 end
            elseif delta == 1 then 
                if Scroll_Offset > 0 then Scroll_Offset = Scroll_Offset - 1 end
            end

            DropDown.Container.Scroll_Offset = Scroll_Offset
            ChildButtons_Layout(DropDown) 
        end)

        DropDown.Container.Scroll_Offset = 0
        DropDown.ChildButtons = {}

        for i, value in ipairs(Contents) do 
            if not IsConfigRelated or i ~= ParentFrame.Data.value then
                local Text = value[2] or tostring(value[1])

                local ChildButton = CreateFrame("Button", nil, DropDown.Container, "Kib_DropDownChildButtonTemplate")
                ChildButton.Text:SetFont(GlobalDatabase.Font, 11, "THINOUTLINE")
                ChildButton.Text:SetText(Text)

                ChildButton:SetScript("OnEnter", function(self) 
                    LocalDatabase.AddTipMessage(Text)
                    self.Indicator:SetColorTexture(1, 1, 0, 1)
                end)

                ChildButton.Parent = DropDown.Container
                ChildButton.ExpandIcon = DropDown.ExpandTexture

                ChildButton:SetScript("OnClick", function(self) 
                    if not IsConfigRelated then DropDown.Text:SetText(Text) end
                    DropDown.Container:Hide()

                    if ParentFrame.Data.popup_text then 
                        LocalDatabase.Spawn_Popup(ParentFrame.Data.func, i, ParentFrame.Data.popup_text .. " " .. Text) 
                    else
                        DropDown.Text:SetText(Text)
                        ParentFrame.Data.func(i)
                    end
                end) 

                DropDown.ChildButtons[#DropDown.ChildButtons + 1] = ChildButton
            end
        end 

        ChildButtons_Layout(DropDown)
    end

--<<COLOR>>-----------------------------------------------------------------------------------------<<>>

    local function UpdateColoursFunc(ColourButtons, Data)
        ColourButtons.r.Texture:SetColorTexture(Data.value.r, 0, 0)
        ColourButtons.g.Texture:SetColorTexture(0, Data.value.g, 0)
        ColourButtons.b.Texture:SetColorTexture(0, 0, Data.value.b)
    end

    function LocalDatabase.Color(ParentFrame, Data)
        ParentFrame.ColourButtons = {}
        local function ApplyColor() ParentFrame.Data.func({r = ParentFrame.Data.value.r, g = ParentFrame.Data.value.g, b = ParentFrame.Data.value.b}) end

        for i, Color in ipairs(Colors) do
            local Button = CreateFrame("Button", nil, ParentFrame, "Kib_ColorTemplate")
            Button:SetPoint("RIGHT", ((i - 1) * -50) -64, 0)
            Button.Slider.Texture:SetTexture("Interface\\AddOns\\Kib_Config\\media\\colorslider_" .. Color)
            Button.Slider:SetValue(1 - ParentFrame.Data.value[Color])

            Button.Slider.Text:SetPoint("RIGHT", ParentFrame, "RIGHT", -20, 0)
            Button.Slider.Text:SetFont(GlobalDatabase.Font, 11, "THINOUTLINE")
            Button.Slider.Text:SetText(format("%.2f", ParentFrame.Data.value[Color]))  

            Button.Slider:SetScript("OnHide", ApplyColor)
            Button.Slider:SetScript("OnMouseUp", ApplyColor)
            Button.Slider:SetScript("OnValueChanged", function(self, value)
                local NewValue = 1 - value 
                ParentFrame.Data.value[Color] = NewValue
                self.Text:SetText(format("%.2f", NewValue)) 
                UpdateColoursFunc(ParentFrame.ColourButtons, ParentFrame.Data)  
            end)

            ParentFrame.ColourButtons[Color] = Button
        end

        ParentFrame:RegisterForClicks("LeftButtonUp" , "RightButtonUp")
        ParentFrame:SetScript("OnClick", function(_, input) 
            if input == "LeftButton" then
                Saved_ColorSettings.r = ParentFrame.Data.value.r
                Saved_ColorSettings.g = ParentFrame.Data.value.g
                Saved_ColorSettings.b = ParentFrame.Data.value.b
            elseif input == "RightButton" then
                if Saved_ColorSettings then
                    ParentFrame.Data.value.r = Saved_ColorSettings.r
                    ParentFrame.Data.value.g = Saved_ColorSettings.g
                    ParentFrame.Data.value.b = Saved_ColorSettings.b
                    UpdateColoursFunc(ParentFrame.ColourButtons, ParentFrame.Data)
                    ApplyColor()
                end
            end
        end)

        UpdateColoursFunc(ParentFrame.ColourButtons, ParentFrame.Data)
    end

--<<TAB / SUB TAB>>---------------------------------------------------------------------------------<<>>

    function LocalDatabase.Config_AddTab(TabType, Parent, EnableMouse, Tip, TabName, SubTabName)
        local Name = (TabType == "tab" and TabName) or SubTabName

        local Tab = CreateFrame("Button", nil, Parent, "Kib_TabTemplate")
        Tab.Text:SetText(string.upper(Name))
        Tab.Text:SetFont(GlobalDatabase.Font, 12)

        Tab.ChildContainer = CreateFrame("Frame", nil, Parent, "Kib_TabChildContainerTemplate")
        Tab.ChildContainer:SetPoint("TOPLEFT", Parent, "BOTTOMLEFT")
        Tab.ChildContainer:SetPoint("BOTTOMRIGHT", Parent, 0, -32)
        Tab.ChildContainer:Hide()

        if EnableMouse then Tab.ChildContainer:EnableMouseWheel(true) end

        local InfoText = Tip and format("%s\n\n%s", Name, Tip) or Name

        Tab:SetScript("OnEnter", function(self) 
            LocalDatabase.AddTipMessage(InfoText)
            self.Text:SetTextColor(0, 1, 0, 1) 
        end)

        Tab:SetScript("OnClick", function(self)
            GlobalDatabase.Config_Open(TabType, TabName, SubTabName)
        end)

        return Tab
    end

----------------------------------------------------------------------------------------------------<<END>>