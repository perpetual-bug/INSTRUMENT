


/*

~player1["instruments"][0]["currentInstrument"]=0;
~player1["instruments"][0]["currentInstrument"]=1;

~player1["instruments"][1]["currentInstrument"]=0;
~player1["instruments"][1]["currentInstrument"]=1;


*/

// callback arrays

/*"model"*/
~toggles = Array.fill(64, 0);

/*"controller"*/

~callbacks = Array.fill(8, {


   Array.fill(8, {
      {|row, col, val|

         var number;
         var color;

         switch( val,
            0, { },
            127, {

               number = (row*8)+col;

               ~toggles[ number ] = (~toggles[ number ]+1) % 2;

               color = ~toggles[ number ] * 7;

               NetAddr.localAddr.sendMsg( "/OSCpad/set", col, row, color );

            }

         );


      };
   });
});


~modes[0] = ~callbacks;
