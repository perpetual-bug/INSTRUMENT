(

var notes, on, off;
var polysynth;
var funcs;

MIDIClient.init;
/*MIDIIn.connectAll;*/

funcs = Dictionary.new();



polysynth = Array.newClear(2);
polysynth[0] = {|synth, num, velocity| notes[num] = Synth(synth, [\freq, num.midicps, \amp, velocity / 127 ]); };
polysynth[1] = {|synth, num, velocity| notes[num].release; };

notes = Dictionary.new();    // array has one slot per possible MIDI note


on = MIDIFunc.noteOn({ |velocity, num, chan, src|

   [velocity, num, chan, src].postln;

   switch ( chan,

   	0,   {
         if(notes.includesKey(num.asSymbol), { notes[num].free;  },{ polysynth[0].value(\polytest01, num, velocity )});
      },

      9,   {
         "do".postln;
         switch( num,
            36, {

               polysynth[0].value(\drumtest01, num, velocity );
            },
            37, {

               polysynth[0].value(\drumtest02, num, velocity );
            },
            38, {

               polysynth[0].value(\drumtest03, num, velocity );
            },
            39, {

               polysynth[0].value(\drumtest04, num, velocity );
            },
            40, {

               polysynth[0].value(\drumtest05, num, velocity );
            },
            41, {

               polysynth[0].value(\drumtest06, num, velocity );
            },
            42, {

               polysynth[0].value(\drumtest07, num, velocity );
            },
            43, {

               polysynth[0].value(\drumtest08, num, velocity );
            }
         );
      }

   );


   ("noteon:"++num).postln;
   ("chan:"++chan).postln;

});

off = MIDIFunc.noteOff({ |velocity, num, chan, src|

   switch ( chan,

   	0,   {
         polysynth[1].value(\polytest01, num, velocity);
      },

      9,   {
         // no noteoff for sampler ?
      }

   );

   ("noteoff:"++num).postln;
   ("chan:"++chan).postln;

});

)
