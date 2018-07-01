module Crypt.NaCl.Random where

import Data.Unit (Unit)
import Data.ArrayBuffer.Types (Uint8Array)
import Effect (Effect)

import Crypt.NaCl.Types (Nonce, NACL_RANDOM)

-- | Assigns a new PRNG for all random data generation
foreign import setPRNG :: forall e e1. (Uint8Array -> Int -> Eff e1 Unit) -> Eff (naclRandom :: NACL_RANDOM | e) Unit

-- | Generate a cryptographically secure, random Nonce for NaCl operations
foreign import generateNonce:: forall e. Eff (naclRandom :: NACL_RANDOM | e) Nonce
