module Scene.Angle exposing
    ( Angle
    , degrees
    , mul
    , radians
    , toRadians
    )


type Angle
    = Angle Float


radians : Float -> Angle
radians =
    Angle


degrees : Float -> Angle
degrees r =
    (r / 180)
        * pi
        |> radians


toRadians : Angle -> Float
toRadians (Angle r) =
    r



-- toDegrees : Angle -> Float
-- toDegrees (Angle r) =


mul : Angle -> Angle -> Angle
mul (Angle x) (Angle y) =
    radians <| x * y
