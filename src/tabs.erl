-module(tabs).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).
-define(EVENT_TABSSHOW, 'tabsshow').

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

title() -> "Tabs Pane Example".
headline() -> "Tabs Pane Example".

body() ->
    wf:wire(tabs, #tab_event_on{event = ?EVENT_TABSSHOW}),
    wf:wire(#api{name=history_back, tag=f1}),
    [
	#tabs{
	    id = tabs,
	    options=[
		{selected, 0}
		%% {event, mouseover},
		%% {cache, true}
	    ],
	    tabs=[
		#tab{title="Tab 1", url = "/content/tabs2.htm"},
		#tab{title="Tab 2", body=["Tab two body..."]},
		#tab{title="Tab 3", body=["Tab three body..."]}
	    ]
	}
].

tabs_event(?EVENT_TABSSHOW, Tabs_Id, TabIndex) ->
    wf:wire(wf:f("pushState(\"State ~s\", \"?state=~s\", {tabindex:~s});", [TabIndex, TabIndex, TabIndex])).

api_event(history_back, _B, [[_,{data, Data}]]) ->
    %% ?PRINT({history_back_event, B, Data}),
    TabIndex = proplists:get_value(tabindex, Data),
    wf:wire(tabs, #tab_event_off{event = ?EVENT_TABSSHOW}),
    wf:wire(tabs, #tab_select{tab = TabIndex}),
    wf:wire(tabs, #tab_event_on{event = ?EVENT_TABSSHOW});
api_event(A, B, C) ->
    ?PRINT(A), ?PRINT(B), ?PRINT(C).
