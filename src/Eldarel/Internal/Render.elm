module Eldarel.Internal.Render exposing (Vertex, toVertex)

import Math.Vector2 as Vec2 exposing (Vec2, vec2)


flip : (a -> b -> c) -> (b -> a -> c)
flip f =
    \x y -> f y x


type alias Vertex =
    { a_position : Vec2
    , a_texcoord : Vec2
    }


toVertex : Vec2 -> Vertex
toVertex =
    flip Vertex <| vec2 0 0
