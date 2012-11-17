-module(action_dialog_example).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() ->
    #template { file=filename:join([web_common:templates(), "onecolumn.html"])
}.

title() -> "Action Dialog Example".
headline() -> "Action Dialog Example".

body() -> [

    #dialog{body = "Action Dialog Body"}

].

%% tabs_event(EventType, TabsTag, TabAnchor, TabPanel, TabIndex) ->
%%     ?PRINT({tabs_event, EventType, TabsTag, TabAnchor, TabPanel, TabIndex}).
