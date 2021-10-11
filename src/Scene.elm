module Scene exposing (Scene, fromRecord, toHtml)

import Html exposing (Html)
import Html.Attributes
import Internal.Render
import Scene.Camera as Camera exposing (Camera)
import Scene.Dimensions as Dimensions
import Scene.Shape exposing (Shape)
import WebGL


type Scene
    = Scene
        { camera : Camera
        , content : List Shape
        }


fromRecord : { camera : Camera, content : List Shape } -> Scene
fromRecord =
    Scene


toHtml : List (Html.Attribute msg) -> Scene -> Html msg
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
