-------------------------------------------------------------------------------
--
--  Mod Name : BlinkRogueHelper 3.0a
--  Author   : Blink
--  Date     : 2004/10/11
--  LastUpdate : 2008/10/16
--
-------------------------------------------------------------------------------

BRH_ComboSkill = 35;
BRH_FinishSkill = 30;
if BlinkRogueHelper_FontSizePixel == nil then
	BlinkRogueHelper_FontSizePixel = 38;
end

local Yajust = 80;
local PreviousCombo = 0;
local PreviousPower = 0;

function BlinkRogueHelperFrame_OnLoad()
	BlinkRogueHelperFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")

	BlinkRogueHelperFrame.fadeInTime = 0.2;		-- fade in time(sec)
	BlinkRogueHelperFrame.holdTime = 2;		-- hold time(sec)
	BlinkRogueHelperFrame.fadeOutTime = 0.8;		-- fade out time(sec)
	BlinkRogueHelperFrame.flowTime = BlinkRogueHelperFrame.fadeInTime + BlinkRogueHelperFrame.holdTime +BlinkRogueHelperFrame.fadeOutTime;
	BlinkRogueHelperFrame.PI = 3.141592;
	BlinkRogueHelperFrame:Hide();

	BlinkRogueHelper_Register();
	BubbleTextString:SetTextHeight(BlinkRogueHelper_FontSizePixel);
	BubbleTextString:SetFont("Interface\\AddOns\\BlinkRogueHelper\\Fonts\\font.ttf", BlinkRogueHelper_FontSizePixel, "OUTLINE");
	BlinkRogueHelper_Enabled = 0;
	
	if select(2, UnitClass("player")) == "ROGUE" then 
		BlinkRogueHelper_Enabled = 1;
	elseif select(2, UnitClass("player")) == "DRUID" then 
		BlinkRogueHelper_Enabled = 1;
	end
 
end

function BlinkRogueHelperFrame_OnEvent(event)
	if BlinkRogueHelper_Enabled == 1  and event == "UNIT_POWER_FREQUENT" then
		local mana = UnitPower("player", 3)
		local cp = UnitPower('player', 4)
		
		if(cp == 0) then
			PreviousCombo = 0
			BlinkRogueHelperFrame:Hide();
		elseif(cp ~= PreviousCombo or mana < PreviousPower) then
			if PreviousCombo - cp ~= 1 then -- 自然减少不跳出来
				SetBubbleTextColor();
				BlinkComboShow(cp);
			end
		end
		
		PreviousCombo = cp
		PreviousPower = mana;
	end
end

function BlinkRogueHelper_OnUpdate()
	if ( BlinkRogueHelper_Enabled == 1 ) then
		if( BlinkRogueHelper_Type == 2 ) then
			BlinkRogueHelper_Type2();
		elseif( BlinkRogueHelper_Type == 3 ) then
			BlinkRogueHelper_Type3();
		elseif( BlinkRogueHelper_Type == 4 ) then
			BlinkRogueHelper_Type4();
		elseif( BlinkRogueHelper_Type == 5 ) then
			BlinkRogueHelper_Type5();
		else	BlinkRogueHelper_Type1(); 
		end
	end
end


