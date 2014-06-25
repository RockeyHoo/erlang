%%%  
%%%  Erlang ����
%%%  	-- ��Ҫִ��һ��ģ���еĺ����������ȱ��룬�������ڸ�Ŀ¼������һ��module.beam�ļ�
%%% 	-- cd(Directory)  ����Ŀ¼
%%% 	-- c(Module) ����.erl��׺���ļ�
%%% 
%%%  eg ʹ���޶����Ƶ��ú���
> cd("/home/francesco/examples").
> c(demo).
> demo:double(10).
	
	
%%%  
%%%  Erlang ģ��ָ��
%%%  	ÿ��ģ�鶼ӵ��һ�� -attribute(Value)��ʽ�������б���-��ʼ��.������ module������ǿ���Ե�
%%%  	-- ����ʱ����һ������ָ�� -compile(export_all) ����׶ε���ģ���е����к��� ��ͬ�� c(Mod,[export_all])
%%% 	-- import(Module,[Function/Arity,...]) ������ģ���е��뺯�����ص���
%%% 	-- export([double/1]) �����˵���������һ���б�,�������Ա��ⲿ����
%%% 
%%%  �û��Զ���ģ������
%%%	  -- �Զ�������,ֻ����һ������ 
%%% 
%%%  ����ģ������Կ���ͨ�� Mod:module_info/0 or Mod:module_info/1 �õ� �����ն˿���ʹ��m(Module)���
%%% 
%%% eg:
-module(demo).
-export([double/1]).  %exportָ����Function/Arity�ĸ�ʽ �����˵���������һ���б�
-import(math,[sqrt/1]). %����ϵͳ����  �������� ����ά��
-author(Name).  %�Զ�������

> demo:module_info().

> m(demo).
	