-- not used
local me=MAJOR_VERSION .. MINOR_VERSION
do
	local L=l:NewLocale(me,"enUS",true,true)
L["%1$d%% lower than %2$d%%. Lower %s"] = true
L["%s for a wowhead link popup"] = true
L["%s start the mission without even opening the mission page. No question asked"] = true
L["%s starts missions"] = true
L["%s to blacklist"] = true
L["%s to remove from blacklist"] = true
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = true
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = true
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = true
L["Always counter increased resource cost"] = true
L["Always counter increased time"] = true
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = true
L["Always counter no bonus loot threat"] = true
L["Artifact shown value is the base value without considering knowledge multiplier"] = true
L["Attempting %s"] = true
L["Base Chance"] = true
L["Better parties available in next future"] = true
L["Blacklisted"] = true
L["Blacklisted missions are ignored in Mission Control"] = true
L["Bonus Chance"] = true
L["Building Final report"] = true
L["but using troops with just one durability left"] = true
L["Capped %1$s. Spend at least %2$d of them"] = true
L["Changes the sort order of missions in Mission panel"] = true
L["Combat ally is proposed for missions so you can consider unassigning him"] = true
L["Complete all missions without confirmation"] = true
L["Configuration for mission party builder"] = true
L["Cost reduced"] = true
L["Could not fulfill mission, aborting"] = true
L["Counter kill Troops"] = true
L["Customization options (non mission related)"] = true
L["Disables warning: "] = true
L["Dont use this slot"] = true
L["Don't use troops"] = true
L["Duration reduced"] = true
L["Duration Time"] = true
L["Elites mission mode"] = true
L["Empty missions sorted as last"] = true
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = true
L["Equipped by following champions:"] = true
L["Expiration Time"] = true
L["Favours leveling follower for xp missions"] = true
L["General"] = true
L["Global approx. xp reward"] = true
L["Global approx. xp reward per hour"] = true
L["HallComander Quick Mission Completion"] = true
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = true
L["If not checked, inactive followers are used as last chance"] = true
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = true
L["Ignore busy followers"] = true
L["Ignore inactive followers"] = true
L["Keep cost low"] = true
L["Keep extra bonus"] = true
L["Keep time short"] = true
L["Keep time VERY short"] = true
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = true
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = true
L["Level"] = true
L["Lock all"] = true
L["Lock this follower"] = true
L["Locked follower are only used in this mission"] = true
L["Make Order Hall Mission Panel movable"] = true
L["Makes sure that no troops will be killed"] = true
L["Max champions"] = true
L["Maximize xp gain"] = true
L["Mission duration reduced"] = true
L["Mission was capped due to total chance less than"] = true
L["Missions"] = true
L["Never kill Troops"] = true
L["No follower gained xp"] = true
L["No suitable missions. Have you reserved at least one follower?"] = true
L["Not blacklisted"] = true
L["Nothing to report"] = true
L["Notifies you when you have troops ready to be collected"] = true
L["Only accept missions with time improved"] = true
L["Only consider elite missions"] = true
L["Only use champions even if troops are available"] = true
L["Open configuration"] = true
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = true
L["Original method"] = true
L["Position is not saved on logout"] = true
L["Prefer high durability"] = true
L["Quick start first mission"] = true
L["Remove no champions warning"] = true
L["Restart tutorial from beginning"] = true
L["Resume tutorial"] = true
L["Resurrect troops effect"] = true
L["Reward type"] = true
L["Sets all switches to a very permissive setup"] = true
L["Show tutorial"] = true
L["Show/hide OrderHallCommander mission menu"] = true
L["Sort missions by:"] = true
L["Started with "] = true
L["Success Chance"] = true
L["Troop ready alert"] = true
L["Unable to fill missions, raise \"%s\""] = true
L["Unable to fill missions. Check your switches"] = true
L["Unable to start mission, aborting"] = true
L["Unlock all"] = true
L["Unlock this follower"] = true
L["Unlocks all follower and slots at once"] = true
L["Upgrading to |cff00ff00%d|r"] = true
L["URL Copy"] = true
L["Use at most this many champions"] = true
L["Use combat ally"] = true
L["Use this slot"] = true
L["Uses troops with the highest durability instead of the ones with the lowest"] = true
L["When no free followers are available shows empty follower"] = true
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = true
L["Would start with "] = true
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = true
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = true
L["You now need to press both %s and %s to start mission"] = true

-- Tutorial
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = true
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = true
L["Base Chance"] = true
L["Bonus Chance"] = true
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = true
L["Counter Kill Troops"] = true
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = true
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = true
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = true
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = true
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = true
L["Max champions"] = true
L["Maximize xp gain"] = true
L["Never kill Troops"] = true
L["Prefer high durability"] = true
L["Restart the tutorial"] = true
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = true
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = true
L["Thank you for reading this, enjoy %s"] = true
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = true
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = true
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = true
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = true
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = true
L["You can choose not to use a troop type clicking its icon"] = true
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = true

	L=l:NewLocale(me,"ptBR")
	if (L) then
--Translation missing 
-- L["%1$d%% lower than %2$d%%. Lower %s"] = ""
--Translation missing 
-- L["%s for a wowhead link popup"] = ""
--Translation missing 
-- L["%s start the mission without even opening the mission page. No question asked"] = ""
--Translation missing 
-- L["%s starts missions"] = ""
--Translation missing 
-- L["%s to blacklist"] = ""
--Translation missing 
-- L["%s to remove from blacklist"] = ""
--Translation missing 
-- L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = ""
--Translation missing 
-- L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = ""
--Translation missing 
-- L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = ""
L["Always counter increased resource cost"] = "Sempre contra o aumento do custo de recursos"
L["Always counter increased time"] = "Sempre contra o aumento do tempo"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Sempre counter kill tropas (ignorado se podemos apenas usar tropas com apenas 1 durabilidade \195\160 esquerda)"
--Translation missing 
-- L["Always counter no bonus loot threat"] = ""
--Translation missing 
-- L["Artifact shown value is the base value without considering knowledge multiplier"] = ""
--Translation missing 
-- L["Attempting %s"] = ""
--Translation missing 
-- L["Base Chance"] = ""
L["Better parties available in next future"] = "Festas melhores dispon\195\173veis no pr\195\179ximo futuro"
--Translation missing 
-- L["Blacklisted"] = ""
--Translation missing 
-- L["Blacklisted missions are ignored in Mission Control"] = ""
--Translation missing 
-- L["Bonus Chance"] = ""
L["Building Final report"] = "Relat\195\179rio final do edif\195\173cio"
--Translation missing 
-- L["but using troops with just one durability left"] = ""
L["Capped %1$s. Spend at least %2$d of them"] = "Capped% 1 $ s. Gaste pelo menos% 2 $ d deles"
L["Changes the sort order of missions in Mission panel"] = "Altera a ordem de classifica\195\167\195\163o das miss\195\181es no painel da Miss\195\163o"
--Translation missing 
-- L["Combat ally is proposed for missions so you can consider unassigning him"] = ""
L["Complete all missions without confirmation"] = "Complete todas as miss\195\181es sem confirma\195\167\195\163o"
L["Configuration for mission party builder"] = "Configura\195\167\195\163o para o construtor de parte da miss\195\163o"
--Translation missing 
-- L["Cost reduced"] = ""
--Translation missing 
-- L["Could not fulfill mission, aborting"] = ""
--Translation missing 
-- L["Counter kill Troops"] = ""
--Translation missing 
-- L["Customization options (non mission related)"] = ""
--Translation missing 
-- L["Disables warning: "] = ""
--Translation missing 
-- L["Dont use this slot"] = ""
--Translation missing 
-- L["Don't use troops"] = ""
L["Duration reduced"] = "Dura\195\167\195\163o reduzida"
L["Duration Time"] = "Tempo de dura\195\167\195\163o"
--Translation missing 
-- L["Elites mission mode"] = ""
--Translation missing 
-- L["Empty missions sorted as last"] = ""
--Translation missing 
-- L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = ""
--Translation missing 
-- L["Equipped by following champions:"] = ""
L["Expiration Time"] = "Data de validade"
L["Favours leveling follower for xp missions"] = "Favors leveling follower para miss\195\181es xp"
L["General"] = "Geral"
L["Global approx. xp reward"] = "Global aprox. Recompensa xp"
--Translation missing 
-- L["Global approx. xp reward per hour"] = ""
L["HallComander Quick Mission Completion"] = "Conclus\195\163o R\195\161pida da Miss\195\163o HallComander"
--Translation missing 
-- L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = ""
--Translation missing 
-- L["If not checked, inactive followers are used as last chance"] = ""
--Translation missing 
-- L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = ""
--Translation missing 
-- L["Ignore busy followers"] = ""
--Translation missing 
-- L["Ignore inactive followers"] = ""
L["Keep cost low"] = "Mantenha o custo baixo"
--Translation missing 
-- L["Keep extra bonus"] = ""
L["Keep time short"] = "Mantenha o tempo curto"
L["Keep time VERY short"] = "Mantenha o tempo MUITO curto"
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
L["Level"] = "N\195\173vel"
--Translation missing 
-- L["Lock all"] = ""
--Translation missing 
-- L["Lock this follower"] = ""
--Translation missing 
-- L["Locked follower are only used in this mission"] = ""
L["Make Order Hall Mission Panel movable"] = "Fa\195\167a a encomenda Hall Miss\195\163o Painel m\195\179vel"
--Translation missing 
-- L["Makes sure that no troops will be killed"] = ""
--Translation missing 
-- L["Max champions"] = ""
L["Maximize xp gain"] = "Maximize o ganho de xp"
--Translation missing 
-- L["Mission duration reduced"] = ""
--Translation missing 
-- L["Mission was capped due to total chance less than"] = ""
L["Missions"] = "Miss\195\181es"
--Translation missing 
-- L["Never kill Troops"] = ""
L["No follower gained xp"] = "Nenhum seguidor ganhou xp"
--Translation missing 
-- L["No suitable missions. Have you reserved at least one follower?"] = ""
--Translation missing 
-- L["Not blacklisted"] = ""
L["Nothing to report"] = "Nada a declarar"
L["Notifies you when you have troops ready to be collected"] = "Notifica voc\195\170 quando voc\195\170 tem tropas prontas para serem coletadas"
L["Only accept missions with time improved"] = "Aceitar apenas miss\195\181es com o tempo melhorado"
--Translation missing 
-- L["Only consider elite missions"] = ""
--Translation missing 
-- L["Only use champions even if troops are available"] = ""
--Translation missing 
-- L["Open configuration"] = ""
--Translation missing 
-- L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = ""
L["Original method"] = "M\195\169todo original"
L["Position is not saved on logout"] = "A posi\195\167\195\163o n\195\163o \195\169 salva no logout"
--Translation missing 
-- L["Prefer high durability"] = ""
--Translation missing 
-- L["Quick start first mission"] = ""
--Translation missing 
-- L["Remove no champions warning"] = ""
--Translation missing 
-- L["Restart tutorial from beginning"] = ""
--Translation missing 
-- L["Resume tutorial"] = ""
L["Resurrect troops effect"] = "Resurrect efeito tropas"
L["Reward type"] = "Tipo de recompensa"
--Translation missing 
-- L["Sets all switches to a very permissive setup"] = ""
--Translation missing 
-- L["Show tutorial"] = ""
L["Show/hide OrderHallCommander mission menu"] = "Mostrar / ocultar o menu da miss\195\163o OrderHallCommander"
L["Sort missions by:"] = "Classifique miss\195\181es por:"
--Translation missing 
-- L["Started with "] = ""
L["Success Chance"] = "Chance de sucesso"
L["Troop ready alert"] = "Alerta de tropas"
--Translation missing 
-- L["Unable to fill missions, raise \"%s\""] = ""
--Translation missing 
-- L["Unable to fill missions. Check your switches"] = ""
--Translation missing 
-- L["Unable to start mission, aborting"] = ""
--Translation missing 
-- L["Unlock all"] = ""
--Translation missing 
-- L["Unlock this follower"] = ""
--Translation missing 
-- L["Unlocks all follower and slots at once"] = ""
L["Upgrading to |cff00ff00%d|r"] = "Atualizando para | cff00ff00% d | r"
--Translation missing 
-- L["URL Copy"] = ""
--Translation missing 
-- L["Use at most this many champions"] = ""
--Translation missing 
-- L["Use combat ally"] = ""
--Translation missing 
-- L["Use this slot"] = ""
--Translation missing 
-- L["Uses troops with the highest durability instead of the ones with the lowest"] = ""
--Translation missing 
-- L["When no free followers are available shows empty follower"] = ""
--Translation missing 
-- L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = ""
--Translation missing 
-- L["Would start with "] = ""
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Voc\195\170 est\195\161 desperdi\195\167ando | cffff0000% d | cffffd200 point (s) !!!"
--Translation missing 
-- L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = ""
--Translation missing 
-- L["You now need to press both %s and %s to start mission"] = ""

-- Tutorial
--Translation missing 
-- L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = ""
--Translation missing 
-- L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = ""
--Translation missing 
-- L["Base Chance"] = ""
--Translation missing 
-- L["Bonus Chance"] = ""
--Translation missing 
-- L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = ""
--Translation missing 
-- L["Counter Kill Troops"] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = ""
--Translation missing 
-- L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = ""
--Translation missing 
-- L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = ""
--Translation missing 
-- L["Max champions"] = ""
--Translation missing 
-- L["Maximize xp gain"] = ""
--Translation missing 
-- L["Never kill Troops"] = ""
--Translation missing 
-- L["Prefer high durability"] = ""
--Translation missing 
-- L["Restart the tutorial"] = ""
--Translation missing 
-- L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = ""
--Translation missing 
-- L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = ""
--Translation missing 
-- L["Thank you for reading this, enjoy %s"] = ""
--Translation missing 
-- L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = ""
--Translation missing 
-- L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = ""
--Translation missing 
-- L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = ""
--Translation missing 
-- L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = ""
--Translation missing 
-- L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = ""
--Translation missing 
-- L["You can choose not to use a troop type clicking its icon"] = ""
--Translation missing 
-- L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = ""

	end
	L=l:NewLocale(me,"frFR")
	if (L) then
--Translation missing 
-- L["%1$d%% lower than %2$d%%. Lower %s"] = ""
--Translation missing 
-- L["%s for a wowhead link popup"] = ""
--Translation missing 
-- L["%s start the mission without even opening the mission page. No question asked"] = ""
--Translation missing 
-- L["%s starts missions"] = ""
--Translation missing 
-- L["%s to blacklist"] = ""
--Translation missing 
-- L["%s to remove from blacklist"] = ""
--Translation missing 
-- L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = ""
--Translation missing 
-- L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = ""
--Translation missing 
-- L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = ""
L["Always counter increased resource cost"] = "Toujours contrer les co\195\187ts accrus des ressources"
L["Always counter increased time"] = "Toujours contrer le temps accru"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Toujours \195\169viter de tuer les troupes (ignor\195\169 s'il ne reste qu'un seul point de vitalit\195\169 aux troupes disponibles)"
L["Always counter no bonus loot threat"] = "Toujours contrer les malus au butin bonus"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Le montant de puissance prodigieuse affich\195\169e est la valeur de base, sans prendre en consid\195\169ration le niveau de connaissance de l'arme prodigieuse"
--Translation missing 
-- L["Attempting %s"] = ""
--Translation missing 
-- L["Base Chance"] = ""
L["Better parties available in next future"] = "De meilleurs groupes seront disponibles plus tard"
--Translation missing 
-- L["Blacklisted"] = ""
--Translation missing 
-- L["Blacklisted missions are ignored in Mission Control"] = ""
--Translation missing 
-- L["Bonus Chance"] = ""
L["Building Final report"] = "Rapport final du b\195\162timent"
--Translation missing 
-- L["but using troops with just one durability left"] = ""
L["Capped %1$s. Spend at least %2$d of them"] = "Plafonn\195\169% 1 $ s. D\195\169penser au moins% 2 $ d d'entre eux"
L["Changes the sort order of missions in Mission panel"] = "Modifie l'ordre de tri des missions dans le panneau Mission"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "Le combattant alli\195\169 est pris en compte pour le retirer et l'envoyer en mission"
L["Complete all missions without confirmation"] = "Terminer toutes les missions sans confirmation"
L["Configuration for mission party builder"] = "Configuration pour le constructeur de mission"
L["Cost reduced"] = "Co\195\187t r\195\169duit"
--Translation missing 
-- L["Could not fulfill mission, aborting"] = ""
--Translation missing 
-- L["Counter kill Troops"] = ""
--Translation missing 
-- L["Customization options (non mission related)"] = ""
--Translation missing 
-- L["Disables warning: "] = ""
--Translation missing 
-- L["Dont use this slot"] = ""
L["Don't use troops"] = "Ne pas utiliser les troupes"
L["Duration reduced"] = "Dur\195\169e r\195\169duite"
L["Duration Time"] = "Dur\195\169e"
--Translation missing 
-- L["Elites mission mode"] = ""
--Translation missing 
-- L["Empty missions sorted as last"] = ""
--Translation missing 
-- L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = ""
--Translation missing 
-- L["Equipped by following champions:"] = ""
L["Expiration Time"] = "Date d'expiration"
L["Favours leveling follower for xp missions"] = "Favoriser les champions \195\160 entra\195\174ner pour les missions rapportant de l'exp\195\169rience"
L["General"] = "G\195\169n\195\169ral"
L["Global approx. xp reward"] = "Global env. Xp r\195\169compense"
--Translation missing 
-- L["Global approx. xp reward per hour"] = ""
L["HallComander Quick Mission Completion"] = "Ach\195\168vement rapide de mission HallComander"
--Translation missing 
-- L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = ""
L["If not checked, inactive followers are used as last chance"] = "Si non coch\195\169, les sujets d\195\169sactiv\195\169 seront utilis\195\169 en dernier recours"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[Si vous %s, vous allez les perdre.
Cliquez sur %s pour annuler.]=]
L["Ignore busy followers"] = "Ignorer les sujets occup\195\169s"
L["Ignore inactive followers"] = "Ignore les sujets d\195\169sactiv\195\169s"
L["Keep cost low"] = "Garder le co\195\187t bas"
L["Keep extra bonus"] = "Garder le butin bonus"
L["Keep time short"] = "Garde le temps court"
L["Keep time VERY short"] = "Gardez le temps tr\195\168s court"
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
L["Level"] = "Niveau"
--Translation missing 
-- L["Lock all"] = ""
--Translation missing 
-- L["Lock this follower"] = ""
--Translation missing 
-- L["Locked follower are only used in this mission"] = ""
L["Make Order Hall Mission Panel movable"] = "Panneau de missions de domaine d\195\169pla\195\167able"
--Translation missing 
-- L["Makes sure that no troops will be killed"] = ""
L["Max champions"] = "Champions max"
L["Maximize xp gain"] = "Maximiser le gain d'xp"
L["Mission duration reduced"] = "Dur\195\169e de la mission r\195\169duite"
--Translation missing 
-- L["Mission was capped due to total chance less than"] = ""
L["Missions"] = true
--Translation missing 
-- L["Never kill Troops"] = ""
L["No follower gained xp"] = "Aucun sujet n'a gagn\195\169 d'xp"
--Translation missing 
-- L["No suitable missions. Have you reserved at least one follower?"] = ""
--Translation missing 
-- L["Not blacklisted"] = ""
L["Nothing to report"] = "Rien \195\160 signaler"
L["Notifies you when you have troops ready to be collected"] = "Vous avertit lorsque vous avez des troupes pr\195\170tes \195\160 \195\170tre r\195\169cup\195\169r\195\169es"
L["Only accept missions with time improved"] = "N'acceptez que les missions avec le temps am\195\169lior\195\169"
--Translation missing 
-- L["Only consider elite missions"] = ""
L["Only use champions even if troops are available"] = "Utiliser uniquement des champions m\195\170me si des troupes sont disponibles"
--Translation missing 
-- L["Open configuration"] = ""
--Translation missing 
-- L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = ""
L["Original method"] = "M\195\169thode originale"
L["Position is not saved on logout"] = "La position n'est pas enregistr\195\169e lors de la d\195\169connexion"
--Translation missing 
-- L["Prefer high durability"] = ""
--Translation missing 
-- L["Quick start first mission"] = ""
--Translation missing 
-- L["Remove no champions warning"] = ""
--Translation missing 
-- L["Restart tutorial from beginning"] = ""
--Translation missing 
-- L["Resume tutorial"] = ""
L["Resurrect troops effect"] = "Effet R\195\169surrection des troupes"
L["Reward type"] = "Type de r\195\169compense"
--Translation missing 
-- L["Sets all switches to a very permissive setup"] = ""
--Translation missing 
-- L["Show tutorial"] = ""
L["Show/hide OrderHallCommander mission menu"] = "Afficher / masquer le menu de mission OrderHallCommander"
L["Sort missions by:"] = "Trier les missions par:"
--Translation missing 
-- L["Started with "] = ""
L["Success Chance"] = "Chance de succ\195\168s"
L["Troop ready alert"] = "Alerte troupes pr\195\170tes"
--Translation missing 
-- L["Unable to fill missions, raise \"%s\""] = ""
L["Unable to fill missions. Check your switches"] = "Impossible de remplir les missions. V\195\169rifiez les param\195\168tres."
--Translation missing 
-- L["Unable to start mission, aborting"] = ""
--Translation missing 
-- L["Unlock all"] = ""
--Translation missing 
-- L["Unlock this follower"] = ""
--Translation missing 
-- L["Unlocks all follower and slots at once"] = ""
L["Upgrading to |cff00ff00%d|r"] = "Mise \195\160 niveau vers |cff00ff00%d|r"
--Translation missing 
-- L["URL Copy"] = ""
L["Use at most this many champions"] = "Utilis\195\169 au maximum ce nombre de champions"
L["Use combat ally"] = "Utiliser le combattant alli\195\169"
--Translation missing 
-- L["Use this slot"] = ""
--Translation missing 
-- L["Uses troops with the highest durability instead of the ones with the lowest"] = ""
L["When no free followers are available shows empty follower"] = "Quand aucun sujet n'est disponible afficher un sujet vide"
--Translation missing 
-- L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = ""
--Translation missing 
-- L["Would start with "] = ""
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Vous perdez |cffff0000%d|cffffd200 point (s) !!!"
--Translation missing 
-- L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = ""
--Translation missing 
-- L["You now need to press both %s and %s to start mission"] = ""

-- Tutorial
--Translation missing 
-- L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = ""
--Translation missing 
-- L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = ""
--Translation missing 
-- L["Base Chance"] = ""
--Translation missing 
-- L["Bonus Chance"] = ""
--Translation missing 
-- L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = ""
--Translation missing 
-- L["Counter Kill Troops"] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = ""
--Translation missing 
-- L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = ""
--Translation missing 
-- L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = ""
--Translation missing 
-- L["Max champions"] = ""
--Translation missing 
-- L["Maximize xp gain"] = ""
--Translation missing 
-- L["Never kill Troops"] = ""
--Translation missing 
-- L["Prefer high durability"] = ""
--Translation missing 
-- L["Restart the tutorial"] = ""
--Translation missing 
-- L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = ""
--Translation missing 
-- L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = ""
--Translation missing 
-- L["Thank you for reading this, enjoy %s"] = ""
--Translation missing 
-- L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = ""
--Translation missing 
-- L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = ""
--Translation missing 
-- L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = ""
--Translation missing 
-- L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = ""
--Translation missing 
-- L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = ""
--Translation missing 
-- L["You can choose not to use a troop type clicking its icon"] = ""
--Translation missing 
-- L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = ""

	end
	L=l:NewLocale(me,"deDE")
	if (L) then
--Translation missing 
-- L["%1$d%% lower than %2$d%%. Lower %s"] = ""
--Translation missing 
-- L["%s for a wowhead link popup"] = ""
--Translation missing 
-- L["%s start the mission without even opening the mission page. No question asked"] = ""
--Translation missing 
-- L["%s starts missions"] = ""
--Translation missing 
-- L["%s to blacklist"] = ""
--Translation missing 
-- L["%s to remove from blacklist"] = ""
--Translation missing 
-- L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = ""
--Translation missing 
-- L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = ""
--Translation missing 
-- L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = ""
L["Always counter increased resource cost"] = "Immer erh\195\182hte Ressourcenkosten kontern"
L["Always counter increased time"] = "Immer erh\195\182hte Missionsdauer kontern"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "T\195\182ten der Trupps immer kontern (dies wird ignoriert, falls nur Truppen mit 1 Haltbarkeit benutzt werden k\195\182nnen)"
L["Always counter no bonus loot threat"] = "Kontert immer Bedrohungen, die Bonusbeute verhindern"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Der angezeigte Wert ist der Grundwert ohne die Ber\195\188cksichtigung von Artefakwissen."
--Translation missing 
-- L["Attempting %s"] = ""
L["Base Chance"] = "Basis-Chance"
L["Better parties available in next future"] = "Bessere Gruppen sind in absehbarer Zeit verf\195\188gbar"
--Translation missing 
-- L["Blacklisted"] = ""
--Translation missing 
-- L["Blacklisted missions are ignored in Mission Control"] = ""
L["Bonus Chance"] = "Bonus-Chance"
L["Building Final report"] = "Erstelle Abschlussbericht"
--Translation missing 
-- L["but using troops with just one durability left"] = ""
L["Capped %1$s. Spend at least %2$d of them"] = "Maximal %1$ s. Gib mindestens %2$d davon aus"
L["Changes the sort order of missions in Mission panel"] = "Ver\195\164ndert die Sortierreihenfolge der Missionen in der Missions\195\188bersicht"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "Der Kampfgef\195\164hrte wird f\195\188r Missionen vorgeschlagen, du kannst dann entscheiden, ob du ihn abziehen m\195\182chtest"
L["Complete all missions without confirmation"] = "Alle Missionen ohne Best\195\164tigung abschlie\195\159en"
L["Configuration for mission party builder"] = "Konfiguration des Gruppenerstellers f\195\188r Missionen"
L["Cost reduced"] = "Kosten reduziert"
--Translation missing 
-- L["Could not fulfill mission, aborting"] = ""
L["Counter kill Troops"] = "Kontere T\195\182dlich"
--Translation missing 
-- L["Customization options (non mission related)"] = ""
L["Disables warning: "] = "Deaktiviert Warnung:"
--Translation missing 
-- L["Dont use this slot"] = ""
L["Don't use troops"] = "Keine Truppen verwenden"
L["Duration reduced"] = "Dauer reduziert"
L["Duration Time"] = "Dauer"
--Translation missing 
-- L["Elites mission mode"] = ""
--Translation missing 
-- L["Empty missions sorted as last"] = ""
--Translation missing 
-- L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = ""
--Translation missing 
-- L["Equipped by following champions:"] = ""
L["Expiration Time"] = "Ablaufzeit"
L["Favours leveling follower for xp missions"] = "Bevorzugt niedrigstufige Anh\195\164nger f\195\188r EP-Missionen"
L["General"] = "Allgemein"
L["Global approx. xp reward"] = "EP-Belohnung gesamt"
L["Global approx. xp reward per hour"] = "EP-Belohnung pro Stunde"
L["HallComander Quick Mission Completion"] = "HallComander Schneller Missionsabschluss"
--Translation missing 
-- L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = ""
L["If not checked, inactive followers are used as last chance"] = "Wenn nicht ausgew\195\164hlt, werden inaktive Anh\195\164nger als letzte M\195\182glichkeit verwendet"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[Wenn du %s, wirst du sie verlieren.
Klicke auf %s, um abzubrechen]=]
L["Ignore busy followers"] = "Besch\195\164ftigte Anh\195\164nger ignorieren"
L["Ignore inactive followers"] = "Unt\195\164tige Anh\195\164nger ignorieren"
L["Keep cost low"] = "Kosten niedrig halten"
L["Keep extra bonus"] = "Bonusbeute behalten"
L["Keep time short"] = "Zeit kurz halten"
L["Keep time VERY short"] = "Zeit SEHR kurz halten"
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
L["Level"] = "Stufe"
--Translation missing 
-- L["Lock all"] = ""
--Translation missing 
-- L["Lock this follower"] = ""
--Translation missing 
-- L["Locked follower are only used in this mission"] = ""
L["Make Order Hall Mission Panel movable"] = "Ordenshallen-Missionsfenster beweglich machen"
--Translation missing 
-- L["Makes sure that no troops will be killed"] = ""
L["Max champions"] = "Max. Anh\195\164nger"
L["Maximize xp gain"] = "Erfahrungszunahme maximieren"
L["Mission duration reduced"] = "Missionsdauer reduziert"
--Translation missing 
-- L["Mission was capped due to total chance less than"] = ""
L["Missions"] = "Missionen"
L["Never kill Troops"] = "T\195\182te nie Truppen"
L["No follower gained xp"] = "Kein Anh\195\164nger erhielt EP"
--Translation missing 
-- L["No suitable missions. Have you reserved at least one follower?"] = ""
--Translation missing 
-- L["Not blacklisted"] = ""
L["Nothing to report"] = "Nichts zu berichten"
L["Notifies you when you have troops ready to be collected"] = "Benachrichtigt, wenn Truppen bereit sind, gesammelt zu werden"
L["Only accept missions with time improved"] = "Nur Missionen mit verk\195\188rzter Dauer annehmen"
--Translation missing 
-- L["Only consider elite missions"] = ""
L["Only use champions even if troops are available"] = "Verwende nur Anh\195\164nger, auch wenn Trupps vorhanden sind"
--Translation missing 
-- L["Open configuration"] = ""
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander \195\188berschreibt GarrisonCommaner f\195\188r Mission in der Ordenshalle.
Du kannst OrderhallCommander einfach deaktvieren um wieder OrderhallCommander zu verwenden.
Wenn du OrderhallCommander allerdings gut findest, vergiss nicht es in deinem Curse Client hinzuzuf\195\188gen und aktuell zu halten.]=]
L["Original method"] = "Standard"
L["Position is not saved on logout"] = "Die Position wird beim Ausloggen nicht gespeichert"
L["Prefer high durability"] = "Bevorzuge hohe Haltbarkeit"
--Translation missing 
-- L["Quick start first mission"] = ""
--Translation missing 
-- L["Remove no champions warning"] = ""
--Translation missing 
-- L["Restart tutorial from beginning"] = ""
--Translation missing 
-- L["Resume tutorial"] = ""
L["Resurrect troops effect"] = "Truppen wiederbeleben"
L["Reward type"] = "Belohnungsart"
--Translation missing 
-- L["Sets all switches to a very permissive setup"] = ""
L["Show tutorial"] = "Zeige Tutorial"
L["Show/hide OrderHallCommander mission menu"] = "OrderHallCommander-Missionsmen\195\188 zeigen/ausblenden"
L["Sort missions by:"] = "Sortieren nach:"
L["Started with "] = "Startet mit"
L["Success Chance"] = "Erfolgschance"
L["Troop ready alert"] = "Warnung Trupp bereit"
--Translation missing 
-- L["Unable to fill missions, raise \"%s\""] = ""
L["Unable to fill missions. Check your switches"] = "Mit den aktuellen Einstellungen kann keine Mission besetzt werden"
--Translation missing 
-- L["Unable to start mission, aborting"] = ""
--Translation missing 
-- L["Unlock all"] = ""
--Translation missing 
-- L["Unlock this follower"] = ""
--Translation missing 
-- L["Unlocks all follower and slots at once"] = ""
L["Upgrading to |cff00ff00%d|r"] = "Erh\195\182he Stufe auf |cff00ff00%d|r"
L["URL Copy"] = "URL kopieren"
L["Use at most this many champions"] = "Verwende maximal so viele Anh\195\164nger pro Mission"
L["Use combat ally"] = "Kampfgef\195\164hrten verwenden"
--Translation missing 
-- L["Use this slot"] = ""
--Translation missing 
-- L["Uses troops with the highest durability instead of the ones with the lowest"] = ""
--Translation missing 
-- L["When no free followers are available shows empty follower"] = ""
--Translation missing 
-- L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = ""
--Translation missing 
-- L["Would start with "] = ""
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Du verschwendst |cffff0000%d |cffffd200|4Punkt:Punkte;!"
--Translation missing 
-- L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = ""
--Translation missing 
-- L["You now need to press both %s and %s to start mission"] = ""

