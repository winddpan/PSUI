local me,ns=...
local lang=GetLocale()
local l=LibStub("AceLocale-3.0")
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
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%% lower than %2$d%%. Lower %s"
--Translation missing 
L["%s for a wowhead link popup"] = "%s for a wowhead link popup"
--Translation missing 
L["%s start the mission without even opening the mission page. No question asked"] = "%s start the mission without even opening the mission page. No question asked"
--Translation missing 
L["%s starts missions"] = "%s starts missions"
--Translation missing 
L["%s to blacklist"] = "%s to blacklist"
--Translation missing 
L["%s to remove from blacklist"] = "%s to remove from blacklist"
--Translation missing 
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=]
--Translation missing 
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s, please review the tutorial\\n(Click the icon to dismiss this message)"
--Translation missing 
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "Allow to start a mission directly from the mission list page (no single mission page shown)"
L["Always counter increased resource cost"] = "Sempre contra o aumento do custo de recursos"
L["Always counter increased time"] = "Sempre contra o aumento do tempo"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Sempre counter kill tropas (ignorado se podemos apenas usar tropas com apenas 1 durabilidade à esquerda)"
--Translation missing 
L["Always counter no bonus loot threat"] = "Always counter no bonus loot threat"
--Translation missing 
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Artifact shown value is the base value without considering knowledge multiplier"
--Translation missing 
L["Attempting %s"] = "Attempting %s"
--Translation missing 
L["Base Chance"] = "Base Chance"
L["Better parties available in next future"] = "Festas melhores disponíveis no próximo futuro"
--Translation missing 
L["Blacklisted"] = "Blacklisted"
--Translation missing 
L["Blacklisted missions are ignored in Mission Control"] = "Blacklisted missions are ignored in Mission Control"
--Translation missing 
L["Bonus Chance"] = "Bonus Chance"
L["Building Final report"] = "Relatório final do edifício"
--Translation missing 
L["but using troops with just one durability left"] = "but using troops with just one durability left"
L["Capped %1$s. Spend at least %2$d of them"] = "Capped% 1 $ s. Gaste pelo menos% 2 $ d deles"
L["Changes the sort order of missions in Mission panel"] = "Altera a ordem de classificação das missões no painel da Missão"
--Translation missing 
L["Combat ally is proposed for missions so you can consider unassigning him"] = "Combat ally is proposed for missions so you can consider unassigning him"
L["Complete all missions without confirmation"] = "Complete todas as missões sem confirmação"
L["Configuration for mission party builder"] = "Configuração para o construtor de parte da missão"
--Translation missing 
L["Cost reduced"] = "Cost reduced"
--Translation missing 
L["Could not fulfill mission, aborting"] = "Could not fulfill mission, aborting"
--Translation missing 
L["Counter kill Troops"] = "Counter kill Troops"
--Translation missing 
L["Customization options (non mission related)"] = "Customization options (non mission related)"
--Translation missing 
L["Disables warning: "] = "Disables warning: "
--Translation missing 
L["Dont use this slot"] = "Dont use this slot"
--Translation missing 
L["Don't use troops"] = "Don't use troops"
L["Duration reduced"] = "Duração reduzida"
L["Duration Time"] = "Tempo de duração"
--Translation missing 
L["Elites mission mode"] = "Elites mission mode"
--Translation missing 
L["Empty missions sorted as last"] = "Empty missions sorted as last"
--Translation missing 
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"
--Translation missing 
L["Equipped by following champions:"] = "Equipped by following champions:"
L["Expiration Time"] = "Data de validade"
L["Favours leveling follower for xp missions"] = "Favors leveling follower para missões xp"
L["General"] = "Geral"
L["Global approx. xp reward"] = "Global aprox. Recompensa xp"
--Translation missing 
L["Global approx. xp reward per hour"] = "Global approx. xp reward per hour"
L["HallComander Quick Mission Completion"] = "Conclusão Rápida da Missão HallComander"
--Translation missing 
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."
--Translation missing 
L["If not checked, inactive followers are used as last chance"] = "If not checked, inactive followers are used as last chance"
--Translation missing 
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[If you %s, you will lose them
Click on %s to abort]=]
--Translation missing 
L["Ignore busy followers"] = "Ignore busy followers"
--Translation missing 
L["Ignore inactive followers"] = "Ignore inactive followers"
L["Keep cost low"] = "Mantenha o custo baixo"
--Translation missing 
L["Keep extra bonus"] = "Keep extra bonus"
L["Keep time short"] = "Mantenha o tempo curto"
L["Keep time VERY short"] = "Mantenha o tempo MUITO curto"
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=]
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=]
L["Level"] = "Nível"
--Translation missing 
L["Lock all"] = "Lock all"
--Translation missing 
L["Lock this follower"] = "Lock this follower"
--Translation missing 
L["Locked follower are only used in this mission"] = "Locked follower are only used in this mission"
L["Make Order Hall Mission Panel movable"] = "Faça a encomenda Hall Missão Painel móvel"
--Translation missing 
L["Makes sure that no troops will be killed"] = "Makes sure that no troops will be killed"
--Translation missing 
L["Max champions"] = "Max champions"
L["Maximize xp gain"] = "Maximize o ganho de xp"
--Translation missing 
L["Mission duration reduced"] = "Mission duration reduced"
--Translation missing 
L["Mission was capped due to total chance less than"] = "Mission was capped due to total chance less than"
L["Missions"] = "Missões"
--Translation missing 
L["Never kill Troops"] = "Never kill Troops"
L["No follower gained xp"] = "Nenhum seguidor ganhou xp"
--Translation missing 
L["No suitable missions. Have you reserved at least one follower?"] = "No suitable missions. Have you reserved at least one follower?"
--Translation missing 
L["Not blacklisted"] = "Not blacklisted"
L["Nothing to report"] = "Nada a declarar"
L["Notifies you when you have troops ready to be collected"] = "Notifica você quando você tem tropas prontas para serem coletadas"
L["Only accept missions with time improved"] = "Aceitar apenas missões com o tempo melhorado"
--Translation missing 
L["Only consider elite missions"] = "Only consider elite missions"
--Translation missing 
L["Only use champions even if troops are available"] = "Only use champions even if troops are available"
--Translation missing 
L["Open configuration"] = "Open configuration"
--Translation missing 
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=]
L["Original method"] = "Método original"
L["Position is not saved on logout"] = "A posição não é salva no logout"
--Translation missing 
L["Prefer high durability"] = "Prefer high durability"
--Translation missing 
L["Quick start first mission"] = "Quick start first mission"
--Translation missing 
L["Remove no champions warning"] = "Remove no champions warning"
--Translation missing 
L["Restart tutorial from beginning"] = "Restart tutorial from beginning"
--Translation missing 
L["Resume tutorial"] = "Resume tutorial"
L["Resurrect troops effect"] = "Resurrect efeito tropas"
L["Reward type"] = "Tipo de recompensa"
--Translation missing 
L["Sets all switches to a very permissive setup"] = "Sets all switches to a very permissive setup"
--Translation missing 
L["Show tutorial"] = "Show tutorial"
L["Show/hide OrderHallCommander mission menu"] = "Mostrar / ocultar o menu da missão OrderHallCommander"
L["Sort missions by:"] = "Classifique missões por:"
--Translation missing 
L["Started with "] = "Started with "
L["Success Chance"] = "Chance de sucesso"
L["Troop ready alert"] = "Alerta de tropas"
--Translation missing 
L["Unable to fill missions, raise \"%s\""] = "Unable to fill missions, raise \"%s\""
--Translation missing 
L["Unable to fill missions. Check your switches"] = "Unable to fill missions. Check your switches"
--Translation missing 
L["Unable to start mission, aborting"] = "Unable to start mission, aborting"
--Translation missing 
L["Unlock all"] = "Unlock all"
--Translation missing 
L["Unlock this follower"] = "Unlock this follower"
--Translation missing 
L["Unlocks all follower and slots at once"] = "Unlocks all follower and slots at once"
L["Upgrading to |cff00ff00%d|r"] = "Atualizando para | cff00ff00% d | r"
--Translation missing 
L["URL Copy"] = "URL Copy"
--Translation missing 
L["Use at most this many champions"] = "Use at most this many champions"
--Translation missing 
L["Use combat ally"] = "Use combat ally"
--Translation missing 
L["Use this slot"] = "Use this slot"
--Translation missing 
L["Uses troops with the highest durability instead of the ones with the lowest"] = "Uses troops with the highest durability instead of the ones with the lowest"
--Translation missing 
L["When no free followers are available shows empty follower"] = "When no free followers are available shows empty follower"
--Translation missing 
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"
--Translation missing 
L["Would start with "] = "Would start with "
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Você está desperdiçando | cffff0000% d | cffffd200 point (s) !!!"
--Translation missing 
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=]
--Translation missing 
L["You now need to press both %s and %s to start mission"] = "You now need to press both %s and %s to start mission"

-- Tutorial
--Translation missing 
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=]
--Translation missing 
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[A requested window is not open
Tutorial will resume as soon as possible]=]
--Translation missing 
L["Base Chance"] = "Base Chance"
--Translation missing 
L["Bonus Chance"] = "Bonus Chance"
--Translation missing 
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=]
--Translation missing 
L["Counter Kill Troops"] = "Counter Kill Troops"
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=]
--Translation missing 
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"
--Translation missing 
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=]
--Translation missing 
L["Max champions"] = "Max champions"
--Translation missing 
L["Maximize xp gain"] = "Maximize xp gain"
--Translation missing 
L["Never kill Troops"] = "Never kill Troops"
--Translation missing 
L["Prefer high durability"] = "Prefer high durability"
--Translation missing 
L["Restart the tutorial"] = "Restart the tutorial"
--Translation missing 
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=]
--Translation missing 
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"
--Translation missing 
L["Thank you for reading this, enjoy %s"] = "Thank you for reading this, enjoy %s"
--Translation missing 
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=]
--Translation missing 
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=]
--Translation missing 
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=]
--Translation missing 
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=]
--Translation missing 
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=]
--Translation missing 
L["You can choose not to use a troop type clicking its icon"] = "You can choose not to use a troop type clicking its icon"
--Translation missing 
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=]

