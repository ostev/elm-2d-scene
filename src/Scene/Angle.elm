module Scene.Angle exposing
    ( Angle
    , add
    , fromDegrees
    , multiply
    , fromRadians
    , toDegrees
    , toRadians
    , subtract
    , divide
    )

{-|

@docs Angle

## Conversion
@docs fromRadians, fromDegrees

## Arithmetic
@docs add, subtract, multiply, divide

-}

{-| Represents an angle in [radians](https://en.wikipedia.org/wiki/Radian).
You can create one with [`fromRadians`](#fromRadians) or
[`fromDegrees`](#fromDegrees).
-}
type Angle
    = Angle Float

{-| Create an angle from a value in
[radians](https://en.wikipedia.org/wiki/Radian).

    fromRadians 1 == fromDegrees 57.29577951308232
-}
fromRadians : Float -> Angle
fromRadians =
    Angle


{-| Create an angle from a value in
[radians](https://en.wikipedia.org/wiki/Radian).

    fromDegrees 57.29577951308232 == fromRadians 1
-}
fromDegrees : Float -> Angle
fromDegrees r =
    r
        / 180
        * pi 
        |> fromRadians

{-| Get the value of an [`Angle`](#Angle) in radians.

    toRadians (fromRadians 1) == 1
-}
toRadians : Angle -> Float
toRadians (Angle r) =
    r

{-| Get the value of an [`Angle`](#Angle) in degrees.

    toDegrees (fromDegrees 180) == 180
-}
toDegrees : Angle -> Float
toDegrees (Angle r) =
    r
        * 180
        / pi

{-| Multiply two [`Angle`](#Angle)s.
-}
multiply : Angle -> Angle -> Angle
multiply (Angle x) (Angle y) =
    fromRadians <| x * y

{-| Divide two [`Angle1](#Angle)s.
-}
divide : Angle -> Angle -> Angle
divide (Angle x) (Angle y) =
    fromRadians <| x / y


{-| Add two [`Angle1](#Angle)s.
-}
add : Angle -> Angle -> Angle
add (Angle x) (Angle y) =
    fromRadians <| x + y

{-| Subtract two [`Angle1](#Angle)s.
-}
subtract : Angle -> Angle -> Angle
subtract (Angle x) (Angle y) =
    fromRadians <| x - y

