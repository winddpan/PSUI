local L = LibStub("AceLocale-3.0"):GetLocale("XentiTargets")

if type(L) ~= "table" then print("|cdc1c1c7fXentiTargets:|r ERROR: Please restart WoW.") return end

local DRData = LibStub("DRData-1.0")
local trackedPlayers = {}
local unitInterrupts = {}
local numDR={
	["stun"]=1,
	--["silence"]=2,
	["incapacitate"]=3,
	--["root"]=4,
	["disorient"]=2,
}

local COMBATLOG_OBJECT_TYPE_PLAYER = COMBATLOG_OBJECT_TYPE_PLAYER
local COMBATLOG_OBJECT_REACTION_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE
local COMBATLOG_OBJECT_CONTROL_PLAYER = COMBATLOG_OBJECT_CONTROL_PLAYER
local strformat = string.format 

local IsSpellKnown, GetSpellInfo, IsRatedBattleground = IsSpellKnown, GetSpellInfo, IsRatedBattleground
local table_sort = table.sort
local RequestBattlefieldScoreData = RequestBattlefieldScoreData
local _G = _G;
local XentiTargets = CreateFrame('Frame', "XentiTargets", UIParent)
local Interface = {PlayerButtons={}, NameplateCache={}, FactionFrame=nil}
local Players = {}
local Classes = {}
local PlayerNamesToIndex = {}
local Settings = {
	Debug = false,
	Test = false,
	ButtonSize = {
		Width = 190,
		Height = 28
	},
	Locked = false,
	MaxPlayers = 15,
	BG_MAPS = {},
	BlizzSort = {},
	DefaultScale = 1

}

local NumPlayers = 0
local PlayerFaction
local PlayerGUID
local Aura_Types = {
	DEFAULT = 0,
	OBJECTIVE = 1
}


XentiTargets.defaults = {}
local auraTable = {
		-- Higher Number is Higher Priority
		[GetSpellInfo(108843)]	= 0,	-- Blazing Speed
		[GetSpellInfo(65081)]	= 0,	-- Body and Soul
		[GetSpellInfo(108212)]	= 0,	-- Burst of Speed
		[GetSpellInfo(68992)]	= 0,	-- Darkflight
		[GetSpellInfo(1850)]	= 0,	-- Dash
		[GetSpellInfo(137452)]	= 0,	-- Displacer Beast
		[GetSpellInfo(114239)]	= 0,	-- Phantasm
		[GetSpellInfo(118922)]	= 0,	-- Posthaste
		[GetSpellInfo(85499)]	= 0,	-- Speed of Light
		[GetSpellInfo(2983)]	= 0,	-- Sprint
		[GetSpellInfo(06898)]	= 0,	-- Stampeding Roar
		[GetSpellInfo(116841)]	= 0, 	-- Tiger's Lust
		-- Movement Reduction Auras (1)
		[GetSpellInfo(5116)]	= 1,	-- Concussive Shot
		[GetSpellInfo(120)]		= 1,	-- Cone of Cold
		[GetSpellInfo(13809)]	= 1,	-- Frost Trap
		-- Purgable Buffs (2)
		--[GetSpellInfo(16188)]	= 2,	-- Ancestral Swiftness
		[GetSpellInfo(31842)]	= 2,	-- Divine Favor
		--[GetSpellInfo(6346)]	= 2,	-- Fear Ward
		[GetSpellInfo(112965)]	= 2,	-- Fingers of Frost
		[GetSpellInfo(1044)]	= 2,	-- Hand of Freedom
		[GetSpellInfo(1022)]	= 2,	-- Hand of Protection
		--[GetSpellInfo(114039)]	= 2,	-- Hand of Purity
		[GetSpellInfo(6940)]	= 2,	-- Hand of Sacrifice
		[GetSpellInfo(11426)]	= 2,	-- Ice Barrier
		[GetSpellInfo(53271)]	= 2,	-- Master's Call
		--[GetSpellInfo(132158)]	= 2,	-- Nature's Swiftness
		--[GetSpellInfo(12043)]	= 2,	-- Presence of Mind
		[GetSpellInfo(48108)]	= 2,	-- Pyroblast!
		[GetSpellInfo(23505)]	= 2,	-- Berserking!
		
		-- Defensive - Damage Redution Auras (3)
		[GetSpellInfo(108271)]	= 3,	-- Astral Shift
		[GetSpellInfo(22812)]	= 3,	-- Barkskin
		[GetSpellInfo(18499)]	= 3,	-- Berserker Rage
		--[GetSpellInfo(111397)]	= 3,	-- Blood Horror
		[GetSpellInfo(74001)]	= 3,	-- Combat Readiness
		[GetSpellInfo(31224)]	= 3,	-- Cloak of Shadows
		[GetSpellInfo(108359)]	= 3,	-- Dark Regeneration
		[GetSpellInfo(118038)]	= 3,	-- Die by the Sword
		[GetSpellInfo(498)]		= 3,	-- Divine Protection
		[GetSpellInfo(5277)]	= 3,	-- Evasion
		[GetSpellInfo(47788)]	= 3,	-- Guardian Spirit
		[GetSpellInfo(48792)]	= 3,	-- Icebound Fortitude
		[GetSpellInfo(66)]		= 3,	-- Invisibility
		[GetSpellInfo(102342)]	= 3,	-- Ironbark
		[GetSpellInfo(12975)]	= 3,	-- Last Stand
		[GetSpellInfo(49039)]	= 3,	-- Lichborne
		[GetSpellInfo(116849)]	= 3,	-- Life Cocoon
		[GetSpellInfo(114028)]	= 3,	-- Mass Spell Reflection
		--[GetSpellInfo(30884)]	= 3,	-- Nature's Guardian
		[GetSpellInfo(124974)]	= 3,	-- Nature's Vigil
		--[GetSpellInfo(137562)]	= 3,	-- Nimble Brew
		[GetSpellInfo(33206)]	= 3,	-- Pain Suppression
		[GetSpellInfo(53480)]	= 3,	-- Roar of Sacrifice
		--[GetSpellInfo(30823)]	= 3,	-- Shamanistic Rage
		[GetSpellInfo(871)]		= 3,	-- Shield Wall
		[GetSpellInfo(112833)]	= 3,	-- Spectral Guise
		[GetSpellInfo(23920)]	= 3,	-- Spell Reflection
		[GetSpellInfo(122470)]	= 3,	-- Touch of Karma
		[GetSpellInfo(61336)]	= 3,	-- Survival Instincts
		-- Offensive - Melee Auras (4)
		[GetSpellInfo(13750)]	= 4,	-- Adrenaline Rush
		[GetSpellInfo(152151)]	= 4,	-- Shadow Reflection
		[GetSpellInfo(107574)]	= 4,	-- Avatar
		--[GetSpellInfo(106952)]	= 4,	-- Berserk
		[GetSpellInfo(12292)]	= 4,	-- Bloodbath
		[GetSpellInfo(51271)]	= 4,	-- Pillar of Frost
		[GetSpellInfo(1719)]	= 4,	-- Recklessness
		--[GetSpellInfo(51713)]	= 4,	-- Shadow Dance
		-- Roots (5)
		[GetSpellInfo(91807)]	= 5,	-- Shambling Rush (Ghoul)
		["96294"]				= 5,	-- Chains of Ice (Chilblains)
		[GetSpellInfo(61685)]	= 5,	-- Charge (Various)
		[GetSpellInfo(116706)]	= 5,	-- Disable
		--[GetSpellInfo(87194)]	= 5,	-- Mind Blast (Glyphed)
		[GetSpellInfo(114404)]	= 5,	-- Void Tendrils
		[GetSpellInfo(64695)]	= 5,	-- Earthgrab
		[GetSpellInfo(64803)]	= 5,	-- Entrapment
		--[GetSpellInfo(63685)]	= 5,	-- Freeze (Frozen Power)
		--[GetSpellInfo(111340)]	= 5,	-- Ice Ward
		[GetSpellInfo(107566)]	= 5,	-- Staggering Shout
		[GetSpellInfo(339)]		= 5,	-- Entangling Roots
		--[GetSpellInfo(113770)]	= 5,	-- Entangling Roots (Force of Nature)
		[GetSpellInfo(33395)]	= 5,	-- Freeze (Water Elemental)
		[GetSpellInfo(122)]		= 5,	-- Frost Nova
		--[GetSpellInfo(102051)]	= 5,	-- Frostjaw
		[GetSpellInfo(102359)]	= 5,	-- Mass Entanglement
		[GetSpellInfo(136634)]	= 5,	-- Narrow Escape
		[GetSpellInfo(105771)]	= 5,	-- Warbringer
		[GetSpellInfo(194249)] = 5, 	--Voidform
		-- Offensive - Ranged / Spell Auras (6)
		[GetSpellInfo(12042)]	= 6,	-- Arcane Power
		[GetSpellInfo(114049)]	= 6,	-- Ascendance
		[GetSpellInfo(31884)]	= 6,	-- Avenging Wrath
		[GetSpellInfo(191427)] =6, --Metamorphosis
		[GetSpellInfo(216113)] =6, --Way of the crane
		--[GetSpellInfo(113858)]	= 6,	-- Dark Soul: Instability
		--[GetSpellInfo(113861)]	= 6,	-- Dark Soul: Knowledge
		--[GetSpellInfo(113860)]	= 6,	-- Dark Soul: Misery
		[GetSpellInfo(16166)]	= 6,	-- Elemental Mastery
		[GetSpellInfo(12472)]	= 6,	-- Icy Veins
		[GetSpellInfo(33891)]	= 6,	-- Incarnation: Tree of Life
		[GetSpellInfo(102560)]	= 6,	-- Incarnation: Chosen of Elune
		[GetSpellInfo(102543)]	= 6,	-- Incarnation: King of the Jungle
		[GetSpellInfo(102558)]	= 6,	-- Incarnation: Son of Ursoc
		[GetSpellInfo(10060)]	= 6,	-- Power Infusion
		[GetSpellInfo(3045)]	= 6,	-- Rapid Fire
		[GetSpellInfo(193526)]	= 6,	-- Trueshot
		--[GetSpellInfo(48505)]	= 6,	-- Starfall
		-- Silence and Spell Immunities Auras (7)
		[GetSpellInfo(31821)]	= 7,	-- Devotion Aura
		--[GetSpellInfo(115723)]	= 7,	-- Glyph of Ice Block
		[GetSpellInfo(8178)]	= 7,	-- Grounding Totem Effect
		[GetSpellInfo(199954)]	= 7,	-- Curse of fragility warlock
		[GetSpellInfo(198817)]	= 7,	-- Sharpen Blade Arms warrior
		[GetSpellInfo(131558)]	= 7,	-- Spiritwalker's Aegis
		[GetSpellInfo(104773)]	= 7,	-- Unending Resolve
		[GetSpellInfo(124488)]	= 7,	-- Zen Focus
		--[GetSpellInfo(159630)]  = 7,    -- Shadow Magic
		-- Silence Auras (8)
		[GetSpellInfo(1330)]	= 8,	-- Garrote (Silence)
		[GetSpellInfo(15487)]	= 8,	-- Silence
		[GetSpellInfo(47476)]	= 8,	-- Strangulate
		[GetSpellInfo(31935)]	= 8,	-- Avenger's Shield
		--[GetSpellInfo(137460)]	= 8,	-- Ring of Peace
		[GetSpellInfo(28730)]	= 8,	-- Arcane Torrent (Mana version)
		[GetSpellInfo(80483)]	= 8,	-- Arcane Torrent (Focus version)
		[GetSpellInfo(25046)]	= 8,	-- Arcane Torrent (Energy version)
		[GetSpellInfo(50613)]	= 8,	-- Arcane Torrent (Runic Power version)
		[GetSpellInfo(69179)]	= 8,	-- Arcane Torrent (Rage version)
		
		-- Disorients & Stuns Auras (9)
		[GetSpellInfo(108194)]	= 9,	-- Asphyxiate
		[GetSpellInfo(91800)]	= 9,	-- Gnaw (Ghoul)
		[GetSpellInfo(91797)]	= 9,	-- Monstrous Blow (Dark Transformation Ghoul)
		[GetSpellInfo(89766)]	= 9,	-- Axe Toss (Felguard)
		[GetSpellInfo(117526)]	= 9,	-- Binding Shot
		[GetSpellInfo(224729)]	= 9,	-- Bursting Shot
		[GetSpellInfo(213691)]	= 9,	-- Scatter Shot
		[GetSpellInfo(24394)]	= 9,	-- Intimidation
		[GetSpellInfo(105421)]	= 9,	-- Blinding Light
		[GetSpellInfo(7922)]	= 9,	-- Charge Stun
		--[GetSpellInfo(119392)]	= 9,	-- Charging Ox Wave
		[GetSpellInfo(1833)]	= 9,	-- Cheap Shot
		--[GetSpellInfo(118895)]	= 9,	-- Dragon Roar
		[GetSpellInfo(77505)]	= 9,	-- Earthquake
		[GetSpellInfo(120086)]	= 9,	-- Fist of Fury
		--[GetSpellInfo(44572)]	= 9,	-- Deep Freeze
		[GetSpellInfo(99)]		= 9,	-- Disorienting Roar
		[GetSpellInfo(31661)]	= 9,	-- Dragon's Breath
		--[GetSpellInfo(123393)]	= 9,	-- Breath of Fire (Glyphed)
		--[GetSpellInfo(105593)]	= 9,	-- Fist of Justice
		[GetSpellInfo(47481)]	= 9,	-- Gnaw
		[GetSpellInfo(1776)]	= 9,	-- Gouge
		[GetSpellInfo(853)]		= 9,	-- Hammer of Justice
		--[GetSpellInfo(119072)]	= 9,	-- Holy Wrath
		[GetSpellInfo(88625)]	= 9,	-- Holy Word: Chastise
		[GetSpellInfo(19577)]	= 9,	-- Intimidation
		[GetSpellInfo(408)]		= 9,	-- Kidney Shot
		[GetSpellInfo(119381)]	= 9,	-- Leg Sweep
		[GetSpellInfo(22570)]	= 9,	-- Maim
		[GetSpellInfo(5211)]	= 9,	-- Mighty Bash
		[GetSpellInfo(179057)] = 9, -- Chaos nova
		--[GetSpellInfo(113801)]	= 9,	-- Bash (Treants)
		[GetSpellInfo(118345)]	= 9,	-- Pulverize (Primal Earth Elemental)
		--[GetSpellInfo(115001)]	= 9,	-- Remorseless Winter
		[GetSpellInfo(30283)]	= 9,	-- Shadowfury
		[GetSpellInfo(22703)]	= 9,	-- Summon Infernal
		[GetSpellInfo(46968)]	= 9,	-- Shockwave
		[GetSpellInfo(118905)]	= 9,	-- Static Charge (Capacitor Totem Stun)
		[GetSpellInfo(132169)]	= 9,	-- Storm Bolt
		[GetSpellInfo(20549)]	= 9,	-- War Stomp
		[GetSpellInfo(16979)]	= 9,	-- Wild Charge
		[GetSpellInfo(117526)]  = 9,    -- Binding Shot
		["163505"]              = 9,    -- Rake
		-- Crowd Controls Auras (10)
		[GetSpellInfo(710)]		= 10,	-- Banish
		[GetSpellInfo(2094)]	= 10,	-- Blind
		--[GetSpellInfo(137143)]	= 10,	-- Blood Horror
		[GetSpellInfo(33786)]	= 10,	-- Cyclone
		[GetSpellInfo(200851)] 	= 10, 	--Rage of the sleeper
		[GetSpellInfo(217832)] 	= 10, 	--Imprison
		[GetSpellInfo(605)]		= 10,	-- Dominate Mind
		[GetSpellInfo(118699)]	= 10,	-- Fear
		[GetSpellInfo(3355)]	= 10,	-- Freezing Trap
		[GetSpellInfo(51514)]	= 10,	-- Hex
		[GetSpellInfo(5484)]	= 10,	-- Howl of Terror
		[GetSpellInfo(5246)]	= 10,	-- Intimidating Shout
		[GetSpellInfo(115268)]	= 10,	-- Mesmerize (Shivarra)
		[GetSpellInfo(6789)]	= 10,	-- Mortal Coil
		[GetSpellInfo(115078)]	= 10,	-- Paralysis
		[GetSpellInfo(118)]		= 10,	-- Polymorph
		[GetSpellInfo(8122)]	= 10,	-- Psychic Scream
		[GetSpellInfo(64044)]	= 10,	-- Psychic Horror
		[GetSpellInfo(20066)]	= 10,	-- Repentance
		[GetSpellInfo(82691)]	= 10,	-- Ring of Frost
		[GetSpellInfo(6770)]	= 10,	-- Sap
		[GetSpellInfo(107079)]	= 10,	-- Quaking Palm
		[GetSpellInfo(6358)]	= 10,	-- Seduction (Succubus)
		[GetSpellInfo(9484)]	= 10,	-- Shackle Undead
		--[GetSpellInfo(10326)]	= 10,	-- Turn Evil
		[GetSpellInfo(19386)]	= 10,	-- Wyvern Sting
		-- Immunity Auras (11)
		[GetSpellInfo(48707)]	= 11,	-- Anti-Magic Shell
		[GetSpellInfo(46924)]	= 11,	-- Bladestorm
		--[GetSpellInfo(110913)]	= 11,	-- Dark Bargain
		[GetSpellInfo(19263)]	= 11,	-- Deterrence
		[GetSpellInfo(47585)]	= 11,	-- Dispersion
		[GetSpellInfo(642)]		= 11,	-- Divine Shield
		[GetSpellInfo(232707)]  = 11, -- Ray of hope
		[GetSpellInfo(45438)]	= 11,	-- Ice Block
		[GetSpellInfo(199845)]	= 11,	-- Psyflay  (Psyfiend ability)
		-- Drink (12)
		[GetSpellInfo(118358)]	= 12,	-- Drink
	}
