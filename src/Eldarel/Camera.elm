module Eldarel.Camera exposing (Camera, fromRecord, getDimensions)

import Eldarel.Dimensions exposing (Dimensions)
import Eldarel.Point as Point exposing (Point)


type Camera
    = Camera
        { dimensions : Dimensions
        , position : Point
        }


fromRecord : { dimensions : Dimensions, position : Point } -> Camera
fromRecord =
    Camera

getDimensions : Camera -> Dimensions
getDimensions (Camera {dimensions}) = dimensions
