%% -*- mode: nitrogen -*-
-module(nitrogen_elements_test_sup).
-behaviour(supervisor).
-export([
	 start_link/0,
	 init/1
	]).

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

    Options = [
        {ip, BindAddress},
        {port, Port},
        {dispatch, dispatch()}
    ],
    webmachine_mochiweb:start(Options),
    {ok, { {one_for_one, 5, 10}, []} }.

dispatch() ->
    [
     %% Static content handlers...
     {["css", '*'], static_resource, [{root, "./priv/static/css"}]},
     {["images", '*'], static_resource, [{root, "./priv/static/images"}]},
     {["nitrogen", '*'], static_resource, [{root, "./priv/static/nitrogen"}]},
     {["jqgrid", '*'], static_resource, [{root, "./priv/static/jqgrid"}]},
     {["content", '*'], static_resource, [{root, "./priv/content"}]},
     {["history", '*'], static_resource, [{root, "./priv/static/history"}]},
     %% {["/", '*.html'], static_resource, [{root, "./priv"}]},
	%{["bf_api", func, '*'], bf_api_web, []}.
     {["get_jqgrid_data", '*'], get_jqgrid_data, []},
     %% Add routes to your modules here. The last entry makes the
     %% system use the dynamic_route_handler, which determines the
     %% module name based on the path. It's a good way to get
     %% started, but you'll likely want to remove it after you have
     %% added a few routes.
     %%
     %% p.s. - Remember that you will need to RESTART THE VM for
     %%        dispatch changes to take effect!!!
     %%
     %% {["path","to","module1",'*'], ?MODULE, module_name_1}
     %% {["path","to","module2",'*'], ?MODULE, module_name_2}
     %% {["path","to","module3",'*'], ?MODULE, module_name_3}
     {["/"], nitrogen_webmachine, index},
     {['*'], nitrogen_webmachine, dynamic_route_handler}
    ].
