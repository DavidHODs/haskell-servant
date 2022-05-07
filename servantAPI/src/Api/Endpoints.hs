module Api.Endpoints 
    (users, user1, user2, emailForClient, position, hello) where

import Server

import qualified Model.Data as Data (User, ClientInfo, Email, Position, Email, HelloMessage)

users :: [User]
users =
    [
    user1,
    user2 
        
    ]

user1 :: Data.User
user1 = Data.User "Isaac Clemence" 372 "IsaacClemence@test.io" (fromGregorian 1683 3 1)

user2 :: Data.User
user2 = Data.User "Albert Greg" 136 "mc2@newton.uk" (fromGregorian 1905 12 1)

emailForClient :: Data.ClientInfo -> Data.Email
emailForClient c = Data.Email from' to' subject' body'
    where
    from' = "test@io.com"
    to' = clientEmail c
    subject' = "Hi " ++ clientName c ++ "\n\n"
    body' = "Hey " ++ clientName c ++ ", checking up on you!!"
                ++ " Since you've recently turned " ++ show (clientAge c)
                ++ ", have you checked out our latest "
                ++ intercalate ", " (clientInterestedIn c)
                ++ " products? Give us a visit!"

position :: Int -> Int -> Handler Data.Position
position x y = return (Data.Position x y)

hello :: Maybe String -> Handler Data.HelloMessage
hello mname = return . Data.HelloMessage $ case mname of
    Nothing -> "Hello, anonymous user"
    Just n -> "Hello, " ++ n

marketing :: Data.ClientInfo -> Handler Data.Email
marketing ci = return (emailForClient ci)
 