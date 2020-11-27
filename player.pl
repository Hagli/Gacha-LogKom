:- include('store.pl').
:- include('DIO.pl').
:- include('quest.pl').

/* job yang mungkin */
job(swordsman).
job(archer).
job(sorcerer).

/* player stat */
/* player (name,job,weapon,armor,accesory,level,exp,attack,defense,hp,recovery) */
/* semua stat saat level 1 hanya ada dari equipment */
/*DEFINISI MAX HP*/
:- dynamic(max_hp/1).
max_hp(20).
:- dynamic(player/11).
createSwordsman(A) :-
	asserta(player(A,swordsman,rusty_sword,fur_armor,none,1,0,25,20,20,0)),
	mult_itemSave(5,hp_potion),!.
createArcher(A) :-
	asserta(player(A,archer,rusty_bow,fur_armor,none,1,0,20,20,20,0)),
	mult_itemSave(5,hp_potion),!.
createSorcerer(A) :-
	asserta(player(A,sorcerer,apprentice_book,fur_armor,none,1,0,20,20,20,0)),
	mult_itemSave(5,hp_potion),!.
	
lvl_up :-
	write('Level up!'),nl,
	call(player(Name,Job,Weapon,Armor,Acc,Lvl,Exp,Att,Def,Hp,Recc)),
	random(3,9,A),random(3,9,B),random(3,9,C), /*stat get modifier*/
	X is Att+1+A, Y is Def+1+B, Z is Hp+1+C, W is Lvl+1, V is Exp-5*Lvl,
	write('Level '),write(W),nl,
	write('Attack: '),write(X),nl,
	write('Defense: '),write(Y),nl,
	assertz(player(Name,Job,Weapon,Armor,Acc,W,V,X,Y,Z,Recc)),
	retract(player(Name,Job,Weapon,Armor,Acc,Lvl,Exp,Att,Def,Hp,Recc)),
	/*changing da max hp 8*/
	max_hp(HP), NewHP is HP+1+C,
	assertz(max_hp(NewHP)), retract(max_hp(HP)),
	write('HP: '),write(Z),write('/'),write(NewHP),nl.
	
/*player(my_boi,swordsman,rusty_sword,fur_armor,none,1,444,444,444,444,0).*/