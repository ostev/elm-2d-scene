module Render.Texture exposing (Metadata, Texture, metadata)

import Render.Dimensions exposing (Dimensions)
import WebGL.Texture
import Internal.Texture

type alias Location =
    String


{-| Represents texture metadata.
This can be created with [`metadata`](#metadata)
and is used to [`load`](#load) [`Texture`s](#Texture)
-}
type alias Metadata = Internal.Texture.Metadata


{-| Represents a fully loaded texture. You can
create one with [`load`](#load).
-}
type alias Texture = Internal.Texture.Texture


{-| Creates a `Texture` from a URL (`Location`) and
`Dimensions`.

    map =
        metadata "/images/map.jpg" (Dimensions.dimensions 4200 4200)

-}
metadata : Location -> Dimensions -> Metadata
metadata =
    Internal.Texture.Metadata
