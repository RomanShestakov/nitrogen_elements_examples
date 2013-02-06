all: get-deps compile

get-deps:
	rebar get-deps

compile:
	rebar compile
	cp -R deps/nitrogen_elements/doc priv/static

clean:
	rebar clean

test: all
	rebar skip_deps=true eunit