return
end
L=l:NewLocale(me,"frFR")
if (L) then
--Translation missing 
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%% lower than %2$d%%. Lower %s"
--Translation missing 
L["%s for a wowhead link popup"] = "%s for a wowhead link popup"
--Translation missing 
L["%s start the mission without even opening the mission page. No question asked"] = "%s start the mission without even opening the mission page. No question asked"
--Translation missing 
L["%s starts missions"] = "%s starts missions"
--Translation missing 
L["%s to blacklist"] = "%s to blacklist"
--Translation missing 
L["%s to remove from blacklist"] = "%s to remove from blacklist"
--Translation missing 
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=]
--Translation missing 
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s, please review the tutorial\\n(Click the icon to dismiss this message)"
--Translation missing 
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "Allow to start a mission directly from the mission list page (no single mission page shown)"
L["Always counter increased resource cost"] = "Toujours contrer les coûts accrus des ressources"
L["Always counter increased time"] = "Toujours contrer le temps accru"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Toujours éviter de tuer les troupes (ignoré s'il ne reste qu'un seul point de vitalité aux troupes disponibles)"
L["Always counter no bonus loot threat"] = "Toujours contrer les malus au butin bonus"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Le montant de puissance prodigieuse affichée est la valeur de base, sans prendre en considération le niveau de connaissance de l'arme prodigieuse"
--Translation missing 
L["Attempting %s"] = "Attempting %s"
--Translation missing 
L["Base Chance"] = "Base Chance"
L["Better parties available in next future"] = "De meilleurs groupes seront disponibles plus tard"
--Translation missing 
L["Blacklisted"] = "Blacklisted"
--Translation missing 
L["Blacklisted missions are ignored in Mission Control"] = "Blacklisted missions are ignored in Mission Control"
--Translation missing 
L["Bonus Chance"] = "Bonus Chance"
L["Building Final report"] = "Rapport final du bâtiment"
--Translation missing 
L["but using troops with just one durability left"] = "but using troops with just one durability left"
L["Capped %1$s. Spend at least %2$d of them"] = "Plafonné% 1 $ s. Dépenser au moins% 2 $ d d'entre eux"
L["Changes the sort order of missions in Mission panel"] = "Modifie l'ordre de tri des missions dans le panneau Mission"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "Le combattant allié est pris en compte pour le retirer et l'envoyer en mission"
L["Complete all missions without confirmation"] = "Terminer toutes les missions sans confirmation"
L["Configuration for mission party builder"] = "Configuration pour le constructeur de mission"
L["Cost reduced"] = "Coût réduit"
--Translation missing 
L["Could not fulfill mission, aborting"] = "Could not fulfill mission, aborting"
--Translation missing 
L["Counter kill Troops"] = "Counter kill Troops"
--Translation missing 
L["Customization options (non mission related)"] = "Customization options (non mission related)"
--Translation missing 
L["Disables warning: "] = "Disables warning: "
--Translation missing 
L["Dont use this slot"] = "Dont use this slot"
L["Don't use troops"] = "Ne pas utiliser les troupes"
L["Duration reduced"] = "Durée réduite"
L["Duration Time"] = "Durée"
--Translation missing 
L["Elites mission mode"] = "Elites mission mode"
--Translation missing 
L["Empty missions sorted as last"] = "Empty missions sorted as last"
--Translation missing 
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"
--Translation missing 
L["Equipped by following champions:"] = "Equipped by following champions:"
L["Expiration Time"] = "Date d'expiration"
L["Favours leveling follower for xp missions"] = "Favoriser les champions à entraîner pour les missions rapportant de l'expérience"
L["General"] = "Général"
L["Global approx. xp reward"] = "Global env. Xp récompense"
--Translation missing 
L["Global approx. xp reward per hour"] = "Global approx. xp reward per hour"
L["HallComander Quick Mission Completion"] = "Achèvement rapide de mission HallComander"
--Translation missing 
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."
L["If not checked, inactive followers are used as last chance"] = "Si non coché, les sujets désactivé seront utilisé en dernier recours"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[Si vous %s, vous allez les perdre.
Cliquez sur %s pour annuler.]=]
L["Ignore busy followers"] = "Ignorer les sujets occupés"
L["Ignore inactive followers"] = "Ignore les sujets désactivés"
L["Keep cost low"] = "Garder le coût bas"
L["Keep extra bonus"] = "Garder le butin bonus"
L["Keep time short"] = "Garde le temps court"
L["Keep time VERY short"] = "Gardez le temps très court"
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=]
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=]
L["Level"] = "Niveau"
--Translation missing 
L["Lock all"] = "Lock all"
--Translation missing 
L["Lock this follower"] = "Lock this follower"
--Translation missing 
L["Locked follower are only used in this mission"] = "Locked follower are only used in this mission"
L["Make Order Hall Mission Panel movable"] = "Panneau de missions de domaine déplaçable"
--Translation missing 
L["Makes sure that no troops will be killed"] = "Makes sure that no troops will be killed"
L["Max champions"] = "Champions max"
L["Maximize xp gain"] = "Maximiser le gain d'xp"
L["Mission duration reduced"] = "Durée de la mission réduite"
--Translation missing 
L["Mission was capped due to total chance less than"] = "Mission was capped due to total chance less than"
L["Missions"] = true
--Translation missing 
L["Never kill Troops"] = "Never kill Troops"
L["No follower gained xp"] = "Aucun sujet n'a gagné d'xp"
--Translation missing 
L["No suitable missions. Have you reserved at least one follower?"] = "No suitable missions. Have you reserved at least one follower?"
--Translation missing 
L["Not blacklisted"] = "Not blacklisted"
L["Nothing to report"] = "Rien à signaler"
L["Notifies you when you have troops ready to be collected"] = "Vous avertit lorsque vous avez des troupes prêtes à être récupérées"
L["Only accept missions with time improved"] = "N'acceptez que les missions avec le temps amélioré"
--Translation missing 
L["Only consider elite missions"] = "Only consider elite missions"
L["Only use champions even if troops are available"] = "Utiliser uniquement des champions même si des troupes sont disponibles"
--Translation missing 
L["Open configuration"] = "Open configuration"
--Translation missing 
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=]
L["Original method"] = "Méthode originale"
L["Position is not saved on logout"] = "La position n'est pas enregistrée lors de la déconnexion"
--Translation missing 
L["Prefer high durability"] = "Prefer high durability"
--Translation missing 
L["Quick start first mission"] = "Quick start first mission"
--Translation missing 
L["Remove no champions warning"] = "Remove no champions warning"
--Translation missing 
L["Restart tutorial from beginning"] = "Restart tutorial from beginning"
--Translation missing 
L["Resume tutorial"] = "Resume tutorial"
L["Resurrect troops effect"] = "Effet Résurrection des troupes"
L["Reward type"] = "Type de récompense"
--Translation missing 
L["Sets all switches to a very permissive setup"] = "Sets all switches to a very permissive setup"
--Translation missing 
L["Show tutorial"] = "Show tutorial"
L["Show/hide OrderHallCommander mission menu"] = "Afficher / masquer le menu de mission OrderHallCommander"
L["Sort missions by:"] = "Trier les missions par:"
--Translation missing 
L["Started with "] = "Started with "
L["Success Chance"] = "Chance de succès"
L["Troop ready alert"] = "Alerte troupes prêtes"
--Translation missing 
L["Unable to fill missions, raise \"%s\""] = "Unable to fill missions, raise \"%s\""
L["Unable to fill missions. Check your switches"] = "Impossible de remplir les missions. Vérifiez les paramètres."
--Translation missing 
L["Unable to start mission, aborting"] = "Unable to start mission, aborting"
--Translation missing 
L["Unlock all"] = "Unlock all"
--Translation missing 
L["Unlock this follower"] = "Unlock this follower"
--Translation missing 
L["Unlocks all follower and slots at once"] = "Unlocks all follower and slots at once"
L["Upgrading to |cff00ff00%d|r"] = "Mise à niveau vers |cff00ff00%d|r"
--Translation missing 
L["URL Copy"] = "URL Copy"
L["Use at most this many champions"] = "Utilisé au maximum ce nombre de champions"
L["Use combat ally"] = "Utiliser le combattant allié"
--Translation missing 
L["Use this slot"] = "Use this slot"
--Translation missing 
L["Uses troops with the highest durability instead of the ones with the lowest"] = "Uses troops with the highest durability instead of the ones with the lowest"
L["When no free followers are available shows empty follower"] = "Quand aucun sujet n'est disponible afficher un sujet vide"
--Translation missing 
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"
--Translation missing 
L["Would start with "] = "Would start with "
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Vous perdez |cffff0000%d|cffffd200 point (s) !!!"
--Translation missing 
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=]
--Translation missing 
L["You now need to press both %s and %s to start mission"] = "You now need to press both %s and %s to start mission"

-- Tutorial
--Translation missing 
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=]
--Translation missing 
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[A requested window is not open
Tutorial will resume as soon as possible]=]
--Translation missing 
L["Base Chance"] = "Base Chance"
--Translation missing 
L["Bonus Chance"] = "Bonus Chance"
--Translation missing 
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=]
--Translation missing 
L["Counter Kill Troops"] = "Counter Kill Troops"
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=]
--Translation missing 
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"
--Translation missing 
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=]
--Translation missing 
L["Max champions"] = "Max champions"
--Translation missing 
L["Maximize xp gain"] = "Maximize xp gain"
--Translation missing 
L["Never kill Troops"] = "Never kill Troops"
--Translation missing 
L["Prefer high durability"] = "Prefer high durability"
--Translation missing 
L["Restart the tutorial"] = "Restart the tutorial"
--Translation missing 
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=]
--Translation missing 
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"
--Translation missing 
L["Thank you for reading this, enjoy %s"] = "Thank you for reading this, enjoy %s"
--Translation missing 
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=]
--Translation missing 
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=]
--Translation missing 
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=]
--Translation missing 
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=]
--Translation missing 
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=]
--Translation missing 
L["You can choose not to use a troop type clicking its icon"] = "You can choose not to use a troop type clicking its icon"
--Translation missing 
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=]

return
end
L=l:NewLocale(me,"deDE")
if (L) then
--Translation missing 
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%% lower than %2$d%%. Lower %s"
--Translation missing 
L["%s for a wowhead link popup"] = "%s for a wowhead link popup"
--Translation missing 
L["%s start the mission without even opening the mission page. No question asked"] = "%s start the mission without even opening the mission page. No question asked"
--Translation missing 
L["%s starts missions"] = "%s starts missions"
--Translation missing 
L["%s to blacklist"] = "%s to blacklist"
--Translation missing 
L["%s to remove from blacklist"] = "%s to remove from blacklist"
--Translation missing 
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=]
--Translation missing 
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s, please review the tutorial\\n(Click the icon to dismiss this message)"
--Translation missing 
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "Allow to start a mission directly from the mission list page (no single mission page shown)"
L["Always counter increased resource cost"] = "Immer erhöhte Ressourcenkosten kontern"
L["Always counter increased time"] = "Immer erhöhte Missionsdauer kontern"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Töten der Trupps immer kontern (dies wird ignoriert, falls nur Truppen mit 1 Haltbarkeit benutzt werden können)"
L["Always counter no bonus loot threat"] = "Kontert immer Bedrohungen, die Bonusbeute verhindern"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Der angezeigte Wert ist der Grundwert ohne die Berücksichtigung von Artefakwissen."
--Translation missing 
L["Attempting %s"] = "Attempting %s"
L["Base Chance"] = "Basis-Chance"
L["Better parties available in next future"] = "Bessere Gruppen sind in absehbarer Zeit verfügbar"
--Translation missing 
L["Blacklisted"] = "Blacklisted"
--Translation missing 
L["Blacklisted missions are ignored in Mission Control"] = "Blacklisted missions are ignored in Mission Control"
L["Bonus Chance"] = "Bonus-Chance"
L["Building Final report"] = "Erstelle Abschlussbericht"
--Translation missing 
L["but using troops with just one durability left"] = "but using troops with just one durability left"
L["Capped %1$s. Spend at least %2$d of them"] = "Maximal %1$ s. Gib mindestens %2$d davon aus"
L["Changes the sort order of missions in Mission panel"] = "Verändert die Sortierreihenfolge der Missionen in der Missionsübersicht"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "Der Kampfgefährte wird für Missionen vorgeschlagen, du kannst dann entscheiden, ob du ihn abziehen möchtest"
L["Complete all missions without confirmation"] = "Alle Missionen ohne Bestätigung abschließen"
L["Configuration for mission party builder"] = "Konfiguration des Gruppenerstellers für Missionen"
L["Cost reduced"] = "Kosten reduziert"
--Translation missing 
L["Could not fulfill mission, aborting"] = "Could not fulfill mission, aborting"
L["Counter kill Troops"] = "Kontere Tödlich"
--Translation missing 
L["Customization options (non mission related)"] = "Customization options (non mission related)"
L["Disables warning: "] = "Deaktiviert Warnung:"
--Translation missing 
L["Dont use this slot"] = "Dont use this slot"
L["Don't use troops"] = "Keine Truppen verwenden"
L["Duration reduced"] = "Dauer reduziert"
L["Duration Time"] = "Dauer"
--Translation missing 
L["Elites mission mode"] = "Elites mission mode"
--Translation missing 
L["Empty missions sorted as last"] = "Empty missions sorted as last"
--Translation missing 
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"
--Translation missing 
L["Equipped by following champions:"] = "Equipped by following champions:"
L["Expiration Time"] = "Ablaufzeit"
L["Favours leveling follower for xp missions"] = "Bevorzugt niedrigstufige Anhänger für EP-Missionen"
L["General"] = "Allgemein"
L["Global approx. xp reward"] = "EP-Belohnung gesamt"
L["Global approx. xp reward per hour"] = "EP-Belohnung pro Stunde"
L["HallComander Quick Mission Completion"] = "HallComander Schneller Missionsabschluss"
--Translation missing 
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."
L["If not checked, inactive followers are used as last chance"] = "Wenn nicht ausgewählt, werden inaktive Anhänger als letzte Möglichkeit verwendet"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[Wenn du %s, wirst du sie verlieren.
Klicke auf %s, um abzubrechen]=]
L["Ignore busy followers"] = "Beschäftigte Anhänger ignorieren"
L["Ignore inactive followers"] = "Untätige Anhänger ignorieren"
L["Keep cost low"] = "Kosten niedrig halten"
L["Keep extra bonus"] = "Bonusbeute behalten"
L["Keep time short"] = "Zeit kurz halten"
L["Keep time VERY short"] = "Zeit SEHR kurz halten"
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=]
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=]
L["Level"] = "Stufe"
--Translation missing 
L["Lock all"] = "Lock all"
--Translation missing 
L["Lock this follower"] = "Lock this follower"
--Translation missing 
L["Locked follower are only used in this mission"] = "Locked follower are only used in this mission"
L["Make Order Hall Mission Panel movable"] = "Ordenshallen-Missionsfenster beweglich machen"
--Translation missing 
L["Makes sure that no troops will be killed"] = "Makes sure that no troops will be killed"
L["Max champions"] = "Max. Anhänger"
L["Maximize xp gain"] = "Erfahrungszunahme maximieren"
L["Mission duration reduced"] = "Missionsdauer reduziert"
--Translation missing 
L["Mission was capped due to total chance less than"] = "Mission was capped due to total chance less than"
L["Missions"] = "Missionen"
L["Never kill Troops"] = "Töte nie Truppen"
L["No follower gained xp"] = "Kein Anhänger erhielt EP"
--Translation missing 
L["No suitable missions. Have you reserved at least one follower?"] = "No suitable missions. Have you reserved at least one follower?"
--Translation missing 
L["Not blacklisted"] = "Not blacklisted"
L["Nothing to report"] = "Nichts zu berichten"
L["Notifies you when you have troops ready to be collected"] = "Benachrichtigt, wenn Truppen bereit sind, gesammelt zu werden"
L["Only accept missions with time improved"] = "Nur Missionen mit verkürzter Dauer annehmen"
--Translation missing 
L["Only consider elite missions"] = "Only consider elite missions"
L["Only use champions even if troops are available"] = "Verwende nur Anhänger, auch wenn Trupps vorhanden sind"
--Translation missing 
L["Open configuration"] = "Open configuration"
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander überschreibt GarrisonCommaner für Mission in der Ordenshalle.
Du kannst OrderhallCommander einfach deaktvieren um wieder OrderhallCommander zu verwenden.
Wenn du OrderhallCommander allerdings gut findest, vergiss nicht es in deinem Curse Client hinzuzufügen und aktuell zu halten.]=]
L["Original method"] = "Standard"
L["Position is not saved on logout"] = "Die Position wird beim Ausloggen nicht gespeichert"
L["Prefer high durability"] = "Bevorzuge hohe Haltbarkeit"
--Translation missing 
L["Quick start first mission"] = "Quick start first mission"
--Translation missing 
L["Remove no champions warning"] = "Remove no champions warning"
--Translation missing 
L["Restart tutorial from beginning"] = "Restart tutorial from beginning"
--Translation missing 
L["Resume tutorial"] = "Resume tutorial"
L["Resurrect troops effect"] = "Truppen wiederbeleben"
L["Reward type"] = "Belohnungsart"
--Translation missing 
L["Sets all switches to a very permissive setup"] = "Sets all switches to a very permissive setup"
L["Show tutorial"] = "Zeige Tutorial"
L["Show/hide OrderHallCommander mission menu"] = "OrderHallCommander-Missionsmenü zeigen/ausblenden"
L["Sort missions by:"] = "Sortieren nach:"
L["Started with "] = "Startet mit"
L["Success Chance"] = "Erfolgschance"
L["Troop ready alert"] = "Warnung Trupp bereit"
--Translation missing 
L["Unable to fill missions, raise \"%s\""] = "Unable to fill missions, raise \"%s\""
L["Unable to fill missions. Check your switches"] = "Mit den aktuellen Einstellungen kann keine Mission besetzt werden"
--Translation missing 
L["Unable to start mission, aborting"] = "Unable to start mission, aborting"
--Translation missing 
L["Unlock all"] = "Unlock all"
--Translation missing 
L["Unlock this follower"] = "Unlock this follower"
--Translation missing 
L["Unlocks all follower and slots at once"] = "Unlocks all follower and slots at once"
L["Upgrading to |cff00ff00%d|r"] = "Erhöhe Stufe auf |cff00ff00%d|r"
L["URL Copy"] = "URL kopieren"
L["Use at most this many champions"] = "Verwende maximal so viele Anhänger pro Mission"
L["Use combat ally"] = "Kampfgefährten verwenden"
--Translation missing 
L["Use this slot"] = "Use this slot"
--Translation missing 
L["Uses troops with the highest durability instead of the ones with the lowest"] = "Uses troops with the highest durability instead of the ones with the lowest"
--Translation missing 
L["When no free followers are available shows empty follower"] = "When no free followers are available shows empty follower"
--Translation missing 
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"
--Translation missing 
L["Would start with "] = "Would start with "
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Du verschwendst |cffff0000%d |cffffd200|4Punkt:Punkte;!"
--Translation missing 
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=]
--Translation missing 
L["You now need to press both %s and %s to start mission"] = "You now need to press both %s and %s to start mission"

