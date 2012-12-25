-module(grid).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).
%% -define(EVENT_TABSSHOW, 'tabsshow').

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

title() -> "Grid Example".
headline() -> "Grid Example".

body() ->

    %% wf:wire(wf:f("var populateGrid = function(postdata){alert(\"postdata\")};", [])),
    [
	#datagrid{
	    id = jqgrid,
	    options=[
		%% grid config
		{url, 'http://localhost:8000/get_jqgrid_data'},
		{datatype, <<"json">>},
		%% {datatype, <<"clientSide">>},
		%% DataModel
		%% {colNames, ['Inv No', 'Date', 'Client', 'Amount', 'Tax', 'Total', 'Notes']},
		{colModel, [
		    [{name, 'id1'}, {index, 'id1'}, {width, 55}],
		    [{name, 'name1'}, {index, 'name1'}, {width, 80}],
		    [{name, 'values1'}, {index, 'values1'}, {width, 100}]
		    %% [{name, 'amount'}, {index, 'amount'}, {width, 80}, {align, <<"right">>}],
		    %% [{name, 'tax'}, {index, 'tax'}, {width, 80}, {align, <<"right">>}],
		    %% [{name, 'total'}, {index, 'total'}, {width, 80}, {align, <<"right">>}],
		    %% [{name, 'note'}, {index, 'note'}, {width, 150}, {sortable, false}]
		]},
		{rowNum, 10},
		{rowList, [10, 20, 30]},
		%% {sortname, 'id'},
		%% {viewrecords, true},
		%% {sortorder, <<"desc">>},
		{caption, <<"JSON Example">>}
	    ]
	}
    ].


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
