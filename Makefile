all: get-deps compile

get-deps:
	rebar get-deps

compile:
	rebar compile

clean:
	rebar clean

test: all
	rebar skip_deps=true eunit
