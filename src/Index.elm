module Index exposing (htmlToReinject, index)

import Html.String exposing (..)
import Html.String.Attributes exposing (..)
import Html.String.Extra exposing (..)
import Main
import Starter.ConfMeta
import Starter.Flags
import Starter.Icon
import Starter.SnippetCss
import Starter.SnippetHtml
import Starter.SnippetJavascript


index : Starter.Flags.Flags -> Html msg
index flags =
    html
        [ lang "en" ]
        [ head []
            ([]
                ++ [ title_ [] [ text <| Main.conf.title ]
                   , meta [ charset "utf-8" ] []
                   , meta [ name "author", content Main.conf.author ] []
                   , meta [ name "description", content Main.conf.description ] []
                   , meta [ name "viewport", content "width=device-width, initial-scale=1, shrink-to-fit=no" ] []
                   , meta [ httpEquiv "x-ua-compatible", content "ie=edge" ] []
                   , link [ rel "icon", href (Starter.Icon.iconFileName 64) ] []
                   , link [ rel "apple-touch-icon", href (Starter.Icon.iconFileName 152) ] []
                   , style_ []
                        [ text <| """
                            body 
                                { background-color: """ ++ Main.conf.themeColor ++ """
                                ; font-family: 'IBM Plex Sans', helvetica, sans-serif
                                ; margin: 0px;
                                }""" ]
                   ]
                ++ Starter.SnippetHtml.messagesStyle
                ++ Starter.SnippetHtml.pwa Main.conf
                ++ Starter.SnippetHtml.previewCards Main.conf
            )
        , body [] <| htmlToReinject flags
        ]


htmlToReinject : Starter.Flags.Flags -> List (Html.String.Html msg)
htmlToReinject flags =
    []
        -- Friendly message in case Javascript is disabled
        ++ (if flags.env == "dev" then
                Starter.SnippetHtml.messageYouNeedToEnableJavascript

            else
                Starter.SnippetHtml.messageEnableJavascriptForBetterExperience
           )
        -- Initializing "window.ElmStarter" global object
        ++ [ Html.String.Extra.script []
                [ Html.String.textUnescaped <|
                    Starter.SnippetJavascript.metaInfo
                        { gitBranch = flags.gitBranch
                        , gitCommit = flags.gitCommit
                        , env = flags.env
                        , version = flags.version
                        }
                ]
           ]
        -- Loading Elm code
        ++ [ Html.String.Extra.script [ Html.String.Attributes.src "/elm.js" ] [] ]
        -- Elm finished to load, de-activating the "Loading..." message
        -- ++ Starter.SnippetHtml.messageLoadingOff
        -- Loading utility for pretty console formatting
        ++ Starter.SnippetHtml.prettyConsoleFormatting flags.env
        -- Signature "Made with ❤ and Elm"
        ++ [ Html.String.Extra.script [] [ Html.String.textUnescaped Starter.SnippetJavascript.signature ] ]
        -- Let's start Elm!
        ++ [ Html.String.Extra.script []
                [ Html.String.textUnescaped
                    ("""
                        // Need to remove this node otherwise Elm doesn't work
                        // because it seems that Elm detect that a similar part
                        // of the DOM already exists and it trys to hydrate, but
                        // the code is buggy.
                        // Infact, not removing this node, the links in the
                        // application reload the browser also if they are
                        // internal.

                        var node = document.getElementById('elm');
                        if (node) { node.remove(); }

                        window.ElmApp = Elm.Main.init(
                            { flags:
                                { commit: ElmStarter.commit
                                , branch: ElmStarter.branch
                                , env: ElmStarter.env
                                , version: ElmStarter.version
                                , versionElmStarter: ElmStarter.versionElmStarter
                                , width: window.innerWidth
                                , height: window.innerHeight
                                , languages: window.navigator.userLanguages || window.navigator.languages || []
                                , locationHref: location.href
                                }
                            }
                        );"""
                        ++ Starter.SnippetJavascript.portChangeMeta
                    )
                ]
           ]
        -- Register the Service Worker, we are a PWA!
        ++ [ Html.String.Extra.script [] [ Html.String.textUnescaped Starter.SnippetJavascript.registerServiceWorker ] ]
