pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--★farming game★--

-- goals --
function _init()
	iplr()
	icrops()
	iinv()
	
end

function _update()
	uplr()
	ucrops()
	uinv()
end

function _draw()
	cls(11)
	map()
	dcrops()
	dplr()
	dinv()
end
-->8
--★player★--

function iplr()
 plr={
 	x=63,
 	y=63
 }
end--iplr

function uplr()

--movement--
	if btn(➡️) then
		plr.x+=1.2
		elseif btn(⬅️) then
			plr.x-=1.2
		elseif btn(⬆️) then
			plr.y-=1.2
		elseif btn(⬇️) then
			plr.y+=1.2
	end--if
	
	--plant seeds--
	local ptx=(plr.x+4)/8
	local pty=(plr.y+7)/8
	
	if btnp(❎) then
	
		--plant patches on blank tiles--	
		if fget(mget(ptx,pty),1) then
			if seed>0 then
				seed-=1
				mset(ptx,pty,19)
				add(patches,{
					px=flr(ptx),
					py=flr(pty),
					watered=false,
					tig=0 --time in ground
				})
			end--if patches
			
		elseif mget(ptx,pty)==19 then
			--water seeds--
			mset(ptx,pty,21)
			for p in all(patches) do
				if p.sx==flr(ptx) and p.sy==flr(pty) then
					p.watered=true
				end
			end--for
			
		elseif fget(mget(ptx,pty),2) then
			--collect a carrot--
			mset(ptx,pty,0)
			harvest()
			for p in all (patches) do
				if p.sx==flr(ptx) and p.sy==flr(pty) then
					del(patches,p)
				end
			end--for
		end--if fget
	end--if btnp
end--uplr

function dplr()
	spr(14,plr.x,plr.y)
end
-->8
--★growing crops★--

function icrops()
	patches={}
end

function ucrops()
	for p in all(patches) do
		if p.watered then
		p.tig+=1
		end
		
		if p.tig>300 then
			mset(p.sx,p.sy,20) --grow carrot		
		end
	end
end

function dcrops()
end--dcrops

-->8
--★inventory★--

function iinv()
	inv={}
	seed=9
	carrots=0
end

function uinv()
	
end

function dinv()
--draw seed inv
	spr(35,88,2)
	print(seed,98,3,7)

--draw carrot inv
	spr(34,104,2)
	print(carrots,113,3,7)
end

function harvest()
	carrots+=1
	seed+=2
 --add(inv,34)
