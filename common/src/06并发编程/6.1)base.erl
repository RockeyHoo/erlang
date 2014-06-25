6、  并发编程
    Erlang并发简介
    *进程属于操作语言，而非操作系统
    *Erlang进程创建和销毁都非常迅速
    *在进程间收发消息非常迅捷
    *进程在所有的操作系统上行为相同
    *可以创建大量进程
    *进程之间不共享任何数据，彼此完全独立
    *进程交互的唯一方式就是通过消息传递
        进程原语有三个：spawn,send,receive

6.1 并发原语
    Pid = spawn(Module,Function,Arguments) or   %无法获得代码动态更新的特性
    Pid = spawn(fun Module:Func/Arrys)          %函数引用，适用于动态更新
        创建一个新的并发进程，用于对Fun求值。

    Pid ! Message
        向标识符为pid的进程发送消息（异步）。 !为发送操作符。
    Pid!M 返回值为消息本身。 Pid1!Pid2!...!M将消息M发送到Pid1,Pid2所有进程中。

    receive ... end
        接收一个发给当前进程的消息。每个Erlang进程都有用来存储传入消息的信箱。消息可以使用receive语句从进程信箱中取得。
    recevie从信箱中取消息。如果一个receive没有匹配成功，则会暂停，而case会抛出异常。
    receive
        Pattern1 [when Guard1] -> Expression1;
        Pattern2 [when Guard2] -> Expression2;
        ...
    end
        当一个消息到达进程时，系统会尝试与Patten1匹配。如果成功，那么对Expression求值。
        使用receive时，如果信箱没有消息，则receive语句会暂停eg6.3
        可以使用flush()刷新信箱。

6.2 注册进程
        为了方便代替进程标示符的名称，利用注册进程别名是常用的方法。  
        使用内置函数register(Alias,Pid)注册一个进程，其中Alias是一个基元而Pid是进程标示符。
        注意发送消息到不存在的注册进程会导致错误，这点不同于使用进程表示符。
        相关的四个函数
    register(anAtom,Pid)  注册进程
    unregister(anAtom)    移除进程
    whereis(anAtom)       判断anAtom是否已经注册成功。true:Pid, false:undefined  
    registed()            返回一个注册名称的列表

6.3 超时
        当进程进入一个receive语句没有消息时，进程就会暂停。有一种结构可以设置超时时间。
    receive
        Pattern1 [when Guard1] -> Expression1;
        Pattern2 [when Guard2] -> Expression2;
    after
        Timeout ->Expression1;
        ...
    end
        如果没有消息，则等待Timeout毫秒，超时后执行after后结构。Timeout为整数，单位是毫秒
        注意1：使用超时时，注意flush（）信箱保证等到的是本次的消息。

6.4 进程管理器
        调试器主要用来跟踪程序的顺序方面的特性，而进程管理器则处理并发的方面。
        输入pman:start()启动进程管理器



进程相关的函数
    processes().  %返回所有系统中运行的进程列表。  可以通过erl +p MaxProcesses改变
    i().          %当前运行时系统正在执行的进程。
    unregister(Pid)
    registed()    %返回一个注册名称的列表
    regs()        %输出所有已注册的进程
    whereis(Alias)%返回和Alias关联的进程标示符


































