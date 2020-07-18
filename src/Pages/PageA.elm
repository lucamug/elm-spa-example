module Pages.PageA exposing (Model, Msg, Params, page)

import Element exposing (..)
import Element.Font as Font
import Html
import Html.Attributes
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.static
        { view = view
        }


type alias Model =
    Url Params


type alias Msg =
    Never



-- VIEW


type alias Params =
    ()


view : Url Params -> Document Msg
view { params } =
    { title = "PageA"
    , body =
        [ el [ Font.size 32 ] <| text "Page A"
        , el [ Font.size 16 ] <| html <| Html.pre [ Html.Attributes.style "line-height" "26px" ] [ Html.text """
Inferno: Canto I


Midway upon the journey of our life
  I found myself within a forest dark,
  For the straightforward pathway had been lost.

Ah me! how hard a thing it is to say
  What was this forest savage, rough, and stern,
  Which in the very thought renews the fear.

So bitter is it, death is little more;
  But of the good to treat, which there I found,
  Speak will I of the other things I saw there.

I cannot well repeat how there I entered,
  So full was I of slumber at the moment
  In which I had abandoned the true way.

But after I had reached a mountain's foot,
  At that point where the valley terminated,
  Which had with consternation pierced my heart,

Upward I looked, and I beheld its shoulders,
  Vested already with that planet's rays
  Which leadeth others right by every road.
""" ]
        ]
    }
