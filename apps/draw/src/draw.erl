-module(draw).
-behaviour(supervisor).
-behaviour(application).
-export([init/1, start/2, stop/1, main/1]).
-compile(export_all).

main(A)    -> mad_repl:sh(A).
start(_,_) -> supervisor:start_link({local,draw }, draw,[]).
stop(_)    -> ok.
init([])   -> naga:start([draw]), 
              naga:watch(draw),
              sup().
sup()      -> { ok, { { one_for_one, 5, 100 }, [] } }.

log_modules() -> [index].
