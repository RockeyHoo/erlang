%%%  
%%%  Erlang ����
%%%  	-- ������������һ����Ԫ��
%%% 	-- ���������ĸ�������Ԫ������->�ָ����ͺ���ͷ
%%% 	-- �����ķ���ֵ�����һ�����ʽ�Ľ��
%%% 
%%% 
%%%  eg ������״�����
area({square,Side})->
	Side*Side;
area({cicre,R})->
	math:pi()*R*R;
area({triangle,A,B,C})->
	S=(A+B)*C/2;
area(Other)->
	{error,invalid_object}.
	
	
%%%  
%%%  Erlang ģ��
%%%  	-- ���������һ�𹹳�ģ�顣
%%% 	-- ģ��������ʽ -module(Name)
%%% 	-- �����ķ���ֵ�����һ�����ʽ�Ľ��
%%% 
%%% eg:
-module(demo).
-export([double/1]).  %exportָ����Function/Arity�ĸ�ʽ

double(Value) ->
	times(Value, 2).
times(X, Y)->
	X*Y.

%%%    	
%%%  	
%%%  	