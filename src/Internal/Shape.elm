module Internal.Shape exposing
    ( Kind(..)
    , Shape(..)
    )

import Color exposing (Color)
import Internal.Vertex as Vertex exposing (Vertex)
import Scene.Dimensions as Dimensions exposing (Dimensions)
import Scene.Point exposing (Point)
import Scene.Texture as Texture exposing (Texture)
import WebGL


type Kind
    = Triangles (List ( Point, Point, Point ))
    | Circle Float Point


type Shape msg
    = Shape Color Kind
    | Image Texture Point



-- toMesh : Shape msg -> WebGL.Mesh Vertex
-- toMesh =
--     toTriangles >> WebGL.triangles
-- {-| Extracts a [`Shape`'s](#Shape) texture,
-- if it has one. If it doesn't, [`Nothing`](Maybe#Nothing).
--     toTexture (image myTexture) == Just myTexture
--     toTexture rectangle
-- -}
-- toTexture : Shape msg -> Maybe Texture
-- toTexture shape =
--     case shape of
--         Textured texture _ ->
--             Just texture
--         _ ->
--             Nothing
-- toTriangles : Shape msg -> List ( Vertex, Vertex, Vertex )
-- toTriangles shape =
--     case shape of
--         Triangles triangles ->
--             triangles
--         Textured _ shape2 ->
--             toTriangles shape2
