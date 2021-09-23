module Internal.Shape exposing
    ( Shape(..)
    , toMesh
    , toTexture
    , toTriangles
    )

import Internal.Vertex as Vertex exposing (Vertex)
import Scene.Dimensions as Dimensions exposing (Dimensions)
import Scene.Texture as Texture exposing (Texture)
import WebGL


type Shape msg
    = Triangles (List ( Vertex, Vertex, Vertex ))
    | Textured Texture (Shape msg)





toMesh : Shape msg -> WebGL.Mesh Vertex
toMesh =
    toTriangles >> WebGL.triangles


{-| Extracts a [`Shape`'s](#Shape) texture,
if it has one. If it doesn't, [`Nothing`](Maybe#Nothing).

    toTexture (image myTexture) == Just myTexture

    toTexture rectangle

-}
toTexture : Shape msg -> Maybe Texture
toTexture shape =
    case shape of
        Textured texture _ ->
            Just texture

        _ ->
            Nothing


toTriangles : Shape msg -> List ( Vertex, Vertex, Vertex )
toTriangles shape =
    case shape of
        Triangles triangles ->
            triangles

        Textured _ shape2 ->
            toTriangles shape2
