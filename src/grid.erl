-module(grid).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).
%% -define(EVENT_TABSSHOW, 'tabsshow').

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

title() -> "Grid Example".
headline() -> "Grid Example".

body() ->

    wf:wire(wf:f("var populateGrid = function(postdata){alert(\"postdata\")};", [])),
    [
	#datagrid{
	    id = jqgrid,
	    options=[
		%% grid config
		{datatype, <<"clientSide">>},
		{width, 800},
		{height, 350},
		{blockui, true},
		{altRows, true},
		{deepempty, true},
		{sortname, 'ID'},
		{sortorder, 'desc'},
		%%remote data options
		{prmNames, [{page,<<"pageIndex">>},{sort,<<"sortCol">>},{order,<<"sortDir">>},{rows,<<"pageSize">>}]},
		{postData, [{method, <<"getEntries">>}, {returnFormat, <<"JSON">>}]},
		{datatype, populateGrid},
		{jsonreader, [{id, <<"ID">>},
		    {root, <<"function(obj){return obj.data.DATA;}">>},
		    {page, <<"pageIndex">>},
		    {total, <<"function(obj){return, parseInt(obj.recordCount);}">>},
		    {cell, <<"">>}
		]},
		%% pager config
		{toppager, true},
		{pagerpos, left},
		{rowNum, 50},
		{rowList, [10, 20, 30, 40, 50]},
		{viewrecords, true},
		%% DataModel
		{colModel, [{name, 'summary'}, {name,'date'}]},
		{data, [[{'summary','2'},{'date','10-jul'}], [{'summary','1'},{'date','12-jul'}]]}
		%% {colModel, [{name, 'TITLE'}, {name,'POSTED'}, {name,'VIEWS'}]}
		%% {data, [[{'','2'},{'date','10-jul'}],
		%% 	[{'summary','1'},{'date','12-jul'}]]}
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
