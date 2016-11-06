module Crypt.NaCl.Hash where

import Crypt.NaCl.Types (HashSha512, MessageRaw)

-- | Compute the SHA-512 hash of a `MessageRaw`
foreign import hash :: MessageRaw -> HashSha512
