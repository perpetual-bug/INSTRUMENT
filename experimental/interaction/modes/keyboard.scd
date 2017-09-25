   // callback arrays

   /*"model"*/
   ~toggles = Array.fill(8, Array.fill(8, 0));



   ~action_type_color = Array.fill(4, {|i|
      1+((i%3)*4)
   });

   ~modeNotes = Dictionary.new();

   ~modeCallback = {|col, row, val|

   var channel = (col / 4).floor+((row / 4).floor*2);

         var num = 63 - ((8-col) + (row * 8));

      ["note",num].postln;
      switch( val,

         0, {
var color;
                  ~modeNotes[num].release;
if( num % 12 != 0, { color = 0; }, { color=5; });
if( (num) % 12 != 7, { color = color; }, { color=1; });

                  ~launchpad_set.value(
                     col,
                     row,
                     color
                  );
         },
         127, {

               ~modeNotes[num] = Synth(\sinosc_synth,[\freq, (48+num).midicps, \amp, 0.5, \gain, 1]);


               ~launchpad_set.value(
                  col,
                  row,
                  7
               );
                  }
)


      /*set current instrument in channel*/



   };




   ~actions = Array.newClear(4);

   ~actions[0] = ~instrumentCallback;
   ~actions[1] = ~fxCallback;
   ~actions[2] = ~mixCallback;
   ~actions[3] = ~loopCallback;


   ~launchpad_setup = {

      NetAddr.localAddr.sendMsg( "/OSCpad/reset" );


      64.do {|h|
var num = (h-3);
         if( h % 12 == 0, {
            var x, y;

            x = (8-(h % 8))-3;
            y = ((h) / 8).asInteger;

            ~launchpad_set.value(x,y,5);

         }, {});
         if( (h + 7) % 12 == 0, {
            var x, y;

            x = (8-(h % 8))-3;
            y = ((h) / 8).asInteger;

            ~launchpad_set.value(x,y,1);

         }, {});

      };

      "";

   };




   ~callbacks = Array.fill(8, {

      Array.fill(8, {
         ~modeCallback
      });

   });



   ~modes["keyboard"] = ~callbacks;
