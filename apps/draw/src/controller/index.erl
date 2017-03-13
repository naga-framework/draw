-module(index).
-export([index/3, event/1]).
-default_action(index).
-actions([index]).

-include_lib("n2o/include/wf.hrl").
-include_lib("nitro/include/nitro.hrl").

-define(TOPIC, {topic,<<"drawboard">>}).

%% INDEX CONTROLLER
index(<<"GET">>, _, _) -> ok.

%% WS EVENT HANDLING
event(init)                     -> wf:reg(?TOPIC);
event(#client{data={Sid,Data}}) -> case wf:session_id() of Sid -> skip; _-> draw(Data) end;
event(#client{data=D})          -> wf:send(?TOPIC,#client{data={wf:session_id(),D}}).

draw(Data) -> 
  Exec = wf:f("var dt = ~s;if(dt.socketid !== -1)"
              "{mySocketId =dt.socketid;} else "
              "{setupDraw(dt, true);}",[Data]),
  wf:wire(Exec).


