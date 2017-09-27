// callback arrays

/*"controller"*/

~callbacks = Array.fill(8, {

   Array.fill(8, {
      {|row, col, val|

         var color;


         switch( val,
            0, { color = 0; },
            127, {
         ["MODE0", row, col, val].postln;
 color = 3; },

         );

         ~launchpad_set.value( row, col, color );

      };
   });
});




~modes["mode_0"] = Dictionary.new();

~modes["mode_0"]["launchpad"] = Dictionary.new();


~modes["mode_0"]["init"] = {

   ~modes["mode_0"]["launchpad"]["setup"].value();

};

~modes["mode_0"]["launchpad"]["setup"] = {

   NetAddr.localAddr.sendMsg( "/OSCpad/reset" );

   64.do {|i|
      var x, y;
      var color;
      x = (i % 8);
      y = ((i) / 8).asInteger;


      color = 1+(i%12);

      ~launchpad_set.value(x,y,color)

   };

   "";

};

~modes["mode_0"]["launchpad"]["callbacks"] = ~callbacks;
