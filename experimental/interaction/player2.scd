(
// Create Instruments for Player:
~player2 = {
   var newPlayer;
   var playerInstruments;


   playerInstruments = List.new();
   ~notes = List.new();

   playerInstruments.add(
      ~newInstrument.value(
         "instrument_01",
         \polytest01,
         [
            \iphase, 1,
            \width, 1
         ],
         [
            {|synth, num, velocity| notes[num] = Synth(synth, [\freq, num.midicps, \amp, velocity / 127 ]); },
            {|synth, num, velocity| notes[num].release; }
         ]
      )
   );


   newPlayer = ~newPlayer.value(
      "Uno",
      playerInstruments
   );

}.value();

~players.add( ~player2 );

)