-- Tutorial
--Translation missing 
-- L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = ""
--Translation missing 
-- L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = ""
L["Base Chance"] = "Basis-Chance"
L["Bonus Chance"] = "Bonus-Chance"
--Translation missing 
-- L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = ""
L["Counter Kill Troops"] = "Kontere T\195\182dlich"
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = ""
--Translation missing 
-- L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = ""
--Translation missing 
-- L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = ""
--Translation missing 
-- L["Max champions"] = ""
--Translation missing 
-- L["Maximize xp gain"] = ""
L["Never kill Troops"] = "T\195\182te nie Truppen"
L["Prefer high durability"] = "Bevorzuge hohe Haltbarkeit"
L["Restart the tutorial"] = "Startet das Tutorial neu"
--Translation missing 
-- L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = ""
--Translation missing 
-- L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = ""
--Translation missing 
-- L["Thank you for reading this, enjoy %s"] = ""
--Translation missing 
-- L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = ""
--Translation missing 
-- L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = ""
--Translation missing 
-- L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = ""
--Translation missing 
-- L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = ""
--Translation missing 
-- L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = ""
--Translation missing 
-- L["You can choose not to use a troop type clicking its icon"] = ""
--Translation missing 
-- L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = ""

	end
	L=l:NewLocale(me,"itIT")
	if (L) then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%% \195\168 inferiore a %2$d%%. Abbassa %s"
--Translation missing 
-- L["%s for a wowhead link popup"] = ""
--Translation missing 
-- L["%s start the mission without even opening the mission page. No question asked"] = ""
--Translation missing 
-- L["%s starts missions"] = ""
L["%s to blacklist"] = "Clicca col destro per mettere in blacklist"
L["%s to remove from blacklist"] = "Clicca col destro per rimuovere dalla blacklist"
--Translation missing 
-- L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = ""
--Translation missing 
-- L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = ""
--Translation missing 
-- L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = ""
L["Always counter increased resource cost"] = "Contrasta sempre incremento risorse"
L["Always counter increased time"] = "Contrasta sempre incremento durata"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Contrasta sempre morte milizie (ignorato tutte le milizie hanno solo una vita rimanente)"
L["Always counter no bonus loot threat"] = "Contrasta sempre il \"no bonus\""
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Il valore mostrato \195\168 quello base, senza considerare il moltiplicatore dalla conoscenza"
L["Attempting %s"] = "Provo %s"
L["Base Chance"] = "Percentuale base"
L["Better parties available in next future"] = "Ci sono combinazioni migliori nel futuro"
L["Blacklisted"] = "In blacklist"
L["Blacklisted missions are ignored in Mission Control"] = "Le missioni in blacklist vengono ignorate negli automatismi"
L["Bonus Chance"] = "Percentuale globale"
L["Building Final report"] = "Sto preparando il rapporto finale"
L["but using troops with just one durability left"] = "ma uso truppe con solo un punto vita rimasto"
L["Capped %1$s. Spend at least %2$d of them"] = "%1$s ha un limite. Spendine almeno %2%d"
L["Changes the sort order of missions in Mission panel"] = "Cambia l'ordine delle mission nel Pannello Missioni"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "Viene proposto l'alleato, per poter valutare se rimuoverlo dalla missione di scorta"
L["Complete all missions without confirmation"] = "Completa tutte le missioni senza chiedere conferma"
L["Configuration for mission party builder"] = "Configurazioni per il generatore di gruppi"
L["Cost reduced"] = "Costo ridotto"
L["Could not fulfill mission, aborting"] = "Non riesco a completare il party per la missione, rinuncio"
L["Counter kill Troops"] = "Contrasta \"Uccide le truppe\""
--Translation missing 
-- L["Customization options (non mission related)"] = ""
L["Disables warning: "] = "Disabilita l'avviso:"
L["Dont use this slot"] = "Non usare questo slot"
L["Don't use troops"] = "Non usare truppe"
L["Duration reduced"] = "Durata ridotta"
L["Duration Time"] = "Durata"
L["Elites mission mode"] = "Modalit\195\160 missioni \"elite\""
L["Empty missions sorted as last"] = "Le missioni senza campioni vengono ordinate come ultime"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "Le missioni senza campioni o con lo 0% o meno di possibilit\195\160 di successo vengono ordinate come ultime. Non si applica all'ordinamento originale Blizzard"
L["Equipped by following champions:"] = "Usato da questi campioni:"
L["Expiration Time"] = "Scadenza"
L["Favours leveling follower for xp missions"] = "Preferisci i campioni che devono livellare"
L["General"] = "Generale"
L["Global approx. xp reward"] = "Approssimativi PE globali"
L["Global approx. xp reward per hour"] = "Approssimativi PE globali per ora"
L["HallComander Quick Mission Completion"] = "OrderHallCommander Completamento rapido"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "Se %1$s \195\168 inferiore a questa, allora cerchiamo di raggiungere almeno %2$s senza superare il 100%%. Viene ignorato nelle missioni elite."
L["If not checked, inactive followers are used as last chance"] = "Se non attivo, visualizzer\195\160 seguaci inattivi pur di riempire la missione"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = "Se %s le perderai. Clicca su %s per interrompere"
L["Ignore busy followers"] = "Ignora i seguaci occupati"
L["Ignore inactive followers"] = "Ignora i seguaci inattivi"
L["Keep cost low"] = "Mantieni il costo basso"
L["Keep extra bonus"] = "Ottieni il bonus aggiuntivo"
L["Keep time short"] = "Riduci la durata"
L["Keep time VERY short"] = "Riduci MOLTO la durata"
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = "Avvia la prima missione con almeno un seguage riservato. Tieni premuto shift per avviare la missione, un semplice click si limita a scrivere in chat cosa verrebbe fatto"
L["Level"] = "Livello"
L["Lock all"] = "Riserva tutti"
L["Lock this follower"] = "Riserva questo seguace"
L["Locked follower are only used in this mission"] = "I seguaci riservati saranno usati solo in questa missione"
L["Make Order Hall Mission Panel movable"] = "Rendi spostabile il pannello missioni"
L["Makes sure that no troops will be killed"] = "Si accerta che nessuna truppa venga uccisa"
L["Max champions"] = "Campioni massimi"
L["Maximize xp gain"] = "Massimizza il guadagno di PE"
L["Mission duration reduced"] = "Durata missione ridotta"
L["Mission was capped due to total chance less than"] = "La percentuale di success \195\168 stata ridotta perch\195\169 era comunque inferiore a"
L["Missions"] = "Missioni"
L["Never kill Troops"] = "Non uccidere mai le truppe"
L["No follower gained xp"] = "Nessun campione ha guaagnato PE"
L["No suitable missions. Have you reserved at least one follower?"] = "Nessuna missione valida. Hai riservato almeno un seguace?"
L["Not blacklisted"] = "Non blacklistata"
L["Nothing to report"] = "Niente da segnalare"
L["Notifies you when you have troops ready to be collected"] = "Notificami quando ho truppe pronte per essere raccolte"
L["Only accept missions with time improved"] = "Accetta solo missioni con bonus durata ridotta"
L["Only consider elite missions"] = "Visualizza solo missioni elite"
L["Only use champions even if troops are available"] = "Usa solo campioni anche se ci sono truppe disponibili"
--Translation missing 
-- L["Open configuration"] = ""
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander sostituisce l'interfaccia di GarrisonComamnder per le missioni di classe
Disabilitalo se preferisci GarrisonCommander.
Se invece ti piace, aggiungilo al client Curse e tienilo aggiornato]=]
L["Original method"] = "Metodo originale"
L["Position is not saved on logout"] = "La posizione non \195\168 salvata alla disconnessione"
L["Prefer high durability"] = "Alta durabilit\195\160 preferita"
L["Quick start first mission"] = "Avvio rapido prima missione"
L["Remove no champions warning"] = "Rimuovi avviso campioni insufficienti"
--Translation missing 
-- L["Restart tutorial from beginning"] = ""
--Translation missing 
-- L["Resume tutorial"] = ""
L["Resurrect troops effect"] = "Resurrezione truppe possibile"
L["Reward type"] = "Tipo ricompensa"
--Translation missing 
-- L["Sets all switches to a very permissive setup"] = ""
--Translation missing 
-- L["Show tutorial"] = ""
L["Show/hide OrderHallCommander mission menu"] = "Mostra/ascondi il menu di missione di OrderHallCommander"
L["Sort missions by:"] = "Ordina le missioni per:"
L["Started with "] = "Avviata con"
L["Success Chance"] = "Percentuale di successo"
L["Troop ready alert"] = "Avviso truppe pronte"
L["Unable to fill missions, raise \"%s\""] = "Non riesco ad assegnare seguaci alle mission, incrementa \"%s\""
L["Unable to fill missions. Check your switches"] = "Impossibile riempire le missioni. Controlla le opzioni scelte"
L["Unable to start mission, aborting"] = "Non riesco a far partire la missione, rinuncio"
L["Unlock all"] = "Libera tutti"
L["Unlock this follower"] = "Libera questo seguace"
L["Unlocks all follower and slots at once"] = "Libera tutti i seguaci riservati e gli slot vietati in un colpo solo"
L["Upgrading to |cff00ff00%d|r"] = "Incremento a |cff00ff00%d|r"
L["URL Copy"] = "Copia la URL"
L["Use at most this many champions"] = "Usa al massimo questo numero di campioni"
L["Use combat ally"] = "Usa l'alleato"
L["Use this slot"] = "Usa questo slot"
L["Uses troops with the highest durability instead of the ones with the lowest"] = "Sceglie la truppe con durabilit\195\160 residua piu' alta anzich\195\169 quelle con durabilit\195\160 residua piu' bassa"
L["When no free followers are available shows empty follower"] = "Quando non ci sono seguaci disponibili mostra le caselle vuote"
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "Se non \195\168 possibile raggiungere la percentuale di successo globale, si cerca di raggiungere almeno questa senza superare il 100%"
L["Would start with "] = "Avvierei con"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Stai sprecando |cffff0000%d|cffffd200 punti!!"
--Translation missing 
-- L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = ""
--Translation missing 
-- L["You now need to press both %s and %s to start mission"] = ""

-- Tutorial
--Translation missing 
-- L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = ""
--Translation missing 
-- L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = ""
--Translation missing 
-- L["Base Chance"] = ""
--Translation missing 
-- L["Bonus Chance"] = ""
--Translation missing 
-- L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = ""
--Translation missing 
-- L["Counter Kill Troops"] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = ""
--Translation missing 
-- L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = ""
--Translation missing 
-- L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = ""
--Translation missing 
-- L["Max champions"] = ""
--Translation missing 
-- L["Maximize xp gain"] = ""
--Translation missing 
-- L["Never kill Troops"] = ""
--Translation missing 
-- L["Prefer high durability"] = ""
--Translation missing 
-- L["Restart the tutorial"] = ""
--Translation missing 
-- L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = ""
--Translation missing 
-- L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = ""
--Translation missing 
-- L["Thank you for reading this, enjoy %s"] = ""
--Translation missing 
-- L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = ""
--Translation missing 
-- L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = ""
--Translation missing 
-- L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = ""
--Translation missing 
-- L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = ""
--Translation missing 
-- L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = ""
--Translation missing 
-- L["You can choose not to use a troop type clicking its icon"] = ""
--Translation missing 
-- L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = ""

	end
	L=l:NewLocale(me,"koKR")
	if (L) then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%2$d%%\235\179\180\235\139\164 %1$d%% \235\130\174\236\138\181\235\139\136\235\139\164. %3$s \235\130\174\236\138\181\235\139\136\235\139\164"
L["%s for a wowhead link popup"] = "%s - wowhead \235\167\129\237\129\172 \237\140\157\236\151\133"
L["%s start the mission without even opening the mission page. No question asked"] = "%s - \236\158\132\235\172\180 \237\142\152\236\157\180\236\167\128\235\165\188 \236\151\180\236\167\128 \236\149\138\234\179\160 \236\158\132\235\172\180\235\165\188 \236\139\156\236\158\145\237\149\169\235\139\136\235\139\164. \236\149\132\235\172\180\234\178\131\235\143\132 \235\172\187\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164"
L["%s starts missions"] = "%s - \236\158\132\235\172\180 \236\139\156\236\158\145"
L["%s to blacklist"] = "\236\176\168\235\139\168\237\149\152\235\160\164\235\169\180 %s"
L["%s to remove from blacklist"] = "\236\176\168\235\139\168\235\170\169\235\161\157\236\151\144\236\132\156 \236\160\156\234\177\176\237\149\152\235\160\164\235\169\180 %s"
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s\235\139\152, \236\132\164\235\170\133\236\132\156\235\165\188 \236\130\180\237\142\180\235\180\144\236\163\188\236\132\184\236\154\148
(\236\149\132\236\157\180\236\189\152\236\157\132 \237\129\180\235\166\173\237\149\152\235\169\180 \236\157\180 \235\169\148\236\139\156\236\167\128\235\165\188 \235\139\171\234\179\160 \236\132\164\235\170\133\236\132\156\235\165\188 \236\139\156\236\158\145\237\149\169\235\139\136\235\139\164)]=]
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = [=[%s\235\139\152, \236\132\164\235\170\133\236\132\156\235\165\188 \236\130\180\237\142\180\235\180\144\236\163\188\236\132\184\236\154\148
(\236\157\180 \235\169\148\236\139\156\236\167\128\235\165\188 \235\139\171\236\156\188\235\160\164\235\169\180 \236\149\132\236\157\180\236\189\152\236\157\132 \237\129\180\235\166\173\237\149\152\236\132\184\236\154\148)]=]
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "\236\158\132\235\172\180 \235\170\169\235\161\157 \237\142\152\236\157\180\236\167\128\236\151\144\236\132\156 \236\158\132\235\172\180\235\165\188 \235\176\148\235\161\156 \236\139\156\236\158\145\237\149\160 \236\136\152 \236\158\136\235\143\132\235\161\157 \237\151\136\236\154\169\237\149\169\235\139\136\235\139\164 (\235\139\168\236\157\188 \236\158\132\235\172\180 \237\142\152\236\157\180\236\167\128\234\176\128 \237\145\156\236\139\156\235\144\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164)"
L["Always counter increased resource cost"] = "\236\158\144\236\155\144 \235\185\132\236\154\169 \236\166\157\234\176\128 \237\149\173\236\131\129 \235\140\128\236\157\145"
L["Always counter increased time"] = "\236\134\140\236\154\148 \236\139\156\234\176\132 \236\166\157\234\176\128 \237\149\173\236\131\129 \235\140\128\236\157\145"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "\235\179\145\235\160\165 \236\163\189\236\157\180\234\184\176 \237\149\173\236\131\129 \235\140\128\236\157\145 (\237\153\156\235\160\165\236\157\180 1\235\167\140 \235\130\168\236\157\128 \235\179\145\235\160\165\235\167\140 \236\158\136\236\157\132 \235\149\144 \235\172\180\236\139\156)"
L["Always counter no bonus loot threat"] = "\236\182\148\234\176\128 \236\160\132\235\166\172\237\146\136 \237\154\141\235\147\157 \235\182\136\234\176\128 \237\149\173\236\131\129 \235\140\128\236\157\145"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "\237\145\156\236\139\156\235\144\156 \236\156\160\235\172\188\235\160\165 \236\136\152\236\185\152\235\138\148 \236\156\160\235\172\188 \236\167\128\236\139\157 \235\160\136\235\178\168\236\157\132 \234\179\160\235\160\164\237\149\152\236\167\128 \236\149\138\236\157\128 \234\184\176\235\179\184 \236\136\152\236\185\152\236\158\133\235\139\136\235\139\164"
L["Attempting %s"] = "%s \236\139\156\235\143\132 \236\164\145"
L["Base Chance"] = "\234\184\176\235\179\184 \236\132\177\234\179\181 \237\153\149\235\165\160"
L["Better parties available in next future"] = "\235\139\164\236\157\140 \236\139\156\234\176\132 \237\155\132\236\151\148 \235\141\148 \235\130\152\236\157\128 \237\140\140\237\139\176\234\176\128 \234\176\128\235\138\165\237\149\169\235\139\136\235\139\164"
L["Blacklisted"] = "\236\176\168\235\139\168\235\144\168"
L["Blacklisted missions are ignored in Mission Control"] = "\236\176\168\235\139\168\235\144\156 \236\158\132\235\172\180\235\138\148 \236\158\132\235\172\180 \236\160\156\236\150\180\236\151\144\236\132\156 \235\172\180\236\139\156\235\144\169\235\139\136\235\139\164"
L["Bonus Chance"] = "\235\179\180\235\132\136\236\138\164 \236\163\188\236\130\172\236\156\132"
L["Building Final report"] = "\236\181\156\236\162\133 \235\179\180\234\179\160\236\132\156 \236\158\145\236\132\177"
L["but using troops with just one durability left"] = "\237\153\156\235\160\165\236\157\180 \237\149\152\235\130\152\235\167\140 \235\130\168\236\157\128 \235\179\145\235\160\165\236\157\128 \236\130\172\236\154\169\237\149\169\235\139\136\235\139\164"
L["Capped %1$s. Spend at least %2$d of them"] = "%1$s\236\151\144 \235\143\132\235\139\172\237\150\136\236\138\181\235\139\136\235\139\164. \236\181\156\236\134\140 %2$d|1\236\157\132;\235\165\188; \236\134\140\235\170\168\237\149\152\236\132\184\236\154\148"
L["Changes the sort order of missions in Mission panel"] = "\236\158\132\235\172\180 \236\176\189 \235\130\180 \236\158\132\235\172\180\236\157\152 \236\160\149\235\160\172 \235\176\169\235\178\149\236\157\132 \235\179\128\234\178\189\237\149\169\235\139\136\235\139\164"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "\236\160\132\237\136\172 \235\143\153\235\163\140\234\176\128 \236\158\132\235\172\180\236\151\144 \236\160\156\236\149\136\235\144\152\235\169\176 \236\160\132\237\136\172 \235\143\153\235\163\140 \236\167\128\236\160\149 \237\149\180\236\160\156\235\165\188 \237\149\180\236\149\188 \237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164"
L["Complete all missions without confirmation"] = "\237\153\149\236\157\184 \236\151\134\236\157\180 \235\170\168\235\147\160 \236\158\132\235\172\180\235\165\188 \236\153\132\235\163\140\237\149\169\235\139\136\235\139\164"
L["Configuration for mission party builder"] = "\236\158\132\235\172\180 \237\140\140\237\139\176 \234\181\172\236\132\177 \236\132\164\236\160\149"
L["Cost reduced"] = "\235\185\132\236\154\169 \234\176\144\236\134\140"
L["Could not fulfill mission, aborting"] = "\236\158\132\235\172\180\235\165\188 \236\153\132\235\163\140\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164, \236\183\168\236\134\140\237\149\169\235\139\136\235\139\164"
L["Counter kill Troops"] = "\235\179\145\235\160\165 \236\163\189\236\157\180\234\184\176 \235\140\128\236\157\145"
--Translation missing 
-- L["Customization options (non mission related)"] = ""
L["Disables warning: "] = "\234\178\189\234\179\160 \235\185\132\237\153\156\236\132\177: "
L["Dont use this slot"] = "\236\157\180 \236\185\184 \236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\234\184\176"
L["Don't use troops"] = "\235\179\145\235\160\165 \236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\234\184\176"
L["Duration reduced"] = "\236\134\140\236\154\148 \236\139\156\234\176\132 \234\176\144\236\134\140"
L["Duration Time"] = "\236\134\140\236\154\148 \236\139\156\234\176\132"
L["Elites mission mode"] = "\236\160\149\236\152\136 \236\158\132\235\172\180 \235\170\168\235\147\156"
L["Empty missions sorted as last"] = "\235\185\136 \236\158\132\235\172\180\235\165\188 \235\167\136\236\167\128\235\167\137\236\151\144 \236\160\149\235\160\172"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "\235\185\132\236\151\136\234\177\176\235\130\152 \236\132\177\234\179\181\235\165\160\236\157\180 0%\236\157\184 \236\158\132\235\172\180\234\176\128 \235\167\136\236\167\128\235\167\137\236\151\144 \236\160\149\235\160\172\235\144\169\235\139\136\235\139\164. \"\236\155\144\235\158\152\236\157\152 \235\176\169\235\178\149\"\236\151\144\235\138\148 \236\160\129\236\154\169\235\144\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164"
L["Equipped by following champions:"] = "\235\139\164\236\157\140 \236\154\169\236\130\172\234\176\128 \236\158\165\236\176\169\237\149\168:"
L["Expiration Time"] = "\235\167\140\235\163\140 \236\139\156\234\176\132"
L["Favours leveling follower for xp missions"] = "\235\160\136\235\178\168 \236\156\161\236\132\177 \236\164\145\236\157\184 \236\182\148\236\162\133\236\158\144\235\165\188 \234\178\189\237\151\152\236\185\152 \236\158\132\235\172\180\236\151\144 \236\154\176\236\132\160 \236\167\128\236\160\149\237\149\169\235\139\136\235\139\164"
L["General"] = "\236\157\188\235\176\152"
L["Global approx. xp reward"] = "\236\180\157 \236\152\136\236\131\129 \234\178\189\237\151\152\236\185\152 \235\179\180\236\131\129"
L["Global approx. xp reward per hour"] = "\236\139\156\234\176\132 \235\139\185 \236\152\136\236\131\129 \234\178\189\237\151\152\236\185\152 \235\179\180\236\131\129"
L["HallComander Quick Mission Completion"] = "HallCommander \235\185\160\235\165\184 \236\158\132\235\172\180 \236\153\132\235\163\140"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "%1$s|1\236\157\180;\234\176\128; \236\157\180 \234\176\146\235\179\180\235\139\164 \235\130\174\236\156\188\235\169\180 100%%\235\165\188 \235\132\152\234\184\176\236\167\128 \236\149\138\234\179\160 \236\181\156\236\134\140 %2$s|1\236\157\132;\235\165\188; \235\139\172\236\132\177\237\149\152\235\143\132\235\161\157 \236\139\156\235\143\132\237\149\169\235\139\136\235\139\164. \236\160\149\236\152\136 \236\158\132\235\172\180\235\138\148 \235\172\180\236\139\156\237\149\169\235\139\136\235\139\164."
L["If not checked, inactive followers are used as last chance"] = "\236\132\160\237\131\157\237\149\152\236\167\128 \236\149\138\236\156\188\235\169\180 \235\185\132\237\153\156\236\132\177 \236\182\148\236\162\133\236\158\144\234\176\128 \237\153\149\235\165\160 \234\179\132\236\130\176\236\151\144 \236\130\172\236\154\169\235\144\169\235\139\136\235\139\164"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[\235\167\140\236\149\189 %s|1\236\157\180\235\157\188\235\169\180;\235\157\188\235\169\180; \234\183\184\235\147\164\236\157\132 \236\158\131\234\178\140 \235\144\169\235\139\136\235\139\164
\236\183\168\236\134\140\237\149\152\235\160\164\235\169\180 %s|1\236\157\132;\235\165\188; \237\129\180\235\166\173\237\149\152\236\132\184\236\154\148]=]
L["Ignore busy followers"] = "\235\176\148\236\129\156 \236\182\148\236\162\133\236\158\144 \235\172\180\236\139\156"
L["Ignore inactive followers"] = "\235\185\132\237\153\156\236\132\177 \236\182\148\236\162\133\236\158\144 \235\172\180\236\139\156"
L["Keep cost low"] = "\235\185\132\236\154\169 \236\160\136\234\176\144 \236\156\160\236\167\128"
L["Keep extra bonus"] = "\236\182\148\234\176\128 \236\160\132\235\166\172\237\146\136 \236\156\160\236\167\128"
L["Keep time short"] = "\236\139\156\234\176\132 \236\160\136\236\149\189 \236\156\160\236\167\128"
L["Keep time VERY short"] = "\236\139\156\234\176\132 \235\167\164\236\154\176 \236\160\136\236\149\189 \236\156\160\236\167\128"
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[\236\181\156\236\134\140 \237\149\156\235\170\133\236\157\152 \236\182\148\236\162\133\236\158\144\234\176\128 \234\179\160\236\160\149\235\144\156 \236\178\171\235\178\136\236\167\184\235\161\156 \236\177\132\236\155\140\236\167\132 \236\158\132\235\172\180\235\165\188 \236\139\156\236\158\145\237\149\169\235\139\136\235\139\164.
%s|1\236\157\132;\235\165\188; \235\136\132\235\165\180\234\179\160 \236\158\136\236\150\180\236\149\188 \236\139\164\236\160\156\235\161\156 \236\139\156\236\158\145\237\149\152\235\169\176, \235\139\168\236\136\156\237\158\136 \237\129\180\235\166\173\235\167\140 \237\149\152\235\169\180 \236\158\132\235\172\180 \236\157\180\235\166\132\234\179\188 \235\176\176\236\160\149\235\144\156 \236\182\148\236\162\133\236\158\144 \235\170\133\235\139\168\235\167\140 \236\182\156\235\160\165\237\149\169\235\139\136\235\139\164]=]
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[\236\181\156\236\134\140 \237\149\156\235\170\133\236\157\152 \236\182\148\236\162\133\236\158\144\234\176\128 \234\179\160\236\160\149\235\144\156 \236\178\171\235\178\136\236\167\184\235\161\156 \236\177\132\236\155\140\236\167\132 \236\158\132\235\172\180\235\165\188 \236\139\156\236\158\145\237\149\169\235\139\136\235\139\164.
SHIFT\235\165\188 \235\136\132\235\165\180\234\179\160 \236\158\136\236\150\180\236\149\188 \236\139\164\236\160\156\235\161\156 \236\139\156\236\158\145\237\149\152\235\169\176, \235\139\168\236\136\156\237\158\136 \237\129\180\235\166\173\235\167\140 \237\149\152\235\169\180 \236\158\132\235\172\180 \236\157\180\235\166\132\234\179\188 \235\176\176\236\160\149\235\144\156 \236\182\148\236\162\133\236\158\144 \235\170\133\235\139\168\235\167\140 \236\182\156\235\160\165\237\149\169\235\139\136\235\139\164]=]
L["Level"] = "\235\160\136\235\178\168"
L["Lock all"] = "\235\170\168\235\145\144 \234\179\160\236\160\149"
L["Lock this follower"] = "\236\157\180 \236\182\148\236\162\133\236\158\144 \234\179\160\236\160\149"
L["Locked follower are only used in this mission"] = "\234\179\160\236\160\149\235\144\156 \236\182\148\236\162\133\236\158\144\235\138\148 \236\157\180 \236\158\132\235\172\180\236\151\144\236\132\156\235\167\140 \236\130\172\236\154\169\235\144\169\235\139\136\235\139\164"
L["Make Order Hall Mission Panel movable"] = "\236\167\129\236\151\133 \236\160\132\235\139\185 \236\158\132\235\172\180 \236\176\189 \236\157\180\235\143\153 \234\176\128\235\138\165 \236\132\164\236\160\149"
L["Makes sure that no troops will be killed"] = "\235\179\145\235\160\165\236\157\180 \236\163\189\236\167\128 \236\149\138\234\178\140 \237\149\169\235\139\136\235\139\164"
L["Max champions"] = "\236\181\156\235\140\128 \236\154\169\236\130\172"
L["Maximize xp gain"] = "\234\178\189\237\151\152\236\185\152 \237\154\141\235\147\157 \236\181\156\235\140\128\237\153\148"
L["Mission duration reduced"] = "\236\158\132\235\172\180 \236\134\140\236\154\148 \236\139\156\234\176\132 \234\176\144\236\134\140"
L["Mission was capped due to total chance less than"] = "\236\160\132\236\178\180 \237\153\149\235\165\160\236\157\180 \235\139\164\236\157\140\235\179\180\235\139\164 \235\130\174\236\149\132\236\132\156 \236\158\132\235\172\180\234\176\128 \236\160\156\237\149\156\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164:"
L["Missions"] = "\236\158\132\235\172\180"
L["Never kill Troops"] = "\235\179\145\235\160\165 \236\163\189\236\157\180\236\167\128 \236\149\138\234\184\176"
L["No follower gained xp"] = "\234\178\189\237\151\152\236\185\152\235\165\188 \237\154\141\235\147\157\237\149\156 \236\182\148\236\162\133\236\158\144 \236\151\134\236\157\140"
L["No suitable missions. Have you reserved at least one follower?"] = "\236\160\129\236\160\136\237\149\156 \236\158\132\235\172\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164. \236\181\156\236\134\140 \237\149\156\235\170\133\236\157\152 \236\182\148\236\162\133\236\158\144\235\165\188 \236\152\136\236\149\189\237\150\136\235\130\152\236\154\148?"
L["Not blacklisted"] = "\236\176\168\235\139\168\235\144\152\236\167\128 \236\149\138\236\157\140"
L["Nothing to report"] = "\235\179\180\234\179\160\237\149\160 \235\130\180\236\154\169 \236\151\134\236\157\140"
L["Notifies you when you have troops ready to be collected"] = "\235\179\145\235\160\165\236\157\132 \237\154\140\236\136\152\237\149\160 \236\164\128\235\185\132\234\176\128 \235\144\152\235\169\180 \235\139\185\236\139\160\236\151\144\234\178\140 \236\149\140\235\166\189\235\139\136\235\139\164"
L["Only accept missions with time improved"] = "\236\134\140\236\154\148 \236\139\156\234\176\132\236\157\180 \234\176\144\236\134\140\237\149\156 \236\158\132\235\172\180\235\167\140 \236\136\152\235\157\189\237\149\169\235\139\136\235\139\164"
L["Only consider elite missions"] = "\236\160\149\236\152\136 \236\158\132\235\172\180\235\167\140 \234\179\160\235\160\164"
L["Only use champions even if troops are available"] = "\235\179\145\235\160\165\236\157\132 \236\130\172\236\154\169\234\176\128\235\138\165 \237\149\180\235\143\132 \236\154\169\236\130\172\235\167\140 \236\130\172\236\154\169\237\149\169\235\139\136\235\139\164"
L["Open configuration"] = "\236\132\164\236\160\149 \236\151\180\234\184\176"
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander\235\138\148 \236\167\129\236\151\133 \236\160\132\235\139\185 \234\180\128\235\166\172\236\151\144 GarrisonCommander\235\179\180\235\139\164 \236\154\176\236\132\160\235\144\169\235\139\136\235\139\164.
OrderHallCommander\235\165\188 \235\185\132\237\153\156\236\132\177\237\149\152\235\169\180 GarrisonCommander\235\161\156 \236\160\132\237\153\152\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.
\235\140\128\236\139\160 \235\139\185\236\139\160\236\157\180 OrderHallCommander\235\165\188 \236\162\139\236\149\132\237\149\156\235\139\164\235\169\180 Curse \237\129\180\235\157\188\236\157\180\236\150\184\237\138\184\236\151\144 \236\182\148\234\176\128\237\149\152\234\179\160 \236\151\133\235\141\176\236\157\180\237\138\184\235\165\188 \236\156\160\236\167\128\237\149\152\236\132\184\236\154\148]=]
L["Original method"] = "\236\155\144\235\158\152\236\157\152 \235\176\169\235\178\149"
L["Position is not saved on logout"] = "\236\160\145\236\134\141 \236\162\133\235\163\140\236\139\156 \236\156\132\236\185\152\235\138\148 \236\160\128\236\158\165\235\144\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164"
L["Prefer high durability"] = "\235\134\146\236\157\128 \237\153\156\235\160\165 \236\132\160\237\152\184"
L["Quick start first mission"] = "\236\178\171\235\178\136\236\167\184 \236\158\132\235\172\180 \235\185\160\235\165\184 \236\139\156\236\158\145"
L["Remove no champions warning"] = "\236\154\169\236\130\172 \236\151\134\236\157\140 \234\178\189\234\179\160 \236\160\156\234\177\176"
L["Restart tutorial from beginning"] = "\236\178\152\236\157\140\235\182\128\237\132\176 \236\132\164\235\170\133\236\132\156 \235\139\164\236\139\156 \236\139\156\236\158\145"
L["Resume tutorial"] = "\236\132\164\235\170\133\236\132\156 \236\157\180\236\150\180\236\132\156 \236\139\156\236\158\145"
L["Resurrect troops effect"] = "\235\179\145\235\160\165 \235\182\128\237\153\156 \237\154\168\234\179\188"
L["Reward type"] = "\235\179\180\236\131\129 \236\156\160\237\152\149"
L["Sets all switches to a very permissive setup"] = "\235\170\168\235\147\160 \236\160\132\237\153\152 \236\132\164\236\160\149\236\157\132 \237\151\136\236\154\169\236\160\129\236\157\184 \234\181\172\236\132\177\236\156\188\235\161\156 \236\132\164\236\160\149"
L["Show tutorial"] = "\236\130\180\235\170\133\236\132\156 \235\179\180\234\184\176"
L["Show/hide OrderHallCommander mission menu"] = "OrderHallCommander \236\158\132\235\172\180 \235\169\148\235\137\180 \237\145\156\236\139\156/\236\136\168\234\184\176\234\184\176"
L["Sort missions by:"] = "\236\158\132\235\172\180 \236\160\149\235\160\172 \235\176\169\235\178\149:"
L["Started with "] = "\235\139\164\236\157\140\234\179\188 \237\149\168\234\187\152 \236\139\156\236\158\145:"
L["Success Chance"] = "\236\132\177\234\179\181 \237\153\149\235\165\160"
L["Troop ready alert"] = "\235\179\145\235\160\165 \236\164\128\235\185\132 \234\178\189\235\179\180"
L["Unable to fill missions, raise \"%s\""] = "\236\158\132\235\172\180\235\165\188 \236\177\132\236\154\184 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164, \"%s\"|1\236\157\132;\235\165\188; \235\138\152\235\166\172\236\132\184\236\154\148"
L["Unable to fill missions. Check your switches"] = "\236\158\132\235\172\180\235\165\188 \236\177\132\236\154\184 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \236\132\164\236\160\149\236\157\132 \237\153\149\236\157\184\237\149\152\236\132\184\236\154\148"
L["Unable to start mission, aborting"] = "\236\158\132\235\172\180\235\165\188 \236\139\156\236\158\145\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164, \236\183\168\236\134\140\237\149\169\235\139\136\235\139\164"
L["Unlock all"] = "\235\170\168\235\145\144 \234\179\160\236\160\149 \237\149\180\236\160\156"
L["Unlock this follower"] = "\236\157\180 \236\182\148\236\162\133\236\158\144 \234\179\160\236\160\149 \237\149\180\236\160\156"
L["Unlocks all follower and slots at once"] = "\235\170\168\235\147\160 \236\182\148\236\162\133\236\158\144\236\153\128 \236\185\184\236\157\132 \237\149\156\235\178\136\236\151\144 \234\179\160\236\160\149 \237\149\180\236\160\156"
L["Upgrading to |cff00ff00%d|r"] = "|cff00ff00%d|r|1\236\156\188\235\161\156;\235\161\156; \237\150\165\236\131\129\236\139\156\237\130\164\234\184\176"
L["URL Copy"] = "URL \235\179\181\236\130\172"
L["Use at most this many champions"] = "\235\144\152\235\143\132\235\161\157 \236\157\180 \236\136\171\236\158\144\236\157\152 \236\154\169\236\130\172\235\165\188 \236\130\172\236\154\169\237\149\169\235\139\136\235\139\164"
L["Use combat ally"] = "\236\160\132\237\136\172 \235\143\153\235\163\140 \236\130\172\236\154\169"
L["Use this slot"] = "\236\157\180 \236\185\184 \236\130\172\236\154\169"
L["Uses troops with the highest durability instead of the ones with the lowest"] = "\234\176\128\236\158\165 \235\130\174\236\157\128 \237\153\156\235\160\165\236\157\132 \234\176\128\236\167\132 \235\179\145\235\160\165 \235\140\128\236\139\160 \234\176\128\236\158\165 \235\134\146\236\157\128 \237\153\156\235\160\165\236\157\132 \234\176\128\236\167\132 \235\179\145\235\160\165\236\157\132 \236\130\172\236\154\169\237\149\169\235\139\136\235\139\164"
L["When no free followers are available shows empty follower"] = "\236\130\172\236\154\169 \234\176\128\235\138\165\237\149\156 \236\182\148\236\162\133\236\158\144\234\176\128 \236\151\134\236\156\188\235\169\180 \236\182\148\236\162\133\236\158\144 \236\185\184\236\157\132 \235\185\136 \236\131\129\237\131\156\235\161\156 \237\145\156\236\139\156\237\149\169\235\139\136\235\139\164"
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "\236\154\148\236\178\173\235\144\156 %1$s|1\236\157\132;\235\165\188; \235\139\172\236\132\177\237\149\152\236\167\128 \235\170\187\237\150\136\236\157\132 \235\149\140 (\234\176\128\235\138\165\237\149\152\235\139\164\235\169\180) 100%%\235\165\188 \235\132\152\234\184\176\236\167\128 \236\149\138\234\179\160 \236\181\156\236\134\140\237\149\156 \236\157\180 \234\176\146\236\151\144 \234\183\188\236\160\145\237\149\152\235\143\132\235\161\157 \236\139\156\235\143\132\237\149\169\235\139\136\235\139\164"
L["Would start with "] = "\235\139\164\236\157\140\234\179\188 \234\176\153\236\157\180 \236\139\156\236\158\145\237\149\160 \236\152\136\236\160\149:"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "|cffff0000%d|cffffd200\236\160\144\236\157\132 \235\130\173\235\185\132\237\149\152\234\179\160 \236\158\136\236\138\181\235\139\136\235\139\164!!!"
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[\236\157\180 \235\178\132\236\160\132\236\157\152 OrderHallCommander\235\165\188 \236\151\133\235\141\176\236\157\180\237\138\184\237\149\152\234\184\176 \236\156\132\237\149\180 \236\155\148\235\147\156 \236\152\164\235\184\140 \236\155\140\237\129\172\235\158\152\237\148\132\237\138\184\235\165\188 \236\162\133\235\163\140\237\149\156 \237\155\132 \235\139\164\236\139\156 \236\139\156\236\158\145\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.
UI\235\165\188 \235\139\164\236\139\156 \235\182\136\235\159\172\236\152\164\235\138\148 \234\178\131\236\156\188\235\161\156 \236\182\169\235\182\132\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164]=]
L["You now need to press both %s and %s to start mission"] = "\236\158\132\235\172\180\235\165\188 \236\139\156\236\158\145\237\149\152\235\160\164\235\169\180 %s|1\234\179\188;\236\153\128; %s|1\236\157\132;\235\165\188; \234\176\153\236\157\180 \235\136\140\235\159\172\236\149\188 \237\149\169\235\139\136\235\139\164"

