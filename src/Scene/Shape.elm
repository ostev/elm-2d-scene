module Scene.Shape exposing
    ( Shape
    , image
    , quad
    , rectangle
    , triangle
    )

import Color exposing (Color)
import Internal.Shape
import Internal.Vertex as Vertex exposing (Vertex)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Scene.Dimensions as Dimensions exposing (Dimensions)
import Scene.Point as Point exposing (Point)
import Scene.Texture exposing (Texture)


type alias Kind =
    Internal.Shape.Kind


type alias Shape msg =
    Internal.Shape.Shape msg


tupleMapThree : (a -> b) -> ( a, a, a ) -> ( b, b, b )
tupleMapThree f ( x, y, z ) =
    ( f x, f y, f z )


triangles : List ( Point, Point, Point ) -> Shape msg
triangles =
    Internal.Shape.Triangles
        >> Internal.Shape.Shape Color.black


triangle : Point -> Point -> Point -> Shape msg
triangle a b c =
    triangles [ ( a, b, c ) ]


quad : Point -> Point -> Point -> Point -> Shape msg
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


rectangle : Dimensions -> Point -> Shape msg
rectangle size position =
    let
        x1 =
            Point.first position

        x2 =
            x1 + Dimensions.width size

        y1 =
            Point.second position

        y2 =
            y1 + Dimensions.height size
    in
    quad
        (Point.fromXY x1 y1)
        (Point.fromXY x2 y1)
        (Point.fromXY x1 y2)
        (Point.fromXY x2 y2)


image : Texture -> Point -> Shape msg
image =
    Internal.Shape.Image
