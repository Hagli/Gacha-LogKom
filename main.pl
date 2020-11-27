:-include('player.pl').
:- dynamic(playing/1).
playing(0).
inGame:- playing(X), X=1.
play:-
    
write('███████╗██╗███╗░░██╗░█████╗░██╗░░░░░  ██████╗░██╗███████╗░█████╗░██████╗░██████╗░███████╗'),nl,
write('██╔════╝██║████╗░██║██╔══██╗██║░░░░░  ██╔══██╗██║╚════██║██╔══██╗██╔══██╗██╔══██╗██╔════╝'),nl,
write('█████╗░░██║██╔██╗██║███████║██║░░░░░  ██████╦╝██║░░███╔═╝███████║██████╔╝██████╔╝█████╗░░'),nl,
write('██╔══╝░░██║██║╚████║██╔══██║██║░░░░░  ██╔══██╗██║██╔══╝░░██╔══██║██╔══██╗██╔══██╗██╔══╝░░'),nl,
write('██║░░░░░██║██║░╚███║██║░░██║███████╗  ██████╦╝██║███████╗██║░░██║██║░░██║██║░░██║███████╗'),nl,
write('╚═╝░░░░░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝╚══════╝  ╚═════╝░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝'),nl,

write('░█████╗░██████╗░██╗░░░██╗███████╗███╗░░██╗████████╗██╗░░░██╗██████╗░███████╗'),nl,
write('██╔══██╗██╔══██╗██║░░░██║██╔════╝████╗░██║╚══██╔══╝██║░░░██║██╔══██╗██╔════╝'),nl,
write('███████║██║░░██║╚██╗░██╔╝█████╗░░██╔██╗██║░░░██║░░░██║░░░██║██████╔╝█████╗░░'),nl,
write('██╔══██║██║░░██║░╚████╔╝░██╔══╝░░██║╚████║░░░██║░░░██║░░░██║██╔══██╗██╔══╝░░'),nl,
write('██║░░██║██████╔╝░░╚██╔╝░░███████╗██║░╚███║░░░██║░░░╚██████╔╝██║░░██║███████╗'),nl,
write('╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░╚══╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝'),nl,
write('-----------------------------------------------------------------------------'),nl,
write('Guide :'),nl,
write('1. command w : gerak ke utara 1 langkah'),nl,
write('2. command a : gerak ke barat 1 langkah'),nl,
write('3. command s : gerak ke selatan 1 langkah'),nl,
write('4. command d : gerak ke timur 1 langkah'),nl,
write('6. command show_stat : untuk menunjukkan stat pemain saat ini'),nl,
write('7. command show_inventory : untuk melihat daftar inventory yang dimiliki'),nl,
write('8. command equip(something) : untuk menggunakan sebuah equipment'),nl,
write('9. command store : untuk masuk ke dalam toko. Harus berada di tempat yang sama'),nl,
write('10. command quest : untuk mengambil quest di guild'),nl,
write('11. command show_quest : untuk melihat quest yang sedang diambil'),nl,
write('12. command fight_the_boss : untuk melawan boss terakhir'),nl,nl,
write('To start playing, enter "start." command.'),nl.

start:-
 write('Welcome! choose your class (enter by number):'),nl,
 write('1. swordsman'),nl,
 write('2. archer'),nl,
 write('3. sorcerer'),nl,
 read(Input),(
     Input=1 -> character_create_swordsman;
     Input=2 -> character_create_archer;
     Input=3 -> character_create_sorcerer
 ),!.

 character_create_swordsman:-
    write('Enter your name :'),nl,
    read(Name),
    createSwordsman(Name),
    story(Name).
 character_create_archer:-
    write('Enter your name :'),nl,
    read(Name),
    createSwordsman(Name),
    story(Name).
 character_create_sorcerer:-
    write('Enter your name :'),nl,
    read(Name),
    createSwordsman(Name),
    story(Name).

story(Name):-
   retract(playing(0)), asserta(playing(1)),
    nl,nl,
    write('Aincrad, 2023'),nl,
    sleep(1),
    write('Sudah setahun sejak pembuat game ini menjebak kami di dunia virtual ini. Dia menjebak 10.000 orang di game yang sangat mengerikan ini—dimana jika mati di game ini maka kami akan mati di dunia nyata—tanpa alasan yang jelas. Kami hanya bisa keluar dari game ini jika telah mengalahkan bos di setiap lantai. Mungkin terdengar gampang, tapi melawan 100 bos itu sangat sulit. Kami telah kehilangan lebih dari setengah pemain.'),nl,nl,
    sleep(1),
    write('Aku, '),write(Name),write(' adalah salah satu pemain yang berusaha untuk keluar dari game ini. Aku memutuskan untuk berkelana sendirian agar tidak ada korban lain yang tidak di perlukan.'),nl,
    write('Terakhir kali aku melakukan petualangan seperti ini, aku kehilangan ketiga temanku. Iggy, Avdol, dan Kakyoin. Aku tidak ingin kehilangan siapapun lagi.'),nl,nl,
    sleep(2),
    write('Sekarang aku berada di lantai ke 44. Pegunungan yang diselimuti salju ini dipenuhi oleh slime, goblin, dan wolf. Pada ujung lantai ini,  pintu menuju lantai selanjutnya dijaga oleh seekor naga bernama DIO yang sampai sekarang belum pernah dikalahkan siapa-siapa.'),nl,nl,
    sleep(1),
    write('Karena mekanisme yang me-reward kreativitas pemain, playerbase game ini dapat memecah class character menjadi 3 : swordsman, archer, dan sorcerer. Sorcerer mungkin adalah class yang aneh di game ini,tetapi hal tersebut mungkin dilakukan dengan mengambil tongkat sihir yang biasanya dipakai oleh goblin di lantai 34.'),nl,nl,
    sleep(2),
    write('Aku rasa, siapapun bisa mengalahkan naga ini, tetapi tidak ada yang berani. Oleh karena itulah, aku sendiri yang akan mengalahkannya.'),nl,nl,nl,
    sleep(3),
    printmap.