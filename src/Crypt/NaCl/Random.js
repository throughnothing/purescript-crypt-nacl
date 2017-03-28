// module Crypt.NaCl.Random
"use strict";

var nacl = require('tweetnacl');

exports.setPRNG = function(f) {
  return function() {
    nacl.setPRNG(function(x,n) {f(x)(n)();});
  }
}

exports.generateNonce = function() {
  return nacl.randomBytes(nacl.box.nonceLength);
}
