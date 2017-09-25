// callback arrays

/*"model"*/
~toggles = Array.fill(8, Array.fill(8, 0));



~action_type_color = Array.fill(4, {|i|
   1+((i%3)*4)
});



~modeCallback = {|col, row, val|
   var channel;
   var device;
   var which;

   /*channel = (col / 4).floor + (row / 4).floor;*/
   channel = (col / 4).floor+((row / 4).floor*2);
   device = col % 4;
   which = row % 4;

   /*["got", col, row, val].postln;
   ["do", channel, device, which].postln;*/


   ~actions[device].value(channel,which);


   4.do{|j|
      ~launchpad_set.value(
         ((channel%2)*4)
         +
         device
         ,
         ((channel/2).floor*4)
         +
         j,
         ~action_type_color[((col%4)%2)+channel%3]+((device+1)%1)
      );
   };

   ~launchpad_set.value(
      col,
      row,
      ~action_type_color[((col%4)%2)+channel%3]+2
   );


   /*set current instrument in channel*/



};




~actions = Array.newClear(4);

~actions[0] = ~instrumentCallback;
~actions[1] = ~fxCallback;
~actions[2] = ~mixCallback;
~actions[3] = ~loopCallback;


~launchpad_setup = {

   NetAddr.localAddr.sendMsg( "/OSCpad/reset" );


   4.do {|h|
      4.do {|i|
         4.do {|j|
            var num;

            num =
            ((h%2)*4)
            +
            (((h/2).asInteger*32)
            +
            i
            +
            (j*8)
            );


            ~launchpad_set.value(
               num%8,
               (num/8).asInteger,
               ~action_type_color[((i%2)+h)%3]+((i+1)%1)
            );

         };

      };

   };

   "";

};


~launchpad_setup.value();


~callbacks = Array.fill(8, {

   Array.fill(8, {
      ~modeCallback
   });

});



~modes["four_instruments"] = ~callbacks;