-- Tutorial
--Translation missing 
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=]
--Translation missing 
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[A requested window is not open
Tutorial will resume as soon as possible]=]
L["Base Chance"] = "Basis-Chance"
L["Bonus Chance"] = "Bonus-Chance"
--Translation missing 
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=]
L["Counter Kill Troops"] = "Kontere Tödlich"
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=]
--Translation missing 
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"
--Translation missing 
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=]
--Translation missing 
L["Max champions"] = "Max champions"
--Translation missing 
L["Maximize xp gain"] = "Maximize xp gain"
L["Never kill Troops"] = "Töte nie Truppen"
L["Prefer high durability"] = "Bevorzuge hohe Haltbarkeit"
L["Restart the tutorial"] = "Startet das Tutorial neu"
--Translation missing 
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=]
--Translation missing 
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"
--Translation missing 
L["Thank you for reading this, enjoy %s"] = "Thank you for reading this, enjoy %s"
--Translation missing 
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=]
--Translation missing 
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=]
--Translation missing 
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=]
--Translation missing 
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=]
--Translation missing 
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=]
--Translation missing 
L["You can choose not to use a troop type clicking its icon"] = "You can choose not to use a troop type clicking its icon"
--Translation missing 
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=]

return
end
L=l:NewLocale(me,"itIT")
if (L) then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%% è inferiore a %2$d%%. Abbassa %s"
--Translation missing 
L["%s for a wowhead link popup"] = "%s for a wowhead link popup"
--Translation missing 
L["%s start the mission without even opening the mission page. No question asked"] = "%s start the mission without even opening the mission page. No question asked"
--Translation missing 
L["%s starts missions"] = "%s starts missions"
L["%s to blacklist"] = "Clicca col destro per mettere in blacklist"
L["%s to remove from blacklist"] = "Clicca col destro per rimuovere dalla blacklist"
--Translation missing 
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=]
--Translation missing 
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s, please review the tutorial\\n(Click the icon to dismiss this message)"
--Translation missing 
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "Allow to start a mission directly from the mission list page (no single mission page shown)"
L["Always counter increased resource cost"] = "Contrasta sempre incremento risorse"
L["Always counter increased time"] = "Contrasta sempre incremento durata"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Contrasta sempre morte milizie (ignorato tutte le milizie hanno solo una vita rimanente)"
L["Always counter no bonus loot threat"] = "Contrasta sempre il \"no bonus\""
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Il valore mostrato è quello base, senza considerare il moltiplicatore dalla conoscenza"
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
L["Customization options (non mission related)"] = "Customization options (non mission related)"
L["Disables warning: "] = "Disabilita l'avviso:"
L["Dont use this slot"] = "Non usare questo slot"
L["Don't use troops"] = "Non usare truppe"
L["Duration reduced"] = "Durata ridotta"
L["Duration Time"] = "Durata"
L["Elites mission mode"] = "Modalità missioni \"elite\""
L["Empty missions sorted as last"] = "Le missioni senza campioni vengono ordinate come ultime"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "Le missioni senza campioni o con lo 0% o meno di possibilità di successo vengono ordinate come ultime. Non si applica all'ordinamento originale Blizzard"
L["Equipped by following champions:"] = "Usato da questi campioni:"
L["Expiration Time"] = "Scadenza"
L["Favours leveling follower for xp missions"] = "Preferisci i campioni che devono livellare"
L["General"] = "Generale"
L["Global approx. xp reward"] = "Approssimativi PE globali"
L["Global approx. xp reward per hour"] = "Approssimativi PE globali per ora"
L["HallComander Quick Mission Completion"] = "OrderHallCommander Completamento rapido"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "Se %1$s è inferiore a questa, allora cerchiamo di raggiungere almeno %2$s senza superare il 100%%. Viene ignorato nelle missioni elite."
L["If not checked, inactive followers are used as last chance"] = "Se non attivo, visualizzerà seguaci inattivi pur di riempire la missione"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = "Se %s le perderai. Clicca su %s per interrompere"
L["Ignore busy followers"] = "Ignora i seguaci occupati"
L["Ignore inactive followers"] = "Ignora i seguaci inattivi"
L["Keep cost low"] = "Mantieni il costo basso"
L["Keep extra bonus"] = "Ottieni il bonus aggiuntivo"
L["Keep time short"] = "Riduci la durata"
L["Keep time VERY short"] = "Riduci MOLTO la durata"
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=]
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
L["Mission was capped due to total chance less than"] = "La percentuale di success è stata ridotta perché era comunque inferiore a"
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
L["Open configuration"] = "Open configuration"
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander sostituisce l'interfaccia di GarrisonComamnder per le missioni di classe
Disabilitalo se preferisci GarrisonCommander.
Se invece ti piace, aggiungilo al client Curse e tienilo aggiornato]=]
L["Original method"] = "Metodo originale"
L["Position is not saved on logout"] = "La posizione non è salvata alla disconnessione"
L["Prefer high durability"] = "Alta durabilità preferita"
L["Quick start first mission"] = "Avvio rapido prima missione"
L["Remove no champions warning"] = "Rimuovi avviso campioni insufficienti"
--Translation missing 
L["Restart tutorial from beginning"] = "Restart tutorial from beginning"
--Translation missing 
L["Resume tutorial"] = "Resume tutorial"
L["Resurrect troops effect"] = "Resurrezione truppe possibile"
L["Reward type"] = "Tipo ricompensa"
--Translation missing 
L["Sets all switches to a very permissive setup"] = "Sets all switches to a very permissive setup"
--Translation missing 
L["Show tutorial"] = "Show tutorial"
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
L["Uses troops with the highest durability instead of the ones with the lowest"] = "Sceglie la truppe con durabilità residua piu' alta anziché quelle con durabilità residua piu' bassa"
L["When no free followers are available shows empty follower"] = "Quando non ci sono seguaci disponibili mostra le caselle vuote"
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "Se non è possibile raggiungere la percentuale di successo globale, si cerca di raggiungere almeno questa senza superare il 100%"
L["Would start with "] = "Avvierei con"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Stai sprecando |cffff0000%d|cffffd200 punti!!"
--Translation missing 
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=]
--Translation missing 
L["You now need to press both %s and %s to start mission"] = "You now need to press both %s and %s to start mission"

-- Tutorial
--Translation missing 
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=]
--Translation missing 
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[A requested window is not open
Tutorial will resume as soon as possible]=]
--Translation missing 
L["Base Chance"] = "Base Chance"
--Translation missing 
L["Bonus Chance"] = "Bonus Chance"
--Translation missing 
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=]
--Translation missing 
L["Counter Kill Troops"] = "Counter Kill Troops"
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=]
--Translation missing 
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"
--Translation missing 
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=]
--Translation missing 
L["Max champions"] = "Max champions"
--Translation missing 
L["Maximize xp gain"] = "Maximize xp gain"
--Translation missing 
L["Never kill Troops"] = "Never kill Troops"
--Translation missing 
L["Prefer high durability"] = "Prefer high durability"
--Translation missing 
L["Restart the tutorial"] = "Restart the tutorial"
--Translation missing 
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=]
--Translation missing 
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"
--Translation missing 
L["Thank you for reading this, enjoy %s"] = "Thank you for reading this, enjoy %s"
--Translation missing 
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=]
--Translation missing 
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=]
--Translation missing 
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=]
--Translation missing 
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=]
--Translation missing 
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=]
--Translation missing 
L["You can choose not to use a troop type clicking its icon"] = "You can choose not to use a troop type clicking its icon"
--Translation missing 
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=]

return
end
L=l:NewLocale(me,"koKR")
if (L) then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%2$d%%보다 %1$d%% 낮습니다. %3$s 낮습니다"
L["%s for a wowhead link popup"] = "%s - wowhead 링크 팝업"
L["%s start the mission without even opening the mission page. No question asked"] = "%s - 임무 페이지를 열지 않고 임무를 시작합니다. 아무것도 묻지 않습니다"
L["%s starts missions"] = "%s - 임무 시작"
L["%s to blacklist"] = "차단하려면 %s"
L["%s to remove from blacklist"] = "차단목록에서 제거하려면 %s"
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s님, 설명서를 살펴봐주세요
(아이콘을 클릭하면 이 메시지를 닫고 설명서를 시작합니다)]=]
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = [=[%s님, 설명서를 살펴봐주세요
(이 메시지를 닫으려면 아이콘을 클릭하세요)]=]
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "임무 목록 페이지에서 임무를 바로 시작할 수 있도록 허용합니다 (단일 임무 페이지가 표시되지 않습니다)"
L["Always counter increased resource cost"] = "자원 비용 증가 항상 대응"
L["Always counter increased time"] = "소요 시간 증가 항상 대응"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "병력 죽이기 항상 대응 (활력이 1만 남은 병력만 있을 땐 무시)"
L["Always counter no bonus loot threat"] = "추가 전리품 획득 불가 항상 대응"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "표시된 유물력 수치는 유물 지식 레벨을 고려하지 않은 기본 수치입니다"
L["Attempting %s"] = "%s 시도 중"
L["Base Chance"] = "기본 성공 확률"
L["Better parties available in next future"] = "다음 시간 후엔 더 나은 파티가 가능합니다"
L["Blacklisted"] = "차단됨"
L["Blacklisted missions are ignored in Mission Control"] = "차단된 임무는 임무 제어에서 무시됩니다"
L["Bonus Chance"] = "보너스 주사위"
L["Building Final report"] = "최종 보고서 작성"
L["but using troops with just one durability left"] = "활력이 하나만 남은 병력은 사용합니다"
L["Capped %1$s. Spend at least %2$d of them"] = "%1$s에 도달했습니다. 최소 %2$d|1을;를; 소모하세요"
L["Changes the sort order of missions in Mission panel"] = "임무 창 내 임무의 정렬 방법을 변경합니다"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "전투 동료가 임무에 제안되며 전투 동료 지정 해제를 해야 할 수 있습니다"
L["Complete all missions without confirmation"] = "확인 없이 모든 임무를 완료합니다"
L["Configuration for mission party builder"] = "임무 파티 구성 설정"
L["Cost reduced"] = "비용 감소"
L["Could not fulfill mission, aborting"] = "임무를 완료할 수 없습니다, 취소합니다"
L["Counter kill Troops"] = "병력 죽이기 대응"
--Translation missing 
L["Customization options (non mission related)"] = "Customization options (non mission related)"
L["Disables warning: "] = "경고 비활성: "
L["Dont use this slot"] = "이 칸 사용하지 않기"
L["Don't use troops"] = "병력 사용하지 않기"
L["Duration reduced"] = "소요 시간 감소"
L["Duration Time"] = "소요 시간"
L["Elites mission mode"] = "정예 임무 모드"
L["Empty missions sorted as last"] = "빈 임무를 마지막에 정렬"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "비었거나 성공률이 0%인 임무가 마지막에 정렬됩니다. \"원래의 방법\"에는 적용되지 않습니다"
L["Equipped by following champions:"] = "다음 용사가 장착함:"
L["Expiration Time"] = "만료 시간"
L["Favours leveling follower for xp missions"] = "레벨 육성 중인 추종자를 경험치 임무에 우선 지정합니다"
L["General"] = "일반"
L["Global approx. xp reward"] = "총 예상 경험치 보상"
L["Global approx. xp reward per hour"] = "시간 당 예상 경험치 보상"
L["HallComander Quick Mission Completion"] = "HallCommander 빠른 임무 완료"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "%1$s|1이;가; 이 값보다 낮으면 100%%를 넘기지 않고 최소 %2$s|1을;를; 달성하도록 시도합니다. 정예 임무는 무시합니다."
L["If not checked, inactive followers are used as last chance"] = "선택하지 않으면 비활성 추종자가 확률 계산에 사용됩니다"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[만약 %s|1이라면;라면; 그들을 잃게 됩니다
취소하려면 %s|1을;를; 클릭하세요]=]
L["Ignore busy followers"] = "바쁜 추종자 무시"
L["Ignore inactive followers"] = "비활성 추종자 무시"
L["Keep cost low"] = "비용 절감 유지"
L["Keep extra bonus"] = "추가 전리품 유지"
L["Keep time short"] = "시간 절약 유지"
L["Keep time VERY short"] = "시간 매우 절약 유지"
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[최소 한명의 추종자가 고정된 첫번째로 채워진 임무를 시작합니다.
%s|1을;를; 누르고 있어야 실제로 시작하며, 단순히 클릭만 하면 임무 이름과 배정된 추종자 명단만 출력합니다]=]
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[최소 한명의 추종자가 고정된 첫번째로 채워진 임무를 시작합니다.
SHIFT를 누르고 있어야 실제로 시작하며, 단순히 클릭만 하면 임무 이름과 배정된 추종자 명단만 출력합니다]=]
L["Level"] = "레벨"
L["Lock all"] = "모두 고정"
L["Lock this follower"] = "이 추종자 고정"
L["Locked follower are only used in this mission"] = "고정된 추종자는 이 임무에서만 사용됩니다"
L["Make Order Hall Mission Panel movable"] = "직업 전당 임무 창 이동 가능 설정"
L["Makes sure that no troops will be killed"] = "병력이 죽지 않게 합니다"
L["Max champions"] = "최대 용사"
L["Maximize xp gain"] = "경험치 획득 최대화"
L["Mission duration reduced"] = "임무 소요 시간 감소"
L["Mission was capped due to total chance less than"] = "전체 확률이 다음보다 낮아서 임무가 제한되었습니다:"
L["Missions"] = "임무"
L["Never kill Troops"] = "병력 죽이지 않기"
L["No follower gained xp"] = "경험치를 획득한 추종자 없음"
L["No suitable missions. Have you reserved at least one follower?"] = "적절한 임무가 없습니다. 최소 한명의 추종자를 예약했나요?"
L["Not blacklisted"] = "차단되지 않음"
L["Nothing to report"] = "보고할 내용 없음"
L["Notifies you when you have troops ready to be collected"] = "병력을 회수할 준비가 되면 당신에게 알립니다"
L["Only accept missions with time improved"] = "소요 시간이 감소한 임무만 수락합니다"
L["Only consider elite missions"] = "정예 임무만 고려"
L["Only use champions even if troops are available"] = "병력을 사용가능 해도 용사만 사용합니다"
L["Open configuration"] = "설정 열기"
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander는 직업 전당 관리에 GarrisonCommander보다 우선됩니다.
OrderHallCommander를 비활성하면 GarrisonCommander로 전환할 수 있습니다.
대신 당신이 OrderHallCommander를 좋아한다면 Curse 클라이언트에 추가하고 업데이트를 유지하세요]=]
L["Original method"] = "원래의 방법"
L["Position is not saved on logout"] = "접속 종료시 위치는 저장되지 않습니다"
L["Prefer high durability"] = "높은 활력 선호"
L["Quick start first mission"] = "첫번째 임무 빠른 시작"
L["Remove no champions warning"] = "용사 없음 경고 제거"
L["Restart tutorial from beginning"] = "처음부터 설명서 다시 시작"
L["Resume tutorial"] = "설명서 이어서 시작"
L["Resurrect troops effect"] = "병력 부활 효과"
L["Reward type"] = "보상 유형"
L["Sets all switches to a very permissive setup"] = "모든 전환 설정을 허용적인 구성으로 설정"
L["Show tutorial"] = "살명서 보기"
L["Show/hide OrderHallCommander mission menu"] = "OrderHallCommander 임무 메뉴 표시/숨기기"
L["Sort missions by:"] = "임무 정렬 방법:"
L["Started with "] = "다음과 함께 시작:"
L["Success Chance"] = "성공 확률"
L["Troop ready alert"] = "병력 준비 경보"
L["Unable to fill missions, raise \"%s\""] = "임무를 채울 수 없습니다, \"%s\"|1을;를; 늘리세요"
L["Unable to fill missions. Check your switches"] = "임무를 채울 수 없습니다. 설정을 확인하세요"
L["Unable to start mission, aborting"] = "임무를 시작할 수 없습니다, 취소합니다"
L["Unlock all"] = "모두 고정 해제"
L["Unlock this follower"] = "이 추종자 고정 해제"
L["Unlocks all follower and slots at once"] = "모든 추종자와 칸을 한번에 고정 해제"
L["Upgrading to |cff00ff00%d|r"] = "|cff00ff00%d|r|1으로;로; 향상시키기"
L["URL Copy"] = "URL 복사"
L["Use at most this many champions"] = "되도록 이 숫자의 용사를 사용합니다"
L["Use combat ally"] = "전투 동료 사용"
L["Use this slot"] = "이 칸 사용"
L["Uses troops with the highest durability instead of the ones with the lowest"] = "가장 낮은 활력을 가진 병력 대신 가장 높은 활력을 가진 병력을 사용합니다"
L["When no free followers are available shows empty follower"] = "사용 가능한 추종자가 없으면 추종자 칸을 빈 상태로 표시합니다"
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "요청된 %1$s|1을;를; 달성하지 못했을 때 (가능하다면) 100%%를 넘기지 않고 최소한 이 값에 근접하도록 시도합니다"
L["Would start with "] = "다음과 같이 시작할 예정:"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "|cffff0000%d|cffffd200점을 낭비하고 있습니다!!!"
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[이 버전의 OrderHallCommander를 업데이트하기 위해 월드 오브 워크래프트를 종료한 후 다시 시작해야 합니다.
UI를 다시 불러오는 것으로 충분하지 않습니다]=]
L["You now need to press both %s and %s to start mission"] = "임무를 시작하려면 %s|1과;와; %s|1을;를; 같이 눌러야 합니다"

