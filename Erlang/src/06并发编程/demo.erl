%% @author heshuang
%% @doc @todo Add description to demo.


-module(demo).

%% ====================================================================
%% API functions
%% ====================================================================
-export([loop/0,
         go/0,
         fore/0,
         go1/0,
         fore1/0,
        sleep/3,
        send/2,
        start/1,
        start_proc/2,
        max/1,
        test_sleep/0,
        timer_start/2,
        cancel/1]).



%% ====================================================================
%% 6.1 测试并发
%% ====================================================================
loop() ->
    receive
        {From,{founder,Width,Height}} ->  From ! Width*Height,loop();
        {From,{circle,R}} -> From ! 3.14*R*R,loop();
        {From,Other} -> From !{error,Other},loop()
    end.

%% ====================================================================
%% 6.2 rpc辅助函数
%% ====================================================================
%%rpc(Pid,Request) ->
%%    Pid ! {self(),Request},
%%    recevie
%%        Response ->
%%            Response
%%    end.

%% ====================================================================
%% 6.3 进程通信
%% ====================================================================
go() ->
    Pid = spawn(demo,fore,[]),     %初始化一个子进程，子进程信箱没有消息，receive暂停
    Pid ! {self(),hello},          %父进程向子进程发送消息
    receive                        %父进程在receive语句暂停，并等待一个消息
        {Pid,Msg} -> io:format("~w~n",[Msg])        %此处Pid是已经绑定的变量，确保只接收指定子进程的消息
    end,
    Pid ! stop.                    %父进程收到消息后，发送stop指令到子进程

fore() ->
    receive
        {From,Msg} -> From ! {self(),Msg},fore();  %如果进程没有更多的代码可以执行，就会终止，为了避免终止，采用了递归
        stop -> true
    end.
        
%% ====================================================================
%% 6.4 注册进程
%% ====================================================================
go1() ->
    register(demo,spawn(demo,fore1,[])),    %使用注册进程，一般以模块名命名进程名字
    demo ! {self(),hello},          
    receive                        
        {_pid,Msg} -> io:format("~w~n",[Msg])       
    end.                    

fore1() ->
    receive
        {From,Msg} -> From ! {self(),Msg},fore1();  
        stop -> true
    end.

%% ====================================================================
%% 6.5 延迟发送消息
%% ====================================================================
sleep(Pid,Time,Msg) ->
    receive
    after 
        Time-> Pid ! Msg   %延迟Time毫秒向Pid发送消息
    end.

send(Time,Msg) ->
    spawn(demo,sleep,[self(),Time,Msg]).

%  eg2, 测试】
test_sleep() ->
    io:format(" begin ......"),
    sleep1(5000),
    io:format(" end ......").

sleep1(Time) ->
    receive
    after 
        Time -> true
    end.
%demo:max(10000).


%% ====================================================================
%% 6.6 性能基准测试demo
%% ====================================================================
start(Num) ->
    start_proc(Num,self()).

start_proc(0,Pid) ->
    Pid ! ok;
start_proc(Num,Pid) ->
    Npid = spawn(demo,start_proc,[Num-1,Pid]),
    Npid ! ok,
    receive 
        ok -> ok
    end.
% timer:tc(demo,start,[10000]).

%% ====================================================================
%% 6.7 测试创建进程花多长时间
%% ====================================================================
% 创建N个进程，然后销毁，测试需要多长时间
max(N) ->
    Max = erlang:system_info(process_limit),
    io:format("Maxinum allowed processs : ~p~n",[Max]),
    statistics(runtime),
    statistics(wall_clock),
    L = for(1,N,fun() -> spawn(fun() -> wait() end) end),
    {_,Time1} = statistics(runtime),
    {_,Time2} = statistics(wall_clock),
    lists:foreach(fun(Pid) -> Pid! die end, L),
    U1 = Time1*1000 /N,
    U2 = Time2*1000 /N,
    io:format("Process spawn time = ~p (~p) microsends ~n",[U1,U2]).

wait() ->
    receive 
        die -> void
    end.

for(N,N,F) -> [F()];
for(I,N,F) -> [F()|for(I+1,N,F)].

%% 实现一个计时器
%% 在指定Time毫秒数后，调用Fun函数
timer_start(Time,Fun) ->
    spawn(fun() -> timer(Time,Fun) end).

cancel(Pid) ->
        Pid ! cancel.

timer(Time,Fun) ->
    receive
        cancel -> void
    after
        Time -> Fun()
    end.

% Pid = demo:timer_start(5000,fun() -> io:format("hello world ! ~n") end).
% demo:cancel(Pid).




%cd("E:/Erlang/src/6并发编程").
%c(demo).
%Pid = spawn(fun demo:loop/0).
%Pid ! {circle,10}.
%








































