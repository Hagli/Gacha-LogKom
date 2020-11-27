:- dynamic(enemy/5).
:- dynamic(cooldown/1).
:- dynamic(run/1).

get_enemy :-
	random(0,99,X),
	player(_,_,_,_,_,Level,_,_,_,_,_),
	Bronto is Level+2,
	random(Level,Bronto,Y),
	enemy_appear(X,Y),!.
	
	
enemy_appear(X,Y) :- 
	X < 34,
	HP is Y*4 + 9,
	Att is Y*3 + 7,
	Def is Y*2 + 8,
	asserta(enemy(slime,Y,HP,Att,Def)).
enemy_appear(X,Y) :- 
	X > 66,
	HP is Y*8 + 5,
	Att is Y*11 + 2,
	Def is Y*4 + 8,
	asserta(enemy(goblin,Y,HP,Att,Def)).
enemy_appear(_,Y) :- 
	HP is Y*9 + 1,
	Att is Y*6 + 9,
	Def is Y*8 + 6,
	asserta(enemy(wolf,Y,HP,Att,Def)).
	
potion:-
	(
		\+kept(hp_potion,Count) -> write('Anda tidak memiliki hp potion.');
		kept(hp_potion,Count) ->
			(
			Count=<0 -> write('Anda tidak memiliki hp potion.'),nl;
			Count>0 -> determine_hp
		)
	),!.
determine_hp:-
		item(_,_,hp_potion,_,_,_,Recovery,_,_),
		max_hp(MaxHP),
		player(_,_,_,_,_,_,_,_,_,Health,_), NowHealth is Health+Recovery,
		(
			NowHealth > MaxHP -> increase_hp(MaxHP);
			NowHealth =< MaxHP -> increase_hp(NowHealth)
		).

increase_hp(NewHealth):-
		/*MENGUBAH FAKTA*/	
		kept(hp_potion,Count),
		NewCount is Count-1,
		player(A,B,C,D,E,F,G,H,I,_,J),
		retract(player(A,B,C,D,E,F,G,H,I,_,J)),
		assertz(player(A,B,C,D,E,F,G,H,I,NewHealth,J)),
		assertz(kept(hp_potion,NewCount)),
		retract(kept(hp_potion,Count)),
		inventory(Filled), NewFilled is Filled-1,
		asserta(space_Filled(NewFilled)),
		retract(space_Filled(Filled)),
		write('Anda meminum sebotol hp potion! Health anda bertambah sebanyak 30 poin!'),nl.

attack :-
	inGame,
	player(_,_,_,_,_,_,_,Y,_,_,_),
	call(enemy(A,Lv,HP,Att,Def)),
	random(0,5,Plus),
	Z is Y + 6 - Def + Plus,
	(Z<0 -> Z is 0;Z is Z),
	X is HP - Z,
	(Z =< 0 -> (write('Musuh '),write(A),write('menghindari seranganmu!'));
	(write('Deal '),write(Z),write(' damage'))),nl,
	assertz(enemy(A,Lv,X,Att,Def)),
	retract(enemy(A,Lv,HP,Att,Def)).
/*attack :-
	call(enemy(A,Lv,HP,Att,Def)),
	retract(enemy(A,Lv,HP,Att,Def)),!.*/
	
write_enemy_attack(A,Z) :-
	Z =< 0,
	write('Kau menghindari serangan musuh '), write(A),!.
write_enemy_attack(A,Z) :-
	write('Musuh '), write(A),write(' deal '),write(Z),write(' damage'),!.
enemy_attack :-
	enemy(A,_,_,Att,_),
	call(player(O,N,M,L,K,J,I,H,G,F,E)),
	random(0,3,Plus),
	Z is Att + 3 - G + Plus,
	(Z<0 -> Z is 0;
	Z is Z),
	X is F - Z,
	write_enemy_attack(A,Z),
	nl,nl,
	assertz(player(O,N,M,L,K,J,I,H,G,X,E)),
	retract(player(O,N,M,L,K,J,I,H,G,F,E)).
	
	
