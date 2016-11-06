module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

import Crypt.NaCl

main :: forall e. Eff (naclRandom :: NACL_RANDOM, console :: CONSOLE | e) Unit
main = do
  boxKeyPair <- generateBoxKeyPair
  let boxPublicKey = getBoxPublicKey boxKeyPair
  let boxSecretKey = getBoxSecretKey boxKeyPair
  log ("Public Key: " <> (toBase64 (BoxPublicKeyB64 boxPublicKey)))
  log ("Private Key: " <> (toBase64 (BoxSecretKeyB64 boxSecretKey)))

  let msg = "Test Message"
  let msgRaw = toMessageRaw msg
  log ("messageRaw: " <> (toString (MessageRawStr msgRaw)))
