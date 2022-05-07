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

import qualified Model.Data as Data (User, users1)

type UserAPIOne = "users" :> Get '[JSON] [Data.User]

data SortBy = Age | Name

server1 :: Server UserAPIOne
server1 = return Data.users1

userAPI :: Proxy UserAPIOne
userAPI = Proxy

app :: Application
app = serve userAPI server1


