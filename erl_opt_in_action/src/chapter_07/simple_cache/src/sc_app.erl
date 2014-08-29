-module(sc_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    sc_store:init(),  % 初始化内存数据库 ets
    case sc_sup:start_link() of
        {ok, Pid} ->
            sc_event_logger:add_handler(),
            {ok, Pid};
        Other ->
            {error, Other}
    end.

stop(_State) ->
    ok.
