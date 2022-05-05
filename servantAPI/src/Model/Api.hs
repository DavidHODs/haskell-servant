{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Model.Api ( User, testFunc ) where

import Data.Text ()
import Data.Time (UTCTime)
-- import Servant.API

data User = User {
    name :: String,
    age :: Int,
    email :: String,
    registration_date :: UTCTime
}

testFunc :: IO()
testFunc = do
    putStrLn "what is your name"
    name <- getLine
    let fullset = "he said his name is " ++ name
    putStrLn fullset
