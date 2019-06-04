module Test.Box where

import Prelude
import Effect (Effect)
import Data.Maybe
import Test.Assert

import Test.Util
import Crypt.NaCl

runBoxTests :: Effect Unit
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
  let str         = "Test Message 123"
  let msg         = fromString str

  -- | Test getting keyPair from BoxSecretKey
  let bobKp2        = (getBoxKeyPair bobSecKey)
  assert $ cmpUint8ArrayAble (getBoxSecretKey bobKp2) (getBoxSecretKey bobKp)
  assert $ cmpUint8ArrayAble (getBoxPublicKey bobKp2) (getBoxPublicKey bobKp)

  -- | Encrypt a box from bob -> alice
  let myBox  = box msg nonce alicePubKey bobSecKey
  -- | Fail to decrypt box with wrong keys
  let msgFail    = boxOpen myBox nonce bobPubKey bobSecKey
  assert $ isNothing msgFail
  -- | Succeed to decrypt box with right keys
  let msgSuccess = boxOpen myBox nonce alicePubKey bobSecKey
  assert $ cmpMsg str msgSuccess

  -- | Test Before/After Box Encryption/Decryption
  let mySharedKey = boxBefore bobPubKey aliceSecKey
  let myBadSharedKey = boxBefore alicePubKey evilSecKey
  let myBoxAfter = boxAfter msg nonce mySharedKey
  let myOpenMsgFail = boxOpenAfter myBoxAfter nonce myBadSharedKey
  let myOpenMsgSuccess = boxOpenAfter myBoxAfter nonce mySharedKey
  assert $ isNothing myOpenMsgFail
  assert $ cmpMsg str myOpenMsgSuccess
