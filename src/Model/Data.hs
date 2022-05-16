module Model.Data 
  ( User(..), Position(..), HelloMessage(..), ClientInfo(..), Email(..), FileContent(..), ServerErrors(..) )
   where

import Data.Text ()
import Data.Time.Calendar
import GHC.Generics
import Data.Aeson
import Servant
import Data.ByteString

data User = User {
  name :: String,
  age :: Int,
  email :: String,
  registration_date :: Day
} deriving (Eq, Show, Generic)
instance ToJSON User

data Position = Position 
  {
    xCoord :: Int,
    yCoord :: Int
  } deriving (Eq, Show, Generic)
instance ToJSON Position

newtype HelloMessage = HelloMessage 
  {
    msg :: String
  } deriving (Show, Eq, Generic)

instance ToJSON HelloMessage

data ClientInfo = ClientInfo 
  {
    clientName :: String,
    clientEmail :: String,
    clientAge :: Int,
    clientInterestedIn :: [String]
  } deriving (Generic, Eq, Show)

instance ToJSON ClientInfo
instance FromJSON ClientInfo

data Email = Email 
  {
    from :: String,
    to :: String,
    subject :: String,
    body :: String
  } deriving (Generic, Eq, Show)
  
instance ToJSON Email

newtype FileContent = FileContent
  {
    content :: String
  } deriving Generic

instance ToJSON FileContent
instance FromJSON FileContent

data ServerErrors = ServerErrors
  {
    errHTTPCode :: Int,
    errResponseString :: String,
    errBody :: ByteString
  } deriving (Generic, Show)
