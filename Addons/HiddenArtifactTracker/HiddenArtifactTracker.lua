HiddenArtifactTracker ={}  			--options
HiddenArtifactTracker.active = true;		--turn the addon on/off
HiddenArtifactTracker.colourOptions = true;	--colour tooltip text; false to make all addon text white
HiddenArtifactTracker.advTracking = true;	--extra tracking for artifact specific unlock criteria; false to hide

local arti_names = {
	["Maw of the Damned"]=43646,
	["Blades of the Fallen Prince"]=43647,
	["Apocalypse"]=43648,
	["Twinblades of the Deceiver"]=43649,
	["Aldrachi Warblades"]=43650, 
	["Scythe of Elune"]=43651,
	["Fangs of Ashamane"]=43652,
	["Claws of Ursoc"]=43653,
	["G'Hanir, the Mother Tree"]=43654,
	["Titanstrike"]=43655,
	["Thas'dorah, Legacy of the Windrunners"]=43656,
	["Talonclaw"]=43657,
	["Aluneth"]=43658,
	["Felo'melorn"]=43659,
		["Heart of the Phoenix"]=43659,
	["Ebonchill"]=43660,
	["Fu Zan, the Wanderer's Companion"]=43661,
	["Sheilun, Staff of the Mists"]=43662,
	["Fists of the Heavens"]=43663,
	["The Silver Hand"]=43664,
	["Truthguard"]=43665,
		["Oathseeker"]=43665,
	["Ashbringer"]=43666,
	["Light's Wrath"]=43667,
	["T'uure, Beacon of the Naaru"]=43668,
	["Xal'atath, Blade of the Black Empire"]=43669,
		["Secrets of the Void"]=43669,
	["The Kingslayers"]=43670,
	["The Dreadblades"]=43671,
	["Fangs of the Devourer"]=43672,
	["The Fist of Ra-den"]=43673,
		["The Highkeeper's Ward"]=43673,
	["Doomhammer"]=43674,
		["Fury of the Stonemother"]=43674,
	["Sharas'dal, Scepter of Tides"]=43675,
		["Shield of the Sea Queen"]=43675,
	["Ulthalesh, the Deadwind Harvester"]=43676,
	["Skull of the Man'ari"]=43677,
		["Spine of Thal'kiel"]=43677,
	["Scepter of Sargeras"]=43678,
	["Strom'kar, the Warbreaker"]=43679,
	["Warswords of the Valarjar"]=43680,
	["Scale of the Earth-Warder"]=43681,
		["Scaleshard"]=43681
}

SLASH_HIDDENAT1 = '/hat'
function SlashCmdList.HIDDENAT(msg, editbox)
	if msg=="on" then
		HiddenArtifactTracker.active = true
	elseif msg=="off" then
		HiddenArtifactTracker.active = false
	elseif msg=="colour" or msg=="color" then
		HiddenArtifactTracker.colourOptions = not HiddenArtifactTracker.colourOptions
	elseif msg=="adv" then
		HiddenArtifactTracker.advTracking = not HiddenArtifactTracker.advTracking
	else
		print("Usage: /hat <option> where option is:\noff - deactivate\non - enable\nadv - toggle advanced tracking\ncolour - toggle coloured/white text")
	end
end

local handler = GameTooltip:GetScript("OnTooltipSetItem")
GameTooltip:SetScript("OnTooltipSetItem",

	function(...)

		--default tooltip behaviours
		handler(...)

		-- artifact specific additional text
		local name = GameTooltip:GetItem()
		if HiddenArtifactTracker.active and arti_names[name] then

			-- Advanced tracking for unlocking base appearance (only for supported artifacts [WIP])
			if HiddenArtifactTracker.advTracking and not IsQuestFlaggedCompleted(arti_names[name]) and HiddenArtifactTrackerFuncs[name] then
				HiddenArtifactTrackerFuncs[name]()
			end

			-- tracking for tint unlocks if base appearance is unlocked
			if IsQuestFlaggedCompleted(arti_names[name]) then

				-- Check additional tint criteria
				local k=GetAchievementCriteriaInfo
				local x,b; local a=0
				for i=1,11 do 
					_,_,_,x,b = k(11152,i)
					a=a+x
				end
				local _,_,_,c, d = k(11153,1)
				local _,_,_,e, f = k(11154,1)
		
				local n_once="\n"

				if a~=b then
					if HiddenArtifactTracker.colourOptions then
						GameTooltip:AddLine(n_once.."Dungeons:"..a.."/"..b,math.min(1,2-(2*a/b)),math.min(1,2*a/b),0,True)
					else
						GameTooltip:AddLine(n_once.."Dungeons:"..a.."/"..b,1,1,1,True)
					end
					n_once=""
				end
				if c~=d then
					if HiddenArtifactTracker.colourOptions then
						GameTooltip:AddLine(n_once.."World Quests: "..c.."/"..d,math.min(1,2-(2*c/d)),2*c/d,0,True)
					else
						GameTooltip:AddLine(n_once.."World Quests: "..c.."/"..d,1,1,1,True)
					end
					n_once=""
				end
				if e~=f then
					if HiddenArtifactTracker.colourOptions then
						GameTooltip:AddLine(n_once.."PvP: "..e.."/"..f,math.min(1,2-(2*e/f)),2*e/f,0,True)
					else
						GameTooltip:AddLine(n_once.."PvP: "..e.."/"..f,1,1,1,True)
					end
					n_once=""
				end
			end

			-- force tooltip to resize itself
			GameTooltip:Show()
		end
	end

)