-- Tutorial
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[\235\139\185\236\139\160\236\157\180 \236\155\144\237\149\152\235\138\148 \236\158\132\235\172\180\235\165\188 \236\177\132\236\154\176\235\138\148 \235\176\169\235\178\149\236\157\132 \236\130\172\236\154\169\236\158\144 \236\132\164\236\160\149\237\149\160 \236\136\152 \236\158\136\235\143\132\235\161\157 %1$s|1\234\179\188;\236\153\128; %2$s|1\236\157\128;\235\138\148; \237\149\168\234\187\152 \236\158\145\235\143\153\237\149\169\235\139\136\235\139\164

%1$s\236\151\144 \236\132\164\236\160\149\235\144\156 \236\182\148\234\176\128 \236\160\132\235\166\172\237\146\136\236\157\132 \236\150\187\235\138\148 \235\141\176 \236\139\156\235\143\132\237\149\152\235\138\148 \236\181\156\236\134\140 \237\151\136\236\154\169 \237\153\149\235\165\160(\237\152\132\236\158\172 %3$s%%)\236\157\132 \234\176\149\235\160\165\237\149\156 \236\182\148\236\162\133\236\158\144\234\176\128 \236\182\169\235\182\132\237\149\152\236\167\128 \236\149\138\236\149\132\236\132\156 \235\139\172\236\132\177\237\149\152\236\167\128 \235\170\187\237\149\152\235\169\180 %2$s(\237\152\132\236\158\172 %4$s%%)\236\151\144 \235\167\158\236\182\165\235\139\136\235\139\164]=]
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[\236\154\148\236\178\173\235\144\156 \236\176\189\236\157\180 \236\151\180\235\166\172\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164
\234\176\128\235\138\165\237\149\152\235\139\164\235\169\180 \236\132\164\235\170\133\236\132\156\234\176\128 \235\139\164\236\139\156 \236\139\156\236\158\145\235\144\169\235\139\136\235\139\164]=]
L["Base Chance"] = "\234\184\176\235\179\184 \236\132\177\234\179\181 \237\153\149\235\165\160"
L["Bonus Chance"] = "\235\179\180\235\132\136\236\138\164 \236\163\188\236\130\172\236\156\132"
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = "\237\140\140\237\139\176 \235\178\132\237\138\188\236\157\132 \237\129\180\235\166\173\237\149\152\235\169\180 \237\152\132\236\158\172 \236\158\132\235\172\180\236\151\144 \236\182\148\236\162\133\236\158\144\235\165\188 \236\167\128\236\160\149\237\149\169\235\139\136\235\139\164. \236\130\172\236\154\169\237\149\152\235\169\180 OHC\234\176\128 \235\184\148\235\166\172\236\158\144\235\147\156\236\157\152 \237\153\149\235\165\160\235\161\156 \236\132\177\234\179\181\235\165\160\236\157\132 \234\179\132\236\130\176\237\149\152\235\143\132\235\161\157 \237\151\136\236\154\169\237\149\169\235\139\136\235\139\164. \236\176\168\236\157\180\234\176\128 \236\158\136\235\139\164\235\169\180 \236\138\164\237\129\172\235\166\176\236\131\183\236\157\132 \236\176\141\234\179\160 \237\139\176\236\188\147\236\157\132 \236\151\180\236\150\180\236\163\188\236\132\184\236\154\148 :)."
L["Counter Kill Troops"] = "\235\179\145\235\160\165 \236\163\189\236\157\180\234\184\176 \235\140\128\236\157\145"
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[\236\182\148\236\162\133\236\158\144 \236\158\165\235\185\132\236\153\128 \235\160\136\235\178\168 \236\149\132\236\157\180\237\133\156\236\157\128 \236\151\172\234\184\176\236\151\144 \237\129\180\235\166\173\237\149\160 \236\136\152 \236\158\136\235\138\148 \235\178\132\237\138\188\236\156\188\235\161\156 \235\130\152\236\151\180\235\144\169\235\139\136\235\139\164.
\235\184\148\235\166\172\236\158\144\235\147\156 \236\189\148\235\147\156 \235\179\180\237\152\184 \236\178\180\234\179\132\236\151\144 \236\157\152\237\149\180 \234\176\128\235\176\169\236\151\144\236\132\156 \235\129\140\236\150\180\235\139\164 \235\134\147\236\156\188\235\169\180 \236\152\164\235\165\152\234\176\128 \235\176\156\236\131\157\235\144\169\235\139\136\235\139\164.
\234\176\128\235\176\169\236\151\144\236\132\156 \236\149\132\236\157\180\237\133\156\236\157\132 \235\129\140\236\150\180\235\139\164 \235\134\147\236\156\188\235\169\180 \236\152\164\235\165\152\234\176\128 \235\176\156\236\131\157\237\149\169\235\139\136\235\139\164.
\235\170\169\235\161\157\236\151\144 \236\151\134\235\138\148 \236\158\165\235\185\132\235\165\188 \236\167\128\236\160\149\237\149\152\235\160\164\235\169\180 \234\176\128\235\176\169\236\151\144\236\132\156 \236\149\132\236\157\180\237\133\156\236\157\132 \236\152\164\235\165\184\236\170\189 \237\129\180\235\166\173\237\149\156 \237\155\132 \236\182\148\236\162\133\236\158\144\235\165\188 \237\129\180\235\166\173\237\149\152\236\132\184\236\154\148. (\235\170\169\235\161\157\236\157\132 \236\162\133\236\162\133 \236\151\133\235\141\176\236\157\180\237\138\184\237\149\152\236\167\128\235\167\140 \234\176\128\235\129\148 \235\184\148\235\166\172\236\158\144\235\147\156\234\176\128 \235\141\148 \235\185\160\235\166\133\235\139\136\235\139\164)
\236\157\180 \235\176\169\235\178\149\236\157\128 \236\152\164\235\165\152\235\165\188 \235\176\156\236\131\157\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164]=]
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[\236\158\165\235\185\132\236\153\128 \234\176\149\237\153\148 \236\149\132\236\157\180\237\133\156\236\157\132 \237\129\180\235\166\173\237\149\160 \236\136\152 \236\158\136\235\138\148 \235\178\132\237\138\188 \235\170\169\235\161\157\236\157\180 \236\157\180\234\179\179\236\151\144 \235\130\152\237\131\128\235\130\169\235\139\136\235\139\164.
\235\184\148\235\166\172\236\158\144\235\147\156 \236\189\148\235\147\156 \235\179\180\237\152\184 \236\178\180\234\179\132\235\149\140\235\172\184\236\151\144 \236\149\132\236\157\180\237\133\156\236\157\132 \234\176\128\235\176\169\236\151\144\236\132\156 \235\129\140\236\150\180\235\139\164 \235\134\147\236\156\188\235\169\180 \236\152\164\235\165\152\234\176\128 \235\176\156\236\131\157\237\149\169\235\139\136\235\139\164.
\235\170\169\235\161\157\236\151\144 \235\130\152\237\131\128\235\130\152\236\167\128 \236\149\138\235\138\148 \236\158\165\235\185\132\235\165\188 \236\167\128\236\160\149\237\149\152\235\160\164\235\169\180 \234\176\128\235\176\169\236\151\144 \236\158\136\235\138\148 \236\149\132\236\157\180\237\133\156\236\157\132 \236\152\164\235\165\184\236\170\189 \237\129\180\235\166\173\237\149\156 \237\155\132 \236\182\148\236\162\133\236\158\144\235\165\188 \236\153\188\236\170\189 \237\129\180\235\166\173\237\149\152\236\132\184\236\154\148.(\236\162\133\236\162\133 \235\170\169\235\161\157\236\157\132 \236\151\133\235\141\176\236\157\180\237\138\184\237\149\152\236\167\128\235\167\140 \234\176\128\235\129\148 \235\184\148\235\166\172\236\158\144\235\147\156\234\176\128 \235\141\148 \235\185\160\235\166\133\235\139\136\235\139\164)
\236\157\180 \235\176\169\235\178\149\236\156\188\235\161\156\235\138\148 \236\152\164\235\165\152\234\176\128 \235\176\156\236\131\157\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164]=]
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[\236\152\136\235\165\188 \235\147\164\236\150\180, \236\132\177\234\179\181 \237\153\149\235\165\160\236\157\180 95%%, 130%% \234\183\184\235\166\172\234\179\160 180%%\236\151\144 \235\143\132\235\139\172\237\149\160 \236\136\152 \236\158\136\235\138\148 \236\158\132\235\172\180\234\176\128 \236\158\136\235\139\164\234\179\160 \234\176\128\236\160\149\237\149\180\235\180\133\236\139\156\235\139\164.
%1$s|1\236\157\180;\234\176\128; 170%%\235\161\156 \236\132\164\236\160\149\235\144\152\236\150\180 \236\158\136\235\139\164\235\169\180 180%%\236\157\152 \236\158\132\235\172\180\234\176\128 \236\132\160\237\131\157\235\144\169\235\139\136\235\139\164.
%1$s|1\236\157\180;\234\176\128; 200%%\235\161\156 \236\132\164\236\160\149\235\144\152\236\150\180 \236\158\136\235\139\164\235\169\180 OHC\235\138\148 %2$s \236\132\164\236\160\149\236\151\144 \236\157\152\237\149\152\236\151\172 100%%\236\151\144 \234\176\128\236\158\165 \234\183\188\236\160\145\237\149\156 \236\158\132\235\172\180\235\165\188 \236\176\190\236\138\181\235\139\136\235\139\164
%2$s|1\236\157\180;\234\176\128; 100%%\235\161\156 \236\132\164\236\160\149\235\144\152\236\150\180 \236\158\136\235\139\164\234\179\160 \234\176\128\236\160\149\237\149\156\235\139\164\235\169\180 130%%\236\157\152 \236\158\132\235\172\180\234\176\128 \236\132\160\237\131\157\235\144\152\236\167\128\235\167\140, %2$s|1\236\157\180;\234\176\128; 90%%\235\161\156 \236\132\164\236\160\149\235\144\152\236\150\180 \236\158\136\235\139\164\235\169\180 95%%\236\157\152 \236\158\132\235\172\180\234\176\128 \236\132\160\237\131\157\235\144\169\235\139\136\235\139\164]=]
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "\236\130\172\236\154\169 \234\176\128\235\138\165 \237\149\156 \236\158\132\235\172\180\235\165\188 \237\149\173\236\131\129 \234\176\128\236\158\165 \235\167\142\236\157\180 \235\179\180\234\179\160 \236\139\182\235\139\164\235\169\180 %1$s|1\236\157\132;\235\165\188; 100%%\235\161\156 %2$s|1\236\157\132;\235\165\188; 0%%\235\161\156 \236\132\164\236\160\149\237\149\152\236\132\184\236\154\148"
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[OHC\234\176\128 \236\132\160\237\131\157\237\149\156 \236\158\132\235\172\180 \234\181\172\236\132\177\236\157\132 \236\157\180\237\149\180\237\149\160 \236\136\152 \236\151\134\235\139\164\235\169\180 \236\160\132\236\178\180 \235\182\132\236\132\157\236\157\132 \236\154\148\236\178\173\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.
\237\140\140\237\139\176 \235\182\132\236\132\157\236\157\128 \235\170\168\235\147\160 \234\176\128\235\138\165\237\149\156 \236\161\176\237\149\169\236\157\132 \237\145\156\236\139\156\237\149\152\234\179\160 OHC\236\157\152 \236\151\176\236\130\176 \235\176\169\235\178\149\236\157\132 \235\179\180\236\151\172\236\164\141\235\139\136\235\139\164]=]
L["Max champions"] = "\236\181\156\235\140\128 \236\154\169\236\130\172"
L["Maximize xp gain"] = "\234\178\189\237\151\152\236\185\152 \237\154\141\235\147\157 \236\181\156\235\140\128\237\153\148"
L["Never kill Troops"] = "\235\179\145\235\160\165 \236\160\136\235\140\128 \236\163\189\236\157\180\236\167\128 \236\149\138\234\184\176"
L["Prefer high durability"] = "\235\134\146\236\157\128 \237\153\156\235\160\165 \236\132\160\237\152\184"
L["Restart the tutorial"] = "\236\132\164\235\170\133\236\132\156 \236\158\172\236\139\156\236\158\145"
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = [=[\236\185\184(\236\134\141\237\149\180 \236\158\136\235\138\148 \236\182\148\236\162\133\236\158\144\234\176\128 \236\149\132\235\139\140 \234\183\184\235\131\165 \236\185\184)\236\157\180 \236\160\156\236\153\184\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.
\236\160\156\236\153\184\235\144\156 \236\185\184\236\157\128 \234\183\184 \236\158\132\235\172\180\236\151\144\236\132\156 \236\177\132\236\155\140\236\167\128\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.
\235\179\145\235\160\165\236\157\128 \237\149\173\236\131\129 \234\176\128\236\158\165 \236\153\188\236\170\189 \236\185\184\236\151\144 \236\158\136\235\139\164\235\138\148 \236\130\172\236\139\164\236\157\132 \236\157\180\236\154\169\237\149\152\235\169\180 \236\158\132\235\172\180\236\151\144 \236\130\172\236\154\169\237\149\152\235\138\148 \236\182\148\236\162\133\236\158\144\236\157\152 \236\160\132\236\178\180 \236\136\171\236\158\144\235\165\188 \236\164\132\236\157\188 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164]=]
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "\236\132\164\235\170\133\236\132\156\235\165\188 \236\162\133\235\163\140\237\149\169\235\139\136\235\139\164. \234\176\128\236\158\165\236\158\144\235\166\172 \235\169\148\235\137\180\236\151\144 \236\158\136\235\138\148 \236\160\149\235\179\180 \236\149\132\236\157\180\236\189\152\236\157\132 \237\129\180\235\166\173\237\149\152\235\169\180 \236\150\184\236\160\156\235\147\160 \235\139\164\236\139\156 \236\167\132\237\150\137\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164"
L["Thank you for reading this, enjoy %s"] = "\236\157\189\236\150\180\236\163\188\236\133\148\236\132\156 \234\176\144\236\130\172\237\149\169\235\139\136\235\139\164, \236\166\144\234\177\176\236\154\180 %s \235\144\152\236\132\184\236\154\148"
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = [=[OrderHallCommander\235\138\148 \236\157\188\235\176\152\236\160\129\236\156\188\235\161\156 \234\176\128\235\138\165\237\149\156 \237\149\156 \236\131\136\235\161\156\236\154\180 \235\179\145\235\160\165\236\157\132 \236\154\148\236\178\173\237\149\160 \236\136\152 \236\158\136\235\143\132\235\161\157 \234\176\128\236\158\165 \235\130\174\236\157\128 \237\153\156\235\160\165\236\157\152 \235\179\145\235\160\165\236\157\132 \236\130\172\236\154\169\237\149\169\235\139\136\235\139\164.
%1$s|1\236\157\132;\235\165\188; \236\132\160\237\131\157\237\149\152\235\169\180 \235\176\152\235\140\128\235\161\156 OrderHallCommander\234\176\128 \234\176\129 \236\158\132\235\172\180\236\151\144 \234\176\128\236\158\165 \235\134\146\236\157\128 \237\153\156\235\160\165\236\157\152 \235\179\145\235\160\165\236\157\132 \236\132\160\237\131\157\237\149\169\235\139\136\235\139\164]=]
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[OrderHallCommander\236\157\152 \236\131\136\235\161\156\236\154\180 \235\176\176\237\143\172 \235\178\132\236\160\132\236\151\144 \236\152\164\236\139\160 \234\177\184 \237\153\152\236\152\129\237\149\169\235\139\136\235\139\164
\235\170\168\235\147\160 \236\131\136\235\161\156\236\154\180 \234\184\176\235\138\165\236\151\144 \235\140\128\237\149\180 \236\149\140\236\149\132 \235\179\180\234\184\176 \236\156\132\237\149\180 \234\176\132\235\139\168\237\149\156 \236\132\164\235\170\133\236\132\156\235\165\188 \235\148\176\235\157\188\236\163\188\236\132\184\236\154\148.
\237\155\132\237\154\140\237\149\152\236\167\128 \236\149\138\236\157\132\234\178\129\235\139\136\235\139\164]=]
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = [=[%1$s|1\236\157\132;\235\165\188; \236\130\172\236\154\169\237\149\152\235\169\180 \235\179\145\235\160\165\236\157\132 \236\163\189\236\157\180\235\138\148 \236\156\132\237\152\145 \236\154\148\236\134\140\235\165\188 \237\149\173\236\131\129 \235\140\128\236\157\145\237\149\169\235\139\136\235\139\164.
OHC\234\176\128 \236\156\132\237\152\145 \236\154\148\236\134\140\235\165\188 \235\140\128\236\157\145\237\149\152\234\177\176\235\130\152 \237\153\156\235\160\165\236\157\180 \237\149\152\235\130\152 \235\130\168\236\157\128 \235\179\145\235\160\165\235\167\140 \236\130\172\236\154\169\237\149\152\235\138\148 \234\177\184 \236\157\152\235\175\184\237\149\169\235\139\136\235\139\164.
\236\157\180 \236\132\164\236\160\149\236\157\152 \235\170\169\237\145\156\235\138\148 \235\179\145\235\160\165\236\157\152 \236\163\189\236\157\140\236\157\132 \237\148\188\237\149\152\235\138\148 \234\178\140 \236\149\132\235\139\140 \237\153\156\235\160\165\236\157\152 \235\130\173\235\185\132\235\165\188 \237\148\188\237\149\152\235\138\148 \234\178\131\236\158\133\235\139\136\235\139\164.]=]
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[%2$s|1\236\157\132;\235\165\188; \236\130\172\236\154\169\237\149\152\235\169\180 \235\179\145\235\160\165\236\157\180 \236\163\189\236\167\128 \236\149\138\235\143\132\235\161\157 \235\179\180\237\152\184\237\149\169\235\139\136\235\139\164.
%1$s|1\234\179\188;\236\153\128; %3$s|1\236\157\132;\235\165\188; \236\157\152\235\175\184\237\149\152\235\138\148 \234\178\131\235\167\140\236\157\128 \236\149\132\235\139\136\235\169\176, OHC\234\176\128 \236\158\132\235\172\180\235\165\188 \235\179\180\235\130\180\235\169\180 \236\163\189\234\178\140 \235\144\160 \235\179\145\235\160\165\236\157\128 \236\160\136\235\140\128 \235\179\180\235\130\180\236\167\128 \236\149\138\235\143\132\235\161\157 \234\176\149\236\160\156\237\149\169\235\139\136\235\139\164.
\236\157\180 \236\132\164\236\160\149\236\157\152 \235\170\169\236\160\129\236\157\128 \236\157\180\234\178\131\235\149\140\235\172\184\236\151\144 \237\140\140\237\139\176\235\165\188 \236\177\132\236\154\176\236\167\128 \235\170\187\237\149\152\235\141\148\235\157\188\235\143\132 \236\153\132\235\178\189\237\158\136 \235\179\145\235\160\165\236\157\132 \236\163\189\236\157\180\236\167\128 \236\149\138\234\184\176 \236\156\132\237\149\168\236\158\133\235\139\136\235\139\164.]=]
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = [=[\236\158\132\235\172\180 \235\178\132\237\138\188\236\157\132 \236\152\164\235\165\184\236\170\189 \237\129\180\235\166\173\237\149\152\236\151\172 \236\158\132\235\172\180\235\165\188 \236\176\168\235\139\168\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.
1.5.1 \235\178\132\236\160\132\235\182\128\237\132\176 \236\158\132\235\172\180 \235\178\132\237\138\188\236\157\132 Shift-\237\129\180\235\166\173\237\149\152\236\151\172 \236\158\132\235\172\180 \237\142\152\236\157\180\236\167\128\235\165\188 \235\179\180\236\167\128 \236\149\138\234\179\160 \236\158\132\235\172\180\235\165\188 \236\139\156\236\158\145\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.
\235\143\153\236\157\152\235\165\188 \234\181\172\237\149\152\236\167\128 \236\149\138\234\184\176 \235\149\140\235\172\184\236\151\144 \237\140\140\237\139\176\234\176\128 \236\152\172\235\176\148\235\165\184\236\167\128 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148]=]
L["You can choose not to use a troop type clicking its icon"] = "\237\149\180\235\139\185 \236\149\132\236\157\180\236\189\152\236\157\132 \237\129\180\235\166\173\237\149\152\236\151\172 \235\179\145\235\160\165\236\157\132 \236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\235\143\132\235\161\157 \236\132\160\237\131\157\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164"
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[\235\170\135 \235\170\133\236\157\152 \236\154\169\236\130\172\235\165\188 \237\149\168\234\187\152 \236\158\132\235\172\180\236\151\144 \235\179\180\235\130\188 \236\167\128 \236\136\171\236\158\144\235\165\188 \236\132\160\237\131\157\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.
OHC\235\138\148 \236\157\180\236\160\156 \234\176\153\236\157\128 \236\158\132\235\172\180\236\151\144 %3$s\235\170\133\236\157\132 \236\180\136\234\179\188\237\149\152\236\151\172 \236\154\169\236\130\172\235\165\188 \236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164-

%2$s|1\236\157\180;\234\176\128; \236\154\176\236\132\160\235\144\169\235\139\136\235\139\164.]=]

	end
	L=l:NewLocale(me,"esMX")
	if (L) then
