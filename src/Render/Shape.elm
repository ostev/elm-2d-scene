module Render.Shape exposing
    ( Shape
    , image
    , rectangle
    , textured
    , triangle
    , triangles
    )

import Internal.Shape
import Internal.Vertex as Vertex exposing (Vertex)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Render.Dimensions as Dimensions exposing (Dimensions)
import Render.Point as Point exposing (Point, point)
import Render.Texture exposing (Texture)


type alias Shape =
    Internal.Shape.Shape


tupleMapThree : (a -> b) -> ( a, a, a ) -> ( b, b, b )
tupleMapThree f ( x, y, z ) =
    ( f x, f y, f z )


triangles : List ( Point, Point, Point ) -> Shape
triangles positions =
    positions
        |> List.map (tupleMapThree Vertex.fromPoint)
        |> Internal.Shape.Triangles


triangle : Point -> Point -> Point -> Shape
triangle a b c =
    triangles [ ( a, b, c ) ]


rectangle : Dimensions -> Point -> Shape
rectangle dimensions position =
    let
        x1 =
            Point.first position

        x2 =
            x1 + Dimensions.width dimensions

        y1 =
            Point.second position

        y2 =
            y1 + Dimensions.height dimensions
    in
    triangles
        [ ( point x1 y1
          , point x2 y1
          , point x1 y2
          )
        , ( point x1 y2
          , point x2 y1
          , point x2 y2
          )
        ]


image : Texture -> Point -> Shape
image texture position =
    Debug.todo "`image` not yet implemented."


textured : Texture -> Shape -> Shape
textured =
    Debug.todo "Textures not implemented yet"
