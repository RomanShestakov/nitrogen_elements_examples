% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(menu).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

body(Tag) ->

    %% output html markup
    [
	#menu{
	    id = menu,
	    options = [ %%{disabled, true},
		{icons, {{submenu, <<"ui-icon-circle-triangle-e">>}}},
		{position, {{my, <<"left top">>}, {at, <<"right top">>}}}
	    ],
	    style = "width:150px;",
	    body = [
		#item{title = "USA", body = [#item{title = "New York City"}, #item{title = "Boston"}]},
		#item{title = "UK"},
		#item{title = "Russia"}
	    ],
	    %% add actions which bind native menu events
	    actions = [
		#menu_event_on{trigger = menu, type = ?EVENT_MENU_BLUR, postback = {Tag, {menu, ?EVENT_MENU_BLUR}}},
		#menu_event_on{trigger = menu, type = ?EVENT_MENU_CREATE, postback = {Tag, {menu, ?EVENT_MENU_CREATE}}},
		#menu_event_on{trigger = menu, type = ?EVENT_MENU_FOCUS, postback = {Tag, {menu, ?EVENT_MENU_FOCUS}}},
		#menu_event_on{trigger = menu, type = ?EVENT_MENU_FOCUS, postback = {Tag, {menu, ?EVENT_MENU_SELECT}}}
	    ]
	},

	#p{},
	%% add button to disable tabs
	#button{id=btn_blur, text="Blur", actions=[#event{type=click, postback={Tag, blur}}]},
	#p{},
	#label{text="Options: "},
	#dropdown{id=dropdown,
	    options=[
		#option { text=disabled },
		#option { text=icons },
		#option { text=menus },
		#option { text=position },
		#option { text=role }
	]},
	#p{},
	#button{text="Get option", actions=[#event{type=click, postback={Tag, select_option}}]},
	#button{text="Get options", actions=[#event{type=click, postback={Tag, select_options}}]},
	#flash {}
    ].

event({_ID, ?EVENT_MENU_BLUR}) ->
    ?PRINT({menu_event, ?EVENT_MENU_BLUR});
event({_ID, ?EVENT_MENU_CREATE}) ->
    ?PRINT({menu_event, ?EVENT_MENU_CREATE});
event({_ID, ?EVENT_MENU_FOCUS}) ->
    ?PRINT({menu_event, ?EVENT_MENU_FOCUS});
event({_ID, ?EVENT_MENU_SELECT}) ->
    ?PRINT({menu_event, ?EVENT_MENU_SELECT});
%% event(Event) ->
%%     ?PRINT({menu_event, Event});
event(blur) ->
    wf:wire(#menu_blur{target=menu});
event(select_option) ->
    Key = wf:q(dropdown),
    wf:wire(#menu_option{target=menu, key=list_to_atom(Key), postback={menu_example_tag, {option, Key}}});
event(select_options) ->
    wf:wire(#menu_option{target=menu, postback={menu_example_tag, options}});
event({option, Key}) ->
    Option = wf:q(Key),
    wf:flash(wf:f("~s: ~s", [Key, Option]));
event(options) ->
    Disabled=wf:q(disabled),
    Icons=wf:q(icons),
    Menus=wf:q(menus),
    Position=wf:q(position),
    Role=wf:q(role),
    wf:flash(wf:f(" Disabled:~s, Icons:~s, Menus:~s, Position:~s, Role:~s",
	[Disabled, Icons, Menus, Position, Role])).
