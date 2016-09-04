module State exposing
    ( init
    , update
    , subscriptions
    
    , withSetStorage
    )

import Types exposing (Model, NetworkEvent, emptyAppState, emptyModel)
import Ports exposing (handleEvent, testEvent, setStorage, startApp)


init : Maybe Model -> ( Model, Cmd Msg )
init savedModel =
    Maybe.withDefault Types.emptyModel savedModel 
        ! [ startApp { emptyAppState | gameViewId = Just "game-view" } ]


{-| UPDATE
-}

type Msg
    = NoOp
    | Initialize String
    | Test String
    | HandleNetworkEvent NetworkEvent


-- State management

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Initialize id ->
            model ! [ startApp { emptyAppState | gameViewId = Just "game-view" } ]

        Test x ->
            { model
                | test = Just x
                } ! []

        HandleNetworkEvent event ->
            model ! []

        _ ->
            model ! []


{-| We want to `setStorage` on every update. This function adds the setStorage
command for every step of the update function.
-}
withSetStorage : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
withSetStorage ( model, cmds ) =
    ( model, Cmd.batch [ setStorage model, cmds ] )



{-| SUBSCRIPTIONS
-}

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ handleEvent HandleNetworkEvent
        , testEvent Test
        ]



