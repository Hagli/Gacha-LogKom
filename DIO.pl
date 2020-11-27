:- include('battle.pl').
:- dynamic(enemy_boss/5).
enemy_boss(dio,50,400,500,400).
/*dio_max_hp(400).*/
posisiB(10,10).

fight_the_boss:-
	inGame,
    posisiP(X,Y),
    (\+posisiB(X,Y)-> write('You are not at the entrance of the boss room.'),nl;
    posisiB(X,Y)->start_battle_boss
    ).

validate(Z,Zey) :-
	Z < 0, Zey is 0,!.
validate(Z,Zey) :-
	Zey is Z.
attack_boss :-
	player(_,_,_,_,_,_,_,Y,_,_,_),
	enemy_boss(A,Lv,HP,Att,Def),
	random(0,5,Plus),
	Z is Y + 6 - Def + Plus,
	validate(Z,Zey),
	X is HP - Zey,
	(Zey =< 0 -> (write('Dio '),write('menghindari seranganmu!'));
	(write('Deal '),write(Zey),write(' damage'))),nl,
	assertz(enemy_boss(A,Lv,X,Att,Def)),
	retract(enemy_boss(A,Lv,HP,Att,Def)).
	
write_boss_attack(Z) :-
	Z =< 0,write('Kau menghindari serangan dio '),nl,
	write('Tidak mungkin!'),nl,!.
write_boss_attack(Z) :-
	write('Dio '),write(' deal '),write(Z),write(' damage'),nl,!.
muda_muda(1) :-
	which_attack(9),!.
muda_muda(X) :-
	which_attack(9),
	Y is X-1,muda_muda(Y).
which_attack(1) :-
	write('Lihatlah kekuatanku!'),nl,
	write('DUNIAWI!!'),nl,
