% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(get_jqgrid_data).

-export([init/3, content_types_provided/2, to_json/2, generate_etag/2, terminate/2]).

%% -include_lib("webmachine/include/webmachine.hrl").

%% init([]) -> {ok, undefined}.
init(_Transport, _Req, []) ->
    {upgrade, protocol, cowboy_rest}.

content_types_provided(ReqData, Context) ->
    {[{<<"application/json">>, to_json}], ReqData, Context}.

to_json(ReqData, Context) ->
    Data = {struct, [{<<"total">>, 1},
		     {<<"page">>, 1},
		     {<<"records">>, 2},
		     {<<"rows">>, [{struct, [{<<"id">>, 1}, {<<"cell">>, [<<"1">>, <<"cell11">>, <<"values11">>]}]},
				   {struct, [{<<"id">>, 2}, {<<"cell">>, [<<"2">>, <<"cell15">>, <<"values22">>]}]}
				  ]}
		    ]},
    Data1 = iolist_to_binary(mochijson2:encode(Data)),
    {Data1, ReqData, Context}.

generate_etag(ReqData, Context) -> {wrq:raw_path(ReqData), ReqData, Context}.

terminate(_Req, _State) ->
    ok.