-- Tutorial
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[당신이 원하는 임무를 채우는 방법을 사용자 설정할 수 있도록 %1$s|1과;와; %2$s|1은;는; 함께 작동합니다

%1$s에 설정된 추가 전리품을 얻는 데 시도하는 최소 허용 확률(현재 %3$s%%)을 강력한 추종자가 충분하지 않아서 달성하지 못하면 %2$s(현재 %4$s%%)에 맞춥니다]=]
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[요청된 창이 열리지 않았습니다
가능하다면 설명서가 다시 시작됩니다]=]
L["Base Chance"] = "기본 성공 확률"
L["Bonus Chance"] = "보너스 주사위"
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = "파티 버튼을 클릭하면 현재 임무에 추종자를 지정합니다. 사용하면 OHC가 블리자드의 확률로 성공률을 계산하도록 허용합니다. 차이가 있다면 스크린샷을 찍고 티켓을 열어주세요 :)."
L["Counter Kill Troops"] = "병력 죽이기 대응"
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[추종자 장비와 레벨 아이템은 여기에 클릭할 수 있는 버튼으로 나열됩니다.
블리자드 코드 보호 체계에 의해 가방에서 끌어다 놓으면 오류가 발생됩니다.
가방에서 아이템을 끌어다 놓으면 오류가 발생합니다.
목록에 없는 장비를 지정하려면 가방에서 아이템을 오른쪽 클릭한 후 추종자를 클릭하세요. (목록을 종종 업데이트하지만 가끔 블리자드가 더 빠릅니다)
이 방법은 오류를 발생하지 않습니다]=]
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[장비와 강화 아이템을 클릭할 수 있는 버튼 목록이 이곳에 나타납니다.
블리자드 코드 보호 체계때문에 아이템을 가방에서 끌어다 놓으면 오류가 발생합니다.
목록에 나타나지 않는 장비를 지정하려면 가방에 있는 아이템을 오른쪽 클릭한 후 추종자를 왼쪽 클릭하세요.(종종 목록을 업데이트하지만 가끔 블리자드가 더 빠릅니다)
이 방법으로는 오류가 발생하지 않습니다]=]
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[예를 들어, 성공 확률이 95%%, 130%% 그리고 180%%에 도달할 수 있는 임무가 있다고 가정해봅시다.
%1$s|1이;가; 170%%로 설정되어 있다면 180%%의 임무가 선택됩니다.
%1$s|1이;가; 200%%로 설정되어 있다면 OHC는 %2$s 설정에 의하여 100%%에 가장 근접한 임무를 찾습니다
%2$s|1이;가; 100%%로 설정되어 있다고 가정한다면 130%%의 임무가 선택되지만, %2$s|1이;가; 90%%로 설정되어 있다면 95%%의 임무가 선택됩니다]=]
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "사용 가능 한 임무를 항상 가장 많이 보고 싶다면 %1$s|1을;를; 100%%로 %2$s|1을;를; 0%%로 설정하세요"
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[OHC가 선택한 임무 구성을 이해할 수 없다면 전체 분석을 요청할 수 있습니다.
파티 분석은 모든 가능한 조합을 표시하고 OHC의 연산 방법을 보여줍니다]=]
L["Max champions"] = "최대 용사"
L["Maximize xp gain"] = "경험치 획득 최대화"
L["Never kill Troops"] = "병력 절대 죽이지 않기"
L["Prefer high durability"] = "높은 활력 선호"
L["Restart the tutorial"] = "설명서 재시작"
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = [=[칸(속해 있는 추종자가 아닌 그냥 칸)이 제외되었습니다.
제외된 칸은 그 임무에서 채워지지 않습니다.
병력은 항상 가장 왼쪽 칸에 있다는 사실을 이용하면 임무에 사용하는 추종자의 전체 숫자를 줄일 수 있습니다]=]
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "설명서를 종료합니다. 가장자리 메뉴에 있는 정보 아이콘을 클릭하면 언제든 다시 진행할 수 있습니다"
L["Thank you for reading this, enjoy %s"] = "읽어주셔서 감사합니다, 즐거운 %s 되세요"
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = [=[OrderHallCommander는 일반적으로 가능한 한 새로운 병력을 요청할 수 있도록 가장 낮은 활력의 병력을 사용합니다.
%1$s|1을;를; 선택하면 반대로 OrderHallCommander가 각 임무에 가장 높은 활력의 병력을 선택합니다]=]
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[OrderHallCommander의 새로운 배포 버전에 오신 걸 환영합니다
모든 새로운 기능에 대해 알아 보기 위해 간단한 설명서를 따라주세요.
후회하지 않을겁니다]=]
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = [=[%1$s|1을;를; 사용하면 병력을 죽이는 위협 요소를 항상 대응합니다.
OHC가 위협 요소를 대응하거나 활력이 하나 남은 병력만 사용하는 걸 의미합니다.
이 설정의 목표는 병력의 죽음을 피하는 게 아닌 활력의 낭비를 피하는 것입니다.]=]
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[%2$s|1을;를; 사용하면 병력이 죽지 않도록 보호합니다.
%1$s|1과;와; %3$s|1을;를; 의미하는 것만은 아니며, OHC가 임무를 보내면 죽게 될 병력은 절대 보내지 않도록 강제합니다.
이 설정의 목적은 이것때문에 파티를 채우지 못하더라도 완벽히 병력을 죽이지 않기 위함입니다.]=]
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = [=[임무 버튼을 오른쪽 클릭하여 임무를 차단할 수 있습니다.
1.5.1 버전부터 임무 버튼을 Shift-클릭하여 임무 페이지를 보지 않고 임무를 시작할 수 있습니다.
동의를 구하지 않기 때문에 파티가 올바른지 확인해주세요]=]
L["You can choose not to use a troop type clicking its icon"] = "해당 아이콘을 클릭하여 병력을 사용하지 않도록 선택할 수 있습니다"
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[몇 명의 용사를 함께 임무에 보낼 지 숫자를 선택할 수 있습니다.
OHC는 이제 같은 임무에 %3$s명을 초과하여 용사를 사용하지 않습니다-

%2$s|1이;가; 우선됩니다.]=]