sp_attack_do(1) :-
	attack.
sp_attack_do(Z) :-
	attack,
	Y is Z-1,
	sp_attack_do(Y).
sp_attack :-
	inGame,
	cooldown(0),
	random(2,5,Z),
	sp_attack_do(Z),
	assertz(cooldown(4)),
	retract(cooldown(0)),!.
sp_attack :-
	inGame,
	cooldown(X),
	write('Special attack tidak bisa digunakan!'),nl,
	write('Cooldown '),write(X),write(' turn'),nl,nl,
	battle_loop.
	
	
tambahan_nigeru :-
	asserta(run(1)),retract(run(0)),
	call(enemy(A,Y,Hp,Att,Def)),
	Boi is 0,
	asserta(enemy(A,Y,Boi,Att,Def)),
	retract(enemy(A,Y,Hp,Att,Def)).
nigerun(1) :-
	write('Gagal kabur...'),nl,!.
nigerun(X) :-
	X > 1,
	tambahan_nigeru,!.
nigeru :-
	inGame,
	random(1,3,Z),
	nl,
	nigerun(Z).
	
	
battle_loop :- /*akhir battle jika player berhasil kabur*/
	run(X), X =:= 1,
	call(enemy(A,Y,Hp,Att,Def)),
	Hp =< 0,write('Berhasil kabur dari musuh!'),
	retract(enemy(A,Y,Hp,Att,Def)),
	retract(run(_)),
	retract(cooldown(_)),!.
battle_loop :- /*akhir battle jika player mati*/
	call(player(_,_,_,_,_,_,_,_,_,D,_)),
	D =< 0,
	write('Kau telah mati'),nl,
	retract(player(_,_,_,_,_,_,_,_,_,_,_)),
	retract(enemy(_,_,_,_,_)),
	retract(cooldown(_)),
	retract(run(_)),
	halt,!.
battle_loop :- /*akhir player jika musuh berhasil dikalahkan*/
	call(enemy(A,Y,Hp,Att,Def)),
	Hp =< 0,
	Xe is Y+6,random(Y,Xe,Z),
	call(player(Name,Class,Weapom,Armor,Acc,Lv,Exp,Attack,Defense,Hpe,Recc)),
	Expi is Exp+Z,
	Ye is Xe+Z,
	write('Musuh '),write(A),write(' telah dikalahkan!'),nl,
	write('Kau mendapatkan '),write(Z),write(' exp!'),nl,
	call(money(Fgc)),
	write('Kau mendapatkan '),write(Ye),write(' money!'),nl,
	Yee is Fgc+Ye,
	asserta(money(Yee)),retract(money(Fgc)),
	asserta(player(Name,Class,Weapom,Armor,Acc,Lv,Expi,Attack,Defense,Hpe,Recc)),
	retract(player(Name,Class,Weapom,Armor,Acc,Lv,Exp,Attack,Defense,Hpe,Recc)),
	quest_part_done(A),questing(Slimey,Goburin,Wolfey),quest_finish(Slimey,Goburin,Wolfey),
	retract(enemy(A,Y,Hp,Att,Def)),
	retract(cooldown(_)),
	retract(run(_)),nl,!.

	
battle_loop :- /*main battle loop*/
	call(enemy(_,_,Hp,Att,Def)),
	call(player(_,_,_,_,_,_,_,B,C,D,_)),
	call(max_hp(Poggers)),
	write('HP: '),write(D),write('/'),write(Poggers),write('                   HP musuh: '),write(Hp),nl,
	write('Attack: '),write(B),write('                   Attack musuh: '),write(Att),nl,
	write('Defense: '),write(C),write('                   Defense musuh: '),write(Def),nl,
	write('Apa yang akan kau lakukan?'),nl,
	write('-> Attack (Command = attack.)'),nl,
	write('-> Special Attack (Command = sp_attack.)'),nl,
	write('-> Use Potion (Command = potion.)'),nl,
	write('-> Run (Command = nigeru. :)'),nl,
	read(Choice),nl,
	battle_choice(Choice),slash,
	call(cooldown(Mate)),
	(Mate = 0 -> Mates is 0; Mates is Mate-1),
	asserta(cooldown(Mates)),
	retract(cooldown(Mate)), 
	battle_loop.

