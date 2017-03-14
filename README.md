Draw: demo of realtime sharing drawing board
============================================

Background
----------

`open whiteboard` is a drawing websocket javascript application,
you can find more information on the given link. 

    https://developer.mozilla.org/fr/demosdetail/open-whiteboard

[draw](http://github.com/mihawk/draw) was first made as a demo on the [ChicagoBoss framework](http://chicagoboss.org), to show how you could
handle websocket inside ChicagoBoss, since then i have made [naga-framework](http://github.com/naga-framework/naga)

Install erlang/OTP
------------------

- install from source code using [kerl](https://github.com/kerl/kerl)
	
```bash
 $ cd ~
 $ mkdir bin
 $ cd bin
 $ curl -O https://raw.githubusercontent.com/kerl/kerl/master/kerl
 $ chmod u+x kerl
 $ kerl list releases
 $ kerl build 19.2 19.2
 $ kerl install 19.2 ~/kerl/19.2
 $ .  ~/kerl/19.2/activate
```
    
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
event(init)                     -> wf:reg(?TOPIC);
event(#client{data={Sid,Data}}) -> case wf:session_id() of Sid -> skip; _-> draw(Data) end;
event(#client{data=D})          -> wf:send(?TOPIC,#client{data={wf:session_id(),D}}).

draw(Data) -> 
  Exec = wf:f("var dt = ~s;if(dt.socketid !== -1)"
              "{mySocketId =dt.socketid;} else "
              "{setupDraw(dt, true);}",[Data]),
  wf:wire(Exec).
```

Open `http://localhost:8001/` in your browser,
open a second web browser on the same url, or a tab
in the first browser then start to draw. :)
