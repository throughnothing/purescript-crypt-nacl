module Crypt.NaCl.Box
  ( generateBoxKeyPair
  , getBoxKeyPair
  , getBoxPublicKey
  , getBoxSecretKey
  , box
  , boxAfter
  , boxBefore
  , boxOpen
  , boxOpenAfter
  ) where

import Control.Monad.Eff (Eff)
import Data.Nullable (Nullable, toMaybe)
import Data.Maybe (Maybe)

import Crypt.NaCl.Types (
    NACL_RANDOM
  , Box
  , BoxKeyPair
  , BoxPublicKey
  , BoxSecretKey
  , MessageRaw
  , Nonce
  , BoxSharedKey
  )


foreign import generateBoxKeyPair :: forall e. Eff (naclRandom :: NACL_RANDOM | e) BoxKeyPair

foreign import getBoxKeyPair :: BoxSecretKey -> BoxKeyPair

foreign import getBoxPublicKey :: BoxKeyPair -> BoxPublicKey

foreign import getBoxSecretKey :: BoxKeyPair -> BoxSecretKey


foreign import box :: MessageRaw -> Nonce -> BoxPublicKey -> BoxSecretKey -> Box

foreign import boxAfter :: MessageRaw -> Nonce -> BoxSharedKey -> Box

foreign import boxBefore :: BoxPublicKey -> BoxSecretKey -> BoxSharedKey

foreign import _boxOpen :: Box -> Nonce -> BoxPublicKey -> BoxSecretKey -> Nullable MessageRaw

foreign import _boxOpenAfter :: Box -> Nonce -> BoxSharedKey -> Nullable MessageRaw


boxOpen :: Box -> Nonce -> BoxPublicKey -> BoxSecretKey -> Maybe MessageRaw
boxOpen b n p s= toMaybe (_boxOpen b n p s)

boxOpenAfter :: Box -> Nonce -> BoxSharedKey -> Maybe MessageRaw
boxOpenAfter b n k = toMaybe (_boxOpenAfter b n k)
