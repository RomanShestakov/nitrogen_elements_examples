-module(nitrogen_elements_test_app).
-behaviour(application).
-export([
	 start/0,
	 start/2,
	 stop/1
	]).

-define(APPS, [nprocreg, sync, nitrogen_elements_test]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

%% to start manually from console with start.sh
start() ->
    [begin application:start(A), io:format("~p~n", [A]) end || A <- ?APPS].

start(_StartType, _StartArgs) ->
    %% io:format("Starting webmachine 0 ~n", []),
    nitrogen_elements_test_sup:start_link().

stop(_State) ->
    ok.
