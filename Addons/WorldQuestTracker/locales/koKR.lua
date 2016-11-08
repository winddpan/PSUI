local L = LibStub("AceLocale-3.0"):NewLocale("WorldQuestTrackerAddon", "koKR") 
if not L then return end 

L["S_APOWER_AVAILABLE"] = "획득 가능"
L["S_APOWER_DOWNVALUE"] = "%s|1으로;로; 표시된 퀘스트는 현재 유물 연구보다 더 긴 시간을 가집니다."
L["S_APOWER_NEXTLEVEL"] = "다음 등급"
L["S_ENABLED"] = "사용"
L["S_ERROR_NOTIMELEFT"] = "이 퀘스트는 만료되었습니다."
L["S_ERROR_NOTLOADEDYET"] = "이 퀘스트를 아직 불러오지 못했습니다, 몇 초만 기다려주세요."
L["S_FLYMAP_SHOWTRACKEDONLY"] = "추적 중인 퀘스트만"
L["S_FLYMAP_SHOWTRACKEDONLY_DESC"] = "추적 중인 퀘스트만 표시"
L["S_FLYMAP_SHOWWORLDQUESTS"] = "전역 퀘스트 표시"
L["S_MAPBAR_AUTOWORLDMAP"] = "자동 세계 지도"
L["S_MAPBAR_AUTOWORLDMAP_DESC"] = [=[달라란이나 직업 전당에 있을 때, 'M' 키를 누르면 바로 부서진 섬 지도를 표시합니다.

'M' 키를 두번 누르면 현재 있는 지역의 지도를 표시합니다.]=]
L["S_MAPBAR_FILTER"] = "선별"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES"] = "사절 퀘스트"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES_DESC"] = "선별하도록 설정하지 않은 퀘스트라도 사절 퀘스트에 포함되면 표시합니다."
L["S_MAPBAR_OPTIONS"] = "옵션"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED"] = "화살표 갱신 속도"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_HIGH"] = "빠름"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_MEDIUM"] = "보통"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_REALTIME"] = "실시간"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_SLOW"] = "느림"
L["S_MAPBAR_OPTIONSMENU_QUESTTRACKER"] = "퀘스트 추적기 사용"
L["S_MAPBAR_OPTIONSMENU_REFRESH"] = "새로 고침"
L["S_MAPBAR_OPTIONSMENU_SHARE"] = "이 애드온 공유"
L["S_MAPBAR_OPTIONSMENU_SOUNDENABLED"] = "소리 사용"
L["S_MAPBAR_OPTIONSMENU_STATUSBARANCHOR"] = "상단에 고정"
L["S_MAPBAR_OPTIONSMENU_TOMTOM_WPPERSISTENT"] = "목표 지점 유지"
L["S_MAPBAR_OPTIONSMENU_TRACKERCONFIG"] = "추적기 설정"
L["S_MAPBAR_OPTIONSMENU_TRACKER_CURRENTZONE"] = "현재 지역만"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_AUTO"] = "자동 위치"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_CUSTOM"] = "위치 사용자 설정"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_LOCKED"] = "잠금"
L["S_MAPBAR_OPTIONSMENU_TRACKER_SCALE"] = "추적기 크기비율: %s"
L["S_MAPBAR_OPTIONSMENU_UNTRACKQUESTS"] = "모든 퀘스트 추적 해제"
L["S_MAPBAR_OPTIONSMENU_WORLDMAPCONFIG"] = "세계 지도 설정"
L["S_MAPBAR_OPTIONSMENU_YARDSDISTANCE"] = "미터 거리 표시"
L["S_MAPBAR_OPTIONSMENU_ZONEMAPCONFIG"] = "지역 지도 설정"
L["S_MAPBAR_OPTIONSMENU_ZONE_QUESTSUMMARY"] = "퀘스트 요약 (전체 화면)"
L["S_MAPBAR_RESOURCES_TOOLTIP_TRACKALL"] = "모두 추적하려면 클릭: |cFFFFFFFF%s|r 퀘스트."
L["S_MAPBAR_SORTORDER"] = "정렬 순서"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_FADE"] = "퀘스트 흐릿하게"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_OPTION"] = "%d시간 미만"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SHOWTEXT"] = "남은 시간 문자"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SORTBYTIME"] = "시간 별 정렬"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_TITLE"] = "남은 시간"
L["S_MAPBAR_SUMMARY"] = "요약"
L["S_MAPBAR_SUMMARYMENU_ACCOUNTWIDE"] = "모든 계정"
L["S_MAPBAR_SUMMARYMENU_MOREINFO"] = "추가 정보를 위해 클릭하세요"
L["S_MAPBAR_SUMMARYMENU_NOATTENTION"] = [=[다른 캐릭터에 추적 중인 퀘스트 중
2시간 내에 만료되는 퀘스트가 없습니다!]=]
L["S_MAPBAR_SUMMARYMENU_REQUIREATTENTION"] = "주의 필요"
L["S_MAPBAR_SUMMARYMENU_TODAYREWARDS"] = "오늘의 보상"
L["S_OVERALL"] = "종합"
L["S_PARTY"] = "파티"
L["S_PARTY_DESC1"] = "파란색 별이 표시된 퀘스트는 모든 파티원이 수행 중이라는 의미입니다."
L["S_PARTY_DESC2"] = "파티원이 전역 퀘스트를 수행할 수 없거나 WQT를 설치하지 않았으면 붉은색 별이 표시됩니다."
L["S_PARTY_PLAYERSWITH"] = "WQT를 사용 중인 파티원:"
L["S_PARTY_PLAYERSWITHOUT"] = "WQT를 사용 하지 않는 파티원:"
L["S_QUESTSCOMPLETED"] = "퀘스트 완료"
L["S_QUESTTYPE_ARTIFACTPOWER"] = "유물력"
L["S_QUESTTYPE_DUNGEON"] = "던전"
L["S_QUESTTYPE_EQUIPMENT"] = "장비"
L["S_QUESTTYPE_GOLD"] = "골드"
L["S_QUESTTYPE_PETBATTLE"] = "애완동물 대전"
L["S_QUESTTYPE_PROFESSION"] = "전문 기술"
L["S_QUESTTYPE_PVP"] = "PvP"
L["S_QUESTTYPE_RESOURCE"] = "자원"
L["S_QUESTTYPE_TRADESKILL"] = "직업용품"
L["S_SHAREPANEL_THANKS"] = [=[World Quest Tracker를 공유해주셔서 감사합니다!
링크를 페이스북, 트위터의 친구들에게 전송하세요.]=]
L["S_SHAREPANEL_TITLE"] = "For All Those About to Rock!"
L["S_SUMMARYPANEL_EXPIRED"] = "만료"
L["S_SUMMARYPANEL_LAST15DAYS"] = "최근 15일"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_ACCOUNT"] = "계정 전체 시간 통계"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_CHARACTER"] = "캐릭터 전체 시간 통계"
L["S_SUMMARYPANEL_OTHERCHARACTERS"] = "다른 캐릭터"
L["S_TUTORIAL_AMOUNT"] = "받을 수 있는 보상의 양을 나타냅니다"
L["S_TUTORIAL_CLICKTOTRACK"] = "퀘스트를 추적하려면 클릭하세요."
L["S_TUTORIAL_CLOSE"] = "기본 설명서 닫기"
L["S_TUTORIAL_FACTIONBOUNTY"] = "사절 퀘스트 여부를 나타냅니다."
L["S_TUTORIAL_FACTIONBOUNTY_AMOUNTQUESTS"] = "지도에 선택된 진영의 퀘스트가 몇개 있는 지 나타냅니다."
L["S_TUTORIAL_HOWTOADDTRACKER"] = "퀘스트를 추적하려면 클릭하세요. 추적 해제하려면 추적기에서 |cFFFFFFFF오른쪽 클릭|r하세요."
L["S_TUTORIAL_PARTY"] = "파티 중일 때, 모든 파티원이 수행 중인 퀘스트에 파란색 별이 표시됩니다!"
L["S_TUTORIAL_RARITY"] = "등급을 나타냅니다 (일반, 희귀, 영웅)"
L["S_TUTORIAL_REWARD"] = "보상 종류를 나타냅니다 (장비, 골드, 유물력, 자원, 재료)"
L["S_TUTORIAL_TIMELEFT"] = "남은 시간을 나타냅니다 (+4시간, +90분, +30분, 30분 미만)"
L["S_TUTORIAL_WORLDMAPBUTTON"] = "이 버튼을 누르면 부서진 섬 지도로 변경됩니다."
L["S_UNKNOWNQUEST"] = "알 수 없는 퀘스트"
L["S_WORLDQUESTS"] = "전역 퀘스트"
