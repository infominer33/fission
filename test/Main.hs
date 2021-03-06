module Main (main) where

import           Test.Fission.Prelude
import qualified Test.Fission.Random

import qualified Test.Fission.User.DID as DID

import qualified Test.Fission.Web.Ping as Web.Ping
import qualified Test.Fission.Web.Auth as Web.Auth

main :: IO ()
main = defaultMain =<< tests

tests :: IO TestTree
tests =
  testGroup "Fission Specs" <$> sequence
    [ Web.Auth.tests
    , Web.Ping.tests
    , DID.tests
    , Test.Fission.Random.tests
    ]
