module Crypt.NaCl.Hash where

import Data.ArrayBuffer.Types (Uint8Array)

import Crypt.NaCl.Types (HashSha512)

-- | Compute the SHA-512 hash of any `Uint8Array`
foreign import hash :: Uint8Array -> HashSha512
