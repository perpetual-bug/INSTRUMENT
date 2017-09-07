(


SynthDef(\polytest01,{|freq=440,gate=1,amp=0.5|

   var sig, env;

   sig = LFPulse.ar( freq*[1,1/2,3],  1/(2*[3,5,6]),  1/(2*[3,5,6]), 1/2 ) ! 1;
   env = EnvGen.kr( Env.asr(1/20,1/3,1/4), gate, doneAction: 2 );

   sig = RLPF.ar( sig, SinOsc.kr(1,0,300,400), 1/8 );
   sig = ( sig * amp * 3 ).tanh;

   Out.ar( 0, amp * sig * env );

}).add;

SynthDef(\pwm_synth,{|freq=440, gate=1, amp=0.5, width=1, gain=0.5, lfo_amp=0.1, lfo_freq=0.1|

   var sig, env;

   sig = LFPulse.ar( freq*[1,1/2,3],  0,  width/(2*[3,5,6]), 1/2 ) ! 1;
   env = EnvGen.kr( Env.asr(1/20,1/3,1/4), gate, doneAction: 2 );

   sig = RLPF.ar( sig, SinOsc.kr( (lfo_freq * 10),0,lfo_amp*300, 300 + ((lfo_amp*300)/4)), 1/8 );

   sig = ( sig * amp * ((gain+0.01)*6) ).tanh;

   Out.ar( 0, amp * sig * env );

}).add;

SynthDef(\sinosc_synth,{|freq=440, gate=1, amp=0.5, width=1, gain=0.5, lfo_amp=0.1, lfo_freq=0.1|

   var sig, env;

   sig = SinOsc.ar( freq*1, SinOsc.kr(width/2,0,0.5,0.5) ) ! 1;

   env = EnvGen.kr( Env.asr(1/5,1/2,1/1), gate, doneAction: 2 );

   sig = RLPF.ar( sig, SinOsc.kr( (lfo_freq * 10),0,lfo_amp*300, 300 + ((lfo_amp*300)/4)), 1/8 );

   sig = ( sig * amp * ((gain+0.05)*1.2) ).tanh;

   Out.ar( 0, amp * sig * env );

}).add;


SynthDef(\pwm_synth_low,{|freq=440, gate=1, amp=0.5, width=1, gain=0.5, lfo_amp=0.1, lfo_freq=0.1|

   var sig, env;

   sig = LFPulse.ar( freq*[1/4,1/2,1],  0,  width/(2*[3,5,6]), 1/2 ) ! 1;
   env = EnvGen.kr( Env.asr(1/20,1/3,1/4), gate, doneAction: 2 );

   sig = RLPF.ar( sig, SinOsc.kr( (lfo_freq * 10),0,lfo_amp*150, 150 + ((lfo_amp*300)/4)), 1/16 );

   sig = ( sig * amp * ((gain+0.01)*2*6) ).tanh;

   Out.ar( 0, amp * sig * env );

}).add;

SynthDef(\sinosc_synth_low,{|freq=440, gate=1, amp=0.5, width=1, gain=0.5, lfo_amp=0.1, lfo_freq=0.1|

   var sig, env;

   sig = SinOsc.ar( freq*[1/2], SinOsc.kr(width/2,0,0.5,0.5) ) ! 1;

   env = EnvGen.kr( Env.asr(1/5,1/2,1/1), gate, doneAction: 2 );

   sig = RLPF.ar( sig, SinOsc.kr( (lfo_freq * 10),0,lfo_amp*150, 150 + ((lfo_amp*150)/4)), 1/8 );

   sig = ( sig * amp * ((gain+0.05)*2) ).tanh;

   Out.ar( 0, amp * sig * env );

}).add;


)
