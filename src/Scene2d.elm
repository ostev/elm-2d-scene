module Scene2d exposing (toHtml)

import Html exposing (Html, div)
import Html.Attributes exposing (height, style, width)
import Internal.Render
import Math.Matrix4 as Mat4 exposing (Mat4)
import Scene2d.Shape as Shape exposing (Shape)
import Scene2d.Point as Point exposing (Point, point)
import Scene2d.Dimensions as Dimensions exposing (Dimensions,
    dimensions)
import Scene2d.Camera as Camera exposing (Camera)
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
