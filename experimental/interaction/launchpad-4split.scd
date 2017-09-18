(

~action_type_color = Array.fill(4, {|i|
   3+((i%3)*4)
});


NetAddr.localAddr.sendMsg( "/OSCpad/reset" );

4.do {|h|
   4.do {|i|
      4.do {|j|
         var num;
            /*~launchpad_set.value(
               h,

         i
         +
         (((h/2).asInteger*32)+(j*8))
         ,
            7);*/

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
            ~action_type_color[h%3]
         );

      };

   };

};

"";

)