local Tracked_Auras = {
	--[164812]={20,"Moonfire"},
	--[164815]={24,"Sunfire"},
	--[980]={18,"Agony"},
	--[774]={12,"Rejuv"},
	-- flags
	--[156621] =	{-1, Aura_Types.OBJECTIVE}, -- Alliance flag
	--[156618] =	{-1, Aura_Types.OBJECTIVE}, -- Horde flag
	--[34976] =	{-1, Aura_Types.OBJECTIVE}, -- EotS flag
	-- carts
	--[140876] =	{-1, Aura_Types.OBJECTIVE}, -- Alliance Mine Cart
	--[141210] =	{-1, Aura_Types.OBJECTIVE}, -- Horde Mine Cart
	-- orbs
	--[121164] =	{-1, Aura_Types.OBJECTIVE}, -- Blue Orb
	--[121175] =	{-1, Aura_Types.OBJECTIVE}, -- Purple Orb
	--[121177] =	{-1, Aura_Types.OBJECTIVE}, -- Orange Orb
	--[121176] =	{-1, Aura_Types.OBJECTIVE}  -- Green Orb
}

local CCDuration={
	stun={
		[179057] = 5, -- Chaos Nova
		[  5211] = 5, -- Mighty Bash
		[119381] = 5, -- Leg Sweep
		[   853] = 6, -- Hammer of Justice
		[226943] = 4, -- Mind Bomb
		[  1833] = 4, -- Cheap Shot
		[132168] = 4, -- Shockwave
		[132169] = 4, -- Storm Bolt
	},
	disorient={
		[ 33786] = 6, -- Cyclone
		[209753] = 6, --Updated cyclone?
		[  8122] = 8, -- Psychic Scream
		[  2094] = 8, -- Blind
	},
	incapacitate = {
		[115078] = 4, -- Paralysis
	}
}

local kickTime = {
	[47528]=3,--Mind Freeze
	[91802]=2, --Shambling Rush
	[96231]=4,--Rebuke
	[6552]=4,--Pummel
	[106839]=4,--Skull Bash
	[119910]=6,--Spell lock sac
	[19647]=6, --spell lock
	[119911]=6, --Optical Blast
	[115781]=6,--Optical blast
	[132409]=6, --sac spell lock
	[171138]=6, --shadow lock
	[171139]=6, -- ^^
	[171140]=6, -- ^^
	[57994]=3, --Wind shear
	[147362]=3, --Counter Shot
	[2139]=6, -- Counterspell
	[1766]=5,--Kick
	[116705]=4, --Spear hand strike
	[97547]=6, --Solar Beam
}

local Tracked_Cooldowns = {
	
	[42292] = 120, --Old pvp trinket use effect?
	[7744] =  30, -- Will of the Forsaken (Undead)
	[59752] =  30,  -- human
	[20594]=30, --dwarf
	[195710] = 180,  -- 180 No talent PvP Trinket
	[208683] = 120,  -- 120 PvP talent Trinket
	[195901] = 60, -- Adapation PvP Talent
	
}
local Tracked_Racial_Cooldowns={
	
	[7744]=120, -- Will of the forsaken
	[20594]=120, --Stoneform
	[58984]=120, -- Shadowmeld
	[59752] =  120,  -- human

}

local Special_Auras = {
	DEAD = 8326
}

local Aura_Overrides = {
	-- orbs
	[121164] =	'Interface/ICONS/inv_misc_enchantedpearlF', -- Blue Orb
	[121175] =	'Interface/ICONS/inv_misc_enchantedpearlD', -- Purple Orb
	[121177] =	'Interface/ICONS/inv_misc_enchantedpearlC', -- Orange Orb
	[121176] =	'Interface/ICONS/inv_misc_enchantedpearlA' -- Green Orb
}

local Range_Spells = {
	DEATHKNIGHT = 49576, -- Death Grip
	DRUID = 339, -- Entangling Roots
	HUNTER = 75, -- Auto Shot
	MAGE = 2139, -- Counterspell
	MONK = 117952, -- Crackling Jade L
	PALADIN = 20271, -- Judgment
	PRIEST = 585, -- Smite
	ROGUE = 6770, -- Sap
	SHAMAN = 403, -- Lightning Bolt
	WARLOCK = 689, -- Drain Life
	WARRIOR = 100, -- Charge
	DEMONHUNTER= 162794 -- CHaos Strike
}

