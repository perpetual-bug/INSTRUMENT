(


SynthDef(\polytest01,{|freq=440,gate=1,amp=0.5|

   var sig, env;

   sig = LFPulse.ar( freq*[1,1/2,3],  1/(2*[3,5,6]),  1/(2*[3,5,6]), 1/2 ) ! 1;
   env = EnvGen.kr( Env.asr(1/20,1/3,1/4), gate, doneAction: 2 );

   sig = RLPF.ar( sig, SinOsc.kr(1,0,300,400), 1/8 );
   sig = ( sig * amp * 3 ).tanh;

   Out.ar( 0, amp * sig * env );

}).add;

SynthDef(\polyphonic_synth,{|freq=440, gate=1, amp=0.5, width=1, gain=0.5, lfo_amp=0.1, lfo_freq=0.1|

   var sig, env;

   sig = LFPulse.ar( freq*[1,1/2,3],  0,  width/(2*[3,5,6]), 1/2 ) ! 1;
   env = EnvGen.kr( Env.asr(1/20,1/3,1/4), gate, doneAction: 2 );

   sig = RLPF.ar( sig, SinOsc.kr( (lfo_freq * 10).poll,0,lfo_amp*300, 300 + ((lfo_amp*300)/4)), 1/8 );

   sig = ( sig * amp * ((gain+0.05)*12) ).tanh;

   Out.ar( 0, amp * sig * env );

}).add;

SynthDef(\drumtest01,{|freq=440,gate=1,amp=0.5|

   var sig, filters, env;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;

   filters[0] = (BPF.ar( sig, 60, 0.01 ) * 1100).tanh;
   filters[1] = (BPF.ar( sig, 160, 0.01 ) * 33).tanh / 4;
   filters[2] = (BPF.ar( sig, 1060, 0.01 ) * 10).tanh / 6;
   filters[3] = (BPF.ar( sig, 8960, 0.01 ) * 1113).tanh / 16;

   sig = Mix.new(filters);
   sig = (sig * 3).tanh;

   env = EnvGen.kr( Env.perc(1/100,1/3), doneAction: 2 );

   Out.ar( 0, amp * sig * env );

}).add;

SynthDef(\drumtest02,{|freq=440,gate=1,amp=0.5|

   var sig, filters, env;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;

   filters[0] = (BPF.ar( sig, 360, 0.5 ) * 100).tanh;
   filters[1] = (BPF.ar( sig, 660, 0.01 ) * 33).tanh / 4;
   filters[2] = (BPF.ar( sig, 2560, 0.01 ) * 310).tanh / 6;
   filters[3] = (BPF.ar( sig, 8500, 0.01 ) * 113).tanh / 16;

   env = EnvGen.kr( Env.perc(1/100,1/4), doneAction: 2 );
   sig = Mix.new(filters) * env * amp;
   sig = (sig * 3).tanh * amp;


   Out.ar( 0, amp * sig);

}).add;


SynthDef(\drumtest03,{|freq=440,gate=1,amp=0.5|

   var sig, filters, env;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;

   filters[0] = (BPF.ar( sig, 360, 0.1 ) * 100).tanh;
   filters[1] = (BPF.ar( sig, 2660, 0.1 ) * 333).tanh / 4;
   filters[2] = (BPF.ar( sig, 5560, 0.1 ) * 310).tanh / 6;
   filters[3] = (BPF.ar( sig, 10500, 0.1 ) * 113).tanh / 16;

   env = EnvGen.kr( Env.perc(1/100,1/6), doneAction: 2 );
   sig = Mix.new(filters) * env * amp;


   Out.ar( 0, amp * sig);

}).add;

SynthDef(\drumtest04,{|freq=440,gate=1,amp=0.5|

   var sig, filters, env;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;

   filters[0] = (BPF.ar( sig, 360, 1.05 ) * 10).tanh;
   filters[1] = (BPF.ar( sig, 1660, 1.3 ) * 33).tanh / 4;
   filters[2] = (BPF.ar( sig, 8560, 1.6 ) * 31).tanh / 6;
   filters[3] = (BPF.ar( sig, 12500, 1.9 ) * 13).tanh / 16;

   env = EnvGen.kr( Env.perc(1/100,1/6), doneAction: 2 );
   sig = Mix.new(filters) * env * amp;


   Out.ar( 0, amp * sig);

}).add;



SynthDef(\drumtest05,{|freq=440,gate=1,amp=0.5|

   var sig, filters, env;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;

   filters[0] = (BPF.ar( sig, 60, 0.01 ) * 500).tanh * 12;
   filters[1] = (BPF.ar( sig, 160, 0.01 ) * 33).tanh / 4;
   filters[2] = (BPF.ar( sig, 1060, 0.01 ) * 10).tanh / 6;
   filters[3] = (BPF.ar( sig, 8960, 0.01 ) * 1113).tanh / 16;

   sig = Mix.new(filters);
   sig = (sig * 1.2).tanh;

   env = EnvGen.kr( Env.perc(1/100,1/13), doneAction: 2 );

   Out.ar( 0, amp * sig * env  * amp);

}).add;

SynthDef(\drumtest06,{|freq=440,gate=1,amp=0.5|

   var sig, filters, env;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;

   filters[0] = (BPF.ar( sig, 60, 0.01 ) * 50).tanh;
   filters[1] = (BPF.ar( sig, 160, 0.01 ) * 33).tanh / 4;
   filters[2] = (BPF.ar( sig, 1060, 0.01 ) * 10).tanh / 6;
   filters[3] = (BPF.ar( sig, 8960, 0.01 ) * 1113).tanh / 16;

   sig = Mix.new(filters);
   sig = (sig * 3).tanh;

   env = EnvGen.kr( Env.perc(1/100,1/3), doneAction: 2 );

   Out.ar( 0, amp * sig * env  * amp);

}).add;



SynthDef(\drumtest07,{|freq=440,gate=1,amp=0.5|

   var sig, filters, env;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;

   filters[0] = (BPF.ar( sig, 260, 0.1 ) * 1100).tanh;
   filters[1] = (BPF.ar( sig, 260, 0.1 ) * 1333).tanh / 4;
   filters[2] = (BPF.ar( sig, 556, 0.1 ) * 1310).tanh / 6;
   filters[3] = (BPF.ar( sig, 1500, 0.1 ) * 1113).tanh / 16;

   env = EnvGen.kr( Env.perc(1/100,1/6), doneAction: 2 );
   sig = Mix.new(filters) * env * amp;


   Out.ar( 0, amp * sig);

}).add;

SynthDef(\drumtest08,{|freq=440,gate=1,amp=0.5|

   var sig, filters, env;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;

   filters[0] = (BPF.ar( sig, 360, 1.05 ) * 1).tanh;
   filters[1] = (BPF.ar( sig, 1660, 1.3 ) * 3).tanh / 4;
   filters[2] = (BPF.ar( sig, 8560, 1.6 ) * 3).tanh / 6;
   filters[3] = (BPF.ar( sig, 12500, 1.9 ) * 13).tanh / 16;

   env = EnvGen.kr( Env.perc(1/100,1/6), doneAction: 2 );
   sig = Mix.new(filters) * env * amp;


   Out.ar( 0, amp * sig);

}).add;



)
