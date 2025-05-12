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
    { title = "Soir Noir | Bookings & Contact"
    , body =
        [ pageWrapper
            [ pageHeader
            , bandImage
            , bookingTitle
            , contactForm
            ]
        , Footer.footer True
        ]
    }


pageWrapper : List (Html msg) -> Html msg
pageWrapper content =
    Html.div
        [ Attr.class "flex flex-col min-h-screen bg-noir-primary text-gold-light font-serif"
        ]
        [ Html.div [ Attr.class "flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-12 flex flex-col items-center" ] content
        ]


pageHeader : Html msg
pageHeader =
    Html.div
        [ Attr.class "flex flex-col items-center w-full py-8 sm:py-12"
        ]
        [ -- highlight-start
          Html.h1
            [ Attr.class "text-5xl sm:text-7xl font-heading text-center text-gold-light" -- Slightly smaller font, horizontal by default
            ]
            [ Html.text "SOIR NOIR" ]

        --, Html.p
        --    -- "JAZZ BAND" as a separate line below
        --    [ Attr.class "text-xl sm:text-2xl text-white text-center mt-1 sm:mt-2"
        --    ]
        --    [ Html.text "JAZZ BAND" ]
        -- highlight-end
        , Html.div
            [ Attr.class "flex justify-center mt-4 mb-6" ]
            [ Html.img
                [ Attr.src "/seperator-cropped2.png"
                , Attr.alt "Decorative separator"
                , Attr.class "w-48 sm:w-56 md:w-64 opacity-80"
                ]
                []
            ]
        ]


bandImage : Html msg
bandImage =
    Html.div
        [ Attr.class "my-8 sm:my-12 flex justify-center w-full"
        ]
        [ Html.img
            [ Attr.src "/duo.jpg"
            , Attr.alt "Soir Noir Jazz Band performing"
            , Attr.class "w-full max-w-3xl h-auto object-cover filter grayscale contrast-125 brightness-90"
            ]
            []
        ]


bookingTitle : Html msg
bookingTitle =
    Html.div
        [ Attr.class "text-center mt-8 mb-6 sm:mt-12 sm:mb-10 w-full"
        ]
        [ Html.h2
            [ Attr.class "text-3xl sm:text-4xl font-semibold text-gold-light uppercase tracking-wider mb-2 font-serif"
            ]
            [ Html.text "BOOKINGS" ]
        , Html.p
            -- highlight-start
            [ Attr.class "text-lg text-white uppercase tracking-widest font-light" -- Changed to text-white

            -- highlight-end
            ]
            [ Html.text "CONTACT FORM" ]
        ]


contactForm : Html msg
contactForm =
    Html.div
        [ Attr.class "flex justify-center w-full"
        ]
        [ Html.form
            [ Attr.attribute "action" "https://usebasin.com/f/1af1dfb3e14e"
            , Attr.method "POST"
            , Attr.id "contact-form"
            , Attr.attribute "enctype" "multipart/form-data"
            , Attr.class "w-full max-w-md space-y-6"
            ]
            [ formField "name" "Name" "text" True Nothing
            , formField "email" "Email" "email" True Nothing
            , formField "venue" "Venue" "text" False (Just "Optional: Event Location / Venue Name") -- isRequired is False
            , formField "message" "Message" "textarea" True Nothing
            , Html.div
                [ Attr.class "pt-6"
                ]
                [ Html.button
                    [ Attr.type_ "submit"
                    , Attr.class """
                        w-full inline-flex justify-center py-3 px-4 border border-gold-light shadow-sm
                        text-base font-medium rounded-none text-noir-primary bg-gold-light
                        hover:bg-gold-light/90 focus:outline-none focus:ring-2 focus:ring-offset-2
                        focus:ring-offset-noir-primary focus:ring-gold-light uppercase tracking-wider font-serif
                      """
                    ]
                    [ Html.text "Send Message" ]
                ]
            ]
        ]


formField : String -> String -> String -> Bool -> Maybe String -> Html msg
formField fieldId labelText inputType isRequired maybePlaceholder =
    Html.div []
        [ -- highlight-start
          Html.div
            -- Wrapper for label text and "Optional" indicator
            [ Attr.class "flex justify-between items-baseline mb-1"
            ]
            [ Html.label
                [ Attr.for fieldId

                -- Label text is now white
                , Attr.class "text-sm font-medium text-white uppercase tracking-wider"
                ]
                [ Html.text labelText ]
            , if not isRequired then
                Html.span
                    -- "Optional" text styling
                    [ Attr.class "text-xs text-gold-light opacity-70 font-normal normal-case"
                    ]
                    [ Html.text "Optional" ]

              else
                Html.span [] []

            -- Empty span to keep flex alignment if needed, or remove
            ]

        -- highlight-end
        , Html.div
            [ Attr.class "mt-1"
            ]
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
        [ "block w-full bg-black/50 border border-gold-light rounded-none px-3 py-2"
        , "text-base text-gray-100 placeholder-gray-500"
        , "focus:outline-none focus:ring-1 focus:ring-gold-light focus:border-gold-light"
        , "shadow-inner"
        ]
