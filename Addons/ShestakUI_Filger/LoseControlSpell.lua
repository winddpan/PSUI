local spellIds = {
	----------------
	-- Death Knight
	----------------
	[108194] = "CC",			-- Asphyxiate
        [221562] = "CC",			-- Asphyxiate
	[47476]  = "Silence",		-- Strangulate
	[96294]  = "Root",			-- Chains of Ice (Chilblains)
	[45524]  = "Snare",			-- Chains of Ice
	[115018] = "Immune",		-- Desecrated Ground
	[218826] = "Immune",		-- Desecrated Ground
        [48707]  = "ImmuneSpell",	-- Anti-Magic Shell
	[48792]  = "Other",			-- Icebound Fortitude
	
	-- NEW
        [205630] = "CC",			-- ÒÁÀûµ¤Ö®ÎÕ
        [216007] = "CC",			-- ÓÀºã·ÅÖð
        [200166] = "CC",			-- ¶ñÄ§±äÐÎ
        [211881] = "CC",			-- Ð°ÄÜ±¬·¢
        [207171] = "CC",			-- ÁÝ¶¬½«ÖÁ
        [179057] = "CC",			-- »ìÂÒÐÂÐÇ
        [199804] = "CC",			-- ÕýÖÐÃ¼ÐÄ
        [209790] = "CC",			-- ±ù¶³Ö®¼ý
        [196958] = "CC",			-- °µÖÐ³ö»÷
        [233582] = "Root",			-- ÁÒÑæ²øÉí
        [20066]  = "CC",			-- âã»Ú
	[207685] = "CC",			-- ±¯¿àÖä·û
        [217832] = "CC",			-- ½ûïÀ
        [221527] = "CC",			-- ½ûïÀ
		[213405] = "Snare",			-- Í¶ÖÀÀûÈÐ¼õËÙ
        [204490] = "Silence",		        -- ³ÁÄ¬Öä·û
        [202933] = "Silence",		        -- Ö©Öë¶¤´Ì
        [198909] = "CC",	                -- ³à¾«Ö®¸è
        [224729] = "CC",		        -- ±¬ÁÑÉä»÷
        [171017] = "CC",		        -- Á÷ÐÇ´ò»÷
        [227508] = "CC",		        -- ÈºÌåâã»Ú
        [203337] = "CC",		        -- ±ù¶³ÏÝÚå
        [232055] = "CC",		        -- Å­À×ÆÆ
        [209753] = "CC",			-- Ðý·ç
        [202346] = "CC",			-- ×íÉÏ¼Ó×í
        [121253] = "Snare",			-- ×íÄðÍ¶
        [211793] = "Snare",			-- Àä¿áÑÏ¶¬
        [226943] = "CC",			-- ÐÄÁéÕ¨µ¯
        [207167] = "CC",			-- ÖÂÃ¤±ùÓê
        [202274] = "CC",			-- ÁÒÑæ¾Æ
        [200196] = "CC",			-- Ê¥ÑÔÊõ£º·£
        [200200] = "CC",			-- Ê¥ÑÔÊõ£º·£
        [207165] = "CC",			-- Ô÷¶ñÖ®Á¦
        [205290] = "CC",			-- »Ò½ý¾õÐÑ
        [205273] = "Snare",			-- »Ò½ý¾õÐÑ
        [183218] = "Snare",			-- ·Áº¦Ö®ÊÖ
        [155145] = "Silence",			-- °ÂÊõºéÁ÷
        [202719] = "Silence",			-- °ÂÊõºéÁ÷
        [230083] = "Silence",			-- ¿¨À­ÔÞ·ÏÁé
        [204399] = "CC",			-- ´óµØÖ®Å­
        [198088] = "CC",			-- ¹âÒ«ËéÆ¬
        [227781] = "CC",			-- ¹âÒ«ËéÆ¬
        [207498] = "Other",			-- ÏÈ×æ»¤ÓÓ
        [196555] = "Immune",		        -- Ðé¿ÕÐÐ×ß
        [209426] = "Other",			-- ºÚ°µ
        [212800] = "Other",			-- ¼²Ó°
        [215429] = "CC",		        -- À×öª´ò»÷
        [205238] = "CC",		        -- »ðÒ©Í°
        [220079] = "CC",		        -- ¾²µçÐÂÐÇ
        [193597] = "CC",		        -- ¾²µçÐÂÐÇ
        [203957] = "CC",		        -- Ê±¿Õ¼ÏËø
        [222198] = "CC",		        -- ¾£¼¬
        [233395] = "Root",			-- ÑÏº®ÖÐÐÄ
        [202773] = "CC",			-- Ê¯¿éÍ¶ÖÀ
        [203694] = "CC",			-- ÑÒÊ¯Í¶ÖÀ
        [191530] = "CC",			-- ÑÒÊ¯Í¶ÖÀ
        [170852] = "CC",			-- ¼µ¶ÊÖ®ÎÇ
        [211810] = "CC",			-- ËéÂ­Õß
        [194279] = "Snare",			-- ÌúÝðÞ¼
        [190780] = "Snare",			-- ±ùËªÍÂÏ¢
        [212638] = "Root",			-- ×·×ÙÕßÖ®Íø
        [206755] = "Snare",			-- ÓÎÏÀÖ®Íø
        [200108] = "Root",			-- ÓÎÏÀÖ®Íø
        [190927] = "Root",			-- Óã²æÃÍ´Ì
        [194401] = "Root",			-- ¸¯ÀÃ¸ùÐë
        [61385]  = "Root",			-- ²¶ÐÜÏÝÚå
        [160067] = "Snare",			-- ÖëÍøÅçÉä
        [228215] = "CC",			-- Ñï³¾ÂþÌì
        [200851] = "ImmuneSpell",	        -- ³ÁË¯ÕßÖ®Å­
        [213691] = "CC",		        -- ÇýÉ¢Éä»÷
        [202244] = "CC",		        -- ÂùÁ¦³å·æ
        [197214] = "CC",		        -- ÁÑµØÊõ
        [198813] = "Snare",			-- ¸´³ð»Ø±Ü
        [222897] = "CC",		        -- ±©·çÖ®´¸
        [203343] = "Other",		        -- ÑÌÎíµ¯
        [204246] = "CC",		        -- ÕÛÄ¥¿Ö¾å
        [199063] = "Root",		        -- ¾À²øÖ®¸ù
        [200273] = "Silence",			-- Å³Èõ
        [193585] = "CC",		        -- Êø¸¿
        [195944] = "CC",		        -- ³åÌìÅ­»ð
        [193069] = "CC",		        -- ÃÎ÷Ê
        [212565] = "CC",		        -- ºÃÆæÄýÊÓ
        [193969] = "Root",		        -- Èñ´Ì
        [209027] = "CC",		        -- Ñ¹ÖÆ´ò»÷
        [213233] = "CC",		        -- ²»ËÙÖ®¿Í
        [217342] = "Root",		        -- Ð°¶ñ²øÍø
        [215552] = "CC",		        -- ²Ô°×÷ÈÁ¦
        [195129] = "CC",		        -- À×öª¼ùÌ¤
        [197144] = "Root",		        -- ¹³Íø
        [196515] = "Root",		        -- Ä§·¨½ûïÀ
        [192708] = "CC",		        -- °ÂÊõÕ¨µ¯
        [218012] = "CC",		        -- °ÂÄÜÂö³å
        [183020] = "Root",			-- Ð°ÄÜÇô½û
        [195561] = "CC",		        -- Ã¤Ä¿×Ä»÷
        [222417] = "CC",		        -- ·ÛËé¾ÞÊ¯
        [214002] = "CC",		        -- ¶ÉÑ»µÄ¸©³å
        [199168] = "CC",		        -- ºÃÑ÷£¡
        [201142] = "Snare",			-- ÌåÓÐÓàº®
        [195645] = "Snare",			-- Ë¤°í
        [182832] = "CC",		        -- Ê¯»¯
        [198405] = "CC",		        -- ´Ì¹Ç¼â½Ð
        [194140] = "CC",		        -- ÑÒÊ¯ÄýÊÓ
        [227981] = "CC",		        -- ÉÏ¹´È­
        [227977] = "CC",		        -- ìÅÄ¿µÆ¹â
        [228239] = "CC",		        -- ¿Ö¾åº¿½Ð
        [229705] = "Root",		        -- ÖëÍø
        [188818] = "Root",		        -- °µÓ°ÁÍîí
        [200329] = "CC",		        -- Ñ¹ÖÆÐÔ¿Ö¾å
        [170995] = "Snare",			-- ²Ð·ÏÊõ
        [219397] = "CC",		        -- ÐÛÓ¥Ìì½µ
        [111673] = "CC",		        -- ¿ØÖÆÍöÁé
        [199097] = "CC",		        -- ´ßÃßÖ®ÔÆ
        [197974] = "CC",		        -- Ëé¹Ç¹¥»÷
        [157997] = "Root",		        -- º®±ùÐÂÐÇ
        [205708] = "Snare",			-- ±ù¶³
        [228600] = "Root",		        -- ±ù´¨¼â´Ì
        [198121] = "Root",		        -- ±ùËªËºÒ§
        [189157] = "CC",		        -- ËÀÍöº¿½Ð
        [200261] = "CC",		        -- Ëé¹Ç´ò»÷
        [199042] = "Root",		        -- À×öª´ò»÷
        [202658] = "CC",		        -- ³éÈ¡
        [213491] = "CC",		        -- ¶ñÄ§¼ùÌ¤
        [216881] = "CC",		        -- ¿Ö¾åÃæÈÝ
        [223093] = "CC",		        -- ¹üÌåÖ®Íø
        [204437] = "CC",		        -- ÉÁµç´ÅËø
        [196942] = "CC",		        -- ÑýÊõ
        [210873] = "CC",		        -- ÑýÊõ
        [211004] = "CC",		        -- ÑýÊõ
        [211010] = "CC",		        -- ÑýÊõ
        [211015] = "CC",		        -- ÑýÊõ
        [202318] = "CC",		        -- ÑýÊõÆ£±¹
        [204042] = "CC",		        -- äÎÃð
        [198144] = "ImmuneSpell",		-- º®±ùÐÎÌ¬
        [200631] = "CC",		        -- ´êÖ¾¼â½Ð
        [232633] = "Silence",			-- °ÂÊõºéÁ÷
        [222783] = "Silence",			-- °ÂÊõºéÁ÷
        [225249] = "CC",		        -- »ÙÃð¼ùÌ¤
        [191743] = "Silence",			-- Õð¶ú¼âÐ¥
        [207979] = "CC",		        -- Õðµ´²¨
        [206580] = "CC",		        -- ¹²Ãù»Ó¿³
        [209404] = "Silence",			-- ·âÓ¡Ä§·¨
        [205097] = "CC",		        -- Ð°ÄÜÖÂÃ¤
        [223914] = "CC",		        -- ÆÆµ¨ÅØÏø
        [205341] = "CC",		        -- ÉøÂ©Ö®Îí
        [203110] = "CC",		        -- ÊÈË¯ÃÎ÷Ê
        [210315] = "Root",		        -- ÃÎ÷Ê¾£¼¬
        [219256] = "CC",		        -- °º¹óµÄÈÅÂÒ
        [199085] = "CC",		        -- Õ½Â·
        [198551] = "CC",		        -- ÆÆËé
        [219108] = "Silence",			-- ±»ÒÅÍüÕßµÄ¿ÞºÅ
        [227917] = "CC",		        -- ÈüÊ«´ó»á
        [217824] = "Silence",			-- ÃÀµÂÖ®¶Ü
        [194500] = "CC",		        -- »ÙÃð¼ùÌ¤
        [210749] = "CC",		        -- ¾²µç·ç±©
        [196591] = "CC",		        -- ËÀÍöÄýÊÓ
        [216044] = "CC",		        -- ÊÜÕÛÄ¥ÕßµÄ¿ÞºÅ
        [53148]  = "Root",		        -- ³å·æ
        [201158] = "Root",		        -- ½¹ÓÍ
        [162480] = "Root",		        -- ¾«¸ÖÏÝÚå
        [198304] = "Snare",			-- À¹½Ø
        [236027] = "Snare",			-- ³å·æ
        [228837] = "CC",		        -- µÍºð
        [198758] = "Root",		        -- À¹½Ø
        [67890]  = "CC",		        -- ¹¤³ÌÕ¨µ¯
        [220128] = "Root",		        -- ±ùËªÐÂÐÇ
        [229926] = "CC",		        -- ¾øÍûÖ®Â·
        [229108] = "CC",		        -- ³å·æ
        [229152] = "Root",		        -- ×øÏÂ
        [22915]  = "CC",		        -- Ç¿»¯Õðµ´Éä»÷
        [133362] = "CC",		        -- ÃÎ»Ã±äÐÎÊõ
        [133308] = "Root",		        -- Í¶Íø
        [134795] = "CC",		        -- ÃÔã¯¼âÐ¥
        [129888] = "Silence",			-- ÈÕ¹âÊõ
        [135621] = "CC",		        -- ¾²µç³äÄÜ
        [206762] = "CC",		        -- ¿Ö¾å¼â½Ð
        [204483] = "CC",		        -- ¾Û½¹³å»÷
        [219293] = "CC",		        -- ¿Ö¾åÅØÏø

                ----------------
		-- Death Knight Ghoul
		----------------

		[91800]  = "CC",			-- Gnaw
		[91797]  = "CC",			-- Monstrous Blow (Dark Transformation)
                [196907] = "CC",			-- Cyclone
		[91807]  = "Root",			-- Shambling Rush (Dark Transformation)
	
	----------------
	-- Druid
	----------------

	[33786]  = "CC",			-- Cyclone
	[99]     = "CC",			-- Incapacitating Roar
	[163505] = "CC",       	 	-- Rake
	[22570]  = "CC",			-- Maim
	[5211]   = "CC",			-- Mighty Bash
	[81261]  = "Silence",		-- Solar Beam
	[339]    = "Root",			-- Entangling Roots
	[45334]  = "Root",			-- Immobilized (Wild Charge - Bear)
	[102359] = "Root",			-- Mass Entanglement
	[50259]  = "Snare",			-- Dazed (Wild Charge - Cat)
	[58180]  = "Snare",			-- Infected Wounds
	[61391]  = "Snare",			-- Typhoon
	[127797] = "Snare",			-- Ursol's Vortex

	----------------
	-- Hunter
	----------------

	[117526] = "CC",			-- Binding Shot
	[3355]   = "CC",			-- Freezing Trap
	[13809]  = "Snare",			-- Ice Trap 1
	[19386]  = "CC",			-- Wyvern Sting
	[128405] = "Root",			-- Narrow Escape
	[5116]   = "Snare",			-- Concussive Shot
	[13810]  = "Snare",			-- Ice Trap 2
	[19263]  = "Immune",		-- Deterrence
	[186265]  = "Immune",		-- Deterrence

	----------------
	-- Hunter Pets
	----------------
		[24394]  = "CC",		-- Intimidation
		[50433]  = "Snare",		-- Ankle Crack (Crocolisk)
		[54644]  = "Snare",		-- Frost Breath (Chimaera)
		[54216]  = "Other",		-- Master's Call (root and snare immune only)

	----------------
	-- Mage
	----------------

	[31661]  = "CC",			-- Dragon's Breath
	[118]    = "CC",			-- Polymorph
	[61305]  = "CC",			-- Polymorph: Black Cat
	[28272]  = "CC",			-- Polymorph: Pig
	[61721]  = "CC",			-- Polymorph: Rabbit
	[61780]  = "CC",			-- Polymorph: Turkey
        [126819] = "CC",			-- Polymorph: Turkey
        [161353] = "CC",			-- Polymorph: Turkey
        [161354] = "CC",			-- Polymorph: Turkey
        [161355] = "CC",			-- Polymorph: Turkey
        [161372] = "CC",			-- Polymorph: Turkey
        [197105] = "CC",			-- Polymorph: Turkey
	[28271]  = "CC",			-- Polymorph: Turtle
	[82691]  = "CC",			-- Ring of Frost
	[140376] = "CC",			-- Ring of Frost
	[122]    = "Root",			-- Frost Nova
	[120]    = "Snare",			-- Cone of Cold
	[116]    = "Snare",			-- Frostbolt
	[44614]  = "Snare",			-- Frostfire Bolt
	[31589]  = "Snare",			-- Slow
	[45438]  = "Immune",		-- Ice Block
	[66309]  = "CC",			-- Ice Nova
	[110959] = "Other",			-- Greater Invisibility

		----------------
		-- Mage Water Elemental
		----------------
		[33395]  = "Root",		-- Freeze


	----------------
	-- Monk
	----------------

	[120086] = "CC",			-- Fists of Fury
	[119381] = "CC",			-- Leg Sweep
	[115078] = "CC",			-- Paralysis
	[116706] = "Root",			-- Disable
	[116095] = "Snare",			-- Disable
	[123586] = "Snare",			-- Flying Serpent Kick


	----------------
	-- Paladin
	----------------

	[105421] = "CC",			-- Blinding Light
	[853]    = "CC",			-- Hammer of Justice
	[20066]  = "CC",			-- Repentance
	[31935]  = "Silence",		-- Avenger's Shield
	[642]    = "Immune",		-- Divine Shield
	[31821]  = "Other",			-- Aura Mastery
	[1022]   = "Other",			-- Hand of Protection
          

	----------------
	-- Priest
	----------------

	[605]    = "CC",			-- Dominate Mind
	[88625]  = "CC",			-- Holy Word: Chastise
	[64044]  = "CC",			-- Psychic Horror
	[8122]   = "CC",			-- Psychic Scream
	[9484]   = "CC",			-- Shackle Undead
	[87204]  = "CC",			-- Sin and Punishment
	[15487]  = "Silence",		-- Silence
	[114404] = "Root",			-- Void Tendril's Grasp
	[15407]  = "Snare",			-- Mind Flay
	[47585]  = "ImmuneSpell",		-- Dispersion
	[114239] = "ImmuneSpell",	-- Phantasm
	[586] 	 = "Other",			-- Fade (Aura mastery when glyphed, dunno which id is right)

	----------------
	-- Rogue
	----------------

	[2094]   = "CC",			-- Blind
	[1833]   = "CC",			-- Cheap Shot
	[1776]   = "CC",			-- Gouge
	[408]    = "CC",			-- Kidney Shot
	[6770]   = "CC",			-- Sap
	[1330]   = "Silence",		-- Garrote - Silence
	[3409]   = "Snare",			-- Crippling Poison
	[26679]  = "Snare",			-- Deadly Throw
	[31224]  = "ImmuneSpell",	-- Cloak of Shadows
	[45182]  = "Other",			-- Cheating Death
	[5277]   = "Other",			-- Evasion
	[76577]  = "Other",			-- Smoke Bomb
	[88611]  = "Other",			-- Smoke Bomb
        [212182] = "Other",			-- Smoke Bomb
        [212183] = "Other",			-- Smoke Bomb

	----------------
	-- Shaman
	----------------

	[77505]  = "CC",			-- Earthquake
	[51514]  = "CC",			-- Hex
	[118905] = "CC",			-- Static Charge (Capacitor Totem)
	[64695]  = "Root",			-- Earthgrab (Earthgrab Totem)
	[3600]   = "Snare",			-- Earthbind (Earthbind Totem)
	[116947] = "Snare",			-- Earthbind (Earthgrab Totem)
	[77478]  = "Snare",			-- Earthquake (Glyph of Unstable Earth)
	[51490]  = "Snare",			-- Thunderstorm
	[8178]   = "ImmuneSpell",	-- Grounding Totem Effect (Grounding Totem)
	
		----------------
		-- Shaman Primal Earth Elemental
		----------------
		[118345] = "CC",		-- Pulverize

	----------------
	-- Warlock
	----------------

	[710]    = "CC",			-- Banish
	[5782]   = "CC",			-- Fear
	[118699] = "CC",			-- Fear
	[130616] = "CC",			-- Fear (Glyph of Fear)
	[5484]   = "CC",			-- Howl of Terror
	[22703]  = "CC",			-- Infernal Awakening
	[6789]   = "CC",			-- Mortal Coil
	[30283]  = "CC",			-- Shadowfury
	[31117]  = "Silence",		-- Unstable Affliction
	[104773] = "Other",			-- Unending Resolve

		----------------
		-- Warlock Pets
		----------------
		[89766]  = "CC",		-- Axe Toss (Felguard/Wrathguard)
		[115268] = "CC",		-- Mesmerize (Shivarra)
		[6358]   = "CC",		-- Seduction (Succubus)


	----------------
	-- Warrior
	----------------
	[5246]   = "CC",			-- Intimidating Shout (aoe)
	[132168] = "CC",			-- Shockwave
	[107570] = "CC",			-- Storm Bolt
	[132169] = "CC",			-- Storm Bolt
	[105771] = "Root",			-- Warbringer
	[1715]   = "Snare",			-- Hamstring
	[12323]  = "Snare",			-- Piercing Howl
	[46924]  = "Immune",		-- Bladestorm
        [227847] = "Immune",		-- Bladestorm
	[23920]  = "ImmuneSpell",	-- Spell Reflection
	[18499]  = "Other",			-- Berserker Rage

	----------------
	-- Other
	----------------

	[30217]  = "CC",		-- Adamantite Grenade
	[67769]  = "CC",		-- Cobalt Frag Bomb
	[30216]  = "CC",		-- Fel Iron Bomb
	[107079] = "CC",		-- Quaking Palm
	[13327]  = "CC",		-- Reckless Charge
	[20549]  = "CC",		-- War Stomp
        [47788]  = "Other",	        -- ÊØ»¤Ö®»ê
        [218826] = "Other",	        -- Õ½¶·¿¼Ñé
        [116888] = "Other",	        -- Á¶Óü
        [198111] = "Other",		-- Ê±¹â»¤¶Ü
        [196555] = "Immune",		-- Ðé¿Õ
        [25046]  = "Silence",		-- Arcane Torrent (Energy)
	[28730]  = "Silence",		-- Arcane Torrent (Mana)
	[50613]  = "Silence",		-- Arcane Torrent (Runic Power)
	[69179]  = "Silence",		-- Arcane Torrent (Rage)
	[80483]  = "Silence",		-- Arcane Torrent (Focus)
	[129597] = "Silence",		-- Arcane Torrent (Chi)
	[39965]  = "Root",		-- Frost Grenade
	[55536]  = "Root",		-- Frostweave Net
	[13099]  = "Root",		-- Net-o-Matic
	[1604]   = "Snare",		-- Dazed
	-- PvE
	--[123456] = "PvE",		-- This is just an example, not a real spell
}

