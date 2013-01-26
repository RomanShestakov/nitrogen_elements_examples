% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(menu).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

%% main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

%% title() -> "Menu Example".
%% headline() -> "Menu Example".

body(Tag) ->
    %% bind to menu events
    wf:wire(menu, #menu_event_on{type = ?EVENT_MENU_CREATE, postback = {Tag, {menu, ?EVENT_MENU_CREATE}}}),
    wf:wire(menu, #menu_event_on{type = ?EVENT_MENU_FOCUS, postback = {Tag, {menu, ?EVENT_MENU_FOCUS}}}),

    %% output html markup
    [
	#menu{
	    id = menu,
	    options = [],
	    style = "width:150px;",
	    body = [
		#item{title = "USA", body = [#item{title = "New York City"}, #item{title = "Boston"}]},
		#item{title = "UK"},
		#item{title = "Russia"}
	    ]
	}
    ].

event({ID, ?EVENT_MENU_CREATE}) ->
    ?PRINT({menu_event, ?EVENT_MENU_CREATE});
event({ID, ?EVENT_MENU_FOCUS}) ->
    ?PRINT({menu_event, ?EVENT_MENU_FOCUS});
event(Event) ->
    ?PRINT({menu_event, Event}).
