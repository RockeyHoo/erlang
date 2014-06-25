%% @author heshuang
%% @doc @todo Add description to demo.


-module(demo).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0,
        store/2,
        lookup/1]).

%% ====================================================================
%% 10.1 一个简单的名字服务
%% ====================================================================
%% 启动服务器，创建服务并且把服务的名字注册为demo
start() -> register(demo,spawn(fun() -> loop() end)).

%% 将键和值关联起来
store(Key,Value) -> rpc({store,Key,Value}).

%% 根据key查找value值
lookup(Key) -> rpc({lookup,Key}).

rpc(Q) ->
    demo!{self(),Q},
    receive
        {demo,Reply} ->
            Reply
    end.

%% 使用进程字典get和put原语事项键值服务
loop() ->
    receive
        {From,{store,Key,Value}} ->
            put(Key,{ok,Value}),
            From! {demo,true},
            loop();
        {From,{lookup,Key}} ->
            From! {demo,get(Key)},
            loop()
    end.


% cd("E:/Erlang/src/10分布式编程").
% c(demo).
% demo:start().
% demo:store({location,rockey},"Rockey Hoo").
% demo:store(weather,"rainning...").
% demo:lookup({location,rookey}).
%
%
%






























