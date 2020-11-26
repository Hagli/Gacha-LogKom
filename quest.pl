:- dynamic(questing/3).
questing(-1,-1,-1). /*state saat blm ada quest yang diterima*/
quest :-
	posisiP(X,Y),
	(\+posisiQ(X,Y)-> write('You are not at the guild.'),nl;
    posisiQ(X,Y)->quest_get
    ).
	
quest_choice(no,_,_,_) :-
	write('Quest tidak diterima'),!.
quest_choice(yes,A,B,C) :-
	assertz(questing(A,B,C)),
	retract(questing(-1,-1,-1)),
	write('Quest telah diterima'),
	X is A*5+B*7+C*9, Y is A*10+B*14+C*20,
	assertz(reward(X,Y)),!.
	
quest_get :-
	questing(-1,-1,-1),
	random(1,3,A),random(1,3,B),random(1,3,C),
	write('Bunuh '),write(A),write(' slime'),nl,
	write('Bunuh '),write(B),write(' goblin'),nl,
	write('Bunuh '),write(C),write(' wolf'),nl,
	write('Terima quest ini ?(yes/no)'),nl,
	read(Well),quest_choice(Well,A,B,C),!.
quest_get :-
	write('Sudah ada quest lain yang belum diselesaikan').
	
write_quest(-1,-1,-1) :-
	write('Tidak ada quest yang aktif'),!.
write_quest(A,B,C) :-
	write('Questmu adalah:'),nl,
	write('Bunuh '),write(A),write(' slime'),nl,
	write('Bunuh '),write(B),write(' goblin'),nl,
	write('Bunuh '),write(C),write(' wolf'),nl.
show_quest :-
	questing(A,B,C),write_quest(A,B,C).
	
quest_finish(0,0,0) :-
	write('Quest telah selesai!'),nl,
	retract(questing(0,0,0)),
	asserta(questing(-1,-1,-1)),
	retract(reward(A,B)),
	player(Name,Class,Weapom,Armor,Acc,Lv,Exp,Attack,Defense,Hpe,Recc),
	money(Count),
	Expi is Exp+A,Counti is Count+B,
	asserta(player(Name,Class,Weapom,Armor,Acc,Lv,Expi,Attack,Defense,Hpe,Recc)),
	retract(player(Name,Class,Weapom,Armor,Acc,Lv,Exp,Attack,Defense,Hpe,Recc)),
	write('Kau mendapatkan tambahan '),write(A),write(' exp'),nl,
	asserta(money(Counti)),retract(money(Count)),
	write('Kau mendapatkan tambahan '),write(B),write(' money'),nl,!.
quest_finish(-1,-1,-1) :-
	questing(_,_,_),!.
quest_finish(_,_,_) :-
	write('Quest belum selesai'),nl.
	
quest_part_done(slime) :-
	questing(A,C,D),
	A > 0, B is A-1, asserta(questing(B,C,D)),retract(questing(A,C,D)),!.
quest_part_done(goblin) :-
	questing(C,A,D),
	A > 0, B is A-1, asserta(questing(C,B,D)),retract(questing(C,A,D)),!.
quest_part_done(wolf) :-
	questing(D,C,A),
	A > 0, B is A-1, asserta(questing(D,C,B)),retract(questing(D,C,A)),!.
quest_part_done(_) :-
	questing(_,_,_).
	