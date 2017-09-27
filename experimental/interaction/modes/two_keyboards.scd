~currentSynth = \sinosc_synth;

~modeNotes = Dictionary.new();
~modeNotes[0] = Dictionary.new();
~modeNotes[1] = Dictionary.new();

~instrumentSynths=Dictionary.new();
~instrumentSynths[0]=\sinosc_synth;
~instrumentSynths[1]=\pwm_synth;

~tmpKeyboardSynthdefs = Dictionary.new();
~tmpKeyboardSynthdefs[0] = [\sinosc_synth,\sinosc_synth_low,\pwm_synth,\pwm_synth_low];
~tmpKeyboardSynthdefs[1] = [\moogNoise,\rlpfNoise,\bpfNoise,\resonzNoise];

~instrumentMenuCallback = {|col, row, val|

   var instrument = (row / 4).floor;

   ~instrumentSynths[instrument] = ~tmpKeyboardSynthdefs[instrument][ (row % 4) % ~tmpKeyboardSynthdefs[instrument].size ];

   4.do{|i|
      var color;
      if( i != (row%4), {
         color = 0;
      }, {
         color = 3+(instrument*4);
      });
      ~launchpad_set.value(
         8,
         i+(instrument*4),
         color
      );
   };


};

~playNoteCallback = {|col, row, val|

   var channel = (col / 4).floor+((row / 4).floor*2);

   /*var num = (col) + (row*8);*/

   var synth;
   var num;

   var keyboard = (col / 4).floor;

   /*col = col - (keyboard * 4);*/
   num = 32 - ((4-(col%4)) + (row * 4));

   switch( keyboard.asInteger,
   0, { synth = \sinosc_synth; },
   1, { synth = \pwm_synth; });

   switch( val,
      0, {
         var color;
         ~modeNotes[keyboard][num].release;

         color = 1+(keyboard*8);

         if( ~black_keys.includes(num % 12), { color = 11-(keyboard*4); },{});

         ~launchpad_set.value(
            col,
            row,
            color
         );
      },

      127, {

         ~modeNotes[keyboard][num] = Synth(~instrumentSynths[keyboard],[\freq, ((48+(keyboard*12))+num).midicps, \amp, 0.25, \gain, 1/2]);


         ~launchpad_set.value(
            col,
            row,
            3+(8*keyboard)
         );

      }
   );

};




~actions = Array.newClear(4);

~actions[0] = ~instrumentCallback;
~actions[1] = ~fxCallback;
~actions[2] = ~mixCallback;
~actions[3] = ~loopCallback;


~launchpad_setup = {

   NetAddr.localAddr.sendMsg( "/OSCpad/reset" );

   ~black_keys = [1,3,6,8,10];

   2.do {|h|
      32.do {|i|
         var x, y;
         var color;
         x = (i % 4) + (h*4);
         y = 7-((i) / 4).asInteger;


         color = 1+(h*8);

         if( ~black_keys.includes(i % 12), { color = 11-(h*4); },{});

         ~launchpad_set.value(x,y,color)

      };
   };

   "";

};




~callbacks = Array.fill(9, {|h|

   Array.fill(8, {|i|

      var callback;

      if( h < 8, {

         callback = ~playNoteCallback;

      }, {

         callback = ~instrumentMenuCallback;

      });

      callback;

   });

});



~modes["two_keyboards"] = ~callbacks;

~launchpad_setup.value();

~instrumentMenuCallback.value(8,0,127);
~instrumentMenuCallback.value(8,4,127);