tinsert(Players, {Name= 'Geoaa', Class='PRIEST',Spec='Disziplin',Health = .3,TargetedBy={},Cooldowns={},Auras={},MaxHealth = 1,Mana = 0.3,MaxMana = 1,LastSeen=1,})
tinsert(Players, {Name= 'Doggydog', Class='DRUID',Spec='Wiederherstellung',Health = 1,TargetedBy={},Cooldowns={},Auras={},MaxHealth = 1,Mana = 0.3,MaxMana = 1,LastSeen=1,})
tinsert(Players, {Name= 'Zekee', Class='MONK',Spec='Nebelwirker',Health = 1,TargetedBy={},Cooldowns={},Auras={},MaxHealth = 1,Mana = 0.3,MaxMana = 1,LastSeen=1,})
tinsert(Players, {Name= 'Melexia', Class='WARRIOR',Spec='Waffen',Health = 1,TargetedBy={},Cooldowns={},Auras={},MaxHealth = 1,Mana = 0.3,MaxMana = 1,LastSeen=1,})
tinsert(Players, {Name= 'Overclocked', Class='WARRIOR',Spec='Waffen',Health = 1,TargetedBy={},Cooldowns={},Auras={},MaxHealth = 1,Mana = 0.3,MaxMana = 1,LastSeen=1,})
tinsert(Players, {Name= 'Adoneal', Class='DRUID',Spec='Gleichgewicht',Health = 1,TargetedBy={},Cooldowns={},Auras={},MaxHealth = 1,Mana = 0.3,MaxMana = 1,LastSeen=1,})
tinsert(Players, {Name= UnitName('player'), Class='DRUID',Spec='Gleichgewicht',Health = 1,TargetedBy={},Cooldowns={},Auras={},MaxHealth = 1,Mana = 0.3,MaxMana = 1,LastSeen=1,})
tinsert(Players, {Name= 'Kyliejennerx', Class='ROGUE',Spec='Kampf',Health = 1,TargetedBy={},Cooldowns={},Auras={},MaxHealth = 1,Mana = 0.3,MaxMana = 1,LastSeen=1,})
tinsert(Players, {Name= 'Styxiez', Class='WARLOCK',Spec='Zerstörung',Health =1,TargetedBy={},Cooldowns={},Auras={},MaxHealth = 1,Mana = 0.3,MaxMana = 1,LastSeen=1,})
tinsert(Players, {Name= 'Zuraa', Class='HUNTER',Spec='Treffsicherheit',Health = 1,TargetedBy={},Cooldowns={},Auras={},MaxHealth = 1,Mana = 0.3,MaxMana = 1,LastSeen=1,})

for i = 1, #CLASS_SORT_ORDER do -- Constants.lua
	Settings.BlizzSort[ CLASS_SORT_ORDER[i] ] = i
end

for classId = 1, MAX_CLASSES do
	local _, classTag = GetClassInfoByID(classId)
	local numSpec = GetNumSpecializationsForClassID(classId)

	Classes[classTag] = {}
	for i = 1, numSpec do
		local id,name,_,icon,role = GetSpecializationInfoForClassID(classId, i)

		if role == "DAMAGER" then
			Classes[classTag][i] = {role = 3, specName = name, icon = icon}
		elseif role == "HEALER" then
			Classes[classTag][i] = {role = 1, specName = name, icon = icon}
		elseif role == "TANK" 
			then Classes[classTag][i] = {role = 2, specName = name, icon = icon}
		end		
	end
end

local RangeCheckSpell
local CurrentTime = GetTime()

local function Print(...) print('|cffffff7fXentiTargets:|r', ...) end
local function Debug(...)
	if Settings.Debug then
		print('|cffffff7fXentiDebug:|r', ...)
	end
end

if L then
	--Print(L["MESSAGES_WELCOME1"]) useless message
	--Print(L["MESSAGES_WELCOME2"])
end	

local Ticker_Counter = 0
local Ticker_Second_Counter = 0
C_Timer.NewTicker(.1,function()
	CurrentTime = GetTime()

	if not NumPlayers or NumPlayers > 30 then
		return
	end

	--Ticker_Counter = Ticker_Counter + 1
	for name, player in pairs(Players) do
		-- Debug('Updating player ', name)
		XentiTargets:UpdatePlayer(player)
	end
	-- Debug('100 MS has ended')
end);

C_Timer.NewTicker(1,function()

	if NumPlayers and NumPlayers > 30 then
		if not InCombatLockdown() then
			XentiTargets:SetShown( false )
		end
		return
	end

	if not InCombatLockdown() then
		XentiTargets:SetShown( XentiTargets:InBattleground(true) )
	end

	if Ticker_Second_Counter > 100 then
		Ticker_Second_Counter = 0
	end

	
	XentiTargets:ScanUnits()
	XentiTargets:CleanUnits()
	XentiTargets:UpdateMainFunctions()
	XentiTargets:CheckNameplates()		
	Ticker_Second_Counter = Ticker_Second_Counter + 1
end);

function XentiTargets:OnEvent(event, ...)
	--if not (InBattleground) then return end

	if event == 'PLAYER_LOGIN' then
		PlayerFaction = UnitFactionGroup('Player')
		PlayerGUID = UnitGUID('player')
		XentiTargets:UnregisterEvent('PLAYER_LOGIN')

		if XentiTargets:InBattleground() then
			wipe(Players)
		end

		XentiTargets:OnAddonLoaded()
		XentiTargets:Initialize()
		XentiTargets:CreateFrames()

		XentiTargets:RegisterEvent("UPDATE_BATTLEFIELD_SCORE")
	
	elseif event == 'COMBAT_LOG_EVENT_UNFILTERED' then
		self:OnCombatEvent(...);
	elseif event == 'PLAYER_TARGET_CHANGED' then
		self:ScanUnit('target');
		self:SnapDots('target');
		self:UnitTargetChanged('player');
	elseif event == '"UPDATE_MOUSEOVER_UNIT"' then
		self:ScanUnit('mouseover');
		self:SnapDots('mouseover');
	elseif event == 'EXECUTE_CHAT_LINE' then
		local name = (...):match('^/targetexact (.*)');
		if name then
			self:CheckTarget(name);
		end
	elseif event == 'UNIT_TARGET' then
		local unit = (...);
		self:ScanUnit(unit..'target');
		self:SnapDots(unit..'target');
		if unit:match('^raid%d+$') and UnitGUID(unit) ~= PlayerGUID then
			self:UnitTargetChanged(unit);
		end
	elseif event == 'UNIT_AURA' then
		local unit = (...);
		if not unit:match('^raid%d+$') then
			self:SnapDots(unit);
		end
	elseif event == 'UPDATE_BATTLEFIELD_SCORE' then
		NumPlayers = GetNumBattlefieldScores()
	elseif event == "CHAT_MSG_BG_SYSTEM_HORDE" then
		local arg1 = ...
		XentiTargets:CarrierCheck(arg1, 0)
	elseif event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" then
		local arg1 = ...
		XentiTargets:CarrierCheck(arg1, 1)
	elseif event == "CHAT_MSG_RAID_BOSS_EMOTE" then
		local arg1 = ...
		XentiTargets:OrbCheck(arg1)
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		currentMapId = nil
		wipe(trackedPlayers)
		wipe(unitInterrupts)
	elseif event=="ARENA_OPPONENT_UPDATE" then
		local arg1=...
		C_PvP.RequestCrowdControlSpell(arg1)
	elseif event =="ARENA_CROWD_CONTROL_SPELL_UPDATE" then
		--ARENA_COOLDOWNS_UPDATE needs also
		local arg1,spellId=...
		
		local unitName=GetUnitName(arg1,true)
		local player = self:GetPlayer(nil, unitName)
		if player and button then
			if spellId==20863 then
				player.Insi=1
				
			elseif spellId==214027 then
				player.Insi=2
			elseif spellId==196029 then
				player.Insi=3
			end
		end
	end
end

local currentMapId
local bgMaps = {}
function XentiTargets:BattlefieldMapCheck()
	if not currentMapId or currentMapId == -1 then
		local wmf = WorldMapFrame
		if wmf and not wmf:IsShown() then
			SetMapToCurrentZone()
			currentMapId = GetCurrentMapAreaID()
			Debug("Setting mapId to ", currentMapId)
		end
	end
end

function XentiTargets:OnAddonLoaded()
	self.dbi = LibStub('AceDB-3.0'):New('XentiTargetsDB', self.defaults)
	self.dbi.RegisterCallback(self, "OnProfileChanged", "UpdateFrame")
	self.dbi.RegisterCallback(self, "OnProfileCopied", "UpdateFrame")
	self.dbi.RegisterCallback(self, "OnProfileReset", "UpdateFrame")

	self.LSM = LibStub("LibSharedMedia-3.0")
	self.LSM:Register('font', 'Arialn', 'Fonts/ARIALN.TTF')
	--button.Name:SetFont('Fonts/ARIALN.TTF', 12, '')

	self.db = setmetatable(self.dbi.profile, {
		__newindex = function(t, index, value)
		if type(value) == "table" then
			rawset(self.defaults.profile, index, value)
		end
		rawset(t, index, value)
	end})
end

function XentiTargets:UpdateFrame()
	self.db = self.dbi.profile

	if XentiTargets:GetScale() ~= self.db.frameScale then
		XentiTargets:SetScale(self.db.frameScale)
	end

	-- doing button width check here! :)
	for i = 1, Settings.MaxPlayers do
		-- Debug('Create Button ', i)
		if Interface.Buttons[i] then 
			local width, height = Interface.Buttons[i]:GetSize()

			if width ~= self.db.barWidth then
				Interface.Buttons[i]:SetSize(self.db.barWidth, height)
			end

			Interface.Buttons[i].Name:SetFont(self.LSM:Fetch(self.LSM.MediaType.FONT, self.db.globalFont), (self.db.useGlobalFontSize and self.db.globalFontSize or 12))
		end
	end
end

