-module(tabs).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

title() -> "Tabs Pane Example".
headline() -> "Tabs Pane Example".

body() ->
    wf:wire(#api { name=history_back, tag=f1 }),
    %% wf:wire(tabs, #tab_select{tab = 1}),
    [
	#tabs{
	    id = tabs,
	    tag = tabs1,
	    options=[
		{selected, 0}
		%% {event, mouseover},
		%% {cache, true}
	    ],
	    tabs=[
		#tab{title="Tab 1", url = "/content/tabs2.htm"},
		#tab{title="Tab 2", body=["Tab two body..."]},
		#tab{title="Tab 3", body=["Tab three body..."]}
	    ]
	}
].

tabs_event('tabsselect', TabsTag, TabAnchor, TabPanel, TabIndex) ->
    ?PRINT({tabs_event, 'tabsselect', TabsTag, TabAnchor, TabPanel, TabIndex}),
    pushState(TabIndex);
tabs_event(_EventType, _TabsTag, _TabAnchor, _TabPanel, _TabIndex) ->
    %% ?PRINT({tabs_event, EventType, TabsTag, TabAnchor, TabPanel, TabIndex}).
    void.

pushState(TabIndex) ->
    wf:wire(wf:f("pushState(\"State ~s\", \"?state=~s\", {state:~s});", [TabIndex, TabIndex, TabIndex])).
    %%ok.

api_event(A, B, C) ->
    ?PRINT(A), ?PRINT(B), ?PRINT(C).

