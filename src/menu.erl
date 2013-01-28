% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(menu).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

body(Tag) ->

    %% output html markup
    [
	#menu{
	    id = menu,
	    options = [ %%{disabled, true},
		{icons, {{submenu, <<"ui-icon-circle-triangle-e">>}}},
		{position, {{my, <<"left top">>}, {at, <<"right top">>}}}
	    ],
	    style = "width:150px;",
	    body = [
		#item{title = "USA", body = [#item{title = "New York City"}, #item{title = "Boston"}]},
		#item{title = "UK"},
		#item{title = "Russia"}
	    ],
	   %% add actions which bind native menu events
	   actions = [ #menu_event_on{trigger = menu, type = ?EVENT_MENU_CREATE, postback = {Tag, {menu, ?EVENT_MENU_CREATE}}},
		       #menu_event_on{trigger = menu, type = ?EVENT_MENU_FOCUS, postback = {Tag, {menu, ?EVENT_MENU_FOCUS}}}
		     ]
	}
    ].

event({_ID, ?EVENT_MENU_CREATE}) ->
    ?PRINT({menu_event, ?EVENT_MENU_CREATE});
event({ID, ?EVENT_MENU_FOCUS}) ->
    ?PRINT({menu_event, ?EVENT_MENU_FOCUS});
event(Event) ->
    ?PRINT({menu_event, Event}).
