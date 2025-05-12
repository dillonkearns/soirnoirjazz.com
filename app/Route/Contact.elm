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
    { title = "Soir Noir Jazz Band Bookings & Contact"
    , body =
        [ header
        , contactFormNew
        , Footer.footer False
        ]
    }


contactFormNew =
    Html.div
        [ Attr.class "relative isolate bg-gray-900"
        ]
        [ Html.div
            [ Attr.class "mx-auto grid max-w-7xl grid-cols-1 lg:grid-cols-2"
            ]
            [ Html.div
                [ Attr.class "relative px-6 pt-24 pb-20 sm:pt-32 lg:static lg:px-8 lg:py-48"
                ]
                [ Html.div
                    [ Attr.class "mx-auto max-w-xl lg:mx-0 lg:max-w-lg"
                    ]
                    [ Html.div
                        [ Attr.class "absolute inset-y-0 left-0 -z-10 w-full overflow-hidden ring-1 ring-white/5 lg:w-1/2"
                        ]
                        [ svg
                            [ SvgAttr.class "absolute inset-0 size-full stroke-gray-700 [mask-image:radial-gradient(100%_100%_at_top_right,white,transparent)]"
                            , Attr.attribute "aria-hidden" "true"
                            ]
                            [ Svg.defs []
                                [ Svg.pattern
                                    [ SvgAttr.id "54f88622-e7f8-4f1d-aaf9-c2f5e46dd1f2"
                                    , SvgAttr.width "200"
                                    , SvgAttr.height "200"
                                    , SvgAttr.x "100%"
                                    , SvgAttr.y "-1"
                                    , SvgAttr.patternUnits "userSpaceOnUse"
                                    ]
                                    [ path
                                        [ SvgAttr.d "M130 200V.5M.5 .5H200"
                                        , SvgAttr.fill "none"
                                        ]
                                        []
                                    ]
                                ]
                            , svg
                                [ SvgAttr.x "100%"
                                , SvgAttr.y "-1"
                                , SvgAttr.class "overflow-visible fill-gray-800/20"
                                ]
                                [ path
                                    [ SvgAttr.d "M-470.5 0h201v201h-201Z"
                                    , SvgAttr.strokeWidth "0"
                                    ]
                                    []
                                ]
                            , Svg.rect
                                [ SvgAttr.width "100%"
                                , SvgAttr.height "100%"
                                , SvgAttr.strokeWidth "0"
                                , SvgAttr.fill "url(#54f88622-e7f8-4f1d-aaf9-c2f5e46dd1f2)"
                                ]
                                []
                            ]
                        , Html.div
                            [ Attr.class "absolute top-[calc(100%-13rem)] -left-56 transform-gpu blur-3xl lg:top-[calc(50%-7rem)] lg:left-[max(-14rem,calc(100%-59rem))]"
                            , Attr.attribute "aria-hidden" "true"
                            ]
                            [ Html.div
                                [ Attr.class "aspect-1155/678 w-[72.1875rem] bg-linear-to-br from-[#80caff] to-[#4f46e5] opacity-20"
                                , Attr.style "clip-path" "polygon(74.1% 56.1%, 100% 38.6%, 97.5% 73.3%, 85.5% 100%, 80.7% 98.2%, 72.5% 67.7%, 60.2% 37.8%, 52.4% 32.2%, 47.5% 41.9%, 45.2% 65.8%, 27.5% 23.5%, 0.1% 35.4%, 17.9% 0.1%, 27.6% 23.5%, 76.1% 2.6%, 74.1% 56.1%)"
                                ]
                                []
                            ]
                        ]
                    , Html.h2
                        [ Attr.class "text-4xl font-semibold tracking-tight text-pretty text-white sm:text-5xl"
                        ]
                        [ Html.text "Request a Booking or Get in Touch" ]
                    , Html.p
                        [ Attr.class "mt-6 text-lg/8 text-gray-300"
                        ]
                        [ Html.text "Feel free to reach out about Jazz bookings, musical collaborations, or general inquiries. I look forward to connecting about your event or project!" ]
                    , Html.dl
                        [ Attr.class "mt-10 space-y-4 text-base/7 text-gray-300"
                        ]
                        [ Html.div
                            [ Attr.class "flex gap-x-4"
                            ]
                            [ Html.dt
                                [ Attr.class "flex-none"
                                ]
                                [ Html.span
                                    [ Attr.class "sr-only"
                                    ]
                                    [ Html.text "Telephone" ]
                                , svg
                                    [ SvgAttr.class "h-7 w-6 text-gray-400"
                                    , SvgAttr.fill "none"
                                    , SvgAttr.viewBox "0 0 24 24"
                                    , SvgAttr.strokeWidth "1.5"
                                    , SvgAttr.stroke "currentColor"
                                    , Attr.attribute "aria-hidden" "true"
                                    , Attr.attribute "data-slot" "icon"
                                    ]
                                    [ path
                                        [ SvgAttr.strokeLinecap "round"
                                        , SvgAttr.strokeLinejoin "round"
                                        , SvgAttr.d "M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 0 0 2.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 0 1-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 0 0-1.091-.852H4.5A2.25 2.25 0 0 0 2.25 4.5v2.25Z"
                                        ]
                                        []
                                    ]
                                ]
                            , Html.dd []
                                [ Html.a
                                    [ Attr.class "hover:text-white"
                                    , Attr.href "tel:+1 (805) 451-5566"
                                    ]
                                    [ Html.text "+1 (805) 451-5566" ]
                                ]
                            ]
                        , Html.div
                            [ Attr.class "flex gap-x-4"
                            ]
                            [ Html.dt
                                [ Attr.class "flex-none"
                                ]
                                [ Html.span
                                    [ Attr.class "sr-only"
                                    ]
                                    [ Html.text "Email" ]
                                , svg
                                    [ SvgAttr.class "h-7 w-6 text-gray-400"
                                    , SvgAttr.fill "none"
                                    , SvgAttr.viewBox "0 0 24 24"
                                    , SvgAttr.strokeWidth "1.5"
                                    , SvgAttr.stroke "currentColor"
                                    , Attr.attribute "aria-hidden" "true"
                                    , Attr.attribute "data-slot" "icon"
                                    ]
                                    [ path
                                        [ SvgAttr.strokeLinecap "round"
                                        , SvgAttr.strokeLinejoin "round"
                                        , SvgAttr.d "M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75"
                                        ]
                                        []
                                    ]
                                ]
                            , Html.dd []
                                [ Html.a
                                    [ Attr.class "hover:text-white"
                                    , Attr.href "mailto:soirnoirjazz@gmail.com"
                                    ]
                                    [ Html.text "soirnoirjazz@gmail.com" ]
                                ]
                            ]
                        ]
                    ]
                ]
            , Html.form
                [ Attr.action "https://usebasin.com/f/1af1dfb3e14e"
                , Attr.method "POST"
                , Attr.id "form"
                , Attr.enctype "multipart/form-data"
                , Attr.class "px-6 pt-20 pb-24 sm:pb-32 lg:px-8 lg:py-48"
                ]
                [ Html.div
                    [ Attr.class "mx-auto max-w-xl lg:mr-0 lg:max-w-lg"
                    ]
                    [ Html.div
                        [ Attr.class "grid grid-cols-1 gap-x-8 gap-y-6 sm:grid-cols-2"
                        ]
                        [ Html.div []
                            [ Html.label
                                [ Attr.for "first-name"
                                , Attr.class "block text-sm/6 font-semibold text-white"
                                ]
                                [ Html.text "First name" ]
                            , Html.div
                                [ Attr.class "mt-2.5"
                                ]
                                [ Html.input
                                    [ Attr.type_ "text"
                                    , Attr.name "first-name"
                                    , Attr.id "first-name"
                                    , Attr.attribute "autocomplete" "given-name"
                                    , Attr.required True
                                    , Attr.class "block w-full rounded-md bg-white/5 px-3.5 py-2 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500"
                                    ]
                                    []
                                ]
                            ]
                        , Html.div []
                            [ Html.label
                                [ Attr.for "last-name"
                                , Attr.class "block text-sm/6 font-semibold text-white"
                                ]
                                [ Html.text "Last name" ]
                            , Html.div
                                [ Attr.class "mt-2.5"
                                ]
                                [ Html.input
                                    [ Attr.type_ "text"
                                    , Attr.name "last-name"
                                    , Attr.id "last-name"
                                    , Attr.required True
                                    , Attr.attribute "autocomplete" "family-name"
                                    , Attr.class "block w-full rounded-md bg-white/5 px-3.5 py-2 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500"
                                    ]
                                    []
                                ]
                            ]
                        , Html.div
                            [ Attr.class "sm:col-span-2"
                            ]
                            [ Html.label
                                [ Attr.for "email"
                                , Attr.class "block text-sm/6 font-semibold text-white"
                                ]
                                [ Html.text "Email" ]
                            , Html.div
                                [ Attr.class "mt-2.5"
                                ]
                                [ Html.input
                                    [ Attr.type_ "email"
                                    , Attr.name "email"
                                    , Attr.required True
                                    , Attr.id "email"
                                    , Attr.attribute "autocomplete" "email"
                                    , Attr.class "block w-full rounded-md bg-white/5 px-3.5 py-2 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500"
                                    ]
                                    []
                                ]
                            ]
                        , Html.div
                            [ Attr.class "sm:col-span-2"
                            ]
                            [ Html.div
                                [ Attr.class "flex justify-between text-sm/6"
                                ]
                                [ Html.label
                                    [ Attr.for "phone-number"
                                    , Attr.class "block font-semibold text-white"
                                    ]
                                    [ Html.text "Phone number" ]
                                , Html.p
                                    [ Attr.id "phone-description"
                                    , Attr.class "text-gray-400"
                                    ]
                                    [ Html.text "Optional" ]
                                ]
                            , Html.div
                                [ Attr.class "mt-2.5"
                                ]
                                [ Html.input
                                    [ Attr.type_ "tel"
                                    , Attr.name "phone-number"
                                    , Attr.id "phone-number"
                                    , Attr.attribute "autocomplete" "tel"
                                    , Attr.attribute "aria-describedby" "phone-description"
                                    , Attr.class "block w-full rounded-md bg-white/5 px-3.5 py-2 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500"
                                    ]
                                    []
                                ]
                            ]
                        , Html.div
                            [ Attr.class "sm:col-span-2"
                            ]
                            [ Html.label
                                [ Attr.for "message"
                                , Attr.class "block text-sm/6 font-semibold text-white"
                                ]
                                [ Html.text "Message" ]
                            , Html.div
                                [ Attr.class "mt-2.5"
                                ]
                                [ Html.textarea
                                    [ Attr.name "message"
                                    , Attr.id "message"
                                    , Attr.required True
                                    , Attr.rows 4
                                    , Attr.class "block w-full rounded-md bg-white/5 px-3.5 py-2 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500"
                                    ]
                                    []
                                ]
                            ]
                        ]
                    , Html.div
                        [ Attr.class "mt-8 flex justify-end"
                        ]
                        [ Html.button
                            [ Attr.type_ "submit"
                            , Attr.class "rounded-md bg-indigo-500 px-3.5 py-2.5 text-center text-sm font-semibold text-white shadow-xs hover:bg-indigo-400 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500"
                            ]
                            [ Html.text "Send message" ]
                        ]
                    ]
                ]
            ]
        ]


