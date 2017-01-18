local LocalDatabase, GlobalDatabase, Locals = unpack(select(2, ...))

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

    local Profiles, ProfileFrame, DropDown, EditBox, CurrentMethod, ClickedDropDownProfile = {}

    local LastClickButton

--<<CREATE DROPDOWN ELEMENT>>-----------------------------------------------------------------------<<>>

    local function DropDown_ChildButton_OnClick(Button)
        ClickedDropDownProfile = Button
        ProfileFrame.Accept:Show()
        ProfileFrame.Decline:Show()
    end

    local function Create_DropDownElement()
        DropDown = LocalDatabase.Spawn_DynamicDropDown("Profiles", Profiles, ProfileFrame, DropDown_ChildButton_OnClick)
        DropDown:SetPoint("TOPRIGHT", ProfileFrame, "BOTTOMRIGHT", 0, 32)
        DropDown:SetPoint("BOTTOMLEFT", ProfileFrame, "BOTTOMLEFT")
    end

--<<CREATE EDITBOX ELEMENT>>------------------------------------------------------------------------<<>>

    local function EditBox_TextChanged(EditBox)
        EditBox:SetText(gsub(EditBox:GetText(),"[%%%+%?%[%]%^%$]","")) -- Strip Special Characters

        local Text = EditBox:GetText()
        if (Text ~= "") and (Text ~= CurrentMethod[2]) and not KIBDB[Text] then
            EditBox.Text = Text
            ProfileFrame.Accept:Show()
            ProfileFrame.Decline:Show()
        else
            ProfileFrame.Accept:Hide()
            ProfileFrame.Decline:Hide()
        end
    end

    local function EditBox_Cancel(EditBox)
        EditBox:ClearFocus()
        EditBox:SetText(CurrentMethod[2])
    end

    local function Create_EditBoxElement()
        EditBox = CreateFrame("EditBox", nil, ProfileFrame, "Kib_ProfileEditBoxTemplate")
        EditBox:SetFont(GlobalDatabase.Font, 12, "THINOUTLINE")
        EditBox:SetScript("OnTextChanged", EditBox_TextChanged)
        EditBox:SetScript("OnEscapePressed", EditBox_Cancel)
        EditBox:SetScript("OnEnterPressed", EditBox_Cancel)
    end

--<<CREATE BUTTONS>>--------------------------------------------------------------------------------<<>>

    local function Create_Buttons(InfoFrame)
        local ProfileButtons = {
            {"new", Locals.ProfileButton_New}, 
            {"delete", Locals.ProfileButton_Delete},
            {"rename", Locals.ProfileButton_Rename}, 
            {"copy", Locals.ProfileButton_Copy},
            {"switch", Locals.ProfileButton_Switch}
        }

        for ButtonNumber, ButtonData in ipairs(ProfileButtons) do
            local Method, Description = ButtonData[1], ButtonData[2]

            local Button = CreateFrame("Button", nil, InfoFrame)
            Button:SetNormalTexture("Interface\\AddOns\\Kib_Config\\media\\profile_" .. Method)
            Button:SetPoint("LEFT", InfoFrame, "TOPLEFT", ButtonNumber * 32, 0)
            Button:SetSize(32, 32)

            Button.MOText = format("%s\n\n%s\n\n%s: %s", Description[1], Description[2], Locals.CurrentProfile, LocalDatabase.ProfileKey)
            Button:SetScript("OnEnter", function(self) InfoFrame.Tip:SetText(self.MOText) end)

            Button:SetScript("OnClick", function(self)
                if LastClickButton == Description[1] and ProfileFrame:IsShown() then 
                    ProfileFrame:Hide() 
                else 
                    CurrentMethod = {Method, Description[1]}

                    if Method == "new" or Method == "rename" then
                        EditBox:SetText(Description[1])
                        DropDown:Hide()
                        EditBox:Show()
                    else
                        DropDown.Text:SetText(Description[1])
                        EditBox:Hide()
                        DropDown:Show()
                    end 

                    ProfileFrame.Accept:Hide()
                    ProfileFrame.Decline:Hide()
                    ProfileFrame:Show() 
                end

                LastClickButton = Description[1]
            end)
        end
    end

