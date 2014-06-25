%% @author heshuang
%% @doc @todo Add description to demo.


-module(demo).

%% ====================================================================
%% API functions
%% ====================================================================
-export([generate_exception/1,
        catcher/1,
        demo1/0,
        demo2/0,
        demo3/0
        ]).



%% ====================================================================
%% 4.1 定义异常函数
%% ====================================================================
generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'Exit',a};
generate_exception(5) -> erlang:error(a).

%% ====================================================================
%% 4.2 演示异常处理
%% ====================================================================
demo1() ->
    [catcher(N) || N <- [1,2,3,4,5]].

catcher(N) ->
    try generate_exception(N) of
        Val -> {N,normal,Val}
    catch
        throw:X -> {N,thrown,X};
        exit:X -> {N,exit,X};
        error:X -> {N,error,X}
    end.

demo2() ->
    [{I, (catch generate_exception(I))}|| I <- [1,2,3,4,5]].

demo3() ->
    try generate_exception(5)
    catch
        error:X -> {X,erlang:get_stacktrace()}
    end.















































