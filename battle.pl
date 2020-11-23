:- dynamic(enemy/5).
get_enemy :-
	random(0,99,X),
	random(2,5,Y),
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
	attP(Y),
	call(enemy(A,Lv,HP,Att,Def)),
	Z is Y + 3 - Def,
	Z < HP,!,
	X is HP - Z,
	write('Deal '),write(Z),write(' damage'),
	assertz(enemy(A,Lv,X,Att,Def)),
	retract(enemy(A,Lv,HP,Att,Def)),!.
attack :-
	call(enemy(A,Lv,HP,Att,Def)),
	retract(enemy(A,Lv,HP,Att,Def)),!.