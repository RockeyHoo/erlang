%%%  
%%%  Erlang 编译
%%%  	-- 若要执行一个模块中的函数，必须先编译，编译后会在该目录下生成一个module.beam文件
%%% 	-- cd(Directory)  进入目录
%%% 	-- c(Module) 编译.erl后缀的文件
%%% 
%%%  eg 使用限定名称调用函数
> cd("/home/francesco/examples").
> c(demo).
> demo:double(10).
	
	
%%%  
%%%  Erlang 模块指令
%%%  	每个模块都拥有一个 -attribute(Value)格式的属性列表。以-开始，.结束。 module属性是强制性的
%%%  	-- 编译时，有一个编译指令 -compile(export_all) 编译阶段导出模块中的所有函数 等同于 c(Mod,[export_all])
%%% 	-- import(Module,[Function/Arity,...]) 从其他模块中导入函数本地调用
%%% 	-- export([double/1]) 包含了导出函数的一个列表,申明可以被外部调用
%%% 
%%%  用户自定义模块属性
%%%	  -- 自定义属性,只能有一个参数 
%%% 
%%%  所以模块的属性可以通过 Mod:module_info/0 or Mod:module_info/1 得到 。在终端可以使用m(Module)命令。
%%% 
%%% eg:
-module(demo).
-export([double/1]).  %export指令以Function/Arity的格式 包含了导出函数的一个列表
-import(math,[sqrt/1]). %调用系统函数  尽量少用 难以维护
-author(Name).  %自定义属性

> demo:module_info().

> m(demo).
	