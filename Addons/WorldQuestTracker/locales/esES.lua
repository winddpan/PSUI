local L = LibStub("AceLocale-3.0"):NewLocale("WorldQuestTrackerAddon", "esES") 
if not L then return end 

L["S_APOWER_AVAILABLE"] = "Disponible"
L["S_APOWER_DOWNVALUE"] = "Misiones con %s significa que tienen más tiempo que la investigación en curso."
L["S_APOWER_NEXTLEVEL"] = "Siguiente Nivel"
L["S_ENABLED"] = "Habilitado"
L["S_ERROR_NOTIMELEFT"] = "Esta misión no tiene tiempo restante."
L["S_ERROR_NOTLOADEDYET"] = "Esta misión no está cargada todavía, por favor de espera unos segundos"
L["S_FLYMAP_SHOWTRACKEDONLY"] = "Sólo en rastreo"
L["S_FLYMAP_SHOWTRACKEDONLY_DESC"] = "Mostrar sólo misiones en rastreo"
L["S_FLYMAP_SHOWWORLDQUESTS"] = "Muestra visiones del mundo"
L["S_MAPBAR_AUTOWORLDMAP"] = "Auto Mapa del Mundo"
L["S_MAPBAR_AUTOWORLDMAP_DESC"] = [=[Estando en Dalaran on Sala de Órden, apretando 'M' va directamente al mapa de las Islas Abruptas.
Apretar 'M' dos veces va al mapa donde te encuentras.]=]
L["S_MAPBAR_FILTER"] = "Filtro"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES"] = "Objetivos de Facción"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES_DESC"] = "Mostrar misiones de facción incluso si han sido filtradas."
L["S_MAPBAR_OPTIONS"] = "Opciones"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED"] = "Velocidad de Actualización de Flecha"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_HIGH"] = "Rápido"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_MEDIUM"] = "Medio"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_REALTIME"] = "Tiempo Real"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_SLOW"] = "Lento"
L["S_MAPBAR_OPTIONSMENU_EQUIPMENTICONS"] = "Iconos de equipo"
L["S_MAPBAR_OPTIONSMENU_QUESTTRACKER"] = "Habilitar Rastreador de Misiones"
L["S_MAPBAR_OPTIONSMENU_REFRESH"] = "Refrescar"
L["S_MAPBAR_OPTIONSMENU_SHARE"] = "Compartir este AddOn"
L["S_MAPBAR_OPTIONSMENU_SOUNDENABLED"] = "Habilitar Sonido"
L["S_MAPBAR_OPTIONSMENU_STATUSBARANCHOR"] = "Anclar en la parte superior"
L["S_MAPBAR_OPTIONSMENU_TOMTOM_WPPERSISTENT"] = "Punto de paso persistente"
L["S_MAPBAR_OPTIONSMENU_TRACKER_CURRENTZONE"] = "Sólo zona actual"
L["S_MAPBAR_OPTIONSMENU_TRACKER_SCALE"] = "Escada del Rastreador: %s"
L["S_MAPBAR_OPTIONSMENU_TRACKERCONFIG"] = "Configuración del Rastreador"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_AUTO"] = "Posición automática"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_CUSTOM"] = "Posición personalizada"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_LOCKED"] = "Bloqueado"
L["S_MAPBAR_OPTIONSMENU_UNTRACKQUESTS"] = "Dejar de rastrear todas las misiones"
L["S_MAPBAR_OPTIONSMENU_WORLDMAPCONFIG"] = "Configuración del Mapa del Mundo"
L["S_MAPBAR_OPTIONSMENU_YARDSDISTANCE"] = "Mostrar distancia en yardas"
L["S_MAPBAR_OPTIONSMENU_ZONE_QUESTSUMMARY"] = "Sumario de misiones (pantalla completa)"
L["S_MAPBAR_OPTIONSMENU_ZONEMAPCONFIG"] = "Configuración del mapa de zona"
L["S_MAPBAR_RESOURCES_TOOLTIP_TRACKALL"] = "Presionar para rastrear todas: |cFFFFFFFF%s|r misiones."
L["S_MAPBAR_SORTORDER"] = "Ordenación"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_FADE"] = "Sombrear misiones"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_OPTION"] = "Menos de %d Horas"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SHOWTEXT"] = "Texto de tiempo restante"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SORTBYTIME"] = "Ordenado por tiempo"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_TITLE"] = "Tiempo restante"
L["S_MAPBAR_SUMMARY"] = "Sumario"
L["S_MAPBAR_SUMMARYMENU_ACCOUNTWIDE"] = "Ligado a la cuenta"
L["S_MAPBAR_SUMMARYMENU_MOREINFO"] = "Da click para más información"
L["S_MAPBAR_SUMMARYMENU_NOATTENTION"] = "A ninguna de las misiones rastreadas en tus otros personajes le queda menos de 2 horas!"
L["S_MAPBAR_SUMMARYMENU_REQUIREATTENTION"] = "Requiere Atención"
L["S_MAPBAR_SUMMARYMENU_TODAYREWARDS"] = "Recompensas de hoy"
L["S_OVERALL"] = "Total"
L["S_PARTY"] = "Grupo"
L["S_PARTY_DESC1"] = "Misiones con una estrella azul significa que todos los miembros del grupo tienen la misión."
L["S_PARTY_DESC2"] = "Si se muestra una estrella roja, un miembro del grupo no es elegible para las misiones de mundo o no tiene WQT instalado aún."
L["S_PARTY_PLAYERSWITH"] = "Jugadores en el grupo con WQT:"
L["S_PARTY_PLAYERSWITHOUT"] = "Jugadores en el grupo sin WQT:"
L["S_QUESTSCOMPLETED"] = "Misiones finalizadas"
L["S_QUESTTYPE_ARTIFACTPOWER"] = "Poder del artefacto"
L["S_QUESTTYPE_DUNGEON"] = "Mazmorra"
L["S_QUESTTYPE_EQUIPMENT"] = "Equipo"
L["S_QUESTTYPE_GOLD"] = "Oro"
L["S_QUESTTYPE_PETBATTLE"] = "Mascota de duelo"
L["S_QUESTTYPE_PROFESSION"] = "Profesión"
L["S_QUESTTYPE_PVP"] = "JcJ"
L["S_QUESTTYPE_RESOURCE"] = "Recursos"
L["S_QUESTTYPE_TRADESKILL"] = "Habilidad de comercio"
L["S_SHAREPANEL_THANKS"] = [=[Gracias por compartir el Rastreador de Misiones de Mundo!
Envía nuestro enlace a tus amigos en facebook, twitter, la Moncloa.]=]
L["S_SUMMARYPANEL_EXPIRED"] = "AGOTADO"
L["S_SUMMARYPANEL_LAST15DAYS"] = "Últimos 15 días"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_ACCOUNT"] = "Estadísticas históricas de la cuenta"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_CHARACTER"] = "Estadísticas históricas del personaje"
L["S_SUMMARYPANEL_OTHERCHARACTERS"] = "Otros personajes"
L["S_TUTORIAL_AMOUNT"] = "indica la cantidad a recibir"
L["S_TUTORIAL_CLICKTOTRACK"] = "Presiona para rastrear una misión."
L["S_TUTORIAL_CLOSE"] = "Cerrar tutorial."
L["S_TUTORIAL_FACTIONBOUNTY"] = "indica que la misión cuenta para la facción seleccionada."
L["S_TUTORIAL_FACTIONBOUNTY_AMOUNTQUESTS"] = "indica cuántas misiones hay en el mapa para la facción seleccionada."
L["S_TUTORIAL_HOWTOADDTRACKER"] = "Botón izquierdo para rastrear una misión. En el rastreador, presionar |cFFFFFFFFbotón derecho|r para dejar de trastrearla."
L["S_TUTORIAL_PARTY"] = "Cuando en grupo, una estrella azul indica las misiones que todos los miembros del grupo tienen!"
L["S_TUTORIAL_RARITY"] = "indica la calidad (común, raro, épico)"
L["S_TUTORIAL_REWARD"] = "indica la recompensa (equipo, oro, poder de artefacto, recursos, componentes)"
L["S_TUTORIAL_TIMELEFT"] = "indica el tiempo restante (+4 horas, +90 minutos, +30 minutos, menos de 30 minutos)"
L["S_TUTORIAL_WORLDMAPBUTTON"] = "Este botón te lleva al mapa de las Islas Abruptas."
L["S_UNKNOWNQUEST"] = "Misión desconocida"
L["S_WORLDQUESTS"] = "Misiones de mundo"
