module Test.Util where

import Prelude
import Data.Maybe
import Crypt.NaCl

cmpMsg :: Message -> Maybe MessageRaw -> Boolean
cmpMsg m (Just r) = m == (toString (MessageRawStr r))
cmpMsg _ Nothing = false

cmpSignKp ::  SignKeyPair -> SignKeyPair -> Boolean
cmpSignKp a b = ((_sB64Pub a) == (_sB64Pub b)) && ((_sB64Sec a) == (_sB64Sec b))

_sB64Pub :: SignKeyPair -> Base64
_sB64Pub kp = toBase64 (SignPublicKeyB64 (getSignPublicKey kp))

_sB64Sec :: SignKeyPair -> Base64
_sB64Sec kp = toBase64 (SignSecretKeyB64 (getSignSecretKey kp))
