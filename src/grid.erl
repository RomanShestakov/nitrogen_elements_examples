% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(grid).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

%% http://stackoverflow.com/questions/2919723/make-jqgrid-fill-its-container/6045451#6045451

body(_Tag) ->
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
		{caption, <<"JSON Example">>},
		{groupColumnShow, false},
		{loadonce, false},
		{scrollOffset, 0}, %% switch off scrollbar
		{autowidth, true} %% fill parent container on load
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

control_panel(Tag) ->
    #panel{id = control_panel, body = [
	#textbox{id = server_txt, style = "width: 100%", text = "ws://localhost:8000/jqdata"},
	#p{},
	%% postback is to the index page, event from index.erl will call event(connect)
	#button{id = conn, text = "Connect", actions = [#event{type = click, postback = {Tag, connect}}]}
    ]}.

event({Tag, connect}) ->
    Server = wf:q(server_txt),
    %?PRINT({gqgrid_server, Server}),
    wf:wire(#ws_open{server = Server, func = "function(event){console.log('open')};"}),
    wf:wire(#ws_message{func = wf:f("function(event){$(obj('~s')).jqGrid('setGridParam',
	                 {datatype:\"jsonstring\", datastr:event.data}).trigger(\"reloadGrid\")};", [jqgrid])}),
    wf:wire(#ws_error{func = "function(event){console.log('error')};"}),
    wf:replace(conn, #button{id = conn, text = "Disconnect", actions = [#event{type = click, postback = {Tag, disconnect}}]});
event({Tag, disconnect}) ->
    wf:wire(#ws_close{}),
    wf:replace(conn, #button{id = conn, text = "Connect", actions = [#event{type = click, postback = {Tag, connect}}]});

event(Event) ->
    ?PRINT({jqgrid_event, Event}).
