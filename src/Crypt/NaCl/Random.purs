module Crypt.NaCl.Random where

import Data.Unit (Unit)
import Data.ArrayBuffer.Types (Uint8Array)
import Effect (Effect)

import Crypt.NaCl.Types (Nonce)

-- | Assigns a new PRNG for all random data generation
foreign import setPRNG :: (Uint8Array -> Int -> Effect Unit) -> Effect Unit

-- | Generate a cryptographically secure, random Nonce for NaCl operations
foreign import generateNonce:: Effect  Nonce
