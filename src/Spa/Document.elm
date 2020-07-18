module Spa.Document exposing
    ( Document
    , map
    , toBrowserDocument
    )

import Browser
import Element exposing (..)
import Html
import Html.Attributes


type alias Document msg =
    { title : String
    , body : List (Element msg)
    }


map : (msg1 -> msg2) -> Document msg1 -> Document msg2
map fn doc =
    { title = doc.title
    , body = List.map (Element.map fn) doc.body
    }


toBrowserDocument : Document msg -> Browser.Document msg
toBrowserDocument doc =
    { title = doc.title
    , body =
        [ Html.div
            [ Html.Attributes.id "elm" ]
            [ Html.node "style" [] [ Html.text css ]
            , Html.a [ Html.Attributes.class "skip-link", Html.Attributes.href "#main" ]
                [ Html.text "Skip to main" ]
            , Element.layout [ width fill, height fill ]
                (column [ width fill, height fill ] doc.body)
            ]
        ]
    }


css : String
css =
    """.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: #000000;
  color: white;
  padding: 8px;
  z-index: 100;
}

.skip-link:focus {
  top: 0;
} """
