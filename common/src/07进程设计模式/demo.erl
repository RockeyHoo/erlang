-module(demo).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0,
    stop/0,
    allocate/0,
    deallocate/1,
    init/0]).


%cd("E:/Erlang/src/7进程设计模式").
%c(demo).
%

%% --======================================================================
%%  7.1 频段服务器，服务端代码
%% --======================================================================
start() ->
    register(demo,spawn(demo,init,[])).  %注册一个并发进程

init() ->
    Frequencies = {get_frequencies(),[]},
    loop(Frequencies).

get_frequencies() ->
    [10,11,12,13,14,15].
    


%% --======================================================================
%%  7.2 客户端代码
%% --======================================================================
stop() -> call(stop).
allocate() -> call(allocate).
deallocate(Freq) -> call({deallocate,Freq}).

call(Msg) ->
    demo ! {request,self(),Msg},
    receive
        {reply,Reply} -> Reply
    end.

%% the main loop
loop(Frequencies) ->
    receive
        {request,Pid,allocate} ->
            {NewFrequeccies,Reply} = allocate(Frequencies,Pid),
            reply(Pid,Reply),
            loop(NewFrequeccies);
        {request,Pid,{deallocate,Freq}} ->
            NewFrequencies = deallocate(Frequencies,Freq),
            reply(Pid,ok),
            loop(NewFrequencies);
        {request,Pid,stop} ->
            reply(Pid,ok)
    end.

reply(Pid,Reply) ->
    Pid !{reply,Reply}.
            
%%  the internal help functions
allocate({[],Allocated},_Pid) ->
    {{[],Allocated},{error,no_frequency}};
allocate({[Freq|Free],Allocated},Pid) ->
    {{Free,[{Freq,Pid}|Allocated]},{ok,Freq}}.

deallocate({Free,Allocated},Freq) ->
    NewAllocated = lists:keydelete(Freq, 1, Allocated),
    {[Freq|Free],NewAllocated}.


%cd("E:/Erlang/src/7进程设计模式").
%c(demo).
% demo:start()
% demo:allocate().
% demo:deallocate(11).
% demo:stop().
%
% pman:start()
% c(demo,[debug_info]).
% debugger:start()
%
%
































