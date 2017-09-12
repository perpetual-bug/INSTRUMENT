(

var on, off, cc;

~launchpadSrcId = 1835008;
~player1SrcId = 1310720;

MIDIClient.init;

~launchpad = {|value, num, chan|

   var x, y;

   x = num % 16;
   y = ( num / 16 ).asInteger;

   ~subscribers.do( { arg sub; sub.sendMsg( "/OSCpad/update", x, y, value ); } );

};

~play = {|instrument, toggle, value, num, chan|

   ("play:"++[toggle, instrument["synthdef"],num,value]).postln;
   if( toggle, {
      instrument["functions"][0].value(instrument["synthdef"],num,value);
   }, {
      instrument["functions"][1].value(num);
   });

};

~note = {|toggle, value, num, chan,src|

   var currentInstrumentChannel;
   var currentInstrument;

   [value, num, chan, src].postln;

   switch(src,
      ~launchpadSrcId, {  // launchpad
         ~launchpad.value(value, num, chan);
      },
      ~player1SrcId, {  // axiom 25
         "improve: play func method?".postln;
         currentInstrumentChannel = ~player1["instruments"][chan];
         currentInstrument = currentInstrumentChannel[currentInstrumentChannel["currentInstrument"]];
         ~play.value(currentInstrument, toggle, value, num, chan);
      }
   );

};


on = MIDIFunc.noteOn({|value, num, chan, src|
   ~note.value(true, value, num, chan, src);
});


off = MIDIFunc.noteOff({ |value, num, chan, src|
   ~note.value(false,value, num, chan, src);
});

cc = MIDIFunc.cc({ |value, num, chan, src|
   var currentPlayer;
   var currentInstrumentChannel;
   var currentInstrument;
   var synthdef;

   var startOffset;
   var parameterIndex;
   var parameters;

   /*[value, num, chan, src].postln;*/

   switch(src,
      //1310720, { // radium49
      ~player1SrcId, {  // axiom 25
         currentPlayer = ~player1;
      }
   );

   startOffset = 0;

   // skip one because params come in pairs ( \key, value )

   parameterIndex = ((num - startOffset)*2).postln;
   ("CHAN"++chan).postln;
   currentInstrumentChannel = currentPlayer["instruments"][chan];
   currentInstrument = currentInstrumentChannel[currentInstrumentChannel["currentInstrument"]];


   currentInstrument["parameters"][parameterIndex + 1] = value / 127;

   parameters = currentInstrument["parameters"];


   currentInstrument["notes"].collect({|i|
      i.set(parameters[0],parameters[1]);
      i.set(parameters[2],parameters[3]);
      i.set(parameters[4],parameters[5]);
      i.set(parameters[6],parameters[7]);
   });

   // TO DO : ALTER CURRENT SYNTHS

});

)
