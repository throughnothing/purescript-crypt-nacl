module Crypt.NaCl.Class where

import Data.ArrayBuffer.Types (Uint8Array)
import Unsafe.Coerce (unsafeCoerce)

import Crypt.NaCl.Types

-- | Denotes a class of NaCl types which are convertable to `Uint8Array`s.
-- | Instances of this typeclass will `unsafeCoerce` their values to `Uint8Array`
-- | because we know that everything in/out of the underlying library are,
-- | in fact, `Uint8Array`s.
class Uint8ArrayAble a where
  toUint8Array :: a -> Uint8Array

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
