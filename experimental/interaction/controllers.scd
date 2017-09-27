(

   ~controllerManager = Dictionary.new();


   ~controllerManager["controllers"] = Dictionary.new();

   // Controller is an association between a controller to a list of nodes
   ~controllerManager["do"] = {|self| z.postln; };

   ~controllerManager["createController"] = {|name, type, midiUID, channel|

      var newController  = ();

      newController.name = name;
      newController.type = type;
      newController.midiUID = midiUID;
      newController.channel = channel;

      newController.nodes = List.new();
      newController.currentNode = 0;

      ~controllerManager["addController"].value(newController);

      /*newController;*/

   };

   ~controllerManager["addController"] = {|controller|


      if( ~controllerManager["controllers"][ controller.midiUID ] == nil, {
         ~controllerManager["controllers"][ controller.midiUID ] = Dictionary.new();
      }, {});

      ~controllerManager["controllers"][ controller.midiUID ][ controller.channel ] = controller;

   };


   ~controllerManager["createNode"] = {|name, synthdef, parameters, functions|

      var newNode;
      newNode = ();

      newNode.name = name;
      newNode.synthdef = synthdef;
      newNode.parameters = parameters;
      newNode.functions = functions;

      newNode.notes = Dictionary.new();

      newNode;

   };







   ~controllerManager["createController"].value("furenku-axiom-25-keys","note", 1572864,0);
   ~controllerManager["createController"].value("furenku-axiom-25-pads","note",1572864,9);
   ~controllerManager["createController"].value("furenku-axiom-25-cc_group1","cc",1572864,10);
   ~controllerManager["createController"].value("furenku-axiom-25-cc_group2","cc",1572864,11);

   ~controllerManager["createController"].value("furenku-axiom-49-keys","note",4472864,0);
   ~controllerManager["createController"].value("furenku-axiom-49-pads","note",4472864,1);
   ~controllerManager["createController"].value("furenku-axiom-49-cc_group1","cc",4472864,10);
   ~controllerManager["createController"].value("furenku-axiom-49-cc_group2","cc",4472864,11);


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
