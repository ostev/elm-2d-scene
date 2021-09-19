module TopDown exposing (main)

import Browser
import Eldarel.Shape as Shape
import Eldarel
import Html exposing (Html, button, div, text)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)

main =
    Browser.sandbox
        { init = {}
        , update = update
        , view = view
        }


type alias Model =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update _ =
    identity


view : Model -> Html Msg
view model =
    Eldarel.toHtml [] [Shape.rectangle (50,50) (vec2 0 0)]
