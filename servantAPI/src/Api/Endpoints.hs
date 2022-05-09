module Api.Endpoints 
    (users, user1, user2, position, hello, marketing, getFileContent, createFileContent) where

import Servant
import Data.List
import Data.Time.Calendar
import GHC.Generics
import Data.Maybe
import Control.Monad.Reader

import qualified Model.Data as Data (User(..), ClientInfo(..), Email(..), Position(..), Email(..), HelloMessage(..), FileContent(..))
import qualified Api.Controllers as Controllers (emailForClient, writeContent)

users :: [Data.User]
users =
    [
    user1,
    user2 
    ]

user1 :: Data.User
user1 = Data.User "Isaac Clemence" 372 "IsaacClemence@test.io" (fromGregorian 1683 3 1)

user2 :: Data.User
user2 = Data.User "Albert Greg" 136 "mc2@newton.uk" (fromGregorian 1905 12 1)

position :: Int -> Int -> Handler Data.Position
position x y = return (Data.Position x y)

hello :: Maybe String -> Handler Data.HelloMessage
hello mname = return . Data.HelloMessage $ case mname of
    Nothing -> "Hello, anonymous user"
    Just n -> "Hello, " ++ n

marketing :: Data.ClientInfo -> Handler Data.Email
marketing ci = return (Controllers.emailForClient ci)

getFileContent :: IO [Data.FileContent]
getFileContent = do
    fileContent1 <- liftIO (readFile "dummy.txt")
    fileContent2 <- liftIO (readFile "file.txt")
    return [
        Data.FileContent fileContent1,
        Data.FileContent fileContent2
        ]

-- createFileContent :: String -> Data.FileContent
-- createFileContent con = Controllers.writeContent con

createFileContent :: String -> Data.FileContent
createFileContent con = return Data.FileContent con