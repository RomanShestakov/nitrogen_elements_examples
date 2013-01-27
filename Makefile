all: get-deps compile

get-deps:
	rebar get-deps

compile:
	rebar compile
	(rm -rf priv/static/nitrogen; mkdir -p priv/static/nitrogen; \
	cp -r deps/nitrogen_core/www/* priv/static/nitrogen/; \
	cp -r deps/nitrogen_elements/www/* priv/static/)

clean:
	rebar clean

test: all
	rebar skip_deps=true eunit
