module Pages.PageB exposing (Model, Msg, Params, page)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , save = save
        , load = load
        }



-- INIT


type alias Params =
    ()


type alias Model =
    { count : Int }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { count = 0 }, Cmd.none )



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


color : { black : Color, cyan : Color }
color =
    { black = rgb255 0 0 0
    , cyan = rgb255 127 209 185
    }


buttonAttrs : List (Attribute msg)
buttonAttrs =
    [ Border.rounded 60
    , Background.color color.black
    , Font.color color.cyan
    , Font.size 30
    , padding 30
    ]


view : Model -> Document Msg
view model =
    { title = "PageB"
    , body =
        [ text "Page B"
        , el [ paddingXY 0 20 ] <|
            column
                [ Background.color color.cyan
                , Border.rounded 60
                , padding 30
                ]
                [ row
                    [ spacing 20
                    , width <| minimum 240 fill
                    ]
                    [ Input.button buttonAttrs
                        { label = text "+1"
                        , onPress = Just Increment
                        }
                    , Input.button (alignRight :: buttonAttrs)
                        { label = text "-1"
                        , onPress = Just Decrement
                        }
                    ]
                , el
                    [ Font.size 200
                    , centerX
                    ]
                  <|
                    text <|
                        String.fromInt model.count
                ]
        ]
    }
