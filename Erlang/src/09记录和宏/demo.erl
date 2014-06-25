%% @author heshuang
%% @doc @todo Add description to demo.


-module(demo).

-vsn(001).
-author({rockey}).
-purpose("example of erlang").
-record(person,{name,age=25,phone}).
-export([start/0,loop/1]).



%% ====================================================================
%% API functions
%% ====================================================================

-ifdef(debug).
-define(TRACE(X),io:format("TRACE ~p:~p ~p~n",[?MODULE,?LINE,X])).
-else.
-define(TRACE(X),void).
-endif.


%% ====================================================================
%% 宏
%% ====================================================================
start() -> loop(5).

loop(0) ->
    void;
loop(N) ->
    ?TRACE(N),loop(N-1).

%cd("E:/Erlang/src/9记录和宏"). 
% c(demo).