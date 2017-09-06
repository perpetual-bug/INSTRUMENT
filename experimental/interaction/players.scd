(

   ~players = List.new();

   // Player is an association between a controller to a list of instruments

   ~newPlayer = {|name|

      var newPlayer;

      newPlayer = Dictionary.new();
      newPlayer["name"] = name;
      newPlayer["instruments"] = List.new();
      newPlayer["notes"] = Dictionary.new();
      newPlayer["currentInstrument"] = 0;

      newPlayer["createInstrument"] = {|name, synthdef, parameters, functions|

         var newInstrument;

         newInstrument = Dictionary.new();
         newInstrument["name"] = name;
         newInstrument["synthdef"] = synthdef;
         newInstrument["parameters"] = parameters;
         newInstrument["functions"] = functions;

         newInstrument;

      };

      newPlayer;



   };



);
