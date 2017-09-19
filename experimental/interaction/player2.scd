
player1.instruments.add(
   ~player1["createInstrument"].value(
      "drumtest01",
      \drumtest,
      [
         'res', 0.75,
         'gain', 0.2,
         'release', 0.6,
         'faktor', 4
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
