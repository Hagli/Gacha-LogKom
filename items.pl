/* Tugas Besar Logika Komutasional*/
:- discontiguous(item/9).
/* [ID],[TYPE],[NAMA],[ATTACK],[DEFENSE],[HP],[RECOVERY],[RARITY],[CLASS COMPABILITY] */
/* ITEM SENJATA */
item(1,weapon,rusty_sword,25,0,0,0,common,swordsman).
item(2,weapon,rusty_katana,30,0,0,0,common,swordsman).
item(3,weapon,shinogi_zukuri,50,0,0,0,common,swordsman).
item(4,weapon,kissaki_moroha_zukuri,70,0,0,0,uncommon,swordsman).
item(5,weapon,elucidator,100,0,0,0,rare,swordsman).
item(6,weapon,dragon_slayer,150,0,0,0,rare,swordsman).
item(7,weapon,excalibur,200,0,0,0,legendary,swordsman).

item(8,weapon,rusty_bow,20,0,0,0,common,archer).
item(9,weapon,short_bow,30,0,0,0,common,archer).
item(10,weapon,long_bow,40,0,0,0,uncommon,archer).
item(11,weapon,pinaka,100,0,0,0,rare,archer).
item(12,weapon,gandiva,200,0,0,0,rare,archer).
item(13,weapon,sharanga,250,0,0,0,legendary,archer).
item(14,weapon,gusisnautar,300,0,0,0,legendary,archer).

item(15,weapon,apprentice_book,20,0,0,0,common,sorcerer).
item(16,weapon,magic_staff,30,0,0,0,common,sorcerer).
item(17,weapon,caduceus,60,0,0,0,uncommon,sorcerer).
item(18,weapon,nehustan,90,0,0,0,uncommon,sorcerer).
item(19,weapon,was,150,0,0,0,rare,sorcerer).
item(20,weapon,kaladanda,200,0,0,0,rare,sorcerer).
item(21,weapon,merlins_staff,250,0,0,0,legendary,sorcerer).

/*ITEM ARMOR*/
item(22,armor,fur_armor,0,20,20,0,common,all).

item(23,armor,chainmail_armor,0,40,30,0,uncommon,warrior).
item(24,armor,iron_armor,0,70,40,0,rare,warrior).
item(25,armor,steel_armor,0,100,60,0,legendary,warrior).

item(26,armor,leather_armor,0,20,40,0,uncommon,archer).
item(27,armor,elven_armor,0,40,60,0,rare,archer).
item(28,armor,amber_armor,0,60,100,0,legendary,archer).

item(29,armor,mage_robe,0,20,40,0,uncommon,sorcerer).
item(30,armor,archmage_robe,0,30,60,0,rare,sorcerer).
item(31,armor,jotunn,0,50,90,legendary,sorcerer).

/*ACCESORY*/
item(32,accessory,necklace,0,0,20,0,common,all).
item(33,accessory,ring,0,10,10,0,common,all).
item(34,accessory,earrings,0,5,15,0,common,all).

/*POTION*/
item(35,potion,hp_potion,0,0,0,50,common,all).

/*DROP CHANCE*/
rarity(1,common).
rarity(2,common).
rarity(3,common).
rarity(4,common).
rarity(5,uncommon).
rarity(6,uncommon).
rarity(7,uncommon).
rarity(8,rare).
rarity(9,rare).
rarity(10,legendary).

/*RARITY LISTING*/
/*[RARITY],[RARITY_ID],[ITEM_ID] */
rarity_list(common,1,1).
rarity_list(common,2,2).
rarity_list(common,3,3).
rarity_list(common,4,8).
rarity_list(common,5,9).
rarity_list(common,6,15).
rarity_list(common,7,16).
rarity_list(common,8,22).
rarity_list(common,9,32).
rarity_list(common,10,33).
rarity_list(common,11,34).

rarity_list(uncommon,1,4).
rarity_list(uncommon,2,10).
rarity_list(uncommon,3,17).
rarity_list(uncommon,4,18).
rarity_list(uncommon,5,23).
rarity_list(uncommon,6,26).
rarity_list(uncommon,7,29).

rarity_list(rare,1,5).
rarity_list(rare,2,6).
rarity_list(rare,3,11).
rarity_list(rare,4,12).
rarity_list(rare,5,19).
rarity_list(rare,6,20).
rarity_list(rare,7,24).
rarity_list(rare,8,27).
rarity_list(rare,9,30).

rarity_list(legendary,1,7).
rarity_list(legendary,2,13).
rarity_list(legendary,3,14).
rarity_list(legendary,4,21).
rarity_list(legendary,5,25).
rarity_list(legendary,6,28).
rarity_list(legendary,7,31).


/*Gacha System*/
randompick:-
    random(1,11,X),
    rarity(X,Rarepick),
    (Rarepick=common -> random(1,12,Y);
    Rarepick=uncommon -> random(1,8,Y);
    Rarepick=rare -> random(1,10,Y);
    Rarepick=legendary ->random(1,8,Y)
    ),
    rarity_list(Rarepick,Y,ITEM_ID),
    item(ITEM_ID,Type,Name,Attack,Defense,HP,_,_,Class),
    write('Congrats! you got : '),write(Name),write(' ('),write(Rarepick),write(')'),nl,
    write('**Item Stat**'),nl,
    write('Type : '),write(Type),nl,
    write('Attack : '),write(Attack),nl,
    write('Defense : '),write(Defense),nl,
    write('HP : '),write(HP),nl,
    write('Class Compability : '),write(Class),nl,
    itemSave(Name).



