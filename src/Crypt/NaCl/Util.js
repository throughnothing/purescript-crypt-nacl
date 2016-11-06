// module Crypt.NaCl.Util
"use strict";

var util = require('tweetnacl-util');

exports._encodeUTF8   = util.encodeUTF8;
exports._decodeUTF8   = util.decodeUTF8;
exports._encodeBase64 = util.encodeBase64;
exports._decodeBase64 = util.decodeBase64;


exports._log = function (x) {
  console.log(x)
}
