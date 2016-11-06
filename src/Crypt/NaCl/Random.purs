module Crypt.NaCl.Random where

import Control.Monad.Eff (Eff)

import Crypt.NaCl.Types (Nonce, NACL_RANDOM)

-- | Generate a cryptographically secure, random Nonce for NaCl operations
foreign import generateNonce:: forall e. Eff (naclRandom :: NACL_RANDOM | e) Nonce
