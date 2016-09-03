port module Todo exposing (..)

{-| Dockyard Elm implementation

Implementation in the Elm Architecture.

Check out <http://guide.elm-lang.org/architecture/index.html> for more info.
-}

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)
import Json.Decode as Json
import Json.Encode exposing (string)
import String
import Dockyard exposing (view)
import Electron.WebView as WebView


main : Program (Maybe Model)
main =
    App.programWithFlags
        { init = init
        , view = view
        , update = (\msg model -> withSetStorage (update msg model))
        , subscriptions = \_ -> Sub.none
        }


port setStorage : Model -> Cmd msg


port focus : String -> Cmd msg


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
    { tasks : List String
    , field : String
    , uid : Int
    , visibility : String
    }


emptyModel : Model
emptyModel =
    { tasks = []
    , visibility = "All"
    , field = ""
    , uid = 0
    }


{-
newTask : String -> Int -> Task
newTask desc id =
    { description = desc
    , completed = False
    , editing = False
    , id = id
    }
-}


init : Maybe Model -> ( Model, Cmd Msg )
init savedModel =
    Maybe.withDefault emptyModel savedModel ! []



{-| UPDATE
-}


type Msg
    = NoOp
    | Initialize


-- State management

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Initialize ->
            model ! []

        _ ->
            model ! []


-- VIEW

view : Model -> Html Msg
view model =
    div
        [ class "dockyard-wrapper"
        , style [ ( "visibility", "hidden" ) ]
        ]
        [ section
            []
            [ WebView.webview
                [ src "http://www.google.com"
                , attribute "nodeintegration" (toString True)
                , attribute "plugins" (toString True)
                , attribute "partition" (toString "persist:dockyard-elm")
                , attribute "persist" (toString "kek")
                ]
                []
            ]
        , infoFooter
        ]


infoFooter : Html msg
infoFooter =
    footer [ id "info" ]
        [ p []
            [ a [ href "https://github.com/rensouhou" ]
                [ text "Rensouhou" ]
            , text " 2016"
            ]
        ]