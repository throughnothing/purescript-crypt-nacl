// module Crypt.NaCl.SecretBox
"use strict";

var nacl = require('tweetnacl');

exports.generateSecretBoxKey = function() {
  return nacl.randomBytes(nacl.secretbox.keyLength);
}

exports.secretBox = function(msg) {
  return function(nonce) {
    return function(key) {
      return nacl.secretbox(msg, nonce, key);
    }
  }
}

exports._secretBoxOpen = function(box) {
  return function(nonce) {
    return function(key) {
      var v = nacl.secretbox.open(box, nonce, key);
      if(!v) {
        return null;
      } else {
        return v;
      }
    }
  }
}