enemy_attack_or_not(H) :-
	H > 0,enemy_attack,!.
enemy_attack_or_not(_) :-
	write(''),!.
slash :-
	enemy(_,_,H,_,_),enemy_attack_or_not(H).

battle_choice(attack) :-
	attack,!.
battle_choice(sp_attack) :-
	sp_attack,!.
battle_choice(nigeru) :-
	nigeru,!.
battle_choice(potion):-
	potion,!.
battle_choice(_) :-
	write('Kau kehilangan keseimbanganmu!'),nl,
	write('Musuhmu menggunakan kesempatan ini untuk menyerang!'),nl,!.
	
draw_enemy(slime) :-
	write('                                                        ..;clc;,..                              '),nl,
    write('                                                    .,cd0KKXXXXNKOd;.                           '),nl,
    write('                                                  ;o0XXNNXXXXXXNNXNXOc.                         '),nl,
    write('                                                ;xKNNNXK0O0K0OOO0KXNNXkc.                       '),nl,
    write('                                             .;lKNNXK0Oxxxk0OkOk0KKKNXKOl;                      '),nl,
    write('                                            .oOKXNNX0kxdolldxkOOkOkOK0Oxl,.                     '),nl,
    write('                                           .oKXK0KXKOkkkkxo;;:oxkxxxddolc;;;.                   '),nl,
    write('                                          .oO0K0O0kdc:::lodl;;lkkxddddo:;;;,.                   '),nl,
    write('                                         .lkk0NXK0kc;:llllodllddlc:,;ll,...,.                   '),nl,
    write('                                        .ckdkKX0xxl:oxkddoldkdccddoc,cd;...,;                   '),nl,
    write('                                       .lxxkOOkxol;;oddolclxkl,lxdxd;,lo,..,,.                  '),nl,
    write('                                     .;ddxO00kxxo:::lllllox00d;,;::,..:o:..;;.                  '),nl,
    write('                                    ;oxox0XXKdclxxdddloxk00000Ol;;;;;,c:;...,,.                 '),nl,
    write('                                  .;kkccx0K0x:;;cc:cldxkkxocccdkxdocod:......,;                 '),nl,
    write('                                .;lxdc:oOOxdl,..;cx0KOxc;;.....;:xOx:,;......;;.                '),nl,
    write('                                ;oxOOkxkkxddlclokO0Od:;..........;k0o;........,;                '),nl,
    write('                               ;lxkkOOkxdoox0KXKOoc,..............:do,........,,.               '),nl,
    write('                             .cx00Okxkxdood0Kkxdc,.................:lc;.......;;;.              '),nl,
    write('                          .,coxO0Oxxddoclddolc:,...;,;:lloddddoc;,.;;lc;.......;;;.             '),nl,
    write('                       .;;looddddodxo:;:ddc;,,,;coxO0KK0OOkxxO0OOkd:,:l;........;;,.            '),nl,
    write('                   ..;;codoodxdooddo:;;lkxoldkO00OOkxxdolc:,,;:ldxxdl:cl,........;;,            '),nl,
    write('                .;,::cloddddxOOkxdoc;.:dddxkOOOOkxxdoddddol;....,:c:;;cxl.........;:,           '),nl,
    write('              .,;::clllcloodkOkxddo;.,coxk0KKOkxxdddoc:codd:......;;...,,..........,;.          '),nl,
    write('            .;;:cllc::ccccllooodddl::oxxOKX0Oxoooooc,.;:dkxo;.......................;.          '),nl,
    write('          .;:coolc:::cc:;:cllodoolodxxO00Okxxdoolc,...,cdxddl;........................          '),nl,
    write('      ..;;:llll:,,:cll:,;coxxdc::cdxk0KK0kdolcc;;......;lolll:.......................;.         '),nl,
    write('  .;,:cccllcc:;.;:llcc;:okOkd:,,cdxxxkOxdocc;;..........;,,,;;;.;;;;;;;;,,,;;;,,,,,,,;;;,;.     '),nl,
    write(' .,,,,,,,,,;;..;:cccc:clolc;...,:c::::::;;..               ............;;..................     '),nl.
	
