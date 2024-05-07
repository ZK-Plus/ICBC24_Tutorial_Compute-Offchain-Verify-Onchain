#!/usr/bin/node
const circomlibjs = require("circomlibjs");

(async function () {
    const preimage = [1, 2]
    const poseidon = await circomlibjs.buildPoseidon();
    const hash = poseidon.F.toString(poseidon(preimage));
    console.log(`poseidon hash of preimage(${preimage}) is: ${hash}`);
})()