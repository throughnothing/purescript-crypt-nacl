module Crypt.NaCl.Class where

import Effect
import Effect.Exception (Error)
import Data.ArrayBuffer.Types (Uint8Array, Uint8, ArrayView)
import Data.Either (Either)
import Data.TextEncoder (encodeUtf8)
import Data.TextDecoder (decodeUtf8)
import Unsafe.Coerce (unsafeCoerce)

import Crypt.NaCl.Types


-- | Denotes a class of NaCl types which are convertable to `Uint8Array`s.
-- | Instances of this typeclass will `unsafeCoerce` their values to `Uint8Array`
-- | because we know that everything in/out of the underlying library are,
-- | in fact, `Uint8Array`s.
class Uint8ArrayAble a where
  toUint8Array :: a -> Uint8Array

-- | This type class denotes types that can be decoded to a UTF8 String.
-- |
-- | The `toString` function returns `Either Error String` to handle errors
-- | during the decode.  We will generally `unsafeCoerce` because we know the
-- | underlying type is already of Uint8Array from the wrapped library.
class Utf8Decodable a where
  toString :: a -> Either Error String

-- | This type class denotes types that can be encoded to a UTF8 String.
-- | The `fromString` function returns the type of the type class instance.
-- | We will generally `unsafeCoerce` from the `Uint8Array` type to the
-- | NaCl type we want because all underlying types are `Uint8Array`
class Utf8Encodable a where
  fromString :: String -> a


instance messageUtf8Decodable :: Utf8Decodable Message where
  toString m = decodeUtf8 (unsafeCoerce m :: (ArrayView Uint8))

instance messageUtf8Encodable :: Utf8Encodable Message where
  fromString = unsafeCoerce encodeUtf8

instance hashSha512Uint8ArrayAble :: Uint8ArrayAble HashSha512 where
  toUint8Array = unsafeCoerce

instance nonceUint8ArrayAble :: Uint8ArrayAble Nonce where
  toUint8Array = unsafeCoerce

instance messageUint8ArrayAble :: Uint8ArrayAble Message where
  toUint8Array = unsafeCoerce

instance boxUint8ArrayAble :: Uint8ArrayAble Box where
  toUint8Array = unsafeCoerce

instance boxPublicKeyUint8ArrayAble :: Uint8ArrayAble BoxPublicKey where
  toUint8Array = unsafeCoerce

instance boxSecretKeyUint8ArrayAble :: Uint8ArrayAble BoxSecretKey where
  toUint8Array = unsafeCoerce

instance boxSharedKeyUint8ArrayAble :: Uint8ArrayAble BoxSharedKey where
  toUint8Array = unsafeCoerce

instance secretBoxUint8ArrayAble :: Uint8ArrayAble SecretBox where
  toUint8Array = unsafeCoerce

instance secretBoxKeyUint8ArrayAble :: Uint8ArrayAble SecretBoxKey where
  toUint8Array = unsafeCoerce

instance signPublicKeyUint8ArrayAble :: Uint8ArrayAble SignPublicKey where
  toUint8Array = unsafeCoerce

instance signSecretKeyUint8ArrayAble :: Uint8ArrayAble SignSecretKey where
  toUint8Array = unsafeCoerce

instance signedMessageUint8ArrayAble :: Uint8ArrayAble SignedMessage where
  toUint8Array = unsafeCoerce
