module Route.Contact exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import BackendTask
import Effect
import FatalError
import Footer
import Head
import Head.Seo as Seo
import Html exposing (Html)
import Html.Attributes as Attr
import Pages.Url
import PagesMsg
import Route
import RouteBuilder
import Shared
import Style
import Svg exposing (path, svg)
import Svg.Attributes as SvgAttr
import UrlPath
import View


type alias Model =
    {}


type Msg
    = NoOp


type alias RouteParams =
    {}


route : RouteBuilder.StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single
        { data = data, head = head }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


init :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> ( Model, Effect.Effect Msg )
init app shared =
    ( {}, Effect.none )


update :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Msg
    -> Model
    -> ( Model, Effect.Effect Msg )
update app shared msg model =
    case msg of
        NoOp ->
            ( model, Effect.none )


subscriptions : RouteParams -> UrlPath.UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions routeParams path shared model =
    Sub.none


type alias Data =
    {}


type alias ActionData =
    BackendTask.BackendTask FatalError.FatalError (List RouteParams)


data : BackendTask.BackendTask FatalError.FatalError Data
data =
    BackendTask.succeed {}


head : RouteBuilder.App Data ActionData RouteParams -> List Head.Tag
head app =
    Seo.summaryLarge
        { canonicalUrlOverride = Nothing
        , siteName = "Soir Noir - Santa Barbara Jazz Band"
        , image =
            { url = "https://res.cloudinary.com/dillonkearns/image/upload/w_1000,c_fill,ar_1:1,g_auto,r_max,bo_5px_solid_red,b_rgb:262c35/v1742066379/hero-color_oh0rng.jpg" |> Pages.Url.external
            , alt = "Soir Noir"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Soir Noir Jazz Band"
        , locale = Nothing
        , title = "Soir Noir - Santa Barbara Jazz Band"
        }
        |> Seo.website


view :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Model
    -> View.View (PagesMsg.PagesMsg Msg)
view app shared model =
    { title = "Soir Noir | Bookings & Contact"
    , body =
        [ contactSection
        , Footer.footer False
        ]
    }


contactSection : Html msg
contactSection =
    Html.div
        [ Attr.class "relative bg-noir-primary min-h-screen"
        ]
        [ Html.div
            [ Attr.class "mx-auto px-6 pt-6 pb-8 sm:pt-8 sm:pb-12 lg:px-8"
            ]
            [ Html.nav []
                [ Route.Index
                    |> Route.link
                        [ Attr.class "inline-block" ]
                        [ Html.h1
                            [ Attr.class "text-2xl sm:text-3xl font-heading text-gold-light hover:text-gold-light/80 transition-colors duration-200 p-2 border-gold-light border-2"
                            ]
                            [ Html.text "SOIR NOIR" ]
                        ]
                ]
            ]
        , Html.div
            [ Attr.class "relative" ]
            [ Html.div
                [ Attr.class "lg:absolute lg:inset-y-0 lg:right-0 lg:w-1/2" ]
                [ Html.img
                    [ Attr.class "aspect-[3/2] w-full bg-noir-primary object-cover lg:absolute lg:inset-y-0 lg:z-0 lg:h-full filter grayscale contrast-125 brightness-90"
                    , Attr.src "/duo.jpg"
                    , Attr.alt "Soir Noir performing"
                    ]
                    []
                ]
            , Html.div
                [ Attr.class "mx-auto grid max-w-7xl grid-cols-1 lg:grid-cols-2 mt-8 lg:mt-0" ]
                [ Html.div
                    [ Attr.class "px-6 pb-24 sm:pb-32 lg:col-span-1 lg:px-8 lg:pb-48" ]
                    [ Html.div
                        [ Attr.class "mx-auto max-w-xl lg:mx-0 lg:max-w-lg" ]
                        [ Html.h2
                            [ Attr.class "text-3xl sm:text-4xl font-heading tracking-tight text-gold-light" ]
                            [ Html.text "Send Booking Inquiry" ]
                        , Html.p
                            [ Attr.class "mt-3 text-lg leading-8 text-gray-300" ]
                            [ Html.text "Soir Noir provides sophisticated live Jazz for events throughout the Santa Barbara area. Provide your details below for booking availability and other inquiries." ]
                        , Html.form
                            [ Attr.action "https://usebasin.com/f/359fb6c1353b"
                            , Attr.method "POST"
                            , Attr.id "contact-form"
                            , Attr.attribute "enctype" "multipart/form-data"
                            , Attr.class "mt-12 sm:mt-16"
                            ]
                            [ Html.div
                                [ Attr.class "grid grid-cols-1 gap-x-8 gap-y-6 sm:grid-cols-2" ]
                                [ formField "name" "Name" "text" True "sm:col-span-2" Nothing
                                , formField "email" "Email" "email" True "sm:col-span-2" Nothing
                                , formField "venue" "Venue" "text" False "sm:col-span-2" (Just "Event Location / Venue Name")
                                , formField "message" "Message" "textarea" True "sm:col-span-2" (Just "Tell us about your event or inquiry...")
                                ]
                            , Html.div
                                [ Attr.class "mt-10 flex justify-end border-t border-gold-light/20 pt-8" ]
                                [ Html.button
                                    [ Attr.type_ "submit"
                                    , Attr.class Style.buttonClasses
                                    ]
                                    [ Html.text "Send Message" ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


formField : String -> String -> String -> Bool -> String -> Maybe String -> Html msg
formField fieldId labelText inputType isRequired gridSpanClasses maybePlaceholder =
    Html.div
        [ Attr.class gridSpanClasses ]
        [ Html.div
            [ Attr.class "flex justify-between items-baseline mb-1.5" ]
            [ Html.label
                [ Attr.for fieldId
                , Attr.class "block text-sm font-semibold leading-6 text-white"
                ]
                [ Html.text labelText ]
            , if not isRequired then
                Html.span
                    [ Attr.class "text-sm leading-6 text-gold-light opacity-70" ]
                    [ Html.text "Optional" ]

              else
                Html.span [] []
            ]
        , Html.div
            [ Attr.class "mt-1" ]
            (if inputType == "textarea" then
                [ Html.textarea
                    [ Attr.name fieldId
                    , Attr.id fieldId
                    , Attr.required isRequired
                    , Attr.rows 4
                    , Attr.class (formInputClasses inputType)
                    , Attr.placeholder (Maybe.withDefault "" maybePlaceholder)
                    ]
                    []
                ]

             else
                [ Html.input
                    [ Attr.type_ inputType
                    , Attr.name fieldId
                    , Attr.id fieldId
                    , Attr.required isRequired
                    , Attr.class (formInputClasses inputType)
                    , Attr.placeholder (Maybe.withDefault "" maybePlaceholder)
                    ]
                    []
                ]
            )
        ]


formInputClasses : String -> String
formInputClasses inputType =
    String.join " "
        [ "block w-full rounded-none border-0 px-3.5 py-2"
        , "bg-white/5 text-white shadow-sm ring-1 ring-inset ring-white/10"
        , "placeholder:text-gray-500 focus:ring-2 focus:ring-inset focus:ring-gold-light"
        , "sm:text-sm sm:leading-6"
        ]