local otherFaction
local carrier, carrierSpell
local orbData = {}
function XentiTargets:CarrierCheck(message, faction)

	otherFaction = (PlayerFaction == 'Alliance') and
		(UnitAura('Player','Horde') and 1 or 0) or
		(UnitAura('Player','Alliance') and 0 or 1)

	-- what kind of bg are we in?
	Debug('Enemy ', otherFaction, ' and message ', faction)
	--Debug('Current carrier ', carrier)
	--if EnemyFaction ~= faction then
	--	return
	--end

	-- only 
	if currentMapId == 856 or currentMapId == 482 or currentMapId == 935 then
		if  otherFaction ~= faction then
			return
		end
	else
		if otherFaction == faction then
			return
		end
	end

	if not L then
		Debug('Did not found BG_MESSAGE')
		return
	end

	
	if currentMapId == 443 or currentMapId == 626 or currentMapId == 935 then -- warsong - twin peaks - deepwind
		-- flag picked
		carrierMessage = strmatch(message, L["BG_MESSAGE_WG_TP_DG_PICKED"]) or strmatch(message, L["BG_MESSAGE_EOTS_PICKED"])
		if carrierMessage then
			carrier = carrierMessage
			carrierSpell = self:GetSpellByBGFaction(otherFaction)
			Debug('Flag picked by ', carrier)
		elseif strmatch(message, L["BG_MESSAGE_WG_TP_DG_DROPPED"]) then
			carrier = nil
			carrierSpell = nil
			Debug('Flag has been dropped')
		elseif strmatch(message, L["BG_MESSAGE_WG_TP_DG_CAPTURED"]) then
			carrier = nil
			carrierSpell = nil
			Debug('Flag has been captured')
		end

	elseif currentMapId == 482 then -- eye of the storm
		-- flag picked
		carrierMessage = strmatch(message, L["BG_MESSAGE_EOTS_PICKED"])

		if carrierMessage then
			carrier = carrierMessage
			carrierSpell = self:GetSpellByBGFaction(otherFaction)
			Debug('Flag picked by ', carrier)
		elseif strmatch(message, L["BG_MESSAGE_EOTS_DROPPED"]) then
			carrier = nil
			carrierSpell = nil
			Debug('Flag has been dropped')
		elseif strmatch(message, L["BG_MESSAGE_EOTS_CAPTURED"]) then
			carrier = nil
			carrierSpell = nil
			Debug('Flag has been captured')
		end

	elseif currentMapId == 856 then -- temple
		Debug('CHeck for orb')
		local orbCarrier, orbColor = strmatch(message, L["BG_MESSAGE_TOK_TAKEN"])

		if orbCarrier and orbColor then
			Debug('Found ', orbCarrier, ' who grapped ', orbColor)
			orbColor = self:GetOrbByColor(orbColor)
			orbData[orbColor] = orbCarrier
		else
			orbColor = strmatch(message, L["BG_MESSAGE_TOK_RETURNED"])

			if orbColor then
				orbColor = self:GetOrbByColor(orbColor)
				Debug('Orb Dropped ', orbColor)
			end
		end
	end

	--Debug('Have carrier ', carrier, ' with spell ', carrierSpell)
end

function XentiTargets:GetSpellByBGFaction(faction)
	if not currentMapId or currentMapId == -1 then
		return nil
	end

	-- 0 = alliance, 1 = horde
	local flagSpell
	if currentMapId == 443 then
		if faction == 1 then
			flagSpell = 156618
		else
			flagSpell = 156621
		end
	elseif currentMapId == 626 then
		if faction == 1 then
			flagSpell = 156618
		else
			flagSpell = 156621
		end
	elseif currentMapId == 935 then
		if faction == 1 then
			flagSpell = 141210
		else
			flagSpell = 140876
		end
	elseif currentMapId == 482 then
		flagSpell = 34976
	end

	return flagSpell
end

function XentiTargets:GetOrbByColor(color)
	local code = strmatch(color, "^|cFF%x%x%x%x%x(%x).*|r$")
	if code == "7" then
		return 121164 -- blue
	elseif code == "F" then
		return 121175 -- purple
	elseif code == "1" then
		return 121176  -- greem
	elseif code == "0" then
		return 121177 -- orange
	else
		return nil
	end
end

function XentiTargets:OrbCheck(message)
	if not L then
		Debug('Did not found BG_MESSAGE')
		return
	end

	local orbColor = strmatch(message, L["BG_MESSAGE_TOK_RETURNED"])

	if orbColor then
		Debug('Delete orb ', orbColor)
		orbColor = self:GetOrbByColor(orbColor)
		Debug('spell ', orbColor)
		orbData[orbColor] = nil
	end
end

-- Updates the TargetedBy tables.
function XentiTargets:UnitTargetChanged(unit)
	local guid = UnitGUID(unit..'target');
	for name,player in pairs(Players) do
		player.TargetedBy[unit] = (guid and player.GUID == guid) or nil;
		self:UpdateTargetIndicators(player,player.TargetedBy)
	end
end

-- Shows/Hides targeting indicators for a button
function XentiTargets:UpdateTargetIndicators(player,units)
	local btn = self:GetPlayerButton(player)

	if not btn then
		return
	end

	local i = 1;
	local x = 0;
	for unit in pairs(units) do
		local indicator = btn.TargetIndicators[i];
		if not indicator then
			indicator = CreateFrame('frame',nil,btn.Health);
			btn.TargetIndicators[i] = indicator;
			indicator:SetSize(8,10);
			indicator:SetPoint('TOP',floor(i/2)*(i%2==0 and -10 or 10), 0);
			indicator:SetBackdrop({
				bgFile = "Interface/Buttons/GreyscaleRamp64",
				edgeFile = "Interface/Buttons/WHITE8X8",
				edgeSize = 1,
			});
			indicator:SetBackdropBorderColor(0,0,0,1);
		end
		local className,class = UnitClass(unit);
		local c = RAID_CLASS_COLORS[class or 'PRIEST'];
		indicator:SetBackdropColor(c.r,c.g,c.b);
		indicator:Show();
		i = i+1;
	end
	while btn.TargetIndicators[i] do
		btn.TargetIndicators[i]:Hide();
		i = i+1;
	end
end

function XentiTargets:Initialize()


	local _, playerClass = UnitClass('player')
	local spellId = Range_Spells[playerClass]
	if spellId then
		if IsSpellKnown(spellId) then
			local spellName, _, _, _, _, _ = GetSpellInfo(spellId)
			RangeCheckSpell = spellName
		end
	end

	Debug('RangeCheckSpell ', RangeCheckSpell)
end

function XentiTargets:CreateFrames()
	-- Interface.Main = XentiTargets

	XentiTargets:SetSize(200, 200)
	XentiTargets:SetClampedToScreen(true)
	XentiTargets:SetMovable(true)
	XentiTargets:SetUserPlaced(true)
	XentiTargets:SetResizable(true)
	XentiTargets:SetToplevel(true)
	XentiTargets:SetScale(self.db.frameScale)

	_G['XentiTargets']:ClearAllPoints()
	if not self.db.x and not self.db.y then
		_G['XentiTargets']:SetPoint("CENTER")
	else
		local scale = _G['XentiTargets']:GetEffectiveScale()
		_G['XentiTargets']:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.x / scale, self.db.y / scale)
	end

	-- pre-create buttons
	Interface.Buttons = {}
	for i = 1, Settings.MaxPlayers do
		-- Debug('Create Button ', i)
		Interface.Buttons[i] = self:CreateButton(i)
		Interface.Buttons[i].SetName('XentiButton ' .. i)
	end
end

--Interrupt handling
function XentiTargets:InterruptGained(button,guid)
	if true then return end --
	if not button then
		return
	end
	local frame=button.Spec
	if not frame.text then 
		frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		frame.text:SetWidth(50)
		frame.text:SetPoint("CENTER", frame, "CENTER", 0, 0)
		frame.text:SetJustifyH("CENTER")
		frame.text:SetShadowOffset(0, 0)
		frame.text:SetShadowColor(0, 0, 0, 0)
		frame.text:SetTextColor(1, 1, 1, 1)
		frame.text:SetFont('Fonts/ARIALN.TTF', 16, 'THINOUTLINE')
	end
	
	frame.guid=guid
	if not unitInterrupts[guid] then return end
	if not unitInterrupts[guid].expires then return end
	frame.timeLeft=unitInterrupts[guid].expires-GetTime()
	if frame.timeLeft<0 then return end
	local _, _, icon, _ =GetSpellInfo(unitInterrupts[guid].extraspell)
	frame.Icon:SetTexture(icon)
	frame.text:Show()
	frame.active=true
	frame.Swipe:SetCooldown(unitInterrupts[guid].t,unitInterrupts[guid].d)
	frame.Swipe:SetHideCountdownNumbers(true)
	frame:SetScript("OnUpdate",function(f,elapsed) 
		f.timeLeft = f.timeLeft - elapsed
		if f.timeLeft <= 0 then
			frame.Icon:SetTexture(frame.Icon.SpecTex)
			frame.text:Hide()
			frame.active=false
		else
			frame.text:SetText(strformat("%.1f", f.timeLeft))
		end
	end 
	)
end


--DR Handling

function XentiTargets:CheckRelentless(diminish,cat,spellID,dstName)
	if not CCDuration[cat] then return end
	local dur = CCDuration[cat][spellID]
	local player = self:GetPlayer(nil, dstName)
	if (not dur) or (not player) then return end
	if player.Insi and player.Insi~=3 then
		return
	end
	local CCreduc,CCrelent= 0, 0.2
	local spellName,_=GetSpellInfo(spellID)
	local apDur
	if player.Unit then
		_,_,_,_,_,apDur=UnitDebuff(player.Unit,spellName)
	else
		--print(player.Name .. " has no unit")
	end
	if not apDur then
		return 
	end
	if cat=="stun" and player.Race=="Orc" then
		--Hardiness
		CCreduc,CCrelent = CCreduc+0.2, CCrelent+0.2
		
	end
	local normDur,relentDur=(dur*(1-CCreduc))*diminish , (dur*(1-CCrelent))*diminish
	--print(spellName .. " dur: " .. apDur .. " normduration: " .. normDur .. " relentless: " ..relentDur)
	if apDur<relentDur then
		return
	elseif apDur<normDur and apDur>=relentDur then
		--Probably relentless
		player.Insi=3
	
	end

end

function XentiTargets:CCdebuffGained(spellID ,destGUID,dstName)
	-- Not a player, and this category isn't diminished in PVE, as well as make sure we want to track NPCs
	local drCat = DRData:GetSpellCategory(spellID)
	

	if( not trackedPlayers[destGUID] ) then
		trackedPlayers[destGUID] = {}
	end

	-- See if we should reset it back to undiminished
	if( not trackedPlayers[destGUID][drCat] ) then
		trackedPlayers[destGUID][drCat] = {reset=0,diminished = 1.0 }
	end
	local tracked = trackedPlayers[destGUID][drCat]
	if( tracked and tracked.reset <= GetTime() ) then
		tracked.diminished = 1.0
	end
	self:CheckRelentless(tracked.diminished,drCat,spellID,dstName)
	tracked.diminished = DRData:NextDR(tracked.diminished, drCat)
	
	--TODO:Add duration prediction
end

