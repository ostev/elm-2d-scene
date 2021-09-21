module Scene2d.Camera exposing
    ( Camera
    , dimensions
    , fromRecord
    , position
    )

import Scene2d.Dimensions exposing (Dimensions)
import Scene2d.Point as Point exposing (Point)


{-| Represents a camera in two-dimensional
space.
-}
type Camera
    = Camera
        { dimensions : Dimensions
        , position : Point
        }


fromRecord : { dimensions : Dimensions, position : Point } -> Camera
fromRecord =
    Camera


dimensions : Camera -> Dimensions
dimensions (Camera internals) =
    internals.dimensions


position : Camera -> Point
position (Camera internals) =
    internals.position
