:- dynamic(enemy/5).
get_enemy :-
	random(0,99,X),
	player(_,_,_,_,_,Level,_,_,_,_,_),
	Bronto is Level+3,
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
	Z is Y + 3 - Def + Plus,
	X is HP - Z,
	write('Deal '),write(Z),write(' damage'),nl,nl,
	assertz(enemy(A,Lv,X,Att,Def)),
	retract(enemy(A,Lv,HP,Att,Def)).
/*attack :-
	call(enemy(A,Lv,HP,Att,Def)),
	retract(enemy(A,Lv,HP,Att,Def)),!.*/
battle_loop :-
	call(enemy(A,Y,Hp,Att,Def)),
	Hp =< 0,write('Musuh telah dikalahkan'),
	retract(enemy(A,Y,Hp,Att,Def)),!.
battle_loop :-
	call(enemy(A,Y,Hp,Att,Def)),
	call(player(_,_,_,_,_,_,_,B,C,D,E)),
	write('HP: '),write(D),write('                   HP musuh: '),write(Hp),nl,
	write('Attack: '),write(B),write('                   Attack musuh: '),write(Att),nl,
	write('Defense: '),write(C),write('                   Defense musuh: '),write(Def),nl,
	write('Apa yang akan kau lakukan?'),nl,
	write('-> Attack (Command = attack.)'),nl,
	write('-> Special Attack (Command = sp_attack.)'),nl,
	write('-> Use Potion (Command = blm dibuat)'),nl,
	write('-> Run (Command = nigeru. :)'),nl,
	read(Choice),nl,
	(
        Choice='attack' -> attack;
		Choice=2 -> randompick
    ),battle_loop.
start_battle :-
	get_enemy,
	call(enemy(A,Y,Hp,Att,Def)),
	write('Sebuah level '),write(Y),write(' '),write(A), write(' telah muncul!'),nl,
	battle_loop.