% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

%% Nitrogen implementation for the jQuery progressbar demo from here http://www.youtube.com/watch?v=bYTRKfcG6Rg

-module(progressbar).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

title() -> "Progressbar Example".
headline() -> "Progressbar Example".

body() ->

    %% wire event with action
    wf:wire(password, #event{type=keyup, trigger = password,
	actions = [wf:f("$(function(){var len = jQuery(obj('~s')).val().length;
                                      jQuery(obj('~s')).progressbar({value : len * 10});
                                      })", [password, progressbar])]}),

    %% wire event with postback
    wf:wire(password_1, #event{type = keyup, postback = {password_1, keyup}}),

    %% wire event for progressbarcomplete and progressbarchange
    wf:wire(progressbar_1, #progressbar_event_on{event = progressbarcomplete, postback = {progressbar_1, complete}}),
    wf:wire(progressbar_1, #progressbar_event_on{event = progressbarchange, postback = {progressbar_1, changed}}),

    %% output html markup
    [
	%% set of controls for test progressbar without postback
	#panel{ body = [
	    #label { text = "Password Box : " },
	    #password {id = password, text="" },
	    #p{},
	    #progressbar{ id = progressbar, style = "width:230px; height:5px;", options=[{value, 0}]}
	]},

	#p{},

	%% set of controls for test progressbar with postback
	#panel{body = [
	    #label { text="Password Box: " },
	    #password {id = password_1, text="" },
	    #p{},
	    #progressbar{ id = progressbar_1, style = "width:230px; height:5px;", options=[{value, 0}]}
	]}
    ].

event({ID, keyup}) ->
    %% get current values from password box with id = password_1
    Len = length(wf:q(password_1)),
    ?PRINT({password_length, Len}),
    wf:wire(progressbar_1, #progressbar_value{value = Len * 10});
event({ID, complete}) ->
    ?PRINT({progressbarcomplete, ID});
event({ID, changed}) ->
    ?PRINT({progressbarchange, ID}).
event(Event) ->
    ?PRINT({Event}).
