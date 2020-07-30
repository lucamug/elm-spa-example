module Pages.PageB exposing (Model, Msg, Params, page)

import Components.Counter
import Element exposing (..)
import Element.Font as Font
import Element.Lazy
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


lazy : Bool
lazy =
    False


subView : Model -> Element Msg
subView model =
    let
        _ =
            Debug.log "view PageB" ()
    in
    el [ paddingXY 0 20 ] <|
        Components.Counter.view
            { bgColor = rgb255 65 169 208
            , count = model.count
            , fgColor = rgb255 0 0 0
            , msgDecrement = Decrement
            , msgIncrement = Increment
            }


view : Model -> Document Msg
view model =
    { title = "PageB"
    , body =
        [ el [ Font.size 32 ] <| text "Page B"
        , text "Another counter:"
        , if lazy then
            Element.Lazy.lazy subView model

          else
            subView model
        ]
    }
