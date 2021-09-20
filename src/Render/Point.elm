module Render.Point exposing
    ( Point
    , point
    , toVec2
    )

import Math.Vector2 as Vec2 exposing (Vec2, vec2)


type Point
    = Point Vec2


{-| Construct a point from two
[`Float`](https://package.elm-lang.org/packages/elm/core/latest/Basics#Float)s.

    point 30 90 : Point

-}
point : Float -> Float -> Point
point x y =
    Point <| vec2 x y


{-| Extract the x component of a point.

     getX (point 5 8) == 5

-}
getX : Point -> Float
getX (Point vec) =
    Vec2.getX vec


{-| Extract the x component of a point.

     getX (point 5 8) == 5

-}
getY : Point -> Float
getY (Point vec) =
    Vec2.getY vec


{-| Convert a [`Point`](#Point) to a
[`Vec2`](https://package.elm-lang.org/packages/elm-explorations/linear-algebra/latest/Math-Vector2#Vec2).

You almost certainly don't need this; the main use case
would be to pass a [`Point`](#Point) to a
[`Vec2`](https://package.elm-lang.org/packages/elm-explorations/linear-algebra/latest/Math-Vector2#Vec2).

-}
toVec2 : Point -> Vec2
toVec2 (Point vec) =
    vec
