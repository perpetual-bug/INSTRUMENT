(

   ~controllerManager = Dictionary.new();


   ~controllerManager["controllers"] = Dictionary.new();

   // Controller is an association between a controller to a list of instruments
   ~controllerManager["do"] = {|self| z.postln; };

   ~controllerManager["createController"] = {|name, midiUID, channel|

      var newController  = ();

      newController.name = name;
      newController.midiUID = midiUID;
      newController.channel = channel;

      newController.instruments = List.new();
      newController.currentInstrument = 0;

      ~controllerManager["addController"].value(newController);

      /*newController;*/

   };

   ~controllerManager["addController"] = {|controller|


      if( ~controllerManager["controllers"][ controller.midiUID ] == nil, {
         ~controllerManager["controllers"][ controller.midiUID ] = Dictionary.new();
      }, {});

      ~controllerManager["controllers"][ controller.midiUID ][ controller.channel ] = controller;

   };


   ~controllerManager["createInstrument"] = {|name, synthdef, parameters, functions|

      var newInstrument;
      newInstrument = ();

      newInstrument.name = name;
      newInstrument.synthdef = synthdef;
      newInstrument.parameters = parameters;
      newInstrument.functions = functions;

      newInstrument.notes = Dictionary.new();

      newInstrument;

   };







   ~controllerManager["createController"].value("furenku-axiom-25-keys",1572864,0);
   ~controllerManager["createController"].value("furenku-axiom-25-pads",1572864,9);
   ~controllerManager["createController"].value("furenku-axiom-25-cc_group1",1572864,10);
   ~controllerManager["createController"].value("furenku-axiom-25-cc_group2",1572864,11);

   ~controllerManager["createController"].value("furenku-axiom-49-keys",4472864,0);
   ~controllerManager["createController"].value("furenku-axiom-49-pads",4472864,1);


   /*~controllerManager["controllers"].postln;*/
   ~controllerManager["controllers"].keysDo({|controllerSrcKey,i|
      var controllerSrc = ~controllerManager["controllers"][controllerSrcKey];
      ("\nMidi source: "++controllerSrcKey).postln;
      controllerSrc.do({|controllerChannel|
         controllerChannel.name.postln;
      })
   });
   ""

);
