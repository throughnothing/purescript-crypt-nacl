module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Test.Assert

import Crypt.NaCl

import Test.Box (runBoxTests)
import Test.SecretBox (runSecretBoxTests)
import Test.Sign (runSignTests)

main :: forall e. Eff (naclRandom :: NACL_RANDOM, assert :: ASSERT | e) Unit
main = do
  runSignTests
  runBoxTests
  runSecretBoxTests
