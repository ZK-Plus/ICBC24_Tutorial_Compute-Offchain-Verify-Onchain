pragma circom 2.1.8;

include "circomlib/circuits/poseidon.circom";

template verifyHash () {
  signal input hash;
  signal input a;
  signal input b;

  component digest = Poseidon(2);

  digest.inputs[0] <== a;
  digest.inputs[1] <== b;

  digest.out === hash;
  log("hash", digest.out);
}


component main { public [ hash ] } = verifyHash();