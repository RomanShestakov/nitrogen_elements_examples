% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(viz).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

-define(DATA, <<"digraph G {subgraph cluster_0 {style=filled;color=lightgrey; node [style=filled,color=white]; a0 -> a1 -> a2 -> a3;label = \"process #1\";} subgraph cluster_1 {node [style=filled]; b0 -> b1 -> b2 -> b3; label = \"process #2\";color=blue} start -> a0; start -> b0; a1 -> b3; b2 -> a3; a3 -> a0; a3 -> end; b3 -> end; start [shape=Mdiamond]; end [shape=Msquare];}">>).

-define(DATA1, <<"digraph G {subgraph cluster_0 {style=filled;color=lightgrey; node [style=filled,color=white]; a0 -> a1 -> a2 -> a3 -> a4;label = \"process #1\";} subgraph cluster_1 {node [style=filled]; b0 -> b1 -> b2 -> b3 -> b4; label = \"process #2\";color=blue} start -> a0; start -> b0; a1 -> b3; b2 -> a3; a3 -> a0; a3 -> a4; a4 -> end; b3 -> end; start [shape=Mdiamond]; end [shape=Msquare];}">>).


body(_Tag) ->
    %% output html markup
    [
	#viz{id = viz, data = ?DATA}
    ].

    %% wf:wire(ID, wf:f("$(function(){jQuery(obj('~s')).html(Viz('~s', \"svg\"));})", [ID, Data])),


control_panel(Tag) ->
    #panel{id = control_panel, body = [
	#textbox{id = server_txt, style = "width: 100%", text = "ws://localhost:8000/websocket"},
	#p{},
	%% postback is to the index page, event from index.erl will call event(connect)
	#button{id = btn_tiggle_connect, text = "Connect", actions = [#event{type = click, postback = {Tag,connect}}]}
    ]}.

event({Tag, connect}) ->
    %% ?PRINT({viz_event, connect}),
    Server = wf:q(server_txt),
    ?PRINT({viz_server, Server}),
    wf:wire(#ws_open{server = Server, on_open = "function(event){console.log('open')};",
	on_message = wf:f("function(event){jQuery(obj('~s')).html(Viz(event.data, \"svg\"));};", [viz])}),
    wf:replace(btn_tiggle_connect,
	#button{id = btn_tiggle_connect, text = "Disconnect", actions = [#event{type = click, postback = {Tag, disconnect}}]}),
    wf:replace(viz, #viz{id = viz, data = ?DATA1});
event({Tag, disconnect}) ->
    wf:replace(btn_tiggle_connect,
	#button{id = btn_tiggle_connect, text = "Connect", actions = [#event{type = click, postback = {Tag, connect}}]}),
    wf:wire(#ws_close{on_close = "function(event){console.log('close')};"});
event(Event) ->
    ?PRINT({viz_event, Event}).


