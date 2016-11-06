module Crypt.NaCl.Hash where

import Crypt.NaCl.Types (HashSha512, MessageRaw)

foreign import hash :: MessageRaw -> HashSha512
