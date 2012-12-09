-module(tabs).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

title() -> "Tabs Pane Example".
headline() -> "Tabs Pane Example".

body() ->
    tabs_bind_event(tabs, tabs1, 'tabsshow'),
    wf:wire(#api { name=history_back, tag=f1 }),
    %% wf:wire(tabs, #tab_select{tab = 0}),
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

tabs_event('tabsshow', TabsTag, TabAnchor, TabPanel, TabIndex) ->
    ?PRINT({tabs_event, 'tabsshow', TabsTag, TabAnchor, TabPanel, TabIndex}),
    pushState(TabIndex);
tabs_event(EventType, _TabsTag, _TabAnchor, _TabPanel, TabIndex) ->
    ?PRINT({tabs_event, EventType, TabIndex}).

pushState(TabIndex) ->
    wf:wire(wf:f("pushState(\"State ~s\", \"?state=~s\", {tabindex:~s});", [TabIndex, TabIndex, TabIndex])).

api_event(history_back, B, [[_,{data, Data}]]) ->
    ?PRINT({history_back_event, B, Data}),
    TabIndex = proplists:get_value(tabindex, Data),
    tabs_unbind_event(tabs, 'tabsshow'),
    wf:wire(tabs, #tab_select{tab = TabIndex}),
    tabs_bind_event(tabs, tabs1, 'tabsshow');
api_event(A, B, C) ->
    ?PRINT(A), ?PRINT(B), ?PRINT(C).

tabs_bind_event(TabsID, TabsTag, Event) ->
    PickledPostbackInfo = wf_event:serialize_event_context(tabsevent, TabsID, TabsID, 'element_tabs'),
    wf:wire(TabsID, wf:f("jQuery(obj('~s')).bind('~s', function(e, ui) {
                       Nitrogen.$queue_event('~s','~s',\"event=\" + e.type + \"&tabs_tag=\" + '~s' + \"&tab=\" + ui.tab + \
                        \"&panel=\" + ui.panel + \"&index=\" + ui.index)})",
			 [TabsID, Event, TabsID, PickledPostbackInfo, TabsTag])).

tabs_unbind_event(TabsID, Event) ->
    wf:wire(TabsID, wf:f("jQuery(obj('~s')).unbind('~s');", [TabsID, Event])).
