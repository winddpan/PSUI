local addon, ns = ...
local cfg = CreateFrame("Frame")

cfg.combattext = {
	font = DAMAGE_TEXT_FONT,	-- font
	fontsize = 20,												-- font size
	fontstyle = "OUTLINE",										-- font style
	
	frame1_pos = {"CENTER", "UIParent", "CENTER", -200, -70},	-- incoming damage frame position
	frame2_pos = {"CENTER", "UIParent", "CENTER", -205, -70},	-- incoming healing frame position
	--cfg.frame3_pos = {"LEFT", "UIParent", "CENTER", 320, 42}	-- outgoing damage/healing frame position
	frame3_pos = {"LEFT", "UIParent", "CENTER", 220, 42},	-- outgoing damage/healing frame position
	
	show_damage = true,				-- enable outgoing damage combat text display
	show_healing = true,			-- enable outgoing healing combat text display
	
	hide_swing = true,				-- hide melee swing attacks: hits, misses, parries, blocks etc
	hide_swing_show_parry = true,	-- only checked if hide_swing is enabled, optionally still show parries
	
	time_to_fade = 3,				-- time till text disappears
	show_icons = true,				-- enable icons display for outgoing damage/healing frame
	iconsize = 16,					-- icon size
	show_overhealing = true,			-- display outgoing overhealing in a specific format 'EFFECTIVE_HEALING (OVERHEALING)'
	
	threshold = {
		heal = 1,					-- the minimum ammount of healing done to display
		damage = 1,					-- the minimum ammount of damage done to display
		heal_maxlvl = 100000,			-- different healing threshold for players @ max lvl
		damage_maxlvl = 100000,			-- different damage threshold for players @ max lvl
	},
	
	merge_aoe_spam = true,			-- merge multiple damage/healing events happening simultaniously in a single message
	merge_aoe_time = 0.3,				-- set the delay in seconds for calculating merged values 
									-- (0 means that only events that happened at exactly the same time will be merged)
}

ns.cfg = cfg