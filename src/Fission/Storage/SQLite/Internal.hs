{-# OPTIONS_GHC -fno-warn-deprecations #-}

module Fission.Storage.SQLite.Internal (traceAll) where

import RIO

import Control.Lens (makeLenses)
import Data.Has
import Database.Selda
import Database.Selda.SQLite

import Fission.Config (DBPool)

traceAll :: (Show a, Relational a) => Table a -> IO ()
traceAll tbl = withSQLite "ipfs-api.sqlite" do
  rows <- query (select tbl)
  forM_ rows (traceIO . textDisplay . displayShow)