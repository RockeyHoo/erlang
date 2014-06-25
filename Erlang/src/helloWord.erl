%% @author heshuang
%%  写一个hello word
%% 1、打开 eclipse , New / Project / Erlang Project
%% 2.右击 src ,选 New Module 来新建一个erlang文件(其扩展名为erl)
%%     函数名称要求第一个字母小写
%% 3.编译
%%    选择文件，右键Run As/ Run configurations...
%%    在run configuration Runtimes / runtimes输入node name
%%    Apply,Run
%%    在控制台中输入 >c(hellpWord).
%%    出错，查看路径，pwd(). 切换路径 cd("E:/Erlang/src").


-module(helloWord).

%% ====================================================================
%% API functions
%% ====================================================================
-export([printHelloWorld/0]). %% 0 表示没有参数



%% ====================================================================
%% Internal functions
%% ====================================================================
printHelloWorld() -> 
    io:format("Hello World!~n").


