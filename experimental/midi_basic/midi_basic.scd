(

var on, off, cc;

var loadMode;

~launchpadSrcId = 1310720;
~controller1SrcId = 1572864;



~controllerManager["createController"].value("furenku-axiom-25",1572864,0);
~controllerManager["createController"].value("furenku-axiom-25",1572864,9);
/*~controllerManager.controllers*/

// Activate listeners
~menus = Array.fill(2,{
	Array.fill(8,{
		"test"
	});
});


MIDIClient.init(~midiInputs,~midiOutputs);

~modes = Dictionary.new();

~launchpad = {|value, num, chan|

	var x, y;

	y = ( num / 16 ).asInteger;
	x = (num-(y*16))%9;


	~modes[~currentMode]["launchpad"]["callbacks"][x][y].value(x, y, value);

};

~play = {|node, toggle, value, num, chan|

   if( toggle, {
      node["functions"][0].value(node["synthdef"],num,value);
   }, {
      node["functions"][1].value(num);
   });

};



~note = {|toggle, value, num, chan,src|


   switch(src,
      ~launchpadSrcId, {  // launchpad
         ~launchpad.value(value, num, chan);
      },
	);

	~controllers.do{|controller|

		if( src, {



		}, {});
	};

};


   on = MIDIFunc.noteOn({|value, num, chan, src|

      ~note.value(true, value, num, chan, src);

   });


   off = MIDIFunc.noteOff({ |value, num, chan, src|
      ~note.value(false,value, num, chan, src);
   });

   cc = MIDIFunc.cc({ |value, num, chan, src|

		var ccNum = num-104;

["Ccnum",ccNum].postln;

		switch(value,
			0, {
				if( ~menuClockTime > 0, {
					~launchpad_set.value(-1,ccNum,0);
				}, {});
				~menuClockTime = 0;
			},
			127, {
				["cc",ccNum].postln;
				~launchpad_set.value(-1,ccNum,6);

				// start holding
				~menuClockTime = ~clock+1;
				~selectingMenu = ccNum;

			}
		);

   });



~launchpad_set = {|col,row,color|

   NetAddr.localAddr.sendMsg( "/OSCpad/set", col, row, color );

}

)
