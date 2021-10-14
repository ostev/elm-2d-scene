module Internal.Shape.Attributes exposing (default)

import Internal.Shape
import Scene.Angle as Angle exposing (Angle)
import Scene.Point as Point exposing (Point)


default : Internal.Shape.Attributes
default =
    { translation = Point.fromXY 0 0
    , rotation = Angle.degrees 0
    , scale = { x = 1, y = 1 }
    }
