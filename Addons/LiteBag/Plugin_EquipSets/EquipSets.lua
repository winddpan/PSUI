--[[----------------------------------------------------------------------------

  LiteBag/Plugin_Equipsets/EquipSets.lua

  Copyright 2013-2016 Mike Battersby

  Released under the terms of the GNU General Public License version 2 (GPLv2).
  See the file LICENSE.txt.

  Adds:
    self.eqTexture1/2/3/4 (Texture level=ARTWORK/1)
        Textures shown when the item is part of one of the first
        four EquipmentSets.

----------------------------------------------------------------------------]]--

local function ContainerItemIsPartOfEquipmentSet(bag, slot, i)
    local _,equipSetNames = GetContainerItemEquipmentSetInfo(bag, slot)

    if not equipSetNames then return end

    local name = GetEquipmentSetInfo(i)
    for _,n in ipairs({ strsplit(", " , equipSetNames) }) do
        if n == name then return true end
    end
    return false
end

local texData = {
    [1] = {
        parentKey = "eqTexture1",
        point = "BOTTOMRIGHT",
        level = "ARTWORK",
        subLevel = 1,
        coords = { 0.0, 0.5, 0.0, 0.5 }
    },
    [2] = {
        parent = "LiteBagEquipSetsTexture",
        parentKey = "eqTexture2",
        point = "BOTTOMLEFT",
        level = "ARTWORK",
        subLevel = 1,
        coords = { 0.5, 1.0, 0.0, 0.5 },
    },
    [3] = {
        parentKey = "eqTexture3",
        point = "TOPLEFT",
        level = "ARTWORK",
        subLevel = 1,
        coords = { 0.5, 1.0, 0.5, 1.0 },
    },
    [4] = {
        parentKey = "eqTexture4",
        point = "TOPRIGHT",
        level = "ARTWORK",
        subLevel = 1,
        coords = { 0.0, 0.5, 0.5, 1.0 },
    },
}

local function MakeTexture(frame, td)
    local tex = frame:CreateTexture(
                    frame:GetName() .. td.parentKey,
                    td.level,
                    "LiteBagEquipSetsTexture",
                    td.subLevel
                )
    tex:ClearAllPoints()
    tex:SetPoint(td.point, frame, "CENTER")
    tex:SetSize(16, 16)
    tex:SetTexCoord(unpack(td.coords))
    return tex
end

local function AddTextures(b)
    for i, td in ipairs(texData) do
        b[td.parentKey] = MakeTexture(b, td)
    end
end

local function Update(button)
    local bag = button:GetParent():GetID()
    local slot = button:GetID()

    if not button.eqTexture1 then
        AddTextures(button)
    end

    for i = 1,4 do
        local tex = _G[button:GetName() .. "eqTexture" .. i]
        if LiteBag_GetGlobalOption("HideEquipsetIcon") == nil and
           ContainerItemIsPartOfEquipmentSet(bag, slot, i) then
            tex:Show()
        else
            tex:Hide()
        end
    end
end

hooksecurefunc(
    "LiteBagItemButton_Update",
    function (b)
        Update(b)
    end
)

hooksecurefunc(
    "LiteBagPanel_OnShow",
    function (f) f:RegisterEvent("EQUIPMENT_SETS_CHANGED") end
)

hooksecurefunc(
    "LiteBagPanel_OnHide",
    function(f) f:UnregisterEvent("EQUIPMENT_SETS_CHANGED") end
)
