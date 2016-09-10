module Network exposing
    ( Action
    , State

    , emptyState
    , update

    , actionForMethod
    )

{-| Handling networking events originating from the Chrome debugger.

# Types
@docs Action, State

# Utility
@docs actionForMethod

# State
@docs update, emptyState

-}

import Json.Encode

type alias RequestId = String


{-|-}
type alias IncomingEvent =
    { requestId : String
    , method : String
    , content: Json.Encode.Value
    }


{-| Represents an a network event sent from an external port.
-}
type Action
    = Default IncomingEvent
    | RequestWillBeSent IncomingEvent
    | ResponseReceived IncomingEvent
    | LoadingFinished IncomingEvent


{- State -}

{-|-}
type alias State =
    { events : List String
    }


{-|-}
emptyState : State
emptyState =
    { events = []
    }


{- Event -}

{-|-}
type alias Event =
    { requestId : String
    , url : Maybe String
    , body : Maybe String
    , postBody : Maybe String
    }

{- Update -}

{-|-}
update : Action -> State -> State
update action state =
    case action of
        {- Take data from `requestId`, `documentURL` and `request` -}
        RequestWillBeSent { requestId } ->
            state

        ResponseReceived { requestId } ->
            state

        LoadingFinished { requestId } ->
            state

        _ ->
            state


{-| Find an action for a method name -}
actionForMethod : String -> IncomingEvent -> Action
actionForMethod method =
    case method of
        "Network.requestWillBeSent" ->
            RequestWillBeSent

        "Network.responseReceived" ->
            ResponseReceived

        "Network.loadingFinished" ->
            LoadingFinished

        _ ->
            Default
