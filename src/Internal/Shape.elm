module Internal.Shape exposing
    ( Kind(..)
    , Shape(..)
    , Type(..)
    , Attributes
    )

import Color exposing (Color)
import Internal.Vertex as Vertex exposing (Vertex)
import Scene.Angle as Angle exposing (Angle)
import Scene.Dimensions as Dimensions exposing (Dimensions)
import Scene.Point exposing (Point)
import Scene.Texture as Texture exposing (Texture)
import WebGL


type Kind
    = Triangles (List ( Point, Point, Point ))
    | Circle Float Point


type alias Attributes =
    { translation : Point
    , rotation : Angle
    , scale :
        { x : Float
        , y : Float
        }
    }


type Type
    = Basic Kind
    | Image Texture Point


type Shape
    = Shape Attributes Type
