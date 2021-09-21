module Scene2d.Dimensions exposing
    ( Dimensions
    , dimensions
    , fromRecord
    , height
    , width
    )

{-| Represents the dimensions of things in 2D.
-}


type Dimensions
    = Dimensions Float Float


fromRecord : { width : Float, height : Float } -> Dimensions
fromRecord record =
    Dimensions record.width record.height


width : Dimensions -> Float
width (Dimensions widthD _) =
    widthD


height : Dimensions -> Float
height (Dimensions _ heightD) =
    heightD


{-| Create [`Dimensions`](#Dimensions) from two
[`Float`][Basics#Float]s.

    dimensions 100 100 == fromRecord { width = 100, height = 100 }

-}
dimensions : Float -> Float -> Dimensions
dimensions =
    Dimensions
