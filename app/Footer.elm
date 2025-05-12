module Footer exposing (footer)

import Html exposing (Html)
import Html.Attributes as Attr
import Route
import Svg exposing (path, svg)
import Svg.Attributes as SvgAttr


footer : Bool -> Html msg
footer showContact =
    Html.footer
        [ Attr.class "bg-noir-primary border-t border-noir-border"
        ]
        [ Html.div
            [ Attr.class "mx-auto max-w-7xl px-6 py-16 sm:py-24 lg:px-8 lg:py-32"
            ]
            (if showContact then
                [ contactButton
                , innerThing
                ]

             else
                [ innerThing
                ]
            )
        ]


contactButton =
    Html.div
        [ Attr.class "mx-auto max-w-2xl text-center"
        ]
        [ Html.div
            [ Attr.class "mt-8 flex justify-center"
            ]
            [ Route.Contact
                |> Route.link
                    [ Attr.class "rounded-md bg-gold-primary px-3.5 py-2.5 text-sm font-semibold text-text-primary shadow-sm hover:bg-gold-dark focus:outline focus:outline-2 focus:outline-offset-2 focus:outline-gold-primary"
                    ]
                    [ Html.text "Contact" ]
            ]
        ]


innerThing =
    Html.div
        [ Attr.class "mt-12 border-t border-noir-border pt-8 md:flex md:items-center md:justify-between"
        ]
        [ Html.div
            [ Attr.class "flex gap-x-6 md:order-2"
            ]
            [ Html.a
                [ Attr.href "http://instagram.com/soirnoirjazz"
                , Attr.class "text-gold-primary hover:text-gold-light focus:outline-none focus:ring-2 focus:ring-gold-primary focus:ring-offset-2 focus:ring-offset-noir-primary rounded-md"
                ]
                [ Html.span
                    [ Attr.class "sr-only"
                    ]
                    [ Html.text "Instagram" ]
                , Svg.svg
                    [ SvgAttr.class "size-6"
                    , SvgAttr.fill "currentColor"
                    , SvgAttr.viewBox "0 0 24 24"
                    , Attr.attribute "aria-hidden" "true"
                    ]
                    [ Svg.path
                        [ SvgAttr.fillRule "evenodd"
                        , SvgAttr.d "M12.315 2c2.43 0 2.784.013 3.808.06 1.064.049 1.791.218 2.427.465a4.902 4.902 0 011.772 1.153 4.902 4.902 0 011.153 1.772c.247.636.416 1.363.465 2.427.048 1.067.06 1.407.06 4.123v.08c0 2.643-.012 2.987-.06 4.043-.049 1.064-.218 1.791-.465 2.427a4.902 4.902 0 01-1.153 1.772 4.902 4.902 0 01-1.772 1.153c-.636.247-1.363.416-2.427.465-1.067.048-1.407.06-4.123.06h-.08c-2.643 0-2.987-.012-4.043-.06-1.064-.049-1.791-.218-2.427-.465a4.902 4.902 0 01-1.772-1.153 4.902 4.902 0 01-1.153-1.772c-.247-.636-.416-1.363-.465-2.427-.047-1.024-.06-1.379-.06-3.808v-.63c0-2.43.013-2.784.06-3.808.049-1.064.218-1.791.465-2.427a4.902 4.902 0 011.153-1.772A4.902 4.902 0 015.45 2.525c.636-.247 1.363-.416 2.427-.465C8.901 2.013 9.256 2 11.685 2h.63zm-.081 1.802h-.468c-2.456 0-2.784.011-3.807.058-.975.045-1.504.207-1.857.344-.467.182-.8.398-1.15.748-.35.35-.566.683-.748 1.15-.137.353-.3.882-.344 1.857-.047 1.023-.058 1.351-.058 3.807v.468c0 2.456.011 2.784.058 3.807.045.975.207 1.504.344 1.857.182.466.399.8.748 1.15.35.35.683.566 1.15.748.353.137.882.3 1.857.344 1.054.048 1.37.058 4.041.058h.08c2.597 0 2.917-.01 3.96-.058.976-.045 1.505-.207 1.858-.344.466-.182.8-.398 1.15-.748.35-.35.566-.683.748-1.15.137-.353.3-.882.344-1.857.048-1.055.058-1.37.058-4.041v-.08c0-2.597-.01-2.917-.058-3.96-.045-.976-.207-1.505-.344-1.858a3.097 3.097 0 00-.748-1.15 3.098 3.098 0 00-1.15-.748c-.353-.137-.882-.3-1.857-.344-1.023-.047-1.351-.058-3.807-.058zM12 6.865a5.135 5.135 0 110 10.27 5.135 5.135 0 010-10.27zm0 1.802a3.333 3.333 0 100 6.666 3.333 3.333 0 000-6.666zm5.338-3.205a1.2 1.2 0 110 2.4 1.2 1.2 0 010-2.4z"
                        , SvgAttr.clipRule "evenodd"
                        ]
                        []
                    ]
                ]
            , Html.a
                [ Attr.href "mailto:soirnoirjazz@gmail.com"
                , Attr.class "text-gold-primary hover:text-gold-light focus:outline-none focus:ring-2 focus:ring-gold-primary focus:ring-offset-2 focus:ring-offset-noir-primary rounded-md"
                ]
                [ Html.span
                    [ Attr.class "sr-only"
                    ]
                    [ Html.text "Email" ]
                , mailIcon
                ]
            , Html.a
                [ Attr.href "https://www.youtube.com/@SoirNoirJazz"
                , Attr.target "_blank"
                , Attr.class "text-gold-primary hover:text-gold-light focus:outline-none focus:ring-2 focus:ring-gold-primary focus:ring-offset-2 focus:ring-offset-noir-primary rounded-md"
                ]
                [ Html.span
                    [ Attr.class "sr-only"
                    ]
                    [ Html.text "YouTube" ]
                , Svg.svg
                    [ SvgAttr.class "size-6"
                    , SvgAttr.fill "currentColor"
                    , SvgAttr.viewBox "0 0 24 24"
                    , Attr.attribute "aria-hidden" "true"
                    ]
                    [ Svg.path
                        [ SvgAttr.fillRule "evenodd"
                        , SvgAttr.d "M19.812 5.418c.861.23 1.538.907 1.768 1.768C21.998 8.746 22 12 22 12s0 3.255-.418 4.814a2.504 2.504 0 0 1-1.768 1.768c-1.56.419-7.814.419-7.814.419s-6.255 0-7.814-.419a2.505 2.505 0 0 1-1.768-1.768C2 15.255 2 12 2 12s0-3.255.417-4.814a2.507 2.507 0 0 1 1.768-1.768C5.744 5 11.998 5 11.998 5s6.255 0 7.814.418ZM15.194 12 10 15V9l5.194 3Z"
                        , SvgAttr.clipRule "evenodd"
                        ]
                        []
                    ]
                ]
            ]
        , Html.p
            [ Attr.class "mt-8 text-sm/6 text-text-tertiary md:order-1 md:mt-0"
            ]
            [ Html.text "© 2025 Soir Noir All rights reserved." ]
        ]


mailIcon =
    svg
        [ SvgAttr.fill "none"
        , SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.strokeWidth "1.5"
        , SvgAttr.stroke "currentColor"
        , SvgAttr.class "size-6"
        ]
        [ path
            [ SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.d "M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75"
            ]
            []
        ]
