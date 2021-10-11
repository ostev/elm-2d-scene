module Image exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events
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
                ( { texture = Nothing
                  , camera = Camera.fromRecord { dimensions = dimensions, position = Point.fromXY 0 0 }
                  }
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
    { texture : Maybe Texture
    , camera : Camera
    }


type Msg
    = NoOp
    | LoadTexture (Result Texture.Error Texture)
    | SetX Int
    | SetY Int


dimensions : Dimensions
dimensions =
    Dimensions.fromRecord
        { width = 400
        , height = 400
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        LoadTexture (Ok texture) ->
            ( { model | texture = Just texture }, Cmd.none )

        LoadTexture (Err _) ->
            ( model, Cmd.none )

        SetX newX ->
            ( { model | camera = Camera.setX (toFloat newX) model.camera }
            , Cmd.none
            )

        SetY newY ->
            ( { model | camera = Camera.setY (toFloat newY) model.camera }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    Html.main_ [ style "font-family" "Cascadia Code, monospace" ]
        [ Scene.toHtml
            [ style "display" "block"
            , style "margin" "1rem"
            , style "border" "solid 1px"
            ]
            (Scene.fromRecord
                { camera = model.camera
                , content =
                    case model.texture of
                        Just texture ->
                            [ Shape.image texture (Point.fromXY 0 0) ]

                        Nothing ->
                            []
                }
            )
        , Html.label [ Html.Attributes.for "x", style "display" "block" ] [ Html.text "Set the X position" ]
        , Html.input
            [ style "display" "block"
            , Html.Attributes.id "x"
            , Html.Attributes.type_ "range"
            , Html.Events.onInput
                (String.toInt
                    >> Maybe.map SetX
                    >> Maybe.withDefault NoOp
                )
            , Html.Attributes.min "-400"
            , Html.Attributes.max "800"
            , Html.Attributes.value
                (Camera.position model.camera
                    |> Point.getX
                    |> String.fromFloat
                )
            ]
            []
        , Html.label [ Html.Attributes.for "y", style "display" "block" ] [ Html.text "Set the Y position" ]
        , Html.input
            [ style "display" "block"
            , Html.Attributes.id "y"
            , Html.Attributes.type_ "range"
            , Html.Events.onInput
                (String.toInt
                    >> Maybe.map SetY
                    >> Maybe.withDefault NoOp
                )
            , Html.Attributes.min "-400"
            , Html.Attributes.max "800"
            , Html.Attributes.value
                (Camera.position model.camera
                    |> Point.getY
                    |> String.fromFloat
                )
            ]
            []
        ]
