% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(tabs).
-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.
title() -> "Tabs Pane Example".
headline() -> "Tabs Pane Example".

body() ->
    %% bind to tabs 'tabsactive' event
    wf:wire(tabs, #tab_event_on{type = ?EVENT_TABSACTIVATE, postback = {tabs, ?EVENT_TABSACTIVATE}}),
    %% wire tabs_select to show how to change tab after tabs control was initialized
    wf:wire(tabs, #event{type = ?EVENT_TABSCREATE, actions = [#tab_select{target = tabs, tab = 1}]}),
    %% wire api_event, this will create javascript function 'page.history_back'
    wf:wire(#api{name = history_back, tag = f1}),
    %% output html markup
    [
	#tabs{
	    id = tabs,
	    options = [{selected, 0}],
	    tabs = [
		#tab{title = "Tab 1", url = "/content/tabs2.htm"},
		#tab{title = "Tab 2", body = ["Tab two body..."]},
		#tab{title = "Tab 3", body = ["Tab three body..."]}
	    ]
	},
     %% add button to disable tabs
     #button{id=btn_disable, text="Disable All tabs", actions=[#event{type=click, postback=disable_tabs}]},
     #button{id=btn_disable1, text="Disable Some tabs", actions=[#event{type=click, postback=disable_some_tabs}]}

].

event({ID, ?EVENT_TABSACTIVATE}) ->
    ?PRINT({tabs_event, ?EVENT_TABSACTIVATE}),
    wf:wire(wf:f("(function(){var index = jQuery(obj('~s')).tabs(\"option\", \"active\");
                     pushState(\"State\"+index, \"?state=\"+index, {tabindex:index});})();", [ID]));
event(disable_tabs) ->
    %% wf:wire(#tab_destroy{target=tabs}),
    wf:wire(#tab_disable{target=tabs}),
    wf:replace(btn_disable,
       #button{id=btn_enable, text="Enable All tabs", actions=[#event{type=click, postback=enable_tabs}]});
event(enable_tabs) ->
    wf:wire(#tab_enable{target=tabs}),
    wf:replace(btn_enable,
       #button{id=btn_disable, text="Disable All tabs", actions=[#event{type=click, postback=disable_tabs}]});
event(disable_some_tabs) ->
    %% ?PRINT({tabs_event, disable_some_tabs}),
    W = wf:f("jQuery(obj('~s')).tabs(\"option\", \"disabled\", ~w);", [tabs, [1, 2]]),
    ?PRINT({tabs_event, W}),
    wf:wire(#tab_disable{target=tabs, tab = [1, 2]}),
    wf:replace(btn_disable1,
       #button{id=btn_enable1, text="Enable All tabs", actions=[#event{type=click, postback=enable_some_tabs}]});
event(enable_some_tabs) ->
    wf:wire(#tab_enable{target=tabs, tab = [1, 2]}),
    wf:replace(btn_enable1,
       #button{id=btn_disable1, text="Disable Some tabs", actions=[#event{type=click, postback=disable_some_tabs}]}).

api_event(history_back, _B, [[_,{data, Data}]]) ->
    ?PRINT({history_back_event, _B, Data}),
    TabIndex = proplists:get_value(tabindex, Data),
    wf:wire(tabs, #tab_event_off{type = ?EVENT_TABSACTIVATE}),
    wf:wire(tabs, #tab_select{tab = TabIndex}),
    wf:wire(tabs, #tab_event_on{type = ?EVENT_TABSACTIVATE});
api_event(A, B, C) ->
    ?PRINT(A), ?PRINT(B), ?PRINT(C).

