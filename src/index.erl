-module(index).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() ->
    #template { file=filename:join([web_common:templates(), "onecolumn.html"])
}.

title() -> "Tabs Pane Example".
headline() -> "Tabs Pane Example".

body() -> [

  %% wf:wire(tabs, #tab_select{tab = 1}),

 #tabs{
	id = tabs,
	options=[
	    {selected, 0},
	    {event, mouseover}
	],
	tabs=[
	    #tab{tag=tabTag1, title="Tab 1", body=["Tab one body..."]},
	    #tab{title="Tab 2", body=["Tab two body..."]}
	]
    }

].

tabs_event(_Evt, _TabsTag, _TabTag, _Index) ->
    ?PRINT({web_samples_tabs, event}).
