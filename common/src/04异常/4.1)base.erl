4、 异常
    4.1 抛出异常
            可以通过调用下面内建的异常产生函数来显示抛出一个异常。
      exit(Why)
            当想要终止当前进程，调用这个函数。如果该异常未捕获，则系统会广播所有与此进程相关的进程{'EXIT',Pid,Why}消息
      throw(Why)
            这个函数用于抛出一个调用者可能会捕获的异常。可以将这个调用包含在try...catch表达式中并对错误进行处理。
      erlang:error(Why)
            这个函数用于抛出“崩溃错误”。

    4.2 捕获异常
      Erlang的捕获异常的语法与java有点相似， 语法如下：
      try FuncOrExpressionSequence of
            Pattern1 [when Guard1] -> Expression1;
            Pattern2 [when Guard2] -> Expression2;
            ...
      catch
          ExceptionType:ExPattern1 [when ExGuard1] -> ExExpressions1;
          ExceptionType:ExPattern2 [when ExGuard2] -> ExExpressions2;
          ...
      after
          AfterExpressions
      end
      try...catch就像一个case表达式。工作原理如下：首先对FuncOrExpressionSequence求值。如果无异常，则执行函数体
        模式匹配Pattern1、Pattern1等，如果匹配成功，它的值被当做整个try...catch的值返回。
            如果FuncOrExpressionSequence有异常抛出，会匹配catch下的ExPattern1等模式，然后对表达式序列求值。ExceptionType
        是原子throw,exit,error中的一个，默认的是throw.
      after用于执行FuncOrExpressionSequence后的清理工作。无论抛出异常，这段代码一定会被执行。在AfterExpressions中
        的返回值会被自动舍弃。
    
    4.2.1 缩减版本
            我们可以忽略try...catch表达式的几个部分，eg:
      try F of
            Val -> Val
      catch
        ..
      end
            等价于
      try F of
      catch
        ..
      end

    4.3 栈跟踪
            当捕获异常时，可以通过调用erlang:get_stacktrace()查看最近的栈跟踪信息。



















