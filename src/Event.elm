module Event exposing (Event, Venue, addToGoogleCalendarUrl, getEvents, googleMapsUrl)

import BackendTask exposing (BackendTask)
import BackendTask.Env
import BackendTask.Http
import DateFormat
import FatalError exposing (FatalError)
import Iso8601
import Json.Decode as Decode exposing (Decoder)
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


eventsDecoder : Decoder (List Event)
eventsDecoder =
    Decode.field "records" (Decode.list (Decode.field "fields" recordDecoder))


recordDecoder : Decoder Event
recordDecoder =
    let
        decodeVenue : String -> String -> Venue
        decodeVenue venueName googleMapsNameWithAddress =
            { name = venueName
            , googleMapsNameWithAddress = googleMapsNameWithAddress
            , webSite = Nothing -- TODO
            }

        decodeEndTime : Posix -> Int -> Posix
        decodeEndTime startTime durationSecs =
            Time.millisToPosix (Time.posixToMillis startTime + (durationSecs * 1000))
    in
    Decode.map5 Event
        (Decode.field "Event Title" Decode.string)
        (Decode.field "Start Date/Time" Iso8601.decoder)
        (Decode.map2 decodeEndTime
            (Decode.field "Start Date/Time" Iso8601.decoder)
            (Decode.field "Duration" Decode.int)
        )
        venueDecoder
        (Decode.succeed Nothing {- TODO -})


venueDecoder : Decoder Venue
venueDecoder =
    Decode.map3 Venue
        (Decode.field "Venue Name" (Decode.index 0 Decode.string))
        (Decode.field "Google Maps Location" (Decode.index 0 Decode.string))
        (Decode.succeed Nothing {- TODO -})


getEvents : BackendTask FatalError (List Event)
getEvents =
    BackendTask.Env.expect "AIRTABLE_JAZZ_TOKEN"
        |> BackendTask.allowFatal
        |> BackendTask.andThen
            (\airTableToken ->
                BackendTask.Http.getWithOptions
                    { url = "https://api.airtable.com/v0/appNxan3bXZ81sXQn/Events?maxRecords=3&view=Grid%20view&maxRecords=10"
                    , timeoutInMs = Nothing
                    , retries = Nothing
                    , cachePath = Nothing
                    , cacheStrategy = Nothing
                    , expect = BackendTask.Http.expectJson eventsDecoder
                    , headers = [ ( "Authorization", "Bearer " ++ airTableToken ) ]
                    }
                    |> BackendTask.allowFatal
            )


googleMapsUrl : Event -> String
googleMapsUrl event =
    "https://www.google.com/maps/search/?api=1&query=" ++ Url.percentEncode event.location.googleMapsNameWithAddress
