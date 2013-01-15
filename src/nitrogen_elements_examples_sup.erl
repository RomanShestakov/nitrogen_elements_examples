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

-include_lib("webmachine/include/webmachine.hrl").
-include_lib ("nitrogen_core/include/wf.hrl").

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
    DocRootBin = wf:to_binary(DocRoot),

    io:format("Starting Cowboy Server (~s) on ~s:~p, root: '~s'~n", [ServerName, BindAddress, Port, DocRoot]),

    {ok, _} = cowboy:start_http(http, 100, [{port, Port}], [{env, [{dispatch, dispatch_rules()}]}]),
    {ok, {{one_for_one, 5, 10}, []}}.

dispatch_rules() ->
    %% {Host, list({Path, Handler, Opts})}
    [{'_', [
	    {[<<"css">>, '...'], cowboy_static, [{directory, {priv_dir, nitrogen_elements_examples, [<<"static/css">>]}}]},
	    {[<<"images">>, '...'], cowboy_static, [{directory, {priv_dir, nitrogen_elements_examples, [<<"static/images">>]}}]},
	    {[<<"nitrogen">>, '...'], cowboy_static, [{directory, {priv_dir, nitrogen_elements_examples, [<<"static/nitrogen">>]}}]},
	    {[<<"jqgrid">>, '...'], cowboy_static, [{directory, {priv_dir, nitrogen_elements_examples, [<<"static/jqgrid">>]}}]},
	    {[<<"content">>, '...'], cowboy_static, [{directory, {priv_dir, nitrogen_elements_examples, [<<"content">>]}}]},
	    {[<<"history">>, '...'], cowboy_static, [{directory, {priv_dir, nitrogen_elements_examples, [<<"static/history">>]}}]},
	    {'_', nitrogen_cowboy, []}
	   ]
     }].
