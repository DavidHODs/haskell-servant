module Lib where

import qualified Model.Api as Api ( testFunc )

someFunc :: IO ()
someFunc = putStrLn "someFunc"

functions :: IO ()
functions = 
    Api.testFunc