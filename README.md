Draw is a demo of how websocket is handle in a NAGA app
=======================================================

Background
----------

`open whiteboard` is a drawing websocket javascript application,
you can find more information on the given link. 

    https://developer.mozilla.org/fr/demosdetail/open-whiteboard

[draw](http://github.com/mihawk/draw) was first made as a demo on the [ChicagoBoss framework](), to show how you could
handle websocket inside ChicagoBoss, since then i have made [naga-framework](http://github.com/naga-framework/naga)

Quickstart
----------

Get draw

```sh
    >git clone http://github.com/naga-framework/draw.git
    >cd draw
    >./mad deps comp plan repl
```
    
All Features in One snippet
---------------------------

```erlang
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
event(init)                      -> wf:reg(?TOPIC);
event(#client{data={draw,Data}}) -> draw(Data);
event(#client{data=D})           -> wf:send(?TOPIC,#client{data={draw,D}}).

% -----------------------------------------------------------------------------
% internal function
% -----------------------------------------------------------------------------
draw(Data) -> 
  Exec = wf:f("var dt = ~s;if(dt.socketid !== -1)"
              "{mySocketId =dt.socketid;}"
              " else "
              "{setupDraw(dt, true);}",[Data]),
  wf:wire(Exec).
```

Open `http://localhost:8001/draw` in your browser,
open a second web browser on the same url, or a tab
in the first browser then start to draw. :)
