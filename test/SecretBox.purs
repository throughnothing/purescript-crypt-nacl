module Test.SecretBox where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Maybe
import Test.Assert

import Test.Util
import Crypt.NaCl

runSecretBoxTests :: forall e. Eff (naclRandom :: NACL_RANDOM, assert :: ASSERT | e) Unit
runSecretBoxTests = do
  keyA     <- generateSecretBoxKey
  keyB     <- generateSecretBoxKey
  nonce    <- generateNonce
  badNonce <- generateNonce
  let msg    = "Test Message 12345"
  let msgRaw = toMessageRaw msg

  let sBox = secretBox msgRaw nonce keyA
  -- Try with good nonce but bad Key
  let decMsgFail = secretBoxOpen sBox nonce keyB
  assert $ isNothing decMsgFail
  -- Try with badNonce but good Key
  let decMsgFail2 = secretBoxOpen sBox badNonce keyA
  assert $ isNothing decMsgFail
  -- Try with right nonce and key
  let decMsgSuccess = secretBoxOpen sBox nonce keyA
  assert $ cmpMsg msg decMsgSuccess