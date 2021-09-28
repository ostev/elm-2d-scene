module Image exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Scene
import Scene.Camera as Camera exposing (Camera)
import Scene.Dimensions as Dimensions exposing (Dimensions)
import Scene.Point as Point exposing (Point)
import Scene.Shape as Shape
import Scene.Texture as Texture exposing (Texture)
import Task


main : Program () Model Msg
main =
    Browser.element
        { init =
            \_ ->
                ( { texture = Nothing }
                , Texture.load
                    (Texture.metadata (Dimensions.fromWidthHeight 640 425)
                        "example-texture.jpg"
                    )
                    |> Task.attempt LoadTexture
                )
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { texture : Maybe Texture }


type Msg
    = NoOp
    | LoadTexture (Result Texture.Error Texture)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        LoadTexture (Ok texture) ->
            ( { model | texture = Just texture }, Cmd.none )

        LoadTexture (Err _) ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Scene.toHtml
        [ style "display" "block"
        , style "margin" "1rem"
        , style "border" "solid 1px"
        ]
        (Scene.fromRecord
            { camera =
                Camera.fromRecord
                    { dimensions =
                        Dimensions.fromRecord
                            { width = 400
                            , height = 400
                            }
                    , position = Point.fromXY 0 0
                    }
            , content =
                (case model.texture of
                    Just texture ->
                        [ Shape.image texture (Point.fromXY 0 0) ]

                    Nothing ->
                        [])
            }
        )