--Translation missing 
-- L["%1$d%% lower than %2$d%%. Lower %s"] = ""
--Translation missing 
-- L["%s for a wowhead link popup"] = ""
--Translation missing 
-- L["%s start the mission without even opening the mission page. No question asked"] = ""
--Translation missing 
-- L["%s starts missions"] = ""
--Translation missing 
-- L["%s to blacklist"] = ""
--Translation missing 
-- L["%s to remove from blacklist"] = ""
--Translation missing 
-- L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = ""
--Translation missing 
-- L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = ""
--Translation missing 
-- L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = ""
L["Always counter increased resource cost"] = "Siempre contrarreste el mayor costo de recursos"
L["Always counter increased time"] = "Siempre contrarreste el tiempo incrementado"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Siempre contra las tropas de matar (ignorado si s\195\179lo podemos utilizar tropas con s\195\179lo 1 durabilidad a la izquierda)"
--Translation missing 
-- L["Always counter no bonus loot threat"] = ""
--Translation missing 
-- L["Artifact shown value is the base value without considering knowledge multiplier"] = ""
--Translation missing 
-- L["Attempting %s"] = ""
--Translation missing 
-- L["Base Chance"] = ""
L["Better parties available in next future"] = "Mejores fiestas disponibles en el pr\195\179ximo futuro"
--Translation missing 
-- L["Blacklisted"] = ""
--Translation missing 
-- L["Blacklisted missions are ignored in Mission Control"] = ""
--Translation missing 
-- L["Bonus Chance"] = ""
L["Building Final report"] = "Informe final del edificio"
--Translation missing 
-- L["but using troops with just one durability left"] = ""
L["Capped %1$s. Spend at least %2$d of them"] = "% 1 $ s cubierto. Gasta al menos% 2 $ d de ellos"
L["Changes the sort order of missions in Mission panel"] = "Cambia el orden de las misiones en el panel de la Misi\195\179n"
--Translation missing 
-- L["Combat ally is proposed for missions so you can consider unassigning him"] = ""
L["Complete all missions without confirmation"] = "Completa todas las misiones sin confirmaci\195\179n"
L["Configuration for mission party builder"] = "Configuraci\195\179n para el constructor de la misi\195\179n"
--Translation missing 
-- L["Cost reduced"] = ""
--Translation missing 
-- L["Could not fulfill mission, aborting"] = ""
--Translation missing 
-- L["Counter kill Troops"] = ""
--Translation missing 
-- L["Customization options (non mission related)"] = ""
--Translation missing 
-- L["Disables warning: "] = ""
--Translation missing 
-- L["Dont use this slot"] = ""
--Translation missing 
-- L["Don't use troops"] = ""
L["Duration reduced"] = "Duraci\195\179n reducida"
L["Duration Time"] = "Duraci\195\179n"
--Translation missing 
-- L["Elites mission mode"] = ""
--Translation missing 
-- L["Empty missions sorted as last"] = ""
--Translation missing 
-- L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = ""
--Translation missing 
-- L["Equipped by following champions:"] = ""
L["Expiration Time"] = "Tiempo de expiraci\195\179n"
L["Favours leveling follower for xp missions"] = "Favors nivelando seguidor para las misiones xp"
L["General"] = true
L["Global approx. xp reward"] = "Global aprox. Recompensa xp"
--Translation missing 
-- L["Global approx. xp reward per hour"] = ""
L["HallComander Quick Mission Completion"] = "Conclusi\195\179n de la misi\195\179n r\195\161pida de HallComander"
--Translation missing 
-- L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = ""
--Translation missing 
-- L["If not checked, inactive followers are used as last chance"] = ""
--Translation missing 
-- L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = ""
--Translation missing 
-- L["Ignore busy followers"] = ""
--Translation missing 
-- L["Ignore inactive followers"] = ""
L["Keep cost low"] = "Mantenga el costo bajo"
--Translation missing 
-- L["Keep extra bonus"] = ""
L["Keep time short"] = "Mantenga el tiempo corto"
L["Keep time VERY short"] = "Mantener el tiempo muy corto"
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
L["Level"] = "Nivel"
--Translation missing 
-- L["Lock all"] = ""
--Translation missing 
-- L["Lock this follower"] = ""
--Translation missing 
-- L["Locked follower are only used in this mission"] = ""
L["Make Order Hall Mission Panel movable"] = "Hacer pedido Hall Misi\195\179n Panel m\195\179vil"
--Translation missing 
-- L["Makes sure that no troops will be killed"] = ""
--Translation missing 
-- L["Max champions"] = ""
L["Maximize xp gain"] = "Maximizar la ganancia de xp"
--Translation missing 
-- L["Mission duration reduced"] = ""
--Translation missing 
-- L["Mission was capped due to total chance less than"] = ""
L["Missions"] = "Misiones"
--Translation missing 
-- L["Never kill Troops"] = ""
L["No follower gained xp"] = "Ning\195\186n seguidor gan\195\179 xp"
--Translation missing 
-- L["No suitable missions. Have you reserved at least one follower?"] = ""
--Translation missing 
-- L["Not blacklisted"] = ""
L["Nothing to report"] = "Nada que reportar"
L["Notifies you when you have troops ready to be collected"] = "Notifica cuando hay tropas listas para ser recolectadas"
L["Only accept missions with time improved"] = "S\195\179lo aceptar misiones mejoradas con el tiempo"
--Translation missing 
-- L["Only consider elite missions"] = ""
--Translation missing 
-- L["Only use champions even if troops are available"] = ""
--Translation missing 
-- L["Open configuration"] = ""
--Translation missing 
-- L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = ""
L["Original method"] = "M\195\169todo original"
L["Position is not saved on logout"] = "La posici\195\179n no se guarda al cerrar la sesi\195\179n"
--Translation missing 
-- L["Prefer high durability"] = ""
--Translation missing 
-- L["Quick start first mission"] = ""
--Translation missing 
-- L["Remove no champions warning"] = ""
--Translation missing 
-- L["Restart tutorial from beginning"] = ""
--Translation missing 
-- L["Resume tutorial"] = ""
L["Resurrect troops effect"] = "Efecto de las tropas de resurrecci\195\179n"
L["Reward type"] = "Tipo de recompensa"
--Translation missing 
-- L["Sets all switches to a very permissive setup"] = ""
--Translation missing 
-- L["Show tutorial"] = ""
L["Show/hide OrderHallCommander mission menu"] = "Mostrar / ocultar el men\195\186 de la misi\195\179n OrderHallCommander"
L["Sort missions by:"] = "Ordenar misiones por:"
--Translation missing 
-- L["Started with "] = ""
L["Success Chance"] = "\195\137xito"
L["Troop ready alert"] = "Alerta lista de tropas"
--Translation missing 
-- L["Unable to fill missions, raise \"%s\""] = ""
--Translation missing 
-- L["Unable to fill missions. Check your switches"] = ""
--Translation missing 
-- L["Unable to start mission, aborting"] = ""
--Translation missing 
-- L["Unlock all"] = ""
--Translation missing 
-- L["Unlock this follower"] = ""
--Translation missing 
-- L["Unlocks all follower and slots at once"] = ""
L["Upgrading to |cff00ff00%d|r"] = "Actualizando a | cff00ff00% d | r"
--Translation missing 
-- L["URL Copy"] = ""
--Translation missing 
-- L["Use at most this many champions"] = ""
--Translation missing 
-- L["Use combat ally"] = ""
--Translation missing 
-- L["Use this slot"] = ""
--Translation missing 
-- L["Uses troops with the highest durability instead of the ones with the lowest"] = ""
--Translation missing 
-- L["When no free followers are available shows empty follower"] = ""
--Translation missing 
-- L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = ""
--Translation missing 
-- L["Would start with "] = ""
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Est\195\161 perdiendo | cffff0000% d | cffffd200 punto (s)!"
--Translation missing 
-- L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = ""
--Translation missing 
-- L["You now need to press both %s and %s to start mission"] = ""

-- Tutorial
--Translation missing 
-- L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = ""
--Translation missing 
-- L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = ""
--Translation missing 
-- L["Base Chance"] = ""
--Translation missing 
-- L["Bonus Chance"] = ""
--Translation missing 
-- L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = ""
--Translation missing 
-- L["Counter Kill Troops"] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = ""
--Translation missing 
-- L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = ""
--Translation missing 
-- L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = ""
--Translation missing 
-- L["Max champions"] = ""
--Translation missing 
-- L["Maximize xp gain"] = ""
--Translation missing 
-- L["Never kill Troops"] = ""
--Translation missing 
-- L["Prefer high durability"] = ""
--Translation missing 
-- L["Restart the tutorial"] = ""
--Translation missing 
-- L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = ""
--Translation missing 
-- L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = ""
--Translation missing 
-- L["Thank you for reading this, enjoy %s"] = ""
--Translation missing 
-- L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = ""
--Translation missing 
-- L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = ""
--Translation missing 
-- L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = ""
--Translation missing 
-- L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = ""
--Translation missing 
-- L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = ""
--Translation missing 
-- L["You can choose not to use a troop type clicking its icon"] = ""
--Translation missing 
-- L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = ""

	end
	L=l:NewLocale(me,"ruRU")
	if (L) then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%% \208\189\208\184\208\182\208\181 \209\135\208\181\208\188 %2$d%%. \208\157\208\184\208\182\208\181 %s"
L["%s for a wowhead link popup"] = "%s \208\180\208\187\209\143 \208\178\209\129\208\191\208\187\209\139\208\178\208\176\209\142\209\137\208\181\208\185 \209\129\209\129\209\139\208\187\208\186\208\184 \208\189\208\176 wowhead"
L["%s start the mission without even opening the mission page. No question asked"] = "%s \208\189\208\176\209\135\208\184\208\189\208\176\208\181\209\130 \208\178\209\139\208\191\208\190\208\187\208\189\208\181\208\189\208\184\208\181 \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \208\177\208\181\208\183 \208\190\209\130\208\186\209\128\209\139\209\130\208\184\209\143 \209\141\208\186\209\128\208\176\208\189\208\176 \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \208\184 \208\177\208\181\208\183 \208\180\208\190\208\191\208\190\208\187\208\189\208\184\209\130\208\181\208\187\209\140\208\189\209\139\209\133 \208\178\208\190\208\191\209\128\208\190\209\129\208\190\208\178"
L["%s starts missions"] = "%s \208\189\208\176\209\135\208\184\208\189\208\176\208\181\209\130 \208\183\208\176\208\180\208\176\208\189\208\184\208\181"
L["%s to blacklist"] = "%s \208\180\208\187\209\143 \208\180\208\190\208\177\208\176\208\178\208\187\208\181\208\189\208\184\209\143 \208\178 \209\135\209\145\209\128\208\189\209\139\208\185 \209\129\208\191\208\184\209\129\208\190\208\186"
L["%s to remove from blacklist"] = "%s \208\180\208\187\209\143 \209\131\208\180\208\176\208\187\208\181\208\189\208\184\209\143 \208\184\208\183 \209\135\209\145\209\128\208\189\208\190\208\179\208\190 \209\129\208\191\208\184\209\129\208\186\208\176"
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s, \208\191\208\190\208\182\208\176\208\187\209\131\208\185\209\129\209\130\208\176 \208\190\208\177\209\128\208\176\209\130\208\184\209\130\208\181\209\129\209\140 \208\186 \208\184\208\189\209\129\209\130\209\128\209\131\208\186\209\134\208\184\208\184
(\208\157\208\176\208\182\208\188\208\184\209\130\208\181 \208\189\208\176 \208\184\208\186\208\190\208\189\208\186\209\131, \209\135\209\130\208\190\208\177\209\139 \209\131\208\177\209\128\208\176\209\130\209\140 \209\141\209\130\208\190 \209\129\208\190\208\190\208\177\209\137\208\181\208\189\208\184\208\181 \208\184 \208\189\208\176\209\135\208\176\209\130\209\140 \208\190\208\177\209\131\209\135\208\181\208\189\208\184\208\181)]=]
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s, \208\191\208\190\208\182\208\176\208\187\209\131\208\185\209\129\209\130\208\176 \208\191\208\181\209\128\208\181\209\129\208\188\208\190\209\130\209\128\208\184\209\130\208\181 \208\184\208\189\209\129\209\130\209\128\209\131\208\186\209\134\208\184\208\184\\n\208\157\208\176\208\182\208\188\208\184\209\130\208\181 \208\189\208\176 \208\184\208\186\208\190\208\189\208\186\209\131, \209\135\209\130\208\190\208\177\209\139 \209\131\208\177\209\128\208\176\209\130\209\140 \209\141\209\130\208\190 \209\129\208\190\208\190\208\177\209\137\208\181\208\189\208\184\208\181"
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "\208\160\208\176\208\183\209\128\208\181\209\136\208\184\209\130\209\140 \208\189\208\176\209\135\208\184\208\189\208\176\209\130\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\208\181 \208\191\209\128\209\143\208\188\208\190 \209\129\208\190 \209\129\209\130\209\128\208\176\208\189\208\184\209\134\209\139 \209\129\208\191\208\184\209\129\208\186\208\176 \208\183\208\176\208\180\208\176\208\189\208\184\208\185 (\208\177\208\181\208\183 \208\191\208\190\208\186\208\176\208\183\208\176 \209\129\209\130\209\128\208\176\208\189\208\184\209\134\209\139 \208\183\208\176\208\180\208\176\208\189\208\184\209\143)"
L["Always counter increased resource cost"] = "\208\163\209\135\208\184\209\130\209\139\208\178\208\176\209\130\209\140 \209\131\208\178\208\181\208\187\208\184\209\135\208\181\208\189\208\184\208\181 \209\129\209\130\208\190\208\184\208\188\208\190\209\129\209\130\208\184 \209\128\208\181\209\129\209\131\209\128\209\129\208\190\208\178"
L["Always counter increased time"] = "\208\163\209\135\208\184\209\130\209\139\208\178\208\176\209\130\209\140 \209\131\208\178\208\181\208\187\208\184\209\135\208\181\208\189\208\184\208\181 \208\178\209\128\208\181\208\188\208\181\208\189\208\184 \208\189\208\176 \208\183\208\176\208\180\208\176\208\189\208\184\208\181"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "\208\163\209\135\208\184\209\130\209\139\208\178\208\176\209\130\209\140 \209\129\208\188\208\181\209\128\209\130\209\140 \208\178\208\190\208\185\209\129\208\186. \208\152\208\179\208\189\208\190\209\128\208\184\209\128\209\131\208\181\209\130\209\129\209\143, \208\181\209\129\208\187\208\184 \208\190\209\129\209\130\208\176\208\187\208\184\209\129\209\140 \208\178\208\190\208\185\209\129\208\186\208\176 \209\130\208\190\208\187\209\140\208\186\208\190 \209\129 1 \208\181\208\180\208\184\208\189\208\184\209\134\208\181\208\185 \208\183\208\180\208\190\209\128\208\190\208\178\209\140\209\143"
L["Always counter no bonus loot threat"] = "\208\152\208\179\208\189\208\190\209\128\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\209\143, \208\181\209\129\208\187\208\184 \208\189\208\181\209\130 \209\136\208\176\208\189\209\129\208\176 \208\189\208\176 \208\180\208\190\208\191\208\190\208\187\208\189\208\184\209\130\208\181\208\187\209\140\208\189\209\131\209\142 \208\180\208\190\208\177\209\139\209\135\209\131"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 \208\177\208\176\208\183\208\190\208\178\208\190\208\181 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\208\181 \209\129\208\184\208\187\209\139 \208\176\209\128\209\130\208\181\209\132\208\176\208\186\209\130\208\176 \208\177\208\181\208\183 \209\131\209\135\208\181\209\130\208\176 \208\188\208\189\208\190\208\182\208\184\209\130\208\181\208\187\209\143 \208\183\208\189\208\176\208\189\208\184\209\143"
L["Attempting %s"] = "\208\159\209\139\209\130\208\176\208\181\208\188\209\129\209\143 %s"
L["Base Chance"] = "\208\145\208\176\208\183\208\190\208\178\209\139\208\185 \209\136\208\176\208\189\209\129"
L["Better parties available in next future"] = "\208\155\209\131\209\135\209\136\208\176\209\143 \208\179\209\128\209\131\208\191\208\191\208\176 \208\177\209\131\208\180\208\181\209\130 \208\180\208\190\209\129\209\130\209\131\208\191\208\189\208\176 \209\129\208\186\208\190\209\128\208\190"
L["Blacklisted"] = "\208\145\208\187\208\190\208\186\208\184\209\128\208\190\208\178\208\176\208\189\208\189\209\139\208\181"
L["Blacklisted missions are ignored in Mission Control"] = "\208\151\208\176\208\180\208\176\208\189\208\184\209\143 \208\184\208\183 \209\135\209\145\209\128\208\189\208\190\208\179\208\190 \209\129\208\191\208\184\209\129\208\186\208\176 \208\184\208\179\208\189\208\190\209\128\208\184\209\128\209\131\209\142\209\130\209\129\209\143 \208\191\209\128\208\184 \209\131\208\191\209\128\208\176\208\178\208\187\208\181\208\189\208\184\208\184 \208\183\208\176\208\180\208\176\208\189\208\184\209\143\208\188\208\184"
L["Bonus Chance"] = "\208\145\208\190\208\189\209\131\209\129\208\189\209\139\208\185 \209\136\208\176\208\189\209\129"
L["Building Final report"] = "\208\161\208\190\208\183\208\180\208\176\209\130\209\140 \208\190\209\130\209\135\208\181\209\130 \208\191\208\190 \208\183\208\176\208\178\208\181\209\128\209\136\208\181\208\189\208\184\208\184 \208\183\208\176\208\180\208\176\208\189\208\184\209\143"
L["but using troops with just one durability left"] = "\208\189\208\190 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \208\178\208\190\208\185\209\129\208\186\208\176 \209\129 1 \208\181\208\180\208\184\208\189\208\184\209\134\208\181\208\185 \208\183\208\180\208\190\209\128\208\190\208\178\209\140\209\143"
L["Capped %1$s. Spend at least %2$d of them"] = "\208\148\208\190\209\129\209\130\208\184\208\179\208\189\209\131\209\130\208\190 %1$. \208\159\208\190\209\130\209\128\208\176\209\130\209\140\209\130\208\181 \208\191\208\190 \208\186\209\128\208\176\208\185\208\189\208\181\208\185 \208\188\208\181\209\128\208\181 2%$"
L["Changes the sort order of missions in Mission panel"] = "\208\156\208\181\208\189\209\143\208\181\209\130 \208\191\208\190\209\128\209\143\208\180\208\190\208\186 \209\129\208\190\209\128\209\130\208\184\209\128\208\190\208\178\208\186\208\184 \208\189\208\176 \208\191\208\176\208\189\208\181\208\187\208\184 \208\183\208\176\208\180\208\176\208\189\208\184\208\185"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \208\177\208\190\208\181\208\178\208\190\208\179\208\190 \209\129\208\191\209\131\209\130\208\189\208\184\208\186\208\176 \208\178 \209\128\208\176\209\129\209\135\208\181\209\130\208\176\209\133. \208\159\208\181\209\128\208\181\208\180 \208\190\209\130\208\191\209\128\208\176\208\178\208\186\208\190\208\185 \208\190\209\130\208\191\209\131\209\129\209\130\208\184\209\130\208\181 \208\181\208\179\208\190"
L["Complete all missions without confirmation"] = "\208\151\208\176\208\178\208\181\209\128\209\136\208\184\209\130\209\140 \208\178\209\129\208\181 \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \208\177\208\181\208\183 \208\191\208\190\208\180\209\130\208\178\208\181\209\128\208\182\208\180\208\181\208\189\208\184\208\185"
L["Configuration for mission party builder"] = "\208\157\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184 \208\180\208\187\209\143 \209\129\208\177\208\190\209\128\208\176 \208\179\209\128\209\131\208\191\208\191\209\139 \208\180\208\187\209\143 \208\183\208\176\208\180\208\176\208\189\208\184\209\143"
L["Cost reduced"] = "\208\161\209\130\208\190\208\184\208\188\208\190\209\129\209\130\209\140 \209\131\208\188\208\181\208\189\209\140\209\136\208\181\208\189\208\176"
L["Could not fulfill mission, aborting"] = "\208\157\208\181 \209\131\208\180\208\176\208\187\208\190\209\129\209\140 \208\178\209\139\208\191\208\190\208\187\208\189\208\184\209\130\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\208\181, \208\191\209\128\208\181\209\128\209\139\208\178\208\176\208\189\208\184\208\181"
L["Counter kill Troops"] = "\208\159\209\128\208\181\208\180\209\131\208\191\209\128\208\181\208\180\208\184\209\130\209\140 \209\129\208\188\208\181\209\128\209\130\209\140 \208\178\208\190\208\185\209\129\208\186"
--Translation missing 
-- L["Customization options (non mission related)"] = ""
L["Disables warning: "] = "\208\158\209\130\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\191\209\128\208\181\208\180\209\131\208\191\209\128\208\181\208\182\208\180\208\181\208\189\208\184\208\181: "
L["Dont use this slot"] = "\208\157\208\181 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \209\141\209\130\208\190\209\130 \209\129\208\187\208\190\209\130"
L["Don't use troops"] = "\208\157\208\181 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \208\178\208\190\208\185\209\129\208\186\208\176"
L["Duration reduced"] = "\208\159\209\128\208\190\208\180\208\190\208\187\208\182\208\184\209\130\208\181\208\187\209\140\208\189\208\190\209\129\209\130\209\140 \209\131\208\188\208\181\208\189\209\140\209\136\208\181\208\189\208\176"
L["Duration Time"] = "\208\159\209\128\208\190\208\180\208\190\208\187\208\182\208\184\209\130\208\181\208\187\209\140\208\189\208\190\209\129\209\130\209\140"
L["Elites mission mode"] = "\208\160\208\181\208\182\208\184\208\188 \209\141\208\187\208\184\209\130\208\189\209\139\209\133 \208\183\208\176\208\180\208\176\208\189\208\184\208\185"
L["Empty missions sorted as last"] = "\208\151\208\176\208\180\208\176\208\189\208\184\209\143 \208\177\208\181\208\183 \208\179\209\128\209\131\208\191\208\191 \209\129\208\190\209\128\209\130\208\184\209\128\209\131\209\142\209\130\209\129\209\143 \208\186\208\176\208\186 \208\191\208\190\209\129\208\187\208\181\208\180\208\189\208\184\208\181"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "\208\151\208\176\208\180\208\176\208\189\208\184\209\143 \208\177\208\181\208\183 \208\179\209\128\209\131\208\191\208\191\209\139 \208\184 \208\191\209\128\208\190\208\178\208\176\208\187\209\140\208\189\209\139\208\181 (0 % \209\131\209\129\208\191\208\181\209\133\208\176) \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \208\190\209\130\208\190\208\177\209\128\208\176\208\182\208\176\209\142\209\130\209\129\209\143 \208\191\208\190\209\129\208\187\208\181\208\180\208\189\208\184\208\188\208\184 \208\191\209\128\208\184 \209\129\208\190\209\128\209\130\208\184\209\128\208\190\208\178\208\186\208\181. \208\157\208\181 \208\190\209\130\208\189\208\190\209\129\208\184\209\130\209\129\209\143 \208\186 \"\208\190\208\177\209\139\209\135\208\189\208\190\208\188\209\131\" \208\188\208\181\209\130\208\190\208\180\209\131"
L["Equipped by following champions:"] = "\208\158\208\180\208\181\209\130\208\190 \208\189\208\176 \209\129\208\187\208\181\208\180\209\131\209\142\209\137\208\184\209\133 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178:"
L["Expiration Time"] = "\208\146\209\128\208\181\208\188\209\143 \208\190\208\186\208\190\208\189\209\135\208\176\208\189\208\184\209\143 \208\176\208\186\209\130\208\184\208\178\208\189\208\190\209\129\209\130\208\184"
L["Favours leveling follower for xp missions"] = "\208\159\209\128\208\181\208\180\208\191\208\190\209\135\208\181\209\129\209\130\209\140 \208\189\208\176\208\177\208\190\209\128 \209\131\209\128\208\190\208\178\208\189\209\143 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\188 \208\178 \208\183\208\176\208\180\208\176\208\189\208\184\209\143\209\133 \208\189\208\176 \208\190\208\191\209\139\209\130"
L["General"] = "\208\158\209\129\208\189\208\190\208\178\208\189\209\139\208\181"
L["Global approx. xp reward"] = "\208\158\208\177\209\137\208\176\209\143 \208\190\209\134\208\181\208\189\208\186\208\176 \208\178\208\190\208\183\208\188\208\190\208\182\208\189\208\190\208\179\208\190 \208\186 \208\191\208\190\208\187\209\131\209\135\208\181\208\189\208\184\209\142 \208\190\208\191\209\139\209\130\208\176"
L["Global approx. xp reward per hour"] = "\208\158\208\177\209\137\208\176\209\143 \208\190\209\134\208\181\208\189\208\186\208\176 \208\178\208\190\208\183\208\188\208\190\208\182\208\189\208\190\208\179\208\190 \208\186 \208\191\208\190\208\187\209\131\209\135\208\181\208\189\208\184\209\142 \208\190\208\191\209\139\209\130\208\176 \208\178 \209\135\208\176\209\129"
L["HallComander Quick Mission Completion"] = "Hall Comander \208\145\209\139\209\129\209\130\209\128\208\190\208\181 \208\183\208\176\208\178\208\181\209\128\209\136\208\181\208\189\208\184\208\181 \208\188\208\184\209\129\209\129\208\184\208\185"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "\208\149\209\129\208\187\208\184 %1$s \208\188\208\181\208\189\209\140\209\136\208\181 \209\141\209\130\208\190\208\179\208\190 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\209\143, \209\130\208\190 \208\188\209\139 \208\191\208\190\208\191\209\128\208\190\208\177\209\131\208\181\208\188 \208\191\208\190\208\187\209\131\209\135\208\184\209\130\209\140 \209\133\208\190\209\130\209\143 \208\177\209\139 %2$s \208\189\208\181 \208\191\209\128\208\181\208\178\208\190\209\129\209\133\208\190\208\180\209\143 100%%. \208\152\208\179\208\189\208\190\209\128\208\184\209\128\209\131\208\181\209\130\209\129\209\143 \208\180\208\187\209\143 \209\141\208\187\208\184\209\130\208\189\209\139\209\133 \208\183\208\176\208\180\208\176\208\189\208\184\208\185"
L["If not checked, inactive followers are used as last chance"] = "\208\149\209\129\208\187\208\184 \209\141\209\130\208\190\209\130 \209\132\208\187\208\176\208\182\208\190\208\186 \208\189\208\181 \209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\187\208\181\208\189, \209\130\208\190 \208\189\208\181\208\176\208\186\209\130\208\184\208\178\208\189\209\139\208\181 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\184 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\209\131\209\142\209\130\209\129\209\143 \208\178 \208\191\208\190\209\129\208\187\208\181\208\180\208\189\209\142\209\142 \208\190\209\135\208\181\209\128\208\181\208\180\209\140"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[\208\149\209\129\208\187\208\184 \208\146\208\176\209\136 %s \209\129\208\187\208\184\209\136\208\186\208\190\208\188 \208\188\208\176\208\187, \208\178\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\191\208\190\209\130\208\181\209\128\209\143\209\130\209\140 \208\184\209\133
\208\169\208\181\208\187\208\186\208\189\208\184\209\130\208\181 %s \208\180\208\187\209\143 \208\191\209\128\208\181\209\128\209\139\208\178\208\176\208\189\208\184\209\143]=]
L["Ignore busy followers"] = "\208\152\208\179\208\189\208\190\209\128\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \208\183\208\176\208\189\209\143\209\130\209\139\209\133 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178"
L["Ignore inactive followers"] = "\208\152\208\179\208\189\208\190\209\128\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \208\189\208\181\208\176\208\186\209\130\208\184\208\178\208\189\209\139\209\133 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178"
L["Keep cost low"] = "\208\148\208\181\209\136\209\145\208\178\209\139\208\181 \208\183\208\176\208\180\208\176\208\189\208\184\209\143"
L["Keep extra bonus"] = "\208\148\208\190\208\191\208\190\208\187\208\189\208\184\209\130\208\181\208\187\209\140\208\189\208\176\209\143 \208\180\208\190\208\177\209\139\209\135\208\176"
L["Keep time short"] = "\208\154\208\190\209\128\208\190\209\130\208\186\208\184\208\181 \208\183\208\176\208\180\208\176\208\189\208\184\209\143"
L["Keep time VERY short"] = "\208\163\208\188\208\181\208\189\209\140\209\136\208\176\209\130\209\140 \208\178\209\128\208\181\208\188\209\143 \208\183\208\176\208\180\208\176\208\189\208\184\209\143"
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = "\208\151\208\176\208\191\209\131\209\129\209\130\208\184\209\130\209\140 \208\191\208\181\209\128\208\178\209\131\209\142 \208\183\208\176\208\191\208\190\208\187\208\189\208\181\208\189\208\189\209\131\209\142 \208\179\209\128\209\131\208\191\208\191\209\131 \208\178\209\139\208\191\208\190\208\187\208\189\209\143\209\130\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\208\181 \209\129 \208\191\208\190 \208\186\209\128\208\176\208\185\208\189\208\181\208\185 \208\188\208\181\209\128\208\181 \208\190\208\180\208\189\208\184\208\188 \208\183\208\176\208\177\208\187\208\190\208\186\208\184\209\128\208\190\208\178\208\176\208\189\208\189\209\139\208\188 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\188. \208\148\208\181\209\128\208\182\208\184\209\130\208\181 \208\186\208\189\208\190\208\191\208\186\209\131 %s \208\189\208\176\208\182\208\176\209\130\208\190\208\185 \208\180\208\187\209\143 \208\189\208\176\209\135\208\176\208\187\208\176 \208\178\209\139\208\191\208\190\208\187\208\189\208\181\208\189\208\184\209\143 (\208\191\209\128\208\190\209\129\209\130\208\190\208\181 \208\189\208\176\208\182\208\176\209\130\208\184\208\181 \208\188\209\139\209\136\208\186\208\184 \208\178\209\139\208\178\208\181\208\180\208\181\209\130 \209\130\208\190\208\187\209\140\208\186\208\190 \208\184\208\188\209\143 \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \209\129\208\190 \209\129\208\191\208\184\209\129\208\186\208\190\208\188 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178)"
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = "\208\151\208\176\208\191\209\131\209\129\209\130\208\184\209\130\209\140 \208\191\208\181\209\128\208\178\209\131\209\142 \208\183\208\176\208\191\208\190\208\187\208\189\208\181\208\189\208\189\209\131\209\142 \208\179\209\128\209\131\208\191\208\191\209\131 \208\178\209\139\208\191\208\190\208\187\208\189\209\143\209\130\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\208\181 \209\129 \208\191\208\190 \208\186\209\128\208\176\208\185\208\189\208\181\208\185 \208\188\208\181\209\128\208\181 \208\190\208\180\208\189\208\184\208\188 \208\183\208\176\208\177\208\187\208\190\208\186\208\184\209\128\208\190\208\178\208\176\208\189\208\189\209\139\208\188 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\188. \208\148\208\181\209\128\208\182\208\184\209\130\208\181 \208\186\208\189\208\190\208\191\208\186\209\131 Shift \208\189\208\176\208\182\208\176\209\130\208\190\208\185 \208\180\208\187\209\143 \208\189\208\176\209\135\208\176\208\187\208\176 \208\178\209\139\208\191\208\190\208\187\208\189\208\181\208\189\208\184\209\143 (\208\191\209\128\208\190\209\129\209\130\208\190\208\181 \208\189\208\176\208\182\208\176\209\130\208\184\208\181 \208\188\209\139\209\136\208\186\208\184 \208\178\209\139\208\178\208\181\208\180\208\181\209\130 \209\130\208\190\208\187\209\140\208\186\208\190 \208\184\208\188\209\143 \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \209\129\208\190 \209\129\208\191\208\184\209\129\208\186\208\190\208\188 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178)"
L["Level"] = "\208\163\209\128\208\190\208\178\208\181\208\189\209\140"
L["Lock all"] = "\208\151\208\176\208\177\208\187\208\190\208\186\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \208\178\209\129\208\181\209\133"
L["Lock this follower"] = "\208\151\208\176\208\177\208\187\208\190\208\186\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \209\141\209\130\208\190\208\179\208\190 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\176"
L["Locked follower are only used in this mission"] = "\208\151\208\176\208\177\208\187\208\190\208\186\208\184\209\128\208\190\208\178\208\176\208\189\208\189\209\139\208\185 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\181\209\130\209\129\209\143 \209\130\208\190\208\187\209\140\208\186\208\190 \208\178 \209\141\209\130\208\190\208\188 \208\183\208\176\208\180\208\176\208\189\208\184\208\184"
L["Make Order Hall Mission Panel movable"] = "\208\161\208\180\208\181\208\187\208\176\209\130\209\140 \208\191\208\176\208\189\208\181\208\187\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\208\185 \208\190\208\191\208\187\208\190\209\130\208\176 \208\186\208\187\208\176\209\129\209\129\208\176 \208\191\208\181\209\128\208\181\208\188\208\181\209\137\208\176\208\181\208\188\208\190\208\185"
L["Makes sure that no troops will be killed"] = "\208\147\208\176\209\128\208\176\208\189\209\130\208\184\209\128\209\131\208\181\209\130, \209\135\209\130\208\190 \208\189\208\184\208\186\208\176\208\186\208\184\208\181 \208\178\208\190\208\185\209\129\208\186\208\176 \208\189\208\181 \208\177\209\131\208\180\209\131\209\130 \209\131\208\177\208\184\209\130\209\139"
L["Max champions"] = "\208\156\208\176\208\186\209\129\208\184\208\188\208\176\208\187\209\140\208\189\208\190 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178"
L["Maximize xp gain"] = "\208\156\208\176\208\186\209\129\208\184\208\188\208\184\208\183\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \208\191\208\190\208\187\209\131\209\135\208\176\208\181\208\188\209\139\208\185 \208\190\208\191\209\139\209\130"
L["Mission duration reduced"] = "\208\161\208\190\208\186\209\128\208\176\209\137\208\181\208\189\208\176 \208\191\209\128\208\190\208\180\208\190\208\187\208\182\208\184\209\130\208\181\208\187\209\140\208\189\208\190\209\129\209\130\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\209\143"
L["Mission was capped due to total chance less than"] = "\208\156\208\184\209\129\209\129\208\184\209\143 \208\177\209\139\208\187\208\176 \208\190\208\179\209\128\208\176\208\189\208\184\209\135\208\181\208\189\208\176 \208\184\208\183-\208\183\208\176 \208\190\208\177\209\137\208\181\208\179\208\190 \209\136\208\176\208\189\209\129\208\176 \208\188\208\181\208\189\209\140\209\136\208\181 \209\135\208\181\208\188"
L["Missions"] = "\208\151\208\176\208\180\208\176\208\189\208\184\209\143"
L["Never kill Troops"] = "\208\157\208\184\208\186\208\190\208\179\208\180\208\176 \208\189\208\181 \209\131\208\177\208\184\208\178\208\176\209\130\209\140 \208\178\208\190\208\185\209\129\208\186\208\176"
L["No follower gained xp"] = "\208\151\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\184 \208\189\208\181 \208\191\208\190\208\187\209\131\209\135\208\184\208\187\208\184 \208\190\208\191\209\139\209\130"
L["No suitable missions. Have you reserved at least one follower?"] = "\208\157\208\181\209\130 \208\191\208\190\208\180\209\133\208\190\208\180\209\143\209\137\208\184\209\133 \208\188\208\184\209\129\209\129\208\184\208\185. \208\146\209\139 \208\183\208\176\209\128\208\181\208\183\208\181\209\128\208\178\208\184\209\128\208\190\208\178\208\176\208\187\208\184 \209\133\208\190\209\130\209\143 \208\177\209\139 \208\190\208\180\208\189\208\190\208\179\208\190 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\176?"
L["Not blacklisted"] = "\208\157\208\181 \208\178 \209\135\209\145\209\128\208\189\208\190\208\188 \209\129\208\191\208\184\209\129\208\186\208\181"
L["Nothing to report"] = "\208\145\208\181\208\183 \208\190\209\130\209\135\209\145\209\130\208\176"
L["Notifies you when you have troops ready to be collected"] = "\208\163\208\178\208\181\208\180\208\190\208\188\208\187\209\143\209\130\209\140 \208\146\208\176\209\129, \208\186\208\190\208\179\208\180\208\176 \208\184\208\188\208\181\209\142\209\130\209\129\209\143 \208\179\208\190\209\130\208\190\208\178\209\139\208\181 \208\186 \209\129\208\177\208\190\209\128\209\131 \208\178\208\190\208\185\209\129\208\186\208\176"
L["Only accept missions with time improved"] = "\208\159\209\128\208\184\208\189\208\184\208\188\208\176\209\130\209\140 \209\130\208\190\208\187\209\140\208\186\208\190 \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \209\129 \209\131\208\187\209\131\209\135\209\136\208\181\208\189\208\189\209\139\208\188 \208\178\209\128\208\181\208\188\208\181\208\189\208\181\208\188"
L["Only consider elite missions"] = "\208\163\209\135\208\184\209\130\209\139\208\178\208\176\209\130\209\140 \209\130\208\190\208\187\209\140\208\186\208\190 \209\141\208\187\208\184\209\130\208\189\209\139\208\181 \208\183\208\176\208\180\208\176\208\189\208\184\209\143"
L["Only use champions even if troops are available"] = "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \209\130\208\190\208\187\209\140\208\186\208\190 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178, \208\180\208\176\208\182\208\181 \208\181\209\129\208\187\208\184 \208\178\208\190\208\185\209\129\208\186\208\176 \208\180\208\190\209\129\209\130\209\131\208\191\208\189\209\139"
L["Open configuration"] = "\208\158\209\130\208\186\209\128\209\139\209\130\209\140 \208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184"
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[Order Hall Commander \208\191\208\181\209\128\208\181\208\190\208\191\209\128\208\181\208\180\208\181\208\187\209\143\208\181\209\130 Garrison Commander \208\180\208\187\209\143 \209\131\208\191\209\128\208\176\208\178\208\187\208\181\208\189\208\184\209\143 \208\183\208\176\208\186\208\176\208\183\208\176\208\188\208\184.
 \208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\178\208\181\209\128\208\189\209\131\209\130\209\140\209\129\209\143 \208\186 Garrison Commander, \208\191\209\128\208\190\209\129\209\130\208\190 \208\190\209\130\208\186\208\187\209\142\209\135\208\184\208\178 Orderhall Commander.
\208\149\209\129\208\187\208\184 \208\178\208\176\208\188 \208\189\209\128\208\176\208\178\208\184\209\130\209\129\209\143 Order Hall Commander, \208\189\208\181 \208\183\208\176\208\177\209\131\208\180\209\140\209\130\208\181 \208\180\208\190\208\177\208\176\208\178\208\184\209\130\209\140 \208\181\208\179\208\190 \208\178 \208\186\208\187\208\184\208\181\208\189\209\130 Twitch \208\184 \208\190\208\177\208\189\208\190\208\178\208\184\209\130\209\140 \208\181\208\179\208\190]=]
L["Original method"] = "\208\158\208\177\209\139\209\135\208\189\209\139\208\185 \208\188\208\181\209\130\208\190\208\180"
L["Position is not saved on logout"] = "\208\159\208\190\208\187\208\190\208\182\208\181\208\189\208\184\208\181 \208\189\208\181 \209\129\208\190\209\133\209\128\208\176\208\189\209\143\208\181\209\130\209\129\209\143 \208\191\209\128\208\184 \208\178\209\139\209\133\208\190\208\180\208\181"
L["Prefer high durability"] = "\208\159\209\128\208\181\208\180\208\191\208\190\209\135\208\181\209\129\209\130\209\140 \208\178\208\190\208\185\209\129\208\186\208\176 \209\129 \208\177\208\190\208\187\209\140\209\136\208\184\208\188 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190\208\188 \208\181\208\180\208\184\208\189\208\184\209\134 \208\183\208\180\208\190\209\128\208\190\208\178\209\140\209\143"
L["Quick start first mission"] = "\208\145\209\139\209\129\209\130\209\128\208\190\208\181 \208\189\208\176\209\135\208\176\208\187\208\190 \208\191\208\181\209\128\208\178\208\190\208\179\208\190 \208\183\208\176\208\180\208\176\208\189\208\184\209\143"
L["Remove no champions warning"] = "\208\158\209\130\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\191\209\128\208\181\208\180\209\131\208\191\209\128\208\181\208\182\208\180\208\181\208\189\208\184\208\181 \208\190\208\177 \208\190\209\130\209\129\209\131\209\130\209\129\209\130\208\178\208\184\208\184 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178"
L["Restart tutorial from beginning"] = "\208\159\208\181\209\128\208\181\208\183\208\176\208\191\209\131\209\129\209\130\208\184\209\130\209\140 \208\184\208\189\209\129\209\130\209\128\209\131\208\186\209\134\208\184\208\184 \209\129 \208\189\208\176\209\135\208\176\208\187\208\176"
L["Resume tutorial"] = "\208\146\208\190\208\183\208\190\208\177\208\189\208\190\208\178\208\184\209\130\209\140 \208\184\208\189\209\129\209\130\209\128\209\131\208\186\209\134\208\184\208\184"
L["Resurrect troops effect"] = "\208\173\209\132\209\132\208\181\208\186\209\130 \208\178\208\190\209\129\208\186\209\128\208\181\209\136\208\181\208\189\208\184\209\143 \208\178\208\190\208\185\209\129\208\186"
L["Reward type"] = "\208\157\208\176\208\179\209\128\208\176\208\180\208\176"
L["Sets all switches to a very permissive setup"] = "\208\163\209\129\209\130\208\176\208\189\208\190\208\178\208\184\209\130\209\140 \208\178\209\129\208\181 \208\191\208\181\209\128\208\181\208\186\208\187\209\142\209\135\208\176\209\130\208\181\208\187\208\184 \209\130\208\176\208\186, \209\135\209\130\208\190\208\177\209\139 \208\191\209\128\208\181\208\180\208\190\209\129\209\130\208\176\208\178\208\184\209\130\209\140 \208\177\208\190\208\187\209\140\209\136\209\131\209\142 \208\178\208\190\208\183\208\188\208\190\208\182\208\189\208\190\209\129\209\130\209\140 \208\188\208\176\208\189\209\145\208\178\209\128\208\176"
L["Show tutorial"] = "\208\159\208\190\208\186\208\176\208\183\208\176\209\130\209\140 \209\129\208\177\208\190\209\128\208\189\208\184\208\186 \208\184\208\189\209\129\209\130\209\128\209\131\208\186\209\134\208\184\208\185"
L["Show/hide OrderHallCommander mission menu"] = "\208\158\209\130\208\190\208\177\209\128\208\176\208\183\208\184\209\130\209\140/\209\129\208\186\209\128\209\139\209\130\209\140 \208\188\208\181\208\189\209\142 \208\183\208\176\208\180\208\176\208\189\208\184\208\185 Order Hall Commander"
L["Sort missions by:"] = "\208\161\208\190\209\128\209\130\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \208\191\208\190:"
L["Started with "] = "\208\157\208\176\209\135\208\176\208\187\208\184 \209\129"
L["Success Chance"] = "\208\168\208\176\208\189\209\129 \209\131\209\129\208\191\208\181\209\133\208\176"
L["Troop ready alert"] = "\208\158\208\191\208\190\208\178\208\181\209\137\208\181\208\189\208\184\208\181 \208\190 \208\179\208\190\209\130\208\190\208\178\208\189\208\190\209\129\209\130\208\184 \208\178\208\190\208\185\209\129\208\186"
L["Unable to fill missions, raise \"%s\""] = "\208\157\208\181 \209\131\208\180\208\176\208\181\209\130\209\129\209\143 \208\183\208\176\208\191\208\190\208\187\208\189\208\184\209\130\209\140 \208\179\209\128\209\131\208\191\208\191\209\139 \208\183\208\176\208\180\208\176\208\189\208\184\208\185. \208\159\208\190\208\178\209\139\209\129\209\140\209\130\208\181 %s"
L["Unable to fill missions. Check your switches"] = "\208\157\208\181 \209\131\208\180\208\176\208\181\209\130\209\129\209\143 \208\183\208\176\208\191\208\190\208\187\208\189\208\184\209\130\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\209\143. \208\159\209\128\208\190\208\178\208\181\209\128\209\140\209\130\208\181 \208\191\208\176\209\128\208\176\208\188\208\181\209\130\209\128\209\139"
L["Unable to start mission, aborting"] = "\208\157\208\181\208\178\208\190\208\183\208\188\208\190\208\182\208\189\208\190 \208\189\208\176\209\135\208\176\209\130\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\208\181, \208\190\209\130\208\188\208\181\208\189\209\143\208\181\208\188"
L["Unlock all"] = "\208\160\208\176\208\183\208\177\208\187\208\190\208\186\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \208\178\209\129\208\181\209\133"
L["Unlock this follower"] = "\208\160\208\176\208\183\208\177\208\187\208\190\208\186\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \209\141\209\130\208\190\208\179\208\190 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\176"
L["Unlocks all follower and slots at once"] = "\208\160\208\176\208\183\208\177\208\187\208\190\208\186\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \209\129\209\128\208\176\208\183\209\131 \208\178\209\129\208\181\209\133 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178 \208\184 \209\129\208\187\208\190\209\130\209\139"
L["Upgrading to |cff00ff00%d|r"] = "\208\158\208\177\208\189\208\190\208\178\208\187\208\181\208\189\208\184\208\181 \208\180\208\190 |cff00ff00%d|r"
L["URL Copy"] = "\208\154\208\190\208\191\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \209\129\209\129\209\139\208\187\208\186\209\131"
L["Use at most this many champions"] = "\208\157\208\176\209\129\208\186\208\190\208\187\209\140\208\186\208\190 \208\188\208\189\208\190\208\179\208\190 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178"
L["Use combat ally"] = "\208\145\208\190\208\181\208\178\208\190\208\185 \209\129\208\191\209\131\209\130\208\189\208\184\208\186"
L["Use this slot"] = "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \209\141\209\130\208\190\209\130 \209\129\208\187\208\190\209\130"
L["Uses troops with the highest durability instead of the ones with the lowest"] = "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\181\209\130 \208\178\208\190\208\185\209\129\208\186\208\176 \209\129 \208\188\208\176\208\186\209\129\208\184\208\188\208\176\208\187\209\140\208\189\209\139\208\188 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190\208\188 \208\181\208\180\208\184\208\189\208\184\209\134 \208\183\208\180\208\190\209\128\208\190\208\178\209\140\209\143 \208\178\208\188\208\181\209\129\209\130\208\190 \208\178\208\190\208\185\209\129\208\186 \209\129 \208\188\208\184\208\189\208\184\208\188\208\176\208\187\209\140\208\189\209\139\208\188 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190\208\188 \208\181\208\180\208\184\208\189\208\184\209\134 \208\183\208\180\208\190\209\128\208\190\208\178\209\140\209\143."
L["When no free followers are available shows empty follower"] = "\208\149\209\129\208\187\208\184 \209\129\208\178\208\190\208\177\208\190\208\180\208\189\209\139\208\181 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\184 \208\189\208\181\208\180\208\190\209\129\209\130\209\131\208\191\208\189\209\139,\209\130\208\190 \208\190\209\130\208\190\208\177\209\128\208\176\208\182\208\176\208\181\209\130\209\129\209\143 \208\191\209\131\209\129\209\130\208\190\208\181 \208\188\208\181\209\129\209\130\208\190"
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "\208\149\209\129\208\187\208\184 \208\188\209\139 \208\189\208\181 \208\178 \209\129\208\190\209\129\209\130\208\190\209\143\208\189\208\184\208\184 \208\180\208\190\209\129\209\130\208\184\209\135\209\140 \208\183\208\176\208\191\209\128\208\190\209\136\208\181\208\189\208\189\209\139\208\185 %1$s, \209\130\208\190 \208\188\209\139 \208\191\208\190\208\191\209\128\208\190\208\177\209\131\208\181\208\188 \208\191\208\190 \208\186\209\128\208\176\208\185\208\189\208\181\208\185 \208\188\208\181\209\128\208\181 \208\191\208\190\208\187\209\131\209\135\208\184\209\130\209\140 \208\177\208\190\208\187\209\140\209\136\208\181 100%% (\208\181\209\129\208\187\208\184 \208\178\208\190\208\183\208\188\208\190\208\182\208\189\208\190)"
L["Would start with "] = "\208\157\208\176\209\135\208\189\209\145\208\188 \209\129 \209\130\208\190\208\179\208\190, \209\135\209\130\208\190"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "\208\146\209\139 \209\130\208\181\209\128\209\143\208\181\209\130\208\181 |cffff0000%d|cffffd200 \208\190\209\135\208\186\208\190\208\178 !!!"
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[\208\146\208\176\208\188 \208\189\208\181\208\190\208\177\209\133\208\190\208\180\208\184\208\188\208\190 \208\183\208\176\208\186\209\128\209\139\209\130\209\140 \208\184 \208\191\208\181\209\128\208\181\208\183\208\176\208\191\209\131\209\129\209\130\208\184\209\130\209\140 World of Warcraft, \209\135\209\130\208\190\208\177\209\139 \208\190\208\177\208\189\208\190\208\178\208\184\209\130\209\140 \209\141\209\130\209\131 \208\178\208\181\209\128\209\129\208\184\209\142 Order Hall Commander.
\208\148\208\190\209\129\209\130\208\176\209\130\208\190\209\135\208\189\208\190 \208\191\208\181\209\128\208\181\208\183\208\176\208\191\209\131\209\129\209\130\208\184\209\130\209\140 \208\179\209\128\208\176\209\132\208\184\209\135\208\181\209\129\208\186\208\184\208\185 \208\184\208\189\209\130\208\181\209\128\209\132\208\181\208\185\209\129]=]
L["You now need to press both %s and %s to start mission"] = "\208\157\208\181\208\190\208\177\209\133\208\190\208\180\208\184\208\188\208\190 \208\189\208\176\208\182\208\176\209\130\209\140 %s \208\184 %s \208\180\208\187\209\143 \208\183\208\176\208\191\209\131\209\129\208\186\208\176 \208\183\208\176\208\180\208\176\208\189\208\184\209\143"

