% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(grid).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

body() ->

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
	    ],
	    actions = [
		#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?ONSELECTROW},
		#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?ONCELLSELECT}
	    ]
	}
    ].

%% event(?ONCELLSELECT, RowId, ICol, Cellcontent) ->
%%     ?PRINT({jqgrid_event, ?ONCELLSELECT, RowId, ICol, Cellcontent}).
%% event(?ONSELECTROW, RowId, Status) ->
%%     ?PRINT({jqgrid_event, ?ONSELECTROW, RowId, Status}).

event(Event) ->
    ?PRINT({jqgrid_event, Event}).
