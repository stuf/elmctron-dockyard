module Types exposing
    ( State
    , AppState
    , PortEvent
    , DebuggerCmd
    )


import Network


{-| State -}

type alias State =
    { app : AppState
    , network : Network.State
    }


{-| Application state -}

type alias AppState =
    { firstLoad : Bool
    , debugger : Bool
    , webviewId : Maybe String
    }


{-| Port events -}

type alias PortEvent =
    { requestId : String
    , method : String
    , content : Maybe String
    }


type alias DebuggerCmd =
    { cmd : String
    , msg : Maybe String
    }
