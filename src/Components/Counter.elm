module Components.Counter exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input


buttonAttrs : Color -> Color -> List (Attribute msg)
buttonAttrs bgColor fgColor =
    [ Border.rounded 60
    , Background.color bgColor
    , Font.color fgColor
    , Font.size 30
    , padding 30
    ]


view :
    { bgColor : Color
    , count : Int
    , fgColor : Color
    , msgDecrement : msg
    , msgIncrement : msg
    }
    -> Element msg
view args =
    column
        [ Background.color args.bgColor
        , Border.rounded 60
        , padding 30
        ]
        [ row
            [ spacing 20
            , width <| minimum 240 fill
            ]
            [ Input.button (buttonAttrs args.fgColor args.bgColor)
                { label = text "+1"
                , onPress = Just args.msgIncrement
                }
            , Input.button (alignRight :: buttonAttrs args.fgColor args.bgColor)
                { label = text "-1"
                , onPress = Just args.msgDecrement
                }
            ]
        , el
            [ Font.size 200
            , centerX
            ]
          <|
            text <|
                String.fromInt args.count
        ]