write('                                                                                    ;;,;.           '),nl,
write('                                                                                   .cccl; .;;;.     '),nl,
write('                                                                                   .:cdl..;c;cc.    '),nl,
write('                                                                                   ...cc...;;;,.    '),nl,
write('                                                                                   .;,lxc,cdc,,,,,. '),nl,
write('                                                                                  .:dxxxodkkc;,,;l; '),nl,
write('                                                                             .....;dO00Okkkxdddlol,;'),nl,
write('                                                                            .;,,;:okO0KK0kxxk00xo:;l'),nl,
write('                                                                             ;lk0OxxO0XWN0xxOKXx:;;;'),nl,
write('                                .                                            .;dxO0XNNXNWXOk0KO;.   '),nl,
write('                              .:c.                                            ;lloOXNNXXNXKKOd,     '),nl,
write('                            .;c:;,.                                         .o0kodxxk0Oxdxkko:.     '),nl,
write('                       ..;;loc;,,,,.      .;;::,.;;;..                     ;k0KkldOOOOkdddxk0x.     '),nl,
write('                   .;:::cccc:;;,,,,;;....;;,cool::::ldoc:,....,,;.........,dkoldddxOKKK000KKNO;     '),nl,
write('                    ;::;,,,,;clc;,,,loloxl,c:;......,okdc,...;c:;,:cc:;;;co:;;.,:cokKXXKKKKXN0;     '),nl,
write('                     .,:;,,,;:cc:;;,cxdoooxdc;,;,cooddc....;,;cc::;;... .;lc..;;;;,codxkkkOXNO,     '),nl,
write('                      .;l:,,;;;;:;;,cxkoll;......,:co;. ..;;codc;.       .:o:;,;:ccoxkkddk0KO:      '),nl,
write('                        ;d:.,:cc:cclxOOkxc...;;;:looo;.;;coxkOo. .........,odl,,coxOKXOkKK0d;       '),nl,
write('                         ,d:..:cclodkkxkkoc;;;;,;lxkd;;:dOK0xo:;..;;......;xOOkdddxO00kkOd;.        '),nl,
write('                        .,oxc.;cdxxddxO00o,......;ldxc:dOXXOxkdc;;:::cllodxO000KXXXXX0kl,.          '),nl,
write('             ...      .;dxooodolooddxxO00o;;,,,,;cokOxdodkK00XXXXK0Okkkkkxxdl;;,:lol:;.             '),nl,
write('            .coc:,.  ..,olcok00OOxolcoxk0Odlc:;:ldxO0Ol;lOOkkOkk0K00xlc:;,.                         '),nl,
write('          .;coodxo;  .;,c:cx00kx00kolcldx00l.....;;;dOdox0OddkkddOOxc.                              '),nl,
write('         .,oddoxOo.  ;xk;.:dO00kxkOOkkxxdkOl;;;;,:clkKOdx00ddOOxdkkxl.                              '),nl,
write('          .:dxdodxo,;:kKo:dxkKK0d:,:dOKOkOkkdc;;;::cokkxxOKOxO0kxxoxo.                              '),nl,
write('          .;cddddOK0000kxxl,:oO0Oc.;:x00OOxol;....;;oxxoclkOk0X0kxoxx.                              '),nl,
write('           ;:cdkxkK0O0xlcc,.;ld0K0xc;:clc;;......;:::lddlcd0K00Okxdko.                              '),nl,
write('            ,coxdk00Oxccdxkxdc:lxOOd;..;;..  ..;....,:oxxxkKKOxddxkx,                               '),nl,
write('             .:okKKOo::oxkOKO:..;okko:..........;,;;,;lkkxkkOOxxxkkl.                               '),nl,
write('               .:k0Odok00OkOXKd;;,cxkxl;.  ..,:;;,;;;.;llccxK0O0Okxc.                               '),nl,
write('                 .,cddxk0Oxl:,...,;:dxxxc,..cxxl:;;::,;;,;,ckOkO0kxc.                               '),nl,
write('                     ...;..      ..;lccxkkkO0OdldxkOkc;:c:coOOkxxxdxl.                              '),nl,
write('                                    ..,:coxxdxkO0OOxc,:llld0KOoldxxdo:                              '),nl,
write('                                         ....;cdOOxocloolcoOKOx0KOdloo;...                          '),nl,
write('                                          ...,:ckOxoloodold0X0OOdddkxlol;;..                        '),nl,
write('                                       .,;;cll::x00xloxxoclxxooxxOKXKxkOd:cl;                       '),nl,
write('                                      .,codxxdc:clllldoll;,;::clodxOKKKXKxokd.                      '),nl,
write('                                     .ck000Ol;:cc:;;cddc;;..;;,,;:lxKNNNN0dxl                       '),nl,
write('                                     .o00oc:;;;;:lllol;;;;;,;::clodkOO0XWXko;                       '),nl,
write('                                   ..;oo,..;:c,;;oxkx:,,;,;:ldxkOO00d;,dK0d,                        '),nl,
write('                                ..;;;;;...;,:llldxdxxl:;:cokOOkkk0X0o;.ld;.                         '),nl,
write('                              .........;;;,;cdOxc;.;dkkdodO0OxdxO0Ol;.;l.                           '),nl,
write('                            ..,,;;;;;;,;;::cdO0dc:,;lkklcoO0OO00Oo:,,co,                            '),nl,
write('                          ..;cc:;,;,,;cloxkOKNKxxdllxOxlokKK00kxoc:lx0o.                            '),nl,
write('                        ..,cxOdc;;;:ldk0KXNWWXkdxxxk0KOkOXNWN0kxdlccoOo.                            '),nl,
write('                       .;:lx0KkoccodOKXXXNXOko,;:loxOkooxkKNNX0xlccdOXK:                            '),nl,
write('                      ,llloxO0OOkOKXXXKkxdl;,;..;;,cl,..;lOXXKOdodkK000;                            '),nl,
write('                    .okkoodxkOkOKNWNXKOxdc;. ..;;;;,,;;;;x0OOOOkdxkxdxl.                            '),nl,
write('                   .lkkkxkOOOkkkKNXOxkxl,.     .;,;:clodoxkO0KKOxdlcl;.                             '),nl,
write('                 ..,okOKXKK00KKXNKxl:;.         .;,;oxxddkOKOkOkxdodc.                              '),nl,
write('                 ..;cxxk0KXXNNX0xc,.               ..;,,;;ckOOkddxkOl.                              '),nl,
write('               .:;;;,,;;dOO0XX0l.                         .dxoodxOOOl.                              '),nl,
write('               ,ll::;,;;okOOkOl.                          ;:;,:ok0Okl.                              '),nl,
write('              ..;doccllclooloc.                           .,;;:lxOOx,                               '),nl,
write('              ..:o;.:xxddoc,.                             ;;;:loxOd,                                '),nl,
write('             .. ...;x0Okl,.                               ;:cdkko;.                                 '),nl,
write('           ...  .;l0Oc;.                                  ,looc;                                    '),nl,
write('         ..;;...:dxc.                                      ..                                       '),nl,
write('       ...;,:cllod;                                                                                 '),nl,
write('      .;;llloxxdxd.                                                                                 '),nl,
write('      ;dxxxkO0KOl.                                                                                  '),nl,
write('     .;okkxkkdl,                                                                                    '),nl,
write('   .;;;:k0Ox:.                                                                                      '),nl,
write(' ..;;,:dO0k:                                                                                        '),nl,
write('.,;;:lx00d,                                                                                         '),nl,
write(':oxkOOOo;.                                                                                          '),nl,
write('lk0KOd;.                                                                                            '),nl,
	random(2,5,Times),
	muda_muda(Times).
