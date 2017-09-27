      s.boot;
      s.doWhenBooted({

      var dir;

      ().play;
      /*~currentMode = "chooseChannelInstrument";*/
      ~currentMode = "mode_0";

      ~clock = 0;
      ~menuClockTime = 0;
      ~selectingMenu = 0;

      ~launchpadSrcId = 1310720;
      ~player1SrcId = 1572864;


      ~midiInputs = 2;
      ~midiOutputs = 2;

      ~menuManager = Dictionary.new();


      dir = '/home/furenku/Musica/perpetual_bug/INSTRUMENT/experimental/';


      /*( dir ++ 'midi_basic/boot.scd' ).load;*/
      /*( dir ++ 'synths/drumkits/drumkit01.scd' ).load;

      */
      ( dir ++ 'synths/synthtests01.scd' ).load;
      ( dir ++ 'interaction/controllers.scd' ).load;
      ( dir ++ 'interaction/menu.scd' ).load;
      ( dir ++ 'midi_basic/midi_basic.scd' ).load;
      ( dir ++ 'interaction/oscpad_setup.scd' ).load;

      /*( dir ++ 'interaction/player1.scd' ).load;


      ( dir ++ 'interaction/devices/deviceCallbacks.scd' ).load;*/

      /*( dir ++ 'interaction/modes/choose_channel_instrument.scd' ).load;*/
      ( dir ++ 'interaction/modes/mode_0.scd' ).load;
      ( dir ++ 'interaction/modes/two_keyboards.scd' ).load;

      ( dir ++ 'interaction/clocks/main_clock.scd' ).load;


      ~menuManager["load_mode"].value( ~currentMode );


      ""

      })
