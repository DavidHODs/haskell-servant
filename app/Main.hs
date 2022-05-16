module Main where

import Lib ( someFunc )
import qualified Api.Server as Server (app)
import Network.Wai.Handler.Warp

main :: IO ()
main = do
    putStrLn "server running on port 8080"
    run 8080 Server.app