conduit_debug = true;
conduitVersion = 2;
trace("ehreer yoooo");
init();
function init()
{
	if (conduit_loaded != true) {
    attachMovie("conduit_mc", "conduit", 21597);
    attachMovie("conduitdata_mc", "conduitdata", 22531);
    attachMovie("interactiontimer_mc", "interactiontimer", 25183);
    conduit_loaded = true;
}
if(_framesloaded >= 2) {
    if (_totalframes == 2) {
		nextScene(); 
    }
    else {
        trace("*** WARNING: Please use gotoAndPlay(1) in the last frame of your Motif creative if you intend to loop. ***");
        trace("*** Please use 'stop();' at the end of your Motif creative if you do not intend for it to loop. ***");

        _root.gotoAndPlay(2);
    }
}
	
	
}

