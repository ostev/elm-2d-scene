module Eldarel.Dimensions exposing
    ( Dimensions
    , fromRecord
    , getHeight
    , getWidth
    )


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
