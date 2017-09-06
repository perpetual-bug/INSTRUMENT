(
// Create Instruments for Player:
~player1 = {

   ~newPlayer.value(
      "Uno"
   );

}.value();

~player1["instruments"].add(
   ~player1["createInstrument"].value(
      "instrument_01",
      \pwm_synth,
      [
         'width', 0.5,
         'gain', 0.5,
         'lfo_amp', 0.1,
         'lfo_freq', 0.1
      ],
      [
         {|synthdef, num, velocity|

            var currentInstrument = ~player1["instruments"][~player1["currentInstrument"]];
            var parameters;

            parameters = [
               \freq, num.midicps, \gate, 1, \amp, velocity / 127,
               currentInstrument["parameters"][0], currentInstrument["parameters"][1],
               currentInstrument["parameters"][2], currentInstrument["parameters"][3],
               currentInstrument["parameters"][4], currentInstrument["parameters"][5],
               currentInstrument["parameters"][6], currentInstrument["parameters"][7]
            ];


            ~player1["notes"][num] = Synth(synthdef, parameters);



         },
         {|num| ~player1["notes"][num].release; }
      ]
   )
);


~player1["instruments"].add(
   ~player1["createInstrument"].value(
      "instrument_02",
      \sinosc_synth,
      [
         'width', 0.5,
         'gain', 0.5,
         'lfo_amp', 0.1,
         'lfo_freq', 0.1
      ],
      [
         {|synthdef, num, velocity|

            var currentInstrument = ~player1["instruments"][~player1["currentInstrument"]];
            var parameters;

            parameters = [
               \freq, num.midicps, \gate, 1, \amp, velocity / 127,
               currentInstrument["parameters"][0], currentInstrument["parameters"][1],
               currentInstrument["parameters"][2], currentInstrument["parameters"][3],
               currentInstrument["parameters"][4], currentInstrument["parameters"][5],
               currentInstrument["parameters"][6], currentInstrument["parameters"][7]
            ];


            ~player1["notes"][num] = Synth(synthdef, parameters);



         },
         {|num| ~player1["notes"][num].release; }
      ]
   )
);



~players.add( ~player1 );

)
