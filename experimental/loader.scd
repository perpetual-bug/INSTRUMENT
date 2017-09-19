(
var dir;

/*~currentMode = "chooseChannelInstrument";*/
~currentMode = "two_instruments";


~launchpadSrcId = 1310720;
~player1SrcId = 1572864;


~midiInputs = 2;
~midiOutputs = 2;


dir = '/home/furenku/Musica/perpetual_bug/INSTRUMENT/experimental/';


/*( dir ++ 'midi_basic/boot.scd' ).load;*/
/*( dir ++ 'synths/drumkits/drumkit01.scd' ).load;
( dir ++ 'synths/synthtests01.scd' ).load;

( dir ++ 'midi_basic/midi_basic.scd' ).load;*/
( dir ++ 'interaction/players.scd' ).load;
/*( dir ++ 'interaction/player1.scd' ).load;

( dir ++ 'interaction/oscpad_setup.scd' ).load;

( dir ++ 'interaction/devices/deviceCallbacks.scd' ).load;*/

/*( dir ++ 'interaction/modes/choose_channel_instrument.scd' ).load;*/
( dir ++ 'interaction/modes/four_instruments.scd' ).load;

""

)
