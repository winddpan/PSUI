local LocalDatabase = unpack(select(2, ...))

--<<IMPORTANT STUFF>>-------------------------------------------------------------------------------<<>>

    local FontObjects = { -- Yuk
        CombatTextFont, ChatBubbleFont, RaidWarningFrameSlot1, RaidWarningFrameSlot2, RaidBossEmoteFrameSlot1, RaidBossEmoteFrameSlot2,
        AchievementFont_Small, CoreAbilityFont, DestinyFontHuge, DestinyFontLarge, FriendsFont_Normal, FriendsFont_Small, FriendsFont_Large,
        FriendsFont_UserText, GameFont_Gigantic, GameTooltipHeader, InvoiceFont_Small, InvoiceFont_Med, MailFont_Large, NumberFont_GameNormal,
        NumberFont_OutlineThick_Mono_Small, NumberFont_Outline_Huge, NumberFont_Outline_Large, NumberFont_Outline_Med, NumberFont_Shadow_Med,
        NumberFont_Shadow_Small, QuestFont_Shadow_Small, QuestFont_Large, QuestFont_Shadow_Huge, QuestFont_Huge, QuestFont_Super_Huge, ReputationDetailFont,
        SpellFont_Small, SystemFont_InverseShadow_Small, SystemFont_Large, SystemFont_Huge1, SystemFont_Med1, SystemFont_Med2, SystemFont_Med3,
        SystemFont_OutlineThick_WTF, SystemFont_OutlineThick_WTF2, SystemFont_OutlineThick_Huge2, SystemFont_OutlineThick_Huge4, SystemFont_Outline_Small,
        SystemFont_Outline, SystemFont_Shadow_Large, SystemFont_Shadow_Large_Outline, SystemFont_Shadow_Large2, SystemFont_Shadow_Med1,
        SystemFont_Shadow_Med1_Outline, SystemFont_Shadow_Med2, SystemFont_Shadow_Med3, SystemFont_Shadow_Outline_Huge2, SystemFont_Shadow_Huge1, SystemFont_Shadow_Huge2,
        SystemFont_Shadow_Huge3, SystemFont_Shadow_Small, SystemFont_Shadow_Small2, SystemFont_Small, SystemFont_Small2, SystemFont_Tiny, Tooltip_Med,
        Tooltip_Small, HelpFrameKnowledgebaseNavBarHomeButtonText, WorldMapFrameNavBarHomeButtonText,
    }

    local FontObjects_NamePlates = {
        {SystemFont_NamePlate, 14}, {SystemFont_LargeNamePlate, 20}, {SystemFont_NamePlateCastBar, 10}
    }

--<<SET GLOBAL FONT>>-------------------------------------------------------------------------------<<>>

    function LocalDatabase.SetFonts(GlobalFont)
        --local FontObjectDummy = CreateFrame("Frame")
        --FontObjectDummy:SetScript("OnEvent", function() print(1) end)
        --FontObjectDummy:RegisterEvent("COMBAT_TEXT_UPDATE")

        STANDARD_TEXT_FONT = GlobalFont
        UNIT_NAME_FONT     = GlobalFont
        DAMAGE_TEXT_FONT   = GlobalFont

        for _, FontObject in pairs(FontObjects) do
            local _, oldSize, oldStyle  = FontObject:GetFont()
            FontObject:SetFont(GlobalFont, oldSize, oldStyle)
        end

        -- [:GetFont] for name plates returns incorrect values so input the correct ones manually
        for _, FontObject in pairs(FontObjects_NamePlates) do
            local _, _, oldStyle  = FontObject[1]:GetFont()
            FontObject[1]:SetFont(GlobalFont, FontObject[2], oldStyle)
        end

        FontObjects = nil
        FontObjects_NamePlates = nil
    end

----------------------------------------------------------------------------------------------------<<END>>