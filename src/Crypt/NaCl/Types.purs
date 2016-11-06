module Crypt.NaCl.Types where

-- | NACL_RANDOM Effect, which signifies that this computation can carry out
-- | a cryptographic random number generation effect
foreign import data NACL_RANDOM :: !


-- | A NaCl SHA-512 Hash
foreign import data HashSha512 :: *

-- | A NaCl Nonce
foreign import data Nonce :: *

-- | A NaCl Message, which is represented as a Uint8Array in JS
foreign import data Message :: *


-- | A NaCl Box, which is an encrypted, authenticated message
foreign import data Box :: *

-- | A NaCl `BoxKeyPair` containing a `BoxPublicKey` and a `BoxSecretKey`
newtype BoxKeyPair = BoxKeyPair { publicKey :: BoxPublicKey, secretKey :: BoxSecretKey }

-- | A NaCl BoxPublicKey
foreign import data BoxPublicKey :: *

-- | A NaCl BoxSecretKey
foreign import data BoxSecretKey :: *

-- | A NaCl BoxSharedKey
foreign import data BoxSharedKey :: *


-- | a NaCL SecretBox
foreign import data SecretBox :: *

-- | a NaCL SecretBoxKey
foreign import data SecretBoxKey :: *


-- | A NaCl Signature
foreign import data Signature :: *

-- | A NaCl `SignKeyPair` containing a `SignPublicKey` and a `SignSecretKey`
newtype SignKeyPair = SignKeyPair { publicKey :: SignPublicKey, secretKey :: SignSecretKey }

-- | A NaCl SignPublicKey
foreign import data SignPublicKey :: *

-- | A NaCl SignSecretKey
foreign import data SignSecretKey :: *

-- | A NaCl SignedMessage, which is represented as a Uint8Array in JS
foreign import data SignedMessage :: *
