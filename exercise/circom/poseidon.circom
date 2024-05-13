pragma circom 2.1.8;

include "circomlib/circuits/poseidon.circom";

template verifyHash () {
  signal input hash;
  signal input a;
  signal input b;

  component hasher = Poseidon(2);
  hasher.inputs[0] <== a;
  hasher.inputs[1] <== b;

  hasher.out === hash;

}
component main {} = verifyHash();
