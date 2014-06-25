5、顺序编程进阶
    5.3 比特语法
1).apply    
   BIF apply(Mod, Func,[Arg1,Arg2,...,ArgN])将Mod模块的Func函数应用到参数Arg1,..ArgN
    上去，等价于 Mod:Func(Arg1,Arg2,...,ArgN).
    eg:erlang:atom_to_list([hello])  等价于  apply(erlang,atom_to_list,[hello])

2).属性
            模块属性的语法是-AtomTag(...).有两种
    1. 预定义属性
        eg: -module(demo) , -import(lists,[map/2]).  -export([Name/1]).
            - complite(Options).向编译器选项列表中添加Options.
            -vsn(Version).  指定一个模块的版本
    2. 自定义属性
                语法如下： -SomeTag(Value).模块属性的值被编译进模块并可以在运行时被提取出来。
      eg: -svn(123456).  -author({joe,armstrong}). -purpose("example").
        > demo:module_info(). % 返回属性列表
3). 转义字符

4). 函数引用
            在一个模块引用引入另一个模块的函数语法如下：
    fun  LocaFunc/Arity or
    fun  Mod:Remote/Arity
    eg: double(L) -> lists:map(fun squart/1,L).    %squart在本模块中
        double(L) -> lists:map(fun x1:square/1,L). %squart在X1模块中

5). 包含文件
            语法如下：
        -include(Filename).  包含扩展名为.hrl的文件，Filename可以使相对或者绝对路径。
        -include_lib(Name).  可以引入库中的文件
        eg: -include_lib("kernel/include/file.hrl").        

6). 宏
 Erlang中宏的语法如下：
 -define(Constant, Replacement).
 -define(Func(Var1,Var2,...,Var),Replacement).   
        当Eralng如果遇到?MacroName表达式，这个宏就会起作用。  
 eg:  -define(macro1(X,Y),{X*Y}).
     foo(A) ->
           ?Macro1(X+10,Y).
                会被扩展为：
     foo(A) ->
           (X+10)*Y.  
 ?FILE  扩展为当前文件名
 ?MODULE扩展为当前模块名
 ?LINE  扩展为当前行号
 .宏的流程控制
    -undef(Macro). 取消该宏定义，该语句之后不能再调用此宏
    -ifdef(Marco). 只有Macro定义后，才对该行以下代码运算
    -ifndef(Macro).只有在Macro未定义下，才对该行以下代码运算
    -else.         只能在ifdef,ifndef后出现
    -endif.        ifdef,ifndef的结束语句。

7). 进程字典
    Erlang的每一个进程都有自己的私有数据存储，叫做进程字典（键值对保存）。
            以下方法可以操作进程字典
    @spec put(Key,Value) -> OldValue %向进程字典加入值
    @spec get(Key) -> [{Key,Value}]  %返回整个字典
    @spec get_keys(Value) -> [Key]   %返回Value的键的列表
    %最后程序中勿使用进程字典，会使调试困难。
        
8). 引用
        引用是全局唯一的Erlang值，使用BIF erlang:make_ref来常见引用。          

9). 下划线变量
   _Var是一种特殊的语法，声明一个常规变量。主要有以下用途：
    1. 命名一个不准备使用的变量。
    2. 方便程序进行太欧式。   

10). 调试
         输入debugger:start()启动调试器
    c(Model,[debug_info]). 使用debug_info标记来编译它
    
        打开调试器Model -> Interpret Modules 选择相应的模块调试
        可以双击打断点调试
     
11). 尾递归调用
        函数f的调用发生在f函数体的最后一个表达式(即尾部)，这个函数f就是尾递归的。
        尾递归调用函数可以无限循环而不需要消耗栈空间。































     