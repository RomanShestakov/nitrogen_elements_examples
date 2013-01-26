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
    DocRootBin = wf:to_binary(DocRoot),

    io:format("Starting Cowboy Server (~s) on ~s:~p, root: '~s'~n", [ServerName, BindAddress, Port, DocRoot]),
    HttpOpts = [{max_keepalive, 50}, {dispatch, dispatch_rules(DocRootBin)}],
    cowboy:start_listener(http, 100,
                          cowboy_tcp_transport, [{port, Port}],
                          cowboy_http_protocol, HttpOpts),
    {ok, {{one_for_one, 5, 10}, []}}.

dispatch_rules(DocRootBin) ->
    %% {Host, list({Path, Handler, Opts})}
    [{'_', [
	    {[<<"css/">>, '...'], cowboy_http_static, [get_path(DocRootBin, <<"static/css">>)]},
	    {[<<"images/">>, '...'], cowboy_http_static, [get_path(DocRootBin, <<"static/images">>)]},
	    {[<<"nitrogen/">>, '...'], cowboy_http_static, [get_path(DocRootBin, <<"static/nitrogen">>)]},
	    {[<<"jqgrid/">>, '...'], cowboy_http_static, [get_path(DocRootBin, <<"static/jqgrid">>)]},
	    {[<<"menubar/">>, '...'], cowboy_http_static, [get_path(DocRootBin, <<"static/menubar">>)]},
	    {[<<"content/">>, '...'], cowboy_http_static, [get_path(DocRootBin, <<"static/content">>)]},
	    {[<<"history/">>, '...'], cowboy_http_static, [get_path(DocRootBin, <<"static/history">>)]},
	    {[<<"get_jqgrid_data">>, '...'], get_jqgrid_data, []},
	    {'_', nitrogen_cowboy, []}
	   ]
     }].

get_path(DocRootBin, Path) ->
    {directory, filename:join([DocRootBin, Path])}.
