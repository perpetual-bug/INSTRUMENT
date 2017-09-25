(
// Create Instruments for Player:
~player1 = {

   ~controllerManager.newPlayer.value(
      "Uno"
   );

}.value();



player1.instruments.add(
   ~controllerManager.createInstrument.value(
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

            var currentInstrumentChannel = player1.instruments;
            var currentInstrument = currentInstrumentChannel[currentInstrumentChannel["currentInstrument"]];
            var parameters;

            parameters = [
               \freq, num.midicps, \gate, 1, \amp, velocity / 127,
               currentInstrument["parameters"][0], currentInstrument["parameters"][1],
               currentInstrument["parameters"][2], currentInstrument["parameters"][3],
               currentInstrument["parameters"][4], currentInstrument["parameters"][5],
               currentInstrument["parameters"][6], currentInstrument["parameters"][7]
            ];

            currentInstrument["notes"][num] = Synth(synthdef, parameters);

         },
         {|num|
            var currentInstrumentChannel = player1.instruments;
            var currentInstrument = currentInstrumentChannel[currentInstrumentChannel["currentInstrument"]];
            currentInstrument["notes"][num].release;
         }
      ]
   )
);



player1.instruments.add(
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

            var currentInstrumentChannel = player1.instruments;
            var currentInstrument = currentInstrumentChannel[currentInstrumentChannel["currentInstrument"]];
            var parameters;

            parameters = [
               \freq, num.midicps, \gate, 1, \amp, velocity / 127,
               currentInstrument["parameters"][0], currentInstrument["parameters"][1],
               currentInstrument["parameters"][2], currentInstrument["parameters"][3],
               currentInstrument["parameters"][4], currentInstrument["parameters"][5],
               currentInstrument["parameters"][6], currentInstrument["parameters"][7]
            ];


            currentInstrument["notes"][num] = Synth(synthdef, parameters);



         },
         {|num|
            var currentInstrumentChannel = player1.instruments;
            var currentInstrument = currentInstrumentChannel[currentInstrumentChannel["currentInstrument"]];
            currentInstrument["notes"][num].release;
         }
      ]
   )
);







player1.instruments.add(
   ~player1["createInstrument"].value(
      "drum_01",
      \drumtest,
      [
         'res', 0.5,
         'gain', 1.2,
         'release', 0.2,
         'faktor', 1
      ],
      [
         {|synthdef, num, velocity|

            var currentInstrumentChannel = player1.instruments;
            var currentInstrument = currentInstrumentChannel[currentInstrumentChannel["currentInstrument"]];
            var parameters;

            parameters = [
               \freq, num.midicps, \gate, 1, \amp, velocity / 127,
               currentInstrument["parameters"][0], currentInstrument["parameters"][1],
               currentInstrument["parameters"][2], currentInstrument["parameters"][3],
               currentInstrument["parameters"][4], currentInstrument["parameters"][5],
               currentInstrument["parameters"][6], currentInstrument["parameters"][7]
            ];

            switch(num-36,
               0, {
                  synthdef = synthdef ++ '01';
               },
               1, {
                  synthdef = synthdef ++ '02';
               },
               2, {
                  synthdef = synthdef ++ '03';
               },
               3, {
                  synthdef = synthdef ++ '04';
               },
               4, {
                  synthdef = synthdef ++ '05';
               },
               5, {
                  synthdef = synthdef ++ '06';
               },
               6, {
                  synthdef = synthdef ++ '07';
               },
               7, {
                  synthdef = synthdef ++ '08';
               },
            );

            currentInstrument["notes"][num] = Synth(synthdef, parameters);



         },
         {|num|
            var currentInstrumentChannel = player1.instruments;
            var currentInstrument = currentInstrumentChannel[currentInstrumentChannel["currentInstrument"]];
            currentInstrument["notes"][num].release;
         }
      ]
   )
);


~players.add( ~player1 );

)
