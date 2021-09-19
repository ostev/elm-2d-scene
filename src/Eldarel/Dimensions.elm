module Eldarel.Dimensions exposing
    ( Dimensions
    , dimensions
    , fromRecord
    , getHeight
    , getWidth
    )

{-| Represents the dimensions of things in 2D.
-}


type Dimensions
    = Dimensions Float Float


fromRecord : { width : Float, height : Float } -> Dimensions
fromRecord { width, height } =
    Dimensions width height


getWidth : Dimensions -> Float
getWidth (Dimensions width _) =
    width


getHeight : Dimensions -> Float
getHeight (Dimensions _ height) =
    height


{-| Create [`Dimensions`](#Dimensions) from two
[`Float`][Basics#Float]s.

    dimensions 100 100 == fromRecord { width = 100, height = 100 }

-}
dimensions : Float -> Float -> Dimensions
dimensions =
    Dimensions
