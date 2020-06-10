module Fission.App.Creator
  ( module Fission.App.Creator.Class
  , createWithPlaceholder
  ) where

import           Fission.Models
import           Fission.Prelude

import           Fission.App.Content         as AppCID
import           Fission.App.Creator.Class   as App

import           Fission.App.Creator.Class

import           Fission.URL.Subdomain.Types

createWithPlaceholder ::
  ( App.Creator        m
  , AppCID.Initializer m
  )
  => UserId
  -> UTCTime
  -> m (Either Errors (AppId, Subdomain))
createWithPlaceholder ownerId now = do
  defaultCID <- AppCID.placeholder
  create ownerId defaultCID now
