(

Tdef("main_clock", {
   inf.do{

      if( (~menuClockTime>0)&&(~clock >= ~menuClockTime), {

         ~menuManager["selectMenu"].value( ~selectingMenu );

         ~menuClockTime = 0;

      }, {});

      ~clock = (~clock + 1);

      1.wait;
   };

}).play;

)
