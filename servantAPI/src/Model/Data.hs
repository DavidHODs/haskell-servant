{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Model.Data ( User ) where

import Data.Text ()
import Data.Time.Calendar
import GHC.Generics
import Data.Aeson

data User = User {
    name :: String,
    age :: Int,
    email :: String,
    registration_date :: Day
} deriving (Eq, Show, Generic)

instance ToJSON User

