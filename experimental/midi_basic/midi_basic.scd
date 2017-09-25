(

var on, off, cc;

var loadMode;

~launchpadSrcId = 1310720;
~controller1SrcId = 1572864;



/*~playFunc = {|controller|
	var currentInstrumentChannel;
	var currentInstrument;

	currentInstrument = currentInstrumentChannel[currentInstrumentChannel["currentInstrument"]];
	~play.value(currentInstrument, toggle, value, num, chan);
};*/


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

~modes.postln;

~launchpad = {|value, num, chan|

	var x, y;

	x = num % 8;
	y = ( num / 16 ).asInteger;

	/*[x,y].postln;*/
	/*~modes[~currentMode].postln;*/
	~modes[~currentMode][x][y].value(x, y, value);

};

~play = {|instrument, toggle, value, num, chan|

   ("play:"++[toggle, instrument["synthdef"],num,value]).postln;
   if( toggle, {
      instrument["functions"][0].value(instrument["synthdef"],num,value);
   }, {
      instrument["functions"][1].value(num);
   });

};

~note = {|toggle, value, num, chan,src|


   /*[src].postln;*/

   [value, num, chan, src].postln;

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

      /*[value, num, chan, src].postln;*/

      switch(src,

         ~launchpadSrcId, {


         ("launchpad!"++value++", chan:"++chan).postln;


         },
         //1310720, { // radium49
         ~controller1SrcId, {  // axiom 25
            currentController = ~controller1;

            startOffset = 0;

            // skip one because params come in pairs ( \key, value )

            parameterIndex = ((num - startOffset)*2).postln;
            ("CHAN"++chan).postln;
            currentInstrumentChannel = currentController["instruments"][chan];
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
