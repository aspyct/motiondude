{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Main where

import Control.Applicative ((<$>), optional)
import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Data.Text.Lazy (unpack)
import Happstack.Lite
import Text.Blaze.Html5 (Html, (!), a, form, input, h1, p, toHtml, label)
import Text.Blaze.Html5.Attributes (action, enctype, href, name, size, type_, value)

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

main :: IO ()
main = serve Nothing myApp

myApp :: ServerPart Response
myApp = msum
    [   dir "echo" $ echo,
        homePage
    ]

homePage :: ServerPart Response
homePage =
    ok $ template "home page" $ do
        h1 "Hello world"
        p "Haskell programming is wild !"

echo :: ServerPart Response
echo =
    path $ \(msg :: String) ->
        ok $ template "echo" $ do
            h1 "Echo service"
            p "Giant, Haskell style Papagallo"
            p $ toHtml msg


template :: Text -> Html -> Response
template title body = toResponse $
    H.html $ do
        H.head $ do
            H.title (toHtml title)
        H.body $ do
            body
            p $ a ! href "/" $ "back home"

