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

-- | Generate a random key pair for signing messages
foreign import generateSignKeyPair :: forall e. Eff (naclRandom :: NACL_RANDOM | e) SignKeyPair

-- | Get the signing keypair for a given `SignSecretKey`
foreign import getSignKeyPair :: SignSecretKey -> SignKeyPair

-- | Get the `SignPublicKey` for a given `SignKeyPair`
foreign import getSignPublicKey :: SignKeyPair -> SignPublicKey

-- | Get the `SignSecretKey` for a given `SignKeyPair`
foreign import getSignSecretKey :: SignKeyPair -> SignSecretKey

-- | Sign a `MessageRaw` using the given `SignSecretKey`.
-- | Returns the contents of the message, signed, as a `SignedMessageRaw`
foreign import sign :: MessageRaw -> SignSecretKey -> SignedMessageRaw

foreign import _signOpen :: SignedMessageRaw -> SignPublicKey -> Nullable MessageRaw

-- | Like `sign`, but only returns the `Signature`, not the message contents
foreign import signDetached :: MessageRaw -> SignSecretKey -> Signature

-- | Verifies a `Signature`, given the `MessageRaw`
foreign import verifyDetached :: MessageRaw -> Signature -> Boolean

-- | Varifies the signature contained in a `SignedMessageRaw` against a given
-- | `SignPublicKey`.  Returns `Just MessageRaw` if the signature verifies,
-- | or `Nothing` otherwise.
signOpen :: SignedMessageRaw -> SignPublicKey -> Maybe MessageRaw
signOpen m s = toMaybe (_signOpen m s)
