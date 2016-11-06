module Test.Box where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Maybe
import Test.Assert

import Test.Util
import Crypt.NaCl

runBoxTests :: forall e. Eff (naclRandom :: NACL_RANDOM, assert :: ASSERT | e) Unit
runBoxTests = do
  -- | Setup with 3 keypairs, Alice, Bob, Evil
  aliceKp <- generateBoxKeyPair
  bobKp   <- generateBoxKeyPair
  evilKp  <- generateBoxKeyPair
  nonce   <- generateNonce
  let alicePubKey = getBoxPublicKey aliceKp
  let aliceSecKey = getBoxSecretKey aliceKp
  let bobPubKey   = getBoxPublicKey bobKp
  let bobSecKey   = getBoxSecretKey bobKp
  let evilSecKey  = getBoxSecretKey evilKp
  let msg         = "Test Message 123"
  let msgRaw      = toMessageRaw msg

  -- | Test getting keyPair from BoxSecretKey
  let bobKp2        = (getBoxKeyPair bobSecKey)
  let bobSecKey1B64 = (toBase64 (BoxSecretKeyB64 (getBoxSecretKey bobKp)))
  let bobSecKey2B64 = (toBase64 (BoxSecretKeyB64 (getBoxSecretKey bobKp2)))
  let bobPubKey1B64 = (toBase64 (BoxPublicKeyB64 (getBoxPublicKey bobKp)))
  let bobPubKey2B64 = (toBase64 (BoxPublicKeyB64 (getBoxPublicKey bobKp2)))
  assert $ bobSecKey1B64 == bobSecKey2B64
  assert $ bobPubKey1B64 == bobPubKey2B64

  -- | Encrypt a box from bob -> alice
  let myBox  = box msgRaw nonce alicePubKey bobSecKey
  -- | Fail to decrypt box with wrong keys
  let msgRawFail    = boxOpen myBox nonce bobPubKey bobSecKey
  assert $ isNothing msgRawFail
  -- | Succeed to decrypt box with right keys
  let msgRawSuccess = boxOpen myBox nonce alicePubKey bobSecKey
  assert $ cmpMsg msg msgRawSuccess

  -- | Test Before/After Box Encryption/Decryption
  let mySharedKey = boxBefore bobPubKey aliceSecKey
  let myBadSharedKey = boxBefore alicePubKey evilSecKey
  let myBoxAfter = boxAfter msgRaw nonce mySharedKey
  let myOpenMsgFail = boxOpenAfter myBoxAfter nonce myBadSharedKey
  let myOpenMsgSuccess = boxOpenAfter myBoxAfter nonce mySharedKey
  assert $ isNothing myOpenMsgFail
  assert $ cmpMsg msg myOpenMsgSuccess
