port module Ports exposing (..)


import Types exposing (Model, AppState)


{-|-}
port setStorage : Model -> Cmd msg


{-|-}
port focus : String -> Cmd msg


{-|-}
port startApp : AppState -> Cmd msg


{-| Sets up the appropriate ports to the game's `webview` element
-}
port setGameView : String -> Cmd msg



{-| SUBSCRIPTIONS
-}

port handleEvent : (Types.NetworkEvent -> msg) -> Sub msg


port testEvent : (String -> msg) -> Sub msg



