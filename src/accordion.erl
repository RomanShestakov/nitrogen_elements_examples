% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(accordion).
-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

body(Tag) ->

    %% output html markup
    [
	#accordion{
	    id = accordion,
	    options = [
		{event, mouseover},
		{active, 2}
	    ],
	    body = [
		#panel{text = "Section 1", body = [#p{ text =
		    "Mauris mauris ante, blandit et, ultrices a, suscipit eget.
		    Integer ut neque. Vivamus nisi metus, molestie vel, gravida in,
		    condimentum sit amet, nunc. Nam a nibh. Donec suscipit eros.
		    Nam mi. Proin viverra leo ut odio."}]},
		#panel{text = "Section 2", body = [#p{ text =
		    "Mauris mauris ante, blandit et, ultrices a, suscipit eget.
		    Integer ut neque. Vivamus nisi metus, molestie vel, gravida in,
		    condimentum sit amet, nunc. Nam a nibh. Donec suscipit eros.
		    Nam mi. Proin viverra leo ut odio."}]},
		#panel{text = "Section 3", body = [#p{ text =
		    "Mauris mauris ante, blandit et, ultrices a, suscipit eget.
		    Integer ut neque. Vivamus nisi metus, molestie vel, gravida in,
		    condimentum sit amet, nunc. Nam a nibh. Donec suscipit eros.
		    Nam mi. Proin viverra leo ut odio."}]},
		#panel{text = "Section 4", body = [
		    #list { body=[
			#listitem { text="List Item 1" },
			#listitem { text="List Item 2" },
			#listitem { body=#checkbox { text="List Item 3" }}
		    ]}
		]}
	    ],
	    actions = [
		#accordion_event_on{trigger = accordion, type = ?EVENT_ACCORDION_ACTIVATE,
		    postback = {Tag, {accordion, ?EVENT_ACCORDION_ACTIVATE}}},
		#accordion_event_on{trigger = accordion, type = ?EVENT_ACCORDION_BEFORE_ACTIVATE,
		    postback = {Tag, {accordion, ?EVENT_ACCORDION_BEFORE_ACTIVATE}}},
		#accordion_event_on{trigger = accordion, type = ?EVENT_ACCORDION_CREATE,
		    postback = {Tag, {accordion, ?EVENT_ACCORDION_CREATE}}}
	    ]
	}
    ].

event(Event) ->
    ?PRINT({accordion_event, Event}).
