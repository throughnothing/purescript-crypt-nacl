module Test.Util where

import Prelude
import Data.ArrayBuffer.Types (Uint8Array)
import Data.Either
import Data.Maybe
import Crypt.NaCl

cmpMsg :: String -> Maybe Message -> Boolean
cmpMsg m (Just r) = case (toString r) of
                  Right a -> a == m
                  Left e  -> false
cmpMsg _ Nothing = false

cmpSignKp :: SignKeyPair -> SignKeyPair -> Boolean
cmpSignKp a b = (cmpUint8Array pubA pubB) && (cmpUint8Array secA secB)
  where
    pubA = toUint8Array $ getSignPublicKey a
    pubB = toUint8Array $ getSignPublicKey b
    secA = toUint8Array $ getSignSecretKey a
    secB = toUint8Array $ getSignSecretKey b

cmpUint8ArrayAble :: forall a. (Uint8ArrayAble a) => a -> a -> Boolean
cmpUint8ArrayAble a b = cmpUint8Array (toUint8Array a) (toUint8Array b)

foreign import cmpUint8Array :: Uint8Array -> Uint8Array -> Boolean
