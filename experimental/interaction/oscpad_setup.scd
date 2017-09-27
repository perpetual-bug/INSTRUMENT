(
//***** API *****
/*
 * To subscribe to updates, send receiving port to /OSCpad/subscribe. OSCpad
 * will confirm this by returning /OSCpad/subscribe.
 *     /OSCpad/subscribe : port
 *
 * To reset the Launchpad (clear all pads).
 *     /OSCpad/reset
 *
 * Pads are defined by an ( x, y ) position. ( 0, 0 ) is the top left pad of the
 * grid. The top row (the control buttons) have position ( x, -1 ).
 *
 * To control a pad send to /OSCpad/set.
 *     /OSCpad/set : x y color
 *
 * Launchpad updates will be sent to /OSCpad/update.
 *     /OSCpad/update : x y color
 */

/*
 * Array with values of all the colors. The index corresponds with the
 * value sent in OSC packets.
 */
~lp_colors = [
	0x0C, // 00: OFF

	0x0D, // 01: RED THIRD
	0x0E, // 02: RED HALF
	0x0F, // 03: RED FULL
	0x0B, // 04: RED BLINK

	0x1C, // 05: GREEN THIRD
	0x2C, // 06: GREEN HALF
	0x3C, // 07: GREEN FULL
	0x38, // 08: GREEN BLINK

	0x1D, // 09: AMBER THIRD
	0x2E, // 10: AMBER HALF
	0x3F, // 11: AMBER FULL
	0x3B  // 12: AMBER BLINK
];
~lp_colors_verbose = [
	"OFF",
	"RED THIRD", "RED HALF", "RED FULL", "RED BLINK",
	"GREEN THIRD", "GREEN HALF", "GREEN FULL", "GREEN BLINK",
	"AMBER THIRD", "AMBER HALF", "AMBER FULL", "AMBER BLINK"
];

// Dump info notice
"***** Launching OSCpad *****\n@koenaad".postln;
("Receiving packets on " ++ NetAddr.localAddr.ip  ).postln;
"Listening on ports:".postln;
thisProcess.openPorts.do( { arg item; ( " - " + item ).postln; } );

//***** Unity --> LP *****
// OSC in, MIDI out

// find a MIDI destination with Launchpad in the name
~lp_name = nil;
// MIDIClient.init( verbose: false );
MIDIClient.destinations.do( {
	arg item;

if ( item.name.find( "Launchpad" ) != nil, { ~lp_name = item.name; } );
} );
if ( ~lp_name == nil, { "Is there a Launchpad connected?".die; } );

// connect to Launchpad
~lp_send = MIDIOut.newByName( ~lp_name, ~lp_name );
( "Connected to " + ~lp_name ).postln;

/*
 * /OSCpad/subscribe : port
 */
// Set keeps track of all the subscribers.
~subscribers = Set[];

~osc_subscribe.free;
~osc_subscribe = OSCFunc.newMatching( {
	arg msg, time, addr, recvPort;
	var sub_addr;

	if ( msg.size() >= 2, {
		sub_addr = NetAddr( addr.ip, msg.at( 1 ) );

		if ( Set[ sub_addr ].isSubsetOf( ~subscribers ), {
			( "Request from " ++ sub_addr.ip ++ ":" ++ sub_addr.port ++ "." ++
				"Already in subscribers." ).postln;
		}, {
			~subscribers.add( sub_addr );
			( "New subscriber " ++ sub_addr.ip ++ ":" ++ sub_addr.port ).postln;
		} );

		sub_addr.sendMsg( "/OSCpad/subscribe" ); // confirm packet

		"Current subscribers:".postln;
		~subscribers.do( { arg item; ( " - " ++ item.ip ++ ":" ++ item.port ).postln }
		);
	} );

	}, '/OSCpad/subscribe'
);

/*
 * /OSCpad/reset
 */
~osc_reset.free;
~osc_reset = OSCFunc.newMatching( {
	arg msg, time, addr, recvPort;

	~lp_send.control( 0, 0, 0 );  // CC0 - 0 = reset
	~lp_send.control( 0, 0, 40 ); // CC0 - 40 = enable blinking

	"Sent reset to Launchpad.".postln;

}, '/OSCpad/reset'
);

/*
 * /OSCpad/set : x y color
 */
~osc_set.free;
~osc_set = OSCFunc.newMatching( {
	arg msg, time, addr, recvPort;
	var x, y, color;

	if ( msg.size() >= 4, {
		x = msg.at( 2 );
		y = msg.at( 1 );
		color = msg.at( 3 );

		if ( y >= 0, {
			~lp_send.noteOn( 0, (16*x + y), ~lp_colors[ color ] );
		}, {
			~lp_send.control( 0, 104 + x, ~lp_colors[ color ] );
		} );

//		( "LP: ( " ++ x ++ ", " ++ y ++ " ) " ++ ~lp_colors_verbose[ color ] ).postln;
	} );

}, '/OSCpad/set'
);

//***** LP --> Unity *****
// MIDI In, OSC out

/*
// MIDI CC listener
MIDIdef.cc( \ccListener, {
	| value, note, channel, src |
	var x;

	x = note - 104;

	~subscribers.do( { arg sub; sub.sendMsg( "/OSCpad/update", x, -1, value ); } );
} );*/

NetAddr.localAddr.sendMsg( "/OSCpad/reset" );

"";

)

/*
// send test OSC message

NetAddr.localAddr.sendMsg( "/OSCpad/set", 8, 3, 7 );

// fake MIDI input
MIDIIn.doNoteOnAction( 1, 0, 33, 127 );
MIDIIn.doNoteOnAction( 1, 0, 34, 0 );:*/