draw_enemy(goblin) :-
write('                                               ..  '),nl,
write('                     ..............         .,,.  '),nl,
write('   ....           .;ldxxdolccccoooolc;.  ..:lc.   '),nl,
write('   .,:cc;,......;oxO000Okxoc;,:dkkxdxOxlclddo,    '),nl,
write('      .;llooodxk00OkxddoolllodxkOOkxdodxkOkdl.    '),nl,
write('       .cloxOKXX0OkxddxkOOOOkxxxkkkOOkddk0kl;     '),nl,
write('       .;ldxxxKX00000000kxxxddddkOkOkO0K0x;.      '),nl,
write('        .,c:::lOKKKXXK0O000KKKKKKXXXKKX0xl;       '),nl,
write('          .::..;oO0KKXXXKKK0OkOkkOO000xl::,.      '),nl,
write('           ..   .;cdkO000OO0OOOkOOOOxc.....::,,.  '),nl,
write('       .           .;cxO00OOOOOOOOkc.     ;ddd:.. '),nl,
write('   ..,cl,            .ck00000OOOOxo:;. .;okkdoll;.'),nl,
write('  .cdkxkx,.         .lOKXXKKKKK000Okd:. .ck0Okxd:.'),nl,
write(' ;cdO0000kdl:.     ;x00KXKK0000O00Okkd:. .cOOo:.  '),nl,
write(' ;oOKKK0000kc.    .d0OO000OkxkkO0OkkOxo;.,d0x;    '),nl,
write(' .,:ldO0O0ko;;.   ;dkOxdkOkxxdxkOxoodo:;,xO00x:.  '),nl,
write('     ,kOddkOko;;,:okkkxldxxxoloxkd;;;...:x00kxx:. '),nl,
write('    .:xkkOOOxlldkOOkloocloddloxkOk:....,:odo;:dl. '),nl,
write('     .;,,,;,;;;;,cl;  .;l:lxxdxOKOo;::;;cooocll,  '),nl,
write('                      ;odolcoxxxkkOxo:. ..,;,..   '),nl,
write('               ...;;;cdxddxxollldk00O:.           '),nl,
write('              .:ccloxxkkxdodO0kdooddd:.           '),nl,
write('             .;lloxO0OxkO0OxdxO0000Okxl;          '),nl,
write('             .cclokKXKOO0000OxdxOOOOxxko;         '),nl,
write('             .cldd:lxOkdc:;;colcoxkxdxxxo,        '),nl,
write('          .,,;cll;   ..     .;..lxxkkxxkOl.       '),nl,
write('       ;:ldkOxdoc,.             ,cdkxddxo,        '),nl,
write('      ;dxkO000Okko,               ;odkd,          '),nl,
write('      ..,:cdkOOko,                ;okk;           '),nl,
write('            .:c:.                 .lxc.           '),nl,
write('                                 .;lol,           '),nl,
write('                                .lxkkkc.          '),nl,
write('                                ;dxddolc;.        '),nl,
write('                                .;,;;;;,..        '),nl.

