{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Model.Data ( User, users1 ) where

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

users1 :: [User]
users1 =
    [
        User "Isaac Clemence" 372 "IsaacClemence@test.io" (fromGregorian 1683 3 1), 
        User "Albert Greg" 136 "mc2@newton.uk" (fromGregorian 1905 12 1)
    ]