module Render exposing (toHtml)

import Render.Shape as Shape exposing (Shape)
import Html exposing (Html, div)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)


toHtml : List () -> List Shape -> Html msg
toHtml _ _ =
    div [] []
