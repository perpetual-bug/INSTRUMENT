(

~modes = Dictionary.new();

~currentMode = "chooseChannelInstrument";


// Activate listeners
~menus = Array.fill(2,{
	Array.fill(8,{
		"test"
	});
});



~update_listener.free;
~update_listener = OSCFunc.newMatching( { arg msg;
var num;
var col, row, val;

msg.postln;

col = msg[1].asInteger;
row = msg[2].asInteger;
val = msg[3].asInteger;

if( row == -1, {

	(~menus[0][col]).postln;

},
{

	if( col == 8, {

		(~menus[1][row]).postln;

	}, {
		~modes[~currentMode].postln;
		~modes[~currentMode][row][col].postln;
		/*~modes[~currentMode][row][col].value(row,col,val);*/

	});

});




}, '/OSCpad/update' );
// Subscribe SuperCollider itself
NetAddr.localAddr.sendMsg( "/OSCpad/subscribe", NetAddr.localAddr.port );
)