function BlinkRogueHelper_Type1()
	local elapsed = GetTime() - BlinkRogueHelperFrame.startTime;

	local fadeInTime = BlinkRogueHelperFrame.fadeInTime;
	if ( elapsed < fadeInTime ) then
		local alpha = (elapsed / fadeInTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		BubbleTextString:SetTextHeight(BlinkRogueHelper_FontSizePixel * alpha + 1);
		BlinkRogueHelperFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, BlinkRogueHelper_FontSizePixel*alpha+Yajust );
		return;
	end
	local holdTime = BlinkRogueHelperFrame.holdTime;
	if ( elapsed < (fadeInTime + holdTime) ) then
		BlinkRogueHelperFrame:SetAlpha(1.0);
		BubbleTextString:SetTextHeight(BlinkRogueHelper_FontSizePixel + 1);
		BlinkRogueHelperFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, BlinkRogueHelper_FontSizePixel+Yajust );
		return;
	end
	local fadeOutTime = BlinkRogueHelperFrame.fadeOutTime;
	if ( elapsed < (fadeInTime + holdTime + fadeOutTime) ) then
		local alpha = 1.0 - ((elapsed - holdTime - fadeInTime) / fadeOutTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		BubbleTextString:SetTextHeight(BlinkRogueHelper_FontSizePixel * alpha + 1);
		BlinkRogueHelperFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, BlinkRogueHelper_FontSizePixel*alpha+Yajust );
		return;
	end
	BlinkRogueHelperFrame:Hide();
end

