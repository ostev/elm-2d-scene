module Render.Camera exposing
    ( Camera
    , dimensions
    , fromRecord
    , position
    )

import Render.Dimensions exposing (Dimensions)
import Render.Point as Point exposing (Point)


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
