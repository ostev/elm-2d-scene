module Rectangle exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Scene2d
import Scene2d.Camera as Camera exposing (Camera)
import Scene2d.Dimensions as Dimensions exposing (Dimensions)
import Scene2d.Point as Point exposing (Point)
import Scene2d.Shape as Shape


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
    Scene2d.toHtml
        (Camera.fromRecord
            { dimensions =
                Dimensions.fromRecord
                    { width = 400
                    , height = 400
                    }
            , position = Point.fromXY 0 0
            }
        )
        []
        [ Shape.rectangle
            (Dimensions.fromWidthHeight 100 100)
            (Point.fromXY 50 50)
        ]
