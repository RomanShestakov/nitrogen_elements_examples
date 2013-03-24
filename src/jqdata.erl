-module(jqdata).
-behaviour(cowboy_websocket_handler).

-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).

init({tcp, http}, _Req, _Opts) ->
    {upgrade, protocol, cowboy_websocket}.

websocket_init(_TransportName, Req, _Opts) ->
    erlang:start_timer(1000, self(), get_data()),
    {ok, Req, undefined_state}.

websocket_handle({text, Msg}, Req, State) ->
    {reply, {text, << "", Msg/binary >>}, Req, State};
websocket_handle(_Data, Req, State) ->
    {ok, Req, State}.

websocket_info({timeout, _Ref, Msg}, Req, State) ->
    erlang:start_timer(1000, self(), get_data()),
    {reply, {text, Msg}, Req, State};
websocket_info(_Info, Req, State) ->
    {ok, Req, State}.

websocket_terminate(_Reason, _Req, _State) ->
    ok.

get_data() ->
    Data = {struct, [{<<"total">>, 1},
		     {<<"page">>, 1},
		     {<<"records">>, 4},
		     {<<"rows">>, [{struct, [{<<"id">>, 1}, {<<"cell">>, [<<"1">>, <<"cell11">>, random:uniform(100)]}]},
				   {struct, [{<<"id">>, 2}, {<<"cell">>, [<<"2">>, <<"cell15">>, random:uniform(50)]}]},
				   {struct, [{<<"id">>, 3}, {<<"cell">>, [<<"3">>, <<"cell55">>, random:uniform(20)]}]},
				   {struct, [{<<"id">>, 4}, {<<"cell">>, [<<"4">>, <<"cell66">>, random:uniform(10)]}]}
				  ]}
		    ]},
    iolist_to_binary(mochijson2:encode(Data)).
