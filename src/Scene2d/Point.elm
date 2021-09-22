module Scene2d.Point exposing
    ( Point
    , first
    , fromXY
    , second
    , toVec2
    )

import Math.Vector2 as Vec2 exposing (Vec2, vec2)


type Point
    = Point Vec2


{-| Construct a point from two
[`Float`](https://package.elm-lang.org/packages/elm/core/latest/Basics#Float)s.

    fromXY 30 90 : Point

-}
fromXY : Float -> Float -> Point
fromXY x y =
    Point <| vec2 x y


{-| Extract the first (`x`) component of a point.

     first (point 5 8) == 5

-}
first : Point -> Float
first (Point vec) =
    Vec2.getX vec


{-| Extracts the second (`y`) component of a point.

     second (point 5 8) == 5

-}
second : Point -> Float
second (Point vec) =
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
