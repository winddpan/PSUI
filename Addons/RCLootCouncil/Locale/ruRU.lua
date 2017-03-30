-- Translate RCLootCouncil to your language at:
-- http://wow.curseforge.com/addons/rclootcouncil/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("RCLootCouncil", "ruRU")
if not L then return end

L[" is not active in this raid."] = "не участвует в текущем рейде."
L[" you are now the Master Looter and RCLootCouncil is now handling looting."] = "вы теперь Ответственный за Добычу и RCLootCouncil теперь занимается распределением добычи."
L["Abort"] = "Сбросить"
L["Accept Whispers"] = "Принимать Личные сообщения"
L["add"] = "добавить"
L["Add Item"] = "Добавить Предмет"
L["Add Note"] = "Добавить Заметку"
L["Add ranks"] = "Добавить ранги"
L["add_ranks_desc"] = "Выберите минимальный ранг для участия в распределении добычи"
L["All items"] = "Все предметы"
L["All items has been awarded and  the loot session concluded"] = "Все предметы были распределены, распределение добычи завершено"
L["Always use RCLootCouncil when I'm Master Looter"] = "Всегда использовать RCLootCouncil, если вы назначены ответственным за распределение добычи"
L["Announce Awards"] = "Анонсировать Врученные предметы"
L["Anonymous Voting"] = "Анонимное Голосование"
L["anonymous_voting_desc"] = "Включить анонимное голосование (т.е. люди не видят кто за что проголосовал)"
L["Append realm names"] = "Добавлять названия игровых миров"
L["Are you sure you want to abort?"] = "Вы уверены, что хотите отменить?"
L["Are you sure you want to give #item to #player?"] = "Вы уверены, что хотите передать %s персонажу %s?"
L["Auto Award"] = "Автоматическое Вручение"
L["Auto Award to"] = "Автоматически Вручать"
L["auto_award_desc"] = "Включить автоматическое распределение"
L["auto_award_to_desc"] = "Игроки для автоматического распределения. Список игроков для выбора появляется если вы в рейдовой группе."
L["Autoloot BoE"] = "Автосбор ПпН-предметов"
L["Autopass"] = "Автопас"
L["Award Reasons"] = "Причина Вручения"
L["award_reasons_desc"] = [=[Причины вручения, которые не могут быть выбраны во время ролла.
Используется при изменении ответа в меню по правой кнопки мыши, и для автоматического вручения.]=]
L["Awards"] = "Награды"
L["Banking"] = "В банк"
L["Button"] = "Кнопка"
L["Candidate didn't respond on time"] = "Кандидат не ответил вовремя"
L["Candidate is selecting response, please wait"] = "Кандидат делает выбор, пожалуйста подождите"
L["Candidate removed"] = "Кандидат удален"
L["Changing loot threshold to enable Auto Awarding"] = "Измените порог распределения добычи, чтобы включить Автоматическое Вручение"
L["Changing LootMethod to Master Looting"] = "Разделение добычи производится по системе Ответственный за добычу."
L["config"] = "настройка"
L["council"] = "совет"
L["current_council_desc"] = "Нажмите, чтобы удалить определенных людей из совета"
L["days and x months"] = "%s и %d месяцев."
L["days, x months, y years"] = "%s, %d месяцев и %d лет."
L["Disenchant"] = "Распыление"
L["DPS"] = "УВС"
L["enable_loot_history_desc"] = "Включает ведение истории. RCLootCouncil не будет ничего записывать если отключено."
L["Free"] = "Бесплатно"
L["g1"] = "п1"
L["g2"] = "п2"
L["Greed"] = "Не откажусь"
L["group_council_members_desc"] = "Используйте это, чтобы добавить членов совета с другого сервера или гильдии."
L["group_council_members_head"] = "Добавить члена совета из текущей группы."
L["Healer"] = "Целитель"
L["help"] = "помощь"
L["Hide Votes"] = "Скрыть Голоса"
L["hide_votes_desc"] = "Только проголосовавшие игроки могут видеть результаты голосования"
L["history"] = "история"
L["ilvl"] = "илвл"
L["ilvl: x"] = "илвл: %d"
L["Items under consideration:"] = "Предметы, ожидающие рассмотрения:"
L["Loot announced, waiting for answer"] = "Добыча объявлена, ожидание ответа"
L["Lower Quality Limit"] = "Нижняя Граница Качества"
L["lower_quality_limit_desc"] = [=[Выберите нижний предел качества для автораспределения (это качество включается!).
Примечание: Это отменяет нормальный порог лута.]=]
L["Mainspec/Need"] = "Основной спек/Нужно"
L["Minor Upgrade"] = "Незначительное улучшение"
L["ML sees voting"] = "МЛ видит результаты голосования"
L["Multi Vote"] = "Множественное голосование"
L["Need"] = "Нужно"
L["No"] = "Нет"
L["None"] = "Никто"
L["Not announced"] = "Не анонсированно"
L["Number of reasons"] = "Количество причин"
L["Offline or RCLootCouncil not installed"] = "Вышел из сети или RCLootCouncil не установлен"
L["Offspec/Greed"] = "Оффспек/Не откажусь"
L["open"] = "открыть"
L["Pass"] = "Пас"
L["Reason"] = "Причина"
L["Reset to default"] = "Восстановить по умолчанию"
L["Self Vote"] = "Своё голосование"
L["Something went wrong :'("] = "Что-то пошло не так :'("
L["Start"] = "Начать"
L["Tank"] = "Танк"
L["Test"] = "Тест"
L["test"] = "тест"
L["Text color"] = "Цвет текста"
L["Text for reason #i"] = "Текст причины #"
L["The Master Looter doesn't allow multiple votes."] = "Ответственный за добычу не разрешил голосование за нескольких."
L["The Master Looter doesn't allow votes for yourself."] = "Ответственный за добычу не разрешил голосовать за себя."
L["This item"] = "Этот предмет"
L["This item has been awarded"] = "Этот предмет был вручен"
L["Unguilded"] = "Не в гильдии"
L["Upper Quality Limit"] = "Лимит улучшения качества"
L["version"] = "версия"
L["Version"] = "Версия"
L["Version Check"] = "Проверка версии"
L["version_check_desc"] = "Открытие модуля проверки версии аддона."
L["version_outdated_msg"] = "Ваша версия аддона %s устарела. Последняя версия %s , пожалуйста обновите RCLootCouncil."
L["Vote"] = "Голос"
L["Voters"] = "Голосующие"
L["Votes"] = "Голоса"
L["Voting options"] = "Опции голосования"
L["Waiting for item info"] = "Ожидание сведения о предмете"
L["Waiting for response"] = "Ожидание ответа"
L["whisper"] = "шепот"
L["whisper_help"] = [=[Рейдеры могут использовать систему личных сообщений, в случае если кто-то не имеет аддона.
Шепнув "rchelp" ответственному за добычу, они получат список ключевых слов, который может быть изменен в меню "Кнопки и Ответы".
Ответственному за добычу рекомендуется включить "Анонс Сообщений" для каждого предмета, потому что номер каждого предмета необходим для использования системы личных сообщений.
Примечание: Людям следует устанавливать аддон, в противном случае об игроке будет доступна не вся информация.]=]
L["whisperKey_greed"] = "не откажусь, оффспек, ос, 2"
L["whisperKey_minor"] = "минимальное улучшение, минимально, 3"
L["whisperKey_need"] = "нужно, мейнспек, мс, 1"
L["Windows reset"] = "Окна сброшены"
L["winners"] = "выигравшие"
L["x days"] = "%d дней"
L["Yell"] = "Крик"
L["Yes"] = "Да"
L["You are not allowed to see the Voting Frame right now."] = "Вы не можете видеть окно голования прямо сейчас."
L["You can only auto award items with a quality lower than 'quality' to yourself due to Blizaard restrictions"] = "Вы можете автоматически передавать себе только те предметы, качество которых ниже, чем %s , из-за ограничений, установленных разработчиками игры."
L["You cannot initiate a test while in a group without being the MasterLooter."] = "Вы не можете запустить тестовый режим в группе, не являясь ответственным за распределение добычи."
L["You cannot start an empty session."] = "Вы не можете начать \"пустую\" сессию распределения добычи."
L["You cannot use the menu when the session has ended."] = "Вы не можете использовать меню, если распределение добычи завершено."
L["You cannot use this command without being the Master Looter"] = "Вы не можете использовать эту команду, не будучи ответственным за распределение добычи"
L["You can't start a loot session while in combat."] = "Вы не можете запустить распределение добычи, находясь в бою."
L["You can't start a session before all items are loaded!"] = "Вы не можете начать распределение добычи, прежде чем будут загружены все предметы!"
L["Your note:"] = "Ваша заметка:"
L["You're already running a session."] = "Вы уже запустили сессию распределения добычи."
