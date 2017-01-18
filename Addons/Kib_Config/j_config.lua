local LocalDatabase, GlobalDatabase, Locals = unpack(select(2, ...))

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

    local ConfigFrame
    local Max_ShownElements     = 10        -- The max amount of config elements allowed to be shown before scrolling is used
    local Tabs                  = {}        -- Contains - Tabs | Sub Tab | Config Lines

    local Num_Tab               = 0         -- Keep count of how many tabs we have
    local Num_SubTabs           = {}        -- Keep count of how many sub tabs we have
    local SubTabOrder           = {}        -- Because Tabs and SubTabs are stored using string names, we need this to keep them in order
                 
    local DefaultConfigWidth    = 512       -- Width of the config frame by default
    local ExtendedConfigWidth   = 1024      -- Width of the config frame when more then 4 tabs are present

    local DefaultTabTextSize    = 12        -- Default size of the tab text
    local ExtendedTabTextSize   = 9         -- Size of the tab text if more then 10 tabs

--<<CREATE MAIN ELEMENTS>>-----------------------------------------------------------------------------------<<>>

    local function Create_ConfigFrame() 
        local Pos = GetScreenHeight() / 2 - 128

        ConfigFrame = CreateFrame("Frame", "Kib_Config_Frame", UIParent, "Kib_ConfigFrameTemplate")
        ConfigFrame:SetPoint("TOP", 0, -Pos)
        ConfigFrame.InfoFrame.Tip:SetFont(GlobalDatabase.Font, 12)
        ConfigFrame.WelcomeFrame.Title:SetFont(GlobalDatabase.Font, 36)
        ConfigFrame.WelcomeFrame.Tip:SetFont(GlobalDatabase.Font, 12)
        ConfigFrame.WelcomeFrame.Tip:SetText(Locals.Welcome_Message_A .. Locals.Welcome_Message_B .. LocalDatabase.Version)

        tinsert(UISpecialFrames, ConfigFrame:GetName()) -- Allows this frame to be hidden with the ESC key(and many other events)
    end

    function LocalDatabase.AddTipMessage(Message) ConfigFrame.InfoFrame.Tip:SetText(Message or "") end

--<<LAYOUT CONFIG LINES>>---------------------------------------------------------------------------<<>>

    local function Layout_ConfigLines(ConfigLines, offset, ContainerFrame, Num_Elements)
        if offset < (Num_Elements - Max_ShownElements) then ContainerFrame.ScrollFrame.ScrollDown:Show() else ContainerFrame.ScrollFrame.ScrollDown:Hide() end
        if offset > 0 then ContainerFrame.ScrollFrame.ScrollUp:Show() else ContainerFrame.ScrollFrame.ScrollUp:Hide() end

        for i = 1, Num_Elements do ConfigLines[i]:Hide() end

        for i = 1, (Num_Elements > Max_ShownElements and Max_ShownElements) or Num_Elements do
            local ConfigLine = ConfigLines[i + offset]
            ConfigLine:SetPoint("TOPLEFT", 0, -32 * (i - 1))
            ConfigLine:SetPoint("BOTTOMRIGHT", ContainerFrame, "TOPRIGHT", 0, -32 * i)
            ConfigLine:Show()
        end
    end

--<<OPEN TAB>>---------------------------------------------------------------------------<<>>

    local function OpenTab(Location, OpenTabName)
        for TabName, Tab in pairs(Location) do 
            if TabName == OpenTabName then
                Tab.ChildContainer:Show()
                Tab.Divider:SetColorTexture(0, 1, 0, 1)
            else
                Tab.Divider:SetColorTexture(1, 1, 1, 1)
                Tab.ChildContainer:Hide() 
            end
        end
    end

    function GlobalDatabase.Config_Open(OpenTabType, TabName, SubTabName, ForceOpen)
        if ForceOpen then ConfigFrame:Show() end

        if ConfigFrame.WelcomeFrame then ConfigFrame.WelcomeFrame:Hide() end

        if OpenTabType == "tab" then
            OpenTab(Tabs, TabName)
        elseif OpenTabType == "subtab" then
            OpenTab(Tabs[TabName].SubTabs, SubTabName)
        elseif OpenTabType == "both" then
            OpenTab(Tabs, TabName)
            OpenTab(Tabs[TabName].SubTabs, SubTabName)
        end
    end

