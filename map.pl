:- dynamic(player/2).
lebarMap(10).
panjangMap(10).
posisiP(1,1).
posisiS(5,6).
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
map(_,_) :- write('.'),!.

printmap :- 
	panjangMap(P), PP is P+1,
	lebarMap(L), LL is L+1,
	forall(between(0,PP,X),
		(forall(between(0,LL,Y),
			(map(X,Y)))
		)),!.
	