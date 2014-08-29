11、OTP 概述

11.1 概念
    OTP 即 Open Telecom Platform 开发电信平台。它是一个应用程序操作系统，还包括大量库和程序用来构建
        大规模的分布式容错系统。


11.2 OTP的行为机制 gen_*
    gen_server - 用以创建通用服务器，向多个客户端提供服务；
    gen_fsm - 用以创建有限状态机。
    gen_event - 用以创建事件处理器和发报器。它最常用于运行错误日志（也是发报器），许多对象（终端、文件等）可与之关联。

11.3 gen_server 回调结构                                                     
   gen_server:start_link---init([])-> {ok,State}.—启动服务，初始状态为state                                             
   gen_server:call(Name,Request)---handle_call(Request,From,State)-处理请求信息，
        主要用来实现远程过程调用（RPC）
        handle_call(Request,From,State) ->
       Reply = .., {reply,Reply,State}
   gen_server:cast(Name,Name)---handle_cast – 实现通知(cast)
    handle_cast(_msg,State) ->
        {noreply,newState}
         handle_info(_msg,State) ->  --处理发给服务器的原生消息
        {noreply,newState}
    terminate(Reason,NewState) -> 服务器终止时调用
        {..}
    code_change(_OldVsn, State, Extra) -> 实现热代码替换
        {ok, State}.

11.4 通用事件处理
        通常当一件事情发生时，只需要发送一条event消息给某个已注册的进程
    eg:  RegProcName ! {event,E}
    RegProcName 注册进程的名字，E 就是事件，可以使任何Erlang类型。

















