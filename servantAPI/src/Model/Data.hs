{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Model.Data ( User ) where

import Data.Text ()
import Data.Time (UTCTime)

data User = User {
    name :: String,
    age :: Int,
    email :: String,
    registration_date :: UTCTime
}

