module State exposing (init, update, withSetStorage, subscriptions)

import Types exposing (Model, NetworkEvent)
import Ports exposing (handleEvent, testEvent, setStorage)


init : Maybe Model -> ( Model, Cmd Msg )
init savedModel =
    Maybe.withDefault Types.emptyModel savedModel ! []


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
            model ! [  ]

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



