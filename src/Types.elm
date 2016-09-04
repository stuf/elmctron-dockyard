module Types exposing
    ( Model
    , AppState
    , NetworkEvent

    , emptyModel
    , emptyAppState
    )

{-| MODEL
-}


--| Model: The full application state of our app.

type alias Model =
    { app : AppState
    , test : Maybe String
    }


{-| Application state
-}

type alias AppState =
    { debuggerIsAttached : Bool
    , firstLoad : Bool
    , gameViewId : Maybe String
    }


-- Application state default

emptyAppState : AppState
emptyAppState =
    { debuggerIsAttached = False
    , firstLoad = True
    , gameViewId = Nothing
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

