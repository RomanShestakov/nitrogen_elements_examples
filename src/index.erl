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

body() ->

    wf:wire(wf:f("function resizeGrid(pane, $Pane, paneState) {
          jQuery(obj('~s')).jqGrid('setGridWidth', paneState.innerWidth - 2, 'true')};", [jqgrid])),

[
    % Main layout...
    #layout {
	%% add menubar for navigation
    	north=menubar(),
    	north_options = [{size, 60}, {spacing_open, 0}, {spacing_closed, 0}],

    	west=#panel{id = west, text = "West"},
    	west_options=[{size, 200}, {spacing_open, 0}, {spacing_closed, 0}],

    	center=#panel{id = center, body = [ #label{ text = "Center" }]},
    	center_options=[{onresize, resizeGrid},	{triggerEventOnLoad, true}],

    	east=#panel{id = east, text = "East"},
    	east_options=[{size, 300}],
    	%%east_options=[{size, 300}, {spacing_open, 0}, {spacing_closed, 0}],

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
	    #item{postback = accordion, title = "Accordion"},
	    #item{postback = tabs, title = "Tabs"},
	    #item{postback = menu, title = "Menu"},
	    #item{postback = grid, title = "Grid"},
	    #item{postback = progressbar, title = "Progressbar"},
	    #item{postback = viz, title = "Viz.js"}
	]
}].

event(action_dialog_example) ->
    wf:update(west, #panel{id = west, body = []}),
    wf:update(center, #panel{id = center, body = [dialog:body()]}),
    wf:update(east, #panel{id = east, body = []});
event(accordion) ->
    wf:update(west, #panel{id = west, body = []}),
    wf:update(center, #panel{id = center, body = [accordion:body(accordion_example_tag)]}),
    wf:update(east, #panel{id = east, actions = [#ajax_load{target = east, url = "/static/doc/html/elements/accordion.html"}]});
event(tabs) ->
    wf:update(west, #panel{id = west, body = [tabs:control_panel(tabs_example_tag)]}),
    wf:update(center, #panel{id = center, body = [tabs:body(tabs_example_tag)]}),
    wf:update(east, #panel{id = east, actions = [#ajax_load{target = east, url = "/static/doc/html/elements/tabs.html"}]});
event(menu) ->
    wf:update(west, #panel{id = west, body = []}),
    wf:update(center, #panel{id = center, body = [menu:body(menu_example_tag)]}),
    wf:update(east, #panel{id = east, actions = [#ajax_load{target = east, url = "/static/doc/html/elements/menu.html"}]});
event(grid) ->
    wf:update(west, #panel{id = west, body = []}),
    wf:update(center, #panel{id = center, body = [grid:body()]}),
    wf:update(east, #panel{id = east, actions = [#ajax_load{target = east, url = "/static/doc/html/elements/jqgrid.html"}]});
event(viz) ->
    wf:update(west, #panel{id = west, body = [viz:control_panel(viz_example_tag)]}),
    wf:update(center, #panel{id = center, body = [viz:body(viz_example_tag)]}),
    wf:update(east, #panel{id = east, body = []});
event(progressbar) ->
    wf:update(west, #panel{id = west, body = []}),
    wf:update(center, #panel{id = center, body = [progressbar:body(progressbar_example_tag)]}),
    wf:update(east, #panel{id = east, actions = [#ajax_load{target = east, url = "/static/doc/html/elements/progressbar.html"
}]});

%% postbacks from controls
event({tabs_example_tag, Event}) ->
    tabs:event(Event);
event({menu_example_tag, Event}) ->
    menu:event(Event);
event({dialog_example_tag, Event}) ->
    dialog:event(Event);
event({viz_example_tag, Event}) ->
    viz:event({viz_example_tag, Event});
event({progressbar_example_tag, Event}) ->
    ?PRINT({progressbar_event, Event}),
    progressbar:event(Event);
event(Event) ->
    ?PRINT({event, Event}).

%% jqgrid events
jqgrid_event({Postback, Event}) ->
    grid:event({Postback, Event}).

api_event(history_back, tabs_example_tag, Data) ->
    tabs:api_event(history_back, tabs_example_tag, Data).

