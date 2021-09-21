module Rectangle exposing (main)

import Browser
import Scene2d.Shape as Shape
import Scene2d
import Scene2d.Dimensions as Dimensions exposing (Dimensions, dimensions)
import Scene2d.Point as Point exposing (Point, point)
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
    Scene2d.toHtml [] [Shape.rectangle (dimensions 50 50) (point 0 0)]
