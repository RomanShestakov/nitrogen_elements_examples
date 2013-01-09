% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(progressbar).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).
-define(EVENT_TABSSHOW, 'tabsshow').

main() -> #template{file=filename:join([web_common:templates(), "onecolumn.html"])}.

title() -> "Progressbar Example".
headline() -> "Progressbar Example".

body() ->
    %% %% bind to tabs 'tabsshow' event
    %% wf:wire(tabs, #tab_event_on{event = ?EVENT_TABSSHOW}),
    %% %% wire tabs_select to show how to change tab after tabs control was initialized
    %% wf:wire(tabs, #tab_select{tab = 1}),
    %% wf:wire(#api{name=history_back, tag=f1}),
    [
	#progressbar{
	    id = progressbar,
	    options=[{value, 37}]
	}
].

%% tabs_event(?EVENT_TABSSHOW, _Tabs_Id, TabIndex) ->
%%     ?PRINT({tabs_event, ?EVENT_TABSSHOW}),
%%     wf:wire(wf:f("pushState(\"State ~s\", \"?state=~s\", {tabindex:~s});", [TabIndex, TabIndex, TabIndex])).

%% api_event(history_back, _B, [[_,{data, Data}]]) ->
%%     %% ?PRINT({history_back_event, B, Data}),
%%     TabIndex = proplists:get_value(tabindex, Data),
%%     wf:wire(tabs, #tab_event_off{event = ?EVENT_TABSSHOW}),
%%     wf:wire(tabs, #tab_select{tab = TabIndex}),
%%     wf:wire(tabs, #tab_event_on{event = ?EVENT_TABSSHOW});
%% api_event(A, B, C) ->
%%     ?PRINT(A), ?PRINT(B), ?PRINT(C).
