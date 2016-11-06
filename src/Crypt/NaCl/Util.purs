module Crypt.NaCl.Util
  ( toBase64
  , toMessageRaw
  , toString

  , _log
  ) where


import Prelude (Unit)

import Data.ArrayBuffer.Types (Uint8Array)
import Unsafe.Coerce (unsafeCoerce)

import Crypt.NaCl.Types

toString :: UTF8StringAble -> String
toString (MessageRawStr a)= _toString a

toMessageRaw :: Message -> MessageRaw
toMessageRaw = unsafeCoerce _decodeUTF8


toBase64 :: Base64Able -> Base64
toBase64 (HashSha512B64 a)       = _toBase64 a
toBase64 (NonceB64 a)            = _toBase64 a
toBase64 (MessageRawB64 a)       = _toBase64 a
toBase64 (BoxB64 a)              = _toBase64 a
toBase64 (BoxPublicKeyB64 a)     = _toBase64 a
toBase64 (BoxSecretKeyB64 a)     = _toBase64 a
toBase64 (BoxSharedKeyB64 a)     = _toBase64 a
toBase64 (SecretBoxB64 a)        = _toBase64 a
toBase64 (SecretBoxKeyB64 a)     = _toBase64 a
toBase64 (SignatureB64 a)        = _toBase64 a
toBase64 (SignPublicKeyB64 a)    = _toBase64 a
toBase64 (SignSecretKeyB64 a)    = _toBase64 a
toBase64 (SignedMessageRawB64 a) = _toBase64 a


foreign import _log :: forall a. a -> Unit

foreign import _encodeUTF8 :: Uint8Array -> String
foreign import _decodeUTF8 :: String -> Uint8Array

foreign import _encodeBase64 :: Uint8Array -> Base64
foreign import _decodeBase64 :: Base64 -> Uint8Array

_toUint8 :: forall a. a -> Uint8Array
_toUint8 = unsafeCoerce

_toString :: forall a. a -> String
_toString a = _encodeUTF8 (_toUint8 a)

_toBase64 :: forall a. a -> String
_toBase64 a = _encodeBase64 (_toUint8 a)
