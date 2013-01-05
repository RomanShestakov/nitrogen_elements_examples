% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(grid).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

title() -> "Grid Example".
headline() -> "Grid Example".

body() ->
    wf:wire(jqgrid, #jqgrid_event{type = ?ONSELECTROW}),
    [
	#jqgrid{
	    id = jqgrid,
	    options=[
		{url, 'get_jqgrid_data'},
		{datatype, <<"json">>},
		{colNames, ['ID', 'Name', 'Values']},
		{colModel, [
		    [{name, 'id'}, {index, 'id'}, {width, 55}],
		    [{name, 'name'}, {index, 'name1'}, {width, 80}],
		    [{name, 'values1'}, {index, 'values1'}, {width, 100}]
		]},
		{rowNum, 10},
		{rowList, [10, 20, 30]},
		{sortname, 'id'},
		{viewrecords, true},
		{sortorder, <<"desc">>},
		{caption, <<"JSON Example">>}
	    ]
	}
    ].

jqgrid_event(?ONSELECTROW, RowId, Status) ->
    %% wf:wire(wf:f("pushState(\"State ~s\", \"?state=~s\", {tabindex:~s});", [TabIndex, TabIndex, TabIndex])).
    ?PRINT({jqgrid_event, ?ONSELECTROW, RowId, Status}).

jqgrid_event(EventType, Id) ->
    %% wf:wire(wf:f("pushState(\"State ~s\", \"?state=~s\", {tabindex:~s});", [TabIndex, TabIndex, TabIndex])).
    ?PRINT({jqgrid_event, EventType, Id}).

%% api_event(history_back, _B, [[_,{data, Data}]]) ->
%%     %% ?PRINT({history_back_event, B, Data}),
%%     TabIndex = proplists:get_value(tabindex, Data),
%%     wf:wire(tabs, #tab_event_off{event = ?EVENT_TABSSHOW}),
%%     wf:wire(tabs, #tab_select{tab = TabIndex}),
%%     wf:wire(tabs, #tab_event_on{event = ?EVENT_TABSSHOW});
%% api_event(A, B, C) ->
%%     ?PRINT(A), ?PRINT(B), ?PRINT(C).
