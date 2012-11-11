-module(tabs).

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
        tag = tabs1,
 	options=[
 	    {selected, 0},
 	    {event, mouseover}
 	],
 	tabs=[
 	    #tab{title="Tab 1", body=["Tab one body..."]},
 	    #tab{title="Tab 2", body=["Tab two body..."]}
 	]
    }

  %% wf:wire(tabs, #tabs_event{type = tabselect, trigger = tabs, postback = {tabs, tabselect}})

].

tabs_event(EventType, TabsTag, TabAnchor, TabPanel, TabIndex) ->
    ?PRINT({tabs_event, EventType, TabsTag, TabAnchor, TabPanel, TabIndex}).
