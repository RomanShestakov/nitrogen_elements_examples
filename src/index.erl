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


layout() ->
    #container_12 { body=[
        #grid_12 { body=header() },
	#p{},
	#p{},
        #grid_12 { body=[ #panel{id = display_pnl, body = [ #label{ text = "test" }]} ] }
    ]}.

header() ->
    #panel { body=[menubar()]}.

menubar() -> [
    #panel{
    	body = [
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
	}]
}].

dialog() ->
    #dialog{buttons = [{"Ok", ok}], show_cancel = true, title = "Action Dialog Title", body = "Action Dialog Body"}.
event(action_dialog_example) ->
    wf:update(display_pnl, #panel{id = display_pnl, body = [dialog()]});
event(tabs) ->
    wf:wire(#event{trigger = tabs, type = ?EVENT_TABS_CREATE, actions = [#tab_select{target = tabs, tab = 1}]}),
    wf:wire(tabs, #event{type = ?EVENT_TABS_CREATE, actions = ["alert(\"created\")"]}),
    wf:update(display_pnl, #panel{id = display_pnl, body = [tabs:body(tabs_example_tag)]});
event(menu) ->
    wf:update(display_pnl, #panel{id = display_pnl, body = [menu:body(menu_example_tag)]});
event(grid) ->
    wf:update(display_pnl, #panel{id = display_pnl, body = [ #label{ text = "grid" }]});
event(progressbar) ->
    wf:update(display_pnl, #panel{id = display_pnl, body = [ #label{ text = "progressbar" }]});



%% event({ID, ?EVENT_TABS_ACTIVATE}) ->
%%     wf:wire(wf:f("(function(){var index = jQuery(obj('~s')).tabs(\"option\", \"active\");
%%                      pushState(\"State\"+index, \"?state=\"+index, {tabindex:index});})();", [ID]));
%% event({_ID, ?EVENT_TABS_BEFORE_ACTIVATE}) ->
%%     ?PRINT({tabs_event, ?EVENT_TABS_BEFORE_ACTIVATE});
%% event({_ID, ?EVENT_TABS_BEFORE_LOAD}) ->
%%     ?PRINT({tabs_event, ?EVENT_TABS_BEFORE_LOAD});
%% event({_ID, ?EVENT_TABS_CREATE}) ->
%%     ?PRINT({tabs_event, ?EVENT_TABS_CREATE});
%% event({_ID, ?EVENT_TABS_LOAD}) ->
%%     ?PRINT({tabs_event, ?EVENT_TABS_LOAD});

%% event(disable_tabs) ->
%%     wf:wire(#tab_disable{target=tabs}),
%%     wf:replace(btn_disable,
%%        #button{id=btn_enable, text="Enable All tabs", actions=[#event{type=click, postback=enable_tabs}]});
%% event(enable_tabs) ->
%%     wf:wire(#tab_enable{target=tabs}),
%%     wf:replace(btn_enable,
%%        #button{id=btn_disable, text="Disable All tabs", actions=[#event{type=click, postback=disable_tabs}]});
%% event(disable_some_tabs) ->
%%     wf:wire(#tab_disable{target=tabs, tab = [1, 2]}),
%%     wf:replace(btn_disable1,
%%        #button{id=btn_enable1, text="Enable All tabs", actions=[#event{type=click, postback=enable_some_tabs}]});
%% event(enable_some_tabs) ->
%%     wf:wire(#tab_enable{target=tabs, tab = [1, 2]}),
%%     wf:replace(btn_enable1,
%%        #button{id=btn_disable1, text="Disable Some tabs", actions=[#event{type=click, postback=disable_some_tabs}]});
%% event(select_tab) ->
%%     Index = wf:q(tbx_tab_index),
%%     wf:wire(#tab_select{target=tabs, tab = wf:to_integer(Index)});
%% event(remove_tab) ->
%%     Index = wf:q(tbx_tab_remove_index),
%%     wf:wire(#tab_remove{target = tabs, tab = wf:to_integer(Index)});
%% event(add_tab) ->
%%     Title = wf:q(tbx_add_tab),
%%     wf:wire(#tab_add{target = tabs, title = Title, url = "/content/tabs2.htm"});
%% event(select_option) ->
%%     Option = wf:q(dropdown),
%%     wf:wire(#tab_option{target=tabs, key=list_to_atom(Option)});
%% event(select_options) ->
%%     wf:wire(#tab_option{target=tabs});
%% event({option, Key}) ->
%%     Option = wf:q(Key),
%%     wf:flash(wf:f("~s: ~s", [Key, Option]));
%% event(options) ->
%%     Active=wf:q(active),
%%     Collapsible=wf:q(collapsible),
%%     Disabled=wf:q(disabled),
%%     Event=wf:q(event),
%%     HeightStyle=wf:q(heightStyle),
%%     Hide=wf:q(hide),
%%     Show=wf:q(show),
%%     wf:flash(wf:f("Active:~s, Collapsible:~s, Disabled:~s, Event:~s, HeightStyle:~s, Hide:~s, Show:~s",
%% 		  [Active, Collapsible, Disabled, Event, HeightStyle, Hide, Show]));

event({tabs_example_tag, Event}) ->
    ?PRINT({tabs_event_tag, Event}),
    tabs:event(Event);
event({menu_example_tag, Event}) ->
    ?PRINT({menu_event_tag, Event}),
    menu:event(Event).

%% api_event(history_back, _B, [[_,{data, Data}]]) ->
%%     ?PRINT({history_back_event, _B, Data}),
%%     TabIndex = proplists:get_value(tabindex, Data),
%%     wf:wire(tabs, #tab_event_off{type = ?EVENT_TABS_ACTIVATE}),
%%     wf:wire(tabs, #tab_select{tab = TabIndex}),
%%     wf:wire(tabs, #tab_event_on{type = ?EVENT_TABS_ACTIVATE});
%% api_event(A, B, C) ->
%%     ?PRINT(A), ?PRINT(B), ?PRINT(C).

