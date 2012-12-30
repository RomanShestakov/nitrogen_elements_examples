-module(web_common).
-compile(export_all).
-export([docroot/0, templates/0]).

-include_lib ("nitrogen_core/include/wf.hrl").

docroot() ->
    code:priv_dir(nitrogen_elements_examples) ++ "/static".

templates() ->
    code:priv_dir(nitrogen_elements_examples) ++ "/templates".

header(Selected) ->
    wf:wire(Selected, #add_class { class=selected }),
    #panel { class=menu, body=[
        #link { id=index, url='/', text="INDEX" }
    ]}.

footer() ->
    #panel { class=credits, body=[
        "
        "
    ]}.

assert_path( Str ) when is_list( Str ) ->
    assert_path( #template {
       file=filename:join([templates(), Str])
});

assert_path( Elem=#template {} ) ->
       Elem.
