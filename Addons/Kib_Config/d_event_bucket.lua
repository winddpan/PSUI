local LocalDatabase, GlobalDatabase, Locals = unpack(select(2, ...))

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

    local EventFrame                            -- The main frame
    local Active_Location                       -- The current data location that will be used
    local DropDownInPosition = false            -- If the dropdown menu has been setup correctly

    local EventFrame_MaxWidth = 512             -- Max width of the frame
    local EventLines_Max = 20                   -- The max amount of event lines before scrolling is used
    local Scroll_Offset = 0                     -- The downward offset of event lines when scrolling

    local Num_DuplicateEvents = 1               -- To prevent spamming of the same event
    local Previous_Event = ""                   -- Store the previous event to prevent duplicates

    local EventData = {}                        -- The data of every triggered event [Location][event]
    local EventBucket = {}                      -- Contains all event lines

    local GetTime = GetTime

--<<UPDATE EVENT LINES>>----------------------------------------------------------------------------<<>>

    local function UpdateLines()
        if Scroll_Offset < (#Active_Location - EventLines_Max) then EventFrame.ScrollDown:Show() else EventFrame.ScrollDown:Hide() end
        if Scroll_Offset > 0 then EventFrame.ScrollUp:Show() else EventFrame.ScrollUp:Hide() end

        for i, EventLine in ipairs(EventBucket) do 
            local Line = i + Scroll_Offset
            local Event = Active_Location[Line]

            if Event then
                EventLine.Text_Left:SetText(Event)
                EventLine.Text_Right:SetText(format("|cFF808080%d|r", Line))
                EventLine:Show()
            else
                EventLine:Hide() 
            end

            EventFrame.Text_EventLines_Cur:SetText(#Active_Location)
        end
    end

--<<CREATE EVENT Frame>>----------------------------------------------------------------------------<<>>

    local function Button_Close_OnClick(Button) Button:GetParent():Hide() end

    local function Button_Reset_OnClick()
        wipe(Active_Location)
        Active_Location[1] = "|cffffff00Data Reset|r"
        Scroll_Offset, Num_DuplicateEvents = 0, 0

        UpdateLines()
    end

    local function ScrollUp_OnClick()
        Scroll_Offset = 0
        UpdateLines()
    end

    local function ScrollDown_OnClick()
        Scroll_Offset = #Active_Location - EventLines_Max
        UpdateLines()
    end

    local function EventFrame_OnMouseWheel(_, delta)
        if #Active_Location > EventLines_Max  then 
            if delta == -1 and Scroll_Offset < (#Active_Location - EventLines_Max) then 
                Scroll_Offset = Scroll_Offset + 1 
            elseif delta == 1 and Scroll_Offset > 0 then
                Scroll_Offset = Scroll_Offset - 1
            end

            UpdateLines()
        end
    end

    local function Create_EventFrame()
        EventFrame = CreateFrame("Frame", nil, UIParent, "Kib_EventBucketFrameTemplate")
        EventFrame:SetSize(EventFrame_MaxWidth, 48)
        EventFrame.Container:SetSize(EventFrame_MaxWidth, (EventLines_Max * 18) + 30)

        EventFrame.Text_Title:SetFont(GlobalDatabase.Font, 20)
        EventFrame.Text_EventLines_Cur:SetFont(GlobalDatabase.Font, 20)

        local Button_Close = CreateFrame("Button", nil, EventFrame, "Kib_EventBucketButtonTemplate")
        Button_Close:SetPoint("TOPRIGHT", EventFrame.Container, "BOTTOMRIGHT", 0, -10)
        Button_Close.Text:SetFont(GlobalDatabase.Font, 11)
        Button_Close.Text:SetText("Close")

        local Button_Reset = CreateFrame("Button", nil, EventFrame, "Kib_EventBucketButtonTemplate")
        Button_Reset:SetPoint("TOPRIGHT", EventFrame.Container, "BOTTOMRIGHT", -106, -10)
        Button_Reset.Text:SetFont(GlobalDatabase.Font, 11)
        Button_Reset.Text:SetText("Reset")

        Button_Close:SetScript("OnClick", Button_Close_OnClick)
        Button_Reset:SetScript("OnClick", Button_Reset_OnClick)

        EventFrame.ScrollUp:SetScript("OnClick", ScrollUp_OnClick)
        EventFrame.ScrollDown:SetScript("OnClick", ScrollDown_OnClick)
        EventFrame.Container:SetScript("OnMouseWheel", EventFrame_OnMouseWheel)

        for i = 1, EventLines_Max do
            local EventLine = CreateFrame("Button", nil, EventFrame.Container, "Kib_EventBucketLineTemplate")
            EventLine:SetPoint("TOPLEFT", 0, ((i - 1) * -18) - 15)
            EventLine:SetPoint("BOTTOMRIGHT", EventFrame.Container, "TOPRIGHT", 0, (i * -18) - 15)

            EventLine.Text_Left:SetFont(GlobalDatabase.Font, 12)
            EventLine.Text_Right:SetFont(GlobalDatabase.Font, 12)
            EventBucket[i] = EventLine
        end
    end

--<<ADD LINE>>--------------------------------------------------------------------------------------<<>>

    local function DropDownItem_OnClick(Button)
        Active_Location = EventData[Button.ID]
        EventFrame.Text_Title:SetText(Button.ID)
        Scroll_Offset = 0

        UpdateLines()
    end

    function GlobalDatabase.EventBucket_AddLine(Location, Event)
        if not EventFrame then  Create_EventFrame() end

        if not EventData[Location] then 
            EventData[Location] = {} 

            if not Active_Location then 
                Active_Location = EventData[Location] 
                EventFrame.Text_Title:SetText(Location)
            end

            local DropDownMenu = LocalDatabase.Spawn_DynamicDropDown(EventFrame.Container, "EventBucket", Location, DropDownItem_OnClick)
            if not DropDownInPosition then
                DropDownMenu:SetPoint("TOPLEFT", EventFrame.Container, "BOTTOMLEFT", 0, -10)
                DropDownMenu:SetPoint("BOTTOMRIGHT", EventFrame.Container, "BOTTOMLEFT", 192, -42)
                DropDownMenu:Show()
                DropDownInPosition = true
            end
        end

        local time = GetTime()
        local M, S, MLS = mod(time/60, 60), mod(time, 60), mod(time*10, 10)

        local StampedEvent = format("|cFF808080%02d.%02d.%02d:|r %s", M, S, MLS, Event)

        if Previous_Event == Location .. Event then
            Num_DuplicateEvents = Num_DuplicateEvents + 1
            EventData[Location][#EventData[Location]] = format("%s |cff00ffffX%d|r", StampedEvent, Num_DuplicateEvents)
        else
            EventData[Location][#EventData[Location] + 1] = StampedEvent
            Num_DuplicateEvents = 1
        end

        UpdateLines()
        Previous_Event = Location .. Event
    end

--<<CREATE AND HANDLE SLASH COMMAND>>---------------------------------------------------------------<<>>

    SLASH_kibEB1 = "/kibeb"
    function SlashCmdList.kibEB()
        if not EventFrame then Create_EventFrame() end
        if EventFrame:IsShown() then EventFrame:Hide() else EventFrame:Show() end 
    end

----------------------------------------------------------------------------------------------------<<END>>