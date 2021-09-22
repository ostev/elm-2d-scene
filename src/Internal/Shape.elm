module Internal.Shape exposing
    ( Shape(..)
    , toTexture
    , toTriangles
    , toMesh
    )

import Internal.Vertex as Vertex exposing (Vertex)
import Scene.Texture as Texture exposing (Texture)
import WebGL

type Shape
    = Triangles (List ( Vertex, Vertex, Vertex ))
    | Textured Texture Shape

toMesh : Shape -> WebGL.Mesh Vertex
toMesh = toTriangles >> WebGL.triangles
                 

{-| Extracts a [`Shape`'s](#Shape) texture,
if it has one. If it doesn't, [`Nothing`](Maybe#Nothing).

    toTexture (image myTexture) == Just myTexture

    toTexture rectangle

-}
toTexture : Shape -> Maybe Texture
toTexture shape =
    case shape of
        Textured texture _ ->
            Just texture

        _ ->
            Nothing


toTriangles : Shape -> List ( Vertex, Vertex, Vertex )
toTriangles shape =
    case shape of
        Triangles triangles ->
            triangles

        Textured _ shape2 ->
            toTriangles shape2
