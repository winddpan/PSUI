
--------------------------------------------------------------------------------
-- TransmogCleanup by Elvador
--

local folder, ns = ...

function TransmogCleanup:getDefaultIgnoredItems()
	return {
		-- List from http://www.wowhead.com/item=65274/cloak-of-coordination#comments
		[6948] = true, --Hearthstone
		[17690] = true, --Frostwolf Insignia Rank 1
		[17691] = true, --Stormpike Insignia Rank 1
		[17900] = true, --Stormpike Insignia Rank 2
		[17901] = true, --Stormpike Insignia Rank 3
		[17902] = true, --Stormpike Insignia Rank 4
		[17903] = true, --Stormpike Insignia Rank 5
		[17904] = true, --Stormpike Insignia Rank 6
		[17905] = true, --Frostwolf Insignia Rank 2
		[17906] = true, --Frostwolf Insignia Rank 3
		[17907] = true, --Frostwolf Insignia Rank 4
		[17908] = true, --Frostwolf Insignia Rank 5
		[17909] = true, --Frostwolf Insignia Rank 6
		[18984] = true, --Dimensional Ripper - Everlook
		[18986] = true, --Ultrasafe Transporter: Gadgetzan
		[22631] = true, --Atiesh, Greatstaff of the Guardian
		[28585] = true, --Ruby Slippers
		[30542] = true, --Dimensional Ripper - Area 52
		[30544] = true, --Ultrasafe Transporter: Toshley's Station
		[32757] = true, --Blessed Medallion of Karabor
		[37118] = true, --Scroll of Recall
		[37863] = true, --Direbrew's Remote
		[40585] = true, --Signet of the Kirin Tor
		[44314] = true, --Scroll of Recall II
		[44315] = true, --Scroll of Recall III
		[45691] = true, --Inscribed Signet of the Kirin Tor
		[46874] = true, --Argent Crusader's Tabard
		[48933] = true, --Wormhole Generator: Northrend
		[48957] = true, --Etched Signet of the Kirin Tor
		[50287] = true, --Boots of the Bay
		[51557] = true, --Runed Signet of the Kirin Tor
		[52251] = true, --Jaina's Locket
		[54452] = true, --Ethereal Portal
		[58487] = true, --Potion of Deepholm
		[63206] = true, --Wrap of Unity
		[63207] = true, --Wrap of Unity
		[63352] = true, --Shroud of Cooperation
		[63353] = true, --Shroud of Cooperation
		[63378] = true, --Hellscream's Reach Tabard
		[63379] = true, --Baradin's Wardens Tabard
		[64457] = true, --The Last Relic of Argus
		[64488] = true, --The Innkeeper's Daughter
		[65274] = true, --Cloak of Coordination
		[65360] = true, --Cloak of Coordination
		[87215] = true, --Wormhole Generator: Pandaria
		[93672] = true, --Dark Portal
		[95050] = true, --The Brassiest Knuckle
		[95051] = true, --The Brassiest Knuckle
		[103678] = true, --Time-Lost Artifact

		[52252] = true, -- Tabard of the Lightbringer

		[9149] = true, -- Philosopher's Stone
		[13503] = true, -- Alchemist Stone
		[31080] = true, -- Mercurial Stone
		[35748] = true, -- Guardian's Alchemist Stone
		[35749] = true, -- Sorcerer's Alchemist Stone
		[35750] = true, -- Redeemer's Alchemist Stone
		[35751] = true, -- Assassin's Alchemist Stone
		[44322] = true, -- Mercurial Alchemist Stone
		[44323] = true, -- Indestructible Alchemist Stone
		[44324] = true, -- Mighty Alchemist Stone
		[58483] = true, -- Lifebound Alchemist Stone
		[68775] = true, -- Volatile Alchemist Stone
		[68776] = true, -- Quicksilver Alchemist Stone
		[68777] = true, -- Vibrant Alchemist Stone
		[75274] = true, -- Zen Alchemist Stone
		[109262] = true, -- Draenic Philosopher's Stone
		[122601] = true, -- Stone of Wind
		[122602] = true, -- Stone of the Earth
		[122603] = true, -- Stone of the Waters
		[122604] = true, -- Stone of Fire
		[127842] = true, -- Infernal Alchemist Stone
		[128023] = true, -- Stone of the Wilds
		[128024] = true, -- Stone of the Elements
	}
end
