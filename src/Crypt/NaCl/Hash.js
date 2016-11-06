// module Crypt.NaCl.Hash
"use strict";

var nacl = require('tweetnacl');

exports.hash = function(msg) {
  return nacl.hash(msg);
}
