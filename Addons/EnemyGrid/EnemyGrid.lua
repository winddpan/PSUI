
if (true) then
	--return
	--but not today
end
-- elsea 
--details! framework
local DF = _G ["DetailsFramework"]
if (not DF) then
	print ("|cFFFFAA00Enemy Grid: framework not found, if you just installed or updated the addon, please restart your client.|r")
	return
end

DF:SetFrameworkDebugState (true)

local LibSharedMedia = LibStub:GetLibrary ("LibSharedMedia-3.0")
local LibWindow = LibStub ("LibWindow-1.1")
local L = LibStub ("AceLocale-3.0"):GetLocale ("EnemyGrid", true)

local UnitAura = UnitAura
local GetRaidTargetIndex = GetRaidTargetIndex
local UnitExists = UnitExists
local Lerp = Lerp
local GetTime = GetTime

LibSharedMedia:Register ("statusbar", "DGround", [[Interface\AddOns\EnemyGrid\images\bar_background]])

LibSharedMedia:Register ("statusbar", "Details D'ictum", [[Interface\AddOns\EnemyGrid\images\bar4]])
LibSharedMedia:Register ("statusbar", "Details Vidro", [[Interface\AddOns\EnemyGrid\images\bar4_vidro]])
LibSharedMedia:Register ("statusbar", "Details D'ictum (reverse)", [[Interface\AddOns\EnemyGrid\images\bar4_reverse]])
LibSharedMedia:Register ("statusbar", "Details Serenity", [[Interface\AddOns\EnemyGrid\images\bar_serenity]])
LibSharedMedia:Register ("statusbar", "BantoBar", [[Interface\AddOns\EnemyGrid\images\BantoBar]])
LibSharedMedia:Register ("statusbar", "Skyline", [[Interface\AddOns\EnemyGrid\images\bar_skyline]])
LibSharedMedia:Register ("statusbar", "WorldState Score", [[Interface\WorldStateFrame\WORLDSTATEFINALSCORE-HIGHLIGHT]])
LibSharedMedia:Register ("statusbar", "DGround", [[Interface\AddOns\EnemyGrid\images\bar_background]])
LibSharedMedia:Register ("statusbar", "PlaterBackground", [[Interface\AddOns\EnemyGrid\images\platebackground]])
LibSharedMedia:Register ("statusbar", "PlaterTexture", [[Interface\AddOns\EnemyGrid\images\platetexture]])

LibSharedMedia:Register ("font", "Oswald", [[Interface\Addons\EnemyGrid\fonts\Oswald-Regular.otf]])
LibSharedMedia:Register ("font", "Nueva Std Cond", [[Interface\Addons\EnemyGrid\fonts\NuevaStd-Cond.otf]])
LibSharedMedia:Register ("font", "Accidental Presidency", [[Interface\Addons\EnemyGrid\fonts\Accidental Presidency.ttf]])
LibSharedMedia:Register ("font", "TrashHand", [[Interface\Addons\EnemyGrid\fonts\TrashHand.TTF]])
LibSharedMedia:Register ("font", "Harry P", [[Interface\Addons\EnemyGrid\fonts\HARRYP__.TTF]])
LibSharedMedia:Register ("font", "FORCED SQUARE", [[Interface\Addons\EnemyGrid\fonts\FORCED SQUARE.ttf]])

local ALL_DEBUFFS = {}
local FILTER_DEBUFFS_BANNED = {}

local ACTORTYPE_FRIENDLY_PLAYER = "friendlyplayer"
local ACTORTYPE_FRIENDLY_NPC = "friendlynpc"
local ACTORTYPE_ENEMY_PLAYER = "enemyplayer"
local ACTORTYPE_ENEMY_NPC = "enemynpc"	

local UNITREACTION_HOSTILE = 3
local UNITREACTION_NEUTRAL = 4
local UNITREACTION_FRIENDLY = 5

local FILTER_BUFFS_BANNED = {}
local BuffsBannedList = {
	61573,
	61574,
}

local HEALTH_CUT_OFF = false

local _
local default_config = {
	profile = {
		only_incombat = false,
		only_instance = false,
		only_inboss = false,

		vertical_rows = 40,
		vertical_gap_size = 1,
		horizontal_gap_size = 1,
		frame_strata = "BACKGROUND",
		frame_locked = false,
		frame_backdropcolor = {1, 1, 1, 1},
		frame_backdropbordercolor = {0, 0, 0, .5},
		frame_range_alpha = 0.3,
		max_targets = 16,
		show_tab = true,
		show_title_text = true,
		grow_direction = 1,
		
		bar_texture = "Details Serenity",
		bar_texturebackground = "PlaterBackground",
		bar_width = 100,
		bar_height = 18,
		bar_direction = 1,
		bar_color_by_class = true,
		
		cast_enabled = true,
		cast_statusbar_texture = "DGround",
		cast_statusbar_bgtexture = "Details Serenity",
		cast_statusbar_color = {1, .7, 0, 1},
		cast_statusbar_color_nointerrupt = {.7, .7, .7, 1},
		cast_statusbar_bgcolor = {0, 0, 0, 1},
		cast_statusbar_anchor = {side = 9, x = 0, y = 0},
		cast_statusbar_width = 100,
		cast_statusbar_height = 18,
		spellname_text_size = 10,
		spellname_text_font = "Arial Narrow",
		spellname_text_color = {1, 1, 1, 1},
		spellname_text_shadow = true,
		spellname_text_anchor = {side = 9, x = 0, y = 0},
		
		npc_enemy_color = {1, .1, .2},
		npc_friendly_color = {.1, 1, .2},
		npc_neutral_color = {1, .95, .1},
		
		name_text_font = "Accidental Presidency",
		name_text_size = 12,
		name_text_stringsize = 72,
		name_text_shadow = true,
		name_text_color = {1, 1, 1, 1},
		name_text_anchor = {side = 10, x = 2, y = 0},
		
		percent_text_enabled = true,
		percent_text_font = "Accidental Presidency",
		percent_text_size = 12,
		percent_text_shadow = true,
		percent_text_color = {1, 1, 1, 1},
		percent_text_anchor = {side = 11, x = -2, y = 0},
		
		debuff_anchor = {side = 6, x = 2, y = 0},
		debuff_anchor_grow_direction = "right",
		aura_width = 20,
		aura_height = 14,
		aura_timer = true,
		aura_custom = {},
		aura_show_tooltip = false,
		aura_always_show_debuffs = false,
		aura_tracker = {
			buff = {},
			debuff = {},
			buff_ban_percharacter = {},
			debuff_ban_percharacter = {},
			options = {},
			track_method = 0x1,
			buff_banned = {},
			debuff_banned = {},
		},
		
		raidmarker_anchor = {side = 9, x = 0, y = 0},
		raidmarker_alpha = 1,
		iconIndicator_anchor = {side = 6, x = 1, y = 0},
		iconIndicator_alpha = 1,
		iconIndicator_show_faction = true,
		
		quest_enabled = true,
		quest_color_enemy = {1, .369, 0},
		quest_color_neutral = {1, .65, 0},
		
		not_affecting_combat_alpha = .5,
		
		tank = {
			colors = {
				aggro = {.7, .7, 1},
				noaggro = {1, 0, 0},
				pulling = {1, 1, 0},
				nocombat = {30/255, 0, 1},
			},
		},
		dps = {
			colors = {
				aggro = {1, .5, .5},
				noaggro = {.5, .5, 1},
				pulling = {1, 1, 0},
				nocombat = {.4, 0, 30/255},
			},
		},
		
		
	}
}

