% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(viz).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

-define(DATA, <<"digraph G {subgraph cluster_0 {style=filled;color=lightgrey; node [style=filled,color=white]; a0 -> a1 -> a2 -> a3;label = \"process #1\";} subgraph cluster_1 {node [style=filled]; b0 -> b1 -> b2 -> b3; label = \"process #2\";color=blue} start -> a0; start -> b0; a1 -> b3; b2 -> a3; a3 -> a0; a3 -> end; b3 -> end; start [shape=Mdiamond]; end [shape=Msquare];}">>).

body(_Tag) ->
    %% output html markup
    [
	#viz{id = viz, data = ?DATA}
    ].

control_panel(Tag) ->
    #panel{id = control_panel, body = [
	#textbox{id = server_txt, style = "width: 100%", text = "ws://localhost:8000/websocket"},
	#p{},
	%% postback is to the index page, event from index.erl will call event(connect)
	#button{id = conn, text = "Connect", actions = [#event{type = click, postback = {Tag, connect}}]}
    ]}.

event({Tag, connect}) ->
    Server = wf:q(server_txt),
    ?PRINT({viz_server, Server}),
    wf:wire(#ws_open{server = Server, func = "function(event){console.log('open')};"}),
    wf:wire(#ws_message{func = wf:f("function(event){var g = jQuery(obj('~s'));
                                               g.html(Viz(event.data, \"svg\"));
	                                       g.find(\"svg\").width('100%');
	                                       g.find(\"svg\").graphviz({status: true});};", [viz])}),
    wf:wire(#ws_error{func = "function(event){console.log('error')};"}),
    wf:replace(conn, #button{id = conn, text = "Disconnect", actions = [#event{type = click, postback = {Tag, disconnect}}]});
event({Tag, disconnect}) ->
    wf:wire(#ws_close{}),
    wf:replace(conn, #button{id = conn, text = "Connect", actions = [#event{type = click, postback = {Tag, connect}}]});
event(Event) ->
    ?PRINT({viz_event, Event}).
