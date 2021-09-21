module Render exposing (toHtml)

import Html exposing (Html, div)
import Html.Attributes exposing (height, style, width)
import Internal.Render
import Math.Matrix4 as Mat4 exposing (Mat4)
import Render.Shape as Shape exposing (Shape)
import Render.Point as Point exposing (Point, point)
import Render.Dimensions as Dimensions exposing (Dimensions,
    dimensions)
import Render.Camera as Camera exposing (Camera)
import WebGL


toHtml : List () -> List Shape -> Html msg
toHtml _ shapes =
    WebGL.toHtml
        [ width 400
        , height 400
        , Html.Attributes.style "display" "block"
        , Html.Attributes.style "margin" "1rem"
        , Html.Attributes.style "border" "solid 1px"
        ]
        (List.map
            (Internal.Render.shapeToEntity (
                Internal.Render.makeViewProjection (
                     Camera.fromRecord {
                        dimensions = dimensions 400 400,
                        position = point 0 0

                     }
                    )
                ))
            shapes
        )
