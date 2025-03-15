module Route.Index exposing (ActionData, Data, Model, Msg, route)

--import Html

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Footer
import Head
import Head.Seo as Seo
import Html exposing (Html, div, h2, iframe, p, text)
import Html.Attributes as Attr
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import Svg exposing (path, svg)
import Svg.Attributes as SvgAttr
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    { message : String
    }


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.succeed Data
        |> BackendTask.andMap
            (BackendTask.succeed "Hello!")


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "Dillon Kearns - Santa Barbara Jazz Pianist"
        , image =
            { url = [ "keyboard.svg" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "Dillon Kearns"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Dillon Kearns Jazz Piano"
        , locale = Nothing
        , title = "Dillon Kearns - Santa Barbara Jazz Pianist"
        }
        |> Seo.website


pianoPhotoId =
    --"photo-1596671516605-c14a1f351c33"
    "photo-1545873494-055618a61ab1"


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "elm-pages is running"
    , body =
        [ -- Html.h1 [] [ Html.text "elm-pages is up and running!" ]
          --, Html.p []
          --    [ Html.text <| "The message is: " ++ app.data.message
          --    ]
          --, Route.Blog__Slug_ { slug = "hello" }
          --    |> Route.link [] [ Html.text "My blog post" ]
          Html.div
            [ Attr.class "relative bg-white"
            ]
            [ Html.div
                [ Attr.class "mx-auto max-w-7xl lg:grid lg:grid-cols-12 lg:gap-x-8 lg:px-8"
                ]
                [ Html.div
                    [ Attr.class "px-6 pt-10 pb-24 sm:pb-32 lg:col-span-7 lg:px-0 lg:pt-40 lg:pb-48 xl:col-span-6"
                    ]
                    [ Html.div
                        [ Attr.class "mx-auto max-w-lg lg:mx-0"
                        ]
                        [ Html.img
                            --[ Attr.class "h-11"
                            [ Attr.class "h-8"
                            , Attr.src "https://svgsilh.com/svg/25711.svg"
                            , Attr.alt "Your Company"
                            ]
                            []
                        , Html.div
                            [ Attr.class "hidden sm:mt-32 sm:flex lg:mt-16"
                            ]
                            [ Html.div
                                [ Attr.class "relative rounded-full px-3 py-1 text-sm/6 text-gray-500 ring-1 ring-gray-900/10 hover:ring-gray-900/20"
                                ]
                                [ Html.text "  Next Event: Fox Wine Co., Sunday, March 23, 5:00–7:00 PM. "
                                , Html.a
                                    [ Attr.href "#upcoming-shows"
                                    , Attr.class "font-semibold whitespace-nowrap text-indigo-600"
                                    ]
                                    [ Html.span
                                        [ Attr.class "absolute inset-0"
                                        , Attr.attribute "aria-hidden" "true"
                                        ]
                                        []
                                    , Html.text "See Upcoming Shows "
                                    , Html.span
                                        [ Attr.attribute "aria-hidden" "true"
                                        ]
                                        [ Html.text "→" ]
                                    ]
                                ]
                            ]
                        , Html.h1
                            [ Attr.class "mt-12 text-5xl font-semibold tracking-tight text-pretty text-gray-900 sm:mt-10 sm:text-7xl"
                            ]
                            [ Html.text "Dillon Kearns Jazz Pianist" ]
                        , Html.p
                            [ Attr.class "mt-8 text-lg font-medium text-gray-600 sm:text-xl" ]
                            [ Html.text "Adding charm and character to Santa Barbara’s restaurants, wineries, bars, and private events through timeless Jazz Standards." ]
                        , Html.ul
                            [ Attr.class "mt-6 space-y-1.5 text-lg text-gray-600 sm:text-xl" ]
                            [ Html.li [ Attr.class "before:content-['•'] before:mr-1.5 before:text-indigo-500 font-normal" ]
                                [ Html.text "Intimate solo piano" ]
                            , Html.li [ Attr.class "before:content-['•'] before:mr-1.5 before:text-indigo-500 font-normal" ]
                                [ Html.text "Dynamic duos with Jazz vocalists and instrumentalists" ]
                            , Html.li [ Attr.class "before:content-['•'] before:mr-1.5 before:text-indigo-500 font-normal" ]
                                [ Html.text "Jazz combos" ]
                            ]
                        , Html.div
                            [ Attr.class "mt-10 flex items-center gap-x-6"
                            ]
                            [ Route.Contact
                                |> Route.link
                                    [ Attr.class "rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                                    ]
                                    [ Html.text "Inquire About Booking" ]
                            , Html.a
                                [ Attr.href "#event-clips"
                                , Attr.class "text-sm/6 font-semibold text-gray-900"
                                ]
                                [ Html.text "See Event Clips "
                                , Html.span
                                    [ Attr.attribute "aria-hidden" "true"
                                    ]
                                    [ Html.text "→" ]
                                ]
                            ]
                        ]
                    ]
                , Html.div
                    [ Attr.class "relative lg:col-span-5 lg:-mr-8 xl:absolute xl:inset-0 xl:left-1/2 xl:mr-0"
                    ]
                    [ Html.img
                        [ Attr.class "aspect-3/2 w-full bg-gray-50 object-cover lg:absolute lg:inset-0 lg:aspect-auto lg:h-full"
                        , Attr.src "https://res.cloudinary.com/dillonkearns/image/upload/c_limit,f_auto,h_1433,q_auto:good/v1742066379/hero-color_oh0rng.jpg"
                        , Attr.alt ""
                        ]
                        []
                    ]
                ]
            ]
        , videoSection
        , eventsSection
        , Footer.footer True
        ]
    }


videoEmbed : String -> Html msg
videoEmbed videoId =
    div
        [ Attr.class "w-full aspect-video bg-gray-200 shadow-lg rounded-xl overflow-hidden" ]
        [ iframe
            [ Attr.class "w-full h-full"
            , Attr.src ("https://www.youtube.com/embed/" ++ videoId)
            , Attr.attribute "frameborder" "0"
            , Attr.attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            , Attr.attribute "allowfullscreen" "true"
            ]
            []
        ]


videoSection : Html msg
videoSection =
    div
        [ Attr.class "mx-auto mt-32 max-w-7xl px-6 sm:mt-56 lg:px-8" ]
        [ div
            [ Attr.class "mx-auto max-w-2xl lg:text-center" ]
            [ h2
                [ Attr.class "text-3xl font-semibold tracking-tight text-gray-900 sm:text-4xl"
                , Attr.id "event-clips"
                ]
                [ text "Event Clips" ]
            , p
                [ Attr.class "mt-6 text-lg text-gray-600" ]
                [ text "Get a feel for the vibe with recent live clips." ]
            ]
        , div
            [ Attr.class "mx-auto mt-16 max-w-2xl sm:mt-20 lg:mt-24 lg:max-w-none" ]
            [ div
                [ --Attr.class "grid max-w-xl grid-cols-1 gap-x-8 gap-y-12 lg:max-w-none lg:grid-cols-3"
                  -- single centered item for now
                  Attr.class "grid max-w-xl grid-cols-1 gap-x-8 gap-y-12 lg:max-w-none grid-cols-1 place-items-center"
                ]
                [ googleDriveEmbed "1g1xZb8DNxnxHMQ5kzd6idQkEhJ-O4q7U"

                --videoEmbed "8c0uz2FoKS8"
                ]
            ]
        ]


eventsSection : Html msg
eventsSection =
    div
        [ Attr.class "mx-auto mt-32 max-w-7xl px-6 sm:mt-56 lg:px-8" ]
        [ div
            [ Attr.class "mx-auto max-w-2xl lg:text-center" ]
            [ h2
                [ Attr.class "text-3xl font-semibold tracking-tight text-gray-900 sm:text-4xl"
                , Attr.id "upcoming-shows"
                ]
                [ text "Upcoming Shows" ]
            ]
        , div
            [ Attr.class "mx-auto mt-8 max-w-2xl sm:mt-20 lg:mt-12 lg:max-w-none" ]
            [ eventsView
            ]
        ]


type alias Event =
    { name : String
    , imageUrl : String
    , dateTime : String
    , timeRange : String
    , dateTimeISO : String
    , location : Venue
    , eventLink : Maybe String
    }


eventView : Event -> Html msg
eventView event =
    Html.li [ Attr.class "relative flex gap-x-6 py-6 xl:static" ]
        [ --Html.img
          --    [ Attr.src event.imageUrl
          --    , Attr.class "size-14 flex-none rounded-full"
          --    , Attr.alt ""
          --    ]
          --    [],
          Html.div [ Attr.class "flex-auto" ]
            [ Html.h3 [ Attr.class "pr-10 font-semibold text-gray-900 xl:pr-0" ]
                [ Html.a
                    (case event.eventLink of
                        Just url ->
                            [ Attr.href url
                            , Attr.attribute "target" "_blank"
                            ]

                        Nothing ->
                            []
                    )
                    [ Html.text event.name
                    ]
                ]
            , Html.dl [ Attr.class "mt-2 flex flex-col text-gray-500 xl:flex-row" ]
                [ Html.div [ Attr.class "flex items-start gap-x-3" ]
                    [ Html.dt [ Attr.class "mt-0.5" ]
                        [ calendarIcon
                        ]
                    , Html.dd [] [ Html.time [ Attr.datetime event.dateTimeISO ] [ Html.text event.dateTime ] ]
                    ]
                , Html.div [ Attr.class "mt-2 flex items-start gap-x-3 xl:mt-0 xl:ml-3.5 xl:border-l xl:border-gray-400/50 xl:pl-3.5" ]
                    [ Html.dt [ Attr.class "mt-0.5" ]
                        [ clockIcon ]
                    , Html.dd [] [ Html.time [ Attr.datetime event.dateTimeISO ] [ Html.text event.timeRange ] ]
                    ]
                , Html.div [ Attr.class "mt-2 flex items-start gap-x-3 xl:mt-0 xl:ml-3.5 xl:border-l xl:border-gray-400/50 xl:pl-3.5" ]
                    [ Html.dt [ Attr.class "mt-0.5" ]
                        [ mapIcon ]
                    , Html.dd []
                        [ Html.a [ Attr.href event.location.googleMaps ]
                            [ Html.text event.location.name
                            ]
                        ]
                    ]
                ]
            ]
        ]


calendarIcon : Html msg
calendarIcon =
    svg [ SvgAttr.class "size-5 text-gray-400 fill-indigo-600", SvgAttr.viewBox "0 0 20 20", SvgAttr.fill "currentColor" ]
        [ path [ SvgAttr.d "M5.75 2a.75.75 0 0 1 .75.75V4h7V2.75a.75.75 0 0 1 1.5 0V4h.25A2.75 2.75 0 0 1 18 6.75v8.5A2.75 2.75 0 0 1 15.25 18H4.75A2.75 2.75 0 0 1 2 15.25v-8.5A2.75 2.75 0 0 1 4.75 4H5V2.75A.75.75 0 0 1 5.75 2Zm-1 5.5c-.69 0-1.25.56-1.25 1.25v6.5c0 .69.56 1.25 1.25 1.25h10.5c.69 0 1.25-.56 1.25-1.25v-6.5c0-.69-.56-1.25-1.25-1.25H4.75Z" ] []
        ]


clockIcon : Html msg
clockIcon =
    svg
        [ SvgAttr.fill "none"
        , SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.strokeWidth "1.5"
        , SvgAttr.stroke "currentColor"
        , SvgAttr.class "size-6 text-indigo-600 w-5 h-5"
        ]
        [ path
            [ SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.d "M12 6v6h4.5m4.5 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
            ]
            []
        ]


mapIcon : Html msg
mapIcon =
    svg
        [ SvgAttr.fill "none"
        , SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.strokeWidth "1.5"
        , SvgAttr.stroke "currentColor"
        , SvgAttr.class "size-6 text-indigo-600 w-5 h-5"
        ]
        [ path
            [ SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.d "M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"
            ]
            []
        , path
            [ SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.d "M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z"
            ]
            []
        ]



-- Event List View


eventsView : Html msg
eventsView =
    Html.ol [ Attr.class "mt-4 divide-y divide-gray-100 text-sm/6 lg:col-span-7 xl:col-span-8" ]
        [ eventView
            { name = "Dillon Kearns & Brandon Kinalele Piano and Guitar Duo"
            , imageUrl = "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
            , dateTime = "Sunday, March 27"
            , timeRange = "5:00PM - 7:00PM"
            , dateTimeISO = "2025-01-10T17:00"
            , location = foxWine
            , eventLink = Nothing
            }
        , eventView
            { name = "SBCC Lunch Break Big Band"
            , imageUrl = "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?crop=faces&fit=crop&h=256&w=256"
            , dateTime = "Monday, April 14"
            , timeRange = "7:00pm"
            , dateTimeISO = "2022-02-15T15:00"
            , location = soho
            , eventLink = Just "https://www.sohosb.com/events/sbcc-student-big-band-soho-santabarbara-4"
            }
        ]


googleDriveEmbed : String -> Html msg
googleDriveEmbed driveId =
    Html.div
        [ Attr.style "height" "640px"
        , Attr.style "width" "100%"
        , Attr.class "flex max-w-sm"
        ]
        [ Html.iframe
            [ Attr.src <|
                "https://drive.google.com/file/d/"
                    ++ driveId
                    ++ "/preview"
            , Attr.style "height" "640px"
            , Attr.style "width" "100%"
            , Attr.attribute "allow" "autoplay"
            , Attr.attribute "allowFullScreen" "true"
            ]
            []
        ]


type alias Venue =
    { name : String
    , googleMaps : String
    }


soho : Venue
soho =
    { name = "SOhO Restaurant & Music Club"
    , googleMaps = "https://maps.app.goo.gl/hE8SL3xcRVzJUBe46"
    }


foxWine : Venue
foxWine =
    { name = "Fox Wine Co."
    , googleMaps = "https://maps.app.goo.gl/ToVrHzafPSpB3dSQ8"
    }
