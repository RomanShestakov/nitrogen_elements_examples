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
		#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?BEFOREREQUEST, postback = before_rqt},
		#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?BEFORESELECTROW, postback = before_slc_row},
		#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?ONSELECTROW, postback = select_row},
		#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?ONCELLSELECT, postback = select_cell},
		#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?AFTERINSERTROW, postback = after_insert_row},
		#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?ONDBLCLICKROW, postback = on_dblclick},
		#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?ONRIGHTCLICKROW, postback = on_right_click},
		#jqgrid_event{trigger = jqgrid, target = jqgrid, type = ?ONHEADERCLICK, postback = on_header_click}
	    ]
	}
    ].

event(Event) ->
    ?PRINT({jqgrid_event, Event}).
