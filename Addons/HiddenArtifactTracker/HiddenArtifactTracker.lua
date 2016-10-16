--Translate by Adavak@斯坦索姆-CN
--Source from: https://wow.curseforge.com/addons/hiddenartifacttracker/

local arti_names = {
["奥达奇战刃"]=true, 
["诅咒之喉"]=true,
["寒冰使者"]=true,
["掠霜使者"]=true,
["天启"]=true,
["维鲁斯"]=true,
["穆拉玛斯"]=true,
["月神镰刀"]=true,
["阿莎曼之牙"]=true,
["乌索克之爪"]=true,
["加尼尔，母亲之树"]=true,
["泰坦之击"]=true,
["萨斯多拉，风行者的遗产"]=true,
["雄鹰之爪"]=true,
["艾露尼斯"]=true,
["烈焰之击"]=true,
["凤凰之心"]=true,
["黑檀之寒"]=true,
["福枬，云游者之友"]=true,
["神龙，迷雾之杖"]=true,
["阿布尔克"]=true,
["奥拉艾德"]=true,
["白银之手"]=true,
["真理守护者"]=true,
["誓言践行者"]=true,
["灰烬使者"]=true,
["圣光之怒"]=true,
["图雷，纳鲁道标"]=true,
["萨拉塔斯，黑暗帝国之刃"]=true,
["虚空的秘密"]=true,
["痛楚"]=true,
["哀伤"]=true,
["命运"]=true,
["机遇"]=true,
["血牙"]=true,
["阿卡丽的意志"]=true,
["莱登之拳"]=true,
["至高守护者之盾"]=true,
["毁灭之锤"]=true,
["石母之怒"]=true,
["莎拉达尔，潮汐权杖"]=true,
["海底女王之盾"]=true,
["乌萨勒斯，逆风收割者"]=true,
["堕落者之颅"]=true,
["萨奇尔的脊椎"]=true,
["萨格拉斯权杖"]=true,
["斯多姆卡，灭战者"]=true,
["奥丁之怒"]=true,
["海拉之怒"]=true,
["大地守护者之鳞"]=true,
["碎鳞"]=true}


local handler = GameTooltip:GetScript("OnTooltipSetItem")
GameTooltip:SetScript("OnTooltipSetItem",

	function(...)
		handler(...)
		local name = GameTooltip:GetItem()
	
		if arti_names[name] then

		local k=GetAchievementCriteriaInfo
		local x,b; local a=0
		for i=1,11 do 
			_,_,_,x,b = k(11152,i)
			a=a+x
		end
		local _,_,_,c, d = k(11153,1)
		local _,_,_,e, f = k(11154,1)

		local prog
		if a~=0 and a~=b then
			prog = "\n地下城："..a.."/"..b
		end
		if c~=0 and c~=d then
			prog = prog.."\n世界任务："..c.."/"..d
		end
		if e~=0 and e~=f then
			prog = prog.."\nPvP："..e.."/"..f
		end


		GameTooltip:AddLine(prog,1,1,1,True)
		GameTooltip:Show()
		end
	end

)