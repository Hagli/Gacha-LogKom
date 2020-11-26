:- dynamic(posisiP/2).
lebarMap(10).
panjangMap(10).
posisiP(1,1).
posisiS(5,6).
posisiQ(2,4).
upline(P,_) :- P=:=0.
leftline(_,L) :- L=:=0.
downline(P,_) :- P1 is P-1, lebarMap(P1),!.
rightline(_,L) :- L1 is L-1, panjangMap(L1),!.

map(P,L) :- downline(P,L), rightline(P,L),write('#'),nl,!.
map(P,L) :- rightline(P,L), write('#'),nl,!.
map(P,L) :- upline(P,L), write('#'),!.
map(P,L) :- leftline(P,L), write('#'),!.
map(P,L) :- downline(P,L), write('#'),!.
map(P,L) :- posisiP(P,L), write('P'),!.
map(P,L) :- posisiS(P,L), write('S'),!.
map(P,L) :- posisiQ(P,L), write('Q'),!.
map(_,_) :- write('.'),!.

printmap :- 
	panjangMap(P), PP is P+1,
	lebarMap(L), LL is L+1,
	forall(between(0,PP,X),
		(forall(between(0,LL,Y),
			(map(X,Y)))
		)),!.
	
	
w :- retract(posisiP(X,Y)),
	(X = 1 -> asserta(posisiP(X,Y)); 
	Z is X-1, asserta(posisiP(Z,Y))),
	printmap,
	random(0,3,Tea),
	(Tea < 2 -> start_battle;
	write('Tidak ada musuh di sekitarmu')).
s :- retract(posisiP(X,Y)),
	(X = 10 -> asserta(posisiP(X,Y)); 
	Z is X+1, asserta(posisiP(Z,Y))),
	printmap,
	random(0,6,Tea),
	(Tea < 2 -> start_battle;
	write('Tidak ada musuh di sekitarmu')).
a :- retract(posisiP(X,Y)),
	(Y = 1 -> asserta(posisiP(X,Y)); 
	Z is Y-1, asserta(posisiP(X,Z))),
	printmap,
	random(0,6,Tea),
	(Tea < 2 -> start_battle;
	write('Tidak ada musuh di sekitarmu')).
d :- retract(posisiP(X,Y)),
	(Y = 10 -> asserta(posisiP(X,Y)); 
	Z is Y+1, asserta(posisiP(X,Z))),
	printmap,
	random(0,6,Tea),
	(Tea < 2 -> start_battle;
	write('Tidak ada musuh di sekitarmu')).
	
	
show_stat :-
	player(A,B,C,D,E,F,G,H,I,J,K),
	write('Name: '),write(A),nl,
	write('Job: '),write(B),nl,
	write('Weapon: '),write(C),nl,
	write('Armor: '),write(D),nl,
	write('Accesory: '),write(E),nl,
	write('Level: '),write(F),nl,
	write('Exp: '),write(G),nl,
	write('Attack: '),write(H),nl,
	write('Defense: '),write(I),nl,
	write('HP: '),write(J),nl,
	write('Recovery: '),write(K).