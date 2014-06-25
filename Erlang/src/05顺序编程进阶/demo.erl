%% @author dell
%% @doc @todo Add description to demo.


-module(demo).
-vsn(001).
-author({rockey}).
-purpose("example of erlang").

%% ====================================================================
%% API functions
%% ====================================================================
-export([find_sync/2,
         is_header/2,
         get_word/2,
         unpack_header/1,
         decode_header/1
            ]).

%% ====================================================================
%% 5.1 find_sync试图找到3个连贯的MPEG头帧，如果Bin的字节N是头帧的开始，返回{ok,Length,Info}
%% ====================================================================
find_sync(Bin,N) ->
    case is_header(N,Bin) of
        {ok,Len1,_} ->
            case is_header(N + Len1,Bin) of
                 {ok,Len2,_} ->
                        case is_header(N + Len1 +Len2,Bin) of
                             {ok,_,_} -> {ok,N};
                             error    -> find_sync(Bin, N +1)
                        end;
                 error      ->  find_sync(Bin,N + 1) 
            end;
        error      ->  find_sync(Bin,N + 1) 
    end.
            
is_header(N,Bin) ->
    unpack_header(get_word(N,Bin)).

get_word(N,Bin) ->
    {_,<<C:4/binary,_/binary>>} = split_binary(Bin,N),C.

unpack_header(X) ->
    try decode_header(X)
    catch 
        _:_ -> error
end.

%% ====================================================================
%% 5.2 解析MPEG头
%% ====================================================================
decode_header(<<2#11111111111:11,B:2,C:2,_D:1,E:4,F:2,G:1,Bits:9>>) ->
    Vsn = case B of
               0 -> {2,5};
               1 -> exit(badVsn);
               2 -> 2;
               3 -> 1
           end,
    Layer = case C of
                 0 -> exit(badLayer);
                 1 -> 3;
                 2 -> 2;
                 3 -> 1
            end,
    %% Protection = D,
    BitRate = bitrate(Vsn,Layer,E) * 1000,
    SampleRate = samplerate(Vsn,F),
    Padding = G,
    FrameLength = framelength(Layer,BitRate,SampleRate,Padding),
    if
        FrameLength < 21 ->
            exit(frameSize);
        true ->
            {ok,FrameLength,{Layer,BitRate,SampleRate,Vsn,Bits}}
    end;
decode_header(_) ->
    exit(badHeader).
































