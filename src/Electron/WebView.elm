module Electron.WebView exposing
    ( webview
    )

import Html exposing (Attribute, Html, node)
-- import Html.Attributes exposing (attribute)


webview : List (Attribute msg) -> List (Html msg) -> Html msg
webview =
    node "webview"