function XentiTargets:CCdebuffFaded(spellID,destGUID,dstName)
	local drCat = DRData:GetSpellCategory(spellID)
	local curButton = self:GetPlayerButton(nil, dstName)

	local drTexts = {
		[1] = {"\194\189", 0, 1, 0},
		[0.5] = {"\194\188", 1, 0.65, 0},
		[0.25] = {"%", 1, 0, 0},
		[0] = {"%", 1, 0, 0},
	}
	
	if( not trackedPlayers[destGUID] ) then
		trackedPlayers[destGUID] = {}
	end

	if( not trackedPlayers[destGUID][drCat] ) then
		trackedPlayers[destGUID][drCat] = { reset = 0, diminished = 1.0 }
	end

	local time = GetTime()
	local tracked = trackedPlayers[destGUID][drCat]
	local timeLeft = DRData:GetResetTime(drCat)
	tracked.reset = time + timeLeft
	
	
	_, _, icon, _ =GetSpellInfo(spellID)
	-- Diminishing returns changed, now you can do an update

	--[[curButton.DR[drCat].Icon:SetTexture(icon)
	curButton.DR[drCat]:Show()
	curButton.DR[drCat].Swipe:SetCooldown(time,DRData:GetResetTime(drCat))
	curButton.DR[drCat].End=tracked.reset
	--]]
	
	if not numDR[drCat] then
		return
	end
	if type(curButton)=="boolean" then 
		return
	end
	local text, r, g, b = unpack(drTexts[tracked.diminished])
	local frame = curButton.DR[drCat]
	if not frame.text then 
		frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		frame.text:SetWidth(50)
		frame.text:SetPoint("CENTER", frame, "CENTER", 0, 0)
		frame.text:SetJustifyH("CENTER")
		frame.text:SetShadowOffset(0, 0)
		frame.text:SetShadowColor(0, 0, 0, 0)
		frame.text:SetTextColor(1, 1, 1, 1)
		frame.text:SetFont('Fonts/ARIALN.TTF', 16, 'THINOUTLINE')
	end
	frame.timeLeft = timeLeft
	frame.reset = tracked.reset
	frame.icon:SetTexture(icon)
	frame.active=true
	frame.text:SetText(text)
	frame.text:SetTextColor(r,g,b)
	frame:Show()
	frame:SetScript("OnUpdate",function(f,elapsed)
		f.timeLeft = f.timeLeft - elapsed
		
		if f.timeLeft <= 0 then
			f.active = false
			frame:SetScript("OnUpdate",nil)
			frame:Hide()
		else
			if f.timeLeft>5 then
				frame.text:SetText(strformat("%.0f", f.timeLeft))
			else
				frame.text:SetText(strformat("%.1f", f.timeLeft))
			end
		end
		
		
	end)

end

function XentiTargets:resetDR(destGUID,srcName)
	-- Reset the tracked DRs for this person
	if( trackedPlayers[destGUID] ) then
		for cat in pairs(trackedPlayers[destGUID]) do
			trackedPlayers[destGUID][cat].reset = 0
			trackedPlayers[destGUID][cat].diminished = 1.0
		end
	end
end


