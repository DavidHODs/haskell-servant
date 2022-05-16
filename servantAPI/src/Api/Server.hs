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
import qualified Api.Endpoints as EndPoints (users, user1, user2, hello, marketing, position, getFileContent, pos1)

type UserAPI = "users" :> Get '[JSON] [Data.User]
    :<|> "user1" :> Get '[JSON] Data.User
    :<|> "user2" :> Get '[JSON] Data.User

data SortBy = Age | Name

type PositionMarketingAPI = "position" :> Capture "x" Int :> Capture "y" Int :> Get '[JSON] Data.Position
    :<|> "hello" :> QueryParam "name" String :> Get '[JSON] Data.HelloMessage
    :<|> "marketing" :> ReqBody '[JSON] Data.ClientInfo :> Post '[JSON] Data.Email

type FileContentIOAPI = "get" :> "files.txt" :> Get '[JSON] [Data.FileContent]

type ResponseHeaderAPI = Capture "optional-header" Bool :> Get '[JSON] (Headers '[Header "Test-Header" Int] Data.Position)

type StaticAPI = "static" :> Raw

type CombinedAPI = UserAPI 
                :<|> PositionMarketingAPI 
                :<|> FileContentIOAPI 
                :<|> ResponseHeaderAPI 
                :<|> StaticAPI

server1 :: Server UserAPI
server1 = return EndPoints.users
    :<|> return EndPoints.user1
    :<|> return EndPoints.user2

server2 :: Server PositionMarketingAPI
server2 = EndPoints.position
        :<|> EndPoints.hello
        :<|> EndPoints.marketing

server3 :: Server FileContentIOAPI
server3 = liftIO EndPoints.getFileContent

server6 :: Server ResponseHeaderAPI
server6 x = return $ if x then addHeader 420 EndPoints.pos1
                          else noHeader EndPoints.pos1

server7 :: Server StaticAPI
server7 = serveDirectoryWebApp "static"

combinedServer :: Server CombinedAPI
combinedServer = server1
                :<|> server2
                :<|> server3
                :<|> server6
                :<|> server7

userAPI :: Proxy UserAPI
userAPI = Proxy

posMarAPI :: Proxy PositionMarketingAPI
posMarAPI = Proxy

fileContentIOAPI :: Proxy FileContentIOAPI
fileContentIOAPI = Proxy

responseHeaderAPI :: Proxy ResponseHeaderAPI
responseHeaderAPI = Proxy

staticAPI :: Proxy StaticAPI
staticAPI = Proxy

proxyAPI :: Proxy CombinedAPI
proxyAPI = Proxy

app :: Application
app = serve proxyAPI combinedServer





-- type StaticAPI = "static" :> Raw

-- And the server:

-- staticAPI :: Proxy StaticAPI
-- staticAPI = Proxy

-- server7 :: Server StaticAPI
-- server7 = serveDirectoryWebApp "static-files"

-- app3 :: Application
-- app3 = serve staticAPI server7

