~currentSynth = \sinosc_synth;

~modeNotes = Dictionary.new();

~tmpKeyboardSynthdefs = [\sinosc_synth,\pwm_synth,\pwm_synth_low,\sinosc_synth_low];

~instrumentMenuCallback = {|col, row, val|

   ~currentSynth = ~tmpKeyboardSynthdefs[row % ~tmpKeyboardSynthdefs.size];

   8.do{|i|
      var color;
      if( i != row, {
         color = 0;
      }, {
         color = 7;
      });
      ~launchpad_set.value(
         8,
         i,
         color
      );
   };


};

~playNoteCallback = {|col, row, val|

   var channel = (col / 4).floor+((row / 4).floor*2);

   /*var num = (col) + (row*8);*/
   var num = 64 - ((8-col) + (row * 8));

   [num].postln;

   switch( val,
      0, {
         var color;
         ~modeNotes[num].release;

         switch( num % 12,
            0, { color = 5; },
            7, { color = 1; },
         );
         if( ~black_keys.includes(num % 12), { color = 9; },{});

         ~launchpad_set.value(
            col,
            row,
            color
         );
      },

      127, {

         ~modeNotes[num] = Synth(~currentSynth,[\freq, (48+num).midicps, \amp, 0.5, \gain, 1]);


         ~launchpad_set.value(
            col,
            row,
            7
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

   64.do {|h|
      var x, y, num;
      num = h;
      x = (num % 8);
      y = 7-((num) / 8).asInteger;
      switch( num % 12,
         0, { ~launchpad_set.value(x,y,5); },
         7, { ~launchpad_set.value(x,y,1); },
      );
      if( ~black_keys.includes(num % 12), { ~launchpad_set.value(x,y,9); },{});


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



~modes["keyboard"] = ~callbacks;

~launchpad_setup.value();

~instrumentMenuCallback.value(8,0,127);
