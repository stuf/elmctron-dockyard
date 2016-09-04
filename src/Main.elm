module Dockyard exposing (..)

{-| Dockyard Elm implementation

Implementation in the Elm Architecture.

Check out <http://guide.elm-lang.org/architecture/index.html> for more info.
-}

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Electron.WebView as WebView
import Types exposing (..)
import State exposing (init, subscriptions, update, withSetStorage)
import View exposing (view)


main : Program (Maybe Model)
main =
    App.programWithFlags
        { init = init
        , view = view
        , update = (\msg model -> withSetStorage <| update msg model)
        , subscriptions = subscriptions
        }

