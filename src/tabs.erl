% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(tabs).
-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

body(Tag) ->

    %% wire #api event to generate page.history_back js function
    wf:wire(#api{anchor=page, name = history_back, tag = Tag}),

    %% output html markup
    [
	#tabs{
	    id = tabs,
	    options = [{selected, 0}, {closable, true}],
	    tabs = [
		#tab{title = "Tab 1", url = "/content/tabs2.htm"},
		#tab{title = "Tab 2", body = ["Tab two body... Proin elit arcu, rutrum commodo, vehicula tempus, commodo a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa et lorem. Mauris dapibus lacus auctor risus. Aenean tempor ullamcorper leo. Vivamus sed magna quis ligula eleifend adipiscing. Duis orci. Aliquam sodales tortor vitae ipsum. Aliquam nulla. Duis aliquam molestie erat. Ut et mauris vel pede varius sollicitudin. Sed ut dolor nec orci tincidunt interdum. Phasellus ipsum. Nunc tristique tempus lectus."]},
		#tab{title = "Tab 3", body = ["Tab three body... Proin elit arcu, rutrum commodo, vehicula tempus, commodo a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa et lorem. Mauris dapibus lacus auctor risus. Aenean tempor ullamcorper leo. Vivamus sed magna quis ligula eleifend adipiscing. Duis orci. Aliquam sodales tortor vitae ipsum. Aliquam nulla. Duis aliquam molestie erat. Ut et mauris vel pede varius sollicitudin. Sed ut dolor nec orci tincidunt interdum."]}
	    ],
	    actions =
	    [
		#tab_event_on{trigger = tabs, type = ?EVENT_TABS_ACTIVATE, postback = {Tag, {tabs, ?EVENT_TABS_ACTIVATE}}},
		#tab_event_on{trigger = tabs, type = ?EVENT_TABS_BEFORE_ACTIVATE, postback = {Tag, {tabs, ?EVENT_TABS_BEFORE_ACTIVATE}}},
		#tab_event_on{trigger = tabs, type = ?EVENT_TABS_BEFORE_LOAD, postback = {Tag, {tabs, ?EVENT_TABS_BEFORE_LOAD}}},
		#tab_event_on{trigger = tabs, type = ?EVENT_TABS_CREATE, postback = {Tag, {tabs, ?EVENT_TABS_CREATE}}},
		#tab_event_on{trigger = tabs, type = ?EVENT_TABS_LOAD, postback = {Tag, {tabs, ?EVENT_TABS_LOAD}}}
	    ]
	}
    ].

control_panel(Tag) ->
    #panel{id=control_panel, body = [
	%% add button to disable tabs
	#button{id=btn_disable, text="Disable All tabs", actions=[#event{type=click, postback={Tag, disable_tabs}}]},
	#p{},
	#button{id=btn_disable1, text="Disable Some tabs", actions=[#event{type=click, postback={Tag, disable_some_tabs}}]},
	#p{},
	#button{id=btn_select, text="Select tab", actions=[#event{type=click, postback={Tag, select_tab}}]},
	#textbox{id=tbx_tab_index, text="0"},
	#p{},
	#button{id=btn_remove, text="Remove tab", actions=[#event{type=click, postback={Tag, remove_tab}}]},
	#textbox{id=tbx_tab_remove_index, text="0"},
	#p{},
	#button{id=btn_add, text="Add tab", actions=[#event{type=click, postback={Tag, add_tab}}]},
	#textbox{id=tbx_add_tab, text="NewTab"},
	#p{},
	#label{text="Options: "},
	#dropdown{id=dropdown,
	    options=[
		#option { text=active },
		#option { text=collapsible },
		#option { text=disabled },
		#option { text=event },
		#option { text=heightStyle },
		#option { text=hide },
		#option { text=show }
	]},
	#button{text="Get option", actions=[#event{type=click, postback={Tag, select_option}}]},
	#button{text="Get options", actions=[#event{type=click, postback={Tag, select_options}}]},
	#flash {}
    ]}.

