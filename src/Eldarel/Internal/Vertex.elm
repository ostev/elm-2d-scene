module Eldarel.Internal.Vertex exposing
    ( Vertex
    , fromPoint
    , fromVec2
    )

import Eldarel.Point as Point exposing (Point)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)


type alias Vertex =
    { a_position : Vec2
    , a_texcoord : Vec2
    }


fromVec2 : Vec2 -> Vertex
fromVec2 pos =
    Vertex pos <| vec2 0 0


fromPoint : Point -> Vertex
fromPoint =
    Point.toVec2 >> fromVec2