-- Tutorial
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = "\208\159\208\181\209\128\208\181\208\186\208\187\209\142\209\135\208\176\209\130\208\181\208\187\208\184 %1$s \208\184 %2$s \208\180\208\181\208\185\209\129\209\130\208\178\209\131\209\142\209\130 \208\178\208\188\208\181\209\129\209\130\208\181, \209\135\209\130\208\190\208\177\209\139 \208\189\208\176\209\129\209\130\209\128\208\190\208\184\209\130\209\140, \208\186\208\176\208\186 \208\146\209\139 \209\133\208\190\209\130\208\184\209\130\208\181 \208\190\209\130\209\132\208\184\208\187\209\140\209\130\209\128\208\190\208\178\208\176\209\130\209\140 \208\146\208\176\209\136\208\184 \208\183\208\176\208\180\208\176\208\189\208\184\209\143. \208\151\208\189\208\176\209\135\208\181\208\189\208\184\208\181, \209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\187\208\181\208\189\208\189\208\190\208\181 \208\178\208\176\208\188\208\184 \208\180\208\187\209\143 %1$s (\209\129\208\181\208\185\209\135\208\176\209\129 \209\128\208\176\208\178\208\189\208\190 %3$s%%), \209\143\208\178\208\187\209\143\208\181\209\130\209\129\209\143 \208\188\208\184\208\189\208\184\208\188\208\176\208\187\209\140\208\189\209\139\208\188 \208\191\209\128\208\184\208\181\208\188\208\187\208\181\208\188\209\139\208\188 \209\136\208\176\208\189\209\129\208\190\208\188 \208\191\209\128\208\184 \208\191\208\190\208\187\209\131\209\135\208\181\208\189\208\184\208\184 \208\177\208\190\208\189\209\131\209\129\208\176, \208\178 \209\130\208\190 \208\178\209\128\208\181\208\188\209\143 \208\186\208\176\208\186 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\208\181, \209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\187\208\181\208\189\208\189\208\190\208\181 \208\180\208\187\209\143 %2$s (\209\129\208\181\208\185\209\135\208\176\209\129 \209\128\208\176\208\178\208\189\208\190 %4$s%%), \209\143\208\178\208\187\209\143\208\181\209\130\209\129\209\143 \209\136\208\176\208\189\209\129\208\190\208\188, \208\186\208\190\209\130\208\190\209\128\209\139\208\185 \208\146\209\139 \209\133\208\190\209\130\208\184\209\130\208\181 \208\191\208\190\208\187\209\131\209\135\208\184\209\130\209\140, \208\186\208\190\208\179\208\180\208\176 \208\178\209\139 \209\130\208\181\209\128\209\143\208\181\209\130\208\181 \208\177\208\190\208\189\209\131\209\129 (\208\191\208\190 \208\191\209\128\208\184\209\135\208\184\208\189\208\181 \208\189\208\181\208\180\208\190\209\129\209\130\208\176\209\130\208\190\209\135\208\189\208\190\208\179\208\190 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\176 \209\129\208\184\208\187\209\140\208\189\209\139\209\133 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178)."
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[\208\151\208\176\208\191\209\128\208\190\209\136\208\181\208\189\208\189\208\190\208\181 \208\190\208\186\208\189\208\190 \208\189\208\181 \208\190\209\130\208\186\209\128\209\139\209\130\208\190.
\208\152\208\189\209\129\209\130\209\128\209\131\208\186\209\134\208\184\208\184 \208\191\209\128\208\190\208\180\208\190\208\187\208\182\208\176\209\130\209\129\209\143 \209\130\208\176\208\186 \209\129\208\186\208\190\209\128\208\190 \208\186\208\176\208\186 \209\130\208\190\208\187\209\140\208\186\208\190 \208\178\208\190\208\183\208\188\208\190\208\182\208\189\208\190.]=]
L["Base Chance"] = "\208\145\208\176\208\183\208\190\208\178\209\139\208\185 \209\136\208\176\208\189\209\129."
L["Bonus Chance"] = "\208\145\208\190\208\189\209\131\209\129\208\189\209\139\208\185 \209\136\208\176\208\189\209\129."
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[\208\157\208\176\208\182\208\176\209\130\208\184\208\181 \208\186\208\189\208\190\208\191\208\186\208\184 \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \209\129\208\190\208\191\208\190\209\129\209\130\208\176\208\178\208\184\209\130 \209\131\208\186\208\176\208\183\208\176\208\189\208\189\209\139\209\133 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178 \209\130\208\181\208\186\209\131\209\137\208\181\208\188\209\131 \208\183\208\176\208\180\208\176\208\189\208\184\209\142.
\208\152\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\185\209\130\208\181 \209\141\209\130\208\190, \209\135\209\130\208\190\208\177\209\139 \208\191\209\128\208\190\208\178\208\181\209\128\208\184\209\130\209\140 \209\129\208\190\208\190\209\130\208\178\208\181\209\130\209\129\209\130\208\178\208\184\208\181 \209\128\208\176\209\129\209\129\209\135\208\184\209\130\208\176\208\189\208\189\209\139\209\133 Order Hall Commander \209\136\208\176\208\189\209\129\208\190\208\178 \209\128\208\181\208\176\208\187\209\140\208\189\209\139\208\188 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\209\143\208\188 \209\129 \208\191\208\190\208\188\208\190\209\137\209\140\209\142 Blizzard.
\208\149\209\129\208\187\208\184 \208\180\208\176\208\189\208\189\209\139\208\181 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\209\143 \208\190\209\130\208\187\208\184\209\135\208\176\209\142\209\130\209\129\209\143, \208\191\209\128\208\190\209\136\209\131 \208\190\209\130\208\186\209\128\209\139\209\130\209\140 \208\177\208\184\208\187\208\181\209\130 \208\191\209\128\208\184\208\187\208\190\208\182\208\184\208\178 \209\129\208\189\208\184\208\188\208\190\208\186 \209\141\208\186\209\128\208\176\208\189\208\176.]=]
L["Counter Kill Troops"] = "\208\159\209\128\208\181\208\180\209\131\208\191\209\128\208\181\208\180\208\184\209\130\209\140 \209\129\208\188\208\181\209\128\209\130\209\140 \208\178\208\190\208\185\209\129\208\186."
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[\208\158\208\177\208\188\209\131\208\189\208\180\208\184\209\128\208\190\208\178\208\176\208\189\208\184\208\181 \208\184 \208\190\208\177\208\189\208\190\208\178\208\187\208\181\208\189\208\184\209\143 \208\191\208\181\209\128\208\181\209\135\208\184\209\129\208\187\208\181\208\189\209\139 \208\183\208\180\208\181\209\129\209\140 \208\178 \208\178\208\184\208\180\208\181 \208\186\208\189\208\190\208\191\208\190\208\186. \208\146 \209\129\208\178\209\143\208\183\208\184 \209\129 \208\191\209\128\208\190\208\177\208\187\208\181\208\188\208\190\208\185 \209\129 \209\129\208\184\209\129\209\130\208\181\208\188\208\190\208\185 Blizzard Taint, \208\191\208\181\209\128\208\181\209\130\208\176\209\129\208\186\208\184\208\178\208\176\208\189\208\184\208\181 \208\184 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\208\189\208\184\208\181 \208\184\208\183 \209\129\209\131\208\188\208\190\208\186 \208\178\209\139\208\183\209\139\208\178\208\176\208\181\209\130 \208\190\209\136\208\184\208\177\208\186\209\131.
\208\149\209\129\208\187\208\184 \208\146\209\139 \208\191\208\181\209\128\208\181\209\130\208\176\209\129\208\186\208\184\208\178\208\176\208\181\209\130\208\181 \208\184 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\181\209\130\208\181 \208\191\209\128\208\181\208\180\208\188\208\181\209\130 \208\184\208\183 \209\129\209\131\208\188\208\186\208\184, \208\186\208\190\209\130\208\190\209\128\209\139\208\185 \208\189\208\181 \208\190\209\130\208\190\208\177\209\128\208\176\208\182\209\145\208\189 (\208\188\209\139 \208\190\208\177\208\189\208\190\208\178\208\187\209\143\208\181\208\188 \209\129\208\191\208\184\209\129\208\190\208\186 \208\180\208\190\209\129\209\130\208\176\209\130\208\190\209\135\208\189\208\190 \209\135\208\176\209\129\209\130\208\190, \208\189\208\190 \208\184\208\189\208\190\208\179\208\180\208\176 Blizzard \208\177\209\139\209\129\209\130\209\128\208\181\208\181), \208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\189\208\176\208\182\208\176\209\130\209\140 \208\191\209\128\208\176\208\178\209\131\209\142 \208\186\208\189\208\190\208\191\208\186\209\131 \208\188\209\139\209\136\208\186\208\184 \208\189\208\176 \208\178\208\181\209\137\208\184 \208\178 \209\129\209\131\208\188\208\186\208\181 \208\184 \208\189\208\176\208\182\208\176\209\130\209\140 \208\187\208\181\208\178\209\131\209\142 \208\186\208\189\208\190\208\191\208\186\209\131 \208\188\209\139\209\136\208\186\208\184 \208\189\208\176 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\181.
\208\162\208\176\208\186\208\184\208\188 \208\190\208\177\209\128\208\176\208\183\208\190\208\188 \208\178\209\139 \208\190\209\136\208\184\208\177\208\186\208\176 \208\189\208\181 \208\191\209\128\208\190\208\184\208\183\208\190\208\185\208\180\209\145\209\130.]=]
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[\208\173\208\186\208\184\208\191\208\184\209\128\208\190\208\178\208\186\208\176 \208\184 \209\129\208\189\208\176\209\128\209\143\208\182\208\181\208\189\208\184\208\181 \208\191\208\181\209\128\208\181\209\135\208\184\209\129\208\187\208\181\208\189\209\139 \208\183\208\180\208\181\209\129\209\140 \208\178 \208\178\208\184\208\180\208\181 \208\186\208\189\208\190\208\191\208\190\208\186, \208\186\208\190\209\130\208\190\209\128\209\139\208\181 \208\188\208\190\208\179\209\131\209\130 \208\177\209\139\209\130\209\140 \208\189\208\176\208\182\208\176\209\130\209\139.
\208\152\208\183-\208\183\208\176 \208\191\209\128\208\190\208\177\208\187\208\181\208\188 \209\129 \209\129\208\184\209\129\209\130\208\181\208\188\208\190\208\185 Blizzard Taint \208\191\209\128\208\184 \208\191\208\181\209\128\208\181\209\130\208\176\209\129\208\186\208\184\208\178\208\176\208\189\208\184\208\184 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\208\176 \208\184\208\183 \209\129\209\131\208\188\208\186\208\184 \208\191\208\190\209\143\208\178\208\187\209\143\208\181\209\130\209\129\209\143 \209\129\208\190\208\190\208\177\209\137\208\181\208\189\208\184\208\181 \208\190\208\177 \208\190\209\136\208\184\208\177\208\186\208\181.
\208\148\208\187\209\143 \209\130\208\190\208\179\208\190, \209\135\209\130\208\190\208\177\209\139 \208\189\208\176\208\183\208\189\208\176\209\135\208\184\209\130\209\140 \209\141\208\186\208\184\208\191\208\184\209\128\208\190\208\178\208\186\209\131, \208\186\208\190\209\130\208\190\209\128\208\190\208\179\208\190 \208\189\208\181\209\130 \208\178 \209\129\208\191\208\184\209\129\208\186\208\181 (\209\143 \209\135\208\176\209\129\209\130\208\190 \208\190\208\177\208\189\208\190\208\178\208\187\209\143\209\142 \209\129\208\191\208\184\209\129\208\190\208\186, \208\189\208\190 \208\184\208\189\208\190\208\179\208\180\208\176 Blizzard \208\177\209\139\209\129\209\130\209\128\208\181\208\181), \208\188\208\190\208\182\208\189\208\190 \209\137\208\181\208\187\208\186\208\189\209\131\209\130\209\140 \208\191\209\128\208\176\208\178\208\190\208\185 \208\186\208\189\208\190\208\191\208\186\208\190\208\185 \208\189\208\176 \208\191\209\128\208\181\208\180\208\188\208\181\209\130 \208\178 \209\129\209\131\208\188\208\186\208\181, \208\180\208\176\208\187\208\181\208\181 \208\187\208\181\208\178\208\190\208\185 \208\186\208\189\208\190\208\191\208\186\208\190\208\185 \208\189\208\176 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\176.
\208\162\208\176\208\186\208\184\208\188 \208\190\208\177\209\128\208\176\208\183\208\190\208\188, \208\146\209\139 \208\189\208\181 \208\191\208\190\208\187\209\131\209\135\208\184\209\130\208\181 \208\189\208\184\208\186\208\176\208\186\208\184\209\133 \208\190\209\136\208\184\208\177\208\190\208\186]=]
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[\208\148\208\187\209\143 \208\191\209\128\208\184\208\188\208\181\209\128\208\176, \208\188\208\184\209\129\209\129\208\184\209\143 \208\188\208\190\208\182\208\181\209\130 \208\180\208\190\209\129\209\130\208\184\208\179\208\176\209\130\209\140 \208\180\208\190 95%%, 130%% \208\184 180%% \208\178\208\181\209\128\208\190\209\143\209\130\208\189\208\190\209\129\209\130\208\184 \209\131\209\129\208\191\208\181\209\133\208\176.
\208\149\209\129\208\187\208\184 %1$s \208\184\208\188\208\181\208\181\209\130 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\208\181 170%%, \208\180\208\190 180%% \208\190\208\180\208\189\208\190 \208\184\208\183 \209\141\209\130\208\184\209\133 \208\177\209\131\208\180\208\181\209\130 \208\178\209\139\208\177\209\128\208\176\208\189\208\190.
\208\149\209\129\208\187\208\184 %1$s \208\184\208\188\208\181\208\181\209\130 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\208\181 200%% Order Hall Commander \208\191\208\190\208\191\209\139\209\130\208\176\208\181\209\130\209\129\209\143 \208\189\208\176\208\185\209\130\208\184 \208\177\208\187\208\184\208\182\208\176\208\185\209\136\209\131\209\142 \208\186 100%% \209\129\208\190\208\177\208\187\209\142\208\180\208\176\209\143 \208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\209\131 %2$s
\208\149\209\129\208\187\208\184, \208\189\208\176\208\191\209\128\208\184\208\188\208\181\209\128 %2$s \208\184\208\188\208\181\208\181\209\130 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\208\181 100%% \208\184\208\187\208\184 130%% \208\190\208\180\208\189\208\190 \208\184\208\183 \209\141\209\130\208\184\209\133 \208\177\209\131\208\180\208\181\209\130 \208\178\209\139\208\177\209\128\208\176\208\189\208\190, \208\189\208\190 \208\181\209\129\208\187\208\184 %2$s \208\184\208\188\208\181\208\181\209\130 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\208\181 90%% \208\184\208\187\208\184 95%% \208\190\208\180\208\189\208\190 \208\184\208\183 \209\141\209\130\208\184\209\133 \208\177\209\131\208\180\208\181\209\130 \208\178\209\139\208\177\209\128\208\176\208\189\208\190.]=]
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "\208\149\209\129\208\187\208\184 \208\146\209\139 \208\178\209\129\208\181\208\179\208\180\208\176 \209\133\208\190\209\130\208\184\209\130\208\181 \208\178\208\184\208\180\208\181\209\130\209\140 \209\130\208\190\208\187\209\140\208\186\208\190 \208\189\208\176\208\184\208\177\208\190\208\187\208\181\208\181 \208\180\208\190\209\129\209\130\209\131\208\191\208\189\209\139\208\181 \208\180\208\187\209\143 \208\178\209\139\208\191\208\190\208\187\208\189\208\181\208\189\208\184\209\143 \208\183\208\176\208\180\208\176\208\189\208\184\209\143, \209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\184\209\130\208\181 %1$s \208\178 100%% \208\184 %2$s \208\178 0%%."
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[\208\149\209\129\208\187\208\184 \208\146\209\139 \208\189\208\181 \208\191\208\190\208\189\208\184\208\188\208\176\208\181\209\130\208\181, \208\191\208\190\209\135\208\181\208\188\209\131 Order Hall Commander \208\178\209\139\208\177\209\128\208\176\208\187 \209\130\208\176\208\186\209\131\209\142 \208\179\209\128\209\131\208\191\208\191\209\131 \208\180\208\187\209\143 \208\183\208\176\208\180\208\176\208\189\208\184\209\143, \209\130\208\190 \208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\183\208\176\208\191\209\128\208\190\209\129\208\184\209\130\209\140 \208\191\208\190\208\187\208\189\209\139\208\185 \208\176\208\189\208\176\208\187\208\184\208\183.
\208\144\208\189\208\176\208\187\208\184\208\183 \208\179\209\128\209\131\208\191\208\191\209\139 \208\191\208\190\208\186\208\176\208\182\208\181\209\130 \208\178\209\129\208\181 \208\178\208\190\208\183\208\188\208\190\208\182\208\189\209\139\208\181 \208\186\208\190\208\188\208\177\208\184\208\189\208\176\209\134\208\184\208\184 \208\184 \208\186\208\176\208\186 Order Hall Commander \208\191\208\190\208\180\208\190\208\177\209\128\208\176\208\187 \208\184\209\133.]=]
L["Max champions"] = "\208\156\208\176\208\186\209\129\208\184\208\188\208\176\208\187\209\140\208\189\208\190 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178."
L["Maximize xp gain"] = "\208\156\208\176\208\186\209\129\208\184\208\188\208\184\208\183\208\184\209\128\208\190\208\178\208\176\209\130\209\140 \208\191\208\190\208\187\209\131\209\135\208\176\208\181\208\188\209\139\208\185 \208\190\208\191\209\139\209\130."
L["Never kill Troops"] = "\208\157\208\184\208\186\208\190\208\179\208\180\208\176 \208\189\208\181 \209\131\208\177\208\184\208\178\208\176\209\130\209\140 \208\178\208\190\208\185\209\129\208\186\208\176."
L["Prefer high durability"] = "\208\159\209\128\208\181\208\180\208\191\208\190\209\135\208\181\209\129\209\130\209\140 \208\178\208\190\208\185\209\129\208\186\208\176 \209\129 \208\177\208\190\208\187\209\140\209\136\208\184\208\188 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190\208\188 \208\181\208\180\208\184\208\189\208\184\209\134 \208\183\208\180\208\190\209\128\208\190\208\178\209\140\209\143."
L["Restart the tutorial"] = "\208\159\208\181\209\128\208\181\208\183\208\176\208\191\209\131\209\129\209\130\208\184\209\130\209\140 \209\129\208\177\208\190\209\128\208\189\208\184\208\186 \208\184\208\189\209\129\209\130\209\128\209\131\208\186\209\134\208\184\208\185."
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = "\208\161\208\187\208\190\209\130 (\208\189\208\181 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186 \208\178 \208\189\209\145\208\188, \208\176 \208\184\208\188\208\181\208\189\208\189\208\190 \209\129\208\187\208\190\209\130) \208\188\208\190\208\182\208\181\209\130 \208\177\209\139\209\130\209\140 \208\183\208\176\208\177\208\187\208\190\208\186\208\184\209\128\208\190\208\178\208\176\208\189. \208\154\208\190\208\179\208\180\208\176 \208\146\209\139 \208\177\208\187\208\190\208\186\208\184\209\128\209\131\208\181\209\130\208\181 \209\129\208\187\208\190\209\130, \208\190\208\189 \208\189\208\181 \208\177\209\131\208\180\208\181\209\130 \208\183\208\176\208\191\208\190\208\187\208\189\208\181\208\189 \208\180\208\187\209\143 \209\141\209\130\208\190\208\179\208\190 \208\183\208\176\208\180\208\176\208\189\208\184\209\143. \208\152\209\129\208\191\208\190\208\187\209\140\208\183\209\131\209\143 \209\130\208\190\209\130 \209\132\208\176\208\186\209\130, \209\135\209\130\208\190 \208\178\208\190\208\185\209\129\208\186\208\176 \208\178\209\129\208\181\208\179\208\180\208\176 \208\189\208\176\209\133\208\190\208\180\209\143\209\130\209\129\209\143 \208\178 \209\129\208\176\208\188\208\190\208\188 \208\187\208\181\208\178\208\190\208\188 \209\129\208\187\208\190\209\130\208\181 (\209\129\208\187\208\190\209\130\208\176\209\133), \208\178\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\180\208\190\208\177\208\184\209\130\209\140\209\129\209\143 \209\133\208\190\209\128\208\190\209\136\208\181\208\185 \209\129\209\130\208\181\208\191\208\181\208\189\208\184 \208\184\208\189\208\180\208\184\208\178\208\184\208\180\209\131\208\176\208\187\209\140\208\189\208\190\208\179\208\190 \208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184, \209\131\208\188\208\181\208\189\209\140\209\136\208\176\209\143 \208\190\208\177\209\137\208\181\208\181 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178, \208\184\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\181\208\188\209\139\209\133 \208\180\208\187\209\143 \208\183\208\176\208\180\208\176\208\189\208\184\209\143."
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "\208\151\208\176\208\186\209\128\209\139\209\130\209\140 \208\184\208\189\209\129\209\130\209\128\209\131\208\186\209\134\208\184\209\142. \208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\191\209\128\208\190\208\180\208\190\208\187\208\182\208\184\209\130\209\140 \208\178 \208\187\209\142\208\177\208\190\208\181 \208\178\209\128\208\181\208\188\209\143 \208\189\208\176\208\182\208\176\208\178 \208\189\208\176 \208\184\208\186\208\190\208\189\208\186\209\131 \208\184\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\208\184 \208\178 \208\177\208\190\208\186\208\190\208\178\208\190\208\188 \208\188\208\181\208\189\209\142."
L["Thank you for reading this, enjoy %s"] = "\208\161\208\191\208\176\209\129\208\184\208\177\208\190 \208\183\208\176 \208\191\209\128\208\190\209\135\209\130\208\181\208\189\208\184\208\181. \208\157\208\176\209\129\208\187\208\176\208\182\208\180\208\176\208\185\209\130\208\181\209\129\209\140 %s."
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = "\208\158\208\177\209\139\209\135\208\189\208\190 Order Hall Commander \208\191\209\139\209\130\208\176\208\181\209\130\209\129\209\143 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \208\178\208\190\208\185\209\129\208\186\208\176 \209\129 \208\189\208\176\208\184\208\188\208\181\208\189\209\140\209\136\208\184\208\188 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190\208\188 \208\181\208\180\208\184\208\189\208\184\209\134 \208\183\208\180\208\190\209\128\208\190\208\178\209\140\209\143, \209\135\209\130\208\190\208\177\209\139 \208\178\209\139 \208\188\208\190\208\179\208\187\208\184 \208\186\208\176\208\186 \208\188\208\190\208\182\208\189\208\190 \209\129\208\186\208\190\209\128\208\181\208\181 \208\178\208\178\208\181\209\129\209\130\208\184 \208\178 \208\177\208\190\208\185 \208\189\208\190\208\178\209\139\208\181 \208\178\208\190\208\185\209\129\208\186\208\176. \208\159\209\128\208\190\208\178\208\181\209\128\208\186\208\176 %1$s \208\190\209\130\208\188\208\181\208\189\209\143\208\181\209\130 \209\141\209\130\208\190 \208\184 Order Hall Commander \208\178\209\139\208\177\208\181\209\128\208\181\209\130 \208\180\208\187\209\143 \208\186\208\176\208\182\208\180\208\190\208\179\208\190 \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \208\178\208\190\208\185\209\129\208\186\208\176 \209\129 \208\189\208\176\208\184\208\177\208\190\208\187\209\140\209\136\208\184\208\188 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190\208\188 \208\181\208\180\208\184\208\189\208\184\209\134 \208\183\208\180\208\190\209\128\208\190\208\178\209\140\209\143."
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[\208\148\208\190\208\177\209\128\208\190 \208\191\208\190\208\182\208\176\208\187\208\190\208\178\208\176\209\130\209\140 \208\178 \208\189\208\190\208\178\209\139\208\185 \208\178\209\139\208\191\209\131\209\129\208\186 Order Hall Commander
\208\161\208\187\208\181\208\180\209\131\208\185\209\130\208\181 \209\141\209\130\208\190\208\188\209\131 \208\186\209\128\208\176\209\130\208\186\208\190\208\185 \208\184\208\189\209\129\209\130\209\128\209\131\208\186\209\134\208\184\208\184, \209\135\209\130\208\190\208\177\209\139 \209\131\208\183\208\189\208\176\209\130\209\140 \208\178\209\129\208\181 \208\189\208\190\208\178\209\139\208\181 \209\132\209\131\208\189\208\186\209\134\208\184\208\184.
\208\146\209\139 \208\189\208\181 \208\191\208\190\208\182\208\176\208\187\208\181\208\181\209\130\208\181 \208\190\208\177 \209\141\209\130\208\190\208\188]=]
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\209\131\209\143 %1$s, \208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\191\208\190\208\191\209\128\208\190\209\129\208\184\209\130\209\140 \208\178\209\129\208\181\208\179\208\180\208\176 \209\131\209\135\208\184\209\130\209\139\208\178\208\176\209\130\209\140 \208\190\208\191\208\176\209\129\208\189\208\190\209\129\209\130\209\140 \209\129\208\188\208\181\209\128\209\130\208\184 \208\178\208\190\208\185\209\129\208\186. \208\173\209\130\208\190 \208\190\208\183\208\189\208\176\209\135\208\176\208\181\209\130, \209\135\209\130\208\190 Order Hall Commander \208\177\209\131\208\180\208\181\209\130 \208\191\209\139\209\130\208\176\209\130\209\140\209\129\209\143 \209\131\209\135\208\184\209\130\209\139\208\178\208\176\209\130\209\140 \208\181\209\145 \208\184\208\187\208\184 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \208\178\208\190\208\185\209\129\208\186\208\176 \209\129 \208\190\209\129\209\130\208\176\208\178\209\136\208\181\208\185\209\129\209\143 \209\130\208\190\208\187\209\140\208\186\208\190 1 \208\181\208\180\208\184\208\189\208\184\209\134\208\181\208\185 \208\183\208\180\208\190\209\128\208\190\208\178\209\140\209\143. \208\166\208\181\208\187\209\140\209\142 \209\141\209\130\208\190\208\179\208\190 \208\191\208\181\209\128\208\181\208\186\208\187\209\142\209\135\208\176\209\130\208\181\208\187\209\143 \209\143\208\178\208\187\209\143\208\181\209\130\209\129\209\143 \208\191\209\128\208\181\208\180\209\131\208\191\209\128\208\181\208\182\208\180\208\181\208\189\208\184\208\181 \208\191\208\190\209\130\208\181\209\128\208\184 \208\182\208\184\208\183\208\189\208\181\208\189\208\189\209\139\209\133 \209\129\208\184\208\187, \208\189\208\190 \208\189\208\181 \208\191\209\128\208\181\208\180\209\131\208\191\209\128\208\181\208\182\208\180\208\181\208\189\208\184\209\143 \209\129\208\188\208\181\209\128\209\130\208\181\208\185 \208\178\208\190\208\185\209\129\208\186."
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\209\131\209\143 %2$s, \208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\191\208\190\208\191\209\128\208\190\209\129\208\184\209\130\209\140 \208\189\208\184\208\186\208\190\208\179\208\180\208\176 \208\189\208\181 \208\191\208\190\208\183\208\178\208\190\208\187\209\143\209\130\209\140 \209\131\208\188\208\184\209\128\208\176\209\130\209\140 \208\178\208\190\208\185\209\129\208\186\208\176\208\188. \208\173\209\130\208\190 \208\189\208\181 \209\130\208\190\208\187\209\140\208\186\208\190 \208\191\209\128\208\184\208\188\208\181\208\189\209\143\208\181\209\130\209\129\209\143 \208\186 %1$s \208\184 %3$s, \208\189\208\190 \208\183\208\176\209\129\209\130\208\176\208\178\208\187\209\143\208\181\209\130 Order Hall Commander \208\189\208\184\208\186\208\190\208\179\208\180\208\176 \208\189\208\181 \208\190\209\130\208\191\209\128\208\176\208\178\208\187\209\143\209\130\209\140 \208\189\208\176 \208\183\208\176\208\180\208\176\208\189\208\184\208\181 \208\178\208\190\208\185\209\129\208\186\208\176, \208\186\208\190\209\130\208\190\209\128\209\139\208\181 \208\188\208\190\208\179\209\131\209\130 \208\191\208\190\208\179\208\184\208\177\208\189\209\131\209\130\209\140. \208\166\208\181\208\187\209\140\209\142 \209\141\209\130\208\190\208\179\208\190 \208\191\208\181\209\128\208\181\208\186\208\187\209\142\209\135\208\176\209\130\208\181\208\187\209\143 \209\143\208\178\208\187\209\143\208\181\209\130\209\129\209\143 \208\191\209\128\208\181\208\180\209\131\208\191\209\128\208\181\208\182\208\180\208\181\208\189\208\184\208\181 \209\129\208\188\208\181\209\128\209\130\208\181\208\185 \208\178\208\190\208\185\209\129\208\186, \208\180\208\176\208\182\208\181 \208\191\209\131\209\130\209\145\208\188 \208\189\208\181\208\178\208\190\208\183\208\188\208\190\208\182\208\189\208\190\209\129\209\130\208\184 \209\129\208\177\208\190\209\128\208\176 \208\179\209\128\209\131\208\191\208\191\209\139 \208\180\208\187\209\143 \208\183\208\176\208\180\208\176\208\189\208\184\209\143."
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = "\208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\183\208\176\208\189\208\181\209\129\209\130\208\184 \208\178 \209\135\209\145\209\128\208\189\209\139\208\185 \209\129\208\191\208\184\209\129\208\190\208\186 \208\183\208\176\208\180\208\176\208\189\208\184\209\143 \208\189\208\176\208\182\208\176\208\178 \208\191\209\128\208\176\208\178\209\131\209\142 \208\186\208\189\208\190\208\191\208\186\209\131 \208\188\209\139\209\136\208\184. \208\157\208\176\209\135\208\184\208\189\208\176\209\143 \209\129 1.5.1 \208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\189\208\176\209\135\208\176\209\130\209\140 \208\183\208\176\208\180\208\176\208\189\208\184\208\181 \209\129\209\128\208\176\208\183\209\131, \208\189\208\181 \208\183\208\176\209\133\208\190\208\180\209\143 \208\189\208\176 \209\141\208\186\209\128\208\176\208\189 \208\183\208\176\208\180\208\176\208\189\208\184\208\185, \208\183\208\176\208\182\208\176\208\178 \208\186\208\189\208\190\208\191\208\186\209\131 Shift \208\184 \208\178\209\139\208\177\209\128\208\176\208\178 \208\183\208\176\208\180\208\176\208\189\208\184\208\181 \208\188\209\139\209\136\208\186\208\190\208\185. \208\163\208\177\208\181\208\180\208\184\209\130\208\181\209\129\209\140, \209\135\209\130\208\190 \208\191\209\128\208\181\208\180\208\187\208\176\208\179\208\176\208\181\208\188\208\176\209\143 \208\179\209\128\209\131\208\191\208\191\208\176 \208\178\208\176\209\129 \209\131\209\129\209\130\209\128\208\176\208\184\208\178\208\176\208\181\209\130, \209\130\208\176\208\186 \208\186\208\176\208\186 \208\183\208\176\208\180\208\176\208\189\208\184\208\181 \208\189\208\176\209\135\208\189\209\145\209\130\209\129\209\143 \208\177\208\181\208\183 \208\191\208\190\208\180\209\130\208\178\208\181\209\128\208\182\208\180\208\181\208\189\208\184\209\143."
L["You can choose not to use a troop type clicking its icon"] = "\208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\190\209\130\208\188\208\181\208\189\208\184\209\130\209\140 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\208\189\208\184\208\181 \208\178\208\190\208\185\209\129\208\186 \208\189\208\176\208\182\208\176\209\130\208\184\208\181\208\188 \208\189\208\176 \209\141\209\130\209\131 \208\184\208\186\208\190\208\189\208\186\209\131."
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = "\208\146\209\139 \208\188\208\190\208\182\208\181\209\130\208\181 \208\190\208\179\209\128\208\176\208\189\208\184\209\135\208\184\209\130\209\140 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\181\208\188\209\139\209\133 \208\190\208\180\208\189\208\190\208\178\209\128\208\181\208\188\208\181\208\189\208\189\208\190 \208\178 \208\183\208\176\208\180\208\176\208\189\208\184\208\184 \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178. \208\161\208\181\208\185\209\135\208\176\209\129 Order Hall Commander \208\184\209\129\208\191\208\190\208\187\209\140\208\183\209\131\208\181\209\130 \208\189\208\181 \208\177\208\190\208\187\208\181\208\181 %3$s \208\183\208\176\209\137\208\184\209\130\208\189\208\184\208\186\208\190\208\178 \208\178 \208\190\208\180\208\189\208\190\208\188 \208\183\208\176\208\180\208\176\208\189\208\184\208\184. \208\158\208\177\209\128\208\176\209\130\208\184\209\130\208\181 \208\178\208\189\208\184\208\188\208\176\208\189\208\184\208\181, \209\135\209\130\208\190 %2$s \208\184\208\188\208\181\208\181\209\130 \208\177\208\190\208\187\209\140\209\136\208\184\208\185 \208\191\209\128\208\184\208\190\209\128\208\184\209\130\208\181\209\130."

	end
	L=l:NewLocale(me,"zhCN")
	if (L) then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%%\228\189\142\228\186\142%2$d%%\239\188\140\233\153\141\228\189\142%s"
