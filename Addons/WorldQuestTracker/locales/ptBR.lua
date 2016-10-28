local L = LibStub("AceLocale-3.0"):NewLocale("WorldQuestTrackerAddon", "ptBR") 
if not L then return end 

L["S_APOWER_AVAILABLE"] = "Disponível"
L["S_APOWER_DOWNVALUE"] = "Quests com %s significa que possuem mais tempo restante do que a pesquisa de poder de artefato."
L["S_APOWER_NEXTLEVEL"] = "Próximo Nível"
L["S_ENABLED"] = "Ativado"
L["S_ERROR_NOTIMELEFT"] = "Esta quest expirou."
L["S_ERROR_NOTLOADEDYET"] = "Esta quest não foi carregada ainda, por favor aguarde."
L["S_FLYMAP_SHOWTRACKEDONLY"] = "Apenas Rastreadas"
L["S_FLYMAP_SHOWTRACKEDONLY_DESC"] = "Mostrar apenas quests que estão sendo rastreadas."
L["S_FLYMAP_SHOWWORLDQUESTS"] = "Mostrar Quests Globais"
L["S_MAPBAR_AUTOWORLDMAP"] = "Mapa Global Automatico"
L["S_MAPBAR_AUTOWORLDMAP_DESC"] = [=[Em Dalaran ou no Hall da sua classe, pressionando 'M' vai direto para o mapa das Ilhas Partidas.

Pressione duas vezes 'M' rapidamente para ir ao mapa em que você esta atualmente.]=]
L["S_MAPBAR_FILTER"] = "Filtros"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES"] = "Objetivos de Facções"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES_DESC"] = "Mostra quets de facções mesmo que elas tenham sido filtradas."
L["S_MAPBAR_OPTIONS"] = "Opções"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED"] = "Atualização da Seta"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_HIGH"] = "Rápida"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_MEDIUM"] = "Médio"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_REALTIME"] = "Em Tempo Real"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_SLOW"] = "Lento"
L["S_MAPBAR_OPTIONSMENU_QUESTTRACKER"] = "Ativar Quest Tracker"
L["S_MAPBAR_OPTIONSMENU_REFRESH"] = "Atualizar Quests"
L["S_MAPBAR_OPTIONSMENU_SHARE"] = "Compartilhe Este AddOn"
L["S_MAPBAR_OPTIONSMENU_SOUNDENABLED"] = "Som Ativo"
L["S_MAPBAR_OPTIONSMENU_STATUSBARANCHOR"] = "Ancora no Topo"
L["S_MAPBAR_OPTIONSMENU_TOMTOM_WPPERSISTENT"] = "Ponto Persistente"
L["S_MAPBAR_OPTIONSMENU_TRACKERCONFIG"] = "Ajustes do Tracker"
L["S_MAPBAR_OPTIONSMENU_TRACKER_CURRENTZONE"] = "Apenas Mapa Atual"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_AUTO"] = "Automático" -- Needs review
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_CUSTOM"] = "Manual"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_LOCKED"] = "Trancado"
L["S_MAPBAR_OPTIONSMENU_TRACKER_SCALE"] = "Tracker Escala: %s"
L["S_MAPBAR_OPTIONSMENU_UNTRACKQUESTS"] = "Parar Todo Rastreamento"
L["S_MAPBAR_OPTIONSMENU_WORLDMAPCONFIG"] = "Ajustes do Mapa Mundi"
L["S_MAPBAR_OPTIONSMENU_YARDSDISTANCE"] = "Mostrar Distância"
L["S_MAPBAR_OPTIONSMENU_ZONEMAPCONFIG"] = "Ajustas do Mapa Zona"
L["S_MAPBAR_OPTIONSMENU_ZONE_QUESTSUMMARY"] = "Mostrar Sumário (tela cheia)"
L["S_MAPBAR_RESOURCES_TOOLTIP_TRACKALL"] = "Clique para rastrear: |cFFFFFFFF%s|r quests."
L["S_MAPBAR_SORTORDER"] = "Ordem"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_FADE"] = "Usar Trasparência"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_OPTION"] = "Menos De %d Horas"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SHOWTEXT"] = "Texto do Tempo Restante"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SORTBYTIME"] = "Ordem por Tempo"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_TITLE"] = "Tempo Restante"
L["S_MAPBAR_SUMMARY"] = "Sumário"
L["S_MAPBAR_SUMMARYMENU_ACCOUNTWIDE"] = "Na Conta"
L["S_MAPBAR_SUMMARYMENU_MOREINFO"] = "botão esquerdo: mostrar mais"
L["S_MAPBAR_SUMMARYMENU_NOATTENTION"] = [=[Nenhuma quest sendo rastreadas nos seus demais personagens
tem menos de 2 horas de tempo restante.]=]
L["S_MAPBAR_SUMMARYMENU_REQUIREATTENTION"] = "Requer Atenção"
L["S_MAPBAR_SUMMARYMENU_TODAYREWARDS"] = "Conquistas de Hoje"
L["S_OVERALL"] = "Em Geral"
L["S_PARTY"] = "Grupo"
L["S_PARTY_DESC1"] = "Uma estrela azul na quest significa que todos do grupo a possuem."
L["S_PARTY_DESC2"] = "Se uma estrela vermelha é mostrada, algum member do grupo não tem WQT instalado ainda."
L["S_PARTY_PLAYERSWITH"] = "Jogadores no grupo com WQT:"
L["S_PARTY_PLAYERSWITHOUT"] = "Jogadores no grupo sem WQT:"
L["S_QUESTSCOMPLETED"] = "Quests Completadas"
L["S_QUESTTYPE_ARTIFACTPOWER"] = "Poder de Artefato"
L["S_QUESTTYPE_DUNGEON"] = "Masmorra"
L["S_QUESTTYPE_EQUIPMENT"] = "Equipamento"
L["S_QUESTTYPE_GOLD"] = "Ouro"
L["S_QUESTTYPE_PETBATTLE"] = "Batalha de Mascote"
L["S_QUESTTYPE_PROFESSION"] = "Profissão"
L["S_QUESTTYPE_PVP"] = "JxJ"
L["S_QUESTTYPE_RESOURCE"] = "Recursos"
L["S_QUESTTYPE_TRADESKILL"] = "Materiais"
L["S_SHAREPANEL_THANKS"] = "Obrigado por compartilhar World Quest Tracker!\\nEnvie este link aos seus amigos no Facebook, Twitter, Itamarati."
L["S_SHAREPANEL_TITLE"] = "Só os Loucos Sabem!"
L["S_SUMMARYPANEL_EXPIRED"] = "EXPIRADA"
L["S_SUMMARYPANEL_LAST15DAYS"] = "Últimos 15 Dias"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_ACCOUNT"] = "Estatísticas da Conta"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_CHARACTER"] = "Estatísticas do Personagem"
L["S_SUMMARYPANEL_OTHERCHARACTERS"] = "Outros Personagems"
L["S_TUTORIAL_AMOUNT"] = "indica a quantidade a receber"
L["S_TUTORIAL_CLICKTOTRACK"] = "Clique para rastrear a quest."
L["S_TUTORIAL_CLOSE"] = "Fechar Tutorial"
L["S_TUTORIAL_FACTIONBOUNTY"] = "indica que a quest conta para a facção selecionada no mapa."
L["S_TUTORIAL_FACTIONBOUNTY_AMOUNTQUESTS"] = "indica quantas quests há no mapa para a facção selecionada."
L["S_TUTORIAL_HOWTOADDTRACKER"] = "Clique para rastrear a quest. No rastreados, você pode clicar com o |cFFFFFFFFbotão direito|r para remove-la do rastreador."
L["S_TUTORIAL_PARTY"] = "Enquanto em grupo, uma estrela azul é mostrada em quests que todos do grupo possuem."
L["S_TUTORIAL_RARITY"] = "indica a raridade da quest (comum, rara ou épica)."
L["S_TUTORIAL_REWARD"] = "indica o prêmio a receber (equipamento, ouro, poder de artefato, recursos ou reagentes)."
L["S_TUTORIAL_TIMELEFT"] = "indica o tempo restante (+4 horas, +90 minutos, +30 minutos, menos de 30 minutos)."
L["S_TUTORIAL_WORLDMAPBUTTON"] = "Este botão mostra o mapa das Ilhas Partidas."
L["S_UNKNOWNQUEST"] = "Quest Desconhecida"
L["S_WORLDQUESTS"] = "Quests Globais"