function BlinkRogueHelper_Type2()
	local elapsed = GetTime() - BlinkRogueHelperFrame.startTime;
	local flowTime = elapsed / BlinkRogueHelperFrame.flowTime;
	BlinkRogueHelperFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, (BlinkRogueHelper_FontSizePixel*10)*flowTime-50 );

	local fadeInTime = BlinkRogueHelperFrame.fadeInTime;
	if ( elapsed < fadeInTime ) then
		local alpha = (elapsed / fadeInTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		return;
	end
	local holdTime = BlinkRogueHelperFrame.holdTime;
	if ( elapsed < (fadeInTime + holdTime) ) then
		BlinkRogueHelperFrame:SetAlpha(1.0);
		return;
	end
	local fadeOutTime = BlinkRogueHelperFrame.fadeOutTime;
	if ( elapsed < (fadeInTime + holdTime + fadeOutTime) ) then
		local alpha = 1.0 - ((elapsed - holdTime - fadeInTime) / fadeOutTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		return;
	end
	BlinkRogueHelperFrame:Hide();
end

function BlinkRogueHelper_Type3()
	local elapsed = GetTime() - BlinkRogueHelperFrame.startTime;
	local flowTime = elapsed / BlinkRogueHelperFrame.flowTime;
	local xpos = math.sin(BlinkRogueHelperFrame.PI*2*flowTime) * 40;

	BlinkRogueHelperFrame:SetPoint("CENTER", "UIParent", "CENTER", xpos, (BlinkRogueHelper_FontSizePixel*4)*flowTime-60 );

	local fadeInTime = BlinkRogueHelperFrame.fadeInTime;
	if ( elapsed < fadeInTime ) then
		local alpha = (elapsed / fadeInTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		return;
	end
	local holdTime = BlinkRogueHelperFrame.holdTime;
	if ( elapsed < (fadeInTime + holdTime) ) then
		BlinkRogueHelperFrame:SetAlpha(1.0);
		return;
	end
	local fadeOutTime = BlinkRogueHelperFrame.fadeOutTime;
	if ( elapsed < (fadeInTime + holdTime + fadeOutTime) ) then
		local alpha = 1.0 - ((elapsed - holdTime - fadeInTime) / fadeOutTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		return;
	end
	BlinkRogueHelperFrame:Hide();
end

function BlinkRogueHelper_Type4()
	local elapsed = GetTime() - BlinkRogueHelperFrame.startTime;
	local flowTime = elapsed / BlinkRogueHelperFrame.flowTime;
	local xpos = math.sin(BlinkRogueHelperFrame.PI*2*flowTime) * 40;

	BlinkRogueHelperFrame:SetPoint("CENTER", "UIParent", "CENTER", (BlinkRogueHelper_FontSizePixel*4)*flowTime-(BlinkRogueHelper_FontSizePixel*2), 60 );

	local fadeInTime = BlinkRogueHelperFrame.fadeInTime;
	if ( elapsed < fadeInTime ) then
		local alpha = (elapsed / fadeInTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		return;
	end
	local holdTime = BlinkRogueHelperFrame.holdTime;
	if ( elapsed < (fadeInTime + holdTime) ) then
		BlinkRogueHelperFrame:SetAlpha(1.0);
		return;
	end
	local fadeOutTime = BlinkRogueHelperFrame.fadeOutTime;
	if ( elapsed < (fadeInTime + holdTime + fadeOutTime) ) then
		local alpha = 1.0 - ((elapsed - holdTime - fadeInTime) / fadeOutTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		return;
	end
	BlinkRogueHelperFrame:Hide();
end

function BlinkRogueHelper_Type5()
	local elapsed = 1.75 * (GetTime() - BlinkRogueHelperFrame.startTime);
	local flowTime = elapsed / BlinkRogueHelperFrame.flowTime;
	local fadeInTime = BlinkRogueHelperFrame.fadeInTime;

	local scale = 1.25;
	local cos, sin, rand = math.cos, math.sin, math.random;
	local xshake, yshake, zshake = rand(-10,10), rand(-7,7), rand(-10,10);
	local xpos = xshake * sin(BlinkRogueHelperFrame.PI*2*8*flowTime);
	local ypos = yshake * sin(BlinkRogueHelperFrame.PI*2*5*flowTime+1.5);
	local zpos = zshake * sin(BlinkRogueHelperFrame.PI*2*flowTime);

	if ( elapsed < fadeInTime ) then
		local alpha = (elapsed / fadeInTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		BubbleTextString:SetTextHeight(BlinkRogueHelper_FontSizePixel * alpha * scale + 1);
		BlinkRogueHelperFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, BlinkRogueHelper_FontSizePixel*alpha * scale );
		return;
	end

	local holdTime = BlinkRogueHelperFrame.holdTime;
	if ( elapsed < (fadeInTime + holdTime) ) then
		BlinkRogueHelperFrame:SetAlpha(1.0);
		BubbleTextString:SetTextHeight( zpos + BlinkRogueHelper_FontSizePixel * scale  + 1);
		BlinkRogueHelperFrame:SetPoint("CENTER", "UIParent", "CENTER", xpos, ypos + BlinkRogueHelper_FontSizePixel * scale );
		return;
	end

	local fadeOutTime = 0.8 * BlinkRogueHelperFrame.fadeOutTime;
	if ( elapsed < (fadeInTime + holdTime + fadeOutTime) ) then
		local alpha = 1.0 - ((elapsed - holdTime - fadeInTime) / fadeOutTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		BubbleTextString:SetTextHeight(BlinkRogueHelper_FontSizePixel * alpha * scale + 1);
		BlinkRogueHelperFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, BlinkRogueHelper_FontSizePixel * alpha * scale );
		return;
	end
	BlinkRogueHelperFrame:Hide();
end

function SetBubbleTextColor()
	local mana = UnitPower("player", 3)
	local r,g,b;

	if( mana >= BRH_ComboSkill )then
		r = 0.1;
		g = 1.0;
		b = 0.1; -- green
	elseif( mana >= BRH_FinishSkill )then
		r = 0.0;
		g = 0.39;
		b = 0.88; -- blue
	else
		r = 1.0;
		g = 0.1;
		b = 0.1; -- red
	end

	BubbleTextString:SetTextColor(r, g, b);
end

local perAnticipation = 0
local perCombo = 0
local skipCall = 0


-- added by winddpan@nga
function BlinkComboShow(cp)
	local show = cp > 0
	if show then
		SetBubbleText(cp);
		BlinkRogueHelper_Show();
	end
end

function SetBubbleText(combo)
	BubbleTextString:SetText(combo);
	SetBubbleTextColor();
end

function BlinkRogueHelper_Show()
	BlinkRogueHelperFrame.startTime = GetTime();
	BlinkRogueHelperFrame:Show();
end

function BlinkRogueHelper_Register()
	SlashCmdList["BLINKROGUEHELPERSLASHENABLE"] = BlinkRogueHelper_Toggle;
	SLASH_BLINKROGUEHELPERSLASHENABLE1 = "/blinkroguehelper";
	SLASH_BLINKROGUEHELPERSLASHENABLE2 = "/brh";

	SlashCmdList["BLINKROGUEHELPERSELECT1"] = BlinkRogueHelper_SelectType1;
	SLASH_BLINKROGUEHELPERSELECT11 = "/blinkroguehelper1";
	SLASH_BLINKROGUEHELPERSELECT12 = "/brh1";

	SlashCmdList["BLINKROGUEHELPERSELECT2"] = BlinkRogueHelper_SelectType2;
	SLASH_BLINKROGUEHELPERSELECT21 = "/blinkroguehelper2";
	SLASH_BLINKROGUEHELPERSELECT22 = "/brh2";

	SlashCmdList["BLINKROGUEHELPERSELECT3"] = BlinkRogueHelper_SelectType3;
	SLASH_BLINKROGUEHELPERSELECT31 = "/blinkroguehelper3";
	SLASH_BLINKROGUEHELPERSELECT32 = "/brh3";

	SlashCmdList["BLINKROGUEHELPERSELECT4"] = BlinkRogueHelper_SelectType4;
	SLASH_BLINKROGUEHELPERSELECT41 = "/blinkroguehelper4";
	SLASH_BLINKROGUEHELPERSELECT42 = "/brh4";

	SlashCmdList["BLINKROGUEHELPERSELECT5"] = BlinkRogueHelper_SelectType5;
	SLASH_BLINKROGUEHELPERSELECT51 = "/blinkroguehelper5";
	SLASH_BLINKROGUEHELPERSELECT52 = "/brh5";
	
	SlashCmdList["BLINKROGUEHELPERSLASHFONT"] = BlinkRogueHelper_FontChange;
	SLASH_BLINKROGUEHELPERSLASHFONT1 = "/brhfont";
end

function BlinkRogueHelper_Toggle()
	if( not BlinkRogueHelper_Enabled or BlinkRogueHelper_Enabled ~= 1 ) then
		BlinkRogueHelper_Enabled = 1;
		ChatFrame1:AddMessage("BlinkRogueHelper Enable");
	else
		BlinkRogueHelper_Enabled = 0;
		ChatFrame1:AddMessage("BlinkRogueHelper Disable");
	end
end

function BlinkRogueHelper_SelectType1() 
	BlinkRogueHelper_Type = 1; 
	ChatFrame1:AddMessage("BlinkRogueHelper - Preset 1");
end

function BlinkRogueHelper_SelectType2()
	BlinkRogueHelper_Type = 2;
	ChatFrame1:AddMessage("BlinkRogueHelper - Preset 2");
	BubbleTextString:SetTextHeight(BlinkRogueHelper_FontSizePixel);
end

function BlinkRogueHelper_SelectType3()
	BlinkRogueHelper_Type = 3;
	ChatFrame1:AddMessage("BlinkRogueHelper - Preset 3");
	BubbleTextString:SetTextHeight(BlinkRogueHelper_FontSizePixel);
end

function BlinkRogueHelper_SelectType4()
	BlinkRogueHelper_Type = 4;
	ChatFrame1:AddMessage("BlinkRogueHelper - Preset 4");
	BubbleTextString:SetTextHeight(BlinkRogueHelper_FontSizePixel);
end

function BlinkRogueHelper_SelectType5()
	BlinkRogueHelper_Type = 5;
	ChatFrame1:AddMessage("BlinkRogueHelper - Preset 5");
	BubbleTextString:SetTextHeight(BlinkRogueHelper_FontSizePixel);
end

function BlinkRogueHelper_FontChange(value)
	local number = tonumber(value)
	if number ~= nil then
		BlinkRogueHelper_FontSizePixel = number;
		ChatFrame1:AddMessage("BlinkRogueHelper Font -> "..value);
	end
end
