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

control_panel(Tag) ->
    #panel{id=control_panel, body = [
	#button{id=btn_update_graph, text="Update Graph", actions=[#event{type=click, postback={Tag, update_graph}}]}
    ]}.

event(update_graph) ->
    ?PRINT({viz_event, update_graph}),
    wf:replace(viz, #viz{id = viz, data = ?DATA1});
event(Event) ->
    ?PRINT({viz_event, Event}).