--<<ACCEPT/DECLINE CLICKED FUNCTIONS>>--------------------------------------------------------------<<>>

    local function Accept_OnClick()
        if CurrentMethod[1] == "rename" then
            KIBDB[EditBox.Text] = KIBDB[LocalDatabase.ProfileKey]                       -- Create new table with selected name and copy previous table
            KIBDB[LocalDatabase.CharacterKey].ProfileKey = EditBox.Text                 -- Set the name of the new table to this characters profile key
            KIBDB[LocalDatabase.ProfileKey] = nil                                       -- Kill previous profile
            ReloadUI()                          
                            
        elseif CurrentMethod[1] == "new" then                       
            KIBDB[LocalDatabase.CharacterKey].ProfileKey = EditBox.Text                 -- Set your characters profile key to this new name
            ReloadUI()                                                                  -- If a profile key exists without a table one will be created on launch/reload
                            
        elseif CurrentMethod[1] == "delete" then            
            DropDown.Text:SetText(CurrentMethod[2])                                     -- Set the dropdown button to the selected profiles name              
            KIBDB[ClickedDropDownProfile.ID] = nil                                      -- Kill the selected profile
            ClickedDropDownProfile:Disable()                                            -- Disable the selected button (alot more sufficient then creating a full reload function on the dropdown frame)
            ClickedDropDownProfile.Indicator:SetColorTexture(1, 0, 0, 1)
            ProfileFrame.Accept:Hide()                                                  -- Show the Accept and Decline buttons once an acceptable name exists
            ProfileFrame.Decline:Hide()

        elseif CurrentMethod[1] == "copy" then
            for Addon_Name, Addon in pairs(KIBDB[ClickedDropDownProfile.ID]) do
                KIBDB[LocalDatabase.ProfileKey][Addon_Name] = Addon                     -- Copy all the Addon settings from the selected profile
            end
            ReloadUI() 
        else
            KIBDB[LocalDatabase.CharacterKey].ProfileKey = ClickedDropDownProfile.ID    -- Set the Profile key of this character to the selected profile
            ReloadUI() 
        end
    end

    local function Decline_OnClick()
        DropDown.Text:SetText(CurrentMethod[2])
        EditBox:SetText(CurrentMethod[2])
        EditBox:ClearFocus()
        ProfileFrame.Accept:Hide()
        ProfileFrame.Decline:Hide()
    end

--<<CREATE PROFILE ELEMENTS>>-----------------------------------------------------------------------<<>>
                                                                                                        
    function LocalDatabase.Create_ProfileFrame(ConfigFrame)  

        -- Create Profile Frame
        ProfileFrame = CreateFrame("Frame", nil, ConfigFrame.InfoFrame, "Kib_ProfileFrameTemplate")
        ProfileFrame.Accept.Text:SetText(Locals.Accept)
        ProfileFrame.Accept.Text:SetFont(GlobalDatabase.Font, 12, "THINOUTLINE")
        ProfileFrame.Decline.Text:SetText(Locals.Decline)
        ProfileFrame.Decline.Text:SetFont(GlobalDatabase.Font, 12, "THINOUTLINE")

        ProfileFrame.Accept:SetScript("OnClick", Accept_OnClick)
        ProfileFrame.Decline:SetScript("OnClick", Decline_OnClick)

        -- Gather And Store Profiles
        for ProfileName in pairs(KIBDB) do
            if not string.match(ProfileName, "Character Key:") and (ProfileName ~= LocalDatabase.ProfileKey) then
                Profiles[#Profiles + 1] = {ID = ProfileName}
            end
        end

        Create_Buttons(ConfigFrame.InfoFrame)       -- Create Button Data
        Create_EditBoxElement()                     -- Create EditBox
        Create_DropDownElement()                    -- Create DropDown
    end

----------------------------------------------------------------------------------------------------<<END>>