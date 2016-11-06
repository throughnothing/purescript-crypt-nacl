// module Crypt.NaCl.Sign
"use strict";

var nacl = require('tweetnacl');

exports.generateSignKeyPair = function() {
  return nacl.sign.keyPair();
}

exports.getSignKeyPair = function(secretKey) {
  return nacl.sign.keyPair.fromSecretKey(secretKey);
}

exports.getSignPublicKey = function(signKeyPair) {
  return signKeyPair.publicKey;
}

exports.getSignSecretKey = function(signKeyPair) {
  return signKeyPair.secretKey;
}

exports._signOpen = function(signedMsg) {
  return function(signPublicKey) {
    return nacl.sign.open(signedMsg, signPublicKey);
  }
}

exports.sign = function(msg) {
  return function(signSecretKey) {
    return nacl.sign(msg, signSecretKey);
  }
}

exports.signDetached = function(msg) {
  return function(signSecretKey) {
    return nacl.sign.detached(msg, signSecretKey);
  }
}

exports.verifyDetached = function(msg) {
  return function(signature) {
    return function(signPublicKey) {
      return nacl.sign.detached.verify(msg, signature, signPublicKey)
    }
  }
}
