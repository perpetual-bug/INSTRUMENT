(

SynthDef(\drumtest01,{|freq=440,gate=1,amp=0.5,res=0.5,gain=1.2,release=0.2,faktor=1|

   var sig, filters, env;
   var bw;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;
   bw = 0.005 + (res / 50);

   filters[0] = (BPF.ar( sig, 60 * [1,1+faktor,1+faktor*3], bw ) * 1100).tanh;
   filters[1] = (BPF.ar( sig, 160 * [1,1+faktor,1+faktor*3], bw ) * 33).tanh / 4;
   filters[2] = (BPF.ar( sig, 1060 * [1,1+faktor,1+faktor*3], bw ) * 10).tanh / 6;
   filters[3] = (BPF.ar( sig, 8960 * [1,1+faktor,1+faktor*3], bw ) * 1113).tanh / 16;

   sig = Mix.new(filters);
   sig = (sig * (gain* 3)).tanh * amp;

   env = EnvGen.kr( Env.perc(1/100,0.05+release), doneAction: 2 );

   Out.ar( 0, amp * sig * env );

}).add;

SynthDef(\drumtest02,{|freq=440,gate=1,amp=0.5,res=0.5,gain=1.2,release=0.2,faktor=1|

   var sig, filters, env;
   var bw;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;
   bw = 0.005 + (res / 50);

   filters[0] = (BPF.ar( sig, 360 * [1,1+faktor,1+faktor*3], bw+0.5 ) * 100).tanh;
   filters[1] = (BPF.ar( sig, 660 * [1,1+faktor,1+faktor*3], bw ) * 33).tanh / 4;
   filters[2] = (BPF.ar( sig, 2560 * [1,1+faktor,1+faktor*3], bw ) * 310).tanh / 6;
   filters[3] = (BPF.ar( sig, 8500 * [1,1+faktor,1+faktor*3], bw ) * 113).tanh / 16;

   env = EnvGen.kr( Env.perc(1/100,0.05+release), doneAction: 2 );
   sig = Mix.new(filters) * env * amp;
   sig = (sig * (gain* 3)).tanh * amp;


   Out.ar( 0, amp * sig);

}).add;


SynthDef(\drumtest03,{|freq=440,gate=1,amp=0.5,res=0.5,gain=1.2,release=0.2,faktor=1|

   var sig, filters, env;
   var bw;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;
   bw = 0.05 + (res / 5);

   filters[0] = (BPF.ar( sig, 360 * [1,1+faktor,1+faktor*3], bw ) * 100).tanh;
   filters[1] = (BPF.ar( sig, 2660 * [1,1+faktor,1+faktor*3], bw ) * 333).tanh / 4;
   filters[2] = (BPF.ar( sig, 5560 * [1,1+faktor,1+faktor*3], bw ) * 310).tanh / 6;
   filters[3] = (BPF.ar( sig, 10500 * [1,1+faktor,1+faktor*3], bw ) * 113).tanh / 16;

   env = EnvGen.kr( Env.perc(1/100,0.05+release), doneAction: 2 );
   sig = Mix.new(filters) * env * amp;
   sig = (sig * (gain* 3)).tanh * amp;


   Out.ar( 0, amp * sig);

}).add;

SynthDef(\drumtest04,{|freq=440,gate=1,amp=0.5,res=0.5,gain=1.2,release=0.2,faktor=1|

   var sig, filters, env;
   var bw;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;
   bw = 0.25 + res;

   filters[0] = (BPF.ar( sig, 360 * [1,1+faktor,1+faktor*3], bw + 0.05 ) * 10).tanh;
   filters[1] = (BPF.ar( sig, 1660 * [1,1+faktor,1+faktor*3], bw + 0.3 ) * 33).tanh / 4;
   filters[2] = (BPF.ar( sig, 8560 * [1,1+faktor,1+faktor*3], bw + 0.6 ) * 31).tanh / 6;
   filters[3] = (BPF.ar( sig, 12500 * [1,1+faktor,1+faktor*3], bw + 0.9 ) * 13).tanh / 16;

   env = EnvGen.kr( Env.perc(1/100,0.05+release), doneAction: 2 );
   sig = Mix.new(filters) * env * amp;
   sig = (sig * (gain* 3)).tanh * amp;


   Out.ar( 0, amp * sig);

}).add;



SynthDef(\drumtest05,{|freq=440,gate=1,amp=0.5,res=0.5,gain=1.2,release=0.2,faktor=1|

   var sig, filters, env;
   var bw;
   filters = Array.newClear(4);
   sig = WhiteNoise.ar;

   bw = 0.005 + (res / 50);

   filters[0] = (BPF.ar( sig, 60 * [1,1+faktor,1+faktor*3], bw ) * 500).tanh * 12;
   filters[1] = (BPF.ar( sig, 160 * [1,1+faktor,1+faktor*3], bw ) * 33).tanh / 4;
   filters[2] = (BPF.ar( sig, 1060 * [1,1+faktor,1+faktor*3], bw ) * 10).tanh / 6;
   filters[3] = (BPF.ar( sig, 8960 * [1,1+faktor,1+faktor*3], bw ) * 1113).tanh / 16;

   sig = Mix.new(filters);
   sig = (sig * (gain* 3)).tanh * amp;

   env = EnvGen.kr( Env.perc(1/100,release), doneAction: 2 );

   Out.ar( 0, amp * sig * env  * amp);

}).add;

SynthDef(\drumtest06,{|freq=440,gate=1,amp=0.5,res=0.5,gain=1.2,release=0.2,faktor=1|

   var sig, filters, env;
   var bw;

   filters = Array.newClear(4);
   sig = WhiteNoise.ar;
   bw = 0.005 + (res / 50);

   filters[0] = (BPF.ar( sig, 60 * [1,1+faktor,1+faktor*3], bw ) * 50).tanh;
   filters[1] = (BPF.ar( sig, 160 * [1,1+faktor,1+faktor*3], bw ) * 33).tanh / 4;
   filters[2] = (BPF.ar( sig, 1060 * [1,1+faktor,1+faktor*3], bw ) * 10).tanh / 6;
   filters[3] = (BPF.ar( sig, 8960 * [1,1+faktor,1+faktor*3], bw ) * 1113).tanh / 16;

   sig = Mix.new(filters);
   sig = (sig * (gain* 3)).tanh * amp;

   env = EnvGen.kr( Env.perc(1/100,0.05+release), doneAction: 2 );

   Out.ar( 0, amp * sig * env  * amp);

}).add;



SynthDef(\drumtest07,{|freq=440,gate=1,amp=0.5,res=0.5,gain=1.2,release=0.2,faktor=1|

   var sig, filters, env;
var bw;
   filters = Array.newClear(4);
   sig = WhiteNoise.ar;
   bw = 0.05 + (res / 5);

   filters[0] = (BPF.ar( sig, 260 * [1,1+faktor,1+faktor*3], bw ) * 1100).tanh;
   filters[1] = (BPF.ar( sig, 260 * [1,1+faktor,1+faktor*3], bw ) * 1333).tanh / 4;
   filters[2] = (BPF.ar( sig, 556 * [1,1+faktor,1+faktor*3], bw ) * 1310).tanh / 6;
   filters[3] = (BPF.ar( sig, 1500 * [1,1+faktor,1+faktor*3], bw ) * 1113).tanh / 16;

   env = EnvGen.kr( Env.perc(1/100,0.05+release), doneAction: 2 );
   sig = Mix.new(filters) * env * amp;
   sig = (sig * (gain* 3)).tanh * amp;


   Out.ar( 0, amp * sig);

}).add;

SynthDef(\drumtest08,{|freq=440,gate=1,amp=0.5,res=0.5,gain=1.2,release=0.2,faktor=1|

   var sig, filters, env;
var bw;
   filters = Array.newClear(4);
   sig = WhiteNoise.ar;
   bw = 0.25 + res;

   filters[0] = (BPF.ar( sig, 360 * [1,1+faktor,1+faktor*3], bw+0.05 ) * 1).tanh;
   filters[1] = (BPF.ar( sig, 1660 * [1,1+faktor,1+faktor*3], bw+0.3 ) * 3).tanh / 4;
   filters[2] = (BPF.ar( sig, 8560 * [1,1+faktor,1+faktor*3], bw+0.6 ) * 3).tanh / 6;
   filters[3] = (BPF.ar( sig, 12500 * [1,1+faktor,1+faktor*3], bw+0.9 ) * 13).tanh / 16;

   env = EnvGen.kr( Env.perc(1/100,0.05+release), doneAction: 2 );
   sig = Mix.new(filters) * env * amp;
   sig = (sig * (gain* 3)).tanh * amp;


   Out.ar( 0, amp * sig);

}).add;


)
