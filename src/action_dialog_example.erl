% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(action_dialog_example).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

main() ->
    #template { file=filename:join([web_common:templates(), "onecolumn.html"])
}.

title() -> "Action Dialog Example".
headline() -> "Action Dialog Example".

body() -> [

    #dialog{buttons = [{"Ok", ok}], show_cancel = true, title = "Action Dialog Title", body = "Action Dialog Body"}
].

dialog_event(Event) ->
    ?PRINT({page_event, Event}).
