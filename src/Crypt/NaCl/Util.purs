module Crypt.NaCl.Util
  ( toMessage
  , toString
  ) where

import Control.Monad.Eff.Exception (Error)
import Data.ArrayBuffer.Types (Uint8, ArrayView)
import Data.Either (Either)
import Data.TextEncoder (encodeUtf8)
import Data.TextDecoder (decodeUtf8)
import Unsafe.Coerce (unsafeCoerce)

import Crypt.NaCl.Types (Message)

-- | Converts any `String` string into a NaCl `Message`, which is really a
-- | `Uint8Array` underneath.  That is why we can `unsafeCoerce` to `Message`
toMessage :: String -> Message
toMessage = unsafeCoerce encodeUtf8

-- | Convert a `Message` to a `String`, using `Either Error String` to handle
-- | errors during the conversion.  We can `unsafeCoerce` because `Message`
-- | has to be a `Uint8Array`.
toString :: Message -> Either Error String
toString m = decodeUtf8 (unsafeCoerce m :: (ArrayView Uint8))
