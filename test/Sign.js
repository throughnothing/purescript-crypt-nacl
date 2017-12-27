exports.testSeedData = {
  seed: Uint8Array.from(Array(32).fill(0)),
  publicKey: Uint8Array.from([59,106,39,188,206,182,164,45,98,163,168,208,42,111,13,115,101,50,21,119,29,226,67,166,58,192,72,161,139,89,218,41]),
  secretKey: Uint8Array.from([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,59,106,39,188,206,182,164,45,98,163,168,208,42,111,13,115,101,50,21,119,29,226,67,166,58,192,72,161,139,89,218,41])
}

exports.eqUint8Array = function (a1) {
  return function(a2) {
    if (a1.byteLength != a2.byteLength) {
      return false;
    }
    for (var i = 0; i < a1.byteLength; i++) {
      if (a1[i] != a2[i]) {
        return false;
      }
    }
    return true;
  }
}
