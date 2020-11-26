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
    money(Count),
    Remainder is Count-500,
    write('What do you want to buy? (input with number)'),
    nl,
    write('1. Gacha (500 gold)'),
    nl,
    write('2. HP Potion (50 gold)'),
    nl,
    read(Input),
    (
        Input=1 -> Remainder is Count-500,(
            Remainder < 0 -> write('Uang anda tidak cukup.');
            Remainder >= 0 -> randompick, retract(money(_)), asserta(money(Remainder))
        );
        Input=2 -> Remainder is Count-50,(
            Remainder < 0 -> write('Uang anda tidak cukup.');
            Remainder >= 0 -> itemSave(hp_potion),retract(money(_)), asserta(money(Remainder))
        )
    ).
