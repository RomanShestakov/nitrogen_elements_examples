-module(grid).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).
%% -define(EVENT_TABSSHOW, 'tabsshow').

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

title() -> "Grid Example".
headline() -> "Grid Example".

body() ->
    [
	#datagrid{
	    id = grid,
	    html_id = grid_html_id,
	    options=[
		{datatype, "clientSide"},
		{colModel, [{name,'summary'}, {name,'date'}]},
		{data, [[{'summary','2'},{'date','10-jul'}], [{'summary','1'},{'date','12-jul'}]]}
	    ]
	}
    ].

y
%% tabs_event(?EVENT_TABSSHOW, Tabs_Id, TabIndex) ->
%%     wf:wire(wf:f("pushState(\"State ~s\", \"?state=~s\", {tabindex:~s});", [TabIndex, TabIndex, TabIndex])).

%% api_event(history_back, _B, [[_,{data, Data}]]) ->
%%     %% ?PRINT({history_back_event, B, Data}),
%%     TabIndex = proplists:get_value(tabindex, Data),
%%     wf:wire(tabs, #tab_event_off{event = ?EVENT_TABSSHOW}),
%%     wf:wire(tabs, #tab_select{tab = TabIndex}),
%%     wf:wire(tabs, #tab_event_on{event = ?EVENT_TABSSHOW});
%% api_event(A, B, C) ->
%%     ?PRINT(A), ?PRINT(B), ?PRINT(C).
