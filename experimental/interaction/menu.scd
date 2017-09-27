(


   ~menuModes = [
      /*"mixer",*/
      /*"choose_channel_instrument",*/
      /*"parameter_view",*/
      /*"loops",*/
      /*"four_instruments",*/
      "mode_0",
      "two_keyboards",
         // select instrument
         // toggle fx
         // mix
         // record loop
      /*"four_keyboards",*/
      /*"step_sequencer",*/
   ];
~menuManager["selectMenu"] = {|menuIndex|

   ~launchpad_set.value(-1, menuIndex, 11 );
   8.do{|i| if( i != menuIndex, { ~launchpad_set.value(-1, i, 0 ); },{}); "" };

   ~currentMode = ~menuModes[ menuIndex % ~menuModes.size ];
   ~menuManager["load_mode"].value( ~currentMode );

   ""
};


~menuManager["load_mode"] = {|mode|
   var index = -1;
   var break = false;
   ~menuModes.do{|name,i|
      if( name == mode, {
         index = i;
      },{});
   };

   ~modes[mode]["init"].value();
   ~launchpad_set.value(-1,index,11);
};

)
