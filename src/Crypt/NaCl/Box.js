// module Crypt.NaCl.Box
"use strict";

var nacl = require('tweetnacl');

exports.generateBoxKeyPair = function() {
  return nacl.box.keyPair();
}

exports.getBoxKeyPair = function(secretKey) {
  return nacl.box.keyPair.fromSecretKey(secretKey);
}

exports.getBoxPublicKey = function(keyPair) {
  return keyPair.publicKey;
}

exports.getBoxSecretKey = function(keyPair) {
  return keyPair.secretKey;
}

exports.box = function(msg) {
  return function(nonce) {
    return function(publicKey) {
      return function(secretKey) {
        return nacl.box(msg, nonce, publicKey, secretKey);
      }
    }
  }
}

exports.boxAfter = function(msg) {
  return function(nonce) {
    return function(sharedKey) {
      return nacl.box.after(msg, nonce, sharedKey);
    }
  }
}

exports.boxBefore = function(publicKey) {
  return function(secretKey) {
    return nacl.box.before(publicKey, secretKey);
  }
}

exports._boxOpen = function(box) {
  return function(nonce) {
    return function(publicKey) {
      return function(secretKey) {
        var v = nacl.box.open(box, nonce, publicKey, secretKey);
        if (!v) {
          return null;
        } else {
          return v;
        }
      }
    }
  }
}

exports._boxOpenAfter = function(box) {
  return function(nonce) {
    return function(sharedKey) {
      var v = nacl.box.open.after(box, nonce, sharedKey);
      if (!v) {
        return null;
      } else {
        return v;
      }
    }
  }
}
