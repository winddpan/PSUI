local L = LibStub("AceLocale-3.0"):NewLocale("EnemyGrid", "koKR") 
if not L then return end 

L["S_AGGROCOLORS"] = "위협 수준 별 색상"
L["S_AGGROCOLORS_DPS_AGGRO"] = "[공격 전담] 위협 수준 획득 색상"
L["S_AGGROCOLORS_DPS_AGGRO_DESC"] = "자신이 공격 전담 (또는 치유 전담)이면서 위협 수준을 획득했을 때 이름표를 이 색상으로 칠합니다."
L["S_AGGROCOLORS_DPS_HIGHAGGRO"] = "[공격 전담] 높은 위협 수준 색상"
L["S_AGGROCOLORS_DPS_HIGHAGGRO_DESC"] = "위협 수준 획득에 거의 근접했을 때."
L["S_AGGROCOLORS_DPS_NOAGGRO"] = "[공격 전담] 위협 수준 없음 색상"
L["S_AGGROCOLORS_DPS_NOAGGRO_DESC"] = "자신이 공격 전담 (또는 치유 전담)이면서 몹이 자신을 공격하지 않을 때."
L["S_AGGROCOLORS_TANK_AGGRO"] = "[방어 전담] 위협 수준 획득 색상"
L["S_AGGROCOLORS_TANK_AGGRO_DESC"] = "자신이 방어 전담이면서 위협 수준을 가졌을 때."
L["S_AGGROCOLORS_TANK_HIGHAGGRO"] = "[방어 전담] 높은 위협 수준 색상"
L["S_AGGROCOLORS_TANK_HIGHAGGRO_DESC"] = "다른 방어 전담이나 그룹원이 위협 수준 획득에 거의 근접했을 때."
L["S_AGGROCOLORS_TANK_NOAGGRO"] = "[방어 전담] 위협 수준 없음 색상"
L["S_AGGROCOLORS_TANK_NOAGGRO_DESC"] = "자신이 방어 전담이고 몹이 자신을 공격하지 않을 때."
L["S_AGGROCOLORS_TANK_NOCOMBAT"] = "[방어 전담] 비 전투 중 색상"
L["S_AGGROCOLORS_TANK_NOCOMBAT_DESC"] = "자신이 전투 중일 때 적이 자신이나 그룹원과 전투 중이지 않을 때."
L["S_ALPHA"] = "투명도"
L["S_ALWAYSSHOWDEBUFFS"] = "약화 효과 항상 표시"
L["S_ALWAYSSHOWDEBUFFS_DESC"] = "수동 오라 추적을 사용할 때만 작동합니다."
L["S_ANCHOR"] = "고정 위치"
L["S_ANCHOR_TOOLTIP"] = [=[|cFFFFFF00오른쪽 클릭|r 또는 '|cFFFFFF00/enemygrid|r'로 설정합니다.
설정에서 프레임을 잠글 수 있습니다.]=]
L["S_APPLY"] = "적용"
L["S_BACKGROUNDCOLOR"] = "배경 색상"
L["S_BORDERCOLOR"] = "테두리 색상"
L["S_CASTBAR_APPEARANCE"] = "시전 바 외형"
L["S_CASTBAR_NONINTERRUPT_COLOR"] = "차단 불가 색상"
L["S_CASTBAR_TEXT"] = "시전 바 문자"
L["S_CLASSCOLOR"] = "직업 색상"
L["S_COLOR"] = "색상"
L["S_DEBUFFCONFIG"] = "약화 효과 설정"
L["S_ENABLED"] = "사용"
L["S_ENEMY"] = "적"
L["S_FACTION"] = "진영"
L["S_FONT"] = "글꼴"
L["S_FRAMESTRATA"] = "프레임 우선 순위"
L["S_FRAMESTRATA_DESC"] = "인터페이스 상에서 프레임의 우선 순위를 설정합니다."
L["S_FRIENDLY"] = "우호적"
L["S_GROWDIRECTION"] = "성장 방향"
L["S_GROWDIRECTION_BOTTOM_TOP"] = "아래에서 위로"
L["S_GROWDIRECTION_TOP_BOTTOM"] = "위에서 아래로"
L["S_HEALTHBAR_APPEARANCE"] = "생명력 바 외형"
L["S_HEALTHBAR_TEXT"] = "생명력 바 문자"
L["S_HEALTHPERCENT_TEXT"] = "생명력 백분율 문자"
L["S_HEIGHT"] = "높이"
L["S_INBOSS"] = "우두머리 전투 중"
L["S_INBOSS_DESC"] = "우두머리 전투 중일 때만 창을 표시합니다."
L["S_INCOMBAT"] = "전투 중"
L["S_INCOMBAT_DESC"] = "전투 중일 때만 창을 표시합니다."
L["S_INDICATORS"] = "지시기"
L["S_ININSTANCE"] = "인스턴스 내부"
L["S_ININSTANCE_DESC"] = "인스턴스 안에 있을 때만 창을 표시합니다."
L["S_LAYOUT"] = "배치"
L["S_LEFT"] = "왼쪽"
L["S_LENGTH"] = "길이"
L["S_LOCKED"] = "잠금"
L["S_LOCKED_DESC"] = "프레임을 움직일 수 없습니다."
L["S_MAXTARGETS"] = "대상 최대 수"
L["S_MAXTARGETS_DESC"] = "동시에 표시할 적의 숫자를 설정합니다."
L["S_MENU_BARSCONFIG"] = "생명력 & 시전 바"
L["S_MENU_DEBUFFCONFIG"] = "약화 효과 설정"
L["S_MENU_KEYBINDS"] = "단축키 설정"
L["S_MENU_MAINPANEL"] = "일반 설정"
L["S_NAMEPLATE_DISTANCE"] = "이름표 거리"
L["S_NAMEPLATE_DISTANCE_DESC"] = "이름표를 볼 수 있는 거리를 설정합니다.\\n\\n|cFFFFFF00중요:|r 이 설정은 클라이언트에 적용되며 다른 애드온이 변경할 수 있습니다."
L["S_NAMEPLATE_DISTANCE_NOCOMBAT"] = "전투 중엔 변경할 수 없습니다."
L["S_NEUTRAL"] = "중립"
L["S_NPCCOLOR"] = "Npc 색상"
L["S_ONLYSHOWWHEN"] = "다음에만 표시하기"
L["S_OPTIONSDENY_REASON_INCOMBAT"] = "전투 중엔 창을 설정할 수 없습니다."
L["S_PADDING_HORIZONTAL"] = "수평 간격"
L["S_PADDING_HORIZONTAL_DESC"] = "프레임 간 수평 간격의 넓이를 설정합니다."
L["S_PADDING_VERTICAL"] = "수직 간격"
L["S_PADDING_VERTICAL_DESC"] = "프레임 간 수직 간격의 넓이를 설정합니다."
L["S_PRESETWIZARD"] = "설정 마법사"
L["S_PRESETWIZARD_DESC"] = "처음 시작 화면을 다시 엽니다."
L["S_PROFILES"] = "프로필"
L["S_QUESTCOLOR"] = "퀘스트 색상"
L["S_RAIDMARKS"] = "공격대 전술 아이콘"
L["S_RANGEALPHA"] = "거리 투명도"
L["S_RANGEALPHA_DESC"] = "유닛이 거리를 벗어났을 때."
L["S_RANGECHECK"] = "거리 확인"
L["S_RIGHT"] = "오른쪽"
L["S_ROWS"] = "줄"
L["S_ROWS_DESC"] = "줄의 수."
L["S_SCALE"] = "크기"
L["S_SHADOW"] = "그림자"
L["S_SHOWTAB"] = "탭 표시"
L["S_SHOWTAB_DESC"] = "고정 위치 탭 표시 여부."
L["S_SHOWTIMER"] = "타이머 표시"
L["S_SHOWTIMER_DESC"] = "강화 효과나 약화 효과의 남은 시간."
L["S_SHOWTITLE"] = "제목 표시"
L["S_SHOWTOOLTIP"] = "오라 툴팁 표시"
L["S_SIZE"] = "크기"
L["S_SPECBAN"] = "전문화"
L["S_SPECBAN_TOOLTIP"] = "이 전문화일 때 Enemy Grid를 활성화합니다."
L["S_TEXT"] = "문자"
L["S_TEXTURE"] = "무늬"
L["S_TEXTUREBACKGROUND"] = "배경 무늬"
L["S_UNIT_ENEMY"] = "적대적 유닛"
L["S_UNIT_FRIENDLY"] = "우호적 유닛"
L["S_WIDTH"] = "넓이"
L["S_XOFFSET"] = "X 좌표"
L["S_YOFFSET"] = "Y 좌표"
