module Test.SecretBox where

import Prelude
import Effect (Effect)
import Data.Maybe
import Test.Assert

import Test.Util
import Crypt.NaCl

runSecretBoxTests :: Effect Unit
runSecretBoxTests = do
  keyA     <- generateSecretBoxKey
  keyB     <- generateSecretBoxKey
  nonce    <- generateNonce
  badNonce <- generateNonce
  let str = "Test Message 12345"
  let msg = fromString str

  let sBox = secretBox msg nonce keyA
  -- Try with good nonce but bad Key
  let decMsgFail = secretBoxOpen sBox nonce keyB
  assert $ isNothing decMsgFail
  -- Try with badNonce but good Key
  let decMsgFail2 = secretBoxOpen sBox badNonce keyA
  assert $ isNothing decMsgFail
  -- Try with right nonce and key
  let decMsgSuccess = secretBoxOpen sBox nonce keyA
  assert $ cmpMsg str decMsgSuccess
