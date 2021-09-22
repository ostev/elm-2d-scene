module Rectangle exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Scene
import Scene.Camera as Camera exposing (Camera)
import Scene.Dimensions as Dimensions exposing (Dimensions)
import Scene.Point as Point exposing (Point)
import Scene.Shape as Shape


main =
    Browser.sandbox
        { init = {}
        , update = update
        , view = view
        }


type alias Model =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update _ =
    identity


view : Model -> Html Msg
view model =
    Scene.toHtml
        (Camera.fromRecord
            { dimensions =
                Dimensions.fromRecord
                    { width = 400
                    , height = 400
                    }
            , position = Point.fromXY 0 0
            }
        )
        [ style "display" "block"
        , style "margin" "1rem"
        , style "border" "solid 1px"
        ]
        [ Shape.rectangle
            (Dimensions.fromWidthHeight 100 100)
            (Point.fromXY 50 50)
        ]