local preset_settings = {
	{
		name = "Battleground Targets",
		settings_override = {
			["name_text_size"] = 11,
			["aura_height"] = 22,
			["bar_color"] = {
				0.980392156862745, -- [1]
				0, -- [2]
				1, -- [3]
			},
			["cast_statusbar_height"] = 23,
			["cast_statusbar_width"] = 115,
			["dps"] = {
				["colors"] = {
					["aggro"] = {
						1, -- [1]
						0.345098039215686, -- [2]
						0.294117647058824, -- [3]
						1, -- [4]
					},
				},
			},
			["bar_width"] = 115,
			["y"] = -142.499145507813,
			["npc_friendly_color"] = {
				0.4, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["horizontal_gap_size"] = 0,
			["frame_backdropcolor"] = {
				0.643137254901961, -- [1]
				0.643137254901961, -- [2]
				0.643137254901961, -- [3]
				0.210000038146973, -- [4]
			},
			["bar_height"] = 25,
			["x"] = 176.000045776367,
			["debuff_anchor_grow_direction"] = "left",
			["percent_text_anchor"] = {
				["x"] = 2,
			},
			["cast_statusbar_anchor"] = {
				["side"] = 10,
			},
			["bar_texture"] = "DGround",
			["frame_range_alpha"] = 0.33254075050354,
			["tank"] = {
				["colors"] = {
					["nocombat"] = {
						0.341176470588235, -- [1]
						0.00392156862745098, -- [2]
						0.0117647058823529, -- [3]
						1, -- [4]
					},
				},
			},
			["iconIndicator_anchor"] = {
				["x"] = 0,
			},
			["scale"] = 1,
			["cast_statusbar_color"] = {
				1, -- [1]
				0.701960784313726, -- [2]
			},
			["percent_text_size"] = 11,
			["debuff_anchor"] = {
				["x"] = -2,
				["side"] = 2,
			},
			["name_text_stringsize"] = 80,
			["npc_neutral_color"] = {
				1, -- [1]
				0.843137254901961, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["point"] = "TOPLEFT",
			["npc_enemy_color"] = {
				1, -- [1]
				0.0901960784313726, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["cast_statusbar_bgcolor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.724460273981094, -- [4]
			},
			["cast_statusbar_texture"] = "PlaterTexture",
			["vertical_gap_size"] = 0,
			["frame_backdropbordercolor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.310000002384186, -- [4]
			},
			["percent_text_color"] = {
				0.972549019607843, -- [1]
				[3] = 0.972549019607843,
			},
			["aura_width"] = 26,
		},
	},
	{
		name = "Grid",
		settings_override = {
			["aura_height"] = 16,
			["name_text_size"] = 10,
			["bar_color"] = {
				0.980392156862745, -- [1]
				0, -- [2]
				1, -- [3]
			},
			["vertical_rows"] = 6,
			["cast_statusbar_height"] = 20,
			["cast_statusbar_width"] = 50,
			["debuff_anchor"] = {
				["side"] = 10,
			},
			["bar_width"] = 50,
			["name_text_anchor"] = {
				["y"] = -1,
				["x"] = 1,
				["side"] = 12,
			},
			["cast_statusbar_color"] = {
				1, -- [1]
				0.701960784313726, -- [2]
			},
			["npc_friendly_color"] = {
				0.4, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["aura_width"] = 16,
			["horizontal_gap_size"] = 0,
			["frame_backdropcolor"] = {
				0.643137254901961, -- [1]
				0.643137254901961, -- [2]
				0.643137254901961, -- [3]
				0.210000038146973, -- [4]
			},
			["bar_height"] = 50,
			["x"] = 87.0000534057617,
			["spellname_text_anchor"] = {
				["side"] = 10,
			},
			["percent_text_anchor"] = {
				["y"] = 1,
				["x"] = 2,
				["side"] = 13,
			},
			["cast_statusbar_anchor"] = {
				["side"] = 13,
			},
			["bar_texture"] = "DGround",
			["frame_range_alpha"] = 0.33,
			["tank"] = {
				["colors"] = {
					["nocombat"] = {
						0.341176470588235, -- [1]
						0.00392156862745098, -- [2]
						0.0117647058823529, -- [3]
						1, -- [4]
					},
				},
			},
			["point"] = "TOPLEFT",
			["scale"] = 1,
			["cast_statusbar_bgcolor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.724460273981094, -- [4]
			},
			["percent_text_size"] = 11,
			["percent_text_color"] = {
				0.972549019607843, -- [1]
				[3] = 0.972549019607843,
			},
			["name_text_stringsize"] = 50,
			["dps"] = {
				["colors"] = {
					["aggro"] = {
						1, -- [1]
						0.345098039215686, -- [2]
						0.294117647058824, -- [3]
						1, -- [4]
					},
				},
			},
			["vertical_gap_size"] = 0,
			["npc_neutral_color"] = {
				1, -- [1]
				0.843137254901961, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["frame_backdropbordercolor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.310000002384186, -- [4]
			},
			["cast_statusbar_texture"] = "PlaterTexture",
			["npc_enemy_color"] = {
				1, -- [1]
				0.0901960784313726, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["iconIndicator_anchor"] = {
				["x"] = 0,
			},
			["y"] = -134.4990234375,
			["show_tab"] = false,
		},
	},
}

local options_table = {
	name = "Enemy Grid",
	type = "group",
	args = {
		
	}
}

local EnemyGrid = DF:CreateAddOn ("EnemyGrid", "EnemyGridDB", default_config, options_table)

EnemyGrid.QuestCache = {}
EnemyGrid.ClassBuffCache = {}

local CONST_RANGECHECK_INTERVAL = .1

function EnemyGrid:LoadSettingsPreset (presetIndex)
	local currentProfile = EnemyGrid.db.profile
	local preset = preset_settings [presetIndex] and preset_settings [presetIndex].settings_override
	if (preset) then
		--reseta a config
		DF.table.copy (currentProfile, default_config.profile)
		--aplica as defini��es
		DF.table.copy (currentProfile, preset)
		
		--da refresh no painel de op��o se ele estiver aberto
		if (EnemyGridOptionsPanelFrameFrontPageFrame) then
			EnemyGridOptionsPanelFrameFrontPageFrame:RefreshOptions()
			EnemyGridOptionsPanelFrameAuraFrame:RefreshOptions()
			EnemyGridOptionsPanelFrameBarsFrame:RefreshOptions()
		end
		
		--atualiza todos os frames
		EnemyGrid:RefreshConfig()
	else
		EnemyGrid:Msg ("preset not found.")
	end
end

local re_SelectLayoutWizard = function()
	return EnemyGrid:SelectLayoutWizard()
end
function EnemyGrid:SelectLayoutWizard()

	if (InCombatLockdown()) then
		return C_Timer.After (1, re_SelectLayoutWizard)
	end

	if (EnemyGridWelcomeFrame) then
		EnemyGridWelcomeFrame:Show()
		return
	end

	local WelcomeFrame = DF:CreateSimplePanel (UIParent, 600, 400, "Enemy Grid", "EnemyGridWelcomeFrame")
	WelcomeFrame:SetPoint ("center", UIParent, "center", 0, 0)
	WelcomeFrame:Hide()
	
	--abilita friendly para que seja mostrados mais resultados caso o jogador esteja dentro de uma cidade
	WelcomeFrame:SetScript ("OnShow", function()
		if (not InCombatLockdown()) then
			if (GetCVar ("nameplateShowFriends") == "0") then
				SetCVar ("nameplateShowFriends", "1")
				WelcomeFrame.ChangedShowFriends = true
			end
		end
		if (EnemyGridOptionsPanelFrame and EnemyGridOptionsPanelFrame:IsShown()) then
			WelcomeFrame.ReopenOptions = true
			EnemyGridOptionsPanelFrame:Hide()
		end
	end)
	WelcomeFrame:SetScript ("OnHide", function()
		if (not InCombatLockdown()) then
			if (WelcomeFrame.ChangedShowFriends) then
				SetCVar ("nameplateShowFriends", "0")
				WelcomeFrame.ChangedShowFriends = nil
			end
		end
		if (WelcomeFrame.ReopenOptions) then
			EnemyGridOptionsPanelFrame:Show()
			WelcomeFrame.ReopenOptions = nil
		end
	end)
	
	local wf = WelcomeFrame
	wf.currentSelected = 1

	wf.welcome1 = DF:CreateLabel (wf, "Welcome to Enemy Grid!", 14, "orange")
	wf.welcome2 = DF:CreateLabel (wf, "To start using, please choose a layout:", 12, "silver")
	wf.welcome1:SetPoint (10, -30)
	wf.welcome2:SetPoint (10, -44)
	
	local x = 6
	local y = 0
	
	wf.image1 = DF:CreateImage (wf, [[Interface\AddOns\EnemyGrid\images\background_welcome]], 183, 232, "artwork", {0/512, 183/512, 8/256, 240/256})
	wf.image2 = DF:CreateImage (wf, [[Interface\AddOns\EnemyGrid\images\background_welcome]], 171, 232, "artwork", {184/512, 355/512, 8/256, 240/256})
	wf.image1:SetPoint ("topleft", wf, "topleft", 50, -100)
	wf.image2:SetPoint ("topright", wf, "topright", -50, -100)
	
	wf.layout1 = DF:CreateLabel (wf, "Vertical", 14)
	wf.layout2 = DF:CreateLabel (wf, "Square", 14)
	wf.layout1:SetPoint ("bottomleft", wf.image1, "topleft", 3, 2)
	wf.layout2:SetPoint ("bottomleft", wf.image2, "topleft", 3, 2)
	
	wf.change_later = DF:CreateLabel (wf, "- you can customize even more at the options panel (/enemygrid).", 12, "orange")
	wf.change_later:SetPoint ("bottomleft", wf, "bottomleft", 10, 10)
	
	local selected = function (_, _, index)
		wf.AllButtons[1].selectedHightlight:Hide()
		wf.AllButtons[2].selectedHightlight:Hide()
		wf.AllButtons[index].selectedHightlight:Show()
		wf.currentSelected = index
	end
	
	wf.button1 = DF:CreateButton (wf, selected, 0, 0, "", 1)
	wf.button1:SetAllPoints (wf.image1.widget)
	wf.button1.selectedHightlight = DF:CreateImage (wf.button1, [[Interface\Tooltips\UI-Tooltip-Background]])
	wf.button1.selectedHightlight:SetPoint ("topleft", 8, -7)
	wf.button1.selectedHightlight:SetPoint ("bottomright", -7, 7)
	wf.button1.selectedHightlight:SetVertexColor (1, 1, 1, .5)
	wf.button1.selectedHightlight:Hide()
	wf.button2 = DF:CreateButton (wf, selected, 0, 0, "", 2)
	wf.button2:SetAllPoints (wf.image2.widget)
	wf.button2.selectedHightlight = DF:CreateImage (wf.button2, [[Interface\Tooltips\UI-Tooltip-Background]])
	wf.button2.selectedHightlight:SetPoint ("topleft", 7, -6)
	wf.button2.selectedHightlight:SetPoint ("bottomright", -7, 6)
	wf.button2.selectedHightlight:SetVertexColor (1, 1, 1, .5)
	wf.button2.selectedHightlight:Hide()
	
	wf.AllButtons = {wf.button1, wf.button2}
	
	local confirm_layout = function()
		EnemyGrid:LoadSettingsPreset (wf.currentSelected)
		EnemyGrid.db.profile.first_run = true
	end
	
	wf.confirm = DF:CreateButton (wf, confirm_layout, 120, 20, L["S_APPLY"])
	wf.confirm:InstallCustomTexture()
	wf.confirm:SetPoint ("bottomright", wf, "bottomright", -10, 10)

	wf:Show()
end
	
--copied from blizzard code
local function IsTapDenied (frame)
	return not UnitPlayerControlled (frame.unit) and UnitIsTapDenied (frame.unit)
end
--> copied from blizzard code
local function IsPlayerEffectivelyTank()
	local assignedRole = UnitGroupRolesAssigned ("player");
	if ( assignedRole == "NONE" ) then
		local spec = GetSpecialization();
		return spec and GetSpecializationRole(spec) == "TANK";
	end
	return assignedRole == "TANK";
end

local clearDebuffsOnPlate = function (self)
	for i = 1, #self.debuffAnchor.buffList do 
		local debuff = self.debuffAnchor.buffList[i]
		debuff:Hide()
	end
end

local auraWatch = function (ticker)
	ticker.cooldown.Timer:SetText (floor (ticker.expireTime-GetTime()))
end

local EnemyGrid_AuraOnEnter = function (self)
	if (self.spellId) then
		if (not EnemyGrid.db.profile.aura_show_tooltip) then
			return
		end
		GameTooltip:SetOwner (self, "ANCHOR_LEFT")
		GameTooltip:SetSpellByID (self.spellId)
		GameTooltip:Show()
	end
end
local EnemyGrid_AuraOnLeave = function (self)
	GameTooltip:Hide()
end

local AddAura = function (self, i, auraWidth, auraHeight, name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId, isBuff)
	if (not self.debuffAnchor.buffList [i]) then
		self.debuffAnchor.buffList [i] = CreateFrame ("Frame", self:GetName() .. "Debuff" .. i, self.debuffAnchor, "NameplateBuffButtonTemplate")
		self.debuffAnchor.buffList [i]:SetMouseClickEnabled (false)
		self.debuffAnchor.buffList [i]:SetBackdrop ({edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1})
		self.debuffAnchor.buffList [i]:SetScript ("OnEnter", EnemyGrid_AuraOnEnter)
		self.debuffAnchor.buffList [i]:SetScript ("OnLeave", EnemyGrid_AuraOnLeave)
		
		self.debuffAnchor.BuffFrameUpdateTime = 0
		local timer = self.debuffAnchor.buffList [i].Cooldown:CreateFontString (nil, "overlay", "NumberFontNormal")
		self.debuffAnchor.buffList [i].Cooldown.Timer = timer
		timer:SetPoint ("center")
	end
	
	local debuff = self.debuffAnchor.buffList [i]
	
	if (name == false) then
		if (EnemyGrid.RegenIsDisabled) then
			debuff.spellId = nil
			debuff:SetSize (auraWidth, auraHeight)
			--debuff.Icon:SetTexture (nil)
			debuff:SetBackdropBorderColor (0, 0, 0, 0)
			debuff:SetAlpha (.2)
			debuff:Show()
		else
			debuff:Hide()
		end
		return
	else
		debuff:SetAlpha (1)
	end
	
	--debuff:SetID (i)
	debuff.spellId = spellId
	debuff.name = name
	debuff.layoutIndex = i
	
	debuff:SetSize (auraWidth, auraHeight)
	debuff.Icon:SetSize (auraWidth-2, auraHeight-2)
	
	debuff.Icon:SetTexture (texture)
	if (count > 1) then
		debuff.CountFrame.Count:SetText (count)
		debuff.CountFrame.Count:Show()
	else
		debuff.CountFrame.Count:Hide()
	end
	
	if (debuff.Cooldown.TimerTicker and not debuff.Cooldown.TimerTicker._cancelled) then
		debuff.Cooldown.TimerTicker:Cancel()
	end
	
	if (isBuff) then
		debuff:SetBackdropBorderColor (1, 1, 0, 1)
	else
		debuff:SetBackdropBorderColor (0, 0, 0, 0)
	end
	
	CooldownFrame_Set (debuff.Cooldown, expirationTime - duration, duration, duration > 0, true)
	
	if (EnemyGrid.db.profile.aura_timer) then
		local timeLeft = expirationTime - GetTime()
		local ticker = C_Timer.NewTicker (.33, auraWatch, timeLeft*3)
		ticker.expireTime = expirationTime
		ticker.cooldown = debuff.Cooldown
		debuff.Cooldown.Timer:Show()
		debuff.Cooldown.TimerTicker = ticker
		DF:SetFontSize (debuff.Cooldown.Timer, Lerp (9, 22, auraHeight/40))
		auraWatch (ticker)
	else
		debuff.Cooldown.Timer:Hide()
	end
	
	debuff:Show()
	hasDebuffs = true
end

local namePlateOnEvent = function (self, event, ...)
	if (event == "UNIT_AURA") then
		local profile = EnemyGrid.db.profile
		local hasDebuffs = false
		local auraWidth = profile.aura_width
		local auraHeight = profile.aura_height
		
		if (profile.aura_tracker.track_method == 0x1) then
			local buff_banned = profile.aura_tracker.buff_banned
			local debuff_banned = profile.aura_tracker.debuff_banned
			
			if (self.actorType == ACTORTYPE_ENEMY_PLAYER or self.actorType == ACTORTYPE_ENEMY_NPC) then
				local auraIndex = 1
				
				if (self.actorType == ACTORTYPE_ENEMY_NPC) then
					--enemy npc buffs
					for i = 1, BUFF_MAX_DISPLAY do
						local name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId = UnitAura (self.NamePlateId, i, "HELPFUL")
						if (name and not buff_banned [spellId] and spellId ~= 228466) then
						--buff 218502 from botanist tel'arn
							AddAura (self, auraIndex, auraWidth, auraHeight, name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId, true)
							auraIndex = auraIndex + 1
						end
					end
					
				elseif (self.actorType == ACTORTYPE_ENEMY_PLAYER) then
					--enemy player buffs
					local class = self.class or select (2, UnitClass (self.NamePlateId))
					local spells = EnemyGrid.ClassBuffCache [class]
					if (spells) then
						for i = 1, #spells do
							local name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId = UnitAura (self.NamePlateId, spells[i])
							if (name) then
								AddAura (self, auraIndex, auraWidth, auraHeight, name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId, true)
								auraIndex = auraIndex + 1
							end
						end
					end
				end

				--unit debuffs
				for i = 1, BUFF_MAX_DISPLAY do
					local name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId = UnitAura (self.NamePlateId, i, "HARMFUL|PLAYER")
					if (name and not debuff_banned [spellId]) then
						AddAura (self, auraIndex, auraWidth, auraHeight, name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId)
						auraIndex = auraIndex + 1
					end
				end
				
				--esconde os frames n�o usados
				for i = auraIndex, #self.debuffAnchor.buffList do
					self.debuffAnchor.buffList [i]:Hide()
				end
			end
		
		elseif (profile.aura_tracker.track_method == 0x2) then
			local buffs = profile.aura_tracker.buff
			local debuffs = profile.aura_tracker.debuff
			
			local auraIndex = 1
			
			for i = 1, #debuffs do
				local name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId = UnitAura (self.NamePlateId, debuffs [i], nil, "HARMFUL|PLAYER")
				if (name) then
					AddAura (self, auraIndex, auraWidth, auraHeight, name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId)
					auraIndex = auraIndex + 1
				elseif (profile.aura_always_show_debuffs) then
					AddAura (self, auraIndex, auraWidth, auraHeight, false)
					auraIndex = auraIndex + 1
				end
			end
			
			for i = 1, #buffs do
				local name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId = UnitAura (self.NamePlateId, buffs [i])
				if (name) then
					AddAura (self, auraIndex, auraWidth, auraHeight, name, rank, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellId, true)
					auraIndex = auraIndex + 1
				end
			end
			
			--esconde os frames n�o usados
			for i = auraIndex, #self.debuffAnchor.buffList do
				self.debuffAnchor.buffList [i]:Hide()
			end
		end
		
		self.debuffAnchor:Layout()
		
		if (hasDebuffs) then 
			local anchor1, anchor2, anchor3 = profile.debuff_anchor_grow_direction == "right" and "topleft" or "topright", profile.debuff_anchor_grow_direction == "right" and "topright" or "topleft", profile.debuff_anchor_grow_direction == "right" and "topleft" or "topright"
			local last
			for i = 1, #self.debuffAnchor.buffList do 
				local debuff = self.debuffAnchor.buffList[i]
				debuff:ClearAllPoints()
				if (last) then
					debuff:SetPoint (anchor1, last, anchor2, profile.debuff_anchor_grow_direction == "right" and 1 or -1, 0)
				else
					debuff:SetPoint (anchor1, self.debuffAnchor, anchor3, profile.debuff_anchor_grow_direction == "right" and 1 or -1, 0)
				end
				last = debuff
			end
		end
	end
end

local playerBuffList = {
	["DEMONHUNTER"] = {
		
	},
	["DEATHKNIGHT"] = {
		[55233] = {60, 10}, -- Vampiric Blood
		[48792] = {180, 12}, -- Icebound Fortitude
		
	},
	["WARRIOR"] = {
		[1719]	=	true, -- Recklessness (attack cd)
		[871] = true, -- Shield Wall
		[118038] = true, -- Die by the Sword
		[23920] = true, -- Spell Reflection
	},
	["MAGE"] = {
		[12472]	=	true,-- Icy Veins
		[12042]	=	true,-- Arcane Power
		[80353]	=	true,-- Time Warp
		[45438] = true, -- Ice Block
	},
	["ROGUE"] = {
		[13750]	=	true, -- Adrenaline Rush (attack cd)
		[31224] = true, -- Cloak of Shadows
		[5277] = true, -- Evasion
	},
	["DRUID"] = {
		[106951]	=	 true, -- Berserk (attack cd)
		[112071]	=	 true, -- Celestial Alignment
		[62606] = true, -- Savage Defense
		[61336] = true, -- Survival Instincts
	},
	["HUNTER"] = {
		[19263] = true, -- Deterrence
	},
	["SHAMAN"] = {
		[2825]	=	true, -- Bloodlust
		[108271] = true, -- Astral Shift
	},
	["PRIEST"] = {
		[10060]	=	true, -- Power Infusion
		[47585] = true, -- Dispersion
		[33206] = true, -- Pain Suppression
	},
	["WARLOCK"] = {
		[110913] = true, -- Dark Bargain
	},
	["PALADIN"] = {
		[31884]	=	true,-- Avenging Wrath
		[1022] = true, -- Hand of Protection
	},
	["MONK"] = {
		[115288]	=	true, -- Energizing Brew
		
	},
}

local defaultSpecKeybindList = {
	["DEMONHUNTER"] = {
		[577] = {--> havoc demon hunter
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		}, 
		[581] = {--> vengeance demon hunter
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
	},
	["DEATHKNIGHT"] = {
		[250] = { --> blood dk
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
		[251] = { --> frost dk
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
		[252] = { --> unholy dk
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
	},
	["WARRIOR"] = {
		[71] = { --> warrior arms
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
		[72] = { --> warrior fury
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
		[73] = { --> warrior protect
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
	},
	["MAGE"] = {
		[62] = { --> mage arcane
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
		},
		[63] = { --> mage fire
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
		},
		[64] = { --> mage frost
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
		},
	},
	["ROGUE"] = {
		[259] = { --> rogue assassination
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
		},
		[260] = { --> rogue combat
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
		},		
		[261] = { --> rogue sub
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
		},
	},
	["DRUID"] = {
		[102] = { -->  druid balance
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_dispel", actiontext = ""},
		},
		[103] = { -->  druid feral
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
		[104] = { -->  druid guardian
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
		[105] = { -->  druid resto
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_dispel", actiontext = ""},
		},
	},
	["HUNTER"] = {
		[253] = { -->  hunter bm
			{key = "type1", action = "_target", actiontext = ""},
		},
		[254] = { --> hunter marks
			{key = "type1", action = "_target", actiontext = ""},
		},		
		[255] = { --> hunter survivor
			{key = "type1", action = "_target", actiontext = ""},
		},
	},
	["SHAMAN"] = {
		[262] = { --> shaman elemental
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
		},
		[263] = { --> shamel enhancement
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
		},
		[264] = { --> shaman resto
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
		},
	},
	["PRIEST"] = {
		[256] = { --> priest disc
			{key = "type1", action = "_target", actiontext = ""},
		},
		[257] = { --> priest holy
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_dispel", actiontext = ""},
		},
		[258] = { --> priest shadow
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
		},
	},
	["WARLOCK"] = {
		[265] = { --> warlock aff
			{key = "type1", action = "_target", actiontext = ""},
		},
		[266] = { --> warlock demo
			{key = "type1", action = "_target", actiontext = ""},
		},
		[267] = { --> warlock destro
			{key = "type1", action = "_target", actiontext = ""},
		},
	},
	["PALADIN"] = {
		[65] = { --> paladin holy
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_dispel", actiontext = ""},
		},
		[66] = { --> paladin protect
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
		[70] = { --> paladin ret
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		},
	},
	["MONK"] = {
		[268] = {--> monk bm
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		}, 
		[269] = {--> monk ww
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_interrupt", actiontext = ""},
			{key = "type3", action = "_taunt", actiontext = ""},
		}, 
		[270] = {--> monk mw
			{key = "type1", action = "_target", actiontext = ""},
			{key = "type2", action = "_dispel", actiontext = ""},
		}, 
	},
}

local re_GetCurrentSpec = function()
	EnemyGrid.GetCurrentSpec()
end

function EnemyGrid.GetCurrentSpec()
	local specIndex = GetSpecialization()
	HEALTH_CUT_OFF = nil
	if (specIndex) then
		local specID = GetSpecializationInfo (specIndex)
		if (specID and specID ~= 0) then
			EnemyGrid.CurrentSpec = specID
			if (specID == 258) then
				local _, _, _, using_ROS = GetTalentInfo (4, 2, 1)
				if (using_ROS) then
					HEALTH_CUT_OFF = 35
				else
					HEALTH_CUT_OFF = 20
				end
			end
		else
			C_Timer.After (1, re_GetCurrentSpec)
		end
	else
		C_Timer.After (1, re_GetCurrentSpec)
	end
end

local re_LoadKeybindsFromDB = function()
	EnemyGrid.LoadKeybindsFromDB()
end

function EnemyGrid.LoadKeybindsFromDB()
	local specIndex = GetSpecialization()
	if (specIndex) then
		local specID = GetSpecializationInfo (specIndex)
		if (specID) then
			local keys = EnemyGridDBChr.KeyBinds [specID]
			if (not keys) then
				--if no keys stored, populate with the default keys
				local _, class = UnitClass ("player")
				if (class) then
					for thisSpecID, keybinds in pairs (defaultSpecKeybindList [class]) do
						EnemyGridDBChr.KeyBinds [thisSpecID] = keybinds
					end
					EnemyGrid.CurrentKeybindSet = EnemyGridDBChr.KeyBinds [specID]
					EnemyGrid.CurrentSpec = specID
					return true
				else
					C_Timer.After (.1, re_LoadKeybindsFromDB)
				end
			else
				EnemyGrid.CurrentKeybindSet = keys
				EnemyGrid.CurrentSpec = specID
				return true
			end
		else
		 	C_Timer.After (.1, re_LoadKeybindsFromDB)
		end
	else
		C_Timer.After (.1, re_LoadKeybindsFromDB)
	end
end

function EnemyGrid:PLAYER_SPECIALIZATION_CHANGED()
	local specIndex = GetSpecialization()
	if (specIndex) then
		local specID = GetSpecializationInfo (specIndex)
		if (specID) then
			if (specID ~= EnemyGrid.CurrentSpec) then
				if (EnemyGrid.LoadKeybindsFromDB()) then
					EnemyGrid:UpdateKeyBinds()
					if (EnemyGridOptionsPanelFrameKeybindFrame) then
						if (EnemyGridOptionsPanelFrameKeybindFrame:IsShown()) then
							EnemyGridOptionsPanelFrameKeybindFrame:Hide()
							EnemyGridOptionsPanelFrameKeybindFrame:Show()
						end
					end
				end
			end
		end
	end
	
	EnemyGrid.GetCurrentSpec()
	EnemyGrid.GetSpellForRangeCheck()
	EnemyGrid.CanShow()
end

local specDefaultSpellRange = {
	[577] = 198013, --> havoc demon hunter - Eye-Beam
	[581] = 185245, --> vengeance demon hunter - Torment

	[250] = 56222, --> blood dk - dark command
	[251] = 56222, --> frost dk - dark command
	[252] = 56222, --> unholy dk - dark command
	
	[102] = 164815, -->  druid balance - Sunfire
	[103] = 6795, -->  druid feral - Growl
	[104] = 6795, -->  druid guardian - Growl
	[105] = 5176, -->  druid resto - Solar Wrath

	[253] = 193455, -->  hunter bm - Cobra Shot
	[254] = 19434, --> hunter marks - Aimed Shot
	[255] = 190925, --> hunter survivor - Harpoon
	
	[62] = 227170, --> mage arcane - arcane blast
	[63] = 133, --> mage fire - fireball
	[64] = 228597, --> mage frost - frostbolt
	
	[268] = 115546 , --> monk bm - Provoke
	[269] = 115546, --> monk ww - Provoke
	[270] = 115546, --> monk mw - Provoke
	
	[65] = 62124, --> paladin holy - Hand of Reckoning
	[66] = 62124, --> paladin protect - Hand of Reckoning
	[70] = 62124, --> paladin ret - Hand of Reckoning
	
	[256] = 585, --> priest disc - Smite
	[257] = 585, --> priest holy - Smite
	[258] = 8092, --> priest shadow - Mind Blast
	
	[259] = 185565, --> rogue assassination - Poisoned Knife
	[260] = 185763, --> rogue combat - Pistol Shot
	[261] = 36554, --> rogue sub - Shadowstep

	[262] = 403, --> shaman elemental - Lightning Bolt
	[263] = 51514, --> shamel enhancement - Hex
	[264] = 403, --> shaman resto - Lightning Bolt

	[265] = 980, --> warlock aff - Agony
	[266] = 686, --> warlock demo - Shadow Bolt
	[267] = 116858, --> warlock destro - Chaos Bolt
	
	[71] = 100, --> warrior arms - Charge --132337 on beta
	[72] = 100, --> warrior fury - Charge
	[73] = 355, --> warrior protect - Taunt
}

local tauntList = {
	["DEATHKNIGHT"] = 56222, --Dark Command
	["DEMONHUNTER"] = 185245, --Torment
	["WARRIOR"] = 355, --Taunt
	["PALADIN"] = 62124, --Hand of Reckoning
	["MONK"] = 115546, --Provoke
	["DRUID"] = 6795, --Growl
}

local interruptList = {
	["DEATHKNIGHT"] = 47528, --Mind Freeze
	["DEMONHUNTER"] = 183752, --Consume Magic
	["WARRIOR"] = 6552, --Pummel
	["PALADIN"] = 96231, --Rebuke
	["MONK"] = 116705, --Spear Hand Strike
	["HUNTER"] = 147362, --Counter Shot
	["MAGE"] = 2139, --Counterspell
	["DRUID"] = 106839, --Skull Bash - 
	["ROGUE"] = 1766, --Kick
	["SHAMAN"] = 57994, --Wind Shear
	["PRIEST"] = 15487, --Silence
}

local dispelList = {
	["PALADIN"] = {[65] = 4987, [66] = 213644, [70] = 213644}, --Cleanse - Cleanse Toxins - so holy tem 'cleanse' tank e dps tem o toxins
	["MONK"] = 115450, --Detox
	["DRUID"] = {[102] = 2782, [103] = 2782, [104] = 2782, [105] = 88423}, --Nature's Cure - Remove Corruption -so restoration tem o natures cure
	["SHAMAN"] = {[262] = 51886, [263] = 51886, [264] = 77130}, --elemental melee Cleanse Spirit - resto Purify Spirit
	["PRIEST"] = {[256] = 527, [257] = 527, [258] = 213634}, --Purify holy disc - Purify Disease shadow
}

local re_GetSpellForRangeCheck = function()
	EnemyGrid.GetSpellForRangeCheck()
end
function EnemyGrid.GetSpellForRangeCheck()
	local specIndex = GetSpecialization()
	if (specIndex) then
		local specID = GetSpecializationInfo (specIndex)
		if (specID and specID ~= 0) then
			
			EnemyGrid.SpellForRangeCheck = EnemyGridDBChr.spellRangeCheck [specID]
			--local spellID = specDefaultSpellRange [specID]
			--local spellName = GetSpellInfo (spellID)
			--if (spellName and spellName ~= "") then
			--	EnemyGrid.SpellForRangeCheck = spellName
			--else
			--	C_Timer.After (5, re_GetSpellForRangeCheck)
			--end
		else
		 	C_Timer.After (5, re_GetSpellForRangeCheck)
		end
	else
		C_Timer.After (5, re_GetSpellForRangeCheck)
	end
end

--verifica se passa no filtro de pode ou nao pode mostrar na tela
local re_CanShow = function()
	EnemyGrid.CanShow()
end

-- entering_combat vem do regen_disabled, no event incombatlockdown reporta false
function EnemyGrid.CanShow (entering_combat)
	local can_show = true
	
	if (InCombatLockdown() or not EnemyGrid.CurrentSpec) then
		--n�o pode alternar a visibilidade se estiver em combate ou se nao tiver a spec ainda
		if (not EnemyGrid.CurrentSpec) then
			EnemyGrid.GetCurrentSpec()
		end
		return C_Timer.After (1, re_CanShow)
	end
	
	if (EnemyGrid.db.profile.only_instance and not IsInInstance()) then
		can_show = false
	end
	if (EnemyGrid.db.profile.only_incombat and (not InCombatLockdown() and not entering_combat)) then
		can_show = false
	end
	if (EnemyGrid.db.profile.only_inboss and not EnemyGrid.InBossEncounter) then
		can_show = false
	end
	if (not EnemyGridDBChr.specEnabled [EnemyGrid.CurrentSpec]) then
		can_show = false
	end
	
	if (can_show) then
		EnemyGrid.ScreenPanel:Show()
	else
		EnemyGrid.ScreenPanel:Hide()
	end
end

local re_RefreshAmountOfUnitsShown = function()
	EnemyGrid.RefreshAmountOfUnitsShown()
end
function EnemyGrid.RefreshAmountOfUnitsShown()
	if (InCombatLockdown()) then
		C_Timer.After (1, re_RefreshAmountOfUnitsShown)
	end
	for i = 1, EnemyGrid.db.profile.max_targets do
		local unitFrame = EnemyGrid.unitFrameContainer [i]
		RegisterUnitWatch (unitFrame)
		unitFrame.isDisabled = nil
		
		if (UnitExists (unitFrame.unit)) then
			EnemyGrid.HandleNameplateEvents (EnemyGrid.ScreenPanel, "NAME_PLATE_UNIT_ADDED", unitFrame.unit)
		end
	end
	for i = EnemyGrid.db.profile.max_targets+1, 40 do
		local unitFrame = EnemyGrid.unitFrameContainer [i]
		UnregisterUnitWatch (unitFrame)
		unitFrame.isDisabled = true
		unitFrame:Hide()
	end
end

function EnemyGrid:RefreshConfig()
	EnemyGrid.UpdateGrid()
	EnemyGrid.ReEvent()
	if (EnemyGridOptionsPanelFrame) then
		EnemyGridOptionsPanelFrame.RefreshOptionsFrame()
	end
end

function EnemyGrid.OnInit()

	if (not EnemyGrid.db.profile.first_run) then
		C_Timer.After (5, function() EnemyGrid:SelectLayoutWizard() end)
		if (not InCombatLockdown()) then
			SetCVar ("nameplateMaxDistance", 100)
		end
	end
	
	for class, t in pairs (playerBuffList) do
		EnemyGrid.ClassBuffCache [class] = {}
		for spellid, _ in pairs (t) do
			local spellname = GetSpellInfo (spellid)
			if (spellname) then
				tinsert (EnemyGrid.ClassBuffCache [class], spellname)
			end
		end
	end
	for _, spellid in ipairs (BuffsBannedList) do
		local spellname = GetSpellInfo (spellid)
		if (spellname) then
			FILTER_BUFFS_BANNED [spellname] = true
		end
	end
	
	C_Timer.After (10, function()
		if (not EnemyGrid.db.profile.path_7_11_warning) then
			local f = CreateFrame ("frame", nil, UIParent)
			f:SetSize (600, 300)
			f:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1})
			f:SetBackdropColor (0, 0, 0)
			f:SetBackdropBorderColor (1, 0, 0)
			
			local title = DF:CreateLabel (f, "R.I.P.? Enemy Grid", 16, "yellow")
			local text = DF:CreateLabel (f, "We're still receiving many questions about Enemy Grid not working.\n\nEnemy Grid has been hit by several changes on the mod authoring API on Patch 7.1\n\nWith that, we can no longer use our frames on the 2D interface to target enemies on the 3D world.\n\nPlease take in mind that the company that creates this game always want to provide the best experience for us, and, we believe Enemy Grid was indeed an 'OP' mod.\n\nThank you!", 12, "orange")
			text:SetSize (540, 200)
			
			title:SetPoint (12, -12)
			text:SetPoint (12, -30)
			
			local close = DF:CreateButton (f, function() f:Hide(); EnemyGrid.db.profile.path_7_11_warning = true; end, 80, 20, "close")
			close:SetPoint ("bottomright", f, "bottomright", -12, 12)
			close:InstallCustomTexture()
			f:SetPoint ("center")
			f:Show()
		end
	end)	

	--cria o painel principal
	EnemyGrid.ScreenPanel = CreateFrame ("frame", "EnemyGrid_ScreenPanel39", UIParent)
	EnemyGrid.ScreenPanel:SetPoint ("center", UIParent, "center", -500, 200)

	if (not EnemyGrid.db.profile.point) then
		LibWindow.RegisterConfig (EnemyGrid.ScreenPanel, EnemyGrid.db.profile)
	else
		LibWindow.RegisterConfig (EnemyGrid.ScreenPanel, EnemyGrid.db.profile)
		LibWindow.RestorePosition (EnemyGrid.ScreenPanel)
	end
	
	LibWindow.MakeDraggable (EnemyGrid.ScreenPanel)
	
	EnemyGrid.factionGroup = UnitFactionGroup ("player")
	EnemyGrid.SpellForRangeCheck = ""
	C_Timer.After (1, EnemyGrid.GetSpellForRangeCheck)
	
	EnemyGridDBChr = EnemyGridDBChr or {KeyBinds = {}, debuffsBanned = {}, specEnabled = {}, spellRangeCheck = {}}
	EnemyGridDBChr.debuffsBanned = EnemyGridDBChr.debuffsBanned or {}
	EnemyGridDBChr.specEnabled = EnemyGridDBChr.specEnabled or {}
	EnemyGridDBChr.spellRangeCheck = EnemyGridDBChr.spellRangeCheck or {}
	
	for specID, _ in pairs (defaultSpecKeybindList [select (2, UnitClass ("player"))]) do
		if (EnemyGridDBChr.specEnabled [specID] == nil) then
			EnemyGridDBChr.specEnabled [specID] = true
		end
		if (EnemyGridDBChr.spellRangeCheck [specID] == nil) then
			EnemyGridDBChr.spellRangeCheck [specID] = GetSpellInfo (specDefaultSpellRange [specID])
		end
	end
	
	EnemyGrid.CurrentKeybindSet = {}
	EnemyGrid.LoadKeybindsFromDB()
	
	FILTER_DEBUFFS_BANNED = EnemyGridDBChr.debuffsBanned
	
	local tab = EnemyGrid.ScreenPanel:CreateTexture (nil, "artwork")
	tab:SetSize (80, 18)
	tab:SetColorTexture (.7, .7, .7, .1)
	tab:SetPoint ("topleft", EnemyGrid.ScreenPanel, "topleft", 0, -2)
	local tabText = EnemyGrid.ScreenPanel:CreateFontString (nil, "artwork", "GameFontNormal")
	tabText:SetPoint ("left", tab, "left", 2, 0)
	tabText:SetText ("Enemy Grid")
	EnemyGrid:SetFontOutline (tabText, true)
	EnemyGrid.tab = tab
	EnemyGrid.ScreenPanel.titleTab = tab
	EnemyGrid.ScreenPanel.titleTabText = tabText
	EnemyGrid.ScreenPanel:SetMovable (true)
	EnemyGrid.ScreenPanel:EnableMouse (true)
	EnemyGrid.ScreenPanel:SetFrameLevel (20)
	
	EnemyGrid.ScreenPanel:RegisterEvent ("NAME_PLATE_UNIT_ADDED")
	EnemyGrid.ScreenPanel:RegisterEvent ("NAME_PLATE_UNIT_REMOVED")
	EnemyGrid.ScreenPanel:RegisterEvent ("ENCOUNTER_START")
	EnemyGrid.ScreenPanel:RegisterEvent ("ENCOUNTER_END")
	
	EnemyGrid.ScreenPanel:SetScript ("OnEnter", function()
		GameTooltip:SetOwner (EnemyGrid.ScreenPanel, "ANCHOR_TOPLEFT")
		GameTooltip:AddLine (L["S_ANCHOR_TOOLTIP"])
		GameTooltip:Show()
	end)
	EnemyGrid.ScreenPanel:SetScript ("OnLeave", function()
		GameTooltip:Hide()
	end)
	EnemyGrid.ScreenPanel:SetScript ("OnMouseUp", function (self, button)
		if (button == "RightButton") then
			EnemyGrid.OpenOptionsPanel()
		end
	end)
	
	--highlight para o alvo
	--local highlightFrame = CreateFrame ("frame", "PlaterNameGrid_TargetHighlight", EnemyGrid.ScreenPanel)
	--highlightFrame:SetFrameLevel (22)
	
	--cria os frames
	EnemyGrid.unitFrameContainer = {}
	EnemyGrid.unitFrameIDsContainer = {}
	
	local frameOptions = {
		healthBarColorOverride = false,
		useClassColors = true,
		colorHealthBySelection = true,
		considerSelectionInCombatAsHostile = false,
		colorHealthWithExtendedColors = false,
		greyOutWhenTapDenied = true,
	}
	
	local maxTargets = EnemyGrid.db.profile.max_targets
	for i = 1, 40 do
		-- ~create
		local button = CreateFrame ("button", "EnemyGrid_UnitFrame" .. i, EnemyGrid.ScreenPanel, "SecureUnitButtonTemplate,SecureHandlerEnterLeaveTemplate,SecureHandlerShowHideTemplate")
		tinsert (EnemyGrid.unitFrameContainer, button)
		button.NamePlateId = "nameplate" .. i
		button.unit = "nameplate" .. i
		button.displayedUnit = "nameplate" .. i
		button.index = i
		EnemyGrid.unitFrameIDsContainer [button.NamePlateId] = button
		button:SetFrameLevel (21)
		button:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1})
		button:SetBackdropBorderColor (1, 1, 1, 1)
		button.optionTable = frameOptions
		button:Hide()
		
		button:SetAttribute ("unit", button.NamePlateId)
		button:SetAttribute ("_onleave", "self:ClearBindings();")
		button:SetAttribute ("_onshow", "self:ClearBindings();")
		button:SetAttribute ("_onhide", "self:ClearBindings();")
		button:RegisterForClicks ("AnyDown")
		RegisterUnitWatch (button)
		--RegisterStateDriver (button, "visibility") --is there any difference?
		button:SetScript ("OnEvent", namePlateOnEvent)
		
		--health statusbar
		local healthBar = CreateFrame ("statusbar", "EnemyGrid_UnitFrame" .. i .. "HealthBar", button)
		healthBar:SetPoint ("topleft", 1, -1)
		healthBar:SetPoint ("bottomright", -1, 1)
		healthBar:SetAlpha (.1)
		healthBar.NamePlateId = "nameplate" .. i
		healthBar.unit = "nameplate" .. i
		healthBar:SetFrameLevel (22)
		button.healthBar = healthBar
		local healthTexture = healthBar:CreateTexture (nil, "background")
		healthBar:SetStatusBarTexture (healthTexture)
		button.healthTexture =  healthTexture
		healthBar.Texture =  healthTexture
		healthBar.barTexture =  healthTexture
		--background texture
		local backgroundTexture = healthBar:CreateTexture (nil, "background")
		backgroundTexture:SetAllPoints()
		button.backgroundTexture = backgroundTexture
		healthTexture:SetDrawLayer ("background", -5)
		backgroundTexture:SetDrawLayer ("background", 3)
		
		--nome do jogador e percentagem da vida
		local healthPercent =  healthBar:CreateFontString (nil, "artwork", "GameFontNormal")
		healthBar.healthPercent = healthPercent
		button.healthPercent = healthPercent
		local playerName =  healthBar:CreateFontString (nil, "artwork", "GameFontNormal")
		healthBar.playerName = playerName
		button.playerName = playerName

		--castbar
		local castBar = CreateFrame ("statusbar", "EnemyGrid_UnitFrame" .. i .. "CastBar", button)
		castBar:Hide()
		castBar.NamePlateId = "nameplate" .. i
		castBar.EnemyGrid = true
		castBar:SetFrameLevel (23)
		button.castBar = castBar
		healthBar.castBar = castBar

		castBar.iconWhenNoninterruptible = false
		
		castBar.background = castBar:CreateTexture (nil, "background")
		castBar.background:SetAllPoints()
		
		castBar.Text = castBar:CreateFontString (nil, "overlay", "SystemFont_Shadow_Small")
		castBar.Text:SetPoint ("center", 0, 0)

		castBar.BorderShield = castBar:CreateTexture (nil, "overlay", 1)
		castBar.BorderShield:Hide()
		castBar.BorderShield:SetSize (10, 12)
		castBar.BorderShield:SetPoint ("center", castBar, "left", -2, -1)
		
		castBar.Icon = castBar:CreateTexture (nil, "overlay", 1)
		castBar.Icon:Hide()
		castBar.Icon:SetSize (10, 10)
		castBar.Icon:SetPoint ("left", castBar, "left", 0, 0)

		castBar.Spark = castBar:CreateTexture (nil, "overlay")
		castBar.Spark:SetTexture ([[Interface\CastingBar\UI-CastingBar-Spark]])
		castBar.Spark:SetBlendMode ("ADD")
		castBar.Spark:SetSize (16, 16)
		castBar.Spark:SetPoint ("center", 0, 0)
		
		castBar.Flash = castBar:CreateTexture (nil, "overlay")
		castBar.Flash:SetTexture ([[Interface\TargetingFrame\UI-TargetingFrame-BarFill]])
		castBar.Flash:SetBlendMode ("ADD")
		castBar.Flash:SetAllPoints()
		
		castBar:SetScript ("OnEvent", CastingBarFrame_OnEvent)
		castBar:SetScript ("OnUpdate", CastingBarFrame_OnUpdate)
		castBar:SetScript ("OnShow", CastingBarFrame_OnShow)
		
		castBar.Texture = castBar:CreateTexture (nil, "artwork")
		castBar.Texture:SetAllPoints()
		castBar:SetStatusBarTexture (castBar.Texture)
		
		CastingBarFrame_OnLoad (castBar, button.NamePlateId, false, true)

		--debuffs
		local debuffAnchor = CreateFrame ("frame", "EnemyGrid_UnitFrame" .. i .. "DebuffAnchor", button, "HorizontalLayoutFrame")
		debuffAnchor:SetFrameLevel (24)
		button.debuffAnchor = debuffAnchor
		debuffAnchor.buffList = {}
		debuffAnchor.unit = button.NamePlateId
		debuffAnchor.filter = "HARMFUL|PLAYER"
		debuffAnchor:SetSize (1, 1)
		debuffAnchor.debuffFrameContainer = {}
		
		local overlayFrame = CreateFrame ("frame", "EnemyGrid_UnitFrame" .. i .. "Overlay", button)
		overlayFrame:SetAllPoints()
		overlayFrame:SetFrameLevel (25)
		overlayFrame:SetBackdrop ({edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1})
		overlayFrame:SetBackdropBorderColor (1, 1, 0, 0)
		button.overlayFrame = overlayFrame
		
		--target highlight
		local highlightTexture = overlayFrame:CreateTexture (nil, "artwork")
		highlightTexture:SetColorTexture (1, 1, 1, 0.35)
		highlightTexture:SetAllPoints()
		highlightTexture:Hide()
		button.highlightTexture = highlightTexture
		button.selectionHighlight = highlightTexture
		
		--raid marker
		local raidMarker = overlayFrame:CreateTexture (nil, "overlay")
		button.raidMarker = raidMarker
		
		--shadow word: death
		--local SWD = overlayFrame:CreateTexture (nil, "overlay")
		--SWD:SetTexture ([[Interface\AddOns\EnemyGrid\images\priest_shadowword_death]])
		--SWD:SetPoint ("right", button, "right", -2, 0)
		--SWD:SetSize (20, 20)
		
		local healthCutOff = healthBar:CreateTexture (nil, "overlay")
		healthCutOff:SetTexture ([[Interface\AddOns\EnemyGrid\images\health_bypass_indicator]])
		healthCutOff:SetPoint ("left", button, "left")
		healthCutOff:SetSize (16, 25)
		healthCutOff:SetBlendMode ("ADD")
		healthCutOff:SetDrawLayer ("overlay", 7)
		healthCutOff:Hide()
		button.healthCutOff = healthCutOff
		healthBar.healthCutOff = healthCutOff
		
		local animationOnPlay = function()
			healthCutOff:Show()
		end
		local animationOnStop = function()
			healthCutOff:SetAlpha (.5)
		end
		
		local healthCutOffShowAnimation = DF:CreateAnimationHub (healthCutOff, animationOnPlay, animationOnStop)
		DF:CreateAnimation (healthCutOffShowAnimation, "Scale", 1, .2, .3, .3, 1.2, 1.2)
		DF:CreateAnimation (healthCutOffShowAnimation, "Scale", 2, .2, 1.2, 1.2, 1, 1)
		DF:CreateAnimation (healthCutOffShowAnimation, "Alpha", 1, .2, .2, 1)
		DF:CreateAnimation (healthCutOffShowAnimation, "Alpha", 2, .2, 1, .5)
		healthCutOff.ShowAnimation = healthCutOffShowAnimation
		
		--icone de identifica��o
		local iconIndicator = overlayFrame:CreateTexture (nil, "overlay")
		button.iconIndicator = iconIndicator
		
		--levels
		healthTexture:SetDrawLayer ("border", 1)
		highlightTexture:SetDrawLayer ("border", 3)
		healthPercent:SetDrawLayer ("artwork", 2)
		playerName:SetDrawLayer ("artwork", 2)
		raidMarker:SetDrawLayer ("overlay", 3)
		iconIndicator:SetDrawLayer ("overlay", 3)
		
		EnemyGrid.CreateAggroFlashFrame (button)
	end
	
	hooksecurefunc ("CastingBarFrame_OnEvent", function (self, event, ...)

		if (not self.EnemyGrid) then
			return
		end
		
		local unit = ...
		
		if (event == "PLAYER_ENTERING_WORLD") then
			unit = self.unit
			
			local castname = UnitCastingInfo (unit)
			local channelname = UnitChannelInfo (unit)
			if (castname) then
				event = "UNIT_SPELLCAST_START"
			elseif (channelname) then
				event = "UNIT_SPELLCAST_CHANNEL_START"
			else
				return
			end
		end
		
		if (event == "UNIT_SPELLCAST_START") then
			local unitCast = unit
			if (unitCast ~= self.unit) then
				return
			end
			local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo (unitCast)
			self.Icon:SetTexture (texture)
			self.Icon:Show()
			
			if (notInterruptible) then
				self.Texture:SetVertexColor (unpack (EnemyGrid.db.profile.cast_statusbar_color_nointerrupt))
			else
				self.Texture:SetVertexColor (unpack (EnemyGrid.db.profile.cast_statusbar_color))
			end
		
		elseif (event == "UNIT_SPELLCAST_CHANNEL_START") then
			local unitCast = unit
			if (unitCast ~= self.unit) then
				return
			end
			local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo (unitCast)
			self.Icon:SetTexture (texture)
			self.Icon:Show()
			
			if (notInterruptible) then
				self.Texture:SetVertexColor (unpack (EnemyGrid.db.profile.cast_statusbar_color_nointerrupt))
			else
				self.Texture:SetVertexColor (unpack (EnemyGrid.db.profile.cast_statusbar_color))
			end
		end
	end)
	
	local checkRange = function (self) --~range_check ~rangecheck
		--UnitInRange(frame.displayedUnit) para friedndly pc
	
		local isOnRange = IsSpellInRange (EnemyGrid.SpellForRangeCheck, self.NamePlateId)
		if (isOnRange == 1) then
			self:SetAlpha (1)
			self.castBar.Icon:SetAlpha (1)
			self.castBar.background:SetAlpha (1)
		else
			local alpha = EnemyGrid.db.profile.frame_range_alpha
			self:SetAlpha (alpha)
			self.castBar.Icon:SetAlpha ((alpha+.2))
			self.castBar.background:SetAlpha ((alpha+.2))
		end
	end
	
	nextRangeCheck = CONST_RANGECHECK_INTERVAL
	
	local onTickFunc = function (self, deltaTime) --self = healthBar
		if (not UnitExists (self.NamePlateId)) then
			self.playerName:SetText ("")
			self.healthPercent:SetText ("")
			self:SetAlpha (0)
			self:SetScript ("OnUpdate", nil)
		else
			--vida do mob
			local currentHealth = UnitHealth (self.NamePlateId)
			self:SetValue (currentHealth)
			
			local health = currentHealth / self.maxValue * 100
			
			self.healthPercent:SetText (floor (health) .. "%")
			if (HEALTH_CUT_OFF) then
				if (health <= HEALTH_CUT_OFF and not self.healthCutOff:IsShown()) then
					self.healthCutOff:SetPoint ("left", self:GetParent(), "left", self:GetWidth() / 100 * HEALTH_CUT_OFF, 0)
					self.healthCutOff.ShowAnimation:Play()
				end
			end

			--se esta no range
			if (self.nextRangeCheck < 0) then
				if (not self.IgnoreRangeCheck) then
					checkRange (self)
				end
				self.nextRangeCheck = CONST_RANGECHECK_INTERVAL
			else
				self.nextRangeCheck = self.nextRangeCheck - deltaTime
			end
			
			if (InCombatLockdown()) then
				local reaction = UnitReaction ("player", self.unit)
				if (reaction <= 4 and not IsTapDenied (self)) then
					EnemyGrid.UpdateAggroPlates (self)
				end
			end
		end
	end
	
	EnemyGrid.petCache = {}
	
	function EnemyGrid.UpdateAggroPlates (self) --self = healthBar

		if (UnitIsPlayer (self.unit) or EnemyGrid.petCache [self.guid] or self.unit:match ("pet%d$")) then
			return
		end
		
		self:SetAlpha (1)
		
		local isTanking, threatStatus = UnitDetailedThreatSituation ("player", self.unit)
		
		if (IsPlayerEffectivelyTank()) then
			--se o jogador � TANK
			if (not isTanking) then
				if (UnitAffectingCombat (self.unit)) then
					--n�o h� aggro neste mob mas ele esta participando do combate
					EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.tank.colors.noaggro))
				else
					--n�o ha aggro e ele n�o esta participando do combate
					if (self.reaction == 4) then
						--o mob � um npc neutro, apenas colorir com a cor neutra
						EnemyGrid.ForceChangeHealthBarColor (self, 1, 1, 0)
					else
						EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.tank.colors.nocombat))
					end
					self:SetAlpha (EnemyGrid.db.profile.not_affecting_combat_alpha)
				end
			else
				--o jogador esta tankando e:
				if (threatStatus == 3) then --esta tankando com seguran�a
					EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.tank.colors.aggro))
				elseif (threatStatus == 2) then --esta tankando sem seguran�a
					EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.tank.colors.pulling))
				else --n�o esta tankando
					EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.tank.colors.noaggro))
				end
			end

		else
			--o player � DPS
			if (isTanking) then
				--o jogador esta tankando como dps
				EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.dps.colors.aggro))
				if (not self:GetParent().playerHasAggro) then
					self:GetParent().PlayAggroFlash()
				end
				self:GetParent().playerHasAggro = true
			else
				if (threatStatus == 3) then --o jogador esta tankando como dps
					EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.dps.colors.aggro))
					if (not self:GetParent().playerHasAggro) then
						self:GetParent().PlayAggroFlash()
					end
					self:GetParent().playerHasAggro = true
				elseif (threatStatus == 2) then --esta tankando com pouco aggro
					EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.dps.colors.aggro))
					self:GetParent().playerHasAggro = true
				elseif (threatStatus == 1) then --esta quase puxando o aggro
					EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.dps.colors.pulling))
					self:GetParent().playerHasAggro = false
				elseif (threatStatus == 0) then --n�o esta tanando
					EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.dps.colors.noaggro))
					self:GetParent().playerHasAggro = false
					
				elseif (threatStatus == nil) then
					self:GetParent().playerHasAggro = false
					if (UnitAffectingCombat (self.unit)) then
						EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.dps.colors.noaggro))
					else
						EnemyGrid.ForceChangeHealthBarColor (self, unpack (EnemyGrid.db.profile.dps.colors.nocombat))
						self:SetAlpha (EnemyGrid.db.profile.not_affecting_combat_alpha)
					end
				end
			end
		end
	end
	
	function EnemyGrid.ForceChangeHealthBarColor (healthBar, r, g, b)
		if (r ~= healthBar.r or g ~= healthBar.g or b ~= healthBar.b) then
			healthBar.r, healthBar.g, healthBar.b = r, g, b
			healthBar.barTexture:SetVertexColor (r, g, b)
		end
	end

	function EnemyGrid.ReEvent()
		for i = 1, 40 do 
			local unitFrame = EnemyGrid.unitFrameContainer [i]
			if (not unitFrame.isDisabled) then
				if (UnitExists (unitFrame.unit)) then
					EnemyGrid.HandleNameplateEvents (EnemyGrid.ScreenPanel, "NAME_PLATE_UNIT_ADDED", unitFrame.unit)
					namePlateOnEvent (unitFrame, "UNIT_AURA")

					if (InCombatLockdown()) then
						local reaction = UnitReaction ("player", unitFrame.unit)
						if (reaction <= 4 and not IsTapDenied (unitFrame)) then
							EnemyGrid.UpdateAggroPlates (unitFrame.healthBar)
						end
					end
				end
			end
		end
	end
	
	function EnemyGrid.HandleNameplateEvents (self, event, plateID)
	
		local unitFrame = EnemyGrid.unitFrameIDsContainer [plateID]
		if (not unitFrame or unitFrame.isDisabled) then
			return
		end
		
		--> ~added
		if (event == "NAME_PLATE_UNIT_ADDED") then 
		
			if (UnitIsUnit (plateID, "player")) then
				--esconde por que trackeou a personal healthbar
				unitFrame:SetAlpha (0)
				unitFrame.healthBar.IgnoreRangeCheck = true
				return
			else
				unitFrame:SetAlpha (1)
				unitFrame.healthBar.IgnoreRangeCheck = nil
			end
			
			local name = UnitName (plateID) or "none"
			unitFrame.playerName:SetText (name)
			local stringSize = EnemyGrid.db.profile.name_text_stringsize
			
			while (unitFrame.playerName:GetStringWidth() > stringSize) do
				name = strsub (name, 1, #name-1)
				unitFrame.playerName:SetText (name)
			end
			
			unitFrame.healthBar:SetAlpha (1)
			unitFrame.castBar.Icon:SetAlpha (1)
			unitFrame.castBar.background:SetAlpha (1)
			unitFrame.guid = UnitGUID (plateID)
			unitFrame.quest = nil
			unitFrame.class = nil
			unitFrame.healthBar.guid = unitFrame.guid
			unitFrame.healthBar.maxValue = UnitHealthMax (plateID)
			unitFrame.healthBar:SetMinMaxValues (0, unitFrame.healthBar.maxValue)
			unitFrame.healthBar.nextRangeCheck = CONST_RANGECHECK_INTERVAL
			
			unitFrame.healthCutOff:Hide()
			
			--o que esta sendo mostrado na namaplate
			local reaction = UnitReaction ("player", plateID)
			unitFrame.reaction = reaction

			if (UnitIsPlayer (plateID)) then
				--� um jogador
				if (reaction > 4) then
					--jogador amigo, apenas trocar a cor da barra
					unitFrame.actorType = ACTORTYPE_FRIENDLY_PLAYER
				else
					
					--jogador inimigo, trocar a cor da barra e mostar o icone indicador
					if (EnemyGrid.db.profile.iconIndicator_show_faction) then
						if (EnemyGrid.factionGroup == "Horde") then
							unitFrame.iconIndicator:SetTexture ([[Interface\PVPFrame\PVP-Currency-Alliance]])
							unitFrame.iconIndicator:SetTexCoord (4/32, 29/32, 2/32, 30/32)
						else
							unitFrame.iconIndicator:SetTexture ([[Interface\PVPFrame\PVP-Currency-Horde]])
							unitFrame.iconIndicator:SetTexCoord (0, 1, 0, 1)
						end
						unitFrame.iconIndicator:Show()
					end
					unitFrame.actorType = ACTORTYPE_ENEMY_PLAYER
				end
				
				--ajusta a cor do frame de acordo com a classe do jogador
				if (EnemyGrid.db.profile.bar_color_by_class) then
					local _, playerClass = UnitClass (plateID)
					local color = RAID_CLASS_COLORS [playerClass]
					EnemyGrid.ForceChangeHealthBarColor (unitFrame.healthBar, color.r, color.g, color.b)
					unitFrame.class = playerClass
				else 
					if (reaction > 4) then
						EnemyGrid.ForceChangeHealthBarColor (unitFrame.healthBar, unpack (EnemyGrid.db.profile.npc_friendly_color))
					else
						EnemyGrid.ForceChangeHealthBarColor (unitFrame.healthBar, unpack (EnemyGrid.db.profile.npc_enemy_color))
					end
				end
			else
				if (reaction > 4) then
					unitFrame.actorType = ACTORTYPE_FRIENDLY_NPC
					CompactUnitFrame_UpdateHealthColor (unitFrame)
				else
					unitFrame.actorType = ACTORTYPE_ENEMY_NPC

					--verifica se � um npc de quest
					if (EnemyGrid.db.profile.quest_enabled) then
						local isQuestMob = EnemyGrid.IsQuestObjective (unitFrame)
						if (isQuestMob and not IsTapDenied (unitFrame)) then
							if (unitFrame.reaction == UNITREACTION_NEUTRAL) then
								EnemyGrid.ForceChangeHealthBarColor (unitFrame.healthBar, unpack (EnemyGrid.db.profile.quest_color_neutral))
								unitFrame.quest = true
							else
								EnemyGrid.ForceChangeHealthBarColor (unitFrame.healthBar, unpack (EnemyGrid.db.profile.quest_color_enemy))
								unitFrame.quest = true
							end
						else
							CompactUnitFrame_UpdateHealthColor (unitFrame)
						end
					else
						CompactUnitFrame_UpdateHealthColor (unitFrame)
					end
				end
			end
			
			--seta os eventos
			unitFrame.healthBar:SetScript ("OnUpdate", onTickFunc)
			unitFrame:RegisterUnitEvent ("UNIT_AURA", plateID)
			namePlateOnEvent (unitFrame, "UNIT_AURA")
			checkRange (unitFrame.healthBar)
			EnemyGrid:RAID_TARGET_UPDATE (unitFrame)
			
			unitFrame.iconIndicator:Hide()
			
			if (EnemyGrid.db.profile.cast_enabled) then
				unitFrame.castBar:SetScript ("OnEvent", CastingBarFrame_OnEvent)
				unitFrame.castBar:SetScript ("OnUpdate", CastingBarFrame_OnUpdate)
				unitFrame.castBar:SetScript ("OnShow", CastingBarFrame_OnShow)
				unitFrame.castBar.unit = nil
				CastingBarFrame_SetUnit (unitFrame.castBar, plateID, false, false)
			else
				unitFrame.castBar.unit = nil
			end
			
			if (UnitIsUnit (plateID, "target")) then
				EnemyGrid.SetAsTarget (unitFrame)
			else
				if (unitFrame.IsPlayerTarget) then
					EnemyGrid.RemoveTarget (unitFrame)
				end
			end
			
		elseif (event == "NAME_PLATE_UNIT_REMOVED") then
			--unitFrame.healthBar:SetAlpha (.1)
			if (unitFrame.IsPlayerTarget) then
				EnemyGrid.RemoveTarget (unitFrame)
			end
			unitFrame:UnregisterEvent ("UNIT_AURA")
			clearDebuffsOnPlate (unitFrame)
			
			local castFrame = unitFrame.castBar
			castFrame:SetScript ("OnEvent", nil)
			castFrame:SetScript ("OnUpdate", nil)
			castFrame:SetScript ("OnShow", nil)
			castFrame:Hide()
			
		elseif (event == "ENCOUNTER_START") then
			EnemyGrid.InBossEncounter = true
			EnemyGrid.CanShow (true)
		
		elseif (event == "ENCOUNTER_END") then
			EnemyGrid.InBossEncounter = false
			EnemyGrid.CanShow (true)
			
		end
	end
	
	EnemyGrid.ScreenPanel:SetScript ("OnEvent", EnemyGrid.HandleNameplateEvents)
	
	function EnemyGrid:RAID_TARGET_UPDATE (unitFrame)
		if (not unitFrame or not unitFrame.NamePlateId) then
			for i = 1, EnemyGrid.db.profile.max_targets do
				local unitFrame = EnemyGrid.unitFrameIDsContainer ["nameplate" .. i]
				if (UnitExists ("nameplate" .. i)) then
					local raidTarget = GetRaidTargetIndex (unitFrame.NamePlateId)
					if (raidTarget) then
						unitFrame.raidMarker:SetTexture ("Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_" .. raidTarget)
					else
						unitFrame.raidMarker:SetTexture (nil)
					end
				else
					unitFrame.raidMarker:SetTexture (nil)
				end
			end
		else
			if (UnitExists (unitFrame.NamePlateId)) then
				local raidTarget = GetRaidTargetIndex (unitFrame.NamePlateId)
				if (raidTarget) then
					unitFrame.raidMarker:SetTexture ("Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_" .. raidTarget)
				else
					unitFrame.raidMarker:SetTexture (nil)
				end
			else
				unitFrame.raidMarker:SetTexture (nil)
			end
		end
	end
	
	function EnemyGrid.SetAsTarget (unitFrame)
		unitFrame.IsPlayerTarget = true
		unitFrame.overlayFrame:SetBackdropBorderColor (1, 1, 0, 1)
	end
	function EnemyGrid.RemoveTarget (unitFrame)
		unitFrame.IsPlayerTarge = nil
		unitFrame.overlayFrame:SetBackdropBorderColor (1, 1, 0, 0)
	end
	function EnemyGrid:PLAYER_TARGET_CHANGED()
		for i = 1, EnemyGrid.db.profile.max_targets do
			local unitFrame = EnemyGrid.unitFrameIDsContainer ["nameplate" .. i]
			if (UnitIsUnit ("nameplate" .. i, "target")) then
				--unitFrame.highlightTexture:Show()
				unitFrame.overlayFrame:SetBackdropBorderColor (1, 1, 0, 1)
				unitFrame.IsPlayerTarget = true
			else
				--unitFrame.highlightTexture:Hide()
				unitFrame.overlayFrame:SetBackdropBorderColor (1, 1, 0, 0)
				unitFrame.IsPlayerTarget = nil
			end
		end
	end
	
	function EnemyGrid:PLAYER_REGEN_DISABLED()
		EnemyGrid.CombatTime = GetTime()
		EnemyGrid.RegenIsDisabled = true
		
		--verifica se o painel de op��es esta aberto
		if (EnemyGridOptionsPanelFrame and EnemyGridOptionsPanelFrame:IsShown()) then
			EnemyGrid.ShouldReopenOptions = true
			--EnemyGridOptionsPanelFrame:Hide()
		end
		
		EnemyGrid.CanShow (true)
		EnemyGrid.UpdateFrameMovable (true)
	end
	
	function EnemyGrid:PLAYER_REGEN_ENABLED()
		if (EnemyGrid.CheckZoneAfterCombat) then
			EnemyGrid.CheckZoneAfterCombat = nil
			EnemyGrid:ZONE_CHANGED_NEW_AREA()
		end
		
		EnemyGrid.RegenIsDisabled = nil
		
		--verifica se o painel foi fechado por causa de um combate
		if (EnemyGridOptionsPanelFrame and EnemyGrid.ShouldReopenOptions) then
			EnemyGrid.ShouldReopenOptions = nil
			EnemyGridOptionsPanelFrame:Show()
		end
		
		if (EnemyGrid.ScheduleUpdateKeyBinds) then
			EnemyGrid.UpdateKeyBinds()
		end
		
		EnemyGrid.CanShow()
		EnemyGrid.UpdateFrameMovable()
		
		C_Timer.After (.02, EnemyGrid.ReEvent)
	end
	
	function EnemyGrid:ZONE_CHANGED_NEW_AREA()
		EnemyGrid.CanShow()
	end
	
	function EnemyGrid:ENCOUNTER_START()
		EnemyGrid.InBossEncounter = true
		EnemyGrid.CanShow (true)
	end
	function EnemyGrid:ENCOUNTER_END()
		EnemyGrid.InBossEncounter = false
		EnemyGrid.CanShow (true)
	end
	
	EnemyGrid:RegisterEvent ("RAID_TARGET_UPDATE")
	EnemyGrid:RegisterEvent ("PLAYER_TARGET_CHANGED")
	EnemyGrid:RegisterEvent ("PLAYER_REGEN_DISABLED")
	EnemyGrid:RegisterEvent ("PLAYER_REGEN_ENABLED")
	EnemyGrid:RegisterEvent ("ZONE_CHANGED_NEW_AREA")
	EnemyGrid:RegisterEvent ("PLAYER_SPECIALIZATION_CHANGED")
	EnemyGrid:RegisterEvent ("QUEST_ACCEPTED")
	EnemyGrid:RegisterEvent ("QUEST_ACCEPT_CONFIRM")
	EnemyGrid:RegisterEvent ("QUEST_COMPLETE")
	EnemyGrid:RegisterEvent ("QUEST_POI_UPDATE")
	EnemyGrid:RegisterEvent ("QUEST_QUERY_COMPLETE")
	EnemyGrid:RegisterEvent ("QUEST_DETAIL")
	EnemyGrid:RegisterEvent ("QUEST_FINISHED")
	EnemyGrid:RegisterEvent ("QUEST_GREETING")
	EnemyGrid:RegisterEvent ("QUEST_LOG_UPDATE")
	EnemyGrid:RegisterEvent ("UNIT_QUEST_LOG_CHANGED")
	EnemyGrid:RegisterEvent ("ENCOUNTER_START")
	EnemyGrid:RegisterEvent ("ENCOUNTER_END")
	
	EnemyGrid.UpdateGrid()
	
	EnemyGrid.UpdateTitleTab()
	EnemyGrid.UpdateFrameMovable()
	
	if (InCombatLockdown()) then
		EnemyGrid:PLAYER_REGEN_DISABLED()
	else
		EnemyGrid:PLAYER_REGEN_ENABLED()
	end
	EnemyGrid:ZONE_CHANGED_NEW_AREA()

	EnemyGrid.CanShow()
	EnemyGrid.RefreshAmountOfUnitsShown()
	
	--> ~db
	EnemyGrid.db.RegisterCallback (EnemyGrid, "OnProfileChanged", "RefreshConfig")
	EnemyGrid.db.RegisterCallback (EnemyGrid, "OnProfileCopied", "RefreshConfig")
	EnemyGrid.db.RegisterCallback (EnemyGrid, "OnProfileReset", "RefreshConfig")
	
	--> make sure everything is loading correctly
	C_Timer.After (1, EnemyGrid.UpdateGrid)	
	C_Timer.After (1, EnemyGrid.RAID_TARGET_UPDATE)
	C_Timer.After (1, EnemyGrid.UpdateKeyBinds)
	
	local reload = CreateFrame ("frame")
	reload:RegisterEvent ("PLAYER_ENTERING_WORLD")
	reload:RegisterEvent ("PLAYER_LOGIN")
	reload:SetScript ("OnEvent", function (...)
		EnemyGrid.UpdateGrid()
		EnemyGrid.RAID_TARGET_UPDATE()
		EnemyGrid.UpdateKeyBinds()
	end)	
end

local anchor_functions = {
	function (widget, config)--1
		widget:ClearAllPoints()
		widget:SetPoint ("bottomleft", widget:GetParent(), "topleft", config.x, config.y)
	end,
	function (widget, config)--2
		widget:ClearAllPoints()
		widget:SetPoint ("right", widget:GetParent(), "left", config.x, config.y)
	end,
	function (widget, config)--3
		widget:ClearAllPoints()
		widget:SetPoint ("topleft", widget:GetParent(), "bottomleft", config.x, config.y)
	end,
	function (widget, config)--4
		widget:ClearAllPoints()
		widget:SetPoint ("top", widget:GetParent(), "bottom", config.x, config.y)
	end,
	function (widget, config)--5
		widget:ClearAllPoints()
		widget:SetPoint ("topright", widget:GetParent(), "bottomright", config.x, config.y)
	end,
	function (widget, config)--6
		widget:ClearAllPoints()
		widget:SetPoint ("left", widget:GetParent(), "right", config.x, config.y)
	end,
	function (widget, config)--7
		widget:ClearAllPoints()
		widget:SetPoint ("bottomright", widget:GetParent(), "topright", config.x, config.y)
	end,
	function (widget, config)--8
		widget:ClearAllPoints()
		widget:SetPoint ("bottom", widget:GetParent(), "top", config.x, config.y)
	end,
	function (widget, config)--9
		widget:ClearAllPoints()
		widget:SetPoint ("center", widget:GetParent(), "center", config.x, config.y)
	end,
	function (widget, config)--10
		widget:ClearAllPoints()
		widget:SetPoint ("left", widget:GetParent(), "left", config.x, config.y)
	end,
	function (widget, config)--11
		widget:ClearAllPoints()
		widget:SetPoint ("right", widget:GetParent(), "right", config.x, config.y)
	end,
	function (widget, config)--12
		widget:ClearAllPoints()
		widget:SetPoint ("top", widget:GetParent(), "top", config.x, config.y)
	end,
	function (widget, config)--13
		widget:ClearAllPoints()
		widget:SetPoint ("bottom", widget:GetParent(), "bottom", config.x, config.y)
	end
}

function EnemyGrid.SetAnchor (widget, config)
	anchor_functions [config.side] (widget, config)
end

function EnemyGrid.UpdateKeyBinds()

	if (InCombatLockdown()) then
		EnemyGrid.ScheduleUpdateKeyBinds = true
		return
	end
	--~keybind
	local classLoc, class = UnitClass ("player")
	local bindingList = EnemyGrid.CurrentKeybindSet
	local bindString = "self:ClearBindings();"
	local bindKeyBindTypeFunc = [[local unitFrame = ...;]]
	local bindMacroTextFunc = [[local unitFrame = ...;]]
	local isMouseBinding
	
	for i = 1, #bindingList do
		local bind = bindingList [i]
		local bindType
		
		--bot�o a ser precionado
		if (bind.key:find ("type")) then
			local keyNumber = tonumber (bind.key:match ("%d"))
			bindType = keyNumber
			isMouseBinding = true
		else
			bindType = "EG" .. i
			bindString = bindString .. "self:SetBindingClick (0, '" .. bind.key .. "', self:GetName(), '" .. bindType .. "');"
			bindType = "-EG" .. i
			isMouseBinding = nil
		end
		
		--tipo da keybind
		local shift, alt, ctrl = bind.key:match ("SHIFT"), bind.key:match ("ALT"), bind.key:match ("CTRL")
		local CommandKeys = alt and alt .. "-" or ""
		CommandKeys = ctrl and CommandKeys .. ctrl .. "-" or CommandKeys
		CommandKeys = shift and CommandKeys .. shift .. "-" or CommandKeys
		
		local keyBindType
		if (isMouseBinding) then
			keyBindType = [[unitFrame:SetAttribute ("@COMMANDtype@BINDTYPE", "macro");]]
		else
			keyBindType = [[unitFrame:SetAttribute ("type@BINDTYPE", "macro");]]
		end
		
		keyBindType = keyBindType:gsub ("@BINDTYPE", bindType)
		keyBindType = keyBindType:gsub ("@COMMAND", CommandKeys)
		bindKeyBindTypeFunc = bindKeyBindTypeFunc .. keyBindType
		
		--textos dos macros
		if (bind.action == "_target") then
			local macroTextLine
			if (isMouseBinding) then
				macroTextLine = [[unitFrame:SetAttribute ("@COMMANDmacrotext@BINDTYPE", "/target [@mouseover]");]]
			else
				macroTextLine = [[unitFrame:SetAttribute ("macrotext@BINDTYPE", "/target [@mouseover]");]]
			end
			macroTextLine = macroTextLine:gsub ("@BINDTYPE", bindType)
			macroTextLine = macroTextLine:gsub ("@COMMAND", CommandKeys)
			bindMacroTextFunc = bindMacroTextFunc .. macroTextLine
			
		elseif (bind.action == "_taunt") then
			local spell = tauntList [class]
			if (spell) then
				if (type (spell) == "table") then
					spell = spell [EnemyGrid.CurrentSpec]
				end
				spell = GetSpellInfo (spell)
				if (spell) then
					local macroTextLine
					if (isMouseBinding) then
						macroTextLine = [[unitFrame:SetAttribute ("@COMMANDmacrotext@BINDTYPE", "/cast [@mouseover] @SPELL");]]
					else
						macroTextLine = [[unitFrame:SetAttribute ("macrotext@BINDTYPE", "/cast [@mouseover] @SPELL");]]
					end
					macroTextLine = macroTextLine:gsub ("@BINDTYPE", bindType)
					macroTextLine = macroTextLine:gsub ("@SPELL", spell)
					macroTextLine = macroTextLine:gsub ("@COMMAND", CommandKeys)
					bindMacroTextFunc = bindMacroTextFunc .. macroTextLine
				end
			end
			
		elseif (bind.action == "_interrupt") then
			local spell = interruptList [class]
			if (spell) then
				if (type (spell) == "table") then
					spell = spell [EnemyGrid.CurrentSpec]
				end
				spell = GetSpellInfo (spell)
				if (spell) then
					local macroTextLine
					if (isMouseBinding) then
						macroTextLine = [[unitFrame:SetAttribute ("@COMMANDmacrotext@BINDTYPE", "/cast [@mouseover] @SPELL");]]
					else
						macroTextLine = [[unitFrame:SetAttribute ("macrotext@BINDTYPE", "/cast [@mouseover] @SPELL");]]
					end
					macroTextLine = macroTextLine:gsub ("@BINDTYPE", bindType)
					macroTextLine = macroTextLine:gsub ("@SPELL", spell)
					macroTextLine = macroTextLine:gsub ("@COMMAND", CommandKeys)
					bindMacroTextFunc = bindMacroTextFunc .. macroTextLine
				end
			end
			
		elseif (bind.action == "_dispel") then
			local spell = dispelList [class]
			if (spell) then
				if (type (spell) == "table") then
					spell = spell [EnemyGrid.CurrentSpec]
				end
				spell = GetSpellInfo (spell)
				if (spell) then
					local macroTextLine
					if (isMouseBinding) then
						macroTextLine = [[unitFrame:SetAttribute ("@COMMANDmacrotext@BINDTYPE", "/cast [@mouseover] @SPELL");]]
					else
						macroTextLine = [[unitFrame:SetAttribute ("macrotext@BINDTYPE", "/cast [@mouseover] @SPELL");]]
					end
					macroTextLine = macroTextLine:gsub ("@BINDTYPE", bindType)
					macroTextLine = macroTextLine:gsub ("@SPELL", spell)
					macroTextLine = macroTextLine:gsub ("@COMMAND", CommandKeys)
					bindMacroTextFunc = bindMacroTextFunc .. macroTextLine
				end
			end
			
		elseif (bind.action == "_spell") then
			local macroTextLine
			if (isMouseBinding) then
				macroTextLine = [[unitFrame:SetAttribute ("@COMMANDmacrotext@BINDTYPE", "/cast [@mouseover] @SPELL");]]
			else
				macroTextLine = [[unitFrame:SetAttribute ("macrotext@BINDTYPE", "/cast [@mouseover] @SPELL");]]
			end
			macroTextLine = macroTextLine:gsub ("@BINDTYPE", bindType)
			macroTextLine = macroTextLine:gsub ("@SPELL", bind.actiontext)
			macroTextLine = macroTextLine:gsub ("@COMMAND", CommandKeys)
			bindMacroTextFunc = bindMacroTextFunc .. macroTextLine
			
		elseif (bind.action == "_macro") then
			local macroTextLine
			if (isMouseBinding) then
				macroTextLine = [[unitFrame:SetAttribute ("@COMMANDmacrotext@BINDTYPE", "@MACRO");]]
			else
				macroTextLine = [[unitFrame:SetAttribute ("macrotext@BINDTYPE", "@MACRO");]]
			end
			macroTextLine = macroTextLine:gsub ("@BINDTYPE", bindType)
			macroTextLine = macroTextLine:gsub ("@MACRO", bind.actiontext)
			macroTextLine = macroTextLine:gsub ("@COMMAND", CommandKeys)
			bindMacroTextFunc = bindMacroTextFunc .. macroTextLine
			
		end
	end
	
	--~key

	local bindTypeFuncLoaded = loadstring (bindKeyBindTypeFunc)
	local bindMacroFuncLoaded = loadstring (bindMacroTextFunc)
	if (not bindMacroFuncLoaded or not bindTypeFuncLoaded) then
		return
	end

	--seta as macros em todos os 40 alvos
	for i = 1, 40 do
		local unitFrame = EnemyGrid.unitFrameContainer [i]
		bindTypeFuncLoaded (unitFrame)
		bindMacroFuncLoaded (unitFrame)
		unitFrame:SetAttribute ("_onenter", bindString)
	end

end

function EnemyGrid.UpdateGrid() --~update
	
	local horizontalLines = math.ceil (40 / EnemyGrid.db.profile.vertical_rows)
	local firstFrame, lastFrame, jumpToNext = nil, nil, true
	local gapX, gapY = EnemyGrid.db.profile.horizontal_gap_size, EnemyGrid.db.profile.vertical_gap_size
	local nextBreak = EnemyGrid.db.profile.vertical_rows
	
	local barWidth, barHeight = EnemyGrid.db.profile.bar_width, EnemyGrid.db.profile.bar_height
	local healthTexture = LibSharedMedia:Fetch ("statusbar", EnemyGrid.db.profile.bar_texture)
	local backgroundTexture = LibSharedMedia:Fetch ("statusbar", EnemyGrid.db.profile.bar_texturebackground)
	local startY = -20 --EnemyGrid.db.profile.show_tab and -20 or -3
	
	local castTexture = LibSharedMedia:Fetch ("statusbar", EnemyGrid.db.profile.cast_statusbar_texture)
	local castBGTexture = LibSharedMedia:Fetch ("statusbar", EnemyGrid.db.profile.cast_statusbar_bgtexture)
	
	local IsSafe = not InCombatLockdown()
	
	for i = 1, 40 do
		local unitFrame = EnemyGrid.unitFrameContainer [i]
		
		--texturas
			unitFrame.healthTexture:SetTexture (healthTexture)
			unitFrame.backgroundTexture:SetTexture (backgroundTexture)
		
			unitFrame:SetBackdropColor (unpack (EnemyGrid.db.profile.frame_backdropcolor))
			unitFrame:SetBackdropBorderColor (unpack (EnemyGrid.db.profile.frame_backdropbordercolor))
			
		--debuff anchor
			EnemyGrid.SetAnchor (unitFrame.debuffAnchor, EnemyGrid.db.profile.debuff_anchor)
			
		--configura o texto
			EnemyGrid:SetFontColor (unitFrame.playerName, EnemyGrid.db.profile.name_text_color)
			EnemyGrid:SetFontFace (unitFrame.playerName, EnemyGrid.db.profile.name_text_font)
			EnemyGrid:SetFontSize (unitFrame.playerName, EnemyGrid.db.profile.name_text_size)
			EnemyGrid:SetFontOutline  (unitFrame.playerName, EnemyGrid.db.profile.name_text_shadow)
			EnemyGrid.SetAnchor (unitFrame.playerName, EnemyGrid.db.profile.name_text_anchor)

			if (EnemyGrid.db.profile.percent_text_enabled) then
				unitFrame.healthPercent:Show()
				EnemyGrid:SetFontColor (unitFrame.healthPercent, EnemyGrid.db.profile.percent_text_color)
				EnemyGrid:SetFontFace (unitFrame.healthPercent, EnemyGrid.db.profile.percent_text_font)
				EnemyGrid:SetFontSize (unitFrame.healthPercent, EnemyGrid.db.profile.percent_text_size)
				EnemyGrid:SetFontOutline  (unitFrame.healthPercent, EnemyGrid.db.profile.percent_text_shadow)
				EnemyGrid.SetAnchor (unitFrame.healthPercent, EnemyGrid.db.profile.percent_text_anchor)
			else
				unitFrame.healthPercent:Hide()
			end
			
			if (IsSafe) then
				--alinha vertical e horizontal
				unitFrame:ClearAllPoints()

				if (jumpToNext) then
					if (not firstFrame) then --� o primeiro frame a ser anexado 
						if (EnemyGrid.db.profile.grow_direction == 1) then
							unitFrame:SetPoint ("topleft", EnemyGrid.ScreenPanel, "topleft", 0, startY)
						else
							unitFrame:SetPoint ("bottomleft", EnemyGrid.ScreenPanel, "bottomleft", 0, -startY)
						end
					else --anexa ao frame que foi cabe�alho na ultima coluna
						unitFrame:SetPoint ("topleft", firstFrame, "topright", gapX, 0)
					end
					firstFrame = unitFrame
					jumpToNext = false
				else
					if (EnemyGrid.db.profile.grow_direction == 1) then --grow down
						unitFrame:SetPoint ("topleft", lastFrame, "bottomleft", 0, -gapY)
					else --grow up
						unitFrame:SetPoint ("bottomleft", lastFrame, "topleft", 0, gapY)
					end
				end
				if (i == nextBreak) then
					jumpToNext = true
					nextBreak = nextBreak + EnemyGrid.db.profile.vertical_rows
				end

				--atualiza o frame em geral
				lastFrame = unitFrame
				unitFrame:SetSize (barWidth, barHeight)
			end

			if (EnemyGrid.db.profile.bar_direction == 1) then
				unitFrame.healthBar:SetOrientation ("HORIZONTAL")
			else
				unitFrame.healthBar:SetOrientation ("VERTICAL")
			end
			
		--atualiza o raid marker
			unitFrame.raidMarker:SetSize (barHeight, barHeight)
			unitFrame.raidMarker:SetAlpha (EnemyGrid.db.profile.raidmarker_alpha)
			EnemyGrid.SetAnchor (unitFrame.raidMarker, EnemyGrid.db.profile.raidmarker_anchor)
		--atualiza o icone de identifica��o
			unitFrame.iconIndicator:SetSize (barHeight*0.8, barHeight*0.8)
			unitFrame.iconIndicator:SetAlpha (EnemyGrid.db.profile.iconIndicator_alpha)
			EnemyGrid.SetAnchor (unitFrame.iconIndicator, EnemyGrid.db.profile.iconIndicator_anchor)
			
		--atualiza o pin the target de health
			unitFrame.healthCutOff:SetSize (barHeight*0.5, barHeight*0.90)
			
		--atualiza a castbar
			local castFrame = unitFrame.castBar
			local spellnameString= castFrame.Text
			
			castFrame.Texture:SetTexture (castTexture)
			castFrame.Texture:SetVertexColor (unpack (EnemyGrid.db.profile.cast_statusbar_color))
			castFrame.background:SetTexture (castBGTexture)
			castFrame.background:SetVertexColor (unpack (EnemyGrid.db.profile.cast_statusbar_bgcolor))
			
			--castFrame.Flash:SetTexture (castTexture)
			
			--castFrame.Icon:SetTexCoord (0.078125, 0.921875, 0.078125, 0.921875)
			castFrame.Icon:SetSize (EnemyGrid.db.profile.cast_statusbar_height-2, EnemyGrid.db.profile.cast_statusbar_height-2)
			castFrame.Spark:SetHeight (EnemyGrid.db.profile.cast_statusbar_height+10)
			
			--atualiza o texto da cast bar
			DF:SetFontColor (spellnameString, EnemyGrid.db.profile.spellname_text_color)
			DF:SetFontSize (spellnameString, EnemyGrid.db.profile.spellname_text_size)
			DF:SetFontOutline (spellnameString, EnemyGrid.db.profile.spellname_text_shadow)
			DF:SetFontFace (spellnameString, EnemyGrid.db.profile.spellname_text_font)
			EnemyGrid.SetAnchor (spellnameString, EnemyGrid.db.profile.spellname_text_anchor)
			
			castFrame:SetSize (EnemyGrid.db.profile.cast_statusbar_width, EnemyGrid.db.profile.cast_statusbar_height)
			EnemyGrid.SetAnchor (castFrame, EnemyGrid.db.profile.cast_statusbar_anchor)
	end
	
	if (IsSafe) then
		--atualiza a strata
		EnemyGrid.ScreenPanel:SetFrameStrata (EnemyGrid.db.profile.frame_strata)
		
		--calcula o tamanho do frame
		--EnemyGrid.ScreenPanel:SetSize (3 + (barWidth+gapX) * horizontalLines, ((barHeight+gapY) * EnemyGrid.db.profile.vertical_rows) + (-startY))
		EnemyGrid.ScreenPanel:SetSize (80, 18)
		
	end
	
	if (EnemyGrid.db.profile.show_title_text) then
		EnemyGrid.ScreenPanel.titleTabText:Show()
	else
		EnemyGrid.ScreenPanel.titleTabText:Hide()
	end

end

function EnemyGrid.UpdateTitleTab()

	EnemyGrid:SetFontFace (EnemyGrid.ScreenPanel.titleTabText, EnemyGrid.db.profile.name_text_font)

	if true then return end --disabled
	if (EnemyGrid.db.profile.show_tab) then
		EnemyGrid.ScreenPanel.titleTab:Show()
		EnemyGrid.ScreenPanel.titleTabText:Show()
	else
		EnemyGrid.ScreenPanel.titleTab:Hide()
		EnemyGrid.ScreenPanel.titleTabText:Hide()
	end
end

function EnemyGrid.UpdateFrameMovable (forceLocked)
	--force locked durante o combate
	if (forceLocked) then
		EnemyGrid.ScreenPanel:RegisterForDrag (nil)
		EnemyGrid.ScreenPanel:EnableMouse (false)
	else
		EnemyGrid.ScreenPanel:RegisterForDrag (not EnemyGrid.db.profile.frame_locked and "LeftButton" or nil)

		if (EnemyGrid.db.profile.frame_locked) then
			EnemyGrid.tab:SetColorTexture (.7, .7, .7, 0)
			EnemyGrid.ScreenPanel:EnableMouse (false)
		else
			EnemyGrid.tab:SetColorTexture (.7, .7, .7, .1)
			EnemyGrid.ScreenPanel:EnableMouse (true)
		end
	end
end

function EnemyGrid.CreateAggroFlashFrame (unitFrame)

	local f_anim = CreateFrame ("frame", nil, unitFrame)
	f_anim:SetFrameLevel (27)
	f_anim:SetPoint ("topleft", unitFrame, "topleft")
	f_anim:SetPoint ("bottomright", unitFrame, "bottomright")
	
	local t = f_anim:CreateTexture (nil, "artwork")
	t:SetColorTexture (1, 1, 1, 1)
	t:SetAllPoints()
	t:SetBlendMode ("ADD")
	local s = f_anim:CreateFontString (nil, "overlay", "GameFontNormal")
	s:SetText ("-AGGRO-")
	s:SetTextColor (.70, .70, .70)
	s:SetPoint ("center", t, "center")
	
	local animation = t:CreateAnimationGroup()
	local anim1 = animation:CreateAnimation ("Alpha")
	local anim2 = animation:CreateAnimation ("Alpha")
	anim1:SetOrder (1)
	anim1:SetFromAlpha (0)
	anim1:SetToAlpha (1)
	anim1:SetDuration (0.2)
	anim2:SetOrder (2)
	anim2:SetFromAlpha (1)
	anim2:SetToAlpha (0)
	anim2:SetDuration (0.2)
	
	animation:SetScript ("OnFinished", function (self)
		f_anim:Hide()
	end)
	animation:SetScript ("OnPlay", function (self)
		f_anim:Show()
	end)

	local do_flash_anim = function()
		if (EnemyGrid.CombatTime+5 > GetTime()) then
			return
		end
		f_anim:Show()
		animation:Play()
	end
	
	f_anim:Hide()
	unitFrame.PlayAggroFlash = do_flash_anim
end

--------------------

local GameTooltipScanQuest = CreateFrame ("GameTooltip", "EnemyGridScanQuestTooltip", nil, "GameTooltipTemplate")
local ScanQuestTextCache = {}
for i = 1, 8 do
	ScanQuestTextCache [i] = _G ["EnemyGridScanQuestTooltipTextLeft" .. i]
end

function EnemyGrid.IsQuestObjective (unitFrame)
	if (not unitFrame.guid) then
		return
	end
	GameTooltipScanQuest:SetOwner (WorldFrame, "ANCHOR_NONE")
	GameTooltipScanQuest:SetHyperlink ("unit:" .. unitFrame.guid)
	
	for i = 1, 8 do
		local text = ScanQuestTextCache [i]:GetText()
		if (EnemyGrid.QuestCache [text]) then
			--este npc percente a uma quest
			if (not IsInGroup() and i < 8) then
				--verifica se j� fechou a quantidade necess�ria pra esse npc
				local nextLineText = ScanQuestTextCache [i+1]:GetText()
				if (nextLineText) then
					local p1, p2 = nextLineText:match ("(%d%d)/(%d%d)") --^ - 
					if (not p1) then
						p1, p2 = nextLineText:match ("(%d)/(%d%d)")
						if (not p1) then
							p1, p2 = nextLineText:match ("(%d)/(%d)")
						end
					end
					if (p1 and p2 and p1 == p2) then
						return
					end
				end
			end

			unitFrame.quest = true
			return true
		end
	end
end

local update_quest_cache = function()
	wipe (EnemyGrid.QuestCache)
	local numEntries, numQuests = GetNumQuestLogEntries()
	for questId = 1, numEntries do
		local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questId, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle (questId)
		if (type (questId) == "number" and questId > 0) then -- and not isComplete
			EnemyGrid.QuestCache [title] = true
		end
	end
	
	local mapId = GetCurrentMapAreaID()
	local worldQuests = C_TaskQuest.GetQuestsForPlayerByMapID (mapId)
	if (type (worldQuests) == "table") then
		for i, questTable in ipairs (worldQuests) do
			local x, y, floor, numObjectives, questId, inProgress = questTable.x, questTable.y, questTable.floor, questTable.numObjectives, questTable.questId, questTable.inProgress
			if (type (questId) == "number" and questId > 0) then
				local questName = C_TaskQuest.GetQuestInfoByQuestID (questId)
				if (questName) then
					EnemyGrid.QuestCache [questName] = true
				end
			end
		end
	end
	
	EnemyGrid.ReEvent()
end

function EnemyGrid.QuestLogUpdated()
	if (EnemyGrid.UpdateQuestCacheThrottle and not EnemyGrid.UpdateQuestCacheThrottle._cancelled) then
		EnemyGrid.UpdateQuestCacheThrottle:Cancel()
	end
	EnemyGrid.UpdateQuestCacheThrottle = C_Timer.NewTimer (2, update_quest_cache)
end

function EnemyGrid:QUEST_ACCEPTED()
	EnemyGrid.QuestLogUpdated()
end
function EnemyGrid:QUEST_ACCEPT_CONFIRM()
	EnemyGrid.QuestLogUpdated()
end
function EnemyGrid:QUEST_COMPLETE()
	EnemyGrid.QuestLogUpdated()
end
function EnemyGrid:QUEST_POI_UPDATE()
	EnemyGrid.QuestLogUpdated()
end
function EnemyGrid:QUEST_QUERY_COMPLETE()
	EnemyGrid.QuestLogUpdated()
end
function EnemyGrid:QUEST_DETAIL()
	EnemyGrid.QuestLogUpdated()
end
function EnemyGrid:QUEST_FINISHED()
	EnemyGrid.QuestLogUpdated()
end
function EnemyGrid:QUEST_GREETING()
	EnemyGrid.QuestLogUpdated()
end
function EnemyGrid:QUEST_LOG_UPDATE()
	EnemyGrid.QuestLogUpdated()
end
function EnemyGrid:UNIT_QUEST_LOG_CHANGED()
	EnemyGrid.QuestLogUpdated()
end

--------------------

SLASH_ENEMYGRID1 = "/enemygrid"


function SlashCmdList.ENEMYGRID (msg, editbox)
	
	if (msg == "resetpos") then
		if (not InCombatLockdown()) then
			EnemyGrid.ScreenPanel:ClearAllPoints()
			EnemyGrid.ScreenPanel:SetPoint ("center", UIParent, "center")
			LibWindow.SavePosition (EnemyGrid.ScreenPanel)
			LibWindow.RestorePosition (EnemyGrid.ScreenPanel)
			return
		else
			EnemyGrid:Msg ("You are in combat, cannot reset the position.")
			return
		end
	end

	EnemyGrid.OpenOptionsPanel()
	
	
	
end

local ignoredKeys = {
	["LSHIFT"] = true,
	["RSHIFT"] = true,
	["LCTRL"] = true,
	["RCTRL"] = true,
	["LALT"] = true,
	["RALT"] = true,
	["UNKNOWN"] = true,
}
local mouseKeys = {
	["LeftButton"] = "type1",
	["RightButton"] = "type2",
	["MiddleButton"] = "type3",
	["Button4"] = "type4",
	["Button5"] = "type5",
	["Button6"] = "type6",
	["Button7"] = "type7",
	["Button8"] = "type8",
	["Button9"] = "type9",
	["Button10"] = "type10",
	["Button11"] = "type11",
	["Button12"] = "type12",
	["Button13"] = "type13",
	["Button14"] = "type14",
	["Button15"] = "type15",
	["Button16"] = "type16",
}
local keysToMouse = {
	["type1"] = "LeftButton",
	["type2"] = "RightButton",
	["type3"] = "MiddleButton",
	["type4"] = "Button4",
	["type5"] = "Button5",
	["type6"] = "Button6",
	["type7"] = "Button7",
	["type8"] = "Button8",
	["type9"] = "Button9",
	["type10"] = "Button10",
	["type11"] = "Button11",
	["type12"] = "Button12",
	["type13"] = "Button13",
	["type14"] = "Button14",
	["type15"] = "Button15",
	["type16"] = "Button16",
}

-- ~options
function EnemyGrid.OpenOptionsPanel()

	if (EnemyGridOptionsPanelFrame) then
		return EnemyGridOptionsPanelFrame:Show()
	end

	--pega os templates dos os widgets
	local options_text_template = DF:GetTemplate ("font", "OPTIONS_FONT_TEMPLATE")
	local options_dropdown_template = DF:GetTemplate ("dropdown", "OPTIONS_DROPDOWN_TEMPLATE")
	local options_switch_template = DF:GetTemplate ("switch", "OPTIONS_CHECKBOX_TEMPLATE")
	local options_slider_template = DF:GetTemplate ("slider", "OPTIONS_SLIDER_TEMPLATE")
	local options_button_template = DF:GetTemplate ("button", "OPTIONS_BUTTON_TEMPLATE")
	
	local mainStartX, mainStartY, mainHeightSize = 10, -100, 600
	
	local f = DF:CreateSimplePanel (UIParent, 1100, 590, "Enemy Grid Options", "EnemyGridOptionsPanelFrame")
	f:SetPoint ("center", UIParent, "center", 0, 0)

	local frame_options = {
		y_offset = 0,
		button_width = 125,
		button_height = 20,
		button_x = 230,
		button_y = -12,
		button_text_size = 10,
	}
	
	-- mainFrame � um frame vazio para sustentrar todos os demais frames, este frame sempre ser� mostrado
	local mainFrame = DF:CreateTabContainer (f, "Enemy Grid", "EnemyGridOptionsPanelContainer", {
		{name = "FrontPage", title = L["S_MENU_MAINPANEL"]},
		{name = "BarsConfigPage", title = L["S_MENU_BARSCONFIG"]},
		{name = "AurasPage", title = L["S_MENU_DEBUFFCONFIG"]},
		{name = "KeybindsPage", title = L["S_MENU_KEYBINDS"]},
		{name = "ProfilePage", title = L["S_PROFILES"]},
	}, 
	frame_options)

	local frontPageFrame = mainFrame.AllFrames [1]
	local healAndCastBarsFrame = mainFrame.AllFrames [2]
	local auraFrame = mainFrame.AllFrames [3]
	local keybindFrame = mainFrame.AllFrames [4]
	local profileFrame = mainFrame.AllFrames [5]

	--> on profile change
	function f.RefreshOptionsFrame()
		for _, frame in ipairs (mainFrame.AllFrames) do
			if (frame.RefreshOptions) then
				frame:RefreshOptions()
			end
		end
		auraFrame.auraConfigPanel:OnProfileChanged (EnemyGrid.db.profile)
	end
	
	--mostra o painel de profiles no menu de interface
	profileFrame:SetScript ("OnShow", function()
		EnemyGrid:OpenInterfaceProfile()
		f:Hide()
		C_Timer.After (.5, function()
			mainFrame:SetIndex (1)
			mainFrame:SelectIndex (_, 1)
		end)
	end)
	
	local text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")

	--
	local reopenWizardButton = DF:CreateButton (mainFrame, EnemyGrid.SelectLayoutWizard, 120, 20, L["S_PRESETWIZARD"], 4, nil, nil, nil, nil, nil, options_dropdown_templat)
	reopenWizardButton:SetPoint ("topright", f, "topright", -16, -32)
	reopenWizardButton.tooltip = L["S_PRESETWIZARD_DESC"]
	reopenWizardButton:SetFrameLevel (DF.FRAMELEVEL_OVERLAY)

	local nameplateDistance = DF:CreateSlider (mainFrame, 140, 20, 1, 100, 1, tonumber (GetCVar ("nameplateMaxDistance")), false, "nameplateDistance", nil, nil, options_slider_template)
	nameplateDistance.tooltip = L["S_NAMEPLATE_DISTANCE_DESC"]
	nameplateDistance:SetFrameLevel (DF.FRAMELEVEL_OVERLAY)
	nameplateDistance.OnValueChanged = function (_, _, value)
		if (not InCombatLockdown()) then
			SetCVar ("nameplateMaxDistance", value)
		else
			EnemyGrid:Msg (L["S_NAMEPLATE_DISTANCE_NOCOMBAT"])
		end
	end
	local nameplateDistanceLabel = DF:CreateLabel (nameplateDistance, L["S_NAMEPLATE_DISTANCE"])
	nameplateDistanceLabel:SetPoint ("top", reopenWizardButton, "bottom", 0, -6)
	nameplateDistance:SetPoint ("top", nameplateDistanceLabel, "bottom", 0, -2)
	
	--
	local onStrataSelect = function (_, _, strata)
		EnemyGrid.db.profile.frame_strata = strata
		EnemyGrid.UpdateGrid()
	end
	local strataTable = {
		{value = "BACKGROUND", label = "Background", onclick = onStrataSelect, icon = [[Interface\Buttons\UI-MicroStream-Green]], iconcolor = {0, .5, 0, .8}, texcoord = nil}, --Interface\Buttons\UI-MicroStream-Green UI-MicroStream-Red UI-MicroStream-Yellow
		{value = "LOW", label = "Low", onclick = onStrataSelect, icon = [[Interface\Buttons\UI-MicroStream-Green]] , texcoord = nil}, --Interface\Buttons\UI-MicroStream-Green UI-MicroStream-Red UI-MicroStream-Yellow
		{value = "MEDIUM", label = "Medium", onclick = onStrataSelect, icon = [[Interface\Buttons\UI-MicroStream-Yellow]] , texcoord = nil}, --Interface\Buttons\UI-MicroStream-Green UI-MicroStream-Red UI-MicroStream-Yellow
		{value = "HIGH", label = "High", onclick = onStrataSelect, icon = [[Interface\Buttons\UI-MicroStream-Yellow]] , iconcolor = {1, .7, 0, 1}, texcoord = nil}, --Interface\Buttons\UI-MicroStream-Green UI-MicroStream-Red UI-MicroStream-Yellow
		{value = "DIALOG", label = "Dialog", onclick = onStrataSelect, icon = [[Interface\Buttons\UI-MicroStream-Red]] , iconcolor = {1, 0, 0, 1},  texcoord = nil}, --Interface\Buttons\UI-MicroStream-Green UI-MicroStream-Red UI-MicroStream-Yellow
	}
	local buildStrataMenu = function() return strataTable end
	--
	local onGrowDirectionSelect = function (_, _, value)
		EnemyGrid.db.profile.grow_direction = value
		C_Timer.After (1, EnemyGrid.UpdateGrid)
	end
	local growDirectionTable = {
		{value = 1, label = L["S_GROWDIRECTION_TOP_BOTTOM"], onclick = onGrowDirectionSelect},
		{value = 2, label = L["S_GROWDIRECTION_BOTTOM_TOP"], onclick = onGrowDirectionSelect},
	}
	local buildGrowDirectionMenu = function()
		return growDirectionTable
	end
	--
	local build_texture_options = function (key)
		local result = {}
		local textures = LibSharedMedia:HashTable ("statusbar")
		for name, texturePath in pairs (textures) do 
			result [#result+1] = {value = name, label = name, statusbar = texturePath, onclick = function() EnemyGrid.db.profile[key] = name; EnemyGrid.UpdateGrid() end}
		end
		table.sort (result, function (t1, t2) return t1.label < t2.label end)
		return result
	end
	--
	local on_select_castbar_font = function (_, _, value)
		EnemyGrid.db.profile.spellname_text_font = value
		EnemyGrid.UpdateGrid()
	end
	local on_select_healthbar_font = function (_, _, value)
		EnemyGrid.db.profile.name_text_font = value
		EnemyGrid.UpdateGrid()
	end
	local on_select_healthtext_font = function (_, _, value)
		EnemyGrid.db.profile.percent_text_font = value
		EnemyGrid.UpdateGrid()
	end
	
	--
	local anchor_names = {"Top Left", "Left", "Bottom Left", "Bottom", "Bottom Right", "Right", "Top Right", "Top", "Center", "Inner Left", "Inner Right", "Inner Top", "Inner Bottom"}
	local build_anchor_side_table = function (member)
		local t = {}
		for i = 1, 13 do
			tinsert (t, {
				label = anchor_names[i],
				value = i,
				onclick = function (_, _, value)
					EnemyGrid.db.profile [member].side = value
					EnemyGrid.UpdateGrid()
					EnemyGrid.ReEvent()
				end
			})
		end
		return t
	end
	--
	
	local options_table = {
	
		--only show when
		{type = "label", get = function() return L["S_ONLYSHOWWHEN"] end, text_template = text_template},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.only_incombat end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.only_incombat = value
				EnemyGrid.CanShow()
			end,
			name = L["S_INCOMBAT"],
			desc = L["S_INCOMBAT_DESC"],
			nocombat = true,
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.only_instance end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.only_instance = value
				EnemyGrid.CanShow()
			end,
			name = L["S_ININSTANCE"],
			desc = L["S_ININSTANCE_DESC"],
			nocombat = true,
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.only_inboss end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.only_inboss = value
				EnemyGrid.CanShow()
			end,
			name = L["S_INBOSS"],
			desc = L["S_INBOSS_DESC"],
			nocombat = true,
		},
		{type = "blank"},
		
		--layout
		{type = "label", get = function() return L["S_LAYOUT"] end, text_template = text_template},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.max_targets end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.max_targets = value
				EnemyGrid.RefreshAmountOfUnitsShown()
			end,
			min = 1,
			max = 40,
			step = 1,
			name = L["S_MAXTARGETS"],
			desc = L["S_MAXTARGETS_DESC"],
			nocombat = true,
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.vertical_rows end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.vertical_rows = value
				EnemyGrid.UpdateGrid()
			end,
			min = 1,
			max = 40,
			step = 1,
			name = L["S_ROWS"],
			desc = L["S_ROWS_DESC"],
			nocombat = true,
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.bar_width end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.bar_width = value
				EnemyGrid.UpdateGrid()
			end,
			min = 30,
			max = 180,
			step = 1,
			name = L["S_WIDTH"],
			desc = L["S_WIDTH"],
			nocombat = true,
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.bar_height end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.bar_height = value
				EnemyGrid.UpdateGrid()
			end,
			min = 8,
			max = 100,
			step = 1,
			name = L["S_HEIGHT"],
			desc = L["S_HEIGHT"],
			nocombat = true,
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.grow_direction end,
			values = function() return buildGrowDirectionMenu() end,
			name = L["S_GROWDIRECTION"],
			desc = L["S_GROWDIRECTION"],
			nocombat = true,
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.vertical_gap_size end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.vertical_gap_size = value
				EnemyGrid.UpdateGrid()
			end,
			min = 0,
			max = 40,
			step = 1,
			name = L["S_PADDING_VERTICAL"],
			desc = L["S_PADDING_VERTICAL_DESC"],
			nocombat = true,
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.horizontal_gap_size end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.horizontal_gap_size = value
				EnemyGrid.UpdateGrid()
			end,
			min = 0,
			max = 40,
			step = 1,
			name = L["S_PADDING_HORIZONTAL"],
			desc = L["S_PADDING_HORIZONTAL_DESC"],
			nocombat = true,
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.frame_strata end,
			values = function() return buildStrataMenu() end,
			name = L["S_FRAMESTRATA"],
			desc = L["S_FRAMESTRATA_DESC"],
			nocombat = true,
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.frame_locked end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.frame_locked = value
				EnemyGrid.UpdateFrameMovable()
			end,
			name = L["S_LOCKED"],
			desc = L["S_LOCKED_DESC"],
			nocombat = true,
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.show_title_text end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.show_title_text = value
				EnemyGrid.UpdateFrameMovable()
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_SHOWTITLE"],
			desc = L["S_SHOWTITLE"],
			nocombat = true,
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.frame_range_alpha end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.frame_range_alpha = value
				--o range � calculado a cada tick ent�o n�o precisa chamar atualiza��o
			end,
			min = 0,
			max = 1,
			step = 0.1,
			usedecimals = true,
			name = L["S_RANGEALPHA"],
			desc = L["S_RANGEALPHA_DESC"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.frame_backdropcolor
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.frame_backdropcolor
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_BACKGROUNDCOLOR"],
			desc = L["S_BACKGROUNDCOLOR"],
			--nocombat = true,
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.frame_backdropbordercolor
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.frame_backdropbordercolor
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_BORDERCOLOR"],
			desc = L["S_BORDERCOLOR"],
			--nocombat = true,
		},
		--[[
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.show_tab end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.show_tab = value
				EnemyGrid.UpdateTitleTab()
			end,
			name = L["S_SHOWTAB"],
			desc = L["S_SHOWTAB_DESC"],
		},
		--]]
		

		{type = "breakline"},
		
		--color by aggro
		{type = "label", get = function() return L["S_AGGROCOLORS"] end, text_template = text_template},
		
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.tank.colors.aggro
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.tank.colors.aggro
				color[1], color[2], color[3], color[4] = r, g, b, a
			end,
			name = L["S_AGGROCOLORS_TANK_AGGRO"],
			desc = L["S_AGGROCOLORS_TANK_AGGRO_DESC"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.tank.colors.noaggro
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.tank.colors.noaggro
				color[1], color[2], color[3], color[4] = r, g, b, a
			end,
			name = L["S_AGGROCOLORS_TANK_NOAGGRO"],
			desc = L["S_AGGROCOLORS_TANK_NOAGGRO_DESC"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.tank.colors.pulling
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.tank.colors.pulling
				color[1], color[2], color[3], color[4] = r, g, b, a
			end,
			name = L["S_AGGROCOLORS_TANK_HIGHAGGRO"],
			desc = L["S_AGGROCOLORS_TANK_HIGHAGGRO_DESC"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.tank.colors.nocombat
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.tank.colors.nocombat
				color[1], color[2], color[3], color[4] = r, g, b, a
			end,
			name = L["S_AGGROCOLORS_TANK_NOCOMBAT"],
			desc = L["S_AGGROCOLORS_TANK_NOCOMBAT_DESC"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.dps.colors.aggro
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.dps.colors.aggro
				color[1], color[2], color[3], color[4] = r, g, b, a
			end,
			name = L["S_AGGROCOLORS_DPS_AGGRO"],
			desc = L["S_AGGROCOLORS_DPS_AGGRO_DESC"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.dps.colors.noaggro
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.dps.colors.noaggro
				color[1], color[2], color[3], color[4] = r, g, b, a
			end,
			name = L["S_AGGROCOLORS_DPS_NOAGGRO"],
			desc = L["S_AGGROCOLORS_DPS_NOAGGRO_DESC"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.dps.colors.pulling
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.dps.colors.pulling
				color[1], color[2], color[3], color[4] = r, g, b, a
			end,
			name = L["S_AGGROCOLORS_DPS_HIGHAGGRO"],
			desc = L["S_AGGROCOLORS_DPS_HIGHAGGRO_DESC"],
		},
		
		--npc color
		{type = "blank"},
		{type = "label", get = function() return L["S_NPCCOLOR"] end, text_template = text_template},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.npc_enemy_color
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.npc_enemy_color
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.ReEvent()
			end,
			name = L["S_ENEMY"],
			desc = L["S_ENEMY"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.npc_neutral_color
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.npc_neutral_color
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.ReEvent()
			end,
			name = L["S_NEUTRAL"],
			desc = L["S_NEUTRAL"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.npc_friendly_color
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.npc_friendly_color
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.ReEvent()
			end,
			name = L["S_FRIENDLY"],
			desc = L["S_FRIENDLY"],
		},
		
		--npc color
		{type = "blank"},
		{type = "label", get = function() return L["S_QUESTCOLOR"] end, text_template = text_template},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.quest_enabled end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.quest_enabled = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			name = L["S_ENABLED"],
			desc = L["S_ENABLED"],
		},
		
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.quest_color_enemy
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.quest_color_enemy
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.ReEvent()
			end,
			name = L["S_ENEMY"],
			desc = L["S_ENEMY"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.quest_color_neutral
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.quest_color_neutral
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.ReEvent()
			end,
			name = L["S_NEUTRAL"],
			desc = L["S_NEUTRAL"],
		},
		
		{type = "breakline"},
		
		--indicators
		{type = "label", get = function() return L["S_INDICATORS"] end, text_template = text_template},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.iconIndicator_anchor.side end,
			values = function() return build_anchor_side_table ("iconIndicator_anchor") end,
			name = L["S_ANCHOR"],
			desc = L["S_ANCHOR"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.iconIndicator_anchor.x end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.iconIndicator_anchor.x = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_XOFFSET"],
			desc = L["S_XOFFSET"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.iconIndicator_anchor.y end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.iconIndicator_anchor.y = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_YOFFSET"],
			desc = L["S_YOFFSET"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.iconIndicator_alpha end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.iconIndicator_alpha = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = 0,
			max = 1,
			step = 0.1,
			usedecimals = true,
			name = L["S_ALPHA"],
			desc = L["S_ALPHA"],
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.iconIndicator_show_faction end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.iconIndicator_show_faction = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			name = L["S_FACTION"],
			desc = L["S_FACTION"],
		},

		{type = "blank"},
		
		--raid markers
		{type = "label", get = function() return L["S_RAIDMARKS"] end, text_template = text_template},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.raidmarker_anchor.side end,
			values = function() return build_anchor_side_table ("raidmarker_anchor") end,
			name = L["S_ANCHOR"],
			desc = L["S_ANCHOR"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.raidmarker_anchor.x end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.raidmarker_anchor.x = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_XOFFSET"],
			desc = L["S_XOFFSET"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.raidmarker_anchor.y end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.raidmarker_anchor.y = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_YOFFSET"],
			desc = L["S_YOFFSET"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.raidmarker_alpha end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.raidmarker_alpha = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = 0,
			max = 1,
			step = 0.1,
			usedecimals = true,
			name = L["S_ALPHA"],
			desc = L["S_ALPHA"],
		},		
	}
	
	tinsert (options_table, {type = "breakline"})
	tinsert (options_table, {type = "label", get = function() return L["S_SPECBAN"] end, text_template = text_template})
	
	local playerSpecs = defaultSpecKeybindList [select (2, UnitClass ("player"))]
	local i = 1
	for specID, _ in pairs (playerSpecs) do
		local spec_id, spec_name, spec_description, spec_icon, spec_background, spec_role, spec_class = GetSpecializationInfoByID (specID)
		
		tinsert (options_table, {
			type = "toggle",
			get = function() return EnemyGridDBChr.specEnabled [specID] end,
			set = function (self, fixedparam, value) 
				EnemyGridDBChr.specEnabled [specID] = value
				EnemyGrid.CanShow()
			end,
			name = "|T" .. spec_icon .. ":16:16|t " .. spec_name,
			desc = L["S_SPECBAN_TOOLTIP"],
			nocombat = true,
		})
		i = i + 1
	end

	tinsert (options_table, {type = "blank"})
	tinsert (options_table, {type = "label", get = function() return L["S_RANGECHECK"] end, text_template = text_template})
	
	local spells = {}
	local offset
	for i = 2, GetNumSpellTabs() do
		local name, texture, offset, numEntries, isGuild, offspecID = GetSpellTabInfo (i)
		local tabEnd = offset + numEntries
		offset = offset + 1
		
		for j = offset, tabEnd - 1 do
			local spellType, spellID = GetSpellBookItemInfo (j, "player")
			if (spellType == "SPELL") then
				tinsert (spells, spellID)
			end
		end
	end
	
	local playerSpecs = defaultSpecKeybindList [select (2, UnitClass ("player"))]
	local i = 1
	for specID, _ in pairs (playerSpecs) do
		local spec_id, spec_name, spec_description, spec_icon, spec_background, spec_role, spec_class = GetSpecializationInfoByID (specID)
		
		tinsert (options_table, {
			type = "select",
			get = function() return EnemyGridDBChr.spellRangeCheck [specID] end,
			values = function() 
				local onSelectFunc = function (_, _, spellName)
					EnemyGridDBChr.spellRangeCheck [specID] = spellName
					EnemyGrid.GetSpellForRangeCheck()
				end
				local t = {}
				for _, spellID in ipairs (spells) do
					local spellName, _, spellIcon = GetSpellInfo (spellID)
					tinsert (t, {label = spellName, icon = spellIcon, onclick = onSelectFunc, value = spellName})
				end
				return t
			end,
			name = "|T" .. spec_icon .. ":16:16|t " .. spec_name,
			desc = "Spell to range check on this specializartion.",
		})
		i = i + 1
	end
	
	DF:BuildMenu (frontPageFrame, options_table, mainStartX, mainStartY, mainHeightSize + 20, true, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template)	

--------------------------------
--> health and cast bars frame

	local options_table = {
		{type = "label", get = function() return L["S_HEALTHBAR_APPEARANCE"] end, text_template = text_template},
		--health bar appearance
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.bar_texture end,
			values = function() return build_texture_options ("bar_texture") end,
			name = L["S_TEXTURE"],
			desc = L["S_TEXTURE"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.bar_texturebackground end,
			values = function() return build_texture_options ("bar_texturebackground") end,
			name = L["S_TEXTUREBACKGROUND"],
			desc = L["S_TEXTUREBACKGROUND"],
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.bar_color_by_class end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.bar_color_by_class = value
				EnemyGrid.ReEvent()
			end,
			name = L["S_CLASSCOLOR"],
			desc = L["S_CLASSCOLOR"],
		},
		
		{type = "blank"},
		--health bar text (actor name)
		{type = "label", get = function() return L["S_HEALTHBAR_TEXT"] end, text_template = text_template},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.name_text_size end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.name_text_size = value
				EnemyGrid.UpdateGrid()
			end,
			min = 8,
			max = 100,
			step = 1,
			name = L["S_SIZE"],
			desc = L["S_SIZE"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.name_text_stringsize end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.name_text_stringsize = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = 20,
			max = 200,
			step = 1,
			name = L["S_LENGTH"],
			desc = L["S_LENGTH"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.name_text_font end,
			values = function() return DF:BuildDropDownFontList (on_select_healthbar_font) end,
			name = L["S_FONT"],
			desc = L["S_FONT"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.name_text_color
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.name_text_color
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_COLOR"],
			desc = L["S_COLOR"],
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.name_text_shadow end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.name_text_shadow = value
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_SHADOW"],
			desc = L["S_SHADOW"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.name_text_anchor.side end,
			values = function() return build_anchor_side_table ("name_text_anchor") end,
			name = L["S_ANCHOR"],
			desc = L["S_ANCHOR"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.name_text_anchor.x end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.name_text_anchor.x = value
				EnemyGrid.UpdateGrid()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_XOFFSET"],
			desc = L["S_XOFFSET"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.name_text_anchor.y end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.name_text_anchor.y = value
				EnemyGrid.UpdateGrid()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_YOFFSET"],
			desc = L["S_YOFFSET"],
		},
		
		{type = "blank"},
		--health bar percent text
		{type = "label", get = function() return L["S_HEALTHPERCENT_TEXT"] end, text_template = text_template},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.percent_text_enabled end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.percent_text_enabled = value
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_ENABLED"],
			desc = L["S_ENABLED"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.percent_text_size end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.percent_text_size = value
				EnemyGrid.UpdateGrid()
			end,
			min = 8,
			max = 100,
			step = 1,
			name = L["S_SIZE"],
			desc = L["S_SIZE"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.percent_text_font end,
			values = function() return DF:BuildDropDownFontList (on_select_healthtext_font) end,
			name = L["S_FONT"],
			desc = L["S_FONT"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.percent_text_color
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.percent_text_color
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_COLOR"],
			desc = L["S_COLOR"],
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.percent_text_shadow end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.percent_text_shadow = value
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_SHADOW"],
			desc = L["S_SHADOW"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.percent_text_anchor.side end,
			values = function() return build_anchor_side_table ("percent_text_anchor") end,
			name = L["S_ANCHOR"],
			desc = L["S_ANCHOR"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.percent_text_anchor.x end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.percent_text_anchor.x = value
				EnemyGrid.UpdateGrid()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_XOFFSET"],
			desc = L["S_XOFFSET"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.percent_text_anchor.y end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.percent_text_anchor.y = value
				EnemyGrid.UpdateGrid()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_YOFFSET"],
			desc = L["S_YOFFSET"],
		},
		
		{type = "breakline"},

		--cast bar appearance
		{type = "label", get = function() return L["S_CASTBAR_APPEARANCE"] end, text_template = text_template},
		
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.cast_enabled end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.cast_enabled = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			name = L["S_ENABLED"],
			desc = L["S_ENABLED"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.cast_statusbar_texture end,
			values = function() return build_texture_options ("cast_statusbar_texture") end,
			name = L["S_TEXTURE"],
			desc = L["S_TEXTURE"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.cast_statusbar_bgtexture end,
			values = function() return build_texture_options ("cast_statusbar_bgtexture") end,
			name = L["S_TEXTUREBACKGROUND"],
			desc = L["S_TEXTUREBACKGROUND"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.cast_statusbar_color
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.cast_statusbar_color
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_COLOR"],
			desc = L["S_COLOR"],
		},
		
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.cast_statusbar_color_nointerrupt
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.cast_statusbar_color_nointerrupt
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_CASTBAR_NONINTERRUPT_COLOR"],
			desc = L["S_CASTBAR_NONINTERRUPT_COLOR"],
		},

		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.cast_statusbar_bgcolor
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.cast_statusbar_bgcolor
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_BACKGROUNDCOLOR"],
			desc = L["S_BACKGROUNDCOLOR"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.cast_statusbar_anchor.side end,
			values = function() return build_anchor_side_table ("cast_statusbar_anchor") end,
			name = L["S_ANCHOR"],
			desc = L["S_ANCHOR"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.cast_statusbar_anchor.x end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.cast_statusbar_anchor.x = value
				EnemyGrid.UpdateGrid()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_XOFFSET"],
			desc = L["S_XOFFSET"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.cast_statusbar_anchor.y end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.cast_statusbar_anchor.y = value
				EnemyGrid.UpdateGrid()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_YOFFSET"],
			desc = L["S_YOFFSET"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.cast_statusbar_width end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.cast_statusbar_width = value
				EnemyGrid.UpdateGrid()
			end,
			min = 30,
			max = 180,
			step = 1,
			name = L["S_WIDTH"],
			desc = L["S_WIDTH"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.cast_statusbar_height end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.cast_statusbar_height = value
				EnemyGrid.UpdateGrid()
			end,
			min = 8,
			max = 100,
			step = 1,
			name = L["S_HEIGHT"],
			desc = L["S_HEIGHT"],
		},
		
		{type = "blank"},
		--cast bar text (spell name)
		{type = "label", get = function() return L["S_CASTBAR_TEXT"] end, text_template = text_template},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.spellname_text_size end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.spellname_text_size = value
				EnemyGrid.UpdateGrid()
			end,
			min = 8,
			max = 100,
			step = 1,
			name = L["S_SIZE"],
			desc = L["S_SIZE"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.spellname_text_font end,
			values = function() return DF:BuildDropDownFontList (on_select_castbar_font) end,
			name = L["S_FONT"],
			desc = L["S_FONT"],
		},
		{
			type = "color",
			get = function()
				local color = EnemyGrid.db.profile.spellname_text_color
				return {color[1], color[2], color[3], color[4]}
			end,
			set = function (self, r, g, b, a) 
				local color = EnemyGrid.db.profile.spellname_text_color
				color[1], color[2], color[3], color[4] = r, g, b, a
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_COLOR"],
			desc = L["S_COLOR"],
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.spellname_text_shadow end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.spellname_text_shadow = value
				EnemyGrid.UpdateGrid()
			end,
			name = L["S_SHADOW"],
			desc = L["S_SHADOW"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.spellname_text_anchor.side end,
			values = function() return build_anchor_side_table ("spellname_text_anchor") end,
			name = L["S_ANCHOR"],
			desc = L["S_ANCHOR"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.spellname_text_anchor.x end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.spellname_text_anchor.x = value
				EnemyGrid.UpdateGrid()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_XOFFSET"],
			desc = L["S_XOFFSET"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.spellname_text_anchor.y end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.spellname_text_anchor.y = value
				EnemyGrid.UpdateGrid()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_YOFFSET"],
			desc = L["S_YOFFSET"],
		},		
	}

	DF:BuildMenu (healAndCastBarsFrame, options_table, mainStartX, mainStartY, mainHeightSize + 40, true, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template)	

--------------------------------
--> keybind frame ~key
	
	local SCROLL_ROLL_AMOUNT = 12
	
	--frame para setar a keybind
	local keyBindListener = CreateFrame ("frame", "EnemyGridOptionsPanelKeyBindListenerFrame", keybindFrame)
	keyBindListener.IsListening = false
	keyBindListener.EditingSpec = EnemyGrid.CurrentSpec
	keyBindListener.CurrentKeybindEditingSet = EnemyGrid.CurrentKeybindSet
	
	local allSpecButtons = {}
	local switch_spec = function (self, button, specID)
		keyBindListener.EditingSpec = specID
		keyBindListener.CurrentKeybindEditingSet = EnemyGridDBChr.KeyBinds [specID]
		
		for _, button in ipairs (allSpecButtons) do
			button.selectedTexture:Hide()
		end
		self.MyObject.selectedTexture:Show()
		
		--feedback ao jogador uma vez que as keybinds podem ter o mesmo valor
		C_Timer.After (.04, function() EnemyGridOptionsPanelFrameKeybindScroill:Hide() end)
		C_Timer.After (.06, function() EnemyGridOptionsPanelFrameKeybindScroill:Show() end)
		
		--atualiza a scroll
		EnemyGridOptionsPanelFrameKeybindScroill:UpdateScroll()
	end
	
	local inactiveFrame = CreateFrame ("frame", nil, keybindFrame)
	inactiveFrame:SetAllPoints()
	inactiveFrame:EnableMouse (true)
	inactiveFrame:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1})
	inactiveFrame:SetBackdropColor (0, 0, 0, 1)
	inactiveFrame:SetBackdropBorderColor (1, 1, 1, 0)
	inactiveFrame:SetFrameLevel (keybindFrame:GetFrameLevel()+10)
	
	--7.1_warning
	local warning_7_1_patch = DF:CreateLabel (inactiveFrame, "Keybinds won't work anymore since 7.1 patch")
	warning_7_1_patch:SetPoint (450, -150)
	warning_7_1_patch.textcolor = "red"
	warning_7_1_patch.textsize = 16
	
	
	
	--bot�es para selecionar a spec
	local spec1 = DF:CreateButton (keybindFrame, switch_spec, 160, 20, "Spec1 Placeholder Text", 1, _, _, "SpecButton1", _, 0, options_button_template, options_text_template)
	local spec2 = DF:CreateButton (keybindFrame, switch_spec, 160, 20, "Spec2 Placeholder Text", 1, _, _, "SpecButton2", _, 0, options_button_template, options_text_template)
	local spec3 = DF:CreateButton (keybindFrame, switch_spec, 160, 20, "Spec3 Placeholder Text", 1, _, _, "SpecButton3", _, 0, options_button_template, options_text_template)
	local spec4 = DF:CreateButton (keybindFrame, switch_spec, 160, 20, "Spec4 Placeholder Text", 1, _, _, "SpecButton4", _, 0, options_button_template, options_text_template)
	
	local className, class = UnitClass ("player")
	local i = 1
	for specID, _ in pairs (defaultSpecKeybindList [class]) do
		local button = keybindFrame ["SpecButton" .. i]
		local spec_id, spec_name, spec_description, spec_icon, spec_background, spec_role, spec_class = GetSpecializationInfoByID (specID)
		button.text = spec_name
		button:SetClickFunction (switch_spec, specID)
		button:SetIcon (spec_icon)
		button.specID = spec_id
		
		local selectedTexture = button:CreateTexture (nil, "background")
		selectedTexture:SetAllPoints()
		selectedTexture:SetColorTexture (1, 1, 1, 0.5)
		if (spec_id ~= keyBindListener.EditingSpec) then
			selectedTexture:Hide()
		end
		button.selectedTexture = selectedTexture
		
		tinsert (allSpecButtons, button)
		i = i + 1
	end
	
	local specsTitle = DF:CreateLabel (keybindFrame, "Config keys for spec:", 12, "silver")
	specsTitle:SetPoint ("topleft", keybindFrame, "topleft", 10, mainStartY)
	
	spec1:SetPoint ("topleft", specsTitle, "bottomleft", 0, -10)
	spec2:SetPoint ("topleft", specsTitle, "bottomleft", 0, -30)
	spec3:SetPoint ("topleft", specsTitle, "bottomleft", 0, -50)
	if (class == "DRUID") then
		spec4:SetPoint ("topleft", specsTitle, "bottomleft", 0, -70)
	end
	
	local enter_the_key = CreateFrame ("frame", nil, keyBindListener)
	enter_the_key:SetFrameStrata ("tooltip")
	enter_the_key:SetSize (200, 60)
	enter_the_key:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1})
	enter_the_key:SetBackdropColor (0, 0, 0, 1)
	enter_the_key:SetBackdropBorderColor (1, 1, 1, 1)
	enter_the_key.text = DF:CreateLabel (enter_the_key, "- Press a keyboard key to bind.\n- Click to bind a mouse button.\n- Press escape to cancel.", 11, "orange")
	enter_the_key.text:SetPoint ("center", enter_the_key, "center")
	enter_the_key:Hide()
	
	local registerKeybind = function (self, key) 
		if (ignoredKeys [key]) then
			return
		end
		if (key == "ESCAPE") then
			enter_the_key:Hide()
			keyBindListener.IsListening = false
			keyBindListener:SetScript ("OnKeyDown", nil)
			return
		end
		
		local bind = (IsShiftKeyDown() and "SHIFT-" or "") .. (IsControlKeyDown() and "CTRL-" or "") .. (IsAltKeyDown() and "ALT-" or "")
		bind = bind .. key
	
		--adiciona para a tabela de keybinds
		local keybind = keyBindListener.CurrentKeybindEditingSet [self.keybindIndex]
		keybind.key = bind
		
		keyBindListener.IsListening = false
		keyBindListener:SetScript ("OnKeyDown", nil)
		
		enter_the_key:Hide()
		keybindFrame.keybindScroll:UpdateScroll()
		EnemyGrid.UpdateKeyBinds()
	end
	
	local set_keybind_key = function (self, button, keybindIndex)
		if (keyBindListener.IsListening) then
			key = mouseKeys [button] or button
			return registerKeybind (keyBindListener, key)
		end
		keyBindListener.IsListening = true
		keyBindListener.keybindIndex = keybindIndex
		keyBindListener:SetScript ("OnKeyDown", registerKeybind)
		
		enter_the_key:Show()
		enter_the_key:SetPoint ("bottom", self, "top")
	end
	
	local new_key_bind = function (self, button, specID)
		tinsert (keyBindListener.CurrentKeybindEditingSet, {key = "-none-", action = "_target", actiontext = ""})
		FauxScrollFrame_SetOffset (keybindFrame.keybindScroll, max (#keyBindListener.CurrentKeybindEditingSet-SCROLL_ROLL_AMOUNT, 0))
		keybindFrame.keybindScroll:UpdateScroll()
	end	
	
	local set_action_text = function (keybindIndex, _, text)
		local keybind = keyBindListener.CurrentKeybindEditingSet [keybindIndex]
		keybind.actiontext = text
		EnemyGrid.UpdateKeyBinds()
	end
	local set_action_on_espace_press = function (textentry, capsule)
		capsule = capsule or textentry.MyObject
		local keybind = keyBindListener.CurrentKeybindEditingSet [capsule.CurIndex]
		textentry:SetText (keybind.actiontext)
		EnemyGrid.UpdateKeyBinds()
	end
	
	local lock_textentry = {
		["_target"] = true,
		["_taunt"] = true,
		["_interrupt"] = true,
		["_dispel"] = true,
		["_spell"] = false,
		["_macro"] = false,
	}
	
	local change_key_action = function (self, keybindIndex, value)
		local keybind = keyBindListener.CurrentKeybindEditingSet [keybindIndex]
		keybind.action = value
		keybindFrame.keybindScroll:UpdateScroll()
		EnemyGrid.UpdateKeyBinds()
	end
	local fill_action_dropdown = function()
	
		local locClass, class = UnitClass ("player")
		
		local taunt = tauntList [class] and GetSpellInfo (tauntList [class]) or ""
		local interrupt = interruptList [class] and GetSpellInfo (interruptList [class]) or ""
		local dispel = dispelList [class]
		
		if (type (dispel) == "table") then
			local dispelString = "\n"
			for specID, spellid in pairs (dispel) do
				local specid, specName = GetSpecializationInfoByID (specID)
				local spellName = GetSpellInfo (spellid)
				dispelString = dispelString .. "|cFFE5E5E5" .. specName .. "|r: |cFFFFFFFF" .. spellName .. "\n"
			end
			dispel = dispelString
		else
			dispel = GetSpellInfo (dispel) or ""
		end
		
		return {
			{value = "_target", label = "Target", onclick = change_key_action, desc = "Target the unit"},
			{value = "_taunt", label = "Taunt", onclick = change_key_action, desc = "Cast the taunt spell for your class\n\n|cFFFFFFFFSpell: " .. taunt},
			{value = "_interrupt", label = "Interrupt", onclick = change_key_action, desc = "Cast the interrupt spell for your class\n\n|cFFFFFFFFSpell: " .. interrupt},
			{value = "_dispel", label = "Dispel", onclick = change_key_action, desc = "Cast the interrupt spell for your class\n\n|cFFFFFFFFSpell: " .. dispel},
			{value = "_spell", label = "Cast Spell", onclick = change_key_action, desc = "Type the spell name in the text box"},
			{value = "_macro", label = "Macro", onclick = change_key_action, desc = "Type your macro in the text box"},
		}
	end
	
	local copy_keybind = function (self, button, keybindIndex)
		local keybind = keyBindListener.CurrentKeybindEditingSet [keybindIndex]
		for specID, t in pairs (EnemyGridDBChr.KeyBinds) do
			if (specID ~= keyBindListener.EditingSpec) then
				local key = CopyTable (keybind)
				local specid, specName = GetSpecializationInfoByID (specID)
				tinsert (EnemyGridDBChr.KeyBinds [specID], key)
				EnemyGrid:Msg ("Keybind copied to " .. specName)
			end
		end
		EnemyGrid.UpdateKeyBinds()
	end
	
	local delete_keybind = function (self, button, keybindIndex)
		tremove (keyBindListener.CurrentKeybindEditingSet, keybindIndex)
		keybindFrame.keybindScroll:UpdateScroll()
		EnemyGrid.UpdateKeyBinds()
	end
	
	local newTitle = DF:CreateLabel (keybindFrame, "Create a new Keybind:", 12, "silver")
	newTitle:SetPoint ("topleft", keybindFrame, "topleft", 200, mainStartY)
	local createNewKeybind = DF:CreateButton (keybindFrame, new_key_bind, 160, 20, "New Key Bind", 1, _, _, "NewKeybindButton", _, 0, options_button_template, options_text_template)
	createNewKeybind:SetPoint ("topleft", newTitle, "bottomleft", 0, -10)
	--createNewKeybind:SetIcon ([[Interface\Buttons\UI-GuildButton-PublicNote-Up]])

	local update_keybind_list = function (self)
		
		local keybinds = keyBindListener.CurrentKeybindEditingSet
		FauxScrollFrame_Update (self, #keybinds, SCROLL_ROLL_AMOUNT, 21)
		local offset = FauxScrollFrame_GetOffset (self)
		
		for i = 1, SCROLL_ROLL_AMOUNT do
			local index = i + offset
			local f = self.Frames [i]
			local data = keybinds [index]

			if (data) then
				--index
				f.Index.text = index
				--keybind
				local keyBindText = keysToMouse [data.key] or data.key
				
				keyBindText = keyBindText:gsub ("type1", "LeftButton")
				keyBindText = keyBindText:gsub ("type2", "RightButton")
				keyBindText = keyBindText:gsub ("type3", "MiddleButton")
				
				f.KeyBind.text = keyBindText
				f.KeyBind:SetClickFunction (set_keybind_key, index, nil, "left")
				f.KeyBind:SetClickFunction (set_keybind_key, index, nil, "right")
				--action
				f.ActionDrop:SetFixedParameter (index)
				f.ActionDrop:Select (data.action)
				--action text
				f.ActionText.text = data.actiontext
				f.ActionText:SetEnterFunction (set_action_text, index)
				f.ActionText.CurIndex = index
				
				if (lock_textentry [data.action]) then
					f.ActionText:Disable()
				else
					f.ActionText:Enable()
				end
				
				--copy
				f.Copy:SetClickFunction (copy_keybind, index)
				--delete
				f.Delete:SetClickFunction (delete_keybind, index)
				
				f:Show()
			else
				f:Hide()
			end
		end
		
		self:Show()
	end
	
	local keybindScroll = CreateFrame ("scrollframe", "EnemyGridOptionsPanelFrameKeybindScroill", keybindFrame, "FauxScrollFrameTemplate")
	keybindScroll:SetPoint ("topleft", specsTitle.widget, "bottomleft", 0, -120)
	keybindScroll:SetSize (1019, 348)
	keybindScroll.Frames = {}
	keybindFrame.keybindScroll = keybindScroll
	
	keybindScroll:SetScript ("OnVerticalScroll", function (self, offset)
		FauxScrollFrame_OnVerticalScroll (self, offset, 21, update_keybind_list)
	end)
	keybindScroll.UpdateScroll = update_keybind_list
	
	local backdropColor = {.3, .3, .3, .3}
	local backdropColorOnEnter = {.6, .6, .6, .6}
	local on_enter = function (self)
		self:SetBackdropColor (unpack (backdropColorOnEnter))
	end
	local on_leave = function (self)
		self:SetBackdropColor (unpack (backdropColor))
	end
	
	local font = "GameFontHighlightSmall"
	
	for i = 1, SCROLL_ROLL_AMOUNT do
		local f = CreateFrame ("frame", "$KeyBindFrame" .. i, keybindScroll)
		f:SetSize (1009, 20)
		f:SetPoint ("topleft", keybindScroll, "topleft", 0, -(i-1)*29)
		f:SetBackdrop ({bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tileSize = 64, tile = true})
		f:SetBackdropColor (unpack (backdropColor))
		f:SetScript ("OnEnter", on_enter)
		f:SetScript ("OnLeave", on_leave)
		tinsert (keybindScroll.Frames, f)
		
		f.Index = DF:CreateLabel (f, "1")
		f.KeyBind = DF:CreateButton (f, set_key_bind, 100, 20, "", _, _, _, "SetNewKeybindButton", _, 0, options_button_template, options_text_template)
		f.ActionDrop = DF:CreateDropDown (f, fill_action_dropdown, 0, 120, 20, "ActionDropdown", _, options_dropdown_template)
		f.ActionText = DF:CreateTextEntry (f, function()end, 660, 20, "TextBox", _, _, options_dropdown_template)
		f.Copy = DF:CreateButton (f, copy_keybind, 20, 20, "", _, _, _, "CopyKeybindButton", _, 0, options_button_template, options_text_template)
		f.Delete = DF:CreateButton (f, delete_keybind, 16, 20, "", _, _, _, "DeleteKeybindButton", _, 2, options_button_template, options_text_template)
		
		f.Index:SetPoint ("left", f, "left", 10, 0)
		f.KeyBind:SetPoint ("left", f, "left", 43, 0)
		f.ActionDrop:SetPoint ("left", f, "left", 150, 0)
		f.ActionText:SetPoint ("left", f, "left", 276, 0)
		f.Copy:SetPoint ("left", f, "left", 950, 0)
		f.Delete:SetPoint ("left", f, "left", 990, 0)
		
		f.Copy:SetIcon ([[Interface\Buttons\UI-GuildButton-PublicNote-Up]], nil, nil, nil, nil, nil, nil, 4)
		f.Delete:SetIcon ([[Interface\Buttons\UI-StopButton]], nil, nil, nil, nil, nil, nil, 4)
		
		f.Copy.tooltip = "copy this keybind to other specs"
		f.Delete.tooltip = "erase this keybind"
		
		--editbox
		f.ActionText:SetJustifyH ("left")
		f.ActionText:SetHook ("OnEscapePressed", set_action_on_espace_press)
		f.ActionText:SetHook ("OnEditFocusGained", function()
			local playerSpells = {}
			local tab, tabTex, offset, numSpells = GetSpellTabInfo (2)
			for i = 1, numSpells do
				local index = offset + i
				local spellType, spellId = GetSpellBookItemInfo (index, "player")
				if (spellType == "SPELL") then
					local spellName = GetSpellInfo (spellId)
					tinsert (playerSpells, spellName)
				end
			end
			f.ActionText.WordList = playerSpells
		end)
		
		f.ActionText:SetAsAutoComplete ("WordList")
	end
	
	local header = CreateFrame ("frame", "EnemyGridOptionsPanelFrameHeader", keybindScroll)
	header:SetPoint ("bottomleft", keybindScroll, "topleft", 0, 2)
	header:SetPoint ("bottomright", keybindScroll, "topright", 0, 2)
	header:SetHeight (16)

	header.Index = DF:CreateLabel  (header, "Index", DF:GetTemplate ("font", "OPTIONS_FONT_TEMPLATE"))
	header.Key = DF:CreateLabel  (header, "Key", DF:GetTemplate ("font", "OPTIONS_FONT_TEMPLATE"))
	header.Action = DF:CreateLabel  (header, "Action", DF:GetTemplate ("font", "OPTIONS_FONT_TEMPLATE"))
	header.Macro = DF:CreateLabel  (header, "Spell Name / Macro", DF:GetTemplate ("font", "OPTIONS_FONT_TEMPLATE"))
	header.Copy = DF:CreateLabel  (header, "Copy", DF:GetTemplate ("font", "OPTIONS_FONT_TEMPLATE"))
	header.Delete = DF:CreateLabel  (header, "Delete", DF:GetTemplate ("font", "OPTIONS_FONT_TEMPLATE"))
	
	header.Index:SetPoint ("left", header, "left", 10, 0)
	header.Key:SetPoint ("left", header, "left", 43, 0)
	header.Action:SetPoint ("left", header, "left", 150, 0)
	header.Macro:SetPoint ("left", header, "left", 276, 0)
	header.Copy:SetPoint ("left", header, "left", 950, 0)
	header.Delete:SetPoint ("left", header, "left", 990, 0)

	keybindFrame:SetScript ("OnShow", function()
		keyBindListener.EditingSpec = EnemyGrid.CurrentSpec
		keyBindListener.CurrentKeybindEditingSet = EnemyGrid.CurrentKeybindSet
		
		for _, button in ipairs (allSpecButtons) do
			if (keyBindListener.EditingSpec ~= button.specID) then
				button.selectedTexture:Hide()
			else
				button.selectedTexture:Show()
			end
		end
		
		keybindScroll:UpdateScroll()
	end)
	
	keybindFrame:SetScript ("OnHide", function()
		if (keyBindListener.IsListening) then
			keyBindListener.IsListening = false
			keyBindListener:SetScript ("OnKeyDown", nil)
		end
	end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> ~auras ~debuff ~buff
--	local welcomestring = DF:CreateLabel (auraFrame, "Cast spells to fill *your* debuffs list.", 16, "white")
--	welcomestring:SetPoint ("topleft", self, "topleft", 10, -210)
--	local subLine = DF:CreateImage (auraFrame, nil, 300, 1)
--	subLine:SetColorTexture (1, 1, 1, 0.7)
--	subLine:SetPoint ("topleft", welcomestring, "bottomleft")
--	subLine:SetPoint ("topright", welcomestring, "bottomright")

	local aura_options = {
		height = 400, 
		row_height = 16,
		width = 200,
	}

	local auraConfigPanel = DF:CreateAuraConfigPanel (auraFrame, "$parentAuraConfig", EnemyGrid.db.profile, _, aura_options) --method_change_callback
	auraConfigPanel:SetPoint ("topleft", auraFrame, "topleft", 250, -100)
	auraConfigPanel:SetSize (600, 600)
	auraConfigPanel:Show()
	auraFrame.auraConfigPanel = auraConfigPanel

	local options_table = {
		--debuff config debuff settings
		{type = "label", get = function() return L["S_DEBUFFCONFIG"] end, text_template = text_template},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.debuff_anchor.side end,
			values = function() return build_anchor_side_table ("debuff_anchor") end,
			name = L["S_ANCHOR"],
			desc = L["S_ANCHOR"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.debuff_anchor.x end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.debuff_anchor.x = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_XOFFSET"],
			desc = L["S_XOFFSET"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.debuff_anchor.y end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.debuff_anchor.y = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = -20,
			max = 20,
			step = 1,
			name = L["S_YOFFSET"],
			desc = L["S_YOFFSET"],
		},
		{
			type = "select",
			get = function() return EnemyGrid.db.profile.debuff_anchor_grow_direction end,
			values = function()
				return {
					{label = L["S_LEFT"], value = "left", onclick = function() EnemyGrid.db.profile.debuff_anchor_grow_direction = "left"; EnemyGrid.UpdateGrid(); EnemyGrid.ReEvent() end},
					{label = L["S_RIGHT"], value = "right", onclick = function() EnemyGrid.db.profile.debuff_anchor_grow_direction = "right"; EnemyGrid.UpdateGrid(); EnemyGrid.ReEvent() end},
				}
			end,
			name = L["S_GROWDIRECTION"],
			desc = L["S_GROWDIRECTION"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.aura_width end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.aura_width = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = 8,
			max = 40,
			step = 1,
			name = L["S_WIDTH"],
			desc = L["S_WIDTH"],
		},
		{
			type = "range",
			get = function() return EnemyGrid.db.profile.aura_height end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.aura_height = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			min = 8,
			max = 40,
			step = 1,
			name = L["S_HEIGHT"],
			desc = L["S_HEIGHT"],
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.aura_timer end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.aura_timer = value
				EnemyGrid.UpdateGrid()
				EnemyGrid.ReEvent()
			end,
			name = L["S_SHOWTIMER"],
			desc = L["S_SHOWTIMER_DESC"],
		},
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.aura_show_tooltip end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.aura_show_tooltip = value
			end,
			name = L["S_SHOWTOOLTIP"],
			desc = L["S_SHOWTOOLTIP"],
		},
		
		{
			type = "toggle",
			get = function() return EnemyGrid.db.profile.aura_always_show_debuffs end,
			set = function (self, fixedparam, value) 
				EnemyGrid.db.profile.aura_always_show_debuffs = value
			end,
			name = L["S_ALWAYSSHOWDEBUFFS"],
			desc = L["S_ALWAYSSHOWDEBUFFS_DESC"],
		},
		
		
	}

	DF:BuildMenu (auraFrame, options_table, mainStartX, mainStartY, mainHeightSize + 20, true, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template)		

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	f:Show()
end
-- endd doo
