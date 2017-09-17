(
var dir;

dir = '/home/furenku/Musica/perpetual_bug/INSTRUMENT/experimental/';


/*( dir ++ 'midi_basic/boot.scd' ).load;*/
( dir ++ 'synths/drumkits/drumkit01.scd' ).load;
( dir ++ 'synths/synthtests01.scd' ).load;

( dir ++ 'midi_basic/midi_basic.scd' ).load;
( dir ++ 'interaction/players.scd' ).load;
( dir ++ 'interaction/player1.scd' ).load;

( dir ++ 'interaction/oscpad_setup.scd' ).load;
( dir ++ 'interaction/modes/mode_chooseChannelInstrument.scd' ).load;

)
