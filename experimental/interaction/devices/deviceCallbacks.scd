~instrumentCallback = {|channel, value|

   ["instrument", channel, value ].postln;

};

~fxCallback = {|channel, value|

   ["fx", channel, value ].postln;

};

~mixCallback = {|channel, value|

   ["mix", channel, value ].postln;

};

~loopCallback = {|channel, value|

   ["loop", channel, value ].postln;

};
