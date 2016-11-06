module Crypt.NaCl.Sign
  ( generateSignKeyPair
  , getSignKeyPair
  , getSignPublicKey
  , getSignSecretKey
  , signDetached
  , signOpen
  , sign
  , verifyDetached
  ) where

import Control.Monad.Eff (Eff)
import Data.Nullable (Nullable, toMaybe)
import Data.Maybe (Maybe)

import Crypt.NaCl.Types (
    MessageRaw
  , NACL_RANDOM
  , SignKeyPair
  , Signature
  , SignedMessageRaw
  , SignPublicKey
  , SignSecretKey
  )

foreign import generateSignKeyPair :: forall e. Eff (naclRandom :: NACL_RANDOM | e) SignKeyPair

foreign import getSignKeyPair :: SignSecretKey -> SignKeyPair

foreign import getSignPublicKey :: SignKeyPair -> SignPublicKey

foreign import getSignSecretKey :: SignKeyPair -> SignSecretKey

foreign import sign :: MessageRaw -> SignSecretKey -> SignedMessageRaw

foreign import _signOpen :: SignedMessageRaw -> SignPublicKey -> Nullable MessageRaw

foreign import signDetached :: MessageRaw -> SignSecretKey -> Signature

foreign import verifyDetached :: MessageRaw -> Signature -> Boolean

signOpen :: SignedMessageRaw -> SignPublicKey -> Maybe MessageRaw
signOpen m s = toMaybe (_signOpen m s)
