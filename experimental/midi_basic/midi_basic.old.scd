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


	~modes[~currentMode][x][y].value(x, y, value);




	/*[x,y].postln;*/
	/*~modes[~currentMode].postln;*/

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
      var currentController;
      var currentInstrumentChannel;
      var currentInstrument;
      var synthdef;

      var startOffset;
      var parameterIndex;
      var parameters;


      switch(src,

         ~launchpadSrcId, {

         },
         //1310720, { // radium49
         ~controller1SrcId, {  // axiom 25
            currentController = ~controller1;

            startOffset = 0;

            // skip one because params come in pairs ( \key, value )

            parameterIndex = ((num - startOffset)*2).postln;

            currentInstrumentChannel = currentController["nodes"][chan];
            currentInstrument = currentInstrumentChannel[currentInstrumentChannel["currentInstrument"]];


            currentInstrument["parameters"][parameterIndex + 1] = value / 127;

            parameters = currentInstrument["parameters"];


            currentInstrument["notes"].collect({|i|
               i.set(parameters[0],parameters[1]);
               i.set(parameters[2],parameters[3]);
               i.set(parameters[4],parameters[5]);
               i.set(parameters[6],parameters[7]);
               });
               // TO DO : ALTER CURRENT SYNTHS
            }
            );



            });



~launchpad_set = {|col,row,color|

   NetAddr.localAddr.sendMsg( "/OSCpad/set", col, row, color );

}

)
