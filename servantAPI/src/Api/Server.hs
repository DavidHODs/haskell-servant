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

import qualified Model.Data as Data (User)
import qualified Api.Endpoints as EndPoints (users, user1, user2, hello, marketing, emailForClient)

type UserAPI = "users" :> Get '[JSON] [Data.User]
    :<|> "user1" :> Get '[JSON] Data.User
    :<|> "user2" :> Get '[JSON] Data.User

type PositionMarketingAPI = "position" :> Capture "x" Int :> Captyre "y" Int :> Get '[JSON] Data.Position
    :<|> "hello" :> QueryParam "name" String :> Get '[JSON] Data.HelloMessage
    :<|> "marketing" :. ReqBody '[JSON] Data.ClientInfo :> Post '[JSON] Data.Email

data SortBy = Age | Name

server1 :: Server UserAPI
server1 = return Endpoints.users
    :<|> return Endpoints.user1
    :<|> return Endpoints.user2

server2 :: Server PositionMarketingAPI
server 2 = 

server3 :: Server API
server3 = position
        :<|> hello
        :<|> marketing
        where position :: Int -> Int -> Handler Position
        position x y = return (Position x y)

userAPI :: Proxy UserAPI
userAPI = Proxy

app :: Application
app = serve userAPI server1