--Translation missing 
-- L["%s for a wowhead link popup"] = ""
L["%s start the mission without even opening the mission page. No question asked"] = "Shift-\231\130\185\229\135\187\229\143\175\228\187\165\228\184\141\230\137\147\229\188\128\228\187\187\229\138\161\233\161\181\233\157\162\229\176\177\229\144\175\229\138\168\228\187\187\229\138\161\227\128\130\230\178\161\230\156\137\233\151\174\233\162\152"
--Translation missing 
-- L["%s starts missions"] = ""
L["%s to blacklist"] = "\231\130\185\229\135\187\229\143\179\233\148\174\229\138\160\229\133\165\233\187\145\229\144\141\229\141\149"
L["%s to remove from blacklist"] = "\231\130\185\229\135\187\229\143\179\233\148\174\228\187\142\233\187\145\229\144\141\229\141\149\228\184\173\229\136\160\233\153\164"
--Translation missing 
-- L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = ""
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s\239\188\140\232\175\183\230\163\128\230\159\165\230\149\153\231\168\139\\n\239\188\136\229\141\149\229\135\187\229\155\190\230\160\135\229\143\150\230\182\136\230\173\164\230\182\136\230\129\175\239\188\137"
--Translation missing 
-- L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = ""
L["Always counter increased resource cost"] = "\230\128\187\230\152\175\229\143\141\229\136\182\229\162\158\229\138\160\232\181\132\230\186\144\232\138\177\232\180\185"
L["Always counter increased time"] = "\230\128\187\230\152\175\229\143\141\229\136\182\229\162\158\229\138\160\228\187\187\229\138\161\230\151\182\233\151\180"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "\230\128\187\230\152\175\229\143\141\229\136\182\230\157\128\230\173\187\233\131\168\233\152\159(\229\166\130\230\158\156\230\136\145\228\187\172\231\148\168\229\143\170\229\137\169\228\184\128\230\172\161\232\128\144\228\185\133\231\154\132\233\131\168\233\152\159\229\136\153\229\191\189\231\149\165)"
L["Always counter no bonus loot threat"] = "\230\128\187\230\152\175\229\143\141\229\136\182\230\178\161\230\156\137\233\162\157\229\164\150\229\165\150\229\138\177\231\154\132\229\168\129\232\131\129"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "\231\165\158\229\153\168\230\152\190\231\164\186\231\154\132\229\128\188\230\152\175\229\159\186\231\161\128\229\128\188\239\188\140\230\178\161\230\156\137\231\187\143\232\191\135\231\165\158\229\153\168\231\159\165\232\175\134\231\154\132\229\138\160\230\136\144"
L["Attempting %s"] = "\229\176\157\232\175\149%s"
L["Base Chance"] = "\229\159\186\231\161\128\230\156\186\231\142\135"
L["Better parties available in next future"] = "\229\156\168\229\176\134\230\157\165\230\156\137\230\155\180\229\165\189\231\154\132\233\152\159\228\188\141"
L["Blacklisted"] = "\229\138\160\229\133\165\233\187\145\229\144\141\229\141\149"
L["Blacklisted missions are ignored in Mission Control"] = "\229\138\160\229\133\165\233\187\145\229\144\141\229\141\149\231\154\132\228\187\187\229\138\161\229\176\134\228\188\154\229\156\168\228\187\187\229\138\161\233\157\162\230\157\191\232\162\171\229\191\189\231\149\165"
L["Bonus Chance"] = "\233\162\157\229\164\150\229\165\150\229\138\177\230\156\186\231\142\135"
L["Building Final report"] = "\230\158\132\229\187\186\230\156\128\231\187\136\230\138\165\229\145\138"
L["but using troops with just one durability left"] = "\228\189\191\231\148\168\229\143\170\230\156\137\228\184\128\228\184\170\231\148\159\229\145\189\229\128\188\231\154\132\233\131\168\233\152\159"
L["Capped %1$s. Spend at least %2$d of them"] = "%1$s\229\176\129\233\161\182\228\186\134\227\128\130\232\138\177\232\180\185\232\135\179\229\176\145%2$d\229\156\168\229\174\131\232\186\171\228\184\138"
L["Changes the sort order of missions in Mission panel"] = "\230\148\185\229\143\152\228\187\187\229\138\161\233\157\162\230\157\191\228\184\138\231\154\132\228\187\187\229\138\161\230\142\146\229\136\151\233\161\186\229\186\143"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "\230\136\152\230\150\151\231\155\159\229\143\139\232\162\171\229\187\186\232\174\174\229\136\176\228\187\187\229\138\161\239\188\140\230\137\128\228\187\165\228\189\160\229\143\175\228\187\165\232\128\131\232\153\145\229\143\150\230\182\136\230\140\135\230\180\190\228\187\150"
L["Complete all missions without confirmation"] = "\229\174\140\230\136\144\230\137\128\230\156\137\228\187\187\229\138\161\228\184\141\233\161\187\231\161\174\232\174\164"
L["Configuration for mission party builder"] = "\228\187\187\229\138\161\233\152\159\228\188\141\230\158\132\229\187\186\232\174\190\231\189\174"
L["Cost reduced"] = "\229\183\178\233\153\141\228\189\142\232\138\177\232\180\185"
L["Could not fulfill mission, aborting"] = "\228\187\187\229\138\161\230\151\160\230\179\149\230\137\167\232\161\140\232\162\171\229\191\189\231\149\165"
L["Counter kill Troops"] = "\229\143\141\229\136\182\229\141\177\229\174\179\239\188\136\232\135\180\229\145\189\239\188\137\233\152\178\230\173\162\233\131\168\233\152\159\233\152\181\228\186\161"
--Translation missing 
-- L["Customization options (non mission related)"] = ""
L["Disables warning: "] = "\229\129\156\231\148\168\232\173\166\229\145\138\239\188\154"
L["Dont use this slot"] = "\228\184\141\232\166\129\228\189\191\231\148\168\232\191\153\228\184\170\231\169\186\228\189\141"
L["Don't use troops"] = "\228\184\141\232\166\129\228\189\191\231\148\168\233\131\168\233\152\159"
L["Duration reduced"] = "\230\140\129\231\187\173\230\151\182\233\151\180\229\183\178\231\188\169\231\159\173"
L["Duration Time"] = "\230\140\129\231\187\173\230\151\182\233\151\180"
L["Elites mission mode"] = "\231\178\190\232\139\177\228\187\187\229\138\161\230\168\161\229\188\143"
L["Empty missions sorted as last"] = "\231\169\186\231\154\132\228\187\187\229\138\161\230\142\146\229\156\168\230\156\128\229\144\142"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "\231\169\186\230\136\150\232\128\1330%\230\136\144\229\138\159\231\142\135\231\154\132\228\187\187\229\138\161\230\142\146\229\156\168\230\156\128\229\144\142\239\188\140\229\175\185\228\186\142\\\"\229\142\159\229\167\139\\\"\230\150\185\229\188\143\230\142\146\229\186\143\230\151\160\230\149\136\227\128\130"
--Translation missing 
-- L["Equipped by following champions:"] = ""
L["Expiration Time"] = "\229\136\176\230\156\159\230\151\182\233\151\180"
L["Favours leveling follower for xp missions"] = "\229\128\190\229\144\145\228\186\142\228\189\191\231\148\168\229\141\135\231\186\167\228\184\173\232\191\189\233\154\168\232\128\133\229\156\168\231\187\143\233\170\140\229\128\188\228\187\187\229\138\161"
L["General"] = "\228\184\128\232\136\172"
L["Global approx. xp reward"] = "\230\149\180\228\189\147\229\164\167\231\186\166\231\187\143\233\170\140\229\128\188\229\165\150\229\138\177"
L["Global approx. xp reward per hour"] = "\230\175\143\229\176\143\230\151\182\232\142\183\229\190\151\231\154\132\230\149\180\228\189\147\231\187\143\233\170\140\229\128\188\229\165\150\229\138\177"
L["HallComander Quick Mission Completion"] = "\229\164\167\229\142\133\230\140\135\230\140\165\229\174\152\229\191\171\233\128\159\228\187\187\229\138\161\229\174\140\230\136\144"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "\229\166\130\230\158\156 %1$s \228\189\142\228\186\142\230\173\164\229\128\188\239\188\140\233\130\163\228\185\136\230\136\145\228\187\172\232\135\179\229\176\145\229\176\157\232\175\149\232\190\190\229\136\176 %2$s \232\128\140\228\184\141\232\182\133\232\191\135100%%\227\128\130 \229\191\189\231\149\165\231\178\190\232\139\177\228\187\187\229\138\161\227\128\130"
L["If not checked, inactive followers are used as last chance"] = "\228\184\141\229\139\190\233\128\137\230\151\182\239\188\140\230\156\170\230\191\128\230\180\187\231\154\132\232\191\189\233\154\143\232\128\133\228\188\154\230\136\144\228\184\186\230\156\128\229\144\142\231\154\132\232\128\131\232\153\145"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[\229\166\130\230\158\156\228\189\160\231\187\167\231\187\173\239\188\140\228\189\160\228\188\154\229\164\177\229\142\187\229\174\131\228\187\172
\231\130\185\229\135\187%s\228\190\134\229\143\150\230\182\136]=]
L["Ignore busy followers"] = "\229\191\189\231\149\165\228\187\187\229\138\161\228\184\173\231\154\132\232\191\189\233\154\143\232\128\133"
L["Ignore inactive followers"] = "\229\191\189\231\149\165\230\156\170\230\191\128\230\180\187\231\154\132\232\191\189\233\154\143\232\128\133"
L["Keep cost low"] = "\232\138\130\231\156\129\229\164\167\229\142\133\232\181\132\230\186\144"
L["Keep extra bonus"] = "\228\188\152\229\133\136\233\162\157\229\164\150\229\165\150\229\138\177"
L["Keep time short"] = "\229\135\143\229\176\145\228\187\187\229\138\161\230\151\182\233\151\180"
L["Keep time VERY short"] = "\230\156\128\231\159\173\228\187\187\229\138\161\230\151\182\233\151\180"
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
L["Level"] = "\231\173\137\231\186\167"
L["Lock all"] = "\229\133\168\233\131\168\233\148\129\229\174\154"
L["Lock this follower"] = "\233\148\129\229\174\154\230\173\164\232\191\189\233\154\143\232\128\133"
L["Locked follower are only used in this mission"] = "\233\148\129\229\174\154\229\143\170\231\148\168\228\186\142\230\173\164\228\187\187\229\138\161\231\154\132\232\191\189\233\154\143\232\128\133"
L["Make Order Hall Mission Panel movable"] = "\232\174\169\229\164\167\229\142\133\228\187\187\229\138\161\233\157\162\230\157\191\229\143\175\231\167\187\229\138\168"
L["Makes sure that no troops will be killed"] = "\231\161\174\228\191\157\230\178\161\230\156\137\233\131\168\233\152\159\228\188\154\233\152\181\228\186\161"
L["Max champions"] = "\230\156\128\229\164\154\231\154\132\229\139\135\229\163\171\230\149\176\233\135\143"
L["Maximize xp gain"] = "\232\142\183\229\143\150\230\156\128\229\164\154\231\154\132\231\187\143\233\170\140"
L["Mission duration reduced"] = "\228\187\187\229\138\161\230\137\167\232\161\140\230\151\182\233\151\180\229\183\178\231\188\169\231\159\173"
L["Mission was capped due to total chance less than"] = "\228\187\187\229\138\161\233\153\144\229\136\182\231\148\177\228\186\142\230\128\187\231\154\132\229\135\160\231\142\135\229\176\145\228\186\142"
L["Missions"] = "\228\187\187\229\138\161"
L["Never kill Troops"] = "\231\161\174\228\191\157\233\131\168\233\152\159\231\187\157\228\184\141\233\152\181\228\186\161"
L["No follower gained xp"] = "\230\178\161\230\156\137\232\191\189\233\154\143\232\128\133\232\142\183\229\190\151\231\187\143\233\170\140"
L["No suitable missions. Have you reserved at least one follower?"] = "\230\178\161\230\156\137\229\144\136\233\128\130\231\154\132\228\187\187\229\138\161\227\128\130 \230\130\168\230\152\175\229\144\166\232\135\179\229\176\145\228\191\157\231\149\153\228\186\134\228\184\128\228\189\141\232\191\189\233\154\143\232\128\133\239\188\159"
L["Not blacklisted"] = "\230\156\170\229\138\160\229\133\165\233\187\145\229\144\141\229\141\149"
L["Nothing to report"] = "\230\178\161\228\187\128\228\185\136\229\143\175\230\138\165\229\145\138"
L["Notifies you when you have troops ready to be collected"] = "\229\189\147\233\131\168\233\152\159\229\183\178\229\135\134\229\164\135\229\165\189\232\142\183\229\143\150\230\151\182\230\143\144\233\134\146\228\189\160"
L["Only accept missions with time improved"] = "\229\143\170\229\133\129\232\174\184\230\156\137\230\151\182\233\151\180\230\148\185\229\150\132\231\154\132\228\187\187\229\138\161"
L["Only consider elite missions"] = "\229\143\170\232\128\131\232\153\145\231\178\190\232\139\177\228\187\187\229\138\161"
L["Only use champions even if troops are available"] = "\230\156\137\229\143\175\231\148\168\231\154\132\233\131\168\233\152\159\230\151\182\239\188\140\228\187\141\231\132\182\229\143\170\228\189\191\231\148\168\232\191\189\233\154\143\232\128\133"
L["Open configuration"] = "\230\137\147\229\188\128\233\133\141\231\189\174"
--Translation missing 
-- L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = ""
L["Original method"] = "\229\142\159\229\167\139\230\150\185\230\179\149"
L["Position is not saved on logout"] = "\228\189\141\231\189\174\228\184\141\228\188\154\229\156\168\231\153\187\229\135\186\229\144\142\229\130\168\229\173\152"
L["Prefer high durability"] = "\229\150\156\230\172\162\233\171\152\231\148\159\229\145\189\229\128\188"
L["Quick start first mission"] = "\229\191\171\233\128\159\229\188\128\229\167\139\231\172\172\228\184\128\228\184\170\228\187\187\229\138\161"
L["Remove no champions warning"] = "\229\143\150\230\182\136\230\178\161\230\156\137\232\191\189\233\154\143\232\128\133\232\173\166\229\145\138"
--Translation missing 
-- L["Restart tutorial from beginning"] = ""
--Translation missing 
-- L["Resume tutorial"] = ""
L["Resurrect troops effect"] = "\229\164\141\230\180\187\233\131\168\233\152\159\230\149\136\230\158\156"
L["Reward type"] = "\229\165\150\229\138\177\231\177\187\229\158\139"
--Translation missing 
-- L["Sets all switches to a very permissive setup"] = ""
L["Show tutorial"] = "\230\152\190\231\164\186\230\149\153\231\168\139"
L["Show/hide OrderHallCommander mission menu"] = "\230\152\190\231\164\186/\233\154\144\232\151\143\229\164\167\229\142\133\230\140\135\230\140\165\229\174\152\228\187\187\229\138\161\233\128\137\229\141\149"
L["Sort missions by:"] = "\230\142\146\229\136\151\228\187\187\229\138\161\230\160\185\230\141\174\239\188\154"
L["Started with "] = "\229\188\128\229\167\139"
L["Success Chance"] = "\230\136\144\229\138\159\230\156\186\231\142\135"
L["Troop ready alert"] = "\233\131\168\233\152\159\232\163\133\229\164\135\230\143\144\233\134\146"
L["Unable to fill missions, raise \"%s\""] = "\230\151\160\230\179\149\230\140\135\230\180\190\228\187\187\229\138\161\239\188\140\232\175\183\230\143\144\229\141\135 \\\"%s\\"
L["Unable to fill missions. Check your switches"] = "\230\151\160\230\179\149\230\140\135\230\180\190\228\187\187\229\138\161\239\188\140\232\175\183\230\163\128\230\159\165\230\130\168\231\154\132\232\174\190\229\174\154\233\128\137\233\161\185"
L["Unable to start mission, aborting"] = "\230\151\160\230\179\149\229\188\128\229\167\139\228\187\187\229\138\161\239\188\140\228\184\173\230\173\162"
L["Unlock all"] = "\229\133\168\233\131\168\232\167\163\233\153\164\233\148\129\229\174\154"
L["Unlock this follower"] = "\232\167\163\233\148\129\230\173\164\232\191\189\233\154\143\232\128\133"
L["Unlocks all follower and slots at once"] = "\228\184\128\230\172\161\230\128\167\232\167\163\233\148\129\230\137\128\230\156\137\232\191\189\233\154\143\232\128\133\229\146\140\231\169\186\228\189\141"
L["Upgrading to |cff00ff00%d|r"] = "\229\141\135\231\186\167\229\136\176|cff00ff00%d|r"
L["URL Copy"] = "\229\164\141\229\136\182\231\189\145\229\157\128"
L["Use at most this many champions"] = "\230\156\128\229\164\154\228\189\191\231\148\168\228\184\141\232\182\133\232\191\135\232\191\153\228\184\170\230\149\176\233\135\143\231\154\132\229\139\135\229\163\171"
L["Use combat ally"] = "\228\189\191\231\148\168\230\136\152\230\150\151\231\155\159\229\143\139"
L["Use this slot"] = "\228\189\191\231\148\168\232\191\153\228\184\170\231\169\186\228\189\141"
L["Uses troops with the highest durability instead of the ones with the lowest"] = "\228\189\191\231\148\168\230\156\128\233\171\152\231\148\159\229\145\189\229\128\188\231\154\132\233\131\168\233\152\159\239\188\140\232\128\140\228\184\141\230\152\175\230\156\128\228\189\142\231\154\132\233\131\168\233\152\159"
--Translation missing 
-- L["When no free followers are available shows empty follower"] = ""
--Translation missing 
-- L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = ""
L["Would start with "] = "\229\176\134\229\188\128\229\167\139"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "\228\189\160\230\181\170\232\180\185\228\186\134|cffff0000%d|cffffd200 \231\130\185\230\149\176!!!"
--Translation missing 
-- L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = ""
--Translation missing 
-- L["You now need to press both %s and %s to start mission"] = ""

