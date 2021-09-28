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




