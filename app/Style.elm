module Style exposing (buttonClasses, elegantButton, elegantRouteButton)

import Html
import Html.Attributes as Attr
import Route


elegantButton : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
elegantButton additionalAttributes children =
    Html.a
        ([ Attr.class buttonClasses
         ]
            ++ additionalAttributes
        )
        children


elegantRouteButton : Route.Route -> List (Html.Html msg) -> Html.Html msg
elegantRouteButton route_ children =
    route_
        |> Route.link
            [ Attr.class buttonClasses
            ]
            children


buttonClasses : String.String
buttonClasses =
    "border text-center border-gold-light/70 px-6 py-3 text-sm tracking-wider text-gold-light hover:bg-gold-light/10 hover:border-gold-light hover:text-white hover:text-gold-primary transition-all duration-300 focus:outline focus:outline-1 focus:outline-offset-2 focus:outline-gold-light uppercase font-light"
