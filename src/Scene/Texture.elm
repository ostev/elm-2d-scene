module Scene.Texture exposing
    ( Error
    , Metadata
    , Texture
    , dimensions
    , load
    , metadata
    )

import Bitwise
import Internal.Texture
import Scene.Dimensions as Dimensions exposing (Dimensions)
import Task exposing (Task)
import WebGL.Texture


type alias Location =
    String


{-| Represents texture metadata.
This can be created with [`metadata`](#metadata)
and is used to [`load`](#load) [`Texture`s](#Texture)
-}
type alias Metadata =
    Internal.Texture.Metadata


{-| Represents a fully loaded texture. You can
create one with [`load`](#load).
-}
type alias Texture =
    Internal.Texture.Texture


{-| Creates some texture metadata from a URL (`Location`) and
its `Dimensions`.

    map =
        metadata "/images/map.jpg" (Dimensions.dimensions 4200 4200)

-}
metadata : Dimensions -> Location -> Metadata
metadata =
    Internal.Texture.Metadata


dimensions : Texture -> Dimensions
dimensions (Internal.Texture.Texture (Internal.Texture.Metadata textureDimensions _) _) =
    textureDimensions


type Error
    = LoadError
    | SizeMismatchError


isPowerOfTwo : Int -> Bool
isPowerOfTwo n =
    if n == 0 then
        False

    else
        Bitwise.and n (n - 1) == 0


load : Metadata -> Task Error Texture
load meta =
    case meta of
        Internal.Texture.Metadata predictedDimensions location ->
            location
                |> (if
                        isPowerOfTwo (round <| Dimensions.width predictedDimensions)
                            && isPowerOfTwo (round <| Dimensions.height predictedDimensions)
                    then
                        WebGL.Texture.load

                    else
                        WebGL.Texture.loadWith WebGL.Texture.nonPowerOfTwoOptions
                   )
                |> Task.mapError
                    (\err ->
                        case err of
                            WebGL.Texture.LoadError ->
                                LoadError

                            WebGL.Texture.SizeError _ _ ->
                                SizeMismatchError
                    )
                |> Task.andThen
                    (\texture ->
                        if
                            WebGL.Texture.size texture
                                == Tuple.mapBoth round round (Dimensions.toTuple predictedDimensions)
                        then
                            Task.succeed (Internal.Texture.Texture meta texture)

                        else
                            Task.fail SizeMismatchError
                    )
