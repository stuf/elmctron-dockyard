module Electron.WebView exposing
    ( webview
    , nodeintegration
    )

import Html exposing (Attribute, Html, node)
import Html.Attributes exposing (attribute)


{-| Implement the `webview` tag
-}

webview : List (Attribute msg) -> List (Html msg) -> Html msg
webview =
    node "webview"


{-| Electron-specific attributes
-}

nodeintegration : String -> Attribute msg
nodeintegration enabled =
    attribute "nodeintegration" enabled
