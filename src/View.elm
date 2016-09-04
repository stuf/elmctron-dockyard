module View exposing (view)


import Html exposing (..)
import Html.Attributes exposing (..)
import Types
import Electron.WebView as WebView


{-| VIEW
-}

view : Types.Model -> Html msg
view model =
    div
        [ class "dockyard-wrapper"
        , style [ ( "visibility", "hidden" ) ]
        ]
        [ p [] [ text (toString model.test) ]
        , section
            []
            [ WebView.webview
                [ id "game-view"
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