--<<CREATE CONFIG FRAMES>>--------------------------------------------------------------------------<<>>

    function GlobalDatabase.Config_Add(ConfigData, TabName, SubTabName, Texture, Tip)                      
        if not ConfigFrame then 
            Create_ConfigFrame() 
            LocalDatabase.Create_ProfileFrame(ConfigFrame)
        end

        -- Create headers if they don't exist
        if not Tabs[TabName] then 
            Tabs[TabName] = LocalDatabase.Config_AddTab("tab", ConfigFrame, (SubTabName and nil) or true, Tip, TabName) 
            Tabs[TabName].SubTabs = {}
            SubTabOrder[TabName] = {}
            Num_SubTabs[TabName] = 0
            Num_Tab = Num_Tab + 1
        end

        -- Update texture image
        if Texture then Tabs[TabName].Icon:SetTexture(Texture) end

        if not SubTabName and Num_SubTabs[TabName] > 0 then SubTabName = "General" end

        -- Create sub tab if they don't exist
        if (SubTabName and not Tabs[TabName].SubTabs[SubTabName]) then
            Tabs[TabName].SubTabs[SubTabName] = LocalDatabase.Config_AddTab("subtab", Tabs[TabName].ChildContainer, true, Tip, TabName, SubTabName)
            Num_SubTabs[TabName] = Num_SubTabs[TabName] + 1

            SubTabOrder[TabName][Num_SubTabs[TabName]] = SubTabName

            if Num_SubTabs[TabName] == 1 then 
                Tabs[TabName].SubTabs[SubTabName].ChildContainer:Show()
                Tabs[TabName].SubTabs[SubTabName].Divider:SetColorTexture(0, 1, 0, 1)
            end
        end

        -- Resize and position main frame and tabs
        local Config_MinWidth = ((Num_Tab > 4) and ExtendedConfigWidth) or DefaultConfigWidth
        local TabTextSize = ((Num_Tab > 10) and ExtendedTabTextSize) or DefaultTabTextSize
        local TabSize, i = Config_MinWidth / Num_Tab, 0
        local ClampedTabSize = ((TabSize > 256) and 256) or TabSize
        ConfigFrame:SetSize(Config_MinWidth, 2)

        for R_TabName, R_Tab in pairs(Tabs) do
            R_Tab:SetSize(TabSize, ClampedTabSize)
            R_Tab:SetPoint("BOTTOMLEFT", TabSize * i, 0)
            R_Tab.Icon:SetSize(ClampedTabSize, ClampedTabSize)
            R_Tab.Text:SetFont(GlobalDatabase.Font, TabTextSize)
            i = i + 1

            local SubTabSize, SubTabTextSize = Config_MinWidth / Num_SubTabs[R_TabName]

            if Num_Tab <= 4 then
                SubTabTextSize = Num_SubTabs[R_TabName] > 5 and ExtendedTabTextSize or DefaultTabTextSize
            else
                SubTabTextSize = Num_SubTabs[R_TabName] > 10 and ExtendedTabTextSize or DefaultTabTextSize
            end

            for Sub_i, SubTabName in ipairs(SubTabOrder[R_TabName]) do
                local SubTab = Tabs[R_TabName].SubTabs[SubTabName]

                SubTab:SetSize(SubTabSize, 32)
                SubTab:SetPoint("TOPLEFT", SubTabSize * (Sub_i - 1), 0)
                SubTab.Text:SetFont(GlobalDatabase.Font, SubTabTextSize)
            end
        end 

        -- Prepare the correct parent container
        local ConfigLines_Container = (SubTabName and Tabs[TabName].SubTabs[SubTabName]) or Tabs[TabName]
        local ContainerFrame = ConfigLines_Container.ChildContainer

        -- Create config Line
        for i, Data in ipairs(ConfigData) do 
            local Location = (SubTabName and TabName .. " > " .. SubTabName) or TabName

            local ConfigLine = CreateFrame("Button", "Kib_ConfigElement" .. Location, ContainerFrame, "Kib_ConfigLineFrameTemplate")
            ConfigLine.Text_A:SetFont(GlobalDatabase.Font, 12)
            ConfigLine.Text_B:SetFont(GlobalDatabase.Font, 12)
            ConfigLine.Text_A:SetText(Data.text)
            ConfigLine.Data = Data

            ConfigLines_Container[#ConfigLines_Container + 1] = ConfigLine

            -- Setup Description
            local Description = Data.tip and Location .. "\n\n" .. Data.tip or Location
            ConfigLine:SetScript("OnEnter", function() LocalDatabase.AddTipMessage(Description) end)

            -- Create appropriate element
            LocalDatabase[Data.element](ConfigLine)
        end

        -- Resize parent container to match number of element
        local Num_Elements, Enable_Scroll, offset = #ConfigLines_Container, false, 0
        if Num_Elements > Max_ShownElements then 
            Enable_Scroll = true 
            ContainerFrame.ScrollFrame:Show()
        end

        -- Layout elements
        ContainerFrame:SetPoint("BOTTOMRIGHT", ContainerFrame:GetParent(), 0, (Enable_Scroll and Max_ShownElements * -32) or Num_Elements * -32)
        Layout_ConfigLines(ConfigLines_Container, offset, ContainerFrame, Num_Elements)

        -- Handle scrolling through elements
        ContainerFrame.ScrollFrame.ScrollUp:SetScript("OnClick", function() 
            offset = offset - 1
            Layout_ConfigLines(ConfigLines_Container, offset, ContainerFrame, Num_Elements)
        end)

        ContainerFrame.ScrollFrame.ScrollDown:SetScript("OnClick", function() 
            offset = offset + 1
            Layout_ConfigLines(ConfigLines_Container, offset, ContainerFrame, Num_Elements)
        end)

        ContainerFrame:SetScript("OnMouseWheel", function(self, delta)
            if Enable_Scroll then
                if delta == -1 and offset < (Num_Elements - Max_ShownElements) then 
                    offset = offset + 1 
                elseif delta == 1 and offset > 0 then
                    offset = offset - 1
                end
                
                Layout_ConfigLines(ConfigLines_Container, offset, self, Num_Elements)
            end
        end)
    end

--<<CREATE AND HANDLE KIB_CONFIG SLASH COMMANDS>>---------------------------------------------------<<>>

    function GlobalDatabase.Config_Toggle()  
        if ConfigFrame then  
            if ConfigFrame:IsShown() then ConfigFrame:Hide() else ConfigFrame:Show() end 
        end
    end

    SLASH_kib1 = "/kib"
    function SlashCmdList.kib()
        GlobalDatabase.Config_Toggle()
    end

----------------------------------------------------------------------------------------------------<<END>> 