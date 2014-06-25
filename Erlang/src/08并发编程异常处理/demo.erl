-module(demo).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0,
        loop/0,
        request/1
        ]).


%% --======================================================================
%%  8.1 测试退出信号
%% --======================================================================
%% 服务端处理
start() ->
    register(demo,spawn_link(demo,loop,[])).   %% 建立链接进程

loop() ->
    receive 
        {request,Pid,Msg} -> Pid !{result,Msg+1}
    end,
    loop().

%% 客户端请求
request(Int) -> 
    demo ! {request,self(),Int},
    receive 
        {result,Result} -> Result
    after 1000 -> timeout
    end.

%cd("E:/Erlang/src/8并发编程异常处理").
%c(demo).
% self().
% demo:start().
% demo:request(1).
% self().
% demo:request(one).  % 此时会抛出异常，没有处理，消息会传播导致两个进程都终止
%



