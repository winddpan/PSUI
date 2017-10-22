-- Contributors: WetU@GitHub, yuk6196@Curse

local _, addonTable = ...
local L = addonTable.L

-- Lua
local _G = getfenv(0)

if _G.GetLocale() ~= "koKR" then return end

L["ANCHOR"] = "알림창 고정기"
L["ANCHOR_FRAME"] = "고정기 창"
L["BORDER"] = "테두리"
L["COLORS"] = "색상"
L["COPPER_THRESHOLD"] = "코퍼 제한"
L["COPPER_THRESHOLD_DESC"] = "알림창을 만들 최소 코퍼 금액입니다."
L["DND"] = "대기"
L["DND_TOOLTIP"] = "대기 모드의 알림창은 전투 중에 표시되지 않고, 대신 시스템 내부에 대기하게 됩니다. 전투에서 벗어나면 대기 중이던 알림이 나타나기 시작합니다."
L["FADE_OUT_DELAY"] = "페이드 아웃 지연 시간"
L["GROWTH_DIR"] = "성장 방향"
L["GROWTH_DIR_DOWN"] = "아래로"
L["GROWTH_DIR_LEFT"] = "왼쪽으로"
L["GROWTH_DIR_RIGHT"] = "오른쪽으로"
L["GROWTH_DIR_UP"] = "위로"
L["ICON_BORDER"] = "아이콘 테두리"
L["NAME"] = "이름"
L["OPEN_CONFIG"] = "설정 열기"
L["SCALE"] = "크기 비율"
L["SETTINGS_TYPE_LABEL"] = "알림창 종류"
L["SHOW_ILVL"] = "아이템 레벨 표시"
L["SHOW_ILVL_DESC"] = "아이템 이름 옆에 아이템 레벨을 표시합니다."
L["SHOW_QUEST_ITEMS"] = "퀘스트 아이템 표시"
L["SHOW_QUEST_ITEMS_DESC"] = "등급에 상관없이 퀘스트 아이템을 표시합니다."
L["SKIN"] = "스킨"
L["STRATA"] = "우선순위"
L["TEST"] = "테스트"
L["TEST_ALL"] = "모두 테스트"
L["TOAST_NUM"] = "알림창의 갯수"
L["TRANSMOG_ADDED"] = "형상이 추가되었습니다"
L["TRANSMOG_REMOVED"] = "형상이 제거되었습니다"
L["TYPE_ACHIEVEMENT"] = "업적"
L["TYPE_ARCHAEOLOGY"] = "고고학"
L["TYPE_CLASS_HALL"] = "직업 전당"
L["TYPE_COLLECTION"] = "수집품"
L["TYPE_COLLECTION_DESC"] = "새로 수집한 탈것, 애완동물과 장난감의 알림창입니다."
L["TYPE_DUNGEON"] = "던전"
L["TYPE_GARRISON"] = "주둔지"
L["TYPE_LOOT_COMMON"] = "전리품 (일반)"
L["TYPE_LOOT_COMMON_DESC"] = "알림창이 대화 이벤트에 의해 발생됩니다, 즉. 특별 전리품 알림창이 처리하지 않는 모든 고급, 희귀, 몇몇 영웅 전리품입니다."
L["TYPE_LOOT_CURRENCY"] = "전리품 (화폐)"
L["TYPE_LOOT_GOLD"] = "전리품 (골드)"
L["TYPE_LOOT_SPECIAL"] = "전리품 (특별)"
L["TYPE_LOOT_SPECIAL_DESC"] = "알림창이 특별 전리품 이벤트에 의해 발생됩니다, 즉. 주사위 우승, 전설 획득, 개인 획득 등입니다."
L["TYPE_RECIPE"] = "제조법"
L["TYPE_TRANSMOG"] = "형상변환"
L["TYPE_WORLD_QUEST"] = "전역 퀘스트"

