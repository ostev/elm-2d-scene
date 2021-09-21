module Rectangle exposing (main)

import Browser
import Render.Shape as Shape
import Render
import Render.Dimensions as Dimensions exposing (Dimensions, dimensions)
import Render.Point as Point exposing (Point, point)
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
    Render.toHtml [] [Shape.rectangle (dimensions 50 50) (point 0 0)]