return
end
L=l:NewLocale(me,"esMX")
if (L) then
--Translation missing 
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%% lower than %2$d%%. Lower %s"
--Translation missing 
L["%s for a wowhead link popup"] = "%s for a wowhead link popup"
--Translation missing 
L["%s start the mission without even opening the mission page. No question asked"] = "%s start the mission without even opening the mission page. No question asked"
--Translation missing 
L["%s starts missions"] = "%s starts missions"
--Translation missing 
L["%s to blacklist"] = "%s to blacklist"
--Translation missing 
L["%s to remove from blacklist"] = "%s to remove from blacklist"
--Translation missing 
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=]
--Translation missing 
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s, please review the tutorial\\n(Click the icon to dismiss this message)"
--Translation missing 
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "Allow to start a mission directly from the mission list page (no single mission page shown)"
L["Always counter increased resource cost"] = "Siempre contrarreste el mayor costo de recursos"
L["Always counter increased time"] = "Siempre contrarreste el tiempo incrementado"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Siempre contra las tropas de matar (ignorado si sólo podemos utilizar tropas con sólo 1 durabilidad a la izquierda)"
--Translation missing 
L["Always counter no bonus loot threat"] = "Always counter no bonus loot threat"
--Translation missing 
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Artifact shown value is the base value without considering knowledge multiplier"
--Translation missing 
L["Attempting %s"] = "Attempting %s"
--Translation missing 
L["Base Chance"] = "Base Chance"
L["Better parties available in next future"] = "Mejores fiestas disponibles en el próximo futuro"
--Translation missing 
L["Blacklisted"] = "Blacklisted"
--Translation missing 
L["Blacklisted missions are ignored in Mission Control"] = "Blacklisted missions are ignored in Mission Control"
--Translation missing 
L["Bonus Chance"] = "Bonus Chance"
L["Building Final report"] = "Informe final del edificio"
--Translation missing 
L["but using troops with just one durability left"] = "but using troops with just one durability left"
L["Capped %1$s. Spend at least %2$d of them"] = "% 1 $ s cubierto. Gasta al menos% 2 $ d de ellos"
L["Changes the sort order of missions in Mission panel"] = "Cambia el orden de las misiones en el panel de la Misión"
--Translation missing 
L["Combat ally is proposed for missions so you can consider unassigning him"] = "Combat ally is proposed for missions so you can consider unassigning him"
L["Complete all missions without confirmation"] = "Completa todas las misiones sin confirmación"
L["Configuration for mission party builder"] = "Configuración para el constructor de la misión"
--Translation missing 
L["Cost reduced"] = "Cost reduced"
--Translation missing 
L["Could not fulfill mission, aborting"] = "Could not fulfill mission, aborting"
--Translation missing 
L["Counter kill Troops"] = "Counter kill Troops"
--Translation missing 
L["Customization options (non mission related)"] = "Customization options (non mission related)"
--Translation missing 
L["Disables warning: "] = "Disables warning: "
--Translation missing 
L["Dont use this slot"] = "Dont use this slot"
--Translation missing 
L["Don't use troops"] = "Don't use troops"
L["Duration reduced"] = "Duración reducida"
L["Duration Time"] = "Duración"
--Translation missing 
L["Elites mission mode"] = "Elites mission mode"
--Translation missing 
L["Empty missions sorted as last"] = "Empty missions sorted as last"
--Translation missing 
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"
--Translation missing 
L["Equipped by following champions:"] = "Equipped by following champions:"
L["Expiration Time"] = "Tiempo de expiración"
L["Favours leveling follower for xp missions"] = "Favors nivelando seguidor para las misiones xp"
L["General"] = true
L["Global approx. xp reward"] = "Global aprox. Recompensa xp"
--Translation missing 
L["Global approx. xp reward per hour"] = "Global approx. xp reward per hour"
L["HallComander Quick Mission Completion"] = "Conclusión de la misión rápida de HallComander"
--Translation missing 
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."
--Translation missing 
L["If not checked, inactive followers are used as last chance"] = "If not checked, inactive followers are used as last chance"
--Translation missing 
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[If you %s, you will lose them
Click on %s to abort]=]
--Translation missing 
L["Ignore busy followers"] = "Ignore busy followers"
--Translation missing 
L["Ignore inactive followers"] = "Ignore inactive followers"
L["Keep cost low"] = "Mantenga el costo bajo"
--Translation missing 
L["Keep extra bonus"] = "Keep extra bonus"
L["Keep time short"] = "Mantenga el tiempo corto"
L["Keep time VERY short"] = "Mantener el tiempo muy corto"
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=]
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=]
L["Level"] = "Nivel"
--Translation missing 
L["Lock all"] = "Lock all"
--Translation missing 
L["Lock this follower"] = "Lock this follower"
--Translation missing 
L["Locked follower are only used in this mission"] = "Locked follower are only used in this mission"
L["Make Order Hall Mission Panel movable"] = "Hacer pedido Hall Misión Panel móvil"
--Translation missing 
L["Makes sure that no troops will be killed"] = "Makes sure that no troops will be killed"
--Translation missing 
L["Max champions"] = "Max champions"
L["Maximize xp gain"] = "Maximizar la ganancia de xp"
--Translation missing 
L["Mission duration reduced"] = "Mission duration reduced"
--Translation missing 
L["Mission was capped due to total chance less than"] = "Mission was capped due to total chance less than"
L["Missions"] = "Misiones"
--Translation missing 
L["Never kill Troops"] = "Never kill Troops"
L["No follower gained xp"] = "Ningún seguidor ganó xp"
--Translation missing 
L["No suitable missions. Have you reserved at least one follower?"] = "No suitable missions. Have you reserved at least one follower?"
--Translation missing 
L["Not blacklisted"] = "Not blacklisted"
L["Nothing to report"] = "Nada que reportar"
L["Notifies you when you have troops ready to be collected"] = "Notifica cuando hay tropas listas para ser recolectadas"
L["Only accept missions with time improved"] = "Sólo aceptar misiones mejoradas con el tiempo"
--Translation missing 
L["Only consider elite missions"] = "Only consider elite missions"
--Translation missing 
L["Only use champions even if troops are available"] = "Only use champions even if troops are available"
--Translation missing 
L["Open configuration"] = "Open configuration"
--Translation missing 
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=]
L["Original method"] = "Método original"
L["Position is not saved on logout"] = "La posición no se guarda al cerrar la sesión"
--Translation missing 
L["Prefer high durability"] = "Prefer high durability"
--Translation missing 
L["Quick start first mission"] = "Quick start first mission"
--Translation missing 
L["Remove no champions warning"] = "Remove no champions warning"
--Translation missing 
L["Restart tutorial from beginning"] = "Restart tutorial from beginning"
--Translation missing 
L["Resume tutorial"] = "Resume tutorial"
L["Resurrect troops effect"] = "Efecto de las tropas de resurrección"
L["Reward type"] = "Tipo de recompensa"
--Translation missing 
L["Sets all switches to a very permissive setup"] = "Sets all switches to a very permissive setup"
--Translation missing 
L["Show tutorial"] = "Show tutorial"
L["Show/hide OrderHallCommander mission menu"] = "Mostrar / ocultar el menú de la misión OrderHallCommander"
L["Sort missions by:"] = "Ordenar misiones por:"
--Translation missing 
L["Started with "] = "Started with "
L["Success Chance"] = "Éxito"
L["Troop ready alert"] = "Alerta lista de tropas"
--Translation missing 
L["Unable to fill missions, raise \"%s\""] = "Unable to fill missions, raise \"%s\""
--Translation missing 
L["Unable to fill missions. Check your switches"] = "Unable to fill missions. Check your switches"
--Translation missing 
L["Unable to start mission, aborting"] = "Unable to start mission, aborting"
--Translation missing 
L["Unlock all"] = "Unlock all"
--Translation missing 
L["Unlock this follower"] = "Unlock this follower"
--Translation missing 
L["Unlocks all follower and slots at once"] = "Unlocks all follower and slots at once"
L["Upgrading to |cff00ff00%d|r"] = "Actualizando a | cff00ff00% d | r"
--Translation missing 
L["URL Copy"] = "URL Copy"
--Translation missing 
L["Use at most this many champions"] = "Use at most this many champions"
--Translation missing 
L["Use combat ally"] = "Use combat ally"
--Translation missing 
L["Use this slot"] = "Use this slot"
--Translation missing 
L["Uses troops with the highest durability instead of the ones with the lowest"] = "Uses troops with the highest durability instead of the ones with the lowest"
--Translation missing 
L["When no free followers are available shows empty follower"] = "When no free followers are available shows empty follower"
--Translation missing 
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"
--Translation missing 
L["Would start with "] = "Would start with "
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Está perdiendo | cffff0000% d | cffffd200 punto (s)!"
--Translation missing 
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=]
--Translation missing 
L["You now need to press both %s and %s to start mission"] = "You now need to press both %s and %s to start mission"

-- Tutorial
--Translation missing 
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=]
--Translation missing 
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[A requested window is not open
Tutorial will resume as soon as possible]=]
--Translation missing 
L["Base Chance"] = "Base Chance"
--Translation missing 
L["Bonus Chance"] = "Bonus Chance"
--Translation missing 
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=]
--Translation missing 
L["Counter Kill Troops"] = "Counter Kill Troops"
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=]
--Translation missing 
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"
--Translation missing 
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=]
--Translation missing 
L["Max champions"] = "Max champions"
--Translation missing 
L["Maximize xp gain"] = "Maximize xp gain"
--Translation missing 
L["Never kill Troops"] = "Never kill Troops"
--Translation missing 
L["Prefer high durability"] = "Prefer high durability"
--Translation missing 
L["Restart the tutorial"] = "Restart the tutorial"
--Translation missing 
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=]
--Translation missing 
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"
--Translation missing 
L["Thank you for reading this, enjoy %s"] = "Thank you for reading this, enjoy %s"
--Translation missing 
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=]
--Translation missing 
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=]
--Translation missing 
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=]
--Translation missing 
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=]
--Translation missing 
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=]
--Translation missing 
L["You can choose not to use a troop type clicking its icon"] = "You can choose not to use a troop type clicking its icon"
--Translation missing 
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=]

return
end
L=l:NewLocale(me,"ruRU")
if (L) then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%% ниже чем %2$d%%. Ниже %s"
L["%s for a wowhead link popup"] = "%s для всплывающей ссылки на wowhead"
L["%s start the mission without even opening the mission page. No question asked"] = "%s начинает выполнение задания без открытия экрана задания и без дополнительных вопросов"
L["%s starts missions"] = "%s начинает задание"
L["%s to blacklist"] = "%s для добавления в чёрный список"
L["%s to remove from blacklist"] = "%s для удаления из чёрного списка"
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s, пожалуйста обратитесь к инструкции
(Нажмите на иконку, чтобы убрать это сообщение и начать обучение)]=]
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s, пожалуйста пересмотрите инструкции\\nНажмите на иконку, чтобы убрать это сообщение"
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "Разрешить начинать задание прямо со страницы списка заданий (без показа страницы задания)"
L["Always counter increased resource cost"] = "Учитывать увеличение стоимости ресурсов"
L["Always counter increased time"] = "Учитывать увеличение времени на задание"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Учитывать смерть войск. Игнорируется, если остались войска только с 1 единицей здоровья"
L["Always counter no bonus loot threat"] = "Игнорировать задания, если нет шанса на дополнительную добычу"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Показывать базовое значение силы артефакта без учета множителя знания"
L["Attempting %s"] = "Пытаемся %s"
L["Base Chance"] = "Базовый шанс"
L["Better parties available in next future"] = "Лучшая группа будет доступна скоро"
L["Blacklisted"] = "Блокированные"
L["Blacklisted missions are ignored in Mission Control"] = "Задания из чёрного списка игнорируются при управлении заданиями"
L["Bonus Chance"] = "Бонусный шанс"
L["Building Final report"] = "Создать отчет по завершении задания"
L["but using troops with just one durability left"] = "но использовать войска с 1 единицей здоровья"
L["Capped %1$s. Spend at least %2$d of them"] = "Достигнуто %1$. Потратьте по крайней мере 2%$"
L["Changes the sort order of missions in Mission panel"] = "Меняет порядок сортировки на панели заданий"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "Использовать боевого спутника в расчетах. Перед отправкой отпустите его"
L["Complete all missions without confirmation"] = "Завершить все задания без подтверждений"
L["Configuration for mission party builder"] = "Настройки для сбора группы для задания"
L["Cost reduced"] = "Стоимость уменьшена"
L["Could not fulfill mission, aborting"] = "Не удалось выполнить задание, прерывание"
L["Counter kill Troops"] = "Предупредить смерть войск"
--Translation missing 
L["Customization options (non mission related)"] = "Customization options (non mission related)"
L["Disables warning: "] = "Отключить предупреждение: "
L["Dont use this slot"] = "Не использовать этот слот"
L["Don't use troops"] = "Не использовать войска"
L["Duration reduced"] = "Продолжительность уменьшена"
L["Duration Time"] = "Продолжительность"
L["Elites mission mode"] = "Режим элитных заданий"
L["Empty missions sorted as last"] = "Задания без групп сортируются как последние"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "Задания без группы и провальные (0 % успеха) задания отображаются последними при сортировке. Не относится к \"обычному\" методу"
L["Equipped by following champions:"] = "Одето на следующих защитников:"
L["Expiration Time"] = "Время окончания активности"
L["Favours leveling follower for xp missions"] = "Предпочесть набор уровня защитником в заданиях на опыт"
L["General"] = "Основные"
L["Global approx. xp reward"] = "Общая оценка возможного к получению опыта"
L["Global approx. xp reward per hour"] = "Общая оценка возможного к получению опыта в час"
L["HallComander Quick Mission Completion"] = "Hall Comander Быстрое завершение миссий"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "Если %1$s меньше этого значения, то мы попробуем получить хотя бы %2$s не превосходя 100%%. Игнорируется для элитных заданий"
L["If not checked, inactive followers are used as last chance"] = "Если этот флажок не установлен, то неактивные защитники используются в последнюю очередь"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[Если Ваш %s слишком мал, вы можете потерять их
Щелкните %s для прерывания]=]
L["Ignore busy followers"] = "Игнорировать занятых защитников"
L["Ignore inactive followers"] = "Игнорировать неактивных защитников"
L["Keep cost low"] = "Дешёвые задания"
L["Keep extra bonus"] = "Дополнительная добыча"
L["Keep time short"] = "Короткие задания"
L["Keep time VERY short"] = "Уменьшать время задания"
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = "Запустить первую заполненную группу выполнять задание с по крайней мере одним заблокированным защитником. Держите кнопку %s нажатой для начала выполнения (простое нажатие мышки выведет только имя задания со списком защитников)"
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = "Запустить первую заполненную группу выполнять задание с по крайней мере одним заблокированным защитником. Держите кнопку Shift нажатой для начала выполнения (простое нажатие мышки выведет только имя задания со списком защитников)"
L["Level"] = "Уровень"
L["Lock all"] = "Заблокировать всех"
L["Lock this follower"] = "Заблокировать этого защитника"
L["Locked follower are only used in this mission"] = "Заблокированный защитник используется только в этом задании"
L["Make Order Hall Mission Panel movable"] = "Сделать панель заданий оплота класса перемещаемой"
L["Makes sure that no troops will be killed"] = "Гарантирует, что никакие войска не будут убиты"
L["Max champions"] = "Максимально защитников"
L["Maximize xp gain"] = "Максимизировать получаемый опыт"
L["Mission duration reduced"] = "Сокращена продолжительность задания"
L["Mission was capped due to total chance less than"] = "Миссия была ограничена из-за общего шанса меньше чем"
L["Missions"] = "Задания"
L["Never kill Troops"] = "Никогда не убивать войска"
L["No follower gained xp"] = "Защитники не получили опыт"
L["No suitable missions. Have you reserved at least one follower?"] = "Нет подходящих миссий. Вы зарезервировали хотя бы одного защитника?"
L["Not blacklisted"] = "Не в чёрном списке"
L["Nothing to report"] = "Без отчёта"
L["Notifies you when you have troops ready to be collected"] = "Уведомлять Вас, когда имеются готовые к сбору войска"
L["Only accept missions with time improved"] = "Принимать только задания с улучшенным временем"
L["Only consider elite missions"] = "Учитывать только элитные задания"
L["Only use champions even if troops are available"] = "Использовать только защитников, даже если войска доступны"
L["Open configuration"] = "Открыть настройки"
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[Order Hall Commander переопределяет Garrison Commander для управления заказами.
 Вы можете вернуться к Garrison Commander, просто отключив Orderhall Commander.
Если вам нравится Order Hall Commander, не забудьте добавить его в клиент Twitch и обновить его]=]
L["Original method"] = "Обычный метод"
L["Position is not saved on logout"] = "Положение не сохраняется при выходе"
L["Prefer high durability"] = "Предпочесть войска с большим количеством единиц здоровья"
L["Quick start first mission"] = "Быстрое начало первого задания"
L["Remove no champions warning"] = "Отключить предупреждение об отсутствии защитников"
L["Restart tutorial from beginning"] = "Перезапустить инструкции с начала"
L["Resume tutorial"] = "Возобновить инструкции"
L["Resurrect troops effect"] = "Эффект воскрешения войск"
L["Reward type"] = "Награда"
L["Sets all switches to a very permissive setup"] = "Установить все переключатели так, чтобы предоставить большую возможность манёвра"
L["Show tutorial"] = "Показать сборник инструкций"
L["Show/hide OrderHallCommander mission menu"] = "Отобразить/скрыть меню заданий Order Hall Commander"
L["Sort missions by:"] = "Сортировать задания по:"
L["Started with "] = "Начали с"
L["Success Chance"] = "Шанс успеха"
L["Troop ready alert"] = "Оповещение о готовности войск"
L["Unable to fill missions, raise \"%s\""] = "Не удается заполнить группы заданий. Повысьте %s"
L["Unable to fill missions. Check your switches"] = "Не удается заполнить задания. Проверьте параметры"
L["Unable to start mission, aborting"] = "Невозможно начать задание, отменяем"
L["Unlock all"] = "Разблокировать всех"
L["Unlock this follower"] = "Разблокировать этого защитника"
L["Unlocks all follower and slots at once"] = "Разблокировать сразу всех защитников и слоты"
L["Upgrading to |cff00ff00%d|r"] = "Обновление до |cff00ff00%d|r"
L["URL Copy"] = "Копировать ссылку"
L["Use at most this many champions"] = "Насколько много использовать защитников"
L["Use combat ally"] = "Боевой спутник"
L["Use this slot"] = "Использовать этот слот"
L["Uses troops with the highest durability instead of the ones with the lowest"] = "Использует войска с максимальным количеством единиц здоровья вместо войск с минимальным количеством единиц здоровья."
L["When no free followers are available shows empty follower"] = "Если свободные защитники недоступны,то отображается пустое место"
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "Если мы не в состоянии достичь запрошенный %1$s, то мы попробуем по крайней мере получить больше 100%% (если возможно)"
L["Would start with "] = "Начнём с того, что"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Вы теряете |cffff0000%d|cffffd200 очков !!!"
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[Вам необходимо закрыть и перезапустить World of Warcraft, чтобы обновить эту версию Order Hall Commander.
Достаточно перезапустить графический интерфейс]=]
L["You now need to press both %s and %s to start mission"] = "Необходимо нажать %s и %s для запуска задания"

