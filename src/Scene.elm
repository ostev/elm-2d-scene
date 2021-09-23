module Scene exposing (Scene, fromRecord, toHtml)

import Html exposing (Html)
import Html.Attributes
import Internal.Render
import Math.Matrix4 as Mat4 exposing (Mat4)
import Scene.Camera as Camera exposing (Camera)
import Scene.Dimensions as Dimensions exposing (Dimensions)
import Scene.Point as Point exposing (Point)
import Scene.Shape as Shape exposing (Shape)
import WebGL


type Scene msg
    = Scene
        { camera : Camera
        , content : List (Shape msg)
        }


fromRecord : { camera : Camera, content : List (Shape msg) } -> Scene msg
fromRecord =
    Scene


toHtml : List (Html.Attribute msg) -> Scene msg -> Html msg
toHtml htmlAttributes (Scene { camera, content }) =
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
            content
        )
