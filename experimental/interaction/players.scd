(

   ~playerManager = Dictionary.new();


   ~playerManager["players"] = Dictionary.new();

   // Player is an association between a controller to a list of instruments
   ~playerManager["do"] = {|self| z.postln; };

   ~playerManager["createPlayer"] = {|name, midiUID, channel|

      var newPlayer  = ();

      newPlayer.name = name;
      newPlayer.midiUID = midiUID;
      newPlayer.channel = channel;

      newPlayer.instruments = List.new();
      newPlayer.currentInstrument = 0;

      ~playerManager["addPlayer"].value(newPlayer);

      /*newPlayer;*/

   };

   ~playerManager["addPlayer"] = {|player|


      if( ~playerManager["players"][ player.midiUID ] == nil, {
         ~playerManager["players"][ player.midiUID ] = Dictionary.new();
      }, {});

      ~playerManager["players"][ player.midiUID ][ player.channel ] = player;

   };


   ~playerManager["createInstrument"] = {|name, synthdef, parameters, functions|

      var newInstrument;
      newInstrument = ();

      newInstrument.name = name;
      newInstrument.synthdef = synthdef;
      newInstrument.parameters = parameters;
      newInstrument.functions = functions;

      newInstrument.notes = Dictionary.new();

      newInstrument;

   };







   ~playerManager["createPlayer"].value("furenku-axiom-25-keys",1572864,0);
   ~playerManager["createPlayer"].value("furenku-axiom-25-pads",1572864,9);
   ~playerManager["createPlayer"].value("furenku-axiom-25-cc_group1",1572864,10);
   ~playerManager["createPlayer"].value("furenku-axiom-25-cc_group2",1572864,11);

   ~playerManager["createPlayer"].value("furenku-axiom-49-keys",4472864,0);
   ~playerManager["createPlayer"].value("furenku-axiom-49-pads",4472864,1);


   /*~playerManager["players"].postln;*/
   ~playerManager["players"].keysDo({|playerSrcKey,i|
      var playerSrc = ~playerManager["players"][playerSrcKey];
      ("\nMidi source: "++playerSrcKey).postln;
      playerSrc.do({|playerChannel|
         playerChannel.name.postln;
      })
   });
   ""

);
