pragma circom 2.1.8;

include "utils.circom";

template IntegerDivisionWithRest(n) {

    // Input signals
    signal input in; // The number to be divided
    signal input div; // The number by which is divided. Must be smaller than 2**n
    
    // Output signals
    signal output multiplier; // The result of the integer division ("in \ div").
    signal output rest; // The rest of the integer division ("in % div").

    // Make sure that the integer is in the prime field.
    assert(n <= 253); 

    // Used components
    // Range check imported from comparators.circom that takes two inputs and returns 1 if the first input is smaller than the second and 0, else.
    component rangeCheck = LessThan(n);

    // Supply the result of integer division and the rest "magically" (avoids bloating the program with additional (private) inputs or doing more complex computations than necessary inside the circuit).
    multiplier <-- in \ div; // Result of the integer division as advice.
    rest <-- in % div; // Result of the modulo operation as advice.
    
    // Check that this is the unique correct result
    in === multiplier * div + rest; // (1) input must be recovered from multiplier, div, and result.
    rangeCheck.in[0] <== rest;
    rangeCheck.in[1] <== div;
    rangeCheck.out === 1; // (2) rest must be smaller than div.

}

component main = IntegerDivisionWithRest(20);