module Cloudinary exposing (ImageConfig, responsiveImg)

import Html exposing (Html)
import Html.Attributes as Attr


type alias ImageConfig =
    { altText : String
    , cloudinaryId : String
    , cssClass : String
    , baseSize : Int
    }


imageUrl : String -> Int -> String
imageUrl cloudinaryId width =
    baseUrl ++ "/f_auto,q_auto:good,c_scale,w_" ++ String.fromInt width ++ "/" ++ cloudinaryId


srcsetAttr : String -> List Int -> String
srcsetAttr cloudinaryId widths =
    String.join ", " (List.map (\w -> imageUrl cloudinaryId w ++ " " ++ String.fromInt w ++ "w") widths)


breakpointWidths : Int -> List Int
breakpointWidths baseSize =
    [ round (toFloat baseSize * 0.5)
    , round (toFloat baseSize * 0.8)
    , baseSize
    , round (toFloat baseSize * 1.5)
    ]


responsiveImg : ImageConfig -> Html msg
responsiveImg config =
    let
        widths : List Int
        widths =
            breakpointWidths config.baseSize
    in
    Html.img
        [ Attr.class config.cssClass
        , Attr.src (imageUrl config.cloudinaryId (List.head widths |> Maybe.withDefault config.baseSize))
        , Attr.attribute "srcset" (srcsetAttr config.cloudinaryId widths)
        , Attr.attribute "sizes" "(max-width: 480px) 100vw, (max-width: 1024px) 100vw, 50vw"
        , Attr.alt config.altText
        ]
        []


baseUrl : String
baseUrl =
    "https://res.cloudinary.com/dillonkearns/image/upload"