which_attack(Poi) :-
	Poi < 5,!,write('Heh, kau cukup kuat'),nl,
	enemy_boss(A,Bes,Hp,Att,Dicc),
	call(player(O,N,M,L,K,J,I,H,G,F,E)),
	random(0,3,Plus),
	Z is Att + 5 - G + Plus,
	(Z<0 -> Z is 0;
	Z is Z),
	X is F - Z,
	Bro is Hp + Z,
	write_boss_attack(Z),
	write('Dio mendapatkan kembali '),write(Z),write(' health'),nl,
	nl,nl,
	assertz(enemy_boss(A,Bes,Bro,Att,Dicc)),
	retract(enemy_boss(A,Bes,Hp,Att,Dicc)),
	assertz(player(O,N,M,L,K,J,I,H,G,X,E)),
	retract(player(O,N,M,L,K,J,I,H,G,F,E)).
which_attack(_) :-
	write('MUDA MUDA MUDA MUDA MUDA MUDA!'),nl,
	enemy_boss(_,_,_,Att,_),
	call(player(O,N,M,L,K,J,I,H,G,F,E)),
	random(0,3,Plus),
	Z is Att + 5 - G + Plus,
	(Z<0 -> Z is 0;
	Z is Z),
	X is F - Z,
	write_boss_attack(Z),
	assertz(player(O,N,M,L,K,J,I,H,G,X,E)),
	retract(player(O,N,M,L,K,J,I,H,G,F,E)).
boss_attack :-
	random(1,10,Z),
	which_attack(Z),
	write('WWRRYYYYYY'),nl,
	write('                           ...                                              '),nl,
    write('                    ..,;...;:;.                                             '),nl,
    write('                  .:dxkdllodol:.                                            '),nl,
    write('                  ;xkxxoldolldo;.                                           '),nl,
    write('                .;oxxc;;.;;col;.;.                                          '),nl,
    write('               .:ooool;;:;:oo; ..                                           '),nl,
    write('              .;oxdccddxxdddc..                                             '),nl,
    write('               ,ok000KKK0KK00kdoddo:;,.                                     '),nl,
    write('              .loloodkkkO0000000KXXXXX0x;.                                  '),nl,
    write('              ;oc;,,,,;:lx0KKKK0OOO0KXXXKo.                                 '),nl,
    write('            .,:;,;;;;;;:ccokOOO0KKXXXNNNNKdccl:.                            '),nl,
    write('           ,:,.....;,:llc:,,;:o0NXXKKKXXXKK0OO0l.                           '),nl,
    write('          .cc;;;;,;:coxo:;,;;,oKNNNK0000KKXXKKKd.                           '),nl,
    write('          .cl:::cccloddoc;;,;dKXKKKKK0OkkO0Ok0Kkc,;.. ..                    '),nl,
    write('           .,:cllllclloxo:ccoKNXKK0OkdlodxkOO000K0Okdoooc,,:;.   ..         '),nl,
    write('             .:lccc:::cxo,;,ckKXX0OkOkdoooc;:okO0KKOxkkOOkdddoc:cdo,....    '),nl,
    write('              .;lc;;;:ll.  .:oxOOkkxddoc;;..;;ck000Oxollodxdxk00dodxxxxl;   '),nl,
    write('               ,lc;:ccol..lOkdlclxOo:::;,;...;;lOKKK0oc:;,;:ldOOoclkK0kd;   '),nl,
    write('             .,;,;;;,;:lc,ck0Okkkxxdllc;,,;...;,oKX0kocc:;,;;,:clclxOOxd:.  '),nl,
    write('         .,;:lcclcc:;,;,l:....... ,ddo:,,;;..;;,o00Oddlccc:;,,;;;okOOkd:.   '),nl,
    write('        .:loollooolccoc,:;.       ;clc;;;,;..;;;cllxkddoccl:;;;;;:lc;;,.    '),nl,
    write('        .:olc:;;coooxkxc;.       ;l:;;;,,;;.;;;::. .:dddoooo:;;:;;:c,       '),nl,
    write('         .:ccoddlcclxkd;.       .ldc:;,,;;;;;;;c:.   .:dkxxdc;;;;;;:c,.     '),nl,
    write('             .,,:dxooddl.    .;;:cc:;;,,,,,,,;;c;      cOkxl:;;;;;;:lkxc.   '),nl,
    write('                 .,;...;.   ;ol::ccccccc:::;:co;       :xxdlccc:::cldk0Kx.  '),nl,
    write('                            .;loolllllooolodocl:.      .,coxkxdddxxxxxk0k;  '),nl,
    write('                         ...;:dOOxollloodxxko;,.         .lOK00KKK00OkO0o.  '),nl,
    write('                     .,,;:::::lkOxlllldxkkl,.          .:odxxxkO00KKK0kl.   '),nl,
    write('                 .,:::;,,;;;,,;lxxkkkkxdc;             ;ddodddddddxO0d;     '),nl,
    write('                .;od:,,,,,,,;;;:cdxl,..                .lxxdddddddol;.      '),nl,
    write('             ..,;:ccc::::c:cccccll,                    ,oxxxddkxc,.         '),nl,
    write('          .;codollolcclllllllllc;.                     ,dxxdddxxl;.         '),nl,
    write('       .:lodxkk0KOdl:;,,,,,,,,,.                       .lk0OkkkOo;          '),nl,
    write('      .lkdoclx0Kxc,.                                     ;dK0kdxxl:.        '),nl,
    write('    ;:loolccdxl,                                          .x0kdolool:..     '),nl,
    write('  ;ldol:::cdo.                                             ;dOkdoolloo:.    '),nl,
    write(' ;ooc::cc::dl.                                               ..;......      '),nl,
	sleep(1).
	
