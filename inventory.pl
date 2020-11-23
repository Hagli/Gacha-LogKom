/* inventory.pl */
/* Mendefinisikan inventory dengan 100 space */
:- dynamic(space_Filled/1).
inventory(X) :- space_Filled(X).
space_Filled(0).

/* Cek item di inventory */
:- dynamic(kept/2).
check_inventory(X) :- kept(X,Y), Y > 0.

/*Definisi menyimpan item */
itemSave(X):-  (inventory(Filled), Filled < 100 ->
                (kept(X,Y) -> retract(kept(X,Y)), Z is Y+1,
                asserta(kept(X,Z)), retract(space_Filled(Filled)),
                NewFilled is Filled + 1, asserta(space_Filled(NewFilled));
                asserta(kept(X,1)), retract(space_Filled(Filled)),
                NewFilled is Filled + 1, asserta(space_Filled(NewFilled))),
                write('Item telah disimpan ke dalam inventory.'), nl;
                write('Inventory penuh.'), nl).
/* Menghitung jumlah item spesifik */
count_item(Item,Count) :- kept(Item,Count).
