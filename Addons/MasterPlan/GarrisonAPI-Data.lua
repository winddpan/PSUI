local _, T = ...
if T.Mark ~= 23 then return end

T.Affinities = {} do
	local ht, hp = [[ì:¾'00Ç¸jášĞ­C1 ç±G9uïÂ‚®°&|c{ÖÙ†Ü•wÌĞ°ÛÄÅ{O`=ç\1é‚Ş›?g«Úø«-sDê$sJ¶çşè¥>aOwÊ_Uw ár=ÀsÕíMêÌ2s½#H4\?Ñ7búËöt‚Ó]g…p¨JtWcP€ôUR%:¡÷Rî4kí9ˆ°(Î+^% F»ç:ÿÉÿjæt¯é"ÙOü“Éó¥‘'ÒŸ¡Î,ˆÓ­HOá@‘y å­é#¥tLæE!ÿ#¦šE­$\·Î/BØBûcÿı\Ñ'Ê_ûÙ#ÿK¡éJÆP§y)ôM…rNO¦nzSùPŸ?â¶8ñd‘5sŠã;ì;¡5ıÄ"è™ é\fÏ¡k"ÑõÑrgÑDîc’‚%‡_Èú}‰Dã é|–!¯…"ß£éü_5‘‰"hüƒš‰²+š^ˆEÑ$¾×ÇœœÂ/ì"6A”Ğs©¤"sÍ<š‚EçIÖgÌîAG$OÕ¥;Ï‘%>†?óû¢˜‹JÓ%°ëd^é’GBt¹­M>Ç/ìwİù.dVsüXµĞMöQsGŞê1ĞüsÈ‰úh˜Eò$	ùŒsQÅ’D“ÿZ!óœrüÏO¦Oz%A1„`Çµ‘¡VE½sdcÉË[šy“åY·Åçù%$qrI/‘ğtå’o'ş‡$„ÎÂHæ1¹—ì‘‡èOÙóRƒçC¥Ñƒáù'ëÿÿÿÿç]], [[((­h®¯inp(qj¬krgolms]]
	local p, G, V, Vp, by, hk, ak = {}, 79, 673, 159, ht.byte, UnitFactionGroup('player') == 'Horde' and 12131 or 53327, 47122
	for i=1,#hp do p[i] = by(hp, i) p[i] = p[i] + (p[i] > 128 and 80 or -40) end
	setmetatable(T.Affinities, {__index=function(t, k)
		local k, c, a, v, r, b, d, e = k or false, k, type(k)
		if a == "string" then
			a, c = "number", tonumber(k:match("^0x0*(%x*)$") or "z", 16) or false
		end
		if a == "number" and c then
			c = c * hk
			a = 2*(((c * ak) % 2147483629) % G)
			a, b = by(ht, a+1, a+2)
			v = ((c * (a*256+b) + ak) % 2147483629) % V
			v, r = Vp + (v - v % 8)*5/8, v % 8
			a, b, c, d, e = by(ht, v, v + 4)
			v = a * 4294967296 + b * 16777216 + c * 65536 + d * 256 + e
			v = ((v - v % 32^r) / 32^r % 32)
		end
		t[k] = p[v] or 0
		return t[k]
	end})
end

T.MissionExpire = {} do
	local expire = T.MissionExpire
	for n, r in ("000210611621id2e56516c16o17i0:0ga6b:0o2103rz4rz5r86136716e26q37ji9549eja23ai0am1aq4ax0b40cq0dcedx1:102zd3h86vm82maj2ao1av1ay5b51bicc0dczcdr1dz0:1y9a39y3dt3:20050100190cr7:9b8pfb7abv3ceb"):gmatch("(%w%w)(%w+)") do
		local n = tonumber(n, 36)
		for s, l in r:gmatch("(%w%w)(%w)") do
			local s = tonumber(s, 36)
			for i=s, s+tonumber(l, 36) do
				expire[i] = n
			end
		end
	end
end

T.EnvironmentCounters = {[11]=4, [12]=38, [13]=42, [14]=43, [15]=37, [16]=36, [17]=40, [18]=41, [19]=42, [20]=39, [21]=7, [22]=9, [23]=8, [24]=45, [25]=46, [26]=44, [27]=47, [28]=48, [29]=49, [60]=54, [61]=55, [62]=56, [63]=57, [67]=58, [64]=59, [65]=60, [66]=61,}

T.SpecCounters = { nil, {1,2,7,8,10}, {1,4,7,8,10}, {1,2,7,8,10}, {6,7,9,10}, nil, {1,2,6,10}, {1,2,6,9}, {3,4,7,9}, {1,6,7,9,10}, nil, {6,7,8,9,10}, {2,6,7,9,10}, {6,8,9,10}, {6,7,8,9,10}, {2,7,8,9,10}, {1,2,3,6,9}, {3,4,6,8}, {1,6,8,9,10}, {3,4,8,9}, {1,2,4,8,9}, {2,7,8,9,10}, {3,4,6,9}, {3,4,6,7}, {4,6,7,9,10}, {2,6,8,9,10}, {6,7,8,9,10}, {2,6,7,8,9}, {3,7,8,9,10}, {3,6,7,9,10}, {3,4,7,8}, {4,7,8,9,10}, {2,7,8,10,10}, {3,8,9,10,10}, {1,6,7,8,10}, nil, {2,6,7,8,10}, {1,2,6,7,8} }

T.EquivTrait = {[244]=4, [250]=221, [202]=48}

T.XPMissions = {[5]=1, [173]=1, [215]=1, [336]=1, [364]=1,}

T.FOLLOWER_ITEM_LEVEL_CAP = 675