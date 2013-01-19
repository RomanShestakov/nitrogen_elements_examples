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
    wf:wire(tabs, #event{type = ?EVENT_TABSCREATE, actions = [#tab_select{target = tabs, tab = 2}]}),
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
	}
].

event({ID, ?EVENT_TABSACTIVATE}) ->
    ?PRINT({tabs_event, ?EVENT_TABSACTIVATE}),
    wf:wire(wf:f("(function(){var index = jQuery(obj('~s')).tabs(\"option\", \"active\");
                     pushState(\"State\"+index, \"?state=\"+index, {tabindex:index});})();", [ID])).

api_event(history_back, _B, [[_,{data, Data}]]) ->
    ?PRINT({history_back_event, _B, Data}),
    TabIndex = proplists:get_value(tabindex, Data),
    wf:wire(tabs, #tab_event_off{type = ?EVENT_TABSACTIVATE}),
    wf:wire(tabs, #tab_select{tab = TabIndex}),
    wf:wire(tabs, #tab_event_on{type = ?EVENT_TABSACTIVATE});
api_event(A, B, C) ->
    ?PRINT(A), ?PRINT(B), ?PRINT(C).

