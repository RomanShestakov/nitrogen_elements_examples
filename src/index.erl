% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(index).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() ->
    #template { file=filename:join([web_common:templates(), "onecolumn.html"])
}.

title() -> "Nitrogen Elements Examples".
headline() -> "Nitrogen Elements Examples".

body() -> [

    % Main layout...
    #layout {
	%% class="ui-layout-container",

	north=#panel{text = "North"},
	north_options = [{size, 60}, {spacing_open, 0}, {spacing_closed, 0}],

	west=#panel{text = "West"},
	west_options=[{size, 140}, {spacing_open, 0}, {spacing_closed, 0}],

	center=#panel{text = "Center"},

	east=#panel{text = "East"},
	east_options=[{size, 200}, {spacing_open, 0}, {spacing_closed, 0}],

	south=#panel{text = "South"},
	south_options=[{size, 200}, {spacing_open, 0}, {spacing_closed, 0}]
    }

    %%,
    %% #panel{
    %% 	body = [
    %% 	    #menu{
    %% 		id = elements_menu,
    %% 		body = [
    %% 		    #item{url = "action_dialog_example", title = "Action Dialog"},
    %% 		    #item{url = "tabs", title = "Tabs"},
    %% 		    #item{url = "menu", title = "Menu"},
    %% 		    #item{url = "grid", title = "Grid"},
    %% 		    #item{url = "progressbar", title = "Progressbar"}
    %% 		]
    %% 	    }
    %% 	]
    %% }
].
