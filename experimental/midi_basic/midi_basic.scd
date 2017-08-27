s.boot;

().play;

(

SynthDef(\polytest01,{|freq=440,gate=1,amp=0.5|

   var sig, env;

   sig = LFPulse.ar( freq, 1/2, 1/2 );
   env = EnvGen.kr( Env.asr(1/100,1/10), gate, doneAction: 2 );

   Out.ar( 0, amp * sig * env );

}).add;

SynthDef(\polytest02,{|freq=440,gate=1,amp=0.5|

   var sig, env;

   sig = LFPulse.ar( Line.kr(1,0.1,1/113) * (freq*10), 1/16, 1/6 );
   env = EnvGen.kr( Env.perc(1/100,1/3), doneAction: 2 );

   Out.ar( 0, amp * sig * env );

}).add;

)

(

var notes, on, off;
var polysynth;
var funcs;

MIDIClient.init;
MIDIIn.connectAll;

funcs = Dictionary.new();

polysynth = Array.newClear(2);
polysynth[0] = {|synth, num, velocity| notes[num] = Synth(synth, [\freq, num.midicps,
   \amp, velocity / 127 ]); };
polysynth[1] = {|synth, num, velocity| notes[num].release; };


notes = Array.newClear(128);    // array has one slot per possible MIDI note

on = MIDIFunc.noteOn({ |velocity, num, chan, src|

   switch ( chan,

   	0,   {
         polysynth[0].value(\polytest01, num, velocity );
      },

      9,   {
         polysynth[0].value(\polytest02, num - 12, velocity );
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
         polysynth[1].value(\polytest02, num - 12, velocity);
      }

   );

   ("noteoff:"++num).postln;
   ("chan:"++chan).postln;

});

)

// when done:
q.value;