local orderedSpellIds = {}
local orders = {"CC", "Silence", "Root", "Snare", "Immune", "ImmuneSpell", "Other"}
for oi,ov in pairs(orders) do
    for k,v in pairs(spellIds) do
		if v == ov then
			local spell = {spellID = k, spellType = v}
			table.insert(orderedSpellIds, spell)
			spellIds[k] = nil
		end
	end
end

local focus_position = {"BOTTOMLEFT", "oUF_SimpleFocus", "TOPLEFT", -2, 2}	
local target_position = {"BOTTOMLEFT", "oUF_SimpleTarget", "TOPLEFT", -2, 100}
local target_buff_position = {"TOPLEFT", UIParent, "CENTER", 200, -4}

local targetCC = {
	Name = "LoseControl_Target",
	Direction = "RIGHT", Interval = 0,
	Mode = "ICON", IconSize = 44,
	Position = {unpack(target_position)},
}
local focusCC =  {
	Name = "LoseControl_Focus",
	Direction = "RIGHT", Interval = 0,
	Mode = "ICON", IconSize = 40,
	Position = {unpack(focus_position)},
}
local targetBuff =  {
	Name = "LoseControl_Buff",
	Direction = "RIGHT", Interval = 2,
	Mode = "ICON", IconSize = 42,
	Position = {unpack(target_buff_position)},
}

for i,spell in pairs(orderedSpellIds) do
	local ID = spell.spellID
	local Type = spell.spellType
	if Type == "CC" or Type == "Root" or Type == "Silence" or Type == "Snare" then
		local targetV = {spellID =  ID, unitID = "target", caster = "all", filter = "DEBUFF"}
		local focusV = {spellID =  ID, unitID = "focus", caster = "all", filter = "DEBUFF"}
		table.insert(targetCC, targetV)
		table.insert(focusCC, focusV)
	else
		local buffV = {spellID =  ID, unitID = "target", caster = "all", filter = "BUFF"}
		table.insert(targetBuff, buffV)
	end
end

local AllSpells = Filger_Spells["ALL"] or {}
table.insert(AllSpells, targetCC)
table.insert(AllSpells, focusCC)
table.insert(AllSpells, targetBuff)
