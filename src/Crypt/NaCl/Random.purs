module Crypt.NaCl.Random where

import Data.Unit (Unit)
import Data.ArrayBuffer.Types (Uint8Array)
import Control.Monad.Eff (Eff)

import Crypt.NaCl.Types (Nonce, NACL_RANDOM)

-- | Assigns a new PRNG for all random data generation
foreign import setPRNG :: forall e. (forall e. Uint8Array -> Int -> Eff (naclRandom :: NACL_RANDOM | e) Unit) -> Eff (naclRandom :: NACL_RANDOM | e) Unit

-- | Generate a cryptographically secure, random Nonce for NaCl operations
foreign import generateNonce:: forall e. Eff (naclRandom :: NACL_RANDOM | e) Nonce
