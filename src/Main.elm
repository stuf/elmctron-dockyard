module Dockyard exposing (main)

{-| Dockyard Elm implementation

Implementation in the Elm Architecture.

Check out <http://guide.elm-lang.org/architecture/index.html> for more info.
-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Application
import List


import Types exposing (State, AppState, DebuggerCmd, PortEvent)
import Ports exposing (..)
import Network


main : Program (Maybe State)
main =
    Application.programWithFlags
        { init = init
        , view = view
        --, update = (\msg model -> withSetStorage <| update msg model)
        , update = update
        , subscriptions = subscriptions
        }


{-| MODEL -}

init : Maybe State -> ( State, Cmd Msg )
init state =
    let
        state' = state |> Maybe.withDefault emptyState
    in
        state' ! [ startApp state'.app ]


emptyState : State
emptyState =
    { app =
        { firstLoad = True
        , debugger = False
        , webviewId = Just "game-view"
        }
    , network = Network.emptyState
    }


{-| UPDATE -}

-- | Actions

type Msg
    = NoOp
    | BrowserNetworkEvent PortEvent



-- | Update

update : Msg -> State -> (State, Cmd a)
update msg state =
    case msg of
        BrowserNetworkEvent { requestId, method, content } ->
            let
                action = Network.actionForMethod method
            in
                { state | network = Network.update action state.network } ! []

        _ ->
            state ! []



{- Subscriptions -}

subscriptions : State -> Sub Msg
subscriptions state =
    Sub.batch
        [ handleBrowserNetworkEvent BrowserNetworkEvent
        ]


{-| VIEW -}

view : State -> Html a
view state =
    section
        [ class "main"
        ]
        [ viewBody
        , div
            []
            <| viewEventItems state
        , viewFooter
        ]


eventItem : (String, String, String) -> Html a
eventItem (t, u, v) =
    li
        []
        [ text t, text u, text v ]


viewEventItems : State -> List (Html a)
viewEventItems s =
    List.map (\x -> text <| toString x) s.events


viewHeader : State -> Html a
viewHeader state =
    header []
        [ h3 [] [ text "Webview test" ]
        ]


viewBody : Html a
viewBody =
    article []
        [ node "webview"
            [ id "game-view"
            , src "https://www.google.com"
            -- , src "http://www.dmm.com/netgame/social/-/gadgets/=/app_id=854854/"
            , attribute "nodeintegration" "nodeintegration"
            , attribute "plugins" "plugins"
            , attribute "partition" "persist:dockyard-elm"
            ] []
        ]


viewFooter : Html a
viewFooter =
    footer []
        [ text "This is a test" ]
