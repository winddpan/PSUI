local L = LibStub("AceLocale-3.0"):NewLocale ("AddonCpuUsage", "ptBR") 
if not L then return end 

L["STRING_CAPTURING_CPU"] = "capturando Dados"
L["STRING_CLOSE"] = "fechar"
L["STRING_DATABROKER_HELP_LEFTBUTTON"] = "|cFFFFFF00Botão Esquerdo|r: abrir o painel principal."
L["STRING_DATABROKER_HELP_RIGHTBUTTON"] = [=[|cFFFFFF00Botão Direito|r: abrir opções.
]=]
L["STRING_FINISHED_INCOMBAT"] = "esperando o fim do combate para abrir a janela."
L["STRING_FINISHED_NOTENOUGHTIME"] = "a duração do combate foi pequena demais."
L["STRING_FINISHED_SUCCESSFUL"] = "data capturada com sucesso."
L["STRING_HELP_DONTSHOWAGAIN"] = "Não mostrar este painel novamente."
L["STRING_LISTPANEL_ADDONNAME"] = "Nome do AddOn"
L["STRING_LISTPANEL_AVERAGE"] = "Média:"
L["STRING_LISTPANEL_AVERAGE_DESC"] = [=[Média do tempo em milésimos de segundo
usado pelo addon para processar data.

O jogo precisa entregar um
frame a cada |cFFFFFF0016ms|r, qualquer delay causa
uma perda de FPS.]=]
L["STRING_LISTPANEL_AVERAGE_DESC_TITLE"] = "Média de Tempo Gasto"
L["STRING_LISTPANEL_MS"] = "Milésimos"
L["STRING_LISTPANEL_MS_DESC"] = "Média de tempo usada a cada segundo."
L["STRING_LISTPANEL_PEAK"] = "Pico"
L["STRING_LISTPANEL_PEAK_DESC"] = "Maior uso enquanto a captura estava sendo feita."
L["STRING_LISTPANEL_PERCENT"] = "Porcentagem"
L["STRING_LISTPANEL_TOTAL"] = "Total:"
L["STRING_LISTPANEL_TOTAL_DESC"] = [=[Quantidade de tempo onde o jogo ficou congelado
para processar informações de addons.

Esta quantidade é distribuída dentre
cada frame processado.]=]
L["STRING_LISTPANEL_TOTAL_DESC_TITLE"] = "Tempo Total Usado"
L["STRING_LISTPANEL_TOTALUSAGE"] = "Total Usado"
L["STRING_LISTPANEL_TOTALUSAGE_DESC"] = [=[Total de tempo em segundos usado pelo
addon para processar informações.]=]
L["STRING_NO_INTENDED"] = "Não queria? |cFFFF7700Clique aqui|r"
L["STRING_OPTIONS_GATHERTIME"] = "Tempo de Captura"
L["STRING_OPTIONS_GATHERTIME_DESC"] = "Tempo para ficar capturando dados de Cpu dos addons."
L["STRING_OPTIONS_MINIMAP"] = "Ícone no Minimapa"
L["STRING_OPTIONS_MINIMAP_DESC"] = "Mostra ou esconde o ícone no minimapa."
L["STRING_OPTIONS_STARTDELAY"] = "Delay de Início"
L["STRING_OPTIONS_STARTDELAY_DESC"] = "Quando uma luta contra um feche de raide for iniciada, esperar X segundos antes de iniciar a captura."
L["STRING_PROFILE_DISABLED"] = "O jogo não esta capturando uso de CPU (requerido por este addon). Clique no botão ao lado para ligar a captura:"
L["STRING_PROFILE_ENABLED"] = "O jogo esta com a captura de CPU ligada! O addon está pronto para uso."
L["STRING_PROFILE_START"] = "Ligar Captura"
L["STRING_PROFILE_STOP"] = "Desligar"
L["STRING_SWITCH_SHOWGRAPHIC"] = "Mostrar Gráfico"
L["STRING_SWITCH_SHOWLIST"] = "Mostrar Lista"
L["STRING_TUTORIAL_LINE_1"] = "|cFFFFFFFF2|r) Verifique se a Captura de Cpu esta ligada (indicado na parte de baixo da janela)."
L["STRING_TUTORIAL_LINE_2"] = "|cFFFFFFFF3|r) Se não estiver, ligue-a clicando no botão 'Ligar Captura'."
L["STRING_TUTORIAL_LINE_3"] = "|cFFFFFFFF1|r) Entre em uma raide (pode ser Localizador de Raides)."
L["STRING_TUTORIAL_LINE_4"] = [=[|cFFFFFFFF4|r) Jogue normalmente um encontro com um boss por pelo menos 2 minutos.
Após a luta com o boss ter sido iniciada, você verá um indicador de captura de CPU.]=]
L["STRING_TUTORIAL_LINE_5"] = "|cFFFFFFFF5|r) No final no encontro, o painel com os resultados da captura é mostrado."
L["STRING_TUTORIAL_LINE_6"] = [=[

|cFFFFFFFFImportante:|r) Quando terminar com os testes de performance, desative a Captura de CPU clicando no botão 'Desligar', no canto inferior direito da janela.]=]
L["STRING_TUTORIAL_TITLE"] = "Sega estes passos:"

