module Fission.Web.User
  ( API
  , Auth
  , RegisterRoute
  , VerifyRoute
  , UpdatePublicKeyRoute
  , ResetRoute
  , WhoAmIRoute
  , server
  ) where

import           Servant

import           Fission.Prelude
import           Fission.IPFS.DNSLink.Class as DNSLink

import qualified Fission.User as User

import qualified Fission.Web.User.Create          as Create
import qualified Fission.Web.User.Verify          as Verify
import qualified Fission.Web.User.Password.Reset  as Reset
import qualified Fission.Web.User.UpdatePublicKey as UpdatePublicKey
import qualified Fission.Web.User.UpdateData      as UpdateData
import qualified Fission.Web.User.WhoAmI          as WhoAmI

import qualified Fission.Web.Auth.Types as Auth

type API
  =   RegisterRoute
 :<|> Create.PasswordAPI
 :<|> WhoAmIRoute
 :<|> VerifyRoute
 :<|> UpdatePublicKeyRoute
 :<|> UpdateDataRoute
 :<|> ResetRoute

type Auth
  = Auth.HigherOrder

type RegisterRoute
  = Auth.RegisterDID
    :> Create.API

type WhoAmIRoute
  = "whoami"
    :> Auth
    :> WhoAmI.API

type VerifyRoute
  = "verify"
    :> Auth
    :> Verify.API

type UpdatePublicKeyRoute
  = "did"
    :> Auth
    :> UpdatePublicKey.API

type UpdateDataRoute
  = "data"
    :> Auth
    :> UpdateData.API

type ResetRoute
  = "reset_password"
    :> Auth
    :> Reset.API

server ::
  ( MonadDNSLink  m
  , MonadLogger   m
  , MonadTime     m
  , User.Modifier m
  , User.Creator  m
  )
  => ServerT API m
server = Create.withDID
    :<|> Create.withPassword
    :<|> WhoAmI.server
    :<|> (\_ -> Verify.server)
    :<|> UpdatePublicKey.server
    :<|> UpdateData.server
    :<|> Reset.server
