module Event exposing (Event, Venue, addToGoogleCalendarUrl, baseUrl)

import DateFormat exposing (Token(..), format)
import Time exposing (Posix, Zone)
import Url.Builder exposing (absolute)


type alias Event =
    { name : String
    , dateTimeStart : Time.Posix
    , dateTimeEnd : Time.Posix
    , location : Venue
    , ticketUrl : Maybe String -- link to the ticket page if available
    }


type alias Venue =
    { name : String
    , googleMapsUrl : String
    , webSite : Maybe String -- if the venue has a web site
    }


addToGoogleCalendarUrl : Time.Zone -> Event -> String
addToGoogleCalendarUrl zone event =
    let
        formatTime : Time.Posix -> String
        formatTime =
            format
                [ DateFormat.yearNumber
                , DateFormat.monthFixed
                , DateFormat.dayOfMonthFixed
                , DateFormat.text "T"
                , DateFormat.hourMilitaryFixed
                , DateFormat.minuteFixed
                , DateFormat.secondFixed
                ]
                zone

        formattedStart : String
        formattedStart =
            formatTime event.dateTimeStart

        formattedEnd : String
        formattedEnd =
            formatTime event.dateTimeEnd

        detailsParam =
            event.ticketUrl
                |> Maybe.map
                    (\url ->
                        [ Url.Builder.string
                            "details"
                            ("More info: " ++ url)
                        ]
                    )
                |> Maybe.withDefault []

        params =
            [ Url.Builder.string "action" "TEMPLATE"
            , Url.Builder.string "text" event.name
            , Url.Builder.string "dates" (formattedStart ++ "/" ++ formattedEnd)
            , Url.Builder.string "location" event.location.name
            ]
                ++ detailsParam
    in
    absolute [ baseUrl ] params


baseUrl : String
baseUrl =
    "https://calendar.google.com/calendar/render"
