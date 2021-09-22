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
toHtml camera htmlAttributes shapes =
    WebGL.toHtml
        ([ Html.Attributes.width
            ((Dimensions.width <| Camera.dimensions camera)
                |> truncate
            )
         , Html.Attributes.height
            ((Dimensions.height <| Camera.dimensions camera)
                |> truncate
            )
         ]
            ++ htmlAttributes
        )
        (List.map
            (Internal.Render.shapeToEntity
                (Internal.Render.makeViewProjection camera)
            )
            shapes
        )
