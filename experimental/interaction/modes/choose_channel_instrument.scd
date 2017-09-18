// callback arrays

/*"model"*/
~toggles = Array.fill(8, Array.fill(8, 0));

/*"controller"*/

~callbacks = Array.fill(8, {


   Array.fill(8, {
      {|row, col, val|

         var number;
         var color;
         switch( val.asInteger,
            0, { },
            127, {

               /*~toggles[row][col].postln;*/


               ~toggles[row][col] = (~toggles[row][col]+1) % 2;
               color = ~toggles[row][col] * 7;

               NetAddr.localAddr.sendMsg( "/OSCpad/set", col, row, color );


            }

         );


      };
   });
});


~modes["chooseChannelInstrument"] = ~callbacks;