-- Tutorial
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = "Переключатели %1$s и %2$s действуют вместе, чтобы настроить, как Вы хотите отфильтровать Ваши задания. Значение, установленное вами для %1$s (сейчас равно %3$s%%), является минимальным приемлемым шансом при получении бонуса, в то время как значение, установленное для %2$s (сейчас равно %4$s%%), является шансом, который Вы хотите получить, когда вы теряете бонус (по причине недостаточного количества сильных защитников)."
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[Запрошенное окно не открыто.
Инструкции продолжатся так скоро как только возможно.]=]
L["Base Chance"] = "Базовый шанс."
L["Bonus Chance"] = "Бонусный шанс."
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[Нажатие кнопки задания сопоставит указанных защитников текущему заданию.
Используйте это, чтобы проверить соответствие рассчитанных Order Hall Commander шансов реальным значениям с помощью Blizzard.
Если данные значения отличаются, прошу открыть билет приложив снимок экрана.]=]
L["Counter Kill Troops"] = "Предупредить смерть войск."
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Обмундирование и обновления перечислены здесь в виде кнопок. В связи с проблемой с системой Blizzard Taint, перетаскивание и использование из сумок вызывает ошибку.
Если Вы перетаскиваете и используете предмет из сумки, который не отображён (мы обновляем список достаточно часто, но иногда Blizzard быстрее), Вы можете нажать правую кнопку мышки на вещи в сумке и нажать левую кнопку мышки на защитнике.
Таким образом вы ошибка не произойдёт.]=]
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Экипировка и снаряжение перечислены здесь в виде кнопок, которые могут быть нажаты.
Из-за проблем с системой Blizzard Taint при перетаскивании предмета из сумки появляется сообщение об ошибке.
Для того, чтобы назначить экипировку, которого нет в списке (я часто обновляю список, но иногда Blizzard быстрее), можно щелкнуть правой кнопкой на предмет в сумке, далее левой кнопкой на защитника.
Таким образом, Вы не получите никаких ошибок]=]
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[Для примера, миссия может достигать до 95%%, 130%% и 180%% вероятности успеха.
Если %1$s имеет значение 170%%, до 180%% одно из этих будет выбрано.
Если %1$s имеет значение 200%% Order Hall Commander попытается найти ближайшую к 100%% соблюдая настройку %2$s
Если, например %2$s имеет значение 100%% или 130%% одно из этих будет выбрано, но если %2$s имеет значение 90%% или 95%% одно из этих будет выбрано.]=]
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "Если Вы всегда хотите видеть только наиболее доступные для выполнения задания, установите %1$s в 100%% и %2$s в 0%%."
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[Если Вы не понимаете, почему Order Hall Commander выбрал такую группу для задания, то Вы можете запросить полный анализ.
Анализ группы покажет все возможные комбинации и как Order Hall Commander подобрал их.]=]
L["Max champions"] = "Максимально защитников."
L["Maximize xp gain"] = "Максимизировать получаемый опыт."
L["Never kill Troops"] = "Никогда не убивать войска."
L["Prefer high durability"] = "Предпочесть войска с большим количеством единиц здоровья."
L["Restart the tutorial"] = "Перезапустить сборник инструкций."
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = "Слот (не защитник в нём, а именно слот) может быть заблокирован. Когда Вы блокируете слот, он не будет заполнен для этого задания. Используя тот факт, что войска всегда находятся в самом левом слоте (слотах), вы можете добиться хорошей степени индивидуального настройки, уменьшая общее количество защитников, используемых для задания."
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "Закрыть инструкцию. Вы можете продолжить в любое время нажав на иконку информации в боковом меню."
L["Thank you for reading this, enjoy %s"] = "Спасибо за прочтение. Наслаждайтесь %s."
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = "Обычно Order Hall Commander пытается использовать войска с наименьшим количеством единиц здоровья, чтобы вы могли как можно скорее ввести в бой новые войска. Проверка %1$s отменяет это и Order Hall Commander выберет для каждого задания войска с наибольшим количеством единиц здоровья."
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[Добро пожаловать в новый выпуск Order Hall Commander
Следуйте этому краткой инструкции, чтобы узнать все новые функции.
Вы не пожалеете об этом]=]
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = "Используя %1$s, Вы можете попросить всегда учитывать опасность смерти войск. Это означает, что Order Hall Commander будет пытаться учитывать её или использовать войска с оставшейся только 1 единицей здоровья. Целью этого переключателя является предупреждение потери жизненных сил, но не предупреждения смертей войск."
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = "Используя %2$s, Вы можете попросить никогда не позволять умирать войскам. Это не только применяется к %1$s и %3$s, но заставляет Order Hall Commander никогда не отправлять на задание войска, которые могут погибнуть. Целью этого переключателя является предупреждение смертей войск, даже путём невозможности сбора группы для задания."
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = "Вы можете занести в чёрный список задания нажав правую кнопку мыши. Начиная с 1.5.1 Вы можете начать задание сразу, не заходя на экран заданий, зажав кнопку Shift и выбрав задание мышкой. Убедитесь, что предлагаемая группа вас устраивает, так как задание начнётся без подтверждения."
L["You can choose not to use a troop type clicking its icon"] = "Вы можете отменить использование войск нажатием на эту иконку."
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = "Вы можете ограничить количество используемых одновременно в задании защитников. Сейчас Order Hall Commander использует не более %3$s защитников в одном задании. Обратите внимание, что %2$s имеет больший приоритет."

return
end
L=l:NewLocale(me,"zhCN")
if (L) then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%%低于%2$d%%，降低%s"
--Translation missing 
L["%s for a wowhead link popup"] = "%s for a wowhead link popup"
L["%s start the mission without even opening the mission page. No question asked"] = "Shift-点击可以不打开任务页面就启动任务。没有问题"
--Translation missing 
L["%s starts missions"] = "%s starts missions"
L["%s to blacklist"] = "点击右键加入黑名单"
L["%s to remove from blacklist"] = "点击右键从黑名单中删除"
--Translation missing 
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=]
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s，请检查教程\\n（单击图标取消此消息）"
--Translation missing 
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "Allow to start a mission directly from the mission list page (no single mission page shown)"
L["Always counter increased resource cost"] = "总是反制增加资源花费"
L["Always counter increased time"] = "总是反制增加任务时间"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "总是反制杀死部队(如果我们用只剩一次耐久的部队则忽略)"
L["Always counter no bonus loot threat"] = "总是反制没有额外奖励的威胁"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "神器显示的值是基础值，没有经过神器知识的加成"
L["Attempting %s"] = "尝试%s"
L["Base Chance"] = "基础机率"
L["Better parties available in next future"] = "在将来有更好的队伍"
L["Blacklisted"] = "加入黑名单"
L["Blacklisted missions are ignored in Mission Control"] = "加入黑名单的任务将会在任务面板被忽略"
L["Bonus Chance"] = "额外奖励机率"
L["Building Final report"] = "构建最终报告"
L["but using troops with just one durability left"] = "使用只有一个生命值的部队"
L["Capped %1$s. Spend at least %2$d of them"] = "%1$s封顶了。花费至少%2$d在它身上"
L["Changes the sort order of missions in Mission panel"] = "改变任务面板上的任务排列顺序"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "战斗盟友被建议到任务，所以你可以考虑取消指派他"
L["Complete all missions without confirmation"] = "完成所有任务不须确认"
L["Configuration for mission party builder"] = "任务队伍构建设置"
L["Cost reduced"] = "已降低花费"
L["Could not fulfill mission, aborting"] = "任务无法执行被忽略"
L["Counter kill Troops"] = "反制危害（致命）防止部队阵亡"
--Translation missing 
L["Customization options (non mission related)"] = "Customization options (non mission related)"
L["Disables warning: "] = "停用警告："
L["Dont use this slot"] = "不要使用这个空位"
L["Don't use troops"] = "不要使用部队"
L["Duration reduced"] = "持续时间已缩短"
L["Duration Time"] = "持续时间"
L["Elites mission mode"] = "精英任务模式"
L["Empty missions sorted as last"] = "空的任务排在最后"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "空或者0%成功率的任务排在最后，对于\\\"原始\\\"方式排序无效。"
--Translation missing 
L["Equipped by following champions:"] = "Equipped by following champions:"
L["Expiration Time"] = "到期时间"
L["Favours leveling follower for xp missions"] = "倾向于使用升级中追隨者在经验值任务"
L["General"] = "一般"
L["Global approx. xp reward"] = "整体大约经验值奖励"
L["Global approx. xp reward per hour"] = "每小时获得的整体经验值奖励"
L["HallComander Quick Mission Completion"] = "大厅指挥官快速任务完成"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "如果 %1$s 低于此值，那么我们至少尝试达到 %2$s 而不超过100%%。 忽略精英任务。"
L["If not checked, inactive followers are used as last chance"] = "不勾选时，未激活的追随者会成为最后的考虑"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[如果你继续，你会失去它们
点击%s來取消]=]
L["Ignore busy followers"] = "忽略任务中的追随者"
L["Ignore inactive followers"] = "忽略未激活的追随者"
L["Keep cost low"] = "节省大厅资源"
L["Keep extra bonus"] = "优先额外奖励"
L["Keep time short"] = "减少任务时间"
L["Keep time VERY short"] = "最短任务时间"
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=]
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=]
L["Level"] = "等级"
L["Lock all"] = "全部锁定"
L["Lock this follower"] = "锁定此追随者"
L["Locked follower are only used in this mission"] = "锁定只用于此任务的追随者"
L["Make Order Hall Mission Panel movable"] = "让大厅任务面板可移动"
L["Makes sure that no troops will be killed"] = "确保没有部队会阵亡"
L["Max champions"] = "最多的勇士数量"
L["Maximize xp gain"] = "获取最多的经验"
L["Mission duration reduced"] = "任务执行时间已缩短"
L["Mission was capped due to total chance less than"] = "任务限制由于总的几率少于"
L["Missions"] = "任务"
L["Never kill Troops"] = "确保部队绝不阵亡"
L["No follower gained xp"] = "没有追随者获得经验"
L["No suitable missions. Have you reserved at least one follower?"] = "没有合适的任务。 您是否至少保留了一位追随者？"
L["Not blacklisted"] = "未加入黑名单"
L["Nothing to report"] = "没什么可报告"
L["Notifies you when you have troops ready to be collected"] = "当部队已准备好获取时提醒你"
L["Only accept missions with time improved"] = "只允许有时间改善的任务"
L["Only consider elite missions"] = "只考虑精英任务"
L["Only use champions even if troops are available"] = "有可用的部队时，仍然只使用追随者"
L["Open configuration"] = "打开配置"
--Translation missing 
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=]
L["Original method"] = "原始方法"
L["Position is not saved on logout"] = "位置不会在登出后储存"
L["Prefer high durability"] = "喜欢高生命值"
L["Quick start first mission"] = "快速开始第一个任务"
L["Remove no champions warning"] = "取消没有追随者警告"
--Translation missing 
L["Restart tutorial from beginning"] = "Restart tutorial from beginning"
--Translation missing 
L["Resume tutorial"] = "Resume tutorial"
L["Resurrect troops effect"] = "复活部队效果"
L["Reward type"] = "奖励类型"
--Translation missing 
L["Sets all switches to a very permissive setup"] = "Sets all switches to a very permissive setup"
L["Show tutorial"] = "显示教程"
L["Show/hide OrderHallCommander mission menu"] = "显示/隐藏大厅指挥官任务选单"
L["Sort missions by:"] = "排列任务根据："
L["Started with "] = "开始"
L["Success Chance"] = "成功机率"
L["Troop ready alert"] = "部队装备提醒"
L["Unable to fill missions, raise \"%s\""] = "无法指派任务，请提升 \\\"%s\\"
L["Unable to fill missions. Check your switches"] = "无法指派任务，请检查您的设定选项"
L["Unable to start mission, aborting"] = "无法开始任务，中止"
L["Unlock all"] = "全部解除锁定"
L["Unlock this follower"] = "解锁此追随者"
L["Unlocks all follower and slots at once"] = "一次性解锁所有追随者和空位"
L["Upgrading to |cff00ff00%d|r"] = "升级到|cff00ff00%d|r"
L["URL Copy"] = "复制网址"
L["Use at most this many champions"] = "最多使用不超过这个数量的勇士"
L["Use combat ally"] = "使用战斗盟友"
L["Use this slot"] = "使用这个空位"
L["Uses troops with the highest durability instead of the ones with the lowest"] = "使用最高生命值的部队，而不是最低的部队"
--Translation missing 
L["When no free followers are available shows empty follower"] = "When no free followers are available shows empty follower"
--Translation missing 
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"
L["Would start with "] = "将开始"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "你浪费了|cffff0000%d|cffffd200 点数!!!"
--Translation missing 
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=]
--Translation missing 
L["You now need to press both %s and %s to start mission"] = "You now need to press both %s and %s to start mission"

