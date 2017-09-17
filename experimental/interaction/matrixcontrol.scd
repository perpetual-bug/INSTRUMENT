// callback arrays

~callbacks = Array.fill(8, {
   Array.fill(8, {
      {|row, col, val|

         var color;

         ("do callback:"++row++","++col).postln;

         switch( val,
            0, { color = 0; },
            127, {
               color = 7;
               [row, col, val, color].postln;
            }
         );

         NetAddr.localAddr.sendMsg( "/OSCpad/set", col, row, color );

      };
   });
});


~modes[0] = ~callbacks;
