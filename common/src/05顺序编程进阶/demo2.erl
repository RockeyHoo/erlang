%% @author heshuang
%% @doc @todo Add description to demo2.


-module(demo2).
-vsn(001).
-author({rockey}).
-purpose("example of erlang").
%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0]).

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

%%% cd("E:/Erlang/src/5顺序编程进阶").

