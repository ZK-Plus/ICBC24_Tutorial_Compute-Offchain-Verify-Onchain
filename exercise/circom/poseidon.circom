pragma circom 2.1.8;

include "circomlib/circuits/poseidon.circom";

template verifyHash () {
  signal input hash;
  signal input a;
  signal input b;

  //TODO: verify a poseidon hash here

}


component main { public [ hash ] } = verifyHash();