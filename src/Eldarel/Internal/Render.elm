module Eldarel.Internal.Render exposing (makeCamera, makeProjection)

import Eldarel.Camera as Camera exposing (Camera)
import Eldarel.Dimensions as Dimensions exposing (Dimensions)
import Eldarel.Internal.Vertex as Vertex exposing (Vertex)
import Eldarel.Shape as Shape exposing (Shape)
import Math.Matrix4 as Mat4 exposing (Mat4)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import WebGL


makeProjection : Camera -> Mat4
makeProjection camera =
    let
        dimensions =
            Camera.getDimensions camera
    in
    Mat4.mul (makeCamera camera)
        (Mat4.makeOrtho
            0
            (Dimensions.getWidth dimensions)
            (Dimensions.getHeight dimensions)
            0
            -1
            -1
        )


makeCamera : Camera -> Mat4
makeCamera camera =
    Debug.todo "`makeCamera` not yet implemented"



-- toEntity : Camera -> Shape -> WebGL.Entity
-- toEntity camera shape =
--     WebGL.entity
