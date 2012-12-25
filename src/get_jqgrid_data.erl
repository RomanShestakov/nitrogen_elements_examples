-module(get_jqgrid_data).

-export([init/1, content_types_provided/2, to_json/2, generate_etag/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

content_types_provided(ReqData, Context) ->
    {[{"application/json", to_json}], ReqData, Context}.

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