event({ID, ?EVENT_TABS_ACTIVATE}) ->
    ?PRINT({tabs_event, ?EVENT_TABS_ACTIVATE}),
    wf:wire(wf:f("(function(){var index = jQuery(obj('~s')).tabs(\"option\", \"active\");
	pushState(\"State\"+index, \"?state=\"+index, {tabindex:index});})();", [ID]));
event({_ID, ?EVENT_TABS_BEFORE_ACTIVATE}) ->
    ?PRINT({tabs_event, ?EVENT_TABS_BEFORE_ACTIVATE});
event({_ID, ?EVENT_TABS_BEFORE_LOAD}) ->
    ?PRINT({tabs_event, ?EVENT_TABS_BEFORE_LOAD});
event({_ID, ?EVENT_TABS_CREATE}) ->
    ?PRINT({tabs_event, ?EVENT_TABS_CREATE});
event({_ID, ?EVENT_TABS_LOAD}) ->
    ?PRINT({tabs_event, ?EVENT_TABS_LOAD});
event(disable_tabs) ->
    wf:wire(#tab_disable{target=tabs}),
    wf:replace(btn_disable, #button{id=btn_enable, text="Enable All tabs",
	actions=[#event{type=click, postback={tabs_example_tag, enable_tabs}}]});
event(enable_tabs) ->
    wf:wire(#tab_enable{target=tabs}),
    wf:replace(btn_enable, #button{id=btn_disable, text="Disable All tabs",
	actions=[#event{type=click, postback={tabs_example_tag, disable_tabs}}]});
event(disable_some_tabs) ->
    wf:wire(#tab_disable{target=tabs, tab = [1, 2]}),
    wf:replace(btn_disable1, #button{id=btn_enable1, text="Enable All tabs",
	actions=[#event{type=click, postback={tabs_example_tag, enable_some_tabs}}]});
event(enable_some_tabs) ->
    wf:wire(#tab_enable{target=tabs, tab = [1, 2]}),
    wf:replace(btn_enable1, #button{id=btn_disable1, text="Disable Some tabs",
	actions=[#event{type=click, postback={tabs_example_tag, disable_some_tabs}}]});
event(select_tab) ->
    Index = wf:q(tbx_tab_index),
    wf:wire(#tab_select{target=tabs, tab = wf:to_integer(Index)});
event(remove_tab) ->
    Index = wf:q(tbx_tab_remove_index),
    wf:wire(#tab_remove{target = tabs, tab = wf:to_integer(Index)});
event(add_tab) ->
    Title = wf:q(tbx_add_tab),
    wf:wire(#tab_add{target = tabs, title = Title, url = "/content/tabs2.htm"});
event(select_option) ->
    Key = wf:q(dropdown),
    wf:wire(#tab_option{target=tabs, key=list_to_atom(Key), postback={tabs_example_tag, {option, Key}}});
event(select_options) ->
    wf:wire(#tab_option{target=tabs, postback={tabs_example_tag, options}});
event({option, Key}) ->
    Option = wf:q(Key),
    wf:flash(wf:f("~s: ~s", [Key, Option]));
event(options) ->
    Active=wf:q(active),
    Collapsible=wf:q(collapsible),
    Disabled=wf:q(disabled),
    Event=wf:q(event),
    HeightStyle=wf:q(heightStyle),
    Hide=wf:q(hide),
    Show=wf:q(show),
    wf:flash(wf:f("Active:~s, Collapsible:~s, Disabled:~s, Event:~s, HeightStyle:~s, Hide:~s, Show:~s",
	[Active, Collapsible, Disabled, Event, HeightStyle, Hide, Show])).

api_event(history_back, _B, [[_,{data, Data}]]) ->
    ?PRINT({history_back_event, _B, Data}),
    TabIndex = proplists:get_value(tabindex, Data),
    wf:wire(tabs, #tab_event_off{type = ?EVENT_TABS_ACTIVATE}),
    wf:wire(tabs, #tab_select{tab = TabIndex}),
    wf:wire(tabs, #tab_event_on{type = ?EVENT_TABS_ACTIVATE});
api_event(A, B, C) ->
    ?PRINT(A), ?PRINT(B), ?PRINT(C).
