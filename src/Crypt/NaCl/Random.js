// module Crypt.NaCl.Random
"use strict";

var nacl = require('tweetnacl');

exports.generateNonce = function() {
  return nacl.randomBytes(nacl.box.nonceLength);
}
