(

~menuManager["selectMenu"] = {|menuIndex|

   ~launchpad_set.value(-1, menuIndex, 11 );
   8.do{|i| if( i != menuIndex, { ~launchpad_set.value(-1, i, 0 ); },{}); "" };

   ""
};


)
