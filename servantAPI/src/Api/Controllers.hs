module Api.Controllers (emailForClient) where

import Data.List

import qualified Model.Data as Data (Email(..), ClientInfo(..))

emailForClient :: Data.ClientInfo -> Data.Email
emailForClient c = Data.Email from' to' subject' body'
    where
    from' = "test@io.com"
    to' = Data.clientEmail c
    subject' = "Hi " ++ Data.clientName c
    body' = "Hey " ++ Data.clientName c ++ ", checking up on you!!"
                ++ " Since you've recently turned " ++ show (Data.clientAge c)
                ++ ", have you checked out our latest "
                ++ intercalate ", " (Data.clientInterestedIn c)
                ++ " products? Give us a visit!"