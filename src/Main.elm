port module Dockyard exposing (..)

{-| Dockyard Elm implementation

Implementation in the Elm Architecture.

Check out <http://guide.elm-lang.org/architecture/index.html> for more info.
-}

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Electron.WebView as WebView


main : Program (Maybe Model)
main =
    App.programWithFlags
        { init = init
        , view = view
        , update = (\msg model -> withSetStorage <| update msg model)
        , subscriptions = subscriptions
        }


port setStorage : Model -> Cmd msg


port focus : String -> Cmd msg


port startGame : GameState -> Cmd msg


{-| We want to `setStorage` on every update. This function adds the setStorage
command for every step of the update function.
-}
withSetStorage : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
withSetStorage ( model, cmds ) =
    ( model, Cmd.batch [ setStorage model, cmds ] )


{-| MODEL
-}


--| Model: The full application state of our app.

type alias Model =
    { gameState : GameState
    , test : Maybe String
    }


type alias GameState =
    { debuggerIsAttached : Bool
    , firstLoad : Bool
    , gameViewId : Maybe String
    }


type alias NetworkEvent =
    { path : String
    , error : Maybe String
    , headers : Maybe String
    , body : Maybe String
    , postBody : Maybe String
    }


emptyModel : Model
emptyModel =
    { gameState = { firstLoad = True
                  , debuggerIsAttached = False
                  , gameViewId = Nothing
                  }
    , test = Nothing
    }


init : Maybe Model -> ( Model, Cmd Msg )
init savedModel =
    Maybe.withDefault emptyModel savedModel ! [ startGame emptyModel.gameState ]



{-| UPDATE
-}


type Msg
    = NoOp
    | Initialize
    | Test String
    | HandleNetworkEvent NetworkEvent


-- State management

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Initialize ->
            model ! []

        Test x ->
            { model
                | test = Just x
                } ! []

        HandleNetworkEvent event ->
            model ! []

        _ ->
            model ! []


{-| SUBSCRIPTIONS
-}

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ handleEvent HandleNetworkEvent
        , testEvent Test
        ]


port handleEvent : (NetworkEvent -> msg) -> Sub msg


port testEvent : (String -> msg) -> Sub msg


{-| VIEW
-}

view : Model -> Html Msg
view model =
    div
        [ class "dockyard-wrapper"
        , style [ ( "visibility", "hidden" ) ]
        ]
        [ p [] [ text (toString model.test) ]
        , section
            []
            [ WebView.webview
                [ id "gameview"
                , src gameUrl
                , attribute "nodeintegration" "nodeintegration"
                , attribute "plugins" "plugins"
                , attribute "partition" "persist:dockyard-elm"
                ]
                []
            ]
        , infoFooter
        ]


infoFooter : Html msg
infoFooter =
    footer
        [ id "info" ]
        [ p []
            [ a [ href "https://github.com/rensouhou" ]
                [ text "Rensouhou" ]
            , text " 2016"
            ]
        ]


gameUrl : String
gameUrl =
    "http://www.google.com"
    -- "http://www.dmm.com/netgame/social/-/gadgets/=/app_id=854854/"
