module Scene2d exposing (toHtml)

import Html exposing (Html)
import Html.Attributes
import Internal.Render
import Math.Matrix4 as Mat4 exposing (Mat4)
import Scene2d.Camera as Camera exposing (Camera)
import Scene2d.Dimensions as Dimensions exposing (Dimensions)
import Scene2d.Point as Point exposing (Point)
import Scene2d.Shape as Shape exposing (Shape)
import WebGL


toHtml : Camera -> List (Html.Attribute msg) -> List Shape -> Html msg
toHtml camera _ shapes =
    WebGL.toHtml
        [ Html.Attributes.style "display" "block"
        , Html.Attributes.style "margin" "1rem"
        , Html.Attributes.style "border" "solid 1px"
        , Html.Attributes.width
            ((Dimensions.width <| Camera.dimensions camera)
                |> truncate
            )
        , Html.Attributes.height
            ((Dimensions.height <| Camera.dimensions camera)
                |> truncate
            )
        ]
        (List.map
            (Internal.Render.shapeToEntity
                (Internal.Render.makeViewProjection camera)
            )
            shapes
        )
