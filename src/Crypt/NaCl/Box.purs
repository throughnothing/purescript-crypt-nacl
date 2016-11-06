module Crypt.NaCl.Box
  ( generateBoxKeyPair
  , getBoxKeyPair
  , getBoxPublicKey
  , getBoxSecretKey
  , box
  , boxAfter
  , boxBefore
  , boxOpen
  , boxOpenAfter
  ) where

import Prelude (($))
import Control.Monad.Eff (Eff)
import Data.Nullable (Nullable, toMaybe)
import Data.Maybe (Maybe)

import Crypt.NaCl.Types (
    NACL_RANDOM
  , Box
  , BoxKeyPair
  , BoxPublicKey
  , BoxSecretKey
  , MessageRaw
  , Nonce
  , BoxSharedKey
  )


-- | Generate a `BoxKeyPair` for NaCl Box operations
foreign import generateBoxKeyPair :: forall e. Eff (naclRandom :: NACL_RANDOM | e) BoxKeyPair

-- | Get a `BoxKeyPair` from the given `BoxSecretKey`
foreign import getBoxKeyPair :: BoxSecretKey -> BoxKeyPair

-- | Get a `BoxPublicKey` from the given `BoxKeyPair`
foreign import getBoxPublicKey :: BoxKeyPair -> BoxPublicKey

-- | Get a `BoxSecretKey` from the given `BoxKeyPair`
foreign import getBoxSecretKey :: BoxKeyPair -> BoxSecretKey

-- | Create a `Box`, which is an encrypted, authenticated message
foreign import box :: MessageRaw -> Nonce -> BoxPublicKey -> BoxSecretKey -> Box

-- | Create a `Box` with a `BoxSharedKey`
foreign import boxAfter :: MessageRaw -> Nonce -> BoxSharedKey -> Box

-- | Create a `BoxSharedKey` from one user's `BoxPublicKey` and a separate
-- | user's `BoxSecretKey`
foreign import boxBefore :: BoxPublicKey -> BoxSecretKey -> BoxSharedKey

foreign import _boxOpen :: Box -> Nonce -> BoxPublicKey -> BoxSecretKey -> Nullable MessageRaw

foreign import _boxOpenAfter :: Box -> Nonce -> BoxSharedKey -> Nullable MessageRaw

-- | Opening a box decrypts and authenticates the message.
-- | This will return the `MessageRaw` plaintext if decryption and SignatureB64
-- | validation succeeds, and `Nothing` if authentication or decryption fails.
boxOpen :: Box -> Nonce -> BoxPublicKey -> BoxSecretKey -> Maybe MessageRaw
boxOpen b n p s = toMaybe $ _boxOpen b n p s

-- | Similar to `boxOpen`, but opens a box with a `BoxSharedKey` that has been
-- | generated with `boxBefore` instead of a `BoxPublicKey` and `BoxSecretKey`
boxOpenAfter :: Box -> Nonce -> BoxSharedKey -> Maybe MessageRaw
boxOpenAfter b n k = toMaybe $ _boxOpenAfter b n k
