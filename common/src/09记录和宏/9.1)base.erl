9、记录和宏
        记录提供数据抽象，当访问它的时候数据的实际形式被隐藏起来了。
        宏允许我们使用缩写，允许之后由Erlang预处理器来展开。

9.1 记录
    介绍记录
        记录（record）通常用用于元组的表示，用一个名称与元组中的一个元素对应起来。类似于c语言的structure，
        记录是有固定数目字段的数据结构，这些字段通过名称访问。记录不同于元组，元组通过位置信息访问。
        语法定义如下
    -record(name,{key1=Default1,key2 = default2,...}).        
    name是记录的名字，key1,key2是记录的字段名，且必须为原子。每个字段可以有默认值。        
    eg:   -record(person,{name,age,phone})   
        上述引入了记录类型person,每个记录实例包含三个名字的字段：name,age、phone
    #person{name="rockey",age=21,phone="999-999-999"}
        创建记录实例，#person是person记录的构造函数。  
   
    操作记录
        访问字段的一般形式为：
    Field1 = RecordExp#name.fieldName
    eg: Person = #person{name="abc"}   
        Name = Person#person.name  %获取name属性
        修改记录字段的一般形式为
    RecordExp#name{}..,fieldNamei=valuei,...}
    eg: NewPerson = Person#person{name="bcd"} %更新字段

    终端中的记录
    erlang只在编译器有效，在虚拟机中没有他们的类型，终端中可以使用rr(moduleName)加载模块中定义的记录。
        或者使用rd(name,{field1,field2,...})来直接定义包含有field1、field2等的记录
    rl()   返回目前终端中所有可见的记录定义。

9.1 宏
    简单宏
        定义如下
     -define(Name,Replacement)
    eg:-define(Timeout,1000).
    receive
    after ?Timeout -> ok    
    end

    宏参数化
        带参数的宏一般形式表示为：
    -define(Name(var1,var2,...,),Replacement).
    eg: -define(Log(Str,Args),io:format(Str,Args)).
      ?Log(" args is not wright (~p)~n",[1c2])

    -ifdef(debug).
    -define(TRACE(X),io:format("TRACE ~p:~p ~p~n",[?MODULE,?LINE,X])).
    -else.
    -define(TRACE(X),void).
    -endif.
























