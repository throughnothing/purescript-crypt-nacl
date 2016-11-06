module Crypt.NaCl.Random where

import Control.Monad.Eff (Eff)

import Crypt.NaCl.Types (Nonce, NACL_RANDOM)

foreign import generateNonce:: forall e. Eff (naclRandom :: NACL_RANDOM | e) Nonce
