module Render.Texture exposing (Texture, texture)

import Render.Dimensions exposing (Dimensions)

type alias Location =
    String


type Texture
    = Texture Location Dimensions


{-|

    Creates a `Texture` from a URL (`Location`) and
    `Dimensions`.

        map = texture "/images/map.jpg" (4200, 4200)

-}
texture : Location -> Dimensions -> Texture
texture =
    Texture
