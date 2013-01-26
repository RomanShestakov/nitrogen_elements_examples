% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(dialog).

-include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
-compile(export_all).

body() -> [
    #dialog{buttons = [{"Ok", ok}], show_cancel = true, title = "Action Dialog Title", body = "Action Dialog Body"}
].

event(Event) ->
    Module = wf:page_module(),
    Module:event(Event).
