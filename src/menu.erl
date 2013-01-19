% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(menu).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

title() -> "Menu Example".
headline() -> "Menu Example".

body() ->
    [
	#menu{
	    id = menu,
	    options = [],
	    style = "width:150px;",
	    items = [
		#item{title = "USA", items = [#item{title = "New York City"}, #item{title = "Boston"}]},
		#item{title = "UK"},
		#item{title = "Russia"}
	    ]
	}
].
