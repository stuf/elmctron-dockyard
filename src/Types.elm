module Types exposing
    ( Model
    , AppState
    , NetworkEvent

    , emptyModel
    )

{-| MODEL
-}


--| Model: The full application state of our app.

type alias Model =
    { app : AppState
    , test : Maybe String
    }


type alias AppState =
    { debuggerIsAttached : Bool
    , firstLoad : Bool
    , gameViewId : Maybe String
    }


{-| Network event type
-} 

type alias NetworkEvent =
    { path : String
    , headers : Maybe (List (String, String))
    , body : Maybe String
    , postBody : Maybe String
    }


emptyModel : Model
emptyModel =
    { app = { firstLoad = True
            , debuggerIsAttached = False
            , gameViewId = Nothing
            }
    , test = Nothing
    }

