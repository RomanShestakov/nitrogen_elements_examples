% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(nitrogen_elements_examples_sup).
-behaviour(supervisor).
-export([
	 start_link/0,
	 init/1
	]).

-compile(export_all).
-include_lib ("nitrogen_core/include/wf.hrl").
-define(APP, nitrogen_elements_examples).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, Port} = application:get_env(port),
    io:format("Starting Cowboy Server ~p ~n", [Port]),
    {ok, _} = cowboy:start_http(http, 100,
				[{port, Port}],
				[{env, [{dispatch, dispatch_rules()}]}]),
    {ok, {{one_for_one, 5, 10}, []}}.

dispatch_rules() ->
    cowboy_router:compile(
	%% {Host, list({Path, Handler, Opts})}
	[{'_', [
	    {["/content/[...]"], cowboy_static, [{directory, {priv_dir, ?APP, [<<"content">>]}},
		{mimetypes, {fun mimetypes:path_to_mimes/2, default}}]},
	    {["/static/[...]"], cowboy_static, [{directory, {priv_dir, ?APP, [<<"static">>]}},
		{mimetypes, {fun mimetypes:path_to_mimes/2, default}}]},
	    {["/plugins/[...]"], cowboy_static, [{directory, {priv_dir, ?APP, [<<"plugins">>]}},
		{mimetypes, {fun mimetypes:path_to_mimes/2, default}}]},
	    {["/doc/[...]"], cowboy_static, [{directory, {priv_dir, ?APP, [<<"doc">>]}},
		{mimetypes, {fun mimetypes:path_to_mimes/2, default}}]},
	    {["/get_jqgrid_data/[...]"], get_jqgrid_data, []},
	    {["/websocket"], websocket_handler, []},
	    {'_', nitrogen_cowboy, []}
    ]}]).