sp_attack_do_boss(1) :-
	attack_boss.
sp_attack_do_boss(Z) :-
	attack_boss,
	Y is Z-1,
	sp_attack_do_boss(Y).
sp_attack_boss :-
	cooldown(0),
	random(2,5,Z),
	sp_attack_do_boss(Z),
	assertz(cooldown(4)),
	retract(cooldown(0)),!.
sp_attack_boss :-
	cooldown(X),
	write('Special attack tidak bisa digunakan!'),nl,
	write('Cooldown '),write(X),write(' turn'),nl,nl,
	boss_battle_loop.


boss_attack_or_not(H) :-
	H > 0,boss_attack,!.
boss_attack_or_not(_) :-
	write(''),!.
slash_boss :-
	enemy_boss(_,_,H,_,_),boss_attack_or_not(H).
	
battle_choice_boss(attack) :-
	attack_boss,nl,!.
battle_choice_boss(sp_attack) :-
	sp_attack_boss,!.
battle_choice_boss(nigeru) :-
	write('KAU PIKIR KAU BISA KABUR BOCAH?!'),nl,!.
battle_choice_boss(potion):-
	potion,!.
battle_choice_boss(_) :-
	write('Kau kehilangan keseimbanganmu!'),nl,
	write('Musuhmu menggunakan kesempatan ini untuk menyerang!'),nl,!.


boss_battle_loop :- /*akhir battle jika player mati*/
	call(player(_,_,_,_,_,_,_,_,_,D,_)),
	D =< 0,
	write('HAHAHAHA'),nl,write('Tidak ada manusia manapun yang bisa mengalahkanku!!'),nl,
	write('Apalgi bocah sepertimu'),nl,
	write('Kau telah mati'),nl,
	retract(player(_,_,_,_,_,_,_,_,_,_,_)),
	retract(cooldown(_)),
	halt,!.

