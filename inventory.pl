/* inventory.pl */
/* Mendefinisikan inventory dengan 100 space */
:- dynamic(space_Filled/1).
inventory(X) :- space_Filled(X).
space_Filled(0).
/* Cek item di inventory */
:- dynamic(kept/2).
check_inventory(X) :- kept(X,Y), Y > 0.

/*HERE COMES THE MONEEEEEEEEEEEEEEEEEEEH */
:-dynamic(money/1).
money(2000).
/*Definisi menyimpan item */
itemSave(X):-  (inventory(Filled), Filled < 100 ->
                (kept(X,Y) -> retract(kept(X,Y)), Z is Y+1,
                asserta(kept(X,Z)), retract(space_Filled(Filled)),
                NewFilled is Filled + 1, asserta(space_Filled(NewFilled));
                asserta(kept(X,1)), retract(space_Filled(Filled)),
                NewFilled is Filled + 1, asserta(space_Filled(NewFilled))),
                write(X), write(' telah disimpan ke dalam inventory.'), nl;
                write('Inventory penuh.'), nl).
/* Menghitung jumlah item spesifik */
count_item(Item,Count) :- kept(Item,Count).

/* Simpan multiple item */
mult_itemSave(1,X) :-
	itemSave(X).
mult_itemSave(Y,X) :-
	itemSave(X),
	Z is Y-1,
	mult_itemSave(Z,X).

show_inventory:-
    inGame,
    write('Item yang ada di inventory anda :'),nl,
    forall(kept(X,_),
        print_items(X)
    ).
print_items(X):-
    kept(X,Y),
    item(_,A,X,_,_,_,_,B,Z),
    write('- '),write(Y),write(' '),write(X),write(' ( Type : '),write(A),write('; Rarity : '),write(B),write('; Class : '),write(Z),write(' )'),nl.

discard(X):-
    inGame,
    (
        \+ kept(X,_) -> write('Anda tidak memiliki item tersebut.'),nl;
        kept(X,_) -> truly_discard(X)
    ).

truly_discard(X):-
    kept(X,Y), NewY is Y-1,
    (
        NewY=0 -> retract(kept(X,Y));
        NewY>0 -> retract(kept(X,Y)), assertz(kept(X,NewY))
    ),
    inventory(Filled), NewFilled is Filled-1,
    retract(space_Filled(Filled)),
    asserta(space_Filled(NewFilled)).

equip(X):-
    inGame,
    (\+kept(X,Y)->write('Anda tidak memiliki equipment itu.'),nl;
    kept(X,Y)->lanjut_equip(X)
    ),!.

lanjut_equip(X):-
    kept(X,Y),
    (
        Y=<0 -> write('Anda tidak memiliki equipment itu.'),nl;
        Y>0 -> equip_class_check(X)
    ).
equip_class_check(X):-
    item(_,_,X,_,_,_,_,_,Class),
    player(_,PlayerClass,_,_,_,_,_,_,_,_,_),
    (
        Class=PlayerClass -> change_equip(X);
        Class=all ->change_equip(X);
        \+ Class=PlayerClass -> write('Anda tidak bisa menggunakan equipment itu.'),nl
    ).
change_equip(X):-
    item(_,Type,X,_,_,_,_,_,_),
    (
        Type=weapon -> change_weapon(X);
        Type=armor -> change_armor(X);
        Type=accessory -> change_acc(X)
    ).
change_weapon(X):-
    item(_,_,X,Atk,_,_,_,_,_),
    kept(X,Y),
    player(A,B,OldWeapon,C,D,E,F,OldAtk,G,H,I),
    item(_,_,OldWeapon,OldWeaponAtk,_,_,_,_,_),
    NewAtk is OldAtk-OldWeaponAtk+Atk,
    NewY is Y-1,
    /*player ganti senjata*/
    retract(player(A,B,OldWeapon,C,D,E,F,OldAtk,G,H,I)),
    asserta(player(A,B,X,C,D,E,F,NewAtk,G,H,I)),
    /*ganti inventory*/
    retract(kept(X,Y)),
    (
        NewY > 0 -> asserta(kept(X,NewY)),change_inventory(OldWeapon,OldQty);
        NewY = 0 -> change_inventory(OldWeapon,OldQty)
    ).
    