function XentiTargets:OnCombatEvent(timestamp,event,hide,srcGUID,srcName,srcF1,srcF2,destGUID,destName,destF1,destF2,spellId,_,_,extraSpellID)
	if event == 'SPELL_CAST_SUCCESS' then
		local button = self:GetPlayerButton(nil, srcName)
		local relent=nil
		if (not button) or not (Tracked_Cooldowns[spellId] or Tracked_Racial_Cooldowns[spellId])  then
			return
		end
		local player= self:GetPlayer(nil, srcName)
		if spellId==195710 then
			button.Insi.Icon:SetTexture("Interface/Icons/Sha_ability_rogue_sturdyrecuperate")
		elseif spellId==208683 then
			
			player.Insi=1
		end
		if player.Insi==3 and (spellId==20594 or spellId==59752 or spellId==7744) then
			--if we have relentless as detected trinket and racial was used don't incur cd
			relent=true
		end
		if Tracked_Cooldowns[spellId] then
			self:StartCooldown( button, spellId, Tracked_Cooldowns[spellId] or 120,relent );
		end
		if Tracked_Racial_Cooldowns[spellId] then
			self:StartRacialCD(button, spellId, Tracked_Racial_Cooldowns[spellId])
		end
	elseif event == 'UNIT_DIED' then
		local player = self:GetPlayer(nil, destName)

		if player and destGUID:sub(1,6) == 'Player' then
			player.Health = 0;
			player.Mana = 0;

			self:SetPlayerDead(player, CurrentTime+27, 27)
			self:UpdateAura(player)
		end
	elseif event=="SPELL_INTERRUPT" then
		local button = self:GetPlayerButton(nil, destName)

		if not button then
			return
		end
		local cTime=GetTime()
		unitInterrupts[destGUID]={}
		unitInterrupts[destGUID].d=kickTime[spellId]
		if unitInterrupts[destGUID].d then
			unitInterrupts[destGUID].t=cTime
			unitInterrupts[destGUID].expires=cTime+unitInterrupts[destGUID].d
			unitInterrupts[destGUID].extraspell=extraSpellID
			unitInterrupts[destGUID].icon=GetSpellTexture(spellId)
			--GetSpellTexture
			unitInterrupts[destGUID].spell=spellId
			
			--C_Timer.After(unitInterrupts[dstGUID].d,clearGUID(dstGUID) )
		else
			unitInterrupts[destGUID]=nil
		end
		--Automatic cleanup
		local length=table.getn(unitInterrupts)
		if length>20 then
			for i,v in pairs(unitInterrupts) do
				if unitInterrupts[v].expires<cTime then
					table.remove(unitInterrupts,i)
				end
			end
		end
		self:InterruptGained(button,destGUID)
		
	--[[elseif event:sub(1,10) == 'SPELL_AURA' then
		local player = self:GetPlayer(nil, destName)

		if not player then
			return
		end

		local spell = spellId
		local info = Tracked_Auras[spell]
		
		if info then
			self:UpdateAura(player)
		end
		
		if false then --info before
			local remaining, duration = 0, info[1]

			local expires = -1
			if duration then
				if event == 'SPELL_AURA_APPLIED' then
					expires=CurrentTime+duration
				elseif event == 'SPELL_AURA_REFRESH' then
					expires = CurrentTime + duration + 6
					duration=duration + 6
				end
				
			end

			self:SetAura(player, spell, expires, duration)
			self:UpdateAura(player)
		end	
		--]]
	elseif event == "SPELL_AURA_APPLIED" then
		if spellId==195901 then
			local button = self:GetPlayerButton(nil, srcName)
			local player=self:GetPlayer(nil,srcName)
			if button then
				player.Insi=2
				button.Insi.Icon:SetTexture("Interface/Icons/Sha_ability_rogue_sturdyrecuperate")
				self:StartCooldown( button, spellId, 60 );
			end
			
		end
		if(DRData:GetSpellCategory(spellId) ) then
			local isPlayer = (bit.band(destF1, COMBATLOG_OBJECT_TYPE_PLAYER) == COMBATLOG_OBJECT_TYPE_PLAYER or bit.band(destF1, COMBATLOG_OBJECT_CONTROL_PLAYER) == COMBATLOG_OBJECT_CONTROL_PLAYER )
			if isPlayer and (bit.band(destF1, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE) then
				self:CCdebuffGained(spellId,destGUID,destName)
			end
			
		end
		local info = Tracked_Auras[spell]
		if info then
			local player = self:GetPlayer(nil, destName)
			if player then
				local duration=info[1]
				local expires=CurrentTime+duration
				self:SetAura(player, spell, expires, duration)
				self:UpdateAura(player)
			end		
		end
		
	elseif event == "SPELL_AURA_REFRESH" then
		if(DRData:GetSpellCategory(spellId) ) then
			local isPlayer = ( bit.band(destF1, COMBATLOG_OBJECT_TYPE_PLAYER) == COMBATLOG_OBJECT_TYPE_PLAYER or bit.band(destF1, COMBATLOG_OBJECT_CONTROL_PLAYER) == COMBATLOG_OBJECT_CONTROL_PLAYER )
			if isPlayer and (bit.band(destF1, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE) then
				self:CCdebuffFaded(spellId, destGUID,destName)
				self:CCdebuffGained(spellId, destGUID,destName)
			end
		end
		local info = Tracked_Auras[spell]
		if info then
			local player = self:GetPlayer(nil, destName)
			if player then
				local duration=info[1]*1.3
				local expires=CurrentTime+duration
				self:SetAura(player, spell, expires, duration)
				self:UpdateAura(player)
			end		
		end
	elseif event == "SPELL_AURA_REMOVED" then
		
		if(DRData:GetSpellCategory(spellId) ) then
			local isPlayer = ( bit.band(destF1, COMBATLOG_OBJECT_TYPE_PLAYER) == COMBATLOG_OBJECT_TYPE_PLAYER or bit.band(destF1, COMBATLOG_OBJECT_CONTROL_PLAYER) == COMBATLOG_OBJECT_CONTROL_PLAYER )
			if isPlayer and (bit.band(destF1, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE) then
				self:CCdebuffFaded(spellId, destGUID,destName)
			end			
		end
		
	
	end
end

function XentiTargets:StartCooldown(button, spellId, duration,relent)
	
		
	--elseif spellId == 7744 or spellId == 59752 or spellId == 20594  then
	
	if duration and not relent then
		if button.Insi.End <= CurrentTime+30 then --Using racials while having less than 30 sec of
			button.Insi.Swipe:SetCooldown(CurrentTime, duration)
			button.Insi.End = CurrentTime+duration
			button.Insi:Show()
			--end = 10s cTime=5s duration = 6s
		end
	end
	
end
function XentiTargets:StartRacialCD(button, spellId, duration)
	
	button.Racial.Swipe:SetCooldown(CurrentTime, duration)
	button.Racial.End = CurrentTime+duration
	button.Racial:Show()
	local icon=GetSpellTexture(spellId)
	button.Racial.Icon:SetTexture(icon)

			

end

function XentiTargets:SavePosition()
	if not InCombatLockdown() then
		local f = _G['XentiTargets']
		f:StopMovingOrSizing()
		local scale = f:GetEffectiveScale()
		self.db.x= f:GetLeft() * scale
		self.db.y = f:GetTop() * scale
	end
end

function XentiTargets:CreateButton(index)
	local button = CreateFrame('Button', nil, XentiTargets, 'SecureActionButtonTemplate')
	-- initial settings
	button:SetPoint('TOP', 0, 26 - ( index * (Settings.ButtonSize.Height + 1)))
	button:SetSize(self.db.barWidth, Settings.ButtonSize.Height)
	button:SetBackdrop({
		bgFile = "Interface/Buttons/GreyscaleRamp64",
		edgeFile = 'Interface/Buttons/WHITE8X8',
		edgeSize = 1,
	})
	button:SetBackdropBorderColor(0, 0, 0, 1)
	button:Hide()
	
	-- events/scripts
	button:RegisterForClicks('AnyUp')
	button:RegisterForDrag('LeftButton')
	button:SetAttribute('*type1','macro')
	button:SetAttribute('*type2','macro')

	button:SetScript('OnDragStart', function() return XentiTargets.db.locked or XentiTargets:StartMoving() end)
	button:SetScript('OnDragStop', function() XentiTargets:StopMovingOrSizing() XentiTargets:SavePosition() end)

	-- helper
	button.SetVisible = function(visible)  end

	-- health
	button.SetHealth = function(current, max) button.Health:SetValue( current / max ) end
	button.Health = CreateFrame('StatusBar', nil, button)
	button.Health:SetPoint('TOPLEFT', 1, -1)
	button.Health:SetPoint('BOTTOMRIGHT', -1, 1)
	button.Health:SetStatusBarTexture('Interface/Buttons/GreyscaleRamp64')
	button.Health:SetMinMaxValues(0, 1)

	-- name
	button.SetName = function(name) button.Name:SetText(name) end
	button.Name = button.Health:CreateFontString()
	button.Name:SetPoint('TOPLEFT', 5, 0)
	button.Name:SetPoint('BOTTOMRIGHT')
	button.Name:SetFont(self.LSM:Fetch(self.LSM.MediaType.FONT, self.db.globalFont), (self.db.useGlobalFontSize and self.db.globalFontSize or 12))
	--button.Name:SetFont('Fonts/ARIALN.TTF', 12, '')
	button.Name:SetJustifyH('LEFT')
	button.Name:SetTextColor(1, 1, 1)
	button.Name:SetShadowColor(0, 0, 0, 1)
	button.Name:SetShadowOffset(1, -1)
	button.Name:SetDrawLayer('ARTWORK', 2)
	-- extended info (e.g. orb debuff)
	button.SetInfo = function(info) button.Info:SetText(info) end
	button.Info = button.Health:CreateFontString()
	-- spec
	button.Spec = CreateFrame('Frame', nil, button)
	button.Spec.active=false
	button.Spec:SetPoint('RIGHT', button, 'LEFT',-1,0);
	button.Spec:SetSize(36,26);
	button.Spec.Icon = button.Spec:CreateTexture()
	button.Spec.Icon:SetPoint('CENTER', button.Spec, 'CENTER',0,0);
	button.Spec.Icon:SetSize(36,26);
	button.Spec.Icon:SetTexCoord( 4/64, (4+56)/64, 12/64, (12+40)/64 );
	button.Spec.Icon:SetDrawLayer('ARTWORK',2);
	button.Spec.Icon:SetTexture('Interface/ICONS/INV_Jewelry_TrinketPVP_01')
	button.Spec.Icon.SpecTex='Interface/ICONS/INV_Jewelry_TrinketPVP_01'
	button.Spec.Swipe = CreateFrame("Cooldown", nil, button.Spec)
	button.Spec.Swipe:SetAllPoints()
	button.Spec.Swipe:SetSwipeTexture('Interface/Buttons/WHITE8X8')
	button.Spec.Swipe:SetSwipeColor(0, 0, 0, 0.75)
	button.Spec.End = 0
	
	
	
	-- Diminishing Returns
	button.DR={}
	local i=1
	for k,v in pairs(numDR) do
		button.DR[k] = CreateFrame('Frame', nil, button)
		button.DR[k]:SetPoint('RIGHT', button, 'LEFT',-46+(i*31*-1),0);
		button.DR[k]:SetSize(30,26);
		button.DR[k]:Hide()
		
		button.DR[k].icon =  button.DR[k]:CreateTexture(nil, "BORDER")
		button.DR[k].icon:SetAllPoints()
		button.DR[k].icon:SetTexCoord( 4/64, 59/64, 12/64, 52/64 );
		button.DR[k].icon:SetTexture('Interface/ICONS/INV_Jewelry_TrinketPVP_01')
		
		
		
		button.DR[k].Swipe = CreateFrame("Cooldown", nil, button.DR[k])
		button.DR[k].Swipe:SetAllPoints()
		button.DR[k].Swipe:SetSwipeTexture('Interface/Buttons/WHITE8X8')
		button.DR[k].Swipe:SetSwipeColor(0, 0, 0, 0.40)
		button.DR[k].Swipe:HookScript("OnDisable", function(self) self:GetParent():Hide() end)
		button.DR[k].End=0
		i=i+1
	end
	
	--[[
		button.DR[k].Text = button.DR[k]:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		button.DR[k].Text:SetWidth(50)
		button.DR[k].Text:SetPoint("CENTER", button.DR[k], "CENTER", 0, 0)
		button.DR[k].Text:SetJustifyH("CENTER")
		button.DR[k].Text:SetShadowOffset(0, 0)
		button.DR[k].Text:SetShadowColor(0, 0, 0, 0)
		button.DR[k].Text:SetTextColor(1, 1, 1, 1)
		button.DR[k].Text:SetFont('Fonts/ARIALN.TTF', 16, 'THINOUTLINE')
	
	--]]
	
	-- objective
	button.Objective = CreateFrame('Frame', nil, button)
	button.Objective:SetPoint('RIGHT', button, 'LEFT',-40,0);
	button.Objective:SetSize(36,26);

	button.Objective.Icon = button.Objective:CreateTexture(nil, "BORDER")
	button.Objective.Icon:SetAllPoints()
	button.Objective.Icon:SetTexCoord( 4/64, 59/64, 12/64, 52/64 );
	button.Objective.SetAuraInformations = function(auraInformation)

		button.Objective.AuraText:SetText(auraInformation)
	end
	button.Objective.SetAuraTexture = function(auraTexture) button.Objective.Icon:SetTexture(auraTexture) end
	-- aura information

	button.Objective.AuraText = button.Objective:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	button.Objective.AuraText:SetWidth(50)
	button.Objective.AuraText:SetPoint("CENTER", button.Objective.Icon, "CENTER", 0, 0)
	button.Objective.AuraText:SetJustifyH("CENTER")
	button.Objective.AuraText:SetShadowOffset(0, 0)
	button.Objective.AuraText:SetShadowColor(0, 0, 0, 0)
	button.Objective.AuraText:SetTextColor(1, 1, 1, 1)
	button.Objective.AuraText:SetFont('Fonts/ARIALN.TTF', 16, 'THINOUTLINE')


	button.SetFaction = function(faction)  
		button.Insi.Icon:SetTexture('Interface/ICONS/INV_Jewelry_TrinketPVP_0'..(faction == 1 and 1 or 2)) 
	end

	button.Insi = CreateFrame('Frame', nil, button)
	button.Insi:SetPoint('LEFT', button, 'RIGHT', 1, 0)
	button.Insi:SetSize(26, 26)
	button.Insi.Icon = button.Insi:CreateTexture()
	button.Insi.Icon:SetAllPoints()
	button.Insi.Icon:SetTexCoord(0.075, 0.925, 0.075, 0.925)
	button.Insi.Swipe = CreateFrame("Cooldown", nil, button.Insi)
	button.Insi.Swipe:SetAllPoints()
	button.Insi.Swipe:SetSwipeTexture('Interface/Buttons/WHITE8X8')
	button.Insi.Swipe:SetSwipeColor(0, 0, 0, 0.75)
	button.Insi.End = 0
	
	
	button.Racial = CreateFrame('Frame', nil, button)
	button.Racial:SetPoint('LEFT', button.Insi, 'RIGHT', 1, 0)
	button.Racial:SetSize(26, 26)
	button.Racial.Icon = button.Racial:CreateTexture()
	button.Racial.Icon:SetAllPoints()
	button.Racial.Icon:SetTexCoord(0.075, 0.925, 0.075, 0.925)
	button.Racial.Swipe = CreateFrame("Cooldown", nil, button.Racial)
	button.Racial.Swipe:SetAllPoints()
	button.Racial.Swipe:SetSwipeTexture('Interface/Buttons/WHITE8X8')
	button.Racial.Swipe:SetSwipeColor(0, 0, 0, 0.75)
	button.Racial.End = 0
	button.Racial:Hide()

	-- umrandung der klassen icons
	button.Respawn = CreateFrame('Frame', nil, button)
	button.Respawn:SetPoint('LEFT', button.Racial, 'RIGHT', 1, 0);
	button.Respawn:SetSize(26, 26)
	button.Respawn.Icon = button.Respawn:CreateTexture()
	button.Respawn.Icon:SetAllPoints()
	button.Respawn.Icon:SetTexCoord(0.075,0.925,0.075,0.925);
	button.Respawn.Icon:SetTexture( select(3, GetSpellInfo(8326)))
	button.Respawn.End = 0

	button.Respawn.Swipe = CreateFrame("Cooldown", nil, button.Respawn)
	button.Respawn.Swipe:SetAllPoints()
	button.Respawn.Swipe:SetSwipeTexture('Interface/Buttons/WHITE8X8')
	button.Respawn.Swipe:SetSwipeColor(0, 0, 0, 0.75)
	button.Respawn.Swipe:SetReverse(true)
	button.Respawn:Hide()

	button.TargetIndicators = {}
	button.Cooldowns = {}
	button.Auras = {}

	return button
end

function XentiTargets:SetPlayerDead(enemy,expires,duration,ts)
	if not IsRatedBattleground() then
		return
	end

	local button = self:GetPlayerButton(enemy)

	if button then
		button.Respawn.End = expires
		button.Respawn.Swipe:SetCooldown( expires-duration, duration );
		button.Respawn:Show()
	end
end

function XentiTargets:SetPlayerAlive(enemy)
	if not IsRatedBattleground() then
		return
	end

	local button = self:GetPlayerButton(enemy)

	if button then
		button.Respawn.End = 0
		button.Respawn:Hide()
	end
end

function XentiTargets:InBattleground(allowDebug)
	if allowDebug then
		if Settings.Test then
			return true
		end
	end

	local isInBattleground = select(2, IsInInstance()) == "pvp"

	if isInBattleground then
		self:BattlefieldMapCheck()
		self:BattlefieldScoreRequest()
	else
		-- reset mapid
		currentMapId = nil
	end

	return isInBattleground
end

function XentiTargets:BattlefieldScoreRequest()
	local wssf = WorldStateScoreFrame
	if wssf and wssf:IsShown() then
		return
	end

	RequestBattlefieldScoreData()
end


local EnemyFaction, currPlayer, BattlefieldScoreFaction
hooksecurefunc('SetBattlefieldScoreFaction',function(v)
	BattlefieldScoreFaction = v;
end)
function XentiTargets:ScanUnits()
	if Settings.Test or NumPlayers==0 then
		return
	end
	--if Ticker_Second_Counter % 10 == 0 then
		--Debug('Is in battleground: ', XentiTargets:InBattleground(), ' with ', NumPlayers, ' Player')
	--end	

	EnemyFaction = (PlayerFaction == 'Alliance') and
		(UnitAura('Player','Horde') and 1 or 0) or
		(UnitAura('Player','Alliance') and 0 or 1)

	-- save faction to reset it
	local previousFaction = BattlefieldScoreFaction
	-- we wanna see every
	SetBattlefieldScoreFaction(nil)
	for i = 1, NumPlayers do
		local name,_,_,_,_,faction,_,race,class,_,_,_,_,_,_,spec = GetBattlefieldScore(i)
		currPlayer = nil
		if faction == EnemyFaction and class and spec then
			if not PlayerNamesToIndex[name] then
				currPlayer = {
					Name = name,
					Race = race,
					Class = class,
					Spec = spec,
					Health = 1,
					MaxHealth = 1,
					Mana = 1,
					MaxMana = 1,
					LastSeen = 0,
					TargetedBy = {},
					Cooldowns = {},
					Auras = {},
					TickerCounter = Ticker_Second_Counter
				}

				tinsert(Players, currPlayer)
			elseif Players[PlayerNamesToIndex[name]] then
				currPlayer = Players[PlayerNamesToIndex[name]]
				currPlayer.TickerCounter = Ticker_Second_Counter
				currPlayer.Spec = spec
				currPlayer.Class = class
			end

			if currPlayer then
				local token = Classes[class]
				if token then
					for j = 1, #token do
						if spec == token[j].specName then
							currPlayer.RoleSpec = token[j].role
							currPlayer.Icon = token[j].icon
							break
						end
					end
				end
			end
		end
	end
	SetBattlefieldScoreFaction(previousFaction)
end

function XentiTargets:CleanUnits()
	wipe(Interface.PlayerButtons)
	for i = #Players, 1, -1 do
		currPlayer = Players[i]
		if not Settings.Test and currPlayer.TickerCounter ~= Ticker_Second_Counter then
			PlayerNamesToIndex[currPlayer.Name] = nil
			table.remove(Players, i)
		end
	end
end

local WorldFrameNumChildren = 0;
function XentiTargets:CheckNameplates()
	-- Scan nameplates
	--[[
	local n = WorldFrame:GetNumChildren();
	if n > WorldFrameNumChildren then
		self:CollectNameplates(n,WorldFrame:GetChildren());
	end
	
	for nameplate,elements in pairs(Interface.NameplateCache) do
		if nameplate:IsShown() then
			local text = elements.Name:GetText():match("[^%s]+");
			for i = 1, #Players do
				currPlayer = Players[i]
				if currPlayer then
					local name = currPlayer.Name
					if name:match("[^%-]+") == text then
						currPlayer.LastSeen = CurrentTime+2;
						currPlayer.Health = elements.HealthBar:GetValue();
						currPlayer.MaxHealth = select(2,elements.HealthBar:GetMinMaxValues());
						break;
					end
				end
			end
		end
	end
	--]]
	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
		local unit=frame.UnitFrame.displayedUnit;
		self:SnapDots(unit)
		local uName,realm=UnitName(unit);
		if realm then
			uName=uName..'-'..realm
		end
		local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)
		for i = 1, #Players do
				currPlayer = Players[i]
				if currPlayer then
					local name = currPlayer.Name
					if name==uName then
						currPlayer.LastSeen = CurrentTime+2;
						currPlayer.Health = health;
						currPlayer.MaxHealth = maxHealth;
						currPlayer.Unit=unit
						break
					end
				end
		end
	end
end

local function sortByRoleClassName(a, b)
	if a.RoleSpec == b.RoleSpec then
		if Settings.BlizzSort[ a.Class ] == Settings.BlizzSort[ b.Class ] then
			if a.Name < b.Name then return true end
		elseif Settings.BlizzSort[ a.Class ] < Settings.BlizzSort[ b.Class ] then return true end
	elseif a.RoleSpec < b.RoleSpec then return true end
end


local BattlefieldScoreFaction = nil;
function XentiTargets:UpdateMainFunctions()
	table_sort(Players, sortByRoleClassName)
	local _, playerClass = UnitClass('player')
	local ccSpellName="Hearthstone"
	if playerClass=="DEMONHUNTER" then
		ccSpellName="Imprison"
	elseif playerClass=="DRUID" then
		ccSpellName="Cyclone(Honor Talent)"
	elseif playerClass=="MONK" then
		ccSpellName="Paralysis"
	elseif playerClass=="WARLOCK" then
		ccSpellName="Fear"
	elseif playerClass=="SHAMAN" then
		ccSpellName="Hex"
	end
	
	local currentButton
	for i = 1, #Players do
		if Players[i] then
			--Debug(i)
			currPlayer = Players[i]
			Interface.PlayerButtons[i] = Interface.Buttons[i]
			currentButton = Interface.PlayerButtons[i]
			PlayerNamesToIndex[currPlayer.Name] = i

			if not currentButton then
				return
			end

			if not InCombatLockdown() then
				currentButton:Show()
				currentButton:SetAttribute('*macrotext1',
					'/cleartarget\n'..
					'/targetexact '..currPlayer.Name
				);
				
				currentButton:SetAttribute('*macrotext2',
					'/targetexact '..currPlayer.Name..'\n'..
					'/cast [mod:shift]' .. ccSpellName ..  '\n'..
					'/focus [nomod]\n'..
					'/targetlasttarget'
				);
				
				--[[currentButton:SetAttribute('macrotext2',
					'/targetexact '..currPlayer.Name..'\n'..
					'/cast Moonfire\n'..
					'/targetlasttarget'
				);
				--]]
			end

			local c = RAID_CLASS_COLORS[currPlayer.Class];
			local alpha = .65
			local alphaColor = .5

			if currPlayer.Icon then
				--print(currentButton.Spec.Icon:GetTexture())
				if not currentButton.Spec.active then
					currentButton.Spec.Icon:SetTexture(currPlayer.Icon)
					currentButton.Spec.Icon.SpecTex=currPlayer.Icon
				end
			
			end

			if currPlayer.LastSeen == 0 or CurrentTime-currPlayer.LastSeen >= 3 then
				currentButton.Health:SetStatusBarColor(c.r * alphaColor, c.g * alphaColor, c.b * alphaColor, alpha)
				currentButton.SetHealth(0, currPlayer.MaxHealth)
			else
				currentButton.Health:SetStatusBarColor(c.r,c.g,c.b)
				--
			end

			-- currentButton.Role:SetStatusBarColor(0,0,0,.8)

			currentButton.SetHealth(currPlayer.Health, currPlayer.MaxHealth)

			if self.db.showRealm then
				currentButton.SetName(currPlayer.Name)
			else
				currentButton.SetName(currPlayer.Name:match("[^%-]*"))
			end

			
			if currPlayer.Insi==2 then
				currentButton.Insi.Icon:SetTexture("Interface/Icons/Sha_ability_rogue_sturdyrecuperate")
			elseif currPlayer.Insi==3 then
				currentButton.Insi.Icon:SetTexture("Interface/Icons/ability_bossdarkvindicator_auraofcontempt")
			else
				currentButton.SetFaction(EnemyFaction)
			end

			-- 8326
			
			-- setting class color
			--currentButton.Health:SetStatusBarColor(c.r,c.g,c.b)
			currentButton:SetBackdropColor(0,0,0,.28)

			self:UpdateAura(currPlayer)
			self:UpdateObjectives(currPlayer)
		end
	end

	

	-- hide unused buttons
	local playerCount = #Players
	if playerCount == 0 then
		playerCount = 0
	end
	for i = Settings.MaxPlayers, 1, -1 do
		-- skip last one
		if i == playerCount then
			break
		end

		currentButton = Interface.Buttons[i]
		currentButton.Insi.End = 0
		currentButton.Respawn.End = 0
		currentButton.Racial:Hide()
		for k,v in pairs(numDR) do
			currentButton.DR[k]:Hide()
		end
		currentButton.TargetIndicators = {};
		currentButton.Cooldowns = {};
		currentButton.Auras = {};
		if not InCombatLockdown() then
			currentButton:Hide()
		end
	end
end

-- Nameplate Scanner
function XentiTargets:CollectNameplates(n,...)
for _, frame in pairs(C_NamePlate.GetNamePlates()) do 
local unit=frame.UnitFrame.displayedUnit 
local name,realm=UnitName(unit) 

end

--[[
	for i = 1, n do
		local f = select(i,...);
		if (not Interface.NameplateCache[f]) and (f:GetName() or ""):match("^NamePlate%d+") then
			Interface.NameplateCache[f] = {
				Name = select(2,f:GetChildren()):GetRegions(),
				HealthBar = f:GetChildren():GetChildren()
			};
		end
	end--]]
end

function XentiTargets:SetAuraIcon(button, aura)
	local frame=button.Spec
	
	--print("SetAuraIcon for " .. aura.spname .. " on " .. enemy)
	
	if not frame.text then 
		frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		frame.text:SetWidth(50)
		frame.text:SetPoint("CENTER", frame, "CENTER", 0, 0)
		frame.text:SetJustifyH("CENTER")
		frame.text:SetShadowOffset(0, 0)
		frame.text:SetShadowColor(0, 0, 0, 0)
		frame.text:SetTextColor(1, 1, 1, 1)
		frame.text:SetFont('Fonts/ARIALN.TTF', 16, 'THINOUTLINE')
	end
	
	if button.Aura and (button.Aura.priority<aura.priority and button.Aura.expires<aura.expires) then
		button.Aura=aura
	elseif button.Aura==nil then
	
	else
		return
	end
	
	frame.text:Show()
	frame.active=true
	frame.timeLeft=aura.expires-GetTime()
	frame.Swipe:SetCooldown(aura.expires-aura.duration,aura.duration)
	frame.Swipe:SetHideCountdownNumbers(true)

	frame.Icon:SetTexture(aura.icon)
	frame:SetScript("OnUpdate",function(f,elapsed) 
		f.timeLeft = f.timeLeft - elapsed
		if f.timeLeft <= 0 then
			frame.Icon:SetTexture(frame.Icon.SpecTex)
			frame.text:Hide()
			frame.active=false
		else
			frame.text:SetText(strformat("%.1f", f.timeLeft))
		end
	end 
	)
end


--Saving dot duration from target, mouseover, focus or other targets
function XentiTargets:SnapDots(unit)
	if not UnitIsPlayer(unit) then return end
	local name, realm = UnitName(unit);
	name = realm and (name..'-'..realm) or name;
	local doUpdate=false
	local enemy=nil
	local aura
	local hasFlay=false
	for _, auraType in pairs({'HELPFUL', 'HARMFUL'}) do
		for i = 1, 40 do
			local spname,_,icon,_,_,duration, expires, src,_ ,_ , spell = UnitAura(unit, i,auraType)
			
			if not spell then
				
				break
			end
			local info = nil
			if src =="player" or src=="Iring" or src=="Riax" or src=="Hazal" then
				if src=="Iring" then
					--print("Source was Iring")
				end
				--print(spell .. " on " .. name)
				info = Tracked_Auras[spell]
			end
			
			local priority = auraTable[spname] or auraTable[tostring(spell)]
			if spell==199845 then
				--print(auraTable[spname], name)
				--print("dur:" .. duration .. " expires: " .. expires)
				duration=10
				expires=duration+GetTime()
				hasFlay=true
			end
			if priority and (not aura or aura.priority < priority)  then
				aura = {
					spname = spname,
					icon = icon,
					duration = duration,
					expires = expires,
					spell = spell,
					priority = priority
				}
			end
			
			
			
		end
	end
	
	if aura then
		--print(duration,src,spell)
		enemy = self:GetPlayer(nil,name)
		local button=self:GetPlayerButton(nil,name)
		if button then
			if hasFlay then
				--ActionButton_ShowOverlayGlow(button)
			else
				--ActionButton_HideOverlayGlow(button)
			end
			--doUpdate=true
			if (not button.Aura or (button.Aura ~= aura or button.Aura.expires ~= aura.expires)) then
				self:SetAuraIcon(button, aura)
			end
			--print("Sent auraicon info about " .. aura.spname)
			
		end
	end
	if doUpdate and enemy then
		
		self:UpdateAura(enemy)
	end
end

function XentiTargets:UpdatePlayer(enemy)
	if not enemy then
		return
	end

	local currentButton = self:GetPlayerButton(enemy)

	local updateAuras = false

	if enemy.Unit then
		if UnitGUID(enemy.Unit) == enemy.GUID then
			enemy.Health = UnitHealth(enemy.Unit);
			enemy.MaxHealth = UnitHealthMax(enemy.Unit);
			enemy.Mana = UnitPower(enemy.Unit);
			enemy.MaxMana = UnitPowerMax(enemy.Unit);
			if RangeCheckSpell then
				enemy.LastSeen = (IsSpellInRange(RangeCheckSpell,enemy.Unit) == 1) and (CurrentTime+1) or 0;
			end
			-- checking auras
			for i = 1, 40 do
				local duration, expires, src,_ ,_ , spell = select(6, UnitAura(enemy.Unit, i))
				
				if not spell then
					
					break
				end
				local info = nil
				if src =="player" then
					--print(enemy.Unit .. " " .. spell)
					info = Tracked_Auras[spell]
				end
				if info then
					updateAuras = self:SetAura(enemy, spell, expires, duration, CurrentTime) or updateAuras;
				end
			end
			for i = 1, 40 do
				local duration, expires, src,_ ,_ , spell = select(6, UnitDebuff(enemy.Unit, i))
				
				if not spell then
					
					break
				end
				local info = nil
				if src =="player" then
					--print(enemy.Unit .. " " .. spell)
					info = Tracked_Auras[spell]
				end
				if info then
					updateAuras = self:SetAura(enemy, spell, expires, duration, CurrentTime) or updateAuras;
				end
			end
			
			-- RespawnTimer
			if UnitIsDead(enemy.Unit) then
				self:SetPlayerDead(enemy, CurrentTime+26, 26, CurrentTime);
			end

			if currentButton then
				if enemy.GUID and enemy.GUID == UnitGUID('target') then
					currentButton:SetBackdropBorderColor(17, 27, 161, 1)
				else
					currentButton:SetBackdropBorderColor(0, 0, 0, 1)
				end
			end

		else -- unit no longer relevant
			if currentButton then
				currentButton:SetBackdropBorderColor(0, 0, 0, 1)
			end

			enemy.Unit = nil;
		end
	end

	for i, aura in pairs(enemy.Auras) do
		if aura.expires and ( (aura.expires > 0 and CurrentTime >= aura.expires) or (enemy.Unit and aura.timestamp ~= CurrentTime)) then
			aura.expires = nil;
			updateAuras = true;
		end
	end

	if updateAuras then
		self:UpdateAura(enemy)
	end

	-- do we've an active timer?
	if currentButton then
		if (currentButton.Respawn.End > 0 and currentButton.Respawn.End <= CurrentTime) or (enemy.Health > 0) then
			currentButton.Respawn.End = 0
			currentButton.Respawn:Hide()
		end
		
	
		
	end
	
end

function XentiTargets:ScanUnit(unit)
	if not (UnitIsPlayer(unit) or Settings.Test) then
		return
	end

	local name, realm = UnitName(unit);
	name = realm and (name..'-'..realm) or name;

	local playerIndex =  PlayerNamesToIndex[name]

	if Players[playerIndex] then
		local Player = Players[playerIndex]

		if Player.Name == name then
			if  Player.Unit == nil then
				Player.GUID = UnitGUID(unit);
				Player.Unit = unit;
			end

			self:UpdatePlayer(Player);
		end
	end
end

function XentiTargets:GetPlayerButton(player, playerName)
	local playerIndex =  PlayerNamesToIndex[(player) and player.Name or playerName]

	if not playerIndex then
		return false
	end

	local playerButton = Interface.PlayerButtons[playerIndex]

	if not playerButton then
		return false
	end

	return playerButton
end

function XentiTargets:GetPlayer(player, playerName)
	local playerIndex =  PlayerNamesToIndex[(player) and player.Name or playerName]

	if not playerIndex then
		return false
	end

	return Players[playerIndex] or nil
end

function XentiTargets:CheckTarget(expName)

end

-- Aura System
function XentiTargets:SetAura(player, spell, expires, duration, timestamp)
	
	if not Tracked_Auras[spell] then
		return
	end
	--print("SetAura Called with " .. spell .. " dur: " .. duration)
	local currentIndex
	for i, aura in pairs(player.Auras) do
		if aura.spell == spell then
			currentIndex = i;
			break;
		end
	end

	local aura
	if not currentIndex then
		currentIndex = #player.Auras+1
		player.Auras[currentIndex] = {
			spell = spell,
			info = Tracked_Auras[spell],
			timestamp = timestamp
		}
		aura = player.Auras[currentIndex]
	else
		aura = player.Auras[currentIndex]
		aura.timestamp = timestamp
	end

	aura.duration = duration
	aura.expires = expires

	aura.type = aura.info[2]

	return true
end

function XentiTargets:UpdateObjectives(player)
	local currentButton = self:GetPlayerButton(player)

	if not currentButton then
		Debug('Did not found button... skipping')
		return
	end

	-- make orb check
	if currentMapId == 856 then
		-- iterate throw object
		local foundOrb = false
		for color, playerName in pairs(orbData) do
			if playerName and playerName == player.Name then
				self:ShowObjective(currentButton.Objective, player, color)
				foundOrb = true
				break
			end
		end

		if not foundOrb then
			currentButton.Objective.AuraText:SetText("")
			currentButton.Objective:Hide()
		end
	else
		if carrier ~= player.Name then
			currentButton.Objective.AuraText:SetText("")
			currentButton.Objective:Hide()
		else
			self:ShowObjective(currentButton.Objective, player, carrierSpell)
		end
	end
end

function XentiTargets:ShowObjective(objective, player, spell)
	local specialInformations = self:GetAuraSpecialInformations(player.Unit)
	local spellAura = Aura_Overrides[spell] or select(3, GetSpellInfo(spell))

	if spellAura then
		objective.Icon:SetTexture(spellAura)
	end

	if specialInformations then
		objective.AuraText:SetText(specialInformations)
	end

	objective:Show()
end

function XentiTargets:UpdateAura(player)
	local currentButton = self:GetPlayerButton(player)

	for i, aura in pairs(currentButton.Auras) do
		aura.spell = nil
	end

	for i, aura in pairs(player.Auras) do
		if aura.expires then
			self:ShowAura(currentButton, aura.spell, aura.expires, aura.duration, aura.type, player.Unit)
		end
	end

	-- disable all unused aura buttons
	for i, aura in pairs(currentButton.Auras) do
		if not aura.spell then
			aura:Hide()
		end
	end
end

function XentiTargets:ShowAura(button, spell, expires, duration, auraType, playerUnit) 
	--if not button then
	--	Debug('Doesnt have any button for that unit ... going to exit o.O')
	--end
	local targetButton
	if auraType == Aura_Types.OBJECTIVE then
		-- use special button for objectives
		targetButton = button.Objective
		-- currently not supporting other auras
	end
	
	if auraType =="Moonfire" or auraType=="Sunfire" or auraType=="Agony" then
		--print("ShowAura called")
		tButton=button[auraType]
		if not tButton then
			tButton = CreateFrame('frame',nil,button.Health);
			button[auraType] = tButton;
			tButton:SetSize(16,16);
			local ind=0
			if auraType =="Moonfire" then
				ind=20
			end
			tButton:SetPoint('BOTTOMLEFT',5+ind, 5);
			tButton:SetBackdrop({
				bgFile = "Interface/Buttons/GreyscaleRamp64",
				edgeFile = "Interface/Buttons/WHITE8X8",
				edgeSize = 1,
			});
			if auraType =="Moonfire" then
				tButton:SetBackdropColor(255,255,255,1);
			else
				tButton:SetBackdropColor(255,255,255,1);
			end
			
		end
		local frame = tButton
		if not frame.text then 
			frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
			frame.text:SetWidth(24)
			frame.text:SetPoint("CENTER", frame, "CENTER", 0, 0)
			frame.text:SetJustifyH("CENTER")
			frame.text:SetShadowOffset(1, 1)
			frame.text:SetShadowColor(0, 0, 0, 0.5)
			if auraType =="Moonfire" then
				frame.text:SetTextColor(0.098, 0.098, 1, 1)
			else
				frame.text:SetTextColor(1, 0.72, 0.2, 1)
			end
			frame.text:SetFont('Fonts/ARIALN.TTF', 18, 'THINOUTLINE')
		end
		frame.timeLeft = expires-GetTime()
		frame.active=true
		frame.text:SetText("")
		frame:Show()
		frame:SetScript("OnUpdate",function(f,elapsed)
			f.timeLeft = f.timeLeft - elapsed
			
			if f.timeLeft <= 0 then
				f.active = false
				frame:SetScript("OnUpdate",nil)
				frame:Hide()
			else
				
				frame.text:SetText(strformat("%.0f", f.timeLeft))
				
			end
			
			
		end)
		
	end
	
	
	if targetButton then
		targetButton.spell = spell
		local specialInformations = self:GetAuraSpecialInformations(playerUnit)

		if duration and expires and expires > 0 then
			targetButton.Swipe:SetCooldown(expires-duration, duration)
			targetButton.Swipe:Show()
		else
			if targetButton.Swipe then
				targetButton.Swipe:Hide()
			end
		end

		if specialInformations then
			--Debug('Found debuff with amount of ', specialInformations)
			targetButton.AuraText:SetText(specialInformations)
			--targetButton:SetAuraInformations(specialInformations)
		else
			targetButton.AuraText:SetText("")
			--targetButton:SetAuraInformations("")
		end

		local spellTexture = Aura_Overrides[spell] or select(3, GetSpellInfo(spell))

		if spellTexture then
			-- targetButton:SetAuraTexture(spellTexture)
			targetButton.Icon:SetTexture(spellTexture)
			--targetButton:SetAuraTexture(select(3, GetSpellInfo(spell)))
		end

		targetButton:Show()
	end
end

local auraDebuffs = {
	[46392] = 1, -- Focused Assault
	[46393] = 1, -- Brutal Assault
}
local orbs = {
	[121164] =	1, -- Blue Orb
	[121175] =	1, -- Purple Orb
	[121177] =	1, -- Orange Orb
	[121176] =	1  -- Green Orb
}
function XentiTargets:GetAuraSpecialInformations(unit)
	-- todo | add debuff
	local specialInformations

	if not unit then
		--Debug('Did not found unit... unable to get debuff')
		return specialInformations
	end

	for i = 1, 40 do
		local _, _, _, count, _, _, _, _, _, _, spellId, _, _, _, _,_, _,val2 = UnitDebuff(unit, i)
		if not spellId then
			break
		end
		if orbs[spellId] then
			specialInformations = val2
			break
		else
			if auraDebuffs[spellId] then
				specialInformations = count
				break
			end
		end
	end

	return specialInformations
end

local function OnEvent(self, event, ...)
	XentiTargets:OnEvent(event, ...)
end

XentiTargets:RegisterEvent("ADDON_LOADED")
XentiTargets:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")
XentiTargets:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
XentiTargets:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
XentiTargets:RegisterEvent("PLAYER_LOGIN")
XentiTargets:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED');
XentiTargets:RegisterEvent("ARENA_OPPONENT_UPDATE")
XentiTargets:RegisterEvent("ARENA_CROWD_CONTROL_SPELL_UPDATE")
XentiTargets:RegisterEvent("ARENA_COOLDOWNS_UPDATE")
XentiTargets:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
XentiTargets:RegisterEvent('PLAYER_TARGET_CHANGED');
XentiTargets:RegisterEvent('UNIT_TARGET');
XentiTargets:RegisterEvent('EXECUTE_CHAT_LINE');
XentiTargets:RegisterEvent('ZONE_CHANGED_NEW_AREA')
XentiTargets:SetScript("OnEvent", OnEvent)