-- Tutorial
--Translation missing 
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=]
--Translation missing 
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[A requested window is not open
Tutorial will resume as soon as possible]=]
L["Base Chance"] = "基础机率"
L["Bonus Chance"] = "额外奖励机率"
--Translation missing 
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=]
L["Counter Kill Troops"] = "反制危害（致命）防止部队阵亡"
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=]
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "相反，如果你只想总是看到最好的可用任务，只需要设置%1$s到100%，%2$s到0%。"
--Translation missing 
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=]
L["Max champions"] = "最多的勇士数量"
L["Maximize xp gain"] = "获取最多的经验"
L["Never kill Troops"] = "确保部队绝不阵亡"
L["Prefer high durability"] = "喜欢高生命值"
L["Restart the tutorial"] = "重新启动教程"
--Translation missing 
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=]
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "终止教程。您可以随时点击侧边菜单的信息图标恢复它"
--Translation missing 
L["Thank you for reading this, enjoy %s"] = "Thank you for reading this, enjoy %s"
--Translation missing 
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=]
--Translation missing 
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=]
--Translation missing 
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=]
--Translation missing 
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=]
--Translation missing 
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=]
--Translation missing 
L["You can choose not to use a troop type clicking its icon"] = "You can choose not to use a troop type clicking its icon"
--Translation missing 
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=]

return
end
L=l:NewLocale(me,"esES")
if (L) then
--Translation missing 
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%% lower than %2$d%%. Lower %s"
--Translation missing 
L["%s for a wowhead link popup"] = "%s for a wowhead link popup"
--Translation missing 
L["%s start the mission without even opening the mission page. No question asked"] = "%s start the mission without even opening the mission page. No question asked"
--Translation missing 
L["%s starts missions"] = "%s starts missions"
--Translation missing 
L["%s to blacklist"] = "%s to blacklist"
--Translation missing 
L["%s to remove from blacklist"] = "%s to remove from blacklist"
--Translation missing 
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=]
--Translation missing 
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "%s, please review the tutorial\\n(Click the icon to dismiss this message)"
--Translation missing 
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "Allow to start a mission directly from the mission list page (no single mission page shown)"
L["Always counter increased resource cost"] = "Siempre contrarreste el mayor costo de recursos"
L["Always counter increased time"] = "Siempre contrarreste el tiempo incrementado"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "Siempre contrarrestar la muerte de tropas (ignorado si sólo podemos utilizar tropas con un solo punto de durabilidad)"
L["Always counter no bonus loot threat"] = "Siempre contrarresta la falta de bonificación de botín"
--Translation missing 
L["Artifact shown value is the base value without considering knowledge multiplier"] = "Artifact shown value is the base value without considering knowledge multiplier"
--Translation missing 
L["Attempting %s"] = "Attempting %s"
--Translation missing 
L["Base Chance"] = "Base Chance"
L["Better parties available in next future"] = "Mejores fiestas disponibles en el próximo futuro"
--Translation missing 
L["Blacklisted"] = "Blacklisted"
--Translation missing 
L["Blacklisted missions are ignored in Mission Control"] = "Blacklisted missions are ignored in Mission Control"
--Translation missing 
L["Bonus Chance"] = "Bonus Chance"
L["Building Final report"] = "Informe final del edificio"
--Translation missing 
L["but using troops with just one durability left"] = "but using troops with just one durability left"
L["Capped %1$s. Spend at least %2$d of them"] = "% 1 $ s cubierto. Gasta al menos% 2 $ d de ellos"
L["Changes the sort order of missions in Mission panel"] = "Cambia el orden de las misiones en el panel de la Misión"
--Translation missing 
L["Combat ally is proposed for missions so you can consider unassigning him"] = "Combat ally is proposed for missions so you can consider unassigning him"
L["Complete all missions without confirmation"] = "Completa todas las misiones sin confirmación"
L["Configuration for mission party builder"] = "Configuración para el constructor de la misión"
--Translation missing 
L["Cost reduced"] = "Cost reduced"
--Translation missing 
L["Could not fulfill mission, aborting"] = "Could not fulfill mission, aborting"
--Translation missing 
L["Counter kill Troops"] = "Counter kill Troops"
--Translation missing 
L["Customization options (non mission related)"] = "Customization options (non mission related)"
--Translation missing 
L["Disables warning: "] = "Disables warning: "
--Translation missing 
L["Dont use this slot"] = "Dont use this slot"
--Translation missing 
L["Don't use troops"] = "Don't use troops"
L["Duration reduced"] = "Duración reducida"
L["Duration Time"] = "Duración"
--Translation missing 
L["Elites mission mode"] = "Elites mission mode"
--Translation missing 
L["Empty missions sorted as last"] = "Empty missions sorted as last"
--Translation missing 
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"
--Translation missing 
L["Equipped by following champions:"] = "Equipped by following champions:"
L["Expiration Time"] = "Tiempo de expiración"
L["Favours leveling follower for xp missions"] = "Favors nivelando seguidor para las misiones xp"
L["General"] = true
L["Global approx. xp reward"] = "Global aprox. Recompensa xp"
--Translation missing 
L["Global approx. xp reward per hour"] = "Global approx. xp reward per hour"
L["HallComander Quick Mission Completion"] = "Conclusión de la misión rápida de HallComander"
--Translation missing 
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."
--Translation missing 
L["If not checked, inactive followers are used as last chance"] = "If not checked, inactive followers are used as last chance"
--Translation missing 
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[If you %s, you will lose them
Click on %s to abort]=]
--Translation missing 
L["Ignore busy followers"] = "Ignore busy followers"
--Translation missing 
L["Ignore inactive followers"] = "Ignore inactive followers"
L["Keep cost low"] = "Mantenga el costo bajo"
L["Keep extra bonus"] = "Mantener bonificación extra"
L["Keep time short"] = "Mantenga el tiempo corto"
L["Keep time VERY short"] = "Mantener el tiempo muy corto"
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=]
--Translation missing 
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=]
L["Level"] = "Nivel"
--Translation missing 
L["Lock all"] = "Lock all"
--Translation missing 
L["Lock this follower"] = "Lock this follower"
--Translation missing 
L["Locked follower are only used in this mission"] = "Locked follower are only used in this mission"
L["Make Order Hall Mission Panel movable"] = "Hacer pedido Hall Misión Panel móvil"
--Translation missing 
L["Makes sure that no troops will be killed"] = "Makes sure that no troops will be killed"
--Translation missing 
L["Max champions"] = "Max champions"
L["Maximize xp gain"] = "Maximizar la ganancia de xp"
--Translation missing 
L["Mission duration reduced"] = "Mission duration reduced"
--Translation missing 
L["Mission was capped due to total chance less than"] = "Mission was capped due to total chance less than"
L["Missions"] = "Misiones"
--Translation missing 
L["Never kill Troops"] = "Never kill Troops"
L["No follower gained xp"] = "Ningún seguidor ganó xp"
--Translation missing 
L["No suitable missions. Have you reserved at least one follower?"] = "No suitable missions. Have you reserved at least one follower?"
--Translation missing 
L["Not blacklisted"] = "Not blacklisted"
L["Nothing to report"] = "Nada que reportar"
L["Notifies you when you have troops ready to be collected"] = "Notifica cuando hay tropas listas para ser recolectadas"
L["Only accept missions with time improved"] = "Sólo aceptar misiones mejoradas con el tiempo"
--Translation missing 
L["Only consider elite missions"] = "Only consider elite missions"
--Translation missing 
L["Only use champions even if troops are available"] = "Only use champions even if troops are available"
--Translation missing 
L["Open configuration"] = "Open configuration"
--Translation missing 
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=]
L["Original method"] = "Método original"
L["Position is not saved on logout"] = "La posición no se guarda al cerrar la sesión"
--Translation missing 
L["Prefer high durability"] = "Prefer high durability"
--Translation missing 
L["Quick start first mission"] = "Quick start first mission"
--Translation missing 
L["Remove no champions warning"] = "Remove no champions warning"
--Translation missing 
L["Restart tutorial from beginning"] = "Restart tutorial from beginning"
--Translation missing 
L["Resume tutorial"] = "Resume tutorial"
L["Resurrect troops effect"] = "Efecto de las tropas de resurrección"
L["Reward type"] = "Tipo de recompensa"
--Translation missing 
L["Sets all switches to a very permissive setup"] = "Sets all switches to a very permissive setup"
--Translation missing 
L["Show tutorial"] = "Show tutorial"
L["Show/hide OrderHallCommander mission menu"] = "Mostrar / ocultar el menú de la misión OrderHallCommander"
L["Sort missions by:"] = "Ordenar misiones por:"
--Translation missing 
L["Started with "] = "Started with "
L["Success Chance"] = "Éxito"
L["Troop ready alert"] = "Alerta lista de tropas"
--Translation missing 
L["Unable to fill missions, raise \"%s\""] = "Unable to fill missions, raise \"%s\""
--Translation missing 
L["Unable to fill missions. Check your switches"] = "Unable to fill missions. Check your switches"
--Translation missing 
L["Unable to start mission, aborting"] = "Unable to start mission, aborting"
--Translation missing 
L["Unlock all"] = "Unlock all"
--Translation missing 
L["Unlock this follower"] = "Unlock this follower"
--Translation missing 
L["Unlocks all follower and slots at once"] = "Unlocks all follower and slots at once"
L["Upgrading to |cff00ff00%d|r"] = "Actualizando a | cff00ff00% d | r"
--Translation missing 
L["URL Copy"] = "URL Copy"
--Translation missing 
L["Use at most this many champions"] = "Use at most this many champions"
L["Use combat ally"] = "Usar aliado de combate"
--Translation missing 
L["Use this slot"] = "Use this slot"
--Translation missing 
L["Uses troops with the highest durability instead of the ones with the lowest"] = "Uses troops with the highest durability instead of the ones with the lowest"
--Translation missing 
L["When no free followers are available shows empty follower"] = "When no free followers are available shows empty follower"
--Translation missing 
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"
--Translation missing 
L["Would start with "] = "Would start with "
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "Está perdiendo | cffff0000% d | cffffd200 punto (s)!"
--Translation missing 
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=]
--Translation missing 
L["You now need to press both %s and %s to start mission"] = "You now need to press both %s and %s to start mission"

-- Tutorial
--Translation missing 
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=]
--Translation missing 
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[A requested window is not open
Tutorial will resume as soon as possible]=]
--Translation missing 
L["Base Chance"] = "Base Chance"
--Translation missing 
L["Bonus Chance"] = "Bonus Chance"
--Translation missing 
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=]
--Translation missing 
L["Counter Kill Troops"] = "Counter Kill Troops"
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=]
--Translation missing 
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=]
--Translation missing 
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"
--Translation missing 
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=]
--Translation missing 
L["Max champions"] = "Max champions"
--Translation missing 
L["Maximize xp gain"] = "Maximize xp gain"
--Translation missing 
L["Never kill Troops"] = "Never kill Troops"
--Translation missing 
L["Prefer high durability"] = "Prefer high durability"
--Translation missing 
L["Restart the tutorial"] = "Restart the tutorial"
--Translation missing 
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=]
--Translation missing 
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"
--Translation missing 
L["Thank you for reading this, enjoy %s"] = "Thank you for reading this, enjoy %s"
--Translation missing 
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=]
--Translation missing 
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=]
--Translation missing 
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=]
--Translation missing 
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=]
--Translation missing 
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=]
--Translation missing 
L["You can choose not to use a troop type clicking its icon"] = "You can choose not to use a troop type clicking its icon"
--Translation missing 
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=]

