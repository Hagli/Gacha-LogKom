/*TUBES LOGKOM*/
/*include map.pl, player.pl, inventory.pl*/
:- include('items.pl').
:- include('inventory.pl').
:- include('map.pl').


store:-
    posisiP(X,Y),
    (\+posisiS(X,Y)-> write('You are not at the shop.'),nl;
    posisiS(X,Y)->serve
    ).

serve:-
    write('What do you want to buy? (input with number)'),
    nl,
    write('1. Gacha (500 gold)'),
    nl,
    write('2. HP Potion'),
    nl,
    read(Input),
    (
        Input=1 -> randompick;
        Input=2 -> item_save(hp_potion)
    ).