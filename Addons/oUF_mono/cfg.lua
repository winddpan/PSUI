  local addon, ns = ...
  local cfg = CreateFrame("Frame")

  cfg.oUF = { 
    -- CONFIG
	settings = {		-- general settings
		ReverseHPbars = false,				-- fill health bars from right to left instead of standard left -> right direction 
		health_spark = true,				-- add spark to the health bar
		class_color_power = false,			-- class color power bar
		show_class = false,					-- display additional class indication @ unit frames
		playerauras = "NONE",  			-- small aura frame for player, available options: "BUFFS", "DEBUFFS", "AURAS", "NONE"
		auratimers = {
			["enable"] = true,				-- aura timers
			["font_size"] = 8,				-- aura timer font size
		},
		ghost_target = false, 				-- fake target bars that spawn if you don't have anything targeted
		raid_mark = {
			["enable"] = true,				-- enable raid marks
			["alpha"] = 0.6,				-- raid mark opacity
			["size"] = 16,					-- raid mark size
		},
		CombatFeedback = false,				-- enables CombatFeedback on player and target unit frames
		SwingTimer = false,					-- enables oUF_Swing module for player's auto attack/shot timer
		Portrait = false,					-- enables 3d portraits on player and target unit frames
		ClassBars = {
			["enable"] = true,				-- enable class specific bars (totems, runes etc.)
			["undock"] = false,				-- set a custom position for this element
			["position"] = {"CENTER",UIParent,"BOTTOM",0,250},
		},
		AltPowerBar = {
			["enable"] = true,				-- let oUF handle alternative powerbar
			["undock"] = false,				-- set custom position for it
			["position"] = {"BOTTOM", "UIParent", "BOTTOM", 0, 275},
		},
		click2focus = {					
			["enable"] = true,				-- set focus macro on modified frame click (may cause taint)
			["key"] = "Shift",				-- modifier key to focus
		},
	},
	frames = {			-- unit frames settings
		PPHeight = 12,
		player = {						-- Player's frame
			["position"] = {"RIGHT", UIParent, "BOTTOM", -150, 280},		
			["width"] = 208,
			["height"] = 20,
			["scale"] = 1,
		},
		target = {						-- Target's frame
			["position"] = {"LEFT", UIParent, "BOTTOM", 150, 280},	
			["width"] = 208,
			["height"] = 20,
			["scale"] = 1,
		},
		tot = {
			["enable"] = true,			-- Target of Target
			["position"] = {"TOPRIGHT", "oUF_monoTargetFrame", "BOTTOMRIGHT", 0, -39},
			["width"] = 60,
			["height"] = 24,
			["scale"] = 1,
		},
		pet = {
			["enable"] = true,			-- Player's pet
			["position"] = {"TOPRIGHT", "oUF_monoPlayerFrame", "TOPLEFT", -28, 0},
			["width"] = 60,
			["height"] = 24,
			["scale"] = 1,
		},
		focus = {
			["enable"] = true,			-- Focus target + target of focus target
			--["position"] = {"TOPLEFT", "oUF_monoPlayerFrame", "BOTTOMLEFT", 0, -39},
			--["target_position"] = {"TOPLEFT", "oUF_monoTargetFrame", "BOTTOMLEFT", 0, -42},
			["position"] = {"RIGHT", "oUF_monoTargetFrame", "RIGHT", 0, 400},	
			["width"] = 150,
			["height"] = 24,
			["scale"] = 1,
		},
		party = {
			["enable"] = true,			-- Party frames
			["position"] = {"BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 100, 360},
			["spacing"] = 30,			-- spacing between party units
			["width"] = 190,
			["height"] = 20,
			["scale"] = 1,
		},
		arena_boss = {
			["enable_arena"] = false,	-- Boss & Arena frames
			["enable_boss"] = true,
			["position"] = {"BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -60, 360},
			["spacing"] = 56,			-- spacing between units
			["width"] = 190,
			["height"] = 20,
			["scale"] = 1,
		},
		raid = {						-- Raid frames configuration
			["enable"] = true,			
			["position"] = {"TOPLEFT", "UIParent", "TOPLEFT", 24, -225},
			
			["party"] = false, 								-- show party as 5 men raid group
			["raid5"] = false, 								-- show raid frame for 5 (or less) men raid group
			["raid40"] = true, 								-- allow raid frames to change their size if there are more than 30 players in the group
			["raid_menu"] = false,							-- enable/disable right-click menu for raid frames
			main_tank = { 
				["enable"] = false,														-- enable Main tank frames
				["position"] = {"BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -163, 233},	-- MTs frame position
				["scale"] = 1.5, 														-- MT size relatively to unit size
			},
			["width"] = 115, 								-- raid unit width
			["height"] = 27, 								-- raid unit height
			["spacing"] = 5, 								-- spacing between units
			["name_length"] = 4, 							-- number of letters to display
			["font_size"] = 12, 							-- font size for names / hp values
			["orientation"] = "HORIZONTAL", 				-- hp/mp bar direction
			["focus_color"] = {.8, .8, .2, .66}, 			-- focus border color
			["DisableRaidManager"] = true, 					-- disable default compact Raid Manager button
			["update_time"] = .25, 							-- Enhances update rate for indicators (can be cpu intensive with lower values)
			debuff = {	
				["size"] = 15, 								-- debuff icon size
				["timer"] = 5,								-- enable/disable timer for raid debuffs 
			}, 
			indicators = { 							
				["enable"] = true,							-- enable/disable raid frames indicators
				["size"] = 5, 								-- square indicator size
				["counter_size"] = 11, 						-- bottom right corner counter size
			},
			icons = {
				["size"] = 10, 								-- informative icon size (aka RL,ML,A etc.)
				["leader"] = true,							-- toggle leader/assistant/master looter icons visibility on raid units
				["raid_mark"] = true, 						-- toggle raid mark visibility on raid units
				["ready_check"] = true, 					-- ready check icon
				["role"] = true, 							-- toggle group role indication on/off
			},
			powerbar = {
				["enable"] = true, 							-- toggle display of tiny power bars on raid frames
				["size"] = 2, 								-- power bar size
			},
			healbar = { 								
				["enable"] = true,							-- enable healing prediction bar
				["healalpha"] = 0.25, 						-- heal prediction bar alpha
				["healoverflow"] = 1, 						-- overhealing display (1 = disabled, may take values higher than 1)
				["healtext"] = false, 						-- show/hide heal prediction text
			},
		},
	},
	castbar = {			-- cast bars settings
		color = {
			["normal"] = {.3,.45,.65},
			["uninterruptable"] = {1,.49,0},
		},
		player = {
			["enable"] = true,								-- enable cast bar for player frame
			["undock"] = false,								-- detach cast bar from frame
			["position"] = {"CENTER",UIParent,"BOTTOM",10,320}, -- custom castbar position if undocked
			["width"] = 210,								-- cast bar width if undocked
			["height"] = 20, 								-- cast bar height if undocked
		},
		target = {
			["enable"] = true,
			["undock"] = false,
			["position"] = {"CENTER",UIParent,"BOTTOM",10,360},	
			["width"] = 210,
			["height"] = 20,
		},
		focus = {
			["enable"] = true,
			["undock"] = true,
			["position"] = {"TOPRIGHT","oUF_monoFocusFrame","BOTTOMRIGHT",0,-2},

			["width"] = 150,
			["height"] = 20,
		},
	},
	-- MEDIA
	media = {
		statusbar = "Interface\\Addons\\oUF_mono\\media\\statusbar",
		auratex = "Interface\\Addons\\oUF_mono\\media\\iconborder",
		font = STANDARD_TEXT_FONT,
		numberFont = "Interface\\Addons\\oUF_mono\\media\\numberfont.ttf",
		pixFont = "Interface\\Addons\\oUF_mono\\media\\pixfont.ttf",
		backdrop_texture = "Interface\\Addons\\oUF_mono\\media\\backdrop",
		backdrop_edge_texture = "Interface\\Addons\\oUF_mono\\media\\backdrop_edge",
		
		aurafont = "Interface\\Addons\\oUF_mono\\media\\auras.ttf",
		debuffborder = "Interface\\Addons\\oUF_mono\\media\\iconborder",
		highlightTex = "Interface\\Buttons\\WHITE8x8",
	},
  }
  
  -- my config 
  -- HANDOVER
  ns.cfg = cfg