boss_battle_loop :- /*akhir player jika musuh berhasil dikalahkan*/
	call(enemy_boss(A,Y,Hp,Att,Def)),
	Hp =< 0,
	Xe is Y+6,random(Y,Xe,Z),
	call(player(Name,Class,Weapom,Armor,Acc,Lv,Exp,Attack,Defense,Hpe,Recc)),
	Expi is Exp+Z,
	Ye is Xe+Z,
	write('Dio '),write(' telah dikalahkan!'),nl,
	write('Kau mendapatkan '),write(Z),write(' exp!'),nl,
	call(money(Fgc)),
	write('Kau mendapatkan '),write(Ye),write(' money!'),nl,
	Yee is Fgc+Ye,
	asserta(money(Yee)),retract(money(Fgc)),
	asserta(player(Name,Class,Weapom,Armor,Acc,Lv,Expi,Attack,Defense,Hpe,Recc)),
	retract(player(Name,Class,Weapom,Armor,Acc,Lv,Exp,Attack,Defense,Hpe,Recc)),
	retract(enemy_boss(A,Y,Hp,Att,Def)),
	retract(cooldown(_)),nl,
	write('"BA-BAKANAAAA!!! KONO DIO DA!!!"'),nl,
	write('Terakan dari monster yang bernama DIO itu menggetarkan seluruh tanah di lantai ini.'),nl, 
	write('Walaupun ini hanyalah dunia virtual, tapi teriakannya itu mungkin saja dapat membuat gendang telingaku pecah di dunia nyata.'),nl,
	write('Sampai awal hingga akhir, DIO benar-benar mengerikan...'),nl,
	write('Akan tetapi, tujuanku telah tercapai. AKu telah mengalahkannya tanpa harus mengorbankan kawan-kawanku. Dengan begini...aku bisa terus maju.'),halt,!.
	
boss_battle_loop :-
	call(enemy_boss(_,_,Hp,Att,Def)),
	call(player(_,_,_,_,_,_,_,B,C,D,_)),
	call(max_hp(Poggers)),/* call(dio_max_hp(Sreggop)),*/
	write('HP: '),write(D),write('/'),write(Poggers),write('                   HP musuh: '),write(Hp),nl,
	write('Attack: '),write(B),write('                   Attack musuh: '),write(Att),nl,
	write('Defense: '),write(C),write('                   Defense musuh: '),write(Def),nl,
	write('Apa yang akan kau lakukan?'),nl,
	write('-> Attack (Command = attack.)'),nl,
	write('-> Special Attack (Command = sp_attack.)'),nl,
	write('-> Use Potion (Command = potion.)'),nl,
	write('-> Run (Command = nigeru. :)'),nl,
	read(Choic),nl,
	battle_choice_boss(Choic),slash_boss,
	call(cooldown(Mate)),
	(Mate = 0 -> Mates is 0; Mates is Mate-1),
	asserta(cooldown(Mates)),
	retract(cooldown(Mate)), 
	boss_battle_loop.
		
	
write_flavour(yes) :-
	write('Kalau begitu mendekatlah sebisamu...bocah'),nl.
write_flavour(no) :-
	write('Terlambat! Kau sudah tidak bisa lagi lari dari tempat ini!'),nl.


start_battle_boss :-
	asserta(cooldown(0)), /*untuk sp_attack cooldown*/
	write('Hohoo...kau mendekatiku? (yes/no)'),nl,
	read(Forward),
	write_flavour(Forward),
