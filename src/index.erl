% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(index).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() ->
    #template { file=filename:join([web_common:templates(), "onecolumn.html"])
}.

title() -> "Nitrogen Elements Examples".
headline() -> "Nitrogen Elements Examples".

body() -> [

    % Main layout...
    #layout {
	%% add menubar for navigation
    	north=menubar(),
    	north_options = [{size, 60}, {spacing_open, 0}, {spacing_closed, 0}],

    	west=#panel{id = west, text = "West"},
    	west_options=[{size, 140}, {spacing_open, 0}, {spacing_closed, 0}],

    	center=#panel{id = center, body = [ #label{ text = "Center" }]},

    	east=#panel{id = east, text = "East"},
    	east_options=[{size, 200}, {spacing_open, 0}, {spacing_closed, 0}],

    	south=#panel{id = south, text = "South"},
    	south_options=[{size, 30}, {spacing_open, 0}, {spacing_closed, 0}]
    }
].

menubar() -> [
    #menubar{
	id = elements_menu,
	options = [
	    {autoExpand, true},
	    {menuIcon, true},
	    {buttons, true},
	    {select, select}
	],
	body = [
	    #item{postback = action_dialog_example, title = "Action Dialog"},
	    #item{postback = tabs, title = "Tabs"},
	    #item{postback = menu, title = "Menu"},
	    #item{postback = grid, title = "Grid"},
	    #item{postback = progressbar, title = "Progressbar"}
	]
}].

event(action_dialog_example) ->
    %% ?PRINT({tabsevent, action}),
     wf:update(center, #panel{id = center, body = [dialog:body()]});
event(tabs) ->
    %% ?PRINT({tabsevent, tabs});
    wf:update(center, #panel{id = center, body = [tabs:body(tabs_example_tag)]});
event(menu) ->
    ?PRINT({tabsevent, manu});

    %% wf:update(display_pnl, #panel{id = display_pnl, body = [menu:body(menu_example_tag)]});
event(grid) ->
    ?PRINT({tabsevent, grid});
    %% wf:update(display_pnl, #panel{id = display_pnl, body = [ #label{ text = "grid" }]});
event(progressbar) ->
    ?PRINT({tabsevent, progressbar}).
    %% wf:update(display_pnl, #panel{id = display_pnl, body = [ #label{ text = "progressbar" }]}).

event({tabs_example_tag, Event}) ->
    ?PRINT({tabs_event_tag, Event}),
    tabs:event(Event);
event({menu_example_tag, Event}) ->
    ?PRINT({menu_event_tag, Event}),
    menu:event(Event).
