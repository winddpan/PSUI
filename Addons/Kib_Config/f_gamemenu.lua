local LocalDatabase, GlobalDatabase, Locals = unpack(select(2, ...))

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

    local ButtonHeight      = 35
    local ButtonWidth       = 256
    local SubButtonHeight   = 25
    local ButtonSpacing     = 8
    local Buttons           = {}
    local NewGameMenu
    local OldGameMenu       = GameMenuFrame

--<<EXPAND BUTTON>>---------------------------------------------------------------------------------<<>>

    local function ExpandSubButtons(ParentButton, NumSubButtons)
        ParentButton:SetHeight(ButtonHeight + (NumSubButtons * SubButtonHeight))
        ParentButton.SubButtonContainer:Show()
    end

--<<RETRACT BUTTON>>--------------------------------------------------------------------------------<<>>

    local function RetractSubButton(ParentButton, Force)
        if not ParentButton.SubButtonContainer then return end

        if Force or not MouseIsOver(ParentButton) then
            ParentButton.SubButtonContainer:Hide()
            ParentButton:SetHeight(ButtonHeight)
        end
    end

--<<CREATE BUTTON>>---------------------------------------------------------------------------------<<>>

    local function Create_Button(ButtonNumber, ButtonData, Container)
        local Button = CreateFrame("Button", nil, Container, "Kib_GameMenuButtonTemplate")
        Button:SetSize(ButtonWidth, ButtonHeight)
        Button.Text:SetPoint("LEFT", Button, "TOPLEFT", 15, -(ButtonHeight / 2))
        Button.Text:SetFont(GlobalDatabase.Font, 20, "THINOUTLINE")
        Button.Text:SetText(ButtonData[1])

        Button:SetScript("OnClick", function(self) RetractSubButton(self, true) HideUIPanel(OldGameMenu) ButtonData[2]() end)

        Button:SetScript("OnEnter", function(self)
            self.Edge:SetColorTexture(1, 1, 0, 1) 
            if self.SubButtonContainer then ExpandSubButtons(self, #ButtonData[3]) end
        end)

        Button:SetScript("OnLeave", function(self) 
            self.Edge:SetColorTexture(1, 1, 1, 1) 
            RetractSubButton(self)
        end)

        if not Buttons[ButtonNumber - 1] then
            Button:SetPoint("TOP")
        else
            Button:SetPoint("TOP", Buttons[ButtonNumber - 1], "BOTTOM", 0 , -ButtonSpacing)
        end

        Buttons[ButtonNumber] = Button

        return Button
    end

--<<CREATE SUB BUTTON>>-----------------------------------------------------------------------------<<>>

    local function Create_SubButtons(SubButtonNumber, SubButtonData, ParentButton)
        local SubButton = CreateFrame("Button", nil, ParentButton.SubButtonContainer, "Kib_GameMenuButtonTemplate")
        SubButton:SetSize(ButtonWidth, SubButtonHeight)
        SubButton:SetPoint("TOP", 0, (SubButtonNumber - 1) * -SubButtonHeight)
        SubButton.Text:SetPoint("LEFT", 40, 0)
        SubButton.Text:SetFont(GlobalDatabase.Font, 12, "THINOUTLINE")
        SubButton.Text:SetText(SubButtonData[1])

        SubButton:SetScript("OnClick", function() RetractSubButton(ParentButton, true) HideUIPanel(OldGameMenu) SubButtonData[2]() end)

        SubButton:SetScript("OnEnter", function(self)
            self.Edge:SetColorTexture(1, 1, 0, 1) 
        end)

        SubButton:SetScript("OnLeave", function(self) 
            self.Edge:SetColorTexture(1, 1, 1, 1)
            RetractSubButton(ParentButton)
        end)

        return SubButton
    end

--<<CREATE BUTTON DATA>>----------------------------------------------------------------------------<<>>

    local function Create_ButtonData()
        local ShowAddonPanel = (ACP and ACP.ToggleUI) or function() ShowUIPanel(AddonList) end

        return {
            [1] = {
                Locals.System,  
                function() ShowUIPanel(VideoOptionsFrame) VideoOptionsFrame.lastFrame = OldGameMenu end,
                {
                    {Locals.Interface, function() ShowUIPanel(InterfaceOptionsFrame) InterfaceOptionsFrame.lastFrame = OldGameMenu end},
                    {Locals.Addons2, ShowAddonPanel},
                    {"KIB CONFIG", GlobalDatabase.Config_Toggle}
                }
            },
            [2] = {Locals.Help, ToggleHelpFrame},
            [3] = {Locals.Shop, ToggleStoreUI},
            [4] = {Locals.KeyBindings, function() KeyBindingFrame_LoadUI() ShowUIPanel(KeyBindingFrame) end},
            [5] = {Locals.Macros, ShowMacroFrame},
            [6] = {Locals.Logout, Logout, {{Locals.Quit, Quit}}},
            [7] = {Locals.Close, function() HideUIPanel(OldGameMenu) end},
        }
    end

--<<CREATE NEW GAME MENU>>-----------------------------------------------------------------------------<<>>

    local function Create_NewGameMenu()
        local ScreenWidth, ScreenHeight = GetScreenWidth(), GetScreenHeight()

        -- Gather Button Data
        local NewButtonsData = Create_ButtonData()

        -- Create New Menu
        NewGameMenu = CreateFrame("Frame", nil, UIParent, "Kib_GameMenuFrameTemplate")
        NewGameMenu:SetSize(ButtonWidth, ScreenHeight)
        NewGameMenu:SetPoint("TOP", -(ScreenWidth / 4), 0)
        NewGameMenu.Text:SetFont(GlobalDatabase.Font, 40, "THINOUTLINE")
        NewGameMenu.Text:SetText(Locals.GameMenu)

        NewGameMenu.Container:SetSize(ButtonWidth, (#NewButtonsData * ButtonHeight) + ((#NewButtonsData - 1) * ButtonSpacing))

        -- Change Old Menu
        OldGameMenu:SetAlpha(0)
        OldGameMenu:EnableMouse(false)
        OldGameMenu:HookScript("OnShow", function() NewGameMenu:Show() end)
        OldGameMenu:HookScript("OnHide", function() NewGameMenu:Hide() end)
        for _, child in pairs({OldGameMenu:GetChildren()}) do child:EnableMouse(false) end

        -- Create New Menu Buttons
        for ButtonNumber, ButtonData in ipairs(NewButtonsData) do
            local Button = Create_Button(ButtonNumber, ButtonData, NewGameMenu.Container)

            if ButtonData[3] then
                Button.SubButtonContainer = CreateFrame("Frame", nil, Button) Button.SubButtonContainer:Hide()
                Button.SubButtonContainer:SetPoint("BOTTOMLEFT")
                Button.SubButtonContainer:SetPoint("TOPRIGHT", Button, "BOTTOMRIGHT", 0, #ButtonData[3] * SubButtonHeight)

                for SubButtonNumber, SubButtonData in ipairs(ButtonData[3]) do
                    local SubButton = Create_SubButtons(SubButtonNumber, SubButtonData, Button)
                end
            end
        end
    end

--<<INIT GAME MENU>>--------------------------------------------------------------------------------<<>>

    function LocalDatabase.Init_GameMenu(SavedVariables)
        print(SavedVariables.ShowConfigButton, SavedVariables.UseOldMenu)
        if SavedVariables.UseOldMenu == true then
            if SavedVariables.ShowConfigButton then
                local KibConfigButton = CreateFrame("Button", nil, OldGameMenu, "GameMenuButtonTemplate")
                KibConfigButton:SetPoint("TOP", OldGameMenu, "BOTTOM", 0, -16)
                KibConfigButton:SetText("Kib Config")

                KibConfigButton:SetScript("OnClick", function() HideUIPanel(OldGameMenu) GlobalDatabase.Config_Toggle() end)
            end
        else
            OldGameMenu:HookScript("OnShow", function() 
                if not NewGameMenu then Create_NewGameMenu() end 
                NewGameMenu:Show() 
            end)
        end
    end

----------------------------------------------------------------------------------------------------<<END>>