end
__gfx__
00000000bbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a99a9000000000
00000000bbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a99a99000000000
00700700bbbbbbbb00030030030000000003000000000000000000000000000000000000000000000000000000000000000000000000000000cfcf0000000000
00077000bbbbbbbb00300300003000300000300000000000000000000000000000000000000000000000000000000000000000000000000000ffff0000000000
00077000bbbbbbbb0030300000300300030030000000000000000000000000000000000000000000000000000000000000000000000000000777777000000000
00700700bbbbbbbb0030300000000300003003000000000000000000000000000000000000000000000000000000000000000000000000000077770000000000
00000000bbbbbbbb0000000000000000003003000000000000000000000000000000000000000000000000000000000000000000000000000011110000000000
00000000bbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010010000000000
0000000000000000066f44600444444004444440044444400000000000000000000000000000000000000000000000000000000000000000cccccccc00000000
00000000000000004444444444ff49444444444444ff49c40000000000000000000000000000000000000000000000000000000000000000cccccccc00000000
0000000000000000444466f444944444444b4b444c94c4440000000000000000000000000000000000000000000000000000000000000000cca9a9cc00000000
00000000000000004464444444449f444444b44444449fc40000000000000000000000000000000000000000000000000000000000000000cccfffcc00000000
000000000000000066f4444449f444944449994449f444940000000000000000000000000000000000000000000000000000000000000000cccccccc00000000
00000000000000004444466f49444444442999244944c4440000000000000000000000000000000000000000000000000000000000000000cccccccc00000000
00000000000000004444444444499f444442224444c99f440000000000000000000000000000000000000000000000000000000000000000cccccccc00000000
00000000000000000646ff400444444004444440044444400000000000000000000000000000000000000000000000000000000000000000cccccccc00000000
0000000000000000000111000eeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000131310e2e22e2e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000013100e22ee22e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000199410e2b22b2e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000199910e22bb22e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000199910e299992e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000149910e299992e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000191000eeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888eeeeee888777777888888888888888888888888888888888888888888888888888888888888888ff8ff8888228822888222822888888822888888228888
8888ee888ee88778877788888888888888888888888888888888888888888888888888888888888888ff888ff888222222888222822888882282888888222888
888eee8e8ee87777877788888e88888888888888888888888888888888888888888888888888888888ff888ff888282282888222888888228882888888288888
888eee8e8ee8777787778888eee8888888888888888888888888888888888888888888888888888888ff888ff888222222888888222888228882888822288888
888eee8e8ee87777877788888e88888888888888888888888888888888888888888888888888888888ff888ff888822228888228222888882282888222288888
888eee888ee877788877888888888888888888888888888888888888888888888888888888888888888ff8ff8888828828888228222888888822888222888888
888eeeeeeee877777777888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
111111111eee1e1111ee1eee1eee1eee11111bbb1bbb1bb1117111666661117111111eee1e1e1eee1ee111111111111111111111111111111111111111111111
111111111e111e111e111e1111e11e1111111b1b11b11b1b1711166611661117111111e11e1e1e111e1e11111111111111111111111111111111111111111111
111111111ee11e111eee1ee111e11ee111111bb111b11b1b1711166111661117111111e11eee1ee11e1e11111111111111111111111111111111111111111111
111111111e111e11111e1e1111e11e1111111b1b11b11b1b1711166611661117111111e11e1e1e111e1e11111111111111111111111111111111111111111111
111111111eee1eee1ee11eee1eee1e1111111bbb11b11b1b1171116666611171111111e11e1e1eee1e1e11111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111116661611166611111616111111111cc111111ccc1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111161616111616111116161111177711c11111111c1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111166616111661111111611777111111c111111ccc1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111161116111616111116161111177711c111111c111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111116111666161611711616111111111ccc11c11ccc1111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1e1111ee1eee1eee1eee11111bbb1bbb1bb1117111666661117111111eee1e1e1eee1ee111111111111111111111111111111111111111111111
111111111e111e111e111e1111e11e1111111b1b11b11b1b1711166616661117111111e11e1e1e111e1e11111111111111111111111111111111111111111111
111111111ee11e111eee1ee111e11ee111111bb111b11b1b1711166111661117111111e11eee1ee11e1e11111111111111111111111111111111111111111111
111111111e111e11111e1e1111e11e1111111b1b11b11b1b1711166111661117111111e11e1e1e111e1e11111111111111111111111111111111111111111111
111111111eee1eee1ee11eee1eee1e1111111bbb11b11b1b1171116666611171111111e11e1e1eee1e1e11111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111116661611166611111616111111111cc111111ccc1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111161616111616111116161111177711c11111111c1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111166616111661111116661777111111c111111ccc1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111161116111616111111161111177711c111111c111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111116111666161611711666111111111ccc11c11ccc1111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1e1111ee1eee1eee1eee11111bbb1bbb1bb1117111666661117111111eee1e1e1eee1ee111111111111111111111111111111111111111111111
111111111e111e111e111e1111e11e1111111b1b11b11b1b1711166111661117111111e11e1e1e111e1e11111111111111111111111111111111111111111111
111111111ee11e111eee1ee111e11ee111111bb111b11b1b1711166111661117111111e11eee1ee11e1e11111111111111111111111111111111111111111111
111111111e111e11111e1e1111e11e1111111b1b11b11b1b1711166616661117111111e11e1e1e111e1e11111111111111111111111111111111111111111111
111111111eee1eee1ee11eee1eee1e1111111bbb11b11b1b1171116666611171111111e11e1e1eee1e1e11111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111116661611166611111616111111111cc111111ccc1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111161616111616111116161171177711c11111111c1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111166616111661111116661777111111c111111ccc1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111161116111616111111161171177711c111111c111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111116111666161611711666111111111ccc11c11ccc1111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111eee1ee11ee1111111111ddd1ddd111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111e111e1e1e1e1111111111d11d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111ee11e1e1e1e1ddd1ddd11d11dd1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111e111e1e1e1e1111111111d11d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111eee1e1e1eee111111111ddd1d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111ddd1d111ddd1dd11ddd111111dd1ddd1ddd1dd111dd1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111d1d1d111d1d1d1d11d111111d111d111d111d1d1d111111111111111111111111111111111111111111111111111111111111111111111111111111
1ddd1ddd1ddd1d111ddd1d1d11d111111ddd1dd11dd11d1d1ddd1ddd1ddd11111111111111111111111111111111111111111111111111111111111111111111
111111111d111d111d1d1d1d11d11111111d1d111d111d1d111d1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111d111ddd1d1d1d1d11d111111dd11ddd1ddd1ddd1dd11111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111e1111ee11ee1eee1e11111116661666161611111666161116661111161611171ccc11111111111111111111111111111111111111111111111111111111
11111e111e1e1e111e1e1e11111116161161161617771616161116161111161611711c1c11111111111111111111111111111111111111111111111111111111
11111e111e1e1e111eee1e11111116661161116111111666161116611111116111711ccc11111111111111111111111111111111111111111111111111111111
11111e111e1e1e111e1e1e11111116111161161617771611161116161111161611711c1c11111111111111111111111111111111111111111111111111111111
11111eee1ee111ee1e1e1eee111116111161161611111611166616161171161617111ccc11111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111e1111ee11ee1eee1e1111111666166616161111166616111666111116161117166611111111111111111111111111111111111111111111111111111111
11111e111e1e1e111e1e1e1111111616116116161777161616111616111116161171161611111111111111111111111111111111111111111111111111111111
11111e111e1e1e111eee1e1111111666116116661111166616111661111116661171166111111111111111111111111111111111111111111111111111111111
11111e111e1e1e111e1e1e1111111611116111161777161116111616111111161171161611111111111111111111111111111111111111111111111111111111
11111eee1ee111ee1e1e1eee11111611116116661111161116661616117116661711166611111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111eee1eee11111bbb1bbb1bb1117111666661117111111eee1e1e1eee1ee11111111111111111111111111111111111111111111111111111111111111111
111111e11e1111111b1b11b11b1b1711166161661117111111e11e1e1e111e1e1111111111111111111111111111111111111111111111111111111111111111
111111e11ee111111bb111b11b1b1711166616661117111111e11eee1ee11e1e1111111111111111111111111111111111111111111111111111111111111111
111111e11e1111111b1b11b11b1b1711166161661117111111e11e1e1e111e1e1111111111111111111111111111111111111111111111111111111111111111
11111eee1e1111111bbb11b11b1b1171116666611171111111e11e1e1eee1e1e1111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111188888111111111111111111111111111111111111111111111111111111111111111
111111111bbb11bb1bbb1bbb11711666166616161111166616661616111188888111111111111111111111111111111111111111111111111111111111111111
111111111bbb1b111b1111b117111616116116161111161611611616111188888111111111111111111111111111111111111111111111111111111111111111
111111111b1b1bbb1bb111b117111666116111611111166611611666111188888111111111111111111111111111111111111111111111111111111111111111
111111111b1b111b1b1111b117111611116116161171161111611116117188881111111111111111111111111111111111111111111111111111111111111111
111111111b1b1bb11bbb11b111711611116116161711161111611666171188817111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111117711111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111117771111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111117777111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111117711111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111171111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1eee1ee11ee1111111111d1d1ddd1d111ddd11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1e111e1e1e1e111111111d1d1d1d1d111d1d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1ee11e1e1e1e1ddd1ddd1d1d1ddd1d111dd111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1e111e1e1e1e111111111d1d1d111d111d1d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1eee1e1e1eee1111111111dd1d111ddd1d1d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1eee1e1e1ee111ee1eee1eee11ee1ee1111116611666161116661171117111111111111111111111111111111111111111111111111111111111111111111111
1e111e1e1e1e1e1111e111e11e1e1e1e111116161616161116161711111711111111111111111111111111111111111111111111111111111111111111111111
1ee11e1e1e1e1e1111e111e11e1e1e1e111116161666161116611711111711111111111111111111111111111111111111111111111111111111111111111111
1e111e1e1e1e1e1111e111e11e1e1e1e111116161611161116161711111711111111111111111111111111111111111111111111111111111111111111111111
1e1111ee1e1e11ee11e11eee1ee11e1e111116661611166616161171117111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111bb1bbb1bbb11711cc11c1c1111166616111666111116161111166616111666111116161171111111111111111111111111111111111111111111111111
11111b111b1b1b1b171111c11c1c1111161616111616111116161111161616111616111116161117111111111111111111111111111111111111111111111111
11111bbb1bbb1bb1171111c11ccc1111166616111661111111611111166616111661111116661117111111111111111111111111111111111111111111111111
1111111b1b111b1b171111c1111c1171161116111616111116161171161116111616111111161117111111111111111111111111111111111111111111111111
11111bb11b111b1b11711ccc111c1711161116661616117116161711161116661616117116661171111111111111111111111111111111111111111111111111
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
82888222822882228888822282228882822282828888888888888888888888888888888888888888888888888228822282228882822282288222822288866688
82888828828282888888888282828828888282828888888888888888888888888888888888888888888888888828828288828828828288288282888288888888
82888828828282288888822282228828882282228888888888888888888888888888888888888888888888888828828282228828822288288222822288822288
82888828828282888888828882828828888288828888888888888888888888888888888888888888888888888828828282888828828288288882828888888888
82228222828282228888822282228288822288828888888888888888888888888888888888888888888888888222822282228288822282228882822288822288
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__gff__
0202020202000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000030000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000003000000040000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0004000002020000000000000000000000030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000505050000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000505050000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000300000505050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402000000000402000000040000000400000402000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0002000000000200000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000400000000000000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000300000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000030000000000000000000302000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0200000000000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000300000000000004030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
