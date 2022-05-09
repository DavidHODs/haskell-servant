module Api.Controllers (emailForClient, writeContent, endpointError) where

import Data.List
import Control.Monad.Reader
import Servant
import Data.ByteString as B

import qualified Model.Data as Data (Email(..), ClientInfo(..), FileContent(..), ServerErrors(..))

emailForClient :: Data.ClientInfo -> Data.Email
emailForClient c = Data.Email from' to' subject' body'
    where
    from' = "test@io.com"
    to' = Data.clientEmail c
    subject' = "Hi " ++ Data.clientName c
    body' = "Hey " ++ Data.clientName c ++ ", checking up on you!!"
                ++ " Since you've recently turned " ++ show (Data.clientAge c)
                ++ ", have you checked out our latest "
                ++ Data.List.intercalate ", " (Data.clientInterestedIn c)
                ++ " products? Give us a visit!"

writeContent :: String -> Data.FileContent
writeContent = Data.FileContent 

endpointError :: Int -> String -> B.ByteString -> Data.ServerErrors
endpointError code msg byteMsg = Data.ServerErrors code msg byteMsg 
    -- { 
    --     errBody = byteMsg,
    --     errHTTPCode = 500,
    --     Data.errResponseString = msg
    -- }





-- failingHandler :: Handler ()
-- failingHandler = throwError myerr

--   where myerr :: ServerErrors
--         myerr = err503 { errBody = "Sorry dear user." }