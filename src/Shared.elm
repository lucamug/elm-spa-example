module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
    , subscriptions
    , update
    , view
    )

import Browser.Navigation exposing (Key)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route
import Url exposing (Url)



-- INIT


type alias Flags =
    ()


type alias Model =
    { url : Url
    , key : Key
    }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model url key
    , Cmd.none
    )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


buttonAttrs : List (Attribute msg)
buttonAttrs =
    [ Border.widthEach { bottom = 2, left = 0, right = 0, top = 0 }
    , Border.color <| rgba 0 0 0 0.2
    , padding 6
    , alignRight
    ]


linkAttrs : List (Attr decorative msg)
linkAttrs =
    [ Font.color <| rgb 1 1 1 ]


view :
    { page : Document msg, toMsg : Msg -> msg }
    -> Model
    -> Document msg
view { page, toMsg } model =
    let
        _ =
            Debug.log "view" ()
    in
    { title = page.title
    , body =
        [ column
            [ spacing 30
            , width fill
            , Background.color <| rgb255 116 222 165
            ]
            [ el
                [ padding 20
                , width fill
                , Background.color <| rgb255 38 104 69
                ]
              <|
                wrappedRow
                    [ Font.color <| rgba 1 1 1 0.9
                    , width fill
                    , spacing 20
                    ]
                    [ el [ width <| px 100, height <| px 100 ] <| image [ width fill ] { description = "Logo", src = "/icons/512.png" }
                    , column [ width fill, spacing 10 ]
                        [ el [ Font.size 32, width fill ] <| text "elm-spa-example"
                        , paragraph [ Font.size 16 ]
                            [ text "Built with "
                            , link linkAttrs { label = text "elm-spa", url = "https://www.elm-spa.dev/" }
                            , text " and "
                            , link linkAttrs { label = text "elm-starter", url = "https://github.com/lucamug/elm-starter" }
                            , text "."
                            ]
                        ]
                    , wrappedRow [ spacing 20, width fill ]
                        [ link buttonAttrs { url = Route.toString Route.Top, label = text "Top" }
                        , link buttonAttrs { url = Route.toString Route.PageA, label = text "Page A" }
                        , link buttonAttrs { url = Route.toString Route.PageB, label = text "Page B" }
                        ]
                    ]
            , column
                [ height fill
                , spacing 15
                , paddingEach { top = 0, right = 30, bottom = 300, left = 30 }
                ]
                page.body
            ]
        ]
    }
