module Internal.Vertex exposing
    ( Textured
    , Untextured
    , Vertex
    , fromPoint
    , fromVec2
    )

import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Scene.Point as Point exposing (Point)


type alias Vertex a =
    { a | a_position : Vec2 }


type alias Untextured =
    Vertex {}


type alias Textured =
    Vertex { a_texcoord : Vec2 }


fromVec2 : Vec2 -> Vertex {}
fromVec2 vec =
    { a_position = vec }


fromPoint : Point -> Vertex {}
fromPoint point =
    { a_position = Point.toVec2 point }
