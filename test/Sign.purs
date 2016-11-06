module Test.Sign where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Maybe
import Test.Assert

import Test.Util
import Crypt.NaCl

runSignTests :: forall e. Eff (naclRandom :: NACL_RANDOM, assert :: ASSERT | e) Unit
runSignTests = do
  signKpA  <- generateSignKeyPair
  signKpB  <- generateSignKeyPair
  nonce    <- generateNonce
  badNonce <- generateNonce
  let secKeyA  = getSignSecretKey signKpA
  let pubKeyA  = getSignPublicKey signKpA
  let pubKeyB  = getSignPublicKey signKpB
  let signKpA2 = getSignKeyPair secKeyA
  let msg      = "Test message 123 haha"
  let msgRaw   = toMessageRaw msg

  -- Check that we get the same key
  assert $ cmpSignKp signKpA signKpA2

  -- A signs a message
  let signedMsg = sign msgRaw secKeyA
  -- Try to open with keyB should fail
  let openMsgFail = signOpen signedMsg pubKeyB
  assert $ isNothing openMsgFail
  -- Try to open with correct key should succed
  let openMsgSuccess = signOpen signedMsg pubKeyA
  assert $ cmpMsg msg openMsgSuccess

  -- Sign a message Detached
  let sigA = signDetached msgRaw secKeyA
  -- Try to verify with wrong key
  let verified = verifyDetached msgRaw sigA
  assert verified
