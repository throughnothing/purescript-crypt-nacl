// module Test.Util
"use strict";

// Compare to Uint8Arrays
exports.cmpUint8Array = function(a) {
  return function(b) {
    if (a.byteLength != b.byteLength){
      return false;
    }
    var a2 = new Uint8Array(a);
    var b2 = new Uint8Array(b);
    for (var i = 0 ; i != a.byteLength ; i++) {
        if (a2[i] != b2[i]) return false;
    }
    return true;
  }
}
