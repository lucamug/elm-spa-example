module Pages.Top exposing (Model, Msg, Params, page)

import Components.Counter
import Element exposing (..)
import Element.Font as Font
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


view : Model -> Document Msg
view model =
    { title = "Top"
    , body =
        [ el [ Font.size 32 ] <| text "Top"
        , text "Here is a counter:"
        , el [ paddingXY 0 20 ] <|
            Components.Counter.view
                { bgColor = rgb255 198 50 116
                , count = model.count
                , fgColor = rgb255 0 0 0
                , msgDecrement = Decrement
                , msgIncrement = Increment
                }
        ]
    }
