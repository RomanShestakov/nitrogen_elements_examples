(function(window,undefined){

    // Prepare
    var
    History = window.History; // Note: We are using a capital H instead of a lower h
    var timestamps = []; //array of uniq timestamps

    if ( !History.enabled ) {
        // History.js is disabled for this browser.
        // This is because we can optionally choose to support HTML4 browsers or not.
        return false;
    }

    // push state
    function pushState (title, url, anydata) {
	// creating uniq timestamps
	var t = new Date().getTime();
	timestamps[t] = t;
	// adding to history
	History.pushState({timestamp:t, data:anydata}, title, url);
    }
    // assign to global pushState
    window.pushState = pushState;

    // Bind to StateChange Event
    History.Adapter.bind(window, 'statechange', function(){ // Note: We are using statechange instead of popstate
        var State = History.getState(); // Note: We are using History.getState() instead of event.state
	if(State.data.timestamp in timestamps)
	    delete timestamps[State.data.timestamp];
	else {
	    // send postbacks to nitrogen page
	    page.history_back(State.data);
	    //console.log('backbutton fired!');
	}
    })

})(window);