change_inventory(OldWeapon,OldQty):-
    (
        \+kept(OldWeapon,OldQty) -> asserta(kept(OldWeapon,1));
        kept(OldWeapon,OldQty) -> retract(kept(OldWeapon,OldQty)),NewOldQty is OldQty+1 ,asserta(kept(OldWeapon,NewOldQty))
    ).

change_armor(X):-
    item(_,_,X,_,Def,HP,_,_,_),
    kept(X,Y),
    player(A,B,C,OldWeapon,D,E,F,G,OldDef,OldHP,H),
    item(_,_,OldWeapon,_,OldWeaponDef,OldWeaponHP,_,_,_),
    NewDef is OldDef-OldWeaponDef+Def,
    NewHP is OldHP-OldWeaponHP+HP,
    NewY is Y-1,
    /*player ganti senjata*/
    retract(player(A,B,C,OldWeapon,D,E,F,G,OldDef,OldHP,H)),
    asserta(player(A,B,C,X,D,E,F,G,NewDef,NewHP,H)),
    /*ganti inventory*/
    retract(kept(X,Y)),
    (
        NewY > 0 -> asserta(kept(X,NewY)),change_inventory(OldWeapon,OldQty);
        NewY = 0 -> change_inventory(OldWeapon,OldQty)
    ),
    /*MAX HP change*/
    max_hp(OldMaxHP),
    NewMaxHp is OldMaxHP-OldWeaponHP+HP,
    retract(max_hp(OldMaxHP)), asserta(max_hp(NewMaxHp)).

change_acc(X):-
    player(_,_,_,_,OldWeapon,_,_,_,_,_,_),
    (
        OldWeapon=none -> change_acc_none(X);
        \+OldWeapon=none -> change_acc_lanjutan(X)
    ).

change_acc_none(X):-
    item(_,_,X,Atk,Def,HP,_,_,_),
    kept(X,Y),
    player(A,B,C,D,OldWeapon,E,F,OldAtk,OldDef,OldHP,H),
    /*new stat*/
    NewAtk is OldAtk+Atk,
    NewDef is OldDef+Def,
    NewHP is OldHP+HP,
    NewY is Y-1,
    /*player ganti senjata*/
    retract(player(A,B,C,D,OldWeapon,E,F,OldAtk,OldDef,OldHP,H)),
    asserta(player(A,B,C,D,X,E,F,NewAtk,NewDef,NewHP,H)),
    /*ganti inventory*/
    retract(kept(X,Y)),
    (
        NewY > 0 -> asserta(kept(X,NewY));
        NewY = 0 -> write('') /*do nothing*/
    ),
    inventory(Filled),
    NewFilled is Filled-1,
    asserta(space_Filled(NewFilled)),
    retract(space_Filled(Filled)),
    /*MAX HP change*/
    max_hp(OldMaxHP),
    NewMaxHp is OldMaxHP+HP,
    retract(max_hp(OldMaxHP)), asserta(max_hp(NewMaxHp)).

change_acc_lanjutan(X):-
    item(_,_,X,Atk,Def,HP,_,_,_),
    kept(X,Y),
    player(A,B,C,D,OldWeapon,E,F,OldAtk,OldDef,OldHP,H),
    item(_,_,OldWeapon,OldWeaponAtk,OldWeaponDef,OldWeaponHP,_,_,_),
    /*new stat*/
    NewAtk is OldAtk-OldWeaponAtk+Atk,
    NewDef is OldDef-OldWeaponDef+Def,
    NewHP is OldHP-OldWeaponHP+HP,
    NewY is Y-1,
    /*player ganti senjata*/
    retract(player(A,B,C,D,OldWeapon,E,F,OldAtk,OldDef,OldHP,H)),
    asserta(player(A,B,C,D,X,E,F,NewAtk,NewDef,NewHP,H)),
    /*ganti inventory*/
    retract(kept(X,Y)),
    (
        NewY > 0 -> asserta(kept(X,NewY)),change_inventory(OldWeapon,OldQty);
        NewY = 0 -> change_inventory(OldWeapon,OldQty)
    ),
    /*MAX HP change*/
    max_hp(OldMaxHP),
    NewMaxHp is OldMaxHP-OldWeaponHP+HP,
    retract(max_hp(OldMaxHP)), asserta(max_hp(NewMaxHp)).