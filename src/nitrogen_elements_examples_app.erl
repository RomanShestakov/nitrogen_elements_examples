-module(nitrogen_elements_examples_app).
-behaviour(application).
-export([
	 start/0,
	 start/2,
	 stop/1
	]).

-define(APPS, [nprocreg, sync, nitrogen_elements_examples]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

%% to start manually from console with start.sh
start() ->
    [begin application:start(A), io:format("~p~n", [A]) end || A <- ?APPS].

start(_StartType, _StartArgs) ->
    nitrogen_elements_examples_sup:start_link().

stop(_State) ->
    ok.
