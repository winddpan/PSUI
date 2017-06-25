local mod = _G.WQA

mod.QuestDB = {
  Eligible = {
    [45795] = true,     -- Presence of Power, Azsuna invasion
    [44789] = true,     -- Holding the Ramparts, Val'Sharah invasion
    [45572] = true,     -- Holding Our Ground, Highmountain invasion
    [45406] = true,     -- The Storm's Fury, Stormheim invasion
  },
  Blacklist = {
    -- Broken Shore
    [45379] = true,     -- Treasure Master Iks'reeged
    [46825] = true,     -- Mud Mucking
    [46308] = true,     -- Leave A Trail

    -- Kirin Tor Quests
    [45032] = true,     -- Like The Wind, Suramar
    [45049] = true,     -- Like The Wind, Stormheim
    [45046] = true,     -- Like The Wind, Azsuna
    [45047] = true,     -- Like The Wind, Val'sharah
    [45048] = true,     -- Like The Wind, Highmountain

    [43328] = true,     -- Enigmatic, Azsuna
    [43756] = true,     -- Enigmatic, Val'sharah
    [43767] = true,     -- Enigmatic, Highmountain
    [43778] = true,     -- Enigmatic, Suramar
    [43772] = true,     -- Enigmatic, Stormheim

    [43325] = true,     -- Ley Race, Azsuna
    [43753] = true,     -- Ley Race, Val'sharah
    [43764] = true,     -- Ley Race, Highmountain
    [43774] = true,     -- Ley Race, Suramar
    [43769] = true,     -- Ley Race, Stormheim

    [43327] = true,     -- The Magic Of Flight, Azsuna
    [43755] = true,     -- The Magic Of Flight, Val'sharah
    [43766] = true,     -- The Magic Of Flight, Highmountain
    [43777] = true,     -- The Magic Of Flight, Suramar
    [43771] = true,     -- The Magic Of Flight, Stormheim

    [45069] = true,     -- Barrels 'o Fun, Azsuna
    [45070] = true,     -- Barrels 'o Fun, Val'sharah
    [45071] = true,     -- Barrels 'o Fun, Highmountain
    [45068] = true,     -- Barrels 'o Fun, Suramar
    [45072] = true,     -- Barrels 'o Fun, Stormheim

    -- Other
    [43943] = true,     -- Withered Army Training
    [42880] = true,     -- Meeting Their Quota
    [44891] = true,     -- 2v2 Weekly Quest
    [44908] = true,     -- 3v3 Weekly Quest
    [44909] = true,     -- RBG Weekly
    [42969] = true,     -- A spy in our midst - not really something that can be groupable, and it often overlaps with other quests
  },
  Raid = {   -- Generated with tools/import.rb
    --[[
    -- While technically raid-compatible, it seems like overkill to form raids for these. Gonna just leave them as 5-mans for now.
    [44017] = true,     -- WANTED: Apothecary Faldren
    [42636] = true,     -- WANTED: Arcanist Shal'iman
    [42620] = true,     -- WANTED: Arcavellus
    [41824] = true,     -- WANTED: Arru
    [44301] = true,     -- WANTED: Bahagar
    [41836] = true,     -- WANTED: Bodash the Hoarder
    [41828] = true,     -- WANTED: Bristlemaul
    [43426] = true,     -- WANTED: Brogozog
    [42796] = true,     -- WANTED: Broodmother Shu'malis
    [44016] = true,     -- WANTED: Cadraeus
    [43430] = true,     -- WANTED: Captain Volo'ren
    [41826] = true,     -- WANTED: Crawshuk the Hungry
    [44299] = true,     -- WANTED: Darkshade
    [43455] = true,     -- WANTED: Devouring Darkness
    [43428] = true,     -- WANTED: Doomlord Kazrok
    [44298] = true,     -- WANTED: Dreadbog
    [43454] = true,     -- WANTED: Egyl the Enduring
    [43434] = true,     -- WANTED: Fathnyr
    [43436] = true,     -- WANTED: Glimar Ironfist
    [44013] = true,     -- WANTED: Guardian Thor'el
    [41819] = true,     -- WANTED: Gurbog da Basher
    [43453] = true,     -- WANTED: Hannval the Butcher
    [44021] = true,     -- WANTED: Hertha Grimdottir
    [43427] = true,     -- WANTED: Infernal Lord
    [42631] = true,     -- WANTED: Inquisitor Tivos
    [43452] = true,     -- WANTED: Isel the Hammer
    [43460] = true,     -- WANTED: Kiranys Duskwhisper
    [44019] = true,     -- WANTED: Lieutenant Strathmar
    [44018] = true,     -- WANTED: Magister Phaedris
    [41818] = true,     -- WANTED: Majestic Elderhorn
    [44015] = true,     -- WANTED: Mal'Dreth the Corruptor
    [43438] = true,     -- WANTED: Nameless King
    [43432] = true,     -- WANTED: Normantis the Deposed
    [44010] = true,     -- WANTED: Oreth the Vile
    [43458] = true,     -- WANTED: Perrexx
    [42795] = true,     -- WANTED: Sanaar
    [44300] = true,     -- WANTED: Seersei
    [41844] = true,     -- WANTED: Sekhan
    [44022] = true,     -- WANTED: Shal'an
    [41821] = true,     -- WANTED: Shara Felbreath
    [44012] = true,     -- WANTED: Siegemaster Aedrin
    [43456] = true,     -- WANTED: Skul'vrax
    [41838] = true,     -- WANTED: Slumber
    [43429] = true,     -- WANTED: Syphonus
    [43437] = true,     -- WANTED: Thane Irglov
    [43457] = true,     -- WANTED: Theryssia
    [43459] = true,     -- WANTED: Thondrax
    [43450] = true,     -- WANTED: Tiptog the Lost
    [43451] = true,     -- WANTED: Urgev the Flayer
    [42633] = true,     -- WANTED: Vorthax
    [43431] = true,     -- WANTED: Warbringer Mox'na
    ]]
    [44113] = true,     -- DANGER: Achronos
    [42820] = true,     -- DANGER: Aegir Wavecrusher
    [41685] = true,     -- DANGER: Ala'washte
    [43344] = true,     -- DANGER: Aodh Witherpetal
    [43091] = true,     -- DANGER: Arcanor Prime
    [44118] = true,     -- DANGER: Auditor Esiel
    [44121] = true,     -- DANGER: Az'jatar
    [44189] = true,     -- DANGER: Bestrix
    [42861] = true,     -- DANGER: Boulderfall, the Eroded
    [42864] = true,     -- DANGER: Captain Dargun
    [43121] = true,     -- DANGER: Chief Treasurer Jabrill
    [44187] = true,     -- DANGER: Cinderwing
    [41697] = true,     -- DANGER: Colerian, Alteria, and Selenyi
    [43175] = true,     -- DANGER: Deepclaw
    [41695] = true,     -- DANGER: Defilia
    [42785] = true,     -- DANGER: Den Mother Ylva
    [41093] = true,     -- DANGER: Durguth
    [43346] = true,     -- DANGER: Ealdis
    [43059] = true,     -- DANGER: Fjordun
    [42806] = true,     -- DANGER: Fjorlag, the Grave's Chill
    [43345] = true,     -- DANGER: Harbinger of Screams
    [42798] = true,     -- DANGER: Huntress Estrid
    [43079] = true,     -- DANGER: Immolian
    [44190] = true,     -- DANGER: Jade Darkhaven
    [44191] = true,     -- DANGER: Karthax
    [42870] = true,     -- DANGER: Kathaw the Savage
    [43798] = true,     -- DANGER: Kosumoth the Hungering
    [42964] = true,     -- DANGER: Lagertha
    [44192] = true,     -- DANGER: Lysanis Shadesoul
    [43152] = true,     -- DANGER: Lytheron
    [44114] = true,     -- DANGER: Magistrix Vilessa
    [42927] = true,     -- DANGER: Malisandra
    [43098] = true,     -- DANGER: Marblub the Massive
    [41696] = true,     -- DANGER: Mawat'aki
    [43027] = true,     -- DANGER: Mortiferous
    [43333] = true,     -- DANGER: Nylaathria the Forgotten
    [42799] = true,     -- DANGER: Oglok the Furious
    [41686] = true,     -- DANGER: Olokk the Shipbreaker
    [41703] = true,     -- DANGER: Ormagrogg
    [41816] = true,     -- DANGER: Oubdob da Smasher
    [43347] = true,     -- DANGER: Rabxach
    [42963] = true,     -- DANGER: Rulf Bonesnapper
    [42991] = true,     -- DANGER: Runeseer Sigvid
    [42797] = true,     -- DANGER: Scythemaster Cil'raman
    [44193] = true,     -- DANGER: Sea King Tidross
    [41700] = true,     -- DANGER: Shalas'aman
    [44122] = true,     -- DANGER: Sorallus
    [42953] = true,     -- DANGER: Soulbinder Halldora
    [43063] = true,     -- DANGER: Stormfeather
    [43072] = true,     -- DANGER: The Whisperer
    [44194] = true,     -- DANGER: Torrentius
    [43040] = true,     -- DANGER: Valakar the Thirsty
    [44119] = true,     -- DANGER: Volshax, Breaker of Will
    [43101] = true,     -- DANGER: Witchdoctor Grgl-Brgl
  }
}
