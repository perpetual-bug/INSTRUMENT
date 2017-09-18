(
   
   ~launchpad_setup = {
      64.do {|i|
         ~launchpad_set.value(i/8,i%8,7);
      };
      ~launchpad_set.value(0,3,3);
      ~launchpad_set.value(2,3,3);
      ~launchpad_set.value(4,3,3);
      ~launchpad_set.value(6,3,3);
      ~launchpad_set.value(4,0,11);
      ~launchpad_set.value(4,2,11);
      ~launchpad_set.value(4,4,11);
      ~launchpad_set.value(4,6,11);
      "";
   };

   ~launchpad_setup.value();

)
