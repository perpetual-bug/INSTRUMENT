Tdef(\drum_test,{
   inf.do {|i|

      x = Synth([\drumtest01,\drumtest02].choose);

      (1/[1,1.5,3 ]).choose.wait;

      y = Synth([\drumtest03,\drumtest04].choose);
      (1/[4,6]).choose.wait;
      z = Synth([\drumtest03,\drumtest04].choose);

      (1/[3,8]).choose.wait;
   }
}).play;
