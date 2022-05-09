{-# LANGUAGE ScopedTypeVariables #-}
module Mod where


import GHC.Base
import Prelude
import Data.Maybe


transformM :: Num a => Maybe a -> a -> Maybe a
transformM mx y = mx >>= (\x -> Just $ x + y) >>= (\x -> Just $ x + 10 )

transform :: Num a => Maybe a -> a -> Maybe a
transform mx y = do
    firstStep <- mx + y 
    return $ Just firstStep + 10