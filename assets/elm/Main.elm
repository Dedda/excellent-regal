module Main exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Html exposing (..)

-- MAIN


main : Program Never Model Msg
main = 
    Html.program 
        {
          init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }

type alias Model =
    { quote: String    
    }

type Msg = GetQuote


init : (Model, Cmd Msg)
init =
  (Model "Wat?", Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GetQuote ->
            ( { model | quote = model.quote ++ " Woot?" }, Cmd.none )

view : Model -> Html Msg
view model =
    div [] [
        p [] [ text "Ja moin!" ],
        p [] [ text model.quote ],
        button [ class "btn btn-success", onClick GetQuote ] [ text "Grab a quote!" ]

    ]