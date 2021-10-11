module Scene.Angle exposing (Angle, degrees, radians)


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
