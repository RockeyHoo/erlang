5、顺序编程进阶

    5.1 BIF
        BIF(内建函数),是Erlang内建的函数。通常用于完成那些无法用Erlang完成的任务。
        eg: tuple_to_list/1  将元组转换成列表，time/0返回当前时间
                所有BIF都在Erlang模块之中，而且常用的都已经被自动导入，可以不用写erlang:前缀符号。
        > time().
        {15,30,3}

    5.2 二进制数据
                在Erlang中可以用二进制数据的结构来存储大量的原始数据。效率更高，且更节省空间。
                在书写或者打印时，二进制以整数或者字符序列形式出现，用尖括号包起来。
        eg: 
            <<5,10,25>>, <<"abcdef">>   
                每个二进制中的整数，必须在0~255之间。 <<"cat">> 等价于 <<99,97,116>>  
        
        BIF中有一些内置函数处理二进制数据，eg :
            @spec list_to_binary(IoList) -> binary()   %将IoList数据转换成二进制数据
            @spec split_binary(Bin,Pos) -> {Bin1,Bin2} %这个函数在Pos指定的位置将二进制数据Bin分割为两个部分
            @spec term_to_binary(Term) -> binary()     %将任意Erlang值转换为二进制数据
            @spec binary_to_term(Bin) -> Term          %将二进制数据转换成“外部数据格式”
            @spec size(Bin) -> Int                     %返回二进制数据的字节长度

    5.3 比特语法
            比特语法是模式匹配的一种扩展。一般用于比特级别的二进制数据封包和解包，它可以产生极为高效的代码，用来处理
        协议数据的封包和解包。

    5.3.1 16 bit色彩的封装与解包
            比如有一个16bit的RGB颜色,如果红色5bit,绿色6bit,蓝5bit,封包如下：
        Mem = <<Red:5,Green:6,Blue:5>>  
            解包如下：
       <<Red:5,Green:6,Blue:5>>  = Men     
    
    5.3.2 比特语法表达式
                比特语法表达式有如下形式：
      <<>>
      <<E1,E2,....,En>>
                每个Ei代表了二进制数据中的一个单独区块。每个Ei都是以下4种形式的一种：
         Ei = Value |
              Value:Size |      
              Value/TypeSpecifierList |
              Value:Size/TypeSpecifierList
                其中：
        Value -- 已经绑定的变量、文本串、或者返回值为整数、浮点数、二进制数的表达式
        Size  -- 返回值为整数的表达式
        TypeSpecifierList -- 由连字符间隔的形式End-Sign-Type-Unit的列表。
            @type End = big | little | native
                           该字段指定了计算机系统的字节序。native是运行时的字节序，依赖cpu.默认的是big.在不同字节序的机器上进行整形
                       和二进制的封包解包是，需要注意。
            @type Sign = signed | unsigned
                           这个参数用于模式匹配，默认unsigned
            @type Type = integer | float | binary
                            默认是integer
            @type Unit = 1 | 2 | ... 255
                整个区块的长度为Size * Unit bit ,区块长度必须>=0,8的倍数。
        Unit默认值依赖Type,Type = integer/float,则为1；Type = binary，则为8.
                
          






































    5.3 比特语法
        