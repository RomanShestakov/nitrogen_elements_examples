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
    {ok, BindAddress} = application:get_env(bind_address),
    {ok, Port} = application:get_env(port),
    {ok, ServerName} = application:get_env(server_name),
    {ok, DocRoot} = application:get_env(document_root),

    io:format("Starting Cowboy Server (~s) on ~s:~p, ~n", [ServerName, BindAddress, Port]),
    HttpOpts = [{max_keepalive, 50}, {dispatch, dispatch_rules()}],
    cowboy:start_listener(http, 100,
                          cowboy_tcp_transport, [{port, Port}],
                          cowboy_http_protocol, HttpOpts),
    {ok, {{one_for_one, 5, 10}, []}}.

dispatch_rules() ->
    %% {Host, list({Path, Handler, Opts})}
    [{'_', [
	{[<<"content">>, '...'], cowboy_http_static, [{directory, {priv_dir, ?APP, [<<"content">>]}},
	    {mimetypes, [{<<".css">>, [<<"text/css">>]}, {mimetypes, {fun mimetypes:path_to_mimes/2, default}}]}]},
	{[<<"static">>, '...'], cowboy_http_static, [{directory, {priv_dir, ?APP, [<<"static">>]}},
	    {mimetypes, [{<<".css">>, [<<"text/css">>]}, {mimetypes, {fun mimetypes:path_to_mimes/2, default}}]}]},
	{[<<"plugins">>, '...'], cowboy_http_static, [{directory, {priv_dir, ?APP, [<<"plugins">>]}},
	    {mimetypes, [{<<".css">>, [<<"text/css">>]}, {mimetypes, {fun mimetypes:path_to_mimes/2, default}}]}]},
	{[<<"doc">>, '...'], cowboy_http_static, [{directory, {priv_dir, ?APP, [<<"doc">>]}},
	    {mimetypes, [{<<".css">>, [<<"text/css">>]}, {mimetypes, {fun mimetypes:path_to_mimes/2, default}}]}]},
	{[<<"get_jqgrid_data">>, '...'], get_jqgrid_data, []},
	{'_', nitrogen_cowboy, []}
    ]
    }].
