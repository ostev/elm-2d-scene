module Internal.Texture exposing (Metadata(..), Texture(..), toWebGLTexture)

import Scene.Dimensions exposing (Dimensions)
import WebGL.Texture


type alias Location =
    String


type Metadata
    = Metadata Dimensions Location


type Texture
    = Texture Metadata WebGL.Texture.Texture


toWebGLTexture : Texture -> WebGL.Texture.Texture
toWebGLTexture (Texture _ texture) =
    texture
