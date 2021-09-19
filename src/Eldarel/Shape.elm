module Eldarel.Shape exposing
    ( Shape
    , rectangle
    , textured
    , triangle
    , triangles
    )

import Eldarel.Dimensions as Dimensions exposing (Dimensions)
import Eldarel.Internal.Render as Render exposing (Vertex)
import Eldarel.Point as Point exposing (Point, point)
import Eldarel.Texture exposing (Texture)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)


type Shape
    = Vertices (List ( Vertex, Vertex, Vertex ))
    | Textured Texture Shape


tupleMapThree : (a -> b) -> ( a, a, a ) -> ( b, b, b )
tupleMapThree f ( x, y, z ) =
    ( f x, f y, f z )


triangles : List ( Point, Point, Point ) -> Shape
triangles positions =
    positions
        |> List.map (tupleMapThree (Point.toVec2 >> Render.toVertex))
        |> Vertices


triangle : Point -> Point -> Point -> Shape
triangle a b c =
    triangles [ ( a, b, c ) ]


rectangle : Dimensions -> Vec2 -> Shape
rectangle dimensions position =
    let
        x1 =
            Vec2.getX position

        x2 =
            x1 + Dimensions.getWidth dimensions

        y1 =
            Vec2.getY position

        y2 =
            y1 + Dimensions.getHeight dimensions
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


textured : Texture -> Shape -> Shape
textured =
    Debug.todo "Textures not implemented yet"
