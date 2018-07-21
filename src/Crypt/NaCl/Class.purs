module Crypt.NaCl.Class where

import Crypt.NaCl.Types

import Data.ArrayBuffer.Types (Uint8Array, Uint8, ArrayView)
import Data.Either (Either)
import Data.TextDecoder (decodeUtf8)
import Data.TextEncoder (encodeUtf8)
import Effect.Exception (Error)
import Unsafe.Coerce (unsafeCoerce)


-- | Denotes a class of NaCl types which are convertable to `Uint8Array`s.
-- | Instances of this typeclass will `unsafeCoerce` their values to `Uint8Array`
-- | because we know that everything in/out of the underlying library are,
-- | in fact, `Uint8Array`s.
class Uint8ArrayAble a where
  toUint8Array :: a -> Uint8Array

-- | Denotes a class of NaCl types which are convertable from `Uint8Array`s.
-- | Instances of this typeclass will `unsafeCoerce` their values from `Uint8Array`
-- | because we know that everything in/out of the underlying library are,
-- | in fact, `Uint8Array`s.
class Uint8ArrayReadable a where
  fromUint8Array :: Uint8Array -> a

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

instance hashSha512Uint8ArrayReadable :: Uint8ArrayReadable HashSha512 where
  fromUint8Array = unsafeCoerce

instance nonceUint8ArrayReadable :: Uint8ArrayReadable Nonce where
  fromUint8Array = unsafeCoerce

instance messageUint8ArrayReadable :: Uint8ArrayReadable Message where
  fromUint8Array = unsafeCoerce

instance boxUint8ArrayReadable :: Uint8ArrayReadable Box where
  fromUint8Array = unsafeCoerce

instance boxPublicKeyUint8ArrayReadable :: Uint8ArrayReadable BoxPublicKey where
  fromUint8Array = unsafeCoerce

instance boxSecretKeyUint8ArrayReadable :: Uint8ArrayReadable BoxSecretKey where
  fromUint8Array = unsafeCoerce

instance boxSharedKeyUint8ArrayReadable :: Uint8ArrayReadable BoxSharedKey where
  fromUint8Array = unsafeCoerce

instance secretBoxUint8ArrayReadable :: Uint8ArrayReadable SecretBox where
  fromUint8Array = unsafeCoerce

instance secretBoxKeyUint8ArrayReadable :: Uint8ArrayReadable SecretBoxKey where
  fromUint8Array = unsafeCoerce

instance signPublicKeyUint8ArrayReadable :: Uint8ArrayReadable SignPublicKey where
  fromUint8Array = unsafeCoerce

instance signSecretKeyUint8ArrayReadable :: Uint8ArrayReadable SignSecretKey where
  fromUint8Array = unsafeCoerce

instance signedMessageUint8ArrayReadable :: Uint8ArrayReadable SignedMessage where
  fromUint8Array = unsafeCoerce

