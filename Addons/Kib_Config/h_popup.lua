local LocalDatabase, GlobalDatabase, Locals = unpack(select(2, ...))

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

    local Popup_Frame

--<<POPUP ACCEPT>>----------------------------------------------------------------------------------<<>>

    local function Popup_Accept()
        Popup_Frame.AcceptFunc(Popup_Frame.CurrentValue)
        ReloadUI()
    end

--<<CREATE POPUP FRAME>>----------------------------------------------------------------------------<<>>

	local function Create_Popup()
        Popup_Frame = CreateFrame("Frame", nil, UIParent, "Kib_PopupFrameTemplate")
        Popup_Frame.Frame.Text:SetFont(GlobalDatabase.Font, 11, "THINOUTLINE")
        Popup_Frame.Frame.Yes:SetScript("OnClick", Popup_Accept)
        Popup_Frame.Frame.No:SetScript("OnClick", function() Popup_Frame:Hide() end)
    end

--<<SPAWN POPUP FRAME>>-----------------------------------------------------------------------------<<>>

    function LocalDatabase.Spawn_Popup(AcceptFunc, Value, Text)
        if not Popup_Frame then Create_Popup() end

        Popup_Frame.AcceptFunc = AcceptFunc
        Popup_Frame.CurrentValue = Value
        Popup_Frame.Frame.Text:SetText(Text or Value .. Locals.Reload)
        Popup_Frame:Show()
    end

----------------------------------------------------------------------------------------------------<<END>>