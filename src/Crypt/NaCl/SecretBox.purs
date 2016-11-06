module Crypt.NaCl.SecretBox
  ( generateSecretBoxKey
  , secretBox
  , secretBoxOpen
  ) where

import Control.Monad.Eff (Eff)
import Data.Nullable (Nullable, toMaybe)
import Data.Maybe (Maybe)

import Crypt.NaCl.Random (generateNonce)

import Crypt.NaCl.Types (
    MessageRaw
  , NACL_RANDOM
  , Nonce
  , SecretBoxKey
  , SecretBox
  )

-- | Generate a key for use with a `SecretBox`
foreign import generateSecretBoxKey :: forall e. Eff (naclRandom :: NACL_RANDOM | e) SecretBoxKey

-- | Create a SecretBox, which is an encrypted and authenticated message
foreign import secretBox :: MessageRaw -> Nonce -> SecretBoxKey -> SecretBox

foreign import _secretBoxOpen :: SecretBox -> Nonce -> SecretBoxKey -> Nullable MessageRaw

-- | Open a SecretBox, returning `Maybe MessageRaw`
secretBoxOpen :: SecretBox -> Nonce -> SecretBoxKey -> Maybe MessageRaw
secretBoxOpen b n k = toMaybe (_secretBoxOpen b n k)