write('                                                            .locc:.   ...                           '),nl,
write('                                                         .;lxxddo:;:olc;.                           '),nl,
write('                                                        ;xOlodxkxlcoxocll,.                         '),nl,
write('                                                      .,lO0xdddxkkdxxddoldl;;                       '),nl,
write('                                                     ;okkddkOxdolllooodoodolc.                      '),nl,
write('                                                    ;dOxocoxddlc:locccoxxol:.                       '),nl,
write('                                                     :xOOdccoo:lkxlccloddolc:.                      '),nl,
write('                                                    .oOkxxxoll:oOo;;;;cloc;;;.                      '),nl,
write('                                                   .,lxdcclc:lc::;;ldo::doc:;.                      '),nl,
write('                                                 ..;oooc;;;,;d0xlokK0kddool;.                       '),nl,
write('                                                  .,ol:loodlo0NXKXNNXXXOdol:. ....                  '),nl,
write('                                                    ;;..:dkoloxKNXKNWWOlc;;c:clool;                 '),nl,
write('                                                        ;oO0dok0O0NWWWx;c;,loddlc:;                 '),nl,
write('                                                        .;oOOddk0XWMWKook:.;lcc:;,,.                '),nl,
write('                                                          ;d0xxKWWXKxldkdc;;:c::;.        .....     '),nl,
write('                                                          ;:llccllokocl:;;..:c;,,.    ..;;oxkxc,.   '),nl,
write('                                                    ......;....  .dk;;;.   .co;;,:::cccoxk0KXX0o;.  '),nl,
write('                                      .....    .cdkkxdoc;,;      .lk:....;lxOOOOkO00OO000KXWWWWXxc; '),nl,
write('                                  .,:lx00xlc;;colccc;;..  .   .   .,:cdkKXNNNNKOO0OkOOO0NWWWWWNNNOo,'),nl,
write('                                ;lk0KK0KK0OO0xl,. ...            ,lx0KXNNNNNX000OkddddkXNNNWNNNNNN0o'),nl,
write('                              ;lkKX000KXNNNKo;.               .;lkKXXXXNNNNXOkOxllclox0KXXXNNNNNNNN0'),nl,
write('                             .o0K0kOKNNNNXk;.             .;cokO0KKXXNNNNNNKOxoc:;:cloox0KXNNNNNNNNN'),nl,
write('                            .;xkxkKNWNNXKd.          .,cooodoooolllooddk00K00kc,;,,,;:lkXNNNNNNNNNNN'),nl,
write('                            .:ccdKXXNX0Od.          .o0XXOkkO000Oxdlc:;;;:cloo,;,..;ckXNWWWNNNNNNNXX'),nl,
write('                          ..;,,l0K0kxold;          .l0KKKKKXNNNNNNXX0kdl:;,,,,....,o0NWWWNNXKKKXXXKk'),nl,
write('                       .:odxxc;:doc:;,co;......... .:OXXXXXK0KXNNNNNNNNXKOd:;....ck0KXXX0kkkk0KOxkxc'),nl,
write('                      .lkKKOKO:,::cdkOkc.......      .oKXXNNXKKKXXXXXNNNNNX0x;.,dKXKOxooox0XNNXkoxoc'),nl,
write('                     .,lO000K0l,;lONWN0c.             .c0XKKKKKKKXNX00KXXKKKKdcxXXkl;;lkXNNNNNNX0x:;'),nl,
write('               ...;:ldxdkKK0XKo,cOKXNXKx.        ....  .oxdxkkOOO00KK0000KXXXkoddl:cd0XNNX00KNNNNN0k'),nl,
write('            .,ldxk0KXXXK0KK0ko::llc::::;.  ...      ..  ;o:;;::lxOOO0XNK00XXX0l;;oOKXKK0kolokOKXNNNN'),nl,
write('            ;lOKKXXNNNNXXK0xc:;;,.                      ...     .,cox0XNXOk0XKx:dKKKKKko:coddxkOOOkk'),nl,
write('        ...,:okO00OO0XXXXOxoclcc,.         ...  ......              .,o0XXkld00xxOkkxl;;lkOOOxdddoc;'),nl,
write('    ..:dxddk0KXXKOxxxkKX0kdccooo;.        .       ........             :kK0o,:ol;:xk:.;:x0KXXKOxoodo'),nl,
write('  .,oOXNXXK0O0KKK0xddodkdodoloooc;                                     .lkko,.;;;,cocok0KKKK0OkOkdld'),nl,
write(' .:ONWNNXKK00KNNXXKOxoldoc:codool:;;   ...    ..                ..     ,oolc;;cclox0KXXNWWNNXKOkO0kd'),nl,
write(' ,kNNWNNNNNNXOdc:lk0KKK0xl,.;lolllcc,.;col;.;,co;.                ..   .coc:okOOKXXXXXXNNNNNNNNXXXXO'),nl,
write('.c0NNNNNNNNK0Oc;;;;lloxkxc;,;,;..,:okkollllcclk0kodc.             ...;,:odco00KXXXXXXK00KXNNNNNNNNXK'),nl,
write(',dKXXNNNNX0dkOxkxdxdc,;oxdolc. .;:;:ll;,cdodkOOl;cdooc;          .cllcc::;lOOdoOXXKK00kdxOKXNNNNNNNX'),nl,
write(':dO0XXXXX0l;;,;oooldooxxkO00xllloo:;,,;.,::;;;...;;cooc:;,..    .col:,..;cOKOkxdxk0K0xc;:d0XXXNNNNNN'),nl,
write('oOOk0000Oo;,:;c:,;;cdOKK000K0kkOOkoc;;...     .,ok00xlcloodddoodk000Ol;..lOOxol:,,:::;.;;:oOXNNNNNNN'),nl,
write('ck00KXXX0l;;.......,xKXN0kOkO0kdxkxo:;...   ..;xKKK0xd0KOkxdk0K0KK0OOkdc;coc,;;.;;....;;;lddx0XNNNNN'),nl,
	write('Battle Start!'),nl,
	boss_battle_loop.