pragma circom 2.1.8;

include "circomlib/circuits/poseidon.circom";

template verifyHash() {
  signal input hash;
  signal input a;
  signal input b;

  component hasher = Poseidon(2);
  hasher.inputs[0] <== a;
  hasher.inputs[1] <== b;

  log("hash: ", hasher.out);
  hasher.out === hash;


}

component main = verifyHash();

/* INPUT = {
    "hash": "6785167652243325121502926540806452447443769108715415059349984576933636058888", 
    "a": "3",
    "b": "5"
} */
