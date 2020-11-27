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
	write('Dio '),write(' deal '),write(Z),write(' damage'),nl,
	write('AHAHAHAHA'),nl,!.
which_attack(1) :-
	write('Lihatlah kekuatanku!'),nl,
	write('DUNIAWI!!'),nl,
	enemy_boss(A,_,_,Att,_),
	call(player(O,N,M,L,K,J,I,H,G,F,E)),
	random(0,3,Plus),
	Z is Att + 30 - G + Plus,
	(Z<0 -> Z is 0;
	Z is Z),
	X is F - Z,
	write_boss_attack(Z),
	nl,nl,
	assertz(player(O,N,M,L,K,J,I,H,G,X,E)),
	retract(player(O,N,M,L,K,J,I,H,G,F,E)).
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
	write('WWWWRRRYYYYYYYYY'),nl,
	enemy_boss(A,_,_,Att,_),
	call(player(O,N,M,L,K,J,I,H,G,F,E)),
	random(0,3,Plus),
	Z is Att + 5 - G + Plus,
	(Z<0 -> Z is 0;
	Z is Z),
	X is F - Z,
	write_boss_attack(Z),
	nl,nl,
	assertz(player(O,N,M,L,K,J,I,H,G,X,E)),
	retract(player(O,N,M,L,K,J,I,H,G,F,E)).
boss_attack :-
	random(1,10,Z),
	which_attack(Z),
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
	write('Battle Start!'),nl,
	boss_battle_loop.