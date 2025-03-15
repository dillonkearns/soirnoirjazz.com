module Event exposing (Event, Venue, addToGoogleCalendarUrl)

import DateFormat
import Time exposing (Posix, Zone)
import Url


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
    , googleMapsNameWithAddress : String
    , webSite : Maybe String -- if the venue has a web site
    }


formatGoogleTime : Time.Zone -> Time.Posix -> String
formatGoogleTime zone posix =
    DateFormat.format
        [ DateFormat.yearNumber
        , DateFormat.monthFixed
        , DateFormat.dayOfMonthFixed
        , DateFormat.text "T"
        , DateFormat.hourMilitaryFixed
        , DateFormat.minuteFixed
        , DateFormat.secondFixed
        ]
        zone
        posix


addToGoogleCalendarUrl : Time.Zone -> Event -> String
addToGoogleCalendarUrl zone event =
    let
        detailsParam =
            case event.ticketUrl of
                Just url ->
                    "&details=" ++ Url.percentEncode ("More info: " ++ url)

                Nothing ->
                    ""
    in
    "https://calendar.google.com/calendar/render?action=TEMPLATE"
        ++ "&text="
        ++ Url.percentEncode event.name
        ++ "&dates="
        ++ formatGoogleTime zone event.dateTimeStart
        ++ "/"
        ++ formatGoogleTime zone event.dateTimeEnd
        ++ "&location="
        ++ Url.percentEncode event.location.googleMapsNameWithAddress
        ++ detailsParam
