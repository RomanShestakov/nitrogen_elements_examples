-module(index).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() ->
    #template { file=filename:join([web_common:templates(), "onecolumn.html"])
}.

title() -> "Nitrogen Elements Examples".
headline() -> "Nitrogen Elements Examples".

body() -> [
    #panel{
	body = [
	    #list{
		body = [
			#listitem{body = #link{url = "action_dialog_example", body = "Action Dialog"}},
			#listitem{body = #link{url = "tabs", body = "Tabs"}}
		       ]
		%% #listitem{body = #link{url = "#")}
	    }
	]
    }
].
