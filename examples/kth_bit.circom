pragma circom 2.1.8;

include "utils.circom";

template extractKthBit(n) {
    /*
    Given a 253-bit BigInt as input, this template computes the binary representation and returns the corresponding bit at the k-th position​
   (starting the counting from 1 at the least significant bit!). 
    */

    // Make sure that the integer is in the prime field.
    assert(n <= 253);

    signal input in;
    signal input k;
    signal binaryRepresentation[n]; // Binary representation of in, used as intermediate signal​

    var powersOfTwo = 1; // Used to iteratively compute powers of two.
    var runningBinarySum = 0; // Used to recover in from its binary representation (necessary as the decomposition to binary is not constrained).

    signal runningOutputBitSum[n+1]; // Used to iteratively compute the result.
    runningOutputBitSum[0] <== 0;

    component equalityCheck[n]; // Used for populating with many IsEqual() components, one for every loop.

    for (var i = 0; i<n; i++) {
        binaryRepresentation[i] <-- (in >> i) & 1; // Extract the bit value through non-deterministic (unverified) advice.
        binaryRepresentation[i] * (binaryRepresentation[i]-1) === 0; // Ensure that the bit is indeed boolean, i.e., 0 or 1.
        equalityCheck[i] = IsEqual(); // Initialize an IsEqual() component from comparators.circom.
        equalityCheck[i].in[0] <== k-1; // First input of the equality comparison.
        equalityCheck[i].in[1] <== i; // Second input of the equality comparison.

        // If i = k, add this bit to runningOutputBitSum; else, there should be no contribution.
        runningOutputBitSum[i+1] <== runningOutputBitSum[i] + binaryRepresentation[i] * equalityCheck[i].out;

        // Iteratively recover the input from its supposed binary representation.
        runningBinarySum += binaryRepresentation[i] * powersOfTwo;
        powersOfTwo += powersOfTwo;
    }

    // Make the remaining check to verify that the Oracle-provided binary representation is legitimate. 
    runningBinarySum === in;

    // Assign the output bit by using the last value of the runningOutputBitSum.
    signal output outBit;
    outBit <== runningOutputBitSum[n];
}

component main = extractKthBit(253);
