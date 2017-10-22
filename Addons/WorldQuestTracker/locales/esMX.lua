local L = LibStub("AceLocale-3.0"):NewLocale("WorldQuestTrackerAddon", "esMX") 
if not L then return end 

L["S_APOWER_AVAILABLE"] = "Disponible"
L["S_APOWER_DOWNVALUE"] = "Misiones con %s significa que tienen más tiempo que la investigación actual."
L["S_APOWER_NEXTLEVEL"] = "Siguiente nivel"
L["S_ENABLED"] = "Habilitado"
L["S_ERROR_NOTIMELEFT"] = "A esta misión no le queda tiempo."
L["S_ERROR_NOTLOADEDYET"] = "Esta misión no se ha cargado todavía, por favor espere unos segundos."
L["S_FLYMAP_SHOWTRACKEDONLY"] = "Sólo con seguimiento"
L["S_FLYMAP_SHOWTRACKEDONLY_DESC"] = "Muestra únicamente misiones que están en seguimiento"
L["S_FLYMAP_SHOWWORLDQUESTS"] = "Mostrar misiones de mundo"
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_CANCEL_APPLICATIONS"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_CANCELING"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_CREATE"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_CREATE_DIRECT"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_LEAVEASK"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_LEAVINGIN"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_RETRYSEARCH"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_SEARCH"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_SEARCH_RARENPC"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_SEARCH_TOOLTIP"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_SEARCHING"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_SEARCHMORE"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_SEARCHOTHER"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_UNAPPLY1"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_UNLIST"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_UNLISTING"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ACTIONS_WAITING"] = ""
--Translation missing 
-- L["S_GROUPFINDER_AUTOOPEN_RARENPC_TARGETED"] = ""
--Translation missing 
-- L["S_GROUPFINDER_ENABLED"] = ""
--Translation missing 
-- L["S_GROUPFINDER_INVASION_ENABLED"] = ""
--Translation missing 
-- L["S_GROUPFINDER_LEAVEOPTIONS"] = ""
--Translation missing 
-- L["S_GROUPFINDER_LEAVEOPTIONS_AFTERX"] = ""
--Translation missing 
-- L["S_GROUPFINDER_LEAVEOPTIONS_ASKX"] = ""
--Translation missing 
-- L["S_GROUPFINDER_LEAVEOPTIONS_DONTLEAVE"] = ""
--Translation missing 
-- L["S_GROUPFINDER_LEAVEOPTIONS_IMMEDIATELY"] = ""
--Translation missing 
-- L["S_GROUPFINDER_NOPVP"] = ""
--Translation missing 
-- L["S_GROUPFINDER_OT_ENABLED"] = ""
--Translation missing 
-- L["S_GROUPFINDER_QUEUEBUSY"] = ""
--Translation missing 
-- L["S_GROUPFINDER_QUEUEBUSY2"] = ""
--Translation missing 
-- L["S_GROUPFINDER_RESULTS_APPLYING"] = ""
--Translation missing 
-- L["S_GROUPFINDER_RESULTS_APPLYING1"] = ""
--Translation missing 
-- L["S_GROUPFINDER_RESULTS_FOUND"] = ""
--Translation missing 
-- L["S_GROUPFINDER_RESULTS_FOUND1"] = ""
--Translation missing 
-- L["S_GROUPFINDER_RESULTS_UNAPPLY"] = ""
--Translation missing 
-- L["S_GROUPFINDER_RIGHTCLICKCLOSE"] = ""
--Translation missing 
-- L["S_GROUPFINDER_SECONDS"] = ""
--Translation missing 
-- L["S_GROUPFINDER_TITLE"] = ""
--Translation missing 
-- L["S_GROUPFINDER_TUTORIAL1"] = ""
L["S_MAPBAR_AUTOWORLDMAP"] = "Auto mapa del mundo"
L["S_MAPBAR_AUTOWORLDMAP_DESC"] = [=[Estando en Dalaran o Sala de clase, pulsando la tecla 'M' va directamente al mapa de las Islas quebradas.

Doble "M" va al mapa en el que te encuentras actualmente.]=]
L["S_MAPBAR_FILTER"] = "Filtro"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES"] = "Objetivos de facción"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES_DESC"] = "Mostrar misiones de facción, incluso si han sido filtradas."
L["S_MAPBAR_OPTIONS"] = "Opciones"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED"] = "Actualicación de la flecha"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_HIGH"] = "Rápido"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_MEDIUM"] = "Medio"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_REALTIME"] = "Tiempo real"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_SLOW"] = "Lento"
L["S_MAPBAR_OPTIONSMENU_EQUIPMENTICONS"] = "Iconos de equipo"
L["S_MAPBAR_OPTIONSMENU_QUESTTRACKER"] = "Habilitar seguimiento de misiones"
L["S_MAPBAR_OPTIONSMENU_REFRESH"] = "Refrescar"
L["S_MAPBAR_OPTIONSMENU_SHARE"] = "Comparte este AddOn"
L["S_MAPBAR_OPTIONSMENU_SOUNDENABLED"] = "Habilitar sonido"
L["S_MAPBAR_OPTIONSMENU_STATUSBARANCHOR"] = "Anclar arriba"
L["S_MAPBAR_OPTIONSMENU_TOMTOM_WPPERSISTENT"] = "Punto de ruta persistente"
L["S_MAPBAR_OPTIONSMENU_TRACKER_CURRENTZONE"] = "Zona actual solamente"
L["S_MAPBAR_OPTIONSMENU_TRACKER_SCALE"] = "Escala de seguimiento: %s"
L["S_MAPBAR_OPTIONSMENU_TRACKERCONFIG"] = "Configuración de seguimiento"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_AUTO"] = "Posición automática"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_CUSTOM"] = "Posición personalizada"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_LOCKED"] = "Bloqueado"
L["S_MAPBAR_OPTIONSMENU_UNTRACKQUESTS"] = "Quitar todo seguimiento"
L["S_MAPBAR_OPTIONSMENU_WORLDMAPCONFIG"] = "Configuración de mapa del mundo"
L["S_MAPBAR_OPTIONSMENU_YARDSDISTANCE"] = "Mostrar distancia (yardas)"
L["S_MAPBAR_OPTIONSMENU_ZONE_QUESTSUMMARY"] = "Resumen de misiones (pantalla completa)"
L["S_MAPBAR_OPTIONSMENU_ZONEMAPCONFIG"] = "Configuración del mapa de la zona"
L["S_MAPBAR_RESOURCES_TOOLTIP_TRACKALL"] = "Clic para realizar seguimiento de todas las misiones de: |cFFFFFFFF%s|r."
L["S_MAPBAR_SORTORDER"] = "Orden"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_FADE"] = "Desvanecimiento de misiones"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_OPTION"] = "Menos de %d horas"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SHOWTEXT"] = "Texto de tiempo restante"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SORTBYTIME"] = "Ordenar por tiempo"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_TITLE"] = "Tiempo restante"
L["S_MAPBAR_SUMMARY"] = "Resumen"
L["S_MAPBAR_SUMMARYMENU_ACCOUNTWIDE"] = "Toda la cuenta"
L["S_MAPBAR_SUMMARYMENU_MOREINFO"] = "Clic para más información"
L["S_MAPBAR_SUMMARYMENU_NOATTENTION"] = [=[¡No hay misiones en seguimiento en tus otros
personajes que tengan menos de 2 horas restantes!]=]
L["S_MAPBAR_SUMMARYMENU_REQUIREATTENTION"] = "Requieren atención"
L["S_MAPBAR_SUMMARYMENU_TODAYREWARDS"] = "Recompensas de hoy"
L["S_OVERALL"] = "En total"
L["S_PARTY"] = "Grupo"
L["S_PARTY_DESC1"] = "Misiones con una estrella azul significa que todos los miembros del grupo tienen la misión."
L["S_PARTY_DESC2"] = "Si se muestra una estrella roja, un miembro del grupo no es elegible para la misiones de mundo o no tiene instalado todavía WQT."
L["S_PARTY_PLAYERSWITH"] = "Jugadores en el grupo con WQT:"
L["S_PARTY_PLAYERSWITHOUT"] = "Jugadores en el grupo sin WQT:"
L["S_QUESTSCOMPLETED"] = "Misiones completadas"
L["S_QUESTTYPE_ARTIFACTPOWER"] = "Poder de artefacto"
L["S_QUESTTYPE_DUNGEON"] = "Mazmorra"
L["S_QUESTTYPE_EQUIPMENT"] = "Equipo"
L["S_QUESTTYPE_GOLD"] = "Oro"
L["S_QUESTTYPE_PETBATTLE"] = "Duelo de mascotas"
L["S_QUESTTYPE_PROFESSION"] = "Profesión"
L["S_QUESTTYPE_PVP"] = "JcJ"
L["S_QUESTTYPE_RESOURCE"] = "Recursos"
L["S_QUESTTYPE_TRADESKILL"] = "Habilidad comercial"
--Translation missing 
-- L["S_RAREFINDER_ADDFROMPREMADE"] = ""
--Translation missing 
-- L["S_RAREFINDER_NPC_NOTREGISTERED"] = ""
--Translation missing 
-- L["S_RAREFINDER_OPTIONS_ENGLISHSEARCH"] = ""
--Translation missing 
-- L["S_RAREFINDER_OPTIONS_SHOWICONS"] = ""
--Translation missing 
-- L["S_RAREFINDER_SOUND_ALWAYSPLAY"] = ""
--Translation missing 
-- L["S_RAREFINDER_SOUND_ENABLED"] = ""
--Translation missing 
-- L["S_RAREFINDER_SOUNDWARNING"] = ""
--Translation missing 
-- L["S_RAREFINDER_TITLE"] = ""
--Translation missing 
-- L["S_RAREFINDER_TOOLTIP_REMOVE"] = ""
--Translation missing 
-- L["S_RAREFINDER_TOOLTIP_SEACHREALM"] = ""
--Translation missing 
-- L["S_RAREFINDER_TOOLTIP_SPOTTEDBY"] = ""
--Translation missing 
-- L["S_RAREFINDER_TOOLTIP_TIMEAGO"] = ""
L["S_SHAREPANEL_THANKS"] = [=[¡Gracias por compartir World Quest Tracker!
Enviar nuestro enlace a tus amigos de Facebook, Twitter o la Casa Blanca.]=]
L["S_SHAREPANEL_TITLE"] = "For All Those About to Rock!"
L["S_SUMMARYPANEL_EXPIRED"] = "EXPIRADO"
L["S_SUMMARYPANEL_LAST15DAYS"] = "Últimos 15 días"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_ACCOUNT"] = "Estadísticas de la cuenta"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_CHARACTER"] = "Estadísticas del personaje"
L["S_SUMMARYPANEL_OTHERCHARACTERS"] = "Otros personajes"
L["S_TUTORIAL_AMOUNT"] = "indica la cantidad a recibir"
L["S_TUTORIAL_CLICKTOTRACK"] = "Clic para seguir una misión."
L["S_TUTORIAL_CLOSE"] = "Cerrar tutorial"
L["S_TUTORIAL_FACTIONBOUNTY"] = "indica el conteo de misiones para la facción seleccionada."
L["S_TUTORIAL_FACTIONBOUNTY_AMOUNTQUESTS"] = "indica cuántas misiones hay en el mapa para la facción seleccionada."
L["S_TUTORIAL_HOWTOADDTRACKER"] = "Clic izquierdo para seguir una misión. En el seguimiento, puedes hacer |cFFFFFFFFClic derecho|r para quitar el seguimiento."
L["S_TUTORIAL_PARTY"] = "¡Cuando en un grupo, se muestra una estrella azul, es una misiones que todos los miembros del grupo tienen!"
L["S_TUTORIAL_RARITY"] = "indica la rareza (común, rara, épica)"
L["S_TUTORIAL_REWARD"] = "indica la recompensa (equipo, oro, poder de artefacto, recursos, reactivos)"
L["S_TUTORIAL_TIMELEFT"] = "indica el tiempo que queda (+4 horas, +90 minutos, +30 minutos, menos de 30 minutos)"
L["S_TUTORIAL_WORLDMAPBUTTON"] = "Este botón lo llevara al mapa de las Islas quebradas."
L["S_UNKNOWNQUEST"] = "Misión desconocida"
--Translation missing 
-- L["S_WORLDMAP_TOOGLEQUESTS"] = ""
L["S_WORLDQUESTS"] = "Misiones de mundo"

