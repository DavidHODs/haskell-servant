{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Unused LANGUAGE pragma" #-}

module Api.Server (app) where

import Prelude ()
import Prelude.Compat
import Control.Monad.Except
import Control.Monad.Reader
import Data.Aeson
import Data.Aeson.Types
import Data.Attoparsec.ByteString
import Data.ByteString (ByteString)
import Data.List
import Data.Maybe
import Data.String.Conversions
import Data.Time.Calendar
import GHC.Generics
import Lucid
import Network.HTTP.Media ((//), (/:))
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import System.Directory
import Text.Blaze
import Text.Blaze.Html.Renderer.Utf8
import Servant.Types.SourceT (source)
import qualified Data.Aeson.Parser
import Text.Blaze.Html

import qualified Model.Data as Data (User, ClientInfo, HelloMessage, Email, Position, FileContent)
import qualified Api.Endpoints as EndPoints (users, user1, user2, hello, marketing, position, getFileContent, createFileContent)

type UserAPI = "users" :> Get '[JSON] [Data.User]
    :<|> "user1" :> Get '[JSON] Data.User
    :<|> "user2" :> Get '[JSON] Data.User

data SortBy = Age | Name

type PositionMarketingAPI = "position" :> Capture "x" Int :> Capture "y" Int :> Get '[JSON] Data.Position
    :<|> "hello" :> QueryParam "name" String :> Get '[JSON] Data.HelloMessage
    :<|> "marketing" :> ReqBody '[JSON] Data.ClientInfo :> Post '[JSON] Data.Email

type FileContentAPI = "get" :> "files.txt" :> Get '[JSON] [Data.FileContent]
                    -- :<|> "create" :> "file.txt" :> ReqBody '[JSON] Data.FileContent :> Post '[JSON] Data.FileContent


server1 :: Server UserAPI
server1 = return EndPoints.users
    :<|> return EndPoints.user1
    :<|> return EndPoints.user2

server2 :: Server PositionMarketingAPI
server2 = EndPoints.position
        :<|> EndPoints.hello
        :<|> EndPoints.marketing

server3 :: Server FileContentAPI
server3 = liftIO EndPoints.getFileContent
        -- :<|> EndPoints.createFileContent

userAPI :: Proxy UserAPI
userAPI = Proxy

posMarAPI :: Proxy PositionMarketingAPI
posMarAPI = Proxy

fileContentAPI :: Proxy FileContentAPI
fileContentAPI = Proxy

app :: Application
app = serve fileContentAPI server3
