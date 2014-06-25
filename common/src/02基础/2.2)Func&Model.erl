%%%  
%%%  Erlang 函数
%%%  	-- 函数的名称是一个基元。
%%% 	-- 函数参数的个数叫做元数。用->分割函数体和函数头
%%% 	-- 函数的返回值是最后一个表达式的结果
%%% 
%%% 
%%%  eg 计算形状的面积
area({square,Side})->
	Side*Side;
area({cicre,R})->
	math:pi()*R*R;
area({triangle,A,B,C})->
	S=(A+B)*C/2;
area(Other)->
	{error,invalid_object}.
	
	
%%%  
%%%  Erlang 模块
%%%  	-- 函数组合在一起构成模块。
%%% 	-- 模块命名方式 -module(Name)
%%% 	-- 函数的返回值是最后一个表达式的结果
%%% 
%%% eg:
-module(demo).
-export([double/1]).  %export指令以Function/Arity的格式

double(Value) ->
	times(Value, 2).
times(X, Y)->
	X*Y.

%%%    	
%%%  	
%%%  	