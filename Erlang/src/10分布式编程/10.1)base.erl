10、 分布式编程

10.1 分布式原语
        分布式Erlang的核心概念就是节点。一个节点就是一个自己自足的的系统，它是一个包含了地址空间和独立进程集的完整
        虚拟机。
        在一个分布式的Erlang的系统中，所有的节点都必须用相同的magic cookie来启动，或者执行erlang:set_cookie
        来将他们的cookie改为相同的值。
        分布式编程常用的BIF:    
    @spec spawn(Node,Fun) -> Pid / spawn_link(Node,Fun) -> Pid
        这个原语和spawn(Fun)没有多大区别，但是新创建的进程位于Node节点之上。
    @spec disconnect_node(Node) -> bool() |ignored
        强制端口一个节点的连接
    @spec monitor_node(Node,Flag) -> true
        如果Flag=true就打开监听，在监听被打开时，若有新的Node加入或者离开erlang集群，进程会
        收到{nodeup,Node},{nodedown,Node}消息
    @spec node() -> Node
        返回本地节点的名字
    {RegName,Node} ! Msg
        向节点Node上名为RegName的注册进程发送消息Msg.

10.2 分布式编程中使用的库
        在标准库中，下面两个模块可以满足大多数编程需要
    rpc模块提供了一系列远程调用服务。
    global模块提供了名称注册和分布式系统中的锁定功能。

10.3 有cookie保护的系统
        对于两个相互通信的Erlang节点来说，他们必须使用相同的magic cookie。我们可以用3种方式设置cookie.
    1. 把相同的cookie存放在$HOME/.erlang.cookie文件中。
    2. 启动erlang时，可以使用命令行参数-setcookie设置
    3. 使用BIF erlang:set_cookie(node(), Cookie)设置本地节点cookie值。

10.4 基于套接字的分布式编程
    Erlang内置的分布式模型，主要问题是客户机可以在服务器上运行任何进程。这在带来极大便利的同时，也易于
        攻击，这时，可以采用一种受限的进程创建模式。
    lib_chan
    lib_chan允许一个用户显示的控制他自己的机器能够启动哪些进程的模块。主要接口如下：
    @spec  start_server() -> true
        这个函数在本地主机启动一个服务。
    @spec  start_server(Conf) -> true
         这个函数在本地主机启动一个服务,其行为取决于文件conf的内容。
    @spec connect(Host,Port,S,P,Args) -> {ok,Pid} | {error,Why}
        尝试在主机host上打开端口port,然后尝试激活有密码P保护的服务S，如果密码正确，返回{ok,Pid}.



























