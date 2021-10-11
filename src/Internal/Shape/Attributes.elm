module Internal.Shape.Attributes exposing (default)

import Internal.Shape
import Scene.Point as Point exposing (Point)
import Scene.Angle as Angle exposing (Angle)

default : Internal.Shape.Attributes
default = {
        translation = Point.fromXY 0 0,
        rotation = Angle.radians 0,
        scale = {x=1,y=1}
    }