return
end
L=l:NewLocale(me,"zhTW")
if (L) then
L["%1$d%% lower than %2$d%%. Lower %s"] = "%1$d%%低於%2$d%%，降低%s"
L["%s for a wowhead link popup"] = "%s跳出wowhead連結"
L["%s start the mission without even opening the mission page. No question asked"] = "%s甚至可以不打開任務頁面就啟動任務， 沒問題"
L["%s starts missions"] = "%s開始任務"
L["%s to blacklist"] = "%s加入黑名單"
L["%s to remove from blacklist"] = "%s從黑名單移除"
L[ [=[%s, please review the tutorial
(Click the icon to dismiss this message and start the tutorial)]=] ] = [=[%s，請查看本指南
（點擊此圖示解除此訊息並開始指南）]=]
L["%s, please review the tutorial\\n(Click the icon to dismiss this message)"] = "這是一個新版本的OrderHallCommander。 請花點時間查看本指南。 點擊此圖標關閉它"
L["Allow to start a mission directly from the mission list page (no single mission page shown)"] = "允許直接從任務列表頁面啟動任務（不會顯示個別任務頁面）"
L["Always counter increased resource cost"] = "總是反制增加資源花費"
L["Always counter increased time"] = "總是反制增加任務時間"
L["Always counter kill troops (ignored if we can only use troops with just 1 durability left)"] = "總是反制殺死部隊(如果我們用只剩一次耐久的部隊則忽略)"
L["Always counter no bonus loot threat"] = "總是反制沒有額外獎勵的威脅"
L["Artifact shown value is the base value without considering knowledge multiplier"] = "神兵顯示的值是基礎值，沒有經過神兵知識的加成。"
L["Attempting %s"] = "嘗試%s"
L["Base Chance"] = "基礎機率"
L["Better parties available in next future"] = "在將來有更好的隊伍"
L["Blacklisted"] = "列入黑名單"
L["Blacklisted missions are ignored in Mission Control"] = "列入黑名單的任務會在任務面板忽略"
L["Bonus Chance"] = "額外獎勵機率"
L["Building Final report"] = "構建最終報告"
L["but using troops with just one durability left"] = "但使用只有一個耐久度的部隊"
L["Capped %1$s. Spend at least %2$d of them"] = "%1$s封頂了。花費至少%2$d在它身上"
L["Changes the sort order of missions in Mission panel"] = "改變任務面板上的任務排列順序"
L["Combat ally is proposed for missions so you can consider unassigning him"] = "戰鬥盟友被建議到任務，所以你可以考慮取消指派他"
L["Complete all missions without confirmation"] = "完成所有任務不須確認"
L["Configuration for mission party builder"] = "任務隊伍構建設置"
L["Cost reduced"] = "花費已降低"
L["Could not fulfill mission, aborting"] = "任務無法履行，忽略"
L["Counter kill Troops"] = "反制殺死部隊"
--Translation missing 
L["Customization options (non mission related)"] = "Customization options (non mission related)"
L["Disables warning: "] = "停用警告："
L["Dont use this slot"] = "不要使用這個空槽"
L["Don't use troops"] = "不要使用部隊"
L["Duration reduced"] = "持續時間已縮短"
L["Duration Time"] = "持續時間"
L["Elites mission mode"] = "精英任務模式"
L["Empty missions sorted as last"] = "空的任務排在最後"
L["Empty or 0% success mission are sorted as last. Does not apply to \"original\" method"] = "空或0%成功率的任務排列在最後，對於\"原始\"方式排序無效。"
--Translation missing 
L["Equipped by following champions:"] = "Equipped by following champions:"
L["Expiration Time"] = "到期時間"
L["Favours leveling follower for xp missions"] = "傾向於使用升級中追隨者在經驗值任務"
L["General"] = "(G) 一般"
L["Global approx. xp reward"] = "整體大約經驗值獎勵"
L["Global approx. xp reward per hour"] = "每小時獲得整體經驗值獎勵"
L["HallComander Quick Mission Completion"] = "大廳任務快速完成"
L["If %1$s is lower than this, then we try to achieve at least %2$s without going over 100%%. Ignored for elite missions."] = "如果%1$s低於此值，那麼我們嘗試至少達到%2$s而不超過100%%。 忽視精英任務。"
L["If not checked, inactive followers are used as last chance"] = "不勾選時，閒置的追隨者會成為最後的考量。"
L[ [=[If you %s, you will lose them
Click on %s to abort]=] ] = [=[如果您繼續，您會失去它們
點擊%s來取消]=]
L["Ignore busy followers"] = "忽略任務中的追隨者"
L["Ignore inactive followers"] = "忽略閒置的追隨者"
L["Keep cost low"] = "保持低花費"
L["Keep extra bonus"] = "保持額外獎勵"
L["Keep time short"] = "保持短時間"
L["Keep time VERY short"] = "保持非常短的時間"
L[ [=[Launch the first filled mission with at least one locked follower.
Keep %s pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = "用至少一個鎖定的追隨者啟動第一個填充任務。 按住%s按鈕實際啟動，一個簡單的點擊將只列印任務名稱與其追隨者名單"
L[ [=[Launch the first filled mission with at least one locked follower.
Keep SHIFT pressed to actually launch, a simple click will only print mission name with its followers list]=] ] = "用至少一個鎖定的追隨者啟動第一個填充任務。 按住SHIFT實際啟動，一個簡單的點擊將只列印任務名稱與其追隨者名單"
L["Level"] = "等級"
L["Lock all"] = "全部鎖定"
L["Lock this follower"] = "鎖定此追隨者"
L["Locked follower are only used in this mission"] = "鎖定只用於此任務的追隨者"
L["Make Order Hall Mission Panel movable"] = "讓大廳任務面板可移動"
L["Makes sure that no troops will be killed"] = "確保沒有部隊會被殺害"
L["Max champions"] = "最多勇士"
L["Maximize xp gain"] = "最大化經驗獲取"
L["Mission duration reduced"] = "任務時間已縮短"
L["Mission was capped due to total chance less than"] = "任務被限制了，由於總機率不及"
L["Missions"] = "(M) 任務"
L["Never kill Troops"] = "絕不殺死部隊"
L["No follower gained xp"] = "沒有追隨者獲得經驗"
L["No suitable missions. Have you reserved at least one follower?"] = "沒有合適的任務。 您是否至少保留一位追隨者？"
L["Not blacklisted"] = "未列入黑名單"
L["Nothing to report"] = "沒什麼可報告"
L["Notifies you when you have troops ready to be collected"] = "當部隊已準備好獲取時提醒你"
L["Only accept missions with time improved"] = "只允許有時間改善的任務"
L["Only consider elite missions"] = "只考慮精英任務"
L["Only use champions even if troops are available"] = "有可用的部隊時，仍然只要使用勇士。"
L["Open configuration"] = "開啟設置選項"
L[ [=[OrderHallCommander overrides GarrisonCommander for Order Hall Management.
 You can revert to GarrisonCommander simply disabling OrderhallCommander.
If instead you like OrderHallCommander remember to add it to Curse client and keep it updated]=] ] = [=[職業大廳指揮官已經取代要塞指揮官來管理職業大廳。
要返回使用要塞指揮官，只要停用職業大廳指揮官插件就可以了。]=]
L["Original method"] = "原始方式"
L["Position is not saved on logout"] = "位置不會在登出後儲存"
L["Prefer high durability"] = "喜好高耐久度"
L["Quick start first mission"] = "快速開始第一個任務"
L["Remove no champions warning"] = "移除沒有勇士警告"
L["Restart tutorial from beginning"] = "從開始的地方重啟指南"
L["Resume tutorial"] = "繼續指南"
L["Resurrect troops effect"] = "復活部隊效果"
L["Reward type"] = "獎勵類型"
L["Sets all switches to a very permissive setup"] = "切換所有設置為非常寬容的設置"
L["Show tutorial"] = "顯示指南"
L["Show/hide OrderHallCommander mission menu"] = "顯示/隱藏大廳指揮官任務選單"
L["Sort missions by:"] = "排列任務根據："
L["Started with "] = "已開始"
L["Success Chance"] = "成功機率"
L["Troop ready alert"] = "部隊整備提醒"
L["Unable to fill missions, raise \"%s\""] = "無法指派任務，請提升 \"%s\""
L["Unable to fill missions. Check your switches"] = "無法分派任務，請檢查你的設定選項。"
L["Unable to start mission, aborting"] = "無法開始任務，中止"
L["Unlock all"] = "全部解除鎖定"
L["Unlock this follower"] = "解鎖此追隨者"
L["Unlocks all follower and slots at once"] = "一次解鎖所有追隨者和空槽"
L["Upgrading to |cff00ff00%d|r"] = "升級到|cff00ff00%d|r"
L["URL Copy"] = "複製網址"
L["Use at most this many champions"] = "至少使用這個數量的勇士"
L["Use combat ally"] = "使用戰鬥盟友"
L["Use this slot"] = "使用此空槽"
L["Uses troops with the highest durability instead of the ones with the lowest"] = "使用最高耐久性的部隊，而不是最低的部隊"
L["When no free followers are available shows empty follower"] = "沒有可用的追隨者時，顯示空欄位。"
L["When we cant achieve the requested %1$s, we try to reach at least this one without (if possible) going over 100%%"] = "當我們無法實現請求的%1$s時, 我們嘗試至少達到這一目標, 而不 (如果可能) 超過100%%"
L["Would start with "] = "會開始"
L["You are wasting |cffff0000%d|cffffd200 point(s)!!!"] = "你浪費了|cffff0000%d|cffffd200 點數!!!"
L[ [=[You need to close and restart World of Warcraft in order to update this version of OrderHallCommander.
Simply reloading UI is not enough]=] ] = [=[您需要關閉並重新啟動魔獸世界才能更新此版本的OrderHallCommander。
簡單的重新載入UI是不夠的]=]
L["You now need to press both %s and %s to start mission"] = "您現在需要同時按下%s和%s來啟動任務"

-- Tutorial
L[ [=[%1$s and %2$s switches work together to customize how you want your mission filled

The value you set for %1$s (right now %3$s%%) is the minimum acceptable chance for attempting to achieve bonus while the value to set for %2$s (right now %4$s%%) is the chance you want achieve when you are forfaiting bonus (due to not enough powerful followers)]=] ] = [=[%1$s與%2$s一起交換運作以定制你想要任務如何分派

你為 %1$s 設置的值(目前為 %3$s%%)是最低可接受的額外獎勵機率，而為為 %2$s 設置的值(目前為 %4$s%%)是你想要實現的機率，當你是為了爭取獎勵（由於沒有足夠強大的追隨者）]=]
L[ [=[A requested window is not open
Tutorial will resume as soon as possible]=] ] = [=[請求的視窗未打開
指南將盡快恢復]=]
L["Base Chance"] = "基礎機率"
L["Bonus Chance"] = "額外獎勵機率"
L[ [=[Clicking a party button will assign its followers to the current mission.
Use it to verify OHC calculated chance with Blizzard one.
If they differs please take a screenshot and open a ticket :).]=] ] = [=[點擊一個隊伍按鈕將會將其追隨者分配給當前的任務。
使用它來比較驗證OHC與暴雪計算的機率。
如果他們不同，請拍攝截圖並開啟一個問題回報:)。]=]
L["Counter Kill Troops"] = "反制殺死部隊"
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, drag and drop from bags raise an error.
if you drag and drop an item from a bag, you receive an error.
In order to assign equipments which are not listed (I update the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = [=[設備和升級在這裡被列為可點擊的按鈕。
由於Blizzard 系統汙染的問題，從包中拖放會導致錯誤。
如果您從包中拖放了一個物品，則會收到錯誤。
為了指定未列出的設備（我經常更新列表，但有時暴雪更快），您可以右鍵單擊包中的物品，然後左鍵單擊跟隨者。
這種方式您不會收到任何錯誤]=]
L[ [=[Equipment and upgrades are listed here as clickable buttons.
Due to an issue with Blizzard Taint system, if you drag and drop an item from a bag, you receive an error.
In order to assign equipment which are not listed (I updated the list often but sometimes Blizzard is faster), you can right click the item in the bag and the left click the follower.
This way you dont receive any error]=] ] = "設備和升級在這裡列為可點擊的按鈕。 由於暴雪污染系統的問題，如果您從包中拖放物品，您會收到錯誤。 為了分配未列出的設備（我經常更新列表，但有時暴雪更快），您可以右鍵單擊包中的物品，然後左鍵單擊追隨者。 這樣你就不會收到任何錯誤"
L[ [=[For example, let's say a mission can reach 95%%, 130%% and 180%% success chance.
If %1$s is set to 170%%, the 180%% one will be choosen.
If %1$s is set to 200%% OHC will try to find the nearest to 100%% respecting %2$s setting
If for example %2$s is set to 100%%, then the 130%% one will be choosen, but if %2$s is set to 90%% then the 95%% one will be choosen]=] ] = [=[例如，假設一個任務可以達到95%%，130%%和180%%的成功機會。
如果%1$s設置為170%%，則會選擇180%%。 如果%1$s 被設置為200%% OHC將嘗試找到最接近100%%
至於%2$s設置
假設%2$s設置為100%%，那麼將會選擇130%%，但如果%2$s設置為90%%，那麼將選擇95%%
假設％2$s設置為100%%，那麼將會選擇130%%，但如果％2$s設置為90%%，那麼將選擇95%%]=]
L["If instead you just want to always see the best available mission just set %1$s to 100%% and %2$s to 0%%"] = "如果您只是希望始終看到最佳可用任務，只需將%1$s設置為100%%，將%2$s設置為0%%"
L[ [=[If you dont understand why OHC choosed a setup for a mission, you can request a full analysis.
Analyze party will show all the possible combinations and how OHC evaluated them]=] ] = [=[如果你不明白OHC如何選擇一個任務的設置，你可以要求一個完整的分析。
分析隊伍將顯示所有可能的組合, 以及OHC如何評估他們]=]
L["Max champions"] = "最多勇士"
L["Maximize xp gain"] = "最大化經驗獲取"
L["Never kill Troops"] = "絕不殺死部隊"
L["Prefer high durability"] = "喜好高耐久度"
L["Restart the tutorial"] = "重啟指南"
L[ [=[Slots (non the follower in it but just the slot) can be banned.
When you ban a slot, that slot will not be filled for that mission.
Exploiting the fact that troops are always in the leftmost slot(s) you can achieve a nice degree of custom tailoring, reducing the overall number of followers used for a mission]=] ] = "插槽（不是其中的追隨者，而只是插槽）可以被禁止。 當你禁止一個插槽時，這個插槽不會被填滿。 總是在最左側的插槽使用部隊，您可以實現一個很好的定制裁剪，減少用於任務的追隨者總數"
L["Terminate the tutorial. You can resume it anytime clicking on the info icon in the side menu"] = "終止本指南。您可以隨時點擊側面選單中的訊息圖標來恢復"
L["Thank you for reading this, enjoy %s"] = "感謝您的閱讀，享受%s"
L[ [=[Usually OrderHallCOmmander tries to use troops with the lowest durability in order to let you enque new troops request as soon as possible.
Checking %1$s reverse it and OrderHallCOmmander will choose for each mission troops with the highest possible durability]=] ] = "通常，OrderHallCOmmander嘗試使用最低耐久性的部隊，以便盡快請求新的部隊。 勾選%1$s反向操作，OrderHallCOmmander將為每個任務選擇盡可能高耐久度的部隊"
L[ [=[Welcome to a new release of OrderHallCommander
Please follow this short tutorial to discover all new functionalities.
You will not regret it]=] ] = "歡迎來到OrderHallCommander的新版本請按照這個簡短的指南來發現所有新的功能。 你不會後悔的"
L[ [=[With %1$s you ask to always counter the Hazard kill troop.
This means that OHC will try to counter it OR use a troop with just one durability left.
The target for this switch is to avoid wasting durability point, NOT to avoid troops' death.]=] ] = "至於%1$s你要求總是反制危險殺死部隊。 這意味著OHC將試圖對付它，或者使用一個只有一個耐久度的部隊。 這種切換的目標是避免浪費耐久度，而不是避免部隊死亡。"
L[ [=[With %2$s you ask to never let a troop die.
This not only implies %1$s and %3$s, but force OHC to never send to mission a troop which will die.
The target for this switch is to totally avoid killing troops, even it for this we cant fill the party]=] ] = [=[至於%2$s你要求不要讓部隊死亡。
這不僅意味著%1$s和%3$s，而且強制OHC永遠不會派一個部隊會死亡的任務。
這個轉變的目標是完全避免殺死部隊，即使這樣我們也不能填補隊伍]=]
L[ [=[You can blacklist missions right clicking mission button.
Since 1.5.1 you can start a mission witout passing from mission page shift-clicking the mission button.
Be sure you liked the party because no confirmation is asked]=] ] = "您可以右鍵點擊任務按鈕將任務加入黑名單。 自1.5.1以來，您可以shift-點擊任務按鈕開始任務而無須轉到任務頁面。 確保你喜歡此隊伍，因為不經確認"
L["You can choose not to use a troop type clicking its icon"] = "您可以單擊其圖標選擇不使用的部隊類型"
L[ [=[You can choose to limit how much champions are sent together.
Right now OHC is not using more than %3$s champions in the same mission-

Note that %2$s overrides it.]=] ] = [=[您可以選擇限制一起分派的勇士數量。 現在OHC沒有在同一個任務中使用超過 %3$s 的勇士 -

請注意，%2$s會覆蓋它。]=]

return
end
