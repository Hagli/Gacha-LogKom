/* inventory.pl */
/* Mendefinisikan inventory dengan 100 space */
:- dynamic(space_filled/1).
inventory(X) :- space_filled(X).

/* Cek item di inventory */
:- dynamic(kept/2).
check_inventory(X) :- kept(X,Y), Y > 0.

/*Definisi menyimpan item */
item_save(X):-  (inventory(filled), filled < 100 ->
                (kept(X,Y) -> retract(kept(X,Y)), Z is Y+1,
                asserta(kept(X,Z)), retract(filledSpace(filled)),
                Newfilled is filled + 1, asserta(filledSpace(Newfilled));
                asserta(kept(X,1)), retract(filledSpace(filled)),
                Newfilled is filled + 1, asserta(filledSpace(Newfilled))),
                write('Item telah disimpan ke dalam inventory'), nl;
                write('Inventory penuh'), nl).
/* Menghitung jumlah item spesifik */
count_item(Item,Count) :- kept(Item,Count).

/* Menyimpan banyak item ke inventory */
/*mult_item_save(1,X) :- */
/*	item_save(X). */
/*mult_item_save(Y,X) :- */
/*	item_save(X), */
/*	Z is Y-1, */
/*	mult_item_save(Z,X). */