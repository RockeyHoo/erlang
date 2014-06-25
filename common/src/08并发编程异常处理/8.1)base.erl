8、 并发编程异常处理
      并发编程中处理异常的方法，需要引入3个概念：连接(link)、退出信号(exit signal)、系统进程

8.1 链接进程
    A进程可以通过调用BIF link(P)（P值是另一个进程B的pid）,与B建立链接，一单建立链接，它们就会自动
        相互监视。此时，若A消亡，系统会向B发送一个叫做退出信号的东西（eg：{'EXIT',B,Why}），反之一样。

        如果接到退出信号没有特殊处理，那么这个退出信号的默认处理就是让该进程一并退出。如果进程捕获退出信号，
        那么我们称其为系统进程(system process)。

8.2 捕获退出信号
        进程可以通过设定进程标示符trap_exit，然后执行函数调用process_flag(trap_exit,true)来捕获退出
        信号。

8.3 监控内置函数
        链接是双向的，监控可以使单向的
        erlang:monitor(process,Pid) 
        其中pid可以使进程标示符，也可以使注册的名字。当pid终止的时候，监控树会得到消息{'DOWN',Reference,process,Pid,Reason}。
        可以通过erlang:demonitor（Reference,[flush])关闭监控，同时刷新信箱
        链接是永久的，而且是双向的。

































