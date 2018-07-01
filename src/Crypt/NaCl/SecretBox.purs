module Crypt.NaCl.SecretBox
  ( generateSecretBoxKey
  , secretBox
  , secretBoxOpen
  ) where

import Effect (Effect)
import Data.Nullable (Nullable, toMaybe)
import Data.Maybe (Maybe)

import Crypt.NaCl.Types (
    Message
  , NACL_RANDOM
  , Nonce
  , SecretBoxKey
  , SecretBox
  )

-- | Generate a key for use with a `SecretBox`
foreign import generateSecretBoxKey :: forall e. Eff (naclRandom :: NACL_RANDOM | e) SecretBoxKey

-- | Create a SecretBox, which is an encrypted and authenticated message
foreign import secretBox :: Message -> Nonce -> SecretBoxKey -> SecretBox

foreign import _secretBoxOpen :: SecretBox -> Nonce -> SecretBoxKey -> Nullable Message

-- | Open a SecretBox, returning `Maybe Message`
-- | If decryption and authentication succeed, `Just Message` will be
-- | returned.  If decryption or authentication fail, `Nothing` will be returned
secretBoxOpen :: SecretBox -> Nonce -> SecretBoxKey -> Maybe Message
secretBoxOpen b n k = toMaybe (_secretBoxOpen b n k)
