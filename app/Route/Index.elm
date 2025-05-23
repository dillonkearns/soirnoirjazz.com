module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import DateFormat
import Effect exposing (Effect)
import Event exposing (Event, Venue)
import FatalError exposing (FatalError)
import Footer
import Head
import Head.Seo as Seo
import Html exposing (Html, div, h2, iframe, p, text)
import Html.Attributes as Attr
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route
import RouteBuilder exposing (App, StatefulRoute, StatelessRoute)
import Shared
import Style
import Svg exposing (path, svg)
import Svg.Attributes as SvgAttr
import Task
import Time
import View exposing (View)


type alias Model =
    { zone : Time.Zone
    }


type Msg
    = GotTimezone Time.Zone


type alias RouteParams =
    {}


type alias Data =
    { events : List Event
    }


type alias ActionData =
    {}


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , subscriptions = \_ _ _ _ -> Sub.none
            , update = update
            }


init :
    App Data ActionData RouteParams
    -> Shared.Model
    -> ( Model, Effect Msg )
init app shared =
    ( { zone = Time.utc
      }
    , Effect.fromCmd (Time.here |> Task.perform GotTimezone)
    )


update :
    App Data ActionData RouteParams
    -> Shared.Model
    -> Msg
    -> Model
    -> ( Model, Effect Msg )
update app shared msg model =
    case msg of
        GotTimezone zone ->
            ( { model | zone = zone }, Effect.none )


