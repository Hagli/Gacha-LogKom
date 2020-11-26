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
	
	
attack :-
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
	
	
enemy_attack :-
	enemy(A,_,_,Att,_),
	call(player(O,N,M,L,K,J,I,H,G,F,E)),
	random(0,3,Plus),
	Z is Att + 3 - G + Plus,
	(Z<0 -> Z is 0; Z is Z),
	X is F - Z,
	(Z =< 0 -> (write('Kau menghindari serangan musuh '), write(A));
	(write('Musuh '), write(A),write(' deal '),write(Z),write(' damage'))),
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
	cooldown(0),
	random(2,5,Z),
	sp_attack_do(Z),
	assertz(cooldown(4)),
	retract(cooldown(0)).
sp_attack :-
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
/*nigerun(X) :-
	X > 1,
	tambahan_nigeru,!.
nigerun(1) :-
	write('Gagal kabur'),nl.*/
nigeru :-
	random(1,3,Z),
	(Z > 1 -> tambahan_nigeru;
	write('Gagal kabur...')).
	
	
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
	retract(run(_)),!.
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
	write('HP: '),write(D),write('                   HP musuh: '),write(Hp),nl,
	write('Attack: '),write(B),write('                   Attack musuh: '),write(Att),nl,
	write('Defense: '),write(C),write('                   Defense musuh: '),write(Def),nl,
	write('Apa yang akan kau lakukan?'),nl,
	write('-> Attack (Command = attack.)'),nl,
	write('-> Special Attack (Command = sp_attack.)'),nl,
	write('-> Use Potion (Command = blm dibuat)'),nl,
	write('-> Run (Command = nigeru. :)'),nl,
	read(Choice),nl,
	battle_choice(Choice),call(enemy(_,_,H,_,_)),
	(H > 0 -> enemy_attack; 2 =:= 2),
	call(cooldown(Mate)),
	(Mate = 0 -> Mates is 0; Mates is Mate-1),
	asserta(cooldown(Mates)),
	retract(cooldown(Mate)), 
	battle_loop.
	
battle_choice(attack) :-
	attack,!.
battle_choice(sp_attack) :-
	sp_attack,!.
battle_choice(nigeru) :-
	nigeru,!.
battle_choice(_) :-
	write('Kau kehilangan keseimbanganmu!'),nl,
	write('Musuhmu menggunakan kesempatan ini untuk menyerang!'),nl.
	

start_battle :-
	get_enemy,
	asserta(cooldown(0)), /*untuk sp_attack cooldown*/
	assertz(run(0)), /*menandakan apakah player berhasil lari atau tdk*/
	call(enemy(A,Y,_,_,_)),
	write('Sebuah level '),write(Y),write(' '),write(A), write(' telah muncul!'),nl,
	battle_loop,
	call(player(_,_,_,_,_,Lv,Exp,_,_,_,_)),
	Lvli is 5*Lv, Exp >= Lvli, lvl_up.