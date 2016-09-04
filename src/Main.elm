module Dockyard exposing (main)

{-| Dockyard Elm implementation

Implementation in the Elm Architecture.

Check out <http://guide.elm-lang.org/architecture/index.html> for more info.
-}

import Html.App as Application
import App.Types exposing (Model)
import App.State exposing (init, subscriptions, update, withSetStorage)
import App.View exposing (view)


main : Program (Maybe Model)
main =
    Application.programWithFlags
        { init = init
        , view = view
        , update = (\msg model -> withSetStorage <| update msg model)
        , subscriptions = subscriptions
        }

