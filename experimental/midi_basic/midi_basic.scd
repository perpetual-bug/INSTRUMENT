(


var on, off, cc;

MIDIClient.init;


on = MIDIFunc.noteOn({ |velocity, num, chan, src|

   var currentPlayer;
   var currentInstrument;
   var synthdef;

   /*[velocity, num, chan, src].postln;*/

   switch(src,
      1310720, {
         currentPlayer = ~player1;
      }
   );

   currentInstrument = currentPlayer["instruments"][currentPlayer["currentInstrument"]];
   synthdef = currentInstrument["synthdef"];

   currentInstrument["functions"][0].value(synthdef,num,velocity);

});


off = MIDIFunc.noteOff({ |velocity, num, chan, src|
   var currentPlayer;
   var currentInstrument;
   var synthdef;

   /*[velocity, num, chan, src].postln;*/

   switch(src,
      1310720, {
         currentPlayer = ~player1;
      }
   );

   currentInstrument = currentPlayer["instruments"][currentPlayer["currentInstrument"]];

   currentInstrument["functions"][1].value(num);

});

cc = MIDIFunc.cc({ |value, num, chan, src|
   var currentPlayer;
   var currentInstrument;
   var synthdef;

   var startOffset;
   var parameterIndex;
   var parameters;

   /*[value, num, chan, src].postln;*/

   switch(src,
      1310720, {
         currentPlayer = ~player1;
      }
   );

   startOffset = 14;

   // skip one because params come in pairs ( \key, value )

   parameterIndex = ((num - startOffset)*2).postln;

   currentInstrument = currentPlayer["instruments"][currentPlayer["currentInstrument"]];


   currentInstrument["parameters"][parameterIndex + 1] = value / 127;

   parameters = currentInstrument["parameters"];


   currentPlayer["notes"].collect({|i|
      i.set(parameters[0],parameters[1]);
      i.set(parameters[2],parameters[3]);
      i.set(parameters[4],parameters[5]);
      i.set(parameters[6],parameters[7]);
   });

   // TO DO : ALTER CURRENT SYNTHS

});

)
