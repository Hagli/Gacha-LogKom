:- include('store.pl').
:- include('battle.pl').

/* job yang mungkin */
job(swordsman).
job(archer).
job(sorcerer).

/* player stat */
/* player (name,job,weapon,armor,accesory,level,exp,attack,defense,hp,recovery) */
/* semua stat saat level 1 hanya ada dari equipment */
:- dynamic(player/11).
createSwordsman(A) :-
	asserta(player(A,swordsman,rusty_sword,fur_armor,none,1,0,25,20,20,0)),
	mult_itemSave(5,hp_potion),!.
createArcher(A) :-
	asserta(player(A,archer,rusty_bow,fur_armor,none,1,0,20,20,20,0)),
	mult_itemSave(5,hp_potion),!.
createSorcerer(A) :-
	asserta(player(A,sorcerer,apprentice_book,fur_armor,0,1,0,20,20,20,0)),
	mult_itemSave(5,hp_potion),!.
player(my_boi,swordsman,rusty_sword,fur_armor,none,1,0,25,20,20,0).