-- Tutorial
--Translation missing 
-- L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = ""
--Translation missing 
-- L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = ""
L["Base Chance"] = "\229\159\186\231\161\128\230\156\186\231\142\135"
L["Bonus Chance"] = "\233\162\157\229\164\150\229\165\150\229\138\177\230\156\186\231\142\135"
--Translation missing 
-- L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = ""
L["Counter Kill Troops"] = "\229\143\141\229\136\182\229\141\177\229\174\179\239\188\136\232\135\180\229\145\189\239\188\137\233\152\178\230\173\162\233\131\168\233\152\159\233\152\181\228\186\161"
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = ""
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "\231\155\184\229\143\141\239\188\140\229\166\130\230\158\156\228\189\160\229\143\170\230\131\179\230\128\187\230\152\175\231\156\139\229\136\176\230\156\128\229\165\189\231\154\132\229\143\175\231\148\168\228\187\187\229\138\161\239\188\140\229\143\170\233\156\128\232\166\129\232\174\190\231\189\174%1$s\229\136\176100%\239\188\140%2$s\229\136\1760%\227\128\130"
--Translation missing 
-- L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = ""
L["Max champions"] = "\230\156\128\229\164\154\231\154\132\229\139\135\229\163\171\230\149\176\233\135\143"
L["Maximize xp gain"] = "\232\142\183\229\143\150\230\156\128\229\164\154\231\154\132\231\187\143\233\170\140"
L["Never kill Troops"] = "\231\161\174\228\191\157\233\131\168\233\152\159\231\187\157\228\184\141\233\152\181\228\186\161"
L["Prefer high durability"] = "\229\150\156\230\172\162\233\171\152\231\148\159\229\145\189\229\128\188"
L["Restart the tutorial"] = "\233\135\141\230\150\176\229\144\175\229\138\168\230\149\153\231\168\139"
--Translation missing 
-- L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = ""
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "\231\187\136\230\173\162\230\149\153\231\168\139\227\128\130\230\130\168\229\143\175\228\187\165\233\154\143\230\151\182\231\130\185\229\135\187\228\190\167\232\190\185\232\143\156\229\141\149\231\154\132\228\191\161\230\129\175\229\155\190\230\160\135\230\129\162\229\164\141\229\174\131"
--Translation missing 
-- L["Thank you for reading this, enjoy %s"] = ""
--Translation missing 
-- L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = ""
--Translation missing 
-- L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = ""
--Translation missing 
-- L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = ""
--Translation missing 
-- L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = ""
--Translation missing 
-- L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = ""
--Translation missing 
-- L["You can choose not to use a troop type clicking its icon"] = ""
--Translation missing 
-- L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = ""

	end
	L=l:NewLocale(me,"esES")
	if (L) then
--Translation missing 
-- L["%1$d%% lower than %2$d%%. Lower %s"] = ""
--Translation missing 
-- L["%s for a wowhead link popup"] = ""
--Translation missing 
-- L["%s start the mission without even opening the mission page. No question asked"] = ""
--Translation missing 
-- L["%s starts missions"] = ""
--Translation missing 
-- L["%s to blacklist"] = ""
--Translation missing 
-- L["%s to remove from blacklist"] = ""
--Translation missing 
-- L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = ""
--Translation missing 
-- L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = ""
--Translation missing 
-- L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = ""
L["Always counter increased resource cost"] = "Siempre contrarreste el mayor costo de recursos"
L["Always counter increased time"] = "Siempre contrarreste el tiempo incrementado"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Siempre contrarrestar la muerte de tropas (ignorado si s\195\179lo podemos utilizar tropas con un solo punto de durabilidad)"
L["Always counter no bonus loot threat"] = "Siempre contrarresta la falta de bonificaci\195\179n de bot\195\173n"
--Translation missing 
-- L["Artifact shown value is the base value without considering knowledge multiplier"] = ""
--Translation missing 
-- L["Attempting %s"] = ""
--Translation missing 
-- L["Base Chance"] = ""
L["Better parties available in next future"] = "Mejores fiestas disponibles en el pr\195\179ximo futuro"
--Translation missing 
-- L["Blacklisted"] = ""
--Translation missing 
-- L["Blacklisted missions are ignored in Mission Control"] = ""
--Translation missing 
-- L["Bonus Chance"] = ""
L["Building Final report"] = "Informe final del edificio"
--Translation missing 
-- L["but using troops with just one durability left"] = ""
L["Capped %1$s. Spend at least %2$d of them"] = "% 1 $ s cubierto. Gasta al menos% 2 $ d de ellos"
L["Changes the sort order of missions in Mission panel"] = "Cambia el orden de las misiones en el panel de la Misi\195\179n"
--Translation missing 
-- L["Combat ally is proposed for missions so you can consider unassigning him"] = ""
L["Complete all missions without confirmation"] = "Completa todas las misiones sin confirmaci\195\179n"
L["Configuration for mission party builder"] = "Configuraci\195\179n para el constructor de la misi\195\179n"
--Translation missing 
-- L["Cost reduced"] = ""
--Translation missing 
-- L["Could not fulfill mission, aborting"] = ""
--Translation missing 
-- L["Counter kill Troops"] = ""
--Translation missing 
-- L["Customization options (non mission related)"] = ""
--Translation missing 
-- L["Disables warning: "] = ""
--Translation missing 
-- L["Dont use this slot"] = ""
--Translation missing 
-- L["Don't use troops"] = ""
L["Duration reduced"] = "Duraci\195\179n reducida"
L["Duration Time"] = "Duraci\195\179n"
--Translation missing 
-- L["Elites mission mode"] = ""
--Translation missing 
-- L["Empty missions sorted as last"] = ""
--Translation missing 
-- L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = ""
--Translation missing 
-- L["Equipped by following champions:"] = ""
L["Expiration Time"] = "Tiempo de expiraci\195\179n"
L["Favours leveling follower for xp missions"] = "Favors nivelando seguidor para las misiones xp"
L["General"] = true
L["Global approx. xp reward"] = "Global aprox. Recompensa xp"
--Translation missing 
-- L["Global approx. xp reward per hour"] = ""
L["HallComander Quick Mission Completion"] = "Conclusi\195\179n de la misi\195\179n r\195\161pida de HallComander"
--Translation missing 
-- L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = ""
--Translation missing 
-- L["If not checked, inactive followers are used as last chance"] = ""
--Translation missing 
-- L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = ""
--Translation missing 
-- L["Ignore busy followers"] = ""
--Translation missing 
-- L["Ignore inactive followers"] = ""
L["Keep cost low"] = "Mantenga el costo bajo"
L["Keep extra bonus"] = "Mantener bonificaci\195\179n extra"
L["Keep time short"] = "Mantenga el tiempo corto"
L["Keep time VERY short"] = "Mantener el tiempo muy corto"
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
--Translation missing 
-- L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = ""
L["Level"] = "Nivel"
--Translation missing 
-- L["Lock all"] = ""
--Translation missing 
-- L["Lock this follower"] = ""
--Translation missing 
-- L["Locked follower are only used in this mission"] = ""
L["Make Order Hall Mission Panel movable"] = "Hacer pedido Hall Misi\195\179n Panel m\195\179vil"
--Translation missing 
-- L["Makes sure that no troops will be killed"] = ""
--Translation missing 
-- L["Max champions"] = ""
L["Maximize xp gain"] = "Maximizar la ganancia de xp"
--Translation missing 
-- L["Mission duration reduced"] = ""
--Translation missing 
-- L["Mission was capped due to total chance less than"] = ""
L["Missions"] = "Misiones"
--Translation missing 
-- L["Never kill Troops"] = ""
L["No follower gained xp"] = "Ning\195\186n seguidor gan\195\179 xp"
--Translation missing 
-- L["No suitable missions. Have you reserved at least one follower?"] = ""
--Translation missing 
-- L["Not blacklisted"] = ""
L["Nothing to report"] = "Nada que reportar"
L["Notifies you when you have troops ready to be collected"] = "Notifica cuando hay tropas listas para ser recolectadas"
L["Only accept missions with time improved"] = "S\195\179lo aceptar misiones mejoradas con el tiempo"
--Translation missing 
-- L["Only consider elite missions"] = ""
--Translation missing 
-- L["Only use champions even if troops are available"] = ""
--Translation missing 
-- L["Open configuration"] = ""
--Translation missing 
-- L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = ""
L["Original method"] = "M\195\169todo original"
L["Position is not saved on logout"] = "La posici\195\179n no se guarda al cerrar la sesi\195\179n"
--Translation missing 
-- L["Prefer high durability"] = ""
--Translation missing 
-- L["Quick start first mission"] = ""
--Translation missing 
-- L["Remove no champions warning"] = ""
--Translation missing 
-- L["Restart tutorial from beginning"] = ""
--Translation missing 
-- L["Resume tutorial"] = ""
L["Resurrect troops effect"] = "Efecto de las tropas de resurrecci\195\179n"
L["Reward type"] = "Tipo de recompensa"
--Translation missing 
-- L["Sets all switches to a very permissive setup"] = ""
--Translation missing 
-- L["Show tutorial"] = ""
L["Show/hide OrderHallCommander mission menu"] = "Mostrar / ocultar el men\195\186 de la misi\195\179n OrderHallCommander"
L["Sort missions by:"] = "Ordenar misiones por:"
--Translation missing 
-- L["Started with "] = ""
L["Success Chance"] = "\195\137xito"
L["Troop ready alert"] = "Alerta lista de tropas"
--Translation missing 
-- L["Unable to fill missions, raise \"%s\""] = ""
--Translation missing 
-- L["Unable to fill missions. Check your switches"] = ""
--Translation missing 
-- L["Unable to start mission, aborting"] = ""
--Translation missing 
-- L["Unlock all"] = ""
--Translation missing 
-- L["Unlock this follower"] = ""
--Translation missing 
-- L["Unlocks all follower and slots at once"] = ""
L["Upgrading to |cff00ff00%d|r"] = "Actualizando a | cff00ff00% d | r"
--Translation missing 
-- L["URL Copy"] = ""
--Translation missing 
-- L["Use at most this many champions"] = ""
L["Use combat ally"] = "Usar aliado de combate"
--Translation missing 
-- L["Use this slot"] = ""
--Translation missing 
-- L["Uses troops with the highest durability instead of the ones with the lowest"] = ""
--Translation missing 
-- L["When no free followers are available shows empty follower"] = ""
--Translation missing 
-- L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = ""
--Translation missing 
-- L["Would start with "] = ""
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Est\195\161 perdiendo | cffff0000% d | cffffd200 punto (s)!"
--Translation missing 
-- L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = ""
--Translation missing 
-- L["You now need to press both %s and %s to start mission"] = ""

-- Tutorial
--Translation missing 
-- L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = ""
--Translation missing 
-- L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = ""
--Translation missing 
-- L["Base Chance"] = ""
--Translation missing 
-- L["Bonus Chance"] = ""
--Translation missing 
-- L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = ""
--Translation missing 
-- L["Counter Kill Troops"] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = ""
--Translation missing 
-- L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = ""
--Translation missing 
-- L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = ""
--Translation missing 
-- L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = ""
--Translation missing 
-- L["Max champions"] = ""
--Translation missing 
-- L["Maximize xp gain"] = ""
--Translation missing 
-- L["Never kill Troops"] = ""
--Translation missing 
-- L["Prefer high durability"] = ""
--Translation missing 
-- L["Restart the tutorial"] = ""
--Translation missing 
-- L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = ""
--Translation missing 
-- L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = ""
--Translation missing 
-- L["Thank you for reading this, enjoy %s"] = ""
--Translation missing 
-- L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = ""
--Translation missing 
-- L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = ""
--Translation missing 
-- L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = ""
--Translation missing 
-- L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = ""
--Translation missing 
-- L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = ""
--Translation missing 
-- L["You can choose not to use a troop type clicking its icon"] = ""
--Translation missing 
-- L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = ""

	end
	L=l:NewLocale(me,"zhTW")
	if (L) then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%%\228\189\142\230\150\188%2$d%%\239\188\140\233\153\141\228\189\142%s"
