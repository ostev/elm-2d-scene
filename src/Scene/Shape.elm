module Scene.Shape exposing
    ( Shape
    , image
    , quad
    , rectangle
    , rotate
    , scale
    , triangle
    )

import Color exposing (Color)
import Html.Attributes exposing (type_)
import Internal.Shape
import Internal.Shape.Attributes
import Internal.Vertex as Vertex exposing (Vertex)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Scene.Angle as Angle exposing (Angle)
import Scene.Dimensions as Dimensions exposing (Dimensions)
import Scene.Point as Point exposing (Point)
import Scene.Texture exposing (Texture)


type alias Shape =
    Internal.Shape.Shape


tupleMapThree : (a -> b) -> ( a, a, a ) -> ( b, b, b )
tupleMapThree f ( x, y, z ) =
    ( f x, f y, f z )


triangles : List ( Point, Point, Point ) -> Shape
triangles =
    Internal.Shape.Triangles
        >> Internal.Shape.Basic Color.black
        >> Internal.Shape.Shape
            Internal.Shape.Attributes.default


triangle : Point -> Point -> Point -> Shape
triangle a b c =
    triangles [ ( a, b, c ) ]


quad : Point -> Point -> Point -> Point -> Shape
quad topLeft topRight bottomLeft bottomRight =
    triangles
        [ ( topLeft
          , bottomLeft
          , topRight
          )
        , ( bottomLeft
          , topRight
          , bottomRight
          )
        ]


rectangle : Dimensions -> Point -> Shape
rectangle size position =
    let
        x1 =
            Point.getX position

        x2 =
            x1 + Dimensions.width size

        y1 =
            Point.getY position

        y2 =
            y1 + Dimensions.height size
    in
    quad
        (Point.fromXY x1 y1)
        (Point.fromXY x2 y1)
        (Point.fromXY x1 y2)
        (Point.fromXY x2 y2)


image : Texture -> Point -> Shape
image texture =
    Internal.Shape.Image texture
        >> Internal.Shape.Shape
            Internal.Shape.Attributes.default


translate : Point -> Shape -> Shape
translate point (Internal.Shape.Shape attributes shapeType) =
    Internal.Shape.Shape
        { attributes | translation = Point.add attributes.translation point }
        shapeType


rotate : Angle -> Shape -> Shape
rotate angle (Internal.Shape.Shape attributes shapeType) =
    Internal.Shape.Shape
        { attributes | rotation = Angle.add attributes.rotation angle }
        shapeType


scale : Float -> Float -> Shape -> Shape
scale scaleX scaleY (Internal.Shape.Shape attributes shapeType) =
    Internal.Shape.Shape
        { attributes
            | scale =
                { x = scaleX * attributes.scale.x
                , y = scaleY * attributes.scale.y
                }
        }
        shapeType
