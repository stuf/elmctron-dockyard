port module Ports exposing
    ( startApp
    , debuggerCmdRes
    , debuggerAttach
    , debuggerLog

    , handleBrowserNetworkEvent
    , debuggerCmd
    , debuggerState
    , attachDebugger
    , reqWillBeSent
    , resReceived
    , netLoadFinished
    )


import Types exposing (AppState, PortEvent, DebuggerCmd)


{-| Outgoing ports -}

port startApp : AppState -> Cmd a
port debuggerCmdRes : String -> Cmd a
port debuggerAttach : String -> Cmd a
port debuggerLog : Maybe String -> Cmd a


{-| Incoming ports -}

port handleBrowserNetworkEvent : (PortEvent -> a) -> Sub a
port debuggerCmd : (DebuggerCmd -> a) -> Sub a
port debuggerState : (Bool -> a) -> Sub a
port attachDebugger : (String -> a) -> Sub a


port reqWillBeSent : ({ requestId : String } -> a) -> Sub a
port resReceived : ({ requestId : String } -> a) -> Sub a
port netLoadFinished : ({ requestId : String } -> a) -> Sub a