draw_enemy(wolf) :-
write('                                                            .              ...                      '),nl,
write('                                                           .coc:;;;c:,,,;;:dOo.                     '),nl,
write('                                                            ;xOkOkkOOOO0KOOXXx;                     '),nl,
write('                                                             lK0kkddddoodookkkl.                    '),nl,
write('                                                            ,kK0Okdlllllol:;:,,;                    '),nl,
write('                                                           ,kXK00Okdoodkxolc;....                   '),nl,
write('                              ..,;;;;;.....      ...     .:kXXOkO0OO0OOxdo:c:;.;.                   '),nl,
write('                         .;;coxOKXKKKK0OkkxdxxdooddxxdoldkOKXXkdx00OkkOxlc;cc:::;                   '),nl,
write('                      .cdx0000K000O0KKXX00KKKKKK0OO0KK00000KXKOxxO0Okxdol:cdxxkd;                   '),nl,
write('                   .:dk0K0OkO00kxkkxO00K0000K0OO0KKKKKK0O0OO0KKOkkOkdxkOxxxkO00d;                   '),nl,
write('                 .:kXK0OxoclxOOkxkkxkkOOOOOdooodkO00KK0Oxxkkkk0KO0OxxOkxO0000KOl.                   '),nl,
write('                ,d0XX0Oxl:::cclolodxO00Oxddl:::cloooxkO0kddoloxO00OOOkO00OO000x:.                   '),nl,
write('              .;x0XX0koccc:;;:;,;,codOKKOxlll:::::cclodkkxolcclldkOOOOOkxxxkkxd;.                   '),nl,
write('              ;xKNXK0xl:cc:;;;,;;;;;clkK0kdlcc::;;;:llolodlc:cllllloddddxO00kdc.                    '),nl,
write('            .lkKNNX0kocc:;,;..;,,;.,cox0K0kdooc:;;;:loollddlcclooc:clooddxkOx;                      '),nl,
write('          .l0XXXXNXKK0Okxooc;:cooc::oxkKK0OOOxdo:;;:ldxkxdollloxxddxkkkxdxOOl,.   .....             '),nl,
write('   .......cKXKO0XXXXKXKK0O00kkOOOkxdxOKNNXXXX0OOdoooxkkkxocccclxO0K0OkxdxOOkxxxddddxxxd;.           '),nl,
write('   .;;;;;ck0K0OO00000Ooododoodk00OOkO0XXXXXXXXXK0O00KKOkkxolodoxkO000OxxOOkdxkOO00OkkO0Ol.          '),nl,
write('  .,;;,;;x00K0OOOkdxdc,;;,;:ccldkOOxdxkxxxkk0KXXKKKKXK000kdxO0kO0KKKKOkO00OO0Okdoc;,:dO00kl,        '),nl,
write('  .,;:;;lk0000Okkdolcc::;,;::;,,:odxkkOOkdlllloooxk0K000K0OO0KKKXXK00kxkkkxo;..      .:x0OOOo;      '),nl,
write('   .;:ccdk0KK00K0kOOxxxdxkdolccc::coox00K0x:;,,,;;;:ok00000OOO0XXXOc;.....             .lO0KKx.     '),nl,
write('   .;;,,:oxk0KKKK00000OOKXKKOO0Ok0Ok0000KOxl;,,,,;...;;lxOkkkkkO0XNKx;.                 .;cll:.     '),nl,
write('    ,,,;;,,;,;,:lolldOkkkOOO0KKKKK00KXXK0kolc:;,,;;;,;..;;cokKK000KKKKx:.                           '),nl,
write('                            ,;coddxdcol:,            .    ..;ldO0XX00KXKo.                          '),nl,
write('                                                                .;cdO00KXXk;                        '),nl,
write('                                                                    .;cxKXNKo;                      '),nl,
write('                                                                       .:O0kOOd;                    '),nl,
write('                                                                         ,xOOkkk,                   '),nl,
write('                                                                          .,:::;.                   '),nl.

start_battle :-
	inGame,
	get_enemy,
	asserta(cooldown(0)), /*untuk sp_attack cooldown*/
	assertz(run(0)), /*menandakan apakah player berhasil lari atau tdk*/
	call(enemy(A,Y,_,_,_)),
	write('Sebuah level '),write(Y),write(' '),write(A), write(' telah muncul!'),nl,
	draw_enemy(A),
	battle_loop,
	call(player(_,_,_,_,_,Lv,Exp,_,_,_,_)),
	Lvli is 5*Lv, Exp >= Lvli, lvl_up.