-module(demo2).
-export([even/1,number/1]).
% This is a comment.
% Everything on a line after % is ignored.
even(Int) when Int rem 2 ==0 -> true;
even(Int) when Int rem 2 ==1 -> false.

number(Num) when is_integer(Num) -> integer;
number(Num) when is_float(Num) -> float;
number(_Other)  -> false.



% cd("E:/Erlang/src/3顺序编程").
% c(demo2).
% demo:convert(1).


