local LocalDatabase, GlobalDatabase = unpack(select(2, ...))

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

    local DropDownMenus = {}
    local MaxSubButtons = 6                   -- While the dropdown is active, this is the max shown before scrolling is used

--<<LAYOUT SUB BUTTONS>>-----------------------------------------------------------------------<<>>

    local function Layout(ID)
        local Menu = DropDownMenus[ID]

        local NumSubButtons, Scroll_Offset = #Menu, Menu.Container.Scroll_Offset

        if Scroll_Offset < (NumSubButtons - MaxSubButtons) then Menu.Container.ScrollDown:Show() else Menu.Container.ScrollDown:Hide() end
        if Scroll_Offset > 0 then Menu.Container.ScrollUp:Show() else Menu.Container.ScrollUp:Hide() end

        for _, SubButton in ipairs(Menu) do SubButton:Hide() end

        local i = 1
        for k = 1, Menu.NumVisibleSubButtons do
            local SubButton = Menu[i + Scroll_Offset]
            SubButton:SetPoint("TOPLEFT", 0, -24 * (i - 1))
            SubButton:SetPoint("BOTTOMRIGHT", Menu.Container, "TOPRIGHT", 0, -24 * i)
            SubButton:Show()

            i = i + 1
        end

        Menu.Container:SetPoint("TOPLEFT", Menu, "BOTTOMLEFT")
        Menu.Container:SetPoint("BOTTOMRIGHT", 0, Menu.NumVisibleSubButtons * -24)
    end

    local function OnMouseWheel(Container, delta)
        local NumSubButtons = #DropDownMenus[Container.ID]

        if NumSubButtons > MaxSubButtons  then 
            if delta == -1 and Container.Scroll_Offset < (NumSubButtons - MaxSubButtons) then 
                Container.Scroll_Offset = Container.Scroll_Offset + 1 
            elseif delta == 1 and Container.Scroll_Offset > 0 then
                Container.Scroll_Offset = Container.Scroll_Offset - 1
            end
            
            Layout(Container.ID)
        end
    end

--<<CREATE MAIN BUTTON>>-----------------------------------------------------------------------<<>>

    local function Create_MainButton(ID, Parent)
        local DropDown = CreateFrame("Button", nil, Parent, "Kib_DropDownButtonTemplate")
        DropDown.Text:SetFont(GlobalDatabase.Font, 12, "THINOUTLINE")
        DropDown.Text:SetText("|cFF808080...|r")

        DropDown.Container.Scroll_Offset = 0
        DropDown.Container.ID = ID
        DropDown.Container:SetScript("OnMouseWheel", OnMouseWheel)

        DropDownMenus[ID] = DropDown
    end

--<<CREATE SUB BUTTONS>>-----------------------------------------------------------------------<<>>

    local function Create_SubButtons(ID, Contents, OverRideFunc)
        for i, SubButtonData in ipairs(Contents) do
            local SubButton = DropDownMenus[ID][i] or CreateFrame("Button", nil, DropDownMenus[ID].Container, "Kib_DropDownChildButtonTemplate")
            SubButton.Text:SetFont(GlobalDatabase.Font, 11, "THINOUTLINE")
            SubButton.Text:SetText(SubButtonData.ID)

            SubButton.ID            = SubButtonData.ID
            SubButton.Parent        = DropDownMenus[ID].Container
            SubButton.ExpandIcon    = DropDownMenus[ID].ExpandTexture
            local OnClickFunc       = OverRideFunc or SubButtonData.Func

            SubButton:SetScript("OnClick", function(self) OnClickFunc(self) self.Parent:Hide() end) 

            DropDownMenus[ID][i] = SubButton
        end

        DropDownMenus[ID].NumVisibleSubButtons = (#DropDownMenus[ID] > MaxSubButtons and MaxSubButtons) or #DropDownMenus[ID]

        Layout(ID)
    end

--<<SPAWN DYNAMIC DROPDOWN MENU>>------------------------------------------------------------------<<>>

    function LocalDatabase.Spawn_DynamicDropDown(ID, Contents, Parent, OverRideFunc)
        if not DropDownMenus[ID] then Create_MainButton(ID, Parent) end

        Create_SubButtons(ID, Contents, OverRideFunc)

        return DropDownMenus[ID]
    end

----------------------------------------------------------------------------------------------------<<END>>