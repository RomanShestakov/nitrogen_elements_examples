all: get-deps compile

get-deps:
	rebar get-deps

compile:
	rebar compile
	(rm -rf priv/static/nitrogen; mkdir -p priv/static/nitrogen; \
	cp -r deps/nitrogen_core/www/* priv/static/nitrogen/;)

clean:
	rebar clean
