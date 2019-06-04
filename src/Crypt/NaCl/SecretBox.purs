module Crypt.NaCl.SecretBox
  ( generateSecretBoxKey
  , secretBox
  , secretBoxOpen
  ) where

import Data.Nullable (Nullable, toMaybe)
import Data.Maybe (Maybe)
import Effect (Effect)

import Crypt.NaCl.Types
  ( Message
  , Nonce
  , SecretBoxKey
  , SecretBox
  )

-- | Generate a key for use with a `SecretBox`
foreign import generateSecretBoxKey :: Effect SecretBoxKey

-- | Create a SecretBox, which is an encrypted and authenticated message
foreign import secretBox :: Message -> Nonce -> SecretBoxKey -> SecretBox

foreign import _secretBoxOpen :: SecretBox -> Nonce -> SecretBoxKey -> Nullable Message

-- | Open a SecretBox, returning `Maybe Message`
-- | If decryption and authentication succeed, `Just Message` will be
-- | returned.  If decryption or authentication fail, `Nothing` will be returned
secretBoxOpen :: SecretBox -> Nonce -> SecretBoxKey -> Maybe Message
secretBoxOpen b n k = toMaybe (_secretBoxOpen b n k)
