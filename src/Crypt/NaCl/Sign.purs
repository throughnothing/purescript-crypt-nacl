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

import Effect (Effect)
import Data.Nullable (Nullable, toMaybe)
import Data.Maybe (Maybe)

import Crypt.NaCl.Types (
    Message
  , NACL_RANDOM
  , SignKeyPair
  , Signature
  , SignedMessage
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

-- | Sign a `Message` using the given `SignSecretKey`.
-- | Returns the contents of the message, signed, as a `SignedMessage`
foreign import sign :: Message -> SignSecretKey -> SignedMessage

foreign import _signOpen :: SignedMessage -> SignPublicKey -> Nullable Message

-- | Like `sign`, but only returns the `Signature`, not the message contents
foreign import signDetached :: Message -> SignSecretKey -> Signature

-- | Verifies a `Signature`, given the `Message`
foreign import verifyDetached :: Message -> Signature -> Boolean

-- | Varifies the signature contained in a `SignedMessage` against a given
-- | `SignPublicKey`.  Returns `Just Message` if the signature verifies,
-- | or `Nothing` otherwise.
signOpen :: SignedMessage -> SignPublicKey -> Maybe Message
signOpen m s = toMaybe (_signOpen m s)