header : Html msg
header =
    Html.div
        [ Attr.class "md:flex md:items-center md:justify-between md:space-x-5 p-6"
        ]
        [ Route.Index
            |> Route.link
                [ Attr.class "flex items-start space-x-5"
                ]
                [ Html.div
                    [ Attr.class "shrink-0"
                    ]
                    [ Html.div
                        [ Attr.class "relative"
                        ]
                        [ Html.img
                            [ Attr.class "size-16 rounded-full object-cover"
                            , Attr.src "https://res.cloudinary.com/dillonkearns/image/upload/w_1000,c_fill,ar_1:1,g_auto,r_max,bo_5px_solid_red,b_rgb:262c35/v1742066379/hero-color_oh0rng.jpg"
                            , Attr.alt ""
                            ]
                            []
                        , Html.span
                            [ Attr.class "absolute inset-0 rounded-full shadow-inner"
                            , Attr.attribute "aria-hidden" "true"
                            ]
                            []
                        ]
                    ]
                , {-
                     Use vertical padding to simulate center alignment when both lines of text are one line,
                     but preserve the same layout if the text wraps without making the image jump around.
                  -}
                  Html.div
                    [ Attr.class "pt-1.5"
                    ]
                    [ Html.h1
                        [ Attr.class "text-2xl font-bold text-gray-900"
                        ]
                        [ Html.text "Soir Noir" ]
                    , Html.p
                        [ Attr.class "text-sm font-medium text-gray-500"
                        ]
                        [ Html.text "Santa Barbara based "
                        , Html.a
                            [ --Attr.href "#"
                              Attr.class "text-gray-900"
                            ]
                            [ Html.text "Jazz Band" ]
                        ]
                    ]
                ]
        ]
