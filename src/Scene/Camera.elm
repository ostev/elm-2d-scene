module Scene.Camera exposing
    ( Camera
    , dimensions
    , fromRecord
    , position
    , setDimensions
    , setPosition
    , setX
    , setY
    )

import Scene.Dimensions exposing (Dimensions)
import Scene.Point as Point exposing (Point)


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


setPosition : Point -> Camera -> Camera
setPosition newPosition (Camera internals) =
    Camera { internals | position = newPosition }


setDimensions : Dimensions -> Camera -> Camera
setDimensions newDimensions (Camera internals) =
    Camera { internals | dimensions = newDimensions }


setX : Float -> Camera -> Camera
setX newX camera =
    setPosition (Point.fromXY newX (Point.getY <| position camera)) camera


setY : Float -> Camera -> Camera
setY newY camera =
    setPosition (Point.fromXY (Point.getX <| position camera) newY) camera
