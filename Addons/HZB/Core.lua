local HZB_F=nil
local HZB_RUN=nil
local INITIALIZE=false


SLASH_HZB1 = "/hzb"
SlashCmdList["HZB"] = function()
	HZB_INIT()
end






local TEMP_F=CreateFrame("frame")
TEMP_F:SetScript("OnUpdate",function()

	local Spec = GetSpecialization()
	local _, SpecName = GetSpecializationInfo(Spec)
	if INITIALIZE then
		TEMP_F:SetScript("OnUpdate",nil)
		return
	end
	if HZB_HAS() then
		HZB_INIT()
	else
		showMsg("加载失败,请检查是否存在装备方案“"..SpecName.."单体(团本)”,“"..SpecName.."单体”,“"..SpecName.."AOE”")
	end
	INITIALIZE=true
end)




function HZB_INIT()
	if HZB_F==nil then
		HZB_F=CreateFrame("frame")
	end


	
	
	local T=0
	
	local Spec = GetSpecialization()
	local _, SpecName = GetSpecializationInfo(Spec)
	UseEquipmentSet(SpecName.."单体")
	
	local TIMER=function()

		
	
	
		local t=GetTime()
		if t-T>1 then
		    HZB_RUN()
			T=t
		end
	end
	
	local HZB_X=function()
		if InCombatLockdown() then
			return
		end
		if UnitIsFriend("player", "target") then
			return
		end 
		--if UnitCanAttack("target","player")==false then
			--return
		--end
		
		local currentSpec = GetSpecialization()
		local _, currentSpecName = GetSpecializationInfo(currentSpec)
		
		local level=UnitLevel("target")
		if IsInRaid() or IsPartyLFG() then 
			HZB_UseEquipmentSet(currentSpecName.."单体(团本)")
		elseif (level and level < 0) or (level and level == 112) or UnitIsPVP("target") then
			HZB_UseEquipmentSet(currentSpecName.."单体")
		else
			HZB_UseEquipmentSet(currentSpecName.."AOE")
		end
		
	end
	

	if HZB_RUN==nil then
		showMsg("开启 自动换装")
		HZB_RUN=HZB_X
	else 
		showMsg("关闭 自动换装")
		TIMER=nil
		HZB_RUN=nil
	end

	HZB_F:SetScript("OnUpdate",TIMER)
	
end
local INDEX_EQUIP=nil
function HZB_UseEquipmentSet(name)
	if INDEX_EQUIP==nil then
		local currentSpec = GetSpecialization()
		local _, currentSpecName = GetSpecializationInfo(currentSpec)
		INDEX_EQUIP=currentSpecName.."单体"
	end
	if INDEX_EQUIP ~= name then
		UseEquipmentSet(name)
		INDEX_EQUIP=name
		showMsg("切换装备 ["..INDEX_EQUIP.."]")
		return true
	end
	return false
end
function showMsg(msg)
	local hour, minute = GetGameTime()
	if hour<10 then
		hour="0"..hour
	end
	if minute<10 then
		minute="0"..minute
	end
	print("|cFF00D1FF["..hour..":"..minute.."][自动换装]|r"..msg)
end 
function HZB_HAS()
		local currentSpec = GetSpecialization()
		local _, currentSpecName = GetSpecializationInfo(currentSpec)
		
	local count=0
	for i=1,GetNumEquipmentSets(),1 do
		local name, icon, setID, isEquipped, numItems, numEquipped, numInventory, numMissing, numIgnored = GetEquipmentSetInfo(i)
		if name==currentSpecName.."AOE" or name==currentSpecName.."单体" or name==currentSpecName.."单体(团本)" then 
			count=count+1
		end
		
	end
	if count>2 then 
		return true
	end 
	return false
end