data : BackendTask FatalError Data
data =
    BackendTask.succeed Data
        |> BackendTask.andMap
            Event.getEvents


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summaryLarge
        { canonicalUrlOverride = Nothing
        , siteName = "Soir Noir"
        , image =
            -- TODO use this code after deploying to the canonical URL
            --{ url = [ "avatar.png" ] |> Pages.Url.fromPath
            { url = "https://soirnoir.netlify.app/avatar.png" |> Pages.Url.external
            , alt = "Soir Noir"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Soir Noir - Santa Barbara Jazz Band"
        , locale = Nothing
        , title = "Soir Noir - Santa Barbara Jazz Band"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> Model
    -> View (PagesMsg Msg)
view app shared model =
    { title = "Soir Noir - Santa Barbara Jazz Band"
    , body =
        [ Html.div
            [ Attr.class "relative bg-noir-primary"
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
                        [ Html.h1
                            [ Attr.class "mt-12 text-5xl text-pretty sm:mt-10 sm:text-8xl font-heading flex flex-col gap-2 text-center text-gold-light"
                            ]
                            [ Html.span [] [ Html.text "SOIR" ]
                            , Html.span [] [ Html.text "NOIR" ]
                            , Html.span
                                [ Attr.class "text-xl sm:text-2xl  text-white" ]
                                [ Html.text "JAZZ BAND" ]
                            ]
                        , Html.div
                            [ Attr.class "flex justify-center mt-4 mb-6" ]
                            [ Html.img
                                [ Attr.src "/seperator-cropped2.png"
                                , Attr.alt "Decorative separator"
                                , Attr.class "w-48 sm:w-56 md:w-64 opacity-80"
                                ]
                                []
                            ]
                        , Html.p
                            [ Attr.class "mt-8 text-lg font-medium text-text-secondary sm:text-xl text-center"
                            ]
                            [ Html.text "The perfect pairing for Santa Barbara’s finest restaurants, wineries, bars, and private events." ]
                        , Html.div
                            [ Attr.class "mt-10 flex items-center gap-x-6"
                            ]
                            [ Style.elegantRouteButton Route.Contact [ Html.text "INQUIRE ABOUT BOOKING" ]
                            , Style.elegantButton [ Attr.href "#live-clips", Attr.class "uppercase" ]
                                [ Html.text "See Live Clips "
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
                    [ --Cloudinary.responsiveImg
                      --    { altText = "Soir Noir"
                      --    , cloudinaryId = "v1742066379/hero-color_oh0rng.jpg"
                      --    , cssClass = "aspect-3/2 w-full bg-dark-surface object-cover lg:absolute lg:inset-0 lg:aspect-auto lg:h-full"
                      --    , baseSize = 1000
                      --    }
                      Html.img
                        [ Attr.src "/duo.jpg"

                        -- black and white effect
                        , Attr.class "aspect-3/2 w-full bg-dark-surface object-cover lg:absolute lg:inset-0 lg:aspect-auto lg:h-full grayscale contrast-100"
                        ]
                        []
                    ]
                ]
            ]
        , videoSection
        , eventsSection app.data.events model.zone
        , Footer.footer True
        ]
    }


videoEmbed : String -> Html msg
videoEmbed videoId =
    div
        [ Attr.class "w-full aspect-video bg-gray-200 shadow-lg rounded-xl overflow-hidden" ]
        [ iframe
            [ --Attr.class "w-full h-full"
              Attr.src ("https://www.youtube.com/embed/" ++ videoId)
            , Attr.attribute "frameborder" "0"
            , Attr.attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            , Attr.attribute "allowfullscreen" "true"
            , Attr.style "width" "100%"
            , Attr.style "height" "700px"
            ]
            []
        ]


heading2 : String -> String -> Html msg
heading2 text_ id =
    h2
        [ Attr.class "text-5xl text-text-primary uppercase font-heading text-pretty text-center"
        , Attr.id id
        ]
        [ text text_ ]


videoSection : Html msg
videoSection =
    div
        [ Attr.class "mx-auto mt-32 max-w-7xl px-6 sm:mt-56 lg:px-8" ]
        [ div
            [ Attr.class "mx-auto max-w-2xl lg:text-center" ]
            [ heading2 "Live Moments" "live-clips"
            , p
                [ Attr.class "mt-6 text-lg text-text-secondary text-center" ]
                [ text "Get a taste of our sound." ]
            ]
        , div
            [ Attr.class "mx-auto mt-16 max-w-2xl sm:mt-20 lg:mt-24 lg:max-w-none" ]
            [ div
                [ Attr.class "grid max-w-xl grid-cols-1 gap-x-8 gap-y-12 lg:max-w-none grid-cols-1 place-items-center" ]
                [ --youtubeEmbedHorizontal "4-pFT1gSXcA?si=fJ7FquG3ppDNx1pG"
                  youtubeEmbed "goWJH-F1FK8"
                , youtubeEmbed "9wXe_-JZu5A?si=tnr0Ni7pvxM7Z9cZ"

                --, youtubeEmbed "RnJZW9CvYok"
                --, youtubeEmbed "yElkWb_wN60"
                , youtubeEmbed "vyq2MWUOYgs"
                ]
            ]
        ]


eventsSection : List Event -> Time.Zone -> Html msg
eventsSection events zone =
    div
        [ Attr.class "mx-auto mt-32 max-w-7xl px-6 sm:mt-56 lg:px-8" ]
        [ div
            [ Attr.class "mx-auto max-w-2xl lg:text-center text-center" ]
            [ heading2 "Upcoming Shows" "upcoming-shows"
            ]
        , div
            [ Attr.class "mx-auto mt-16 max-w-2xl sm:mt-20 lg:mt-12 lg:max-w-none" ]
            [ eventsView events zone
            ]
        ]


eventView : Time.Zone -> Event -> Html msg
eventView zone event =
    Html.div
        [ Attr.class "mb-8 border border-white border-2 flex p-2 max-w-4xl mx-auto" ]
        [ -- Date box on left side
          Html.div [ Attr.class "w-32 border-r border-gray-700 flex flex-col justify-center items-center p-4" ]
            [ -- Day of week (large)
              Html.div [ Attr.class "text-4xl text-center" ]
                [ Html.text (DateFormat.format [ DateFormat.dayOfWeekNameAbbreviated ] zone event.dateTimeStart) ]

            -- Month and day (with nowrap to prevent breaking)
            , Html.div [ Attr.class "text-3xl font-bold mt-1 text-center" ]
                [ Html.span
                    [ Attr.class "whitespace-nowrap" ]
                    [ Html.text (DateFormat.format [ DateFormat.monthNameAbbreviated, DateFormat.text " ", DateFormat.dayOfMonthNumber ] zone event.dateTimeStart) ]
                ]
            ]
        , -- Content on right side
          Html.div [ Attr.class "flex-1 p-6" ]
            [ -- Venue name
              Html.h3 [ Attr.class "text-2xl font-semibold" ]
                [ (case event.ticketUrl of
                    Just url ->
                        Html.a
                            [ Attr.href url
                            , Attr.attribute "target" "_blank"
                            ]

                    Nothing ->
                        Html.span []
                  )
                    [ Html.text event.location.name ]
                ]

            -- Time (updated with text-right class)
            , Html.div [ Attr.class "mt-2 flex flex-col gap-2  text-right" ]
                [ Html.div [ Attr.class "text-md" ]
                    [ Html.text (formatTime zone event.dateTimeStart ++ " - " ++ formatTime zone event.dateTimeEnd)
                    ]
                , Html.div [ Attr.class "" ]
                    [ Html.a
                        [ Attr.href (Event.addToGoogleCalendarUrl zone event)
                        , Attr.target "_blank"
                        , Attr.class "text-gold-primary hover:text-white"
                        ]
                        [ Html.text "Add to Calendar" ]
                    ]
                ]
            ]
        ]


formatTime : Time.Zone -> Time.Posix -> String
formatTime zone dateTime =
    DateFormat.format
        [ DateFormat.hourFixed
        , DateFormat.text ":"
        , DateFormat.minuteFixed
        , DateFormat.text " "
        , DateFormat.amPmLowercase
        ]
        zone
        dateTime


calendarIcon : Html msg
calendarIcon =
    svg [ SvgAttr.class "size-5 text-text-tertiary fill-gold-primary", SvgAttr.viewBox "0 0 20 20", SvgAttr.fill "currentColor" ]
        [ path [ SvgAttr.d "M5.75 2a.75.75 0 0 1 .75.75V4h7V2.75a.75.75 0 0 1 1.5 0V4h.25A2.75 2.75 0 0 1 18 6.75v8.5A2.75 2.75 0 0 1 15.25 18H4.75A2.75 2.75 0 0 1 2 15.25v-8.5A2.75 2.75 0 0 1 4.75 4H5V2.75A.75.75 0 0 1 5.75 2Zm-1 5.5c-.69 0-1.25.56-1.25 1.25v6.5c0 .69.56 1.25 1.25 1.25h10.5c.69 0 1.25-.56 1.25-1.25v-6.5c0-.69-.56-1.25-1.25-1.25H4.75Z" ] []
        ]


clockIcon : Html msg
clockIcon =
    svg
        [ SvgAttr.fill "none"
        , SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.strokeWidth "1.5"
        , SvgAttr.stroke "currentColor"
        , SvgAttr.class "size-6 text-gold-primary w-5 h-5"
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
        , SvgAttr.class "size-6 text-gold-primary w-5 h-5"
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


eventsView : List Event -> Time.Zone -> Html msg
eventsView events zone =
    Html.div [ Attr.class "flex flex-col items-center" ]
        [ Html.ol [ Attr.class "mt-4 divide-y divide-noir-border text-sm/6 lg:col-span-7 xl:col-span-8 w-full" ]
            (List.map (eventView zone) events)
        ]


twoHours : Int
twoHours =
    2 * 60 * 60 * 1000


googleDriveEmbed : String -> Html msg
googleDriveEmbed driveId =
    Html.div
        [ Attr.class "flex max-w-sm"
        ]
        [ Html.iframe
            [ Attr.src <|
                "https://drive.google.com/file/d/"
                    ++ driveId
                    ++ "/preview"
            , Attr.style "width" "100%"
            , Attr.style "height" "480px"
            , Attr.attribute "allow" "autoplay"
            , Attr.attribute "allowFullScreen" "true"
            ]
            []
        ]


youtubeEmbed : String -> Html msg
youtubeEmbed youtubeId =
    Html.div
        []
        [ Html.iframe
            [ Attr.src <| "https://www.youtube.com/embed/" ++ youtubeId
            , Attr.class "w-full bg-gray-200 shadow-lg rounded-xl overflow-hidden aspect-9/16 grayscale contrast-100"
            , Attr.style "width" "100%"
            , Attr.style "height" "700px"
            , Attr.title "YouTube video player"
            , Attr.attribute "frameborder" "0"
            , Attr.attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
            , Attr.attribute "referrerpolicy" "strict-origin-when-cross-origin"
            , Attr.attribute "allowfullscreen" ""
            ]
            []
        ]


youtubeEmbedHorizontal : String -> Html msg
youtubeEmbedHorizontal youtubeId =
    Html.div
        []
        [ Html.iframe
            [ Attr.src <| "https://www.youtube.com/embed/" ++ youtubeId
            , Attr.class "w-full bg-gray-200 shadow-lg rounded-xl overflow-hidden aspect-16/9 grayscale contrast-100"
            , Attr.style "width" "100%"
            , Attr.style "height" "700px"
            , Attr.title "YouTube video player"
            , Attr.attribute "frameborder" "0"
            , Attr.attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
            , Attr.attribute "referrerpolicy" "strict-origin-when-cross-origin"
            , Attr.attribute "allowfullscreen" ""
            ]
            []
        ]
