-module(ws_handler).
-behaviour(cowboy_websocket_handler).

-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).

-define(DATA, <<"digraph G {subgraph cluster_0 {style=filled;color=lightgrey; node [style=filled,color=white]; a0 -> a1 -> a2 -> a3;label = \"process #1\";} subgraph cluster_1 {node [style=filled]; b0 -> b1 -> b2 -> b3; label = \"process #2\";color=blue} start -> a0; start -> b0; a1 -> b3; b2 -> a3; a3 -> a0; a3 -> end; b3 -> end; start [shape=Mdiamond]; end [shape=Msquare];}">>).

-define(DATA1, <<"digraph G {subgraph cluster_0 {style=filled;color=lightgrey; node [style=filled,color=white]; a0 -> a1 -> a2 -> a3 -> a4;label = \"process #1\";} subgraph cluster_1 {node [style=filled]; b0 -> b1 -> b2 -> b3 -> b4; label = \"process #2\";color=blue} start -> a0; start -> b0; a1 -> b3; b2 -> a3; a3 -> a0; a3 -> a4; a4 -> end; b3 -> end; start [shape=Mdiamond]; end [shape=Msquare];}">>).

init({tcp, http}, _Req, _Opts) ->
    %% io:format("init ~n"),
    {upgrade, protocol, cowboy_websocket}.

websocket_init(_TransportName, Req, _Opts) ->
    %% io:format("connecting ~n"),
    erlang:start_timer(1000, self(), ?DATA),
    {ok, Req, undefined_state}.

websocket_handle({text, Msg}, Req, State) ->
    %% io:format("handle ~n"),
    {reply, {text, << "That's what she said! ", Msg/binary >>}, Req, State};
websocket_handle(_Data, Req, State) ->
    %% io:format("handle1 ~n"),
    {ok, Req, State}.

websocket_info({timeout, _Ref, Msg}, Req, State) ->
    %% io:format("info ~n"),
    erlang:start_timer(1000, self(), ?DATA1),
    {reply, {text, Msg}, Req, State};
websocket_info(_Info, Req, State) ->
    {ok, Req, State}.

websocket_terminate(_Reason, _Req, _State) ->
    ok.
