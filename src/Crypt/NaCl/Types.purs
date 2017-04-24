module Crypt.NaCl.Types where
import Control.Monad.Eff (kind Effect)

foreign import data NACL_RANDOM :: Effect

-- | A NaCl SHA-512 Hash
foreign import data HashSha512 :: Type

-- | A NaCl Nonce
foreign import data Nonce :: Type

-- | A NaCl Message, which is represented as a Uint8Array in JS
foreign import data Message :: Type


-- | A NaCl Box, which is an encrypted, authenticated message
foreign import data Box :: Type

-- | A NaCl `BoxKeyPair` containing a `BoxPublicKey` and a `BoxSecretKey`
newtype BoxKeyPair = BoxKeyPair { publicKey :: BoxPublicKey, secretKey :: BoxSecretKey }

-- | A NaCl BoxPublicKey
foreign import data BoxPublicKey :: Type

-- | A NaCl BoxSecretKey
foreign import data BoxSecretKey :: Type

-- | A NaCl BoxSharedKey
foreign import data BoxSharedKey :: Type


-- | a NaCL SecretBox
foreign import data SecretBox :: Type

-- | a NaCL SecretBoxKey
foreign import data SecretBoxKey :: Type


-- | A NaCl Signature
foreign import data Signature :: Type

-- | A NaCl `SignKeyPair` containing a `SignPublicKey` and a `SignSecretKey`
newtype SignKeyPair = SignKeyPair { publicKey :: SignPublicKey, secretKey :: SignSecretKey }

-- | A NaCl SignPublicKey
foreign import data SignPublicKey :: Type

-- | A NaCl SignSecretKey
foreign import data SignSecretKey :: Type

-- | A NaCl SignedMessage, which is represented as a Uint8Array in JS
foreign import data SignedMessage :: Type
