local addonName, privateTable = ...
-- translators wanted :(
if (GetLocale() == "itIT")  then
privateTable.L = setmetatable({
	["reset"]="Le impostazioni sono state resettate",
	["usage1"]="'on'/'off' per abilitare o disabilitare l'addon",
	["usage2"]="'all'/'list' per gestire qualsiasi missione o solo quelle specificate in una lista",
	["usage3"]="'loot' non completare le missioni con una lista di ricompense o completarle scegliendo la più costosa tra le ricompense",
	["enabled"]="abilitato",
	["disabled"]="disabilitato",
	["all"]="pronto a gestire ogni missione",
	["list"]="solo le missioni giornaliere verranno gestite",
	["dontlootfalse"]="scegli la ricompensa più costosa",
	["dontloottrue"]="non completare le missioni con ricompense",
	["resetbutton"]="resetta",

	["questTypeLabel"] = "missioni da gestire",
	["questTypeAll"] = "Tutte",
	["questTypeList"] = "giornaliere",
	["questTypeExceptDaily"] = "escuso le giornaliere",
	["TrivialQuests"]="accetta le missioni 'grigie'",
	["ShareQuestsLabel"] = "condivisione automatica delle missioni",
	["CompleteOnly"] = "completa solamente",

	["lootTypeLabel"]="missioni con ricompensa",
	["lootTypeFalse"]="non consegnare",
	["lootTypeGreed"]="scegli la ricompensa più costosa",
	["lootTypeNeed"]="scegli la ricompensa da parametri",

	["tournamentLabel"]="Torneo d'argento",
	["tournamentWrit"]="Decreto del Campione", -- 46114
	["tournamentPurse"]="Borsellino del Campione", -- 45724

	["DarkmoonTeleLabel"]="Lunacupa: teletrasportarsi al cannone",
	["ToDarkmoonLabel"]="Lunacupa: teletrasportarsi a isola",
	["DarkmoonFaireTeleport"]="Teletrasportologo Fozlebub",
	["DarkmoonAutoLabel"]="Lunacupa: avviare il gioco!",
	["Darkmoon Island"]="Isola di Lunacupa",
	["Darkmoon Faire Mystic Mage"]="Maga Mistica di Lunacupa",
	
	["The Jade Forest"]="Foresta di Giada",
	["Scared Pandaren Cub"]="Cucciolo Pandaren Spaventato",
	
	["rewardtext"]="print quest competition text",
	["questlevel"]="mostra il livello della missione",
	["watchlevel"]="show watched quest level",
	["autoequip"]="indossa ricompensa ricevuta",
	["togglekey"]="tasto di abilitazione/disablilitazione",
	
	['Gioielli']="Gioielli",
	["rewardlootoptions"]="Condizioni di selezione ricompensa",
	['greedifnothing']='Greed if nothing found',
	["multiplefound"]="Multiple reward candidates found. "..ERR_QUEST_MUST_CHOOSE,
	["nosuitablefound"]="No suitable reward found. "..ERR_QUEST_MUST_CHOOSE,
	["gogreedy"]="No suitable reward found, choosing the highest value one.",
	["rewardlag"]=BUTTON_LAG_LOOT_TOOLTIP.. '. '..ERR_QUEST_MUST_CHOOSE,
	["stopitemfound"]="There is %s in rewards. Choose and equip an item yourself.",
	["relictoggle"]="Disabilitare selezione direliquia ricompensa.",
	["artifactpowertoggle"]="Disabilitare selezione di Potere Artefatto ricompensa.",
	["ivechosen"]="I have chosen first option for you.",
	},
	{__index = function(table, index) return index end})
	
privateTable.L.quests = {
-- Steamwheedle Cartel
['Making Amends']={item="Runecloth", amount=40, currency=false},
['War at Sea']={item="Mageweave Cloth", amount=40, currency=false},
['Traitor to the Bloodsail']={item="Silk Cloth", amount=40, currency=false},
['Mending Old Wounds']={item="Linen Cloth", amount=40, currency=false},
-- AV both fractions
['Empty Stables']={donotaccept=true},
-- Alliance AV Quests
['Crystal Cluster']={donotaccept=true},
['Ivus the Forest Lord']={donotaccept=true},
["Call of Air - Ichman's Fleet"]={donotaccept=true},
["Call of Air - Slidore's Fleet"]={donotaccept=true},
["Call of Air - Vipore's Fleet"]={donotaccept=true},
['Armor Scraps']={donotaccept=true},
['More Armor Scraps']={donotaccept=true},
['Ram Riding Harnesses']={donotaccept=true},
-- Horde AV Quests
['A Gallon of Blood']={donotaccept=true},
['Lokholar the Ice Lord']={donotaccept=true},
["Call of Air - Guse's Fleet"]={donotaccept=true},
["Call of Air - Jeztor's Fleet"]={donotaccept=true},
["Call of Air - Mulverick's Fleet"]={donotaccept=true},
['Enemy Booty']={donotaccept=true},
['More Booty!']={donotaccept=true},
['Ram Hide Harnesses']={donotaccept=true},
-- Timbermaw Quests
['Feathers for Grazle']={item="Deadwood Headdress Feather", amount=5, currency=false},
['Feathers for Nafien']={item="Deadwood Headdress Feather", amount=5, currency=false},
['More Beads for Salfa']={item="Winterfall Spirit Beads", amount=5, currency=false},
-- Cenarion
['Encrypted Twilight Texts']={item="Encrypted Twilight Text", amount=10, currency=false},
['Still Believing']={item="Encrypted Twilight Text", amount=10, currency=false},
-- Thorium Brotherhood
['Favor Amongst the Brotherhood, Blood of the Mountain']={item="Blood of the Mountain", amount=1, currency=false},
['Favor Amongst the Brotherhood, Core Leather']={item="Core Leather", amount=2, currency=false},
['Favor Amongst the Brotherhood, Dark Iron Ore']={item="Dark Iron Ore", amount=10, currency=false},
['Favor Amongst the Brotherhood, Fiery Core']={item="Fiery Core", amount=1, currency=false},
['Favor Amongst the Brotherhood, Lava Core']={item="Lava Core", amount=1, currency=false},
['Gaining Acceptance']={item="Dark Iron Residue", amount=4, currency=false},
['Gaining Even More Acceptance']={item="Dark Iron Residue", amount=100, currency=false},

-- Fiona's Caravan
["Argus' Journal"]={donotaccept=true},
["Beezil's Cog"]={donotaccept=true},
["Fiona's Lucky Charm"]={donotaccept=true},
["Gidwin's Weapon Oil"]={donotaccept=true},
["Pamela's Doll"]={donotaccept=true},
["Rimblat's Stone"]={donotaccept=true},
["Tarenar's Talisman"]={donotaccept=true},
["Vex'tul's Armbands"]={donotaccept=true},

--[[Burning Crusade]]--
--Lower City
["More Feathers"]={item="Arakkoa Feather", amount=30, currency=false},
--Aldor
["More Marks of Kil'jaeden"]={item="Mark of Kil'jaeden", amount=10, currency=false},
["More Marks of Sargeras"]={item="Mark of Sargeras", amount=10, currency=false},
["Fel Armaments"]={item="Fel Armaments", amount=10, currency=false},
["Single Mark of Kil'jaeden"]={item="Mark of Kil'jaeden", amount=1, currency=false},
["Single Mark of Sargeras"]={item="Mark of Sargeras", amount=1, currency=false},
["More Venom Sacs"]={item="Dreadfang Venom Sac", amount=8, currency=false},
--Scryer
["More Firewing Signets"]={item="Firewing Signet", amount=10, currency=false},
["More Sunfury Signets"]={item="Sunfury Signet", amount=10, currency=false},
["Arcane Tomes"]={item="Arcane Tome", amount=1, currency=false},
["Single Firewing Signet"]={item="Firewing Signet", amount=1, currency=false},
["Single Sunfury Signet"]={item="Sunfury Signet", amount=1, currency=false},
["More Basilisk Eyes"]={item="Dampscale Basilisk Eye", amount=8, currency=false},
--Skettis
["More Shadow Dust"]={item="Shadow Dust", amount=6, currency=false},
--SporeGar
["Bring Me Another Shrubbery!"]={item="Sanguine Hibiscus", amount=5, currency=false},
["More Fertile Spores"]={item="Fertile Spores", amount=6, currency=false},
["More Glowcaps"]={item="Glowcap", amount=10, currency=false},
["More Spore Sacs"]={item="Mature Spore Sac", amount=10, currency=false},
["More Tendrils!"]={item="Bog Lord Tendril", amount=6, currency=false},
-- Halaa
["Oshu'gun Crystal Powder"]={item="Oshu'gun Crystal Powder Sample", amount=10, currency=false},

["Hodir's Tribute"]={item="Relic of Ulduar", amount=10, currency=false},
["Remember Everfrost!"]={item="Everfrost Chip", amount=1, currency=false},
["Additional Armaments"]={item=416, amount=125, currency=true},
["Calling the Ancients"]={item=416, amount=125, currency=true},
["Filling the Moonwell"]={item=416, amount=125, currency=true},
["Into the Fire"]={donotaccept=true},
["The Forlorn Spire"]={donotaccept=true},
["Fun for the Little Ones"] = {item=393, amount=15, currency=true},
--MoP
["Seeds of Fear"]={item="Dread Amber Shards", amount=5, currency=false},
["A Dish for Jogu"]={item="Sauteed Carrots", amount=5, currency=false},

["A Dish for Ella"]={item="Shrimp Dumplings", amount=5, currency=false},
["Valley Stir Fry"]={item="Valley Stir Fry", amount=5, currency=false},
["A Dish for Farmer Fung"]={item="Wildfowl Roast", amount=5, currency=false},
["A Dish for Fish"]={item="Twin Fish Platter", amount=5, currency=false},
["Swirling Mist Soup"]={item="Swirling Mist Soup", amount=5, currency=false},
["A Dish for Haohan"]={item="Charbroiled Tiger Steak", amount=5, currency=false},
["A Dish for Old Hillpaw"]={item="Braised Turtle", amount=5, currency=false},
["A Dish for Sho"]={item="Eternal Blossom Fish", amount=5, currency=false},
["A Dish for Tina"]={item="Fire Spirit Salmon", amount=5, currency=false},
["Replenishing the Pantry"]={item="Bundle of Groceries", amount=1, currency=false},
--MOP timeless Island
['Great Turtle Meat']={item="Great Turtle Meat", amount=1, currency=false},
['Heavy Yak Flank']={item="Heavy Yak Flank", amount=1, currency=false},
['Meaty Crane Leg']={item="Meaty Crane Leg", amount=1, currency=false},
['Pristine Firestorm Egg']={item="Pristine Firestorm Egg", amount=1, currency=false},
['Thick Tiger Haunch']={item="Thick Tiger Haunch", amount=1, currency=false},

}

privateTable.L.ignoreList = {
--MOP Tillers
["A Marsh Lily for"]="",
["A Lovely Apple for"]="",
["A Jade Cat for"]="",
["A Blue Feather for"]="",
["A Ruby Shard for"]="",
["Supplies Needed: Starlight Roses"]="",
["Città della luce"]="",
}
end