L["%s for a wowhead link popup"] = "%s\232\183\179\229\135\186wowhead\233\128\163\231\181\144"
L["%s start the mission without even opening the mission page. No question asked"] = "%s\231\148\154\232\135\179\229\143\175\228\187\165\228\184\141\230\137\147\233\150\139\228\187\187\229\139\153\233\160\129\233\157\162\229\176\177\229\149\159\229\139\149\228\187\187\229\139\153\239\188\140 \230\178\146\229\149\143\233\161\140"
L["%s starts missions"] = "%s\233\150\139\229\167\139\228\187\187\229\139\153"
L["%s to blacklist"] = "%s\229\138\160\229\133\165\233\187\145\229\144\141\229\150\174"
L["%s to remove from blacklist"] = "%s\229\190\158\233\187\145\229\144\141\229\150\174\231\167\187\233\153\164"
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s\239\188\140\232\171\139\230\159\165\231\156\139\230\156\172\230\140\135\229\141\151
\239\188\136\233\187\158\230\147\138\230\173\164\229\156\150\231\164\186\232\167\163\233\153\164\230\173\164\232\168\138\230\129\175\228\184\166\233\150\139\229\167\139\230\140\135\229\141\151\239\188\137]=]
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "\233\128\153\230\152\175\228\184\128\229\128\139\230\150\176\231\137\136\230\156\172\231\154\132OrderHallCommander\227\128\130 \232\171\139\232\138\177\233\187\158\230\153\130\233\150\147\230\159\165\231\156\139\230\156\172\230\140\135\229\141\151\227\128\130 \233\187\158\230\147\138\230\173\164\229\156\150\230\168\153\233\151\156\233\150\137\229\174\131"
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "\229\133\129\232\168\177\231\155\180\230\142\165\229\190\158\228\187\187\229\139\153\229\136\151\232\161\168\233\160\129\233\157\162\229\149\159\229\139\149\228\187\187\229\139\153\239\188\136\228\184\141\230\156\131\233\161\175\231\164\186\229\128\139\229\136\165\228\187\187\229\139\153\233\160\129\233\157\162\239\188\137"
L["Always counter increased resource cost"] = "\231\184\189\230\152\175\229\143\141\229\136\182\229\162\158\229\138\160\232\179\135\230\186\144\232\138\177\232\178\187"
L["Always counter increased time"] = "\231\184\189\230\152\175\229\143\141\229\136\182\229\162\158\229\138\160\228\187\187\229\139\153\230\153\130\233\150\147"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "\231\184\189\230\152\175\229\143\141\229\136\182\230\174\186\230\173\187\233\131\168\233\154\138(\229\166\130\230\158\156\230\136\145\229\128\145\231\148\168\229\143\170\229\137\169\228\184\128\230\172\161\232\128\144\228\185\133\231\154\132\233\131\168\233\154\138\229\137\135\229\191\189\231\149\165)"
L["Always counter no bonus loot threat"] = "\231\184\189\230\152\175\229\143\141\229\136\182\230\178\146\230\156\137\233\161\141\229\164\150\231\141\142\229\139\181\231\154\132\229\168\129\232\132\133"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "\231\165\158\229\133\181\233\161\175\231\164\186\231\154\132\229\128\188\230\152\175\229\159\186\231\164\142\229\128\188\239\188\140\230\178\146\230\156\137\231\182\147\233\129\142\231\165\158\229\133\181\231\159\165\232\173\152\231\154\132\229\138\160\230\136\144\227\128\130"
L["Attempting %s"] = "\229\152\151\232\169\166%s"
L["Base Chance"] = "\229\159\186\231\164\142\230\169\159\231\142\135"
L["Better parties available in next future"] = "\229\156\168\229\176\135\228\190\134\230\156\137\230\155\180\229\165\189\231\154\132\233\154\138\228\188\141"
L["Blacklisted"] = "\229\136\151\229\133\165\233\187\145\229\144\141\229\150\174"
L["Blacklisted missions are ignored in Mission Control"] = "\229\136\151\229\133\165\233\187\145\229\144\141\229\150\174\231\154\132\228\187\187\229\139\153\230\156\131\229\156\168\228\187\187\229\139\153\233\157\162\230\157\191\229\191\189\231\149\165"
L["Bonus Chance"] = "\233\161\141\229\164\150\231\141\142\229\139\181\230\169\159\231\142\135"
L["Building Final report"] = "\230\167\139\229\187\186\230\156\128\231\181\130\229\160\177\229\145\138"
L["but using troops with just one durability left"] = "\228\189\134\228\189\191\231\148\168\229\143\170\230\156\137\228\184\128\229\128\139\232\128\144\228\185\133\229\186\166\231\154\132\233\131\168\233\154\138"
L["Capped %1$s. Spend at least %2$d of them"] = "%1$s\229\176\129\233\160\130\228\186\134\227\128\130\232\138\177\232\178\187\232\135\179\229\176\145%2$d\229\156\168\229\174\131\232\186\171\228\184\138"
L["Changes the sort order of missions in Mission panel"] = "\230\148\185\232\174\138\228\187\187\229\139\153\233\157\162\230\157\191\228\184\138\231\154\132\228\187\187\229\139\153\230\142\146\229\136\151\233\160\134\229\186\143"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "\230\136\176\233\172\165\231\155\159\229\143\139\232\162\171\229\187\186\232\173\176\229\136\176\228\187\187\229\139\153\239\188\140\230\137\128\228\187\165\228\189\160\229\143\175\228\187\165\232\128\131\230\133\174\229\143\150\230\182\136\230\140\135\230\180\190\228\187\150"
L["Complete all missions without confirmation"] = "\229\174\140\230\136\144\230\137\128\230\156\137\228\187\187\229\139\153\228\184\141\233\160\136\231\162\186\232\170\141"
L["Configuration for mission party builder"] = "\228\187\187\229\139\153\233\154\138\228\188\141\230\167\139\229\187\186\232\168\173\231\189\174"
L["Cost reduced"] = "\232\138\177\232\178\187\229\183\178\233\153\141\228\189\142"
L["Could not fulfill mission, aborting"] = "\228\187\187\229\139\153\231\132\161\230\179\149\229\177\165\232\161\140\239\188\140\229\191\189\231\149\165"
L["Counter kill Troops"] = "\229\143\141\229\136\182\230\174\186\230\173\187\233\131\168\233\154\138"
--Translation missing 
-- L["Customization options (non mission related)"] = ""
L["Disables warning: "] = "\229\129\156\231\148\168\232\173\166\229\145\138\239\188\154"
L["Dont use this slot"] = "\228\184\141\232\166\129\228\189\191\231\148\168\233\128\153\229\128\139\231\169\186\230\167\189"
L["Don't use troops"] = "\228\184\141\232\166\129\228\189\191\231\148\168\233\131\168\233\154\138"
L["Duration reduced"] = "\230\140\129\231\186\140\230\153\130\233\150\147\229\183\178\231\184\174\231\159\173"
L["Duration Time"] = "\230\140\129\231\186\140\230\153\130\233\150\147"
L["Elites mission mode"] = "\231\178\190\232\139\177\228\187\187\229\139\153\230\168\161\229\188\143"
L["Empty missions sorted as last"] = "\231\169\186\231\154\132\228\187\187\229\139\153\230\142\146\229\156\168\230\156\128\229\190\140"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "\231\169\186\230\136\1500%\230\136\144\229\138\159\231\142\135\231\154\132\228\187\187\229\139\153\230\142\146\229\136\151\229\156\168\230\156\128\229\190\140\239\188\140\229\176\141\230\150\188\"\229\142\159\229\167\139\"\230\150\185\229\188\143\230\142\146\229\186\143\231\132\161\230\149\136\227\128\130"
--Translation missing 
-- L["Equipped by following champions:"] = ""
L["Expiration Time"] = "\229\136\176\230\156\159\230\153\130\233\150\147"
L["Favours leveling follower for xp missions"] = "\229\130\190\229\144\145\230\150\188\228\189\191\231\148\168\229\141\135\231\180\154\228\184\173\232\191\189\233\154\168\232\128\133\229\156\168\231\182\147\233\169\151\229\128\188\228\187\187\229\139\153"
L["General"] = "(G) \228\184\128\232\136\172"
L["Global approx. xp reward"] = "\230\149\180\233\171\148\229\164\167\231\180\132\231\182\147\233\169\151\229\128\188\231\141\142\229\139\181"
L["Global approx. xp reward per hour"] = "\230\175\143\229\176\143\230\153\130\231\141\178\229\190\151\230\149\180\233\171\148\231\182\147\233\169\151\229\128\188\231\141\142\229\139\181"
L["HallComander Quick Mission Completion"] = "\229\164\167\229\187\179\228\187\187\229\139\153\229\191\171\233\128\159\229\174\140\230\136\144"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "\229\166\130\230\158\156%1$s\228\189\142\230\150\188\230\173\164\229\128\188\239\188\140\233\130\163\233\186\188\230\136\145\229\128\145\229\152\151\232\169\166\232\135\179\229\176\145\233\129\148\229\136\176%2$s\232\128\140\228\184\141\232\182\133\233\129\142100%%\227\128\130 \229\191\189\232\166\150\231\178\190\232\139\177\228\187\187\229\139\153\227\128\130"
L["If not checked, inactive followers are used as last chance"] = "\228\184\141\229\139\190\233\129\184\230\153\130\239\188\140\233\150\146\231\189\174\231\154\132\232\191\189\233\154\168\232\128\133\230\156\131\230\136\144\231\130\186\230\156\128\229\190\140\231\154\132\232\128\131\233\135\143\227\128\130"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[\229\166\130\230\158\156\230\130\168\231\185\188\231\186\140\239\188\140\230\130\168\230\156\131\229\164\177\229\142\187\229\174\131\229\128\145
\233\187\158\230\147\138%s\228\190\134\229\143\150\230\182\136]=]
L["Ignore busy followers"] = "\229\191\189\231\149\165\228\187\187\229\139\153\228\184\173\231\154\132\232\191\189\233\154\168\232\128\133"
L["Ignore inactive followers"] = "\229\191\189\231\149\165\233\150\146\231\189\174\231\154\132\232\191\189\233\154\168\232\128\133"
L["Keep cost low"] = "\228\191\157\230\140\129\228\189\142\232\138\177\232\178\187"
L["Keep extra bonus"] = "\228\191\157\230\140\129\233\161\141\229\164\150\231\141\142\229\139\181"
L["Keep time short"] = "\228\191\157\230\140\129\231\159\173\230\153\130\233\150\147"
L["Keep time VERY short"] = "\228\191\157\230\140\129\233\157\158\229\184\184\231\159\173\231\154\132\230\153\130\233\150\147"
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = "\231\148\168\232\135\179\229\176\145\228\184\128\229\128\139\233\142\150\229\174\154\231\154\132\232\191\189\233\154\168\232\128\133\229\149\159\229\139\149\231\172\172\228\184\128\229\128\139\229\161\171\229\133\133\228\187\187\229\139\153\227\128\130 \230\140\137\228\189\143%s\230\140\137\233\136\149\229\175\166\233\154\155\229\149\159\229\139\149\239\188\140\228\184\128\229\128\139\231\176\161\229\150\174\231\154\132\233\187\158\230\147\138\229\176\135\229\143\170\229\136\151\229\141\176\228\187\187\229\139\153\229\144\141\231\168\177\232\136\135\229\133\182\232\191\189\233\154\168\232\128\133\229\144\141\229\150\174"
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = "\231\148\168\232\135\179\229\176\145\228\184\128\229\128\139\233\142\150\229\174\154\231\154\132\232\191\189\233\154\168\232\128\133\229\149\159\229\139\149\231\172\172\228\184\128\229\128\139\229\161\171\229\133\133\228\187\187\229\139\153\227\128\130 \230\140\137\228\189\143SHIFT\229\175\166\233\154\155\229\149\159\229\139\149\239\188\140\228\184\128\229\128\139\231\176\161\229\150\174\231\154\132\233\187\158\230\147\138\229\176\135\229\143\170\229\136\151\229\141\176\228\187\187\229\139\153\229\144\141\231\168\177\232\136\135\229\133\182\232\191\189\233\154\168\232\128\133\229\144\141\229\150\174"
L["Level"] = "\231\173\137\231\180\154"
L["Lock all"] = "\229\133\168\233\131\168\233\142\150\229\174\154"
L["Lock this follower"] = "\233\142\150\229\174\154\230\173\164\232\191\189\233\154\168\232\128\133"
L["Locked follower are only used in this mission"] = "\233\142\150\229\174\154\229\143\170\231\148\168\230\150\188\230\173\164\228\187\187\229\139\153\231\154\132\232\191\189\233\154\168\232\128\133"
L["Make Order Hall Mission Panel movable"] = "\232\174\147\229\164\167\229\187\179\228\187\187\229\139\153\233\157\162\230\157\191\229\143\175\231\167\187\229\139\149"
L["Makes sure that no troops will be killed"] = "\231\162\186\228\191\157\230\178\146\230\156\137\233\131\168\233\154\138\230\156\131\232\162\171\230\174\186\229\174\179"
L["Max champions"] = "\230\156\128\229\164\154\229\139\135\229\163\171"
L["Maximize xp gain"] = "\230\156\128\229\164\167\229\140\150\231\182\147\233\169\151\231\141\178\229\143\150"
L["Mission duration reduced"] = "\228\187\187\229\139\153\230\153\130\233\150\147\229\183\178\231\184\174\231\159\173"
L["Mission was capped due to total chance less than"] = "\228\187\187\229\139\153\232\162\171\233\153\144\229\136\182\228\186\134\239\188\140\231\148\177\230\150\188\231\184\189\230\169\159\231\142\135\228\184\141\229\143\138"
L["Missions"] = "(M) \228\187\187\229\139\153"
L["Never kill Troops"] = "\231\181\149\228\184\141\230\174\186\230\173\187\233\131\168\233\154\138"
L["No follower gained xp"] = "\230\178\146\230\156\137\232\191\189\233\154\168\232\128\133\231\141\178\229\190\151\231\182\147\233\169\151"
L["No suitable missions. Have you reserved at least one follower?"] = "\230\178\146\230\156\137\229\144\136\233\129\169\231\154\132\228\187\187\229\139\153\227\128\130 \230\130\168\230\152\175\229\144\166\232\135\179\229\176\145\228\191\157\231\149\153\228\184\128\228\189\141\232\191\189\233\154\168\232\128\133\239\188\159"
L["Not blacklisted"] = "\230\156\170\229\136\151\229\133\165\233\187\145\229\144\141\229\150\174"
L["Nothing to report"] = "\230\178\146\228\187\128\233\186\188\229\143\175\229\160\177\229\145\138"
L["Notifies you when you have troops ready to be collected"] = "\231\149\182\233\131\168\233\154\138\229\183\178\230\186\150\229\130\153\229\165\189\231\141\178\229\143\150\230\153\130\230\143\144\233\134\146\228\189\160"
L["Only accept missions with time improved"] = "\229\143\170\229\133\129\232\168\177\230\156\137\230\153\130\233\150\147\230\148\185\229\150\132\231\154\132\228\187\187\229\139\153"
L["Only consider elite missions"] = "\229\143\170\232\128\131\230\133\174\231\178\190\232\139\177\228\187\187\229\139\153"
L["Only use champions even if troops are available"] = "\230\156\137\229\143\175\231\148\168\231\154\132\233\131\168\233\154\138\230\153\130\239\188\140\228\187\141\231\132\182\229\143\170\232\166\129\228\189\191\231\148\168\229\139\135\229\163\171\227\128\130"
L["Open configuration"] = "\233\150\139\229\149\159\232\168\173\231\189\174\233\129\184\233\160\133"
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[\232\129\183\230\165\173\229\164\167\229\187\179\230\140\135\230\143\174\229\174\152\229\183\178\231\182\147\229\143\150\228\187\163\232\166\129\229\161\158\230\140\135\230\143\174\229\174\152\228\190\134\231\174\161\231\144\134\232\129\183\230\165\173\229\164\167\229\187\179\227\128\130
\232\166\129\232\191\148\229\155\158\228\189\191\231\148\168\232\166\129\229\161\158\230\140\135\230\143\174\229\174\152\239\188\140\229\143\170\232\166\129\229\129\156\231\148\168\232\129\183\230\165\173\229\164\167\229\187\179\230\140\135\230\143\174\229\174\152\230\143\146\228\187\182\229\176\177\229\143\175\228\187\165\228\186\134\227\128\130]=]
L["Original method"] = "\229\142\159\229\167\139\230\150\185\229\188\143"
L["Position is not saved on logout"] = "\228\189\141\231\189\174\228\184\141\230\156\131\229\156\168\231\153\187\229\135\186\229\190\140\229\132\178\229\173\152"
L["Prefer high durability"] = "\229\150\156\229\165\189\233\171\152\232\128\144\228\185\133\229\186\166"
L["Quick start first mission"] = "\229\191\171\233\128\159\233\150\139\229\167\139\231\172\172\228\184\128\229\128\139\228\187\187\229\139\153"
L["Remove no champions warning"] = "\231\167\187\233\153\164\230\178\146\230\156\137\229\139\135\229\163\171\232\173\166\229\145\138"
L["Restart tutorial from beginning"] = "\229\190\158\233\150\139\229\167\139\231\154\132\229\156\176\230\150\185\233\135\141\229\149\159\230\140\135\229\141\151"
L["Resume tutorial"] = "\231\185\188\231\186\140\230\140\135\229\141\151"
L["Resurrect troops effect"] = "\229\190\169\230\180\187\233\131\168\233\154\138\230\149\136\230\158\156"
L["Reward type"] = "\231\141\142\229\139\181\233\161\158\229\158\139"
L["Sets all switches to a very permissive setup"] = "\229\136\135\230\143\155\230\137\128\230\156\137\232\168\173\231\189\174\231\130\186\233\157\158\229\184\184\229\175\172\229\174\185\231\154\132\232\168\173\231\189\174"
L["Show tutorial"] = "\233\161\175\231\164\186\230\140\135\229\141\151"
L["Show/hide OrderHallCommander mission menu"] = "\233\161\175\231\164\186/\233\154\177\232\151\143\229\164\167\229\187\179\230\140\135\230\143\174\229\174\152\228\187\187\229\139\153\233\129\184\229\150\174"
L["Sort missions by:"] = "\230\142\146\229\136\151\228\187\187\229\139\153\230\160\185\230\147\154\239\188\154"
L["Started with "] = "\229\183\178\233\150\139\229\167\139"
L["Success Chance"] = "\230\136\144\229\138\159\230\169\159\231\142\135"
L["Troop ready alert"] = "\233\131\168\233\154\138\230\149\180\229\130\153\230\143\144\233\134\146"
L["Unable to fill missions, raise \"%s\""] = "\231\132\161\230\179\149\230\140\135\230\180\190\228\187\187\229\139\153\239\188\140\232\171\139\230\143\144\229\141\135 \"%s\""
L["Unable to fill missions. Check your switches"] = "\231\132\161\230\179\149\229\136\134\230\180\190\228\187\187\229\139\153\239\188\140\232\171\139\230\170\162\230\159\165\228\189\160\231\154\132\232\168\173\229\174\154\233\129\184\233\160\133\227\128\130"
L["Unable to start mission, aborting"] = "\231\132\161\230\179\149\233\150\139\229\167\139\228\187\187\229\139\153\239\188\140\228\184\173\230\173\162"
L["Unlock all"] = "\229\133\168\233\131\168\232\167\163\233\153\164\233\142\150\229\174\154"
L["Unlock this follower"] = "\232\167\163\233\142\150\230\173\164\232\191\189\233\154\168\232\128\133"
L["Unlocks all follower and slots at once"] = "\228\184\128\230\172\161\232\167\163\233\142\150\230\137\128\230\156\137\232\191\189\233\154\168\232\128\133\229\146\140\231\169\186\230\167\189"
L["Upgrading to |cff00ff00%d|r"] = "\229\141\135\231\180\154\229\136\176|cff00ff00%d|r"
L["URL Copy"] = "\232\164\135\232\163\189\231\182\178\229\157\128"
L["Use at most this many champions"] = "\232\135\179\229\176\145\228\189\191\231\148\168\233\128\153\229\128\139\230\149\184\233\135\143\231\154\132\229\139\135\229\163\171"
L["Use combat ally"] = "\228\189\191\231\148\168\230\136\176\233\172\165\231\155\159\229\143\139"
L["Use this slot"] = "\228\189\191\231\148\168\230\173\164\231\169\186\230\167\189"
L["Uses troops with the highest durability instead of the ones with the lowest"] = "\228\189\191\231\148\168\230\156\128\233\171\152\232\128\144\228\185\133\230\128\167\231\154\132\233\131\168\233\154\138\239\188\140\232\128\140\228\184\141\230\152\175\230\156\128\228\189\142\231\154\132\233\131\168\233\154\138"
L["When no free followers are available shows empty follower"] = "\230\178\146\230\156\137\229\143\175\231\148\168\231\154\132\232\191\189\233\154\168\232\128\133\230\153\130\239\188\140\233\161\175\231\164\186\231\169\186\230\172\132\228\189\141\227\128\130"
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "\231\149\182\230\136\145\229\128\145\231\132\161\230\179\149\229\175\166\231\143\190\232\171\139\230\177\130\231\154\132%1$s\230\153\130, \230\136\145\229\128\145\229\152\151\232\169\166\232\135\179\229\176\145\233\129\148\229\136\176\233\128\153\228\184\128\231\155\174\230\168\153, \232\128\140\228\184\141 (\229\166\130\230\158\156\229\143\175\232\131\189) \232\182\133\233\129\142100%%"
L["Would start with "] = "\230\156\131\233\150\139\229\167\139"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "\228\189\160\230\181\170\232\178\187\228\186\134|cffff0000%d|cffffd200 \233\187\158\230\149\184!!!"
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[\230\130\168\233\156\128\232\166\129\233\151\156\233\150\137\228\184\166\233\135\141\230\150\176\229\149\159\229\139\149\233\173\148\231\141\184\228\184\150\231\149\140\230\137\141\232\131\189\230\155\180\230\150\176\230\173\164\231\137\136\230\156\172\231\154\132OrderHallCommander\227\128\130
\231\176\161\229\150\174\231\154\132\233\135\141\230\150\176\232\188\137\229\133\165UI\230\152\175\228\184\141\229\164\160\231\154\132]=]
L["You now need to press both %s and %s to start mission"] = "\230\130\168\231\143\190\229\156\168\233\156\128\232\166\129\229\144\140\230\153\130\230\140\137\228\184\139%s\229\146\140%s\228\190\134\229\149\159\229\139\149\228\187\187\229\139\153"

-- Tutorial
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[%1$s\232\136\135%2$s\228\184\128\232\181\183\228\186\164\230\143\155\233\129\139\228\189\156\228\187\165\229\174\154\229\136\182\228\189\160\230\131\179\232\166\129\228\187\187\229\139\153\229\166\130\228\189\149\229\136\134\230\180\190

\228\189\160\231\130\186 %1$s \232\168\173\231\189\174\231\154\132\229\128\188(\231\155\174\229\137\141\231\130\186 %3$s%%)\230\152\175\230\156\128\228\189\142\229\143\175\230\142\165\229\143\151\231\154\132\233\161\141\229\164\150\231\141\142\229\139\181\230\169\159\231\142\135\239\188\140\232\128\140\231\130\186\231\130\186 %2$s \232\168\173\231\189\174\231\154\132\229\128\188(\231\155\174\229\137\141\231\130\186 %4$s%%)\230\152\175\228\189\160\230\131\179\232\166\129\229\175\166\231\143\190\231\154\132\230\169\159\231\142\135\239\188\140\231\149\182\228\189\160\230\152\175\231\130\186\228\186\134\231\136\173\229\143\150\231\141\142\229\139\181\239\188\136\231\148\177\230\150\188\230\178\146\230\156\137\232\182\179\229\164\160\229\188\183\229\164\167\231\154\132\232\191\189\233\154\168\232\128\133\239\188\137]=]
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[\232\171\139\230\177\130\231\154\132\232\166\150\231\170\151\230\156\170\230\137\147\233\150\139
\230\140\135\229\141\151\229\176\135\231\155\161\229\191\171\230\129\162\229\190\169]=]
L["Base Chance"] = "\229\159\186\231\164\142\230\169\159\231\142\135"
L["Bonus Chance"] = "\233\161\141\229\164\150\231\141\142\229\139\181\230\169\159\231\142\135"
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[\233\187\158\230\147\138\228\184\128\229\128\139\233\154\138\228\188\141\230\140\137\233\136\149\229\176\135\230\156\131\229\176\135\229\133\182\232\191\189\233\154\168\232\128\133\229\136\134\233\133\141\231\181\166\231\149\182\229\137\141\231\154\132\228\187\187\229\139\153\227\128\130
\228\189\191\231\148\168\229\174\131\228\190\134\230\175\148\232\188\131\233\169\151\232\173\137OHC\232\136\135\230\154\180\233\155\170\232\168\136\231\174\151\231\154\132\230\169\159\231\142\135\227\128\130
\229\166\130\230\158\156\228\187\150\229\128\145\228\184\141\229\144\140\239\188\140\232\171\139\230\139\141\230\148\157\230\136\170\229\156\150\228\184\166\233\150\139\229\149\159\228\184\128\229\128\139\229\149\143\233\161\140\229\155\158\229\160\177:)\227\128\130]=]
L["Counter Kill Troops"] = "\229\143\141\229\136\182\230\174\186\230\173\187\233\131\168\233\154\138"
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[\232\168\173\229\130\153\229\146\140\229\141\135\231\180\154\229\156\168\233\128\153\232\163\161\232\162\171\229\136\151\231\130\186\229\143\175\233\187\158\230\147\138\231\154\132\230\140\137\233\136\149\227\128\130
\231\148\177\230\150\188Blizzard \231\179\187\231\181\177\230\177\153\230\159\147\231\154\132\229\149\143\233\161\140\239\188\140\229\190\158\229\140\133\228\184\173\230\139\150\230\148\190\230\156\131\229\176\142\232\135\180\233\140\175\232\170\164\227\128\130
\229\166\130\230\158\156\230\130\168\229\190\158\229\140\133\228\184\173\230\139\150\230\148\190\228\186\134\228\184\128\229\128\139\231\137\169\229\147\129\239\188\140\229\137\135\230\156\131\230\148\182\229\136\176\233\140\175\232\170\164\227\128\130
\231\130\186\228\186\134\230\140\135\229\174\154\230\156\170\229\136\151\229\135\186\231\154\132\232\168\173\229\130\153\239\188\136\230\136\145\231\182\147\229\184\184\230\155\180\230\150\176\229\136\151\232\161\168\239\188\140\228\189\134\230\156\137\230\153\130\230\154\180\233\155\170\230\155\180\229\191\171\239\188\137\239\188\140\230\130\168\229\143\175\228\187\165\229\143\179\233\141\181\229\150\174\230\147\138\229\140\133\228\184\173\231\154\132\231\137\169\229\147\129\239\188\140\231\132\182\229\190\140\229\183\166\233\141\181\229\150\174\230\147\138\232\183\159\233\154\168\232\128\133\227\128\130
\233\128\153\231\168\174\230\150\185\229\188\143\230\130\168\228\184\141\230\156\131\230\148\182\229\136\176\228\187\187\228\189\149\233\140\175\232\170\164]=]
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = "\232\168\173\229\130\153\229\146\140\229\141\135\231\180\154\229\156\168\233\128\153\232\163\161\229\136\151\231\130\186\229\143\175\233\187\158\230\147\138\231\154\132\230\140\137\233\136\149\227\128\130 \231\148\177\230\150\188\230\154\180\233\155\170\230\177\161\230\159\147\231\179\187\231\181\177\231\154\132\229\149\143\233\161\140\239\188\140\229\166\130\230\158\156\230\130\168\229\190\158\229\140\133\228\184\173\230\139\150\230\148\190\231\137\169\229\147\129\239\188\140\230\130\168\230\156\131\230\148\182\229\136\176\233\140\175\232\170\164\227\128\130 \231\130\186\228\186\134\229\136\134\233\133\141\230\156\170\229\136\151\229\135\186\231\154\132\232\168\173\229\130\153\239\188\136\230\136\145\231\182\147\229\184\184\230\155\180\230\150\176\229\136\151\232\161\168\239\188\140\228\189\134\230\156\137\230\153\130\230\154\180\233\155\170\230\155\180\229\191\171\239\188\137\239\188\140\230\130\168\229\143\175\228\187\165\229\143\179\233\141\181\229\150\174\230\147\138\229\140\133\228\184\173\231\154\132\231\137\169\229\147\129\239\188\140\231\132\182\229\190\140\229\183\166\233\141\181\229\150\174\230\147\138\232\191\189\233\154\168\232\128\133\227\128\130 \233\128\153\230\168\163\228\189\160\229\176\177\228\184\141\230\156\131\230\148\182\229\136\176\228\187\187\228\189\149\233\140\175\232\170\164"
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[\228\190\139\229\166\130\239\188\140\229\129\135\232\168\173\228\184\128\229\128\139\228\187\187\229\139\153\229\143\175\228\187\165\233\129\148\229\136\17695%%\239\188\140130%%\229\146\140180%%\231\154\132\230\136\144\229\138\159\230\169\159\230\156\131\227\128\130
\229\166\130\230\158\156%1$s\232\168\173\231\189\174\231\130\186170%%\239\188\140\229\137\135\230\156\131\233\129\184\230\147\135180%%\227\128\130 \229\166\130\230\158\156%1$s \232\162\171\232\168\173\231\189\174\231\130\186200%% OHC\229\176\135\229\152\151\232\169\166\230\137\190\229\136\176\230\156\128\230\142\165\232\191\145100%%
\232\135\179\230\150\188%2$s\232\168\173\231\189\174
\229\129\135\232\168\173%2$s\232\168\173\231\189\174\231\130\186100%%\239\188\140\233\130\163\233\186\188\229\176\135\230\156\131\233\129\184\230\147\135130%%\239\188\140\228\189\134\229\166\130\230\158\156%2$s\232\168\173\231\189\174\231\130\18690%%\239\188\140\233\130\163\233\186\188\229\176\135\233\129\184\230\147\13595%%
\229\129\135\232\168\173\239\188\1332$s\232\168\173\231\189\174\231\130\186100%%\239\188\140\233\130\163\233\186\188\229\176\135\230\156\131\233\129\184\230\147\135130%%\239\188\140\228\189\134\229\166\130\230\158\156\239\188\1332$s\232\168\173\231\189\174\231\130\18690%%\239\188\140\233\130\163\233\186\188\229\176\135\233\129\184\230\147\13595%%]=]
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "\229\166\130\230\158\156\230\130\168\229\143\170\230\152\175\229\184\140\230\156\155\229\167\139\231\181\130\231\156\139\229\136\176\230\156\128\228\189\179\229\143\175\231\148\168\228\187\187\229\139\153\239\188\140\229\143\170\233\156\128\229\176\135%1$s\232\168\173\231\189\174\231\130\186100%%\239\188\140\229\176\135%2$s\232\168\173\231\189\174\231\130\1860%%"
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[\229\166\130\230\158\156\228\189\160\228\184\141\230\152\142\231\153\189OHC\229\166\130\228\189\149\233\129\184\230\147\135\228\184\128\229\128\139\228\187\187\229\139\153\231\154\132\232\168\173\231\189\174\239\188\140\228\189\160\229\143\175\228\187\165\232\166\129\230\177\130\228\184\128\229\128\139\229\174\140\230\149\180\231\154\132\229\136\134\230\158\144\227\128\130
\229\136\134\230\158\144\233\154\138\228\188\141\229\176\135\233\161\175\231\164\186\230\137\128\230\156\137\229\143\175\232\131\189\231\154\132\231\181\132\229\144\136, \228\187\165\229\143\138OHC\229\166\130\228\189\149\232\169\149\228\188\176\228\187\150\229\128\145]=]
L["Max champions"] = "\230\156\128\229\164\154\229\139\135\229\163\171"
L["Maximize xp gain"] = "\230\156\128\229\164\167\229\140\150\231\182\147\233\169\151\231\141\178\229\143\150"
L["Never kill Troops"] = "\231\181\149\228\184\141\230\174\186\230\173\187\233\131\168\233\154\138"
L["Prefer high durability"] = "\229\150\156\229\165\189\233\171\152\232\128\144\228\185\133\229\186\166"
L["Restart the tutorial"] = "\233\135\141\229\149\159\230\140\135\229\141\151"
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = "\230\143\146\230\167\189\239\188\136\228\184\141\230\152\175\229\133\182\228\184\173\231\154\132\232\191\189\233\154\168\232\128\133\239\188\140\232\128\140\229\143\170\230\152\175\230\143\146\230\167\189\239\188\137\229\143\175\228\187\165\232\162\171\231\166\129\230\173\162\227\128\130 \231\149\182\228\189\160\231\166\129\230\173\162\228\184\128\229\128\139\230\143\146\230\167\189\230\153\130\239\188\140\233\128\153\229\128\139\230\143\146\230\167\189\228\184\141\230\156\131\232\162\171\229\161\171\230\187\191\227\128\130 \231\184\189\230\152\175\229\156\168\230\156\128\229\183\166\229\129\180\231\154\132\230\143\146\230\167\189\228\189\191\231\148\168\233\131\168\233\154\138\239\188\140\230\130\168\229\143\175\228\187\165\229\175\166\231\143\190\228\184\128\229\128\139\229\190\136\229\165\189\231\154\132\229\174\154\229\136\182\232\163\129\229\137\170\239\188\140\230\184\155\229\176\145\231\148\168\230\150\188\228\187\187\229\139\153\231\154\132\232\191\189\233\154\168\232\128\133\231\184\189\230\149\184"
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "\231\181\130\230\173\162\230\156\172\230\140\135\229\141\151\227\128\130\230\130\168\229\143\175\228\187\165\233\154\168\230\153\130\233\187\158\230\147\138\229\129\180\233\157\162\233\129\184\229\150\174\228\184\173\231\154\132\232\168\138\230\129\175\229\156\150\230\168\153\228\190\134\230\129\162\229\190\169"
L["Thank you for reading this, enjoy %s"] = "\230\132\159\232\172\157\230\130\168\231\154\132\233\150\177\232\174\128\239\188\140\228\186\171\229\143\151%s"
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = "\233\128\154\229\184\184\239\188\140OrderHallCOmmander\229\152\151\232\169\166\228\189\191\231\148\168\230\156\128\228\189\142\232\128\144\228\185\133\230\128\167\231\154\132\233\131\168\233\154\138\239\188\140\228\187\165\228\190\191\231\155\161\229\191\171\232\171\139\230\177\130\230\150\176\231\154\132\233\131\168\233\154\138\227\128\130 \229\139\190\233\129\184%1$s\229\143\141\229\144\145\230\147\141\228\189\156\239\188\140OrderHallCOmmander\229\176\135\231\130\186\230\175\143\229\128\139\228\187\187\229\139\153\233\129\184\230\147\135\231\155\161\229\143\175\232\131\189\233\171\152\232\128\144\228\185\133\229\186\166\231\154\132\233\131\168\233\154\138"
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = "\230\173\161\232\191\142\228\190\134\229\136\176OrderHallCommander\231\154\132\230\150\176\231\137\136\230\156\172\232\171\139\230\140\137\231\133\167\233\128\153\229\128\139\231\176\161\231\159\173\231\154\132\230\140\135\229\141\151\228\190\134\231\153\188\231\143\190\230\137\128\230\156\137\230\150\176\231\154\132\229\138\159\232\131\189\227\128\130 \228\189\160\228\184\141\230\156\131\229\190\140\230\130\148\231\154\132"
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = "\232\135\179\230\150\188%1$s\228\189\160\232\166\129\230\177\130\231\184\189\230\152\175\229\143\141\229\136\182\229\141\177\233\154\170\230\174\186\230\173\187\233\131\168\233\154\138\227\128\130 \233\128\153\230\132\143\229\145\179\232\145\151OHC\229\176\135\232\169\166\229\156\150\229\176\141\228\187\152\229\174\131\239\188\140\230\136\150\232\128\133\228\189\191\231\148\168\228\184\128\229\128\139\229\143\170\230\156\137\228\184\128\229\128\139\232\128\144\228\185\133\229\186\166\231\154\132\233\131\168\233\154\138\227\128\130 \233\128\153\231\168\174\229\136\135\230\143\155\231\154\132\231\155\174\230\168\153\230\152\175\233\129\191\229\133\141\230\181\170\232\178\187\232\128\144\228\185\133\229\186\166\239\188\140\232\128\140\228\184\141\230\152\175\233\129\191\229\133\141\233\131\168\233\154\138\230\173\187\228\186\161\227\128\130"
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[\232\135\179\230\150\188%2$s\228\189\160\232\166\129\230\177\130\228\184\141\232\166\129\232\174\147\233\131\168\233\154\138\230\173\187\228\186\161\227\128\130
\233\128\153\228\184\141\229\131\133\230\132\143\229\145\179\232\145\151%1$s\229\146\140%3$s\239\188\140\232\128\140\228\184\148\229\188\183\229\136\182OHC\230\176\184\233\129\160\228\184\141\230\156\131\230\180\190\228\184\128\229\128\139\233\131\168\233\154\138\230\156\131\230\173\187\228\186\161\231\154\132\228\187\187\229\139\153\227\128\130
\233\128\153\229\128\139\232\189\137\232\174\138\231\154\132\231\155\174\230\168\153\230\152\175\229\174\140\229\133\168\233\129\191\229\133\141\230\174\186\230\173\187\233\131\168\233\154\138\239\188\140\229\141\179\228\189\191\233\128\153\230\168\163\230\136\145\229\128\145\228\185\159\228\184\141\232\131\189\229\161\171\232\163\156\233\154\138\228\188\141]=]
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = "\230\130\168\229\143\175\228\187\165\229\143\179\233\141\181\233\187\158\230\147\138\228\187\187\229\139\153\230\140\137\233\136\149\229\176\135\228\187\187\229\139\153\229\138\160\229\133\165\233\187\145\229\144\141\229\150\174\227\128\130 \232\135\1701.5.1\228\187\165\228\190\134\239\188\140\230\130\168\229\143\175\228\187\165shift-\233\187\158\230\147\138\228\187\187\229\139\153\230\140\137\233\136\149\233\150\139\229\167\139\228\187\187\229\139\153\232\128\140\231\132\161\233\160\136\232\189\137\229\136\176\228\187\187\229\139\153\233\160\129\233\157\162\227\128\130 \231\162\186\228\191\157\228\189\160\229\150\156\230\173\161\230\173\164\233\154\138\228\188\141\239\188\140\229\155\160\231\130\186\228\184\141\231\182\147\231\162\186\232\170\141"
L["You can choose not to use a troop type clicking its icon"] = "\230\130\168\229\143\175\228\187\165\229\150\174\230\147\138\229\133\182\229\156\150\230\168\153\233\129\184\230\147\135\228\184\141\228\189\191\231\148\168\231\154\132\233\131\168\233\154\138\233\161\158\229\158\139"
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[\230\130\168\229\143\175\228\187\165\233\129\184\230\147\135\233\153\144\229\136\182\228\184\128\232\181\183\229\136\134\230\180\190\231\154\132\229\139\135\229\163\171\230\149\184\233\135\143\227\128\130 \231\143\190\229\156\168OHC\230\178\146\230\156\137\229\156\168\229\144\140\228\184\128\229\128\139\228\187\187\229\139\153\228\184\173\228\189\191\231\148\168\232\182\133\233\129\142 %3$s \231\154\132\229\139\135\229\163\171 -

\232\171\139\230\179\168\230\132\143\239\188\140%2$s\230\156\131\232\166\134\232\147\139\229\174\131\227\128\130]=]

	end
end
L=LibStub("AceLocale-3.0"):GetLocale(me,true)

