module Test.Main where

import Prelude
import Effect (Effect)
import Test.Assert

import Crypt.NaCl

import Test.Box (runBoxTests)
import Test.SecretBox (runSecretBoxTests)
import Test.Sign (runSignTests)

main :: Effect Unit
main = do
  runSignTests
  runBoxTests
  runSecretBoxTests
