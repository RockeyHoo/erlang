%% @author dell
%%  捕获推出信号进阶
%%      程序启动3个进程：A和B、C。让后A链接到B,再把B链接到C。
%% 


-module(demo2).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/2]).



%% ====================================================================
%% Internal functions
%% ====================================================================
start(Bool,M) ->
    A = spawn(fun() -> a() end),            %A是系统进程
    B = spawn(fun() -> b(A,Bool) end),
    C = spawn(fun() -> c(B,M) end),
    sleep(1000),
    status(a,A),
    status(b,B),
    status(c,C).

%% ====================================================================
%% 辅助函数
%% ====================================================================
a() ->
    process_flag(trap_exit,true),
    wait(a).

b(A,Bool) ->
    process_flag(trap_exit,Bool),   
    link(A),
    wait(b).

c(B,M) ->
    link(B),
    case M of
        {die,Reason} ->
            exit(Reason);
        {divide,N} ->
            1/N,
            wait(c);
        normal ->
            true
    end.

%% 打印接受到的所有消息
wait(Prog) ->   
    receive
        Any ->
            io:format("Process ~p receive ~p~n",[Prog,Any]),
            wait(Prog)
    end.

%%暂停T号码
sleep(T) ->
    receive
    after T -> true
    end.

%%检测进程是否存活
status(Name,Pid) ->
    case erlang:is_process_alive(Pid) of
        true ->
            io:format("process ~p (~p) is alive~n", [Name,Pid]);
        false ->
            io:format("process ~p (~p) is dead~n", [Name,Pid])
    end.





% cd("E:/Erlang/erl/src/06顺序编程高阶"). 
% c(demo2).
% demo2:start(false,{die,abc})        B是普通进程，exit X     测试B、C都消亡
% demo2:start(false,{devide,0})       B是普通进程，exit X     测试B、C都消亡
% demo2:start(false,{die,normal})     B是普通进程，exit normal测试C都消亡
% demo2:start(false,{die,kill})       B是普通进程，exit kill  测试B、C都消亡
%
% demo2:start(true,{die,abc})        B是系统进程，exit X     测试C都消亡
% demo2:start(true,{devide,0})       B是系统进程，exit X     测试C都消亡
% demo2:start(true,{die,normal})     B是系统进程，exit normal测试C都消亡
% demo2:start(true,{die,kill})       B是系统进程，exit kill  测试C都消亡
% 




























