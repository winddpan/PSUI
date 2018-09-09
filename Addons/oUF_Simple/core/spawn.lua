
-- oUF_Simple: core/spawn
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...
local oUF = L.oUF or oUF

-----------------------------
-- Register Style
-----------------------------

if L.F.CreatePlayerStyle then oUF:RegisterStyle(A.."Player", L.F.CreatePlayerStyle) end
if L.F.CreateTargetStyle then oUF:RegisterStyle(A.."Target", L.F.CreateTargetStyle) end
if L.F.CreateTargetTargetStyle then oUF:RegisterStyle(A.."TargetTarget", L.F.CreateTargetTargetStyle) end
if L.F.CreatePetStyle then oUF:RegisterStyle(A.."Pet", L.F.CreatePetStyle) end
if L.F.CreateFocusStyle then oUF:RegisterStyle(A.."Focus", L.F.CreateFocusStyle) end
if L.F.CreateMouseoverStyle then oUF:RegisterStyle(A.."Mouseover", L.F.CreateMouseoverStyle) end
if L.F.CreatePartyStyle then oUF:RegisterStyle(A.."Party", L.F.CreatePartyStyle) end
if L.F.CreateBossStyle then oUF:RegisterStyle(A.."Boss", L.F.CreateBossStyle) end
if L.F.CreateNamePlateStyle then oUF:RegisterStyle(A.."Nameplate",L.F.CreateNamePlateStyle) end
if L.F.CreateRaidStyle then oUF:RegisterStyle(A.."Raid", L.F.CreateRaidStyle) end

-----------------------------
-- Spawn Units
-----------------------------

--spawn player
if L.F.CreatePlayerStyle then
  oUF:SetActiveStyle(A.."Player")
  local player = oUF:Spawn("player", A.."Player")
  --show/hide the frame on a given state driver
  if player.cfg.frameVisibility then
    player:Disable()
    --frameVisibility needed for rLib drag and drop
    player.frameVisibility = player.cfg.frameVisibility
    RegisterStateDriver(player, "visibility", player.cfg.frameVisibility)
  end
end

--spawn target
if L.F.CreateTargetStyle then
  oUF:SetActiveStyle(A.."Target")
  oUF:Spawn("target", A.."Target")
end

--spawn targettarget
if L.F.CreateTargetTargetStyle then
  oUF:SetActiveStyle(A.."TargetTarget")
  oUF:Spawn("targettarget", A.."TargetTarget")
end

--spawn pet
if L.F.CreatePetStyle then
  oUF:SetActiveStyle(A.."Pet")
  local pet = oUF:Spawn("pet", A.."Pet")
  --show/hide the frame on a given state driver
  if pet.cfg.frameVisibility then
    pet:Disable()
    --frameVisibility needed for rLib drag and drop
    pet.frameVisibility = pet.cfg.frameVisibility
    RegisterStateDriver(pet, "visibility", pet.cfg.frameVisibility)
  end
end

--spawn focus
if L.F.CreateFocusStyle then
  oUF:SetActiveStyle(A.."Focus")
  oUF:Spawn("focus", A.."Focus")
end

--spawn mouseover
if L.F.CreateMouseoverStyle then
  oUF:SetActiveStyle(A.."Mouseover")
  oUF:Spawn("mouseover", A.."Mouseover")
end

--spawn party
if L.F.CreatePartyStyle then
  oUF:SetActiveStyle(A.."Party")
  oUF:SpawnHeader(
    A.."PartyHeader",
    L.C.party.setup.template,
    L.C.party.setup.visibility,
    "showPlayer", L.C.party.setup.showPlayer,
    "showSolo",   L.C.party.setup.showSolo,
    "showParty",  L.C.party.setup.showParty,
    "showRaid",   L.C.party.setup.showRaid,
    "point",      L.C.party.setup.point,
    "xOffset",    L.C.party.setup.xOffset,
    "yOffset",    L.C.party.setup.yOffset,
    "oUF-initialConfigFunction", ([[
      self:SetWidth(%d)
      self:SetHeight(%d)
      self:GetParent():SetScale(%f)
    ]]):format(L.C.party.size[1], L.C.party.size[2], L.C.party.scale)
  ):SetPoint(unpack(L.C.party.point))
end

--spawn boss frames
if L.F.CreateBossStyle then
  oUF:SetActiveStyle(A.."Boss")
  local boss = {}
  for i = 1, MAX_BOSS_FRAMES do
    boss[i] = oUF:Spawn("boss"..i, A.."Boss"..i)
    if (i == 1) then
      boss[i]:SetPoint(unpack(L.C.boss.point))
    else
      boss[i]:SetPoint(L.C.boss.setup.point, boss[i-1], L.C.boss.setup.relativePoint, L.C.boss.setup.xOffset, L.C.boss.setup.yOffset)
    end
  end
end

--spawn nameplates
if L.F.CreateNamePlateStyle then
  oUF:SetActiveStyle(A.."Nameplate")
  oUF:SpawnNamePlates(A, L.C.NamePlateCallback, L.C.NamePlateCVars)
end

--spawn raid
if L.F.CreateRaidStyle then
  oUF:SetActiveStyle(A.."Raid")
  for i=1, NUM_RAID_GROUPS do
    oUF:SpawnHeader(
      A.."RaidHeader"..i,
      L.C.raid.setup.template,
      L.C.raid.setup.visibility,
      "showPlayer", L.C.raid.setup.showPlayer,
      "showSolo",   L.C.raid.setup.showSolo,
      "showParty",  L.C.raid.setup.showParty,
      "showRaid",   L.C.raid.setup.showRaid,
      "point",      L.C.raid.setup.point,
      "xOffset",    L.C.raid.setup.xOffset,
      "yOffset",    L.C.raid.setup.yOffset,
      "groupFilter",    tostring(i),
      "unitsPerColumn", 5,
      "oUF-initialConfigFunction", ([[
        self:SetWidth(%d)
        self:SetHeight(%d)
        self:GetParent():SetScale(%f)
      ]]):format(L.C.raid.size[1], L.C.raid.size[2], L.C.raid.scale)
    ):SetPoint(unpack(L.C.raid.points[i])) --config needs to provide 8 point tables, one for each raid group
  end
end

